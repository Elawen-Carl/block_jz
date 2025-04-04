pragma solidity >=0.4.24 <0.6.11;

contract CharityProject {
    // 项目基本信息
    struct Project {
        uint256 projectId;      // 项目ID
        string projectName;     // 项目名称
        string projectDesc;     // 项目描述
        uint256 targetAmount;   // 目标金额(以分为单位)
        uint256 currentAmount;  // 已筹金额(以分为单位)
        address initiator;      // 发起人地址
        uint8 initiatorType;    // 发起类型(0个人、1组织)
        uint256 startTime;      // 开始时间
        uint256 endTime;        // 结束时间
        uint8 status;           // 项目状态(0待开始、1进行中、2已结束、3已取消)
        uint8 auditStatus;      // 审核状态(0待审核、1已通过、2已拒绝)
    }
    
    // 捐赠记录
    struct Donation {
        uint256 donationId;     // 捐赠ID
        uint256 projectId;      // 项目ID
        address donor;          // 捐赠人地址
        uint256 amount;         // 捐赠金额(以分为单位)
        uint256 donationTime;   // 捐赠时间
        bool isAnonymous;       // 是否匿名
    }
    
    // 资金使用记录
    struct FundUsage {
        uint256 usageId;        // 使用记录ID
        uint256 projectId;      // 项目ID
        uint256 amount;         // 使用金额(以分为单位)
        string usageDesc;       // 使用描述
        uint256 usageTime;      // 使用时间
        uint8 applicationStatus; // 申请状态(0未提交、1待审核、2已审核通过、3已拒绝)
        address auditor;        // 审核人地址
        uint256 auditTime;      // 审核时间
    }
    
    // 映射关系
    mapping(uint256 => Project) public projects;                     // 项目ID => 项目信息
    mapping(uint256 => Donation[]) public projectDonations;          // 项目ID => 捐赠记录数组
    mapping(uint256 => FundUsage[]) public projectFundUsages;        // 项目ID => 资金使用记录数组
    mapping(address => Donation[]) public userDonations;             // 用户地址 => 捐赠记录数组
    mapping(uint256 => uint256) public projectBalances;              // 项目ID => 可用余额
    
    // 项目数量计数器
    uint256 public projectCount;
    
    // 事件
    event ProjectCreated(uint256 indexed projectId, string projectName, address initiator);
    event ProjectUpdated(uint256 indexed projectId, uint8 status);
    event DonationReceived(uint256 indexed projectId, uint256 donationId, address donor, uint256 amount);
    event FundUsageCreated(uint256 indexed projectId, uint256 usageId, uint256 amount);
    event FundUsageAudited(uint256 indexed projectId, uint256 usageId, address auditor, uint8 status);
    event FundWithdrawn(uint256 indexed projectId, uint256 usageId, address recipient, uint256 amount);
    
    // 管理员地址
    address public admin;
    
    // 构造函数
    constructor() public {
        admin = msg.sender;
        projectCount = 0;
    }
    
    // 权限控制修饰器
    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can call this function");
        _;
    }
    
    modifier onlyProjectInitiator(uint256 _projectId) {
        require(msg.sender == projects[_projectId].initiator, "Only project initiator can call this function");
        _;
    }
    
    // 创建新项目
    function createProject(
        string memory _projectName,
        string memory _projectDesc,
        uint256 _targetAmount,
        uint8 _initiatorType,
        uint256 _startTime,
        uint256 _endTime
    ) public returns (uint256) {
        projectCount++;
        
        Project memory newProject = Project({
            projectId: projectCount,
            projectName: _projectName,
            projectDesc: _projectDesc,
            targetAmount: _targetAmount,
            currentAmount: 0,
            initiator: msg.sender,
            initiatorType: _initiatorType,
            startTime: _startTime,
            endTime: _endTime,
            status: 0,
            auditStatus: 0
        });
        
        projects[projectCount] = newProject;
        projectBalances[projectCount] = 0;
        
        emit ProjectCreated(projectCount, _projectName, msg.sender);
        
        return projectCount;
    }
    
    // 审核项目
    function auditProject(uint256 _projectId, uint8 _auditStatus) public onlyAdmin {
        require(_projectId <= projectCount && _projectId > 0, "Invalid project ID");
        require(_auditStatus <= 2, "Invalid audit status");
        
        projects[_projectId].auditStatus = _auditStatus;
        
        // 如果审核通过且开始时间已到，则将项目状态设为进行中
        if (_auditStatus == 1 && now >= projects[_projectId].startTime) {
            projects[_projectId].status = 1;
        }
        
        emit ProjectUpdated(_projectId, projects[_projectId].status);
    }
    
    // 进行捐赠
    function donate(uint256 _projectId, bool _isAnonymous) public payable {
        require(_projectId <= projectCount && _projectId > 0, "Invalid project ID");
        require(projects[_projectId].status == 1, "Project is not active");
        require(projects[_projectId].auditStatus == 1, "Project is not approved");
        require(msg.value > 0, "Donation amount must be greater than 0");
        
        // 创建捐赠记录
        uint256 donationId = projectDonations[_projectId].length + 1;
        Donation memory newDonation = Donation({
            donationId: donationId,
            projectId: _projectId,
            donor: msg.sender,
            amount: msg.value,
            donationTime: now,
            isAnonymous: _isAnonymous
        });
        
        // 更新项目已筹金额和可用余额
        projects[_projectId].currentAmount += msg.value;
        projectBalances[_projectId] += msg.value;
        
        // 保存捐赠记录
        projectDonations[_projectId].push(newDonation);
        userDonations[msg.sender].push(newDonation);
        
        emit DonationReceived(_projectId, donationId, msg.sender, msg.value);
    }
    
    // 申请使用资金
    function applyForFundUsage(
        uint256 _projectId, 
        uint256 _amount, 
        string memory _usageDesc
    ) public onlyProjectInitiator(_projectId) {
        require(_projectId <= projectCount && _projectId > 0, "Invalid project ID");
        require(_amount > 0 && _amount <= projectBalances[_projectId], "Invalid amount or insufficient balance");
        
        uint256 usageId = projectFundUsages[_projectId].length + 1;
        FundUsage memory newUsage = FundUsage({
            usageId: usageId,
            projectId: _projectId,
            amount: _amount,
            usageDesc: _usageDesc,
            usageTime: now,
            applicationStatus: 1, // 直接设为待审核状态
            auditor: address(0),
            auditTime: 0
        });
        
        projectFundUsages[_projectId].push(newUsage);
        
        emit FundUsageCreated(_projectId, usageId, _amount);
    }
    
    // 审核资金使用申请
    function auditFundUsage(
        uint256 _projectId,
        uint256 _usageId,
        uint8 _status
    ) public onlyAdmin {
        require(_projectId <= projectCount && _projectId > 0, "Invalid project ID");
        require(_usageId > 0 && _usageId <= projectFundUsages[_projectId].length, "Invalid usage ID");
        require(_status == 2 || _status == 3, "Invalid status, must be 2 (approved) or 3 (rejected)");
        
        FundUsage storage usage = projectFundUsages[_projectId][_usageId - 1];
        require(usage.applicationStatus == 1, "Usage is not in pending status");
        
        usage.applicationStatus = _status;
        usage.auditor = msg.sender;
        usage.auditTime = now;
        
        emit FundUsageAudited(_projectId, _usageId, msg.sender, _status);
    }
    
    // 执行资金使用（转账给项目发起人）
    function executeFundUsage(uint256 _projectId, uint256 _usageId) public onlyAdmin {
        require(_projectId <= projectCount && _projectId > 0, "Invalid project ID");
        require(_usageId > 0 && _usageId <= projectFundUsages[_projectId].length, "Invalid usage ID");
        
        FundUsage storage usage = projectFundUsages[_projectId][_usageId - 1];
        require(usage.applicationStatus == 2, "Usage is not approved");
        
        // 确保项目余额充足
        require(projectBalances[_projectId] >= usage.amount, "Insufficient project balance");
        
        // 更新项目余额
        projectBalances[_projectId] -= usage.amount;
        
        // 转账给项目发起人
        address payable initiator = address(uint160(projects[_projectId].initiator));
        initiator.transfer(usage.amount);
        
        emit FundWithdrawn(_projectId, _usageId, initiator, usage.amount);
    }
    
    // 获取项目信息
    function getProjectInfo(uint256 _projectId) public view returns (
        string memory projectName,
        string memory projectDesc,
        uint256 targetAmount,
        uint256 currentAmount,
        address initiator,
        uint8 initiatorType,
        uint256 startTime,
        uint256 endTime,
        uint8 status,
        uint8 auditStatus
    ) {
        require(_projectId <= projectCount && _projectId > 0, "Invalid project ID");
        
        Project memory p = projects[_projectId];
        return (
            p.projectName,
            p.projectDesc,
            p.targetAmount,
            p.currentAmount,
            p.initiator,
            p.initiatorType,
            p.startTime,
            p.endTime,
            p.status,
            p.auditStatus
        );
    }
    
    // 获取项目余额
    function getProjectBalance(uint256 _projectId) public view returns (uint256) {
        require(_projectId <= projectCount && _projectId > 0, "Invalid project ID");
        return projectBalances[_projectId];
    }
    
    // 获取项目捐赠记录数量
    function getDonationCount(uint256 _projectId) public view returns (uint256) {
        require(_projectId <= projectCount && _projectId > 0, "Invalid project ID");
        return projectDonations[_projectId].length;
    }
    
    // 获取项目捐赠记录
    function getDonation(uint256 _projectId, uint256 _donationId) public view returns (
        address donor,
        uint256 amount,
        uint256 donationTime,
        bool isAnonymous
    ) {
        require(_projectId <= projectCount && _projectId > 0, "Invalid project ID");
        require(_donationId > 0 && _donationId <= projectDonations[_projectId].length, "Invalid donation ID");
        
        Donation memory d = projectDonations[_projectId][_donationId - 1];
        return (
            d.donor,
            d.amount,
            d.donationTime,
            d.isAnonymous
        );
    }
    
    // 获取项目资金使用记录数量
    function getFundUsageCount(uint256 _projectId) public view returns (uint256) {
        require(_projectId <= projectCount && _projectId > 0, "Invalid project ID");
        return projectFundUsages[_projectId].length;
    }
    
    // 获取项目资金使用记录
    function getFundUsage(uint256 _projectId, uint256 _usageId) public view returns (
        uint256 amount,
        string memory usageDesc,
        uint256 usageTime,
        uint8 applicationStatus,
        address auditor,
        uint256 auditTime
    ) {
        require(_projectId <= projectCount && _projectId > 0, "Invalid project ID");
        require(_usageId > 0 && _usageId <= projectFundUsages[_projectId].length, "Invalid usage ID");
        
        FundUsage memory u = projectFundUsages[_projectId][_usageId - 1];
        return (
            u.amount,
            u.usageDesc,
            u.usageTime,
            u.applicationStatus,
            u.auditor,
            u.auditTime
        );
    }
    
    // 获取用户捐赠记录数量
    function getUserDonationCount(address _user) public view returns (uint256) {
        return userDonations[_user].length;
    }
    
    // 获取用户捐赠记录
    function getUserDonation(address _user, uint256 _index) public view returns (
        uint256 projectId,
        uint256 donationId,
        uint256 amount,
        uint256 donationTime
    ) {
        require(_index < userDonations[_user].length, "Invalid index");
        
        Donation memory d = userDonations[_user][_index];
        return (
            d.projectId,
            d.donationId,
            d.amount,
            d.donationTime
        );
    }
} 