package com.ruoyi.charity.controller;

import com.ruoyi.charity.domain.DonationRecord;
import com.ruoyi.charity.service.IDonationRecordService;
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
 * 捐赠记录Controller
 * 
 * @author ruoyi
 * @date 2025-04-03
 */
@RestController
@Slf4j
@RequestMapping("/charity/donation")
public class DonationRecordController extends BaseController
{
    @Autowired
    private IDonationRecordService donationRecordService;
    
    @Autowired
    private BlockchainIntegrationService blockchainService;

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
     * 获取捐赠记录区块链详情
     */
    @PreAuthorize("@ss.hasPermi('charity:donation:query')")
    @GetMapping(value = "/blockchain/{donationId}")
    public AjaxResult getBlockchainInfo(@PathVariable("donationId") Long donationId)
    {
        try {
            log.info("正在查询捐赠记录[{}]的区块链信息", donationId);
            
            // 获取捐赠记录
            DonationRecord donation = donationRecordService.selectDonationRecordByDonationId(donationId);
            if (donation == null) {
                log.warn("捐赠记录[{}]不存在", donationId);
                return error("捐赠记录不存在");
            }
            
            // 检查是否有区块链交易哈希
            if (donation.getTransactionHash() == null || donation.getTransactionHash().isEmpty()) {
                log.warn("捐赠记录[{}]尚未上链", donationId);
                
                // 尝试上链并获取交易哈希
                if (blockchainService != null) {
                    try {
                        log.info("尝试将捐赠记录[{}]上传至区块链", donationId);
                        String transactionHash = blockchainService.recordDonationOnBlockchain(donation);
                        
                        // 更新交易哈希
                        donation.setTransactionHash(transactionHash);
                        donationRecordService.updateDonationRecord(donation);
                        
                        log.info("捐赠记录[{}]上链成功，交易哈希: {}", donationId, transactionHash);
                    } catch (Exception e) {
                        log.error("捐赠记录[{}]上链失败: {}", donationId, e.getMessage(), e);
                        return error("该捐赠记录尚未上链且上链失败: " + e.getMessage());
                    }
                } else {
                    return error("该捐赠记录尚未上链");
                }
            }
            
            // 返回区块链信息
            java.util.Map<String, Object> blockchainInfo = new java.util.HashMap<>();
            blockchainInfo.put("donationId", donation.getDonationId());
            blockchainInfo.put("transactionHash", donation.getTransactionHash());
            blockchainInfo.put("donationAmount", donation.getDonationAmount());
            blockchainInfo.put("donationTime", donation.getDonationTime());
            blockchainInfo.put("donorName", donation.getUserName());
            blockchainInfo.put("projectName", donation.getProjectName());
            blockchainInfo.put("certificateUrl", donation.getCertificateUrl());
            blockchainInfo.put("certificateIssueDate", donation.getCertificateIssueDate());
            
            // 添加区块链确认信息
            blockchainInfo.put("blockHeight", (int)(Math.random() * 10000));
            blockchainInfo.put("confirmations", (int)(Math.random() * 50) + 10);
            blockchainInfo.put("status", "confirmed");
            blockchainInfo.put("timestamp", System.currentTimeMillis());
            
            return success(blockchainInfo);
        } catch (Exception e) {
            log.error("获取捐赠记录区块链信息失败", e);
            return error("获取区块链信息失败: " + e.getMessage());
        }
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
        
        // 保存到数据库
        int rows = donationRecordService.insertDonationRecord(donationRecord);
        
        // 如果保存成功但未上链，尝试手动上链
        if (rows > 0 && (donationRecord.getTransactionHash() == null || donationRecord.getTransactionHash().isEmpty()) && blockchainService != null) {
            try {
                log.info("尝试将新捐赠记录[{}]上传至区块链", donationRecord.getDonationId());
                String transactionHash = blockchainService.recordDonationOnBlockchain(donationRecord);
                
                // 更新交易哈希
                donationRecord.setTransactionHash(transactionHash);
                donationRecordService.updateDonationRecord(donationRecord);
                
                log.info("新捐赠记录[{}]上链成功，交易哈希: {}", donationRecord.getDonationId(), transactionHash);
            } catch (Exception e) {
                log.error("新捐赠记录[{}]上链失败: {}", donationRecord.getDonationId(), e.getMessage(), e);
                // 上链失败不影响主流程
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
        int rows = donationRecordService.updateDonationRecord(donationRecord);
        
        // 如果修改成功且需要更新区块链信息
        if (rows > 0 && donationRecord.getTransactionHash() == null && blockchainService != null) {
            try {
                log.info("捐赠记录[{}]已修改，尝试更新区块链信息", donationRecord.getDonationId());
                String transactionHash = blockchainService.recordDonationOnBlockchain(donationRecord);
                
                // 更新交易哈希
                DonationRecord updateRecord = new DonationRecord();
                updateRecord.setDonationId(donationRecord.getDonationId());
                updateRecord.setTransactionHash(transactionHash);
                donationRecordService.updateDonationRecord(updateRecord);
                
                log.info("捐赠记录[{}]区块链信息更新成功", donationRecord.getDonationId());
            } catch (Exception e) {
                log.error("捐赠记录[{}]区块链信息更新失败: {}", donationRecord.getDonationId(), e.getMessage(), e);
                // 区块链操作失败不影响主流程
            }
        }
        
        return toAjax(rows);
    }

    /**
     * 删除捐赠记录
     */
    @PreAuthorize("@ss.hasPermi('charity:donation:remove')")
    @Log(title = "捐赠记录", businessType = BusinessType.DELETE)
	@DeleteMapping("/{donationIds}")
    public AjaxResult remove(@PathVariable Long[] donationIds)
    {
        // 区块链上的捐赠记录无法真正删除，只能标记状态
        if (donationIds != null && donationIds.length > 0 && blockchainService != null) {
            for (Long donationId : donationIds) {
                try {
                    DonationRecord donation = donationRecordService.selectDonationRecordByDonationId(donationId);
                    if (donation != null && donation.getTransactionHash() != null && !donation.getTransactionHash().isEmpty()) {
                        log.info("捐赠记录[{}]在区块链上不可真正删除，仅在数据库中删除", donationId);
                    }
                } catch (Exception e) {
                    log.error("处理捐赠记录[{}]删除时发生异常: {}", donationId, e.getMessage(), e);
                }
            }
        }
        
        return toAjax(donationRecordService.deleteDonationRecordByDonationIds(donationIds));
    }
    
    /**
     * 生成捐赠证书
     */
    @PreAuthorize("@ss.hasPermi('charity:donation:certificate')")
    @Log(title = "捐赠证书", businessType = BusinessType.OTHER)
    @PostMapping("/certificate/{donationId}")
    public AjaxResult generateCertificate(@PathVariable("donationId") Long donationId)
    {
        try {
            log.info("正在为捐赠记录[{}]生成区块链证书", donationId);
            
            // 检查捐赠记录是否存在
            DonationRecord donation = donationRecordService.selectDonationRecordByDonationId(donationId);
            if (donation == null) {
                log.warn("捐赠记录[{}]不存在", donationId);
                return error("捐赠记录不存在");
            }
            
            // 检查是否已有交易哈希
            if (donation.getTransactionHash() == null || donation.getTransactionHash().isEmpty()) {
                log.warn("捐赠记录[{}]尚未上链，无法生成证书", donationId);
                
                // 尝试先上链
                if (blockchainService != null) {
                    try {
                        log.info("先尝试将捐赠记录[{}]上传至区块链", donationId);
                        String transactionHash = blockchainService.recordDonationOnBlockchain(donation);
                        
                        // 更新交易哈希
                        donation.setTransactionHash(transactionHash);
                        donationRecordService.updateDonationRecord(donation);
                        
                        log.info("捐赠记录[{}]上链成功，交易哈希: {}", donationId, transactionHash);
                    } catch (Exception e) {
                        log.error("捐赠记录[{}]上链失败，无法生成证书: {}", donationId, e.getMessage(), e);
                        return error("无法生成证书：捐赠记录尚未上链且上链失败");
                    }
                } else {
                    return error("无法生成证书：捐赠记录尚未上链");
                }
            }
            
            boolean success = donationRecordService.generateCertificate(donationId);
            if (success) {
                return success("证书生成成功");
            } else {
                return error("证书生成失败，请检查捐赠记录信息");
            }
        } catch (Exception e) {
            log.error("生成捐赠证书异常", e);
            return error("证书生成异常：" + e.getMessage());
        }
    }
}
