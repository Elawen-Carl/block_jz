package com.ruoyi.charity.blockchain.service.impl;

import com.ruoyi.charity.blockchain.service.BlockchainIntegrationService;
import com.ruoyi.charity.blockchain.service.FabricService;
import com.ruoyi.charity.domain.BlockchainTransaction;
import com.ruoyi.charity.domain.CharityProject;
import com.ruoyi.charity.domain.DonationRecord;
import com.ruoyi.charity.domain.FundUsageRecord;
import com.ruoyi.charity.mapper.CharityProjectMapper;
import com.ruoyi.charity.service.IBlockchainTransactionService;
import com.ruoyi.common.utils.SecurityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.UUID;

/**
 * 区块链集成服务实现
 * 
 * @author ruoyi
 * @date 2025-04-05
 */
@Service
public class BlockchainIntegrationServiceImpl implements BlockchainIntegrationService {
    
    private static final Logger log = LoggerFactory.getLogger(BlockchainIntegrationServiceImpl.class);
    
    @Autowired
    private FabricService fabricService;
    
    @Autowired
    private IBlockchainTransactionService transactionService;
    
    @Autowired
    private CharityProjectMapper charityProjectMapper;
    
    @Override
    public String uploadProjectToBlockchain(CharityProject project) {
        try {
            if (project == null) {
                throw new IllegalArgumentException("项目信息不能为空");
            }
            
            if (project.getProjectName() == null || project.getProjectName().trim().isEmpty()) {
                throw new IllegalArgumentException("项目名称不能为空");
            }
            
            log.info("正在上传项目到区块链: {}", project.getProjectName());
            
            // 准备新的区块链项目ID
            String blockchainProjectId = null; // 初始化为null
            
            // 检查是否已有区块链ID
            if (project.getBlockchainId() != null && !project.getBlockchainId().trim().isEmpty()) {
                log.info("项目已有区块链ID: {}，尝试重用", project.getBlockchainId());
                
                // 检查ID格式是否合理
                if (project.getBlockchainId().contains(" ") || project.getBlockchainId().length() < 5) {
                    log.warn("现有区块链ID [{}] 格式不合法，将生成新ID", project.getBlockchainId());
                    // 不设置blockchainProjectId，让它继续使用默认值null
                } else {
                    try {
                        // 检查区块链上是否存在该ID
                        boolean exists = checkProjectExists(project.getBlockchainId());
                        if (exists) {
                            log.info("项目 [{}] 已存在于区块链，返回现有ID: {}", 
                                project.getProjectName(), project.getBlockchainId());
                            return project.getBlockchainId();
                        } else {
                            log.warn("项目 [{}] 的区块链ID [{}] 在链上不存在，将使用该ID创建新项目", 
                                project.getProjectName(), project.getBlockchainId());
                            blockchainProjectId = project.getBlockchainId();
                        }
                    } catch (Exception e) {
                        log.warn("检查项目 [{}] 区块链ID [{}] 是否存在时发生错误: {}", 
                            project.getProjectName(), project.getBlockchainId(), e.getMessage());
                        blockchainProjectId = project.getBlockchainId();
                    }
                }
            }
            
            // 如果没有设置区块链ID或需要生成新ID
            if (blockchainProjectId == null) {
                // 生成新ID，使用前缀标识不同类型的项目，便于后续管理
                blockchainProjectId = "proj_" + UUID.randomUUID().toString().replace("-", "").substring(0, 16);
                log.info("为项目 [{}] 生成新区块链ID: {}", project.getProjectName(), blockchainProjectId);
            }
            
            // 构建项目信息JSON
            String projectInfo = buildProjectInfoJson(project);
            
            // 记录上链参数
            log.info("项目上链参数 - ID: {}, 项目信息: {}", blockchainProjectId, projectInfo);
            
            // 调用链码上传项目
            String result = fabricService.createCharityProject(blockchainProjectId, projectInfo);
            
            // 保存交易记录
            saveBlockchainTransaction(project.getProjectId(), "createCharityProject", blockchainProjectId, result);
            
            log.info("项目上传区块链成功: {} -> {}, 响应: {}", project.getProjectName(), blockchainProjectId, result);
            
            return blockchainProjectId;
        } catch (Exception e) {
            log.error("项目 [{}] 上传区块链失败: {}", 
                project != null ? project.getProjectName() : "未知项目", e.getMessage(), e);
            
            // 对于重复ID的错误，尝试生成新ID并重试
            if (e.getMessage() != null && e.getMessage().contains("已存在") && project != null) {
                try {
                    log.info("检测到项目ID冲突，尝试使用新ID重新上链");
                    
                    // 生成新ID
                    String newBlockchainId = "proj_" + UUID.randomUUID().toString().replace("-", "").substring(0, 16);
                    log.info("为项目 [{}] 生成新区块链ID: {}", project.getProjectName(), newBlockchainId);
                    
                    // 构建项目信息
                    String projectInfo = buildProjectInfoJson(project);
                    
                    // 再次调用链码上传项目
                    String result = fabricService.createCharityProject(newBlockchainId, projectInfo);
                    
                    // 保存交易记录
                    saveBlockchainTransaction(project.getProjectId(), "createCharityProject", newBlockchainId, result);
                    
                    log.info("项目使用新ID上传区块链成功: {} -> {}, 响应: {}", 
                        project.getProjectName(), newBlockchainId, result);
                    
                    return newBlockchainId;
                } catch (Exception retryEx) {
                    log.error("使用新ID重试上链失败: {}", retryEx.getMessage(), retryEx);
                }
            }
            
            throw new RuntimeException("项目上传区块链失败: " + e.getMessage());
        }
    }
    
