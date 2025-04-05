package com.ruoyi.charity.blockchain.service;

import com.ruoyi.charity.domain.CharityProject;
import com.ruoyi.charity.domain.DonationRecord;
import com.ruoyi.charity.domain.FundUsageRecord;

/**
 * 区块链集成服务接口
 * 
 * @author ruoyi
 * @date 2025-04-05
 */
public interface BlockchainIntegrationService {
    
    /**
     * 将慈善项目上传到区块链
     * 
     * @param project 慈善项目信息
     * @return 区块链上的项目ID
     */
    String uploadProjectToBlockchain(CharityProject project);
    
    /**
     * 在区块链上审核项目
     * 
     * @param project 慈善项目信息
     * @return 是否成功
     */
    boolean approveProjectOnBlockchain(CharityProject project);
    
    /**
     * 将捐赠记录上传到区块链
     * 
     * @param donation 捐赠记录信息
     * @return 区块链上的捐赠ID
     */
    String recordDonationOnBlockchain(DonationRecord donation);
    
    /**
     * 生成捐赠证书
     * 
     * @param donation 捐赠记录信息
     * @return 证书信息
     */
    String generateDonationCertificate(DonationRecord donation);
    
    /**
     * 将资金使用记录上传到区块链
     * 
     * @param fundUsage 资金使用记录
     * @return 区块链上的资金使用ID
     */
    String recordFundUsageOnBlockchain(FundUsageRecord fundUsage);
} 