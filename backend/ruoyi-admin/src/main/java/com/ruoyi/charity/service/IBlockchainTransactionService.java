package com.ruoyi.charity.service;

import java.util.List;
import com.ruoyi.charity.domain.BlockchainTransaction;

/**
 * 区块链交易记录Service接口
 * 
 * @author ruoyi
 * @date 2025-04-03
 */
public interface IBlockchainTransactionService 
{
    /**
     * 查询区块链交易记录
     * 
     * @param txId 区块链交易记录主键
     * @return 区块链交易记录
     */
    public BlockchainTransaction selectBlockchainTransactionByTxId(String txId);

    /**
     * 查询区块链交易记录列表
     * 
     * @param blockchainTransaction 区块链交易记录
     * @return 区块链交易记录集合
     */
    public List<BlockchainTransaction> selectBlockchainTransactionList(BlockchainTransaction blockchainTransaction);

    /**
     * 新增区块链交易记录
     * 
     * @param blockchainTransaction 区块链交易记录
     * @return 结果
     */
    public int insertBlockchainTransaction(BlockchainTransaction blockchainTransaction);

    /**
     * 修改区块链交易记录
     * 
     * @param blockchainTransaction 区块链交易记录
     * @return 结果
     */
    public int updateBlockchainTransaction(BlockchainTransaction blockchainTransaction);

    /**
     * 批量删除区块链交易记录
     * 
     * @param txIds 需要删除的区块链交易记录主键集合
     * @return 结果
     */
    public int deleteBlockchainTransactionByTxIds(String[] txIds);

    /**
     * 删除区块链交易记录信息
     * 
     * @param txId 区块链交易记录主键
     * @return 结果
     */
    public int deleteBlockchainTransactionByTxId(String txId);
}
