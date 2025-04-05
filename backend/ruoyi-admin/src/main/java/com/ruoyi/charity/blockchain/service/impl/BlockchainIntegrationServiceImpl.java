package com.ruoyi.charity.blockchain.service.impl;

import com.ruoyi.charity.blockchain.service.BlockchainIntegrationService;
import com.ruoyi.charity.blockchain.service.FabricService;
import com.ruoyi.charity.domain.BlockchainTransaction;
import com.ruoyi.charity.domain.CharityProject;
import com.ruoyi.charity.domain.DonationRecord;
import com.ruoyi.charity.domain.FundUsageRecord;
import com.ruoyi.charity.service.IBlockchainTransactionService;
import com.ruoyi.common.utils.SecurityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
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
    
    @Override
    public String uploadProjectToBlockchain(CharityProject project) {
        try {
            log.info("正在上传项目到区块链: {}", project.getProjectName());
            
            // 生成区块链项目ID
            String blockchainProjectId = "project_" + UUID.randomUUID().toString().replace("-", "").substring(0, 16);
            
            // 构建项目信息JSON
            String projectInfo = buildProjectInfoJson(project);
            
            // 调用链码上传项目
            String result = fabricService.createCharityProject(blockchainProjectId, projectInfo);
            
            log.info("项目上传区块链成功: {}, 结果: {}", blockchainProjectId, result);
            
            return blockchainProjectId;
        } catch (Exception e) {
            log.error("项目上传区块链失败: {}", e.getMessage(), e);
            throw new RuntimeException("项目上传区块链失败: " + e.getMessage());
        }
    }
    
    @Override
    public boolean approveProjectOnBlockchain(CharityProject project) {
        try {
            log.info("正在审核区块链项目: {}", project.getBlockchainId());
            
            String organizationId = "org_" + SecurityUtils.getUserId();
            String approvalStatus = "1".equals(project.getAuditStatus()) ? "approved" : "rejected";
            String remarks = project.getAuditRemark() != null ? project.getAuditRemark() : "";
            
            // 调用链码审核项目
            String result = fabricService.approveProject(
                project.getBlockchainId(), 
                organizationId, 
                approvalStatus, 
                remarks
            );
            
            log.info("区块链项目审核成功: {}, 状态: {}", project.getBlockchainId(), approvalStatus);
            
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
            
            CharityProject project = new CharityProject();
            project.setProjectId(donation.getProjectId());
            
            // 生成区块链捐赠ID
            String blockchainDonationId = "donation_" + UUID.randomUUID().toString().replace("-", "").substring(0, 16);
            
            // 将系统用户ID转换为区块链用户ID
            String donorId = "user_" + donation.getUserId();
            
            // 调用链码记录捐赠
            String result = fabricService.recordDonation(
                blockchainDonationId,
                donorId,
                donation.getTransactionHash(), // 使用交易哈希作为项目ID
                donation.getDonationAmount().toString(),
                donation.getPaymentMethod(),
                donation.getDonationTime() != null ? String.valueOf(donation.getDonationTime().getTime()) : ""
            );
            
            log.info("捐赠记录上链成功: {}, 结果: {}", blockchainDonationId, result);
            
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
            
            // 生成区块链资金使用ID
            String blockchainAllocationId = "fund_" + UUID.randomUUID().toString().replace("-", "").substring(0, 16);
            
            // 调用链码记录资金使用
            String result = fabricService.recordFundAllocation(
                blockchainAllocationId,
                fundUsage.getTransactionHash(), // 使用交易哈希作为项目ID
                fundUsage.getAmount().toString(),
                fundUsage.getUsageDesc(),
                "recipient_" + SecurityUtils.getUserId(),
                fundUsage.getUsageTime() != null ? String.valueOf(fundUsage.getUsageTime().getTime()) : ""
            );
            
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