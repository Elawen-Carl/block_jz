package com.ruoyi.charity.service;

import java.util.List;
import com.ruoyi.charity.domain.CharityProject;

/**
 * 慈善项目Service接口
 * 
 * @author ruoyi
 * @date 2025-04-03
 */
public interface ICharityProjectService 
{
    /**
     * 查询慈善项目
     * 
     * @param projectId 慈善项目主键
     * @return 慈善项目
     */
    public CharityProject selectCharityProjectByProjectId(Long projectId);

    /**
     * 查询慈善项目列表
     * 
     * @param charityProject 慈善项目
     * @return 慈善项目集合
     */
    public List<CharityProject> selectCharityProjectList(CharityProject charityProject);

    /**
     * 新增慈善项目
     * 
     * @param charityProject 慈善项目
     * @return 结果
     */
    public int insertCharityProject(CharityProject charityProject);

    /**
     * 修改慈善项目
     * 
     * @param charityProject 慈善项目
     * @return 结果
     */
    public int updateCharityProject(CharityProject charityProject);

    /**
     * 批量删除慈善项目
     * 
     * @param projectIds 需要删除的慈善项目主键集合
     * @return 结果
     */
    public int deleteCharityProjectByProjectIds(Long[] projectIds);

    /**
     * 删除慈善项目信息
     * 
     * @param projectId 慈善项目主键
     * @return 结果
     */
    public int deleteCharityProjectByProjectId(Long projectId);
}
