package com.ruoyi.charity.domain;

import java.math.BigDecimal;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 慈善项目对象 charity_project
 * 
 * @author ruoyi
 * @date 2025-04-03
 */
public class CharityProject extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 项目编号 */
    private Long projectId;

    /** 项目名称 */
    @Excel(name = "项目名称")
    private String projectName;

    /** 项目描述 */
    private String projectDesc;

    /** 目标金额 */
    @Excel(name = "目标金额")
    private BigDecimal targetAmount;

    /** 当前金额 */
    @Excel(name = "当前金额")
    private BigDecimal currentAmount;

    /** 发起人编号 */
    @Excel(name = "发起人编号")
    private Long initiatorId;

    /** 发起类型 */
    @Excel(name = "发起类型")
    private String initiatorType;

    /** 封面图片 */
    @Excel(name = "封面图片")
    private String coverImage;

    /** 开始时间 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "开始时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date startTime;

    /** 结束时间 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "结束时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date endTime;

    /** 项目状态 */
    @Excel(name = "项目状态")
    private String status;

    /** 区块链项目编号 */
    @Excel(name = "区块链项目编号")
    private String blockchainId;

    /** 资金使用规则(JSON格式) */
    private String fundUsageRules;

    /** 审核人编号 */
    @Excel(name = "审核人编号")
    private Long auditUserId;

    /** 审核时间 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "审核时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date auditTime;

    /** 审核状态 */
    @Excel(name = "审核状态")
    private String auditStatus;

    /** 审核备注 */
    private String auditRemark;

    /** 发起人姓名 */
    @Excel(name = "发起人姓名")
    private String initiatorName;

    /** 审核人姓名 */
    @Excel(name = "审核人姓名")
    private String auditorName;

    public void setProjectId(Long projectId) 
    {
        this.projectId = projectId;
    }

    public Long getProjectId() 
    {
        return projectId;
    }

    public void setProjectName(String projectName) 
    {
        this.projectName = projectName;
    }

    public String getProjectName() 
    {
        return projectName;
    }

    public void setProjectDesc(String projectDesc) 
    {
        this.projectDesc = projectDesc;
    }

    public String getProjectDesc() 
    {
        return projectDesc;
    }

    public void setTargetAmount(BigDecimal targetAmount) 
    {
        this.targetAmount = targetAmount;
    }

    public BigDecimal getTargetAmount() 
    {
        return targetAmount;
    }

    public void setCurrentAmount(BigDecimal currentAmount) 
    {
        this.currentAmount = currentAmount;
    }

    public BigDecimal getCurrentAmount() 
    {
        return currentAmount;
    }

    public void setInitiatorId(Long initiatorId) 
    {
        this.initiatorId = initiatorId;
    }

    public Long getInitiatorId() 
    {
        return initiatorId;
    }

    public void setInitiatorType(String initiatorType) 
    {
        this.initiatorType = initiatorType;
    }

    public String getInitiatorType() 
    {
        return initiatorType;
    }

    public void setCoverImage(String coverImage) 
    {
        this.coverImage = coverImage;
    }

    public String getCoverImage() 
    {
        return coverImage;
    }

    public void setStartTime(Date startTime) 
    {
        this.startTime = startTime;
    }

    public Date getStartTime() 
    {
        return startTime;
    }

    public void setEndTime(Date endTime) 
    {
        this.endTime = endTime;
    }

    public Date getEndTime() 
    {
        return endTime;
    }

    public void setStatus(String status) 
    {
        this.status = status;
    }

    public String getStatus() 
    {
        return status;
    }

    public void setBlockchainId(String blockchainId) 
    {
        this.blockchainId = blockchainId;
    }

    public String getBlockchainId() 
    {
        return blockchainId;
    }

    public void setFundUsageRules(String fundUsageRules) 
    {
        this.fundUsageRules = fundUsageRules;
    }

    public String getFundUsageRules() 
    {
        return fundUsageRules;
    }

    public void setAuditUserId(Long auditUserId) 
    {
        this.auditUserId = auditUserId;
    }

    public Long getAuditUserId() 
    {
        return auditUserId;
    }

    public void setAuditTime(Date auditTime) 
    {
        this.auditTime = auditTime;
    }

    public Date getAuditTime() 
    {
        return auditTime;
    }

    public void setAuditStatus(String auditStatus) 
    {
        this.auditStatus = auditStatus;
    }

    public String getAuditStatus() 
    {
        return auditStatus;
    }

    public void setAuditRemark(String auditRemark) 
    {
        this.auditRemark = auditRemark;
    }

    public String getAuditRemark() 
    {
        return auditRemark;
    }

    public String getInitiatorName() 
    {
        return initiatorName;
    }

    public void setInitiatorName(String initiatorName) 
    {
        this.initiatorName = initiatorName;
    }

    public String getAuditorName() 
    {
        return auditorName;
    }

    public void setAuditorName(String auditorName) 
    {
        this.auditorName = auditorName;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("projectId", getProjectId())
            .append("projectName", getProjectName())
            .append("projectDesc", getProjectDesc())
            .append("targetAmount", getTargetAmount())
            .append("currentAmount", getCurrentAmount())
            .append("initiatorId", getInitiatorId())
            .append("initiatorType", getInitiatorType())
            .append("initiatorName", getInitiatorName())
            .append("coverImage", getCoverImage())
            .append("startTime", getStartTime())
            .append("endTime", getEndTime())
            .append("status", getStatus())
            .append("blockchainId", getBlockchainId())
            .append("fundUsageRules", getFundUsageRules())
            .append("auditUserId", getAuditUserId())
            .append("auditTime", getAuditTime())
            .append("auditStatus", getAuditStatus())
            .append("auditRemark", getAuditRemark())
            .append("auditorName", getAuditorName())
            .append("createTime", getCreateTime())
            .append("updateTime", getUpdateTime())
            .toString();
    }
}
