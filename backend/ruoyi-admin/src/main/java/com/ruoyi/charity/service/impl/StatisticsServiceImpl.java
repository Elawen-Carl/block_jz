package com.ruoyi.charity.service.impl;

import com.ruoyi.charity.domain.CharityProject;
import com.ruoyi.charity.domain.DonationRecord;
import com.ruoyi.charity.domain.FundUsageRecord;
import com.ruoyi.charity.domain.dto.StatisticsDTO;
import com.ruoyi.charity.mapper.CharityProjectMapper;
import com.ruoyi.charity.mapper.DonationRecordMapper;
import com.ruoyi.charity.mapper.FundUsageRecordMapper;
import com.ruoyi.charity.service.IStatisticsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.stream.Collectors;

/**
 * 统计数据 服务层实现
 * 
 * @author ruoyi
 * @date 2025-04-03
 */
@Service
public class StatisticsServiceImpl implements IStatisticsService {
    
    @Autowired
    private CharityProjectMapper charityProjectMapper;
    
    @Autowired
    private DonationRecordMapper donationRecordMapper;
    
    @Autowired
    private FundUsageRecordMapper fundUsageRecordMapper;
    
                                                                                              /**
     * 获取总体统计数据
     * 
     * @return 总体统计数据
     */
    @Override
    public StatisticsDTO.OverallStatistics getOverallStatistics() {
        StatisticsDTO.OverallStatistics stats = new StatisticsDTO.OverallStatistics();
        
        // 查询所有捐赠记录
        DonationRecord donationQuery = new DonationRecord();
        List<DonationRecord> donations = donationRecordMapper.selectDonationRecordList(donationQuery);
        
        // 查询所有项目
        CharityProject projectQuery = new CharityProject();
        List<CharityProject> projects = charityProjectMapper.selectCharityProjectList(projectQuery);
        
        // 查询所有资金使用记录
        FundUsageRecord fundQuery = new FundUsageRecord();
        List<FundUsageRecord> funds = fundUsageRecordMapper.selectFundUsageRecordList(fundQuery);
        
        // 计算总捐赠金额
        BigDecimal totalDonation = donations.stream()
                .map(DonationRecord::getDonationAmount)
                .filter(Objects::nonNull)
                .reduce(BigDecimal.ZERO, BigDecimal::add);
        
        // 计算总的资金使用金额
        BigDecimal totalUsed = funds.stream()
                .map(FundUsageRecord::getAmount)
                .filter(Objects::nonNull)
                .reduce(BigDecimal.ZERO, BigDecimal::add);
        
        // 计算资金使用率
        BigDecimal usageRate = BigDecimal.ZERO;
        if (totalDonation.compareTo(BigDecimal.ZERO) > 0) {
            usageRate = totalUsed.multiply(new BigDecimal("100"))
                    .divide(totalDonation, 2, RoundingMode.HALF_UP);
        }
        
        // 计算捐赠人数
        Set<Long> donorSet = donations.stream()
                .map(DonationRecord::getUserId)
                .filter(Objects::nonNull)
                .collect(Collectors.toSet());
        
        // 计算月均捐赠人数
        Calendar calendar = Calendar.getInstance();
        calendar.add(Calendar.MONTH, -1); // 一个月前
        Date oneMonthAgo = calendar.getTime();
        
        Set<Long> monthlyDonors = donations.stream()
                .filter(d -> d.getDonationTime() != null && d.getDonationTime().after(oneMonthAgo))
                .map(DonationRecord::getUserId)
                .filter(Objects::nonNull)
                .collect(Collectors.toSet());
        
        // 计算进行中的项目数
        long activeProjects = projects.stream()
                .filter(p -> "1".equals(p.getStatus()))
                .count();
        
        // 设置结果
        stats.setTotalDonation(totalDonation);
        stats.setDonationCount(donations.size());
        stats.setTotalProjects(projects.size());
        stats.setActiveProjects((int) activeProjects);
        stats.setTotalDonors(donorSet.size());
        stats.setMonthlyDonors(monthlyDonors.size());
        stats.setFundUsageRate(usageRate);
        stats.setUsedFunds(totalUsed);
        
        return stats;
    }
    
