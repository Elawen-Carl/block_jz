package com.ruoyi.charity.blockchain.domain;

import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

/**
 * 区块链统计信息对象 blockchain_stats
 * 
 * @author ruoyi
 * @date 2025-03-27
 */
@ApiModel(value = "区块链统计信息", description = "包含区块链的统计数据")
public class BlockchainStats extends BaseEntity
{
    private static final long serialVersionUID = 1L;
    
    /** 区块链总区块数 */
    @ApiModelProperty(value = "区块链总区块数", example = "1000")
    @Excel(name = "总区块数")
    private long totalBlocks;
    
    /** 区块链总交易数 */
    @ApiModelProperty(value = "区块链总交易数", example = "5000")
    @Excel(name = "总交易数")
    private long totalTransactions;
    
    /** 每秒交易处理量 */
    @ApiModelProperty(value = "每秒交易处理量", example = "10.5")
    @Excel(name = "TPS")
    private double transactionsPerSecond;
    
    /** 在线节点数量 */
    @ApiModelProperty(value = "在线节点数量", example = "4")
    @Excel(name = "在线节点数")
    private int onlineNodes;

    public BlockchainStats() 
    {
    }

    public long getTotalBlocks() 
    {
        return this.totalBlocks;
    }

    public void setTotalBlocks(long totalBlocks) 
    {
        this.totalBlocks = totalBlocks;
    }

    public long getTotalTransactions() 
    {
        return this.totalTransactions;
    }

    public void setTotalTransactions(long totalTransactions) 
    {
        this.totalTransactions = totalTransactions;
    }

    public double getTransactionsPerSecond() 
    {
        return this.transactionsPerSecond;
    }

    public void setTransactionsPerSecond(double transactionsPerSecond) 
    {
        this.transactionsPerSecond = transactionsPerSecond;
    }

    public int getOnlineNodes() 
    {
        return this.onlineNodes;
    }

    public void setOnlineNodes(int onlineNodes) 
    {
        this.onlineNodes = onlineNodes;
    }
    
    @Override
    public String toString() {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
            .append("totalBlocks", getTotalBlocks())
            .append("totalTransactions", getTotalTransactions())
            .append("transactionsPerSecond", getTransactionsPerSecond())
            .append("onlineNodes", getOnlineNodes())
            .toString();
    }
}