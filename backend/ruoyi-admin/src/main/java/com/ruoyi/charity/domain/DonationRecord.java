package com.ruoyi.charity.domain;

import java.math.BigDecimal;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 捐赠记录对象 donation_record
 * 
 * @author ruoyi
 * @date 2025-04-03
 */
public class DonationRecord extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 捐赠编号 */
    @Excel(name = "捐赠编号")
    private Long donationId;

    /** 用户编号 */
    @Excel(name = "用户编号")
    private Long userId;

    /** 项目编号 */
    @Excel(name = "项目编号")
    private Long projectId;

    /** 捐赠金额 */
    @Excel(name = "捐赠金额")
    private BigDecimal donationAmount;

    /** 支付方式 */
    @Excel(name = "支付方式")
    private String paymentMethod;

    /** 捐赠时间 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "捐赠时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date donationTime;

    /** 捐赠状态 */
    @Excel(name = "捐赠状态")
    private String status;

    /** 区块链交易哈希值 */
    @Excel(name = "区块链交易哈希值")
    private String transactionHash;

    /** 捐赠证书链接 */
    @Excel(name = "捐赠证书链接")
    private String certificateUrl;

    /** 证书颁发日期 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "证书颁发日期", width = 30, dateFormat = "yyyy-MM-dd")
    private Date certificateIssueDate;

    public void setDonationId(Long donationId) 
    {
        this.donationId = donationId;
    }

    public Long getDonationId() 
    {
        return donationId;
    }

    public void setUserId(Long userId) 
    {
        this.userId = userId;
    }

    public Long getUserId() 
    {
        return userId;
    }

    public void setProjectId(Long projectId) 
    {
        this.projectId = projectId;
    }

    public Long getProjectId() 
    {
        return projectId;
    }

    public void setDonationAmount(BigDecimal donationAmount) 
    {
        this.donationAmount = donationAmount;
    }

    public BigDecimal getDonationAmount() 
    {
        return donationAmount;
    }

    public void setPaymentMethod(String paymentMethod) 
    {
        this.paymentMethod = paymentMethod;
    }

    public String getPaymentMethod() 
    {
        return paymentMethod;
    }

    public void setDonationTime(Date donationTime) 
    {
        this.donationTime = donationTime;
    }

    public Date getDonationTime() 
    {
        return donationTime;
    }

    public void setStatus(String status) 
    {
        this.status = status;
    }

    public String getStatus() 
    {
        return status;
    }

    public void setTransactionHash(String transactionHash) 
    {
        this.transactionHash = transactionHash;
    }

    public String getTransactionHash() 
    {
        return transactionHash;
    }

    public void setCertificateUrl(String certificateUrl) 
    {
        this.certificateUrl = certificateUrl;
    }

    public String getCertificateUrl() 
    {
        return certificateUrl;
    }

    public void setCertificateIssueDate(Date certificateIssueDate) 
    {
        this.certificateIssueDate = certificateIssueDate;
    }

    public Date getCertificateIssueDate() 
    {
        return certificateIssueDate;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("donationId", getDonationId())
            .append("userId", getUserId())
            .append("projectId", getProjectId())
            .append("donationAmount", getDonationAmount())
            .append("paymentMethod", getPaymentMethod())
            .append("donationTime", getDonationTime())
            .append("status", getStatus())
            .append("transactionHash", getTransactionHash())
            .append("certificateUrl", getCertificateUrl())
            .append("certificateIssueDate", getCertificateIssueDate())
            .append("remark", getRemark())
            .append("createTime", getCreateTime())
            .append("updateTime", getUpdateTime())
            .toString();
    }
}
