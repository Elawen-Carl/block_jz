package com.ruoyi.charity.service.impl;

import com.ruoyi.charity.domain.DonationRecord;
import com.ruoyi.charity.domain.CharityProject;
import com.ruoyi.charity.mapper.DonationRecordMapper;
import com.ruoyi.charity.mapper.CharityProjectMapper;
import com.ruoyi.charity.service.IDonationRecordService;
import com.ruoyi.charity.blockchain.service.BlockchainIntegrationService;
import com.ruoyi.common.utils.DateUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.List;

/**
 * 捐赠记录Service业务层处理
 * 
 * @author ruoyi
 * @date 2025-04-03
 */
@Service
public class DonationRecordServiceImpl implements IDonationRecordService 
{
    private static final Logger log = LoggerFactory.getLogger(DonationRecordServiceImpl.class);
    
    @Autowired
    private DonationRecordMapper donationRecordMapper;

    @Autowired
    private CharityProjectMapper charityProjectMapper;
    
    @Autowired
    private BlockchainIntegrationService blockchainService;

    /**
     * 查询捐赠记录
     * 
     * @param donationId 捐赠记录主键
     * @return 捐赠记录
     */
    @Override
    public DonationRecord selectDonationRecordByDonationId(Long donationId)
    {
        return donationRecordMapper.selectDonationRecordByDonationId(donationId);
    }

    /**
     * 查询捐赠记录列表
     * 
     * @param donationRecord 捐赠记录
     * @return 捐赠记录
     */
    @Override
    public List<DonationRecord> selectDonationRecordList(DonationRecord donationRecord)
    {
        return donationRecordMapper.selectDonationRecordList(donationRecord);
    }

    /**
     * 新增捐赠记录
     * 
     * @param donationRecord 捐赠记录
     * @return 结果
     */
    @Override
    @Transactional
    public int insertDonationRecord(DonationRecord donationRecord)
    {
        donationRecord.setCreateTime(DateUtils.getNowDate());
        donationRecord.setDonationTime(DateUtils.getNowDate());
        
        // 更新项目已筹金额
        if (donationRecord.getProjectId() != null && donationRecord.getDonationAmount() != null) {
            // 查询当前项目
            CharityProject project = charityProjectMapper.selectCharityProjectByProjectId(donationRecord.getProjectId());
            if (project != null) {
                // 更新项目已筹金额
                BigDecimal newAmount = project.getCurrentAmount().add(donationRecord.getDonationAmount());
                project.setCurrentAmount(newAmount);
                charityProjectMapper.updateCharityProject(project);
            }
        }
        
        int rows = donationRecordMapper.insertDonationRecord(donationRecord);
        
        if (rows > 0) {
            try {
                // 将捐赠记录上传到区块链
                String blockchainDonationId = blockchainService.recordDonationOnBlockchain(donationRecord);
                
                // 更新交易哈希值
                donationRecord.setTransactionHash(blockchainDonationId);
                donationRecordMapper.updateDonationRecord(donationRecord);
                
                log.info("捐赠记录 {} 成功上传到区块链, ID: {}", donationRecord.getDonationId(), blockchainDonationId);
            } catch (Exception e) {
                log.error("捐赠记录上传区块链失败: {}", e.getMessage(), e);
                // 继续处理，区块链上传失败不影响主流程
            }
        }
        
        return rows;
    }

    /**
     * 修改捐赠记录
     * 
     * @param donationRecord 捐赠记录
     * @return 结果
     */
    @Override
    public int updateDonationRecord(DonationRecord donationRecord)
    {
        donationRecord.setUpdateTime(DateUtils.getNowDate());

        return donationRecordMapper.updateDonationRecord(donationRecord);
    }
    
    /**
     * 生成捐赠证书
     * 
     * @param donationId 捐赠记录ID
     * @return 是否成功
     */
    @Override
    public boolean generateCertificate(Long donationId)
    {
        DonationRecord donation = donationRecordMapper.selectDonationRecordByDonationId(donationId);
        if (donation == null) {
            return false;
        }
        
        // 检查是否已经有证书
        if (donation.getCertificateUrl() != null && !donation.getCertificateUrl().isEmpty()) {
            return true;
        }
        
        // 检查是否有区块链交易哈希
        if (donation.getTransactionHash() == null || donation.getTransactionHash().isEmpty()) {
            log.error("捐赠记录没有区块链交易哈希，无法生成证书: {}", donationId);
            return false;
        }
        
        try {
            // 调用区块链生成证书
            String certificateInfo = blockchainService.generateDonationCertificate(donation);
            
            // 设置证书信息
            donation.setCertificateUrl(certificateInfo);
            donation.setCertificateIssueDate(DateUtils.getNowDate());
            
            // 更新捐赠记录
            donationRecordMapper.updateDonationRecord(donation);
            
            log.info("为捐赠记录 {} 成功生成证书", donationId);
            return true;
        } catch (Exception e) {
            log.error("捐赠证书生成失败: {}", e.getMessage(), e);
            return false;
        }
    }

    /**
     * 批量删除捐赠记录
     * 
     * @param donationIds 需要删除的捐赠记录主键
     * @return 结果
     */
    @Override
    public int deleteDonationRecordByDonationIds(Long[] donationIds)
    {
        return donationRecordMapper.deleteDonationRecordByDonationIds(donationIds);
    }

    /**
     * 删除捐赠记录信息
     * 
     * @param donationId 捐赠记录主键
     * @return 结果
     */
    @Override
    public int deleteDonationRecordByDonationId(Long donationId)
    {
        return donationRecordMapper.deleteDonationRecordByDonationId(donationId);
    }
}
