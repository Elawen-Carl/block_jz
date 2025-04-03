/*
 Navicat Premium Data Transfer

 Source Server         : 1
 Source Server Type    : MySQL
 Source Server Version : 80034
 Source Host           : localhost:3306
 Source Schema         : block_jz

 Target Server Type    : MySQL
 Target Server Version : 80034
 File Encoding         : 65001

 Date: 03/04/2025 00:53:02
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for gen_table_column
-- ----------------------------
DROP TABLE IF EXISTS `gen_table_column`;
CREATE TABLE `gen_table_column`  (
  `column_id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_id` bigint(0) NULL DEFAULT NULL COMMENT '归属表编号',
  `column_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '列名称',
  `column_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '列描述',
  `column_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '列类型',
  `java_type` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'JAVA类型',
  `java_field` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'JAVA字段名',
  `is_pk` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否主键（1是）',
  `is_increment` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否自增（1是）',
  `is_required` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否必填（1是）',
  `is_insert` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否为插入字段（1是）',
  `is_edit` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否编辑字段（1是）',
  `is_list` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否列表字段（1是）',
  `is_query` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否查询字段（1是）',
  `query_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'EQ' COMMENT '查询方式（等于、不等于、大于、小于、范围）',
  `html_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',
  `dict_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典类型',
  `sort` int(0) NULL DEFAULT NULL COMMENT '排序',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`column_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '代码生成业务表字段' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gen_table_column
-- ----------------------------
INSERT INTO `gen_table_column` VALUES (61, 7, 'tx_id', '交易ID', 'varchar(100)', 'String', 'txId', '1', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2025-04-03 00:51:41', '', NULL);
INSERT INTO `gen_table_column` VALUES (62, 7, 'related_id', '关联业务ID', 'bigint', 'Long', 'relatedId', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2025-04-03 00:51:41', '', NULL);
INSERT INTO `gen_table_column` VALUES (63, 7, 'related_type', '关联业务类型（donation/project/usage）', 'varchar(50)', 'String', 'relatedType', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'select', '', 3, 'admin', '2025-04-03 00:51:41', '', NULL);
INSERT INTO `gen_table_column` VALUES (64, 7, 'tx_data', '交易数据(JSON)', 'text', 'String', 'txData', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'textarea', '', 4, 'admin', '2025-04-03 00:51:41', '', NULL);
INSERT INTO `gen_table_column` VALUES (65, 7, 'tx_time', '交易时间', 'datetime', 'Date', 'txTime', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'datetime', '', 5, 'admin', '2025-04-03 00:51:41', '', NULL);
INSERT INTO `gen_table_column` VALUES (66, 7, 'tx_status', '交易状态（0处理中 1成功 2失败）', 'char(1)', 'String', 'txStatus', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'radio', '', 6, 'admin', '2025-04-03 00:51:41', '', NULL);
INSERT INTO `gen_table_column` VALUES (67, 7, 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'datetime', '', 7, 'admin', '2025-04-03 00:51:41', '', NULL);
INSERT INTO `gen_table_column` VALUES (68, 8, 'project_id', '项目ID', 'bigint', 'Long', 'projectId', '1', '1', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2025-04-03 00:51:41', '', NULL);
INSERT INTO `gen_table_column` VALUES (69, 8, 'project_name', '项目名称', 'varchar(100)', 'String', 'projectName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 2, 'admin', '2025-04-03 00:51:41', '', NULL);
INSERT INTO `gen_table_column` VALUES (70, 8, 'project_desc', '项目描述', 'text', 'String', 'projectDesc', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'textarea', '', 3, 'admin', '2025-04-03 00:51:41', '', NULL);
INSERT INTO `gen_table_column` VALUES (71, 8, 'target_amount', '目标金额', 'decimal(10,2)', 'BigDecimal', 'targetAmount', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 4, 'admin', '2025-04-03 00:51:41', '', NULL);
INSERT INTO `gen_table_column` VALUES (72, 8, 'current_amount', '当前筹集金额', 'decimal(10,2)', 'BigDecimal', 'currentAmount', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 5, 'admin', '2025-04-03 00:51:41', '', NULL);
INSERT INTO `gen_table_column` VALUES (73, 8, 'initiator_id', '发起人ID', 'bigint', 'Long', 'initiatorId', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 6, 'admin', '2025-04-03 00:51:41', '', NULL);
INSERT INTO `gen_table_column` VALUES (74, 8, 'initiator_type', '发起类型（0个人 1慈善组织）', 'char(1)', 'String', 'initiatorType', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'select', '', 7, 'admin', '2025-04-03 00:51:41', '', NULL);
INSERT INTO `gen_table_column` VALUES (75, 8, 'cover_image', '项目封面图片', 'varchar(255)', 'String', 'coverImage', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'imageUpload', '', 8, 'admin', '2025-04-03 00:51:41', '', NULL);
INSERT INTO `gen_table_column` VALUES (76, 8, 'start_time', '开始时间', 'datetime', 'Date', 'startTime', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'datetime', '', 9, 'admin', '2025-04-03 00:51:41', '', NULL);
INSERT INTO `gen_table_column` VALUES (77, 8, 'end_time', '结束时间', 'datetime', 'Date', 'endTime', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'datetime', '', 10, 'admin', '2025-04-03 00:51:41', '', NULL);
INSERT INTO `gen_table_column` VALUES (78, 8, 'status', '状态（0待审核 1进行中 2已完成 3已关闭）', 'char(1)', 'String', 'status', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'radio', '', 11, 'admin', '2025-04-03 00:51:41', '', NULL);
INSERT INTO `gen_table_column` VALUES (79, 8, 'blockchain_id', '区块链上的项目ID', 'varchar(100)', 'String', 'blockchainId', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 12, 'admin', '2025-04-03 00:51:41', '', NULL);
INSERT INTO `gen_table_column` VALUES (80, 8, 'fund_usage_rules', '资金使用规则（JSON格式存储简单规则）', 'text', 'String', 'fundUsageRules', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'textarea', '', 13, 'admin', '2025-04-03 00:51:41', '', NULL);
INSERT INTO `gen_table_column` VALUES (81, 8, 'audit_user_id', '审核人ID', 'bigint', 'Long', 'auditUserId', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 14, 'admin', '2025-04-03 00:51:41', '', NULL);
INSERT INTO `gen_table_column` VALUES (82, 8, 'audit_time', '审核时间', 'datetime', 'Date', 'auditTime', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'datetime', '', 15, 'admin', '2025-04-03 00:51:41', '', NULL);
INSERT INTO `gen_table_column` VALUES (83, 8, 'audit_status', '审核状态（0待审核 1通过 2拒绝）', 'char(1)', 'String', 'auditStatus', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'radio', '', 16, 'admin', '2025-04-03 00:51:41', '', NULL);
INSERT INTO `gen_table_column` VALUES (84, 8, 'audit_remark', '审核备注', 'varchar(500)', 'String', 'auditRemark', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'textarea', '', 17, 'admin', '2025-04-03 00:51:41', '', NULL);
INSERT INTO `gen_table_column` VALUES (85, 8, 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'datetime', '', 18, 'admin', '2025-04-03 00:51:41', '', NULL);
INSERT INTO `gen_table_column` VALUES (86, 8, 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', '0', '1', '1', NULL, NULL, 'EQ', 'datetime', '', 19, 'admin', '2025-04-03 00:51:41', '', NULL);
INSERT INTO `gen_table_column` VALUES (87, 9, 'donation_id', '捐赠ID', 'bigint', 'Long', 'donationId', '1', '1', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2025-04-03 00:51:41', '', '2025-04-03 00:52:23');
INSERT INTO `gen_table_column` VALUES (88, 9, 'user_id', '捐赠用户ID', 'bigint', 'Long', 'userId', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2025-04-03 00:51:41', '', '2025-04-03 00:52:23');
INSERT INTO `gen_table_column` VALUES (89, 9, 'project_id', '慈善项目ID', 'bigint', 'Long', 'projectId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2025-04-03 00:51:41', '', '2025-04-03 00:52:23');
INSERT INTO `gen_table_column` VALUES (90, 9, 'donation_amount', '捐赠金额', 'decimal(10,2)', 'BigDecimal', 'donationAmount', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 4, 'admin', '2025-04-03 00:51:41', '', '2025-04-03 00:52:23');
INSERT INTO `gen_table_column` VALUES (91, 9, 'payment_method', '捐赠方式', 'varchar(50)', 'String', 'paymentMethod', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 5, 'admin', '2025-04-03 00:51:41', '', '2025-04-03 00:52:23');
INSERT INTO `gen_table_column` VALUES (92, 9, 'donation_time', '捐赠时间', 'datetime', 'Date', 'donationTime', '0', '0', '1', '1', '1', '1', '1', 'BETWEEN', 'datetime', '', 6, 'admin', '2025-04-03 00:51:41', '', '2025-04-03 00:52:23');
INSERT INTO `gen_table_column` VALUES (93, 9, 'status', '状态（0待处理 1已完成 2已拒绝）', 'char(1)', 'String', 'status', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'radio', '', 7, 'admin', '2025-04-03 00:51:41', '', '2025-04-03 00:52:23');
INSERT INTO `gen_table_column` VALUES (94, 9, 'transaction_hash', '区块链交易哈希', 'varchar(100)', 'String', 'transactionHash', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 8, 'admin', '2025-04-03 00:51:41', '', '2025-04-03 00:52:23');
INSERT INTO `gen_table_column` VALUES (95, 9, 'certificate_url', '捐赠证书URL', 'varchar(255)', 'String', 'certificateUrl', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 9, 'admin', '2025-04-03 00:51:41', '', '2025-04-03 00:52:23');
INSERT INTO `gen_table_column` VALUES (96, 9, 'certificate_issue_date', '证书颁发日期', 'datetime', 'Date', 'certificateIssueDate', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'datetime', '', 10, 'admin', '2025-04-03 00:51:41', '', '2025-04-03 00:52:23');
INSERT INTO `gen_table_column` VALUES (97, 9, 'remark', '备注', 'varchar(500)', 'String', 'remark', '0', '0', '0', '1', '1', '1', NULL, 'EQ', 'textarea', '', 11, 'admin', '2025-04-03 00:51:41', '', '2025-04-03 00:52:23');
INSERT INTO `gen_table_column` VALUES (98, 9, 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'datetime', '', 12, 'admin', '2025-04-03 00:51:41', '', '2025-04-03 00:52:23');
INSERT INTO `gen_table_column` VALUES (99, 9, 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', '0', '1', '1', NULL, NULL, 'EQ', 'datetime', '', 13, 'admin', '2025-04-03 00:51:41', '', '2025-04-03 00:52:23');
INSERT INTO `gen_table_column` VALUES (100, 10, 'usage_id', '使用记录ID', 'bigint', 'Long', 'usageId', '1', '1', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2025-04-03 00:51:41', '', NULL);
INSERT INTO `gen_table_column` VALUES (101, 10, 'project_id', '慈善项目ID', 'bigint', 'Long', 'projectId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2025-04-03 00:51:41', '', NULL);
INSERT INTO `gen_table_column` VALUES (102, 10, 'amount', '使用金额', 'decimal(10,2)', 'BigDecimal', 'amount', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2025-04-03 00:51:41', '', NULL);
INSERT INTO `gen_table_column` VALUES (103, 10, 'usage_desc', '使用描述', 'varchar(500)', 'String', 'usageDesc', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'textarea', '', 4, 'admin', '2025-04-03 00:51:41', '', NULL);
INSERT INTO `gen_table_column` VALUES (104, 10, 'usage_time', '使用时间', 'datetime', 'Date', 'usageTime', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'datetime', '', 5, 'admin', '2025-04-03 00:51:41', '', NULL);
INSERT INTO `gen_table_column` VALUES (105, 10, 'proof_url', '证明材料链接', 'varchar(255)', 'String', 'proofUrl', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 6, 'admin', '2025-04-03 00:51:41', '', NULL);
INSERT INTO `gen_table_column` VALUES (106, 10, 'transaction_hash', '区块链交易哈希', 'varchar(100)', 'String', 'transactionHash', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 7, 'admin', '2025-04-03 00:51:41', '', NULL);
INSERT INTO `gen_table_column` VALUES (107, 10, 'create_by', '创建者', 'varchar(64)', 'String', 'createBy', '0', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 8, 'admin', '2025-04-03 00:51:41', '', NULL);
INSERT INTO `gen_table_column` VALUES (108, 10, 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'datetime', '', 9, 'admin', '2025-04-03 00:51:41', '', NULL);
INSERT INTO `gen_table_column` VALUES (109, 11, 'comment_id', '评价ID', 'bigint', 'Long', 'commentId', '1', '1', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2025-04-03 00:51:41', '', NULL);
INSERT INTO `gen_table_column` VALUES (110, 11, 'project_id', '项目ID', 'bigint', 'Long', 'projectId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2025-04-03 00:51:41', '', NULL);
INSERT INTO `gen_table_column` VALUES (111, 11, 'user_id', '用户ID', 'bigint', 'Long', 'userId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2025-04-03 00:51:41', '', NULL);
INSERT INTO `gen_table_column` VALUES (112, 11, 'content', '评价内容', 'text', 'String', 'content', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'editor', '', 4, 'admin', '2025-04-03 00:51:41', '', NULL);
INSERT INTO `gen_table_column` VALUES (113, 11, 'rating', '评分(1-5)', 'int', 'Long', 'rating', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 5, 'admin', '2025-04-03 00:51:41', '', NULL);
INSERT INTO `gen_table_column` VALUES (114, 11, 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'datetime', '', 6, 'admin', '2025-04-03 00:51:41', '', NULL);
INSERT INTO `gen_table_column` VALUES (115, 12, 'user_id', '用户ID', 'bigint', 'Long', 'userId', '1', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2025-04-03 00:51:41', '', NULL);
INSERT INTO `gen_table_column` VALUES (116, 12, 'show_donation_amount', '是否显示捐赠金额（0不显示 1显示）', 'tinyint(1)', 'Integer', 'showDonationAmount', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2025-04-03 00:51:41', '', NULL);
INSERT INTO `gen_table_column` VALUES (117, 12, 'show_donation_list', '是否在捐赠列表显示（0不显示 1显示）', 'tinyint(1)', 'Integer', 'showDonationList', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2025-04-03 00:51:41', '', NULL);
INSERT INTO `gen_table_column` VALUES (118, 12, 'show_real_name', '是否显示真实姓名（0不显示 1显示）', 'tinyint(1)', 'Integer', 'showRealName', '0', '0', '0', '1', '1', '1', '1', 'LIKE', 'input', '', 4, 'admin', '2025-04-03 00:51:41', '', NULL);
INSERT INTO `gen_table_column` VALUES (119, 12, 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'datetime', '', 5, 'admin', '2025-04-03 00:51:41', '', NULL);
INSERT INTO `gen_table_column` VALUES (120, 12, 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', '0', '1', '1', NULL, NULL, 'EQ', 'datetime', '', 6, 'admin', '2025-04-03 00:51:41', '', NULL);

SET FOREIGN_KEY_CHECKS = 1;
