package com.ruoyi.charity.blockchain.domain;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

import java.util.Date;
import java.util.Map;

/**
 * 区块链交易信息对象 blockchain_transaction_info
 * 
 * @author ruoyi
 * @date 2025-03-27
 */
@ApiModel(value = "区块链交易信息", description = "存储区块链中的交易详情")
public class BlockchainTransactionInfo extends BaseEntity
{
    private static final long serialVersionUID = 1L;
    
    /** 交易ID */
    @ApiModelProperty(value = "交易ID", example = "tx123456789")
    @Excel(name = "交易ID")
    private String txId;
    
    /** 所属区块高度 */
    @ApiModelProperty(value = "所属区块高度", example = "100")
    @Excel(name = "区块高度")
    private long blockNumber;
    
    /** 交易创建者 */
    @ApiModelProperty(value = "交易创建者", example = "user123")
    @Excel(name = "创建者")
    private String creator;
    
    /** 交易时间戳 */
    @ApiModelProperty(value = "交易时间戳", example = "2025-03-27 15:30:45")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Excel(name = "交易时间", width = 30, dateFormat = "yyyy-MM-dd HH:mm:ss")
    private Date timestamp;
    
    /** 交易是否有效 */
    @ApiModelProperty(value = "交易是否有效", example = "true")
    @Excel(name = "是否有效", readConverterExp = "true=是,false=否")
    private boolean valid;
    
    /** 交易验证代码 */
    @ApiModelProperty(value = "交易验证代码", example = "0")
    @Excel(name = "验证代码")
    private int validationCode;
    
    /** 链码名称 */
    @ApiModelProperty(value = "链码名称", example = "wastechain")
    @Excel(name = "链码名称")
    private String chaincodeName;
    
    /** 是否包含读写集 */
    @ApiModelProperty(value = "是否包含读写集", example = "true")
    @Excel(name = "包含读写集", readConverterExp = "true=是,false=否")
    private boolean hasReadWriteSet;
    
    /** 交易读写集数据 */
    @ApiModelProperty(value = "交易读写集数据")
    private Map<String, Object> readWriteSet;

    public BlockchainTransactionInfo() 
    {
    }

    public String getTxId() 
    {
        return this.txId;
    }

    public void setTxId(String txId) 
    {
        this.txId = txId;
    }

    public long getBlockNumber() 
    {
        return this.blockNumber;
    }

    public void setBlockNumber(long blockNumber) 
    {
        this.blockNumber = blockNumber;
    }

    public String getCreator() 
    {
        return this.creator;
    }

    public void setCreator(String creator) 
    {
        this.creator = creator;
    }

    public Date getTimestamp() 
    {
        return this.timestamp;
    }

    public void setTimestamp(Date timestamp) 
    {
        this.timestamp = timestamp;
    }

    public boolean isValid() 
    {
        return this.valid;
    }

    public void setValid(boolean valid) 
    {
        this.valid = valid;
    }

    public int getValidationCode() 
    {
        return this.validationCode;
    }

    public void setValidationCode(int validationCode) 
    {
        this.validationCode = validationCode;
    }

    public String getChaincodeName() 
    {
        return this.chaincodeName;
    }

    public void setChaincodeName(String chaincodeName) 
    {
        this.chaincodeName = chaincodeName;
    }

    public boolean isHasReadWriteSet() 
    {
        return this.hasReadWriteSet;
    }

    public void setHasReadWriteSet(boolean hasReadWriteSet) 
    {
        this.hasReadWriteSet = hasReadWriteSet;
    }

    public Map<String, Object> getReadWriteSet() 
    {
        return this.readWriteSet;
    }

    public void setReadWriteSet(Map<String, Object> readWriteSet) 
    {
        this.readWriteSet = readWriteSet;
    }
    
    @Override
    public String toString() {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
            .append("txId", getTxId())
            .append("blockNumber", getBlockNumber())
            .append("creator", getCreator())
            .append("timestamp", getTimestamp())
            .append("valid", isValid())
            .append("validationCode", getValidationCode())
            .append("chaincodeName", getChaincodeName())
            .append("hasReadWriteSet", isHasReadWriteSet())
            .toString();
    }
}