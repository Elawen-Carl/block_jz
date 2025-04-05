package com.ruoyi.charity.blockchain.controller;

import com.ruoyi.charity.blockchain.domain.BlockchainBlock;
import com.ruoyi.charity.blockchain.domain.BlockchainStats;
import com.ruoyi.charity.blockchain.domain.BlockchainTransactionInfo;
import com.ruoyi.charity.blockchain.service.FabricQueryService;
import com.ruoyi.charity.blockchain.service.FabricService;
import com.ruoyi.charity.domain.BlockchainTransaction;
import com.ruoyi.charity.service.IBlockchainTransactionService;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

/**
 * 区块链操作控制器 - 提供区块链交易、查询等功能
 *
 * @author ruoyi
 * @date 2023-04-21
 */
@Api(tags = "区块链操作管理", description = "提供区块链垃圾处理记录、区块查询和交易查询等功能")
@RestController
@RequestMapping({"/blockchain"})
public class BlockchainController extends BaseController {
    private static final Logger log = LoggerFactory.getLogger(BlockchainController.class);
    @Autowired
    private FabricService fabricService;
    @Autowired
    private IBlockchainTransactionService blockchainTransactionService;
    @Autowired
    private FabricQueryService fabricQueryService;
    @Value("${fabric.channelName}")
    private String channelName;
    @Value("${fabric.chaincodeName}")
    private String chaincodeName;

    public BlockchainController() {
    }



    /**
     * 获取区块链统计信息
     *
     * @return 区块链统计数据
     */
    @ApiOperation(value = "获取区块链统计", notes = "获取区块链的基本统计信息，如区块总数、交易总数等")
    @GetMapping({"/stats"})
    public AjaxResult getBlockchainStats() {
        try {
            BlockchainStats stats = this.fabricQueryService.getBlockchainStats();
            return stats == null ? AjaxResult.error("获取区块链统计信息失败") : AjaxResult.success(stats);
        } catch (Exception var2) {
            Exception e = var2;
            log.error("获取区块链统计信息失败", e);
            return AjaxResult.error("获取区块链统计信息失败: " + e.getMessage());
        }
    }

    /**
     * 获取最新区块
     *
     * @param count 获取数量
     * @return 区块列表
     */
    @ApiOperation(value = "获取最新区块", notes = "获取区块链上的最新区块信息，可指定返回数量")
    @ApiImplicitParam(name = "count", value = "返回的区块数量", defaultValue = "3", dataType = "int", paramType = "query", example = "5")
    @GetMapping({"/blocks/latest"})
    public AjaxResult getLatestBlocks(@RequestParam(value = "count",defaultValue = "3") int count) {
        try {
            count = Math.min(count, 10);
            List<BlockchainBlock> blocks = this.fabricQueryService.getLatestBlocks(count);
            return blocks != null && !blocks.isEmpty() ? AjaxResult.success(blocks) : AjaxResult.error("获取最新区块失败");
        } catch (Exception var3) {
            Exception e = var3;
            log.error("获取最新区块失败", e);
            return AjaxResult.error("获取最新区块失败: " + e.getMessage());
        }
    }

    /**
     * 获取区块详情
     *
     * @param blockNumber 区块号
     * @return 区块详细信息
     */
    @ApiOperation(value = "获取区块详情", notes = "根据区块号获取区块链上的区块详细信息")
    @ApiImplicitParam(name = "blockNumber", value = "区块号", required = true, dataType = "long", paramType = "path", example = "10")
    @GetMapping({"/blocks/{blockNumber}"})
    public AjaxResult getBlockDetail(@PathVariable("blockNumber") long blockNumber) {
        try {
            BlockchainBlock block = this.fabricQueryService.getBlockDetail(blockNumber);
            return block == null ? AjaxResult.error("获取区块详情失败") : AjaxResult.success(block);
        } catch (Exception var4) {
            Exception e = var4;
            log.error("获取区块详情失败", e);
            return AjaxResult.error("获取区块详情失败: " + e.getMessage());
        }
    }

    /**
     * 获取最新交易
     *
     * @param transaction 交易查询参数
     * @return 交易列表
     */
    @ApiOperation(value = "获取最新交易", notes = "获取区块链上的最新交易信息，支持按交易哈希筛选")
    @GetMapping({"/transactions/latest"})
    public TableDataInfo getLatestTransactions(@ApiParam(value = "交易查询参数，可选", required = false) BlockchainTransaction transaction) {
        try {
            this.startPage();
            List txList;
            if (transaction != null && transaction.getTransactionHash() != null && !transaction.getTransactionHash().isEmpty()) {
                txList = this.fabricQueryService.queryTransactions(transaction.getTransactionHash());
                return this.getDataTable(txList);
            } else {
                txList = this.fabricQueryService.getLatestTransactions(20);
                return this.getDataTable(txList);
            }
        } catch (Exception var3) {
            Exception e = var3;
            log.error("获取最新交易失败", e);
            return this.getDataTable(new ArrayList());
        }
    }

    /**
     * 获取交易详情
     *
     * @param hash 交易哈希
     * @return 交易详细信息
     */
    @ApiOperation(value = "获取交易详情", notes = "根据交易哈希获取区块链上的交易详细信息")
    @ApiImplicitParam(name = "hash", value = "交易哈希", required = true, dataType = "String", paramType = "path", example = "abcdef1234567890")
    @GetMapping({"/transactions/{hash}"})
    public AjaxResult getTransactionDetail(@PathVariable("hash") String hash) {
        try {
            BlockchainTransactionInfo tx = this.fabricQueryService.getTransactionDetail(hash);
            return tx == null ? AjaxResult.error("获取交易详情失败") : AjaxResult.success(tx);
        } catch (Exception var3) {
            Exception e = var3;
            log.error("获取交易详情失败", e);
            return AjaxResult.error("获取交易详情失败: " + e.getMessage());
        }
    }
}