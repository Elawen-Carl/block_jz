package com.ruoyi.charity.blockchain.service.impl;

import com.ruoyi.charity.blockchain.service.FabricService;
import com.ruoyi.charity.domain.BlockchainTransaction;
import com.ruoyi.charity.service.IBlockchainTransactionService;
import org.hyperledger.fabric.gateway.Contract;
import org.hyperledger.fabric.gateway.Gateway;
import org.hyperledger.fabric.gateway.Network;
import org.hyperledger.fabric.gateway.Transaction;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;
import java.nio.charset.StandardCharsets;
import java.util.Date;
import java.util.List;
import java.util.UUID;

@Service
public class FabricServiceImpl implements FabricService {
    private static final Logger log = LoggerFactory.getLogger(FabricServiceImpl.class);
    
    @Resource
    private Gateway gateway;
    
    @Value("${fabric.channelName}")
    private String channelName;
    
    @Value("${fabric.chaincodeName}")
    private String chaincodeName;
    
    private Contract contract;
    private String lastTransactionId;
    private Long lastWasteRecordId;
    private Long lastPointsRecordId;
    
    @Autowired
    private IBlockchainTransactionService blockchainTransactionService;

    @PostConstruct
    public void init() {
        try {
            log.info("初始化Fabric网络连接...");
            log.info("ChannelName: {}", channelName);
            log.info("ChaincodeName: {}", chaincodeName);
            
            if (gateway == null) {
                log.error("Gateway对象为null，请检查Gateway Bean的配置");
                return;
            }

            Network network = gateway.getNetwork(channelName);
            if (network == null) {
                log.error("无法获取网络: {}", channelName);
                return;
            }

            contract = network.getContract(chaincodeName);
            if (contract == null) {
                log.error("无法获取合约: {}", chaincodeName);
                return;
            }

            log.info("尝试获取合约函数列表...");

            try {
                byte[] functionListResult = contract.evaluateTransaction("org.hyperledger.fabric:GetMetadata");
                log.info("合约元数据信息: {}", new String(functionListResult, StandardCharsets.UTF_8));
            } catch (Exception e) {
                log.warn("获取合约元数据失败: {}", e.getMessage());
            }

            log.info("Fabric网络连接初始化成功");
        } catch (Exception e) {
            log.error("Fabric网络连接初始化失败", e);
        }
    }

    private void validateContract() {
        if (contract == null) {
            log.error("Fabric合约未初始化或初始化失败");
            throw new RuntimeException("Fabric合约未初始化");
        }
    }

    private void validateParameters(String... params) {
        for (String param : params) {
            if (param == null) {
                log.error("调用链码参数不能为null");
                throw new RuntimeException("调用链码参数不能为null");
            }
            if (param.isEmpty()) {
                log.error("调用链码关键参数不能为空字符串");
                throw new RuntimeException("调用链码关键参数不能为空字符串");
            }
        }
    }

    private void saveTransactionId() {
        try {
            if (lastTransactionId == null || lastTransactionId.isEmpty()) {
                log.warn("交易ID为空，无法保存区块链交易记录");
                return;
            }

            // 生成唯一的交易记录ID，避免主键冲突
            String uniqueTxId = "tx_" + UUID.randomUUID().toString().replace("-", "").substring(0, 16);
            log.info("生成唯一交易记录ID: {}, 实际交易ID: {}", uniqueTxId, lastTransactionId);
            
            BlockchainTransaction transaction = new BlockchainTransaction();
            // 设置交易ID和哈希值
            transaction.setTxId(uniqueTxId);  // 使用唯一ID作为txId
            transaction.setTransactionHash(lastTransactionId);  // 使用实际交易ID作为hash
            
            // 获取最大区块号
            long maxBlockNumber = getMaxBlockNumber();
            transaction.setBlockNumber(maxBlockNumber + 1L);
            
            // 设置交易类型 - 根据函数名推断交易类型
            String transactionType = inferTransactionType(lastTransactionId);
            transaction.setRelatedType(transactionType);
            
            // 设置关联业务ID - 目前使用时间戳作为临时ID
            transaction.setRelatedId(System.currentTimeMillis());
            
            // 设置其他属性
            transaction.setTxData(String.valueOf(new Date()));
            transaction.setTxStatus("1"); // 1表示成功
            transaction.setTxTime(new Date()); // 设置交易时间
            
            blockchainTransactionService.insertBlockchainTransaction(transaction);
            log.info("保存区块链交易记录成功: {}", uniqueTxId);
        } catch (Exception e) {
            log.error("保存区块链交易记录失败: {}", e.getMessage(), e);
        }
    }

