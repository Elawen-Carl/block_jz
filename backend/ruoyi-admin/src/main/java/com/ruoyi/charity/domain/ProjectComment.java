package com.ruoyi.charity.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 项目评价对象 project_comment
 * 
 * @author ruoyi
 * @date 2025-04-03
 */
public class ProjectComment extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 评价编号 */
    @Excel(name = "评价编号")
    private Long commentId;

    /** 项目编号 */
    @Excel(name = "项目编号")
    private Long projectId;

    /** 用户编号 */
    @Excel(name = "用户编号")
    private Long userId;

    /** 评价内容 */
    @Excel(name = "评价内容")
    private String content;

    /** 评分 */
    @Excel(name = "评分")
    private Long rating;

    public void setCommentId(Long commentId) 
    {
        this.commentId = commentId;
    }

    public Long getCommentId() 
    {
        return commentId;
    }

    public void setProjectId(Long projectId) 
    {
        this.projectId = projectId;
    }

    public Long getProjectId() 
    {
        return projectId;
    }

    public void setUserId(Long userId) 
    {
        this.userId = userId;
    }

    public Long getUserId() 
    {
        return userId;
    }

    public void setContent(String content) 
    {
        this.content = content;
    }

    public String getContent() 
    {
        return content;
    }

    public void setRating(Long rating) 
    {
        this.rating = rating;
    }

    public Long getRating() 
    {
        return rating;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("commentId", getCommentId())
            .append("projectId", getProjectId())
            .append("userId", getUserId())
            .append("content", getContent())
            .append("rating", getRating())
            .append("createTime", getCreateTime())
            .toString();
    }
}
