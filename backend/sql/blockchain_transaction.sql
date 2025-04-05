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

 Date: 05/04/2025 15:49:23
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

SET FOREIGN_KEY_CHECKS = 1;
