<template>
  <div class="app-container">
    <!-- 总体统计数据卡片 -->
    <el-row :gutter="20" class="dashboard-statistics">
      <el-col :span="6">
        <el-card class="statistic-card" shadow="hover">
          <div class="statistic-title">
            <i class="el-icon-money"></i>
            <span>总捐赠金额</span>
          </div>
          <div class="statistic-value">{{ formatCurrency(overallData.totalDonation) }}</div>
          <div class="statistic-footer">
            <el-tag>{{ overallData.donationCount }} 笔捐赠</el-tag>
          </div>
        </el-card>
      </el-col>
      <el-col :span="6">
        <el-card class="statistic-card" shadow="hover">
          <div class="statistic-title">
            <i class="el-icon-data-analysis"></i>
            <span>项目总数</span>
          </div>
          <div class="statistic-value">{{ overallData.totalProjects }}</div>
          <div class="statistic-footer">
            <el-tag type="success">{{ overallData.activeProjects }} 个进行中</el-tag>
          </div>
        </el-card>
      </el-col>
      <el-col :span="6">
        <el-card class="statistic-card" shadow="hover">
          <div class="statistic-title">
            <i class="el-icon-user"></i>
            <span>捐赠人数</span>
          </div>
          <div class="statistic-value">{{ overallData.totalDonors }}</div>
          <div class="statistic-footer">
            <el-tag type="warning">月均 {{ overallData.monthlyDonors }} 人</el-tag>
          </div>
        </el-card>
      </el-col>
      <el-col :span="6">
        <el-card class="statistic-card" shadow="hover">
          <div class="statistic-title">
            <i class="el-icon-wallet"></i>
            <span>资金使用率</span>
          </div>
          <div class="statistic-value">{{ overallData.fundUsageRate }}%</div>
          <div class="statistic-footer">
            <el-tag type="info">已使用 {{ formatCurrency(overallData.usedFunds) }}</el-tag>
          </div>
        </el-card>
      </el-col>
    </el-row>

    <!-- 图表区域 -->
    <el-row :gutter="20" class="dashboard-charts">
      <!-- 捐赠趋势图 -->
      <el-col :span="12">
        <el-card class="chart-card" shadow="hover">
          <template #header>
            <div class="card-header">
              <span>捐赠趋势分析</span>
              <div class="chart-actions">
                <el-radio-group v-model="trendTimeRange" size="small" @change="loadDonationTrend">
                  <el-radio-button label="week">最近一周</el-radio-button>
                  <el-radio-button label="month">最近一月</el-radio-button>
                  <el-radio-button label="year">最近一年</el-radio-button>
                </el-radio-group>
              </div>
            </div>
          </template>
          <div class="chart-container" ref="trendChartRef"></div>
        </el-card>
      </el-col>

      <!-- 项目进展状态图 -->
      <el-col :span="12">
        <el-card class="chart-card" shadow="hover">
          <template #header>
            <div class="card-header">
              <span>项目进展状态</span>
              <el-button type="text" @click="loadProjectStatistics">刷新</el-button>
            </div>
          </template>
          <div class="chart-container" ref="projectChartRef"></div>
        </el-card>
      </el-col>
    </el-row>

    <el-row :gutter="20" class="dashboard-charts">
      <!-- 资金使用情况图 -->
      <el-col :span="12">
        <el-card class="chart-card" shadow="hover">
          <template #header>
            <div class="card-header">
              <span>资金使用情况</span>
              <el-button type="text" @click="loadFundUsageStatistics">刷新</el-button>
            </div>
          </template>
          <div class="chart-container" ref="fundChartRef"></div>
        </el-card>
      </el-col>

      <!-- 捐赠来源分布图 -->
      <el-col :span="12">
        <el-card class="chart-card" shadow="hover">
          <template #header>
            <div class="card-header">
              <span>捐赠来源分布</span>
              <el-button type="text" @click="loadDonationStatistics">刷新</el-button>
            </div>
          </template>
          <div class="chart-container" ref="sourceChartRef"></div>
        </el-card>
      </el-col>
    </el-row>
  </div>