    /**
     * 检查项目在区块链上是否存在
     */
    private boolean checkProjectExists(String blockchainProjectId) {
        if (blockchainProjectId == null || blockchainProjectId.trim().isEmpty()) {
            return false;
        }
        
        try {
            String result = fabricService.getProject(blockchainProjectId);
            
            // 检查结果是否包含有效的项目信息
            if (result != null && !result.isEmpty() && 
                (result.contains("\"name\"") || result.contains("\"projectName\""))) {
                log.info("区块链上存在项目 [{}]，返回结果: {}", blockchainProjectId, 
                    result.length() > 100 ? result.substring(0, 100) + "..." : result);
                return true;
            }
            
            // 返回值存在但格式不正确
            log.warn("从区块链获取的项目 [{}] 信息格式不正确: {}", blockchainProjectId, result);
            return false;
        } catch (Exception e) {
            // 记录详细的错误信息
            String errorMsg = e.getMessage();
            
            // 如果是"不存在"错误，返回false
            if (errorMsg != null && (
                errorMsg.contains("不存在") || 
                errorMsg.contains("not exist") || 
                errorMsg.contains("not found"))) {
                log.info("区块链上不存在项目 [{}]: {}", blockchainProjectId, errorMsg);
                return false;
            }
            
            // 其他类型的错误，记录并抛出
            log.error("检查项目 [{}] 是否存在时发生错误: {}", blockchainProjectId, errorMsg, e);
            if (e instanceof RuntimeException) {
                throw (RuntimeException) e;
            }
            throw new RuntimeException("检查项目是否存在时发生错误: " + errorMsg, e);
        }
    }
    
    /**
     * 保存区块链交易记录
     */
    private void saveBlockchainTransaction(Long businessId, String functionName, String blockchainId, String result) {
        try {
            // 生成唯一的交易ID，避免主键冲突
            String uniqueTxId = "tx_" + UUID.randomUUID().toString().replace("-", "").substring(0, 16);
            
            // 确定业务类型
            String businessType = "Other";
            if (functionName.contains("CharityProject") || functionName.contains("Project")) {
                businessType = "CharityProject";
            } else if (functionName.contains("Donation")) {
                businessType = "DonationRecord";
            } else if (functionName.contains("Fund") || functionName.contains("Allocation")) {
                businessType = "FundUsageRecord";
            }
            
            log.info("保存区块链交易记录 - 业务ID: {}, 函数: {}, 业务类型: {}, 区块链ID: {}, 交易ID: {}", 
                    businessId, functionName, businessType, blockchainId, uniqueTxId);
            
            BlockchainTransaction tx = new BlockchainTransaction();
            tx.setTxId(uniqueTxId);  // 使用生成的唯一ID作为txId
            tx.setRelatedId(businessId);  // 使用businessId作为relatedId
            tx.setRelatedType(businessType);  // 业务类型
            tx.setTransactionHash(blockchainId);  // 使用blockchainId作为transactionHash
            tx.setTxData(result);  // 使用result作为txData
            tx.setTxStatus("1");  // 1表示成功
            tx.setCreateTime(new Date());
            tx.setTxTime(new Date());
            
            // 执行插入操作
            transactionService.insertBlockchainTransaction(tx);
            log.info("区块链交易记录保存成功: {}", uniqueTxId);
        } catch (Exception e) {
            log.error("保存区块链交易记录失败: {}", e.getMessage(), e);
            // 交易记录保存失败不影响主流程
        }
    }
    
