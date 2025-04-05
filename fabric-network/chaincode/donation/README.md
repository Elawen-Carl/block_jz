# 捐赠管理区块链智能合约

本项目包含一套基于Hyperledger Fabric的慈善捐赠平台智能合约，用于管理慈善项目、捐赠记录和资金流向。

## 功能概述

智能合约实现以下主要功能：

1. **用户管理**
   - 用户注册与信息管理
   - 个人隐私设置控制

2. **捐赠管理**
   - 捐赠信息录入与存储
   - 捐赠记录查询
   - 捐赠证书自动生成

3. **慈善项目管理**
   - 项目发布与管理
   - 项目审核流程
   - 项目评价与反馈

4. **资金透明度**
   - 资金流向记录
   - 数据可视化所需的链上数据支持

## 智能合约数据模型

智能合约使用以下主要数据模型：

- **用户(User)**: 存储用户基本信息、捐赠历史和隐私设置
- **捐赠(Donation)**: 记录捐赠交易详情和状态
- **项目(Project)**: 存储慈善项目信息、资金状态和评价
- **证书(Certificate)**: 捐赠证书信息和验证码
- **资金分配(FundAllocation)**: 记录项目资金的使用流向

## 主要API接口

### 用户管理
- `registerUser`: 注册新用户
- `updateUserInfo`: 更新用户信息
- `getUser`: 获取用户信息

### 捐赠管理
- `recordDonation`: 记录新的捐赠
- `getDonation`: 获取捐赠记录
- `generateDonationCertificate`: 生成捐赠证书
- `queryUserDonations`: 查询用户捐赠历史

### 慈善项目管理
- `createCharityProject`: 创建慈善项目
- `approveProject`: 审核慈善项目
- `getProject`: 获取项目信息
- `reviewProject`: 对项目进行评价

### 资金透明度
- `recordFundAllocation`: 记录资金分配
- `getFundAllocation`: 获取资金分配记录
- `queryProjectFundAllocations`: 查询项目的所有资金流向

## 部署说明

智能合约需要在Hyperledger Fabric网络上部署。请确保您的环境已经安装了以下组件：
- Node.js v12或更高版本
- npm v5或更高版本
- Hyperledger Fabric v2.2或更高版本

执行以下命令安装依赖：
```
npm install
```