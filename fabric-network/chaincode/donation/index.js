'use strict';

const { Contract } = require('fabric-contract-api');

class DonationContract extends Contract {

    // 初始化账本
    async initLedger(ctx) {
        console.info('============= 初始化捐赠管理账本 ===========');
        return;
    }

    // 获取交易时间戳ISO字符串
    getTimestamp(ctx) {
        const timestamp = ctx.stub.getTxTimestamp();
        const milliseconds = (timestamp.seconds.low * 1000) + (timestamp.nanos / 1000000);
        const dateObject = new Date(milliseconds);
        return dateObject.toISOString();
    }

    // 用户注册
    async registerUser(ctx, userId, userInfo) {
        console.info('============= 用户注册 ===========');

        const userKey = 'user_' + userId;
        const userExists = await this.checkIfExists(ctx, userKey);

        if (userExists) {
            throw new Error(`用户ID ${userId} 已存在`);
        }

        const userObject = JSON.parse(userInfo);
        const user = {
            docType: 'user',
            userId: userId,
            name: userObject.name,
            contactInfo: userObject.contactInfo,
            registrationDate: userObject.registrationDate || this.getTimestamp(ctx),
            donationHistory: [],
            privacySettings: userObject.privacySettings || 'default',
            totalDonated: 0
        };

        await ctx.stub.putState(userKey, Buffer.from(JSON.stringify(user)));
        console.info(`用户 ${userId} 已注册`);

        return JSON.stringify(user);
    }

    // 更新用户信息
    async updateUserInfo(ctx, userId, updatedInfo) {
        console.info('============= 更新用户信息 ===========');

        const userKey = 'user_' + userId;
        const userBytes = await ctx.stub.getState(userKey);

        if (!userBytes || userBytes.length === 0) {
            throw new Error(`用户 ${userId} 不存在`);
        }

        const user = JSON.parse(userBytes.toString());
        const updates = JSON.parse(updatedInfo);

        // 只允许更新某些字段，不允许更新敏感信息
        if (updates.name) user.name = updates.name;
        if (updates.contactInfo) user.contactInfo = updates.contactInfo;
        if (updates.privacySettings) user.privacySettings = updates.privacySettings;

        await ctx.stub.putState(userKey, Buffer.from(JSON.stringify(user)));
        console.info(`用户 ${userId} 信息已更新`);

        return JSON.stringify(user);
    }

    // 获取用户信息
    async getUser(ctx, userId) {
        console.info('============= 获取用户信息 ===========');

        const userKey = 'user_' + userId;
        const userBytes = await ctx.stub.getState(userKey);

        if (!userBytes || userBytes.length === 0) {
            throw new Error(`用户 ${userId} 不存在`);
        }

        return userBytes.toString();
    }

    // 记录捐赠
    async recordDonation(ctx, donationId, donorId, projectId, amount, method, timestamp) {
        console.info('============= 记录捐赠 ===========');

        // 检查项目是否存在
        const projectKey = 'project_' + projectId;
        const projectBytes = await ctx.stub.getState(projectKey);

        if (!projectBytes || projectBytes.length === 0) {
            throw new Error(`慈善项目 ${projectId} 不存在`);
        }

        const project = JSON.parse(projectBytes.toString());

        // 创建捐赠记录
        const donation = {
            docType: 'donation',
            donationId,
            donorId,
            projectId,
            projectName: project.name,
            amount: parseFloat(amount),
            method, // 可能的值: 'credit_card', 'bank_transfer', 'digital_wallet'等
            timestamp: timestamp || this.getTimestamp(ctx),
            status: 'completed',
            certificateGenerated: false,
            transactionId: ctx.stub.getTxID()
        };

        await ctx.stub.putState(donationId, Buffer.from(JSON.stringify(donation)));
        console.info(`捐赠 ${donationId} 已记录`);

        // 更新项目捐赠总额
        project.currentAmount = (parseFloat(project.currentAmount) + parseFloat(amount)).toFixed(2);
        project.donationCount = parseInt(project.donationCount) + 1;
        project.lastDonationDate = donation.timestamp;

        // 如果达到目标，更新项目状态
        if (parseFloat(project.currentAmount) >= parseFloat(project.targetAmount)) {
            project.status = 'funded';
        }

        await ctx.stub.putState(projectKey, Buffer.from(JSON.stringify(project)));

        // 更新用户捐赠历史
        await this.updateUserDonationHistory(ctx, donorId, donationId, amount, project.name);

        return JSON.stringify(donation);
    }

