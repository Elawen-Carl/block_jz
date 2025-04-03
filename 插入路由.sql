-- 删除原有菜单条目
DELETE FROM sys_menu WHERE menu_id BETWEEN 2000 AND 2200;

-- 一级菜单：慈善捐赠平台
INSERT INTO sys_menu VALUES('2000', '慈善捐赠平台', '0', '5', 'charity', null, '', '', 1, 0, 'M', '0', '0', '', 'guide', 'admin', sysdate(), '', null, '慈善捐赠平台目录');

-- 二级菜单：项目管理
INSERT INTO sys_menu VALUES('2001', '项目管理', '2000', '1', 'project', null, '', '', 1, 0, 'M', '0', '0', '', 'build', 'admin', sysdate(), '', null, '慈善项目管理目录');

-- 三级菜单：项目列表 (管理员和用户都可访问)
INSERT INTO sys_menu VALUES('2011', '项目列表', '2001', '1', 'index', 'charity/project/index', '', '', 1, 0, 'C', '0', '0', 'charity:project:list', 'list', 'admin', sysdate(), '', null, '慈善项目列表');
-- 项目列表按钮
INSERT INTO sys_menu VALUES('2101', '项目查询', '2011', '1', '#', '', '', '', 1, 0, 'F', '0', '0', 'charity:project:query', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu VALUES('2102', '项目捐赠', '2011', '2', '#', '', '', '', 1, 0, 'F', '0', '0', 'charity:project:donate', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu VALUES('2103', '项目评价', '2011', '3', '#', '', '', '', 1, 0, 'F', '0', '0', 'charity:project:comment', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu VALUES('2104', '项目导出', '2011', '4', '#', '', '', '', 1, 0, 'F', '0', '0', 'charity:project:export', '#', 'admin', sysdate(), '', null, '');

-- 三级菜单：项目发布 (组织用户可访问)
INSERT INTO sys_menu VALUES('2012', '项目发布', '2001', '2', 'publish', 'charity/project/publish', '', '', 1, 0, 'C', '0', '0', 'charity:project:publish', 'edit', 'admin', sysdate(), '', null, '慈善项目发布');
-- 项目发布按钮
INSERT INTO sys_menu VALUES('2105', '发布查询', '2012', '1', '#', '', '', '', 1, 0, 'F', '0', '0', 'charity:project:publishquery', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu VALUES('2106', '发布新增', '2012', '2', '#', '', '', '', 1, 0, 'F', '0', '0', 'charity:project:publishadd', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu VALUES('2107', '发布修改', '2012', '3', '#', '', '', '', 1, 0, 'F', '0', '0', 'charity:project:publishedit', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu VALUES('2108', '发布删除', '2012', '4', '#', '', '', '', 1, 0, 'F', '0', '0', 'charity:project:publishremove', '#', 'admin', sysdate(), '', null, '');

-- 三级菜单：项目审核 (管理员可访问)
INSERT INTO sys_menu VALUES('2013', '项目审核', '2001', '3', 'audit', 'charity/project/audit', '', '', 1, 0, 'C', '0', '0', 'charity:project:audit', 'validCode', 'admin', sysdate(), '', null, '慈善项目审核');
-- 项目审核按钮
INSERT INTO sys_menu VALUES('2109', '审核查询', '2013', '1', '#', '', '', '', 1, 0, 'F', '0', '0', 'charity:project:auditquery', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu VALUES('2110', '审核操作', '2013', '2', '#', '', '', '', 1, 0, 'F', '0', '0', 'charity:project:auditoperate', '#', 'admin', sysdate(), '', null, '');

-- 二级菜单：捐赠管理
INSERT INTO sys_menu VALUES('2002', '捐赠管理', '2000', '2', 'donation', null, '', '', 1, 0, 'M', '0', '0', '', 'money', 'admin', sysdate(), '', null, '捐赠管理目录');

-- 三级菜单：捐赠记录 (管理员可访问)
INSERT INTO sys_menu VALUES('2021', '捐赠记录', '2002', '1', 'index', 'charity/donation/index', '', '', 1, 0, 'C', '0', '0', 'charity:donation:list', 'form', 'admin', sysdate(), '', null, '捐赠记录管理');
-- 捐赠记录按钮
INSERT INTO sys_menu VALUES('2111', '捐赠查询', '2021', '1', '#', '', '', '', 1, 0, 'F', '0', '0', 'charity:donation:query', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu VALUES('2112', '捐赠新增', '2021', '2', '#', '', '', '', 1, 0, 'F', '0', '0', 'charity:donation:add', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu VALUES('2113', '捐赠导出', '2021', '3', '#', '', '', '', 1, 0, 'F', '0', '0', 'charity:donation:export', '#', 'admin', sysdate(), '', null, '');

-- 三级菜单：我的捐赠 (捐赠用户可访问)
INSERT INTO sys_menu VALUES('2022', '我的捐赠', '2002', '2', 'my', 'charity/donation/my', '', '', 1, 0, 'C', '0', '0', 'charity:donation:my', 'list', 'admin', sysdate(), '', null, '我的捐赠记录');
-- 我的捐赠按钮
INSERT INTO sys_menu VALUES('2114', '我的捐赠查询', '2022', '1', '#', '', '', '', 1, 0, 'F', '0', '0', 'charity:donation:myquery', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu VALUES('2115', '证书下载', '2022', '2', '#', '', '', '', 1, 0, 'F', '0', '0', 'charity:donation:certificate', '#', 'admin', sysdate(), '', null, '');

-- 二级菜单：资金管理
INSERT INTO sys_menu VALUES('2003', '资金管理', '2000', '3', 'fund', null, '', '', 1, 0, 'M', '0', '0', '', 'money', 'admin', sysdate(), '', null, '资金管理目录');

-- 三级菜单：资金使用记录 (管理员可访问)
INSERT INTO sys_menu VALUES('2031', '资金使用记录', '2003', '1', 'index', 'charity/fund/index', '', '', 1, 0, 'C', '0', '0', 'charity:fund:list', 'excel', 'admin', sysdate(), '', null, '资金使用记录');
-- 资金使用记录按钮
INSERT INTO sys_menu VALUES('2116', '资金查询', '2031', '1', '#', '', '', '', 1, 0, 'F', '0', '0', 'charity:fund:query', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu VALUES('2117', '资金导出', '2031', '2', '#', '', '', '', 1, 0, 'F', '0', '0', 'charity:fund:export', '#', 'admin', sysdate(), '', null, '');

-- 三级菜单：资金申请 (组织用户可访问)
INSERT INTO sys_menu VALUES('2032', '资金申请', '2003', '2', 'apply', 'charity/fund/apply', '', '', 1, 0, 'C', '0', '0', 'charity:fund:apply', 'edit', 'admin', sysdate(), '', null, '资金申请');
-- 资金申请按钮
INSERT INTO sys_menu VALUES('2118', '申请查询', '2032', '1', '#', '', '', '', 1, 0, 'F', '0', '0', 'charity:fund:applyquery', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu VALUES('2119', '申请新增', '2032', '2', '#', '', '', '', 1, 0, 'F', '0', '0', 'charity:fund:applyadd', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu VALUES('2120', '申请修改', '2032', '3', '#', '', '', '', 1, 0, 'F', '0', '0', 'charity:fund:applyedit', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu VALUES('2121', '申请删除', '2032', '4', '#', '', '', '', 1, 0, 'F', '0', '0', 'charity:fund:applyremove', '#', 'admin', sysdate(), '', null, '');

-- 二级菜单：区块链管理
INSERT INTO sys_menu VALUES('2004', '区块链管理', '2000', '4', 'blockchain', null, '', '', 1, 0, 'M', '0', '0', '', 'monitor', 'admin', sysdate(), '', null, '区块链管理目录');

-- 三级菜单：交易记录
INSERT INTO sys_menu VALUES('2041', '交易记录', '2004', '1', 'index', 'charity/blockchain/index', '', '', 1, 0, 'C', '0', '0', 'charity:blockchain:list', 'chart', 'admin', sysdate(), '', null, '区块链交易记录');
-- 交易记录按钮
INSERT INTO sys_menu VALUES('2122', '交易查询', '2041', '1', '#', '', '', '', 1, 0, 'F', '0', '0', 'charity:blockchain:query', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu VALUES('2123', '交易导出', '2041', '2', '#', '', '', '', 1, 0, 'F', '0', '0', 'charity:blockchain:export', '#', 'admin', sysdate(), '', null, '');

-- 三级菜单：规则管理
INSERT INTO sys_menu VALUES('2042', '规则管理', '2004', '2', 'rule', 'charity/blockchain/rule', '', '', 1, 0, 'C', '0', '0', 'charity:blockchain:rule', 'code', 'admin', sysdate(), '', null, '区块链规则管理');
-- 规则管理按钮
INSERT INTO sys_menu VALUES('2124', '规则查询', '2042', '1', '#', '', '', '', 1, 0, 'F', '0', '0', 'charity:blockchain:rulequery', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu VALUES('2125', '规则新增', '2042', '2', '#', '', '', '', 1, 0, 'F', '0', '0', 'charity:blockchain:ruleadd', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu VALUES('2126', '规则修改', '2042', '3', '#', '', '', '', 1, 0, 'F', '0', '0', 'charity:blockchain:ruleedit', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu VALUES('2127', '规则删除', '2042', '4', '#', '', '', '', 1, 0, 'F', '0', '0', 'charity:blockchain:ruleremove', '#', 'admin', sysdate(), '', null, '');

-- 二级菜单：评价管理
INSERT INTO sys_menu VALUES('2005', '评价管理', '2000', '5', 'comment', 'charity/comment/index', '', '', 1, 0, 'C', '0', '0', 'charity:comment:list', 'message', 'admin', sysdate(), '', null, '项目评价管理');
-- 评价管理按钮
INSERT INTO sys_menu VALUES('2128', '评价查询', '2005', '1', '#', '', '', '', 1, 0, 'F', '0', '0', 'charity:comment:query', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu VALUES('2129', '评价新增', '2005', '2', '#', '', '', '', 1, 0, 'F', '0', '0', 'charity:comment:add', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu VALUES('2130', '评价删除', '2005', '3', '#', '', '', '', 1, 0, 'F', '0', '0', 'charity:comment:remove', '#', 'admin', sysdate(), '', null, '');

-- 二级菜单：隐私设置
INSERT INTO sys_menu VALUES('2006', '隐私设置', '2000', '6', 'privacy', 'charity/privacy/index', '', '', 1, 0, 'C', '0', '0', 'charity:privacy:list', 'user', 'admin', sysdate(), '', null, '用户隐私设置');
-- 隐私设置按钮
INSERT INTO sys_menu VALUES('2131', '隐私查询', '2006', '1', '#', '', '', '', 1, 0, 'F', '0', '0', 'charity:privacy:query', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu VALUES('2132', '隐私修改', '2006', '2', '#', '', '', '', 1, 0, 'F', '0', '0', 'charity:privacy:edit', '#', 'admin', sysdate(), '', null, '');

-- 二级菜单：数据可视化
INSERT INTO sys_menu VALUES('2007', '数据可视化', '2000', '7', 'visualization', 'charity/visualization/index', '', '', 1, 0, 'C', '0', '0', 'charity:visualization:view', 'chart', 'admin', sysdate(), '', null, '数据可视化');