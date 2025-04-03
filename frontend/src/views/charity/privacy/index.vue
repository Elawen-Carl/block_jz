<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryRef" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="用户编号" prop="userId">
        <el-input
          v-model="queryParams.userId"
          placeholder="请输入用户编号"
          clearable
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="是否显示捐赠金额" prop="showDonationAmount">
        <el-select v-model="queryParams.showDonationAmount" placeholder="请选择是否显示捐赠金额" clearable>
          <el-option
            v-for="dict in sys_yes_no"
            :key="dict.value"
            :label="dict.label"
            :value="dict.value"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="是否在捐赠列表显示" prop="showDonationList">
        <el-select v-model="queryParams.showDonationList" placeholder="请选择是否在捐赠列表显示" clearable>
          <el-option
            v-for="dict in sys_yes_no"
            :key="dict.value"
            :label="dict.label"
            :value="dict.value"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="是否显示真实姓名" prop="showRealName">
        <el-select v-model="queryParams.showRealName" placeholder="请选择是否显示真实姓名" clearable>
          <el-option
            v-for="dict in sys_yes_no"
            :key="dict.value"
            :label="dict.label"
            :value="dict.value"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="创建时间" prop="createTime">
        <el-date-picker clearable
          v-model="queryParams.createTime"
          type="date"
          value-format="YYYY-MM-DD"
          placeholder="请选择创建时间">
        </el-date-picker>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="Search" @click="handleQuery">搜索</el-button>
        <el-button icon="Refresh" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button
          type="primary"
          plain
          icon="Plus"
          @click="handleAdd"
          v-hasPermi="['charity:privacy:add']"
        >新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="success"
          plain
          icon="Edit"
          :disabled="single"
          @click="handleUpdate"
          v-hasPermi="['charity:privacy:edit']"
        >修改</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="danger"
          plain
          icon="Delete"
          :disabled="multiple"
          @click="handleDelete"
          v-hasPermi="['charity:privacy:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="Download"
          @click="handleExport"
          v-hasPermi="['charity:privacy:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="privacyList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="用户编号" align="center" prop="userId" />
      <el-table-column label="是否显示捐赠金额" align="center" prop="showDonationAmount">
        <template #default="scope">
          <dict-tag :options="sys_yes_no" :value="scope.row.showDonationAmount"/>
        </template>
      </el-table-column>
      <el-table-column label="是否在捐赠列表显示" align="center" prop="showDonationList">
        <template #default="scope">
          <dict-tag :options="sys_yes_no" :value="scope.row.showDonationList"/>
        </template>
      </el-table-column>
      <el-table-column label="是否显示真实姓名" align="center" prop="showRealName">
        <template #default="scope">
          <dict-tag :options="sys_yes_no" :value="scope.row.showRealName"/>
        </template>
      </el-table-column>
      <el-table-column label="创建时间" align="center" prop="createTime" width="180">
        <template #default="scope">
          <span>{{ parseTime(scope.row.createTime, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template #default="scope">
          <el-button link type="primary" icon="Edit" @click="handleUpdate(scope.row)" v-hasPermi="['charity:privacy:edit']">修改</el-button>
          <el-button link type="primary" icon="Delete" @click="handleDelete(scope.row)" v-hasPermi="['charity:privacy:remove']">删除</el-button>
        </template>
      </el-table-column>
    </el-table>
    
    <pagination
      v-show="total>0"
      :total="total"
      v-model:page="queryParams.pageNum"
      v-model:limit="queryParams.pageSize"
      @pagination="getList"
    />

    <!-- 添加或修改用户隐私设置对话框 -->
    <el-dialog :title="title" v-model="open" width="500px" append-to-body>
      <el-form ref="privacyRef" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="是否显示捐赠金额" prop="showDonationAmount">
          <el-radio-group v-model="form.showDonationAmount">
            <el-radio
              v-for="dict in sys_yes_no"
              :key="dict.value"
              :label="parseInt(dict.value)"
            >{{dict.label}}</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="是否在捐赠列表显示" prop="showDonationList">
          <el-radio-group v-model="form.showDonationList">
            <el-radio
              v-for="dict in sys_yes_no"
              :key="dict.value"
              :label="parseInt(dict.value)"
            >{{dict.label}}</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="是否显示真实姓名" prop="showRealName">
          <el-radio-group v-model="form.showRealName">
            <el-radio
              v-for="dict in sys_yes_no"
              :key="dict.value"
              :label="parseInt(dict.value)"
            >{{dict.label}}</el-radio>
          </el-radio-group>
        </el-form-item>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" @click="submitForm">确 定</el-button>
          <el-button @click="cancel">取 消</el-button>
        </div>
      </template>
    </el-dialog>
  </div>
</template>

<script setup name="Privacy">
import { listPrivacy, getPrivacy, delPrivacy, addPrivacy, updatePrivacy } from "@/api/charity/privacy";

const { proxy } = getCurrentInstance();
const { sys_yes_no } = proxy.useDict('sys_yes_no');

const privacyList = ref([]);
const open = ref(false);
const loading = ref(true);
const showSearch = ref(true);
const ids = ref([]);
const single = ref(true);
const multiple = ref(true);
const total = ref(0);
const title = ref("");

const data = reactive({
  form: {},
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    userId: null,
    showDonationAmount: null,
    showDonationList: null,
    showRealName: null,
    createTime: null,
  },
  rules: {
    showDonationAmount: [
      { required: true, message: "是否显示捐赠金额不能为空", trigger: "change" }
    ],
    showDonationList: [
      { required: true, message: "是否在捐赠列表显示不能为空", trigger: "change" }
    ],
    showRealName: [
      { required: true, message: "是否显示真实姓名不能为空", trigger: "change" }
    ],
  }
});

const { queryParams, form, rules } = toRefs(data);

/** 查询用户隐私设置列表 */
function getList() {
  loading.value = true;
  listPrivacy(queryParams.value).then(response => {
    privacyList.value = response.rows;
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
    userId: null,
    showDonationAmount: null,
    showDonationList: null,
    showRealName: null,
    createTime: null,
    updateTime: null
  };
  proxy.resetForm("privacyRef");
}

/** 搜索按钮操作 */
function handleQuery() {
  queryParams.value.pageNum = 1;
  getList();
}

/** 重置按钮操作 */
function resetQuery() {
  proxy.resetForm("queryRef");
  handleQuery();
}

// 多选框选中数据
function handleSelectionChange(selection) {
  ids.value = selection.map(item => item.userId);
  single.value = selection.length != 1;
  multiple.value = !selection.length;
}

/** 新增按钮操作 */
function handleAdd() {
  reset();
  open.value = true;
  title.value = "添加用户隐私设置";
}

/** 修改按钮操作 */
function handleUpdate(row) {
  reset();
  const _userId = row.userId || ids.value
  getPrivacy(_userId).then(response => {
    form.value = response.data;
    open.value = true;
    title.value = "修改用户隐私设置";
  });
}

/** 提交按钮 */
function submitForm() {
  proxy.$refs["privacyRef"].validate(valid => {
    if (valid) {
      if (form.value.userId != null) {
        updatePrivacy(form.value).then(response => {
          proxy.$modal.msgSuccess("修改成功");
          open.value = false;
          getList();
        });
      } else {
        addPrivacy(form.value).then(response => {
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
  const _userIds = row.userId || ids.value;
  proxy.$modal.confirm('是否确认删除用户隐私设置编号为"' + _userIds + '"的数据项？').then(function() {
    return delPrivacy(_userIds);
  }).then(() => {
    getList();
    proxy.$modal.msgSuccess("删除成功");
  }).catch(() => {});
}

/** 导出按钮操作 */
function handleExport() {
  proxy.download('charity/privacy/export', {
    ...queryParams.value
  }, `privacy_${new Date().getTime()}.xlsx`)
}

getList();
</script>