    /**
     * 根据交易ID推断交易类型
     */
    private String inferTransactionType(String txId) {
        // 根据当前调用的链码函数名来推断交易类型
        if (txId.contains("registerUser") || txId.contains("updateUserInfo")) {
            return "user";
        } else if (txId.contains("recordDonation") || txId.contains("generateDonationCertificate")) {
            return "donation";
        } else if (txId.contains("createCharityProject") || txId.contains("approveProject") || txId.contains("reviewProject")) {
            return "project";
        } else if (txId.contains("recordFundAllocation")) {
            return "fund";
        } else {
            return "other";
        }
    }

    private long getMaxBlockNumber() {
        BlockchainTransaction query = new BlockchainTransaction();
        List<BlockchainTransaction> existingTransactions = blockchainTransactionService.selectBlockchainTransactionList(query);
        
        long maxBlockNumber = 10000L;
        if (!existingTransactions.isEmpty()) {
            for (BlockchainTransaction tx : existingTransactions) {
                if (tx.getBlockNumber() != null && tx.getBlockNumber() > maxBlockNumber) {
                    maxBlockNumber = tx.getBlockNumber();
                }
            }
        }
        return maxBlockNumber;
    }

    /**
     * 创建事务并记录事务ID
     */
    private Transaction createTransaction(String fcn) {
        Transaction transaction = contract.createTransaction(fcn);
        lastTransactionId = transaction.getTransactionId();
        log.info("创建交易: 函数={}, 交易ID={}", fcn, lastTransactionId);
        return transaction;
    }

    // ==================== 用户管理相关接口实现 ====================

    @Override
    public String registerUser(String userId, String userInfo) throws Exception {
        log.info("调用链码注册用户: userId={}", userId);
        validateContract();
        validateParameters(userId, userInfo);
        
        try {
            // 使用简化的方式调用事务
            Transaction transaction = createTransaction("registerUser");
            
            // 记录请求信息用于调试
            log.debug("注册用户请求参数: userId={}, userInfo={}", userId, userInfo);
            
            // 直接提交事务
            byte[] result = transaction.submit(userId, userInfo);
            
            // 保存交易记录
            saveTransactionId();
            
            return new String(result, StandardCharsets.UTF_8);
        } catch (Exception e) {
            log.error("调用链码注册用户失败: {}", e.getMessage(), e);
            if (e.getCause() != null) {
                log.error("根本原因: {}", e.getCause().getMessage());
            }
            throw new Exception("调用链码注册用户失败: " + e.getMessage(), e);
        }
    }

    @Override
    public String updateUserInfo(String userId, String updatedInfo) throws Exception {
        log.info("调用链码更新用户信息: userId={}", userId);
        validateContract();
        validateParameters(userId, updatedInfo);
        
        try {
            Transaction transaction = createTransaction("updateUserInfo");
            byte[] result = transaction.submit(userId, updatedInfo);
            saveTransactionId();
            return new String(result, StandardCharsets.UTF_8);
        } catch (Exception e) {
            log.error("调用链码更新用户信息失败: {}", e.getMessage(), e);
            throw new Exception("调用链码更新用户信息失败: " + e.getMessage(), e);
        }
    }

