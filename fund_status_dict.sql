-- 资金申请状态字典类型
INSERT INTO `sys_dict_type` (
   `dict_id`,
   `dict_name`,
   `dict_type`,
   `status`,
   `create_by`,
   `create_time`,
   `update_by`,
   `update_time`,
   `remark`
) VALUES (
   100,  -- 请根据实际情况修改ID
   '资金申请状态',
   'fund_application_status',
   '0',
   'admin',
   NOW(),
   '',
   NULL,
   '资金申请状态列表'
);

-- 资金申请状态字典数据
INSERT INTO `sys_dict_data` (
   `dict_code`,
   `dict_sort`,
   `dict_label`,
   `dict_value`,
   `dict_type`,
   `css_class`,
   `list_class`,
   `is_default`,
   `status`,
   `create_by`,
   `create_time`,
   `update_by`,
   `update_time`,
   `remark`
) VALUES (
   100,  -- 请根据实际情况修改ID
   1,
   '未提交',
   '0',
   'fund_application_status',
   '',
   'info',
   'Y',
   '0',
   'admin',
   NOW(),
   '',
   NULL,
   '未提交状态（草稿）'
);

INSERT INTO `sys_dict_data` (
   `dict_code`,
   `dict_sort`,
   `dict_label`,
   `dict_value`,
   `dict_type`,
   `css_class`,
   `list_class`,
   `is_default`,
   `status`,
   `create_by`,
   `create_time`,
   `update_by`,
   `update_time`,
   `remark`
) VALUES (
   101,  -- 请根据实际情况修改ID
   2,
   '待审核',
   '1',
   'fund_application_status',
   '',
   'warning',
   'N',
   '0',
   'admin',
   NOW(),
   '',
   NULL,
   '已提交待审核状态'
);

INSERT INTO `sys_dict_data` (
   `dict_code`,
   `dict_sort`,
   `dict_label`,
   `dict_value`,
   `dict_type`,
   `css_class`,
   `list_class`,
   `is_default`,
   `status`,
   `create_by`,
   `create_time`,
   `update_by`,
   `update_time`,
   `remark`
) VALUES (
   102,  -- 请根据实际情况修改ID
   3,
   '已审核',
   '2',
   'fund_application_status',
   '',
   'success',
   'N',
   '0',
   'admin',
   NOW(),
   '',
   NULL,
   '审核完成状态'
); 