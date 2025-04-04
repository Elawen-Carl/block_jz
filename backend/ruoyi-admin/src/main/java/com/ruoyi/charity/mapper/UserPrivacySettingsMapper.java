package com.ruoyi.charity.mapper;

import java.util.List;
import com.ruoyi.charity.domain.UserPrivacySettings;

/**
 * 用户隐私设置Mapper接口
 * 
 * @author ruoyi
 * @date 2025-04-03
 */
public interface UserPrivacySettingsMapper 
{
    /**
     * 查询用户隐私设置
     * 
     * @param userId 用户隐私设置主键
     * @return 用户隐私设置
     */
    public UserPrivacySettings selectUserPrivacySettingsByUserId(Long userId);

    /**
     * 查询用户隐私设置列表
     * 
     * @param userPrivacySettings 用户隐私设置
     * @return 用户隐私设置集合
     */
    public List<UserPrivacySettings> selectUserPrivacySettingsList(UserPrivacySettings userPrivacySettings);

    /**
     * 新增用户隐私设置
     * 
     * @param userPrivacySettings 用户隐私设置
     * @return 结果
     */
    public int insertUserPrivacySettings(UserPrivacySettings userPrivacySettings);

    /**
     * 修改用户隐私设置
     * 
     * @param userPrivacySettings 用户隐私设置
     * @return 结果
     */
    public int updateUserPrivacySettings(UserPrivacySettings userPrivacySettings);

    /**
     * 删除用户隐私设置
     * 
     * @param userId 用户隐私设置主键
     * @return 结果
     */
    public int deleteUserPrivacySettingsByUserId(Long userId);

    /**
     * 批量删除用户隐私设置
     * 
     * @param userIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteUserPrivacySettingsByUserIds(Long[] userIds);
}
