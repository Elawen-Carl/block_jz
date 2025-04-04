pragma solidity ^0.6.0;

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
        uint8 applicationStatus; // 申请状态(0未提交、1待审核、2已审核)
        address auditor;        // 审核人地址
        uint256 auditTime;      // 审核时间
    }
    
    // 映射关系
    mapping(uint256 => Project) public projects;                     // 项目ID => 项目信息
    mapping(uint256 => Donation[]) public projectDonations;          // 项目ID => 捐赠记录数组
    mapping(uint256 => FundUsage[]) public projectFundUsages;        // 项目ID => 资金使用记录数组
    mapping(address => Donation[]) public userDonations;             // 用户地址 => 捐赠记录数组
    
    // 项目数量计数器
    uint256 public projectCount;
    
    // 事件
    event ProjectCreated(uint256 indexed projectId, string projectName, address initiator);
    event ProjectUpdated(uint256 indexed projectId, uint8 status);
    event DonationReceived(uint256 indexed projectId, uint256 donationId, address donor, uint256 amount);
    event FundUsageCreated(uint256 indexed projectId, uint256 usageId, uint256 amount);
    event FundUsageAudited(uint256 indexed projectId, uint256 usageId, address auditor, uint8 status);
    
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
        
        emit ProjectCreated(projectCount, _projectName, msg.sender);
        
        return projectCount;
    }
    
    // 审核项目
    function auditProject(uint256 _projectId, uint8 _auditStatus) public onlyAdmin {
        require(_projectId <= projectCount && _projectId > 0, "Invalid project ID");
        require(_auditStatus <= 2, "Invalid audit status");
        
        projects[_projectId].auditStatus = _auditStatus;
        
        // 如果审核通过且开始时间已到，则将项目状态设为进行中
        if (_auditStatus == 1 && block.timestamp >= projects[_projectId].startTime) {
            projects[_projectId].status = 1;
        }
        
        emit ProjectUpdated(_projectId, projects[_projectId].status);
    }
    
    // 进行捐赠
    function donate(uint256 _projectId, bool _isAnonymous) public payable {
        require(_projectId <= projectCount && _projectId > 0, "Invalid project ID");
        require(projects[_projectId].status == 1, "Project is not active");
        require(msg.value > 0, "Donation amount must be greater than 0");
        
        // 创建捐赠记录
        Donation memory newDonation = Donation({
            donationId: projectDonations[_projectId].length + 1,
            projectId: _projectId,
            donor: msg.sender,
            amount: msg.value,
            donationTime: block.timestamp,
            isAnonymous: _isAnonymous
        });
        
        // 更新项目已筹金额
        projects[_projectId].currentAmount += msg.value;
        
        // 保存捐赠记录
        projectDonations[_projectId].push(newDonation);
        userDonations[msg.sender].push(newDonation);
        
        emit DonationReceived(_projectId, newDonation.donationId, msg.sender, msg.value);
    }
    
    // 申请使用资金
    function applyForFundUsage(
        uint256 _projectId, 
        uint256 _amount, 
        string memory _usageDesc
    ) public onlyProjectInitiator(_projectId) {
        require(_projectId <= projectCount && _projectId > 0, "Invalid project ID");
        require(_amount > 0 && _amount <= projects[_projectId].currentAmount, "Invalid amount");
        
        FundUsage memory newUsage = FundUsage({
            usageId: projectFundUsages[_projectId].length + 1,
            projectId: _projectId,
            amount: _amount,
            usageDesc: _usageDesc,
            usageTime: block.timestamp,
            applicationStatus: 1, // 直接设为待审核状态
            auditor: address(0),
            auditTime: 0
        });
        
        projectFundUsages[_projectId].push(newUsage);
        
        emit FundUsageCreated(_projectId, newUsage.usageId, _amount);
    }
    
    // 审核资金使用申请
    function auditFundUsage(
        uint256 _projectId,
        uint256 _usageId,
        uint8 _status
    ) public onlyAdmin {
        require(_projectId <= projectCount && _projectId > 0, "Invalid project ID");
        require(_usageId > 0 && _usageId <= projectFundUsages[_projectId].length, "Invalid usage ID");
        require(_status == 1 || _status == 2, "Invalid status");
        
        FundUsage storage usage = projectFundUsages[_projectId][_usageId - 1];
        require(usage.applicationStatus == 1, "Usage is not in pending status");
        
        usage.applicationStatus = _status;
        usage.auditor = msg.sender;
        usage.auditTime = block.timestamp;
        
        emit FundUsageAudited(_projectId, _usageId, msg.sender, _status);
    }
    
    // 执行资金使用（转账给项目发起人）
    function executeFundUsage(uint256 _projectId, uint256 _usageId) public onlyAdmin {
        require(_projectId <= projectCount && _projectId > 0, "Invalid project ID");
        require(_usageId > 0 && _usageId <= projectFundUsages[_projectId].length, "Invalid usage ID");
        
        FundUsage storage usage = projectFundUsages[_projectId][_usageId - 1];
        require(usage.applicationStatus == 2, "Usage is not approved");
        
        address payable initiator = payable(projects[_projectId].initiator);
        initiator.transfer(usage.amount);
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
    
    // 获取项目捐赠记录数量
    function getDonationCount(uint256 _projectId) public view returns (uint256) {
        require(_projectId <= projectCount && _projectId > 0, "Invalid project ID");
        return projectDonations[_projectId].length;
    }
    
    // 获取项目资金使用记录数量
    function getFundUsageCount(uint256 _projectId) public view returns (uint256) {
        require(_projectId <= projectCount && _projectId > 0, "Invalid project ID");
        return projectFundUsages[_projectId].length;
    }
}