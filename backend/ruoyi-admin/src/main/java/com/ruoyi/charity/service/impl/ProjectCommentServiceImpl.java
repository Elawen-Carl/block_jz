package com.ruoyi.charity.service.impl;

import java.util.List;
import com.ruoyi.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.charity.mapper.ProjectCommentMapper;
import com.ruoyi.charity.domain.ProjectComment;
import com.ruoyi.charity.service.IProjectCommentService;

/**
 * 项目评价Service业务层处理
 * 
 * @author ruoyi
 * @date 2025-04-03
 */
@Service
public class ProjectCommentServiceImpl implements IProjectCommentService 
{
    @Autowired
    private ProjectCommentMapper projectCommentMapper;

    /**
     * 查询项目评价
     * 
     * @param commentId 项目评价主键
     * @return 项目评价
     */
    @Override
    public ProjectComment selectProjectCommentByCommentId(Long commentId)
    {
        return projectCommentMapper.selectProjectCommentByCommentId(commentId);
    }

    /**
     * 查询项目评价列表
     * 
     * @param projectComment 项目评价
     * @return 项目评价
     */
    @Override
    public List<ProjectComment> selectProjectCommentList(ProjectComment projectComment)
    {
        return projectCommentMapper.selectProjectCommentList(projectComment);
    }

    /**
     * 新增项目评价
     * 
     * @param projectComment 项目评价
     * @return 结果
     */
    @Override
    public int insertProjectComment(ProjectComment projectComment)
    {
        projectComment.setCreateTime(DateUtils.getNowDate());
        return projectCommentMapper.insertProjectComment(projectComment);
    }

    /**
     * 修改项目评价
     * 
     * @param projectComment 项目评价
     * @return 结果
     */
    @Override
    public int updateProjectComment(ProjectComment projectComment)
    {
        return projectCommentMapper.updateProjectComment(projectComment);
    }

    /**
     * 批量删除项目评价
     * 
     * @param commentIds 需要删除的项目评价主键
     * @return 结果
     */
    @Override
    public int deleteProjectCommentByCommentIds(Long[] commentIds)
    {
        return projectCommentMapper.deleteProjectCommentByCommentIds(commentIds);
    }

    /**
     * 删除项目评价信息
     * 
     * @param commentId 项目评价主键
     * @return 结果
     */
    @Override
    public int deleteProjectCommentByCommentId(Long commentId)
    {
        return projectCommentMapper.deleteProjectCommentByCommentId(commentId);
    }
}
