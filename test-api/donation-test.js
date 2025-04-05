/**
 * 区块链慈善捐赠平台接口测试脚本
 * 
 * 使用说明:
 * 1. 安装依赖: npm install axios
 * 2. 修改 API_BASE_URL 为您的实际服务器地址
 * 3. 运行脚本: node donation-test.js
 */

const axios = require('axios');
const querystring = require('querystring');

// 配置参数
const API_BASE_URL = 'http://localhost:8080';  // 修改为您的实际服务器地址
const TEST_TIMESTAMP = Date.now();  // 用于生成唯一ID

// 生成测试ID
const testIds = {
    userId: `user_${TEST_TIMESTAMP}`,
    projectId: `project_${TEST_TIMESTAMP}`,
    donationId: `donation_${TEST_TIMESTAMP}`,
    allocationId: `allocation_${TEST_TIMESTAMP}`,
    organizationId: `org_${TEST_TIMESTAMP}`,
};

// 存储测试过程中的状态
const testState = {
    userCreated: false,
    projectCreated: false,
    projectApproved: false,
    donationRecorded: false,
    certificateGenerated: false,
    allocationRecorded: false,
    projectReviewed: false,
};

// HTTP客户端
const client = axios.create({
    baseURL: API_BASE_URL,
    headers: {
        'Content-Type': 'application/x-www-form-urlencoded'
    }
});

// 请求拦截器 - 日志
client.interceptors.request.use(request => {
    console.log(`\n>> 发送请求: ${request.method.toUpperCase()} ${request.url}`);
    if (request.data) {
        console.log('>> 请求数据:', request.data);
    }
    return request;
});

// 响应拦截器 - 日志
client.interceptors.response.use(
    response => {
        console.log(`<< 响应状态: ${response.status}`);
        console.log('<< 响应数据:', JSON.stringify(response.data, null, 2));
        return response;
    },
    error => {
        console.error('<< 请求错误:', error.message);
        if (error.response) {
            console.error('<< 错误状态:', error.response.status);
            console.error('<< 错误数据:', error.response.data);
        }
        return Promise.reject(error);
    }
);

