import request from '@/utils/request'

// 查询慈善项目列表
export function listProject(query) {
  return request({
    url: '/charity/project/list',
    method: 'get',
    params: query
  })
}

// 查询慈善项目详细
export function getProject(projectId) {
  return request({
    url: '/charity/project/' + projectId,
    method: 'get'
  })
}

// 新增慈善项目
export function addProject(data) {
  return request({
    url: '/charity/project',
    method: 'post',
    data: data
  })
}

// 修改慈善项目
export function updateProject(data) {
  return request({
    url: '/charity/project',
    method: 'put',
    data: data
  })
}

// 删除慈善项目
export function delProject(projectId) {
  return request({
    url: '/charity/project/' + projectId,
    method: 'delete'
  })
}
