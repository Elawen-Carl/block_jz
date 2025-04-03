import request from '@/utils/request'

// 查询区块链交易记录列表
export function listBlockchain(query) {
  return request({
    url: '/charity/blockchain/list',
    method: 'get',
    params: query
  })
}

// 查询区块链交易记录详细
export function getBlockchain(txId) {
  return request({
    url: '/charity/blockchain/' + txId,
    method: 'get'
  })
}

// 新增区块链交易记录
export function addBlockchain(data) {
  return request({
    url: '/charity/blockchain',
    method: 'post',
    data: data
  })
}

// 修改区块链交易记录
export function updateBlockchain(data) {
  return request({
    url: '/charity/blockchain',
    method: 'put',
    data: data
  })
}

// 删除区块链交易记录
export function delBlockchain(txId) {
  return request({
    url: '/charity/blockchain/' + txId,
    method: 'delete'
  })
}
