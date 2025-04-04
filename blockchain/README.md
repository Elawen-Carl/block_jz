# 慈善捐赠平台区块链集成

本项目使用FISCO BCOS区块链平台实现资金流向透明化和智能合约管理。

## 合约说明

### CharityProject.sol

主要的慈善项目管理合约，功能包括：

- 项目创建与管理
- 捐赠记录
- 资金使用申请与审核
- 完整的资金流向记录

### FundTransparency.sol

资金透明化专用合约，功能包括：

- 记录所有交易流向
- 提供完整的交易查询功能
- 支持多种交易类型（捐赠、资金使用、退款）
- 分页查询项目和用户交易记录

## 部署说明

### 前提条件

- 安装并运行FISCO BCOS节点（单机或多机）
- JDK 1.8+
- Maven 3.6+

### 部署步骤

1. **编译智能合约**

   ```bash
   cd blockchain
   # 使用FISCO BCOS控制台编译合约
   ./console.sh solidity --compile contracts/CharityProject.sol contracts/FundTransparency.sol
   ```

2. **部署智能合约**

   ```bash
   # 使用FISCO BCOS控制台部署合约
   ./console.sh deploy CharityProject.sol/CharityProject
   ./console.sh deploy FundTransparency.sol/FundTransparency
   ```

   记录下返回的合约地址，后续需要配置

3. **配置应用**

   修改`application.yml`中的区块链配置：

   ```yaml
   blockchain:
     # 是否启用区块链功能
     enable: true
     # 区块链群组ID
     group-id: 1
     # 区块链合约地址（替换为实际部署的地址）
     charity-project-contract: 0x1234567890123456789012345678901234567890
     fund-transparency-contract: 0x0987654321098765432109876543210987654321
   ```

4. **配置证书**

   将FISCO BCOS的SDK证书复制到`backend/ruoyi-admin/src/main/resources/config/certs`目录下：

   - ca.crt
   - sdk.crt
   - sdk.key

## 主要功能

1. **项目上链**：项目创建后自动上链，记录项目信息
2. **捐赠上链**：捐赠记录自动上链，确保资金来源透明
3. **资金使用上链**：资金使用申请和审核流程上链，确保资金去向透明
4. **区块链查询**：提供区块链交易信息查询，包括交易哈希、区块、时间戳等

## 开发指南

### Java SDK集成

系统使用FISCO BCOS Java SDK与区块链进行交互，主要类包括：

- `BlockchainConfig`：配置类，负责初始化SDK
- `BlockchainService`：服务类，提供合约调用方法
- 各Controller类中的区块链集成方法

### 前端集成

前端通过后端API获取区块链信息，主要接口包括：

- `/charity/project/blockchain/{projectId}`：获取项目区块链信息
- `/charity/donation/blockchain/{donationId}`：获取捐赠记录区块链信息
- `/charity/fund/blockchain/{usageId}`：获取资金使用记录区块链信息

前端界面展示区块链信息的卡片，呈现交易哈希、区块高度、时间戳等信息。

## 测试模式

如果没有区块链环境，可以将配置中的`blockchain.enable`设置为`false`，系统将使用模拟数据进行展示，不影响基本功能使用。 