// 测试接口函数
const testApi = {
    // 测试连接
    async testConnection() {
        console.log('\n========== 测试连接 ==========');
        try {
            const response = await client.get('/blockchain/chaincode/connection');
            return response.data.success;
        } catch (error) {
            console.error('测试连接失败');
            return false;
        }
    },

    // 测试初始化账本
    async testInitLedger() {
        console.log('\n========== 测试初始化账本 ==========');
        try {
            const response = await client.get('/blockchain/chaincode/init');
            return response.data.success;
        } catch (error) {
            console.error('初始化账本失败');
            return false;
        }
    },

    // 测试调试接口
    async testDebug() {
        console.log('\n========== 测试调试接口 ==========');
        try {
            const response = await client.get('/blockchain/chaincode/debug');
            return response.data.success;
        } catch (error) {
            console.error('调试接口测试失败');
            return false;
        }
    },

    // 测试查询请求
    async testQuery() {
        console.log('\n========== 测试查询请求 ==========');
        try {
            const response = await client.get('/blockchain/chaincode/test-query');
            return response.data.success;
        } catch (error) {
            console.error('查询请求测试失败');
            return false;
        }
    },

    // 用户注册
    async registerUser() {
        console.log('\n========== 测试用户注册 ==========');
        const data = {
            userId: testIds.userId,
            userInfo: JSON.stringify({
                name: '测试用户',
                contactInfo: '13800138000',
                email: 'test@example.com',
                privacySettings: 'public'
            })
        };

        try {
            const response = await client.post(
                '/blockchain/chaincode/user/register',
                querystring.stringify(data)
            );

            if (response.data.success) {
                testState.userCreated = true;
                return true;
            }
            return false;
        } catch (error) {
            console.error('用户注册失败');
            return false;
        }
    },

    // 获取用户信息
    async getUser() {
        console.log('\n========== 测试获取用户信息 ==========');
        try {
            const response = await client.get(`/blockchain/chaincode/user/${testIds.userId}`);
            return response.data.success;
        } catch (error) {
            console.error('获取用户信息失败');
            return false;
        }
    },

    // 更新用户信息
    async updateUserInfo() {
        console.log('\n========== 测试更新用户信息 ==========');
        const data = {
            updatedInfo: JSON.stringify({
                name: '测试用户(已更新)',
                contactInfo: '13900139000',
                privacySettings: 'private'
            })
        };

        try {
            const response = await client.put(
                `/blockchain/chaincode/user/${testIds.userId}`,
                querystring.stringify(data)
            );
            return response.data.success;
        } catch (error) {
            console.error('更新用户信息失败');
            return false;
        }
    },

    // 创建慈善项目
    async createCharityProject() {
        console.log('\n========== 测试创建慈善项目 ==========');
        const currentDate = new Date();
        const endDate = new Date();
        endDate.setFullYear(currentDate.getFullYear() + 1);

        const data = {
            projectId: testIds.projectId,
            projectInfo: JSON.stringify({
                organizationId: testIds.organizationId,
                name: '测试希望小学项目',
                description: '这是一个测试项目，用于建设希望小学',
                targetAmount: '100000',
                startDate: currentDate.toISOString(),
                endDate: endDate.toISOString()
            })
        };

        try {
            const response = await client.post(
                '/blockchain/chaincode/project/create',
                querystring.stringify(data)
            );

            if (response.data.success) {
                testState.projectCreated = true;
                return true;
            }
            return false;
        } catch (error) {
            console.error('创建慈善项目失败');
            return false;
        }
    },

    // 审核慈善项目
    async approveProject() {
        console.log('\n========== 测试审核慈善项目 ==========');
        const data = {
            organizationId: testIds.organizationId,
            approvalStatus: 'approved',
            remarks: '测试项目，审核通过'
        };

        try {
            const response = await client.put(
                `/blockchain/chaincode/project/${testIds.projectId}/approve`,
                querystring.stringify(data)
            );

            if (response.data.success) {
                testState.projectApproved = true;
                return true;
            }
            return false;
        } catch (error) {
            console.error('审核慈善项目失败');
            return false;
        }
    },

    // 获取项目信息
    async getProject() {
        console.log('\n========== 测试获取项目信息 ==========');
        try {
            const response = await client.get(`/blockchain/chaincode/project/${testIds.projectId}`);
            return response.data.success;
        } catch (error) {
            console.error('获取项目信息失败');
            return false;
        }
    },

    // 记录捐赠
    async recordDonation() {
        console.log('\n========== 测试记录捐赠 ==========');
        const data = {
            donationId: testIds.donationId,
            donorId: testIds.userId,
            projectId: testIds.projectId,
            amount: '1000',
            method: 'credit_card',
            timestamp: new Date().toISOString()
        };

        try {
            const response = await client.post(
                '/blockchain/chaincode/donation/record',
                querystring.stringify(data)
            );

            if (response.data.success) {
                testState.donationRecorded = true;
                return true;
            }
            return false;
        } catch (error) {
            console.error('记录捐赠失败');
            return false;
        }
    },

    // 获取捐赠记录
    async getDonation() {
        console.log('\n========== 测试获取捐赠记录 ==========');
        try {
            const response = await client.get(`/blockchain/chaincode/donation/${testIds.donationId}`);
            return response.data.success;
        } catch (error) {
            console.error('获取捐赠记录失败');
            return false;
        }
    },

    // 生成捐赠证书
    async generateCertificate() {
        console.log('\n========== 测试生成捐赠证书 ==========');
        try {
            const response = await client.post(`/blockchain/chaincode/donation/${testIds.donationId}/certificate`);

            if (response.data.success) {
                testState.certificateGenerated = true;
                return true;
            }
            return false;
        } catch (error) {
            console.error('生成捐赠证书失败');
            return false;
        }
    },

    // 查询用户捐赠历史
    async queryUserDonations() {
        console.log('\n========== 测试查询用户捐赠历史 ==========');
        try {
            const response = await client.get(`/blockchain/chaincode/donation/user/${testIds.userId}`);
            return response.data.success;
        } catch (error) {
            console.error('查询用户捐赠历史失败');
            return false;
        }
    },

    // 记录资金分配
    async recordFundAllocation() {
        console.log('\n========== 测试记录资金分配 ==========');
        const data = {
            allocationId: testIds.allocationId,
            projectId: testIds.projectId,
            amount: '500',
            purpose: '购买建筑材料',
            recipient: '建材供应商',
            timestamp: new Date().toISOString()
        };

        try {
            const response = await client.post(
                '/blockchain/chaincode/fund/allocation',
                querystring.stringify(data)
            );

            if (response.data.success) {
                testState.allocationRecorded = true;
                return true;
            }
            return false;
        } catch (error) {
            console.error('记录资金分配失败');
            return false;
        }
    },

    // 获取资金分配记录
    async getFundAllocation() {
        console.log('\n========== 测试获取资金分配记录 ==========');
        try {
            const response = await client.get(`/blockchain/chaincode/fund/allocation/${testIds.allocationId}`);
            return response.data.success;
        } catch (error) {
            console.error('获取资金分配记录失败');
            return false;
        }
    },

    // 查询项目资金流向
    async queryProjectFundAllocations() {
        console.log('\n========== 测试查询项目资金流向 ==========');
        try {
            const response = await client.get(`/blockchain/chaincode/fund/allocation/project/${testIds.projectId}`);
            return response.data.success;
        } catch (error) {
            console.error('查询项目资金流向失败');
            return false;
        }
    },

    // 项目评价
    async reviewProject() {
        console.log('\n========== 测试项目评价 ==========');
        const data = {
            userId: testIds.userId,
            rating: '5',
            comment: '这个项目很棒，非常有意义！'
        };

        try {
            const response = await client.post(
                `/blockchain/chaincode/project/${testIds.projectId}/review`,
                querystring.stringify(data)
            );

            if (response.data.success) {
                testState.projectReviewed = true;
                return true;
            }
            return false;
        } catch (error) {
            console.error('项目评价失败');
            return false;
        }
    },

    // 自动化完整测试流程
    async testFullProcess() {
        console.log('\n========== 测试完整流程 ==========');
        try {
            const response = await client.get('/blockchain/chaincode/full-test');
            return response.data.success;
        } catch (error) {
            console.error('完整测试流程失败');
            return false;
        }
    }
};

