#!/bin/bash

# 设置颜色代码
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
NC='\033[0m' # 无颜色

# 设置源路径和目标路径
FABRIC_NETWORK_PATH="$(pwd)/fabric-samples/test-network"
PROJECT_PATH="$(cd .. && pwd)/backend/ruoyi-admin/src/main/resources/fabric"

echo -e "${YELLOW}开始导出Fabric网络证书和配置文件...${NC}"
echo -e "${YELLOW}源路径: ${FABRIC_NETWORK_PATH}${NC}"
echo -e "${YELLOW}目标路径: ${PROJECT_PATH}${NC}"

# 检查源路径是否存在
if [ ! -d "$FABRIC_NETWORK_PATH" ]; then
    echo -e "${RED}错误：源路径不存在: ${FABRIC_NETWORK_PATH}${NC}"
    echo -e "${YELLOW}请确认fabric-samples/test-network目录存在${NC}"
    exit 1
fi

# 创建目标目录
mkdir -p $PROJECT_PATH/crypto-config/peerOrganizations/org1.example.com/users/User1@org1.example.com/msp/signcerts
mkdir -p $PROJECT_PATH/crypto-config/peerOrganizations/org1.example.com/users/User1@org1.example.com/msp/keystore
mkdir -p $PROJECT_PATH/crypto-config/peerOrganizations/org1.example.com/users/User1@org1.example.com/msp/admincerts
mkdir -p $PROJECT_PATH/crypto-config/peerOrganizations/org1.example.com/users/User1@org1.example.com/msp/cacerts
mkdir -p $PROJECT_PATH/crypto-config/peerOrganizations/org1.example.com/users/User1@org1.example.com/msp/tlscacerts
mkdir -p $PROJECT_PATH/crypto-config/peerOrganizations/org1.example.com/users/User1@org1.example.com/tls
mkdir -p $PROJECT_PATH/crypto-config/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls
mkdir -p $PROJECT_PATH/crypto-config/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/msp
mkdir -p $PROJECT_PATH/crypto-config/peerOrganizations/org1.example.com/ca
mkdir -p $PROJECT_PATH/crypto-config/peerOrganizations/org1.example.com/tlsca

# 为org2创建目录
mkdir -p $PROJECT_PATH/crypto-config/peerOrganizations/org2.example.com/users/User1@org2.example.com/msp/signcerts
mkdir -p $PROJECT_PATH/crypto-config/peerOrganizations/org2.example.com/users/User1@org2.example.com/msp/keystore
mkdir -p $PROJECT_PATH/crypto-config/peerOrganizations/org2.example.com/users/User1@org2.example.com/msp/admincerts
mkdir -p $PROJECT_PATH/crypto-config/peerOrganizations/org2.example.com/users/User1@org2.example.com/msp/cacerts
mkdir -p $PROJECT_PATH/crypto-config/peerOrganizations/org2.example.com/users/User1@org2.example.com/msp/tlscacerts
mkdir -p $PROJECT_PATH/crypto-config/peerOrganizations/org2.example.com/users/User1@org2.example.com/tls
mkdir -p $PROJECT_PATH/crypto-config/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls
mkdir -p $PROJECT_PATH/crypto-config/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/msp
mkdir -p $PROJECT_PATH/crypto-config/peerOrganizations/org2.example.com/ca
mkdir -p $PROJECT_PATH/crypto-config/peerOrganizations/org2.example.com/tlsca

# 为orderer创建目录
mkdir -p $PROJECT_PATH/crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/msp
mkdir -p $PROJECT_PATH/crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/tls
mkdir -p $PROJECT_PATH/crypto-config/ordererOrganizations/example.com/ca
mkdir -p $PROJECT_PATH/crypto-config/ordererOrganizations/example.com/tlsca
mkdir -p $PROJECT_PATH/connection-profiles

# 复制Org1证书
echo -e "${YELLOW}正在复制Org1的证书和私钥...${NC}"

# 复制User1证书和私钥 - 完整的MSP结构
echo -e "${YELLOW}复制User1@org1.example.com的完整MSP结构...${NC}"

