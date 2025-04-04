package com.ruoyi.charity.mapper;

import java.util.List;
import com.ruoyi.charity.domain.ProjectComment;

/**
 * 项目评价Mapper接口
 * 
 * @author ruoyi
 * @date 2025-04-03
 */
public interface ProjectCommentMapper 
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
     * 删除项目评价
     * 
     * @param commentId 项目评价主键
     * @return 结果
     */
    public int deleteProjectCommentByCommentId(Long commentId);

    /**
     * 批量删除项目评价
     * 
     * @param commentIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteProjectCommentByCommentIds(Long[] commentIds);
}
