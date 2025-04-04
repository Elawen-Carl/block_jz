import request from '@/utils/request'

// 获取捐赠统计数据
export function getDonationStatistics(params) {
    return request({
        url: '/charity/statistics/donation',
        method: 'get',
        params: params
    })
}

// 获取项目统计数据
export function getProjectStatistics(params) {
    return request({
        url: '/charity/statistics/project',
        method: 'get',
        params: params
    })
}

// 获取资金使用统计数据
export function getFundUsageStatistics(params) {
    return request({
        url: '/charity/statistics/fund',
        method: 'get',
        params: params
    })
}

// 获取捐赠趋势数据
export function getDonationTrend(params) {
    return request({
        url: '/charity/statistics/trend',
        method: 'get',
        params: params
    })
}

// 获取总体统计数据
export function getOverallStatistics() {
    return request({
        url: '/charity/statistics/overall',
        method: 'get'
    })
} 