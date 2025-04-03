<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryRef" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="项目名称" prop="projectName">
        <el-input v-model="queryParams.projectName" placeholder="请输入项目名称" clearable @keyup.enter="handleQuery" />
      </el-form-item>
      <el-form-item label="发起类型" prop="initiatorType" style="width: 254px;">
        <el-select v-model="queryParams.initiatorType" placeholder="请选择发起类型" clearable>
          <el-option v-for="dict in charity_initiator_type" :key="dict.value" :label="dict.label" :value="dict.value" />
        </el-select>
      </el-form-item>
      <el-form-item label="项目状态" prop="status" style="width: 254px;">
        <el-select v-model="queryParams.status" placeholder="请选择项目状态" clearable>
          <el-option v-for="dict in charity_project_status" :key="dict.value" :label="dict.label" :value="dict.value" />
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="Search" @click="handleQuery">搜索</el-button>
        <el-button icon="Refresh" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <!-- 项目卡片展示 -->
    <el-row :gutter="16" v-loading="loading">
      <el-col :xs="24" :sm="12" :md="8" :lg="6" v-for="(project, index) in projectList" :key="index" class="mb-4">
        <el-card :body-style="{ padding: '0px' }" class="project-card" shadow="hover">
          <el-image :src="getImageUrl(project.coverImage)" fit="cover" class="card-image" />
          <div style="padding: 14px;">
            <div class="card-title">{{ project.projectName }}</div>
            <div class="card-progress">
              <el-progress :percentage="calculateProgress(project.currentAmount, project.targetAmount)"
                :format="(p) => `${p.toFixed(0)}%`" />
              <div class="amount-info">
                <span>已筹: {{ project.currentAmount }}元</span>
                <span>目标: {{ project.targetAmount }}元</span>
              </div>
            </div>
            <div class="card-footer">
              <span class="time">
                {{ parseTime(project.startTime, '{y}-{m}-{d}') }} 至
                {{ parseTime(project.endTime, '{y}-{m}-{d}') }}
              </span>
              <div class="card-actions">
                <el-button type="primary" size="small" @click="handleDetail(project)">查看详情</el-button>
                <el-button type="success" size="small" @click="handleDonate(project)"
                  :disabled="String(project.status) !== '1'">我要捐赠</el-button>
              </div>
            </div>
          </div>
        </el-card>
      </el-col>
    </el-row>

    <pagination v-show="total > 0" :total="total" v-model:page="queryParams.pageNum"
      v-model:limit="queryParams.pageSize" @pagination="getList" />

    <!-- 项目详情对话框 -->
    <el-dialog title="项目详情" v-model="detailOpen" width="800px" append-to-body>
      <el-descriptions :column="2" border>
        <el-descriptions-item label="项目名称">{{ projectDetail.projectName }}</el-descriptions-item>
        <el-descriptions-item label="发起类型">
          <dict-tag :options="charity_initiator_type" :value="projectDetail.initiatorType" />
        </el-descriptions-item>
        <el-descriptions-item label="目标金额">{{ projectDetail.targetAmount }}元</el-descriptions-item>
        <el-descriptions-item label="已筹金额">{{ projectDetail.currentAmount }}元</el-descriptions-item>
        <el-descriptions-item label="开始时间">{{ parseTime(projectDetail.startTime, '{y}-{m}-{d}')
          }}</el-descriptions-item>
        <el-descriptions-item label="结束时间">{{ parseTime(projectDetail.endTime, '{y}-{m}-{d}') }}</el-descriptions-item>
        <el-descriptions-item label="项目状态">
          <dict-tag :options="charity_project_status" :value="projectDetail.status" />
        </el-descriptions-item>
        <el-descriptions-item label="审核状态">
          <dict-tag :options="charity_project_audit_status" :value="projectDetail.auditStatus" />
        </el-descriptions-item>
        <el-descriptions-item label="项目描述" :span="2">
          <div v-html="projectDetail.projectDesc"></div>
        </el-descriptions-item>
        <el-descriptions-item label="项目图片" :span="2">
          <el-image :src="getImageUrl(projectDetail.coverImage)" style="max-width: 300px;" />
        </el-descriptions-item>
      </el-descriptions>
      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" @click="handleDonate(projectDetail)"
            :disabled="String(projectDetail.status) !== '1'">我要捐赠</el-button>
          <el-button @click="detailOpen = false">关闭</el-button>
        </div>
      </template>
    </el-dialog>

    <!-- 捐赠对话框 -->
    <el-dialog title="爱心捐赠" v-model="donateOpen" width="500px" append-to-body>
      <el-form ref="donateRef" :model="donateForm" :rules="donateRules" label-width="100px">
        <el-form-item label="项目名称">
          <span>{{ donateForm.projectName }}</span>
        </el-form-item>
        <el-form-item label="捐赠金额" prop="amount">
          <el-input-number v-model="donateForm.amount" :min="1" :precision="2" :step="10"
            style="width: 180px;"></el-input-number>
          <span class="ml-2">元</span>
        </el-form-item>
        <el-form-item label="捐赠留言" prop="message">
          <el-input v-model="donateForm.message" type="textarea" placeholder="请输入留言(选填)" />
        </el-form-item>
        <el-form-item label="是否匿名" prop="isAnonymous">
          <el-switch v-model="donateForm.isAnonymous"></el-switch>
        </el-form-item>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" @click="submitDonate">确认捐赠</el-button>
          <el-button @click="donateOpen = false">取消</el-button>
        </div>
      </template>
    </el-dialog>
  </div>
