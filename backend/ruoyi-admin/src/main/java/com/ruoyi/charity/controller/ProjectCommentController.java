package com.ruoyi.charity.controller;

import java.util.List;
import javax.servlet.http.HttpServletResponse;

import lombok.extern.slf4j.Slf4j;
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
import com.ruoyi.charity.domain.ProjectComment;
import com.ruoyi.charity.service.IProjectCommentService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 项目评价Controller
 * 
 * @author ruoyi
 * @date 2025-04-03
 */
@RestController
@Slf4j
@RequestMapping("/charity/comment")
public class ProjectCommentController extends BaseController
{
    @Autowired
    private IProjectCommentService projectCommentService;

    /**
     * 查询项目评价列表
     */
    @PreAuthorize("@ss.hasPermi('charity:comment:list')")
    @GetMapping("/list")
    public TableDataInfo list(ProjectComment projectComment)
    {
        startPage();
        List<ProjectComment> list = projectCommentService.selectProjectCommentList(projectComment);
        return getDataTable(list);
    }

    /**
     * 导出项目评价列表
     */
    @PreAuthorize("@ss.hasPermi('charity:comment:export')")
    @Log(title = "项目评价", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, ProjectComment projectComment)
    {
        List<ProjectComment> list = projectCommentService.selectProjectCommentList(projectComment);
        ExcelUtil<ProjectComment> util = new ExcelUtil<ProjectComment>(ProjectComment.class);
        util.exportExcel(response, list, "项目评价数据");
    }

    /**
     * 获取项目评价详细信息
     */
    @PreAuthorize("@ss.hasPermi('charity:comment:query')")
    @GetMapping(value = "/{commentId}")
    public AjaxResult getInfo(@PathVariable("commentId") Long commentId)
    {
        return success(projectCommentService.selectProjectCommentByCommentId(commentId));
    }

    /**
     * 新增项目评价
     */
    @PreAuthorize("@ss.hasPermi('charity:comment:add')")
    @Log(title = "项目评价", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody ProjectComment projectComment)
    {
        // 设置当前用户ID
        if (projectComment.getUserId() == null) {
            projectComment.setUserId(getUserId());
        }
        return toAjax(projectCommentService.insertProjectComment(projectComment));
    }

    /**
     * 修改项目评价
     */
    @PreAuthorize("@ss.hasPermi('charity:comment:edit')")
    @Log(title = "项目评价", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody ProjectComment projectComment)
    {
        return toAjax(projectCommentService.updateProjectComment(projectComment));
    }

    /**
     * 删除项目评价
     */
    @PreAuthorize("@ss.hasPermi('charity:comment:remove')")
    @Log(title = "项目评价", businessType = BusinessType.DELETE)
	@DeleteMapping("/{commentIds}")
    public AjaxResult remove(@PathVariable Long[] commentIds)
    {
        return toAjax(projectCommentService.deleteProjectCommentByCommentIds(commentIds));
    }
}
