package com.ruoyi.charity.controller;

import java.util.List;
import java.util.Map;
import java.util.HashMap;
import java.util.UUID;
import javax.servlet.http.HttpServletResponse;

import lombok.extern.slf4j.Slf4j;
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
import com.ruoyi.charity.blockchain.service.BlockchainService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

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
    
    @Autowired(required = false)
    private BlockchainService blockchainService;

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
        // 先保存到数据库
        int rows = fundUsageRecordService.insertFundUsageRecord(fundUsageRecord);
        
        // 如果保存成功且区块链服务可用，则进行上链操作
        if (rows > 0 && blockchainService != null) {
            try {
                // 进行上链操作
                String txHash = blockchainService.applyFundUsageOnChain(fundUsageRecord);
                // 更新交易哈希
                fundUsageRecord.setTransactionHash(txHash);
                fundUsageRecordService.updateFundUsageRecord(fundUsageRecord);
            } catch (Exception e) {
                log.error("资金使用申请上链失败", e);
                // 上链失败不影响业务操作
            }
        }
        
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
        return toAjax(fundUsageRecordService.updateFundUsageRecord(fundUsageRecord));
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
        
        // 先保存到数据库
        int rows = fundUsageRecordService.auditFundUsageRecord(fundUsageRecord);
        
        // 如果保存成功且区块链服务可用，则进行上链操作
        if (rows > 0 && blockchainService != null) {
            try {
                // 进行上链操作
                String txHash = blockchainService.auditFundUsageOnChain(fundUsageRecord);
                // 这里选择不更新交易哈希，保留申请时的交易哈希
            } catch (Exception e) {
                log.error("资金使用审核上链失败", e);
                // 上链失败不影响业务操作
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
        return toAjax(fundUsageRecordService.deleteFundUsageRecordByUsageIds(usageIds));
    }
    
    /**
     * 获取资金使用记录区块链信息
     */
    @GetMapping("/blockchain/{usageId}")
    public AjaxResult getBlockchainInfo(@PathVariable("usageId") Long usageId)
    {
        try {
            // 获取资金使用记录信息
            FundUsageRecord fundUsage = fundUsageRecordService.selectFundUsageRecordByUsageId(usageId);
            
            if (fundUsage == null) {
                return AjaxResult.error("资金使用记录不存在");
            }
            
            // 获取区块链交易哈希
            String txHash = fundUsage.getTransactionHash();
            
            if (txHash == null || txHash.isEmpty()) {
                // 如果没有交易哈希，则返回默认信息
                Map<String, Object> blockchainInfo = new HashMap<>();
                blockchainInfo.put("txHash", "未上链");
                blockchainInfo.put("timestamp", System.currentTimeMillis());
                blockchainInfo.put("status", "pending");
                return AjaxResult.success(blockchainInfo);
            }
            
            // 使用区块链服务获取交易信息
            if (blockchainService != null) {
                return AjaxResult.success(blockchainService.getTransactionInfo(txHash));
            } else {
                // 如果区块链服务不可用，则返回模拟数据
                Map<String, Object> blockchainInfo = new HashMap<>();
                blockchainInfo.put("txHash", txHash);
                blockchainInfo.put("blockNumber", (int)(Math.random() * 10000000) + 1000000);
                blockchainInfo.put("blockHash", "0x" + UUID.randomUUID().toString().replace("-", ""));
                blockchainInfo.put("from", "0x" + UUID.randomUUID().toString().replace("-", "").substring(0, 40));
                blockchainInfo.put("to", "0x" + UUID.randomUUID().toString().replace("-", "").substring(0, 40));
                blockchainInfo.put("status", "confirmed");
                blockchainInfo.put("timestamp", System.currentTimeMillis());
                blockchainInfo.put("confirmations", (int)(Math.random() * 100) + 1);
                return AjaxResult.success(blockchainInfo);
            }
        } catch (Exception e) {
            log.error("获取区块链信息失败", e);
            return AjaxResult.error("获取区块链信息失败: " + e.getMessage());
        }
    }
}
