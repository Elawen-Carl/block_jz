<template>
  <div class="app-container">
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
    <el-dialog title="区块链交易详情" v-model="detailOpen" width="700px" append-to-body>
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
  </div>
</template>

<script setup name="Blockchain">
import { listBlockchain, getBlockchain } from "@/api/charity/blockchain";

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

getList();
</script>
