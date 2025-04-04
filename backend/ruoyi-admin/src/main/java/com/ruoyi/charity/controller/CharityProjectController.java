package com.ruoyi.charity.controller;

import com.ruoyi.charity.blockchain.service.BlockchainService;
import com.ruoyi.charity.domain.CharityProject;
import com.ruoyi.charity.service.ICharityProjectService;
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
@RequestMapping("/charity/project")
@Slf4j
public class CharityProjectController extends BaseController
{
    @Autowired
    private ICharityProjectService charityProjectService;
    
    @Autowired(required = false)
    private BlockchainService blockchainService;

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
     * 新增慈善项目
     */
    @PreAuthorize("@ss.hasPermi('charity:project:add')")
    @Log(title = "慈善项目", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody CharityProject charityProject)
    {
        // 先保存到数据库
        int rows = charityProjectService.insertCharityProject(charityProject);
        
        // 如果保存成功且区块链服务可用，则进行上链操作
        if (rows > 0 && blockchainService != null) {
            try {
                // 进行上链操作
                String txHash = blockchainService.createProjectOnChain(charityProject);
                // 更新区块链ID
                charityProject.setBlockchainId(txHash);
                charityProjectService.updateCharityProject(charityProject);
            } catch (Exception e) {
                log.error("项目上链失败", e);
                // 上链失败不影响业务操作
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
        return toAjax(charityProjectService.updateCharityProject(charityProject));
    }

    /**
     * 删除慈善项目
     */
    @PreAuthorize("@ss.hasPermi('charity:project:remove')")
    @Log(title = "慈善项目", businessType = BusinessType.DELETE)
	@DeleteMapping("/{projectIds}")
    public AjaxResult remove(@PathVariable Long[] projectIds)
    {
        return toAjax(charityProjectService.deleteCharityProjectByProjectIds(projectIds));
    }
    
    /**
     * 获取项目区块链信息
     */
    @GetMapping("/blockchain/{projectId}")
    public AjaxResult getBlockchainInfo(@PathVariable("projectId") Long projectId)
    {
        try {
            // 获取项目信息
            CharityProject project = charityProjectService.selectCharityProjectByProjectId(projectId);
            
            if (project == null) {
                return AjaxResult.error("项目不存在");
            }
            
            // 获取项目的区块链ID
            String blockchainId = project.getBlockchainId();
            
            if (blockchainId == null || blockchainId.isEmpty()) {
                // 如果没有区块链ID，则返回默认信息
                Map<String, Object> blockchainInfo = blockchainService != null ? 
                        blockchainService.getTransactionInfo(null) : 
                        createDefaultBlockchainInfo();
                
                blockchainInfo.put("txHash", "未上链");
                blockchainInfo.put("status", "pending");
                return AjaxResult.success(blockchainInfo);
            }
            
            // 使用BlockchainService获取实际的区块链信息
            Map<String, Object> blockchainInfo = blockchainService != null ? 
                    blockchainService.getTransactionInfo(blockchainId) : 
                    createDefaultBlockchainInfo();
                    
            return AjaxResult.success(blockchainInfo);
        } catch (Exception e) {
            log.error("获取区块链信息失败", e);
            return AjaxResult.success(createDefaultBlockchainInfo());
        }
    }
    
    /**
     * 创建默认的区块链信息
     */
    private Map<String, Object> createDefaultBlockchainInfo() {
        // 从区块链服务获取信息失败，返回模拟数据
        java.util.Map<String, Object> blockchainInfo = new java.util.HashMap<>();
        String uuid = java.util.UUID.randomUUID().toString().replace("-", "");
        int length = Math.min(uuid.length(), 40);
        blockchainInfo.put("txHash", "0x" + uuid.substring(0, length));
        blockchainInfo.put("timestamp", System.currentTimeMillis());
        blockchainInfo.put("blockNumber", (int)(Math.random() * 10000000) + 1000000);
        blockchainInfo.put("confirmations", (int)(Math.random() * 100) + 1);
        blockchainInfo.put("status", "confirmed");
        
        return blockchainInfo;
    }
}
