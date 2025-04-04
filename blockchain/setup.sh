#!/bin/bash

# 创建区块链相关目录
mkdir -p contracts/abi
mkdir -p config/certs

echo "创建合约目录结构成功！"

# 创建一个简单的ABI文件用于测试
cat > contracts/abi/CharityProject.abi << EOF
[
  {
    "constant": true,
    "inputs": [{"name": "projectId", "type": "string"}],
    "name": "getProject",
    "outputs": [
      {"name": "id", "type": "string"},
      {"name": "name", "type": "string"},
      {"name": "description", "type": "string"},
      {"name": "targetAmount", "type": "uint256"},
      {"name": "currentAmount", "type": "uint256"},
      {"name": "startTime", "type": "uint256"},
      {"name": "endTime", "type": "uint256"},
      {"name": "status", "type": "uint8"}
    ],
    "payable": false,
    "stateMutability": "view",
    "type": "function"
  },
  {
    "constant": false,
    "inputs": [
      {"name": "projectId", "type": "string"},
      {"name": "name", "type": "string"},
      {"name": "description", "type": "string"},
      {"name": "targetAmount", "type": "uint256"},
      {"name": "startTime", "type": "uint256"},
      {"name": "endTime", "type": "uint256"}
    ],
    "name": "createProject",
    "outputs": [],
    "payable": false,
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "constant": false,
    "inputs": [
      {"name": "projectId", "type": "string"},
      {"name": "donationId", "type": "string"},
      {"name": "donorId", "type": "string"},
      {"name": "amount", "type": "uint256"}
    ],
    "name": "donate",
    "outputs": [],
    "payable": false,
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "constant": false,
    "inputs": [
      {"name": "projectId", "type": "string"},
      {"name": "usageId", "type": "string"},
      {"name": "amount", "type": "uint256"},
      {"name": "description", "type": "string"}
    ],
    "name": "applyFundUsage",
    "outputs": [],
    "payable": false,
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "constant": false,
    "inputs": [
      {"name": "usageId", "type": "string"},
      {"name": "approved", "type": "bool"}
    ],
    "name": "approveFundUsage",
    "outputs": [],
    "payable": false,
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "constant": true,
    "inputs": [{"name": "usageId", "type": "string"}],
    "name": "getFundUsage",
    "outputs": [
      {"name": "id", "type": "string"},
      {"name": "projectId", "type": "string"},
      {"name": "amount", "type": "uint256"},
      {"name": "description", "type": "string"},
      {"name": "status", "type": "uint8"},
      {"name": "approved", "type": "bool"}
    ],
    "payable": false,
    "stateMutability": "view",
    "type": "function"
  }
]
EOF

cat > contracts/abi/FundTransparency.abi << EOF
[
  {
    "constant": true,
    "inputs": [
      {"name": "userId", "type": "string"},
      {"name": "offset", "type": "uint256"},
      {"name": "limit", "type": "uint256"}
    ],
    "name": "getTransactionsByUser",
    "outputs": [
      {"name": "total", "type": "uint256"},
      {"name": "records", "type": "tuple[]", "components": [
        {"name": "id", "type": "string"},
        {"name": "projectId", "type": "string"},
        {"name": "userId", "type": "string"},
        {"name": "amount", "type": "uint256"},
        {"name": "txType", "type": "uint8"},
        {"name": "timestamp", "type": "uint256"}
      ]}
    ],
    "payable": false,
    "stateMutability": "view",
    "type": "function"
  },
  {
    "constant": true,
    "inputs": [
      {"name": "projectId", "type": "string"},
      {"name": "offset", "type": "uint256"},
      {"name": "limit", "type": "uint256"}
    ],
    "name": "getTransactionsByProject",
    "outputs": [
      {"name": "total", "type": "uint256"},
      {"name": "records", "type": "tuple[]", "components": [
        {"name": "id", "type": "string"},
        {"name": "projectId", "type": "string"},
        {"name": "userId", "type": "string"},
        {"name": "amount", "type": "uint256"},
        {"name": "txType", "type": "uint8"},
        {"name": "timestamp", "type": "uint256"}
      ]}
    ],
    "payable": false,
    "stateMutability": "view",
    "type": "function"
  }
]
EOF

echo "已创建示例ABI文件"

# 创建测试证书目录
touch config/certs/ca.crt
touch config/certs/sdk.crt
touch config/certs/sdk.key

echo "已创建占位证书文件（实际部署时需要替换为真实证书）"

# 准备package.json
cat > package.json << EOF
{
  "name": "charity-blockchain",
  "version": "1.0.0",
  "description": "区块链慈善捐赠平台测试环境",
  "main": "test-contract.js",
  "scripts": {
    "test": "node test-contract.js"
  },
  "dependencies": {
    "web3": "^1.5.3"
  }
}
EOF

echo "已创建package.json文件"
echo "=========================================="
echo "区块链环境初始化完成！"
echo "请运行 'npm install' 安装依赖"
echo "然后执行 'node test-contract.js' 进行测试"
echo "=========================================="

chmod +x setup.sh

echo "脚本已设置为可执行，请运行 './setup.sh' 完成环境配置" 