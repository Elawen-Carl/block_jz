package com.ruoyi.charity.service.impl;

import java.util.List;
import com.ruoyi.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.charity.mapper.FundUsageRecordMapper;
import com.ruoyi.charity.domain.FundUsageRecord;
import com.ruoyi.charity.service.IFundUsageRecordService;

/**
 * 资金使用记录Service业务层处理
 * 
 * @author ruoyi
 * @date 2025-04-03
 */
@Service
public class FundUsageRecordServiceImpl implements IFundUsageRecordService 
{
    @Autowired
    private FundUsageRecordMapper fundUsageRecordMapper;

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
    public int insertFundUsageRecord(FundUsageRecord fundUsageRecord)
    {
        fundUsageRecord.setCreateTime(DateUtils.getNowDate());
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