# 检查并显示signcerts目录内容
echo -e "${YELLOW}检查User1@org1.example.com的signcerts目录...${NC}"
SIGNCERTS_PATH="$FABRIC_NETWORK_PATH/organizations/peerOrganizations/org1.example.com/users/User1@org1.example.com/msp/signcerts"
if [ -d "$SIGNCERTS_PATH" ]; then
    echo -e "${GREEN}✓ signcerts目录存在${NC}"
    ls -la "$SIGNCERTS_PATH"
    
    # 查找签名证书文件
    CERT_FILE=$(find "$SIGNCERTS_PATH" -name "*.pem" | head -n 1)
    if [ -n "$CERT_FILE" ]; then
        echo -e "${GREEN}找到签名证书: $CERT_FILE${NC}"
        cp "$CERT_FILE" \
           $PROJECT_PATH/crypto-config/peerOrganizations/org1.example.com/users/User1@org1.example.com/msp/signcerts/User1@org1.example.com-cert.pem
        echo -e "${GREEN}✓ 复制签名证书成功${NC}"
    else
        echo -e "${RED}未找到签名证书文件${NC}"
    fi
else
    echo -e "${RED}signcerts目录不存在${NC}"
    # 尝试在其他位置查找
    echo -e "${YELLOW}尝试查找可能的证书位置...${NC}"
    find "$FABRIC_NETWORK_PATH/organizations/peerOrganizations/org1.example.com" -name "*.pem" | grep -i user1 | grep -v keystore
fi

# 复制私钥 - 使用精确方法确保复制的文件名正确
echo -e "${YELLOW}检查User1@org1.example.com的keystore目录...${NC}"
KEYSTORE_PATH="$FABRIC_NETWORK_PATH/organizations/peerOrganizations/org1.example.com/users/User1@org1.example.com/msp/keystore"
if [ -d "$KEYSTORE_PATH" ]; then
    echo -e "${GREEN}✓ keystore目录存在${NC}"
    ls -la "$KEYSTORE_PATH"
    
    # 查找私钥文件
    KEY_FILE=$(find "$KEYSTORE_PATH" -type f | head -n 1)
    if [ -n "$KEY_FILE" ]; then
        echo -e "${GREEN}找到私钥: $KEY_FILE${NC}"
        cp "$KEY_FILE" \
           $PROJECT_PATH/crypto-config/peerOrganizations/org1.example.com/users/User1@org1.example.com/msp/keystore/priv_sk
        echo -e "${GREEN}✓ 复制私钥成功${NC}"
    else
        echo -e "${RED}未找到私钥文件${NC}"
    fi
else
    echo -e "${RED}keystore目录不存在${NC}"
fi

