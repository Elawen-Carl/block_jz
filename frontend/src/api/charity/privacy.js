import request from '@/utils/request'

// 查询用户隐私设置列表
export function listPrivacy(query) {
  return request({
    url: '/charity/privacy/list',
    method: 'get',
    params: query
  })
}

// 查询用户隐私设置详细
export function getPrivacy(userId) {
  return request({
    url: '/charity/privacy/' + userId,
    method: 'get'
  })
}

// 新增用户隐私设置
export function addPrivacy(data) {
  return request({
    url: '/charity/privacy',
    method: 'post',
    data: data
  })
}

// 修改用户隐私设置
export function updatePrivacy(data) {
  return request({
    url: '/charity/privacy',
    method: 'put',
    data: data
  })
}

// 删除用户隐私设置
export function delPrivacy(userId) {
  return request({
    url: '/charity/privacy/' + userId,
    method: 'delete'
  })
}
