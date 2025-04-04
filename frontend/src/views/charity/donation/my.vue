<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryRef" :inline="true" v-show="showSearch" label-width="68px">
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
      <el-form-item>
        <el-button type="primary" icon="Search" @click="handleQuery">搜索</el-button>
        <el-button icon="Refresh" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <!-- 我的捐赠记录 -->
    <el-card class="box-card" v-loading="loading">
      <template #header>
        <div class="card-header">
          <span><i class="el-icon-gift"></i> 我的捐赠记录</span>
        </div>
      </template>

      <el-table :data="donationList" stripe style="width: 100%">
        <el-table-column label="项目名称" align="center" prop="projectName" />
        <el-table-column label="捐赠金额" align="center" prop="donationAmount" />
        <el-table-column label="支付方式" align="center" prop="paymentMethod">
          <template #default="scope">
            <el-tag v-if="scope.row.paymentMethod === 'online'">在线支付</el-tag>
            <el-tag v-else-if="scope.row.paymentMethod === 'offline'" type="success">线下捐赠</el-tag>
            <el-tag v-else>其他方式</el-tag>
          </template>
        </el-table-column>
        <el-table-column label="捐赠时间" align="center" prop="donationTime" width="100">
          <template #default="scope">
            <span>{{ parseTime(scope.row.donationTime, '{y}-{m}-{d}') }}</span>
          </template>
        </el-table-column>
        <el-table-column label="捐赠状态" align="center" prop="status" width="100">
          <template #default="scope">
            <dict-tag :options="donation_status" :value="scope.row.status" />
          </template>
        </el-table-column>
        <el-table-column label="捐赠证书" align="center" width="150">
          <template #default="scope">
            <el-button v-if="scope.row.certificateUrl" type="success" size="small"
              @click="downloadCertificate(scope.row)" icon="Download">下载证书</el-button>
            <el-button v-else-if="scope.row.status === '1'" type="primary" size="small"
              @click="generateCertificate(scope.row)" icon="Picture">生成证书</el-button>
            <el-tag v-else type="info">暂不可用</el-tag>
          </template>
        </el-table-column>
        <el-table-column label="操作" align="center" width="150">
          <template #default="scope">
            <el-button link type="primary" icon="View" @click="handleView(scope.row)">查看详情</el-button>
            <el-button v-if="scope.row.status === '1'" link type="success" icon="Comment"
              @click="handleAddComment(scope.row)">评价</el-button>
          </template>
        </el-table-column>
      </el-table>

      <pagination v-show="total > 0" :total="total" v-model:page="queryParams.pageNum"
        v-model:limit="queryParams.pageSize" @pagination="getList" />
    </el-card>

    <!-- 捐赠详情对话框 -->
    <el-dialog title="捐赠详情" v-model="viewOpen" width="600px" append-to-body>
      <el-descriptions :column="2" border>
        <el-descriptions-item label="项目名称">{{ form.projectName }}</el-descriptions-item>
        <el-descriptions-item label="捐赠金额">{{ form.donationAmount }}元</el-descriptions-item>
        <el-descriptions-item label="支付方式">
          <el-tag v-if="form.paymentMethod === 'online'">在线支付</el-tag>
          <el-tag v-else-if="form.paymentMethod === 'offline'" type="success">线下捐赠</el-tag>
          <el-tag v-else>其他方式</el-tag>
        </el-descriptions-item>
        <el-descriptions-item label="捐赠状态">
          <dict-tag :options="donation_status" :value="form.status" />
        </el-descriptions-item>
        <el-descriptions-item label="捐赠时间">{{ parseTime(form.donationTime, '{y}-{m}-{d} {h}:{i}:{s}')
          }}</el-descriptions-item>
        <el-descriptions-item label="创建时间">{{ parseTime(form.createTime, '{y}-{m}-{d} {h}:{i}:{s}')
          }}</el-descriptions-item>
        <el-descriptions-item label="捐赠留言" :span="2">{{ form.message || '无' }}</el-descriptions-item>
        <el-descriptions-item label="区块链交易" :span="2">
          <div v-if="form.transactionHash">
            <p>交易哈希: {{ form.transactionHash }}</p>
            <el-button size="small" type="primary" @click="viewBlockchainInfo(form.transactionHash)">
              查看区块链信息
            </el-button>
          </div>
          <span v-else>未记录到区块链</span>
        </el-descriptions-item>
        <el-descriptions-item label="捐赠证书" :span="2">
          <div v-if="form.certificateUrl">
            <el-image style="width: 100%; max-height: 200px" :src="getCertificateUrl(form.certificateUrl)"
              :preview-src-list="[getCertificateUrl(form.certificateUrl)]" />
            <div class="mt-2">
              <el-button type="success" size="small" @click="downloadCertificate(form)">
                下载证书
              </el-button>
            </div>
          </div>
          <div v-else-if="form.status === '1'">
            <el-button type="primary" size="small" @click="generateCertificate(form)">
              生成证书
            </el-button>
          </div>
          <span v-else>暂不可用</span>
        </el-descriptions-item>
      </el-descriptions>
      <template #footer>
        <div class="dialog-footer">
          <el-button @click="viewOpen = false">关闭</el-button>
        </div>
      </template>
    </el-dialog>

    <!-- 证书预览对话框 -->
    <el-dialog title="捐赠证书预览" v-model="certificateOpen" width="800px" append-to-body>
      <div class="certificate-container" ref="certificateRef">
        <div class="certificate">
          <div class="certificate-header">
            <h1>爱心捐赠证书</h1>
          </div>
          <div class="certificate-content">
            <p class="certificate-text">兹证明</p>
            <p class="certificate-name">{{ certificateData.userName }}</p>
            <p class="certificate-text">于 {{ parseTime(certificateData.donationTime, '{y}年{m}月{d}日') }}</p>
            <p class="certificate-text">向 <span class="highlight">{{ certificateData.projectName }}</span> 项目</p>
            <p class="certificate-text">捐赠人民币</p>
            <p class="certificate-amount">{{ certificateData.donationAmount }} 元</p>
            <p class="certificate-thanks">感谢您的爱心和慷慨，您的善举将温暖他人，照亮世界。</p>
          </div>
          <div class="certificate-footer">
            <div class="certificate-seal">
              <div class="seal-circle">
                <span class="seal-text">爱心捐赠</span>
                <span class="seal-text-small">证书专用章</span>
              </div>
            </div>
            <div class="certificate-date">
              <p>证书编号: {{ certificateData.certificateNo }}</p>
              <p>颁发日期: {{ parseTime(certificateData.issueDate, '{y}年{m}月{d}日') }}</p>
            </div>
          </div>
        </div>
      </div>
      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" @click="saveCertificate">保存证书</el-button>
          <el-button @click="certificateOpen = false">关闭</el-button>
        </div>
      </template>
    </el-dialog>

    <!-- 评价对话框 -->
    <el-dialog title="项目评价" v-model="commentOpen" width="500px" append-to-body>
      <el-form ref="commentRef" :model="commentForm" :rules="commentRules" label-width="80px">
        <el-form-item label="项目名称">
          <span>{{ commentForm.projectName }}</span>
        </el-form-item>
        <el-form-item label="评分" prop="rating">
          <el-rate :model-value="commentForm.rating" @update:model-value="commentForm.rating = $event"
            :texts="ratingTexts" show-text />
        </el-form-item>
        <el-form-item label="评价内容" prop="content">
          <el-input v-model="commentForm.content" type="textarea" :rows="4" placeholder="请输入您对该项目的评价或反馈意见..." />
        </el-form-item>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" @click="submitComment">提交评价</el-button>
          <el-button @click="commentOpen = false">取消</el-button>
        </div>
      </template>
    </el-dialog>
  </div>
