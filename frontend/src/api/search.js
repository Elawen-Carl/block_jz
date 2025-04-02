import request from '@/utils/request'

// 综合搜索
export function search(keyword) {
    return request({
        url: '/search/comprehensive',
        method: 'get',
        params: { keyword }
    })
} 