    @Override
    public String getUser(String userId) throws Exception {
        log.info("调用链码获取用户信息: userId={}", userId);
        validateContract();
        validateParameters(userId);
        
        try {
            byte[] result = contract.evaluateTransaction("getUser", userId);
            return new String(result, StandardCharsets.UTF_8);
        } catch (Exception e) {
            log.error("调用链码获取用户信息失败: {}", e.getMessage(), e);
            throw new Exception("调用链码获取用户信息失败: " + e.getMessage(), e);
        }
    }

    // ==================== 捐赠管理相关接口实现 ====================

    @Override
    public String recordDonation(String donationId, String donorId, String projectId, 
                                String amount, String method, String timestamp) throws Exception {
        log.info("调用链码记录捐赠: donationId={}, donorId={}, projectId={}, amount={}", 
                 donationId, donorId, projectId, amount);
        validateContract();
        validateParameters(donationId, donorId, projectId, amount, method);
        
        // 如果timestamp为空，使用默认值
        if (timestamp == null || timestamp.isEmpty()) {
            timestamp = Long.toString(System.currentTimeMillis());
        }
        
        try {
            Transaction transaction = createTransaction("recordDonation");
            byte[] result = transaction.submit(donationId, donorId, projectId, amount, method, timestamp);
            saveTransactionId();
            return new String(result, StandardCharsets.UTF_8);
        } catch (Exception e) {
            log.error("调用链码记录捐赠失败: {}", e.getMessage(), e);
            throw new Exception("调用链码记录捐赠失败: " + e.getMessage(), e);
        }
    }

    @Override
    public String getDonation(String donationId) throws Exception {
        log.info("调用链码获取捐赠记录: donationId={}", donationId);
        validateContract();
        validateParameters(donationId);
        
        try {
            byte[] result = contract.evaluateTransaction("getDonation", donationId);
            return new String(result, StandardCharsets.UTF_8);
        } catch (Exception e) {
            log.error("调用链码获取捐赠记录失败: {}", e.getMessage(), e);
            throw new Exception("调用链码获取捐赠记录失败: " + e.getMessage(), e);
        }
    }

    @Override
    public String generateDonationCertificate(String donationId) throws Exception {
        log.info("调用链码生成捐赠证书: donationId={}", donationId);
        validateContract();
        validateParameters(donationId);
        
        try {
            Transaction transaction = createTransaction("generateDonationCertificate");
            byte[] result = transaction.submit(donationId);
            saveTransactionId();
            return new String(result, StandardCharsets.UTF_8);
        } catch (Exception e) {
            log.error("调用链码生成捐赠证书失败: {}", e.getMessage(), e);
            throw new Exception("调用链码生成捐赠证书失败: " + e.getMessage(), e);
        }
    }

    @Override
    public String queryUserDonations(String userId) throws Exception {
        log.info("调用链码查询用户捐赠历史: userId={}", userId);
        validateContract();
        validateParameters(userId);
        
        try {
            byte[] result = contract.evaluateTransaction("queryUserDonations", userId);
            return new String(result, StandardCharsets.UTF_8);
        } catch (Exception e) {
            log.error("调用链码查询用户捐赠历史失败: {}", e.getMessage(), e);
            throw new Exception("调用链码查询用户捐赠历史失败: " + e.getMessage(), e);
        }
    }

    // ==================== 慈善项目管理相关接口实现 ====================