// 主测试流程
async function runTests() {
    console.log('============================================');
    console.log('  区块链慈善捐赠平台接口测试');
    console.log('============================================');
    console.log('测试时间戳:', TEST_TIMESTAMP);
    console.log('测试 ID:');
    Object.entries(testIds).forEach(([key, value]) => {
        console.log(`  ${key}: ${value}`);
    });
    console.log('============================================');

    try {
        // 连接和基础测试
        const isConnected = await testApi.testConnection();
        if (!isConnected) {
            throw new Error('连接测试失败，终止测试');
        }

        await testApi.testDebug();
        await testApi.testQuery();
        await testApi.testInitLedger();

        // 阶段 1: 用户和项目管理
        await testApi.registerUser();
        if (testState.userCreated) {
            await testApi.getUser();
            await testApi.updateUserInfo();
        } else {
            console.warn('用户创建失败，跳过用户相关测试');
        }

        await testApi.createCharityProject();
        if (testState.projectCreated) {
            await testApi.getProject();
            await testApi.approveProject();
        } else {
            console.warn('项目创建失败，跳过项目相关测试');
        }

        // 阶段 2: 捐赠管理
        if (testState.userCreated && testState.projectApproved) {
            await testApi.recordDonation();
            if (testState.donationRecorded) {
                await testApi.getDonation();
                await testApi.generateCertificate();
                await testApi.queryUserDonations();
            } else {
                console.warn('捐赠记录创建失败，跳过捐赠相关测试');
            }
        } else {
            console.warn('用户或项目准备不完整，跳过捐赠相关测试');
        }

        // 阶段 3: 资金管理和评价
        if (testState.projectApproved && testState.donationRecorded) {
            await testApi.recordFundAllocation();
            if (testState.allocationRecorded) {
                await testApi.getFundAllocation();
                await testApi.queryProjectFundAllocations();
            } else {
                console.warn('资金分配记录创建失败，跳过资金相关测试');
            }

            await testApi.reviewProject();
            await testApi.getProject(); // 再次获取项目信息，查看评价后的变化
        } else {
            console.warn('项目或捐赠准备不完整，跳过资金和评价相关测试');
        }

        // 自动化完整测试
        console.log('\n==== 开始自动化完整测试流程 ====');
        await testApi.testFullProcess();

        // 测试总结
        console.log('\n============================================');
        console.log('  测试完成');
        console.log('============================================');
        console.log('测试状态:');
        Object.entries(testState).forEach(([key, value]) => {
            console.log(`  ${key}: ${value ? '✓' : '✗'}`);
        });
        console.log('============================================');

    } catch (error) {
        console.error('\n测试过程中发生错误:', error.message);
    }
}

// 运行测试
runTests();