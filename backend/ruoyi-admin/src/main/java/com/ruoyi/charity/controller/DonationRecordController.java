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
import com.ruoyi.charity.domain.DonationRecord;
import com.ruoyi.charity.service.IDonationRecordService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 捐赠记录Controller
 * 
 * @author ruoyi
 * @date 2025-04-03
 */
@RestController
@RequestMapping("/charity/donation")
public class DonationRecordController extends BaseController
{
    @Autowired
    private IDonationRecordService donationRecordService;

    /**
     * 查询捐赠记录列表
     */
    @PreAuthorize("@ss.hasPermi('charity:donation:list')")
    @GetMapping("/list")
    public TableDataInfo list(DonationRecord donationRecord)
    {
        startPage();
        List<DonationRecord> list = donationRecordService.selectDonationRecordList(donationRecord);
        return getDataTable(list);
    }

    /**
     * 导出捐赠记录列表
     */
    @PreAuthorize("@ss.hasPermi('charity:donation:export')")
    @Log(title = "捐赠记录", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, DonationRecord donationRecord)
    {
        List<DonationRecord> list = donationRecordService.selectDonationRecordList(donationRecord);
        ExcelUtil<DonationRecord> util = new ExcelUtil<DonationRecord>(DonationRecord.class);
        util.exportExcel(response, list, "捐赠记录数据");
    }

    /**
     * 获取捐赠记录详细信息
     */
    @PreAuthorize("@ss.hasPermi('charity:donation:query')")
    @GetMapping(value = "/{donationId}")
    public AjaxResult getInfo(@PathVariable("donationId") Long donationId)
    {
        return success(donationRecordService.selectDonationRecordByDonationId(donationId));
    }

    /**
     * 新增捐赠记录
     */
    @PreAuthorize("@ss.hasPermi('charity:donation:add')")
    @Log(title = "捐赠记录", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody DonationRecord donationRecord)
    {
        // 如果没有提供用户ID，则使用当前登录用户的ID
        if (donationRecord.getUserId() == null) {
            donationRecord.setUserId(getUserId());
        }
        return toAjax(donationRecordService.insertDonationRecord(donationRecord));
    }

    /**
     * 修改捐赠记录
     */
    @PreAuthorize("@ss.hasPermi('charity:donation:edit')")
    @Log(title = "捐赠记录", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody DonationRecord donationRecord)
    {
        return toAjax(donationRecordService.updateDonationRecord(donationRecord));
    }

    /**
     * 删除捐赠记录
     */
    @PreAuthorize("@ss.hasPermi('charity:donation:remove')")
    @Log(title = "捐赠记录", businessType = BusinessType.DELETE)
	@DeleteMapping("/{donationIds}")
    public AjaxResult remove(@PathVariable Long[] donationIds)
    {
        return toAjax(donationRecordService.deleteDonationRecordByDonationIds(donationIds));
    }
}
