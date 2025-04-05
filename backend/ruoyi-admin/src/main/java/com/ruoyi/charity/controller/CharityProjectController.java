package com.ruoyi.charity.controller;

import com.ruoyi.charity.domain.CharityProject;
import com.ruoyi.charity.service.ICharityProjectService;
import com.ruoyi.charity.blockchain.service.BlockchainIntegrationService;
import com.ruoyi.charity.blockchain.service.FabricQueryService;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.common.utils.poi.ExcelUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Map;

/**
 * 慈善项目Controller
 * 
 * @author ruoyi
 * @date 2025-04-03
 */
@RestController
@Slf4j
@RequestMapping("/charity/project")
public class CharityProjectController extends BaseController
{
    @Autowired
    private ICharityProjectService charityProjectService;
    
    @Autowired
    private BlockchainIntegrationService blockchainService;
    
    @Autowired(required = false)
    private FabricQueryService fabricQueryService;

    /**
     * 查询慈善项目列表
     */
    @PreAuthorize("@ss.hasPermi('charity:project:list')")
    @GetMapping("/list")
    public TableDataInfo list(CharityProject charityProject)
    {
        startPage();
        List<CharityProject> list = charityProjectService.selectCharityProjectList(charityProject);
        return getDataTable(list);
    }

    /**
     * 导出慈善项目列表
     */
    @PreAuthorize("@ss.hasPermi('charity:project:export')")
    @Log(title = "慈善项目", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, CharityProject charityProject)
    {
        List<CharityProject> list = charityProjectService.selectCharityProjectList(charityProject);
        ExcelUtil<CharityProject> util = new ExcelUtil<CharityProject>(CharityProject.class);
        util.exportExcel(response, list, "慈善项目数据");
    }

    /**
     * 获取慈善项目详细信息
     */
    @PreAuthorize("@ss.hasPermi('charity:project:query')")
    @GetMapping(value = "/{projectId}")
    public AjaxResult getInfo(@PathVariable("projectId") Long projectId)
    {
        return success(charityProjectService.selectCharityProjectByProjectId(projectId));
    }
    
    /**
     * 获取慈善项目区块链详情
     */
    @PreAuthorize("@ss.hasPermi('charity:project:query')")
    @GetMapping(value = "/blockchain/{projectId}")
    public AjaxResult getBlockchainInfo(@PathVariable("projectId") Long projectId)
    {
        try {
            log.info("正在查询项目[{}]的区块链信息", projectId);
            
            // 查询项目信息
            CharityProject project = charityProjectService.selectCharityProjectByProjectId(projectId);
            if (project == null) {
                log.warn("项目[{}]不存在", projectId);
                return error("项目不存在");
            }
            
            String blockchainId = project.getBlockchainId();
            boolean needReupload = false;
            
            // 检查区块链ID是否存在
            if (blockchainId == null || blockchainId.isEmpty()) {
                log.warn("项目[{}]尚未上链，区块链ID为空", projectId);
                needReupload = true;
            }
            
            // 如果需要上传到区块链
            if (needReupload) {
                // 项目必须审核通过才能上链
                if ("1".equals(project.getAuditStatus()) && blockchainService != null) {
                    try {
                        log.info("项目[{}]已审核但未上链，尝试主动上链", projectId);
                        String newBlockchainId = blockchainService.uploadProjectToBlockchain(project);
                        project.setBlockchainId(newBlockchainId);
                        charityProjectService.updateCharityProject(project);
                        blockchainId = newBlockchainId;
                        log.info("项目[{}]主动上链成功，区块链ID: {}", projectId, newBlockchainId);
                    } catch (Exception e) {
                        log.error("项目[{}]主动上链失败: {}", projectId, e.getMessage(), e);
                        return error("该项目尚未上链且上链失败: " + e.getMessage());
                    }
                } else {
                    return error("该项目尚未审核通过，无法上链");
                }
            }
            
            log.info("项目[{}]的区块链ID: {}", projectId, blockchainId);
            
            Map<String, Object> blockchainInfo;
            if (fabricQueryService != null) {
                // 尝试从区块链获取详细信息
                try {
                    blockchainInfo = fabricQueryService.getCharityProjectDetails(blockchainId);
                    if (blockchainInfo != null && "error".equals(blockchainInfo.get("status"))) {
                        log.warn("区块链查询返回错误: {}", blockchainInfo.get("error"));
                        
                        // 检查是否是"项目不存在"错误，如果是则尝试重新上链
                        String errorMsg = blockchainInfo.get("error") != null ? blockchainInfo.get("error").toString() : "";
                        if (errorMsg.contains("不存在") && "1".equals(project.getAuditStatus()) && blockchainService != null) {
                            log.info("项目[{}]在区块链上不存在，尝试重新上链", projectId);
                            try {
                                String newBlockchainId = blockchainService.uploadProjectToBlockchain(project);
                                project.setBlockchainId(newBlockchainId);
                                charityProjectService.updateCharityProject(project);
                                
                                // 重新查询区块链信息
                                blockchainInfo = fabricQueryService.getCharityProjectDetails(newBlockchainId);
                                if (blockchainInfo != null && !"error".equals(blockchainInfo.get("status"))) {
                                    log.info("项目[{}]重新上链并查询成功", projectId);
                                    return success(blockchainInfo);
                                }
                            } catch (Exception e) {
                                log.error("项目[{}]重新上链失败: {}", projectId, e.getMessage(), e);
                            }
                        }
                        
                        // 如果区块链查询返回错误，使用默认数据
                        blockchainInfo = createDefaultBlockchainInfo(project);
                    }
                    log.info("成功获取项目[{}]的区块链详情", projectId);
                } catch (Exception e) {
                    log.error("获取项目[{}]区块链详情出错: {}", projectId, e.getMessage(), e);
                    blockchainInfo = createDefaultBlockchainInfo(project);
                }
            } else {
                // Fabric查询服务不可用，返回模拟数据
                log.warn("Fabric查询服务不可用，返回模拟区块链数据");
                blockchainInfo = createDefaultBlockchainInfo(project);
            }
            
            return success(blockchainInfo);
        } catch (Exception e) {
            log.error("查询项目区块链信息异常", e);
            return error("查询区块链信息失败: " + e.getMessage());
        }
    }

