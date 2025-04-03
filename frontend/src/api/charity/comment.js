import request from '@/utils/request'

// 查询项目评价列表
export function listComment(query) {
  return request({
    url: '/charity/comment/list',
    method: 'get',
    params: query
  })
}

// 查询项目评价详细
export function getComment(commentId) {
  return request({
    url: '/charity/comment/' + commentId,
    method: 'get'
  })
}

// 新增项目评价
export function addComment(data) {
  return request({
    url: '/charity/comment',
    method: 'post',
    data: data
  })
}

// 修改项目评价
export function updateComment(data) {
  return request({
    url: '/charity/comment',
    method: 'put',
    data: data
  })
}

// 删除项目评价
export function delComment(commentId) {
  return request({
    url: '/charity/comment/' + commentId,
    method: 'delete'
  })
}
