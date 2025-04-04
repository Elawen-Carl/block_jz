pragma solidity >=0.4.24 <0.6.11;

/**
 * 资金透明化智能合约
 * 用于记录所有资金流向，提供完整的资金追踪功能
 */
contract FundTransparency {
    
    // 交易类型枚举
    enum TransactionType { Donation, FundUsage, Refund }
    
    // 交易记录结构
    struct Transaction {
        uint256 txId;                // 交易ID
        TransactionType txType;      // 交易类型（捐赠、资金使用、退款）
        uint256 projectId;           // 项目ID
        address from;                // 资金来源
        address to;                  // 资金去向
        uint256 amount;              // 金额
        uint256 timestamp;           // 时间戳
        string description;          // 描述
        string evidence;             // 证据（如证明材料的IPFS哈希）
        string externalId;           // 外部ID（如区块链ID、交易哈希等）
    }
    
    // 系统参数
    address public admin;
    uint256 public transactionCount;
    
    // 映射关系
    mapping(uint256 => Transaction) public transactions;              // 交易ID => 交易记录
    mapping(uint256 => uint256[]) public projectTransactions;         // 项目ID => 交易ID数组
    mapping(address => uint256[]) public userTransactions;           // 用户地址 => 交易ID数组
    
    // 事件
    event TransactionRecorded(uint256 indexed txId, uint256 indexed projectId, TransactionType txType, address from, address to, uint256 amount);
    
    // 构造函数
    constructor() public {
        admin = msg.sender;
        transactionCount = 0;
    }
    
    // 权限控制
    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can call this function");
        _;
    }
    
    // 记录交易
    function recordTransaction(
        TransactionType _txType,
        uint256 _projectId,
        address _from,
        address _to,
        uint256 _amount,
        string memory _description,
        string memory _evidence,
        string memory _externalId
    ) public onlyAdmin returns (uint256) {
        transactionCount++;
        
        Transaction memory newTx = Transaction({
            txId: transactionCount,
            txType: _txType,
            projectId: _projectId,
            from: _from,
            to: _to,
            amount: _amount,
            timestamp: now,
            description: _description,
            evidence: _evidence,
            externalId: _externalId
        });
        
        transactions[transactionCount] = newTx;
        projectTransactions[_projectId].push(transactionCount);
        
        // 记录用户交易
        if (_from != address(0)) {
            userTransactions[_from].push(transactionCount);
        }
        if (_to != address(0) && _to != _from) {
            userTransactions[_to].push(transactionCount);
        }
        
        emit TransactionRecorded(transactionCount, _projectId, _txType, _from, _to, _amount);
        
        return transactionCount;
    }
    
    // 记录捐赠交易
    function recordDonation(
        uint256 _projectId,
        address _donor,
        address _recipient,
        uint256 _amount,
        string memory _description,
        string memory _externalId
    ) public onlyAdmin returns (uint256) {
        return recordTransaction(
            TransactionType.Donation,
            _projectId,
            _donor,
            _recipient,
            _amount,
            _description,
            "",
            _externalId
        );
    }
    
    // 记录资金使用交易
    function recordFundUsage(
        uint256 _projectId,
        address _from,
        address _to,
        uint256 _amount,
        string memory _description,
        string memory _evidence,
        string memory _externalId
    ) public onlyAdmin returns (uint256) {
        return recordTransaction(
            TransactionType.FundUsage,
            _projectId,
            _from,
            _to,
            _amount,
            _description,
            _evidence,
            _externalId
        );
    }
    
    // 记录退款交易
    function recordRefund(
        uint256 _projectId,
        address _from,
        address _to,
        uint256 _amount,
        string memory _description,
        string memory _externalId
    ) public onlyAdmin returns (uint256) {
        return recordTransaction(
            TransactionType.Refund,
            _projectId,
            _from,
            _to,
            _amount,
            _description,
            "",
            _externalId
        );
    }
    
    // 获取交易详情
    function getTransaction(uint256 _txId) public view returns (
        uint256 txId,
        uint8 txType,
        uint256 projectId,
        address from,
        address to,
        uint256 amount,
        uint256 timestamp,
        string memory description,
        string memory evidence,
        string memory externalId
    ) {
        require(_txId > 0 && _txId <= transactionCount, "Invalid transaction ID");
        
        Transaction memory t = transactions[_txId];
        return (
            t.txId,
            uint8(t.txType),
            t.projectId,
            t.from,
            t.to,
            t.amount,
            t.timestamp,
            t.description,
            t.evidence,
            t.externalId
        );
    }
    
    // 获取项目交易数量
    function getProjectTransactionCount(uint256 _projectId) public view returns (uint256) {
        return projectTransactions[_projectId].length;
    }
    
    // 获取项目交易ID（分页）
    function getProjectTransactions(uint256 _projectId, uint256 _offset, uint256 _limit) public view returns (uint256[] memory) {
        uint256 count = projectTransactions[_projectId].length;
        if (_offset >= count) {
            return new uint256[](0);
        }
        
        uint256 end = _offset + _limit;
        if (end > count) {
            end = count;
        }
        
        uint256 resultLength = end - _offset;
        uint256[] memory result = new uint256[](resultLength);
        
        for (uint256 i = 0; i < resultLength; i++) {
            result[i] = projectTransactions[_projectId][_offset + i];
        }
        
        return result;
    }
    
    // 获取用户交易数量
    function getUserTransactionCount(address _user) public view returns (uint256) {
        return userTransactions[_user].length;
    }
    
    // 获取用户交易ID（分页）
    function getUserTransactions(address _user, uint256 _offset, uint256 _limit) public view returns (uint256[] memory) {
        uint256 count = userTransactions[_user].length;
        if (_offset >= count) {
            return new uint256[](0);
        }
        
        uint256 end = _offset + _limit;
        if (end > count) {
            end = count;
        }
        
        uint256 resultLength = end - _offset;
        uint256[] memory result = new uint256[](resultLength);
        
        for (uint256 i = 0; i < resultLength; i++) {
            result[i] = userTransactions[_user][_offset + i];
        }
        
        return result;
    }
} 