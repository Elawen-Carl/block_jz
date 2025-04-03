package com.ruoyi.charity.mapper;

import java.util.List;
import com.ruoyi.charity.domain.DonationRecord;

/**
 * 捐赠记录Mapper接口
 * 
 * @author ruoyi
 * @date 2025-04-03
 */
public interface DonationRecordMapper 
{
    /**
     * 查询捐赠记录
     * 
     * @param donationId 捐赠记录主键
     * @return 捐赠记录
     */
    public DonationRecord selectDonationRecordByDonationId(Long donationId);

    /**
     * 查询捐赠记录列表
     * 
     * @param donationRecord 捐赠记录
     * @return 捐赠记录集合
     */
    public List<DonationRecord> selectDonationRecordList(DonationRecord donationRecord);

    /**
     * 新增捐赠记录
     * 
     * @param donationRecord 捐赠记录
     * @return 结果
     */
    public int insertDonationRecord(DonationRecord donationRecord);

    /**
     * 修改捐赠记录
     * 
     * @param donationRecord 捐赠记录
     * @return 结果
     */
    public int updateDonationRecord(DonationRecord donationRecord);

    /**
     * 删除捐赠记录
     * 
     * @param donationId 捐赠记录主键
     * @return 结果
     */
    public int deleteDonationRecordByDonationId(Long donationId);

    /**
     * 批量删除捐赠记录
     * 
     * @param donationIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteDonationRecordByDonationIds(Long[] donationIds);
}
