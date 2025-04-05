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

 Date: 05/04/2025 20:41:44
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for blockchain_transaction
-- ----------------------------
DROP TABLE IF EXISTS `blockchain_transaction`;
CREATE TABLE `blockchain_transaction`  (
  `tx_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '交易ID',
  `transaction_hash` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '交易哈希值',
  `related_id` bigint(0) NULL DEFAULT NULL COMMENT '关联业务ID',
  `related_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '关联业务类型（donation/project/usage）',
  `tx_data` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '交易数据(JSON)',
  `tx_time` datetime(0) NULL DEFAULT NULL COMMENT '交易时间',
  `tx_status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '交易状态（0处理中 1成功 2失败）',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `block_number` bigint(0) NULL DEFAULT NULL COMMENT '区块高度',
  PRIMARY KEY (`tx_id`) USING BTREE,
  INDEX `idx_related_id`(`related_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '区块链交易记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of blockchain_transaction
-- ----------------------------
INSERT INTO `blockchain_transaction` VALUES ('1b6197d4c76eaf9b1f0c7dbf05a70f567e1cc4353c28bf8d1bb322e90217c282', '1b6197d4c76eaf9b1f0c7dbf05a70f567e1cc4353c28bf8d1bb322e90217c282', 1743837664754, 'other', 'Sat Apr 05 15:21:04 CST 2025', '2025-04-05 15:21:05', '1', '2025-04-05 15:21:05', 10012);
INSERT INTO `blockchain_transaction` VALUES ('1f8ca13fcbb74b180c1da20dad8b78d519af2a8a31125f2411e8eef57710628b', '1f8ca13fcbb74b180c1da20dad8b78d519af2a8a31125f2411e8eef57710628b', 1743837642090, 'other', 'Sat Apr 05 15:20:42 CST 2025', '2025-04-05 15:20:42', '1', '2025-04-05 15:20:42', 10002);
INSERT INTO `blockchain_transaction` VALUES ('217b038edaf3a0bc4b6f61d19bcf5dcf60c6158525cd713fc55433c5a792b8be', '217b038edaf3a0bc4b6f61d19bcf5dcf60c6158525cd713fc55433c5a792b8be', 1743837648740, 'other', 'Sat Apr 05 15:20:48 CST 2025', '2025-04-05 15:20:49', '1', '2025-04-05 15:20:49', 10005);
INSERT INTO `blockchain_transaction` VALUES ('339a54d60a4f9df03dfe50cfc95ee996874c4d0134ab015253c0c469379e1106', '339a54d60a4f9df03dfe50cfc95ee996874c4d0134ab015253c0c469379e1106', 1743837671188, 'other', 'Sat Apr 05 15:21:11 CST 2025', '2025-04-05 15:21:11', '1', '2025-04-05 15:21:11', 10015);
INSERT INTO `blockchain_transaction` VALUES ('3ef126ab482d7455ba32abef51f51f728f5d42faaf0799c51ae94fd659091329', '3ef126ab482d7455ba32abef51f51f728f5d42faaf0799c51ae94fd659091329', 1743837662653, 'other', 'Sat Apr 05 15:21:02 CST 2025', '2025-04-05 15:21:03', '1', '2025-04-05 15:21:03', 10011);
INSERT INTO `blockchain_transaction` VALUES ('4d2413dee32e2364db46478bb31948bac4d8f155eab1c65de8f85fa975a59da9', '4d2413dee32e2364db46478bb31948bac4d8f155eab1c65de8f85fa975a59da9', 1743837660494, 'other', 'Sat Apr 05 15:21:00 CST 2025', '2025-04-05 15:21:00', '1', '2025-04-05 15:21:00', 10010);
INSERT INTO `blockchain_transaction` VALUES ('510d9d97f45710b934e16f2093543f7619ce80cb20dd3edc5d385e1842e7b181', '510d9d97f45710b934e16f2093543f7619ce80cb20dd3edc5d385e1842e7b181', 1743854316135, 'other', 'Sat Apr 05 19:58:36 CST 2025', '2025-04-05 19:58:36', '1', '2025-04-05 19:58:36', 10016);
INSERT INTO `blockchain_transaction` VALUES ('6fdb396eccde87822f9a44f3f220d8b62a62bd86f6894529a3bf6941b6f2dc1e', '6fdb396eccde87822f9a44f3f220d8b62a62bd86f6894529a3bf6941b6f2dc1e', 1743837644436, 'other', 'Sat Apr 05 15:20:44 CST 2025', '2025-04-05 15:20:44', '1', '2025-04-05 15:20:44', 10003);
INSERT INTO `blockchain_transaction` VALUES ('7d24ae9212c7234dc1105f50b6f71d41052a46f5b24f347c6172b7275cf42a3c', '7d24ae9212c7234dc1105f50b6f71d41052a46f5b24f347c6172b7275cf42a3c', 1743837653206, 'other', 'Sat Apr 05 15:20:53 CST 2025', '2025-04-05 15:20:53', '1', '2025-04-05 15:20:53', 10007);
INSERT INTO `blockchain_transaction` VALUES ('943381cd0243fab4005bd1da594c478f86362780fca436525eac67be46f8b1ba', '943381cd0243fab4005bd1da594c478f86362780fca436525eac67be46f8b1ba', 1743837666853, 'other', 'Sat Apr 05 15:21:06 CST 2025', '2025-04-05 15:21:07', '1', '2025-04-05 15:21:07', 10013);
INSERT INTO `blockchain_transaction` VALUES ('9a78925efd0e173df9ac55b01415ac5db9f2ed9ce33574615a2a45a899137643', '9a78925efd0e173df9ac55b01415ac5db9f2ed9ce33574615a2a45a899137643', 1743837655419, 'other', 'Sat Apr 05 15:20:55 CST 2025', '2025-04-05 15:20:55', '1', '2025-04-05 15:20:55', 10008);
INSERT INTO `blockchain_transaction` VALUES ('a54bf21a46444240a4ceb29c44190a7f5d73e5249cc99ab39f2b772ebc9f8b0b', 'a54bf21a46444240a4ceb29c44190a7f5d73e5249cc99ab39f2b772ebc9f8b0b', 1743837669023, 'other', 'Sat Apr 05 15:21:09 CST 2025', '2025-04-05 15:21:09', '1', '2025-04-05 15:21:09', 10014);
INSERT INTO `blockchain_transaction` VALUES ('b61e643d360719662376137447491191dbccabff5b2c7c37cdf5f5c19fabdd41', 'b61e643d360719662376137447491191dbccabff5b2c7c37cdf5f5c19fabdd41', 1743837646587, 'other', 'Sat Apr 05 15:20:46 CST 2025', '2025-04-05 15:20:47', '1', '2025-04-05 15:20:47', 10004);
INSERT INTO `blockchain_transaction` VALUES ('c2096e48999437e191d4e209041339bb4d511556f6589c9597d00492d97f5064', 'c2096e48999437e191d4e209041339bb4d511556f6589c9597d00492d97f5064', 1743837651045, 'other', 'Sat Apr 05 15:20:51 CST 2025', '2025-04-05 15:20:51', '1', '2025-04-05 15:20:51', 10006);
INSERT INTO `blockchain_transaction` VALUES ('c96c818a47138b9ddeebd1e6dee6d0d6f8a43b5b988c954cc583d47c64a2aa47', 'c96c818a47138b9ddeebd1e6dee6d0d6f8a43b5b988c954cc583d47c64a2aa47', 1743837657691, 'other', 'Sat Apr 05 15:20:57 CST 2025', '2025-04-05 15:20:58', '1', '2025-04-05 15:20:58', 10009);
INSERT INTO `blockchain_transaction` VALUES ('e2db483a75703ec8ccaf77d3f1379df11eefa3ca95fca1d4840784826ec0a8a8', 'e2db483a75703ec8ccaf77d3f1379df11eefa3ca95fca1d4840784826ec0a8a8', 1743854866359, 'other', 'Sat Apr 05 20:07:46 CST 2025', '2025-04-05 20:07:46', '1', '2025-04-05 20:07:46', 10017);
INSERT INTO `blockchain_transaction` VALUES ('e5cb95ccc6b347cdf7664fb066a1a16f9c7dbb4ce1d2211aa5bf7a12724e2276', 'e5cb95ccc6b347cdf7664fb066a1a16f9c7dbb4ce1d2211aa5bf7a12724e2276', 1743837635560, 'other', 'Sat Apr 05 15:20:35 CST 2025', '2025-04-05 15:20:36', '1', '2025-04-05 15:20:36', 10001);

-- ----------------------------
-- Table structure for charity_project
-- ----------------------------
DROP TABLE IF EXISTS `charity_project`;
CREATE TABLE `charity_project`  (
  `project_id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '项目ID',
  `project_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '项目名称',
  `project_desc` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '项目描述',
  `target_amount` decimal(10, 2) NULL DEFAULT NULL COMMENT '目标金额',
  `current_amount` decimal(10, 2) NULL COMMENT '当前筹集金额',
  `initiator_id` bigint(0) NULL DEFAULT NULL COMMENT '发起人ID',
  `initiator_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '发起类型（0个人 1慈善组织）',
  `cover_image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '项目封面图片',
  `start_time` datetime(0) NULL DEFAULT NULL COMMENT '开始时间',
  `end_time` datetime(0) NULL DEFAULT NULL COMMENT '结束时间',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态（0待审核 1进行中 2已完成 3已关闭）',
  `blockchain_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '区块链上的项目ID',
  `fund_usage_rules` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '资金使用规则（JSON格式存储简单规则）',
  `audit_user_id` bigint(0) NULL DEFAULT NULL COMMENT '审核人ID',
  `audit_time` datetime(0) NULL DEFAULT NULL COMMENT '审核时间',
  `audit_status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '审核状态（0待审核 1通过 2拒绝）',
  `audit_remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '审核备注',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`project_id`) USING BTREE,
  INDEX `idx_initiator_id`(`initiator_id`) USING BTREE,
  INDEX `idx_status`(`status`) USING BTREE,
  INDEX `idx_audit_status`(`audit_status`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '慈善项目表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of charity_project
-- ----------------------------
INSERT INTO `charity_project` VALUES (1, '希望工程助学计划', '<p>为贫困地区的孩子提供教育资助，帮助他们完成学业</p>', 100000.00, 35000.00, 1, '0', '/profile/upload/2025/04/03/PixPin_2025-03-15_20-59-14_20250403090900A003.png', '2025-03-04 00:00:00', '2025-06-02 00:00:00', '1', 'bc_proj_001', '{\"rule1\":\"资金将全部用于学生学费和生活补贴\",\"rule2\":\"每季度公布资金使用情况\"}', 100, '2025-04-04 00:00:00', '0', 'dfsa', '2025-04-03 09:05:38', '2025-04-04 18:20:48');
INSERT INTO `charity_project` VALUES (2, '山区医疗援助', '<p>为偏远山区提供基础医疗设备和药品，改善当地医疗条件</p>', 50000.00, 25413.00, 2, '1', '/profile/upload/2025/04/03/2d52ca694cdc86a78eee55e46329bd5d_20250403092848A002.jpg', '2025-03-19 00:00:00', '2025-07-02 00:00:00', '1', 'bc_proj_002', '{\"rule1\":\"60%用于医疗设备采购\",\"rule2\":\"40%用于药品采购\"}', 101, '2025-04-04 00:00:00', '0', 'sadf', '2025-04-03 09:05:38', '2025-04-04 18:21:17');
INSERT INTO `charity_project` VALUES (3, '环保植树行动', '<p>在沙漠化地区开展植树活动，改善生态环境</p>', 30000.00, 5010.00, 100, '0', '/profile/upload/2025/04/04/brown-glass10_20250404180432A001.jpg', '2025-03-29 00:00:00', '2025-08-01 00:00:00', '1', 'bc_proj_003', '{\"rule1\":\"80%用于树苗购买和种植\",\"rule2\":\"20%用于后期维护\"}', 101, '2025-04-03 00:00:00', '0', '11', '2025-04-03 09:05:38', '2025-04-04 18:04:34');
INSERT INTO `charity_project` VALUES (4, '老年人关爱计划', '为孤寡老人提供生活用品和心理关怀服务', 20000.00, 0.00, 101, '1', 'project/cover/elderly_care.jpg', '2025-04-03 09:05:38', '2025-05-18 09:05:38', '1', NULL, '{\"rule1\":\"全部用于老人生活物资采购和志愿者补贴\"}', NULL, NULL, '0', NULL, '2025-04-03 09:05:38', '2025-04-03 09:05:38');
INSERT INTO `charity_project` VALUES (5, '灾区重建援助', '<p>为自然灾害受灾地区提供重建资金和物资支持</p>', 200000.00, 150000.00, 1, '1', '/profile/upload/2025/04/03/PixPin_2025-03-15_21-03-13_20250403090709A001.png', '2025-02-02 00:00:00', '2025-03-24 00:00:00', '1', 'bc_proj_004', '{\"rule1\":\"70%用于基础设施重建\",\"rule2\":\"30%用于灾民生活补助\"}', 100, '2025-02-07 00:00:00', '0', 'teset', '2025-04-03 09:05:38', '2025-04-04 18:37:09');
INSERT INTO `charity_project` VALUES (11, 'test', '<blockquote><br></blockquote>', 1000.00, 0.00, NULL, '1', '/profile/upload/2025/04/05/PixPin_2025-03-15_20-59-14_20250405195827A001.png', '2025-04-18 00:00:00', '2025-05-11 00:00:00', '1', 'project_75e1825329a7469d', 'test', NULL, NULL, '0', 'test', '2025-04-05 19:58:34', '2025-04-05 19:58:45');
INSERT INTO `charity_project` VALUES (12, 'test', '<p>tests</p>', 1000.00, 0.00, NULL, '0', '/profile/upload/2025/04/05/PixPin_2025-03-15_20-59-14_20250405200740A001.png', '2025-04-18 00:00:00', '2025-05-12 00:00:00', '1', 'project_54b8ef6fe6294bda', 'tests', NULL, NULL, '0', 'tes', '2025-04-05 20:07:44', '2025-04-05 20:07:58');

-- ----------------------------
-- Table structure for donation_record
-- ----------------------------
DROP TABLE IF EXISTS `donation_record`;
CREATE TABLE `donation_record`  (
  `donation_id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '捐赠ID',
  `user_id` bigint(0) NULL DEFAULT NULL COMMENT '捐赠用户ID',
  `project_id` bigint(0) NOT NULL COMMENT '慈善项目ID',
  `donation_amount` decimal(10, 2) NOT NULL COMMENT '捐赠金额',
  `payment_method` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '捐赠方式',
  `donation_time` datetime(0) NOT NULL COMMENT '捐赠时间',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态（0待处理 1已完成 2已拒绝）',
  `transaction_hash` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '区块链交易哈希',
  `certificate_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '捐赠证书URL',
  `certificate_issue_date` datetime(0) NULL DEFAULT NULL COMMENT '证书颁发日期',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`donation_id`) USING BTREE,
  INDEX `idx_user_id`(`user_id`) USING BTREE,
  INDEX `idx_project_id`(`project_id`) USING BTREE,
  CONSTRAINT `fk_donation_user_id` FOREIGN KEY (`user_id`) REFERENCES `sys_user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '捐赠记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of donation_record
-- ----------------------------
INSERT INTO `donation_record` VALUES (10, 2, 1, 0.00, '微信支付', '2025-04-03 09:05:38', '0', NULL, NULL, NULL, '处理中的捐赠', '2025-04-03 09:05:38', '2025-04-03 09:05:38');
INSERT INTO `donation_record` VALUES (20, 1, 2, 10.00, 'online', '2025-04-04 19:20:18', '1', NULL, NULL, NULL, 'sdfsdf', '2025-04-04 19:20:18', NULL);
INSERT INTO `donation_record` VALUES (21, 1, 2, 40.00, 'online', '2025-04-05 19:50:13', '1', NULL, NULL, NULL, 'asdf', '2025-04-05 19:50:13', NULL);

-- ----------------------------
-- Table structure for fund_usage_record
-- ----------------------------
DROP TABLE IF EXISTS `fund_usage_record`;
CREATE TABLE `fund_usage_record`  (
  `usage_id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '使用记录ID',
  `project_id` bigint(0) NOT NULL COMMENT '慈善项目ID',
  `amount` decimal(10, 2) NOT NULL COMMENT '使用金额',
  `usage_desc` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '使用描述',
  `usage_time` datetime(0) NOT NULL COMMENT '使用时间',
  `application_status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '1' COMMENT '申请状态（0未提交 1待审核 2已审核）',
  `audit_status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '1' COMMENT '审核状态（0通过 1驳回）',
  `auditor` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '审核人',
  `audit_time` datetime(0) NULL DEFAULT NULL COMMENT '审核时间',
  `audit_remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '审核备注',
  `proof_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '证明材料链接',
  `transaction_hash` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '区块链交易哈希',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`usage_id`) USING BTREE,
  INDEX `idx_project_id`(`project_id`) USING BTREE,
  INDEX `idx_fund_application_status`(`application_status`) USING BTREE COMMENT '申请状态索引',
  CONSTRAINT `fk_usage_project_id` FOREIGN KEY (`project_id`) REFERENCES `charity_project` (`project_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '资金使用记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fund_usage_record
-- ----------------------------
INSERT INTO `fund_usage_record` VALUES (1, 1, 10000.00, '为100名贫困学生支付本学期学费', '2025-03-24 09:05:38', '2', '1', 'admin', '2025-04-04 18:15:23', '', 'proof/usage_001.pdf', 'tx_hash_usage_001', 'admin', '2025-04-03 09:05:38');
INSERT INTO `fund_usage_record` VALUES (2, 1, 5000.00, '购买学习用品发放给贫困学生', '2025-03-26 09:05:38', '2', '1', 'admin', '2025-04-04 18:15:26', '', 'proof/usage_002.pdf', 'tx_hash_usage_002', 'admin', '2025-04-03 09:05:38');
INSERT INTO `fund_usage_record` VALUES (3, 2, 8000.00, '购买基础医疗设备送往山区诊所', '2025-03-29 09:05:38', '1', '1', NULL, NULL, NULL, 'proof/usage_003.pdf', 'tx_hash_usage_003', 'admin', '2025-04-03 09:05:38');
INSERT INTO `fund_usage_record` VALUES (4, 3, 2000.00, '购买树苗1000棵', '2025-04-01 09:05:38', '1', '1', NULL, NULL, NULL, 'proof/usage_004.pdf', 'tx_hash_usage_004', 'admin', '2025-04-03 09:05:38');
INSERT INTO `fund_usage_record` VALUES (5, 5, 50000.00, '灾区道路修复工程', '2025-03-04 09:05:38', '1', '1', NULL, NULL, NULL, 'proof/usage_005.pdf', 'tx_hash_usage_005', 'admin', '2025-04-03 09:05:38');
INSERT INTO `fund_usage_record` VALUES (6, 5, 30000.00, '为受灾家庭提供临时住所建设', '2025-03-09 09:05:38', '1', '1', NULL, NULL, NULL, 'proof/usage_006.pdf', 'tx_hash_usage_006', 'admin', '2025-04-03 09:05:38');
INSERT INTO `fund_usage_record` VALUES (7, 5, 20000.00, '灾区学校重建项目', '2025-03-14 09:05:38', '2', '1', 'admin', '2025-04-04 19:06:52', 'teset', 'proof/usage_007.pdf', 'tx_hash_usage_007', 'admin', '2025-04-03 09:05:38');
INSERT INTO `fund_usage_record` VALUES (8, 1, 1000.00, 'ssadf', '2025-04-03 00:00:00', '2', '1', 'admin', '2025-04-04 18:59:30', '', '/profile/upload/2025/04/03/Java高级程序设计-1_20250403171251A001.pdf', NULL, '', '2025-04-03 17:13:03');
INSERT INTO `fund_usage_record` VALUES (9, 1, 10000.00, '【救助支出】testfsdfasdfa', '2025-04-03 00:00:00', '2', '1', 'admin', '2025-04-04 18:58:23', '', '/profile/upload/2025/04/03/Java高级程序设计-1_20250403171617A002.pdf', NULL, '', '2025-04-03 17:16:22');
INSERT INTO `fund_usage_record` VALUES (10, 1, 10000.00, '【医疗支出】tesatset', '2025-04-04 00:00:00', '2', '1', 'admin', '2025-04-04 18:58:38', '', '/profile/upload/2025/04/04/Java高级程序设计-1_20250404185805A001.pdf', NULL, '', '2025-04-04 18:58:06');

-- ----------------------------
-- Table structure for gen_table
-- ----------------------------
DROP TABLE IF EXISTS `gen_table`;
CREATE TABLE `gen_table`  (
  `table_id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '表名称',
  `table_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '表描述',
  `sub_table_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '关联子表的表名',
  `sub_table_fk_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '子表关联的外键名',
  `class_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '实体类名称',
  `tpl_category` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'crud' COMMENT '使用的模板（crud单表操作 tree树表操作）',
  `tpl_web_type` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '前端模板类型（element-ui模版 element-plus模版）',
  `package_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生成包路径',
  `module_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生成模块名',
  `business_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生成业务名',
  `function_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生成功能名',
  `function_author` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生成功能作者',
  `gen_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '生成代码方式（0zip压缩包 1自定义路径）',
  `gen_path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '/' COMMENT '生成路径（不填默认项目路径）',
  `options` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '其它生成选项',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`table_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '代码生成业务表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gen_table
-- ----------------------------
INSERT INTO `gen_table` VALUES (7, 'blockchain_transaction', '区块链交易记录表', NULL, NULL, 'BlockchainTransaction', 'crud', 'element-plus', 'com.ruoyi.charity', 'charity', 'blockchain', '区块链交易记录', 'ruoyi', '0', '/', NULL, 'admin', '2025-04-03 00:51:41', '', NULL, NULL);
INSERT INTO `gen_table` VALUES (8, 'charity_project', '慈善项目表', NULL, NULL, 'CharityProject', 'crud', 'element-plus', 'com.ruoyi.charity', 'charity', 'project', '慈善项目', 'ruoyi', '0', '/', NULL, 'admin', '2025-04-03 00:51:41', '', NULL, NULL);
INSERT INTO `gen_table` VALUES (9, 'donation_record', '捐赠记录表', NULL, NULL, 'DonationRecord', 'crud', 'element-plus', 'com.ruoyi.charity', 'charity', 'donation', '捐赠记录', 'ruoyi', '0', '/', '{}', 'admin', '2025-04-03 00:51:41', '', '2025-04-03 00:52:23', NULL);
INSERT INTO `gen_table` VALUES (10, 'fund_usage_record', '资金使用记录表', NULL, NULL, 'FundUsageRecord', 'crud', 'element-plus', 'com.ruoyi.charity', 'charity', 'fund', '资金使用记录', 'ruoyi', '0', '/', NULL, 'admin', '2025-04-03 00:51:41', '', NULL, NULL);
INSERT INTO `gen_table` VALUES (11, 'project_comment', '项目评价表', NULL, NULL, 'ProjectComment', 'crud', 'element-plus', 'com.ruoyi.charity', 'charity', 'comment', '项目评价', 'ruoyi', '0', '/', NULL, 'admin', '2025-04-03 00:51:41', '', NULL, NULL);
INSERT INTO `gen_table` VALUES (12, 'user_privacy_settings', '用户隐私设置表', NULL, NULL, 'UserPrivacySettings', 'crud', 'element-plus', 'com.ruoyi.charity', 'charity', 'privacy', '用户隐私设置', 'ruoyi', '0', '/', NULL, 'admin', '2025-04-03 00:51:41', '', NULL, NULL);

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
) ENGINE = InnoDB AUTO_INCREMENT = 120 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '代码生成业务表字段' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gen_table_column
-- ----------------------------
INSERT INTO `gen_table_column` VALUES (61, 7, 'tx_id', '交易编号', 'varchar(100)', 'String', 'txId', '1', '0', '1', '1', '0', '1', '1', 'EQ', 'input', '', 1, 'admin', '2025-04-03 00:51:41', '', NULL);
INSERT INTO `gen_table_column` VALUES (62, 7, 'related_id', '关联业务编号', 'bigint', 'Long', 'relatedId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2025-04-03 00:51:41', '', NULL);
INSERT INTO `gen_table_column` VALUES (63, 7, 'related_type', '关联业务类型', 'varchar(50)', 'String', 'relatedType', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'select', 'blockchain_related_type', 3, 'admin', '2025-04-03 00:51:41', '', NULL);
INSERT INTO `gen_table_column` VALUES (64, 7, 'tx_data', '交易数据(JSON格式)', 'text', 'String', 'txData', '0', '0', '1', '1', '1', '0', '0', 'EQ', 'textarea', '', 4, 'admin', '2025-04-03 00:51:41', '', NULL);
INSERT INTO `gen_table_column` VALUES (65, 7, 'tx_time', '交易时间', 'datetime', 'Date', 'txTime', '0', '0', '1', '1', '1', '1', '1', 'BETWEEN', 'datetime', '', 5, 'admin', '2025-04-03 00:51:41', '', NULL);
INSERT INTO `gen_table_column` VALUES (66, 7, 'tx_status', '交易状态', 'char(1)', 'String', 'txStatus', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'select', 'blockchain_tx_status', 6, 'admin', '2025-04-03 00:51:41', '', NULL);
INSERT INTO `gen_table_column` VALUES (67, 7, 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', '0', '1', '0', '1', '1', 'BETWEEN', 'datetime', '', 7, 'admin', '2025-04-03 00:51:41', '', NULL);
INSERT INTO `gen_table_column` VALUES (68, 8, 'project_id', '项目编号', 'bigint', 'Long', 'projectId', '1', '1', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2025-04-03 00:51:41', '', NULL);
INSERT INTO `gen_table_column` VALUES (69, 8, 'project_name', '项目名称', 'varchar(100)', 'String', 'projectName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 2, 'admin', '2025-04-03 00:51:41', '', NULL);
INSERT INTO `gen_table_column` VALUES (70, 8, 'project_desc', '项目描述', 'text', 'String', 'projectDesc', '0', '0', '1', '1', '1', '0', '0', 'EQ', 'editor', '', 3, 'admin', '2025-04-03 00:51:41', '', NULL);
INSERT INTO `gen_table_column` VALUES (71, 8, 'target_amount', '目标金额', 'decimal(10,2)', 'BigDecimal', 'targetAmount', '0', '0', '1', '1', '1', '1', '0', 'EQ', 'input', '', 4, 'admin', '2025-04-03 00:51:41', '', NULL);
INSERT INTO `gen_table_column` VALUES (72, 8, 'current_amount', '当前金额', 'decimal(10,2)', 'BigDecimal', 'currentAmount', '0', '0', '0', '1', '1', '1', '0', 'EQ', 'input', '', 5, 'admin', '2025-04-03 00:51:41', '', NULL);
INSERT INTO `gen_table_column` VALUES (73, 8, 'initiator_id', '发起人编号', 'bigint', 'Long', 'initiatorId', '0', '0', '1', '1', '0', '1', '1', 'EQ', 'input', '', 6, 'admin', '2025-04-03 00:51:41', '', NULL);
INSERT INTO `gen_table_column` VALUES (74, 8, 'initiator_type', '发起类型', 'char(1)', 'String', 'initiatorType', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'select', 'charity_initiator_type', 7, 'admin', '2025-04-03 00:51:41', '', NULL);
INSERT INTO `gen_table_column` VALUES (75, 8, 'cover_image', '封面图片', 'varchar(255)', 'String', 'coverImage', '0', '0', '0', '1', '1', '1', '0', 'EQ', 'imageUpload', '', 8, 'admin', '2025-04-03 00:51:41', '', NULL);
INSERT INTO `gen_table_column` VALUES (76, 8, 'start_time', '开始时间', 'datetime', 'Date', 'startTime', '0', '0', '1', '1', '1', '1', '1', 'BETWEEN', 'datetime', '', 9, 'admin', '2025-04-03 00:51:41', '', NULL);
INSERT INTO `gen_table_column` VALUES (77, 8, 'end_time', '结束时间', 'datetime', 'Date', 'endTime', '0', '0', '1', '1', '1', '1', '1', 'BETWEEN', 'datetime', '', 10, 'admin', '2025-04-03 00:51:41', '', NULL);
INSERT INTO `gen_table_column` VALUES (78, 8, 'status', '项目状态', 'char(1)', 'String', 'status', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'select', 'charity_project_status', 11, 'admin', '2025-04-03 00:51:41', '', NULL);
INSERT INTO `gen_table_column` VALUES (79, 8, 'blockchain_id', '区块链项目编号', 'varchar(100)', 'String', 'blockchainId', '0', '0', '0', '1', '0', '1', '0', 'EQ', 'input', '', 12, 'admin', '2025-04-03 00:51:41', '', NULL);
INSERT INTO `gen_table_column` VALUES (80, 8, 'fund_usage_rules', '资金使用规则(JSON格式)', 'text', 'String', 'fundUsageRules', '0', '0', '0', '1', '1', '0', '0', 'EQ', 'textarea', '', 13, 'admin', '2025-04-03 00:51:41', '', NULL);
INSERT INTO `gen_table_column` VALUES (81, 8, 'audit_user_id', '审核人编号', 'bigint', 'Long', 'auditUserId', '0', '0', '0', '1', '0', '1', '0', 'EQ', 'input', '', 14, 'admin', '2025-04-03 00:51:41', '', NULL);
INSERT INTO `gen_table_column` VALUES (82, 8, 'audit_time', '审核时间', 'datetime', 'Date', 'auditTime', '0', '0', '0', '1', '1', '1', '1', 'BETWEEN', 'datetime', '', 15, 'admin', '2025-04-03 00:51:41', '', NULL);
INSERT INTO `gen_table_column` VALUES (83, 8, 'audit_status', '审核状态', 'char(1)', 'String', 'auditStatus', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'select', 'charity_project_audit_status', 16, 'admin', '2025-04-03 00:51:41', '', NULL);
INSERT INTO `gen_table_column` VALUES (84, 8, 'audit_remark', '审核备注', 'varchar(500)', 'String', 'auditRemark', '0', '0', '0', '1', '1', '0', '0', 'EQ', 'textarea', '', 17, 'admin', '2025-04-03 00:51:41', '', NULL);
INSERT INTO `gen_table_column` VALUES (85, 8, 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', '0', '1', '0', '1', '1', 'BETWEEN', 'datetime', '', 18, 'admin', '2025-04-03 00:51:41', '', NULL);
INSERT INTO `gen_table_column` VALUES (86, 8, 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', '0', '1', '1', NULL, NULL, 'EQ', 'datetime', '', 19, 'admin', '2025-04-03 00:51:41', '', NULL);
INSERT INTO `gen_table_column` VALUES (87, 9, 'donation_id', '捐赠编号', 'bigint', 'Long', 'donationId', '1', '1', '1', '1', '0', '1', '0', 'EQ', 'input', '', 1, 'admin', '2025-04-03 00:51:41', '', '2025-04-03 00:52:23');
INSERT INTO `gen_table_column` VALUES (88, 9, 'user_id', '用户编号', 'bigint', 'Long', 'userId', '0', '0', '1', '1', '0', '1', '1', 'EQ', 'input', '', 2, 'admin', '2025-04-03 00:51:41', '', '2025-04-03 00:52:23');
INSERT INTO `gen_table_column` VALUES (89, 9, 'project_id', '项目编号', 'bigint', 'Long', 'projectId', '0', '0', '1', '1', '0', '1', '1', 'EQ', 'input', '', 3, 'admin', '2025-04-03 00:51:41', '', '2025-04-03 00:52:23');
INSERT INTO `gen_table_column` VALUES (90, 9, 'donation_amount', '捐赠金额', 'decimal(10,2)', 'BigDecimal', 'donationAmount', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 4, 'admin', '2025-04-03 00:51:41', '', '2025-04-03 00:52:23');
INSERT INTO `gen_table_column` VALUES (91, 9, 'payment_method', '支付方式', 'varchar(50)', 'String', 'paymentMethod', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'select', '', 5, 'admin', '2025-04-03 00:51:41', '', '2025-04-03 00:52:23');
INSERT INTO `gen_table_column` VALUES (92, 9, 'donation_time', '捐赠时间', 'datetime', 'Date', 'donationTime', '0', '0', '1', '1', '1', '1', '1', 'BETWEEN', 'datetime', '', 6, 'admin', '2025-04-03 00:51:41', '', '2025-04-03 00:52:23');
INSERT INTO `gen_table_column` VALUES (93, 9, 'status', '捐赠状态', 'char(1)', 'String', 'status', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'select', 'donation_status', 7, 'admin', '2025-04-03 00:51:41', '', '2025-04-03 00:52:23');
INSERT INTO `gen_table_column` VALUES (94, 9, 'transaction_hash', '区块链交易哈希值', 'varchar(100)', 'String', 'transactionHash', '0', '0', '0', '1', '0', '1', '0', 'EQ', 'input', '', 8, 'admin', '2025-04-03 00:51:41', '', '2025-04-03 00:52:23');
INSERT INTO `gen_table_column` VALUES (95, 9, 'certificate_url', '捐赠证书链接', 'varchar(255)', 'String', 'certificateUrl', '0', '0', '0', '1', '1', '1', '0', 'EQ', 'input', '', 9, 'admin', '2025-04-03 00:51:41', '', '2025-04-03 00:52:23');
INSERT INTO `gen_table_column` VALUES (96, 9, 'certificate_issue_date', '证书颁发日期', 'datetime', 'Date', 'certificateIssueDate', '0', '0', '0', '1', '1', '1', '0', 'BETWEEN', 'datetime', '', 10, 'admin', '2025-04-03 00:51:41', '', '2025-04-03 00:52:23');
INSERT INTO `gen_table_column` VALUES (97, 9, 'remark', '备注', 'varchar(500)', 'String', 'remark', '0', '0', '0', '1', '1', '0', '0', 'EQ', 'textarea', '', 11, 'admin', '2025-04-03 00:51:41', '', '2025-04-03 00:52:23');
INSERT INTO `gen_table_column` VALUES (98, 9, 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', '0', '1', '0', '1', '1', 'BETWEEN', 'datetime', '', 12, 'admin', '2025-04-03 00:51:41', '', '2025-04-03 00:52:23');
INSERT INTO `gen_table_column` VALUES (99, 9, 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', '0', '1', '1', NULL, NULL, 'EQ', 'datetime', '', 13, 'admin', '2025-04-03 00:51:41', '', '2025-04-03 00:52:23');
INSERT INTO `gen_table_column` VALUES (100, 10, 'usage_id', '使用记录编号', 'bigint', 'Long', 'usageId', '1', '1', '1', '1', '0', '1', '0', 'EQ', 'input', '', 1, 'admin', '2025-04-03 00:51:41', '', NULL);
INSERT INTO `gen_table_column` VALUES (101, 10, 'project_id', '项目编号', 'bigint', 'Long', 'projectId', '0', '0', '1', '1', '0', '1', '1', 'EQ', 'input', '', 2, 'admin', '2025-04-03 00:51:41', '', NULL);
INSERT INTO `gen_table_column` VALUES (102, 10, 'amount', '使用金额', 'decimal(10,2)', 'BigDecimal', 'amount', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2025-04-03 00:51:41', '', NULL);
INSERT INTO `gen_table_column` VALUES (103, 10, 'usage_desc', '使用描述', 'varchar(500)', 'String', 'usageDesc', '0', '0', '1', '1', '1', '1', '0', 'EQ', 'textarea', '', 4, 'admin', '2025-04-03 00:51:41', '', NULL);
INSERT INTO `gen_table_column` VALUES (104, 10, 'usage_time', '使用时间', 'datetime', 'Date', 'usageTime', '0', '0', '1', '1', '1', '1', '1', 'BETWEEN', 'datetime', '', 5, 'admin', '2025-04-03 00:51:41', '', NULL);
INSERT INTO `gen_table_column` VALUES (105, 10, 'proof_url', '证明材料文件', 'varchar(255)', 'String', 'proofUrl', '0', '0', '1', '1', '1', '1', '0', 'EQ', 'fileUpload', '', 6, 'admin', '2025-04-03 00:51:41', '', NULL);
INSERT INTO `gen_table_column` VALUES (106, 10, 'transaction_hash', '区块链交易哈希值', 'varchar(100)', 'String', 'transactionHash', '0', '0', '0', '1', '0', '1', '0', 'EQ', 'input', '', 7, 'admin', '2025-04-03 00:51:41', '', NULL);
INSERT INTO `gen_table_column` VALUES (107, 10, 'create_by', '创建者', 'varchar(64)', 'String', 'createBy', '0', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 8, 'admin', '2025-04-03 00:51:41', '', NULL);
INSERT INTO `gen_table_column` VALUES (108, 10, 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', '0', '1', '0', '1', '1', 'BETWEEN', 'datetime', '', 9, 'admin', '2025-04-03 00:51:41', '', NULL);
INSERT INTO `gen_table_column` VALUES (109, 11, 'comment_id', '评价编号', 'bigint', 'Long', 'commentId', '1', '1', '1', '1', '0', '1', '0', 'EQ', 'input', '', 1, 'admin', '2025-04-03 00:51:41', '', NULL);
INSERT INTO `gen_table_column` VALUES (110, 11, 'project_id', '项目编号', 'bigint', 'Long', 'projectId', '0', '0', '1', '1', '0', '1', '1', 'EQ', 'input', '', 2, 'admin', '2025-04-03 00:51:41', '', NULL);
INSERT INTO `gen_table_column` VALUES (111, 11, 'user_id', '用户编号', 'bigint', 'Long', 'userId', '0', '0', '1', '1', '0', '1', '1', 'EQ', 'input', '', 3, 'admin', '2025-04-03 00:51:41', '', NULL);
INSERT INTO `gen_table_column` VALUES (112, 11, 'content', '评价内容', 'text', 'String', 'content', '0', '0', '1', '1', '1', '1', '0', 'EQ', 'textarea', '', 4, 'admin', '2025-04-03 00:51:41', '', NULL);
INSERT INTO `gen_table_column` VALUES (113, 11, 'rating', '评分', 'int', 'Long', 'rating', '0', '0', '1', '1', '1', '1', '0', 'EQ', 'slider', '', 5, 'admin', '2025-04-03 00:51:41', '', NULL);
INSERT INTO `gen_table_column` VALUES (114, 11, 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', '0', '1', '0', '1', '1', 'BETWEEN', 'datetime', '', 6, 'admin', '2025-04-03 00:51:41', '', NULL);
INSERT INTO `gen_table_column` VALUES (115, 12, 'user_id', '用户编号', 'bigint', 'Long', 'userId', '1', '0', '0', '1', '0', '1', '1', 'EQ', 'input', '', 1, 'admin', '2025-04-03 00:51:41', '', '2025-04-03 00:58:07');
INSERT INTO `gen_table_column` VALUES (116, 12, 'show_donation_amount', '是否显示捐赠金额（0不显示 1显示）', 'tinyint(1)', 'Integer', 'showDonationAmount', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'radio', 'sys_yes_no', 2, 'admin', '2025-04-03 00:51:41', '', '2025-04-03 00:58:07');
INSERT INTO `gen_table_column` VALUES (117, 12, 'show_donation_list', '是否在捐赠列表显示（0不显示 1显示）', 'tinyint(1)', 'Integer', 'showDonationList', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'radio', 'sys_yes_no', 3, 'admin', '2025-04-03 00:51:41', '', '2025-04-03 00:58:07');
INSERT INTO `gen_table_column` VALUES (118, 12, 'show_real_name', '是否显示真实姓名（0不显示 1显示）', 'tinyint(1)', 'Integer', 'showRealName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'radio', 'sys_yes_no', 4, 'admin', '2025-04-03 00:51:41', '', '2025-04-03 00:58:07');
INSERT INTO `gen_table_column` VALUES (119, 12, 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', '0', '1', '0', '1', '1', 'EQ', 'datetime', '', 5, 'admin', '2025-04-03 00:51:41', '', '2025-04-03 00:58:07');
INSERT INTO `gen_table_column` VALUES (120, 12, 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', '0', '1', '1', '0', '0', 'EQ', 'datetime', '', 6, 'admin', '2025-04-03 00:51:41', '', '2025-04-03 00:58:07');

-- ----------------------------
-- Table structure for project_comment
-- ----------------------------
DROP TABLE IF EXISTS `project_comment`;
CREATE TABLE `project_comment`  (
  `comment_id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '评价ID',
  `project_id` bigint(0) NOT NULL COMMENT '项目ID',
  `user_id` bigint(0) NOT NULL COMMENT '用户ID',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '评价内容',
  `rating` int(0) NULL DEFAULT 5 COMMENT '评分(1-5)',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`comment_id`) USING BTREE,
  INDEX `idx_project_id`(`project_id`) USING BTREE,
  INDEX `idx_user_id`(`user_id`) USING BTREE,
  CONSTRAINT `fk_comment_project_id` FOREIGN KEY (`project_id`) REFERENCES `charity_project` (`project_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_comment_user_id` FOREIGN KEY (`user_id`) REFERENCES `sys_user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '项目评价表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of project_comment
-- ----------------------------
INSERT INTO `project_comment` VALUES (1, 1, 1, '项目非常有意义，希望能帮助更多的孩子', 5, '2025-03-19 09:05:38');
INSERT INTO `project_comment` VALUES (2, 1, 2, '项目执行透明，资金使用情况清晰', 5, '2025-03-20 09:05:38');
INSERT INTO `project_comment` VALUES (3, 1, 100, '希望工程一直是我支持的项目，继续加油', 4, '2025-03-24 09:05:38');
INSERT INTO `project_comment` VALUES (4, 2, 101, '山区医疗条件确实需要改善，支持这个项目', 5, '2025-03-26 09:05:38');
INSERT INTO `project_comment` VALUES (5, 2, 1, '项目进展情况可以更新得更频繁一些', 3, '2025-03-29 09:05:38');
INSERT INTO `project_comment` VALUES (6, 3, 2, '环保项目很有意义，期待看到更多树木种植', 4, '2025-04-02 09:05:38');
INSERT INTO `project_comment` VALUES (7, 5, 101, '灾区重建工作做得很好，资金使用透明', 5, '2025-03-14 09:05:38');
INSERT INTO `project_comment` VALUES (8, 5, 1, '希望灾区人民早日恢复正常生活', 5, '2025-03-16 09:05:38');
INSERT INTO `project_comment` VALUES (9, 2, 1, 'asdfasdf', 5, '2025-04-04 19:41:12');
INSERT INTO `project_comment` VALUES (10, 2, 1, 'afsdf', 5, '2025-04-04 19:53:45');

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config`  (
  `config_id` int(0) NOT NULL AUTO_INCREMENT COMMENT '参数主键',
  `config_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '参数名称',
  `config_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '参数键名',
  `config_value` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '参数键值',
  `config_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`config_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '参数配置表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES (1, '主框架页-默认皮肤样式名称', 'sys.index.skinName', 'skin-blue', 'Y', 'admin', '2025-04-02 21:18:49', '', NULL, '蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow');
INSERT INTO `sys_config` VALUES (2, '用户管理-账号初始密码', 'sys.user.initPassword', '123456', 'Y', 'admin', '2025-04-02 21:18:49', '', NULL, '初始化密码 123456');
INSERT INTO `sys_config` VALUES (3, '主框架页-侧边栏主题', 'sys.index.sideTheme', 'theme-dark', 'Y', 'admin', '2025-04-02 21:18:49', '', NULL, '深色主题theme-dark，浅色主题theme-light');
INSERT INTO `sys_config` VALUES (4, '账号自助-验证码开关', 'sys.account.captchaEnabled', 'false', 'Y', 'admin', '2025-04-02 21:18:49', '', NULL, '是否开启验证码功能（true开启，false关闭）');
INSERT INTO `sys_config` VALUES (5, '账号自助-是否开启用户注册功能', 'sys.account.registerUser', 'false', 'Y', 'admin', '2025-04-02 21:18:49', '', NULL, '是否开启注册用户功能（true开启，false关闭）');
INSERT INTO `sys_config` VALUES (6, '用户登录-黑名单列表', 'sys.login.blackIPList', '', 'Y', 'admin', '2025-04-02 21:18:49', '', NULL, '设置登录IP黑名单限制，多个匹配项以;分隔，支持匹配（*通配、网段）');

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept`  (
  `dept_id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '部门id',
  `parent_id` bigint(0) NULL DEFAULT 0 COMMENT '父部门id',
  `ancestors` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '祖级列表',
  `dept_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '部门名称',
  `order_num` int(0) NULL DEFAULT 0 COMMENT '显示顺序',
  `leader` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '邮箱',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`dept_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 109 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '部门表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES (100, 0, '0', '若依科技', 0, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-04-02 21:18:49', '', NULL);
INSERT INTO `sys_dept` VALUES (101, 100, '0,100', '深圳总公司', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-04-02 21:18:49', '', NULL);
INSERT INTO `sys_dept` VALUES (102, 100, '0,100', '长沙分公司', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-04-02 21:18:49', '', NULL);
INSERT INTO `sys_dept` VALUES (103, 101, '0,100,101', '研发部门', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-04-02 21:18:49', '', NULL);
INSERT INTO `sys_dept` VALUES (104, 101, '0,100,101', '市场部门', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-04-02 21:18:49', '', NULL);
INSERT INTO `sys_dept` VALUES (105, 101, '0,100,101', '测试部门', 3, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-04-02 21:18:49', '', NULL);
INSERT INTO `sys_dept` VALUES (106, 101, '0,100,101', '财务部门', 4, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-04-02 21:18:49', '', NULL);
INSERT INTO `sys_dept` VALUES (107, 101, '0,100,101', '运维部门', 5, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-04-02 21:18:49', '', NULL);
INSERT INTO `sys_dept` VALUES (108, 102, '0,100,102', '市场部门', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-04-02 21:18:49', '', NULL);
INSERT INTO `sys_dept` VALUES (109, 102, '0,100,102', '财务部门', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-04-02 21:18:49', '', NULL);

-- ----------------------------
-- Table structure for sys_dict_data
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_data`;
CREATE TABLE `sys_dict_data`  (
  `dict_code` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '字典编码',
  `dict_sort` int(0) NULL DEFAULT 0 COMMENT '字典排序',
  `dict_label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典类型',
  `css_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '表格回显样式',
  `is_default` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 123 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '字典数据表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict_data
-- ----------------------------
INSERT INTO `sys_dict_data` VALUES (1, 1, '男', '0', 'sys_user_sex', '', '', 'Y', '0', 'admin', '2025-04-02 21:18:49', '', NULL, '性别男');
INSERT INTO `sys_dict_data` VALUES (2, 2, '女', '1', 'sys_user_sex', '', '', 'N', '0', 'admin', '2025-04-02 21:18:49', '', NULL, '性别女');
INSERT INTO `sys_dict_data` VALUES (3, 3, '未知', '2', 'sys_user_sex', '', '', 'N', '0', 'admin', '2025-04-02 21:18:49', '', NULL, '性别未知');
INSERT INTO `sys_dict_data` VALUES (4, 1, '显示', '0', 'sys_show_hide', '', 'primary', 'Y', '0', 'admin', '2025-04-02 21:18:49', '', NULL, '显示菜单');
INSERT INTO `sys_dict_data` VALUES (5, 2, '隐藏', '1', 'sys_show_hide', '', 'danger', 'N', '0', 'admin', '2025-04-02 21:18:49', '', NULL, '隐藏菜单');
INSERT INTO `sys_dict_data` VALUES (6, 1, '正常', '0', 'sys_normal_disable', '', 'primary', 'Y', '0', 'admin', '2025-04-02 21:18:49', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (7, 2, '停用', '1', 'sys_normal_disable', '', 'danger', 'N', '0', 'admin', '2025-04-02 21:18:49', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (8, 1, '正常', '0', 'sys_job_status', '', 'primary', 'Y', '0', 'admin', '2025-04-02 21:18:49', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (9, 2, '暂停', '1', 'sys_job_status', '', 'danger', 'N', '0', 'admin', '2025-04-02 21:18:49', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (10, 1, '默认', 'DEFAULT', 'sys_job_group', '', '', 'Y', '0', 'admin', '2025-04-02 21:18:49', '', NULL, '默认分组');
INSERT INTO `sys_dict_data` VALUES (11, 2, '系统', 'SYSTEM', 'sys_job_group', '', '', 'N', '0', 'admin', '2025-04-02 21:18:49', '', NULL, '系统分组');
INSERT INTO `sys_dict_data` VALUES (12, 1, '是', 'Y', 'sys_yes_no', '', 'primary', 'Y', '0', 'admin', '2025-04-02 21:18:49', '', NULL, '系统默认是');
INSERT INTO `sys_dict_data` VALUES (13, 2, '否', 'N', 'sys_yes_no', '', 'danger', 'N', '0', 'admin', '2025-04-02 21:18:49', '', NULL, '系统默认否');
INSERT INTO `sys_dict_data` VALUES (14, 1, '通知', '1', 'sys_notice_type', '', 'warning', 'Y', '0', 'admin', '2025-04-02 21:18:49', '', NULL, '通知');
INSERT INTO `sys_dict_data` VALUES (15, 2, '公告', '2', 'sys_notice_type', '', 'success', 'N', '0', 'admin', '2025-04-02 21:18:49', '', NULL, '公告');
INSERT INTO `sys_dict_data` VALUES (16, 1, '正常', '0', 'sys_notice_status', '', 'primary', 'Y', '0', 'admin', '2025-04-02 21:18:49', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (17, 2, '关闭', '1', 'sys_notice_status', '', 'danger', 'N', '0', 'admin', '2025-04-02 21:18:49', '', NULL, '关闭状态');
INSERT INTO `sys_dict_data` VALUES (18, 99, '其他', '0', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2025-04-02 21:18:49', '', NULL, '其他操作');
INSERT INTO `sys_dict_data` VALUES (19, 1, '新增', '1', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2025-04-02 21:18:49', '', NULL, '新增操作');
INSERT INTO `sys_dict_data` VALUES (20, 2, '修改', '2', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2025-04-02 21:18:49', '', NULL, '修改操作');
INSERT INTO `sys_dict_data` VALUES (21, 3, '删除', '3', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2025-04-02 21:18:49', '', NULL, '删除操作');
INSERT INTO `sys_dict_data` VALUES (22, 4, '授权', '4', 'sys_oper_type', '', 'primary', 'N', '0', 'admin', '2025-04-02 21:18:49', '', NULL, '授权操作');
INSERT INTO `sys_dict_data` VALUES (23, 5, '导出', '5', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2025-04-02 21:18:49', '', NULL, '导出操作');
INSERT INTO `sys_dict_data` VALUES (24, 6, '导入', '6', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2025-04-02 21:18:49', '', NULL, '导入操作');
INSERT INTO `sys_dict_data` VALUES (25, 7, '强退', '7', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2025-04-02 21:18:49', '', NULL, '强退操作');
INSERT INTO `sys_dict_data` VALUES (26, 8, '生成代码', '8', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2025-04-02 21:18:49', '', NULL, '生成操作');
INSERT INTO `sys_dict_data` VALUES (27, 9, '清空数据', '9', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2025-04-02 21:18:49', '', NULL, '清空操作');
INSERT INTO `sys_dict_data` VALUES (28, 1, '成功', '0', 'sys_common_status', '', 'primary', 'N', '0', 'admin', '2025-04-02 21:18:49', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (29, 2, '失败', '1', 'sys_common_status', '', 'danger', 'N', '0', 'admin', '2025-04-02 21:18:49', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (100, 1, '待审核', '0', 'charity_project_status', NULL, 'warning', 'Y', '0', 'admin', '2025-04-02 23:13:55', '', NULL, '待审核状态');
INSERT INTO `sys_dict_data` VALUES (101, 2, '进行中', '1', 'charity_project_status', NULL, 'success', 'N', '0', 'admin', '2025-04-02 23:13:55', '', NULL, '项目进行中');
INSERT INTO `sys_dict_data` VALUES (102, 3, '已完成', '2', 'charity_project_status', NULL, 'info', 'N', '0', 'admin', '2025-04-02 23:13:55', '', NULL, '项目已完成');
INSERT INTO `sys_dict_data` VALUES (103, 4, '已关闭', '3', 'charity_project_status', NULL, 'danger', 'N', '0', 'admin', '2025-04-02 23:13:55', '', NULL, '项目已关闭');
INSERT INTO `sys_dict_data` VALUES (105, 1, '通过', '0', 'charity_project_audit_status', NULL, 'success', 'N', '0', 'admin', '2025-04-02 23:13:55', '', NULL, '审核通过');
INSERT INTO `sys_dict_data` VALUES (106, 2, '拒绝', '1', 'charity_project_audit_status', NULL, 'danger', 'N', '0', 'admin', '2025-04-02 23:13:55', '', NULL, '审核拒绝');
INSERT INTO `sys_dict_data` VALUES (107, 1, '个人', '0', 'charity_initiator_type', NULL, 'default', 'Y', '0', 'admin', '2025-04-02 23:13:55', '', NULL, '个人发起');
INSERT INTO `sys_dict_data` VALUES (108, 2, '慈善组织', '1', 'charity_initiator_type', NULL, 'primary', 'N', '0', 'admin', '2025-04-02 23:13:55', '', NULL, '慈善组织发起');
INSERT INTO `sys_dict_data` VALUES (109, 1, '待处理', '0', 'donation_status', NULL, 'warning', 'Y', '0', 'admin', '2025-04-02 23:13:55', '', NULL, '捐赠待处理');
INSERT INTO `sys_dict_data` VALUES (110, 2, '已完成', '1', 'donation_status', NULL, 'success', 'N', '0', 'admin', '2025-04-02 23:13:55', '', NULL, '捐赠已完成');
INSERT INTO `sys_dict_data` VALUES (111, 3, '已拒绝', '2', 'donation_status', NULL, 'danger', 'N', '0', 'admin', '2025-04-02 23:13:55', '', NULL, '捐赠已拒绝');
INSERT INTO `sys_dict_data` VALUES (112, 1, '处理中', '0', 'blockchain_tx_status', NULL, 'warning', 'Y', '0', 'admin', '2025-04-02 23:13:55', '', NULL, '区块链交易处理中');
INSERT INTO `sys_dict_data` VALUES (113, 2, '成功', '1', 'blockchain_tx_status', NULL, 'success', 'N', '0', 'admin', '2025-04-02 23:13:55', '', NULL, '区块链交易成功');
INSERT INTO `sys_dict_data` VALUES (114, 3, '失败', '2', 'blockchain_tx_status', NULL, 'danger', 'N', '0', 'admin', '2025-04-02 23:13:55', '', NULL, '区块链交易失败');
INSERT INTO `sys_dict_data` VALUES (115, 1, '捐赠记录', 'donation', 'blockchain_related_type', NULL, 'primary', 'Y', '0', 'admin', '2025-04-02 23:13:55', '', NULL, '关联捐赠记录');
INSERT INTO `sys_dict_data` VALUES (116, 2, '项目记录', 'project', 'blockchain_related_type', NULL, 'success', 'N', '0', 'admin', '2025-04-02 23:13:55', '', NULL, '关联项目记录');
INSERT INTO `sys_dict_data` VALUES (117, 3, '资金使用', 'usage', 'blockchain_related_type', NULL, 'info', 'N', '0', 'admin', '2025-04-02 23:13:55', '', NULL, '关联资金使用记录');
INSERT INTO `sys_dict_data` VALUES (120, 1, '未提交', '0', 'fund_application_status', '', 'info', 'Y', '0', 'admin', '2025-04-03 17:42:39', '', NULL, '未提交状态（草稿）');
INSERT INTO `sys_dict_data` VALUES (121, 2, '待审核', '1', 'fund_application_status', '', 'warning', 'N', '0', 'admin', '2025-04-03 17:42:39', '', NULL, '已提交待审核状态');
INSERT INTO `sys_dict_data` VALUES (123, 3, '已审核', '2', 'fund_application_status', '', 'success', 'N', '0', 'admin', '2025-04-03 17:42:39', '', NULL, '审核完成状态');

-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE `sys_dict_type`  (
  `dict_id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '字典主键',
  `dict_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典类型',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`) USING BTREE,
  UNIQUE INDEX `dict_type`(`dict_type`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 118 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '字典类型表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------
INSERT INTO `sys_dict_type` VALUES (1, '用户性别', 'sys_user_sex', '0', 'admin', '2025-04-02 21:18:49', '', NULL, '用户性别列表');
INSERT INTO `sys_dict_type` VALUES (2, '菜单状态', 'sys_show_hide', '0', 'admin', '2025-04-02 21:18:49', '', NULL, '菜单状态列表');
INSERT INTO `sys_dict_type` VALUES (3, '系统开关', 'sys_normal_disable', '0', 'admin', '2025-04-02 21:18:49', '', NULL, '系统开关列表');
INSERT INTO `sys_dict_type` VALUES (4, '任务状态', 'sys_job_status', '0', 'admin', '2025-04-02 21:18:49', '', NULL, '任务状态列表');
INSERT INTO `sys_dict_type` VALUES (5, '任务分组', 'sys_job_group', '0', 'admin', '2025-04-02 21:18:49', '', NULL, '任务分组列表');
INSERT INTO `sys_dict_type` VALUES (6, '系统是否', 'sys_yes_no', '0', 'admin', '2025-04-02 21:18:49', '', NULL, '系统是否列表');
INSERT INTO `sys_dict_type` VALUES (7, '通知类型', 'sys_notice_type', '0', 'admin', '2025-04-02 21:18:49', '', NULL, '通知类型列表');
INSERT INTO `sys_dict_type` VALUES (8, '通知状态', 'sys_notice_status', '0', 'admin', '2025-04-02 21:18:49', '', NULL, '通知状态列表');
INSERT INTO `sys_dict_type` VALUES (9, '操作类型', 'sys_oper_type', '0', 'admin', '2025-04-02 21:18:49', '', NULL, '操作类型列表');
INSERT INTO `sys_dict_type` VALUES (10, '系统状态', 'sys_common_status', '0', 'admin', '2025-04-02 21:18:49', '', NULL, '登录状态列表');
INSERT INTO `sys_dict_type` VALUES (100, '项目状态', 'charity_project_status', '0', 'admin', '2025-04-02 23:13:55', '', NULL, '慈善项目状态');
INSERT INTO `sys_dict_type` VALUES (101, '项目审核状态', 'charity_project_audit_status', '0', 'admin', '2025-04-02 23:13:55', '', NULL, '慈善项目审核状态');
INSERT INTO `sys_dict_type` VALUES (102, '项目发起类型', 'charity_initiator_type', '0', 'admin', '2025-04-02 23:13:55', '', NULL, '慈善项目发起类型');
INSERT INTO `sys_dict_type` VALUES (103, '捐赠状态', 'donation_status', '0', 'admin', '2025-04-02 23:13:55', '', NULL, '捐赠记录状态');
INSERT INTO `sys_dict_type` VALUES (104, '区块链交易状态', 'blockchain_tx_status', '0', 'admin', '2025-04-02 23:13:55', '', NULL, '区块链交易状态');
INSERT INTO `sys_dict_type` VALUES (105, '区块链关联业务类型', 'blockchain_related_type', '0', 'admin', '2025-04-02 23:13:55', '', NULL, '区块链关联业务类型');
INSERT INTO `sys_dict_type` VALUES (118, '资金申请状态', 'fund_application_status', '0', 'admin', '2025-04-03 17:40:11', '', NULL, '资金申请状态列表');

-- ----------------------------
-- Table structure for sys_job
-- ----------------------------
DROP TABLE IF EXISTS `sys_job`;
CREATE TABLE `sys_job`  (
  `job_id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'DEFAULT' COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调用目标字符串',
  `cron_expression` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT 'cron执行表达式',
  `misfire_policy` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '3' COMMENT '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
  `concurrent` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '1' COMMENT '是否并发执行（0允许 1禁止）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态（0正常 1暂停）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '备注信息',
  PRIMARY KEY (`job_id`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '定时任务调度表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_job
-- ----------------------------
INSERT INTO `sys_job` VALUES (1, '系统默认（无参）', 'DEFAULT', 'ryTask.ryNoParams', '0/10 * * * * ?', '3', '1', '1', 'admin', '2025-04-02 21:18:49', '', NULL, '');
INSERT INTO `sys_job` VALUES (2, '系统默认（有参）', 'DEFAULT', 'ryTask.ryParams(\'ry\')', '0/15 * * * * ?', '3', '1', '1', 'admin', '2025-04-02 21:18:49', '', NULL, '');
INSERT INTO `sys_job` VALUES (3, '系统默认（多参）', 'DEFAULT', 'ryTask.ryMultipleParams(\'ry\', true, 2000L, 316.50D, 100)', '0/20 * * * * ?', '3', '1', '1', 'admin', '2025-04-02 21:18:49', '', NULL, '');

-- ----------------------------
-- Table structure for sys_job_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_job_log`;
CREATE TABLE `sys_job_log`  (
  `job_log_id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '任务日志ID',
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调用目标字符串',
  `job_message` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '日志信息',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '执行状态（0正常 1失败）',
  `exception_info` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '异常信息',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`job_log_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '定时任务调度日志表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_job_log
-- ----------------------------

-- ----------------------------
-- Table structure for sys_logininfor
-- ----------------------------
DROP TABLE IF EXISTS `sys_logininfor`;
CREATE TABLE `sys_logininfor`  (
  `info_id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '访问ID',
  `user_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '用户账号',
  `ipaddr` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '登录IP地址',
  `login_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '操作系统',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
  `msg` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '提示消息',
  `login_time` datetime(0) NULL DEFAULT NULL COMMENT '访问时间',
  PRIMARY KEY (`info_id`) USING BTREE,
  INDEX `idx_sys_logininfor_s`(`status`) USING BTREE,
  INDEX `idx_sys_logininfor_lt`(`login_time`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 122 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '系统访问记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_logininfor
-- ----------------------------
INSERT INTO `sys_logininfor` VALUES (100, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-04-02 21:26:33');
INSERT INTO `sys_logininfor` VALUES (101, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-04-02 23:14:12');
INSERT INTO `sys_logininfor` VALUES (102, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-04-03 01:20:49');
INSERT INTO `sys_logininfor` VALUES (103, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '退出成功', '2025-04-03 01:31:20');
INSERT INTO `sys_logininfor` VALUES (104, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-04-03 01:31:24');
INSERT INTO `sys_logininfor` VALUES (105, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-04-03 01:34:18');
INSERT INTO `sys_logininfor` VALUES (106, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '退出成功', '2025-04-03 01:39:28');
INSERT INTO `sys_logininfor` VALUES (107, 'user1', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-04-03 01:39:32');
INSERT INTO `sys_logininfor` VALUES (108, 'user1', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '退出成功', '2025-04-03 01:39:49');
INSERT INTO `sys_logininfor` VALUES (109, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-04-03 01:39:52');
INSERT INTO `sys_logininfor` VALUES (110, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '退出成功', '2025-04-03 02:05:52');
INSERT INTO `sys_logininfor` VALUES (111, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-04-03 02:06:04');
INSERT INTO `sys_logininfor` VALUES (112, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-04-03 08:35:20');
INSERT INTO `sys_logininfor` VALUES (113, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-04-03 14:36:53');
INSERT INTO `sys_logininfor` VALUES (114, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-04-03 15:59:47');
INSERT INTO `sys_logininfor` VALUES (115, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-04-03 16:43:53');
INSERT INTO `sys_logininfor` VALUES (116, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-04-03 19:45:08');
INSERT INTO `sys_logininfor` VALUES (117, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-04-03 20:18:55');
INSERT INTO `sys_logininfor` VALUES (118, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-04-04 13:53:36');
INSERT INTO `sys_logininfor` VALUES (119, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-04-04 17:52:23');
INSERT INTO `sys_logininfor` VALUES (120, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-04-04 18:01:36');
INSERT INTO `sys_logininfor` VALUES (121, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '退出成功', '2025-04-04 18:45:24');
INSERT INTO `sys_logininfor` VALUES (122, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-04-04 18:45:25');
INSERT INTO `sys_logininfor` VALUES (123, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-04-05 12:53:57');
INSERT INTO `sys_logininfor` VALUES (124, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-04-05 19:49:58');

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `menu_id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `menu_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '菜单名称',
  `parent_id` bigint(0) NULL DEFAULT 0 COMMENT '父菜单ID',
  `order_num` int(0) NULL DEFAULT 0 COMMENT '显示顺序',
  `path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '路由地址',
  `component` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '组件路径',
  `query` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '路由参数',
  `route_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '路由名称',
  `is_frame` int(0) NULL DEFAULT 1 COMMENT '是否为外链（0是 1否）',
  `is_cache` int(0) NULL DEFAULT 0 COMMENT '是否缓存（0缓存 1不缓存）',
  `menu_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `visible` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '菜单状态（0显示 1隐藏）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '菜单状态（0正常 1停用）',
  `perms` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '#' COMMENT '菜单图标',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2132 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '菜单权限表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, '系统管理', 0, 1, 'system', NULL, '', '', 1, 0, 'M', '0', '0', '', 'system', 'admin', '2025-04-02 21:18:49', '', NULL, '系统管理目录');
INSERT INTO `sys_menu` VALUES (2, '系统监控', 0, 2, 'monitor', NULL, '', '', 1, 0, 'M', '0', '0', '', 'monitor', 'admin', '2025-04-02 21:18:49', '', NULL, '系统监控目录');
INSERT INTO `sys_menu` VALUES (3, '系统工具', 0, 3, 'tool', NULL, '', '', 1, 0, 'M', '0', '0', '', 'tool', 'admin', '2025-04-02 21:18:49', '', NULL, '系统工具目录');
INSERT INTO `sys_menu` VALUES (100, '用户管理', 1, 1, 'user', 'system/user/index', '', '', 1, 0, 'C', '0', '0', 'system:user:list', 'user', 'admin', '2025-04-02 21:18:49', '', NULL, '用户管理菜单');
INSERT INTO `sys_menu` VALUES (101, '角色管理', 1, 2, 'role', 'system/role/index', '', '', 1, 0, 'C', '0', '0', 'system:role:list', 'peoples', 'admin', '2025-04-02 21:18:49', '', NULL, '角色管理菜单');
INSERT INTO `sys_menu` VALUES (102, '菜单管理', 1, 3, 'menu', 'system/menu/index', '', '', 1, 0, 'C', '0', '0', 'system:menu:list', 'tree-table', 'admin', '2025-04-02 21:18:49', '', NULL, '菜单管理菜单');
INSERT INTO `sys_menu` VALUES (103, '部门管理', 1, 4, 'dept', 'system/dept/index', '', '', 1, 0, 'C', '0', '0', 'system:dept:list', 'tree', 'admin', '2025-04-02 21:18:49', '', NULL, '部门管理菜单');
INSERT INTO `sys_menu` VALUES (104, '岗位管理', 1, 5, 'post', 'system/post/index', '', '', 1, 0, 'C', '0', '0', 'system:post:list', 'post', 'admin', '2025-04-02 21:18:49', '', NULL, '岗位管理菜单');
INSERT INTO `sys_menu` VALUES (105, '字典管理', 1, 6, 'dict', 'system/dict/index', '', '', 1, 0, 'C', '0', '0', 'system:dict:list', 'dict', 'admin', '2025-04-02 21:18:49', '', NULL, '字典管理菜单');
INSERT INTO `sys_menu` VALUES (106, '参数设置', 1, 7, 'config', 'system/config/index', '', '', 1, 0, 'C', '0', '0', 'system:config:list', 'edit', 'admin', '2025-04-02 21:18:49', '', NULL, '参数设置菜单');
INSERT INTO `sys_menu` VALUES (107, '通知公告', 1, 8, 'notice', 'system/notice/index', '', '', 1, 0, 'C', '0', '0', 'system:notice:list', 'message', 'admin', '2025-04-02 21:18:49', '', NULL, '通知公告菜单');
INSERT INTO `sys_menu` VALUES (108, '日志管理', 1, 9, 'log', '', '', '', 1, 0, 'M', '0', '0', '', 'log', 'admin', '2025-04-02 21:18:49', '', NULL, '日志管理菜单');
INSERT INTO `sys_menu` VALUES (109, '在线用户', 2, 1, 'online', 'monitor/online/index', '', '', 1, 0, 'C', '0', '0', 'monitor:online:list', 'online', 'admin', '2025-04-02 21:18:49', '', NULL, '在线用户菜单');
INSERT INTO `sys_menu` VALUES (110, '定时任务', 2, 2, 'job', 'monitor/job/index', '', '', 1, 0, 'C', '0', '0', 'monitor:job:list', 'job', 'admin', '2025-04-02 21:18:49', '', NULL, '定时任务菜单');
INSERT INTO `sys_menu` VALUES (111, '数据监控', 2, 3, 'druid', 'monitor/druid/index', '', '', 1, 0, 'C', '0', '0', 'monitor:druid:list', 'druid', 'admin', '2025-04-02 21:18:49', '', NULL, '数据监控菜单');
INSERT INTO `sys_menu` VALUES (112, '服务监控', 2, 4, 'server', 'monitor/server/index', '', '', 1, 0, 'C', '0', '0', 'monitor:server:list', 'server', 'admin', '2025-04-02 21:18:49', '', NULL, '服务监控菜单');
INSERT INTO `sys_menu` VALUES (113, '缓存监控', 2, 5, 'cache', 'monitor/cache/index', '', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis', 'admin', '2025-04-02 21:18:49', '', NULL, '缓存监控菜单');
INSERT INTO `sys_menu` VALUES (114, '缓存列表', 2, 6, 'cacheList', 'monitor/cache/list', '', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis-list', 'admin', '2025-04-02 21:18:49', '', NULL, '缓存列表菜单');
INSERT INTO `sys_menu` VALUES (115, '表单构建', 3, 1, 'build', 'tool/build/index', '', '', 1, 0, 'C', '0', '0', 'tool:build:list', 'build', 'admin', '2025-04-02 21:18:49', '', NULL, '表单构建菜单');
INSERT INTO `sys_menu` VALUES (116, '代码生成', 3, 2, 'gen', 'tool/gen/index', '', '', 1, 0, 'C', '0', '0', 'tool:gen:list', 'code', 'admin', '2025-04-02 21:18:49', '', NULL, '代码生成菜单');
INSERT INTO `sys_menu` VALUES (117, '系统接口', 3, 3, 'swagger', 'tool/swagger/index', '', '', 1, 0, 'C', '0', '0', 'tool:swagger:list', 'swagger', 'admin', '2025-04-02 21:18:49', '', NULL, '系统接口菜单');
INSERT INTO `sys_menu` VALUES (500, '操作日志', 108, 1, 'operlog', 'monitor/operlog/index', '', '', 1, 0, 'C', '0', '0', 'monitor:operlog:list', 'form', 'admin', '2025-04-02 21:18:49', '', NULL, '操作日志菜单');
INSERT INTO `sys_menu` VALUES (501, '登录日志', 108, 2, 'logininfor', 'monitor/logininfor/index', '', '', 1, 0, 'C', '0', '0', 'monitor:logininfor:list', 'logininfor', 'admin', '2025-04-02 21:18:49', '', NULL, '登录日志菜单');
INSERT INTO `sys_menu` VALUES (1000, '用户查询', 100, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:query', '#', 'admin', '2025-04-02 21:18:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1001, '用户新增', 100, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:add', '#', 'admin', '2025-04-02 21:18:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1002, '用户修改', 100, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:edit', '#', 'admin', '2025-04-02 21:18:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1003, '用户删除', 100, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:remove', '#', 'admin', '2025-04-02 21:18:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1004, '用户导出', 100, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:export', '#', 'admin', '2025-04-02 21:18:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1005, '用户导入', 100, 6, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:import', '#', 'admin', '2025-04-02 21:18:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1006, '重置密码', 100, 7, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:resetPwd', '#', 'admin', '2025-04-02 21:18:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1007, '角色查询', 101, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:query', '#', 'admin', '2025-04-02 21:18:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1008, '角色新增', 101, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:add', '#', 'admin', '2025-04-02 21:18:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1009, '角色修改', 101, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:edit', '#', 'admin', '2025-04-02 21:18:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1010, '角色删除', 101, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:remove', '#', 'admin', '2025-04-02 21:18:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1011, '角色导出', 101, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:export', '#', 'admin', '2025-04-02 21:18:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1012, '菜单查询', 102, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:query', '#', 'admin', '2025-04-02 21:18:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1013, '菜单新增', 102, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:add', '#', 'admin', '2025-04-02 21:18:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1014, '菜单修改', 102, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:edit', '#', 'admin', '2025-04-02 21:18:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1015, '菜单删除', 102, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:remove', '#', 'admin', '2025-04-02 21:18:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1016, '部门查询', 103, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:query', '#', 'admin', '2025-04-02 21:18:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1017, '部门新增', 103, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:add', '#', 'admin', '2025-04-02 21:18:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1018, '部门修改', 103, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:edit', '#', 'admin', '2025-04-02 21:18:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1019, '部门删除', 103, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:remove', '#', 'admin', '2025-04-02 21:18:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1020, '岗位查询', 104, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:query', '#', 'admin', '2025-04-02 21:18:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1021, '岗位新增', 104, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:add', '#', 'admin', '2025-04-02 21:18:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1022, '岗位修改', 104, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:edit', '#', 'admin', '2025-04-02 21:18:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1023, '岗位删除', 104, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:remove', '#', 'admin', '2025-04-02 21:18:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1024, '岗位导出', 104, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:export', '#', 'admin', '2025-04-02 21:18:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1025, '字典查询', 105, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:query', '#', 'admin', '2025-04-02 21:18:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1026, '字典新增', 105, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:add', '#', 'admin', '2025-04-02 21:18:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1027, '字典修改', 105, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:edit', '#', 'admin', '2025-04-02 21:18:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1028, '字典删除', 105, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:remove', '#', 'admin', '2025-04-02 21:18:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1029, '字典导出', 105, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:export', '#', 'admin', '2025-04-02 21:18:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1030, '参数查询', 106, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:query', '#', 'admin', '2025-04-02 21:18:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1031, '参数新增', 106, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:add', '#', 'admin', '2025-04-02 21:18:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1032, '参数修改', 106, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:edit', '#', 'admin', '2025-04-02 21:18:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1033, '参数删除', 106, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:remove', '#', 'admin', '2025-04-02 21:18:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1034, '参数导出', 106, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:export', '#', 'admin', '2025-04-02 21:18:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1035, '公告查询', 107, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:query', '#', 'admin', '2025-04-02 21:18:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1036, '公告新增', 107, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:add', '#', 'admin', '2025-04-02 21:18:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1037, '公告修改', 107, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:edit', '#', 'admin', '2025-04-02 21:18:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1038, '公告删除', 107, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:remove', '#', 'admin', '2025-04-02 21:18:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1039, '操作查询', 500, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:query', '#', 'admin', '2025-04-02 21:18:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1040, '操作删除', 500, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:remove', '#', 'admin', '2025-04-02 21:18:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1041, '日志导出', 500, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:export', '#', 'admin', '2025-04-02 21:18:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1042, '登录查询', 501, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:query', '#', 'admin', '2025-04-02 21:18:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1043, '登录删除', 501, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:remove', '#', 'admin', '2025-04-02 21:18:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1044, '日志导出', 501, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:export', '#', 'admin', '2025-04-02 21:18:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1045, '账户解锁', 501, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:unlock', '#', 'admin', '2025-04-02 21:18:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1046, '在线查询', 109, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:query', '#', 'admin', '2025-04-02 21:18:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1047, '批量强退', 109, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:batchLogout', '#', 'admin', '2025-04-02 21:18:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1048, '单条强退', 109, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:forceLogout', '#', 'admin', '2025-04-02 21:18:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1049, '任务查询', 110, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:query', '#', 'admin', '2025-04-02 21:18:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1050, '任务新增', 110, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:add', '#', 'admin', '2025-04-02 21:18:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1051, '任务修改', 110, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:edit', '#', 'admin', '2025-04-02 21:18:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1052, '任务删除', 110, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:remove', '#', 'admin', '2025-04-02 21:18:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1053, '状态修改', 110, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:changeStatus', '#', 'admin', '2025-04-02 21:18:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1054, '任务导出', 110, 6, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:export', '#', 'admin', '2025-04-02 21:18:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1055, '生成查询', 116, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:query', '#', 'admin', '2025-04-02 21:18:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1056, '生成修改', 116, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:edit', '#', 'admin', '2025-04-02 21:18:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1057, '生成删除', 116, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:remove', '#', 'admin', '2025-04-02 21:18:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1058, '导入代码', 116, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:import', '#', 'admin', '2025-04-02 21:18:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1059, '预览代码', 116, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:preview', '#', 'admin', '2025-04-02 21:18:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1060, '生成代码', 116, 6, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:code', '#', 'admin', '2025-04-02 21:18:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2000, '慈善捐赠平台', 0, 5, 'charity', NULL, '', '', 1, 0, 'M', '0', '0', '', 'guide', 'admin', '2025-04-03 02:08:05', '', NULL, '慈善捐赠平台目录');
INSERT INTO `sys_menu` VALUES (2001, '项目管理', 2000, 1, 'project', NULL, '', '', 1, 0, 'M', '0', '0', '', 'build', 'admin', '2025-04-03 02:08:05', '', NULL, '慈善项目管理目录');
INSERT INTO `sys_menu` VALUES (2002, '捐赠管理', 2000, 2, 'donation', NULL, '', '', 1, 0, 'M', '0', '0', '', 'money', 'admin', '2025-04-03 02:08:05', '', NULL, '捐赠管理目录');
INSERT INTO `sys_menu` VALUES (2003, '资金管理', 2000, 3, 'fund', NULL, '', '', 1, 0, 'M', '0', '0', '', 'money', 'admin', '2025-04-03 02:08:05', '', NULL, '资金管理目录');
INSERT INTO `sys_menu` VALUES (2004, '区块链管理', 2000, 4, 'blockchain', NULL, '', '', 1, 0, 'M', '0', '0', '', 'monitor', 'admin', '2025-04-03 02:08:05', '', NULL, '区块链管理目录');
INSERT INTO `sys_menu` VALUES (2005, '评价管理', 2000, 5, 'comment', 'charity/comment/index', '', '', 1, 0, 'C', '0', '0', 'charity:comment:list', 'message', 'admin', '2025-04-03 02:08:05', '', NULL, '项目评价管理');
INSERT INTO `sys_menu` VALUES (2006, '隐私设置', 2000, 6, 'privacy', 'charity/privacy/index', '', '', 1, 0, 'C', '0', '0', 'charity:privacy:list', 'user', 'admin', '2025-04-03 02:08:05', '', NULL, '用户隐私设置');
INSERT INTO `sys_menu` VALUES (2007, '数据可视化', 2000, 7, 'visualization', 'charity/visualization/index', '', '', 1, 0, 'C', '0', '0', 'charity:visualization:view', 'chart', 'admin', '2025-04-03 02:08:05', '', NULL, '数据可视化');
INSERT INTO `sys_menu` VALUES (2011, '项目列表', 2001, 1, 'projectList', 'charity/project/index', '', '', 1, 0, 'C', '0', '0', 'charity:project:list', 'list', 'admin', '2025-04-03 02:08:05', 'admin', '2025-04-03 02:12:36', '慈善项目列表');
INSERT INTO `sys_menu` VALUES (2012, '项目发布', 2001, 2, 'publish', 'charity/project/publish', '', '', 1, 0, 'C', '0', '0', 'charity:project:publish', 'edit', 'admin', '2025-04-03 02:08:05', '', NULL, '慈善项目发布');
INSERT INTO `sys_menu` VALUES (2013, '项目审核', 2001, 3, 'audit', 'charity/project/audit', '', '', 1, 0, 'C', '0', '0', 'charity:project:audit', 'validCode', 'admin', '2025-04-03 02:08:05', '', NULL, '慈善项目审核');
INSERT INTO `sys_menu` VALUES (2021, '捐赠记录', 2002, 1, 'donationList', 'charity/donation/index', '', '', 1, 0, 'C', '0', '0', 'charity:donation:list', 'form', 'admin', '2025-04-03 02:08:05', 'admin', '2025-04-03 02:12:53', '捐赠记录管理');
INSERT INTO `sys_menu` VALUES (2022, '我的捐赠', 2002, 2, 'my', 'charity/donation/my', '', '', 1, 0, 'C', '0', '0', 'charity:donation:my', 'list', 'admin', '2025-04-03 02:08:05', '', NULL, '我的捐赠记录');
INSERT INTO `sys_menu` VALUES (2031, '资金使用记录', 2003, 1, 'fundList', 'charity/fund/index', '', '', 1, 0, 'C', '0', '0', 'charity:fund:list', 'excel', 'admin', '2025-04-03 02:08:05', 'admin', '2025-04-03 02:13:05', '资金使用记录');
INSERT INTO `sys_menu` VALUES (2032, '资金审核', 2003, 2, 'fundAudit', 'charity/fund/fundAudit', '', '', 1, 0, 'C', '0', '0', 'charity:fund:audit', 'edit', 'admin', '2025-04-03 02:08:05', 'admin', '2025-04-03 20:15:02', '资金申请');
INSERT INTO `sys_menu` VALUES (2041, '交易记录', 2004, 1, 'blockchainList', 'charity/blockchain/index', '', '', 1, 0, 'C', '0', '0', 'charity:blockchain:list', 'chart', 'admin', '2025-04-03 02:08:05', 'admin', '2025-04-03 02:13:15', '区块链交易记录');
INSERT INTO `sys_menu` VALUES (2042, '规则管理', 2004, 2, 'rule', 'charity/blockchain/rule', '', '', 1, 0, 'C', '0', '0', 'charity:blockchain:rule', 'code', 'admin', '2025-04-03 02:08:05', '', NULL, '区块链规则管理');
INSERT INTO `sys_menu` VALUES (2101, '项目查询', 2011, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'charity:project:query', '#', 'admin', '2025-04-03 02:08:05', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2102, '项目捐赠', 2011, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'charity:project:donate', '#', 'admin', '2025-04-03 02:08:05', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2103, '项目评价', 2011, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'charity:project:comment', '#', 'admin', '2025-04-03 02:08:05', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2104, '项目导出', 2011, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'charity:project:export', '#', 'admin', '2025-04-03 02:08:05', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2105, '发布查询', 2012, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'charity:project:publishquery', '#', 'admin', '2025-04-03 02:08:05', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2106, '发布新增', 2012, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'charity:project:publishadd', '#', 'admin', '2025-04-03 02:08:05', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2107, '发布修改', 2012, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'charity:project:publishedit', '#', 'admin', '2025-04-03 02:08:05', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2108, '发布删除', 2012, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'charity:project:publishremove', '#', 'admin', '2025-04-03 02:08:05', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2109, '审核查询', 2013, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'charity:project:auditquery', '#', 'admin', '2025-04-03 02:08:05', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2110, '审核操作', 2013, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'charity:project:auditoperate', '#', 'admin', '2025-04-03 02:08:05', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2111, '捐赠查询', 2021, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'charity:donation:query', '#', 'admin', '2025-04-03 02:08:05', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2112, '捐赠新增', 2021, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'charity:donation:add', '#', 'admin', '2025-04-03 02:08:05', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2113, '捐赠导出', 2021, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'charity:donation:export', '#', 'admin', '2025-04-03 02:08:05', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2114, '我的捐赠查询', 2022, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'charity:donation:myquery', '#', 'admin', '2025-04-03 02:08:05', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2115, '证书下载', 2022, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'charity:donation:certificate', '#', 'admin', '2025-04-03 02:08:05', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2116, '资金查询', 2031, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'charity:fund:query', '#', 'admin', '2025-04-03 02:08:05', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2117, '资金导出', 2031, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'charity:fund:export', '#', 'admin', '2025-04-03 02:08:05', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2118, '申请查询', 2032, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'charity:fund:applyquery', '#', 'admin', '2025-04-03 02:08:05', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2119, '申请新增', 2032, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'charity:fund:applyadd', '#', 'admin', '2025-04-03 02:08:05', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2120, '申请修改', 2032, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'charity:fund:applyedit', '#', 'admin', '2025-04-03 02:08:05', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2121, '申请删除', 2032, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'charity:fund:applyremove', '#', 'admin', '2025-04-03 02:08:05', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2122, '交易查询', 2041, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'charity:blockchain:query', '#', 'admin', '2025-04-03 02:08:05', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2123, '交易导出', 2041, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'charity:blockchain:export', '#', 'admin', '2025-04-03 02:08:05', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2124, '规则查询', 2042, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'charity:blockchain:rulequery', '#', 'admin', '2025-04-03 02:08:05', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2125, '规则新增', 2042, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'charity:blockchain:ruleadd', '#', 'admin', '2025-04-03 02:08:05', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2126, '规则修改', 2042, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'charity:blockchain:ruleedit', '#', 'admin', '2025-04-03 02:08:05', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2127, '规则删除', 2042, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'charity:blockchain:ruleremove', '#', 'admin', '2025-04-03 02:08:05', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2128, '评价查询', 2005, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'charity:comment:query', '#', 'admin', '2025-04-03 02:08:05', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2129, '评价新增', 2005, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'charity:comment:add', '#', 'admin', '2025-04-03 02:08:05', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2130, '评价删除', 2005, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'charity:comment:remove', '#', 'admin', '2025-04-03 02:08:05', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2131, '隐私查询', 2006, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'charity:privacy:query', '#', 'admin', '2025-04-03 02:08:05', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2132, '隐私修改', 2006, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'charity:privacy:edit', '#', 'admin', '2025-04-03 02:08:05', '', NULL, '');

-- ----------------------------
-- Table structure for sys_notice
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice`;
CREATE TABLE `sys_notice`  (
  `notice_id` int(0) NOT NULL AUTO_INCREMENT COMMENT '公告ID',
  `notice_title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '公告标题',
  `notice_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '公告类型（1通知 2公告）',
  `notice_content` longblob NULL COMMENT '公告内容',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '公告状态（0正常 1关闭）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`notice_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '通知公告表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_notice
-- ----------------------------
INSERT INTO `sys_notice` VALUES (1, '温馨提醒：2018-07-01 若依新版本发布啦', '2', 0xE696B0E78988E69CACE58685E5AEB9, '0', 'admin', '2025-04-02 21:18:49', '', NULL, '管理员');
INSERT INTO `sys_notice` VALUES (2, '维护通知：2018-07-01 若依系统凌晨维护', '1', 0xE7BBB4E68AA4E58685E5AEB9, '0', 'admin', '2025-04-02 21:18:49', '', NULL, '管理员');

-- ----------------------------
-- Table structure for sys_oper_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_oper_log`;
CREATE TABLE `sys_oper_log`  (
  `oper_id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '日志主键',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '模块标题',
  `business_type` int(0) NULL DEFAULT 0 COMMENT '业务类型（0其它 1新增 2修改 3删除）',
  `method` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '方法名称',
  `request_method` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '请求方式',
  `operator_type` int(0) NULL DEFAULT 0 COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
  `oper_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '操作人员',
  `dept_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '部门名称',
  `oper_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '请求URL',
  `oper_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '主机地址',
  `oper_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '操作地点',
  `oper_param` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '请求参数',
  `json_result` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '返回参数',
  `status` int(0) NULL DEFAULT 0 COMMENT '操作状态（0正常 1异常）',
  `error_msg` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '错误消息',
  `oper_time` datetime(0) NULL DEFAULT NULL COMMENT '操作时间',
  `cost_time` bigint(0) NULL DEFAULT 0 COMMENT '消耗时间',
  PRIMARY KEY (`oper_id`) USING BTREE,
  INDEX `idx_sys_oper_log_bt`(`business_type`) USING BTREE,
  INDEX `idx_sys_oper_log_s`(`status`) USING BTREE,
  INDEX `idx_sys_oper_log_ot`(`oper_time`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 194 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '操作日志记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_oper_log
-- ----------------------------
INSERT INTO `sys_oper_log` VALUES (100, '代码生成', 6, 'com.ruoyi.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', '研发部门', '/tool/gen/importTable', '127.0.0.1', '内网IP', '{\"tables\":\"blockchain_transaction,charity_project,donation_record,fund_usage_record,project_comment,user_privacy_settings\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-04-02 21:52:53', 300);
INSERT INTO `sys_oper_log` VALUES (101, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"transaction\",\"className\":\"BlockchainTransaction\",\"columns\":[{\"capJavaField\":\"TxId\",\"columnComment\":\"交易ID\",\"columnId\":1,\"columnName\":\"tx_id\",\"columnType\":\"varchar(100)\",\"createBy\":\"admin\",\"createTime\":\"2025-04-02 21:52:53\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"txId\",\"javaType\":\"String\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"RelatedId\",\"columnComment\":\"关联业务ID\",\"columnId\":2,\"columnName\":\"related_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2025-04-02 21:52:53\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"relatedId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"RelatedType\",\"columnComment\":\"关联业务类型（donation/project/usage）\",\"columnId\":3,\"columnName\":\"related_type\",\"columnType\":\"varchar(50)\",\"createBy\":\"admin\",\"createTime\":\"2025-04-02 21:52:53\",\"dictType\":\"blockchain_related_type\",\"edit\":true,\"htmlType\":\"select\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"relatedType\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"TxData\",\"columnComment\":\"交易数据(JSON)\",\"columnId\":4,\"columnName\":\"tx_data\",\"columnType\":\"text\",\"createBy\":\"admin\",\"createTime\":\"2025-04-02 21:52:53\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"textarea\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncremen', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-04-02 23:17:27', 52);
INSERT INTO `sys_oper_log` VALUES (102, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '研发部门', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"blockchain_transaction,charity_project,donation_record,fund_usage_record,project_comment,user_privacy_settings\"}', NULL, 0, NULL, '2025-04-02 23:33:47', 595);
INSERT INTO `sys_oper_log` VALUES (103, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '研发部门', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"blockchain_transaction,charity_project,donation_record,fund_usage_record,project_comment,user_privacy_settings\"}', NULL, 0, NULL, '2025-04-02 23:41:07', 409);
INSERT INTO `sys_oper_log` VALUES (104, '代码生成', 3, 'com.ruoyi.generator.controller.GenController.remove()', 'DELETE', 1, 'admin', '研发部门', '/tool/gen/1,2,3,4,5,6', '127.0.0.1', '内网IP', '[1,2,3,4,5,6]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-04-03 00:51:26', 51);
INSERT INTO `sys_oper_log` VALUES (105, '代码生成', 6, 'com.ruoyi.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', '研发部门', '/tool/gen/importTable', '127.0.0.1', '内网IP', '{\"tables\":\"blockchain_transaction,charity_project,donation_record,fund_usage_record,project_comment,user_privacy_settings\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-04-03 00:51:41', 233);
INSERT INTO `sys_oper_log` VALUES (106, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"record\",\"className\":\"DonationRecord\",\"columns\":[{\"capJavaField\":\"DonationId\",\"columnComment\":\"捐赠ID\",\"columnId\":87,\"columnName\":\"donation_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2025-04-03 00:51:41\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"donationId\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":9,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"UserId\",\"columnComment\":\"捐赠用户ID\",\"columnId\":88,\"columnName\":\"user_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2025-04-03 00:51:41\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"userId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":9,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"ProjectId\",\"columnComment\":\"慈善项目ID\",\"columnId\":89,\"columnName\":\"project_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2025-04-03 00:51:41\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"projectId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":9,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"DonationAmount\",\"columnComment\":\"捐赠金额\",\"columnId\":90,\"columnName\":\"donation_amount\",\"columnType\":\"decimal(10,2)\",\"createBy\":\"admin\",\"createTime\":\"2025-04-03 00:51:41\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-04-03 00:52:23', 46);
INSERT INTO `sys_oper_log` VALUES (107, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.synchDb()', 'GET', 1, 'admin', '研发部门', '/tool/gen/synchDb/user_privacy_settings', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-04-03 00:58:07', 32);
INSERT INTO `sys_oper_log` VALUES (108, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '研发部门', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"blockchain_transaction,charity_project,donation_record,fund_usage_record,project_comment,user_privacy_settings\"}', NULL, 0, NULL, '2025-04-03 01:00:56', 283);
INSERT INTO `sys_oper_log` VALUES (109, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"charity/donation/\",\"createTime\":\"2025-04-03 00:49:45\",\"icon\":\"form\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2021,\"menuName\":\"捐赠记录\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2002,\"path\":\"index\",\"perms\":\"charity:donation:list\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-04-03 01:10:57', 17);
INSERT INTO `sys_oper_log` VALUES (110, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"charity/donation/index\",\"createTime\":\"2025-04-03 00:49:45\",\"icon\":\"form\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2021,\"menuName\":\"捐赠记录\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2002,\"path\":\"index\",\"perms\":\"charity:donation:list\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-04-03 01:11:19', 8);
INSERT INTO `sys_oper_log` VALUES (111, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"charity/donation/my\",\"createTime\":\"2025-04-03 00:49:45\",\"icon\":\"list\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2022,\"menuName\":\"我的捐赠\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":2002,\"path\":\"my\",\"perms\":\"charity:donation:my\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-04-03 01:11:26', 8);
INSERT INTO `sys_oper_log` VALUES (112, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"charity/fund/index\",\"createTime\":\"2025-04-03 00:49:46\",\"icon\":\"excel\",\"isCache\":\"1\",\"isFrame\":\"1\",\"menuId\":2031,\"menuName\":\"资金使用记录\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2003,\"path\":\"index\",\"perms\":\"charity:fund:list\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-04-03 01:13:17', 8);
INSERT INTO `sys_oper_log` VALUES (113, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"charity/project/index\",\"createTime\":\"2025-04-03 00:49:45\",\"icon\":\"list\",\"isCache\":\"1\",\"isFrame\":\"1\",\"menuId\":2011,\"menuName\":\"项目列表\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2001,\"path\":\"index\",\"perms\":\"charity:project:list\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-04-03 01:26:21', 25);
INSERT INTO `sys_oper_log` VALUES (114, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"charity/aaa/index\",\"createTime\":\"2025-04-03 02:08:05\",\"icon\":\"excel\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2031,\"menuName\":\"资金使用记录\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2003,\"path\":\"aaa\",\"perms\":\"charity:fund:list\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-04-03 02:09:50', 12);
INSERT INTO `sys_oper_log` VALUES (115, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"charity/fund/index\",\"createTime\":\"2025-04-03 02:08:05\",\"icon\":\"excel\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2031,\"menuName\":\"资金使用记录\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2003,\"path\":\"aaa\",\"perms\":\"charity:fund:list\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-04-03 02:10:30', 10);
INSERT INTO `sys_oper_log` VALUES (116, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"charity/fund/index\",\"createTime\":\"2025-04-03 02:08:05\",\"icon\":\"excel\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2031,\"menuName\":\"资金使用记录\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2003,\"path\":\"index\",\"perms\":\"charity:fund:list\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-04-03 02:11:03', 7);
INSERT INTO `sys_oper_log` VALUES (117, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"charity/fund/index\",\"createTime\":\"2025-04-03 02:08:05\",\"icon\":\"excel\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2031,\"menuName\":\"资金使用记录\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2003,\"path\":\"list\",\"perms\":\"charity:fund:list\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-04-03 02:11:42', 8);
INSERT INTO `sys_oper_log` VALUES (118, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"charity/blockchain/index\",\"createTime\":\"2025-04-03 02:08:05\",\"icon\":\"chart\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2041,\"menuName\":\"交易记录\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2004,\"path\":\"list\",\"perms\":\"charity:blockchain:list\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-04-03 02:12:01', 8);
INSERT INTO `sys_oper_log` VALUES (119, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"charity/project/index\",\"createTime\":\"2025-04-03 02:08:05\",\"icon\":\"list\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2011,\"menuName\":\"项目列表\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2001,\"path\":\"projectList\",\"perms\":\"charity:project:list\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-04-03 02:12:36', 8);
INSERT INTO `sys_oper_log` VALUES (120, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"charity/donation/index\",\"createTime\":\"2025-04-03 02:08:05\",\"icon\":\"form\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2021,\"menuName\":\"捐赠记录\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2002,\"path\":\"donationList\",\"perms\":\"charity:donation:list\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-04-03 02:12:53', 10);
INSERT INTO `sys_oper_log` VALUES (121, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"charity/fund/index\",\"createTime\":\"2025-04-03 02:08:05\",\"icon\":\"excel\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2031,\"menuName\":\"资金使用记录\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2003,\"path\":\"fundList\",\"perms\":\"charity:fund:list\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-04-03 02:13:05', 9);
INSERT INTO `sys_oper_log` VALUES (122, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"charity/blockchain/index\",\"createTime\":\"2025-04-03 02:08:05\",\"icon\":\"chart\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2041,\"menuName\":\"交易记录\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2004,\"path\":\"blockchainList\",\"perms\":\"charity:blockchain:list\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-04-03 02:13:15', 9);
INSERT INTO `sys_oper_log` VALUES (123, '慈善项目', 2, 'com.ruoyi.charity.controller.CharityProjectController.edit()', 'PUT', 1, 'admin', '研发部门', '/charity/project', '127.0.0.1', '内网IP', '{\"auditRemark\":\"紧急项目，优先审核通过\",\"auditStatus\":\"1\",\"auditTime\":\"2025-02-07\",\"auditUserId\":100,\"blockchainId\":\"bc_proj_004\",\"coverImage\":\"/profile/upload/2025/04/03/PixPin_2025-03-15_21-03-13_20250403090709A001.png\",\"createTime\":\"2025-04-03 09:05:38\",\"currentAmount\":150000,\"endTime\":\"2025-03-24\",\"fundUsageRules\":\"{\\\"rule1\\\":\\\"70%用于基础设施重建\\\",\\\"rule2\\\":\\\"30%用于灾民生活补助\\\"}\",\"initiatorId\":1,\"initiatorType\":\"1\",\"params\":{},\"projectDesc\":\"<p>为自然灾害受灾地区提供重建资金和物资支持</p>\",\"projectId\":5,\"projectName\":\"灾区重建援助\",\"startTime\":\"2025-02-02\",\"status\":\"2\",\"targetAmount\":200000,\"updateTime\":\"2025-04-03 09:07:12\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-04-03 09:07:12', 19);
INSERT INTO `sys_oper_log` VALUES (124, '慈善项目', 2, 'com.ruoyi.charity.controller.CharityProjectController.edit()', 'PUT', 1, 'admin', '研发部门', '/charity/project', '127.0.0.1', '内网IP', '{\"auditRemark\":\"紧急项目，优先审核通过\",\"auditStatus\":\"1\",\"auditTime\":\"2025-02-07\",\"auditUserId\":100,\"blockchainId\":\"bc_proj_004\",\"coverImage\":\"/profile/upload/2025/04/03/PixPin_2025-03-15_21-03-13_20250403090709A001.png,/profile/upload/2025/04/03/brown-glass10_20250403090740A002.jpg\",\"createTime\":\"2025-04-03 09:05:38\",\"currentAmount\":150000,\"endTime\":\"2025-03-24\",\"fundUsageRules\":\"{\\\"rule1\\\":\\\"70%用于基础设施重建\\\",\\\"rule2\\\":\\\"30%用于灾民生活补助\\\"}\",\"initiatorId\":1,\"initiatorType\":\"1\",\"params\":{},\"projectDesc\":\"<p>为自然灾害受灾地区提供重建资金和物资支持</p>\",\"projectId\":5,\"projectName\":\"灾区重建援助\",\"startTime\":\"2025-02-02\",\"status\":\"2\",\"targetAmount\":200000,\"updateTime\":\"2025-04-03 09:07:42\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-04-03 09:07:42', 7);
INSERT INTO `sys_oper_log` VALUES (125, '慈善项目', 2, 'com.ruoyi.charity.controller.CharityProjectController.edit()', 'PUT', 1, 'admin', '研发部门', '/charity/project', '127.0.0.1', '内网IP', '{\"auditRemark\":\"项目资料完整，目标明确\",\"auditStatus\":\"1\",\"auditTime\":\"2025-03-09\",\"auditUserId\":100,\"blockchainId\":\"bc_proj_001\",\"coverImage\":\"/profile/upload/2025/04/03/PixPin_2025-03-15_20-59-14_20250403090900A003.png\",\"createTime\":\"2025-04-03 09:05:38\",\"currentAmount\":35000,\"endTime\":\"2025-06-02\",\"fundUsageRules\":\"{\\\"rule1\\\":\\\"资金将全部用于学生学费和生活补贴\\\",\\\"rule2\\\":\\\"每季度公布资金使用情况\\\"}\",\"initiatorId\":1,\"initiatorType\":\"0\",\"params\":{},\"projectDesc\":\"<p>为贫困地区的孩子提供教育资助，帮助他们完成学业</p>\",\"projectId\":1,\"projectName\":\"希望工程助学计划\",\"startTime\":\"2025-03-04\",\"status\":\"1\",\"targetAmount\":100000,\"updateTime\":\"2025-04-03 09:09:02\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-04-03 09:09:02', 6);
INSERT INTO `sys_oper_log` VALUES (126, '慈善项目', 2, 'com.ruoyi.charity.controller.CharityProjectController.edit()', 'PUT', 1, 'admin', '研发部门', '/charity/project', '127.0.0.1', '内网IP', '{\"auditRemark\":\"11\",\"auditStatus\":\"2\",\"auditTime\":\"2025-04-03\",\"params\":{},\"projectId\":3,\"status\":\"1\",\"updateTime\":\"2025-04-03 09:10:54\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-04-03 09:10:54', 20);
INSERT INTO `sys_oper_log` VALUES (127, '慈善项目', 2, 'com.ruoyi.charity.controller.CharityProjectController.edit()', 'PUT', 1, 'admin', '研发部门', '/charity/project', '127.0.0.1', '内网IP', '{\"auditRemark\":\"紧急项目，优先审核通过\",\"auditStatus\":\"1\",\"auditTime\":\"2025-02-07\",\"auditUserId\":100,\"blockchainId\":\"bc_proj_004\",\"coverImage\":\"/profile/upload/2025/04/03/PixPin_2025-03-15_21-03-13_20250403090709A001.png\",\"createTime\":\"2025-04-03 09:05:38\",\"currentAmount\":150000,\"endTime\":\"2025-03-24\",\"fundUsageRules\":\"{\\\"rule1\\\":\\\"70%用于基础设施重建\\\",\\\"rule2\\\":\\\"30%用于灾民生活补助\\\"}\",\"initiatorId\":1,\"initiatorType\":\"1\",\"params\":{},\"projectDesc\":\"<p>为自然灾害受灾地区提供重建资金和物资支持</p>\",\"projectId\":5,\"projectName\":\"灾区重建援助\",\"startTime\":\"2025-02-02\",\"status\":\"2\",\"targetAmount\":200000,\"updateTime\":\"2025-04-03 09:26:25\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-04-03 09:26:25', 6);
INSERT INTO `sys_oper_log` VALUES (128, '慈善项目', 2, 'com.ruoyi.charity.controller.CharityProjectController.edit()', 'PUT', 1, 'admin', '研发部门', '/charity/project', '127.0.0.1', '内网IP', '{\"auditRemark\":\"项目可行性高，审核通过\",\"auditStatus\":\"1\",\"auditTime\":\"2025-03-24\",\"auditUserId\":101,\"blockchainId\":\"bc_proj_002\",\"coverImage\":\"/profile/upload/2025/04/03/2d52ca694cdc86a78eee55e46329bd5d_20250403092848A002.jpg\",\"createTime\":\"2025-04-03 09:05:38\",\"currentAmount\":15000,\"endTime\":\"2025-07-02\",\"fundUsageRules\":\"{\\\"rule1\\\":\\\"60%用于医疗设备采购\\\",\\\"rule2\\\":\\\"40%用于药品采购\\\"}\",\"initiatorId\":2,\"initiatorType\":\"1\",\"params\":{},\"projectDesc\":\"<p>为偏远山区提供基础医疗设备和药品，改善当地医疗条件</p>\",\"projectId\":2,\"projectName\":\"山区医疗援助\",\"startTime\":\"2025-03-19\",\"status\":\"1\",\"targetAmount\":50000,\"updateTime\":\"2025-04-03 09:28:50\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-04-03 09:28:50', 7);
INSERT INTO `sys_oper_log` VALUES (129, '慈善项目', 2, 'com.ruoyi.charity.controller.CharityProjectController.edit()', 'PUT', 1, 'admin', '研发部门', '/charity/project', '127.0.0.1', '内网IP', '{\"auditRemark\":\"11\",\"auditStatus\":\"2\",\"auditTime\":\"2025-04-03\",\"params\":{},\"projectId\":2,\"status\":\"1\",\"updateTime\":\"2025-04-03 09:30:08\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-04-03 09:30:08', 6);
INSERT INTO `sys_oper_log` VALUES (130, '慈善项目', 2, 'com.ruoyi.charity.controller.CharityProjectController.edit()', 'PUT', 1, 'admin', '研发部门', '/charity/project', '127.0.0.1', '内网IP', '{\"auditRemark\":\"项目资料完整，目标明确\",\"auditStatus\":\"1\",\"auditTime\":\"2025-03-09\",\"auditUserId\":100,\"blockchainId\":\"bc_proj_001\",\"coverImage\":\"/profile/upload/2025/04/03/PixPin_2025-03-15_20-59-14_20250403090900A003.png\",\"createTime\":\"2025-04-03 09:05:38\",\"currentAmount\":35000,\"endTime\":\"2025-06-02\",\"fundUsageRules\":\"{\\\"rule1\\\":\\\"资金将全部用于学生学费和生活补贴\\\",\\\"rule2\\\":\\\"每季度公布资金使用情况\\\"}\",\"initiatorId\":1,\"initiatorType\":\"0\",\"params\":{},\"projectDesc\":\"<p>为贫困地区的孩子提供教育资助，帮助他们完成学业</p>\",\"projectId\":1,\"projectName\":\"希望工程助学计划\",\"startTime\":\"2025-03-04\",\"status\":\"1\",\"targetAmount\":100000,\"updateTime\":\"2025-04-03 09:47:52\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-04-03 09:47:52', 8);
INSERT INTO `sys_oper_log` VALUES (131, '慈善项目', 2, 'com.ruoyi.charity.controller.CharityProjectController.edit()', 'PUT', 1, 'admin', '研发部门', '/charity/project', '127.0.0.1', '内网IP', '{\"auditRemark\":\"q\",\"auditStatus\":\"1\",\"auditTime\":\"2025-04-03\",\"params\":{},\"projectId\":1,\"status\":\"1\",\"updateTime\":\"2025-04-03 14:41:03\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-04-03 14:41:03', 26);
INSERT INTO `sys_oper_log` VALUES (132, '捐赠记录', 1, 'com.ruoyi.charity.controller.DonationRecordController.add()', 'POST', 1, 'admin', '研发部门', '/charity/donation', '127.0.0.1', '内网IP', '{\"createTime\":\"2025-04-03 15:59:59\",\"donationAmount\":10,\"params\":{},\"paymentMethod\":\"online\",\"projectId\":1}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'donation_time\' doesn\'t have a default value\r\n### The error may exist in file [E:\\jiedan\\juanzeng\\project\\backend\\ruoyi-admin\\target\\classes\\mapper\\charity\\DonationRecordMapper.xml]\r\n### The error may involve com.ruoyi.charity.mapper.DonationRecordMapper.insertDonationRecord-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into donation_record          ( project_id,             donation_amount,             payment_method,                                                                                           create_time )           values ( ?,             ?,             ?,                                                                                           ? )\r\n### Cause: java.sql.SQLException: Field \'donation_time\' doesn\'t have a default value\n; Field \'donation_time\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'donation_time\' doesn\'t have a default value', '2025-04-03 15:59:59', 120);
INSERT INTO `sys_oper_log` VALUES (133, '捐赠记录', 1, 'com.ruoyi.charity.controller.DonationRecordController.add()', 'POST', 1, 'admin', '研发部门', '/charity/donation', '127.0.0.1', '内网IP', '{\"createTime\":\"2025-04-03 16:05:14\",\"donationAmount\":10,\"donationId\":11,\"donationTime\":\"2025-04-03\",\"params\":{},\"paymentMethod\":\"online\",\"projectId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-04-03 16:05:14', 54);
INSERT INTO `sys_oper_log` VALUES (134, '捐赠记录', 1, 'com.ruoyi.charity.controller.DonationRecordController.add()', 'POST', 1, 'admin', '研发部门', '/charity/donation', '127.0.0.1', '内网IP', '{\"createTime\":\"2025-04-03 16:05:33\",\"donationAmount\":10,\"donationId\":12,\"donationTime\":\"2025-04-03\",\"params\":{},\"paymentMethod\":\"online\",\"projectId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-04-03 16:05:33', 9);
INSERT INTO `sys_oper_log` VALUES (135, '捐赠记录', 5, 'com.ruoyi.charity.controller.DonationRecordController.export()', 'POST', 1, 'admin', '研发部门', '/charity/donation/export', '127.0.0.1', '内网IP', '{\"pageSize\":\"10\",\"pageNum\":\"1\"}', NULL, 0, NULL, '2025-04-03 16:06:22', 1406);
INSERT INTO `sys_oper_log` VALUES (136, '捐赠记录', 3, 'com.ruoyi.charity.controller.DonationRecordController.remove()', 'DELETE', 1, 'admin', '研发部门', '/charity/donation/1,2,3,4,5,6,7,8,9', '127.0.0.1', '内网IP', '[1,2,3,4,5,6,7,8,9]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-04-03 16:06:25', 20);
INSERT INTO `sys_oper_log` VALUES (137, '资金使用记录', 1, 'com.ruoyi.charity.controller.FundUsageRecordController.add()', 'POST', 1, 'admin', '研发部门', '/charity/fund', '127.0.0.1', '内网IP', '{\"amount\":1000,\"createTime\":\"2025-04-03 17:13:02\",\"params\":{},\"projectId\":1,\"proofUrl\":\"/profile/upload/2025/04/03/Java高级程序设计-1_20250403171251A001.pdf\",\"usageDesc\":\"ssadf\",\"usageId\":8,\"usageTime\":\"2025-04-03\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-04-03 17:13:02', 29);
INSERT INTO `sys_oper_log` VALUES (138, '资金使用记录', 1, 'com.ruoyi.charity.controller.FundUsageRecordController.add()', 'POST', 1, 'admin', '研发部门', '/charity/fund', '127.0.0.1', '内网IP', '{\"amount\":10000,\"createTime\":\"2025-04-03 17:16:22\",\"params\":{},\"projectId\":1,\"proofUrl\":\"/profile/upload/2025/04/03/Java高级程序设计-1_20250403171617A002.pdf\",\"usageDesc\":\"【救助支出】testfsdfasdfa\",\"usageId\":9,\"usageTime\":\"2025-04-03\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-04-03 17:16:22', 7);
INSERT INTO `sys_oper_log` VALUES (139, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"charity/fund/audit\",\"createTime\":\"2025-04-03 02:08:05\",\"icon\":\"edit\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2032,\"menuName\":\"资金申请\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":2003,\"path\":\"audit\",\"perms\":\"charity:fund:audit\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-04-03 19:51:55', 22);
INSERT INTO `sys_oper_log` VALUES (140, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"charity/fund/fundAudit\",\"createTime\":\"2025-04-03 02:08:05\",\"icon\":\"edit\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2032,\"menuName\":\"资金申请\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":2003,\"path\":\"audit\",\"perms\":\"charity:fund:audit\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-04-03 20:12:54', 18);
INSERT INTO `sys_oper_log` VALUES (141, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"charity/fund/fundAudit\",\"createTime\":\"2025-04-03 02:08:05\",\"icon\":\"edit\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2032,\"menuName\":\"资金审核\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":2003,\"path\":\"audit\",\"perms\":\"charity:fund:audit\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-04-03 20:13:03', 11);
INSERT INTO `sys_oper_log` VALUES (142, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"charity/fund/fundAudit\",\"createTime\":\"2025-04-03 02:08:05\",\"icon\":\"edit\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2032,\"menuName\":\"资金审核\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":2003,\"path\":\"fundAudit\",\"perms\":\"charity:fund:audit\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-04-03 20:15:02', 14);
INSERT INTO `sys_oper_log` VALUES (143, '慈善项目', 2, 'com.ruoyi.charity.controller.CharityProjectController.edit()', 'PUT', 1, 'admin', '研发部门', '/charity/project', '127.0.0.1', '内网IP', '{\"auditRemark\":\"支持\\n\",\"auditStatus\":\"1\",\"auditTime\":\"2025-04-03\",\"params\":{},\"projectId\":2,\"status\":\"1\",\"updateTime\":\"2025-04-03 20:15:19\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-04-03 20:15:20', 14);
INSERT INTO `sys_oper_log` VALUES (144, '慈善项目', 2, 'com.ruoyi.charity.controller.CharityProjectController.edit()', 'PUT', 1, 'admin', '研发部门', '/charity/project', '127.0.0.1', '内网IP', '{\"auditRemark\":\"11\",\"auditStatus\":\"\",\"auditTime\":\"2025-04-03\",\"auditUserId\":101,\"blockchainId\":\"bc_proj_003\",\"coverImage\":\"/profile/upload/2025/04/04/brown-glass10_20250404180432A001.jpg\",\"createTime\":\"2025-04-03 09:05:38\",\"currentAmount\":5000,\"endTime\":\"2025-08-01\",\"fundUsageRules\":\"{\\\"rule1\\\":\\\"80%用于树苗购买和种植\\\",\\\"rule2\\\":\\\"20%用于后期维护\\\"}\",\"initiatorId\":100,\"initiatorType\":\"0\",\"params\":{},\"projectDesc\":\"<p>在沙漠化地区开展植树活动，改善生态环境</p>\",\"projectId\":3,\"projectName\":\"环保植树行动\",\"startTime\":\"2025-03-29\",\"status\":\"1\",\"targetAmount\":30000,\"updateTime\":\"2025-04-04 18:04:33\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-04-04 18:04:33', 22);
INSERT INTO `sys_oper_log` VALUES (145, '资金使用审核', 2, 'com.ruoyi.charity.controller.FundUsageRecordController.audit()', 'PUT', 1, 'admin', '研发部门', '/charity/fund/audit', '127.0.0.1', '内网IP', '{\"applicationStatus\":\"2\",\"auditRemark\":\"\",\"auditTime\":\"2025-04-04 18:15:22\",\"auditor\":\"admin\",\"params\":{},\"usageId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-04-04 18:15:22', 20);
INSERT INTO `sys_oper_log` VALUES (146, '资金使用审核', 2, 'com.ruoyi.charity.controller.FundUsageRecordController.audit()', 'PUT', 1, 'admin', '研发部门', '/charity/fund/audit', '127.0.0.1', '内网IP', '{\"applicationStatus\":\"2\",\"auditRemark\":\"\",\"auditTime\":\"2025-04-04 18:15:25\",\"auditor\":\"admin\",\"params\":{},\"usageId\":2}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-04-04 18:15:25', 7);
INSERT INTO `sys_oper_log` VALUES (147, '慈善项目', 2, 'com.ruoyi.charity.controller.CharityProjectController.edit()', 'PUT', 1, 'admin', '研发部门', '/charity/project', '127.0.0.1', '内网IP', '{\"auditRemark\":\"test\",\"auditStatus\":\"1\",\"auditTime\":\"2025-04-04\",\"params\":{},\"projectId\":1,\"status\":\"1\",\"updateTime\":\"2025-04-04 18:19:25\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-04-04 18:19:25', 23);
INSERT INTO `sys_oper_log` VALUES (148, '慈善项目', 2, 'com.ruoyi.charity.controller.CharityProjectController.edit()', 'PUT', 1, 'admin', '研发部门', '/charity/project', '127.0.0.1', '内网IP', '{\"auditRemark\":\"dfsa\",\"auditStatus\":\"0\",\"auditTime\":\"2025-04-04\",\"params\":{},\"projectId\":1,\"status\":\"0\",\"updateTime\":\"2025-04-04 18:20:48\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-04-04 18:20:48', 6);
INSERT INTO `sys_oper_log` VALUES (149, '慈善项目', 2, 'com.ruoyi.charity.controller.CharityProjectController.edit()', 'PUT', 1, 'admin', '研发部门', '/charity/project', '127.0.0.1', '内网IP', '{\"auditRemark\":\"sadf\",\"auditStatus\":\"0\",\"auditTime\":\"2025-04-04\",\"params\":{},\"projectId\":2,\"status\":\"0\",\"updateTime\":\"2025-04-04 18:21:17\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-04-04 18:21:17', 9);
INSERT INTO `sys_oper_log` VALUES (150, '慈善项目', 1, 'com.ruoyi.charity.controller.CharityProjectController.add()', 'POST', 1, 'admin', '研发部门', '/charity/project', '127.0.0.1', '内网IP', '{\"auditStatus\":\"0\",\"coverImage\":\"/profile/upload/2025/04/04/PixPin_2025-03-15_21-00-25_20250404182353A001.png\",\"createTime\":\"2025-04-04 18:23:58\",\"currentAmount\":0,\"endTime\":\"2025-05-12\",\"fundUsageRules\":\"sdffasd\",\"initiatorType\":\"0\",\"params\":{},\"projectDesc\":\"<p>asdfsdafsdf</p>\",\"projectId\":6,\"projectName\":\"asdfsadf\",\"startTime\":\"2025-04-17\",\"status\":\"0\",\"targetAmount\":1000}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-04-04 18:23:58', 11);
INSERT INTO `sys_oper_log` VALUES (151, '慈善项目', 1, 'com.ruoyi.charity.controller.CharityProjectController.add()', 'POST', 1, 'admin', '研发部门', '/charity/project', '127.0.0.1', '内网IP', '{\"coverImage\":\"/profile/upload/2025/04/04/cardboard10_20250404182653A002.jpg\",\"createTime\":\"2025-04-04 18:27:00\",\"currentAmount\":0,\"endTime\":\"2025-05-12\",\"fundUsageRules\":\"asdfdfs\",\"initiatorType\":\"1\",\"params\":{},\"projectDesc\":\"<p>asdfasdffdsa</p>\",\"projectId\":7,\"projectName\":\"tesat\",\"startTime\":\"2025-04-11\",\"status\":\"0\",\"targetAmount\":1000}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-04-04 18:27:00', 9);
INSERT INTO `sys_oper_log` VALUES (152, '慈善项目', 1, 'com.ruoyi.charity.controller.CharityProjectController.add()', 'POST', 1, 'admin', '研发部门', '/charity/project', '127.0.0.1', '内网IP', '{\"coverImage\":\"/profile/upload/2025/04/04/cardboard10_20250404182733A003.jpg\",\"createTime\":\"2025-04-04 18:27:34\",\"currentAmount\":0,\"endTime\":\"2025-05-23\",\"fundUsageRules\":\"afsddsaf\",\"initiatorType\":\"1\",\"params\":{},\"projectDesc\":\"<p>asdfasdfafds</p>\",\"projectId\":8,\"projectName\":\"asdfdfsa\",\"startTime\":\"2025-04-17\",\"status\":\"0\",\"targetAmount\":1000}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-04-04 18:27:34', 8);
INSERT INTO `sys_oper_log` VALUES (153, '慈善项目', 1, 'com.ruoyi.charity.controller.CharityProjectController.add()', 'POST', 1, 'admin', '研发部门', '/charity/project', '127.0.0.1', '内网IP', '{\"coverImage\":\"/profile/upload/2025/04/04/brown-glass10_20250404182813A004.jpg\",\"createTime\":\"2025-04-04 18:28:14\",\"currentAmount\":0,\"endTime\":\"2025-05-21\",\"fundUsageRules\":\"asfddsf\",\"initiatorType\":\"1\",\"params\":{},\"projectDesc\":\"<p>asfdsdafdfsa</p>\",\"projectId\":9,\"projectName\":\"asdfasdfas\",\"startTime\":\"2025-04-09\",\"status\":\"0\",\"targetAmount\":1000}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-04-04 18:28:14', 11);
INSERT INTO `sys_oper_log` VALUES (154, '慈善项目', 1, 'com.ruoyi.charity.controller.CharityProjectController.add()', 'POST', 1, 'admin', '研发部门', '/charity/project', '127.0.0.1', '内网IP', '{\"coverImage\":\"/profile/upload/2025/04/04/cardboard10_20250404183008A005.jpg\",\"createTime\":\"2025-04-04 18:30:11\",\"currentAmount\":0,\"endTime\":\"2025-05-12\",\"fundUsageRules\":\"asdfasdf\",\"initiatorType\":\"0\",\"params\":{},\"projectDesc\":\"<p>asdfasdf</p>\",\"projectId\":10,\"projectName\":\"asdfsdfa\",\"startTime\":\"2025-04-25\",\"status\":\"0\",\"targetAmount\":1000}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-04-04 18:30:11', 24);
INSERT INTO `sys_oper_log` VALUES (155, '慈善项目', 2, 'com.ruoyi.charity.controller.CharityProjectController.edit()', 'PUT', 1, 'admin', '研发部门', '/charity/project', '127.0.0.1', '内网IP', '{\"auditRemark\":\"sdfsadf\",\"params\":{},\"projectId\":5,\"status\":\"0\",\"updateTime\":\"2025-04-04 18:34:42\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-04-04 18:34:42', 8);
INSERT INTO `sys_oper_log` VALUES (156, '慈善项目', 2, 'com.ruoyi.charity.controller.CharityProjectController.edit()', 'PUT', 1, 'admin', '研发部门', '/charity/project', '127.0.0.1', '内网IP', '{\"auditRemark\":\"asdfasdf\",\"params\":{},\"projectId\":5,\"status\":\"0\",\"updateTime\":\"2025-04-04 18:36:00\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-04-04 18:36:00', 6);
INSERT INTO `sys_oper_log` VALUES (157, '慈善项目', 2, 'com.ruoyi.charity.controller.CharityProjectController.edit()', 'PUT', 1, 'admin', '研发部门', '/charity/project', '127.0.0.1', '内网IP', '{\"auditRemark\":\"teset\",\"params\":{},\"projectId\":5,\"status\":\"0\",\"updateTime\":\"2025-04-04 18:36:23\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-04-04 18:36:23', 6);
INSERT INTO `sys_oper_log` VALUES (158, '慈善项目', 2, 'com.ruoyi.charity.controller.CharityProjectController.edit()', 'PUT', 1, 'admin', '研发部门', '/charity/project', '127.0.0.1', '内网IP', '{\"auditRemark\":\"teset\",\"params\":{},\"projectId\":5,\"status\":\"1\",\"updateTime\":\"2025-04-04 18:37:08\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-04-04 18:37:08', 6);
INSERT INTO `sys_oper_log` VALUES (159, '慈善项目', 2, 'com.ruoyi.charity.controller.CharityProjectController.edit()', 'PUT', 1, 'admin', '研发部门', '/charity/project', '127.0.0.1', '内网IP', '{\"auditRemark\":\"sdfasd\",\"auditStatus\":\"0\",\"params\":{},\"projectId\":6,\"status\":\"1\",\"updateTime\":\"2025-04-04 18:37:53\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-04-04 18:37:53', 6);
INSERT INTO `sys_oper_log` VALUES (160, '慈善项目', 2, 'com.ruoyi.charity.controller.CharityProjectController.edit()', 'PUT', 1, 'admin', '研发部门', '/charity/project', '127.0.0.1', '内网IP', '{\"auditRemark\":\"test\",\"auditStatus\":\"0\",\"params\":{},\"projectId\":10,\"status\":\"1\",\"updateTime\":\"2025-04-04 18:38:22\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-04-04 18:38:22', 6);
INSERT INTO `sys_oper_log` VALUES (161, '捐赠记录', 1, 'com.ruoyi.charity.controller.DonationRecordController.add()', 'POST', 1, 'admin', '研发部门', '/charity/donation', '127.0.0.1', '内网IP', '{\"createTime\":\"2025-04-04 18:38:38\",\"donationAmount\":10,\"donationId\":13,\"donationTime\":\"2025-04-04\",\"params\":{},\"paymentMethod\":\"online\",\"projectId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-04-04 18:38:38', 11);
INSERT INTO `sys_oper_log` VALUES (162, '资金使用记录', 1, 'com.ruoyi.charity.controller.FundUsageRecordController.add()', 'POST', 1, 'admin', '研发部门', '/charity/fund', '127.0.0.1', '内网IP', '{\"amount\":10000,\"applicationStatus\":\"1\",\"createTime\":\"2025-04-04 18:58:06\",\"params\":{},\"projectId\":1,\"proofUrl\":\"/profile/upload/2025/04/04/Java高级程序设计-1_20250404185805A001.pdf\",\"usageDesc\":\"【医疗支出】tesatset\",\"usageId\":10,\"usageTime\":\"2025-04-04\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-04-04 18:58:06', 32);
INSERT INTO `sys_oper_log` VALUES (163, '资金使用审核', 2, 'com.ruoyi.charity.controller.FundUsageRecordController.audit()', 'PUT', 1, 'admin', '研发部门', '/charity/fund/audit', '127.0.0.1', '内网IP', '{\"applicationStatus\":\"2\",\"auditRemark\":\"\",\"auditTime\":\"2025-04-04 18:58:22\",\"auditor\":\"admin\",\"params\":{},\"usageId\":9}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-04-04 18:58:23', 9);
INSERT INTO `sys_oper_log` VALUES (164, '资金使用审核', 2, 'com.ruoyi.charity.controller.FundUsageRecordController.audit()', 'PUT', 1, 'admin', '研发部门', '/charity/fund/audit', '127.0.0.1', '内网IP', '{\"applicationStatus\":\"2\",\"auditRemark\":\"\",\"auditTime\":\"2025-04-04 18:58:37\",\"auditor\":\"admin\",\"params\":{},\"usageId\":10}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-04-04 18:58:37', 6);
INSERT INTO `sys_oper_log` VALUES (165, '资金使用审核', 2, 'com.ruoyi.charity.controller.FundUsageRecordController.audit()', 'PUT', 1, 'admin', '研发部门', '/charity/fund/audit', '127.0.0.1', '内网IP', '{\"applicationStatus\":\"2\",\"auditRemark\":\"\",\"auditTime\":\"2025-04-04 18:59:30\",\"auditor\":\"admin\",\"params\":{},\"usageId\":8}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-04-04 18:59:30', 7);
INSERT INTO `sys_oper_log` VALUES (166, '慈善项目', 2, 'com.ruoyi.charity.controller.CharityProjectController.edit()', 'PUT', 1, 'admin', '研发部门', '/charity/project', '127.0.0.1', '内网IP', '{\"auditRemark\":\"fsadfs\",\"auditStatus\":\"0\",\"params\":{},\"projectId\":7,\"status\":\"1\",\"updateTime\":\"2025-04-04 19:00:11\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-04-04 19:00:11', 12);
INSERT INTO `sys_oper_log` VALUES (167, '慈善项目', 2, 'com.ruoyi.charity.controller.CharityProjectController.edit()', 'PUT', 1, 'admin', '研发部门', '/charity/project', '127.0.0.1', '内网IP', '{\"auditRemark\":\"sdfasd\",\"auditStatus\":\"1\",\"params\":{},\"projectId\":9,\"status\":\"0\",\"updateTime\":\"2025-04-04 19:00:19\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-04-04 19:00:19', 18);
INSERT INTO `sys_oper_log` VALUES (168, '慈善项目', 2, 'com.ruoyi.charity.controller.CharityProjectController.edit()', 'PUT', 1, 'admin', '研发部门', '/charity/project', '127.0.0.1', '内网IP', '{\"auditRemark\":\"fasdf\",\"auditStatus\":\"1\",\"params\":{},\"projectId\":9,\"status\":\"0\",\"updateTime\":\"2025-04-04 19:00:36\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-04-04 19:00:36', 6);
INSERT INTO `sys_oper_log` VALUES (169, '慈善项目', 2, 'com.ruoyi.charity.controller.CharityProjectController.edit()', 'PUT', 1, 'admin', '研发部门', '/charity/project', '127.0.0.1', '内网IP', '{\"auditRemark\":\"asdf\",\"auditStatus\":\"1\",\"params\":{},\"projectId\":8,\"status\":\"0\",\"updateTime\":\"2025-04-04 19:00:39\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-04-04 19:00:39', 6);
INSERT INTO `sys_oper_log` VALUES (170, '慈善项目', 2, 'com.ruoyi.charity.controller.CharityProjectController.edit()', 'PUT', 1, 'admin', '研发部门', '/charity/project', '127.0.0.1', '内网IP', '{\"auditRemark\":\"asdf\",\"auditStatus\":\"1\",\"coverImage\":\"/profile/upload/2025/04/04/cardboard10_20250404182733A003.jpg\",\"createTime\":\"2025-04-04 18:27:35\",\"currentAmount\":0,\"endTime\":\"2025-05-23\",\"fundUsageRules\":\"afsddsaf\",\"initiatorType\":\"1\",\"params\":{},\"projectDesc\":\"<p>asdfasdfafds</p>\",\"projectId\":8,\"projectName\":\"asdfdfsa\",\"startTime\":\"2025-04-17\",\"status\":\"0\",\"targetAmount\":1000,\"updateTime\":\"2025-04-04 19:01:07\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-04-04 19:01:07', 8);
INSERT INTO `sys_oper_log` VALUES (171, '慈善项目', 2, 'com.ruoyi.charity.controller.CharityProjectController.edit()', 'PUT', 1, 'admin', '研发部门', '/charity/project', '127.0.0.1', '内网IP', '{\"auditRemark\":\"asdf\",\"auditStatus\":\"1\",\"coverImage\":\"/profile/upload/2025/04/04/cardboard10_20250404182733A003.jpg\",\"createTime\":\"2025-04-04 18:27:35\",\"currentAmount\":0,\"endTime\":\"2025-05-23\",\"fundUsageRules\":\"afsddsaf\",\"initiatorType\":\"1\",\"params\":{},\"projectDesc\":\"<p>asdfasdfafds</p>\",\"projectId\":8,\"projectName\":\"asdfdfsa\",\"startTime\":\"2025-04-17\",\"status\":\"0\",\"targetAmount\":1000,\"updateTime\":\"2025-04-04 19:01:19\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-04-04 19:01:19', 9);
INSERT INTO `sys_oper_log` VALUES (172, '慈善项目', 2, 'com.ruoyi.charity.controller.CharityProjectController.edit()', 'PUT', 1, 'admin', '研发部门', '/charity/project', '127.0.0.1', '内网IP', '{\"auditRemark\":\"asdf\",\"auditStatus\":\"0\",\"coverImage\":\"/profile/upload/2025/04/04/cardboard10_20250404182733A003.jpg\",\"createTime\":\"2025-04-04 18:27:35\",\"currentAmount\":0,\"endTime\":\"2025-05-23\",\"fundUsageRules\":\"afsddsaf\",\"initiatorType\":\"1\",\"params\":{},\"projectDesc\":\"<p>asdfasdfafds</p>\",\"projectId\":8,\"projectName\":\"asdfdfsa\",\"startTime\":\"2025-04-17\",\"status\":\"0\",\"targetAmount\":1000,\"updateTime\":\"2025-04-04 19:02:21\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-04-04 19:02:21', 9);
INSERT INTO `sys_oper_log` VALUES (173, '慈善项目', 2, 'com.ruoyi.charity.controller.CharityProjectController.edit()', 'PUT', 1, 'admin', '研发部门', '/charity/project', '127.0.0.1', '内网IP', '{\"auditRemark\":\"fasdf\",\"coverImage\":\"/profile/upload/2025/04/04/brown-glass10_20250404182813A004.jpg\",\"createTime\":\"2025-04-04 18:28:14\",\"currentAmount\":0,\"endTime\":\"2025-05-21\",\"fundUsageRules\":\"asfddsf\",\"initiatorType\":\"1\",\"params\":{},\"projectDesc\":\"<p>asfdsdafdfsa</p>\",\"projectId\":9,\"projectName\":\"asdfasdfas\",\"startTime\":\"2025-04-09\",\"status\":\"0\",\"targetAmount\":1000,\"updateTime\":\"2025-04-04 19:03:43\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-04-04 19:03:43', 7);
INSERT INTO `sys_oper_log` VALUES (174, '资金使用审核', 2, 'com.ruoyi.charity.controller.FundUsageRecordController.audit()', 'PUT', 1, 'admin', '研发部门', '/charity/fund/audit', '127.0.0.1', '内网IP', '{\"applicationStatus\":\"2\",\"auditRemark\":\"teset\",\"auditTime\":\"2025-04-04 19:06:52\",\"auditor\":\"admin\",\"params\":{},\"usageId\":7}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-04-04 19:06:52', 19);
INSERT INTO `sys_oper_log` VALUES (175, '慈善项目', 2, 'com.ruoyi.charity.controller.CharityProjectController.edit()', 'PUT', 1, 'admin', '研发部门', '/charity/project', '127.0.0.1', '内网IP', '{\"auditRemark\":\"fasdf\",\"coverImage\":\"/profile/upload/2025/04/04/brown-glass10_20250404182813A004.jpg\",\"createTime\":\"2025-04-04 18:28:14\",\"currentAmount\":0,\"endTime\":\"2025-05-21\",\"fundUsageRules\":\"asfddsf\",\"initiatorType\":\"1\",\"params\":{},\"projectDesc\":\"<p>asfdsdafdfsa</p>\",\"projectId\":9,\"projectName\":\"asdfasdfas\",\"startTime\":\"2025-04-09\",\"status\":\"0\",\"targetAmount\":1000,\"updateTime\":\"2025-04-04 19:07:10\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-04-04 19:07:11', 18);
INSERT INTO `sys_oper_log` VALUES (176, '捐赠记录', 3, 'com.ruoyi.charity.controller.DonationRecordController.remove()', 'DELETE', 1, 'admin', '研发部门', '/charity/donation/11', '127.0.0.1', '内网IP', '[11]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-04-04 19:08:28', 13);
INSERT INTO `sys_oper_log` VALUES (177, '捐赠记录', 3, 'com.ruoyi.charity.controller.DonationRecordController.remove()', 'DELETE', 1, 'admin', '研发部门', '/charity/donation/12', '127.0.0.1', '内网IP', '[12]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-04-04 19:08:29', 6);
INSERT INTO `sys_oper_log` VALUES (178, '捐赠记录', 3, 'com.ruoyi.charity.controller.DonationRecordController.remove()', 'DELETE', 1, 'admin', '研发部门', '/charity/donation/13', '127.0.0.1', '内网IP', '[13]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-04-04 19:08:31', 5);
INSERT INTO `sys_oper_log` VALUES (179, '捐赠记录', 1, 'com.ruoyi.charity.controller.DonationRecordController.add()', 'POST', 1, 'admin', '研发部门', '/charity/donation', '127.0.0.1', '内网IP', '{\"createTime\":\"2025-04-04 19:08:42\",\"donationAmount\":10,\"donationId\":14,\"donationTime\":\"2025-04-04\",\"params\":{},\"paymentMethod\":\"online\",\"projectId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-04-04 19:08:42', 12);
INSERT INTO `sys_oper_log` VALUES (180, '捐赠记录', 3, 'com.ruoyi.charity.controller.DonationRecordController.remove()', 'DELETE', 1, 'admin', '研发部门', '/charity/donation/14', '127.0.0.1', '内网IP', '[14]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-04-04 19:14:21', 17);
INSERT INTO `sys_oper_log` VALUES (181, '捐赠记录', 1, 'com.ruoyi.charity.controller.DonationRecordController.add()', 'POST', 1, 'admin', '研发部门', '/charity/donation', '127.0.0.1', '内网IP', '{\"createTime\":\"2025-04-04 19:14:32\",\"donationAmount\":10,\"donationId\":15,\"donationTime\":\"2025-04-04\",\"params\":{},\"paymentMethod\":\"online\",\"projectId\":2}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-04-04 19:14:32', 35);
INSERT INTO `sys_oper_log` VALUES (182, '捐赠记录', 1, 'com.ruoyi.charity.controller.DonationRecordController.add()', 'POST', 1, 'admin', '研发部门', '/charity/donation', '127.0.0.1', '内网IP', '{\"createTime\":\"2025-04-04 19:14:51\",\"donationAmount\":10333,\"donationId\":16,\"donationTime\":\"2025-04-04\",\"params\":{},\"paymentMethod\":\"online\",\"projectId\":2}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-04-04 19:14:51', 18);
INSERT INTO `sys_oper_log` VALUES (183, '捐赠记录', 1, 'com.ruoyi.charity.controller.DonationRecordController.add()', 'POST', 1, 'admin', '研发部门', '/charity/donation', '127.0.0.1', '内网IP', '{\"createTime\":\"2025-04-04 19:15:49\",\"donationAmount\":10,\"donationId\":17,\"donationTime\":\"2025-04-04\",\"params\":{},\"paymentMethod\":\"online\",\"projectId\":2}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-04-04 19:15:49', 14);
INSERT INTO `sys_oper_log` VALUES (184, '捐赠记录', 1, 'com.ruoyi.charity.controller.DonationRecordController.add()', 'POST', 1, 'admin', '研发部门', '/charity/donation', '127.0.0.1', '内网IP', '{\"createTime\":\"2025-04-04 19:16:04\",\"donationAmount\":10,\"donationId\":18,\"donationTime\":\"2025-04-04\",\"params\":{},\"paymentMethod\":\"online\",\"projectId\":3}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-04-04 19:16:04', 18);
INSERT INTO `sys_oper_log` VALUES (185, '捐赠记录', 1, 'com.ruoyi.charity.controller.DonationRecordController.add()', 'POST', 1, 'admin', '研发部门', '/charity/donation', '127.0.0.1', '内网IP', '{\"createTime\":\"2025-04-04 19:19:07\",\"donationAmount\":10,\"donationId\":19,\"donationTime\":\"2025-04-04\",\"params\":{},\"paymentMethod\":\"online\",\"projectId\":2}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-04-04 19:19:07', 33);
INSERT INTO `sys_oper_log` VALUES (186, '捐赠记录', 1, 'com.ruoyi.charity.controller.DonationRecordController.add()', 'POST', 1, 'admin', '研发部门', '/charity/donation', '127.0.0.1', '内网IP', '{\"createTime\":\"2025-04-04 19:20:18\",\"donationAmount\":10,\"donationId\":20,\"donationTime\":\"2025-04-04\",\"params\":{},\"paymentMethod\":\"online\",\"projectId\":2,\"remark\":\"sdfsdf\",\"status\":\"1\",\"userId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-04-04 19:20:18', 74);
INSERT INTO `sys_oper_log` VALUES (187, '捐赠记录', 3, 'com.ruoyi.charity.controller.DonationRecordController.remove()', 'DELETE', 1, 'admin', '研发部门', '/charity/donation/15', '127.0.0.1', '内网IP', '[15]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-04-04 19:22:47', 8);
INSERT INTO `sys_oper_log` VALUES (188, '捐赠记录', 3, 'com.ruoyi.charity.controller.DonationRecordController.remove()', 'DELETE', 1, 'admin', '研发部门', '/charity/donation/16,19,17,18', '127.0.0.1', '内网IP', '[16,19,17,18]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-04-04 19:22:52', 5);
INSERT INTO `sys_oper_log` VALUES (189, '捐赠记录', 2, 'com.ruoyi.charity.controller.DonationRecordController.edit()', 'PUT', 1, 'admin', '研发部门', '/charity/donation', '127.0.0.1', '内网IP', '{\"certificateIssueDate\":\"2025-04-04\",\"certificateUrl\":\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAABgAAAAUECAYAAAAal9vgAAAAAXNSR0IArs4c6QAAIABJREFUeF7s3QmcXFWd9/9fVe97d7o7naTT6U7IAgSQSFgCOOIy+IAiYVWYB4E4gxu7IjPz6F8Z/csDLiAIKo+yqA8qm6Aio6OOCyEJBANEIAkh6e6ks3Y6vaT37qrndW6opru66t5zqm5V3br1ua+Xr8xjn3vvue9zbs0853vOuYFwOBwWDgQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEPCVQIAAwFftycMggAACCCCAAAIIIIAAAggggAACCCCAAAIIIGAJEADQERBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQ8KEAAYAPG5VHQgABBBBAAAEEEEAAAQQQQAABBBBAAAEEEECAAIA+gAACCCCAAAIIIIAAAggggAACCCCAAAIIIICADwUIAHzYqDwSAggggAACCCCAAAIIIIAAAggggAACCCCAAAIEAPQBBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAQR8KEAA4MNG5ZEQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEECAAoA8ggAACCCCAAAIIIIAAAggggAACCCCAAAIIIOBDAQIAHzYqj4QAAggggAACCCCAAAIIIIAAAggggAACCCCAAAEAfQABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEAAAR8KEAD4sFF5JAQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEECADoAwgggAACCCCAAAIIIIAAAggggAACCCCAAAII+FCAAMCHjcojIYAAAggggAACCCCAAAIIIIAAAggggAACCCBAAEAfQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEEDAhwIEAD5sVB4JAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAECAPoAAggggAACCCCAAAIIIIAAAggggAACCCCAAAI+FCAA8GGj8kgIIIAAAggggAACCCCAAAIIIIAAAggggAACCBAA0AcQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEEPChAAGADxuVR0IAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAgACAPoAAAggggAACCCCAAAIIIIAAAggggAACCCCAgA8FCAB82Kg8EgIIIIAAAggggAACCCCAAAIIIIAAAggggAACBAD0AQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEEfChAAODDRuWREEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBAgAKAPIIAAAggggAACCCCAAAIIIIAAAggggAACCCDgQwECAB82Ko+EAAIIIIAAAggggAACCCCAAAIIIIAAAggggAABAH0AAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAAAEfChAA+LBReSQEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBAgA6AMIIIAAAggggAACCCCAAAIIIIAAAggggAACCPhQgADAh43KIyGAAAIIIIAAAggggAACCCCAAAIIIIAAAgggQABAH0AAAQQQQAABBBBAAAEEEEAAAQQQQAABBBBAwIcCBAA+bFQeCQEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABAgD6AAIIIIAAAggggAACCCCAAAIIIIAAAggggAACPhQgAPBho/JICCCAAAIIIIAAAggggAACCCCAAAIIIIAAAggQANAHEEAAAQQQQAABBBBAAAEEEEAAAQQQQAABBBDwoQABgA8blUdCAAEEEEAAAQQQQAABBBBAAAEEEEAAAQQQQIAAgD6AAAIIIIAAAggggAACCCCAAAIIIIAAAggggIAPBQgAfNioPBICCCCAAAIIIIAAAggggAACCCCAAAIIIIAAAgQA9AEEEEAAAQQQQAABBBB', '{\"msg\":\"操作失败\",\"code\":500}', 0, NULL, '2025-04-04 19:24:32', 33);
INSERT INTO `sys_oper_log` VALUES (190, '区块链交易记录', 3, 'com.ruoyi.charity.controller.BlockchainTransactionController.remove()', 'DELETE', 1, 'admin', '研发部门', '/charity/blockchain/bc_proj_001,bc_proj_002,bc_proj_003,bc_proj_004,tx_hash_001,tx_hash_002,tx_hash_003,tx_hash_004,tx_hash_005,tx_hash_006', '127.0.0.1', '内网IP', '[\"bc_proj_001\",\"bc_proj_002\",\"bc_proj_003\",\"bc_proj_004\",\"tx_hash_001\",\"tx_hash_002\",\"tx_hash_003\",\"tx_hash_004\",\"tx_hash_005\",\"tx_hash_006\"]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-04-04 19:27:28', 10);
INSERT INTO `sys_oper_log` VALUES (191, '区块链交易记录', 3, 'com.ruoyi.charity.controller.BlockchainTransactionController.remove()', 'DELETE', 1, 'admin', '研发部门', '/charity/blockchain/tx_hash_007,tx_hash_008,tx_hash_009,tx_hash_usage_001,tx_hash_usage_002,tx_hash_usage_003,tx_hash_usage_004,tx_hash_usage_005,tx_hash_usage_006,tx_hash_usage_007', '127.0.0.1', '内网IP', '[\"tx_hash_007\",\"tx_hash_008\",\"tx_hash_009\",\"tx_hash_usage_001\",\"tx_hash_usage_002\",\"tx_hash_usage_003\",\"tx_hash_usage_004\",\"tx_hash_usage_005\",\"tx_hash_usage_006\",\"tx_hash_usage_007\"]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-04-04 19:27:31', 24);
INSERT INTO `sys_oper_log` VALUES (192, '项目评价', 1, 'com.ruoyi.charity.controller.ProjectCommentController.add()', 'POST', 1, 'admin', '研发部门', '/charity/comment', '127.0.0.1', '内网IP', '{\"content\":\"sadfasf\",\"createTime\":\"2025-04-04 19:39:12\",\"params\":{},\"projectId\":2,\"rating\":5}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'user_id\' doesn\'t have a default value\r\n### The error may exist in file [E:\\jiedan\\juanzeng\\project\\backend\\ruoyi-admin\\target\\classes\\mapper\\charity\\ProjectCommentMapper.xml]\r\n### The error may involve com.ruoyi.charity.mapper.ProjectCommentMapper.insertProjectComment-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into project_comment          ( project_id,                          content,             rating,             create_time )           values ( ?,                          ?,             ?,             ? )\r\n### Cause: java.sql.SQLException: Field \'user_id\' doesn\'t have a default value\n; Field \'user_id\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'user_id\' doesn\'t have a default value', '2025-04-04 19:39:12', 59);
INSERT INTO `sys_oper_log` VALUES (193, '项目评价', 1, 'com.ruoyi.charity.controller.ProjectCommentController.add()', 'POST', 1, 'admin', '研发部门', '/charity/comment', '127.0.0.1', '内网IP', '{\"commentId\":9,\"content\":\"asdfasdf\",\"createTime\":\"2025-04-04 19:41:11\",\"params\":{},\"projectId\":2,\"rating\":5,\"userId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-04-04 19:41:11', 5);
INSERT INTO `sys_oper_log` VALUES (194, '项目评价', 1, 'com.ruoyi.charity.controller.ProjectCommentController.add()', 'POST', 1, 'admin', '研发部门', '/charity/comment', '127.0.0.1', '内网IP', '{\"commentId\":10,\"content\":\"afsdf\",\"createTime\":\"2025-04-04 19:53:44\",\"params\":{},\"projectId\":2,\"rating\":5,\"userId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-04-04 19:53:44', 28);
INSERT INTO `sys_oper_log` VALUES (195, '捐赠记录', 1, 'com.ruoyi.charity.controller.DonationRecordController.add()', 'POST', 1, 'admin', '研发部门', '/charity/donation', '127.0.0.1', '内网IP', '{\"createTime\":\"2025-04-05 19:50:12\",\"donationAmount\":40,\"donationId\":21,\"donationTime\":\"2025-04-05\",\"params\":{},\"paymentMethod\":\"online\",\"projectId\":2,\"remark\":\"asdf\",\"status\":\"1\",\"userId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-04-05 19:50:12', 63);
INSERT INTO `sys_oper_log` VALUES (196, '慈善项目', 1, 'com.ruoyi.charity.controller.CharityProjectController.add()', 'POST', 1, 'admin', '研发部门', '/charity/project', '127.0.0.1', '内网IP', '{\"blockchainId\":\"project_75e1825329a7469d\",\"coverImage\":\"/profile/upload/2025/04/05/PixPin_2025-03-15_20-59-14_20250405195827A001.png\",\"createTime\":\"2025-04-05 19:58:33\",\"currentAmount\":0,\"endTime\":\"2025-05-11\",\"fundUsageRules\":\"test\",\"initiatorType\":\"1\",\"params\":{},\"projectDesc\":\"<blockquote><br></blockquote>\",\"projectId\":11,\"projectName\":\"test\",\"startTime\":\"2025-04-18\",\"status\":\"0\",\"targetAmount\":1000}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-04-05 19:58:36', 2262);
INSERT INTO `sys_oper_log` VALUES (197, '慈善项目', 2, 'com.ruoyi.charity.controller.CharityProjectController.edit()', 'PUT', 1, 'admin', '研发部门', '/charity/project', '127.0.0.1', '内网IP', '{\"auditRemark\":\"test\",\"auditStatus\":\"0\",\"params\":{},\"projectId\":11,\"status\":\"1\",\"updateTime\":\"2025-04-05 19:58:45\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-04-05 19:58:45', 8);
INSERT INTO `sys_oper_log` VALUES (198, '慈善项目', 1, 'com.ruoyi.charity.controller.CharityProjectController.add()', 'POST', 1, 'admin', '研发部门', '/charity/project', '127.0.0.1', '内网IP', '{\"blockchainId\":\"project_54b8ef6fe6294bda\",\"coverImage\":\"/profile/upload/2025/04/05/PixPin_2025-03-15_20-59-14_20250405200740A001.png\",\"createTime\":\"2025-04-05 20:07:44\",\"currentAmount\":0,\"endTime\":\"2025-05-12\",\"fundUsageRules\":\"tests\",\"initiatorType\":\"0\",\"params\":{},\"projectDesc\":\"<p>tests</p>\",\"projectId\":12,\"projectName\":\"test\",\"startTime\":\"2025-04-18\",\"status\":\"0\",\"targetAmount\":1000}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-04-05 20:07:46', 2340);
INSERT INTO `sys_oper_log` VALUES (199, '慈善项目', 2, 'com.ruoyi.charity.controller.CharityProjectController.edit()', 'PUT', 1, 'admin', '研发部门', '/charity/project', '127.0.0.1', '内网IP', '{\"auditRemark\":\"tes\",\"auditStatus\":\"0\",\"params\":{},\"projectId\":12,\"status\":\"1\",\"updateTime\":\"2025-04-05 20:07:58\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-04-05 20:07:58', 7);

-- ----------------------------
-- Table structure for sys_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_post`;
CREATE TABLE `sys_post`  (
  `post_id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '岗位ID',
  `post_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '岗位编码',
  `post_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '岗位名称',
  `post_sort` int(0) NOT NULL COMMENT '显示顺序',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`post_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '岗位信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_post
-- ----------------------------
INSERT INTO `sys_post` VALUES (1, 'ceo', '董事长', 1, '0', 'admin', '2025-04-02 21:18:49', '', NULL, '');
INSERT INTO `sys_post` VALUES (2, 'se', '项目经理', 2, '0', 'admin', '2025-04-02 21:18:49', '', NULL, '');
INSERT INTO `sys_post` VALUES (3, 'hr', '人力资源', 3, '0', 'admin', '2025-04-02 21:18:49', '', NULL, '');
INSERT INTO `sys_post` VALUES (4, 'user', '普通员工', 4, '0', 'admin', '2025-04-02 21:18:49', '', NULL, '');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `role_id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色名称',
  `role_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色权限字符串',
  `role_sort` int(0) NOT NULL COMMENT '显示顺序',
  `data_scope` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  `menu_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '菜单树选择项是否关联显示',
  `dept_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '部门树选择项是否关联显示',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '角色信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '超级管理员', 'admin', 1, '1', 1, 1, '0', '0', 'admin', '2025-04-02 21:18:49', '', NULL, '超级管理员');
INSERT INTO `sys_role` VALUES (2, '普通角色', 'common', 2, '2', 1, 1, '0', '0', 'admin', '2025-04-02 21:18:49', '', NULL, '普通角色');
INSERT INTO `sys_role` VALUES (3, '慈善组织', 'charity', 3, '1', 1, 1, '0', '0', 'admin', '2025-04-03 00:49:36', '', NULL, '慈善组织角色，可以发布项目并管理资金');
INSERT INTO `sys_role` VALUES (4, '普通用户', 'user', 4, '1', 1, 1, '0', '0', 'admin', '2025-04-03 00:49:36', '', NULL, '普通用户角色，可以捐款和查看项目');

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE `sys_role_dept`  (
  `role_id` bigint(0) NOT NULL COMMENT '角色ID',
  `dept_id` bigint(0) NOT NULL COMMENT '部门ID',
  PRIMARY KEY (`role_id`, `dept_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '角色和部门关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_dept
-- ----------------------------
INSERT INTO `sys_role_dept` VALUES (2, 100);
INSERT INTO `sys_role_dept` VALUES (2, 101);
INSERT INTO `sys_role_dept` VALUES (2, 105);

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `role_id` bigint(0) NOT NULL COMMENT '角色ID',
  `menu_id` bigint(0) NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`, `menu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '角色和菜单关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (1, 2000);
INSERT INTO `sys_role_menu` VALUES (1, 2001);
INSERT INTO `sys_role_menu` VALUES (1, 2002);
INSERT INTO `sys_role_menu` VALUES (1, 2003);
INSERT INTO `sys_role_menu` VALUES (1, 2004);
INSERT INTO `sys_role_menu` VALUES (1, 2005);
INSERT INTO `sys_role_menu` VALUES (1, 2006);
INSERT INTO `sys_role_menu` VALUES (1, 2007);
INSERT INTO `sys_role_menu` VALUES (1, 2011);
INSERT INTO `sys_role_menu` VALUES (1, 2012);
INSERT INTO `sys_role_menu` VALUES (1, 2013);
INSERT INTO `sys_role_menu` VALUES (1, 2021);
INSERT INTO `sys_role_menu` VALUES (1, 2022);
INSERT INTO `sys_role_menu` VALUES (1, 2031);
INSERT INTO `sys_role_menu` VALUES (1, 2032);
INSERT INTO `sys_role_menu` VALUES (1, 2041);
INSERT INTO `sys_role_menu` VALUES (1, 2042);
INSERT INTO `sys_role_menu` VALUES (1, 2101);
INSERT INTO `sys_role_menu` VALUES (1, 2102);
INSERT INTO `sys_role_menu` VALUES (1, 2103);
INSERT INTO `sys_role_menu` VALUES (1, 2104);
INSERT INTO `sys_role_menu` VALUES (1, 2105);
INSERT INTO `sys_role_menu` VALUES (1, 2106);
INSERT INTO `sys_role_menu` VALUES (1, 2107);
INSERT INTO `sys_role_menu` VALUES (1, 2108);
INSERT INTO `sys_role_menu` VALUES (1, 2109);
INSERT INTO `sys_role_menu` VALUES (1, 2110);
INSERT INTO `sys_role_menu` VALUES (1, 2111);
INSERT INTO `sys_role_menu` VALUES (1, 2112);
INSERT INTO `sys_role_menu` VALUES (1, 2113);
INSERT INTO `sys_role_menu` VALUES (1, 2114);
INSERT INTO `sys_role_menu` VALUES (1, 2115);
INSERT INTO `sys_role_menu` VALUES (1, 2116);
INSERT INTO `sys_role_menu` VALUES (1, 2117);
INSERT INTO `sys_role_menu` VALUES (1, 2118);
INSERT INTO `sys_role_menu` VALUES (1, 2119);
INSERT INTO `sys_role_menu` VALUES (1, 2120);
INSERT INTO `sys_role_menu` VALUES (1, 2121);
INSERT INTO `sys_role_menu` VALUES (1, 2122);
INSERT INTO `sys_role_menu` VALUES (1, 2123);
INSERT INTO `sys_role_menu` VALUES (1, 2124);
INSERT INTO `sys_role_menu` VALUES (1, 2125);
INSERT INTO `sys_role_menu` VALUES (1, 2126);
INSERT INTO `sys_role_menu` VALUES (1, 2127);
INSERT INTO `sys_role_menu` VALUES (1, 2128);
INSERT INTO `sys_role_menu` VALUES (1, 2129);
INSERT INTO `sys_role_menu` VALUES (1, 2130);
INSERT INTO `sys_role_menu` VALUES (1, 2131);
INSERT INTO `sys_role_menu` VALUES (1, 2132);
INSERT INTO `sys_role_menu` VALUES (2, 1);
INSERT INTO `sys_role_menu` VALUES (2, 2);
INSERT INTO `sys_role_menu` VALUES (2, 3);
INSERT INTO `sys_role_menu` VALUES (2, 4);
INSERT INTO `sys_role_menu` VALUES (2, 100);
INSERT INTO `sys_role_menu` VALUES (2, 101);
INSERT INTO `sys_role_menu` VALUES (2, 102);
INSERT INTO `sys_role_menu` VALUES (2, 103);
INSERT INTO `sys_role_menu` VALUES (2, 104);
INSERT INTO `sys_role_menu` VALUES (2, 105);
INSERT INTO `sys_role_menu` VALUES (2, 106);
INSERT INTO `sys_role_menu` VALUES (2, 107);
INSERT INTO `sys_role_menu` VALUES (2, 108);
INSERT INTO `sys_role_menu` VALUES (2, 109);
INSERT INTO `sys_role_menu` VALUES (2, 110);
INSERT INTO `sys_role_menu` VALUES (2, 111);
INSERT INTO `sys_role_menu` VALUES (2, 112);
INSERT INTO `sys_role_menu` VALUES (2, 113);
INSERT INTO `sys_role_menu` VALUES (2, 114);
INSERT INTO `sys_role_menu` VALUES (2, 115);
INSERT INTO `sys_role_menu` VALUES (2, 116);
INSERT INTO `sys_role_menu` VALUES (2, 117);
INSERT INTO `sys_role_menu` VALUES (2, 500);
INSERT INTO `sys_role_menu` VALUES (2, 501);
INSERT INTO `sys_role_menu` VALUES (2, 1000);
INSERT INTO `sys_role_menu` VALUES (2, 1001);
INSERT INTO `sys_role_menu` VALUES (2, 1002);
INSERT INTO `sys_role_menu` VALUES (2, 1003);
INSERT INTO `sys_role_menu` VALUES (2, 1004);
INSERT INTO `sys_role_menu` VALUES (2, 1005);
INSERT INTO `sys_role_menu` VALUES (2, 1006);
INSERT INTO `sys_role_menu` VALUES (2, 1007);
INSERT INTO `sys_role_menu` VALUES (2, 1008);
INSERT INTO `sys_role_menu` VALUES (2, 1009);
INSERT INTO `sys_role_menu` VALUES (2, 1010);
INSERT INTO `sys_role_menu` VALUES (2, 1011);
INSERT INTO `sys_role_menu` VALUES (2, 1012);
INSERT INTO `sys_role_menu` VALUES (2, 1013);
INSERT INTO `sys_role_menu` VALUES (2, 1014);
INSERT INTO `sys_role_menu` VALUES (2, 1015);
INSERT INTO `sys_role_menu` VALUES (2, 1016);
INSERT INTO `sys_role_menu` VALUES (2, 1017);
INSERT INTO `sys_role_menu` VALUES (2, 1018);
INSERT INTO `sys_role_menu` VALUES (2, 1019);
INSERT INTO `sys_role_menu` VALUES (2, 1020);
INSERT INTO `sys_role_menu` VALUES (2, 1021);
INSERT INTO `sys_role_menu` VALUES (2, 1022);
INSERT INTO `sys_role_menu` VALUES (2, 1023);
INSERT INTO `sys_role_menu` VALUES (2, 1024);
INSERT INTO `sys_role_menu` VALUES (2, 1025);
INSERT INTO `sys_role_menu` VALUES (2, 1026);
INSERT INTO `sys_role_menu` VALUES (2, 1027);
INSERT INTO `sys_role_menu` VALUES (2, 1028);
INSERT INTO `sys_role_menu` VALUES (2, 1029);
INSERT INTO `sys_role_menu` VALUES (2, 1030);
INSERT INTO `sys_role_menu` VALUES (2, 1031);
INSERT INTO `sys_role_menu` VALUES (2, 1032);
INSERT INTO `sys_role_menu` VALUES (2, 1033);
INSERT INTO `sys_role_menu` VALUES (2, 1034);
INSERT INTO `sys_role_menu` VALUES (2, 1035);
INSERT INTO `sys_role_menu` VALUES (2, 1036);
INSERT INTO `sys_role_menu` VALUES (2, 1037);
INSERT INTO `sys_role_menu` VALUES (2, 1038);
INSERT INTO `sys_role_menu` VALUES (2, 1039);
INSERT INTO `sys_role_menu` VALUES (2, 1040);
INSERT INTO `sys_role_menu` VALUES (2, 1041);
INSERT INTO `sys_role_menu` VALUES (2, 1042);
INSERT INTO `sys_role_menu` VALUES (2, 1043);
INSERT INTO `sys_role_menu` VALUES (2, 1044);
INSERT INTO `sys_role_menu` VALUES (2, 1045);
INSERT INTO `sys_role_menu` VALUES (2, 1046);
INSERT INTO `sys_role_menu` VALUES (2, 1047);
INSERT INTO `sys_role_menu` VALUES (2, 1048);
INSERT INTO `sys_role_menu` VALUES (2, 1049);
INSERT INTO `sys_role_menu` VALUES (2, 1050);
INSERT INTO `sys_role_menu` VALUES (2, 1051);
INSERT INTO `sys_role_menu` VALUES (2, 1052);
INSERT INTO `sys_role_menu` VALUES (2, 1053);
INSERT INTO `sys_role_menu` VALUES (2, 1054);
INSERT INTO `sys_role_menu` VALUES (2, 1055);
INSERT INTO `sys_role_menu` VALUES (2, 1056);
INSERT INTO `sys_role_menu` VALUES (2, 1057);
INSERT INTO `sys_role_menu` VALUES (2, 1058);
INSERT INTO `sys_role_menu` VALUES (2, 1059);
INSERT INTO `sys_role_menu` VALUES (2, 1060);
INSERT INTO `sys_role_menu` VALUES (3, 2000);
INSERT INTO `sys_role_menu` VALUES (3, 2001);
INSERT INTO `sys_role_menu` VALUES (3, 2002);
INSERT INTO `sys_role_menu` VALUES (3, 2003);
INSERT INTO `sys_role_menu` VALUES (3, 2004);
INSERT INTO `sys_role_menu` VALUES (3, 2005);
INSERT INTO `sys_role_menu` VALUES (3, 2007);
INSERT INTO `sys_role_menu` VALUES (3, 2011);
INSERT INTO `sys_role_menu` VALUES (3, 2012);
INSERT INTO `sys_role_menu` VALUES (3, 2021);
INSERT INTO `sys_role_menu` VALUES (3, 2031);
INSERT INTO `sys_role_menu` VALUES (3, 2032);
INSERT INTO `sys_role_menu` VALUES (3, 2041);
INSERT INTO `sys_role_menu` VALUES (3, 2101);
INSERT INTO `sys_role_menu` VALUES (3, 2105);
INSERT INTO `sys_role_menu` VALUES (3, 2106);
INSERT INTO `sys_role_menu` VALUES (3, 2107);
INSERT INTO `sys_role_menu` VALUES (3, 2108);
INSERT INTO `sys_role_menu` VALUES (3, 2111);
INSERT INTO `sys_role_menu` VALUES (3, 2113);
INSERT INTO `sys_role_menu` VALUES (3, 2116);
INSERT INTO `sys_role_menu` VALUES (3, 2117);
INSERT INTO `sys_role_menu` VALUES (3, 2118);
INSERT INTO `sys_role_menu` VALUES (3, 2119);
INSERT INTO `sys_role_menu` VALUES (3, 2120);
INSERT INTO `sys_role_menu` VALUES (3, 2121);
INSERT INTO `sys_role_menu` VALUES (3, 2122);
INSERT INTO `sys_role_menu` VALUES (3, 2128);
INSERT INTO `sys_role_menu` VALUES (4, 2000);
INSERT INTO `sys_role_menu` VALUES (4, 2001);
INSERT INTO `sys_role_menu` VALUES (4, 2002);
INSERT INTO `sys_role_menu` VALUES (4, 2004);
INSERT INTO `sys_role_menu` VALUES (4, 2006);
INSERT INTO `sys_role_menu` VALUES (4, 2011);
INSERT INTO `sys_role_menu` VALUES (4, 2022);
INSERT INTO `sys_role_menu` VALUES (4, 2041);
INSERT INTO `sys_role_menu` VALUES (4, 2101);
INSERT INTO `sys_role_menu` VALUES (4, 2102);
INSERT INTO `sys_role_menu` VALUES (4, 2103);
INSERT INTO `sys_role_menu` VALUES (4, 2114);
INSERT INTO `sys_role_menu` VALUES (4, 2115);
INSERT INTO `sys_role_menu` VALUES (4, 2122);
INSERT INTO `sys_role_menu` VALUES (4, 2131);
INSERT INTO `sys_role_menu` VALUES (4, 2132);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `user_id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `dept_id` bigint(0) NULL DEFAULT NULL COMMENT '部门ID',
  `user_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户账号',
  `nick_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户昵称',
  `user_type` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '00' COMMENT '用户类型（00系统用户）',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '用户邮箱',
  `phonenumber` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '手机号码',
  `sex` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
  `avatar` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '头像地址',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '密码',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '帐号状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `login_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime(0) NULL DEFAULT NULL COMMENT '最后登录时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 101 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 103, 'admin', '若依', '00', 'ry@163.com', '15888888888', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2025-04-05 19:49:59', 'admin', '2025-04-02 21:18:49', '', '2025-04-05 19:49:58', '管理员');
INSERT INTO `sys_user` VALUES (2, 105, 'ry', '若依', '00', 'ry@qq.com', '15666666666', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2025-04-02 21:18:49', 'admin', '2025-04-02 21:18:49', '', NULL, '测试员');
INSERT INTO `sys_user` VALUES (100, 103, 'charity1', '爱心慈善组织', '00', 'charity1@example.com', '13800000001', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '', NULL, 'admin', '2025-04-03 00:49:36', '', NULL, '慈善组织测试账户');
INSERT INTO `sys_user` VALUES (101, 103, 'user1', '张爱心', '00', 'user1@example.com', '13800000002', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2025-04-03 01:39:32', 'admin', '2025-04-03 00:49:36', '', '2025-04-03 01:39:31', '普通用户测试账户');

-- ----------------------------
-- Table structure for sys_user_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_post`;
CREATE TABLE `sys_user_post`  (
  `user_id` bigint(0) NOT NULL COMMENT '用户ID',
  `post_id` bigint(0) NOT NULL COMMENT '岗位ID',
  PRIMARY KEY (`user_id`, `post_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户与岗位关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_post
-- ----------------------------
INSERT INTO `sys_user_post` VALUES (1, 1);
INSERT INTO `sys_user_post` VALUES (2, 2);

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `user_id` bigint(0) NOT NULL COMMENT '用户ID',
  `role_id` bigint(0) NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`, `role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户和角色关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (1, 1);
INSERT INTO `sys_user_role` VALUES (2, 2);
INSERT INTO `sys_user_role` VALUES (100, 3);
INSERT INTO `sys_user_role` VALUES (101, 4);

-- ----------------------------
-- Table structure for user_privacy_settings
-- ----------------------------
DROP TABLE IF EXISTS `user_privacy_settings`;
CREATE TABLE `user_privacy_settings`  (
  `user_id` bigint(0) NOT NULL COMMENT '用户ID',
  `show_donation_amount` tinyint(1) NULL DEFAULT 1 COMMENT '是否显示捐赠金额（0不显示 1显示）',
  `show_donation_list` tinyint(1) NULL DEFAULT 1 COMMENT '是否在捐赠列表显示（0不显示 1显示）',
  `show_real_name` tinyint(1) NULL DEFAULT 1 COMMENT '是否显示真实姓名（0不显示 1显示）',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`user_id`) USING BTREE,
  CONSTRAINT `fk_privacy_user_id` FOREIGN KEY (`user_id`) REFERENCES `sys_user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户隐私设置表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_privacy_settings
-- ----------------------------
INSERT INTO `user_privacy_settings` VALUES (1, 1, 1, 0, '2025-04-03 09:05:38', '2025-04-03 09:05:38');
INSERT INTO `user_privacy_settings` VALUES (2, 0, 1, 1, '2025-04-03 09:05:38', '2025-04-03 09:05:38');
INSERT INTO `user_privacy_settings` VALUES (100, 1, 0, 0, '2025-04-03 09:05:38', '2025-04-03 09:05:38');
INSERT INTO `user_privacy_settings` VALUES (101, 0, 0, 1, '2025-04-03 09:05:38', '2025-04-03 09:05:38');

SET FOREIGN_KEY_CHECKS = 1;
