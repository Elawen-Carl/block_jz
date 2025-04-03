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
import com.ruoyi.charity.domain.FundUsageRecord;
import com.ruoyi.charity.service.IFundUsageRecordService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 资金使用记录Controller
 * 
 * @author ruoyi
 * @date 2025-04-03
 */
@RestController
@RequestMapping("/charity/fund")
public class FundUsageRecordController extends BaseController
{
    @Autowired
    private IFundUsageRecordService fundUsageRecordService;

    /**
     * 查询资金使用记录列表
     */
    @PreAuthorize("@ss.hasPermi('charity:fund:list')")
    @GetMapping("/list")
    public TableDataInfo list(FundUsageRecord fundUsageRecord)
    {
        startPage();
        List<FundUsageRecord> list = fundUsageRecordService.selectFundUsageRecordList(fundUsageRecord);
        return getDataTable(list);
    }

    /**
     * 导出资金使用记录列表
     */
    @PreAuthorize("@ss.hasPermi('charity:fund:export')")
    @Log(title = "资金使用记录", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, FundUsageRecord fundUsageRecord)
    {
        List<FundUsageRecord> list = fundUsageRecordService.selectFundUsageRecordList(fundUsageRecord);
        ExcelUtil<FundUsageRecord> util = new ExcelUtil<FundUsageRecord>(FundUsageRecord.class);
        util.exportExcel(response, list, "资金使用记录数据");
    }

    /**
     * 获取资金使用记录详细信息
     */
    @PreAuthorize("@ss.hasPermi('charity:fund:query')")
    @GetMapping(value = "/{usageId}")
    public AjaxResult getInfo(@PathVariable("usageId") Long usageId)
    {
        return success(fundUsageRecordService.selectFundUsageRecordByUsageId(usageId));
    }

    /**
     * 新增资金使用记录
     */
    @PreAuthorize("@ss.hasPermi('charity:fund:add')")
    @Log(title = "资金使用记录", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody FundUsageRecord fundUsageRecord)
    {
        return toAjax(fundUsageRecordService.insertFundUsageRecord(fundUsageRecord));
    }

    /**
     * 修改资金使用记录
     */
    @PreAuthorize("@ss.hasPermi('charity:fund:edit')")
    @Log(title = "资金使用记录", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody FundUsageRecord fundUsageRecord)
    {
        return toAjax(fundUsageRecordService.updateFundUsageRecord(fundUsageRecord));
    }

    /**
     * 删除资金使用记录
     */
    @PreAuthorize("@ss.hasPermi('charity:fund:remove')")
    @Log(title = "资金使用记录", businessType = BusinessType.DELETE)
	@DeleteMapping("/{usageIds}")
    public AjaxResult remove(@PathVariable Long[] usageIds)
    {
        return toAjax(fundUsageRecordService.deleteFundUsageRecordByUsageIds(usageIds));
    }
}
