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
import com.ruoyi.charity.domain.BlockchainTransaction;
import com.ruoyi.charity.service.IBlockchainTransactionService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 区块链交易记录Controller
 * 
 * @author ruoyi
 * @date 2025-04-03
 */
@RestController
@RequestMapping("/charity/blockchain")
public class BlockchainTransactionController extends BaseController
{
    @Autowired
    private IBlockchainTransactionService blockchainTransactionService;

    /**
     * 查询区块链交易记录列表
     */
    @PreAuthorize("@ss.hasPermi('charity:blockchain:list')")
    @GetMapping("/list")
    public TableDataInfo list(BlockchainTransaction blockchainTransaction)
    {
        startPage();
        List<BlockchainTransaction> list = blockchainTransactionService.selectBlockchainTransactionList(blockchainTransaction);
        return getDataTable(list);
    }

    /**
     * 导出区块链交易记录列表
     */
    @PreAuthorize("@ss.hasPermi('charity:blockchain:export')")
    @Log(title = "区块链交易记录", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, BlockchainTransaction blockchainTransaction)
    {
        List<BlockchainTransaction> list = blockchainTransactionService.selectBlockchainTransactionList(blockchainTransaction);
        ExcelUtil<BlockchainTransaction> util = new ExcelUtil<BlockchainTransaction>(BlockchainTransaction.class);
        util.exportExcel(response, list, "区块链交易记录数据");
    }

    /**
     * 获取区块链交易记录详细信息
     */
    @PreAuthorize("@ss.hasPermi('charity:blockchain:query')")
    @GetMapping(value = "/{txId}")
    public AjaxResult getInfo(@PathVariable("txId") String txId)
    {
        return success(blockchainTransactionService.selectBlockchainTransactionByTxId(txId));
    }

    /**
     * 新增区块链交易记录
     */
    @PreAuthorize("@ss.hasPermi('charity:blockchain:add')")
    @Log(title = "区块链交易记录", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody BlockchainTransaction blockchainTransaction)
    {
        return toAjax(blockchainTransactionService.insertBlockchainTransaction(blockchainTransaction));
    }

    /**
     * 修改区块链交易记录
     */
    @PreAuthorize("@ss.hasPermi('charity:blockchain:edit')")
    @Log(title = "区块链交易记录", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody BlockchainTransaction blockchainTransaction)
    {
        return toAjax(blockchainTransactionService.updateBlockchainTransaction(blockchainTransaction));
    }

    /**
     * 删除区块链交易记录
     */
    @PreAuthorize("@ss.hasPermi('charity:blockchain:remove')")
    @Log(title = "区块链交易记录", businessType = BusinessType.DELETE)
	@DeleteMapping("/{txIds}")
    public AjaxResult remove(@PathVariable String[] txIds)
    {
        return toAjax(blockchainTransactionService.deleteBlockchainTransactionByTxIds(txIds));
    }
}
