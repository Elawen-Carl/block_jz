<template>
  <div class="app-container">

    <!-- 搜索条件 -->
    <el-form :model="queryParams" ref="queryRef" :inline="true" v-show="showSearch" label-width="96px">
      <el-form-item label="项目名称" prop="projectName">
        <el-input v-model="queryParams.projectName" placeholder="请输入项目名称" clearable @keyup.enter="handleQuery" />
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

    <!-- 待审核的资金申请列表 -->
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
      <el-table-column label="申请时间" align="center" prop="createTime" width="120">
        <template #default="scope">
          <span>{{ parseTime(scope.row.createTime, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template #default="scope">
          <el-button link type="primary" icon="View" @click="handleView(scope.row)">查看</el-button>
          <el-button link type="primary" icon="Check" @click="handleAudit(scope.row)"
            v-if="scope.row.applicationStatus === '1'">审核</el-button>
        </template>
      </el-table-column>
    </el-table>

    <!-- 分页 -->
    <pagination v-show="total > 0" :total="total" v-model:page="queryParams.pageNum"
      v-model:limit="queryParams.pageSize" @pagination="getList" />

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
        <el-descriptions-item label="创建时间">{{ parseTime(form.createTime, '{y}-{m}-{d} {h}:{i}:{s}')
        }}</el-descriptions-item>
      </el-descriptions>
      <template #footer>
        <div class="dialog-footer">
          <el-button @click="openView = false">关闭</el-button>
        </div>
      </template>
    </el-dialog>

    <!-- 审核对话框 -->
    <el-dialog title="资金使用审核" v-model="auditOpen" width="700px" append-to-body>
      <el-form ref="auditRef" :model="auditForm" :rules="auditRules" label-width="100px">
        <el-descriptions :column="2" border size="small">
          <el-descriptions-item label="项目名称">{{ form.projectName }}</el-descriptions-item>
          <el-descriptions-item label="使用金额">{{ form.amount }}元</el-descriptions-item>
          <el-descriptions-item label="使用时间">{{ parseTime(form.usageTime, '{y}-{m}-{d}') }}</el-descriptions-item>
          <el-descriptions-item label="申请人">{{ form.createBy }}</el-descriptions-item>
          <el-descriptions-item label="使用描述" :span="2">{{ form.usageDesc }}</el-descriptions-item>
          <el-descriptions-item label="证明材料" :span="2" v-if="form.proofUrl">
            <el-link type="primary" :href="getFileUrl(form.proofUrl)" target="_blank">
              <el-button type="primary" size="small" icon="Download">下载证明材料</el-button>
            </el-link>
          </el-descriptions-item>
        </el-descriptions>
        <div style="margin: 20px 0"></div>
        <el-form-item label="审核结果" prop="auditResult">
          <el-radio-group v-model="auditForm.auditResult">
            <el-radio label="pass">通过</el-radio>
            <el-radio label="reject">拒绝</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="审核备注" prop="auditRemark">
          <el-input v-model="auditForm.auditRemark" type="textarea" placeholder="请输入审核备注" :rows="3" />
        </el-form-item>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" @click="submitAudit" :loading="submitLoading">确认</el-button>
          <el-button @click="auditOpen = false">取消</el-button>
        </div>
      </template>
    </el-dialog>
  </div>
</template>

<script setup name="FundAudit">
import { ref, reactive, toRefs, computed, getCurrentInstance } from 'vue';
import { listFund, getFund, auditFund } from "@/api/charity/fund";
import { isExternal } from "@/utils/validate";
import useUserStore from '@/store/modules/user';

const { proxy } = getCurrentInstance();
const fundList = ref([]);
const loading = ref(true);
const showSearch = ref(true);
const ids = ref([]);
const single = ref(true);
const multiple = ref(true);
const total = ref(0);
const openView = ref(false);
const auditOpen = ref(false);
const submitLoading = ref(false);
const daterangeUsageTime = ref([]);
const baseUrl = import.meta.env.VITE_APP_BASE_API;
const userStore = useUserStore();

// 字典数据
const { fund_application_status } = proxy.useDict('fund_application_status');

// 审核表单
const auditForm = ref({
  usageId: null,
  auditResult: 'pass',
  auditRemark: ''
});

// 审核表单校验规则
const auditRules = {
  auditResult: [
    { required: true, message: "请选择审核结果", trigger: "change" }
  ]
};

const data = reactive({
  form: {},
  queryParams: {
    orderByColumn: 'createTime',
    isAsc: 'desc',
    pageNum: 1,
    pageSize: 10,
    projectName: null,
    usageTime: null,
    applicationStatus: '1' // 默认查询待审核的申请
  }
});

const { queryParams, form } = toRefs(data);

/** 查询资金使用记录列表 */
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

/** 搜索按钮操作 */
function handleQuery() {
  queryParams.value.pageNum = 1;
  getList();
}

/** 重置按钮操作 */
function resetQuery() {
  daterangeUsageTime.value = [];
  proxy.resetForm("queryRef");
  queryParams.value.applicationStatus = '1'; // 重置后默认查询待审核的申请
  handleQuery();
}

/** 获取文件URL */
function getFileUrl(url) {
  if (!url) return '';
  if (isExternal(url) || url.indexOf(baseUrl) !== -1) {
    return url;
  }
  return baseUrl + url;
}

/** 多选框选中数据 */
function handleSelectionChange(selection) {
  ids.value = selection.map(item => item.usageId);
  single.value = selection.length != 1;
  multiple.value = !selection.length;
}

/** 查看按钮操作 */
function handleView(row) {
  getFund(row.usageId).then(response => {
    form.value = response.data;
    openView.value = true;
  });
}

/** 审核按钮操作 */
function handleAudit(row) {
  getFund(row.usageId).then(response => {
    form.value = response.data;
    auditForm.value = {
      usageId: form.value.usageId,
      auditResult: 'pass',
      auditRemark: ''
    };
    auditOpen.value = true;
  });
}

/** 提交审核 */
function submitAudit() {
  proxy.$refs["auditRef"].validate(valid => {
    if (valid) {
      submitLoading.value = true;
      const auditData = {
        usageId: auditForm.value.usageId,
        applicationStatus: auditForm.value.auditResult === 'pass' ? '2' : '0',
        auditRemark: auditForm.value.auditRemark,
        auditor: userStore.name,
      };

      auditFund(auditData).then(response => {
        proxy.$modal.msgSuccess(auditForm.value.auditResult === 'pass' ? "审核通过成功" : "审核拒绝成功");
        auditOpen.value = false;
        getList();
        submitLoading.value = false;
      }).catch(() => {
        submitLoading.value = false;
      });
    }
  });
}

getList();
</script>

<style scoped>
.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.box-card {
  max-width: 1200px;
  margin: 0 auto;
}

.tip-text {
  color: #909399;
  font-size: 12px;
  margin-top: 5px;
}

.ml-2 {
  margin-left: 8px;
}
</style>
