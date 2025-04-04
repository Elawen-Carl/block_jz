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

 Date: 03/04/2025 00:52:54
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

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
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '代码生成业务表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gen_table
-- ----------------------------
INSERT INTO `gen_table` VALUES (7, 'blockchain_transaction', '区块链交易记录表', NULL, NULL, 'BlockchainTransaction', 'crud', '', 'com.ruoyi.system', 'system', 'transaction', '区块链交易记录', 'ruoyi', '0', '/', NULL, 'admin', '2025-04-03 00:51:41', '', NULL, NULL);
INSERT INTO `gen_table` VALUES (8, 'charity_project', '慈善项目表', NULL, NULL, 'CharityProject', 'crud', '', 'com.ruoyi.system', 'system', 'project', '慈善项目', 'ruoyi', '0', '/', NULL, 'admin', '2025-04-03 00:51:41', '', NULL, NULL);
INSERT INTO `gen_table` VALUES (9, 'donation_record', '捐赠记录表', NULL, NULL, 'DonationRecord', 'crud', 'element-plus', 'com.ruoyi.system', 'system', 'record', '捐赠记录', 'ruoyi', '0', '/', '{}', 'admin', '2025-04-03 00:51:41', '', '2025-04-03 00:52:23', NULL);
INSERT INTO `gen_table` VALUES (10, 'fund_usage_record', '资金使用记录表', NULL, NULL, 'FundUsageRecord', 'crud', '', 'com.ruoyi.system', 'system', 'record', '资金使用记录', 'ruoyi', '0', '/', NULL, 'admin', '2025-04-03 00:51:41', '', NULL, NULL);
INSERT INTO `gen_table` VALUES (11, 'project_comment', '项目评价表', NULL, NULL, 'ProjectComment', 'crud', '', 'com.ruoyi.system', 'system', 'comment', '项目评价', 'ruoyi', '0', '/', NULL, 'admin', '2025-04-03 00:51:41', '', NULL, NULL);
INSERT INTO `gen_table` VALUES (12, 'user_privacy_settings', '用户隐私设置表', NULL, NULL, 'UserPrivacySettings', 'crud', '', 'com.ruoyi.system', 'system', 'settings', '用户隐私设置', 'ruoyi', '0', '/', NULL, 'admin', '2025-04-03 00:51:41', '', NULL, NULL);

SET FOREIGN_KEY_CHECKS = 1;
