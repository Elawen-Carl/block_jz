package com.ruoyi.charity.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.ruoyi.charity.domain.dto.StatisticsDTO;
import com.ruoyi.charity.service.IStatisticsService;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;

/**
 * 统计数据 控制器
 * 
 * @author ruoyi
 * @date 2025-04-03
 */
@RestController
@Slf4j
@RequestMapping("/charity/statistics")
public class StatisticsController extends BaseController {
    
    @Autowired
    private IStatisticsService statisticsService;
    
    /**
     * 获取总体统计数据
     */
    @GetMapping("/overall")

    public AjaxResult getOverallStatistics() {
        StatisticsDTO.OverallStatistics stats = statisticsService.getOverallStatistics();
        return AjaxResult.success(stats);
    }
    
    /**
     * 获取捐赠统计数据
     */
    @GetMapping("/donation")
    public AjaxResult getDonationStatistics() {
        StatisticsDTO.DonationSourceStatistics stats = statisticsService.getDonationStatistics();
        return AjaxResult.success(stats);
    }
    
    /**
     * 获取项目统计数据
     */
    @GetMapping("/project")
    public AjaxResult getProjectStatistics() {
        StatisticsDTO.ProjectStatistics stats = statisticsService.getProjectStatistics();
        return AjaxResult.success(stats);
    }
    
    /**
     * 获取资金使用统计数据
     */
    @GetMapping("/fund")
    public AjaxResult getFundUsageStatistics() {
        StatisticsDTO.FundUsageStatistics stats = statisticsService.getFundUsageStatistics();
        return AjaxResult.success(stats);
    }
    
    /**
     * 获取捐赠趋势数据
     */
    @GetMapping("/trend")
    public AjaxResult getDonationTrend(@RequestParam(value = "timeRange", defaultValue = "month") String timeRange) {
        StatisticsDTO.DonationTrend stats = statisticsService.getDonationTrend(timeRange);
        return AjaxResult.success(stats);
    }
} 