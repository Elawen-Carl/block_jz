/**
 * FISCO BCOS 配置文件
 */
class Configuration {
    constructor() {
        // 区块链节点配置
        this.network = {
            nodes: ['127.0.0.1:20200'], // 区块链节点地址和端口
            authentication: {
                key: './config/certs/sdk.key',   // SDK私钥
                cert: './config/certs/sdk.crt',  // SDK证书
                ca: './config/certs/ca.crt'      // CA证书
            },
            timeout: 10000 // 连接超时时间（毫秒）
        };

        // 区块链相关配置
        this.blockchain = {
            groupId: 1,  // 群组ID
            chainId: 1,  // 链ID
            gas: 3000000000, // Gas限制
            gasPrice: 0      // Gas价格
        };

        // 合约相关配置
        this.contracts = {
            charityProjectAddress: '0x1234567890123456789012345678901234567890',
            fundTransparencyAddress: '0x0987654321098765432109876543210987654321'
        };

        // 账户相关配置
        this.account = {
            privateKey: '', // 区块链账户私钥（生产环境应从安全存储中获取）
            address: ''     // 区块链账户地址
        };
    }

    /**
     * 获取节点配置
     * @returns {Object} 节点配置对象
     */
    getNetworkConfig() {
        return this.network;
    }

    /**
     * 获取区块链配置
     * @returns {Object} 区块链配置对象
     */
    getBlockchainConfig() {
        return this.blockchain;
    }

    /**
     * 获取合约地址配置
     * @returns {Object} 合约地址配置对象
     */
    getContractAddresses() {
        return this.contracts;
    }

    /**
     * 获取账户配置
     * @returns {Object} 账户配置对象
     */
    getAccountConfig() {
        return this.account;
    }
}

module.exports = Configuration; 