    // 更新用户捐赠历史
    async updateUserDonationHistory(ctx, userId, donationId, amount, projectName) {
        const userKey = 'user_' + userId;
        const userBytes = await ctx.stub.getState(userKey);

        if (!userBytes || userBytes.length === 0) {
            console.warn(`用户 ${userId} 不存在，无法更新捐赠历史`);
            return;
        }

        const user = JSON.parse(userBytes.toString());

        // 添加捐赠记录到用户历史
        const donationRecord = {
            donationId,
            projectName,
            amount: parseFloat(amount),
            date: this.getTimestamp(ctx)
        };

        if (!user.donationHistory) {
            user.donationHistory = [];
        }

        user.donationHistory.push(donationRecord);
        user.totalDonated = (parseFloat(user.totalDonated || 0) + parseFloat(amount)).toFixed(2);

        await ctx.stub.putState(userKey, Buffer.from(JSON.stringify(user)));
        console.info(`用户 ${userId} 捐赠历史已更新`);
    }

    // 获取捐赠记录
    async getDonation(ctx, donationId) {
        console.info('============= 获取捐赠记录 ===========');

        const donationBytes = await ctx.stub.getState(donationId);

        if (!donationBytes || donationBytes.length === 0) {
            throw new Error(`捐赠记录 ${donationId} 不存在`);
        }

        return donationBytes.toString();
    }

    // 生成捐赠证书
    async generateDonationCertificate(ctx, donationId) {
        console.info('============= 生成捐赠证书 ===========');

        const donationBytes = await ctx.stub.getState(donationId);

        if (!donationBytes || donationBytes.length === 0) {
            throw new Error(`捐赠记录 ${donationId} 不存在`);
        }

        const donation = JSON.parse(donationBytes.toString());

        if (donation.certificateGenerated) {
            throw new Error(`捐赠记录 ${donationId} 已经生成了证书`);
        }

        // 获取项目信息
        const projectKey = 'project_' + donation.projectId;
        const projectBytes = await ctx.stub.getState(projectKey);

        if (!projectBytes || projectBytes.length === 0) {
            throw new Error(`慈善项目 ${donation.projectId} 不存在`);
        }

        const project = JSON.parse(projectBytes.toString());

        // 生成证书信息
        const certificateId = 'cert_' + donationId;
        const certificate = {
            docType: 'certificate',
            certificateId,
            donationId,
            donorId: donation.donorId,
            projectId: donation.projectId,
            projectName: project.name,
            amount: donation.amount,
            timestamp: this.getTimestamp(ctx),
            verificationCode: this.generateVerificationCode(ctx),
            transactionId: ctx.stub.getTxID()
        };

        // 储存证书
        await ctx.stub.putState(certificateId, Buffer.from(JSON.stringify(certificate)));

        // 更新捐赠记录状态
        donation.certificateGenerated = true;
        donation.certificateId = certificateId;
        await ctx.stub.putState(donationId, Buffer.from(JSON.stringify(donation)));

        console.info(`捐赠证书 ${certificateId} 已生成`);

        return JSON.stringify(certificate);
    }

    // 生成验证码，使用交易ID确保确定性
    generateVerificationCode(ctx) {
        const txID = ctx.stub.getTxID();
        return txID.substring(0, 16) + txID.substring(txID.length - 16);
    }