</template>

<script setup name="Visualization">
import { ref, onMounted, onUnmounted, reactive } from 'vue';
import * as echarts from 'echarts';
import {
  getDonationStatistics,
  getProjectStatistics,
  getFundUsageStatistics,
  getDonationTrend,
  getOverallStatistics
} from '@/api/charity/statistics';

// 图表引用
const trendChartRef = ref(null);
const projectChartRef = ref(null);
const fundChartRef = ref(null);
const sourceChartRef = ref(null);

// 图表实例
let trendChart = null;
let projectChart = null;
let fundChart = null;
let sourceChart = null;

// 统计数据
const overallData = reactive({
  totalDonation: 0,
  donationCount: 0,
  totalProjects: 0,
  activeProjects: 0,
  totalDonors: 0,
  monthlyDonors: 0,
  fundUsageRate: 0,
  usedFunds: 0
});

// 时间范围选择
const trendTimeRange = ref('month');

// 格式化货币
function formatCurrency(value) {
  if (value === undefined || value === null) return '0.00';
  return parseFloat(value).toLocaleString('zh-CN', {
    minimumFractionDigits: 2,
    maximumFractionDigits: 2
  });
}

// 加载总体统计数据
function loadOverallStatistics() {
  getOverallStatistics().then(response => {
    const data = response.data || {};
    Object.assign(overallData, {
      totalDonation: data.totalDonation || 0,
      donationCount: data.donationCount || 0,
      totalProjects: data.totalProjects || 0,
      activeProjects: data.activeProjects || 0,
      totalDonors: data.totalDonors || 0,
      monthlyDonors: data.monthlyDonors || 0,
      fundUsageRate: data.fundUsageRate || 0,
      usedFunds: data.usedFunds || 0
    });
  });
}

// 初始化图表
function initCharts() {
  // 初始化捐赠趋势图
  trendChart = echarts.init(trendChartRef.value);

  // 初始化项目进展状态图
  projectChart = echarts.init(projectChartRef.value);

  // 初始化资金使用情况图
  fundChart = echarts.init(fundChartRef.value);

  // 初始化捐赠来源分布图
  sourceChart = echarts.init(sourceChartRef.value);

  // 窗口大小改变时，重置图表大小
  window.addEventListener('resize', handleResize);
}

// 加载捐赠趋势数据
function loadDonationTrend() {
  getDonationTrend({ timeRange: trendTimeRange.value }).then(response => {
    const data = response.data || {};
    const xAxis = data.dates || [];
    const amounts = data.amounts || [];
    const counts = data.counts || [];

    // 设置趋势图数据
    trendChart.setOption({
      tooltip: {
        trigger: 'axis',
        axisPointer: {
          type: 'shadow'
        }
      },
      legend: {
        data: ['捐赠金额', '捐赠次数']
      },
      grid: {
        left: '3%',
        right: '4%',
        bottom: '3%',
        containLabel: true
      },
      xAxis: {
        type: 'category',
        data: xAxis
      },
      yAxis: [
        {
          type: 'value',
          name: '捐赠金额',
          axisLabel: {
            formatter: '{value} 元'
          }
        },
        {
          type: 'value',
          name: '捐赠次数',
          axisLabel: {
            formatter: '{value} 次'
          }
        }
      ],
      series: [
        {
          name: '捐赠金额',
          type: 'bar',
          data: amounts
        },
        {
          name: '捐赠次数',
          type: 'line',
          yAxisIndex: 1,
          data: counts
        }
      ]
    });
  });
}

