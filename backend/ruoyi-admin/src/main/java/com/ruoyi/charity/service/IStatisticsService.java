package com.ruoyi.charity.service;

import com.ruoyi.charity.domain.dto.StatisticsDTO;

/**
 * 统计数据 服务层
 * 
 * @author ruoyi
 * @date 2025-04-03
 */
public interface IStatisticsService {
    
    /**
     * 获取总体统计数据
     * 
     * @return 总体统计数据
     */
    public StatisticsDTO.OverallStatistics getOverallStatistics();
    
    /**
     * 获取捐赠统计数据
     * 
     * @return 捐赠来源分布数据
     */
    public StatisticsDTO.DonationSourceStatistics getDonationStatistics();
    
    /**
     * 获取项目统计数据
     * 
     * @return 项目状态统计数据
     */
    public StatisticsDTO.ProjectStatistics getProjectStatistics();
    
    /**
     * 获取资金使用统计数据
     * 
     * @return 资金使用情况统计
     */
    public StatisticsDTO.FundUsageStatistics getFundUsageStatistics();
    
    /**
     * 获取捐赠趋势数据
     * 
     * @param timeRange 时间范围：week/month/year
     * @return 捐赠趋势数据
     */
    public StatisticsDTO.DonationTrend getDonationTrend(String timeRange);
} 