<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryRef" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="用户名称" prop="userName">
        <el-input v-model="queryParams.userName" placeholder="请输入用户名称" clearable @keyup.enter="handleQuery" />
      </el-form-item>
      <el-form-item label="项目名称" prop="projectName">
        <el-input v-model="queryParams.projectName" placeholder="请输入项目名称" clearable @keyup.enter="handleQuery" />
      </el-form-item>
      <el-form-item label="捐赠金额" prop="donationAmount">
        <el-input v-model="queryParams.donationAmount" placeholder="请输入捐赠金额" clearable @keyup.enter="handleQuery" />
      </el-form-item>
      <el-form-item label="捐赠时间" style="width: 308px">
        <el-date-picker v-model="daterangeDonationTime" value-format="YYYY-MM-DD" type="daterange" range-separator="-"
          start-placeholder="开始日期" end-placeholder="结束日期"></el-date-picker>
      </el-form-item>
      <el-form-item label="捐赠状态" prop="status" style="width: 308px">
        <el-select v-model="queryParams.status" placeholder="请选择捐赠状态" clearable>
          <el-option v-for="dict in donation_status" :key="dict.value" :label="dict.label" :value="dict.value" />
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
          v-hasPermi="['charity:donation:export']">导出</el-button>
      </el-col>
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="donationList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="捐赠编号" align="center" prop="donationId" />
      <el-table-column label="用户名称" align="center" prop="userName" />
      <el-table-column label="项目名称" align="center" prop="projectName" />
      <el-table-column label="捐赠金额" align="center" prop="donationAmount" />
      <el-table-column label="支付方式" align="center" prop="paymentMethod" />
      <el-table-column label="捐赠时间" align="center" prop="donationTime" width="180">
        <template #default="scope">
          <span>{{ parseTime(scope.row.donationTime, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="捐赠状态" align="center" prop="status">
        <template #default="scope">
          <dict-tag :options="donation_status" :value="scope.row.status" />
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template #default="scope">
          <el-button link type="primary" icon="View" @click="handleView(scope.row)">查看</el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination v-show="total > 0" :total="total" v-model:page="queryParams.pageNum"
      v-model:limit="queryParams.pageSize" @pagination="getList" />

    <!-- 查看捐赠记录详情对话框 -->
    <el-dialog title="捐赠记录详情" v-model="open" width="700px" append-to-body>
      <el-descriptions :column="2" border>
        <el-descriptions-item label="捐赠编号">{{ form.donationId }}</el-descriptions-item>
        <el-descriptions-item label="用户名称">{{ form.userName }}</el-descriptions-item>
        <el-descriptions-item label="项目名称">{{ form.projectName }}</el-descriptions-item>
        <el-descriptions-item label="捐赠金额">{{ form.donationAmount }}元</el-descriptions-item>
        <el-descriptions-item label="支付方式">
          <span v-if="form.paymentMethod === 'online'">在线支付</span>
          <span v-else-if="form.paymentMethod === 'offline'">线下捐赠</span>
          <span v-else>{{ form.paymentMethod }}</span>
        </el-descriptions-item>
        <el-descriptions-item label="捐赠时间">{{ parseTime(form.donationTime, '{y}-{m}-{d}') }}</el-descriptions-item>
        <el-descriptions-item label="捐赠状态">
          <dict-tag :options="donation_status" :value="form.status" />
        </el-descriptions-item>
        <el-descriptions-item label="创建时间">{{ parseTime(form.createTime, '{y}-{m}-{d} {h}:{i}:{s}')
          }}</el-descriptions-item>
        <el-descriptions-item label="区块链交易" :span="2" v-if="form.transactionHash">
          <p>交易哈希: {{ form.transactionHash }}</p>
        </el-descriptions-item>
        <el-descriptions-item label="捐赠证书" :span="2" v-if="form.certificateUrl">
          <div>
            <el-link type="primary" :href="form.certificateUrl" target="_blank">查看证书</el-link>
            <p v-if="form.certificateIssueDate">颁发日期: {{ parseTime(form.certificateIssueDate, '{y}-{m}-{d}') }}</p>
          </div>
        </el-descriptions-item>
        <el-descriptions-item label="捐赠留言" :span="2" v-if="form.remark">{{ form.remark }}</el-descriptions-item>
      </el-descriptions>
      <template #footer>
        <div class="dialog-footer">
          <el-button @click="open = false">关闭</el-button>
        </div>
      </template>
    </el-dialog>
  </div>
</template>

<script setup name="Donation">
import { listDonation } from "@/api/charity/donation";

const { proxy } = getCurrentInstance();
const { donation_status } = proxy.useDict('donation_status');

const donationList = ref([]);
const open = ref(false);
const loading = ref(true);
const showSearch = ref(true);
const ids = ref([]);
const single = ref(true);
const multiple = ref(true);
const total = ref(0);
const daterangeDonationTime = ref([]);
const daterangeCertificateIssueDate = ref([]);
const daterangeCreateTime = ref([]);

const data = reactive({
  form: {},
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    userId: null,
    projectId: null,
    donationAmount: null,
    paymentMethod: null,
    donationTime: null,
    status: null,
    createTime: null,
  },
  rules: {
    donationId: [
      { required: true, message: "捐赠编号不能为空", trigger: "blur" }
    ],
    userId: [
      { required: true, message: "用户编号不能为空", trigger: "blur" }
    ],
    projectId: [
      { required: true, message: "项目编号不能为空", trigger: "blur" }
    ],
    donationAmount: [
      { required: true, message: "捐赠金额不能为空", trigger: "blur" }
    ],
    paymentMethod: [
      { required: true, message: "支付方式不能为空", trigger: "change" }
    ],
    donationTime: [
      { required: true, message: "捐赠时间不能为空", trigger: "blur" }
    ],
    status: [
      { required: true, message: "捐赠状态不能为空", trigger: "change" }
    ],
  }
});

const { queryParams, form, rules } = toRefs(data);

/** 查询捐赠记录列表 */
function getList() {
  loading.value = true;
  queryParams.value.params = {};
  if (null != daterangeDonationTime && '' != daterangeDonationTime) {
    queryParams.value.params["beginDonationTime"] = daterangeDonationTime.value[0];
    queryParams.value.params["endDonationTime"] = daterangeDonationTime.value[1];
  }
  if (null != daterangeCertificateIssueDate && '' != daterangeCertificateIssueDate) {
    queryParams.value.params["beginCertificateIssueDate"] = daterangeCertificateIssueDate.value[0];
    queryParams.value.params["endCertificateIssueDate"] = daterangeCertificateIssueDate.value[1];
  }
  if (null != daterangeCreateTime && '' != daterangeCreateTime) {
    queryParams.value.params["beginCreateTime"] = daterangeCreateTime.value[0];
    queryParams.value.params["endCreateTime"] = daterangeCreateTime.value[1];
  }
  listDonation(queryParams.value).then(response => {
    donationList.value = response.rows;
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
    donationId: null,
    userId: null,
    projectId: null,
    donationAmount: null,
    paymentMethod: null,
    donationTime: null,
    status: null,
    transactionHash: null,
    certificateUrl: null,
    certificateIssueDate: null,
    remark: null,
    createTime: null,
    updateTime: null
  };
  proxy.resetForm("donationRef");
}

/** 搜索按钮操作 */
function handleQuery() {
  queryParams.value.pageNum = 1;
  getList();
}

/** 重置按钮操作 */
function resetQuery() {
  daterangeDonationTime.value = [];
  daterangeCertificateIssueDate.value = [];
  daterangeCreateTime.value = [];
  proxy.resetForm("queryRef");
  handleQuery();
}

// 多选框选中数据
function handleSelectionChange(selection) {
  ids.value = selection.map(item => item.donationId);
  single.value = selection.length != 1;
  multiple.value = !selection.length;
}

/** 查看按钮操作 */
function handleView(row) {
  reset();
  form.value = row;
  open.value = true;
}

/** 导出按钮操作 */
function handleExport() {
  proxy.download('charity/donation/export', {
    ...queryParams.value
  }, `donation_${new Date().getTime()}.xlsx`)
}

getList();
</script>
