package com.ruoyi.charity.domain;

import java.math.BigDecimal;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 资金使用记录对象 fund_usage_record
 * 
 * @author ruoyi
 * @date 2025-04-03
 */
public class FundUsageRecord extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 使用记录编号 */
    @Excel(name = "使用记录编号")
    private Long usageId;

    /** 项目编号 */
    @Excel(name = "项目编号")
    private Long projectId;

    /** 使用金额 */
    @Excel(name = "使用金额")
    private BigDecimal amount;

    /** 使用描述 */
    @Excel(name = "使用描述")
    private String usageDesc;

    /** 使用时间 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "使用时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date usageTime;

    /** 证明材料文件 */
    @Excel(name = "证明材料文件")
    private String proofUrl;

    /** 区块链交易哈希值 */
    @Excel(name = "区块链交易哈希值")
    private String transactionHash;

    public void setUsageId(Long usageId) 
    {
        this.usageId = usageId;
    }

    public Long getUsageId() 
    {
        return usageId;
    }

    public void setProjectId(Long projectId) 
    {
        this.projectId = projectId;
    }

    public Long getProjectId() 
    {
        return projectId;
    }

    public void setAmount(BigDecimal amount) 
    {
        this.amount = amount;
    }

    public BigDecimal getAmount() 
    {
        return amount;
    }

    public void setUsageDesc(String usageDesc) 
    {
        this.usageDesc = usageDesc;
    }

    public String getUsageDesc() 
    {
        return usageDesc;
    }

    public void setUsageTime(Date usageTime) 
    {
        this.usageTime = usageTime;
    }

    public Date getUsageTime() 
    {
        return usageTime;
    }

    public void setProofUrl(String proofUrl) 
    {
        this.proofUrl = proofUrl;
    }

    public String getProofUrl() 
    {
        return proofUrl;
    }

    public void setTransactionHash(String transactionHash) 
    {
        this.transactionHash = transactionHash;
    }

    public String getTransactionHash() 
    {
        return transactionHash;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("usageId", getUsageId())
            .append("projectId", getProjectId())
            .append("amount", getAmount())
            .append("usageDesc", getUsageDesc())
            .append("usageTime", getUsageTime())
            .append("proofUrl", getProofUrl())
            .append("transactionHash", getTransactionHash())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .toString();
    }
}
