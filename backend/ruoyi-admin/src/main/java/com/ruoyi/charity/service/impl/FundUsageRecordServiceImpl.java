package com.ruoyi.charity.service.impl;

import java.util.Date;
import java.util.List;
import com.ruoyi.common.utils.DateUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.ruoyi.charity.mapper.FundUsageRecordMapper;
import com.ruoyi.charity.domain.FundUsageRecord;
import com.ruoyi.charity.service.IFundUsageRecordService;
import com.ruoyi.charity.blockchain.service.BlockchainIntegrationService;

/**
 * 资金使用记录Service业务层处理
 * 
 * @author ruoyi
 * @date 2025-04-03
 */
@Service
public class FundUsageRecordServiceImpl implements IFundUsageRecordService 
{
    private static final Logger log = LoggerFactory.getLogger(FundUsageRecordServiceImpl.class);
    
    @Autowired
    private FundUsageRecordMapper fundUsageRecordMapper;
    
    @Autowired
    private BlockchainIntegrationService blockchainService;

    /**
     * 查询资金使用记录
     * 
     * @param usageId 资金使用记录主键
     * @return 资金使用记录
     */
    @Override
    public FundUsageRecord selectFundUsageRecordByUsageId(Long usageId)
    {
        return fundUsageRecordMapper.selectFundUsageRecordByUsageId(usageId);
    }

    /**
     * 查询资金使用记录列表
     * 
     * @param fundUsageRecord 资金使用记录
     * @return 资金使用记录
     */
    @Override
    public List<FundUsageRecord> selectFundUsageRecordList(FundUsageRecord fundUsageRecord)
    {
        return fundUsageRecordMapper.selectFundUsageRecordList(fundUsageRecord);
    }

    /**
     * 新增资金使用记录
     * 
     * @param fundUsageRecord 资金使用记录
     * @return 结果
     */
    @Override
    @Transactional
    public int insertFundUsageRecord(FundUsageRecord fundUsageRecord)
    {
        fundUsageRecord.setCreateTime(DateUtils.getNowDate());
        // 如果没有设置申请状态，默认设置为待审核
        if (fundUsageRecord.getApplicationStatus() == null) {
            fundUsageRecord.setApplicationStatus("1");
        }
        
        return fundUsageRecordMapper.insertFundUsageRecord(fundUsageRecord);
    }

    /**
     * 修改资金使用记录
     * 
     * @param fundUsageRecord 资金使用记录
     * @return 结果
     */
    @Override
    public int updateFundUsageRecord(FundUsageRecord fundUsageRecord)
    {
        return fundUsageRecordMapper.updateFundUsageRecord(fundUsageRecord);
    }
    
    /**
     * 审核资金使用申请
     * 
     * @param fundUsageRecord 资金使用记录
     * @return 结果
     */
    @Override
    @Transactional
    public int auditFundUsageRecord(FundUsageRecord fundUsageRecord)
    {
        // 如果没有设置审核时间，默认为当前时间
        if (fundUsageRecord.getAuditTime() == null) {
            fundUsageRecord.setAuditTime(new Date());
        }
        
        // 确保我们有完整的记录信息
        FundUsageRecord fullRecord = null;
        if (fundUsageRecord.getUsageId() != null) {
            fullRecord = selectFundUsageRecordByUsageId(fundUsageRecord.getUsageId());
            if (fullRecord != null) {
                // 更新审核信息
                fullRecord.setApplicationStatus(fundUsageRecord.getApplicationStatus());
                fullRecord.setAuditTime(fundUsageRecord.getAuditTime());
                fullRecord.setAuditor(fundUsageRecord.getAuditor());
                fullRecord.setAuditRemark(fundUsageRecord.getAuditRemark());
            } else {
                fullRecord = fundUsageRecord;
            }
        } else {
            fullRecord = fundUsageRecord;
        }
        
        // 如果审核通过，上传到区块链
        if ("2".equals(fundUsageRecord.getApplicationStatus())) {
            try {
                // 确保记录中有项目ID
                if (fullRecord.getProjectId() == null) {
                    log.warn("资金使用记录缺少项目ID，无法上传到区块链");
                } else {
                    log.info("审核通过，开始上传资金使用记录到区块链: {}", fullRecord.getUsageId());
                    
                    // 调用区块链服务记录资金使用
                    String blockchainId = blockchainService.recordFundUsageOnBlockchain(fullRecord);
                    
                    // 更新交易哈希
                    fundUsageRecord.setTransactionHash(blockchainId);
                    
                    log.info("资金使用记录 {} 成功上传到区块链, 交易哈希: {}", fullRecord.getUsageId(), blockchainId);
                }
            } catch (Exception e) {
                log.error("资金使用记录上传区块链失败: {}", e.getMessage(), e);
                // 区块链上传失败不影响主流程
            }
        }
        
        return fundUsageRecordMapper.updateFundAuditStatus(fundUsageRecord);
    }

    /**
     * 批量删除资金使用记录
     * 
     * @param usageIds 需要删除的资金使用记录主键
     * @return 结果
     */
    @Override
    public int deleteFundUsageRecordByUsageIds(Long[] usageIds)
    {
        return fundUsageRecordMapper.deleteFundUsageRecordByUsageIds(usageIds);
    }

    /**
     * 删除资金使用记录信息
     * 
     * @param usageId 资金使用记录主键
     * @return 结果
     */
    @Override
    public int deleteFundUsageRecordByUsageId(Long usageId)
    {
        return fundUsageRecordMapper.deleteFundUsageRecordByUsageId(usageId);
    }
}