    @Override
    public boolean approveProjectOnBlockchain(CharityProject project) {
        try {
            log.info("正在审核区块链项目: {}", project.getBlockchainId());
            
            // 如果区块链ID为空，无法进行审核
            if (project.getBlockchainId() == null || project.getBlockchainId().trim().isEmpty()) {
                log.warn("项目区块链ID为空，无法进行审核");
                return false;
            }
            
            String organizationId = "org_" + SecurityUtils.getUserId();
            String approvalStatus = "1".equals(project.getAuditStatus()) ? "approved" : "rejected";
            String remarks = project.getAuditRemark() != null ? project.getAuditRemark() : "";
            
            log.info("区块链项目审核参数 - 项目ID: {}, 组织ID: {}, 审核状态: {}, 备注: {}", 
                     project.getBlockchainId(), organizationId, approvalStatus, remarks);
            
            // 调用链码审核项目
            String result = fabricService.approveProject(
                project.getBlockchainId(), 
                organizationId, 
                approvalStatus, 
                remarks
            );
            
            // 保存交易记录
            saveBlockchainTransaction(project.getProjectId(), "approveProject", project.getBlockchainId(), result);
            
            log.info("区块链项目审核成功: {}, 状态: {}, 响应: {}", 
                     project.getBlockchainId(), approvalStatus, result);
            
            return true;
        } catch (Exception e) {
            log.error("区块链项目审核失败: {}", e.getMessage(), e);
            return false;
        }
    }
    
