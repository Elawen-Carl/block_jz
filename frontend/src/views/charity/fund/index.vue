<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryRef" :inline="true" v-show="showSearch" label-width="96px">
      <el-form-item label="项目名称" prop="projectName">
        <el-input v-model="queryParams.projectName" placeholder="请输入项目名称" clearable @keyup.enter="handleQuery" />
      </el-form-item>
      <el-form-item label="使用金额" prop="amount">
        <el-input v-model="queryParams.amount" placeholder="请输入使用金额" clearable @keyup.enter="handleQuery" />
      </el-form-item>
      <el-form-item label="申请状态" prop="applicationStatus" style="width: 304px">
        <el-select v-model="queryParams.applicationStatus" placeholder="请选择申请状态" clearable>
          <el-option v-for="dict in fund_application_status" :key="dict.value" :label="dict.label"
            :value="dict.value" />
        </el-select>
      </el-form-item>
      <el-form-item label="使用时间" style="width: 308px">
        <el-date-picker v-model="daterangeUsageTime" value-format="YYYY-MM-DD" type="daterange" range-separator="-"
          start-placeholder="开始日期" end-placeholder="结束日期"></el-date-picker>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="Search" @click="handleQuery">搜索</el-button>
        <el-button icon="Refresh" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button type="primary" plain icon="Plus" @click="handleAdd"
          v-hasPermi="['charity:fund:add']">申请资金使用</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="success" plain icon="Edit" :disabled="single" @click="handleUpdate"
          v-hasPermi="['charity:fund:edit']">修改</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="danger" plain icon="Delete" :disabled="multiple" @click="handleDelete"
          v-hasPermi="['charity:fund:remove']">删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="warning" plain icon="Download" @click="handleExport"
          v-hasPermi="['charity:fund:export']">导出</el-button>
      </el-col>
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="fundList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="编号" align="center" prop="usageId" width="100" />
      <el-table-column label="项目名称" align="center" prop="projectName" min-width="150" />
      <el-table-column label="使用金额" align="center" prop="amount" width="120">
        <template #default="scope">
          <span>{{ scope.row.amount }}元</span>
        </template>
      </el-table-column>
      <el-table-column label="使用时间" align="center" prop="usageTime" width="110">
        <template #default="scope">
          <span>{{ parseTime(scope.row.usageTime, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="申请状态" align="center" prop="applicationStatus" width="100">
        <template #default="scope">
          <dict-tag :options="fund_application_status" :value="scope.row.applicationStatus" />
        </template>
      </el-table-column>
      <el-table-column label="使用描述" align="center" prop="usageDesc" min-width="150" show-overflow-tooltip />
      <el-table-column label="区块链记录" align="center" prop="transactionHash" width="120">
        <template #default="scope">
          <el-button v-if="scope.row.transactionHash" size="small" type="primary" link
            @click="viewBlockchainInfo(scope.row.transactionHash)">查看</el-button>
          <span v-else>未上链</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template #default="scope">
          <el-button link type="primary" icon="View" @click="handleView(scope.row)">查看</el-button>
          <el-button link type="primary" icon="Edit" @click="handleUpdate(scope.row)" v-hasPermi="['charity:fund:edit']"
            v-if="scope.row.applicationStatus != '2' && !scope.row.transactionHash">修改</el-button>
          <el-button link type="primary" icon="Delete" @click="handleDelete(scope.row)"
            v-hasPermi="['charity:fund:remove']"
            v-if="scope.row.applicationStatus != '2' && !scope.row.transactionHash">删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination v-show="total > 0" :total="total" v-model:page="queryParams.pageNum"
      v-model:limit="queryParams.pageSize" @pagination="getList" />

    <el-dialog :title="title" v-model="open" width="1000px" append-to-body>
      <el-form ref="fundRef" :model="form" :rules="rules" label-width="100px">
        <el-form-item label="项目" prop="projectId">
          <el-select v-model="form.projectId" placeholder="请选择项目" filterable @change="handleProjectChange">
            <el-option v-for="item in projectOptions" :key="item.projectId" :label="item.projectName"
              :value="item.projectId"></el-option>
          </el-select>
        </el-form-item>

        <el-form-item v-if="selectedProject.projectName" label="项目信息">
          <el-descriptions :column="1" border size="small">
            <el-descriptions-item label="项目名称">{{ selectedProject.projectName }}</el-descriptions-item>
            <el-descriptions-item label="目标金额">{{ selectedProject.targetAmount }}元</el-descriptions-item>
            <el-descriptions-item label="已筹金额">{{ selectedProject.currentAmount }}元</el-descriptions-item>
            <el-descriptions-item label="可用资金">{{ availableFunds }}元</el-descriptions-item>
          </el-descriptions>
        </el-form-item>

        <el-form-item label="使用金额" prop="amount">
          <el-input-number v-model="form.amount" :precision="2" :min="0.01" :max="Math.max(availableFunds, 0.01)"
            :step="100" controls-position="right" style="width: 200px;"
            :disabled="availableFunds <= 0.01 && !form.usageId" />
          <span class="ml-2">元</span>
          <el-text v-if="!form.usageId && availableFunds > 0" type="info" class="ml-2">最多可使用 {{ availableFunds }}
            元</el-text>
          <el-text v-else-if="!form.usageId" type="warning" class="ml-2">当前项目没有可用资金</el-text>
        </el-form-item>

        <el-form-item label="使用类别" prop="usageCategory">
          <el-select v-model="form.usageCategory" placeholder="请选择使用类别">
            <el-option label="救助支出" value="救助支出"></el-option>
            <el-option label="医疗支出" value="医疗支出"></el-option>
            <el-option label="教育支出" value="教育支出"></el-option>
            <el-option label="行政开支" value="行政开支"></el-option>
            <el-option label="其他支出" value="其他支出"></el-option>
          </el-select>
        </el-form-item>

        <el-form-item label="使用描述" prop="usageDesc">
          <el-input v-model="form.usageDesc" type="textarea" placeholder="请详细描述资金使用情况，包括用途、预期效果等" :rows="3" />
        </el-form-item>

        <el-form-item label="使用时间" prop="usageTime">
          <el-date-picker clearable v-model="form.usageTime" type="date" value-format="YYYY-MM-DD"
            placeholder="请选择使用时间"></el-date-picker>
        </el-form-item>

        <el-form-item label="证明材料" prop="proofUrl">
          <file-upload v-model="form.proofUrl" :multiple="false" :tip="'支持上传证明材料：预算表、采购清单、合同等文件'" />
          <div class="tip-text">请上传相关的资金使用计划、预算表、采购清单、合同等证明材料</div>
        </el-form-item>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" @click="submitForm(false)" :loading="submitLoading">保 存</el-button>
          <el-button type="success" @click="submitForm(true)" :loading="submitLoading">保存并提交</el-button>
          <el-button @click="cancel">取 消</el-button>
        </div>
      </template>
    </el-dialog>

    <!-- 查看资金使用详情对话框 -->
    <el-dialog title="资金使用详情" v-model="openView" width="700px" append-to-body>
      <el-descriptions :column="2" border>
        <el-descriptions-item label="使用记录编号">{{ form.usageId }}</el-descriptions-item>
        <el-descriptions-item label="项目名称">{{ form.projectName }}</el-descriptions-item>
        <el-descriptions-item label="使用金额">{{ form.amount }}元</el-descriptions-item>
        <el-descriptions-item label="使用时间">{{ parseTime(form.usageTime, '{y}-{m}-{d}') }}</el-descriptions-item>
        <el-descriptions-item label="申请状态">
          <dict-tag :options="fund_application_status" :value="form.applicationStatus" />
        </el-descriptions-item>
        <el-descriptions-item label="申请人">{{ form.createBy }}</el-descriptions-item>
        <el-descriptions-item label="使用描述" :span="2">{{ form.usageDesc }}</el-descriptions-item>
        <el-descriptions-item label="证明材料" :span="2">
          <div v-if="form.proofUrl">
            <el-link type="primary" :href="getFileUrl(form.proofUrl)" target="_blank">
              <el-button type="primary" size="small" icon="Download">下载证明材料</el-button>
            </el-link>
          </div>
          <span v-else>未上传证明材料</span>
        </el-descriptions-item>
        <template v-if="form.applicationStatus === '2'">
          <el-descriptions-item label="审核人">{{ form.auditor }}</el-descriptions-item>
          <el-descriptions-item label="审核时间">{{ parseTime(form.auditTime, '{y}-{m}-{d} {h}:{i}:{s}')
            }}</el-descriptions-item>
          <el-descriptions-item label="审核备注" :span="2" v-if="form.auditRemark">{{ form.auditRemark
            }}</el-descriptions-item>
        </template>
        <el-descriptions-item label="区块链信息" :span="2" v-if="form.transactionHash">
          <div>
            <div>交易哈希: {{ form.transactionHash }}</div>
            <el-button size="small" type="primary" @click="copyText(form.transactionHash)">复制哈希</el-button>
          </div>
        </el-descriptions-item>
        <el-descriptions-item label="创建时间">{{ parseTime(form.createTime, '{y}-{m}-{d} {h}:{i}:{s}')
          }}</el-descriptions-item>
      </el-descriptions>
      <template #footer>
        <div class="dialog-footer">
          <el-button @click="openView = false">关闭</el-button>
        </div>
      </template>
    </el-dialog>

  </div>
</template>

<script setup name="Fund">
import { listFund, getFund, delFund, addFund, updateFund, auditFund } from "@/api/charity/fund";
import { listProject, getProject } from "@/api/charity/project";
import { isExternal } from "@/utils/validate";
import useUserStore from '@/store/modules/user';

const { proxy } = getCurrentInstance();
const fundList = ref([]);
const open = ref(false);
const openView = ref(false);
const loading = ref(true);
const showSearch = ref(true);
const ids = ref([]);
const single = ref(true);
const multiple = ref(true);
const total = ref(0);
const title = ref("");
const daterangeUsageTime = ref([]);
const projectOptions = ref([]);
const baseUrl = import.meta.env.VITE_APP_BASE_API;
const userStore = useUserStore();
const submitLoading = ref(false);
const selectedProject = ref({});

const { fund_application_status } = proxy.useDict('fund_application_status');


const data = reactive({
  form: {},
  queryParams: {
    orderByColumn: 'createTime',
    isAsc: 'desc',
    pageNum: 1,
    pageSize: 10,
    projectId: null,
    projectName: null,
    amount: null,
    usageDesc: null,
    usageTime: null,
    applicationStatus: null
  },
  rules: {
    projectId: [
      { required: true, message: "项目不能为空", trigger: "change" }
    ],
    amount: [
      { required: true, message: "使用金额不能为空", trigger: "blur" }
    ],
    usageDesc: [
      { required: true, message: "使用描述不能为空", trigger: "blur" }
    ],
    usageTime: [
      { required: true, message: "使用时间不能为空", trigger: "blur" }
    ],

  }
});

const { queryParams, form, rules } = toRefs(data);

function getProjectList() {
  listProject({
    pageNum: 1,
    pageSize: 999,
    status: "1",
    auditStatus: "0",
    initiatorId: form.value.usageId ? null : userStore.userId
  }).then(response => {
    projectOptions.value = response.rows;
  });
}

function getList() {
  loading.value = true;
  queryParams.value.params = {};
  if (daterangeUsageTime.value != null && daterangeUsageTime.value.length > 0) {
    queryParams.value.params["beginUsageTime"] = daterangeUsageTime.value[0];
    queryParams.value.params["endUsageTime"] = daterangeUsageTime.value[1];
  }
  listFund(queryParams.value).then(response => {
    fundList.value = response.rows;
    total.value = response.total;
    loading.value = false;
  });
}

/** 取消按钮 */
function cancel() {
  open.value = false;
  reset();
}

/** 表单重置 */
function reset() {
  form.value = {
    usageId: null,
    projectId: null,
    amount: 0,
    usageCategory: '',
    usageDesc: null,
    usageTime: null,
    proofUrl: null,
    transactionHash: null,
    applicationStatus: '0'  // 默认为草稿状态，用户可以选择保存或提交
  };
  selectedProject.value = {};
  proxy.resetForm("fundRef");
}

/** 搜索按钮操作 */
function handleQuery() {
  queryParams.value.pageNum = 1;
  getList();
}

/** 重置按钮操作 */
function resetQuery() {
  daterangeUsageTime.value = [];
  proxy.resetForm("queryRef");
  handleQuery();
}

/** 多选框选中数据 */
function handleSelectionChange(selection) {
  ids.value = selection.map(item => item.usageId);
  single.value = selection.length != 1;
  multiple.value = !selection.length;
}

/** 获取文件URL */
function getFileUrl(url) {
  if (!url) return '';
  if (isExternal(url) || url.indexOf(baseUrl) !== -1) {
    return url;
  }
  return baseUrl + url;
}

/** 新增按钮操作 */
function handleAdd() {
  reset();
  getProjectList();
  open.value = true;
  title.value = "申请资金使用";
}

/** 修改按钮操作 */
function handleUpdate(row) {
  reset();
  const usageId = row.usageId || ids.value;
  getFund(usageId).then(response => {
    form.value = response.data;
    getProjectList();
    if (form.value.usageDesc && form.value.usageDesc.startsWith('【') && form.value.usageDesc.indexOf('】') > 0) {
      const categoryEndIndex = form.value.usageDesc.indexOf('】');
      form.value.usageCategory = form.value.usageDesc.substring(1, categoryEndIndex);
      form.value.usageDesc = form.value.usageDesc.substring(categoryEndIndex + 1);
    }
    open.value = true;
    title.value = "修改资金使用记录";
  });
}

/** 查看按钮操作 */
function handleView(row) {
  getFund(row.usageId).then(response => {
    form.value = response.data;
    openView.value = true;
  });
}

function submitForm(isSubmit) {
  proxy.$refs["fundRef"].validate(valid => {
    if (!valid) return;

    if (!form.value.usageId && availableFunds.value <= 0.01) {
      proxy.$modal.msgError("当前项目没有足够的可用资金，无法申请");
      return;
    }

    if (!form.value.usageId && form.value.amount > availableFunds.value) {
      proxy.$modal.msgError(`使用金额不能超过可用资金 ${availableFunds.value} 元`);
      return;
    }

    submitLoading.value = true;

    // 设置申请状态：0-草稿，1-提交审核
    form.value.applicationStatus = isSubmit ? "1" : "0";

    const finalDesc = form.value.usageCategory ?
      `【${form.value.usageCategory}】${form.value.usageDesc}` :
      form.value.usageDesc;

    const submitData = {
      ...form.value,
      usageDesc: finalDesc
    };

    if (form.value.usageId != null) {
      updateFund(submitData).then(response => {
        submitLoading.value = false;
        proxy.$modal.msgSuccess(isSubmit ? "修改并提交审核成功" : "修改成功");
        open.value = false;
        getList();
      }).catch(() => {
        submitLoading.value = false;
      });
    } else {
      addFund(submitData).then(response => {
        submitLoading.value = false;
        proxy.$modal.msgSuccess(isSubmit ? "提交审核成功" : "保存草稿成功");
        open.value = false;
        getList();
      }).catch(() => {
        submitLoading.value = false;
      });
    }
  });
}

/** 删除按钮操作 */
function handleDelete(row) {
  const usageIds = row.usageId || ids.value;
  proxy.$modal.confirm('是否确认删除资金使用记录编号为"' + usageIds + '"的数据项？').then(function () {
    return delFund(usageIds);
  }).then(() => {
    getList();
    proxy.$modal.msgSuccess("删除成功");
  }).catch(() => { });
}

/** 导出按钮操作 */
function handleExport() {
  proxy.download('charity/fund/export', {
    ...queryParams.value
  }, `fund_${new Date().getTime()}.xlsx`);
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

/** 查看区块链信息 */
function viewBlockchainInfo(hash) {
  // 这里可以跳转到区块链浏览器或显示区块链信息
  proxy.$modal.msgSuccess(`区块链交易哈希: ${hash}`);
  // 实际项目中可能会跳转到区块链浏览器
  // window.open(`https://example-blockchain-explorer.com/tx/${hash}`, '_blank');
}

/** 处理项目选择变化 */
function handleProjectChange(projectId) {
  if (!projectId) {
    selectedProject.value = {};
    form.value.amount = 0;
    return;
  }

  // 获取项目详情
  getProject(projectId).then(response => {
    selectedProject.value = response.data;

    if (availableFunds.value > 0.01) {
      form.value.amount = Math.min(10000, Math.floor(availableFunds.value / 2));
    } else {
      form.value.amount = 0;
      proxy.$modal.msgWarning("当前项目没有足够的可用资金");
    }
  });
}

// 计算可用资金
const availableFunds = computed(() => {
  if (!selectedProject.value || !selectedProject.value.currentAmount) {
    return 0;
  }
  // 可用资金 = 已筹金额 × 0.95（假设平台收取5%的管理费）
  const available = selectedProject.value.currentAmount * 0.95;
  return parseFloat(available.toFixed(2));
});

getList();
</script>

<style scoped>
.ml-2 {
  margin-left: 8px;
}

.mt-2 {
  margin-top: 8px;
}
</style>
