-- 修改资金使用记录表，添加申请状态和审核信息相关字段

-- 添加申请状态字段
ALTER TABLE `fund_usage_record` 
ADD COLUMN `application_status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '1' COMMENT '申请状态（0未提交 1待审核 2已审核）' AFTER `usage_time`;

-- 添加审核人字段
ALTER TABLE `fund_usage_record` 
ADD COLUMN `auditor` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '审核人' AFTER `application_status`;

-- 添加审核时间字段
ALTER TABLE `fund_usage_record` 
ADD COLUMN `audit_time` datetime DEFAULT NULL COMMENT '审核时间' AFTER `auditor`;

-- 添加审核备注字段
ALTER TABLE `fund_usage_record` 
ADD COLUMN `audit_remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '审核备注' AFTER `audit_time`;

-- 添加索引
ALTER TABLE `fund_usage_record` 
ADD INDEX `idx_fund_application_status`(`application_status`) COMMENT '申请状态索引'; 