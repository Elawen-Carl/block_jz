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
        if (charityProject.getAuditStatus() != null) {
            // 如果是审核操作，且审核时间未设置，则自动设置审核时间
            if (charityProject.getAuditTime() == null) {
                charityProject.setAuditTime(DateUtils.getNowDate());
                log.info("项目 {} 设置审核时间: {}", charityProject.getProjectId(), charityProject.getAuditTime());
            }
            
            // 获取完整的项目信息
            CharityProject fullProject = null;
            if (charityProject.getProjectId() != null) {
                fullProject = selectCharityProjectByProjectId(charityProject.getProjectId());
                if (fullProject != null) {
                    // 合并审核字段到完整项目信息
                    fullProject.setAuditStatus(charityProject.getAuditStatus());
                    fullProject.setAuditTime(charityProject.getAuditTime());
                    fullProject.setAuditRemark(charityProject.getAuditRemark());
                    
                    // 同步审核状态到区块链
                    if (fullProject.getBlockchainId() != null && !fullProject.getBlockchainId().isEmpty()) {
                        try {
                            log.info("尝试将项目 {} 的审核状态同步到区块链", fullProject.getProjectId());
                            boolean success = blockchainService.approveProjectOnBlockchain(fullProject);
                            if (success) {
                                log.info("项目 {} 审核状态已成功同步到区块链", fullProject.getProjectId());
                            } else {
                                log.warn("项目 {} 审核状态同步到区块链失败", fullProject.getProjectId());
                            }
                        } catch (Exception e) {
                            log.error("项目 {} 审核状态同步到区块链失败: {}", fullProject.getProjectId(), e.getMessage(), e);
                            // 继续处理，区块链同步失败不影响主流程
                        }
                    } else if ("1".equals(fullProject.getAuditStatus())) {
                        // 如果是审核通过但没有区块链ID，尝试上链
                        try {
                            log.info("项目 {} 审核通过但无区块链ID，尝试上链", fullProject.getProjectId());
                            String blockchainId = blockchainService.uploadProjectToBlockchain(fullProject);
                            if (blockchainId != null && !blockchainId.isEmpty()) {
                                log.info("项目 {} 上链成功，区块链ID: {}", fullProject.getProjectId(), blockchainId);
                                charityProject.setBlockchainId(blockchainId);
                            }
                        } catch (Exception e) {
                            log.error("项目 {} 上链失败: {}", fullProject.getProjectId(), e.getMessage(), e);
                        }
                    }
                }
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
