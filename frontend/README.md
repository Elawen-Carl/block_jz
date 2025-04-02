# 垃圾分类智能合约部署指南

本文档介绍如何将垃圾分类和积分管理智能合约部署到Hyperledger Fabric网络。

## 前提条件

1. 已安装Hyperledger Fabric 2.x
2. 已启动Fabric测试网络
3. 已安装Node.js 12+和npm 5+

## 部署步骤

### 1. 准备智能合约

智能合约位于`wastemanagement`目录中，包含以下文件：
- `src/index.js`: 合约主代码
- `package.json`: 依赖配置

### 2. 打包智能合约

```bash
cd wastemanagement
npm install
cd ..
peer lifecycle chaincode package wastemanagement.tar.gz --path ./wastemanagement --lang node --label wastemanagement_1.0
```

### 3. 安装智能合约

```bash
# 在所有需要的节点上安装智能合约
peer lifecycle chaincode install wastemanagement.tar.gz
```

### 4. 批准智能合约

```bash
# 获取智能合约包ID
peer lifecycle chaincode queryinstalled

# 批准智能合约定义(替换PACKAGE_ID为上一步查询到的ID)
peer lifecycle chaincode approveformyorg -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --channelID mychannel --name wastemanagement --version 1.0 --package-id PACKAGE_ID --sequence 1 --tls --cafile ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem
```

### 5. 提交智能合约定义

```bash
peer lifecycle chaincode commit -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --channelID mychannel --name wastemanagement --version 1.0 --sequence 1 --tls --cafile ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem --peerAddresses localhost:7051 --tlsRootCertFiles ${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt --peerAddresses localhost:9051 --tlsRootCertFiles ${PWD}/organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt
```

### 6. 初始化智能合约

```bash
peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem -C mychannel -n wastemanagement --peerAddresses localhost:7051 --tlsRootCertFiles ${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt --peerAddresses localhost:9051 --tlsRootCertFiles ${PWD}/organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt -c '{"function":"initLedger","Args":[]}'
```

### 7. 测试智能合约

```bash
# 查询区块高度
peer chaincode query -C mychannel -n wastemanagement -c '{"function":"getBlockHeight","Args":[]}'

# 记录垃圾分类数据 (参数: 记录ID, 用户ID, 分类ID, 重量, 位置, 图片URL, 积分)
peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem -C mychannel -n wastemanagement --peerAddresses localhost:7051 --tlsRootCertFiles ${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt --peerAddresses localhost:9051 --tlsRootCertFiles ${PWD}/organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt -c '{"function":"recordWasteClassification","Args":["1", "1001", "2", "1.5", "北京市朝阳区", "http://example.com/image.jpg", "25"]}'

# 记录积分交易 (参数: 记录ID, 用户ID, 积分值, 类型, 描述)
peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem -C mychannel -n wastemanagement --peerAddresses localhost:7051 --tlsRootCertFiles ${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt --peerAddresses localhost:9051 --tlsRootCertFiles ${PWD}/organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt -c '{"function":"recordPointsTransaction","Args":["1", "1001", "25", "1", "正确投放有害垃圾，获得积分奖励"]}'

# 查询用户积分历史 (参数: 用户ID)
peer chaincode query -C mychannel -n wastemanagement -c '{"function":"queryUserPointsHistory","Args":["1001"]}'
```

## 配置Java应用程序

1. 在部署目录中创建配置文件目录：`${user.dir}/fabric-config/`
2. 将网络连接配置文件保存为`${user.dir}/fabric-config/connection.json`
3. 将用户证书钱包保存到`${user.dir}/fabric-config/wallet/`目录

## 注意事项

1. 确保应用程序拥有正确的证书和权限访问Fabric网络
2. 测试网络中部署完成后，确保通过适当的身份验证
3. 在生产环境中，应当采用更严格的安全措施和权限控制 