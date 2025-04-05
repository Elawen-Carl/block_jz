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

 Date: 05/04/2025 15:49:56
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

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

SET FOREIGN_KEY_CHECKS = 1;