    /**
     * 获取捐赠统计数据
     * 
     * @return 捐赠来源分布数据
     */
    @Override
    public StatisticsDTO.DonationSourceStatistics getDonationStatistics() {
        StatisticsDTO.DonationSourceStatistics stats = new StatisticsDTO.DonationSourceStatistics();
        
        // 查询所有捐赠记录
        DonationRecord donationQuery = new DonationRecord();
        List<DonationRecord> donations = donationRecordMapper.selectDonationRecordList(donationQuery);
        
        // 按来源分组统计
        Map<String, List<DonationRecord>> sourceGroups = donations.stream()
                .collect(Collectors.groupingBy(d -> {
                    // 根据isAnonymous和paymentMethod划分来源
                    if (d.getRemark() != null && d.getRemark().contains("匿名")) {
                        return "匿名捐赠";
                    } else if ("online".equals(d.getPaymentMethod())) {
                        return "在线捐赠";
                    } else if ("offline".equals(d.getPaymentMethod())) {
                        return "线下捐赠";
                    } else {
                        return "其他方式";
                    }
                }));
        
        // 构建来源数据
        List<Map<String, Object>> sourceData = new ArrayList<>();
        sourceGroups.forEach((source, list) -> {
            Map<String, Object> data = new HashMap<>();
            data.put("name", source);
            
            // 计算该来源的总金额
            BigDecimal value = list.stream()
                    .map(DonationRecord::getDonationAmount)
                    .filter(Objects::nonNull)
                    .reduce(BigDecimal.ZERO, BigDecimal::add);
            
            data.put("value", value);
            sourceData.add(data);
        });
        
        stats.setSourceData(sourceData);
        return stats;
    }
    
    /**
     * 获取项目统计数据
     * 
     * @return 项目状态统计数据
     */
    @Override
    public StatisticsDTO.ProjectStatistics getProjectStatistics() {
        StatisticsDTO.ProjectStatistics stats = new StatisticsDTO.ProjectStatistics();
        
        // 查询所有项目
        CharityProject projectQuery = new CharityProject();
        List<CharityProject> projects = charityProjectMapper.selectCharityProjectList(projectQuery);
        
        // 按状态分组统计
        Map<String, Long> statusCounts = projects.stream()
                .collect(Collectors.groupingBy(
                        p -> p.getStatus() != null ? p.getStatus() : "未知",
                        Collectors.counting()
                ));
        
        // 构建状态数据
        List<Map<String, Object>> statusData = new ArrayList<>();
        statusCounts.forEach((status, count) -> {
            Map<String, Object> data = new HashMap<>();
            
            // 状态名称转换
            String statusName;
            switch(status) {
                case "0":
                    statusName = "未开始";
                    break;
                case "1":
                    statusName = "进行中";
                    break;
                case "2":
                    statusName = "已完成";
                    break;
                case "3":
                    statusName = "已关闭";
                    break;
                default:
                    statusName = "未知状态";
            }
            
            data.put("name", statusName);
            data.put("value", count);
            statusData.add(data);
        });
        
        stats.setStatusData(statusData);
        return stats;
    }
    
    /**
     * 获取资金使用统计数据
     * 
     * @return 资金使用情况统计
     */
    @Override
    public StatisticsDTO.FundUsageStatistics getFundUsageStatistics() {
        StatisticsDTO.FundUsageStatistics stats = new StatisticsDTO.FundUsageStatistics();
        
        // 查询所有资金使用记录
        FundUsageRecord fundQuery = new FundUsageRecord();
        List<FundUsageRecord> funds = fundUsageRecordMapper.selectFundUsageRecordList(fundQuery);
        
        // 按用途分组统计
        Map<String, List<FundUsageRecord>> purposeGroups = funds.stream()
                .collect(Collectors.groupingBy(f -> 
                    f.getUsageDesc() != null ? f.getUsageDesc() : "其他用途"
                ));
        
        // 构建类别和值列表
        List<String> categories = new ArrayList<>();
        List<BigDecimal> values = new ArrayList<>();
        
        purposeGroups.forEach((purpose, list) -> {
            categories.add(purpose);
            
            // 计算该用途的总金额
            BigDecimal total = list.stream()
                    .map(FundUsageRecord::getAmount)
                    .filter(Objects::nonNull)
                    .reduce(BigDecimal.ZERO, BigDecimal::add);
            
            values.add(total);
        });
        
        stats.setCategories(categories);
        stats.setValues(values);
        return stats;
    }
    
