package com.ruoyi.charity.service.impl;

import java.util.List;
import com.ruoyi.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.charity.mapper.CharityProjectMapper;
import com.ruoyi.charity.domain.CharityProject;
import com.ruoyi.charity.service.ICharityProjectService;

/**
 * 慈善项目Service业务层处理
 * 
 * @author ruoyi
 * @date 2025-04-03
 */
@Service
public class CharityProjectServiceImpl implements ICharityProjectService 
{
    @Autowired
    private CharityProjectMapper charityProjectMapper;

    /**
     * 查询慈善项目
     * 
     * @param projectId 慈善项目主键
     * @return 慈善项目
     */
    @Override
    public CharityProject selectCharityProjectByProjectId(Long projectId)
    {
        return charityProjectMapper.selectCharityProjectByProjectId(projectId);
    }

    /**
     * 查询慈善项目列表
     * 
     * @param charityProject 慈善项目
     * @return 慈善项目
     */
    @Override
    public List<CharityProject> selectCharityProjectList(CharityProject charityProject)
    {
        return charityProjectMapper.selectCharityProjectList(charityProject);
    }

    /**
     * 新增慈善项目
     * 
     * @param charityProject 慈善项目
     * @return 结果
     */
    @Override
    public int insertCharityProject(CharityProject charityProject)
    {
        charityProject.setCreateTime(DateUtils.getNowDate());
        return charityProjectMapper.insertCharityProject(charityProject);
    }

    /**
     * 修改慈善项目
     * 
     * @param charityProject 慈善项目
     * @return 结果
     */
    @Override
    public int updateCharityProject(CharityProject charityProject)
    {
        charityProject.setUpdateTime(DateUtils.getNowDate());
        return charityProjectMapper.updateCharityProject(charityProject);
    }

    /**
     * 批量删除慈善项目
     * 
     * @param projectIds 需要删除的慈善项目主键
     * @return 结果
     */
    @Override
    public int deleteCharityProjectByProjectIds(Long[] projectIds)
    {
        return charityProjectMapper.deleteCharityProjectByProjectIds(projectIds);
    }

    /**
     * 删除慈善项目信息
     * 
     * @param projectId 慈善项目主键
     * @return 结果
     */
    @Override
    public int deleteCharityProjectByProjectId(Long projectId)
    {
        return charityProjectMapper.deleteCharityProjectByProjectId(projectId);
    }
}
