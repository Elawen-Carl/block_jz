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

    /** 申请状态（0未提交 1待审核 2已审核） */
    @Excel(name = "申请状态", readConverterExp = "0=未提交,1=待审核,2=已审核")
    private String applicationStatus;

    /** 审核人 */
    @Excel(name = "审核人")
    private String auditor;
    
    /** 审核时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Excel(name = "审核时间", width = 30, dateFormat = "yyyy-MM-dd HH:mm:ss")
    private Date auditTime;
    
    /** 审核备注 */
    @Excel(name = "审核备注")
    private String auditRemark;

    /** 证明材料文件 */
    @Excel(name = "证明材料文件")
    private String proofUrl;

    /** 区块链交易哈希值 */
    @Excel(name = "区块链交易哈希值")
    private String transactionHash;
    
    /** 项目名称（非数据库字段） */
    @Excel(name = "项目名称")
    private String projectName;

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
    
    public void setApplicationStatus(String applicationStatus)
    {
        this.applicationStatus = applicationStatus;
    }

    public String getApplicationStatus()
    {
        return applicationStatus;
    }
    
    public void setAuditor(String auditor)
    {
        this.auditor = auditor;
    }

    public String getAuditor()
    {
        return auditor;
    }
    
    public void setAuditTime(Date auditTime)
    {
        this.auditTime = auditTime;
    }

    public Date getAuditTime()
    {
        return auditTime;
    }
    
    public void setAuditRemark(String auditRemark)
    {
        this.auditRemark = auditRemark;
    }

    public String getAuditRemark()
    {
        return auditRemark;
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
    
    public void setProjectName(String projectName)
    {
        this.projectName = projectName;
    }

    public String getProjectName()
    {
        return projectName;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("usageId", getUsageId())
            .append("projectId", getProjectId())
            .append("projectName", getProjectName())
            .append("amount", getAmount())
            .append("usageDesc", getUsageDesc())
            .append("usageTime", getUsageTime())
            .append("applicationStatus", getApplicationStatus())
            .append("auditor", getAuditor())
            .append("auditTime", getAuditTime())
            .append("auditRemark", getAuditRemark())
            .append("proofUrl", getProofUrl())
            .append("transactionHash", getTransactionHash())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .toString();
    }
}
