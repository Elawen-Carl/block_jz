package com.ruoyi.charity.domain.dto;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

/**
 * 统计数据传输对象
 * 
 * @author ruoyi
 * @date 2025-04-03
 */
public class StatisticsDTO {
    
    /**
     * 总体统计数据
     */
    public static class OverallStatistics {
        /** 总捐赠金额 */
        private BigDecimal totalDonation;
        
        /** 捐赠记录数量 */
        private Integer donationCount;
        
        /** 项目总数 */
        private Integer totalProjects;
        
        /** 进行中的项目数 */
        private Integer activeProjects;
        
        /** 捐赠人数 */
        private Integer totalDonors;
        
        /** 月均捐赠人数 */
        private Integer monthlyDonors;
        
        /** 资金使用率 */
        private BigDecimal fundUsageRate;
        
        /** 已使用资金金额 */
        private BigDecimal usedFunds;

        public BigDecimal getTotalDonation() {
            return totalDonation;
        }

        public void setTotalDonation(BigDecimal totalDonation) {
            this.totalDonation = totalDonation;
        }

        public Integer getDonationCount() {
            return donationCount;
        }

        public void setDonationCount(Integer donationCount) {
            this.donationCount = donationCount;
        }

        public Integer getTotalProjects() {
            return totalProjects;
        }

        public void setTotalProjects(Integer totalProjects) {
            this.totalProjects = totalProjects;
        }

        public Integer getActiveProjects() {
            return activeProjects;
        }

        public void setActiveProjects(Integer activeProjects) {
            this.activeProjects = activeProjects;
        }

        public Integer getTotalDonors() {
            return totalDonors;
        }

        public void setTotalDonors(Integer totalDonors) {
            this.totalDonors = totalDonors;
        }

        public Integer getMonthlyDonors() {
            return monthlyDonors;
        }

        public void setMonthlyDonors(Integer monthlyDonors) {
            this.monthlyDonors = monthlyDonors;
        }

        public BigDecimal getFundUsageRate() {
            return fundUsageRate;
        }

        public void setFundUsageRate(BigDecimal fundUsageRate) {
            this.fundUsageRate = fundUsageRate;
        }

        public BigDecimal getUsedFunds() {
            return usedFunds;
        }

        public void setUsedFunds(BigDecimal usedFunds) {
            this.usedFunds = usedFunds;
        }
    }
    
    /**
     * 捐赠趋势数据
     */
    public static class DonationTrend {
        /** 日期列表 */
        private List<String> dates;
        
        /** 捐赠金额列表 */
        private List<BigDecimal> amounts;
        
        /** 捐赠次数列表 */
        private List<Integer> counts;

        public List<String> getDates() {
            return dates;
        }

        public void setDates(List<String> dates) {
            this.dates = dates;
        }

        public List<BigDecimal> getAmounts() {
            return amounts;
        }

        public void setAmounts(List<BigDecimal> amounts) {
            this.amounts = amounts;
        }

        public List<Integer> getCounts() {
            return counts;
        }

        public void setCounts(List<Integer> counts) {
            this.counts = counts;
        }
    }
    
    /**
     * 项目状态统计数据
     */
    public static class ProjectStatistics {
        /** 项目状态数据，包含name和value */
        private List<Map<String, Object>> statusData;

        public List<Map<String, Object>> getStatusData() {
            return statusData;
        }

        public void setStatusData(List<Map<String, Object>> statusData) {
            this.statusData = statusData;
        }
    }
    
    /**
     * 资金使用情况统计
     */
    public static class FundUsageStatistics {
        /** 资金使用类别 */
        private List<String> categories;
        
        /** 各类别使用金额 */
        private List<BigDecimal> values;

        public List<String> getCategories() {
            return categories;
        }

        public void setCategories(List<String> categories) {
            this.categories = categories;
        }

        public List<BigDecimal> getValues() {
            return values;
        }

        public void setValues(List<BigDecimal> values) {
            this.values = values;
        }
    }
    
    /**
     * 捐赠来源分布数据
     */
    public static class DonationSourceStatistics {
        /** 来源数据，包含name和value */
        private List<Map<String, Object>> sourceData;

        public List<Map<String, Object>> getSourceData() {
            return sourceData;
        }

        public void setSourceData(List<Map<String, Object>> sourceData) {
            this.sourceData = sourceData;
        }
    }
}