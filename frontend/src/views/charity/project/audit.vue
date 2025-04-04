<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryRef" :inline="true" v-show="showSearch" label-width="80px">
      <el-form-item label="项目名称" prop="projectName">
        <el-input v-model="queryParams.projectName" placeholder="请输入项目名称" clearable @keyup.enter="handleQuery" />
      </el-form-item>
      <el-form-item label="发起类型" prop="initiatorType" style="width: 254px;">
        <el-select v-model="queryParams.initiatorType" placeholder="请选择发起类型" clearable>
          <el-option v-for="dict in charity_initiator_type" :key="dict.value" :label="dict.label" :value="dict.value" />
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="Search" @click="handleQuery">搜索</el-button>
        <el-button icon="Refresh" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button type="primary" plain icon="Plus" @click="handleAdd"
          v-hasPermi="['charity:project:add']">新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="success" plain icon="Edit" :disabled="single" @click="handleUpdate"
          v-hasPermi="['charity:project:edit']">修改</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="danger" plain icon="Delete" :disabled="multiple" @click="handleDelete"
          v-hasPermi="['charity:project:remove']">删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="warning" plain icon="Download" @click="handleExport"
          v-hasPermi="['charity:project:export']">导出</el-button>
      </el-col>
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <!-- 待审核项目列表 -->
    <el-table v-loading="loading" :data="projectList">
      <el-table-column label="项目名称" align="center" prop="projectName" />
      <el-table-column label="目标金额" align="center" prop="targetAmount" />
      <el-table-column label="发起类型" align="center" prop="initiatorType">
        <template #default="scope">
          <dict-tag :options="charity_initiator_type" :value="scope.row.initiatorType" />
        </template>
      </el-table-column>
      <el-table-column label="提交时间" align="center" prop="createTime" width="180">
        <template #default="scope">
          <span>{{ parseTime(scope.row.createTime, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="项目状态" align="center" prop="status">
        <template #default="scope">
          <dict-tag :options="charity_project_status" :value="scope.row.status" />
        </template>
      </el-table-column>
      <el-table-column label="审核状态" align="center" prop="auditStatus">
        <template #default="scope">
          <dict-tag :options="charity_project_audit_status" :value="scope.row.auditStatus" />
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template #default="scope">
          <el-button link type="primary" icon="View" @click="handleView(scope.row)">查看</el-button>
          <el-button v-if="String(scope.row.auditStatus) !== '0'" link type="success" icon="Check"
            @click="handleAudit(scope.row, false)">通过</el-button>
          <el-button v-if="String(scope.row.auditStatus) !== '0'" link type="danger" icon="Close"
            @click="handleAudit(scope.row, true)">拒绝</el-button>
        </template>
      </el-table-column>
    </el-table>

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
        <el-descriptions-item label="开始时间">{{ parseTime(projectDetail.startTime, '{y}-{m}-{d}')
        }}</el-descriptions-item>
        <el-descriptions-item label="结束时间">{{ parseTime(projectDetail.endTime, '{y}-{m}-{d}') }}</el-descriptions-item>
        <el-descriptions-item label="审核状态">
          <dict-tag :options="charity_project_audit_status" :value="projectDetail.auditStatus" />
        </el-descriptions-item>
        <el-descriptions-item label="项目描述" :span="2">
          <div v-html="projectDetail.projectDesc"></div>
        </el-descriptions-item>
        <el-descriptions-item label="资金使用规则" :span="2">{{ projectDetail.fundUsageRules }}</el-descriptions-item>
        <el-descriptions-item label="项目图片" :span="2">
          <el-image :src="getImageUrl(projectDetail.coverImage)" />
        </el-descriptions-item>
      </el-descriptions>
      <template #footer>
        <div class="dialog-footer">
          <el-button v-if="String(projectDetail.auditStatus) === '0'" type="success"
            @click="handleAudit(projectDetail, false)">通过审核</el-button>
          <el-button v-if="String(projectDetail.auditStatus) === '0'" type="danger"
            @click="handleAudit(projectDetail, true)">拒绝审核</el-button>
          <el-button @click="detailOpen = false">关闭</el-button>
        </div>
      </template>
    </el-dialog>

    <!-- 审核对话框 -->
    <el-dialog :title="isApprove ? '审核通过' : '审核拒绝'" v-model="auditOpen" width="500px" append-to-body>
      <el-form ref="auditRef" :model="auditForm" :rules="auditRules" label-width="100px">
        <el-form-item label="项目名称">
          <span>{{ auditForm.projectName }}</span>
        </el-form-item>
        <el-form-item label="审核备注" prop="auditRemark">
          <el-input v-model="auditForm.auditRemark" type="textarea" placeholder="请输入审核备注" :rows="4" />
        </el-form-item>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" @click="submitAudit">确认</el-button>
          <el-button @click="auditOpen = false">取消</el-button>
        </div>
      </template>
    </el-dialog>
  </div>
</template>

<script setup name="ProjectAudit">
import { listProject, getProject, delProject, addProject, updateProject } from "@/api/charity/project";
import useUserStore from '@/store/modules/user';
import { isExternal } from "@/utils/validate";

const userStore = useUserStore();
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
const auditOpen = ref(false);
const projectDetail = ref({});
const isApprove = ref(true);

const data = reactive({
  form: {},
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    projectName: null,
    initiatorId: null,
    initiatorType: null,
    startTime: null,
    endTime: null,
    status: "0",
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
  },
  auditForm: {
    projectId: null,
    projectName: null,
    auditStatus: null,
    auditUserId: null,
    auditRemark: null
  },
  auditRules: {
    auditRemark: [
      { required: true, message: "审核备注不能为空", trigger: "blur" }
    ]
  }
});

const { queryParams, form, rules, auditForm, auditRules } = toRefs(data);
const baseUrl = import.meta.env.VITE_APP_BASE_API;

/** 查询待审核项目列表 */
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
    console.log("审核页面项目列表数据:", projectList.value);
    if (projectList.value && projectList.value.length > 0) {
      console.log("第一个项目的审核状态:", projectList.value[0].auditStatus, "类型:", typeof projectList.value[0].auditStatus);
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
function handleView(row) {
  getProject(row.projectId).then(response => {
    projectDetail.value = response.data;
    detailOpen.value = true;
  });
}

/** 打开审核对话框 */
function handleAudit(row, approve) {
  isApprove.value = approve;
  auditForm.value = {
    projectId: row.projectId,
    projectName: row.projectName,
    auditStatus: approve ? '1' : '0',  // 1:通过, 0:拒绝
    auditUserId: userStore.userId,
    auditRemark: ''
  };
  auditOpen.value = true;
}

/** 提交审核 */
function submitAudit() {
  proxy.$refs["auditRef"].validate(valid => {
    if (valid) {
      const data = {
        projectId: auditForm.value.projectId,
        auditUserId: auditForm.value.auditUserId,
        auditRemark: auditForm.value.auditRemark,
        status: auditForm.value.auditStatus === '0' ? '1' : '0', // 审核通过则状态为通过(1)，否则为拒绝(0)
        auditStatus: auditForm.value.auditStatus,
      };

      updateProject(data).then(response => {
        proxy.$modal.msgSuccess(isApprove.value ? "审核拒绝成功" : "审核通过成功");
        auditOpen.value = false;
        getList();
        if (detailOpen.value) {
          detailOpen.value = false;
        }
      });
    }
  });
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