    // 发布慈善项目
    async createCharityProject(ctx, projectId, projectInfo) {
        console.info('============= 发布慈善项目 ===========');

        const projectKey = 'project_' + projectId;
        const projectExists = await this.checkIfExists(ctx, projectKey);

        if (projectExists) {
            throw new Error(`项目ID ${projectId} 已存在`);
        }

        const projectData = JSON.parse(projectInfo);
        const project = {
            docType: 'project',
            projectId,
            organizationId: projectData.organizationId,
            name: projectData.name,
            description: projectData.description,
            images: projectData.images || [],
            targetAmount: parseFloat(projectData.targetAmount).toFixed(2),
            currentAmount: '0.00',
            startDate: projectData.startDate || this.getTimestamp(ctx),
            endDate: projectData.endDate,
            status: 'active', // active, funded, completed, canceled
            donationCount: 0,
            lastDonationDate: null,
            reviews: [],
            averageRating: 0,
            isApproved: projectData.isApproved || false,
            approvalDetails: projectData.approvalDetails || null,
            creationTimestamp: this.getTimestamp(ctx),
            transactionId: ctx.stub.getTxID()
        };

        await ctx.stub.putState(projectKey, Buffer.from(JSON.stringify(project)));
        console.info(`慈善项目 ${projectId} 已创建`);

        return JSON.stringify(project);
    }

    // 审核慈善项目
    async approveProject(ctx, projectId, organizationId, approvalStatus, remarks) {
        console.info('============= 审核慈善项目 ===========');

        const projectKey = 'project_' + projectId;
        const projectBytes = await ctx.stub.getState(projectKey);

        if (!projectBytes || projectBytes.length === 0) {
            throw new Error(`慈善项目 ${projectId} 不存在`);
        }

        const project = JSON.parse(projectBytes.toString());

        // 检查组织ID是否有权限审核
        // 这里假设只有特定的组织或管理员可以审核
        // 实际实现时需要根据业务规则来调整

        project.isApproved = approvalStatus === 'approved';
        project.approvalDetails = {
            organization: organizationId,
            status: approvalStatus,
            remarks: remarks,
            timestamp: this.getTimestamp(ctx)
        };

        if (!project.isApproved) {
            project.status = 'canceled';
        }

        await ctx.stub.putState(projectKey, Buffer.from(JSON.stringify(project)));
        console.info(`慈善项目 ${projectId} 审核状态已更新为 ${approvalStatus}`);

        return JSON.stringify(project);
    }

    // 获取项目信息
    async getProject(ctx, projectId) {
        console.info('============= 获取项目信息 ===========');

        const projectKey = 'project_' + projectId;
        const projectBytes = await ctx.stub.getState(projectKey);

        if (!projectBytes || projectBytes.length === 0) {
            throw new Error(`慈善项目 ${projectId} 不存在`);
        }

        return projectBytes.toString();
    }

    // 项目评价
    async reviewProject(ctx, projectId, userId, rating, comment) {
        console.info('============= 项目评价 ===========');

        const projectKey = 'project_' + projectId;
        const projectBytes = await ctx.stub.getState(projectKey);

        if (!projectBytes || projectBytes.length === 0) {
            throw new Error(`慈善项目 ${projectId} 不存在`);
        }

        const project = JSON.parse(projectBytes.toString());

        // 验证用户是否已经捐赠过该项目
        const hasDonated = await this.verifyUserDonation(ctx, userId, projectId);

        if (!hasDonated) {
            throw new Error(`用户 ${userId} 没有捐赠过该项目，无法评价`);
        }

        const review = {
            userId,
            rating: parseInt(rating),
            comment,
            timestamp: this.getTimestamp(ctx)
        };

        if (!project.reviews) {
            project.reviews = [];
        }

        project.reviews.push(review);

        // 计算平均评分
        const totalRating = project.reviews.reduce((sum, item) => sum + item.rating, 0);
        project.averageRating = (totalRating / project.reviews.length).toFixed(1);

        await ctx.stub.putState(projectKey, Buffer.from(JSON.stringify(project)));
        console.info(`用户 ${userId} 对项目 ${projectId} 的评价已添加`);

        return JSON.stringify(review);
    }