</template>

<script setup name="MyDonation">
import { listDonation, getDonation, updateDonation } from "@/api/charity/donation";
import { listComment, addComment } from "@/api/charity/comment";
import useUserStore from '@/store/modules/user';
import { isExternal } from "@/utils/validate";
import html2canvas from 'html2canvas';

const { proxy } = getCurrentInstance();
const { donation_status } = proxy.useDict('donation_status');
const userStore = useUserStore();

const donationList = ref([]);
const viewOpen = ref(false);
const certificateOpen = ref(false);
const commentOpen = ref(false);
const loading = ref(true);
const showSearch = ref(true);
const total = ref(0);
const daterangeDonationTime = ref([]);
const certificateRef = ref(null);
const baseUrl = import.meta.env.VITE_APP_BASE_API;

// 证书数据
const certificateData = reactive({
  certificateNo: '',
  userName: '',
  projectName: '',
  donationAmount: 0,
  donationTime: null,
  issueDate: null
});

// 评价表单
const commentRef = ref(null);
const commentForm = ref({
  projectId: null,
  projectName: '',
  donationId: null,
  rating: 5,
  content: ''
});
const commentRules = {
  rating: [{ required: true, message: "请对项目进行评分", trigger: "change" }],
  content: [{ required: true, message: "请输入评价内容", trigger: "blur" }]
};
const ratingTexts = ["很差", "较差", "一般", "较好", "很好"];