</template>

<script setup name="Project">
import { listProject, getProject, delProject, addProject, updateProject } from "@/api/charity/project";
import { isExternal } from "@/utils/validate";

const { proxy } = getCurrentInstance();
const { charity_project_audit_status, charity_initiator_type, charity_project_status } = proxy.useDict('charity_project_audit_status', 'charity_initiator_type', 'charity_project_status');

const projectList = ref([]);
const open = ref(false);
const loading = ref(true);
const showSearch = ref(true);
const ids = ref([]);
const single = ref(true);
const multiple = ref(true);
const total = ref(0);
const title = ref("");
const daterangeStartTime = ref([]);
const daterangeEndTime = ref([]);
const daterangeAuditTime = ref([]);
const daterangeCreateTime = ref([]);
const detailOpen = ref(false);
const donateOpen = ref(false);
const projectDetail = ref({});
const donateForm = ref({
  projectId: null,
  projectName: '',
  amount: 10,
  message: '',
  isAnonymous: false
});
const donateRules = {
  amount: [
    { required: true, message: "捐赠金额不能为空", trigger: "blur" },
    { type: 'number', min: 1, message: '捐赠金额最小为1元', trigger: 'blur' }
  ]
};

const data = reactive({
  form: {},
  queryParams: {
    pageNum: 1,
    pageSize: 8,
    projectName: null,
    initiatorId: null,
    initiatorType: null,
    startTime: null,
    endTime: null,
    status: '1',  // 默认只显示进行中的项目
    auditStatus: '1',  // 默认只显示审核通过的项目
    auditTime: null,
    createTime: null,
  },
  rules: {
    projectName: [
      { required: true, message: "项目名称不能为空", trigger: "blur" }
    ],
    projectDesc: [
      { required: true, message: "项目描述不能为空", trigger: "blur" }
    ],
    targetAmount: [
      { required: true, message: "目标金额不能为空", trigger: "blur" }
    ],
    initiatorId: [
      { required: true, message: "发起人编号不能为空", trigger: "blur" }
    ],
    initiatorType: [
      { required: true, message: "发起类型不能为空", trigger: "change" }
    ],
    startTime: [
      { required: true, message: "开始时间不能为空", trigger: "blur" }
    ],
    endTime: [
      { required: true, message: "结束时间不能为空", trigger: "blur" }
    ],
    status: [
      { required: true, message: "项目状态不能为空", trigger: "change" }
    ],
    auditStatus: [
      { required: true, message: "审核状态不能为空", trigger: "change" }
    ],
  }
});

const { queryParams, form, rules } = toRefs(data);
const baseUrl = import.meta.env.VITE_APP_BASE_API; // 添加基础URL

/** 查询慈善项目列表 */
function getList() {
  loading.value = true;
  queryParams.value.params = {};
  if (null != daterangeStartTime && '' != daterangeStartTime) {
    queryParams.value.params["beginStartTime"] = daterangeStartTime.value[0];
    queryParams.value.params["endStartTime"] = daterangeStartTime.value[1];
  }
  if (null != daterangeEndTime && '' != daterangeEndTime) {
    queryParams.value.params["beginEndTime"] = daterangeEndTime.value[0];
    queryParams.value.params["endEndTime"] = daterangeEndTime.value[1];
  }
  if (null != daterangeAuditTime && '' != daterangeAuditTime) {
    queryParams.value.params["beginAuditTime"] = daterangeAuditTime.value[0];
    queryParams.value.params["endAuditTime"] = daterangeAuditTime.value[1];
  }
  if (null != daterangeCreateTime && '' != daterangeCreateTime) {
    queryParams.value.params["beginCreateTime"] = daterangeCreateTime.value[0];
    queryParams.value.params["endCreateTime"] = daterangeCreateTime.value[1];
  }
  listProject(queryParams.value).then(response => {
    projectList.value = response.rows;
    // 调试输出，检查数据格式
    console.log("项目列表页数据:", projectList.value);
    if (projectList.value && projectList.value.length > 0) {
      console.log("第一个项目的审核状态:", projectList.value[0].auditStatus, "类型:", typeof projectList.value[0].auditStatus);
      console.log("第一个项目的项目状态:", projectList.value[0].status, "类型:", typeof projectList.value[0].status);
    }
    total.value = response.total;
    loading.value = false;
  });
}

