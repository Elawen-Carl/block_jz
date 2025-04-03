package com.ruoyi.charity.service.impl;

import java.util.List;
import com.ruoyi.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.charity.mapper.BlockchainTransactionMapper;
import com.ruoyi.charity.domain.BlockchainTransaction;
import com.ruoyi.charity.service.IBlockchainTransactionService;

/**
 * 区块链交易记录Service业务层处理
 * 
 * @author ruoyi
 * @date 2025-04-03
 */
@Service
public class BlockchainTransactionServiceImpl implements IBlockchainTransactionService 
{
    @Autowired
    private BlockchainTransactionMapper blockchainTransactionMapper;

    /**
     * 查询区块链交易记录
     * 
     * @param txId 区块链交易记录主键
     * @return 区块链交易记录
     */
    @Override
    public BlockchainTransaction selectBlockchainTransactionByTxId(String txId)
    {
        return blockchainTransactionMapper.selectBlockchainTransactionByTxId(txId);
    }

    /**
     * 查询区块链交易记录列表
     * 
     * @param blockchainTransaction 区块链交易记录
     * @return 区块链交易记录
     */
    @Override
    public List<BlockchainTransaction> selectBlockchainTransactionList(BlockchainTransaction blockchainTransaction)
    {
        return blockchainTransactionMapper.selectBlockchainTransactionList(blockchainTransaction);
    }

    /**
     * 新增区块链交易记录
     * 
     * @param blockchainTransaction 区块链交易记录
     * @return 结果
     */
    @Override
    public int insertBlockchainTransaction(BlockchainTransaction blockchainTransaction)
    {
        blockchainTransaction.setCreateTime(DateUtils.getNowDate());
        return blockchainTransactionMapper.insertBlockchainTransaction(blockchainTransaction);
    }

    /**
     * 修改区块链交易记录
     * 
     * @param blockchainTransaction 区块链交易记录
     * @return 结果
     */
    @Override
    public int updateBlockchainTransaction(BlockchainTransaction blockchainTransaction)
    {
        return blockchainTransactionMapper.updateBlockchainTransaction(blockchainTransaction);
    }

    /**
     * 批量删除区块链交易记录
     * 
     * @param txIds 需要删除的区块链交易记录主键
     * @return 结果
     */
    @Override
    public int deleteBlockchainTransactionByTxIds(String[] txIds)
    {
        return blockchainTransactionMapper.deleteBlockchainTransactionByTxIds(txIds);
    }

    /**
     * 删除区块链交易记录信息
     * 
     * @param txId 区块链交易记录主键
     * @return 结果
     */
    @Override
    public int deleteBlockchainTransactionByTxId(String txId)
    {
        return blockchainTransactionMapper.deleteBlockchainTransactionByTxId(txId);
    }
}