const data = reactive({
  form: {},
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    userId: userStore.userId, // 当前登录用户ID
    projectName: null,
    donationAmount: null,
    donationTime: null,
    status: null,
  }
});

const { queryParams, form } = toRefs(data);

/** 查询我的捐赠记录列表 */
function getList() {
  loading.value = true;
  queryParams.value.params = {};
  if (daterangeDonationTime.value != null && daterangeDonationTime.value.length > 0) {
    queryParams.value.params["beginDonationTime"] = daterangeDonationTime.value[0];
    queryParams.value.params["endDonationTime"] = daterangeDonationTime.value[1];
  }
  // 确保只查询当前用户的数据
  queryParams.value.userId = userStore.userId;

  listDonation(queryParams.value).then(response => {
    donationList.value = response.rows;
    // 检查每条记录是否已有评价
    checkDonationComments();
    total.value = response.total;
    loading.value = false;
  });
}

/** 检查捐赠记录是否已有评价 */
function checkDonationComments() {
  // 获取所有项目ID
  const projectIds = donationList.value.map(item => item.projectId);

  if (projectIds.length === 0) return;

  // 查询用户对这些项目的评价
  listComment({
    userId: userStore.userId,
    projectIds: projectIds.join(',')
  }).then(response => {
    const comments = response.rows || [];
    // 建立项目ID到评价的映射
    const commentMap = {};
    comments.forEach(comment => {
      commentMap[comment.projectId] = true;
    });

    // 更新捐赠记录的评价状态
    donationList.value.forEach(donation => {
      donation.hasComment = commentMap[donation.projectId] || false;
    });
  }).catch(error => {
    console.error("获取评价记录失败", error);
  });
}

/** 搜索按钮操作 */
function handleQuery() {
  queryParams.value.pageNum = 1;
  getList();
}

/** 重置按钮操作 */
function resetQuery() {
  daterangeDonationTime.value = [];
  proxy.resetForm("queryRef");
  queryParams.value.userId = userStore.userId; // 保持当前用户筛选
  handleQuery();
}

/** 查看详情按钮操作 */
function handleView(row) {
  getDonation(row.donationId).then(response => {
    form.value = response.data;
    viewOpen.value = true;
  });
}

/** 获取证书URL */
function getCertificateUrl(url) {
  if (!url) return '';
  if (isExternal(url) || url.indexOf(baseUrl) !== -1) {
    return url;
  }
  return baseUrl + url;
}

/** 生成证书 */
function generateCertificate(row) {
  // 设置证书数据
  certificateData.certificateNo = 'CERT-' + row.donationId + '-' + Date.now().toString().substring(8);
  certificateData.userName = userStore.name;
  certificateData.projectName = row.projectName;
  certificateData.donationAmount = row.donationAmount;
  certificateData.donationTime = row.donationTime;
  certificateData.issueDate = new Date();

  // 打开证书预览
  certificateOpen.value = true;
}

/** 保存证书 */
function saveCertificate() {
  // 使用html2canvas将证书转为图片
  html2canvas(certificateRef.value, {
    backgroundColor: '#fff',
    scale: 2, // 提高清晰度
  }).then(canvas => {
    // 转换为图片数据
    const imgData = canvas.toDataURL('image/png');

    // 保存证书URL到捐赠记录
    const updateData = {
      donationId: form.value.donationId,
      certificateUrl: imgData, // 实际项目中应该上传到服务器并保存URL
      certificateIssueDate: new Date()
    };

    // 更新捐赠记录
    updateDonation(updateData).then(() => {
      proxy.$modal.msgSuccess("证书生成成功！");
      certificateOpen.value = false;
      // 刷新数据
      getList();
      if (viewOpen.value) {
        // 如果详情页打开，更新详情数据
        getDonation(form.value.donationId).then(response => {
          form.value = response.data;
        });
      }
    });

    // 自动下载证书
    downloadImage(imgData, `捐赠证书-${certificateData.projectName}.png`);
  });
}

