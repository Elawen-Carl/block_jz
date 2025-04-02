-- 1. 用户隐私设置表（保留，因为这是功能需求中明确提到的隐私保护设置）
CREATE TABLE `user_privacy_settings` (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `show_donation_amount` tinyint(1) DEFAULT '1' COMMENT '是否显示捐赠金额（0不显示 1显示）',
  `show_donation_list` tinyint(1) DEFAULT '1' COMMENT '是否在捐赠列表显示（0不显示 1显示）',
  `show_real_name` tinyint(1) DEFAULT '1' COMMENT '是否显示真实姓名（0不显示 1显示）',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`user_id`),
  CONSTRAINT `fk_privacy_user_id` FOREIGN KEY (`user_id`) REFERENCES `sys_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户隐私设置表';

-- 2. 捐赠记录表（简化，整合了证书信息）
CREATE TABLE `donation_record` (
  `donation_id` bigint NOT NULL AUTO_INCREMENT COMMENT '捐赠ID',
  `user_id` bigint DEFAULT NULL COMMENT '捐赠用户ID',
  `project_id` bigint NOT NULL COMMENT '慈善项目ID',
  `donation_amount` decimal(10,2) NOT NULL COMMENT '捐赠金额',
  `payment_method` varchar(50) DEFAULT NULL COMMENT '捐赠方式',
  `donation_time` datetime NOT NULL COMMENT '捐赠时间',
  `status` char(1) DEFAULT '0' COMMENT '状态（0待处理 1已完成 2已拒绝）',
  `transaction_hash` varchar(100) DEFAULT NULL COMMENT '区块链交易哈希',
  `certificate_url` varchar(255) DEFAULT NULL COMMENT '捐赠证书URL',
  `certificate_issue_date` datetime DEFAULT NULL COMMENT '证书颁发日期',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`donation_id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_project_id` (`project_id`),
  CONSTRAINT `fk_donation_user_id` FOREIGN KEY (`user_id`) REFERENCES `sys_user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='捐赠记录表';

-- 3. 慈善项目表
CREATE TABLE `charity_project` (
  `project_id` bigint NOT NULL AUTO_INCREMENT COMMENT '项目ID',
  `project_name` varchar(100) NOT NULL COMMENT '项目名称',
  `project_desc` text COMMENT '项目描述',
  `target_amount` decimal(10,2) DEFAULT NULL COMMENT '目标金额',
  `current_amount` decimal(10,2) DEFAULT '0.00' COMMENT '当前筹集金额',
  `initiator_id` bigint DEFAULT NULL COMMENT '发起人ID',
  `initiator_type` char(1) DEFAULT '0' COMMENT '发起类型（0个人 1慈善组织）',
  `cover_image` varchar(255) DEFAULT NULL COMMENT '项目封面图片',
  `start_time` datetime DEFAULT NULL COMMENT '开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '结束时间',
  `status` char(1) DEFAULT '0' COMMENT '状态（0待审核 1进行中 2已完成 3已关闭）',
  `blockchain_id` varchar(100) DEFAULT NULL COMMENT '区块链上的项目ID',
  `fund_usage_rules` text COMMENT '资金使用规则（JSON格式存储简单规则）',
  `audit_user_id` bigint DEFAULT NULL COMMENT '审核人ID',
  `audit_time` datetime DEFAULT NULL COMMENT '审核时间',
  `audit_status` char(1) DEFAULT '0' COMMENT '审核状态（0待审核 1通过 2拒绝）',
  `audit_remark` varchar(500) DEFAULT NULL COMMENT '审核备注',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`project_id`),
  KEY `idx_initiator_id` (`initiator_id`),
  KEY `idx_status` (`status`),
  KEY `idx_audit_status` (`audit_status`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='慈善项目表';

-- 4. 项目评价表
CREATE TABLE `project_comment` (
  `comment_id` bigint NOT NULL AUTO_INCREMENT COMMENT '评价ID',
  `project_id` bigint NOT NULL COMMENT '项目ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `content` text NOT NULL COMMENT '评价内容',
  `rating` int DEFAULT '5' COMMENT '评分(1-5)',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`comment_id`),
  KEY `idx_project_id` (`project_id`),
  KEY `idx_user_id` (`user_id`),
  CONSTRAINT `fk_comment_project_id` FOREIGN KEY (`project_id`) REFERENCES `charity_project` (`project_id`),
  CONSTRAINT `fk_comment_user_id` FOREIGN KEY (`user_id`) REFERENCES `sys_user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='项目评价表';

-- 5. 资金使用记录表
CREATE TABLE `fund_usage_record` (
  `usage_id` bigint NOT NULL AUTO_INCREMENT COMMENT '使用记录ID',
  `project_id` bigint NOT NULL COMMENT '慈善项目ID',
  `amount` decimal(10,2) NOT NULL COMMENT '使用金额',
  `usage_desc` varchar(500) NOT NULL COMMENT '使用描述',
  `usage_time` datetime NOT NULL COMMENT '使用时间',
  `proof_url` varchar(255) DEFAULT NULL COMMENT '证明材料链接',
  `transaction_hash` varchar(100) DEFAULT NULL COMMENT '区块链交易哈希',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`usage_id`),
  KEY `idx_project_id` (`project_id`),
  CONSTRAINT `fk_usage_project_id` FOREIGN KEY (`project_id`) REFERENCES `charity_project` (`project_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='资金使用记录表';

-- 6. 区块链交易记录表
CREATE TABLE `blockchain_transaction` (
  `tx_id` varchar(100) NOT NULL COMMENT '交易ID',
  `related_id` bigint DEFAULT NULL COMMENT '关联业务ID',
  `related_type` varchar(50) DEFAULT NULL COMMENT '关联业务类型（donation/project/usage）',
  `tx_data` text COMMENT '交易数据(JSON)',
  `tx_time` datetime DEFAULT NULL COMMENT '交易时间',
  `tx_status` char(1) DEFAULT '0' COMMENT '交易状态（0处理中 1成功 2失败）',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`tx_id`),
  KEY `idx_related_id` (`related_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='区块链交易记录表';