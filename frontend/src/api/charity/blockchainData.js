import request from '@/utils/request'

// 获取区块链统计信息
export function getBlockchainStats() {
    return request({
        url: '/blockchain/stats',
        method: 'get'
    })
}

// 获取最新区块
export function getLatestBlocks(count) {
    return request({
        url: '/blockchain/blocks/latest',
        method: 'get',
        params: { count }
    })
}

// 获取区块详情
export function getBlockDetail(blockNumber) {
    return request({
        url: `/blockchain/blocks/${blockNumber}`,
        method: 'get'
    })
}

// 获取最新交易
export function getLatestTransactions(params) {
    return request({
        url: '/blockchain/transactions/latest',
        method: 'get',
        params
    })
}

// 获取交易详情
export function getTransactionDetail(hash) {
    return request({
        url: `/blockchain/transactions/${hash}`,
        method: 'get'
    })
} 