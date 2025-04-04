package com.ruoyi.charity.service.impl;

import com.ruoyi.charity.domain.DonationRecord;
import com.ruoyi.charity.mapper.DonationRecordMapper;
import com.ruoyi.charity.service.IDonationRecordService;
import com.ruoyi.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
    @Autowired
    private DonationRecordMapper donationRecordMapper;

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
    public int insertDonationRecord(DonationRecord donationRecord)
    {
        donationRecord.setCreateTime(DateUtils.getNowDate());
        donationRecord.setDonationTime(DateUtils.getNowDate());
        return donationRecordMapper.insertDonationRecord(donationRecord);
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