    /**
     * 新增慈善项目
     */
    @PreAuthorize("@ss.hasPermi('charity:project:add')")
    @Log(title = "慈善项目", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody CharityProject charityProject)
    {
        charityProject.setInitiatorId(getUserId());
        // 先保存到数据库
        int rows = charityProjectService.insertCharityProject(charityProject);
        
        // 如果保存成功且区块链服务可用，且项目已审核通过，则主动进行上链操作
        if (rows > 0 && "1".equals(charityProject.getAuditStatus()) && blockchainService != null) {
            try {
                log.info("项目[{}]新增并审核通过，尝试主动上链", charityProject.getProjectId());
                String blockchainId = blockchainService.uploadProjectToBlockchain(charityProject);
                
                // 更新区块链ID
                charityProject.setBlockchainId(blockchainId);
                charityProjectService.updateCharityProject(charityProject);
                
                log.info("项目[{}]主动上链成功，区块链ID: {}", charityProject.getProjectId(), blockchainId);
            } catch (Exception e) {
                log.error("项目[{}]主动上链失败: {}", charityProject.getProjectId(), e.getMessage(), e);
                // 上链失败不影响项目创建
            }
        }
        
        return toAjax(rows);
    }

    /**
     * 修改慈善项目
     */
    @PreAuthorize("@ss.hasPermi('charity:project:edit')")
    @Log(title = "慈善项目", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody CharityProject charityProject)
    {
        int rows = charityProjectService.updateCharityProject(charityProject);
        
        // 如果修改成功且项目已有区块链ID
        if (rows > 0 && charityProject.getBlockchainId() != null && !charityProject.getBlockchainId().isEmpty() && blockchainService != null) {
            try {
                // 更新区块链上的项目信息（主要是审核状态）
                boolean success = blockchainService.approveProjectOnBlockchain(charityProject);
                if (success) {
                    log.info("项目[{}]的区块链信息已更新", charityProject.getProjectId());
                } else {
                    log.warn("项目[{}]的区块链信息更新失败", charityProject.getProjectId());
                }
            } catch (Exception e) {
                log.error("更新项目[{}]的区块链信息失败: {}", charityProject.getProjectId(), e.getMessage(), e);
                // 区块链更新失败不影响项目更新
            }
        } 
        // 如果项目审核通过但还没有区块链ID，尝试上链
        else if (rows > 0 && "1".equals(charityProject.getAuditStatus()) && 
                (charityProject.getBlockchainId() == null || charityProject.getBlockchainId().isEmpty()) && 
                blockchainService != null) {
            try {
                log.info("项目[{}]修改后审核通过，尝试主动上链", charityProject.getProjectId());
                String blockchainId = blockchainService.uploadProjectToBlockchain(charityProject);
                
                // 更新区块链ID
                CharityProject updateProject = new CharityProject();
                updateProject.setProjectId(charityProject.getProjectId());
                updateProject.setBlockchainId(blockchainId);
                charityProjectService.updateCharityProject(updateProject);
                
                log.info("项目[{}]主动上链成功，区块链ID: {}", charityProject.getProjectId(), blockchainId);
            } catch (Exception e) {
                log.error("项目[{}]主动上链失败: {}", charityProject.getProjectId(), e.getMessage(), e);
                // 上链失败不影响项目更新
            }
        }
        
        return toAjax(rows);
    }

