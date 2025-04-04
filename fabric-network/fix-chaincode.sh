#!/bin/bash

# 设置颜色
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

echo -e "${YELLOW}开始修复链码部署问题...${NC}"

# 设置工作目录
cd $(dirname $0)
NETWORK_DIR="$(pwd)/fabric-samples/test-network"
CHAINCODE_DIR="$(pwd)/chaincode/wastemanagement"
LOG_FILE="$(pwd)/chaincode-deploy.log"

# 开始记录日志
exec > >(tee -a ${LOG_FILE}) 2>&1
echo "=========================== $(date) ==========================="

# 检查链码
echo -e "${YELLOW}检查链码目录: $CHAINCODE_DIR ${NC}"

if [ ! -d "$CHAINCODE_DIR" ]; then
    echo -e "${RED}链码目录不存在!${NC}"
    exit 1
fi

# 检查并重新安装npm依赖
echo -e "${YELLOW}检查并重新安装npm依赖...${NC}"
cd $CHAINCODE_DIR
echo -e "${YELLOW}当前目录: $(pwd)${NC}"

# 显示Node.js和npm版本
echo -e "${YELLOW}Node.js版本:${NC}"
node -v
echo -e "${YELLOW}NPM版本:${NC}"
npm -v

# 删除node_modules和package-lock.json，进行全新安装
echo -e "${YELLOW}删除旧的依赖...${NC}"
rm -rf node_modules package-lock.json

# 重新安装依赖
echo -e "${YELLOW}安装新的依赖...${NC}"
npm install --verbose

# 检查语法错误
echo -e "${YELLOW}检查JavaScript语法错误...${NC}"
node --check index.js
if [ $? -ne 0 ]; then
    echo -e "${RED}链码语法检查失败!${NC}"
    exit 1
else
    echo -e "${GREEN}链码语法检查通过${NC}"
fi

# 返回到网络目录
cd $NETWORK_DIR


# 检查Docker状态
echo -e "${YELLOW}检查Docker状态...${NC}"
docker ps
docker ps -a | grep peer

# 查看链码状态
echo -e "${YELLOW}查看链码状态...${NC}"
peer lifecycle chaincode queryinstalled

# 删除旧链码容器和镜像 (如果存在)
echo -e "${YELLOW}清理旧的链码容器和镜像...${NC}"
CHAINCODE_IMAGES=$(docker images -q --filter reference='dev-peer*')
if [ ! -z "$CHAINCODE_IMAGES" ]; then
    docker rmi -f $CHAINCODE_IMAGES
    echo -e "${GREEN}已删除链码镜像${NC}"
fi

CHAINCODE_CONTAINERS=$(docker ps -a -q --filter name='dev-peer*')
if [ ! -z "$CHAINCODE_CONTAINERS" ]; then
    docker rm -f $CHAINCODE_CONTAINERS
    echo -e "${GREEN}已删除链码容器${NC}"
fi

# 完全重启网络（可选，取消注释以执行）
echo -e "${YELLOW}是否要完全重启网络? [y/N]${NC}"
read -r answer
if [[ "$answer" =~ ^[Yy]$ ]]; then
    echo -e "${YELLOW}关闭网络...${NC}"
    ./network.sh down
    
    echo -e "${YELLOW}启动网络...${NC}"
    ./network.sh up
    
    echo -e "${YELLOW}创建通道...${NC}"
    ./network.sh createChannel -c wastechannel
fi

# 重新部署链码
echo -e "${YELLOW}重新部署链码...${NC}"
# 使用更详细的输出
export FABRIC_LOGGING_SPEC=DEBUG
./network.sh deployCC -c wastechannel -ccn waste -ccp ../../chaincode/wastemanagement -ccl javascript -ccv 1.2 -ccs 2 -verbose

# 输出结果
if [ $? -ne 0 ]; then
    echo -e "${RED}链码部署失败!${NC}"
    exit 1
else
    echo -e "${GREEN}链码部署成功!${NC}"
    
    # 显示Docker中链码容器状态
    echo -e "${YELLOW}链码容器状态:${NC}"
    docker ps | grep waste
    
    echo -e "${GREEN}请重新启动您的Spring Boot应用程序，测试与链码的连接。${NC}"
fi

# 检查链码日志 (如果有容器)
CONTAINER_ID=$(docker ps | grep waste | awk '{print $1}')
if [ ! -z "$CONTAINER_ID" ]; then
    echo -e "${YELLOW}显示链码容器日志:${NC}"
    docker logs $CONTAINER_ID
else
    echo -e "${RED}未找到链码容器${NC}"
fi 