/** 下载证书 */
function downloadCertificate(row) {
  if (row.certificateUrl) {
    const url = getCertificateUrl(row.certificateUrl);
    downloadImage(url, `捐赠证书-${row.projectName || '项目'}.png`);
  }
}

/** 下载图片 */
function downloadImage(url, filename) {
  const a = document.createElement('a');
  a.href = url;
  a.download = filename;
  document.body.appendChild(a);
  a.click();
  document.body.removeChild(a);
}

/** 查看区块链信息 */
function viewBlockchainInfo(hash) {
  // 这里可以跳转到区块链浏览器或显示区块链信息
  proxy.$modal.msgInfo(`区块链交易哈希: ${hash}`);
  // 实际项目中可能会跳转到区块链浏览器
  // window.open(`https://example-blockchain-explorer.com/tx/${hash}`, '_blank');
}

/** 添加评价 */
function handleAddComment(row) {
  commentForm.value = {
    projectId: row.projectId,
    projectName: row.projectName,
    donationId: row.donationId,
    rating: 5,
    content: ''
  };
  commentOpen.value = true;
}

/** 提交评价 */
function submitComment() {
  commentRef.value.validate(async (valid) => {
    if (valid) {
      try {
        // 确保包含用户ID
        const commentData = {
          projectId: commentForm.value.projectId,
          userId: userStore.id,
          rating: commentForm.value.rating,
          content: commentForm.value.content
        };

        await addComment(commentData);
        proxy.$modal.msgSuccess("评价提交成功");
        commentOpen.value = false;
        // 刷新列表
        getList();
      } catch (error) {
        console.error("提交评价失败", error);
        proxy.$modal.msgError("评价提交失败，请重试");
      }
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
  margin-bottom: 20px;
}

.certificate-container {
  display: flex;
  justify-content: center;
  padding: 20px;
}

.certificate {
  width: 700px;
  min-height: 500px;
  border: 2px solid #d4b106;
  padding: 40px;
  background-color: #fffef0;
  background-image: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" width="100" height="100" opacity="0.05"><path d="M0,0 L100,100 M100,0 L0,100" stroke="black" stroke-width="1"/></svg>');
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
  position: relative;
  overflow: hidden;
}

.certificate-header {
  text-align: center;
  margin-bottom: 30px;
}

.certificate-header h1 {
  color: #d4b106;
  font-size: 32px;
  margin: 0;
  font-weight: bold;
  letter-spacing: 4px;
}

.certificate-content {
  text-align: center;
  line-height: 1.6;
}

.certificate-text {
  font-size: 18px;
  margin: 10px 0;
}

.certificate-name,
.certificate-amount {
  font-size: 24px;
  font-weight: bold;
  color: #b12020;
  margin: 15px 0;
}

.highlight {
  font-weight: bold;
  color: #1f5bb5;
}

.certificate-thanks {
  margin-top: 30px;
  font-style: italic;
}

.certificate-footer {
  margin-top: 40px;
  display: flex;
  justify-content: space-between;
  align-items: flex-end;
}

.certificate-seal {
  width: 100px;
  height: 100px;
}

.certificate-date {
  text-align: right;
  font-size: 14px;
}

.mt-2 {
  margin-top: 8px;
}

.seal-text {
  font-size: 20px;
  font-weight: bold;
  color: #d4b106;
  margin: 0;
}

.seal-text-small {
  font-size: 12px;
  display: block;
  margin-top: 5px;
}

.seal-circle {
  width: 100px;
  height: 100px;
  border: 3px solid #b12020;
  border-radius: 50%;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  color: #b12020;
  position: relative;
  transform: rotate(-15deg);
}

.seal-circle::before {
  content: '';
  position: absolute;
  top: -10px;
  left: -10px;
  right: -10px;
  bottom: -10px;
  border: 1px solid #b12020;
  border-radius: 50%;
  opacity: 0.5;
}
</style>
