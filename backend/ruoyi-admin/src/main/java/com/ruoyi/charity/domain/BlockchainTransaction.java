package com.ruoyi.charity.domain;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 区块链交易记录对象 blockchain_transaction
 * 
 * @author ruoyi
 * @date 2025-04-03
 */
public class BlockchainTransaction extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 交易编号 */
    @Excel(name = "交易编号")
    private String txId;

    /** 关联业务编号 */
    @Excel(name = "关联业务编号")
    private Long relatedId;

    /** 关联业务类型 */
    @Excel(name = "关联业务类型")
    private String relatedType;

    /** 交易数据(JSON格式) */
    private String txData;

    /** 交易时间 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "交易时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date txTime;

    /** 交易状态 */
    @Excel(name = "交易状态")
    private String txStatus;

    public void setTxId(String txId) 
    {
        this.txId = txId;
    }

    public String getTxId() 
    {
        return txId;
    }

    public void setRelatedId(Long relatedId) 
    {
        this.relatedId = relatedId;
    }

    public Long getRelatedId() 
    {
        return relatedId;
    }

    public void setRelatedType(String relatedType) 
    {
        this.relatedType = relatedType;
    }

    public String getRelatedType() 
    {
        return relatedType;
    }

    public void setTxData(String txData) 
    {
        this.txData = txData;
    }

    public String getTxData() 
    {
        return txData;
    }

    public void setTxTime(Date txTime) 
    {
        this.txTime = txTime;
    }

    public Date getTxTime() 
    {
        return txTime;
    }

    public void setTxStatus(String txStatus) 
    {
        this.txStatus = txStatus;
    }

    public String getTxStatus() 
    {
        return txStatus;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("txId", getTxId())
            .append("relatedId", getRelatedId())
            .append("relatedType", getRelatedType())
            .append("txData", getTxData())
            .append("txTime", getTxTime())
            .append("txStatus", getTxStatus())
            .append("createTime", getCreateTime())
            .toString();
    }
}
