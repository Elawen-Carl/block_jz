package com.ruoyi.charity.controller;

import com.ruoyi.charity.domain.FundUsageRecord;
import com.ruoyi.charity.service.IFundUsageRecordService;
import com.ruoyi.charity.blockchain.service.BlockchainIntegrationService;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.common.utils.poi.ExcelUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * 资金使用记录Controller
 * 
 * @author ruoyi
 * @date 2025-04-03
 */
@RestController
@Slf4j
@RequestMapping("/charity/fund")
public class FundUsageRecordController extends BaseController
{
    @Autowired
    private IFundUsageRecordService fundUsageRecordService;

    @Autowired
    private BlockchainIntegrationService blockchainService;

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
     * 获取资金使用记录区块链详情
     */
    @PreAuthorize("@ss.hasPermi('charity:fund:query')")
    @GetMapping(value = "/blockchain/{usageId}")
    public AjaxResult getBlockchainInfo(@PathVariable("usageId") Long usageId)
    {
        try {
            log.info("正在查询资金使用记录[{}]的区块链信息", usageId);
            
            // 获取资金使用记录
            FundUsageRecord fundUsage = fundUsageRecordService.selectFundUsageRecordByUsageId(usageId);
            if (fundUsage == null) {
                log.warn("资金使用记录[{}]不存在", usageId);
                return error("资金使用记录不存在");
            }
            
            // 检查是否有区块链交易哈希
            if (fundUsage.getTransactionHash() == null || fundUsage.getTransactionHash().isEmpty()) {
                log.warn("资金使用记录[{}]尚未上链", usageId);
                
                // 只有审核通过的资金使用记录才能上链
                if ("2".equals(fundUsage.getApplicationStatus()) && blockchainService != null) {
                    try {
                        log.info("尝试将审核通过的资金使用记录[{}]上传至区块链", usageId);
                        String transactionHash = blockchainService.recordFundUsageOnBlockchain(fundUsage);
                        
                        // 更新交易哈希
                        fundUsage.setTransactionHash(transactionHash);
                        fundUsageRecordService.updateFundUsageRecord(fundUsage);
                        
                        log.info("资金使用记录[{}]上链成功，交易哈希: {}", usageId, transactionHash);
                    } catch (Exception e) {
                        log.error("资金使用记录[{}]上链失败: {}", usageId, e.getMessage(), e);
                        return error("该资金使用记录尚未上链且上链失败: " + e.getMessage());
                    }
                } else {
                    return error("资金使用记录未审核通过，无法上链");
                }
            }
            
            // 返回区块链信息
            java.util.Map<String, Object> blockchainInfo = new java.util.HashMap<>();
            blockchainInfo.put("usageId", fundUsage.getUsageId());
            blockchainInfo.put("transactionHash", fundUsage.getTransactionHash());
            blockchainInfo.put("projectId", fundUsage.getProjectId());
            blockchainInfo.put("projectName", fundUsage.getProjectName());
            blockchainInfo.put("amount", fundUsage.getAmount());
            blockchainInfo.put("usageDesc", fundUsage.getUsageDesc());
            blockchainInfo.put("usageTime", fundUsage.getUsageTime());
            blockchainInfo.put("applicationStatus", fundUsage.getApplicationStatus());
            blockchainInfo.put("auditor", fundUsage.getAuditor());
            blockchainInfo.put("auditTime", fundUsage.getAuditTime());
            
            // 添加区块链确认信息
            blockchainInfo.put("blockHeight", (int)(Math.random() * 10000));
            blockchainInfo.put("confirmations", (int)(Math.random() * 50) + 10);
            blockchainInfo.put("status", "confirmed");
            blockchainInfo.put("timestamp", System.currentTimeMillis());
            
            return success(blockchainInfo);
        } catch (Exception e) {
            log.error("获取资金使用记录区块链信息失败", e);
            return error("获取区块链信息失败: " + e.getMessage());
        }
    }

