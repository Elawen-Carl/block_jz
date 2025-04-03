package com.ruoyi.charity.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 用户隐私设置对象 user_privacy_settings
 * 
 * @author ruoyi
 * @date 2025-04-03
 */
public class UserPrivacySettings extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 用户编号 */
    @Excel(name = "用户编号")
    private Long userId;

    /** 是否显示捐赠金额（0不显示 1显示） */
    @Excel(name = "是否显示捐赠金额", readConverterExp = "0=不显示,1=显示")
    private Integer showDonationAmount;

    /** 是否在捐赠列表显示（0不显示 1显示） */
    @Excel(name = "是否在捐赠列表显示", readConverterExp = "0=不显示,1=显示")
    private Integer showDonationList;

    /** 是否显示真实姓名（0不显示 1显示） */
    @Excel(name = "是否显示真实姓名", readConverterExp = "0=不显示,1=显示")
    private Integer showRealName;

    public void setUserId(Long userId) 
    {
        this.userId = userId;
    }

    public Long getUserId() 
    {
        return userId;
    }

    public void setShowDonationAmount(Integer showDonationAmount) 
    {
        this.showDonationAmount = showDonationAmount;
    }

    public Integer getShowDonationAmount() 
    {
        return showDonationAmount;
    }

    public void setShowDonationList(Integer showDonationList) 
    {
        this.showDonationList = showDonationList;
    }

    public Integer getShowDonationList() 
    {
        return showDonationList;
    }

    public void setShowRealName(Integer showRealName) 
    {
        this.showRealName = showRealName;
    }

    public Integer getShowRealName() 
    {
        return showRealName;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("userId", getUserId())
            .append("showDonationAmount", getShowDonationAmount())
            .append("showDonationList", getShowDonationList())
            .append("showRealName", getShowRealName())
            .append("createTime", getCreateTime())
            .append("updateTime", getUpdateTime())
            .toString();
    }
}