    /**
     * 创建慈善项目
     */
    @Override
    public String createCharityProject(String projectId, String projectInfo) throws Exception {
        log.info("调用链码创建慈善项目: projectId={}", projectId);
        validateContract();
        validateParameters(projectId, projectInfo);
        
        try {
            // 1. 检查项目是否已存在
            try {
                String existingProject = getProject(projectId);
                log.info("慈善项目已存在于区块链: {}", projectId);
                return existingProject; // 返回已存在的项目信息
            } catch (Exception e) {
                // 如果是"不存在"错误，则继续创建，否则抛出异常
                if (e.getMessage() == null || !e.getMessage().contains("不存在")) {
                    throw e;
                }
                log.info("项目 {} 在区块链上不存在，将创建新项目", projectId);
            }
            
            // 2. 创建事务
            Transaction transaction = createTransaction("createCharityProject");
            
            // 记录请求信息
            log.debug("创建慈善项目请求参数: projectId={}, projectInfo={}", projectId, projectInfo);
            
            // 3. 提交事务时添加重试逻辑
            int maxRetries = 3;
            Exception lastException = null;
            
            for (int attempt = 1; attempt <= maxRetries; attempt++) {
                try {
                    log.info("创建慈善项目尝试 {}/{}: projectId={}", attempt, maxRetries, projectId);
                    byte[] result = transaction.submit(projectId, projectInfo);
                    
                    // 保存交易记录
                    saveTransactionId();
                    
                    String response = new String(result, StandardCharsets.UTF_8);
                    log.info("慈善项目创建成功: {}, 响应: {}", projectId, response);
                    return response;
                } catch (Exception e) {
                    lastException = e;
                    log.warn("创建慈善项目尝试 {}/{} 失败: {}", attempt, maxRetries, e.getMessage());
                    
                    // 如果不是因项目已存在导致的错误，则重试
                    if (e.getMessage() != null && e.getMessage().contains("已存在")) {
                        log.info("项目 {} 已存在于区块链上，无需重试", projectId);
                        return projectId; // 直接返回项目ID
                    }
                    
                    // 等待一段时间后重试
                    if (attempt < maxRetries) {
                        Thread.sleep(1000 * attempt); // 指数退避
                    }
                }
            }
            
            // 所有重试都失败
            if (lastException != null) {
                throw lastException;
            }
            
            return projectId;
        } catch (Exception e) {
            log.error("创建慈善项目失败: projectId={}, error={}", projectId, e.getMessage(), e);
            throw e;
        }
    }

    @Override
    public String approveProject(String projectId, String organizationId, 
                                String approvalStatus, String remarks) throws Exception {
        log.info("调用链码审核慈善项目: projectId={}, organizationId={}, status={}, remarks={}",
                 projectId, organizationId, approvalStatus, remarks);
        validateContract();
        validateParameters(projectId, organizationId, approvalStatus);
        
        // 如果remarks为空，提供默认值
        if (remarks == null || remarks.isEmpty()) {
            remarks = "";
        }
        
        try {
            // 创建交易并记录ID
            Transaction transaction = createTransaction("approveProject");
            
            // 记录详细的请求参数
            log.info("审核项目请求参数: projectId={}, organizationId={}, status={}, remarks={}",
                    projectId, organizationId, approvalStatus, remarks);
            

            // 提交事务
            byte[] result = transaction.submit(projectId, organizationId, approvalStatus, remarks);
            
            // 保存交易记录
            saveTransactionId();
            
            String response = new String(result, StandardCharsets.UTF_8);
            log.info("项目审核成功: {}, 响应: {}", projectId, response);
            
            return response;
        } catch (Exception e) {
            log.error("调用链码审核慈善项目失败: {}", e.getMessage(), e);
            
            // 检查是否是网络或超时问题
            String errorMsg = e.getMessage();
            if (errorMsg != null && (errorMsg.contains("timeout") || errorMsg.contains("deadline") || 
                                    errorMsg.contains("connection") || errorMsg.contains("network"))) {
                log.warn("可能是网络问题导致审核失败，请稍后重试");
            }
            
            throw new Exception("调用链码审核慈善项目失败: " + e.getMessage(), e);
        }
    }

