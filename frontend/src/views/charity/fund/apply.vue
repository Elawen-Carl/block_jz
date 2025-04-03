<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryRef" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="项目编号" prop="projectId">
        <el-input
          v-model="queryParams.projectId"
          placeholder="请输入项目编号"
          clearable
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="使用金额" prop="amount">
        <el-input
          v-model="queryParams.amount"
          placeholder="请输入使用金额"
          clearable
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="使用时间" style="width: 308px">
        <el-date-picker
          v-model="daterangeUsageTime"
          value-format="YYYY-MM-DD"
          type="daterange"
          range-separator="-"
          start-placeholder="开始日期"
          end-placeholder="结束日期"
        ></el-date-picker>
      </el-form-item>
      <el-form-item label="创建时间" style="width: 308px">
        <el-date-picker
          v-model="daterangeCreateTime"
          value-format="YYYY-MM-DD"
          type="daterange"
          range-separator="-"
          start-placeholder="开始日期"
          end-placeholder="结束日期"
        ></el-date-picker>
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
          v-hasPermi="['charity:fund:add']"
        >新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="success"
          plain
          icon="Edit"
          :disabled="single"
          @click="handleUpdate"
          v-hasPermi="['charity:fund:edit']"
        >修改</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="danger"
          plain
          icon="Delete"
          :disabled="multiple"
          @click="handleDelete"
          v-hasPermi="['charity:fund:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="Download"
          @click="handleExport"
          v-hasPermi="['charity:fund:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="fundList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="使用记录编号" align="center" prop="usageId" />
      <el-table-column label="项目编号" align="center" prop="projectId" />
      <el-table-column label="使用金额" align="center" prop="amount" />
      <el-table-column label="使用描述" align="center" prop="usageDesc" />
      <el-table-column label="使用时间" align="center" prop="usageTime" width="180">
        <template #default="scope">
          <span>{{ parseTime(scope.row.usageTime, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="证明材料文件" align="center" prop="proofUrl" />
      <el-table-column label="区块链交易哈希值" align="center" prop="transactionHash" />
      <el-table-column label="创建时间" align="center" prop="createTime" width="180">
        <template #default="scope">
          <span>{{ parseTime(scope.row.createTime, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template #default="scope">
          <el-button link type="primary" icon="Edit" @click="handleUpdate(scope.row)" v-hasPermi="['charity:fund:edit']">修改</el-button>
          <el-button link type="primary" icon="Delete" @click="handleDelete(scope.row)" v-hasPermi="['charity:fund:remove']">删除</el-button>
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

    <!-- 添加或修改资金使用记录对话框 -->
    <el-dialog :title="title" v-model="open" width="500px" append-to-body>
      <el-form ref="fundRef" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="项目编号" prop="projectId">
          <el-input v-model="form.projectId" placeholder="请输入项目编号" />
        </el-form-item>
        <el-form-item label="使用金额" prop="amount">
          <el-input v-model="form.amount" placeholder="请输入使用金额" />
        </el-form-item>
        <el-form-item label="使用描述" prop="usageDesc">
          <el-input v-model="form.usageDesc" type="textarea" placeholder="请输入内容" />
        </el-form-item>
        <el-form-item label="使用时间" prop="usageTime">
          <el-date-picker clearable
            v-model="form.usageTime"
            type="date"
            value-format="YYYY-MM-DD"
            placeholder="请选择使用时间">
          </el-date-picker>
        </el-form-item>
        <el-form-item label="证明材料文件" prop="proofUrl">
          <file-upload v-model="form.proofUrl"/>
        </el-form-item>
        <el-form-item label="区块链交易哈希值" prop="transactionHash">
          <el-input v-model="form.transactionHash" placeholder="请输入区块链交易哈希值" />
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

<script setup name="Fund">
import { listFund, getFund, delFund, addFund, updateFund } from "@/api/charity/fund";

const { proxy } = getCurrentInstance();

const fundList = ref([]);
const open = ref(false);
const loading = ref(true);
const showSearch = ref(true);
const ids = ref([]);
const single = ref(true);
const multiple = ref(true);
const total = ref(0);
const title = ref("");
const daterangeUsageTime = ref([]);
const daterangeCreateTime = ref([]);

const data = reactive({
  form: {},
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    projectId: null,
    amount: null,
    usageTime: null,
    createTime: null
  },
  rules: {
    usageId: [
      { required: true, message: "使用记录编号不能为空", trigger: "blur" }
    ],
    projectId: [
      { required: true, message: "项目编号不能为空", trigger: "blur" }
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
    proofUrl: [
      { required: true, message: "证明材料文件不能为空", trigger: "blur" }
    ],
  }
});

const { queryParams, form, rules } = toRefs(data);

/** 查询资金使用记录列表 */
function getList() {
  loading.value = true;
  queryParams.value.params = {};
  if (null != daterangeUsageTime && '' != daterangeUsageTime) {
    queryParams.value.params["beginUsageTime"] = daterangeUsageTime.value[0];
    queryParams.value.params["endUsageTime"] = daterangeUsageTime.value[1];
  }
  if (null != daterangeCreateTime && '' != daterangeCreateTime) {
    queryParams.value.params["beginCreateTime"] = daterangeCreateTime.value[0];
    queryParams.value.params["endCreateTime"] = daterangeCreateTime.value[1];
  }
  listFund(queryParams.value).then(response => {
    fundList.value = response.rows;
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
    usageId: null,
    projectId: null,
    amount: null,
    usageDesc: null,
    usageTime: null,
    proofUrl: null,
    transactionHash: null,
    createBy: null,
    createTime: null
  };
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
  daterangeCreateTime.value = [];
  proxy.resetForm("queryRef");
  handleQuery();
}

// 多选框选中数据
function handleSelectionChange(selection) {
  ids.value = selection.map(item => item.usageId);
  single.value = selection.length != 1;
  multiple.value = !selection.length;
}

/** 新增按钮操作 */
function handleAdd() {
  reset();
  open.value = true;
  title.value = "添加资金使用记录";
}

/** 修改按钮操作 */
function handleUpdate(row) {
  reset();
  const _usageId = row.usageId || ids.value
  getFund(_usageId).then(response => {
    form.value = response.data;
    open.value = true;
    title.value = "修改资金使用记录";
  });
}

/** 提交按钮 */
function submitForm() {
  proxy.$refs["fundRef"].validate(valid => {
    if (valid) {
      if (form.value.usageId != null) {
        updateFund(form.value).then(response => {
          proxy.$modal.msgSuccess("修改成功");
          open.value = false;
          getList();
        });
      } else {
        addFund(form.value).then(response => {
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
  const _usageIds = row.usageId || ids.value;
  proxy.$modal.confirm('是否确认删除资金使用记录编号为"' + _usageIds + '"的数据项？').then(function() {
    return delFund(_usageIds);
  }).then(() => {
    getList();
    proxy.$modal.msgSuccess("删除成功");
  }).catch(() => {});
}

/** 导出按钮操作 */
function handleExport() {
  proxy.download('charity/fund/export', {
    ...queryParams.value
  }, `fund_${new Date().getTime()}.xlsx`)
}

getList();
</script>
