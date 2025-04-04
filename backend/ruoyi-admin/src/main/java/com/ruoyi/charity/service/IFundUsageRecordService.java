package com.ruoyi.charity.service;

import java.util.List;
import com.ruoyi.charity.domain.FundUsageRecord;

/**
 * 资金使用记录Service接口
 * 
 * @author ruoyi
 * @date 2025-04-03
 */
public interface IFundUsageRecordService 
{
    /**
     * 查询资金使用记录
     * 
     * @param usageId 资金使用记录主键
     * @return 资金使用记录
     */
    public FundUsageRecord selectFundUsageRecordByUsageId(Long usageId);

    /**
     * 查询资金使用记录列表
     * 
     * @param fundUsageRecord 资金使用记录
     * @return 资金使用记录集合
     */
    public List<FundUsageRecord> selectFundUsageRecordList(FundUsageRecord fundUsageRecord);

    /**
     * 新增资金使用记录
     * 
     * @param fundUsageRecord 资金使用记录
     * @return 结果
     */
    public int insertFundUsageRecord(FundUsageRecord fundUsageRecord);

    /**
     * 修改资金使用记录
     * 
     * @param fundUsageRecord 资金使用记录
     * @return 结果
     */
    public int updateFundUsageRecord(FundUsageRecord fundUsageRecord);
    
    /**
     * 审核资金使用申请
     * 
     * @param fundUsageRecord 资金使用记录
     * @return 结果
     */
    public int auditFundUsageRecord(FundUsageRecord fundUsageRecord);

    /**
     * 批量删除资金使用记录
     * 
     * @param usageIds 需要删除的资金使用记录主键集合
     * @return 结果
     */
    public int deleteFundUsageRecordByUsageIds(Long[] usageIds);

    /**
     * 删除资金使用记录信息
     * 
     * @param usageId 资金使用记录主键
     * @return 结果
     */
    public int deleteFundUsageRecordByUsageId(Long usageId);
}