    // 验证用户是否捐赠过特定项目
    async verifyUserDonation(ctx, userId, projectId) {
        const userKey = 'user_' + userId;
        const userBytes = await ctx.stub.getState(userKey);

        if (!userBytes || userBytes.length === 0) {
            return false;
        }

        const user = JSON.parse(userBytes.toString());

        if (!user.donationHistory || user.donationHistory.length === 0) {
            return false;
        }

        // 查询用户的所有捐赠记录
        for (const record of user.donationHistory) {
            const donationBytes = await ctx.stub.getState(record.donationId);
            if (donationBytes && donationBytes.length > 0) {
                const donation = JSON.parse(donationBytes.toString());
                if (donation.projectId === projectId) {
                    return true;
                }
            }
        }

        return false;
    }

    // 记录资金流向
    async recordFundAllocation(ctx, allocationId, projectId, amount, purpose, recipient, timestamp) {
        console.info('============= 记录资金流向 ===========');

        // 检查项目是否存在
        const projectKey = 'project_' + projectId;
        const projectBytes = await ctx.stub.getState(projectKey);

        if (!projectBytes || projectBytes.length === 0) {
            throw new Error(`慈善项目 ${projectId} 不存在`);
        }

        const allocation = {
            docType: 'fundAllocation',
            allocationId,
            projectId,
            amount: parseFloat(amount),
            purpose,
            recipient,
            timestamp: timestamp || this.getTimestamp(ctx),
            status: 'completed',
            transactionId: ctx.stub.getTxID()
        };

        await ctx.stub.putState(allocationId, Buffer.from(JSON.stringify(allocation)));
        console.info(`资金分配 ${allocationId} 已记录`);

        return JSON.stringify(allocation);
    }

    // 查询资金流向
    async getFundAllocation(ctx, allocationId) {
        console.info('============= 查询资金流向 ===========');

        const allocationBytes = await ctx.stub.getState(allocationId);

        if (!allocationBytes || allocationBytes.length === 0) {
            throw new Error(`资金分配记录 ${allocationId} 不存在`);
        }

        return allocationBytes.toString();
    }

    // 查询项目的所有资金流向
    async queryProjectFundAllocations(ctx, projectId) {
        console.info('============= 查询项目的所有资金流向 ===========');

        const iterator = await ctx.stub.getStateByRange('', '');
        const results = [];

        while (true) {
            const res = await iterator.next();
            if (res.value && res.value.value.toString()) {
                let record;
                try {
                    record = JSON.parse(res.value.value.toString('utf8'));
                    if (record.docType === 'fundAllocation' && record.projectId === projectId) {
                        results.push(record);
                    }
                } catch (err) {
                    console.log(err);
                }
            }

            if (res.done) {
                await iterator.close();
                console.info('项目资金流向查询结果数量:', results.length);
                return JSON.stringify(results);
            }
        }
    }

    // 查询用户捐赠历史
    async queryUserDonations(ctx, userId) {
        console.info('============= 查询用户捐赠历史 ===========');

        const userKey = 'user_' + userId;
        const userBytes = await ctx.stub.getState(userKey);

        if (!userBytes || userBytes.length === 0) {
            throw new Error(`用户 ${userId} 不存在`);
        }

        const user = JSON.parse(userBytes.toString());

        if (!user.donationHistory || user.donationHistory.length === 0) {
            return JSON.stringify([]);
        }

        // 获取完整的捐赠记录详情
        const donationDetails = [];
        for (const record of user.donationHistory) {
            try {
                const donationBytes = await ctx.stub.getState(record.donationId);
                if (donationBytes && donationBytes.length > 0) {
                    const donation = JSON.parse(donationBytes.toString());
                    donationDetails.push(donation);
                }
            } catch (error) {
                console.error(`获取捐赠详情错误: ${error}`);
            }
        }

        return JSON.stringify(donationDetails);
    }

    // 辅助方法：检查键是否存在
    async checkIfExists(ctx, key) {
        const bytes = await ctx.stub.getState(key);
        return bytes && bytes.length > 0;
    }
}

module.exports.DonationContract = DonationContract;
module.exports.contracts = [DonationContract]; 