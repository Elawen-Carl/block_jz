#!/bin/bash

# 设置颜色
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

echo -e "${YELLOW}开始测试链码...${NC}"

# 设置工作目录
cd $(dirname $0)
NETWORK_DIR="$(pwd)/fabric-samples/test-network"

# 设置环境变量
echo -e "${YELLOW}设置环境变量...${NC}"
cd $NETWORK_DIR
export PATH=${PWD}/../bin:$PATH
export FABRIC_CFG_PATH=$PWD/../config/
export CORE_PEER_TLS_ENABLED=true
export CORE_PEER_LOCALMSPID="Org1MSP"
export CORE_PEER_TLS_ROOTCERT_FILE=${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp
export CORE_PEER_ADDRESS=localhost:7051

# 检查网络状态
echo -e "${YELLOW}检查网络状态...${NC}"
docker ps | grep hyperledger

# 检查通道列表
echo -e "${YELLOW}查看通道列表...${NC}"
peer channel list

# 读取用户输入通道名称
echo -e "${YELLOW}请输入要使用的通道名称 [默认: mychannel]: ${NC}"
read -r CHANNEL_NAME
CHANNEL_NAME=${CHANNEL_NAME:-mychannel}
echo -e "${GREEN}使用通道: $CHANNEL_NAME${NC}"

# 读取用户输入链码名称
echo -e "${YELLOW}请输入要测试的链码名称 [默认: waste]: ${NC}"
read -r CC_NAME
CC_NAME=${CC_NAME:-waste}
echo -e "${GREEN}使用链码: $CC_NAME${NC}"

# 查询已安装的链码
echo -e "${YELLOW}查询已安装的链码...${NC}"
peer lifecycle chaincode queryinstalled

echo -e "${YELLOW}查询已提交的链码...${NC}"
peer lifecycle chaincode querycommitted --channelID $CHANNEL_NAME

# 执行链码初始化查询（不修改状态）
echo -e "${YELLOW}测试链码初始化函数...${NC}"
peer chaincode query -C $CHANNEL_NAME -n $CC_NAME -c '{"Args":["initLedger"]}' || echo -e "${YELLOW}初始化函数可能不存在或已执行过，这是正常的${NC}"

# 生成唯一测试ID
TEST_ID="test_$(date +%s)"
echo -e "${YELLOW}使用测试ID: $TEST_ID${NC}"

# 测试记录垃圾投放
echo -e "${YELLOW}测试记录垃圾投放...${NC}"
peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem -C $CHANNEL_NAME -n $CC_NAME --peerAddresses localhost:7051 --tlsRootCertFiles ${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt --peerAddresses localhost:9051 --tlsRootCertFiles ${PWD}/organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt -c "{\"function\":\"recordWasteDisposal\",\"Args\":[\"$TEST_ID\", \"testUser\", \"recyclable\", \"1.5\", \"测试位置\", \"$(date +%s)\"]}"

sleep 3

# 测试查询垃圾投放记录
echo -e "${YELLOW}测试查询垃圾投放记录...${NC}"
peer chaincode query -C $CHANNEL_NAME -n $CC_NAME -c "{\"function\":\"getWasteDisposal\",\"Args\":[\"$TEST_ID\"]}"

# 测试查询用户信息
echo -e "${YELLOW}测试查询用户信息...${NC}"
peer chaincode query -C $CHANNEL_NAME -n $CC_NAME -c '{"function":"getUser","Args":["testUser"]}' || echo -e "${YELLOW}查询用户可能失败，请检查函数名是否正确${NC}"

# 测试按类型查询垃圾
echo -e "${YELLOW}测试按类型查询垃圾...${NC}"
peer chaincode query -C $CHANNEL_NAME -n $CC_NAME -c '{"function":"queryWasteByType","Args":["recyclable"]}' || echo -e "${YELLOW}按类型查询可能失败，请检查函数名是否正确${NC}"

echo -e "${GREEN}链码测试完成${NC}"
echo -e "${GREEN}如果以上测试显示了预期的结果，则链码工作正常${NC}"
echo -e "${GREEN}如果测试失败，请查看错误信息并检查链码实现${NC}" 