// 加载项目进展状态数据
function loadProjectStatistics() {
  getProjectStatistics().then(response => {
    const data = response.data || {};
    const statusData = data.statusData || [];

    // 设置项目状态图数据
    projectChart.setOption({
      tooltip: {
        trigger: 'item',
        formatter: '{a} <br/>{b}: {c} ({d}%)'
      },
      legend: {
        orient: 'vertical',
        left: 10,
        data: statusData.map(item => item.name)
      },
      series: [
        {
          name: '项目状态',
          type: 'pie',
          radius: ['50%', '70%'],
          avoidLabelOverlap: false,
          label: {
            show: false,
            position: 'center'
          },
          emphasis: {
            label: {
              show: true,
              fontSize: '18',
              fontWeight: 'bold'
            }
          },
          labelLine: {
            show: false
          },
          data: statusData
        }
      ]
    });
  });
}

// 加载资金使用情况数据
function loadFundUsageStatistics() {
  getFundUsageStatistics().then(response => {
    const data = response.data || {};
    const categories = data.categories || [];
    const values = data.values || [];

    // 设置资金使用图数据
    fundChart.setOption({
      tooltip: {
        trigger: 'axis',
        axisPointer: {
          type: 'shadow'
        }
      },
      grid: {
        left: '3%',
        right: '4%',
        bottom: '3%',
        containLabel: true
      },
      xAxis: {
        type: 'value',
        boundaryGap: [0, 0.01]
      },
      yAxis: {
        type: 'category',
        data: categories
      },
      series: [
        {
          name: '资金使用金额',
          type: 'bar',
          data: values
        }
      ]
    });
  });
}

// 加载捐赠来源分布数据
function loadDonationStatistics() {
  getDonationStatistics().then(response => {
    const data = response.data || {};
    const sourceData = data.sourceData || [];

    // 设置捐赠来源图数据
    sourceChart.setOption({
      tooltip: {
        trigger: 'item',
        formatter: '{a} <br/>{b}: {c} ({d}%)'
      },
      legend: {
        orient: 'vertical',
        left: 10,
        data: sourceData.map(item => item.name)
      },
      series: [
        {
          name: '捐赠来源',
          type: 'pie',
          radius: '55%',
          center: ['50%', '60%'],
          data: sourceData,
          emphasis: {
            itemStyle: {
              shadowBlur: 10,
              shadowOffsetX: 0,
              shadowColor: 'rgba(0, 0, 0, 0.5)'
            }
          }
        }
      ]
    });
  });
}

// 处理窗口大小改变
function handleResize() {
  trendChart && trendChart.resize();
  projectChart && projectChart.resize();
  fundChart && fundChart.resize();
  sourceChart && sourceChart.resize();
}

// 组件挂载时的操作
onMounted(() => {
  // 加载总体数据
  loadOverallStatistics();

  // 等待DOM渲染完成后初始化图表
  setTimeout(() => {
    initCharts();

    // 加载各图表数据
    loadDonationTrend();
    loadProjectStatistics();
    loadFundUsageStatistics();
    loadDonationStatistics();
  }, 100);
});

// 组件卸载时的清理操作
onUnmounted(() => {
  // 移除窗口大小改变事件监听
  window.removeEventListener('resize', handleResize);

  // 销毁图表实例
  trendChart && trendChart.dispose();
  projectChart && projectChart.dispose();
  fundChart && fundChart.dispose();
  sourceChart && sourceChart.dispose();
});
</script>

<style scoped>
.dashboard-statistics {
  margin-bottom: 20px;
}

.statistic-card {
  height: 120px;
  position: relative;
  overflow: hidden;
}

.statistic-title {
  font-size: 16px;
  color: #606266;
  margin-bottom: 10px;
  display: flex;
  align-items: center;
}

.statistic-title i {
  margin-right: 5px;
  font-size: 20px;
}

.statistic-value {
  font-size: 28px;
  font-weight: bold;
  color: #303133;
  margin-bottom: 10px;
}

.statistic-footer {
  position: absolute;
  bottom: 20px;
}

.dashboard-charts {
  margin-bottom: 20px;
}

.chart-card {
  margin-bottom: 20px;
}

.chart-container {
  height: 300px;
}

.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.chart-actions {
  display: flex;
  align-items: center;
}
</style>
