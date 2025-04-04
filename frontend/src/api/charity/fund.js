import request from '@/utils/request'

// 查询资金使用记录列表
export function listFund(query) {
  return request({
    url: '/charity/fund/list',
    method: 'get',
    params: query
  })
}

// 查询资金使用记录详细
export function getFund(usageId) {
  return request({
    url: '/charity/fund/' + usageId,
    method: 'get'
  })
}

// 新增资金使用记录
export function addFund(data) {
  return request({
    url: '/charity/fund',
    method: 'post',
    data: data
  })
}

// 修改资金使用记录
export function updateFund(data) {
  return request({
    url: '/charity/fund',
    method: 'put',
    data: data
  })
}

// 删除资金使用记录
export function delFund(usageId) {
  return request({
    url: '/charity/fund/' + usageId,
    method: 'delete'
  })
}

// 审核资金使用申请
export function auditFund(data) {
  return request({
    url: '/charity/fund/audit',
    method: 'put',
    data: data
  })
}
