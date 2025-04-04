<template>
  <div class="app-container">
    <!-- 我发布的项目列表 -->
    <el-card class="box-card" v-if="!isPublishing">
      <template #header>
        <div class="card-header">
          <span>我发布的项目</span>
          <el-button type="primary" @click="handleAdd">发布新项目</el-button>
        </div>
      </template>
      <el-table v-loading="loading" :data="projectList">
        <el-table-column label="项目名称" align="center" prop="projectName" />
        <el-table-column label="目标金额" align="center" prop="targetAmount" />
        <el-table-column label="已筹金额" align="center" prop="currentAmount" />
        <el-table-column label="开始时间" align="center" prop="startTime" width="100">
          <template #default="scope">
            <span>{{ parseTime(scope.row.startTime, '{y}-{m}-{d}') }}</span>
          </template>
        </el-table-column>
        <el-table-column label="结束时间" align="center" prop="endTime" width="100">
          <template #default="scope">
            <span>{{ parseTime(scope.row.endTime, '{y}-{m}-{d}') }}</span>
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
            <el-button link type="primary" icon="Edit" @click="handleUpdate(scope.row)"
              v-if="!['0'].includes(scope.row.auditStatus)">修改</el-button>
            <el-button link type="primary" icon="Delete" @click="handleDelete(scope.row)"
              v-if="!['0'].includes(scope.row.auditStatus)">删除</el-button>
          </template>
        </el-table-column>
      </el-table>

      <pagination v-show="total > 0" :total="total" v-model:page="queryParams.pageNum"
        v-model:limit="queryParams.pageSize" @pagination="getList" />
    </el-card>

    <!-- 项目发布表单 -->
    <el-card class="box-card" v-if="isPublishing">
      <template #header>
        <div class="card-header">
          <span>{{ form.projectId ? '修改项目' : '发布新项目' }}</span>
          <el-button type="default" @click="isPublishing = false">返回列表</el-button>
        </div>
      </template>
      <el-form ref="projectRef" :model="form" :rules="rules" label-width="120px">
        <el-form-item label="项目名称" prop="projectName">
          <el-input v-model="form.projectName" placeholder="请输入项目名称" />
        </el-form-item>
        <el-form-item label="目标金额" prop="targetAmount">
          <el-input-number v-model="form.targetAmount" :min="100" :step="100" controls-position="right"
            style="width: 200px;" />
          <span class="ml-2">元</span>
        </el-form-item>
        <el-form-item label="项目时间" prop="projectTime">
          <el-date-picker v-model="projectTime" type="daterange" range-separator="至" start-placeholder="开始日期"
            end-placeholder="结束日期" value-format="YYYY-MM-DD" @change="handleDateChange"></el-date-picker>
        </el-form-item>
        <el-form-item label="封面图片" prop="coverImage">
          <image-upload v-model="form.coverImage" />
        </el-form-item>
        <el-form-item label="发起类型" prop="initiatorType">
          <el-select v-model="form.initiatorType" placeholder="请选择发起类型">
            <el-option v-for="dict in charity_initiator_type" :key="dict.value" :label="dict.label"
              :value="dict.value"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="项目描述" prop="projectDesc">
          <editor v-model="form.projectDesc" :min-height="300" />
        </el-form-item>
        <el-form-item label="资金使用规则" prop="fundUsageRules">
          <el-input v-model="form.fundUsageRules" type="textarea" placeholder="请输入资金使用规则，例如：资金将用于XX项目的XX方面，使用比例为XX%"
            :rows="4" />
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="submitForm">提交审核</el-button>
          <el-button @click="isPublishing = false">取消</el-button>
        </el-form-item>
      </el-form>
    </el-card>

    <!-- 查看项目详情对话框 -->
    <el-dialog title="项目详情" v-model="openView" width="800px" append-to-body>
      <el-descriptions :column="2" border>
        <el-descriptions-item label="项目名称">{{ form.projectName }}</el-descriptions-item>
        <el-descriptions-item label="发起类型">
          <dict-tag :options="charity_initiator_type" :value="form.initiatorType" />
        </el-descriptions-item>
        <el-descriptions-item label="目标金额">{{ form.targetAmount }}元</el-descriptions-item>
        <el-descriptions-item label="已筹金额">{{ form.currentAmount }}元</el-descriptions-item>
        <el-descriptions-item label="开始时间">{{ parseTime(form.startTime, '{y}-{m}-{d}') }}</el-descriptions-item>
        <el-descriptions-item label="结束时间">{{ parseTime(form.endTime, '{y}-{m}-{d}') }}</el-descriptions-item>
        <el-descriptions-item label="项目状态">
          <dict-tag :options="charity_project_status" :value="form.status" />
        </el-descriptions-item>
        <el-descriptions-item label="审核状态">
          <dict-tag :options="charity_project_audit_status" :value="form.auditStatus" />
        </el-descriptions-item>
        <el-descriptions-item label="审核时间" v-if="form.auditTime">{{ parseTime(form.auditTime, '{y}-{m}-{d}')
          }}</el-descriptions-item>
        <el-descriptions-item label="审核备注" v-if="form.auditRemark">{{ form.auditRemark }}</el-descriptions-item>
        <el-descriptions-item label="项目描述" :span="2">
          <div v-html="form.projectDesc"></div>
        </el-descriptions-item>
        <el-descriptions-item label="资金使用规则" :span="2">{{ form.fundUsageRules }}</el-descriptions-item>
        <el-descriptions-item label="项目图片" :span="2">
          <el-image :src="getImageUrl(form.coverImage)" style="max-width: 300px;" />
        </el-descriptions-item>
      </el-descriptions>
      <template #footer>
        <div class="dialog-footer">
          <el-button @click="openView = false">关闭</el-button>
        </div>
      </template>
    </el-dialog>
  </div>
