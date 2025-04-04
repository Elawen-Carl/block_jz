package com.ruoyi.charity.service;

import java.util.List;
import com.ruoyi.charity.domain.ProjectComment;

/**
 * 项目评价Service接口
 * 
 * @author ruoyi
 * @date 2025-04-03
 */
public interface IProjectCommentService 
{
    /**
     * 查询项目评价
     * 
     * @param commentId 项目评价主键
     * @return 项目评价
     */
    public ProjectComment selectProjectCommentByCommentId(Long commentId);

    /**
     * 查询项目评价列表
     * 
     * @param projectComment 项目评价
     * @return 项目评价集合
     */
    public List<ProjectComment> selectProjectCommentList(ProjectComment projectComment);

    /**
     * 新增项目评价
     * 
     * @param projectComment 项目评价
     * @return 结果
     */
    public int insertProjectComment(ProjectComment projectComment);

    /**
     * 修改项目评价
     * 
     * @param projectComment 项目评价
     * @return 结果
     */
    public int updateProjectComment(ProjectComment projectComment);

    /**
     * 批量删除项目评价
     * 
     * @param commentIds 需要删除的项目评价主键集合
     * @return 结果
     */
    public int deleteProjectCommentByCommentIds(Long[] commentIds);

    /**
     * 删除项目评价信息
     * 
     * @param commentId 项目评价主键
     * @return 结果
     */
    public int deleteProjectCommentByCommentId(Long commentId);
}
