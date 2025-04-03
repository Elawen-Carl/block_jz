package com.ruoyi.charity.service.impl;

import java.util.List;
import com.ruoyi.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.charity.mapper.UserPrivacySettingsMapper;
import com.ruoyi.charity.domain.UserPrivacySettings;
import com.ruoyi.charity.service.IUserPrivacySettingsService;

/**
 * 用户隐私设置Service业务层处理
 * 
 * @author ruoyi
 * @date 2025-04-03
 */
@Service
public class UserPrivacySettingsServiceImpl implements IUserPrivacySettingsService 
{
    @Autowired
    private UserPrivacySettingsMapper userPrivacySettingsMapper;

    /**
     * 查询用户隐私设置
     * 
     * @param userId 用户隐私设置主键
     * @return 用户隐私设置
     */
    @Override
    public UserPrivacySettings selectUserPrivacySettingsByUserId(Long userId)
    {
        return userPrivacySettingsMapper.selectUserPrivacySettingsByUserId(userId);
    }

    /**
     * 查询用户隐私设置列表
     * 
     * @param userPrivacySettings 用户隐私设置
     * @return 用户隐私设置
     */
    @Override
    public List<UserPrivacySettings> selectUserPrivacySettingsList(UserPrivacySettings userPrivacySettings)
    {
        return userPrivacySettingsMapper.selectUserPrivacySettingsList(userPrivacySettings);
    }

    /**
     * 新增用户隐私设置
     * 
     * @param userPrivacySettings 用户隐私设置
     * @return 结果
     */
    @Override
    public int insertUserPrivacySettings(UserPrivacySettings userPrivacySettings)
    {
        userPrivacySettings.setCreateTime(DateUtils.getNowDate());
        return userPrivacySettingsMapper.insertUserPrivacySettings(userPrivacySettings);
    }

    /**
     * 修改用户隐私设置
     * 
     * @param userPrivacySettings 用户隐私设置
     * @return 结果
     */
    @Override
    public int updateUserPrivacySettings(UserPrivacySettings userPrivacySettings)
    {
        userPrivacySettings.setUpdateTime(DateUtils.getNowDate());
        return userPrivacySettingsMapper.updateUserPrivacySettings(userPrivacySettings);
    }

    /**
     * 批量删除用户隐私设置
     * 
     * @param userIds 需要删除的用户隐私设置主键
     * @return 结果
     */
    @Override
    public int deleteUserPrivacySettingsByUserIds(Long[] userIds)
    {
        return userPrivacySettingsMapper.deleteUserPrivacySettingsByUserIds(userIds);
    }

    /**
     * 删除用户隐私设置信息
     * 
     * @param userId 用户隐私设置主键
     * @return 结果
     */
    @Override
    public int deleteUserPrivacySettingsByUserId(Long userId)
    {
        return userPrivacySettingsMapper.deleteUserPrivacySettingsByUserId(userId);
    }
}
