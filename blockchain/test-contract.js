// FISCO BCOS Web3j 合约测试脚本

const Configuration = require('./configuration');
const Web3jService = require('./web3j');

// 配置信息
const config = new Configuration();
// 初始化web3j服务
const web3j = new Web3jService(config);

// 慈善项目合约ABI和地址
const charityProjectAbi = require('./contracts/abi/CharityProject.abi');
const charityProjectAddress = '0x1234567890123456789012345678901234567890'; // 替换为实际部署的合约地址

// 资金透明合约ABI和地址
const fundTransparencyAbi = require('./contracts/abi/FundTransparency.abi');
const fundTransparencyAddress = '0x0987654321098765432109876543210987654321'; // 替换为实际部署的合约地址

// 初始化合约实例
const charityProject = web3j.createContractObject(charityProjectAbi, charityProjectAddress);
const fundTransparency = web3j.createContractObject(fundTransparencyAbi, fundTransparencyAddress);

// 测试函数
async function testContracts() {
    try {
        console.log('========== 测试慈善项目合约 ==========');

        // 1. 创建项目
        const projectId = "PROJECT_" + Date.now();
        const projectName = "测试公益项目";
        const projectDesc = "这是一个用于测试的公益项目";
        const targetAmount = 100000;
        const startTime = Math.floor(Date.now() / 1000);
        const endTime = startTime + 30 * 24 * 3600; // 30天后结束

        console.log(`创建项目: ${projectName}`);
        const createTx = await charityProject.methods.createProject(
            projectId,
            projectName,
            projectDesc,
            targetAmount,
            startTime,
            endTime
        ).send();

        console.log(`项目创建成功, 交易哈希: ${createTx.transactionHash}`);

        // 2. 查询项目
        const project = await charityProject.methods.getProject(projectId).call();
        console.log('项目详情:', {
            id: project.id,
            name: project.name,
            description: project.description,
            targetAmount: project.targetAmount.toString(),
            currentAmount: project.currentAmount.toString(),
            startTime: new Date(project.startTime * 1000).toLocaleString(),
            endTime: new Date(project.endTime * 1000).toLocaleString(),
            status: project.status
        });

        // 3. 模拟捐赠
        const donationId = "DONATION_" + Date.now();
        const donorId = "USER_001";
        const amount = 1000;

        console.log(`捐赠金额: ${amount}`);
        const donateTx = await charityProject.methods.donate(
            projectId,
            donationId,
            donorId,
            amount
        ).send();

        console.log(`捐赠成功, 交易哈希: ${donateTx.transactionHash}`);

        // 4. 查询项目状态（检查金额变化）
        const updatedProject = await charityProject.methods.getProject(projectId).call();
        console.log('更新后的项目详情:', {
            id: updatedProject.id,
            currentAmount: updatedProject.currentAmount.toString(),
        });

        // 5. 提交资金使用申请
        const usageId = "USAGE_" + Date.now();
        const usageAmount = 500;
        const usageDesc = "购买学习用具";

        console.log(`申请资金使用: ${usageAmount}, 用途: ${usageDesc}`);
        const applyTx = await charityProject.methods.applyFundUsage(
            projectId,
            usageId,
            usageAmount,
            usageDesc
        ).send();

        console.log(`资金使用申请成功, 交易哈希: ${applyTx.transactionHash}`);

        // 6. 审核资金使用
        console.log('审核资金使用申请');
        const approveTx = await charityProject.methods.approveFundUsage(
            usageId,
            true
        ).send();

        console.log(`资金使用审核成功, 交易哈希: ${approveTx.transactionHash}`);

        // 7. 查询资金使用记录
        const usage = await charityProject.methods.getFundUsage(usageId).call();
        console.log('资金使用记录:', {
            id: usage.id,
            projectId: usage.projectId,
            amount: usage.amount.toString(),
            description: usage.description,
            status: usage.status,
            approved: usage.approved
        });

        console.log('\n========== 测试资金透明合约 ==========');

        // 8. 查询交易记录
        const donorTxs = await fundTransparency.methods.getTransactionsByUser(donorId, 0, 10).call();
        console.log(`用户 ${donorId} 的交易记录数量: ${donorTxs.total}`);

        if (donorTxs.total > 0) {
            console.log('交易详情:');
            donorTxs.records.forEach((tx, index) => {
                console.log(`[${index + 1}] 交易ID: ${tx.id}, 金额: ${tx.amount}, 类型: ${tx.txType}, 时间: ${new Date(tx.timestamp * 1000).toLocaleString()}`);
            });
        }

        const projectTxs = await fundTransparency.methods.getTransactionsByProject(projectId, 0, 10).call();
        console.log(`项目 ${projectId} 的交易记录数量: ${projectTxs.total}`);

        if (projectTxs.total > 0) {
            console.log('交易详情:');
            projectTxs.records.forEach((tx, index) => {
                console.log(`[${index + 1}] 交易ID: ${tx.id}, 金额: ${tx.amount}, 类型: ${tx.txType}, 时间: ${new Date(tx.timestamp * 1000).toLocaleString()}`);
            });
        }

        console.log('\n========== 测试完成 ==========');
        console.log('所有合约功能测试通过!');

    } catch (error) {
        console.error('测试过程中发生错误:', error);
    }
}

// 执行测试
testContracts().then(() => {
    console.log('测试脚本执行完毕');
    process.exit(0);
}).catch(error => {
    console.error('测试脚本执行失败:', error);
    process.exit(1);
}); 