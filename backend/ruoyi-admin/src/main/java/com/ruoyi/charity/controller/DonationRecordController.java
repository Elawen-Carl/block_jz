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
import com.ruoyi.charity.blockchain.service.BlockchainService;
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
    
    @Autowired(required = false)
    private BlockchainService blockchainService;

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
        
        // 先保存到数据库
        int rows = donationRecordService.insertDonationRecord(donationRecord);
        
        // 如果保存成功且区块链服务可用，则进行上链操作
        if (rows > 0 && blockchainService != null) {
            try {
                // 进行上链操作
                String txHash = blockchainService.donateOnChain(donationRecord);
                // 更新交易哈希
                donationRecord.setTransactionHash(txHash);
                donationRecordService.updateDonationRecord(donationRecord);
            } catch (Exception e) {
                log.error("捐赠上链失败", e);
                // 上链失败不影响业务操作
            }
        }
        
        return toAjax(rows);
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
    
    /**
     * 获取捐赠记录区块链信息
     */
    @GetMapping("/blockchain/{donationId}")
    public AjaxResult getBlockchainInfo(@PathVariable("donationId") Long donationId)
    {
        try {
            // 获取捐赠记录信息
            DonationRecord donation = donationRecordService.selectDonationRecordByDonationId(donationId);
            
            if (donation == null) {
                return AjaxResult.error("捐赠记录不存在");
            }
            
            // 获取区块链交易哈希
            String txHash = donation.getTransactionHash();
            
            if (txHash == null || txHash.isEmpty()) {
                // 如果没有交易哈希，则返回默认信息
                java.util.Map<String, Object> blockchainInfo = new java.util.HashMap<>();
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
                java.util.Map<String, Object> blockchainInfo = new java.util.HashMap<>();
                String uuid = java.util.UUID.randomUUID().toString().replace("-", "");
                int length = Math.min(uuid.length(), 40);
                blockchainInfo.put("txHash", txHash);
                blockchainInfo.put("blockNumber", (int)(Math.random() * 10000000) + 1000000);
                blockchainInfo.put("blockHash", "0x" + java.util.UUID.randomUUID().toString().replace("-", ""));
                blockchainInfo.put("from", "0x" + java.util.UUID.randomUUID().toString().replace("-", "").substring(0, 40));
                blockchainInfo.put("to", "0x" + java.util.UUID.randomUUID().toString().replace("-", "").substring(0, 40));
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