    @Override
    public String recordDonationOnBlockchain(DonationRecord donation) {
        try {
            log.info("正在记录捐赠到区块链: {}", donation.getDonationId());
            
            // 检查必要的参数
            if (donation.getProjectId() == null) {
                throw new IllegalArgumentException("捐赠记录的项目ID不能为空");
            }
            
            // 生成区块链捐赠ID
            String blockchainDonationId = "donation_" + UUID.randomUUID().toString().replace("-", "").substring(0, 16);
            
            // 将系统用户ID转换为区块链用户ID
            String donorId = "user_" + donation.getUserId();
            
            // 查找项目的区块链ID - 这里是关键改进部分
            String projectBlockchainId = null;
            
            // 1. 首先尝试使用捐赠记录中已有的交易哈希（如果是以proj_开头的）
            if (donation.getTransactionHash() != null && !donation.getTransactionHash().trim().isEmpty() && 
                donation.getTransactionHash().startsWith("proj_")) {
                projectBlockchainId = donation.getTransactionHash();
                log.info("使用捐赠记录中的交易哈希作为项目ID: {}", projectBlockchainId);
            } else {
                // 2. 从慈善项目表中查找项目的区块链ID
                CharityProject charityProject = charityProjectMapper.selectCharityProjectByProjectId(donation.getProjectId());
                if (charityProject != null && charityProject.getBlockchainId() != null && 
                    !charityProject.getBlockchainId().trim().isEmpty()) {
                    projectBlockchainId = charityProject.getBlockchainId();
                    log.info("从项目表中获取到区块链ID: {}", projectBlockchainId);
                } else if (charityProject != null) {
                    // 3. 如果项目存在但没有区块链ID，尝试自动上传项目
                    log.info("项目 [{}] 尚未上链，尝试自动上传到区块链", charityProject.getProjectId());
                    try {
                        // 调用上传项目的方法
                        projectBlockchainId = uploadProjectToBlockchain(charityProject);
                        
                        if (projectBlockchainId != null && !projectBlockchainId.isEmpty()) {
                            // 更新项目的区块链ID
                            charityProject.setBlockchainId(projectBlockchainId);
                            charityProjectMapper.updateCharityProject(charityProject);
                            
                            log.info("项目 [{}] 已成功上链，区块链ID: {}", charityProject.getProjectId(), projectBlockchainId);
                        } else {
                            throw new IllegalArgumentException("自动上传项目失败，未能获取有效的区块链ID");
                        }
                    } catch (Exception e) {
                        log.error("尝试自动上传项目 [{}] 到区块链失败: {}", charityProject.getProjectId(), e.getMessage(), e);
                        throw new IllegalArgumentException("尝试自动上传项目到区块链失败: " + e.getMessage());
                    }
                } else {
                    // 4. 如果找不到项目，提示错误
                    log.error("找不到ID为 [{}] 的慈善项目", donation.getProjectId());
                    throw new IllegalArgumentException("找不到对应的慈善项目，无法确定项目的区块链ID");
                }
            }
            
            log.info("捐赠记录上链参数 - 捐赠ID: {}, 捐赠者: {}, 项目ID: {}, 金额: {}, 方式: {}", 
                    blockchainDonationId, donorId, projectBlockchainId, 
                    donation.getDonationAmount(), donation.getPaymentMethod());
            
            // 调用链码记录捐赠
            String result = fabricService.recordDonation(
                blockchainDonationId,
                donorId,
                projectBlockchainId,
                donation.getDonationAmount().toString(),
                donation.getPaymentMethod(),
                donation.getDonationTime() != null ? String.valueOf(donation.getDonationTime().getTime()) : ""
            );
            
            log.info("捐赠记录上链成功: {}, 结果: {}", blockchainDonationId, result);
            
            // 保存交易记录
            try {
                saveBlockchainTransaction(donation.getDonationId(), "recordDonation", blockchainDonationId, result);
            } catch (Exception e) {
                log.warn("保存捐赠交易记录失败，但不影响主流程: {}", e.getMessage());
            }
            
            return blockchainDonationId;
        } catch (Exception e) {
            log.error("捐赠记录上链失败: {}", e.getMessage(), e);
            throw new RuntimeException("捐赠记录上链失败: " + e.getMessage());
        }
    }
    
    @Override
    public String generateDonationCertificate(DonationRecord donation) {
        try {
            log.info("正在生成捐赠证书: {}", donation.getDonationId());
            
            // 调用链码生成证书
            String result = fabricService.generateDonationCertificate(donation.getTransactionHash());
            
            log.info("捐赠证书生成成功: {}, 结果: {}", donation.getDonationId(), result);
            
            return result;
        } catch (Exception e) {
            log.error("捐赠证书生成失败: {}", e.getMessage(), e);
            throw new RuntimeException("捐赠证书生成失败: " + e.getMessage());
        }
    }
    
