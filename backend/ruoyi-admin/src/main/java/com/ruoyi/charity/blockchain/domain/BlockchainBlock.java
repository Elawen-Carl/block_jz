package com.ruoyi.charity.blockchain.domain;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

import java.util.Date;
import java.util.List;

/**
 * 区块链区块信息对象 blockchain_block
 * 
 * @author ruoyi
 * @date 2025-03-27
 */
@ApiModel(value = "区块链区块信息", description = "包含区块链区块的详细信息")
public class BlockchainBlock extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 区块高度 */
    @ApiModelProperty(value = "区块高度", example = "100")
    @Excel(name = "区块高度")
    private long height;
    
    /** 区块数据哈希 */
    @ApiModelProperty(value = "区块数据哈希", example = "7ae6a41...")
    @Excel(name = "区块数据哈希")
    private String dataHash;
    
    /** 前一个区块的哈希值 */
    @ApiModelProperty(value = "前一个区块的哈希值", example = "9cb1f32...")
    @Excel(name = "前一个区块哈希")
    private String previousHash;
    
    /** 区块生成时间戳 */
    @ApiModelProperty(value = "区块生成时间", example = "2025-03-27 12:30:45")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Excel(name = "区块时间", width = 30, dateFormat = "yyyy-MM-dd HH:mm:ss")
    private Date timestamp;
    
    /** 区块中的交易数量 */
    @ApiModelProperty(value = "区块中的交易数量", example = "10")
    @Excel(name = "交易数量")
    private int txCount;
    
    /** 区块大小（字节） */
    @ApiModelProperty(value = "区块大小（字节）", example = "1024")
    @Excel(name = "区块大小", suffix = "字节")
    private int size;
    
    /** 区块中包含的交易列表 */
    @ApiModelProperty(value = "区块包含的交易列表")
    private List<BlockchainTransactionInfo> transactions;

    public BlockchainBlock() 
    {
    }

    public long getHeight() 
    {
        return this.height;
    }

    public void setHeight(long height) 
    {
        this.height = height;
    }

    public String getDataHash() 
    {
        return this.dataHash;
    }

    public void setDataHash(String dataHash) 
    {
        this.dataHash = dataHash;
    }

    public String getPreviousHash() 
    {
        return this.previousHash;
    }

    public void setPreviousHash(String previousHash) 
    {
        this.previousHash = previousHash;
    }

    public Date getTimestamp() 
    {
        return this.timestamp;
    }

    public void setTimestamp(Date timestamp) 
    {
        this.timestamp = timestamp;
    }

    public int getTxCount() 
    {
        return this.txCount;
    }

    public void setTxCount(int txCount) 
    {
        this.txCount = txCount;
    }

    public int getSize() 
    {
        return this.size;
    }

    public void setSize(int size) 
    {
        this.size = size;
    }

    public List<BlockchainTransactionInfo> getTransactions() 
    {
        return this.transactions;
    }

    public void setTransactions(List<BlockchainTransactionInfo> transactions) 
    {
        this.transactions = transactions;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
            .append("height", getHeight())
            .append("dataHash", getDataHash())
            .append("previousHash", getPreviousHash())
            .append("timestamp", getTimestamp())
            .append("txCount", getTxCount())
            .append("size", getSize())
            .toString();
    }
}