// 取消按钮
function cancel() {
  open.value = false;
  reset();
}

// 表单重置
function reset() {
  form.value = {
    projectId: null,
    projectName: null,
    projectDesc: null,
    targetAmount: null,
    currentAmount: null,
    initiatorId: null,
    initiatorType: null,
    coverImage: null,
    startTime: null,
    endTime: null,
    status: null,
    blockchainId: null,
    fundUsageRules: null,
    auditUserId: null,
    auditTime: null,
    auditStatus: null,
    auditRemark: null,
    createTime: null,
    updateTime: null
  };
  proxy.resetForm("projectRef");
}

/** 搜索按钮操作 */
function handleQuery() {
  queryParams.value.pageNum = 1;
  getList();
}

/** 重置按钮操作 */
function resetQuery() {
  daterangeStartTime.value = [];
  daterangeEndTime.value = [];
  daterangeAuditTime.value = [];
  daterangeCreateTime.value = [];
  proxy.resetForm("queryRef");
  handleQuery();
}

// 多选框选中数据
function handleSelectionChange(selection) {
  ids.value = selection.map(item => item.projectId);
  single.value = selection.length != 1;
  multiple.value = !selection.length;
}

/** 新增按钮操作 */
function handleAdd() {
  reset();
  open.value = true;
  title.value = "添加慈善项目";
}

/** 修改按钮操作 */
function handleUpdate(row) {
  reset();
  const _projectId = row.projectId || ids.value
  getProject(_projectId).then(response => {
    form.value = response.data;
    open.value = true;
    title.value = "修改慈善项目";
  });
}

/** 提交按钮 */
function submitForm() {
  proxy.$refs["projectRef"].validate(valid => {
    if (valid) {
      if (form.value.projectId != null) {
        updateProject(form.value).then(response => {
          proxy.$modal.msgSuccess("修改成功");
          open.value = false;
          getList();
        });
      } else {
        addProject(form.value).then(response => {
          proxy.$modal.msgSuccess("新增成功");
          open.value = false;
          getList();
        });
      }
    }
  });
}

/** 删除按钮操作 */
function handleDelete(row) {
  const _projectIds = row.projectId || ids.value;
  proxy.$modal.confirm('是否确认删除慈善项目编号为"' + _projectIds + '"的数据项？').then(function () {
    return delProject(_projectIds);
  }).then(() => {
    getList();
    proxy.$modal.msgSuccess("删除成功");
  }).catch(() => { });
}

/** 导出按钮操作 */
function handleExport() {
  proxy.download('charity/project/export', {
    ...queryParams.value
  }, `project_${new Date().getTime()}.xlsx`)
}

/** 查看项目详情 */
function handleDetail(row) {
  getProject(row.projectId).then(response => {
    projectDetail.value = response.data;
    detailOpen.value = true;
  });
}

/** 打开捐赠对话框 */
function handleDonate(row) {
  donateForm.value = {
    projectId: row.projectId,
    projectName: row.projectName,
    amount: 10,
    message: '',
    isAnonymous: false
  };
  donateOpen.value = true;
}

/** 提交捐赠 */
function submitDonate() {
  proxy.$refs["donateRef"].validate(valid => {
    if (valid) {
      // 这里应该调用捐赠API，暂时用弹窗模拟
      proxy.$modal.msgSuccess(`您已成功为"${donateForm.value.projectName}"项目捐赠${donateForm.value.amount}元`);
      donateOpen.value = false;
      // 这里应该刷新项目列表
      getList();
    }
  });
}

/** 计算项目进度百分比 */
function calculateProgress(current, target) {
  if (!current || !target) return 0;
  const percent = (current / target) * 100;
  return percent > 100 ? 100 : percent;
}

// 添加处理图片URL的函数
function getImageUrl(url) {
  if (!url) return 'https://placeholder.pics/svg/300x200/DEDEDE/555555/项目图片';
  if (isExternal(url) || url.indexOf(baseUrl) !== -1) {
    return url;
  }
  return baseUrl + url;
}

getList();
</script>

<style scoped>
.mb-4 {
  margin-bottom: 16px;
}

.project-card {
  height: 100%;
  display: flex;
  flex-direction: column;
}

.card-image {
  width: 100%;
  height: 200px;
}

.card-title {
  font-size: 16px;
  font-weight: bold;
  margin-bottom: 10px;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.card-progress {
  margin-bottom: 10px;
}

.amount-info {
  display: flex;
  justify-content: space-between;
  margin-top: 5px;
  font-size: 14px;
  color: #606266;
}

.card-footer {
  margin-top: 10px;
}

.time {
  font-size: 13px;
  color: #999;
  display: block;
  margin-bottom: 8px;
}

.card-actions {
  display: flex;
  justify-content: space-between;
}
</style>
