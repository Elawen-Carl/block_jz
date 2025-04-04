package com.ruoyi.charity.mapper;

import java.util.List;
import com.ruoyi.charity.domain.CharityProject;

/**
 * 慈善项目Mapper接口
 * 
 * @author ruoyi
 * @date 2025-04-03
 */
public interface CharityProjectMapper 
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
     * 删除慈善项目
     * 
     * @param projectId 慈善项目主键
     * @return 结果
     */
    public int deleteCharityProjectByProjectId(Long projectId);

    /**
     * 批量删除慈善项目
     * 
     * @param projectIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteCharityProjectByProjectIds(Long[] projectIds);
}
