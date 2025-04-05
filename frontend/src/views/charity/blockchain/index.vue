<template>
  <div class="app-container">
    <!-- 区块链统计信息卡片 -->
    <el-row :gutter="20" class="mb8">
      <el-col :span="6">
        <el-card shadow="hover" class="stat-card">
          <template #header>
            <div class="card-header">
              <span><el-icon>
                  <Histogram />
                </el-icon> 区块高度</span>
            </div>
          </template>
          <div class="card-body">
            <el-statistic :value="blockchainStats.totalBlocks || 0">
              <template #suffix>
                <span class="text-sm text-gray">区块</span>
              </template>
            </el-statistic>
          </div>
        </el-card>
      </el-col>
      <el-col :span="6">
        <el-card shadow="hover" class="stat-card">
          <template #header>
            <div class="card-header">
              <span><el-icon>
                  <Document />
                </el-icon> 交易总数</span>
            </div>
          </template>
          <div class="card-body">
            <el-statistic :value="blockchainStats.totalTransactions || 0">
              <template #suffix>
                <span class="text-sm text-gray">笔</span>
              </template>
            </el-statistic>
          </div>
        </el-card>
      </el-col>
      <el-col :span="6">
        <el-card shadow="hover" class="stat-card">
          <template #header>
            <div class="card-header">
              <span><el-icon>
                  <Share />
                </el-icon> 节点总数</span>
            </div>
          </template>
          <div class="card-body">
            <el-statistic :value="blockchainStats.onlineNodes || 0">
              <template #suffix>
                <span class="text-sm text-gray">个</span>
              </template>
            </el-statistic>
          </div>
        </el-card>
      </el-col>
      <el-col :span="6">
        <el-card shadow="hover" class="stat-card">
          <template #header>
            <div class="card-header">
              <span><el-icon>
                  <Clock />
                </el-icon> TPS</span>
            </div>
          </template>
          <div class="card-body">
            <el-statistic :value="blockchainStats.transactionsPerSecond || 0" :precision="2">
              <template #suffix>
                <span class="text-sm text-gray">笔/秒</span>
              </template>
            </el-statistic>
          </div>
        </el-card>
      </el-col>
    </el-row>

    <!-- 最新区块信息卡片 -->
    <el-card class="mb8" v-loading="blockLoading">
      <template #header>
        <div class="card-header">
          <span><el-icon>
              <Monitor />
            </el-icon> 最新区块</span>
          <el-button type="primary" size="small" plain @click="refreshLatestBlocks">刷新</el-button>
        </div>
      </template>
      <el-table :data="latestBlocks" stripe style="width: 100%">
        <el-table-column prop="height" label="区块号" width="100" align="center" />
        <el-table-column prop="dataHash" label="区块哈希" min-width="220">
          <template #default="scope">
            <el-tooltip :content="scope.row.dataHash" placement="top" effect="light">
              <span>{{ truncateHash(scope.row.dataHash) }}</span>
            </el-tooltip>
            <el-button link type="primary" size="small" @click="copyText(scope.row.dataHash)">复制</el-button>
          </template>
        </el-table-column>
        <el-table-column prop="txCount" label="交易数" width="100" align="center" />
        <el-table-column prop="timestamp" label="创建时间" width="180" align="center">
          <template #default="scope">
            {{ scope.row.timestamp }}
          </template>
        </el-table-column>
        <el-table-column label="操作" width="120" align="center">
          <template #default="scope">
            <el-button link type="primary" @click="viewBlockDetail(scope.row.height)">查看详情</el-button>
          </template>
        </el-table-column>
      </el-table>
    </el-card>

    <el-form :model="queryParams" ref="queryRef" :inline="true" v-show="showSearch" label-width="96px">
      <el-form-item label="交易编号" prop="txId">
        <el-input v-model="queryParams.txId" placeholder="请输入交易编号" clearable @keyup.enter="handleQuery" />
      </el-form-item>
      <el-form-item label="关联业务类型" prop="relatedType" style="width: 308px">
        <el-select v-model="queryParams.relatedType" placeholder="请选择关联业务类型" clearable>
          <el-option v-for="dict in blockchain_related_type" :key="dict.value" :label="dict.label"
            :value="dict.value" />
        </el-select>
      </el-form-item>
      <el-form-item label="交易时间" style="width: 308px">
        <el-date-picker v-model="daterangeTxTime" value-format="YYYY-MM-DD" type="daterange" range-separator="-"
          start-placeholder="开始日期" end-placeholder="结束日期"></el-date-picker>
      </el-form-item>
      <el-form-item label="交易状态" prop="txStatus" style="width: 308px">
        <el-select v-model="queryParams.txStatus" placeholder="请选择交易状态" clearable>
          <el-option v-for="dict in blockchain_tx_status" :key="dict.value" :label="dict.label" :value="dict.value" />
        </el-select>
      </el-form-item>
      <el-form-item label="创建时间" style="width: 308px">
        <el-date-picker v-model="daterangeCreateTime" value-format="YYYY-MM-DD" type="daterange" range-separator="-"
          start-placeholder="开始日期" end-placeholder="结束日期"></el-date-picker>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="Search" @click="handleQuery">搜索</el-button>
        <el-button icon="Refresh" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button type="warning" plain icon="Download" @click="handleExport"
          v-hasPermi="['charity:blockchain:export']">导出</el-button>
      </el-col>
      <right-toolbar v-model="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="blockchainList">
      <el-table-column label="交易编号" align="center" prop="txId" />
      <el-table-column label="关联业务编号" align="center" prop="relatedId" />
      <el-table-column label="关联业务类型" align="center" prop="relatedType">
        <template #default="scope">
          <dict-tag :options="blockchain_related_type" :value="scope.row.relatedType" />
        </template>
      </el-table-column>
      <el-table-column label="交易时间" align="center" prop="txTime" width="180">
        <template #default="scope">
          <span>{{ parseTime(scope.row.txTime, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="交易状态" align="center" prop="txStatus">
        <template #default="scope">
          <dict-tag :options="blockchain_tx_status" :value="scope.row.txStatus" />
        </template>
      </el-table-column>
      <el-table-column label="创建时间" align="center" prop="createTime" width="180">
        <template #default="scope">
          <span>{{ parseTime(scope.row.createTime, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template #default="scope">
          <el-button link type="primary" icon="View" @click="handleViewDetail(scope.row)">查看详情</el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination v-show="total > 0" :total="total" v-model="queryParams.pageNum" :pageSize="queryParams.pageSize"
      @pagination="getList" />

    <!-- 查看区块链交易详细信息对话框 -->
    <el-dialog title="区块链交易详情" v-model="detailOpen" width="1000px" append-to-body>
      <el-descriptions :column="2" border>
        <el-descriptions-item label="交易编号">{{ detail.txId }}</el-descriptions-item>
        <el-descriptions-item label="关联业务">
          <span>{{ detail.relatedId }}</span>
          <el-tag class="ml-2" type="success">
            <dict-tag :options="blockchain_related_type" :value="detail.relatedType" />
          </el-tag>
        </el-descriptions-item>
        <el-descriptions-item label="交易时间">{{ parseTime(detail.txTime, '{y}-{m}-{d} {h}:{i}:{s}')
        }}</el-descriptions-item>
        <el-descriptions-item label="交易状态">
          <dict-tag :options="blockchain_tx_status" :value="detail.txStatus" />
        </el-descriptions-item>
        <el-descriptions-item label="区块链哈希" :span="2">
          <el-input :value="detail.txHash" readonly>
            <template #append>
              <el-button @click="copyText(detail.txHash)">复制</el-button>
            </template>
          </el-input>
        </el-descriptions-item>
        <el-descriptions-item label="交易数据" :span="2">
          <el-input type="textarea" :value="formatJson(detail.txData)" rows="10" readonly></el-input>
        </el-descriptions-item>
      </el-descriptions>
      <template #footer>
        <div class="dialog-footer">
          <el-button @click="detailOpen = false">关闭</el-button>
          <el-button type="primary" @click="viewOnExplorer(detail.txHash)" v-if="detail.txHash">在区块链浏览器中查看</el-button>
        </div>
      </template>
    </el-dialog>

    <!-- 区块详情对话框 -->
    <el-dialog title="区块详情" v-model="blockDetailOpen" width="1000px" append-to-body>
      <el-skeleton :rows="10" animated v-if="!blockDetail.dataHash" />
      <template v-else>
        <el-descriptions :column="2" border>
          <el-descriptions-item label="区块号">{{ blockDetail.height }}</el-descriptions-item>
          <el-descriptions-item label="交易数量">{{ blockDetail.txCount }}</el-descriptions-item>
          <el-descriptions-item label="区块大小">{{ blockDetail.size }} KB</el-descriptions-item>
          <el-descriptions-item label="创建时间">{{ blockDetail.timestamp }}</el-descriptions-item>
          <el-descriptions-item label="数据哈希" :span="2">
            <el-input :value="blockDetail.dataHash" readonly>
              <template #append>
                <el-button @click="copyText(blockDetail.dataHash)">复制</el-button>
              </template>
            </el-input>
          </el-descriptions-item>
          <el-descriptions-item label="前块哈希" :span="2">
            <el-input :value="blockDetail.previousHash" readonly>
              <template #append>
                <el-button @click="copyText(blockDetail.previousHash)">复制</el-button>
              </template>
            </el-input>
          </el-descriptions-item>
        </el-descriptions>

        <!-- 区块中的交易列表 -->
        <div class="mt20" v-if="blockDetail.transactions && blockDetail.transactions.length > 0">
          <div class="sub-title">区块内交易 ({{ blockDetail.transactions ? blockDetail.transactions.length : 0 }})</div>
          <el-table :data="blockDetail.transactions || []" stripe style="width: 100%">
            <el-table-column prop="txId" label="交易ID" min-width="220">
              <template #default="scope">
                <el-tooltip :content="scope.row.txId" placement="top" effect="light">
                  <span>{{ truncateHash(scope.row.txId) }}</span>
                </el-tooltip>
                <el-button link type="primary" size="small" @click="copyText(scope.row.txId)">复制</el-button>
              </template>
            </el-table-column>
            <el-table-column prop="timestamp" label="时间" width="180">
              <template #default="scope">
                {{ scope.row.timestamp }}
              </template>
            </el-table-column>
            <el-table-column prop="type" label="类型" width="120"></el-table-column>
            <el-table-column label="操作" width="120" align="center">
              <template #default="scope">
                <el-button link type="primary" @click="viewTransactionDetail(scope.row.txId)">查看详情</el-button>
              </template>
            </el-table-column>
          </el-table>
        </div>
        <div class="mt20" v-else>
          <el-empty description="暂无交易详情数据" />
          <div class="text-center mt20">
            <el-button type="primary" @click="loadBlockTransactions(blockDetail.height)">加载交易数据</el-button>
          </div>
        </div>
      </template>
      <template #footer>
        <div class="dialog-footer">
          <el-button @click="blockDetailOpen = false">关闭</el-button>
          <el-button type="primary" @click="viewPreviousBlock(blockDetail.height - 1)"
            :disabled="blockDetail.height <= 1">查看前一区块</el-button>
        </div>
      </template>
    </el-dialog>
  </div>
</template>

<script setup name="Blockchain">
import { listBlockchain, getBlockchain } from "@/api/charity/blockchain";
import { getBlockchainStats, getLatestBlocks, getBlockDetail, getTransactionDetail } from "@/api/charity/blockchainData";
import { Histogram, Document, Share, Clock, Monitor } from '@element-plus/icons-vue';

const { proxy } = getCurrentInstance();
const { blockchain_related_type, blockchain_tx_status } = proxy.useDict('blockchain_related_type', 'blockchain_tx_status');

const blockchainList = ref([]);
const detailOpen = ref(false);
const loading = ref(true);
const showSearch = ref(true);
const total = ref(0);
const daterangeTxTime = ref([]);
const daterangeCreateTime = ref([]);
const detail = ref({});

// 区块链统计和最新区块数据
const blockchainStats = ref({});
const latestBlocks = ref([]);
const blockLoading = ref(false);
const blockDetailOpen = ref(false);
const blockDetail = ref({});

const data = reactive({
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    txId: null,
    relatedId: null,
    relatedType: null,
    txTime: null,
    txStatus: null,
    createTime: null
  }
});

const { queryParams } = toRefs(data);

/** 查询区块链交易记录列表 */
function getList() {
  loading.value = true;
  queryParams.value.params = {};
  if (null != daterangeTxTime && '' != daterangeTxTime) {
    queryParams.value.params["beginTxTime"] = daterangeTxTime.value[0];
    queryParams.value.params["endTxTime"] = daterangeTxTime.value[1];
  }
  if (null != daterangeCreateTime && '' != daterangeCreateTime) {
    queryParams.value.params["beginCreateTime"] = daterangeCreateTime.value[0];
    queryParams.value.params["endCreateTime"] = daterangeCreateTime.value[1];
  }
  listBlockchain(queryParams.value).then(response => {
    blockchainList.value = response.rows;
    total.value = response.total;
    loading.value = false;
  });
}

/** 获取区块链统计信息 */
function getStats() {
  getBlockchainStats().then(response => {
    if (response.code === 200) {
      blockchainStats.value = response.data;
    } else {
      proxy.$modal.msgError(response.msg || "获取区块链统计信息失败");
    }
  }).catch(() => {
    proxy.$modal.msgError("获取区块链统计信息失败");
  });
}

/** 获取最新区块 */
function refreshLatestBlocks() {
  blockLoading.value = true;
  getLatestBlocks(5).then(response => {
    if (response.code === 200) {
      latestBlocks.value = response.data;
    } else {
      proxy.$modal.msgError(response.msg || "获取最新区块信息失败");
    }
    blockLoading.value = false;
  }).catch(() => {
    proxy.$modal.msgError("获取最新区块信息失败");
    blockLoading.value = false;
  });
}

/** 查看区块详情 */
function viewBlockDetail(blockNumber) {
  blockLoading.value = true;
  getBlockDetail(blockNumber).then(response => {
    if (response.code === 200) {
      blockDetail.value = response.data;
      blockDetailOpen.value = true;
    } else {
      proxy.$modal.msgError(response.msg || "获取区块详情失败");
    }
    blockLoading.value = false;
  }).catch((error) => {
    console.error("获取区块详情失败:", error);
    proxy.$modal.msgError("获取区块详情失败: " + (error.message || error));
    blockLoading.value = false;
  });
}

/** 查看交易详情 */
function viewTransactionDetail(txId) {
  getTransactionDetail(txId).then(response => {
    if (response.code === 200) {
      // 可以选择在新窗口打开，或者在当前页显示
      detail.value = {
        txId: response.data.txId,
        txTime: response.data.timestamp,
        txStatus: "1", // 假设交易已确认
        txHash: response.data.txId,
        txData: JSON.stringify(response.data)
      };
      detailOpen.value = true;
    } else {
      proxy.$modal.msgError(response.msg || "获取交易详情失败");
    }
  }).catch(() => {
    proxy.$modal.msgError("获取交易详情失败");
  });
}

/** 截断哈希值显示 */
function truncateHash(hash) {
  if (!hash) return '';
  return hash.length > 16 ? hash.substring(0, 8) + '...' + hash.substring(hash.length - 8) : hash;
}

/** 搜索按钮操作 */
function handleQuery() {
  queryParams.value.pageNum = 1;
  getList();
}

/** 重置按钮操作 */
function resetQuery() {
  daterangeTxTime.value = [];
  daterangeCreateTime.value = [];
  proxy.resetForm("queryRef");
  handleQuery();
}

/** 导出按钮操作 */
function handleExport() {
  proxy.download('charity/blockchain/export', {
    ...queryParams.value
  }, `blockchain_${new Date().getTime()}.xlsx`)
}

/** 查看详情按钮操作 */
function handleViewDetail(row) {
  // 获取详细信息
  getBlockchain(row.txId).then(response => {
    detail.value = response.data;
    detailOpen.value = true;
  });
}

/** 复制文本到剪贴板 */
function copyText(text) {
  if (navigator.clipboard) {
    navigator.clipboard.writeText(text).then(() => {
      proxy.$modal.msgSuccess("复制成功");
    }).catch(() => {
      proxy.$modal.msgError("复制失败");
    });
  } else {
    // 兼容不支持clipboard API的浏览器
    const textarea = document.createElement('textarea');
    textarea.value = text;
    document.body.appendChild(textarea);
    textarea.select();
    try {
      document.execCommand('copy');
      proxy.$modal.msgSuccess("复制成功");
    } catch (err) {
      proxy.$modal.msgError("复制失败");
    }
    document.body.removeChild(textarea);
  }
}

/** 在区块链浏览器中查看交易 */
function viewOnExplorer(txHash) {
  // 这里可以根据不同的区块链类型使用不同的浏览器URL
  // 这里以以太坊为例
  const explorerUrl = `https://etherscan.io/tx/${txHash}`;
  window.open(explorerUrl, '_blank');
}

/** 格式化JSON字符串 */
function formatJson(jsonStr) {
  try {
    if (typeof jsonStr === 'string') {
      const obj = JSON.parse(jsonStr);
      return JSON.stringify(obj, null, 2);
    } else if (typeof jsonStr === 'object') {
      return JSON.stringify(jsonStr, null, 2);
    }
    return jsonStr;
  } catch (e) {
    return jsonStr;
  }
}

/** 加载区块交易数据 */
function loadBlockTransactions(blockNumber) {
  blockLoading.value = true;
  getBlockDetail(blockNumber).then(response => {
    if (response.code === 200) {
      blockDetail.value = response.data;
    } else {
      proxy.$modal.msgError(response.msg || "获取区块交易详情失败");
    }
    blockLoading.value = false;
  }).catch((error) => {
    console.error("获取区块交易详情失败:", error);
    proxy.$modal.msgError("获取区块交易详情失败: " + (error.message || error));
    blockLoading.value = false;
  });
}

/** 查看前一区块 */
function viewPreviousBlock(previousBlockNumber) {
  if (previousBlockNumber > 0) {
    viewBlockDetail(previousBlockNumber);
  }
}

// 初始化
getList();
getStats();
refreshLatestBlocks();
</script>

<style scoped>
.stat-card {
  height: 120px;
  text-align: center;
}

.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.card-body {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 60px;
}

/* 美化统计数字 */
:deep(.el-statistic__number) {
  font-size: 28px;
  font-weight: bold;
  color: #409EFF;
}

:deep(.el-statistic__content) {
  justify-content: center;
}

.text-sm {
  font-size: 14px;
}

.text-gray {
  color: #909399;
}

.mb8 {
  margin-bottom: 8px;
}

.mt20 {
  margin-top: 20px;
}

.text-center {
  text-align: center;
}

.sub-title {
  font-size: 16px;
  font-weight: bold;
  margin-bottom: 10px;
  color: #606266;
}
</style>
