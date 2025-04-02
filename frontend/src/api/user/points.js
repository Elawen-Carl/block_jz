import request from '@/utils/request'

// 查询用户积分列表
export function listPoints(query) {
  return request({
    url: '/user/points/list',
    method: 'get',
    params: query
  })
}

// 查询用户积分详细
export function getPoints(id) {
  return request({
    url: '/user/points/' + id,
    method: 'get'
  })
}

// 新增用户积分
export function addPoints(data) {
  return request({
    url: '/user/points',
    method: 'post',
    data: data
  })
}

// 修改用户积分
export function updatePoints(data) {
  return request({
    url: '/user/points',
    method: 'put',
    data: data
  })
}

// 删除用户积分
export function delPoints(id) {
  return request({
    url: '/user/points/' + id,
    method: 'delete'
  })
}