    @Override
    public String getProject(String projectId) throws Exception {
        log.info("调用链码获取项目信息: projectId={}", projectId);
        validateContract();
        validateParameters(projectId);
        
        try {
            byte[] result = contract.evaluateTransaction("getProject", projectId);
            return new String(result, StandardCharsets.UTF_8);
        } catch (Exception e) {
            // 检查是否是"项目不存在"的错误
            String errorMsg = e.getMessage();
            if (errorMsg != null && 
                (errorMsg.contains("不存在") || 
                 errorMsg.contains("does not exist") || 
                 errorMsg.contains("not found"))) {
                // 对于"不存在"的情况，使用INFO级别而不是ERROR
                log.info("项目 {} 在区块链上不存在: {}", projectId, errorMsg);
            } else {
                // 其他错误仍然使用ERROR级别
                log.error("调用链码获取项目信息失败: {}", errorMsg, e);
            }
            throw new Exception("调用链码获取项目信息失败: " + errorMsg, e);
        }
    }

    @Override
    public String reviewProject(String projectId, String userId, String rating, String comment) throws Exception {
        log.info("调用链码评价项目: projectId={}, userId={}, rating={}", projectId, userId, rating);
        validateContract();
        validateParameters(projectId, userId, rating);
        
        // 如果comment为空，提供默认值
        if (comment == null || comment.isEmpty()) {
            comment = "";
        }
        
        try {
            Transaction transaction = createTransaction("reviewProject");
            byte[] result = transaction.submit(projectId, userId, rating, comment);
            saveTransactionId();
            return new String(result, StandardCharsets.UTF_8);
        } catch (Exception e) {
            log.error("调用链码评价项目失败: {}", e.getMessage(), e);
            throw new Exception("调用链码评价项目失败: " + e.getMessage(), e);
        }
    }

    // ==================== 资金透明度相关接口实现 ====================

    @Override
    public String recordFundAllocation(String allocationId, String projectId, String amount, 
                                      String purpose, String recipient, String timestamp) throws Exception {
        log.info("调用链码记录资金分配: allocationId={}, projectId={}, amount={}", 
                 allocationId, projectId, amount);
        validateContract();
        validateParameters(allocationId, projectId, amount, purpose, recipient);
        
        // 如果timestamp为空，使用默认值
        if (timestamp == null || timestamp.isEmpty()) {
            timestamp = Long.toString(System.currentTimeMillis());
        }
        
        try {
            Transaction transaction = createTransaction("recordFundAllocation");
            byte[] result = transaction.submit(allocationId, projectId, amount, purpose, recipient, timestamp);
            saveTransactionId();
            return new String(result, StandardCharsets.UTF_8);
        } catch (Exception e) {
            log.error("调用链码记录资金分配失败: {}", e.getMessage(), e);
            throw new Exception("调用链码记录资金分配失败: " + e.getMessage(), e);
        }
    }

    @Override
    public String getFundAllocation(String allocationId) throws Exception {
        log.info("调用链码获取资金分配记录: allocationId={}", allocationId);
        validateContract();
        validateParameters(allocationId);
        
        try {
            byte[] result = contract.evaluateTransaction("getFundAllocation", allocationId);
            return new String(result, StandardCharsets.UTF_8);
        } catch (Exception e) {
            log.error("调用链码获取资金分配记录失败: {}", e.getMessage(), e);
            throw new Exception("调用链码获取资金分配记录失败: " + e.getMessage(), e);
        }
    }

    @Override
    public String queryProjectFundAllocations(String projectId) throws Exception {
        log.info("调用链码查询项目资金流向: projectId={}", projectId);
        validateContract();
        validateParameters(projectId);
        
        try {
            byte[] result = contract.evaluateTransaction("queryProjectFundAllocations", projectId);
            return new String(result, StandardCharsets.UTF_8);
        } catch (Exception e) {
            log.error("调用链码查询项目资金流向失败: {}", e.getMessage(), e);
            throw new Exception("调用链码查询项目资金流向失败: " + e.getMessage(), e);
        }
    }
}