package com.ruoyi.charity.service.impl;

import java.util.List;
import com.ruoyi.common.utils.DateUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.ruoyi.charity.mapper.CharityProjectMapper;
import com.ruoyi.charity.domain.CharityProject;
import com.ruoyi.charity.blockchain.service.BlockchainIntegrationService;
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
    private static final Logger log = LoggerFactory.getLogger(CharityProjectServiceImpl.class);
    
    @Autowired
    private CharityProjectMapper charityProjectMapper;
    
    @Autowired
    private BlockchainIntegrationService blockchainService;

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
    @Transactional
    public int insertCharityProject(CharityProject charityProject)
    {
        charityProject.setCreateTime(DateUtils.getNowDate());
        
        // 先保存到数据库获取ID
        int rows = charityProjectMapper.insertCharityProject(charityProject);
        
        if (rows > 0) {
            try {
                // 上传到区块链
                String blockchainProjectId = blockchainService.uploadProjectToBlockchain(charityProject);
                
                // 更新区块链项目ID
                charityProject.setBlockchainId(blockchainProjectId);
                charityProjectMapper.updateCharityProject(charityProject);
                
                log.info("项目 {} 成功上传到区块链, ID: {}", charityProject.getProjectId(), blockchainProjectId);
            } catch (Exception e) {
                log.error("项目上传区块链失败: {}", e.getMessage(), e);
                // 继续处理，区块链上传失败不影响主流程
            }
        }
        
        return rows;
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
        
        // 检查是否是审核操作
        if (charityProject.getAuditStatus() != null && 
            charityProject.getBlockchainId() != null && 
            !charityProject.getBlockchainId().isEmpty()) {
            try {
                // 同步审核状态到区块链
                blockchainService.approveProjectOnBlockchain(charityProject);
                log.info("项目 {} 审核状态已同步到区块链", charityProject.getProjectId());
            } catch (Exception e) {
                log.error("项目审核状态同步到区块链失败: {}", e.getMessage(), e);
                // 继续处理，区块链同步失败不影响主流程
            }
        }
        
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
