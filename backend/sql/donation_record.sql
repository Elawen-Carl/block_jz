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

 Date: 05/04/2025 15:49:35
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

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

SET FOREIGN_KEY_CHECKS = 1;