    /**
     * 获取捐赠趋势数据
     * 
     * @param timeRange 时间范围：week/month/year
     * @return 捐赠趋势数据
     */
    @Override
    public StatisticsDTO.DonationTrend getDonationTrend(String timeRange) {
        StatisticsDTO.DonationTrend stats = new StatisticsDTO.DonationTrend();
        
        // 根据时间范围确定查询开始时间
        Calendar calendar = Calendar.getInstance();
        Date endDate = calendar.getTime();
        
        switch (timeRange) {
            case "week":
                calendar.add(Calendar.DAY_OF_YEAR, -7);
                break;
            case "month":
                calendar.add(Calendar.MONTH, -1);
                break;
            case "year":
                calendar.add(Calendar.YEAR, -1);
                break;
            default:
                calendar.add(Calendar.MONTH, -1); // 默认一个月
        }
        
        Date startDate = calendar.getTime();
        
        // 查询时间范围内的捐赠记录
        DonationRecord donationQuery = new DonationRecord();
        List<DonationRecord> donations = donationRecordMapper.selectDonationRecordList(donationQuery);
        
        // 过滤时间范围内的记录
        List<DonationRecord> filteredDonations = donations.stream()
                .filter(d -> d.getDonationTime() != null && 
                        !d.getDonationTime().before(startDate) && 
                        !d.getDonationTime().after(endDate))
                .collect(Collectors.toList());
        
        // 确定日期格式和间隔
        String dateFormat;
        int calendarField;
        
        if ("week".equals(timeRange)) {
            dateFormat = "MM-dd";
            calendarField = Calendar.DAY_OF_YEAR;
        } else if ("month".equals(timeRange)) {
            dateFormat = "MM-dd";
            calendarField = Calendar.DAY_OF_YEAR;
        } else {
            dateFormat = "yyyy-MM";
            calendarField = Calendar.MONTH;
        }
        
        // 生成日期序列
        List<Date> dateList = new ArrayList<>();
        SimpleDateFormat sdf = new SimpleDateFormat(dateFormat);
        
        Calendar tempCal = Calendar.getInstance();
        tempCal.setTime(startDate);
        
        while (!tempCal.getTime().after(endDate)) {
            dateList.add(tempCal.getTime());
            tempCal.add(calendarField, 1);
        }
        
        // 格式化日期列表
        List<String> dates = dateList.stream()
                .map(sdf::format)
                .collect(Collectors.toList());
        
        // 按日期分组统计金额和次数
        Map<String, List<DonationRecord>> dateGroups = filteredDonations.stream()
                .collect(Collectors.groupingBy(d -> sdf.format(d.getDonationTime())));
        
        // 构建金额和次数数据
        List<BigDecimal> amounts = new ArrayList<>();
        List<Integer> counts = new ArrayList<>();
        
        for (String date : dates) {
            List<DonationRecord> dayDonations = dateGroups.getOrDefault(date, Collections.emptyList());
            
            // 计算当天的总捐赠金额
            BigDecimal dayAmount = dayDonations.stream()
                    .map(DonationRecord::getDonationAmount)
                    .filter(Objects::nonNull)
                    .reduce(BigDecimal.ZERO, BigDecimal::add);
            
            amounts.add(dayAmount);
            counts.add(dayDonations.size());
        }
        
        stats.setDates(dates);
        stats.setAmounts(amounts);
        stats.setCounts(counts);
        
        return stats;
    }
} 