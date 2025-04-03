package com.ruoyi.charity.controller;

import java.util.List;
import javax.servlet.http.HttpServletResponse;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.charity.domain.UserPrivacySettings;
import com.ruoyi.charity.service.IUserPrivacySettingsService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 用户隐私设置Controller
 * 
 * @author ruoyi
 * @date 2025-04-03
 */
@RestController
@RequestMapping("/charity/privacy")
public class UserPrivacySettingsController extends BaseController
{
    @Autowired
    private IUserPrivacySettingsService userPrivacySettingsService;

    /**
     * 查询用户隐私设置列表
     */
    @PreAuthorize("@ss.hasPermi('charity:privacy:list')")
    @GetMapping("/list")
    public TableDataInfo list(UserPrivacySettings userPrivacySettings)
    {
        startPage();
        List<UserPrivacySettings> list = userPrivacySettingsService.selectUserPrivacySettingsList(userPrivacySettings);
        return getDataTable(list);
    }

    /**
     * 导出用户隐私设置列表
     */
    @PreAuthorize("@ss.hasPermi('charity:privacy:export')")
    @Log(title = "用户隐私设置", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, UserPrivacySettings userPrivacySettings)
    {
        List<UserPrivacySettings> list = userPrivacySettingsService.selectUserPrivacySettingsList(userPrivacySettings);
        ExcelUtil<UserPrivacySettings> util = new ExcelUtil<UserPrivacySettings>(UserPrivacySettings.class);
        util.exportExcel(response, list, "用户隐私设置数据");
    }

    /**
     * 获取用户隐私设置详细信息
     */
    @PreAuthorize("@ss.hasPermi('charity:privacy:query')")
    @GetMapping(value = "/{userId}")
    public AjaxResult getInfo(@PathVariable("userId") Long userId)
    {
        return success(userPrivacySettingsService.selectUserPrivacySettingsByUserId(userId));
    }

    /**
     * 新增用户隐私设置
     */
    @PreAuthorize("@ss.hasPermi('charity:privacy:add')")
    @Log(title = "用户隐私设置", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody UserPrivacySettings userPrivacySettings)
    {
        return toAjax(userPrivacySettingsService.insertUserPrivacySettings(userPrivacySettings));
    }

    /**
     * 修改用户隐私设置
     */
    @PreAuthorize("@ss.hasPermi('charity:privacy:edit')")
    @Log(title = "用户隐私设置", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody UserPrivacySettings userPrivacySettings)
    {
        return toAjax(userPrivacySettingsService.updateUserPrivacySettings(userPrivacySettings));
    }

    /**
     * 删除用户隐私设置
     */
    @PreAuthorize("@ss.hasPermi('charity:privacy:remove')")
    @Log(title = "用户隐私设置", businessType = BusinessType.DELETE)
	@DeleteMapping("/{userIds}")
    public AjaxResult remove(@PathVariable Long[] userIds)
    {
        return toAjax(userPrivacySettingsService.deleteUserPrivacySettingsByUserIds(userIds));
    }
}
