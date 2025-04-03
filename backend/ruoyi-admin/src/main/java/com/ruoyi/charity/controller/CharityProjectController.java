package com.ruoyi.charity.controller;

import java.util.List;
import javax.servlet.http.HttpServletResponse;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.charity.domain.CharityProject;
import com.ruoyi.charity.service.ICharityProjectService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 慈善项目Controller
 * 
 * @author ruoyi
 * @date 2025-04-03
 */
@RestController
@RequestMapping("/charity/project")
public class CharityProjectController extends BaseController
{
    @Autowired
    private ICharityProjectService charityProjectService;

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
        return toAjax(charityProjectService.insertCharityProject(charityProject));
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
}