# 复制或创建admincerts (在某些版本中可能不存在)
echo -e "${YELLOW}尝试复制admincerts...${NC}"
if [ -d "$FABRIC_NETWORK_PATH/organizations/peerOrganizations/org1.example.com/users/User1@org1.example.com/msp/admincerts" ]; then
    cp -r $FABRIC_NETWORK_PATH/organizations/peerOrganizations/org1.example.com/users/User1@org1.example.com/msp/admincerts/* \
       $PROJECT_PATH/crypto-config/peerOrganizations/org1.example.com/users/User1@org1.example.com/msp/admincerts/
    echo -e "${GREEN}✓ 从原始目录复制admincerts成功${NC}"
else
    # 如果找到了签名证书，就使用它作为admincerts
    if [ -n "$CERT_FILE" ]; then
        cp "$CERT_FILE" \
           $PROJECT_PATH/crypto-config/peerOrganizations/org1.example.com/users/User1@org1.example.com/msp/admincerts/User1@org1.example.com-cert.pem
        echo -e "${GREEN}✓ 使用签名证书作为admincerts${NC}"
    else
        echo -e "${RED}无法创建admincerts，签名证书未找到${NC}"
    fi
fi

# 复制cacerts和tlscacerts - 先检查目录是否存在
echo -e "${YELLOW}尝试复制cacerts和tlscacerts...${NC}"

# 复制cacerts
if [ -d "$FABRIC_NETWORK_PATH/organizations/peerOrganizations/org1.example.com/users/User1@org1.example.com/msp/cacerts" ]; then
    cp -r $FABRIC_NETWORK_PATH/organizations/peerOrganizations/org1.example.com/users/User1@org1.example.com/msp/cacerts/* \
       $PROJECT_PATH/crypto-config/peerOrganizations/org1.example.com/users/User1@org1.example.com/msp/cacerts/
    echo -e "${GREEN}✓ 复制cacerts成功${NC}"
else
    echo -e "${YELLOW}用户级cacerts目录不存在，尝试从组织级别复制...${NC}"
    if [ -d "$FABRIC_NETWORK_PATH/organizations/peerOrganizations/org1.example.com/msp/cacerts" ]; then
        cp -r $FABRIC_NETWORK_PATH/organizations/peerOrganizations/org1.example.com/msp/cacerts/* \
           $PROJECT_PATH/crypto-config/peerOrganizations/org1.example.com/users/User1@org1.example.com/msp/cacerts/
        echo -e "${GREEN}✓ 从组织级别复制cacerts成功${NC}"
    else
        echo -e "${RED}组织级cacerts目录也不存在${NC}"
    fi
fi

# 复制tlscacerts
if [ -d "$FABRIC_NETWORK_PATH/organizations/peerOrganizations/org1.example.com/users/User1@org1.example.com/msp/tlscacerts" ]; then
    cp -r $FABRIC_NETWORK_PATH/organizations/peerOrganizations/org1.example.com/users/User1@org1.example.com/msp/tlscacerts/* \
       $PROJECT_PATH/crypto-config/peerOrganizations/org1.example.com/users/User1@org1.example.com/msp/tlscacerts/
    echo -e "${GREEN}✓ 复制tlscacerts成功${NC}"
else
    echo -e "${YELLOW}用户级tlscacerts目录不存在，尝试从组织级别复制...${NC}"
    if [ -d "$FABRIC_NETWORK_PATH/organizations/peerOrganizations/org1.example.com/msp/tlscacerts" ]; then
        cp -r $FABRIC_NETWORK_PATH/organizations/peerOrganizations/org1.example.com/msp/tlscacerts/* \
           $PROJECT_PATH/crypto-config/peerOrganizations/org1.example.com/users/User1@org1.example.com/msp/tlscacerts/
        echo -e "${GREEN}✓ 从组织级别复制tlscacerts成功${NC}"
    else
        echo -e "${RED}组织级tlscacerts目录也不存在${NC}"
    fi
fi

# 复制TLS证书 - 先检查目录是否存在
echo -e "${YELLOW}尝试复制User1 TLS证书...${NC}"
if [ -d "$FABRIC_NETWORK_PATH/organizations/peerOrganizations/org1.example.com/users/User1@org1.example.com/tls" ]; then
    cp -r $FABRIC_NETWORK_PATH/organizations/peerOrganizations/org1.example.com/users/User1@org1.example.com/tls/* \
       $PROJECT_PATH/crypto-config/peerOrganizations/org1.example.com/users/User1@org1.example.com/tls/
    echo -e "${GREEN}✓ 复制User1 TLS证书成功${NC}"
else
    echo -e "${RED}User1 TLS目录不存在${NC}"
fi

# 复制peer节点证书和TLS证书
echo -e "${YELLOW}复制peer0.org1.example.com证书...${NC}"

# 复制peer节点MSP
if [ -d "$FABRIC_NETWORK_PATH/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/msp" ]; then
    cp -r $FABRIC_NETWORK_PATH/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/msp \
       $PROJECT_PATH/crypto-config/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/
    echo -e "${GREEN}✓ 复制peer0.org1 MSP成功${NC}"
else
    echo -e "${RED}peer0.org1 MSP目录不存在${NC}"
fi

# 复制peer节点TLS证书
if [ -d "$FABRIC_NETWORK_PATH/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls" ]; then
    cp -r $FABRIC_NETWORK_PATH/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/* \
       $PROJECT_PATH/crypto-config/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/
    echo -e "${GREEN}✓ 复制peer0.org1 TLS证书成功${NC}"
else
    echo -e "${RED}peer0.org1 TLS目录不存在${NC}"
fi

# 复制CA和TLSCA证书
echo -e "${YELLOW}复制org1 CA和TLSCA证书...${NC}"

# 复制CA证书
if [ -d "$FABRIC_NETWORK_PATH/organizations/peerOrganizations/org1.example.com/ca" ]; then
    cp -r $FABRIC_NETWORK_PATH/organizations/peerOrganizations/org1.example.com/ca/* \
       $PROJECT_PATH/crypto-config/peerOrganizations/org1.example.com/ca/
    echo -e "${GREEN}✓ 复制org1 CA证书成功${NC}"
else
    echo -e "${RED}org1 CA目录不存在${NC}"
fi

# 复制TLSCA证书
if [ -d "$FABRIC_NETWORK_PATH/organizations/peerOrganizations/org1.example.com/tlsca" ]; then
    cp -r $FABRIC_NETWORK_PATH/organizations/peerOrganizations/org1.example.com/tlsca/* \
       $PROJECT_PATH/crypto-config/peerOrganizations/org1.example.com/tlsca/
    echo -e "${GREEN}✓ 复制org1 TLSCA证书成功${NC}"
else
    echo -e "${RED}org1 TLSCA目录不存在${NC}"
fi

# 复制组织MSP
echo -e "${YELLOW}复制org1 MSP...${NC}"
if [ -d "$FABRIC_NETWORK_PATH/organizations/peerOrganizations/org1.example.com/msp" ]; then
    cp -r $FABRIC_NETWORK_PATH/organizations/peerOrganizations/org1.example.com/msp \
       $PROJECT_PATH/crypto-config/peerOrganizations/org1.example.com/
    echo -e "${GREEN}✓ 复制org1 MSP成功${NC}"
else
    echo -e "${RED}org1 MSP目录不存在${NC}"
fi

# Org2和Orderer的证书复制类似，但我们先跳过以确保Org1的证书正确
echo -e "${YELLOW}跳过org2和orderer的证书复制，以确保org1证书正确...${NC}"

# 复制连接配置文件
echo -e "${YELLOW}正在复制连接配置文件...${NC}"
if [ -f "$FABRIC_NETWORK_PATH/organizations/peerOrganizations/org1.example.com/connection-org1.json" ]; then
    cp $FABRIC_NETWORK_PATH/organizations/peerOrganizations/org1.example.com/connection-org1.json \
       $PROJECT_PATH/connection-profiles/
    echo -e "${GREEN}✓ 复制connection-org1.json成功${NC}"
else
    echo -e "${RED}connection-org1.json不存在${NC}"
fi

if [ -f "$FABRIC_NETWORK_PATH/organizations/peerOrganizations/org1.example.com/connection-org1.yaml" ]; then
    cp $FABRIC_NETWORK_PATH/organizations/peerOrganizations/org1.example.com/connection-org1.yaml \
       $PROJECT_PATH/connection-profiles/
    echo -e "${GREEN}✓ 复制connection-org1.yaml成功${NC}"
else
    echo -e "${RED}connection-org1.yaml不存在${NC}"
fi

# 检查必要文件是否存在
echo -e "${YELLOW}检查关键文件是否已成功导出...${NC}"

if [ -f "$PROJECT_PATH/crypto-config/peerOrganizations/org1.example.com/users/User1@org1.example.com/msp/signcerts/User1@org1.example.com-cert.pem" ]; then
    echo -e "${GREEN}✓ User1@org1.example.com 签名证书导出成功${NC}"
else
    echo -e "${RED}✗ User1@org1.example.com 签名证书导出失败${NC}"
fi

if [ -f "$PROJECT_PATH/crypto-config/peerOrganizations/org1.example.com/users/User1@org1.example.com/msp/keystore/priv_sk" ]; then
    echo -e "${GREEN}✓ User1@org1.example.com 私钥导出成功${NC}"
else
    echo -e "${RED}✗ User1@org1.example.com 私钥导出失败${NC}"
fi

if [ -f "$PROJECT_PATH/crypto-config/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt" ]; then
    echo -e "${GREEN}✓ peer0.org1.example.com TLS证书导出成功${NC}"
else
    echo -e "${RED}✗ peer0.org1.example.com TLS证书导出失败${NC}"
fi

if [ -f "$PROJECT_PATH/connection-profiles/connection-org1.json" ]; then
    echo -e "${GREEN}✓ connection-org1.json 配置文件导出成功${NC}"
else
    echo -e "${RED}✗ connection-org1.json 配置文件导出失败${NC}"
fi

echo -e "${GREEN}证书和配置文件导出完成！${NC}"
echo -e "${GREEN}文件已导出到: $PROJECT_PATH${NC}" 