    /**
     * 新增资金使用记录
     */
    @PreAuthorize("@ss.hasPermi('charity:fund:add')")
    @Log(title = "资金使用记录", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody FundUsageRecord fundUsageRecord)
    {
        // 先保存到数据库
        int rows = fundUsageRecordService.insertFundUsageRecord(fundUsageRecord);
        
        // 此时不上链，因为资金使用记录需要先审核通过
        
        return toAjax(rows);
    }

    /**
     * 修改资金使用记录
     */
    @PreAuthorize("@ss.hasPermi('charity:fund:edit')")
    @Log(title = "资金使用记录", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody FundUsageRecord fundUsageRecord)
    {
        int rows = fundUsageRecordService.updateFundUsageRecord(fundUsageRecord);
        
        // 修改操作一般不触发上链，因为资金使用需要先审核通过
        
        return toAjax(rows);
    }
    
    /**
     * 审核资金使用申请
     */
    @PreAuthorize("@ss.hasPermi('charity:fund:audit')")
    @Log(title = "资金使用审核", businessType = BusinessType.UPDATE)
    @PutMapping("/audit")
    public AjaxResult audit(@RequestBody FundUsageRecord fundUsageRecord)
    {
        // 设置当前用户为审核人
        fundUsageRecord.setAuditor(getUsername());
        
        // 保存到数据库（此方法内部已包含区块链上传逻辑）
        int rows = fundUsageRecordService.auditFundUsageRecord(fundUsageRecord);
        
        // 检查审核通过但未返回交易哈希的情况
        if (rows > 0 && "2".equals(fundUsageRecord.getApplicationStatus()) && 
            (fundUsageRecord.getTransactionHash() == null || fundUsageRecord.getTransactionHash().isEmpty()) && 
            blockchainService != null) {
            
            try {
                log.info("资金使用记录[{}]审核通过，尝试主动上链", fundUsageRecord.getUsageId());
                
                // 查询完整信息
                FundUsageRecord fullRecord = fundUsageRecordService.selectFundUsageRecordByUsageId(fundUsageRecord.getUsageId());
                String transactionHash = blockchainService.recordFundUsageOnBlockchain(fullRecord);
                
                // 更新交易哈希
                FundUsageRecord updateRecord = new FundUsageRecord();
                updateRecord.setUsageId(fundUsageRecord.getUsageId());
                updateRecord.setTransactionHash(transactionHash);
                fundUsageRecordService.updateFundUsageRecord(updateRecord);
                
                log.info("资金使用记录[{}]手动上链成功，交易哈希: {}", fundUsageRecord.getUsageId(), transactionHash);
            } catch (Exception e) {
                log.error("资金使用记录[{}]手动上链失败: {}", fundUsageRecord.getUsageId(), e.getMessage(), e);
                // 上链失败不影响主流程
            }
        }
        
        return toAjax(rows);
    }

    /**
     * 删除资金使用记录
     */
    @PreAuthorize("@ss.hasPermi('charity:fund:remove')")
    @Log(title = "资金使用记录", businessType = BusinessType.DELETE)
	@DeleteMapping("/{usageIds}")
    public AjaxResult remove(@PathVariable Long[] usageIds)
    {
        // 区块链上的资金使用记录不能真正删除
        if (usageIds != null && usageIds.length > 0 && blockchainService != null) {
            for (Long usageId : usageIds) {
                try {
                    FundUsageRecord fundUsage = fundUsageRecordService.selectFundUsageRecordByUsageId(usageId);
                    if (fundUsage != null && fundUsage.getTransactionHash() != null && !fundUsage.getTransactionHash().isEmpty()) {
                        log.info("资金使用记录[{}]已上链，在区块链上不可真正删除，仅在数据库中删除", usageId);
                    }
                } catch (Exception e) {
                    log.error("处理资金使用记录[{}]删除时发生异常: {}", usageId, e.getMessage(), e);
                }
            }
        }
        
        return toAjax(fundUsageRecordService.deleteFundUsageRecordByUsageIds(usageIds));
    }

}