    @Override
    public String recordFundUsageOnBlockchain(FundUsageRecord fundUsage) {
        try {
            log.info("正在记录资金使用到区块链: {}", fundUsage.getUsageId());
            
            // 检查必要参数
            if (fundUsage.getProjectId() == null) {
                throw new IllegalArgumentException("资金使用记录的项目ID不能为空");
            }
            
            // 生成区块链资金使用ID
            String blockchainAllocationId = "fund_" + UUID.randomUUID().toString().replace("-", "").substring(0, 16);
            
            // 查找项目的区块链ID
            String projectBlockchainId = null;
            
            // 1. 首先尝试使用资金使用记录中已有的交易哈希（如果是以proj_开头的）
            if (fundUsage.getTransactionHash() != null && !fundUsage.getTransactionHash().trim().isEmpty() && 
                fundUsage.getTransactionHash().startsWith("proj_")) {
                projectBlockchainId = fundUsage.getTransactionHash();
                log.info("使用资金使用记录中的交易哈希作为项目ID: {}", projectBlockchainId);
            } else {
                // 2. 从慈善项目表中查找项目的区块链ID
                CharityProject charityProject = charityProjectMapper.selectCharityProjectByProjectId(fundUsage.getProjectId());
                if (charityProject != null && charityProject.getBlockchainId() != null && 
                    !charityProject.getBlockchainId().trim().isEmpty()) {
                    projectBlockchainId = charityProject.getBlockchainId();
                    log.info("从项目表中获取到区块链ID: {}", projectBlockchainId);
                } else if (charityProject != null) {
                    // 3. 如果项目存在但没有区块链ID，尝试自动上传项目
                    log.info("项目 [{}] 尚未上链，尝试自动上传到区块链", charityProject.getProjectId());
                    try {
                        // 调用上传项目的方法
                        projectBlockchainId = uploadProjectToBlockchain(charityProject);
                        
                        if (projectBlockchainId != null && !projectBlockchainId.isEmpty()) {
                            // 更新项目的区块链ID
                            charityProject.setBlockchainId(projectBlockchainId);
                            charityProjectMapper.updateCharityProject(charityProject);
                            
                            log.info("项目 [{}] 已成功上链，区块链ID: {}", charityProject.getProjectId(), projectBlockchainId);
                        } else {
                            throw new IllegalArgumentException("自动上传项目失败，未能获取有效的区块链ID");
                        }
                    } catch (Exception e) {
                        log.error("尝试自动上传项目 [{}] 到区块链失败: {}", charityProject.getProjectId(), e.getMessage(), e);
                        throw new IllegalArgumentException("尝试自动上传项目到区块链失败: " + e.getMessage());
                    }
                } else {
                    // 4. 如果找不到项目，提示错误
                    log.error("找不到ID为 [{}] 的慈善项目", fundUsage.getProjectId());
                    throw new IllegalArgumentException("找不到对应的慈善项目，无法确定项目的区块链ID");
                }
            }
            
            log.info("资金使用记录上链参数 - 资金使用ID: {}, 项目ID: {}, 金额: {}, 用途: {}", 
                    blockchainAllocationId, projectBlockchainId, 
                    fundUsage.getAmount(), fundUsage.getUsageDesc());
            
            // 调用链码记录资金使用
            String result = fabricService.recordFundAllocation(
                blockchainAllocationId,
                projectBlockchainId, // 使用项目的区块链ID
                fundUsage.getAmount().toString(),
                fundUsage.getUsageDesc(),
                "recipient_" + SecurityUtils.getUserId(),
                fundUsage.getUsageTime() != null ? String.valueOf(fundUsage.getUsageTime().getTime()) : ""
            );
            
            // 保存交易记录
            try {
                saveBlockchainTransaction(fundUsage.getUsageId(), "recordFundAllocation", blockchainAllocationId, result);
            } catch (Exception e) {
                log.warn("保存资金使用交易记录失败，但不影响主流程: {}", e.getMessage());
            }
            
            log.info("资金使用记录上链成功: {}, 结果: {}", blockchainAllocationId, result);
            
            return blockchainAllocationId;
        } catch (Exception e) {
            log.error("资金使用记录上链失败: {}", e.getMessage(), e);
            throw new RuntimeException("资金使用记录上链失败: " + e.getMessage());
        }
    }
    
    // 构建项目信息JSON
    private String buildProjectInfoJson(CharityProject project) {
        StringBuilder sb = new StringBuilder();
        sb.append("{");
        sb.append("\"organizationId\":\"org_").append(project.getInitiatorId()).append("\",");
        sb.append("\"name\":\"").append(project.getProjectName()).append("\",");
        sb.append("\"description\":\"").append(project.getProjectDesc()).append("\",");
        sb.append("\"targetAmount\":\"").append(project.getTargetAmount()).append("\",");
        
        if (project.getStartTime() != null) {
            sb.append("\"startDate\":\"").append(project.getStartTime()).append("\",");
        }
        
        if (project.getEndTime() != null) {
            sb.append("\"endDate\":\"").append(project.getEndTime()).append("\"");
        } else {
            // 移除最后一个逗号
            if (sb.charAt(sb.length() - 1) == ',') {
                sb.deleteCharAt(sb.length() - 1);
            }
        }
        
        sb.append("}");
        return sb.toString();
    }
} 