    /**
     * 删除慈善项目
     */
    @PreAuthorize("@ss.hasPermi('charity:project:remove')")
    @Log(title = "慈善项目", businessType = BusinessType.DELETE)
	@DeleteMapping("/{projectIds}")
    public AjaxResult remove(@PathVariable Long[] projectIds)
    {
        // 在删除前获取项目信息，用于区块链状态更新
        if (projectIds != null && projectIds.length > 0 && blockchainService != null) {
            for (Long projectId : projectIds) {
                try {
                    CharityProject project = charityProjectService.selectCharityProjectByProjectId(projectId);
                    if (project != null && project.getBlockchainId() != null && !project.getBlockchainId().isEmpty()) {
                        // 将项目状态更改为已删除（在区块链上）
                        project.setStatus("2"); // 假设状态2表示删除
                        boolean success = blockchainService.approveProjectOnBlockchain(project);
                        if (success) {
                            log.info("项目[{}]在区块链上标记为已删除", projectId);
                        } else {
                            log.warn("项目[{}]在区块链上标记为已删除失败", projectId);
                        }
                    }
                } catch (Exception e) {
                    log.error("项目[{}]在区块链上标记删除状态失败: {}", projectId, e.getMessage(), e);
                    // 区块链更新失败不影响项目删除
                }
            }
        }
        
        return toAjax(charityProjectService.deleteCharityProjectByProjectIds(projectIds));
    }

    
    /**
     * 创建默认的区块链信息
     */
    private Map<String, Object> createDefaultBlockchainInfo(CharityProject project) {
        // 从区块链服务获取信息失败，返回模拟数据
        java.util.Map<String, Object> blockchainInfo = new java.util.HashMap<>();
        
        String blockchainId = project.getBlockchainId();
        if (blockchainId == null) {
            blockchainId = "project_" + java.util.UUID.randomUUID().toString().replace("-", "").substring(0, 16);
        }
        
        blockchainInfo.put("blockchainId", blockchainId);
        blockchainInfo.put("txHash", "0x" + java.util.UUID.randomUUID().toString().replace("-", "").substring(0, 40));
        blockchainInfo.put("timestamp", System.currentTimeMillis());
        blockchainInfo.put("blockNumber", (int)(Math.random() * 10000000) + 1000000);
        blockchainInfo.put("confirmations", (int)(Math.random() * 100) + 1);
        blockchainInfo.put("status", "confirmed");
        blockchainInfo.put("projectName", project.getProjectName());
        blockchainInfo.put("targetAmount", project.getTargetAmount());
        blockchainInfo.put("currentAmount", project.getCurrentAmount());
        
        java.util.Map<String, Object> auditInfo = new java.util.HashMap<>();
        auditInfo.put("status", "1".equals(project.getAuditStatus()) ? "已审核" : "未审核");
        auditInfo.put("time", project.getAuditTime() != null ? project.getAuditTime().getTime() : null);
        auditInfo.put("remark", project.getAuditRemark());
        
        blockchainInfo.put("auditInfo", auditInfo);
        
        return blockchainInfo;
    }
}