</template>

<script setup name="ProjectPublish">
import { listProject, getProject, delProject, addProject, updateProject } from "@/api/charity/project";
import useUserStore from '@/store/modules/user';
import { isExternal } from "@/utils/validate";

const userStore = useUserStore();
const { proxy } = getCurrentInstance();
const { charity_project_audit_status, charity_initiator_type, charity_project_status } = proxy.useDict('charity_project_audit_status', 'charity_initiator_type', 'charity_project_status');

const projectList = ref([]);
const isPublishing = ref(false); // 是否显示发布表单
const openView = ref(false);
const loading = ref(true);
const total = ref(0);
const projectTime = ref([]);
const baseUrl = import.meta.env.VITE_APP_BASE_API; // 添加基础URL

const data = reactive({
  // 查询参数
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    initiatorId: userStore.userId, // 只查询当前用户发布的项目
    projectName: null,
    status: null,
    auditStatus: null
  },
  // 表单参数
  form: {
    projectId: null,
    projectName: null,
    projectDesc: null,
    targetAmount: 1000,
    currentAmount: 0,
    initiatorId: userStore.userId,
    initiatorType: "0", // 默认个人发起
    coverImage: null,
    startTime: null,
    endTime: null,
    status: "0", // 默认未开始
    blockchainId: null,
    fundUsageRules: null,
  },
  // 表单校验
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
    initiatorType: [
      { required: true, message: "发起类型不能为空", trigger: "change" }
    ],
    coverImage: [
      { required: true, message: "封面图片不能为空", trigger: "blur" }
    ],
    fundUsageRules: [
      { required: true, message: "资金使用规则不能为空", trigger: "blur" }
    ]
  }
});

const { queryParams, form, rules } = toRefs(data);

/** 查询我发布的项目列表 */
function getList() {
  loading.value = true;
  listProject(queryParams.value).then(response => {
    projectList.value = response.rows;
    // 调试输出，检查数据格式
    console.log("项目列表数据:", projectList.value);
    if (projectList.value && projectList.value.length > 0) {
      console.log("第一个项目的审核状态:", projectList.value[0].auditStatus, "类型:", typeof projectList.value[0].auditStatus);
    }
    total.value = response.total;
    loading.value = false;
  });
}

/** 处理日期选择变化 */
function handleDateChange(val) {
  if (val) {
    form.value.startTime = val[0];
    form.value.endTime = val[1];
  } else {
    form.value.startTime = null;
    form.value.endTime = null;
  }
}

/** 查看按钮操作 */
function handleView(row) {
  reset();
  getProject(row.projectId).then(response => {
    form.value = response.data;
    openView.value = true;
  });
}

/** 新增按钮操作 */
function handleAdd() {
  reset();
  isPublishing.value = true;
}

/** 修改按钮操作 */
function handleUpdate(row) {
  reset();
  getProject(row.projectId).then(response => {
    form.value = response.data;
    projectTime.value = [form.value.startTime, form.value.endTime];
    isPublishing.value = true;
  });
}

/** 提交按钮 */
function submitForm() {
  proxy.$refs["projectRef"].validate(valid => {
    if (valid) {
      if (form.value.projectId != null) {
        form.value.auditStatus = null;
        updateProject(form.value).then(response => {
          proxy.$modal.msgSuccess("修改成功，项目已提交审核");
          isPublishing.value = false;
          getList();
        });
      } else {
        addProject(form.value).then(response => {
          proxy.$modal.msgSuccess("新增成功，项目已提交审核");
          isPublishing.value = false;
          getList();
        });
      }
    }
  });
}

/** 删除按钮操作 */
function handleDelete(row) {
  proxy.$modal.confirm('确认删除该项目吗？').then(function () {
    return delProject(row.projectId);
  }).then(() => {
    getList();
    proxy.$modal.msgSuccess("删除成功");
  }).catch(() => { });
}

// 表单重置
function reset() {
  form.value = {
    projectId: null,
    projectName: null,
    projectDesc: null,
    targetAmount: 1000,
    currentAmount: 0,
    initiatorId: userStore.userId,
    initiatorType: "0", // 默认个人发起
    coverImage: null,
    startTime: null,
    endTime: null,
    status: "0", // 默认未开始
    blockchainId: null,
    fundUsageRules: null,
  };
  projectTime.value = [];
  proxy.resetForm("projectRef");
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
.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}
</style>
