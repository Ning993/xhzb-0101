
####################
##  xhzb
####################
DROP DATABASE IF EXISTS `xhzb`;

####################
##  database xhzb ddl
####################
CREATE DATABASE `xhzb` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_eo_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

use `xhzb`;

####################
##  alert_data
####################
DROP TABLE IF EXISTS `alert_data`;

####################
##  table alert_data ddl
####################
CREATE TABLE `alert_data` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `iot_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '物联网设备id',
  `device_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '设备名称',
  `product_key` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '所属产品key',
  `product_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '产品名称',
  `function_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '功能标识符',
  `access_location` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '接入位置',
  `location_type` int DEFAULT NULL COMMENT '位置类型 0：随身设备 1：固定设备',
  `physical_location_type` int DEFAULT NULL COMMENT '物理位置类型 0楼层 1房间 2床位',
  `device_description` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '位置备注',
  `data_value` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '数据值',
  `alert_rule_id` bigint NOT NULL COMMENT '报警规则id',
  `alert_reason` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '报警原因，格式：功能名称+运算符+阈值+持续周期+聚合周期',
  `processing_result` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '处理结果',
  `processor_id` bigint DEFAULT NULL COMMENT '处理人id',
  `processor_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '处理人名称',
  `processing_time` datetime DEFAULT NULL COMMENT '处理时间',
  `type` int NOT NULL COMMENT '报警数据类型，0：老人异常数据，1：设备异常数据',
  `status` int NOT NULL COMMENT '状态，0：待处理，1：已处理',
  `user_id` bigint DEFAULT '0' COMMENT '接收人id',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_by` bigint DEFAULT NULL COMMENT '创建人id',
  `update_by` bigint DEFAULT NULL COMMENT '更新人id',
  `remark` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='报警数据';

####################
##  alert_data data
####################

####################
##  alert_data data
####################

####################
##  alert_rule
####################
DROP TABLE IF EXISTS `alert_rule`;

####################
##  table alert_rule ddl
####################
CREATE TABLE `alert_rule` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `product_key` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '所属产品的key',
  `product_name` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '产品名称',
  `module_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '模块的key',
  `module_name` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '模块名称',
  `function_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '功能名称',
  `function_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '功能标识',
  `iot_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '物联网设备id',
  `device_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '设备名称',
  `alert_data_type` int DEFAULT NULL COMMENT '报警数据类型，0：老人异常数据，1：设备异常数据',
  `alert_rule_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '告警规则名称',
  `operator` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '运算符',
  `value` float DEFAULT NULL COMMENT '阈值',
  `duration` int DEFAULT NULL COMMENT '持续周期',
  `alert_effective_period` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '报警生效时段',
  `alert_silent_period` int DEFAULT NULL COMMENT '报警沉默周期',
  `status` int DEFAULT NULL COMMENT '0 禁用 1启用',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `create_by` bigint DEFAULT NULL COMMENT '创建人id',
  `update_by` bigint DEFAULT NULL COMMENT '更新人id',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

####################
##  alert_rule data
####################

####################
##  alert_rule data
####################

####################
##  bed
####################
DROP TABLE IF EXISTS `bed`;

####################
##  table bed ddl
####################
CREATE TABLE `bed` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '床位ID',
  `bed_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '床位编号',
  `bed_status` int DEFAULT NULL COMMENT '床位状态: 未入住0, 已入住1 ',
  `sort` int DEFAULT NULL COMMENT '床位号',
  `room_id` bigint DEFAULT NULL COMMENT '房间ID',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `create_by` bigint DEFAULT NULL COMMENT '创建人id',
  `update_by` bigint DEFAULT NULL COMMENT '更新人id',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `bed_number` (`bed_number`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=212 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='床位表';

####################
##  bed data
####################

####################
##  bed data
####################
INSERT INTO `bed`(`bed_status`,`room_id`,`create_by`,`update_time`,`create_time`,`id`,`sort`,`bed_number`,`update_by`) VALUES (1,1,1671403256519078138,'2025-04-20T17:00:53','2023-09-26T17:39:53',1,1,'101-1',1);
INSERT INTO `bed`(`bed_status`,`room_id`,`create_by`,`update_time`,`create_time`,`id`,`sort`,`bed_number`,`update_by`) VALUES (1,2,1671403256519078138,'2023-10-05T16:00:05','2023-09-26T17:40:01',2,1,'102-1',1671403256519078164);
INSERT INTO `bed`(`bed_status`,`room_id`,`create_by`,`update_time`,`create_time`,`id`,`sort`,`bed_number`,`update_by`) VALUES (0,2,1671403256519078138,'2023-10-05T15:59:45','2023-09-26T17:40:09',3,2,'102-2',1671403256519078164);
INSERT INTO `bed`(`bed_status`,`room_id`,`create_by`,`update_time`,`create_time`,`id`,`sort`,`bed_number`,`update_by`) VALUES (0,3,1671403256519078138,'2023-10-05T16:00:21','2023-09-26T17:40:42',4,1,'103-1',1671403256519078164);
INSERT INTO `bed`(`bed_status`,`room_id`,`create_by`,`update_time`,`create_time`,`id`,`sort`,`bed_number`,`update_by`) VALUES (0,4,1671403256519078138,'2023-09-26T17:45:39','2023-09-26T17:40:49',5,1,'104-1',1671403256519078138);
INSERT INTO `bed`(`bed_status`,`room_id`,`create_by`,`update_time`,`create_time`,`id`,`sort`,`bed_number`,`update_by`) VALUES (0,4,1671403256519078138,'2023-10-20T23:22:12','2023-09-26T17:40:54',6,2,'104-2',1671403256519078164);
INSERT INTO `bed`(`bed_status`,`room_id`,`create_by`,`update_time`,`create_time`,`id`,`sort`,`bed_number`,`update_by`) VALUES (0,5,1671403256519078138,'2023-09-26T17:45:52','2023-09-26T17:41:09',7,1,'105-1',1671403256519078138);
INSERT INTO `bed`(`bed_status`,`room_id`,`create_by`,`update_time`,`create_time`,`id`,`sort`,`bed_number`,`update_by`) VALUES (0,6,1671403256519078138,'2023-09-26T17:45:58','2023-09-26T17:41:16',8,1,'106-1',1671403256519078138);
INSERT INTO `bed`(`bed_status`,`room_id`,`create_by`,`update_time`,`create_time`,`id`,`sort`,`bed_number`,`update_by`) VALUES (0,6,1671403256519078138,'2023-09-26T17:46:04','2023-09-26T17:41:24',9,2,'106-2',1671403256519078138);
INSERT INTO `bed`(`bed_status`,`room_id`,`create_by`,`update_time`,`create_time`,`id`,`sort`,`bed_number`,`update_by`) VALUES (0,7,1671403256519078138,'2023-12-21T09:37:49','2023-09-26T17:41:32',10,1,'107-1',1671403256519078138);
INSERT INTO `bed`(`bed_status`,`room_id`,`create_by`,`update_time`,`create_time`,`id`,`sort`,`bed_number`,`update_by`) VALUES (0,8,1671403256519078138,'2025-04-20T17:07:59','2023-09-26T17:44:53',11,1,'201-1',1);
INSERT INTO `bed`(`bed_status`,`room_id`,`create_by`,`update_time`,`create_time`,`id`,`sort`,`bed_number`,`update_by`) VALUES (1,9,1671403256519078138,'2023-09-26T17:46:33','2023-09-26T17:46:33',12,1,'202-1',1);
INSERT INTO `bed`(`bed_status`,`room_id`,`create_by`,`update_time`,`create_time`,`id`,`sort`,`bed_number`,`update_by`) VALUES (0,9,1671403256519078138,'2023-09-26T17:46:47','2023-09-26T17:46:47',13,2,'202-2',1);
INSERT INTO `bed`(`bed_status`,`room_id`,`create_by`,`update_time`,`create_time`,`id`,`sort`,`bed_number`,`update_by`) VALUES (0,10,1671403256519078138,'2023-09-26T18:43:58','2023-09-26T18:43:58',14,1,'203-1',1);
INSERT INTO `bed`(`bed_status`,`room_id`,`create_by`,`update_time`,`create_time`,`id`,`sort`,`bed_number`,`update_by`) VALUES (0,11,1671403256519078138,'2023-09-26T18:44:03','2023-09-26T18:44:03',15,1,'204-1',1);
INSERT INTO `bed`(`bed_status`,`room_id`,`create_by`,`update_time`,`create_time`,`id`,`sort`,`bed_number`,`update_by`) VALUES (0,11,1671403256519078138,'2023-09-26T18:44:12','2023-09-26T18:44:12',16,2,'204-2',1);
INSERT INTO `bed`(`bed_status`,`room_id`,`create_by`,`update_time`,`create_time`,`id`,`sort`,`bed_number`,`update_by`) VALUES (0,12,1671403256519078138,'2023-12-20T18:40:07','2023-09-26T18:44:23',18,1,'205-1',1671403256519078138);
INSERT INTO `bed`(`bed_status`,`room_id`,`create_by`,`update_time`,`create_time`,`id`,`sort`,`bed_number`,`update_by`) VALUES (0,13,1671403256519078138,'2023-12-20T21:43:10','2023-09-26T18:44:36',19,1,'206-1',1671403256519078138);
INSERT INTO `bed`(`bed_status`,`room_id`,`create_by`,`update_time`,`create_time`,`id`,`sort`,`bed_number`,`update_by`) VALUES (0,13,1671403256519078138,'2023-09-26T18:44:48','2023-09-26T18:44:42',20,2,'206-2',1671403256519078138);
INSERT INTO `bed`(`bed_status`,`room_id`,`create_by`,`update_time`,`create_time`,`id`,`sort`,`bed_number`) VALUES (0,14,1671403256519078138,'2023-09-26T18:45:01','2023-09-26T18:45:01',21,1,'207-1');
INSERT INTO `bed`(`bed_status`,`room_id`,`create_by`,`update_time`,`create_time`,`id`,`sort`,`bed_number`,`update_by`) VALUES (0,15,1671403256519078138,'2023-12-26T19:35:06','2023-09-26T18:45:26',22,1,'301-2',1671403256519078138);
INSERT INTO `bed`(`bed_status`,`room_id`,`create_by`,`update_time`,`create_time`,`id`,`sort`,`bed_number`) VALUES (0,16,1671403256519078138,'2023-09-26T18:45:31','2023-09-26T18:45:31',23,1,'302-1');
INSERT INTO `bed`(`bed_status`,`room_id`,`create_by`,`update_time`,`create_time`,`id`,`sort`,`bed_number`,`update_by`) VALUES (0,16,1671403256519078138,'2023-12-26T19:35:15','2023-09-26T18:45:39',24,2,'302-3',1671403256519078138);
INSERT INTO `bed`(`bed_status`,`room_id`,`create_by`,`update_time`,`create_time`,`id`,`sort`,`bed_number`) VALUES (0,17,1671403256519078138,'2023-09-26T18:45:44','2023-09-26T18:45:44',25,1,'303-1');
INSERT INTO `bed`(`bed_status`,`room_id`,`create_by`,`update_time`,`create_time`,`id`,`sort`,`bed_number`) VALUES (0,18,1671403256519078138,'2023-09-26T18:45:55','2023-09-26T18:45:55',27,1,'304-1');
INSERT INTO `bed`(`bed_status`,`room_id`,`create_by`,`update_time`,`create_time`,`id`,`sort`,`bed_number`,`update_by`) VALUES (0,18,1671403256519078138,'2023-09-26T18:46:04','2023-09-26T18:46:04',28,2,'304-2',1);
INSERT INTO `bed`(`bed_status`,`room_id`,`create_by`,`update_time`,`create_time`,`id`,`sort`,`bed_number`,`update_by`) VALUES (0,19,1671403256519078138,'2023-12-21T10:04:47','2023-09-26T18:46:11',29,1,'305-1',1671403256519078138);
INSERT INTO `bed`(`bed_status`,`room_id`,`create_by`,`update_time`,`create_time`,`id`,`sort`,`bed_number`) VALUES (0,20,1671403256519078138,'2023-09-26T18:46:16','2023-09-26T18:46:16',30,1,'306-1');
INSERT INTO `bed`(`bed_status`,`room_id`,`create_by`,`update_time`,`create_time`,`id`,`sort`,`bed_number`,`update_by`) VALUES (0,20,1671403256519078138,'2023-09-26T19:08:50','2023-09-26T18:46:22',31,2,'306-2',1671403256519078138);
INSERT INTO `bed`(`bed_status`,`room_id`,`create_by`,`update_time`,`create_time`,`id`,`sort`,`bed_number`) VALUES (0,21,1671403256519078138,'2023-09-26T18:46:29','2023-09-26T18:46:29',32,1,'307-1');
INSERT INTO `bed`(`bed_status`,`room_id`,`create_by`,`update_time`,`create_time`,`id`,`sort`,`bed_number`) VALUES (0,22,1671403256519078138,'2023-09-26T18:52:14','2023-09-26T18:52:14',33,1,'401-1');
INSERT INTO `bed`(`bed_status`,`room_id`,`create_by`,`update_time`,`create_time`,`id`,`sort`,`bed_number`) VALUES (0,23,1671403256519078138,'2023-09-26T18:52:22','2023-09-26T18:52:22',34,1,'402-1');
INSERT INTO `bed`(`bed_status`,`room_id`,`create_by`,`update_time`,`create_time`,`id`,`sort`,`bed_number`,`update_by`) VALUES (0,23,1671403256519078138,'2023-09-26T18:52:38','2023-09-26T18:52:35',35,2,'402-2',1671403256519078138);
INSERT INTO `bed`(`bed_status`,`room_id`,`create_by`,`update_time`,`create_time`,`id`,`sort`,`bed_number`,`update_by`) VALUES (0,24,1671403256519078138,'2023-09-26T18:52:47','2023-09-26T18:52:47',36,1,'403-1',1);
INSERT INTO `bed`(`bed_status`,`room_id`,`create_by`,`update_time`,`create_time`,`id`,`sort`,`bed_number`) VALUES (0,25,1671403256519078138,'2023-09-26T18:52:54','2023-09-26T18:52:54',37,1,'404-1');
INSERT INTO `bed`(`bed_status`,`room_id`,`create_by`,`update_time`,`create_time`,`id`,`sort`,`bed_number`,`update_by`) VALUES (0,25,1671403256519078138,'2023-09-26T18:53:10','2023-09-26T18:53:02',38,2,'404-2',1671403256519078138);
INSERT INTO `bed`(`bed_status`,`room_id`,`create_by`,`update_time`,`create_time`,`id`,`sort`,`bed_number`) VALUES (0,26,1671403256519078138,'2023-09-26T18:53:18','2023-09-26T18:53:18',39,1,'405-1');
INSERT INTO `bed`(`bed_status`,`room_id`,`create_by`,`update_time`,`create_time`,`id`,`sort`,`bed_number`) VALUES (0,27,1671403256519078138,'2023-09-26T18:53:27','2023-09-26T18:53:27',40,1,'406-1');
INSERT INTO `bed`(`bed_status`,`room_id`,`create_by`,`update_time`,`create_time`,`id`,`sort`,`bed_number`) VALUES (0,27,1671403256519078138,'2023-09-26T18:53:36','2023-09-26T18:53:36',41,2,'406-2');
INSERT INTO `bed`(`bed_status`,`room_id`,`create_by`,`update_time`,`create_time`,`id`,`sort`,`bed_number`) VALUES (0,28,1671403256519078138,'2023-09-26T18:53:44','2023-09-26T18:53:44',42,1,'407-1');
INSERT INTO `bed`(`bed_status`,`room_id`,`create_by`,`update_time`,`create_time`,`id`,`sort`,`bed_number`) VALUES (0,29,1671403256519078138,'2023-09-26T18:55:47','2023-09-26T18:55:47',43,1,'501-1');
INSERT INTO `bed`(`bed_status`,`room_id`,`create_by`,`update_time`,`create_time`,`id`,`sort`,`bed_number`) VALUES (0,31,1671403256519078138,'2023-09-26T18:55:52','2023-09-26T18:55:52',44,1,'502-1');
INSERT INTO `bed`(`bed_status`,`room_id`,`create_by`,`update_time`,`create_time`,`id`,`sort`,`bed_number`) VALUES (0,31,1671403256519078138,'2023-09-26T18:56:02','2023-09-26T18:56:02',45,2,'502-2');
INSERT INTO `bed`(`bed_status`,`room_id`,`create_by`,`update_time`,`create_time`,`id`,`sort`,`bed_number`) VALUES (0,32,1671403256519078138,'2023-09-26T18:56:10','2023-09-26T18:56:10',46,1,'503-1');
INSERT INTO `bed`(`bed_status`,`room_id`,`create_by`,`update_time`,`create_time`,`id`,`sort`,`bed_number`) VALUES (0,33,1671403256519078138,'2023-09-26T18:56:26','2023-09-26T18:56:26',48,1,'504-1');
INSERT INTO `bed`(`bed_status`,`room_id`,`create_by`,`update_time`,`create_time`,`id`,`sort`,`bed_number`) VALUES (0,33,1671403256519078138,'2023-09-26T18:56:32','2023-09-26T18:56:32',49,2,'504-2');
INSERT INTO `bed`(`bed_status`,`room_id`,`create_by`,`update_time`,`create_time`,`id`,`sort`,`bed_number`) VALUES (0,34,1671403256519078138,'2023-09-26T18:56:37','2023-09-26T18:56:37',50,1,'505-1');
INSERT INTO `bed`(`bed_status`,`room_id`,`create_by`,`update_time`,`create_time`,`id`,`sort`,`bed_number`) VALUES (0,35,1671403256519078138,'2023-09-26T18:56:49','2023-09-26T18:56:49',52,1,'506-1');
INSERT INTO `bed`(`bed_status`,`room_id`,`create_by`,`update_time`,`create_time`,`id`,`sort`,`bed_number`) VALUES (0,35,1671403256519078138,'2023-09-26T18:56:54','2023-09-26T18:56:54',53,2,'506-2');
INSERT INTO `bed`(`bed_status`,`room_id`,`create_by`,`update_time`,`create_time`,`id`,`sort`,`bed_number`) VALUES (0,36,1671403256519078138,'2023-09-26T18:57','2023-09-26T18:57',54,1,'507-1');
INSERT INTO `bed`(`bed_status`,`room_id`,`create_by`,`update_time`,`create_time`,`id`,`sort`,`bed_number`,`update_by`) VALUES (0,37,1671403256519078138,'2023-09-28T22:53:28','2023-09-26T19:05:11',55,1,'601-1',1671403256519078164);
INSERT INTO `bed`(`bed_status`,`room_id`,`create_by`,`update_time`,`create_time`,`id`,`sort`,`bed_number`) VALUES (0,38,1671403256519078138,'2023-09-26T19:05:16','2023-09-26T19:05:16',56,1,'602-1');
INSERT INTO `bed`(`bed_status`,`room_id`,`create_by`,`update_time`,`create_time`,`id`,`sort`,`bed_number`) VALUES (0,38,1671403256519078138,'2023-09-26T19:05:24','2023-09-26T19:05:24',57,2,'602-2');
INSERT INTO `bed`(`bed_status`,`room_id`,`create_by`,`update_time`,`create_time`,`id`,`sort`,`bed_number`) VALUES (0,39,1671403256519078138,'2023-09-26T19:05:29','2023-09-26T19:05:29',58,1,'603-1');
INSERT INTO `bed`(`bed_status`,`room_id`,`create_by`,`update_time`,`create_time`,`id`,`sort`,`bed_number`) VALUES (0,40,1671403256519078138,'2023-09-26T19:05:33','2023-09-26T19:05:33',59,1,'604-1');
INSERT INTO `bed`(`bed_status`,`room_id`,`create_by`,`update_time`,`create_time`,`id`,`sort`,`bed_number`) VALUES (0,40,1671403256519078138,'2023-09-26T19:05:38','2023-09-26T19:05:38',60,2,'604-2');
INSERT INTO `bed`(`bed_status`,`room_id`,`create_by`,`update_time`,`create_time`,`id`,`sort`,`bed_number`) VALUES (0,41,1671403256519078138,'2023-09-26T19:05:43','2023-09-26T19:05:43',61,1,'605-1');
INSERT INTO `bed`(`bed_status`,`room_id`,`create_by`,`update_time`,`create_time`,`id`,`sort`,`bed_number`) VALUES (0,42,1671403256519078138,'2023-09-26T19:05:48','2023-09-26T19:05:48',62,1,'606-1');
INSERT INTO `bed`(`bed_status`,`room_id`,`create_by`,`update_time`,`create_time`,`id`,`sort`,`bed_number`) VALUES (0,42,1671403256519078138,'2023-09-26T19:05:54','2023-09-26T19:05:54',63,2,'606-2');
INSERT INTO `bed`(`bed_status`,`room_id`,`create_by`,`update_time`,`create_time`,`id`,`sort`,`bed_number`) VALUES (0,43,1671403256519078138,'2023-09-26T19:05:59','2023-09-26T19:05:59',64,1,'607-1');
INSERT INTO `bed`(`bed_status`,`room_id`,`create_by`,`update_time`,`create_time`,`id`,`sort`,`bed_number`) VALUES (0,44,1671403256519078138,'2023-09-26T19:06:10','2023-09-26T19:06:10',65,1,'701-1');
INSERT INTO `bed`(`bed_status`,`room_id`,`create_by`,`update_time`,`create_time`,`id`,`sort`,`bed_number`,`update_by`) VALUES (0,45,1671403256519078138,'2023-09-26T19:06:26','2023-09-26T19:06:14',66,1,'702-1',1671403256519078138);
INSERT INTO `bed`(`bed_status`,`room_id`,`create_by`,`update_time`,`create_time`,`id`,`sort`,`bed_number`) VALUES (0,45,1671403256519078138,'2023-09-26T19:06:35','2023-09-26T19:06:35',68,2,'702-2');
INSERT INTO `bed`(`bed_status`,`room_id`,`create_by`,`update_time`,`create_time`,`id`,`sort`,`bed_number`) VALUES (0,46,1671403256519078138,'2023-09-26T19:06:41','2023-09-26T19:06:41',69,1,'703-1');
INSERT INTO `bed`(`bed_status`,`room_id`,`create_by`,`update_time`,`create_time`,`id`,`sort`,`bed_number`,`update_by`) VALUES (0,47,1671403256519078138,'2023-12-20T14:28:22','2023-09-26T19:06:46',70,1,'704-1',1671403256519078138);
INSERT INTO `bed`(`bed_status`,`room_id`,`create_by`,`update_time`,`create_time`,`id`,`sort`,`bed_number`,`update_by`) VALUES (0,47,1671403256519078138,'2023-09-26T19:06:57','2023-09-26T19:06:52',71,2,'704-2',1671403256519078138);
INSERT INTO `bed`(`bed_status`,`room_id`,`create_by`,`update_time`,`create_time`,`id`,`sort`,`bed_number`) VALUES (0,48,1671403256519078138,'2023-09-26T19:07:04','2023-09-26T19:07:04',72,1,'705-1');
INSERT INTO `bed`(`bed_status`,`room_id`,`create_by`,`update_time`,`create_time`,`id`,`sort`,`bed_number`) VALUES (0,49,1671403256519078138,'2023-09-26T19:07:10','2023-09-26T19:07:10',73,1,'706-1');
INSERT INTO `bed`(`bed_status`,`room_id`,`create_by`,`update_time`,`create_time`,`id`,`sort`,`bed_number`,`update_by`) VALUES (0,49,1671403256519078138,'2023-09-26T19:07:19','2023-09-26T19:07:14',74,2,'706-2',1671403256519078138);
INSERT INTO `bed`(`bed_status`,`room_id`,`create_by`,`update_time`,`create_time`,`id`,`sort`,`bed_number`) VALUES (0,50,1671403256519078138,'2023-09-26T19:07:25','2023-09-26T19:07:25',75,1,'707-1');
INSERT INTO `bed`(`bed_status`,`room_id`,`create_by`,`update_time`,`create_time`,`id`,`sort`,`bed_number`) VALUES (0,51,1671403256519078138,'2023-09-26T19:07:41','2023-09-26T19:07:41',76,1,'801-1');
INSERT INTO `bed`(`bed_status`,`room_id`,`create_by`,`update_time`,`create_time`,`id`,`sort`,`bed_number`) VALUES (0,53,1671403256519078138,'2023-09-26T19:07:46','2023-09-26T19:07:46',77,1,'803-1');
INSERT INTO `bed`(`bed_status`,`room_id`,`create_by`,`update_time`,`create_time`,`id`,`sort`,`bed_number`) VALUES (0,55,1671403256519078138,'2023-09-26T19:07:51','2023-09-26T19:07:51',78,1,'805-1');
INSERT INTO `bed`(`bed_status`,`room_id`,`create_by`,`update_time`,`create_time`,`id`,`sort`,`bed_number`,`update_by`) VALUES (0,57,1671403256519078138,'2023-09-26T19:07:56','2023-09-26T19:07:56',79,1,'807-1',1);
INSERT INTO `bed`(`bed_status`,`room_id`,`create_by`,`update_time`,`create_time`,`id`,`sort`,`bed_number`) VALUES (0,52,1671403256519078138,'2023-09-26T19:08:04','2023-09-26T19:08:04',80,1,'802-1');
INSERT INTO `bed`(`bed_status`,`room_id`,`create_by`,`update_time`,`create_time`,`id`,`sort`,`bed_number`) VALUES (0,52,1671403256519078138,'2023-09-26T19:08:09','2023-09-26T19:08:09',81,2,'801-2');
INSERT INTO `bed`(`bed_status`,`room_id`,`create_by`,`update_time`,`create_time`,`id`,`sort`,`bed_number`) VALUES (0,54,1671403256519078138,'2023-09-26T19:08:15','2023-09-26T19:08:15',82,1,'804-1');
INSERT INTO `bed`(`bed_status`,`room_id`,`create_by`,`update_time`,`create_time`,`id`,`sort`,`bed_number`) VALUES (0,54,1671403256519078138,'2023-09-26T19:08:22','2023-09-26T19:08:22',83,2,'804-2');
INSERT INTO `bed`(`bed_status`,`room_id`,`create_by`,`update_time`,`create_time`,`id`,`sort`,`bed_number`) VALUES (0,56,1671403256519078138,'2023-09-26T19:08:28','2023-09-26T19:08:28',84,1,'806-1');
INSERT INTO `bed`(`bed_status`,`room_id`,`create_by`,`update_time`,`create_time`,`id`,`sort`,`bed_number`,`update_by`) VALUES (0,56,1671403256519078138,'2023-09-26T19:08:35','2023-09-26T19:08:35',85,2,'806-2',1);
INSERT INTO `bed`(`bed_status`,`room_id`,`create_by`,`update_time`,`create_time`,`id`,`sort`,`bed_number`,`update_by`) VALUES (1,1,1671403256519078138,'2025-04-20T17:13:18','2023-12-21T11:45:09',170,2,'101-2',1);
INSERT INTO `bed`(`bed_status`,`room_id`,`create_by`,`update_time`,`create_time`,`id`,`sort`,`bed_number`,`update_by`) VALUES (0,3,1671403256519078138,'2023-12-23T16:22:03','2023-12-23T16:12:34',171,1,'103-2',1671403256519078138);
INSERT INTO `bed`(`bed_status`,`room_id`,`create_by`,`update_time`,`create_time`,`id`,`sort`,`bed_number`) VALUES (0,74,1671403256519078138,'2023-12-26T19:32:07','2023-12-26T19:32:07',177,1,'1011');
INSERT INTO `bed`(`bed_status`,`room_id`,`create_by`,`update_time`,`create_time`,`id`,`sort`,`bed_number`) VALUES (0,74,1671403256519078138,'2023-12-26T19:32:15','2023-12-26T19:32:15',178,1,'101');
INSERT INTO `bed`(`bed_status`,`room_id`,`create_by`,`update_time`,`create_time`,`id`,`sort`,`bed_number`,`update_by`) VALUES (0,7,1,'2026-03-17T10:30:44','2026-03-09T15:34:44',200,1,'107-2',1);
INSERT INTO `bed`(`room_id`,`create_by`,`create_time`,`id`,`sort`,`bed_number`) VALUES (143,1,'2026-04-02T08:53:01',210,1,'901-1');
INSERT INTO `bed`(`room_id`,`create_by`,`create_time`,`id`,`sort`,`bed_number`) VALUES (143,1,'2026-04-02T08:53:07',211,1,'901-2');

####################
##  check_in
####################
DROP TABLE IF EXISTS `check_in`;

####################
##  table check_in ddl
####################
CREATE TABLE `check_in` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `elder_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '老人姓名',
  `elder_id` bigint NOT NULL COMMENT '老人ID',
  `id_card_no` char(18) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '身份证号',
  `start_date` date NOT NULL COMMENT '入住开始时间',
  `end_date` date DEFAULT NULL COMMENT '入住结束时间',
  `nursing_level_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '护理等级名称',
  `bed_number` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '入住床位',
  `status` tinyint NOT NULL DEFAULT '0' COMMENT '状态 (0: 已入住, 1: 已退住)',
  `sort_order` int NOT NULL DEFAULT '0' COMMENT '排序编号',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '修改时间',
  `create_by` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '创建人',
  `update_by` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '修改人',
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

####################
##  check_in data
####################

####################
##  check_in data
####################
INSERT INTO `check_in`(`end_date`,`id_card_no`,`nursing_level_name`,`create_time`,`remark`,`elder_id`,`create_by`,`elder_name`,`id`,`bed_number`,`sort_order`,`start_date`,`status`) VALUES ('2026-05-31','132123195912161234','二级护理等级','2026-04-02 16:43:06.0','[{"name":"张苞","phone":"13211112222","kinship":"0"}]',93,'1','张飞',6,'101-1',0,'2026-04-02',0);
INSERT INTO `check_in`(`end_date`,`id_card_no`,`nursing_level_name`,`create_time`,`remark`,`elder_id`,`create_by`,`elder_name`,`id`,`bed_number`,`sort_order`,`start_date`,`status`) VALUES ('2026-05-31','132123195612191256','二级护理等级','2026-04-06 18:01:11.0','[{"name":"刘禅","phone":"13211122334","kinship":"0"}]',94,'1','刘备',7,'101-2',0,'2026-04-06',0);
INSERT INTO `check_in`(`end_date`,`id_card_no`,`nursing_level_name`,`create_time`,`remark`,`elder_id`,`create_by`,`elder_name`,`id`,`bed_number`,`sort_order`,`start_date`,`status`) VALUES ('2026-05-31','132123195601021234','三级护理等级','2026-04-06 18:02:46.0','[{"name":"关兴","phone":"15544332211","kinship":"0"}]',95,'1','关羽',8,'102-1',0,'2026-04-06',0);
INSERT INTO `check_in`(`end_date`,`id_card_no`,`nursing_level_name`,`create_time`,`remark`,`elder_id`,`create_by`,`elder_name`,`id`,`bed_number`,`sort_order`,`start_date`,`status`) VALUES ('2026-05-29','132122194512131234','二级护理等级','2026-04-09 08:49:38.0','[{"name":"李小","phone":"13433332222","kinship":"0"}]',96,'1','李晓',9,'202-1',0,'2026-04-09',0);


####################
##  check_in_config
####################
DROP TABLE IF EXISTS `check_in_config`;

####################
##  table check_in_config ddl
####################
CREATE TABLE `check_in_config` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `check_in_id` bigint NOT NULL COMMENT '入住表ID',
  `nursing_level_id` bigint NOT NULL COMMENT '护理等级ID',
  `nursing_level_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '护理等级名称',
  `fee_start_date` date NOT NULL COMMENT '费用开始时间',
  `fee_end_date` date DEFAULT NULL COMMENT '费用结束时间',
  `deposit` decimal(10,2) NOT NULL COMMENT '押金（元）',
  `nursing_fee` decimal(10,2) NOT NULL COMMENT '护理费用（元/月）',
  `bed_fee` decimal(10,2) NOT NULL COMMENT '床位费用（元/月）',
  `insurance_payment` decimal(10,2) NOT NULL COMMENT '医保支付（元/月）',
  `government_subsidy` decimal(10,2) NOT NULL COMMENT '政府补贴（元/月）',
  `other_fees` decimal(10,2) NOT NULL COMMENT '其他费用（元/月）',
  `sort_order` int NOT NULL DEFAULT '0' COMMENT '排序编号',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '修改时间',
  `create_by` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '创建人',
  `update_by` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '修改人',
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

####################
##  check_in_config data
####################

####################
##  check_in_config data
####################
INSERT INTO `check_in_config`(`other_fees`,`nursing_level_id`,`bed_fee`,`nursing_level_name`,`create_time`,`insurance_payment`,`nursing_fee`,`create_by`,`check_in_id`,`fee_end_date`,`deposit`,`id`,`fee_start_date`,`sort_order`,`government_subsidy`) VALUES ('0.00',80,'4500.00','二级护理等级','2026-04-02 16:43:06.0','0.00','1500.00','1',6,'2026-04-30','3000.00',2,'2026-04-02',0,'0.00');
INSERT INTO `check_in_config`(`other_fees`,`nursing_level_id`,`bed_fee`,`nursing_level_name`,`create_time`,`insurance_payment`,`nursing_fee`,`create_by`,`check_in_id`,`fee_end_date`,`deposit`,`id`,`fee_start_date`,`sort_order`,`government_subsidy`) VALUES ('0.00',80,'4500.00','二级护理等级','2026-04-06 18:01:11.0','0.00','1500.00','1',7,'2026-04-30','3000.00',3,'2026-04-06',0,'0.00');
INSERT INTO `check_in_config`(`other_fees`,`nursing_level_id`,`bed_fee`,`nursing_level_name`,`create_time`,`insurance_payment`,`nursing_fee`,`create_by`,`check_in_id`,`fee_end_date`,`deposit`,`id`,`fee_start_date`,`sort_order`,`government_subsidy`) VALUES ('0.00',81,'4500.00','三级护理等级','2026-04-06 18:02:46.0','0.00','1200.00','1',8,'2026-04-30','3000.00',4,'2026-04-06',0,'0.00');
INSERT INTO `check_in_config`(`other_fees`,`nursing_level_id`,`bed_fee`,`nursing_level_name`,`create_time`,`insurance_payment`,`nursing_fee`,`create_by`,`check_in_id`,`fee_end_date`,`deposit`,`id`,`fee_start_date`,`sort_order`,`government_subsidy`) VALUES ('0.00',80,'3000.00','二级护理等级','2026-04-09 08:49:38.0','0.00','1500.00','1',9,'2026-04-23','3000.00',5,'2026-04-09',0,'0.00');

####################
##  contract
####################
DROP TABLE IF EXISTS `contract`;

####################
##  table contract ddl
####################
CREATE TABLE `contract` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `elder_id` int NOT NULL COMMENT '老人ID',
  `contract_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '合同名称',
  `contract_number` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '合同编号',
  `agreement_path` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '协议地址（文件路径或URL）',
  `third_party_phone` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '丙方手机号',
  `third_party_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '丙方姓名',
  `elder_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '老人姓名',
  `start_date` date NOT NULL COMMENT '开始时间',
  `end_date` date NOT NULL COMMENT '结束时间',
  `status` tinyint NOT NULL DEFAULT '0' COMMENT '状态 (0: 未生效, 1: 已生效, 2: 已过期, 3: 已失效)',
  `sign_date` date NOT NULL COMMENT '签约日期',
  `termination_submitter` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '解除提交人',
  `termination_date` date DEFAULT NULL COMMENT '解除日期',
  `termination_agreement_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '解除协议地址（文件路径或URL）',
  `sort_order` int NOT NULL DEFAULT '0' COMMENT '排序编号',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '修改时间',
  `create_by` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '创建人',
  `update_by` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '修改人',
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

####################
##  contract data
####################

####################
##  contract data
####################
INSERT INTO `contract`(`end_date`,`agreement_path`,`create_time`,`sign_date`,`contract_name`,`elder_id`,`create_by`,`update_time`,`contract_number`,`third_party_phone`,`elder_name`,`id`,`third_party_name`,`sort_order`,`start_date`,`status`) VALUES ('2026-05-31','https://hm-xhzb.oss-cn-beijing.aliyuncs.com/fc30a42a-c577-4480-8581-78c055609341.pdf','2026-04-02 16:43:06.0','2026-04-02','张飞的入住合同',93,'1','2026-04-04 09:43:48.0','HT202604021643050001','13211112222','张飞',9,'张苞',0,'2026-04-02',1);
INSERT INTO `contract`(`end_date`,`agreement_path`,`create_time`,`sign_date`,`contract_name`,`elder_id`,`create_by`,`contract_number`,`third_party_phone`,`elder_name`,`id`,`third_party_name`,`sort_order`,`start_date`,`status`) VALUES ('2026-05-31','https://hm-xhzb.oss-cn-beijing.aliyuncs.com/740bc494-5942-4c01-b968-293bf21579a9.pdf','2026-04-06 18:01:11.0','2026-04-06','刘备的入住合同',94,'1','HT202604061801100001','13211122334','刘备',10,'刘禅',0,'2026-04-06',1);
INSERT INTO `contract`(`end_date`,`agreement_path`,`create_time`,`sign_date`,`contract_name`,`elder_id`,`create_by`,`contract_number`,`third_party_phone`,`elder_name`,`id`,`third_party_name`,`sort_order`,`start_date`,`status`) VALUES ('2026-05-31','https://hm-xhzb.oss-cn-beijing.aliyuncs.com/47811635-067e-4c21-9d33-9e614fca5b9d.pdf','2026-04-06 18:02:46.0','2026-04-06','关羽的入住合同',95,'1','HT202604061802450002','15544332211','关羽',11,'关兴',0,'2026-04-06',1);
INSERT INTO `contract`(`end_date`,`agreement_path`,`create_time`,`sign_date`,`contract_name`,`elder_id`,`create_by`,`contract_number`,`third_party_phone`,`elder_name`,`id`,`third_party_name`,`sort_order`,`start_date`,`status`) VALUES ('2026-05-29','https://hm-xhzb.oss-cn-beijing.aliyuncs.com/109c6639-3551-4fa6-b2dd-9b3de4fe698f.pdf','2026-04-09 08:49:38.0','2026-04-09','李晓的入住合同',96,'1','HT202604090849370001','13433332222','李晓',12,'李小',0,'2026-04-09',1);

####################
##  device
####################
DROP TABLE IF EXISTS `device`;

####################
##  table device ddl
####################
CREATE TABLE `device` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `iot_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '物联网设备ID',
  `secret` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '设备秘钥',
  `binding_location` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '绑定位置',
  `location_type` int DEFAULT NULL COMMENT '位置类型 0：随身设备 1：固定设备',
  `physical_location_type` int DEFAULT NULL COMMENT '物理位置类型 0楼层 1房间 2床位',
  `device_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '设备名称',
  `product_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '产品key',
  `product_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '产品名称',
  `device_description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '位置备注',
  `have_entrance_guard` int NOT NULL DEFAULT '0' COMMENT '产品是否包含门禁，0：否，1：是',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `create_by` bigint DEFAULT NULL COMMENT '创建人id',
  `node_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '节点id',
  `update_by` bigint DEFAULT NULL COMMENT '更新人id',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `binding_location_location_type_physical_location_type_product_id` (`binding_location`,`location_type`,`physical_location_type`,`product_key`) USING BTREE,
  KEY `device_id` (`iot_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

####################
##  device data
####################

####################
##  device data
####################

####################
##  device_data
####################
DROP TABLE IF EXISTS `device_data`;

####################
##  table device_data ddl
####################
CREATE TABLE `device_data` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '告警规则ID，自增主键',
  `device_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '设备名称',
  `iot_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '设备ID',
  `product_key` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '所属产品的key',
  `product_name` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '产品名称',
  `function_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '功能名称',
  `access_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '接入位置',
  `location_type` int DEFAULT NULL COMMENT '位置类型 0：随身设备 1：固定设备',
  `physical_location_type` int DEFAULT NULL COMMENT '物理位置类型 0楼层 1房间 2床位',
  `device_description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '位置备注',
  `data_value` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '数据值',
  `alarm_time` datetime DEFAULT NULL COMMENT '数据上报时间',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `create_by` bigint DEFAULT NULL COMMENT '创建人id',
  `update_by` bigint DEFAULT NULL COMMENT '更新人id',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_iot_id_function_id` (`iot_id`,`function_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

####################
##  device_data data
####################

####################
##  device_data data
####################

####################
##  elder
####################
DROP TABLE IF EXISTS `elder`;

####################
##  table elder ddl
####################
CREATE TABLE `elder` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '名称',
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '头像',
  `id_card_no` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '身份证号',
  `sex` int DEFAULT NULL COMMENT '性别（0:女  1:男）',
  `status` int NOT NULL DEFAULT '1' COMMENT '状态（0:禁用，1:已入住 2:请假 3:已退住）',
  `phone` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '手机号',
  `birthday` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '出生日期',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '家庭住址',
  `id_card_national_emblem_img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '身份证国徽面',
  `id_card_portrait_img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '身份证人像面',
  `bed_number` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '床位编号',
  `bed_id` bigint DEFAULT NULL COMMENT '床位id',
  `nation` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '民族',
  `education_level` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '文化程度',
  `social_security_card` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '社保卡号',
  `living_situation` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '居住情况',
  `religious_belief` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '宗教信仰',
  `economic_source` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '经济来源',
  `marital_status` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '婚姻状况',
  `medical_payment_method` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '医疗费用支付方式',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `create_by` bigint DEFAULT NULL COMMENT '创建人id',
  `update_by` bigint DEFAULT NULL COMMENT '更新人id',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '备注',
  `core_suggestion` varchar(50) DEFAULT NULL COMMENT '核心建议',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `name_id_card_no` (`name`,`id_card_no`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=97 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='老人表';

####################
##  elder data
####################

####################
##  elder data
####################
INSERT INTO `elder`(`birthday`,`id_card_no`,`nation`,`social_security_card`,`create_by`,`core_suggestion`,`living_situation`,`id`,`id_card_portrait_img`,`bed_number`,`bed_id`,`image`,`address`,`create_time`,`sex`,`economic_source`,`religious_belief`,`medical_payment_method`,`marital_status`,`phone`,`id_card_national_emblem_img`,`name`,`education_level`,`status`) VALUES ('1959-12-16','132123195912161234','汉族','66667777',1,'建议入住','与配偶/伴侣居住',93,'https://hm-xhzb.oss-cn-beijing.aliyuncs.com/bdc0949e-7a8d-41d7-b404-83ae62e21420.jpg','101-1',1,'https://hm-xhzb.oss-cn-beijing.aliyuncs.com/6af9db14-45c7-4dea-b0be-6b3d541ffaba.png','北京金燕龙','2026-04-02T16:43:06',0,'子女补贴','无','城镇居民基本医疗保险','已婚','15877776666','https://hm-xhzb.oss-cn-beijing.aliyuncs.com/ba5f343e-4730-49b1-8855-ad3710a74a2d.jpg','张飞','小学',1);
INSERT INTO `elder`(`birthday`,`id_card_no`,`nation`,`social_security_card`,`create_by`,`core_suggestion`,`living_situation`,`id`,`id_card_portrait_img`,`bed_number`,`bed_id`,`image`,`address`,`create_time`,`sex`,`economic_source`,`religious_belief`,`medical_payment_method`,`marital_status`,`phone`,`id_card_national_emblem_img`,`name`,`education_level`,`status`) VALUES ('1956-12-19','132123195612191256','汉族','888666',1,'建议入住','独居',94,'https://hm-xhzb.oss-cn-beijing.aliyuncs.com/dd906ce0-fd96-4faa-a9a2-af74e8724c48.jpg','101-2',170,'https://hm-xhzb.oss-cn-beijing.aliyuncs.com/c8a86ca0-ba3a-4675-80d2-d98323203fe8.png','河北','2026-04-06T18:01:11',0,'其他补贴','无','全自费','已婚','15566676655','https://hm-xhzb.oss-cn-beijing.aliyuncs.com/d700ff97-2a07-41de-b370-85fae4c11cc9.jpg','刘备','小学',1);
INSERT INTO `elder`(`birthday`,`id_card_no`,`nation`,`social_security_card`,`create_by`,`core_suggestion`,`living_situation`,`id`,`id_card_portrait_img`,`bed_number`,`bed_id`,`image`,`address`,`create_time`,`sex`,`economic_source`,`religious_belief`,`medical_payment_method`,`marital_status`,`phone`,`id_card_national_emblem_img`,`name`,`education_level`,`status`) VALUES ('1956-01-02','132123195601021234','汉族','88887777',1,'建议入住','独居',95,'https://hm-xhzb.oss-cn-beijing.aliyuncs.com/a4c59058-59ae-434b-a11e-ddbfefe08497.jpg','102-1',2,'https://hm-xhzb.oss-cn-beijing.aliyuncs.com/ada6ac8d-490e-4693-b154-4d0c691986ee.png','山西','2026-04-06T18:02:46',0,'子女补贴','无','贫困救助','已婚','15677778888','https://hm-xhzb.oss-cn-beijing.aliyuncs.com/769f99f2-6ff2-42f1-964d-785ca10cd5b2.jpg','关羽','小学',1);
INSERT INTO `elder`(`birthday`,`id_card_no`,`nation`,`social_security_card`,`create_by`,`core_suggestion`,`living_situation`,`id`,`id_card_portrait_img`,`bed_number`,`bed_id`,`image`,`address`,`create_time`,`sex`,`economic_source`,`religious_belief`,`medical_payment_method`,`marital_status`,`phone`,`id_card_national_emblem_img`,`name`,`education_level`,`status`) VALUES ('1945-12-13','132122194512131234','汉族','8888',1,'建议入住','独居',96,'https://hm-xhzb.oss-cn-beijing.aliyuncs.com/4a2cd319-0b2e-4823-90a6-4d30b3010ce8.jpg','202-1',12,'https://hm-xhzb.oss-cn-beijing.aliyuncs.com/60a2099b-dae3-4e99-8634-0c2d4d2c3519.png','大幅度','2026-04-09T08:49:38',0,'子女补贴','无','城镇居民基本医疗保险','已婚','13455555666','https://hm-xhzb.oss-cn-beijing.aliyuncs.com/97799219-a840-419f-a1f4-1eec8010c320.jpg','李晓','初中',1);

####################
##  family_member
####################
DROP TABLE IF EXISTS `family_member`;

####################
##  table family_member ddl
####################
CREATE TABLE `family_member` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '手机号',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '名称',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '头像',
  `open_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'OpenID',
  `gender` int DEFAULT NULL COMMENT '性别(0:男，1:女)',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_by` bigint DEFAULT NULL COMMENT '创建人',
  `update_by` bigint DEFAULT NULL COMMENT '更新人',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='老人家属';

####################
##  family_member data
####################

####################
##  family_member data
####################
INSERT INTO `family_member`(`update_time`,`create_time`,`phone`,`open_id`,`name`,`id`) VALUES ('2026-04-06 07:57:00.0','2026-04-06 15:57:01.0','13080445662','oTEhE3UXIuvlxzREysQnLRaGZMGo','大桔大利5662',2);

####################
##  family_member_elder
####################
DROP TABLE IF EXISTS `family_member_elder`;

####################
##  table family_member_elder ddl
####################
CREATE TABLE `family_member_elder` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `family_member_id` bigint DEFAULT NULL COMMENT '家属id',
  `elder_id` bigint DEFAULT NULL COMMENT '老人id',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `create_by` bigint DEFAULT NULL COMMENT '创建人id',
  `update_by` bigint DEFAULT NULL COMMENT '更新人id',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `member_id_elder_id` (`family_member_id`,`elder_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='客户老人关联表';

####################
##  family_member_elder data
####################

####################
##  family_member_elder data
####################

####################
##  floor
####################
DROP TABLE IF EXISTS `floor`;

####################
##  table floor ddl
####################
CREATE TABLE `floor` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '名称',
  `code` bigint DEFAULT NULL COMMENT '编号',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `create_by` bigint DEFAULT NULL COMMENT '创建人id',
  `update_by` bigint DEFAULT NULL COMMENT '更新人id',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `name` (`name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=426 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='楼层表';

####################
##  floor data
####################

####################
##  floor data
####################
INSERT INTO `floor`(`create_by`,`update_time`,`code`,`create_time`,`name`,`id`,`update_by`) VALUES (1671403256519078153,'2026-03-21T13:11:36',1,'2023-09-26T16:10:27','1楼',1,1);
INSERT INTO `floor`(`create_by`,`update_time`,`code`,`create_time`,`name`,`id`) VALUES (1671403256519078138,'2023-09-26T17:37:20',2,'2023-09-26T17:37:20','2楼',2);
INSERT INTO `floor`(`create_by`,`update_time`,`code`,`create_time`,`name`,`id`) VALUES (1671403256519078138,'2023-09-26T17:37:26',3,'2023-09-26T17:37:26','3楼',3);
INSERT INTO `floor`(`create_by`,`update_time`,`code`,`create_time`,`name`,`id`) VALUES (1671403256519078138,'2023-09-26T17:37:32',4,'2023-09-26T17:37:32','4楼',4);
INSERT INTO `floor`(`create_by`,`update_time`,`code`,`create_time`,`name`,`id`) VALUES (1671403256519078138,'2023-09-26T17:37:38',5,'2023-09-26T17:37:38','5楼',5);
INSERT INTO `floor`(`create_by`,`update_time`,`code`,`create_time`,`name`,`id`,`update_by`) VALUES (1671403256519078138,'2023-09-26T17:37:59',6,'2023-09-26T17:37:42','6楼',6,1671403256519078138);
INSERT INTO `floor`(`create_by`,`update_time`,`code`,`create_time`,`name`,`id`,`update_by`) VALUES (1671403256519078138,'2023-09-26T17:37:52',7,'2023-09-26T17:37:47','7楼',7,1671403256519078138);
INSERT INTO `floor`(`create_by`,`update_time`,`code`,`create_time`,`name`,`id`) VALUES (1671403256519078138,'2023-09-26T17:38:09',8,'2023-09-26T17:38:09','8楼',8);
INSERT INTO `floor`(`create_by`,`update_time`,`code`,`create_time`,`name`,`id`) VALUES (1671403256519078138,'2023-12-18T14:53:50',8,'2023-12-18T14:53:50','9楼',391);
INSERT INTO `floor`(`create_by`,`update_time`,`code`,`create_time`,`name`,`id`,`update_by`) VALUES (1671403256519078138,'2023-12-27T10:15:34',9,'2023-12-26T19:29:54','10楼',401,1671403256519078138);

####################
##  gen_table
####################
DROP TABLE IF EXISTS `gen_table`;

####################
##  table gen_table ddl
####################
CREATE TABLE `gen_table` (
  `table_id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '表名称',
  `table_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '表描述',
  `sub_table_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '关联子表的表名',
  `sub_table_fk_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '子表关联的外键名',
  `class_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '实体类名称',
  `tpl_category` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT 'crud' COMMENT '使用的模板（crud单表操作 tree树表操作）',
  `tpl_web_type` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '前端模板类型（element-ui模版 element-plus模版）',
  `package_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '生成包路径',
  `module_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '生成模块名',
  `business_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '生成业务名',
  `function_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '生成功能名',
  `function_author` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '生成功能作者',
  `gen_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '生成代码方式（0zip压缩包 1自定义路径）',
  `gen_path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '/' COMMENT '生成路径（不填默认项目路径）',
  `options` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '其它生成选项',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`table_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='代码生成业务表';

####################
##  gen_table data
####################

####################
##  gen_table data
####################
INSERT INTO `gen_table`(`business_name`,`table_comment`,`create_time`,`function_author`,`gen_path`,`table_id`,`table_name`,`tpl_web_type`,`create_by`,`update_time`,`function_name`,`package_name`,`options`,`module_name`,`update_by`,`class_name`,`tpl_category`,`gen_type`) VALUES ('alertData','报警数据','2026-04-10T02:15:57','ruoyi','/',58,'alert_data','element-plus','admin','2026-04-10T02:16:50','报警数据','com.xhzb.nursing','{`parentMenuId`:``}','nursing','','AlertData','crud','0');

####################
##  gen_table_column
####################
DROP TABLE IF EXISTS `gen_table_column`;

####################
##  table gen_table_column ddl
####################
CREATE TABLE `gen_table_column` (
  `column_id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_id` bigint DEFAULT NULL COMMENT '归属表编号',
  `column_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '列名称',
  `column_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '列描述',
  `column_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '列类型',
  `java_type` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'JAVA类型',
  `java_field` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'JAVA字段名',
  `is_pk` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '是否主键（1是）',
  `is_increment` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '是否自增（1是）',
  `is_required` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '是否必填（1是）',
  `is_insert` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '是否为插入字段（1是）',
  `is_edit` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '是否编辑字段（1是）',
  `is_list` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '是否列表字段（1是）',
  `is_query` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '是否查询字段（1是）',
  `query_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT 'EQ' COMMENT '查询方式（等于、不等于、大于、小于、范围）',
  `html_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',
  `dict_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '字典类型',
  `sort` int DEFAULT NULL COMMENT '排序',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`column_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=949 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='代码生成业务表字段';

####################
##  gen_table_column data
####################

####################
##  gen_table_column data
####################
INSERT INTO `gen_table_column`(`dict_type`,`create_time`,`column_name`,`java_type`,`query_type`,`sort`,`table_id`,`is_pk`,`column_id`,`create_by`,`update_time`,`java_field`,`is_required`,`is_insert`,`html_type`,`column_comment`,`is_increment`,`column_type`,`update_by`) VALUES ('','2026-04-10T02:15:57','id','Long','EQ',1,58,'1',924,'admin','2026-04-10T02:16:50','id','0','1','input','主键','1','bigint','');
INSERT INTO `gen_table_column`(`is_query`,`dict_type`,`create_time`,`column_name`,`java_type`,`is_edit`,`is_list`,`query_type`,`sort`,`table_id`,`is_pk`,`column_id`,`create_by`,`update_time`,`java_field`,`is_required`,`is_insert`,`html_type`,`column_comment`,`is_increment`,`column_type`,`update_by`) VALUES ('1','','2026-04-10T02:15:57','iot_id','String','1','1','EQ',2,58,'0',925,'admin','2026-04-10T02:16:50','iotId','1','1','input','物联网设备id','0','varchar(50)','');
INSERT INTO `gen_table_column`(`is_query`,`dict_type`,`create_time`,`column_name`,`java_type`,`is_edit`,`is_list`,`query_type`,`sort`,`table_id`,`is_pk`,`column_id`,`create_by`,`update_time`,`java_field`,`is_required`,`is_insert`,`html_type`,`column_comment`,`is_increment`,`column_type`,`update_by`) VALUES ('1','','2026-04-10T02:15:57','device_name','String','1','1','LIKE',3,58,'0',926,'admin','2026-04-10T02:16:50','deviceName','0','1','input','设备名称','0','varchar(50)','');
INSERT INTO `gen_table_column`(`is_query`,`dict_type`,`create_time`,`column_name`,`java_type`,`is_edit`,`is_list`,`query_type`,`sort`,`table_id`,`is_pk`,`column_id`,`create_by`,`update_time`,`java_field`,`is_required`,`is_insert`,`html_type`,`column_comment`,`is_increment`,`column_type`,`update_by`) VALUES ('1','','2026-04-10T02:15:57','product_key','String','1','1','EQ',4,58,'0',927,'admin','2026-04-10T02:16:50','productKey','1','1','input','所属产品key','0','varchar(50)','');
INSERT INTO `gen_table_column`(`is_query`,`dict_type`,`create_time`,`column_name`,`java_type`,`is_edit`,`is_list`,`query_type`,`sort`,`table_id`,`is_pk`,`column_id`,`create_by`,`update_time`,`java_field`,`is_required`,`is_insert`,`html_type`,`column_comment`,`is_increment`,`column_type`,`update_by`) VALUES ('1','','2026-04-10T02:15:57','product_name','String','1','1','LIKE',5,58,'0',928,'admin','2026-04-10T02:16:50','productName','0','1','input','产品名称','0','varchar(50)','');
INSERT INTO `gen_table_column`(`is_query`,`dict_type`,`create_time`,`column_name`,`java_type`,`is_edit`,`is_list`,`query_type`,`sort`,`table_id`,`is_pk`,`column_id`,`create_by`,`update_time`,`java_field`,`is_required`,`is_insert`,`html_type`,`column_comment`,`is_increment`,`column_type`,`update_by`) VALUES ('1','','2026-04-10T02:15:57','function_id','String','1','1','EQ',6,58,'0',929,'admin','2026-04-10T02:16:50','functionId','1','1','input','功能标识符','0','varchar(50)','');
INSERT INTO `gen_table_column`(`is_query`,`dict_type`,`create_time`,`column_name`,`java_type`,`is_edit`,`is_list`,`query_type`,`sort`,`table_id`,`is_pk`,`column_id`,`create_by`,`update_time`,`java_field`,`is_required`,`is_insert`,`html_type`,`column_comment`,`is_increment`,`column_type`,`update_by`) VALUES ('1','','2026-04-10T02:15:57','access_location','String','1','1','EQ',7,58,'0',930,'admin','2026-04-10T02:16:50','accessLocation','0','1','input','接入位置','0','varchar(100)','');
INSERT INTO `gen_table_column`(`is_query`,`dict_type`,`create_time`,`column_name`,`java_type`,`is_edit`,`is_list`,`query_type`,`sort`,`table_id`,`is_pk`,`column_id`,`create_by`,`update_time`,`java_field`,`is_required`,`is_insert`,`html_type`,`column_comment`,`is_increment`,`column_type`,`update_by`) VALUES ('1','','2026-04-10T02:15:57','location_type','Integer','1','1','EQ',8,58,'0',931,'admin','2026-04-10T02:16:50','locationType','0','1','select','位置类型 0：随身设备 1：固定设备','0','int','');
INSERT INTO `gen_table_column`(`is_query`,`dict_type`,`create_time`,`column_name`,`java_type`,`is_edit`,`is_list`,`query_type`,`sort`,`table_id`,`is_pk`,`column_id`,`create_by`,`update_time`,`java_field`,`is_required`,`is_insert`,`html_type`,`column_comment`,`is_increment`,`column_type`,`update_by`) VALUES ('1','','2026-04-10T02:15:57','physical_location_type','Integer','1','1','EQ',9,58,'0',932,'admin','2026-04-10T02:16:50','physicalLocationType','0','1','select','物理位置类型 0楼层 1房间 2床位','0','int','');
INSERT INTO `gen_table_column`(`is_query`,`dict_type`,`create_time`,`column_name`,`java_type`,`is_edit`,`is_list`,`query_type`,`sort`,`table_id`,`is_pk`,`column_id`,`create_by`,`update_time`,`java_field`,`is_required`,`is_insert`,`html_type`,`column_comment`,`is_increment`,`column_type`,`update_by`) VALUES ('1','','2026-04-10T02:15:57','device_description','String','1','1','EQ',10,58,'0',933,'admin','2026-04-10T02:16:50','deviceDescription','0','1','input','位置备注','0','varchar(50)','');
INSERT INTO `gen_table_column`(`is_query`,`dict_type`,`create_time`,`column_name`,`java_type`,`is_edit`,`is_list`,`query_type`,`sort`,`table_id`,`is_pk`,`column_id`,`create_by`,`update_time`,`java_field`,`is_required`,`is_insert`,`html_type`,`column_comment`,`is_increment`,`column_type`,`update_by`) VALUES ('1','','2026-04-10T02:15:57','data_value','String','1','1','EQ',11,58,'0',934,'admin','2026-04-10T02:16:50','dataValue','1','1','input','数据值','0','varchar(100)','');
INSERT INTO `gen_table_column`(`is_query`,`dict_type`,`create_time`,`column_name`,`java_type`,`is_edit`,`is_list`,`query_type`,`sort`,`table_id`,`is_pk`,`column_id`,`create_by`,`update_time`,`java_field`,`is_required`,`is_insert`,`html_type`,`column_comment`,`is_increment`,`column_type`,`update_by`) VALUES ('1','','2026-04-10T02:15:57','alert_rule_id','Long','1','1','EQ',12,58,'0',935,'admin','2026-04-10T02:16:50','alertRuleId','1','1','input','报警规则id','0','bigint','');
INSERT INTO `gen_table_column`(`is_query`,`dict_type`,`create_time`,`column_name`,`java_type`,`is_edit`,`is_list`,`query_type`,`sort`,`table_id`,`is_pk`,`column_id`,`create_by`,`update_time`,`java_field`,`is_required`,`is_insert`,`html_type`,`column_comment`,`is_increment`,`column_type`,`update_by`) VALUES ('1','','2026-04-10T02:15:57','alert_reason','String','1','1','EQ',13,58,'0',936,'admin','2026-04-10T02:16:50','alertReason','1','1','textarea','报警原因，格式：功能名称+运算符+阈值+持续周期+聚合周期','0','varchar(500)','');
INSERT INTO `gen_table_column`(`is_query`,`dict_type`,`create_time`,`column_name`,`java_type`,`is_edit`,`is_list`,`query_type`,`sort`,`table_id`,`is_pk`,`column_id`,`create_by`,`update_time`,`java_field`,`is_required`,`is_insert`,`html_type`,`column_comment`,`is_increment`,`column_type`,`update_by`) VALUES ('1','','2026-04-10T02:15:57','processing_result','String','1','1','EQ',14,58,'0',937,'admin','2026-04-10T02:16:50','processingResult','0','1','textarea','处理结果','0','varchar(500)','');
INSERT INTO `gen_table_column`(`is_query`,`dict_type`,`create_time`,`column_name`,`java_type`,`is_edit`,`is_list`,`query_type`,`sort`,`table_id`,`is_pk`,`column_id`,`create_by`,`update_time`,`java_field`,`is_required`,`is_insert`,`html_type`,`column_comment`,`is_increment`,`column_type`,`update_by`) VALUES ('1','','2026-04-10T02:15:57','processor_id','Long','1','1','EQ',15,58,'0',938,'admin','2026-04-10T02:16:50','processorId','0','1','input','处理人id','0','bigint','');
INSERT INTO `gen_table_column`(`is_query`,`dict_type`,`create_time`,`column_name`,`java_type`,`is_edit`,`is_list`,`query_type`,`sort`,`table_id`,`is_pk`,`column_id`,`create_by`,`update_time`,`java_field`,`is_required`,`is_insert`,`html_type`,`column_comment`,`is_increment`,`column_type`,`update_by`) VALUES ('1','','2026-04-10T02:15:57','processor_name','String','1','1','LIKE',16,58,'0',939,'admin','2026-04-10T02:16:50','processorName','0','1','input','处理人名称','0','varchar(50)','');
INSERT INTO `gen_table_column`(`is_query`,`dict_type`,`create_time`,`column_name`,`java_type`,`is_edit`,`is_list`,`query_type`,`sort`,`table_id`,`is_pk`,`column_id`,`create_by`,`update_time`,`java_field`,`is_required`,`is_insert`,`html_type`,`column_comment`,`is_increment`,`column_type`,`update_by`) VALUES ('1','','2026-04-10T02:15:57','processing_time','LocalDateTime','1','1','EQ',17,58,'0',940,'admin','2026-04-10T02:16:50','processingTime','0','1','datetime','处理时间','0','datetime','');
INSERT INTO `gen_table_column`(`is_query`,`dict_type`,`create_time`,`column_name`,`java_type`,`is_edit`,`is_list`,`query_type`,`sort`,`table_id`,`is_pk`,`column_id`,`create_by`,`update_time`,`java_field`,`is_required`,`is_insert`,`html_type`,`column_comment`,`is_increment`,`column_type`,`update_by`) VALUES ('1','','2026-04-10T02:15:57','type','Integer','1','1','EQ',18,58,'0',941,'admin','2026-04-10T02:16:50','type','1','1','select','报警数据类型，0：老人异常数据，1：设备异常数据','0','int','');
INSERT INTO `gen_table_column`(`is_query`,`dict_type`,`create_time`,`column_name`,`java_type`,`is_edit`,`is_list`,`query_type`,`sort`,`table_id`,`is_pk`,`column_id`,`create_by`,`update_time`,`java_field`,`is_required`,`is_insert`,`html_type`,`column_comment`,`is_increment`,`column_type`,`update_by`) VALUES ('1','','2026-04-10T02:15:57','status','Integer','1','1','EQ',19,58,'0',942,'admin','2026-04-10T02:16:50','status','1','1','radio','状态，0：待处理，1：已处理','0','int','');
INSERT INTO `gen_table_column`(`is_query`,`dict_type`,`create_time`,`column_name`,`java_type`,`is_edit`,`is_list`,`query_type`,`sort`,`table_id`,`is_pk`,`column_id`,`create_by`,`update_time`,`java_field`,`is_required`,`is_insert`,`html_type`,`column_comment`,`is_increment`,`column_type`,`update_by`) VALUES ('1','','2026-04-10T02:15:57','user_id','Long','1','1','EQ',20,58,'0',943,'admin','2026-04-10T02:16:50','userId','0','1','input','接收人id','0','bigint','');
INSERT INTO `gen_table_column`(`dict_type`,`create_time`,`column_name`,`java_type`,`query_type`,`sort`,`table_id`,`is_pk`,`column_id`,`create_by`,`update_time`,`java_field`,`is_required`,`is_insert`,`html_type`,`column_comment`,`is_increment`,`column_type`,`update_by`) VALUES ('','2026-04-10T02:15:57','create_time','Date','EQ',21,58,'0',944,'admin','2026-04-10T02:16:50','createTime','1','1','datetime','创建时间','0','datetime','');
INSERT INTO `gen_table_column`(`dict_type`,`create_time`,`column_name`,`java_type`,`is_edit`,`query_type`,`sort`,`table_id`,`is_pk`,`column_id`,`create_by`,`update_time`,`java_field`,`is_required`,`is_insert`,`html_type`,`column_comment`,`is_increment`,`column_type`,`update_by`) VALUES ('','2026-04-10T02:15:57','update_time','Date','1','EQ',22,58,'0',945,'admin','2026-04-10T02:16:50','updateTime','1','1','datetime','更新时间','0','datetime','');
INSERT INTO `gen_table_column`(`dict_type`,`create_time`,`column_name`,`java_type`,`query_type`,`sort`,`table_id`,`is_pk`,`column_id`,`create_by`,`update_time`,`java_field`,`is_required`,`is_insert`,`html_type`,`column_comment`,`is_increment`,`column_type`,`update_by`) VALUES ('','2026-04-10T02:15:57','create_by','Long','EQ',23,58,'0',946,'admin','2026-04-10T02:16:50','createBy','0','1','input','创建人id','0','bigint','');
INSERT INTO `gen_table_column`(`dict_type`,`create_time`,`column_name`,`java_type`,`is_edit`,`query_type`,`sort`,`table_id`,`is_pk`,`column_id`,`create_by`,`update_time`,`java_field`,`is_required`,`is_insert`,`html_type`,`column_comment`,`is_increment`,`column_type`,`update_by`) VALUES ('','2026-04-10T02:15:57','update_by','Long','1','EQ',24,58,'0',947,'admin','2026-04-10T02:16:50','updateBy','0','1','input','更新人id','0','bigint','');
INSERT INTO `gen_table_column`(`dict_type`,`create_time`,`column_name`,`java_type`,`is_edit`,`is_list`,`query_type`,`sort`,`table_id`,`is_pk`,`column_id`,`create_by`,`update_time`,`java_field`,`is_required`,`is_insert`,`html_type`,`column_comment`,`is_increment`,`column_type`,`update_by`) VALUES ('','2026-04-10T02:15:57','remark','String','1','1','EQ',25,58,'0',948,'admin','2026-04-10T02:16:50','remark','0','1','input','备注','0','varchar(200)','');

####################
##  health_assessment
####################
DROP TABLE IF EXISTS `health_assessment`;

####################
##  table health_assessment ddl
####################
CREATE TABLE `health_assessment` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `elder_name` varchar(50) NOT NULL COMMENT '老人姓名',
  `id_card` varchar(18) NOT NULL COMMENT '身份证号码',
  `elder_id` bigint DEFAULT NULL COMMENT '老人id',
  `core_suggestion` tinyint(1) DEFAULT NULL COMMENT '核心建议，0-不建议入住，1-建议入住',
  `check_in_status` tinyint(1) DEFAULT NULL COMMENT '入住状态：0-未入住，1-已入住',
  `evaluation_progress` tinyint(1) DEFAULT NULL COMMENT '评估进度：0-评估中，1-已完成，2-已取消',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `create_by` bigint DEFAULT NULL COMMENT '创建人id',
  `update_by` bigint DEFAULT NULL COMMENT '更新人id',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='健康评估记录表';

####################
##  health_assessment data
####################

####################
##  health_assessment data
####################
INSERT INTO `health_assessment`(`elder_id`,`create_by`,`core_suggestion`,`update_time`,`create_time`,`check_in_status`,`id_card`,`elder_name`,`id`,`evaluation_progress`,`update_by`) VALUES (96,1,true,'2026-04-01T17:29:32','2026-04-01T17:29:15',true,'132122194512131234','李晓',10,true,1);
INSERT INTO `health_assessment`(`elder_id`,`create_by`,`core_suggestion`,`update_time`,`create_time`,`check_in_status`,`id_card`,`elder_name`,`id`,`evaluation_progress`,`update_by`) VALUES (94,1,true,'2026-04-02T11:58:58','2026-04-02T11:58:38',true,'132123195612191256','刘备',11,true,1);
INSERT INTO `health_assessment`(`elder_id`,`create_by`,`core_suggestion`,`update_time`,`create_time`,`check_in_status`,`id_card`,`elder_name`,`id`,`evaluation_progress`,`update_by`) VALUES (95,1,true,'2026-04-02T12:05:45','2026-04-02T12:05:32',true,'132123195601021234','关羽',12,true,1);
INSERT INTO `health_assessment`(`elder_id`,`create_by`,`core_suggestion`,`update_time`,`create_time`,`check_in_status`,`id_card`,`elder_name`,`id`,`evaluation_progress`,`update_by`) VALUES (93,1,true,'2026-04-02T12:08:36','2026-04-02T12:08:21',true,'132123195912161234','张飞',13,true,1);

####################
##  health_assessment_data_collection
####################
DROP TABLE IF EXISTS `health_assessment_data_collection`;

####################
##  table health_assessment_data_collection ddl
####################
CREATE TABLE `health_assessment_data_collection` (
  `id` bigint NOT NULL COMMENT '主键',
  `basic_info` text COMMENT '基本信息',
  `health_assessment` text COMMENT '健康评估',
  `daily_living_activities` text COMMENT '日常生活活动',
  `mental_state` text COMMENT '精神状态',
  `perception_communication` text COMMENT '感知与沟通',
  `social_participation` text COMMENT '社会参与',
  `assessment_details` text COMMENT '详细评估报告内容',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `create_by` bigint DEFAULT NULL COMMENT '创建人id',
  `update_by` bigint DEFAULT NULL COMMENT '更新人id',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='健康评估数据采集';

####################
##  health_assessment_data_collection data
####################

####################
##  health_assessment_data_collection data
####################
INSERT INTO `health_assessment_data_collection`(`social_participation`,`perception_communication`,`basic_info`,`create_time`,`daily_living_activities`,`create_by`,`update_time`,`mental_state`,`id`,`health_assessment`,`update_by`) VALUES ('{"livingAbility":"除个人生活自理外（如饮食、洗漱、穿戴、二便），能料理家务（如做饭、洗衣）或当家管理事务","workAbility":"原来熟练的脑力工作或体力技巧性工作可照常进行","timeSpaceOrientation":"时间观念（年、月、日、时）清楚；可单独出远门，能很快掌握新环境的方位","personOrientation":"知道周围人们的关系，知道祖孙、叔伯、姑姨、侄子侄女等称谓的意义；可分辨陌生人的大致年龄和身份，可用适当称呼","socialSkills":"参与社会，在社会环境有一定的适应能力，待人接物恰当","abilityRating":"能力完好"}','{"consciousLevel":"神志清醒，对周围环境警觉","vision":"能看清楚报纸上的标准字体","hearing":"可正常交谈，能听到电视、电话、门铃的声音","communication":"无困难，能与他人正常沟通和交流","abilityRating":"能力完好"}','{"elderName":"李晓","idCard":"132122194512131234","birthDate":"1945-12-13","age":80,"gender":"男","nation":"汉族","socialSecurityCard":"8888","religiousBelief":"无","educationLevel":"初中","maritalStatus":"已婚","livingSituation":"独居","medicalPaymentMethod":"城镇居民基本医疗保险","economicSource":"子女补贴","elderContact":"13455555666","providerName":"1345555566","providerContact":"13455555666","relationshipWithElder":"子女","informedConsentUrl":"https://hm-xhzb.oss-cn-beijing.aliyuncs.com/e31b2f1e-f171-4e7b-ac14-3caa92c9c09b.png"}','2026-04-01T17:29:15','{"eating":"可独立进食（在合理的时间内独立进食准备好的食物）","bathing":"准备好洗澡水后，可自己独立完成洗澡过程","grooming":"可自己独立完成","dressing":"可独立完成","bowelControl":"可控制大便","bladderControl":"可控制小便","toileting":"可独立完成","chairTransfer":"可独立完成","walkingOnFlatGround":"可独立在平地上行走45m","upDownStairs":"可独立上下楼梯（连续上下10-15个台阶）","totalScore":100,"abilityRating":"能力完好"}',1,'2026-04-01T17:30','{"recallWords":"111、 111、111","clockDrawingTest":{"url":"https://hm-xhzb.oss-cn-beijing.aliyuncs.com/633fde22-27d6-4e64-af88-c06360b6230f.png","result":0},"aggressiveBehavior":"每月有几次身体攻击行为，或每周有几次语言攻击行为","depressiveSymptoms":"无","totalScore":1,"abilityRating":"轻度受损"}',10,'{"diseaseDiagnosis":{"dementia":"无","mentalIllness":"无","chronicDiseases":"懂法守法水电费水电费手打"},"recent30Days":{"fall":0,"lost":0,"choking":0,"suicideAttempt":0,"coma":0,"medicalReport":"https://hm-xhzb.oss-cn-beijing.aliyuncs.com/452e82b1-9c59-4b28-bd89-bcc18f3397fd.pdf"}}',1);
INSERT INTO `health_assessment_data_collection`(`social_participation`,`perception_communication`,`basic_info`,`create_time`,`daily_living_activities`,`create_by`,`update_time`,`mental_state`,`id`,`health_assessment`,`update_by`) VALUES ('{"livingAbility":"除个人生活自理外（如饮食、洗漱、穿戴、二便），能料理家务（如做饭、洗衣）或当家管理事务","workAbility":"原来熟练的脑力工作或体力技巧性工作可照常进行","timeSpaceOrientation":"时间观念（年、月、日、时）清楚；可单独出远门，能很快掌握新环境的方位","personOrientation":"知道周围人们的关系，知道祖孙、叔伯、姑姨、侄子侄女等称谓的意义；可分辨陌生人的大致年龄和身份，可用适当称呼","socialSkills":"参与社会，在社会环境有一定的适应能力，待人接物恰当","abilityRating":"能力完好"}','{"consciousLevel":"神志清醒，对周围环境警觉","vision":"能看清楚报纸上的标准字体","hearing":"可正常交谈，能听到电视、电话、门铃的声音","communication":"无困难，能与他人正常沟通和交流","abilityRating":"能力完好"}','{"elderName":"刘备","idCard":"132123195612191256","birthDate":"1956-12-19","age":69,"gender":"男","nation":"汉族","socialSecurityCard":"888666","religiousBelief":"无","educationLevel":"小学","maritalStatus":"已婚","livingSituation":"独居","medicalPaymentMethod":"全自费","economicSource":"其他补贴","elderContact":"15566676655","providerName":"刘禅","providerContact":"15566554433","relationshipWithElder":"子女","informedConsentUrl":"https://hm-xhzb.oss-cn-beijing.aliyuncs.com/2a761d80-c880-4b13-85d6-30374add2ec6.png"}','2026-04-02T11:58:38','{"eating":"可独立进食（在合理的时间内独立进食准备好的食物）","bathing":"准备好洗澡水后，可自己独立完成洗澡过程","grooming":"可自己独立完成","dressing":"可独立完成","bowelControl":"可控制大便","bladderControl":"可控制小便","toileting":"可独立完成","chairTransfer":"可独立完成","walkingOnFlatGround":"可独立在平地上行走45m","upDownStairs":"可独立上下楼梯（连续上下10-15个台阶）","totalScore":100,"abilityRating":"能力完好"}',1,'2026-04-02T11:59:25','{"recallWords":"123、123、123","clockDrawingTest":{"url":"https://hm-xhzb.oss-cn-beijing.aliyuncs.com/e0246c97-5805-467c-8604-f3e701671a08.png","result":0},"aggressiveBehavior":"无身体攻击行为（如打/踢/推/咬/抓/摔东西）和语言攻击行为（如骂人、语言威胁、尖叫）","depressiveSymptoms":"无","totalScore":0,"abilityRating":"能力完好"}',11,'{"diseaseDiagnosis":{"dementia":"无","mentalIllness":"无","chronicDiseases":"无"},"recent30Days":{"fall":0,"lost":0,"choking":0,"suicideAttempt":0,"coma":0,"medicalReport":"https://hm-xhzb.oss-cn-beijing.aliyuncs.com/d4f8d71d-d80d-46f1-8e53-0e5259358a50.pdf"}}',1);
INSERT INTO `health_assessment_data_collection`(`social_participation`,`perception_communication`,`basic_info`,`create_time`,`daily_living_activities`,`create_by`,`update_time`,`mental_state`,`id`,`health_assessment`,`update_by`) VALUES ('{"livingAbility":"除个人生活自理外（如饮食、洗漱、穿戴、二便），能料理家务（如做饭、洗衣）或当家管理事务","workAbility":"原来熟练的脑力工作或体力技巧性工作可照常进行","timeSpaceOrientation":"时间观念（年、月、日、时）清楚；可单独出远门，能很快掌握新环境的方位","personOrientation":"知道周围人们的关系，知道祖孙、叔伯、姑姨、侄子侄女等称谓的意义；可分辨陌生人的大致年龄和身份，可用适当称呼","socialSkills":"参与社会，在社会环境有一定的适应能力，待人接物恰当","abilityRating":"能力完好"}','{"consciousLevel":"神志清醒，对周围环境警觉","vision":"能看清楚报纸上的标准字体","hearing":"可正常交谈，能听到电视、电话、门铃的声音","communication":"无困难，能与他人正常沟通和交流","abilityRating":"能力完好"}','{"elderName":"关羽","idCard":"132123195601021234","birthDate":"1956-01-02","age":70,"gender":"男","nation":"汉族","socialSecurityCard":"88887777","religiousBelief":"无","educationLevel":"小学","maritalStatus":"已婚","livingSituation":"独居","medicalPaymentMethod":"贫困救助","economicSource":"子女补贴","elderContact":"15677778888","providerName":"关兴","providerContact":"15677778889","relationshipWithElder":"子女","informedConsentUrl":"https://hm-xhzb.oss-cn-beijing.aliyuncs.com/a944fd5f-9c5a-4c4c-bef7-8fcc5d90dd78.png"}','2026-04-02T12:05:32','{"eating":"可独立进食（在合理的时间内独立进食准备好的食物）","bathing":"准备好洗澡水后，可自己独立完成洗澡过程","grooming":"可自己独立完成","dressing":"可独立完成","bowelControl":"可控制大便","bladderControl":"可控制小便","toileting":"可独立完成","chairTransfer":"可独立完成","walkingOnFlatGround":"可独立在平地上行走45m","upDownStairs":"可独立上下楼梯（连续上下10-15个台阶）","totalScore":100,"abilityRating":"能力完好"}',1,'2026-04-02T12:06:13','{"recallWords":"123、123、123","clockDrawingTest":{"url":"https://hm-xhzb.oss-cn-beijing.aliyuncs.com/b0ea501d-cb31-4bf7-a36f-8a0ff0209235.png","result":0},"aggressiveBehavior":"无身体攻击行为（如打/踢/推/咬/抓/摔东西）和语言攻击行为（如骂人、语言威胁、尖叫）","depressiveSymptoms":"无","totalScore":0,"abilityRating":"能力完好"}',12,'{"diseaseDiagnosis":{"dementia":"无","mentalIllness":"无","chronicDiseases":"无"},"recent30Days":{"fall":0,"lost":0,"choking":0,"suicideAttempt":0,"coma":0,"medicalReport":"https://hm-xhzb.oss-cn-beijing.aliyuncs.com/6e45b31c-99b6-4638-a250-a1d0074a510c.pdf"}}',1);
INSERT INTO `health_assessment_data_collection`(`social_participation`,`perception_communication`,`basic_info`,`create_time`,`daily_living_activities`,`create_by`,`update_time`,`mental_state`,`id`,`health_assessment`,`update_by`) VALUES ('{"livingAbility":"除个人生活自理外（如饮食、洗漱、穿戴、二便），能料理家务（如做饭、洗衣）或当家管理事务","workAbility":"原来熟练的脑力工作或体力技巧性工作可照常进行","timeSpaceOrientation":"时间观念（年、月、日、时）清楚；可单独出远门，能很快掌握新环境的方位","personOrientation":"知道周围人们的关系，知道祖孙、叔伯、姑姨、侄子侄女等称谓的意义；可分辨陌生人的大致年龄和身份，可用适当称呼","socialSkills":"参与社会，在社会环境有一定的适应能力，待人接物恰当","abilityRating":"能力完好"}','{"consciousLevel":"神志清醒，对周围环境警觉","vision":"能看清楚报纸上的标准字体","hearing":"可正常交谈，能听到电视、电话、门铃的声音","communication":"无困难，能与他人正常沟通和交流","abilityRating":"能力完好"}','{"elderName":"张飞","idCard":"132123195912161234","birthDate":"1959-12-16","age":66,"gender":"男","nation":"汉族","socialSecurityCard":"66667777","religiousBelief":"无","educationLevel":"小学","maritalStatus":"已婚","livingSituation":"与配偶/伴侣居住","medicalPaymentMethod":"城镇居民基本医疗保险","economicSource":"子女补贴","elderContact":"15877776666","providerName":"张苞","providerContact":"15877776668","relationshipWithElder":"子女","informedConsentUrl":"https://hm-xhzb.oss-cn-beijing.aliyuncs.com/367f40d3-b38d-417a-a5fd-f83f5836a558.png"}','2026-04-02T12:08:21','{"eating":"可独立进食（在合理的时间内独立进食准备好的食物）","bathing":"准备好洗澡水后，可自己独立完成洗澡过程","grooming":"可自己独立完成","dressing":"可独立完成","bowelControl":"可控制大便","bladderControl":"可控制小便","toileting":"可独立完成","chairTransfer":"可独立完成","walkingOnFlatGround":"可独立在平地上行走45m","upDownStairs":"可独立上下楼梯（连续上下10-15个台阶）","totalScore":100,"abilityRating":"能力完好"}',1,'2026-04-02T12:09:02','{"recallWords":"123、123、123","clockDrawingTest":{"url":"https://hm-xhzb.oss-cn-beijing.aliyuncs.com/887e3801-0166-40db-b2f9-5ee50832a0ac.png","result":0},"aggressiveBehavior":"无身体攻击行为（如打/踢/推/咬/抓/摔东西）和语言攻击行为（如骂人、语言威胁、尖叫）","depressiveSymptoms":"无","totalScore":0,"abilityRating":"能力完好"}',13,'{"diseaseDiagnosis":{"dementia":"无","mentalIllness":"无","chronicDiseases":"无"},"recent30Days":{"fall":0,"lost":0,"choking":0,"suicideAttempt":0,"coma":0,"medicalReport":"https://hm-xhzb.oss-cn-beijing.aliyuncs.com/672c0142-df41-4ef1-b36f-4e3452854791.pdf"}}',1);


####################
##  health_assessment_report
####################
DROP TABLE IF EXISTS `health_assessment_report`;

####################
##  table health_assessment_report ddl
####################
CREATE TABLE `health_assessment_report` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `health_assessment_id` bigint unsigned DEFAULT NULL COMMENT '健康评估ID',
  `assessment_time` datetime DEFAULT NULL COMMENT '评估时间',
  `assessor_name` varchar(50) DEFAULT NULL COMMENT '评估员姓名',
  `recommended_room_type` varchar(50) DEFAULT NULL COMMENT '推荐入住房型（如：标准双人间）',
  `recommended_care_level` varchar(20) DEFAULT NULL COMMENT '推荐护理等级（如：一级护理等级）',
  `care_focus` text COMMENT '护理重点（多条用分号分隔，如：血压管控；肢体协助；认知干预）',
  `suggestion_description` text COMMENT '建议说明（如：老人基础健康状况稳定，日常生活能部分自理）',
  `daily_activity_level` varchar(10) DEFAULT NULL COMMENT '日常生活活动等级',
  `mental_status_level` varchar(10) DEFAULT NULL COMMENT '精神状态等级',
  `perception_communication_level` varchar(10) DEFAULT NULL COMMENT '感知觉与沟通等级',
  `social_participation_level` varchar(10) DEFAULT NULL COMMENT '社会参与等级',
  `initial_ability_level` varchar(50) DEFAULT NULL COMMENT '老年人能力初步等级',
  `final_ability_level` varchar(50) DEFAULT NULL COMMENT '老年人能力最终等级',
  `level_change_reason` text COMMENT '等级变更依据说明',
  `family_cooperation` text COMMENT '家属配合事项（多条用分号分隔）',
  `diet_suggestion` text COMMENT '饮食建议（如：低盐低脂饮食，控制主食摄入量，避免高糖食物）',
  `psychological_care` text COMMENT '心理关怀建议（如：多关注老人情绪变化，每日进行不少于10分钟的一对一沟通）',
  `institution_preparation` text COMMENT '机构准备事项（多条用分号分隔，如：提前准备轮椅；房间配置；照护人员适配）',
  `health_score` varchar(20) DEFAULT NULL COMMENT '健康评分',
  `risk_level` varchar(20) DEFAULT NULL COMMENT '严重危险(健康, 提示, 风险, 危险, 严重危险)',
  `report_summary` text COMMENT '报告总结',
  `abnormal_analysis` text COMMENT '异常分析',
  `system_score` varchar(255) DEFAULT NULL COMMENT '健康系统分值',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(255) DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` text COMMENT '备注',
  `core_suggestion` int DEFAULT NULL COMMENT '核心建议，0-不建议入住，1-建议入住',
  `check_in_status` tinyint DEFAULT NULL COMMENT '入住状态：0-未入住，1-已入住',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='健康评估报告表';

####################
##  health_assessment_report data
####################

####################
##  health_assessment_report data
####################
INSERT INTO `health_assessment_report`(`create_by`,`assessment_time`,`core_suggestion`,`daily_activity_level`,`final_ability_level`,`check_in_status`,`perception_communication_level`,`initial_ability_level`,`id`,`assessor_name`,`system_score`,`create_time`,`health_score`,`social_participation_level`,`abnormal_analysis`,`level_change_reason`,`health_assessment_id`,`mental_status_level`,`risk_level`,`report_summary`) VALUES ('1','2026-04-01T17:30:46',1,'能力完好','能力完好',0,'能力完好','能力完好','3','admin','{"breathingSystem":95,"digestiveSystem":68,"endocrineSystem":75,"immuneSystem":85,"circulatorySystem":65,"urinarySystem":80,"motionSystem":90,"senseSystem":70}','2026-04-01T17:30:46','72.5','能力完好','[{"conclusion":"心率偏快伴偶发早搏","examinationItem":"心率","result":"92","referenceValue":"<100","unit":"次/分","interpret":"心率偏快可能与年龄、压力、睡眠不足或潜在心血管问题有关，偶发早搏提示可能存在轻微心律失常。","advice":"建议减少咖啡因摄入，避免过度劳累，定期复查心电图，必要时咨询心脏科医生进行动态心电图检查。"},{"conclusion":"轻度脂肪肝可能","examinationItem":"肝脏B超","result":"实质回声略粗糙","referenceValue":"正常","unit":"-","interpret":"脂肪肝通常与高脂饮食、缺乏运动、肥胖等因素相关，长期未控制可能导致肝功能异常。","advice":"调整饮食结构，减少高脂肪、高糖食物摄入，增加有氧运动如快走或游泳，每3-6个月复查一次肝功能和B超。"},{"conclusion":"慢性胆囊炎可能","examinationItem":"胆囊B超","result":"胆囊壁毛糙","referenceValue":"正常","unit":"-","interpret":"慢性胆囊炎多由胆结石或长期不良饮食习惯引起，可能出现右上腹隐痛或消化不良症状。","advice":"避免油腻食物，规律进餐，定期复查胆囊B超，若症状明显需进一步诊治。"},{"conclusion":"脾脏轻度增大","examinationItem":"脾脏B超","result":"轻度增大","referenceValue":"正常","unit":"-","interpret":"脾脏增大可能与感染、血液病或肝脏疾病相关，需结合其他指标综合判断。","advice":"建议监测脾脏变化，排查血液系统疾病及肝脏疾病，定期复查腹部B超。"},{"conclusion":"右肾小囊肿可能","examinationItem":"肾脏B超","result":"右肾下极见一大小约5mm的无回声区","referenceValue":"正常","unit":"-","interpret":"小囊肿一般为良性病变，但需定期观察其大小变化以排除恶性可能。","advice":"每6-12个月复查肾脏B超，无需特殊处理，注意保持良好生活习惯。"},{"conclusion":"前列腺形态略增大","examinationItem":"前列腺B超","result":"形态略增大，回声欠均匀","referenceValue":"正常","unit":"-","interpret":"前列腺增大常见于老年男性，可能与前列腺增生或炎症有关，需警惕前列腺癌风险。","advice":"建议进行前列腺特异性抗原（PSA）检测，如有排尿困难等症状及时就医。"},{"conclusion":"牙周炎及牙龈退缩","examinationItem":"口腔科检查","result":"牙周炎，牙龈退缩","referenceValue":"正常","unit":"-","interpret":"牙周炎与口腔卫生不良、吸烟等有关，长期不治疗可能导致牙齿松动甚至脱落。","advice":"加强口腔清洁，使用软毛牙刷，定期洗牙，戒烟限酒，必要时接受牙周治疗。"}]','','10','轻度受损','风险','体检报告中发现心率偏快伴偶发早搏、轻度脂肪肝、慢性胆囊炎可能、脾脏轻度增大、右肾小囊肿、前列腺形态略增大、牙周炎及牙龈退缩共7项异常指标。综合这些临床指标和数据分析：循环系统存在‘高危’风险；消化系统存在‘中危’风险；泌尿系统和感官系统存在‘低危’风险；呼吸系统、免疫系统、运动系统基本健康。建议针对上述异常指标采取相应干预措施，并定期复查以监测健康状况。');
INSERT INTO `health_assessment_report`(`create_by`,`assessment_time`,`core_suggestion`,`daily_activity_level`,`final_ability_level`,`check_in_status`,`perception_communication_level`,`initial_ability_level`,`id`,`assessor_name`,`system_score`,`create_time`,`health_score`,`social_participation_level`,`abnormal_analysis`,`level_change_reason`,`health_assessment_id`,`mental_status_level`,`risk_level`,`report_summary`) VALUES ('1','2026-04-02T12:00:45',1,'能力完好','能力完好',0,'能力完好','能力完好','4','admin','{"breathingSystem":90,"digestiveSystem":68,"endocrineSystem":75,"immuneSystem":85,"circulatorySystem":65,"urinarySystem":70,"motionSystem":88,"senseSystem":60}','2026-04-02T12:00:45','72.5','能力完好','[{"conclusion":"心率略快伴偶发早搏","examinationItem":"心率","result":"92次/分","referenceValue":"<100次/分","unit":"次/分","interpret":"心率略快可能与年龄、压力、睡眠不足或潜在的心脏问题有关。偶发早搏提示可能存在心脏节律异常，需进一步评估是否存在心血管疾病风险。","advice":"建议进行动态心电图监测以明确早搏频率和类型，同时减少咖啡因摄入，避免过度劳累。定期复查血压和心率，并在必要时咨询心脏科医生。"},{"conclusion":"轻度脂肪肝可能","examinationItem":"肝脏B超","result":"实质回声略粗糙","referenceValue":"正常","unit":"-","interpret":"脂肪肝通常与高脂饮食、肥胖、饮酒或代谢综合征相关，若不及时干预可能发展为脂肪性肝炎甚至肝硬化。","advice":"调整饮食结构，减少油脂和糖分摄入，多吃蔬菜水果，增加有氧运动如快走、游泳等，每餐控制总热量。每年复查一次肝功能及B超。"},{"conclusion":"慢性胆囊炎可能","examinationItem":"胆囊B超","result":"胆囊壁毛糙","referenceValue":"光滑","unit":"-","interpret":"胆囊壁毛糙常提示慢性炎症，可能与长期高脂肪饮食、胆汁淤积或感染有关，严重时可能导致胆结石形成。","advice":"清淡饮食，避免油炸食品和动物内脏，规律进餐，保持适量饮水。如有右上腹疼痛或不适，应及时就医。"},{"conclusion":"脾轻度增大","examinationItem":"脾脏B超","result":"轻度增大","referenceValue":"正常大小","unit":"-","interpret":"脾脏轻度增大可能由感染、血液病或其他全身性疾病引起，需要排除恶性肿瘤或其他系统性疾病的可能性。","advice":"建议进一步检查血常规、腹部CT或MRI，同时观察是否有乏力、贫血等症状。定期随访脾脏变化情况。"},{"conclusion":"右肾小囊肿可能","examinationItem":"肾脏B超","result":"右肾下极见一大小约5mm的无回声区","referenceValue":"无囊肿","unit":"-","interpret":"单纯性肾囊肿多为良性，但需警惕其增长速度及是否影响肾功能。","advice":"无需特殊治疗，但应每年复查一次B超，监测囊肿大小变化。如果出现腰痛或血尿，立即就诊。"},{"conclusion":"前列腺形态略增大","examinationItem":"前列腺B超","result":"形态略增大，回声欠均匀","referenceValue":"正常形态","unit":"-","interpret":"前列腺增生常见于老年男性，可能伴随排尿困难、夜尿增多等症状，需排除前列腺癌的可能性。","advice":"建议检测前列腺特异性抗原（PSA），并根据结果决定是否行进一步检查。日常注意保暖，避免久坐，适当锻炼盆底肌肉。"},{"conclusion":"左耳听力轻度下降","examinationItem":"听力测试","result":"轻度下降","referenceValue":"正常","unit":"-","interpret":"老年人听力下降可能与自然衰老、噪音暴露、耳部疾病或血液循环障碍有关。","advice":"避免长时间佩戴耳机，远离噪声环境，定期复查听力。必要时可考虑助听器辅助改善生活质量。"},{"conclusion":"牙周炎及牙龈退缩","examinationItem":"口腔检查","result":"牙周炎，牙龈退缩","referenceValue":"无牙周病","unit":"-","interpret":"牙周炎是细菌感染引起的慢性炎症，与口腔卫生不良密切相关，严重时会导致牙齿松动甚至脱落。","advice":"加强口腔清洁，使用软毛牙刷，每天至少刷牙两次，配合使用牙线和漱口水。尽快到口腔科进行洁治和刮治治疗。"}]','','11','能力完好','风险','体检报告显示心率、肝脏B超、胆囊B超、脾脏B超、肾脏B超、前列腺B超、听力测试、口腔检查共8项指标提示异常，其中心率、脾脏增大及前列腺形态异常存在较高风险；血脂、血糖、血常规、尿常规等30余项指标提示正常。综合这些临床指标和数据分析：循环系统、消化系统和泌尿生殖系统存在一定隐患，其中循环系统有“高危”风险；消化系统有“中危”风险；泌尿生殖系统有“低危”风险。建议针对上述异常项目采取相应干预措施，定期随访监测健康状况。');
INSERT INTO `health_assessment_report`(`create_by`,`assessment_time`,`core_suggestion`,`daily_activity_level`,`final_ability_level`,`check_in_status`,`perception_communication_level`,`initial_ability_level`,`id`,`assessor_name`,`system_score`,`create_time`,`health_score`,`social_participation_level`,`abnormal_analysis`,`level_change_reason`,`health_assessment_id`,`mental_status_level`,`risk_level`,`report_summary`) VALUES ('1','2026-04-02T12:07:20',1,'能力完好','能力完好',0,'能力完好','能力完好','5','admin','{"breathingSystem":90,"digestiveSystem":75,"endocrineSystem":80,"immuneSystem":85,"circulatorySystem":65,"urinarySystem":70,"motionSystem":95,"senseSystem":60}','2026-04-02T12:07:20','72.5','能力完好','[{"conclusion":"心率偏快伴偶发早搏","examinationItem":"心率","result":"92次/分","referenceValue":"<100次/分","unit":"次/分","interpret":"心率略高于正常范围，伴有偶发早搏，可能提示心脏功能存在轻度异常或循环系统问题。长期心率过快可能导致心脏负担加重，需警惕潜在的心血管疾病风险。","advice":"建议进行24小时动态心电图检查以明确早搏频率和类型；减少咖啡因、酒精摄入，避免过度劳累；定期监测血压和心率变化；必要时至心内科就诊评估是否需要药物干预。"},{"conclusion":"轻度脂肪肝可能","examinationItem":"肝脏B超","result":"实质回声略粗糙","referenceValue":"正常","unit":"-","interpret":"肝脏B超显示实质回声略粗糙，提示可能存在轻度脂肪肝，与饮食结构不合理、缺乏运动等因素相关，长期发展可能增加肝硬化或代谢性疾病的风险。","advice":"建议低脂、低糖、高纤维饮食，控制总热量摄入；每周至少进行150分钟中等强度有氧运动（如快走、游泳）；3-6个月后复查肝功能及B超；避免饮酒。"},{"conclusion":"慢性胆囊炎可能","examinationItem":"胆囊B超","result":"胆囊壁毛糙","referenceValue":"正常","unit":"-","interpret":"胆囊壁毛糙提示可能存在慢性胆囊炎，通常与胆汁淤积、饮食不规律或高脂饮食有关，严重时可引发急性胆囊炎或胆结石。","advice":"建议清淡饮食，避免油腻食物及暴饮暴食；如有右上腹不适症状，应及时就医；必要时复查腹部B超并咨询消化科医生。"},{"conclusion":"脾脏轻度增大","examinationItem":"脾脏B超","result":"轻度增大","referenceValue":"正常","unit":"-","interpret":"脾脏轻度增大可能由感染、血液病或其他全身性疾病引起，需进一步排查是否存在潜在病因。","advice":"建议结合血常规及其他相关检查明确原因；保持良好的生活习惯，增强免疫力；若出现乏力、发热等症状，及时复诊。"},{"conclusion":"前列腺形态略增大","examinationItem":"前列腺B超","result":"形态略增大，回声欠均匀","referenceValue":"正常","unit":"-","interpret":"前列腺形态增大可能提示良性前列腺增生，常见于老年男性，但需排除恶性病变的可能性。","advice":"建议检测前列腺特异性抗原（PSA），必要时行直肠指检或MRI检查；多饮水，避免久坐，适量锻炼盆底肌肉；如排尿困难明显，应至泌尿外科就诊。"},{"conclusion":"视力下降","examinationItem":"视力","result":"左眼0.3，右眼0.4","referenceValue":"≥1.0","unit":"-","interpret":"双眼视力下降符合老视特征，可能影响日常生活质量，尤其是阅读和近距离工作。","advice":"建议佩戴合适的老花镜矫正视力；注意用眼卫生，避免长时间近距离用眼；每年复查一次视力。"}]','','12','能力完好','风险','体检报告中心率、肝脏B超、胆囊B超、脾脏B超、前列腺B超、视力共6项指标提示异常，其中心血管系统存在‘高危’风险，主要表现为心率偏快伴偶发早搏；泌尿系统和消化系统分别存在‘中危’和‘低危’风险，包括前列腺形态增大和慢性胆囊炎可能；感官系统评分较低，主要受视力下降影响。综合来看，需重点关注心血管健康，并对肝脏、胆囊、前列腺等问题进行随访管理。');
INSERT INTO `health_assessment_report`(`create_by`,`assessment_time`,`core_suggestion`,`daily_activity_level`,`final_ability_level`,`check_in_status`,`perception_communication_level`,`initial_ability_level`,`id`,`assessor_name`,`system_score`,`create_time`,`health_score`,`social_participation_level`,`abnormal_analysis`,`level_change_reason`,`health_assessment_id`,`mental_status_level`,`risk_level`,`report_summary`) VALUES ('1','2026-04-02T12:09:57',1,'能力完好','能力完好',0,'能力完好','能力完好','6','admin','{"breathingSystem":90,"digestiveSystem":68,"endocrineSystem":75,"immuneSystem":85,"circulatorySystem":65,"urinarySystem":80,"motionSystem":95,"senseSystem":60}','2026-04-02T12:09:57','72.5','能力完好','[{"conclusion":"心率略快伴偶发早搏","examinationItem":"心率","result":"92次/分","referenceValue":"<100次/分","unit":"次/分","interpret":"心率略高于正常范围，伴有偶发早搏，提示可能存在心脏功能异常或循环系统问题。可能与年龄、压力、睡眠不足、饮食中盐分摄入过多等有关。","advice":"建议定期监测心率及血压，避免过度劳累和精神紧张，减少高盐食物的摄入。如有持续心悸或胸闷等症状，应及时就医进行心电图和动态心电图检查。"},{"conclusion":"视力下降（老视）","examinationItem":"视力左/右","result":"左眼0.3，右眼0.4","referenceValue":"≥1.0","unit":"-","interpret":"视力下降符合老视特征，属于老年人常见现象，但需关注是否存在其他眼部疾病如白内障或黄斑病变的风险。","advice":"建议佩戴合适的老花镜，并定期复查视力。避免长时间用眼，保持良好的阅读习惯，适当补充富含维生素A的食物如胡萝卜、菠菜等。"},{"conclusion":"轻度脂肪肝","examinationItem":"肝脏B超","result":"实质回声略粗糙","referenceValue":"正常","unit":"-","interpret":"肝脏实质回声略粗糙提示可能存在轻度脂肪肝，通常与肥胖、饮酒、高脂饮食或代谢综合征相关。","advice":"控制体重，减少油腻食物和酒精摄入，增加膳食纤维，适量运动如快走、游泳等。必要时复查肝功能并咨询消化科医生。"},{"conclusion":"慢性胆囊炎可能","examinationItem":"胆囊B超","result":"胆囊壁毛糙","referenceValue":"光滑","unit":"-","interpret":"胆囊壁毛糙提示可能存在慢性胆囊炎，常因长期不良饮食习惯（如高脂肪、高胆固醇饮食）或胆结石引起。","advice":"避免油腻、辛辣刺激性食物，规律进餐，少食多餐。若出现右上腹疼痛或消化不良症状，应尽快就医进一步评估。"},{"conclusion":"脾轻度增大","examinationItem":"脾脏B超","result":"轻度增大","referenceValue":"正常大小","unit":"-","interpret":"脾轻度增大可能与感染、血液病或其他全身性疾病有关，需要进一步排查潜在病因。","advice":"建议定期复查脾脏情况，同时结合血常规及其他实验室检查明确原因。如有发热、乏力等症状，应及时就诊。"},{"conclusion":"右肾小囊肿","examinationItem":"肾脏B超","result":"右肾下极见一大小约5mm的无回声区","referenceValue":"未见异常","unit":"-","interpret":"右肾小囊肿一般为良性病变，但需定期随访观察其变化，以防囊肿增大或并发感染。","advice":"每6-12个月复查一次肾脏B超，注意多饮水，避免憋尿。如出现腰痛、血尿等症状，立即就医。"},{"conclusion":"前列腺形态略增大","examinationItem":"前列腺B超","result":"形态略增大，回声欠均匀","referenceValue":"正常形态","unit":"-","interpret":"前列腺形态增大且回声不均提示可能存在前列腺增生或炎症，需进一步检查以排除恶性病变。","advice":"建议检测前列腺特异性抗原（PSA），并根据结果决定是否需要泌尿外科进一步诊治。日常生活中注意避免久坐，保持规律排尿。"}]','','13','能力完好','风险','体检报告显示心率、视力、肝脏、胆囊、脾脏、肾脏、前列腺等多项指标存在异常，其中心率略快伴偶发早搏、轻度脂肪肝、慢性胆囊炎可能性较大，提示循环系统和消化系统存在一定隐患；右肾小囊肿及前列腺形态增大则需密切随访。综合分析：心脑血管系统有“高危”风险；泌尿系统有“中危”风险；消化系统有“低危”风险。建议采取针对性健康管理措施，包括改善生活方式、定期复查及专科随访。');


####################
##  knowledge_base
####################
DROP TABLE IF EXISTS `knowledge_base`;

####################
##  table knowledge_base ddl
####################
CREATE TABLE `knowledge_base` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL COMMENT '知识标题',
  `category` int unsigned NOT NULL COMMENT '分类',
  `tags` varchar(255) DEFAULT NULL COMMENT '标签数组',
  `status` tinyint NOT NULL COMMENT '状态 0-禁用  1-启用',
  `priority` tinyint unsigned NOT NULL DEFAULT '3' COMMENT '优先级(1-5)',
  `document_url` varchar(255) DEFAULT NULL COMMENT '文档访问URL',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `create_by` bigint DEFAULT NULL COMMENT '创建人id',
  `update_by` bigint DEFAULT NULL COMMENT '更新人id',
  `remark` text COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='知识库主表';

####################
##  knowledge_base data
####################

####################
##  knowledge_base data
####################
INSERT INTO `knowledge_base`(`update_time`,`create_time`,`remark`,`id`,`title`,`category`,`priority`,`document_url`,`tags`,`status`) VALUES ('2026-03-30T09:41:03','2026-03-30T17:41:04','[`c9faa1de-6987-447c-aa61-3864d876f056`,`f4391cc3-f605-4770-9873-2389c3d600e1`,`11f360de-ab7c-4c77-b000-03627c6bd6f2`,`23ab5e82-e890-471e-aa86-ef35c11e90d7`,`ef9e001c-bb61-4397-9c73-ab82e2567549`,`2d52fc15-088d-4e3b-b005-f9f6374707c8`,`856b22aa-220c-4f09-b16a-dfea6266f9ea`,`5f27dd5e-52ae-4793-8b3d-624b4028d19d`,`30c441e7-97fa-450c-b830-772b247cf785`,`132ef62b-425a-4dde-a040-7aaf1e3b6091`,`8854f9c0-0140-4de4-b656-06ee51ee7d4c`,`c6292277-592b-48e4-9593-cdb85dc60e76`,`744f2dea-18ea-4cee-9610-4d66766683af`,`6526f3f6-efef-4ac1-9b08-ca601ac35f4d`,`e83a190a-2f9d-48d2-89dd-148cce9c9477`,`a7b3cf0c-437c-4771-b0bb-7c9a8169a93b`,`9cbd6874-299c-4297-869a-e5692de7e292`,`fcc81357-c262-4fb0-bf98-a60568636fcb`,`8f04902f-0a5d-413e-92ed-416d480338e9`,`57ca4083-9da9-40af-8606-c130708af45b`,`951bd00e-8692-43df-90db-9dfe4183e8ea`,`36e420db-c58b-46f0-b656-165134e36471`,`f54e66f9-32fa-4cc7-93cf-8bc021fffdd3`,`73912ccf-2d5d-4d35-9cf8-75b4b07d4cf7`,`0b9d88d3-c827-4c03-bc9e-b1a81e94c464`,`b3d2dc9a-c688-4103-b726-d7358f202d88`,`5df6005b-0230-449e-94ef-845f4da598f9`,`5f1ddc3b-3b03-41b4-9109-587aa9c5f4c1`,`d4a24421-f3c6-4764-a942-4bc3e35db1a7`,`56df5149-0417-471c-9ffb-bf74481dbbcd`,`73eb5860-17c2-484c-b1dc-c749e256a533`,`511f9928-ff22-4dce-b469-0f0ea8dd2552`,`182bfdc3-199c-4ca1-b1f1-fa613dd91324`,`8aeed206-4f8c-4c34-8fa1-56e26cb5bbb4`,`1b38c776-cc5e-499f-ac08-c60a3920feb1`,`2002b2b0-7332-406f-8794-ad86eebd9927`,`20542b29-83de-474b-89f7-3a0a8d8d271c`,`9834aa53-efc6-4000-8208-782418d08c8b`,`fd3a8ef9-03c9-41b6-a9ae-8fb38eacbe1d`]',2,'护理员工工作手册',1,2,'https://hm-xhzb.oss-cn-beijing.aliyuncs.com/0c630f5d-f27f-4595-be86-52e29d9f72ce.pdf','哈哈',1);

####################
##  nursing_elder
####################
DROP TABLE IF EXISTS `nursing_elder`;

####################
##  table nursing_elder ddl
####################
CREATE TABLE `nursing_elder` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `nursing_id` bigint DEFAULT NULL COMMENT '护理员id',
  `elder_id` bigint DEFAULT NULL COMMENT '老人id',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `create_by` bigint DEFAULT NULL COMMENT '创建人id',
  `update_by` bigint DEFAULT NULL COMMENT '更新人id',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `nursing_id` (`nursing_id`,`elder_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='护理员老人关联表';

####################
##  nursing_elder data
####################

####################
##  nursing_elder data
####################
INSERT INTO `nursing_elder`(`elder_id`,`create_by`,`nursing_id`,`create_time`,`id`) VALUES (93,1,100,'2025-05-04T12:18:37',10);
INSERT INTO `nursing_elder`(`elder_id`,`create_by`,`nursing_id`,`create_time`,`id`) VALUES (93,1,101,'2025-05-04T12:18:42',12);
INSERT INTO `nursing_elder`(`elder_id`,`create_by`,`nursing_id`,`create_time`,`id`) VALUES (94,1,100,'2026-04-11T00:23:46',15);

####################
##  nursing_level
####################
DROP TABLE IF EXISTS `nursing_level`;

####################
##  table nursing_level ddl
####################
CREATE TABLE `nursing_level` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '等级名称',
  `lplan_id` int NOT NULL COMMENT '护理计划ID',
  `fee` decimal(10,2) NOT NULL COMMENT '护理费用',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态（0：禁用，1：启用）',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '等级说明',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` bigint DEFAULT NULL COMMENT '创建人id',
  `update_by` bigint DEFAULT NULL COMMENT '更新人id',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '备注',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `name` (`name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='护理等级表';

####################
##  nursing_level data
####################

####################
##  nursing_level data
####################
INSERT INTO `nursing_level`(`update_time`,`create_time`,`fee`,`name`,`id`,`lplan_id`,`status`) VALUES ('2026-03-03T16:30:04','2026-03-03T16:30:04','1500.00','二级护理等级',80,138,true);
INSERT INTO `nursing_level`(`update_time`,`create_time`,`fee`,`name`,`id`,`lplan_id`,`status`) VALUES ('2026-03-03T16:30:17','2026-03-03T16:30:17','1200.00','三级护理等级',81,139,true);
INSERT INTO `nursing_level`(`update_time`,`create_time`,`fee`,`name`,`description`,`id`,`lplan_id`,`status`) VALUES ('2026-03-13T17:54:25','2026-03-03T16:30:30','1000.00','四级护理等级','无',82,140,true);
INSERT INTO `nursing_level`(`update_time`,`create_time`,`fee`,`name`,`description`,`id`,`lplan_id`,`status`) VALUES ('2026-04-02T03:16:47','2026-03-09T16:37:08','3010.00','顶级护理','最顶级的护理等级',83,141,true);

####################
##  nursing_plan
####################
DROP TABLE IF EXISTS `nursing_plan`;

####################
##  table nursing_plan ddl
####################
CREATE TABLE `nursing_plan` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '编号',
  `sort_no` int DEFAULT NULL COMMENT '排序号',
  `plan_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '名称',
  `status` tinyint NOT NULL DEFAULT '0' COMMENT '状态 0禁用 1启用',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `create_by` bigint DEFAULT NULL COMMENT '创建人id',
  `update_by` bigint DEFAULT NULL COMMENT '更新人id',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `plan_name` (`plan_name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=175 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='护理计划表';

####################
##  nursing_plan data
####################

####################
##  nursing_plan data
####################
INSERT INTO `nursing_plan`(`sort_no`,`create_time`,`id`,`plan_name`,`status`) VALUES (1,'2026-03-03T16:27:23',138,'二级护理计划',1);
INSERT INTO `nursing_plan`(`sort_no`,`create_time`,`id`,`plan_name`,`status`) VALUES (1,'2026-03-03T16:27:57',139,'三级护理计划',1);
INSERT INTO `nursing_plan`(`sort_no`,`create_time`,`id`,`plan_name`,`status`) VALUES (1,'2026-03-03T16:29:13',140,'四级护理计划',1);
INSERT INTO `nursing_plan`(`sort_no`,`create_time`,`id`,`plan_name`,`status`) VALUES (1,'2026-03-09T16:23:53',141,'特级护理计划',1);
INSERT INTO `nursing_plan`(`sort_no`,`create_time`,`id`,`plan_name`,`status`) VALUES (2,'2026-03-09T16:43:41',150,'紧急护理计划',1);

####################
##  nursing_project
####################
DROP TABLE IF EXISTS `nursing_project`;

####################
##  table nursing_project ddl
####################
CREATE TABLE `nursing_project` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '名称',
  `order_no` int DEFAULT NULL COMMENT '排序号',
  `unit` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '单位',
  `price` decimal(10,2) DEFAULT NULL COMMENT '价格',
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '图片',
  `nursing_requirement` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '护理要求',
  `status` int NOT NULL DEFAULT '1' COMMENT '状态（0：禁用，1：启用）',
  `create_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '创建人',
  `update_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '更新人',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '备注',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `name` (`name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='护理项目表';

####################
##  nursing_project data
####################

####################
##  nursing_project data
####################
INSERT INTO `nursing_project`(`order_no`,`image`,`create_time`,`create_by`,`unit`,`update_time`,`price`,`name`,`id`,`nursing_requirement`,`update_by`,`status`) VALUES (1,'https://itheim.oss-cn-beijing.aliyuncs.com/b6631465-1684-41fe-8ccd-0b027cb91e90.png','2024-08-29T16:51:50','1','次','2026-03-21T13:04:21','10.00','修剪指甲',1,'根据老人身体状况，定期修剪手指甲、脚趾甲，避免过长、开裂或划伤皮肤。修剪时动作轻柔，仔细打磨边缘，兼顾舒适度与安全性，预防倒刺、嵌甲及感染。去','1',1);
INSERT INTO `nursing_project`(`order_no`,`image`,`create_time`,`create_by`,`unit`,`update_time`,`price`,`name`,`id`,`nursing_requirement`,`update_by`,`status`) VALUES (1,'https://itheim.oss-cn-beijing.aliyuncs.com/41fc58d3-0627-4fa9-8459-906599aa1efa.png','2024-08-29T16:52:27','1','件','2025-04-27T15:09','5.00','衣物清洁',2,'定时收集、分类清洗老人衣物、床单等织物，按材质选择合适洗涤方式。洗净后烘干、熨烫、整理归位，保持衣物干净、整洁、无异味，提升老人穿着舒适度。','1',1);
INSERT INTO `nursing_project`(`order_no`,`image`,`create_time`,`create_by`,`unit`,`update_time`,`price`,`name`,`id`,`nursing_requirement`,`update_by`,`status`) VALUES (1,'https://itheim.oss-cn-beijing.aliyuncs.com/e611fcc9-dc45-49ac-abeb-f2ea99c2cffc.png','2024-08-29T16:52:52','1','次','2024-08-29T08:51:46','15.00','整理床铺',3,'每日定时整理床铺，更换枕套、床单、被罩，保持床单位平整、干燥、无褶皱。及时清理床上杂物，为老人营造整洁、舒适、卫生的睡眠与休息环境。','1',1);
INSERT INTO `nursing_project`(`order_no`,`image`,`create_time`,`create_by`,`unit`,`update_time`,`price`,`name`,`id`,`nursing_requirement`,`update_by`,`status`) VALUES (1,'https://itheim.oss-cn-beijing.aliyuncs.com/d91ba642-88e5-4c3d-8e50-a681ae3300e5.png','2024-08-29T16:53:29','1','餐','2024-08-29T08:52:24','15.00','助餐',4,'根据老人饮食需求与身体状况，协助进食、饮水。对行动不便、吞咽困难者，提供喂食、喂水服务，注意温度、速度与营养搭配，确保老人安全、顺利进餐。','1',1);
INSERT INTO `nursing_project`(`order_no`,`image`,`create_time`,`create_by`,`unit`,`update_time`,`price`,`name`,`id`,`nursing_requirement`,`update_by`,`status`) VALUES (1,'https://itheim.oss-cn-beijing.aliyuncs.com/125df948-7646-4fce-b322-1db0a84856e7.png','2024-08-29T16:53:51','1','次','2024-08-29T08:52:46','40.00','助浴',5,'协助老人完成全身清洁洗浴，做好防滑、保暖与安全防护。根据老人自理能力，全程陪护，控制水温与时间，避免滑倒、受凉，清洁后及时擦干穿衣。','1',1);
INSERT INTO `nursing_project`(`order_no`,`image`,`create_time`,`create_by`,`unit`,`update_time`,`price`,`name`,`id`,`nursing_requirement`,`update_by`,`status`) VALUES (1,'https://itheim.oss-cn-beijing.aliyuncs.com/a38883fc-870b-40ff-a256-54ce2fc17af9.png','2024-08-29T16:54:22','1','次','2024-08-29T08:53:17','20.00','洗头',6,'定期为老人清洗头发，调节合适水温，做好头部与颈部保暖。冲洗干净后及时擦干、吹干，预防感冒，保持头发清洁清爽，提升老人舒适感。','1',1);
INSERT INTO `nursing_project`(`order_no`,`image`,`create_time`,`create_by`,`unit`,`update_time`,`price`,`name`,`id`,`nursing_requirement`,`update_by`,`status`) VALUES (1,'https://itheim.oss-cn-beijing.aliyuncs.com/95b0ad37-5d61-4ec2-a961-d6fb691a18f0.png','2024-08-29T16:54:45','1','次','2024-08-29T08:53:40','15.00','洗脸',7,'每日早晚协助老人清洁面部，使用温和用品，轻柔擦拭眼、耳、鼻、面部及颈部。保持面部干净清爽，促进血液循环，提升日常舒适度。','1',1);
INSERT INTO `nursing_project`(`order_no`,`image`,`create_time`,`create_by`,`unit`,`update_time`,`price`,`name`,`id`,`nursing_requirement`,`update_by`,`status`) VALUES (1,'https://itheim.oss-cn-beijing.aliyuncs.com/8437eb2d-3ea5-4eee-9d78-017bc8b3a66e.png','2024-08-29T16:55:08','1','次','2024-08-29T08:54:03','20.00','洗脚',8,'每日为老人清洁双脚，调节适宜水温，浸泡、清洗、擦干双脚及趾缝。促进足部血液循环，缓解疲劳，预防脚气、干裂，提升睡眠与生活质量。','1',1);
INSERT INTO `nursing_project`(`order_no`,`image`,`create_time`,`create_by`,`unit`,`update_time`,`price`,`name`,`id`,`nursing_requirement`,`update_by`,`status`) VALUES (2,'https://hm-xhzb.oss-cn-beijing.aliyuncs.com/476920d1-1dbd-4205-a1b6-95568881477e.png','2026-03-09T15:59:52','1','元','2026-03-28T16:52:37','90.00','全身洗浴',20,'北京市海淀区西三旗街北京市海淀区西三旗街北京市海淀区西三旗街北京市海淀区西三旗街北京市','1',1);
INSERT INTO `nursing_project`(`order_no`,`image`,`create_time`,`create_by`,`unit`,`update_time`,`price`,`name`,`id`,`nursing_requirement`,`status`) VALUES (1,'https://hm-xhzb.oss-cn-beijing.aliyuncs.com/12b06336-24df-416b-a0ea-eff8f53e6fc1.png','2026-03-28T17:07:01','1','次','2026-03-28T09:07:01','25.00','心理咨询',31,'心理咨询心理咨询',1);
INSERT INTO `nursing_project`(`order_no`,`image`,`create_time`,`create_by`,`unit`,`update_time`,`price`,`name`,`id`,`nursing_requirement`,`status`) VALUES (1,'https://yjy-slwl-oss.oss-cn-hangzhou.aliyuncs.com/ae7cf766-fb7b-49ff-a73c-c86c25f280e1.png','2026-04-06T10:02:14','1','次','2026-04-06T02:02:12','10.00','护理项目测试',32,'无特殊要求',1);

####################
##  nursing_project_plan
####################
DROP TABLE IF EXISTS `nursing_project_plan`;

####################
##  table nursing_project_plan ddl
####################
CREATE TABLE `nursing_project_plan` (
  `id` int NOT NULL AUTO_INCREMENT,
  `plan_id` int NOT NULL COMMENT '计划id',
  `project_id` int NOT NULL COMMENT '项目id',
  `execute_time` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '计划执行时间',
  `execute_cycle` int NOT NULL COMMENT '执行周期 0 天 1 周 2月',
  `execute_frequency` int NOT NULL COMMENT '执行频次',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `create_by` bigint DEFAULT NULL COMMENT '创建人id',
  `update_by` bigint DEFAULT NULL COMMENT '更新人id',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1859 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='护理计划和项目关联表';

####################
##  nursing_project_plan data
####################

####################
##  nursing_project_plan data
####################
INSERT INTO `nursing_project_plan`(`create_time`,`project_id`,`execute_time`,`execute_cycle`,`execute_frequency`,`id`,`plan_id`) VALUES ('2024-08-19T11:28:43',87,'19:16:49',1,7,1736,133);
INSERT INTO `nursing_project_plan`(`create_time`,`project_id`,`execute_time`,`execute_cycle`,`execute_frequency`,`id`,`plan_id`) VALUES ('2024-08-19T11:28:43',85,'19:28:34',1,1,1737,133);
INSERT INTO `nursing_project_plan`(`create_time`,`project_id`,`execute_time`,`execute_cycle`,`execute_frequency`,`id`,`plan_id`) VALUES ('2024-08-19T11:36:10',85,'19:28:45',0,1,1738,134);
INSERT INTO `nursing_project_plan`(`create_time`,`project_id`,`execute_time`,`execute_cycle`,`execute_frequency`,`id`,`plan_id`) VALUES ('2024-08-29T08:55:34',1,'16:55:58',2,1,1739,135);
INSERT INTO `nursing_project_plan`(`create_time`,`project_id`,`execute_time`,`execute_cycle`,`execute_frequency`,`id`,`plan_id`) VALUES ('2024-08-29T08:55:34',5,'16:56:09',0,1,1740,135);
INSERT INTO `nursing_project_plan`(`create_time`,`project_id`,`execute_time`,`execute_cycle`,`execute_frequency`,`id`,`plan_id`) VALUES ('2024-08-29T08:55:34',4,'08:00:00',0,1,1741,135);
INSERT INTO `nursing_project_plan`(`create_time`,`project_id`,`execute_time`,`execute_cycle`,`execute_frequency`,`id`,`plan_id`) VALUES ('2025-04-18T10:28:47',5,'18:28:23',1,1,1742,136);
INSERT INTO `nursing_project_plan`(`create_time`,`project_id`,`execute_time`,`execute_cycle`,`execute_frequency`,`id`,`plan_id`) VALUES ('2025-04-18T10:28:47',6,'18:28:35',1,2,1743,136);
INSERT INTO `nursing_project_plan`(`create_time`,`project_id`,`execute_time`,`execute_cycle`,`execute_frequency`,`id`,`plan_id`) VALUES ('2025-04-18T10:28:47',7,'18:28:43',0,1,1744,136);
INSERT INTO `nursing_project_plan`(`create_time`,`project_id`,`execute_time`,`execute_cycle`,`execute_frequency`,`id`,`plan_id`) VALUES ('2026-03-03T16:28:33',31,'16:26:36',2,2,1755,138);
INSERT INTO `nursing_project_plan`(`create_time`,`project_id`,`execute_time`,`execute_cycle`,`execute_frequency`,`id`,`plan_id`) VALUES ('2026-03-03T16:28:33',8,'16:27:05',1,3,1756,138);
INSERT INTO `nursing_project_plan`(`create_time`,`project_id`,`execute_time`,`execute_cycle`,`execute_frequency`,`id`,`plan_id`) VALUES ('2026-03-03T16:28:33',2,'16:27:14',1,2,1757,138);
INSERT INTO `nursing_project_plan`(`create_time`,`project_id`,`execute_time`,`execute_cycle`,`execute_frequency`,`id`,`plan_id`) VALUES ('2026-03-03T16:28:33',6,'16:28:20',1,1,1758,138);
INSERT INTO `nursing_project_plan`(`create_time`,`project_id`,`execute_time`,`execute_cycle`,`execute_frequency`,`id`,`plan_id`) VALUES ('2026-03-03T16:28:57',1,'16:27:23',2,2,1759,139);
INSERT INTO `nursing_project_plan`(`create_time`,`project_id`,`execute_time`,`execute_cycle`,`execute_frequency`,`id`,`plan_id`) VALUES ('2026-03-03T16:28:57',3,'16:27:46',1,2,1760,139);
INSERT INTO `nursing_project_plan`(`create_time`,`project_id`,`execute_time`,`execute_cycle`,`execute_frequency`,`id`,`plan_id`) VALUES ('2026-03-03T16:28:57',5,'16:28:49',1,1,1761,139);
INSERT INTO `nursing_project_plan`(`create_time`,`project_id`,`execute_time`,`execute_cycle`,`execute_frequency`,`id`,`plan_id`) VALUES ('2026-03-03T16:29:27',1,'16:28:57',2,2,1763,140);
INSERT INTO `nursing_project_plan`(`create_time`,`project_id`,`execute_time`,`execute_cycle`,`execute_frequency`,`id`,`plan_id`) VALUES ('2026-03-03T16:29:27',2,'16:29:23',1,1,1764,140);
INSERT INTO `nursing_project_plan`(`create_time`,`project_id`,`execute_time`,`execute_cycle`,`execute_frequency`,`id`,`plan_id`) VALUES ('2026-03-09T16:43:40',1,'16:30:19',1,1,1767,150);
INSERT INTO `nursing_project_plan`(`create_time`,`project_id`,`execute_time`,`execute_cycle`,`execute_frequency`,`id`,`plan_id`) VALUES ('2026-03-09T16:43:40',6,'16:39:59',1,2,1768,150);
INSERT INTO `nursing_project_plan`(`create_time`,`project_id`,`execute_time`,`execute_cycle`,`execute_frequency`,`id`,`plan_id`) VALUES ('2026-03-09T16:44:47',3,'09:43:40',0,7,1769,152);
INSERT INTO `nursing_project_plan`(`create_time`,`project_id`,`execute_time`,`execute_cycle`,`execute_frequency`,`id`,`plan_id`) VALUES ('2026-03-11T18:09:03',1,'16:24:45',2,2,1782,137);
INSERT INTO `nursing_project_plan`(`create_time`,`project_id`,`execute_time`,`execute_cycle`,`execute_frequency`,`id`,`plan_id`) VALUES ('2026-03-11T18:09:03',2,'08:25:07',1,1,1783,137);
INSERT INTO `nursing_project_plan`(`create_time`,`project_id`,`execute_time`,`execute_cycle`,`execute_frequency`,`id`,`plan_id`) VALUES ('2026-03-11T18:09:03',4,'08:00:00',0,3,1784,137);
INSERT INTO `nursing_project_plan`(`create_time`,`project_id`,`execute_time`,`execute_cycle`,`execute_frequency`,`id`,`plan_id`) VALUES ('2026-03-11T18:09:03',5,'20:00:00',1,1,1785,137);
INSERT INTO `nursing_project_plan`(`create_time`,`project_id`,`execute_time`,`execute_cycle`,`execute_frequency`,`id`,`plan_id`) VALUES ('2026-03-11T18:09:03',8,'20:26:05',1,3,1786,137);
INSERT INTO `nursing_project_plan`(`create_time`,`project_id`,`execute_time`,`execute_cycle`,`execute_frequency`,`id`,`plan_id`) VALUES ('2026-03-12T11:38:18',2,'08:00',1,1,1788,161);
INSERT INTO `nursing_project_plan`(`create_time`,`project_id`,`execute_time`,`execute_cycle`,`execute_frequency`,`id`,`plan_id`) VALUES ('2026-03-12T11:39:42',2,'08:00:00',1,2,1789,162);
INSERT INTO `nursing_project_plan`(`create_time`,`project_id`,`execute_time`,`execute_cycle`,`execute_frequency`,`id`,`plan_id`) VALUES ('2026-03-12T17:10:33',3,'09:00',1,2,1817,166);
INSERT INTO `nursing_project_plan`(`create_time`,`project_id`,`execute_time`,`execute_cycle`,`execute_frequency`,`id`,`plan_id`) VALUES ('2026-03-12T17:10:33',31,'11:02',2,7,1818,166);
INSERT INTO `nursing_project_plan`(`create_time`,`project_id`,`execute_time`,`execute_cycle`,`execute_frequency`,`id`,`plan_id`) VALUES ('2026-03-12T17:10:33',20,'10:00',0,7,1819,166);
INSERT INTO `nursing_project_plan`(`create_time`,`project_id`,`execute_time`,`execute_cycle`,`execute_frequency`,`id`,`plan_id`) VALUES ('2026-03-12T17:10:33',4,'08:00',1,7,1820,166);
INSERT INTO `nursing_project_plan`(`create_time`,`project_id`,`execute_time`,`execute_cycle`,`execute_frequency`,`id`,`plan_id`) VALUES ('2026-03-12T19:21:17',2,'08:00',1,1,1834,168);
INSERT INTO `nursing_project_plan`(`create_time`,`project_id`,`execute_time`,`execute_cycle`,`execute_frequency`,`id`,`plan_id`) VALUES ('2026-03-13T09:16:58',2,'08:00',1,1,1835,169);
INSERT INTO `nursing_project_plan`(`create_time`,`project_id`,`execute_time`,`execute_cycle`,`execute_frequency`,`id`,`plan_id`) VALUES ('2026-03-13T09:16:58',3,'10:00',0,2,1836,169);
INSERT INTO `nursing_project_plan`(`create_time`,`project_id`,`execute_time`,`execute_cycle`,`execute_frequency`,`id`,`plan_id`) VALUES ('2026-03-13T09:16:58',6,'08:00',1,3,1837,169);
INSERT INTO `nursing_project_plan`(`create_time`,`project_id`,`execute_time`,`execute_cycle`,`execute_frequency`,`id`,`plan_id`) VALUES ('2026-03-13T09:22:39',2,'08:00',1,1,1838,170);
INSERT INTO `nursing_project_plan`(`create_time`,`project_id`,`execute_time`,`execute_cycle`,`execute_frequency`,`id`,`plan_id`) VALUES ('2026-03-13T09:22:39',3,'08:00',0,1,1839,170);
INSERT INTO `nursing_project_plan`(`create_time`,`project_id`,`execute_time`,`execute_cycle`,`execute_frequency`,`id`,`plan_id`) VALUES ('2026-03-13T10:52:18',20,'08:00',1,1,1840,172);
INSERT INTO `nursing_project_plan`(`create_time`,`project_id`,`execute_time`,`execute_cycle`,`execute_frequency`,`id`,`plan_id`) VALUES ('2026-03-13T10:52:18',3,'08:00',1,1,1841,172);
INSERT INTO `nursing_project_plan`(`create_time`,`project_id`,`execute_time`,`execute_cycle`,`execute_frequency`,`id`,`plan_id`) VALUES ('2026-03-13T10:52:18',4,'08:00',1,1,1842,172);
INSERT INTO `nursing_project_plan`(`create_time`,`project_id`,`execute_time`,`execute_cycle`,`execute_frequency`,`id`,`plan_id`) VALUES ('2026-03-13T10:52:18',5,'08:00',1,1,1843,172);
INSERT INTO `nursing_project_plan`(`create_time`,`project_id`,`execute_time`,`execute_cycle`,`execute_frequency`,`id`,`plan_id`) VALUES ('2026-03-13T10:52:18',6,'08:00',1,1,1844,172);
INSERT INTO `nursing_project_plan`(`create_time`,`project_id`,`execute_time`,`execute_cycle`,`execute_frequency`,`id`,`plan_id`) VALUES ('2026-03-13T10:52:18',31,'08:00',1,1,1845,172);
INSERT INTO `nursing_project_plan`(`create_time`,`project_id`,`execute_time`,`execute_cycle`,`execute_frequency`,`id`,`plan_id`) VALUES ('2026-03-13T10:52:18',7,'08:00',1,1,1846,172);
INSERT INTO `nursing_project_plan`(`create_time`,`project_id`,`execute_time`,`execute_cycle`,`execute_frequency`,`id`,`plan_id`) VALUES ('2026-03-13T10:52:18',8,'08:00',1,1,1847,172);
INSERT INTO `nursing_project_plan`(`create_time`,`project_id`,`execute_time`,`execute_cycle`,`execute_frequency`,`id`,`plan_id`) VALUES ('2026-03-13T10:52:18',2,'08:00',1,1,1848,172);
INSERT INTO `nursing_project_plan`(`create_time`,`project_id`,`execute_time`,`execute_cycle`,`execute_frequency`,`id`,`plan_id`) VALUES ('2026-03-13T17:48:01',3,'18:06:25',2,1,1853,158);
INSERT INTO `nursing_project_plan`(`create_time`,`project_id`,`execute_time`,`execute_cycle`,`execute_frequency`,`id`,`plan_id`) VALUES ('2026-03-13T17:48:01',2,'08:00:00',1,1,1854,158);
INSERT INTO `nursing_project_plan`(`create_time`,`project_id`,`execute_time`,`execute_cycle`,`execute_frequency`,`id`,`plan_id`) VALUES ('2026-03-13T21:21:36',2,'08:00',1,6,1855,174);
INSERT INTO `nursing_project_plan`(`create_time`,`project_id`,`execute_time`,`execute_cycle`,`execute_frequency`,`id`,`plan_id`) VALUES ('2026-03-13T21:21:36',3,'08:00',1,7,1856,174);
INSERT INTO `nursing_project_plan`(`create_time`,`project_id`,`execute_time`,`execute_cycle`,`execute_frequency`,`id`,`plan_id`) VALUES ('2026-03-21T13:04:54',4,'16:22:54',1,3,1857,141);
INSERT INTO `nursing_project_plan`(`create_time`,`project_id`,`execute_time`,`execute_cycle`,`execute_frequency`,`id`,`plan_id`) VALUES ('2026-03-21T13:04:54',5,'17:23:31',1,3,1858,141);

####################
##  nursing_task
####################
DROP TABLE IF EXISTS `nursing_task`;

####################
##  table nursing_task ddl
####################
CREATE TABLE `nursing_task` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `nursing_id` varchar(50) DEFAULT NULL COMMENT '护理员id',
  `project_id` int NOT NULL COMMENT '项目id',
  `project_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '护理项目名称',
  `elder_id` bigint DEFAULT NULL COMMENT '老人id',
  `elder_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '老人姓名',
  `bed_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '床位编号',
  `estimated_server_time` datetime DEFAULT NULL COMMENT '预计服务时间',
  `real_server_time` datetime DEFAULT NULL COMMENT '实际服务时间',
  `mark` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '执行记录',
  `cancel_reason` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '取消原因',
  `status` int DEFAULT NULL COMMENT '状态  1待执行 2已执行 3已关闭 ',
  `task_image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '执行图片',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `create_by` bigint DEFAULT NULL COMMENT '创建人id',
  `update_by` bigint DEFAULT NULL COMMENT '更新人id',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=212 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='护理任务表';

####################
##  nursing_task data
####################

####################
##  nursing_task data
####################

####################
##  reservation
####################
DROP TABLE IF EXISTS `reservation`;

####################
##  table reservation ddl
####################
CREATE TABLE `reservation` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '预约人姓名',
  `mobile` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '预约人手机号',
  `time` datetime NOT NULL COMMENT '预约时间',
  `visitor` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '探访人',
  `type` int NOT NULL COMMENT '预约类型，0：参观预约，1：探访预约',
  `status` int NOT NULL COMMENT '预约状态，0：待报道，1：已完成，2：取消，3：过期',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `create_by` bigint DEFAULT NULL COMMENT '创建人id',
  `update_by` bigint DEFAULT NULL COMMENT '更新人id',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `name_mobile_time_visitor` (`mobile`,`time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='预约信息表';

####################
##  reservation data
####################

####################
##  reservation data
####################

####################
##  room
####################
DROP TABLE IF EXISTS `room`;

####################
##  table room ddl
####################
CREATE TABLE `room` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '房间编号',
  `sort` int DEFAULT NULL COMMENT '排序号',
  `type_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '房间类型名称',
  `floor_id` bigint DEFAULT NULL COMMENT '楼层id',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `is_deleted` tinyint(1) DEFAULT '0' COMMENT '是否删除',
  `create_by` bigint DEFAULT NULL COMMENT '创建人id',
  `update_by` bigint DEFAULT NULL COMMENT '更新人id',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `code` (`code`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=144 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='房间表';

####################
##  room data
####################

####################
##  room data
####################
INSERT INTO `room`(`create_by`,`type_name`,`update_time`,`code`,`is_deleted`,`create_time`,`floor_id`,`id`,`sort`,`update_by`) VALUES (1671403256519078138,'豪华双人间','2025-04-18T18:32:41','101',false,'2023-09-26T17:38:25',1,1,1,1);
INSERT INTO `room`(`create_by`,`type_name`,`update_time`,`code`,`is_deleted`,`create_time`,`floor_id`,`id`,`sort`,`update_by`) VALUES (1671403256519078138,'豪华双人间','2025-04-18T18:33:09','102',false,'2023-09-26T17:38:32',1,2,2,1);
INSERT INTO `room`(`create_by`,`type_name`,`update_time`,`code`,`is_deleted`,`create_time`,`floor_id`,`id`,`sort`,`update_by`) VALUES (1671403256519078138,'豪华双人间','2025-04-18T18:33:21','103',false,'2023-09-26T17:38:41',1,3,3,1);
INSERT INTO `room`(`create_by`,`type_name`,`update_time`,`code`,`is_deleted`,`create_time`,`floor_id`,`id`,`sort`,`update_by`) VALUES (1671403256519078138,'双人套房','2025-04-18T18:33:25','104',false,'2023-09-26T17:38:48',1,4,4,1);
INSERT INTO `room`(`create_by`,`type_name`,`update_time`,`code`,`is_deleted`,`create_time`,`floor_id`,`id`,`sort`,`update_by`) VALUES (1671403256519078138,'单人套房','2025-04-18T18:33:31','105',false,'2023-09-26T17:38:55',1,5,5,1);
INSERT INTO `room`(`create_by`,`type_name`,`update_time`,`code`,`is_deleted`,`create_time`,`floor_id`,`id`,`sort`,`update_by`) VALUES (1671403256519078138,'双人套房','2025-04-18T18:33:38','106',false,'2023-09-26T17:39:05',1,6,6,1);
INSERT INTO `room`(`create_by`,`type_name`,`update_time`,`code`,`is_deleted`,`create_time`,`floor_id`,`id`,`sort`,`update_by`) VALUES (1671403256519078138,'单人套房','2025-04-18T18:33:47','107',false,'2023-09-26T17:39:13',1,7,7,1);
INSERT INTO `room`(`create_by`,`type_name`,`update_time`,`code`,`is_deleted`,`create_time`,`floor_id`,`id`,`sort`,`update_by`) VALUES (1671403256519078138,'单人套房','2025-04-18T18:33:56','201',false,'2023-09-26T17:42:02',2,8,1,1);
INSERT INTO `room`(`create_by`,`type_name`,`update_time`,`code`,`is_deleted`,`create_time`,`floor_id`,`id`,`sort`,`update_by`) VALUES (1671403256519078138,'豪华单人间','2025-04-18T18:34:06','202',false,'2023-09-26T17:42:08',2,9,2,1);
INSERT INTO `room`(`create_by`,`type_name`,`update_time`,`code`,`is_deleted`,`create_time`,`floor_id`,`id`,`sort`,`update_by`) VALUES (1671403256519078138,'普通单人间','2025-04-18T18:34:11','203',false,'2023-09-26T17:42:15',2,10,3,1);
INSERT INTO `room`(`create_by`,`type_name`,`update_time`,`code`,`is_deleted`,`create_time`,`floor_id`,`id`,`sort`,`update_by`) VALUES (1671403256519078138,'豪华双人间','2025-04-18T18:34:16','204',false,'2023-09-26T17:42:22',2,11,4,1);
INSERT INTO `room`(`create_by`,`type_name`,`update_time`,`code`,`is_deleted`,`create_time`,`floor_id`,`id`,`sort`) VALUES (1671403256519078138,'豪华单人间','2023-09-26T17:42:30','205',false,'2023-09-26T17:42:30',2,12,5);
INSERT INTO `room`(`create_by`,`type_name`,`update_time`,`code`,`is_deleted`,`create_time`,`floor_id`,`id`,`sort`) VALUES (1671403256519078138,'双人套房','2023-09-26T17:42:41','206',false,'2023-09-26T17:42:41',2,13,6);
INSERT INTO `room`(`create_by`,`type_name`,`update_time`,`code`,`is_deleted`,`create_time`,`floor_id`,`id`,`sort`,`update_by`) VALUES (1671403256519078138,'单人套房','2025-04-18T18:34:30','207',false,'2023-09-26T17:42:48',2,14,7,1);
INSERT INTO `room`(`create_by`,`type_name`,`update_time`,`code`,`is_deleted`,`create_time`,`floor_id`,`id`,`sort`,`update_by`) VALUES (1671403256519078138,'单人套房','2025-04-18T18:34:38','301',false,'2023-09-26T17:43:54',3,15,1,1);
INSERT INTO `room`(`create_by`,`type_name`,`update_time`,`code`,`is_deleted`,`create_time`,`floor_id`,`id`,`sort`,`update_by`) VALUES (1671403256519078138,'豪华双人间','2025-04-18T18:34:43','302',false,'2023-09-26T17:44:01',3,16,2,1);
INSERT INTO `room`(`create_by`,`type_name`,`update_time`,`code`,`is_deleted`,`create_time`,`floor_id`,`id`,`sort`,`update_by`) VALUES (1671403256519078138,'普通单人间','2025-04-18T18:34:48','303',false,'2023-09-26T17:44:09',3,17,3,1);
INSERT INTO `room`(`create_by`,`type_name`,`update_time`,`code`,`is_deleted`,`create_time`,`floor_id`,`id`,`sort`) VALUES (1671403256519078138,'豪华双人间','2023-09-26T17:44:17','304',false,'2023-09-26T17:44:17',3,18,4);
INSERT INTO `room`(`create_by`,`type_name`,`update_time`,`code`,`is_deleted`,`create_time`,`floor_id`,`id`,`sort`,`update_by`) VALUES (1671403256519078138,'豪华单人间','2025-04-18T18:34:56','305',false,'2023-09-26T17:44:24',3,19,5,1);
INSERT INTO `room`(`create_by`,`type_name`,`update_time`,`code`,`is_deleted`,`create_time`,`floor_id`,`id`,`sort`,`update_by`) VALUES (1671403256519078138,'双人套房','2025-04-18T18:34:59','306',false,'2023-09-26T17:44:33',3,20,6,1);
INSERT INTO `room`(`create_by`,`type_name`,`update_time`,`code`,`is_deleted`,`create_time`,`floor_id`,`id`,`sort`,`update_by`) VALUES (1671403256519078138,'单人套房','2025-04-18T18:35:03','307',false,'2023-09-26T17:44:42',3,21,7,1);
INSERT INTO `room`(`create_by`,`type_name`,`update_time`,`code`,`is_deleted`,`create_time`,`floor_id`,`id`,`sort`,`update_by`) VALUES (1671403256519078138,'单人套房','2025-04-18T18:35:11','401',false,'2023-09-26T18:51:10',4,22,1,1);
INSERT INTO `room`(`create_by`,`type_name`,`update_time`,`code`,`is_deleted`,`create_time`,`floor_id`,`id`,`sort`,`update_by`) VALUES (1671403256519078138,'豪华双人间','2025-04-18T18:35:36','402',false,'2023-09-26T18:51:17',4,23,2,1);
INSERT INTO `room`(`create_by`,`type_name`,`update_time`,`code`,`is_deleted`,`create_time`,`floor_id`,`id`,`sort`) VALUES (1671403256519078138,'普通单人间','2023-09-26T18:51:23','403',false,'2023-09-26T18:51:23',4,24,3);
INSERT INTO `room`(`create_by`,`type_name`,`update_time`,`code`,`is_deleted`,`create_time`,`floor_id`,`id`,`sort`) VALUES (1671403256519078138,'豪华双人间','2023-09-26T18:51:32','404',false,'2023-09-26T18:51:32',4,25,4);
INSERT INTO `room`(`create_by`,`type_name`,`update_time`,`code`,`is_deleted`,`create_time`,`floor_id`,`id`,`sort`) VALUES (1671403256519078138,'豪华单人间','2023-09-26T18:51:42','405',false,'2023-09-26T18:51:42',4,26,5);
INSERT INTO `room`(`create_by`,`type_name`,`update_time`,`code`,`is_deleted`,`create_time`,`floor_id`,`id`,`sort`) VALUES (1671403256519078138,'双人套房','2023-09-26T18:51:54','406',false,'2023-09-26T18:51:54',4,27,6);
INSERT INTO `room`(`create_by`,`type_name`,`update_time`,`code`,`is_deleted`,`create_time`,`floor_id`,`id`,`sort`) VALUES (1671403256519078138,'单人套房','2023-09-26T18:52:03','407',false,'2023-09-26T18:52:03',4,28,7);
INSERT INTO `room`(`create_by`,`type_name`,`update_time`,`code`,`is_deleted`,`create_time`,`floor_id`,`id`,`sort`) VALUES (1671403256519078138,'特护房','2023-09-26T18:53:54','501',false,'2023-09-26T18:53:54',5,29,1);
INSERT INTO `room`(`create_by`,`type_name`,`update_time`,`code`,`is_deleted`,`create_time`,`floor_id`,`id`,`sort`) VALUES (1671403256519078138,'普通双人间','2023-09-26T18:54:05','502',false,'2023-09-26T18:54:05',5,31,2);
INSERT INTO `room`(`create_by`,`type_name`,`update_time`,`code`,`is_deleted`,`create_time`,`floor_id`,`id`,`sort`) VALUES (1671403256519078138,'普通单人间','2023-09-26T18:54:12','503',false,'2023-09-26T18:54:12',5,32,3);
INSERT INTO `room`(`create_by`,`type_name`,`update_time`,`code`,`is_deleted`,`create_time`,`floor_id`,`id`,`sort`) VALUES (1671403256519078138,'豪华双人间','2023-09-26T18:54:20','504',false,'2023-09-26T18:54:20',5,33,4);
INSERT INTO `room`(`create_by`,`type_name`,`update_time`,`code`,`is_deleted`,`create_time`,`floor_id`,`id`,`sort`) VALUES (1671403256519078138,'豪华单人间','2023-09-26T18:54:28','505',false,'2023-09-26T18:54:28',5,34,5);
INSERT INTO `room`(`create_by`,`type_name`,`update_time`,`code`,`is_deleted`,`create_time`,`floor_id`,`id`,`sort`) VALUES (1671403256519078138,'双人套房','2023-09-26T18:54:37','506',false,'2023-09-26T18:54:37',5,35,6);
INSERT INTO `room`(`create_by`,`type_name`,`update_time`,`code`,`is_deleted`,`create_time`,`floor_id`,`id`,`sort`) VALUES (1671403256519078138,'单人套房','2023-09-26T18:54:47','507',false,'2023-09-26T18:54:47',5,36,7);
INSERT INTO `room`(`create_by`,`type_name`,`update_time`,`code`,`is_deleted`,`create_time`,`floor_id`,`id`,`sort`) VALUES (1671403256519078138,'特护房','2023-09-26T18:57:14','601',false,'2023-09-26T18:57:14',6,37,1);
INSERT INTO `room`(`create_by`,`type_name`,`update_time`,`code`,`is_deleted`,`create_time`,`floor_id`,`id`,`sort`) VALUES (1671403256519078138,'普通双人间','2023-09-26T18:57:20','602',false,'2023-09-26T18:57:20',6,38,2);
INSERT INTO `room`(`create_by`,`type_name`,`update_time`,`code`,`is_deleted`,`create_time`,`floor_id`,`id`,`sort`) VALUES (1671403256519078138,'普通单人间','2023-09-26T18:57:28','603',false,'2023-09-26T18:57:28',6,39,3);
INSERT INTO `room`(`create_by`,`type_name`,`update_time`,`code`,`is_deleted`,`create_time`,`floor_id`,`id`,`sort`) VALUES (1671403256519078138,'豪华双人间','2023-09-26T18:57:36','604',false,'2023-09-26T18:57:36',6,40,4);
INSERT INTO `room`(`create_by`,`type_name`,`update_time`,`code`,`is_deleted`,`create_time`,`floor_id`,`id`,`sort`) VALUES (1671403256519078138,'豪华单人间','2023-09-26T19:01:36','605',false,'2023-09-26T19:01:36',6,41,5);
INSERT INTO `room`(`create_by`,`type_name`,`update_time`,`code`,`is_deleted`,`create_time`,`floor_id`,`id`,`sort`) VALUES (1671403256519078138,'双人套房','2023-09-26T19:01:45','606',false,'2023-09-26T19:01:45',6,42,6);
INSERT INTO `room`(`create_by`,`type_name`,`update_time`,`code`,`is_deleted`,`create_time`,`floor_id`,`id`,`sort`) VALUES (1671403256519078138,'单人套房','2023-09-26T19:01:54','607',false,'2023-09-26T19:01:54',6,43,7);
INSERT INTO `room`(`create_by`,`type_name`,`update_time`,`code`,`is_deleted`,`create_time`,`floor_id`,`id`,`sort`) VALUES (1671403256519078138,'特护房','2023-09-26T19:02:13','701',false,'2023-09-26T19:02:13',7,44,1);
INSERT INTO `room`(`create_by`,`type_name`,`update_time`,`code`,`is_deleted`,`create_time`,`floor_id`,`id`,`sort`) VALUES (1671403256519078138,'普通双人间','2023-09-26T19:02:20','702',false,'2023-09-26T19:02:20',7,45,2);
INSERT INTO `room`(`create_by`,`type_name`,`update_time`,`code`,`is_deleted`,`create_time`,`floor_id`,`id`,`sort`) VALUES (1671403256519078138,'普通单人间','2023-09-26T19:02:28','703',false,'2023-09-26T19:02:28',7,46,3);
INSERT INTO `room`(`create_by`,`type_name`,`update_time`,`code`,`is_deleted`,`create_time`,`floor_id`,`id`,`sort`) VALUES (1671403256519078138,'豪华双人间','2023-09-26T19:02:49','704',false,'2023-09-26T19:02:49',7,47,4);
INSERT INTO `room`(`create_by`,`type_name`,`update_time`,`code`,`is_deleted`,`create_time`,`floor_id`,`id`,`sort`) VALUES (1671403256519078138,'豪华单人间','2023-09-26T19:03','705',false,'2023-09-26T19:03',7,48,5);
INSERT INTO `room`(`create_by`,`type_name`,`update_time`,`code`,`is_deleted`,`create_time`,`floor_id`,`id`,`sort`) VALUES (1671403256519078138,'双人套房','2023-09-26T19:03:07','706',false,'2023-09-26T19:03:07',7,49,6);
INSERT INTO `room`(`create_by`,`type_name`,`update_time`,`code`,`is_deleted`,`create_time`,`floor_id`,`id`,`sort`) VALUES (1671403256519078138,'单人套房','2023-09-26T19:03:15','707',false,'2023-09-26T19:03:15',7,50,7);
INSERT INTO `room`(`create_by`,`type_name`,`update_time`,`code`,`is_deleted`,`create_time`,`floor_id`,`id`,`sort`) VALUES (1671403256519078138,'特护房','2023-09-26T19:03:49','801',false,'2023-09-26T19:03:49',8,51,1);
INSERT INTO `room`(`create_by`,`type_name`,`update_time`,`code`,`is_deleted`,`create_time`,`floor_id`,`id`,`sort`) VALUES (1671403256519078138,'普通双人间','2023-09-26T19:03:57','802',false,'2023-09-26T19:03:57',8,52,2);
INSERT INTO `room`(`create_by`,`type_name`,`update_time`,`code`,`is_deleted`,`create_time`,`floor_id`,`id`,`sort`) VALUES (1671403256519078138,'普通单人间','2023-09-26T19:04:04','803',false,'2023-09-26T19:04:04',8,53,3);
INSERT INTO `room`(`create_by`,`type_name`,`update_time`,`code`,`is_deleted`,`create_time`,`floor_id`,`id`,`sort`) VALUES (1671403256519078138,'豪华双人间','2023-09-26T19:04:13','804',false,'2023-09-26T19:04:13',8,54,4);
INSERT INTO `room`(`create_by`,`type_name`,`update_time`,`code`,`is_deleted`,`create_time`,`floor_id`,`id`,`sort`) VALUES (1671403256519078138,'豪华单人间','2023-09-26T19:04:45','805',false,'2023-09-26T19:04:45',8,55,5);
INSERT INTO `room`(`create_by`,`type_name`,`update_time`,`code`,`is_deleted`,`create_time`,`floor_id`,`id`,`sort`) VALUES (1671403256519078138,'双人套房','2023-09-26T19:04:52','806',false,'2023-09-26T19:04:52',8,56,6);
INSERT INTO `room`(`create_by`,`type_name`,`update_time`,`code`,`is_deleted`,`create_time`,`floor_id`,`id`,`sort`) VALUES (1671403256519078138,'单人套房','2023-09-26T19:05','807',false,'2023-09-26T19:05',8,57,7);
INSERT INTO `room`(`create_by`,`type_name`,`update_time`,`code`,`is_deleted`,`create_time`,`floor_id`,`id`,`sort`,`update_by`) VALUES (1671403256519078138,'普通单人间','2026-03-21T13:10:36','1001',false,'2023-12-26T19:31:43',401,74,1,1);
INSERT INTO `room`(`create_by`,`type_name`,`code`,`is_deleted`,`create_time`,`floor_id`,`id`,`sort`) VALUES (1,'双人套房','901',false,'2026-04-02T08:52:55',391,143,1);

####################
##  room_type
####################
DROP TABLE IF EXISTS `room_type`;

####################
##  table room_type ddl
####################
CREATE TABLE `room_type` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '房型名称',
  `bed_count` int NOT NULL DEFAULT '0' COMMENT '床位数量',
  `price` decimal(10,2) NOT NULL COMMENT '床位费用',
  `introduction` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '介绍',
  `photo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '照片',
  `status` tinyint NOT NULL COMMENT '状态，0：禁用，1：启用',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `create_by` bigint DEFAULT NULL COMMENT '创建人id',
  `update_by` bigint DEFAULT NULL COMMENT '更新人id',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `name` (`name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=131 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='房型表';

####################
##  room_type data
####################

####################
##  room_type data
####################
INSERT INTO `room_type`(`create_by`,`update_time`,`create_time`,`price`,`name`,`photo`,`id`,`update_by`,`bed_count`,`introduction`,`status`) VALUES (1671403256519078153,'2024-05-20T11:00:19','2023-09-26T15:57:50','4000.00','单人套房','https://yjy-slwl-oss.oss-cn-hangzhou.aliyuncs.com/e2f1031b-e23e-4379-95d4-ce8fe382f58f.png',1,1,0,'宽敞舒适的套房，配备独立卫生间和基本生活设施，满足独自居住的需求，提供私密性和舒适度',1);
INSERT INTO `room_type`(`create_by`,`update_time`,`create_time`,`price`,`name`,`photo`,`id`,`bed_count`,`introduction`,`status`) VALUES (1671403256519078153,'2023-09-26T15:58:51','2023-09-26T15:58:51','6000.00','双人套房','https://yjy-slwl-oss.oss-cn-hangzhou.aliyuncs.com/ff84c185-2e28-431c-951d-d004cc2d5bdc.png',2,0,'适合夫妻或朋友两人居住的套房，设有独立卫生间和基本生活设施，提供共享空间和私密性',1);
INSERT INTO `room_type`(`create_by`,`update_time`,`create_time`,`price`,`name`,`photo`,`id`,`update_by`,`bed_count`,`introduction`,`status`) VALUES (1671403256519078153,'2026-03-10T10:56:03','2023-09-26T15:59:33','3000.00','豪华单人间','https://yjy-slwl-oss.oss-cn-hangzhou.aliyuncs.com/d803832c-5b93-4cae-ba95-aeb52ab0c5e0.png',3,1,0,'豪华装修的单人房间，提供舒适的居住环境和高品质的服务，设计精美，配备独立卫生间和必需设施',1);
INSERT INTO `room_type`(`create_by`,`update_time`,`create_time`,`price`,`name`,`photo`,`id`,`update_by`,`bed_count`,`introduction`,`status`) VALUES (1671403256519078153,'2026-03-10T10:56:05','2023-09-26T16:00:03','4500.00','豪华双人间','https://yjy-slwl-oss.oss-cn-hangzhou.aliyuncs.com/c3522da7-4c5c-48d2-94f9-9f0b95a048d2.png',4,1,0,'精心装修的双人房间，提供舒适和豪华的居住环境，配备独立卫生间和高品质的家具',1);
INSERT INTO `room_type`(`create_by`,`update_time`,`create_time`,`price`,`name`,`photo`,`id`,`update_by`,`bed_count`,`introduction`,`status`) VALUES (1671403256519078153,'2026-03-12T14:23:50','2023-09-26T16:00:27','2000.00','普通单人间','https://yjy-slwl-oss.oss-cn-hangzhou.aliyuncs.com/1a330b1c-b0a1-463d-8d9a-221ef17c314f.png',5,1,0,'简洁实用的单人房间，提供基本的居住设施和舒适度，适合独自居住的老年人，提供相对经济实惠的居住选择',1);
INSERT INTO `room_type`(`create_by`,`update_time`,`create_time`,`price`,`name`,`photo`,`remark`,`id`,`update_by`,`bed_count`,`introduction`,`status`) VALUES (1,'2024-08-22T19:06:41','2024-08-22T19:06:33','3500.00','测试新增','https://itheim.oss-cn-beijing.aliyuncs.com/8fe7b29d-fce0-4201-becb-0586e8284a9d.png','是否',115,1,10,'水电费方式',1);
INSERT INTO `room_type`(`create_by`,`update_time`,`create_time`,`price`,`name`,`photo`,`remark`,`id`,`update_by`,`bed_count`,`introduction`,`status`) VALUES (1,'2024-09-12T22:55:10','2024-09-12T22:52:36','1500.00','标准双人间','https://itheim.oss-cn-beijing.aliyuncs.com/91c4a814-efd5-4093-a5ac-963b41047019.png,https://hm-xhzb.oss-cn-beijing.aliyuncs.com/5535f726-5ae2-413a-8548-0825459963eb.png','1231234565432',116,1,10,'123',1);
INSERT INTO `room_type`(`create_by`,`update_time`,`create_time`,`price`,`name`,`photo`,`remark`,`id`,`update_by`,`bed_count`,`introduction`,`status`) VALUES (1,'2026-03-21T13:11:57','2026-03-09T15:20:42','100000.00','豪华总统房','https://hm-xhzb.oss-cn-beijing.aliyuncs.com/0054a549-63d2-4624-9e40-f530bb631d1f.png','给你一个优雅舒适的家',117,1,3,'给你一个优雅舒适的家',1);
INSERT INTO `room_type`(`create_by`,`update_time`,`create_time`,`price`,`name`,`photo`,`id`,`update_by`,`bed_count`,`introduction`,`status`) VALUES (1,'2026-03-09T15:57:55','2026-03-09T15:57:43','10.00','大车店','https://hm-xhzb.oss-cn-beijing.aliyuncs.com/554fdf86-803a-42b6-b29d-3678eb85004a.jpeg',118,1,100,'群居房',1);
INSERT INTO `room_type`(`create_by`,`update_time`,`create_time`,`price`,`name`,`remark`,`id`,`update_by`,`bed_count`,`introduction`,`status`) VALUES (1,'2026-03-28T16:50:17','2026-03-11T17:14:52','1.00','单人套房3','阿斯钢',120,1,100,'桑',1);

####################
##  sys_config
####################
DROP TABLE IF EXISTS `sys_config`;

####################
##  table sys_config ddl
####################
CREATE TABLE `sys_config` (
  `config_id` int NOT NULL AUTO_INCREMENT COMMENT '参数主键',
  `config_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '参数名称',
  `config_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '参数键名',
  `config_value` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '参数键值',
  `config_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`config_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='参数配置表';

####################
##  sys_config data
####################

####################
##  sys_config data
####################
INSERT INTO `sys_config`(`config_name`,`create_by`,`config_value`,`create_time`,`config_id`,`config_key`,`remark`,`config_type`,`update_by`) VALUES ('主框架页-默认皮肤样式名称','admin','skin-blue','2024-08-14T02:48:24',1,'sys.index.skinName','蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow','Y','');
INSERT INTO `sys_config`(`config_name`,`create_by`,`config_value`,`create_time`,`config_id`,`config_key`,`remark`,`config_type`,`update_by`) VALUES ('用户管理-账号初始密码','admin','123456','2024-08-14T02:48:24',2,'sys.user.initPassword','初始化密码 123456','Y','');
INSERT INTO `sys_config`(`config_name`,`create_by`,`config_value`,`create_time`,`config_id`,`config_key`,`remark`,`config_type`,`update_by`) VALUES ('主框架页-侧边栏主题','admin','theme-dark','2024-08-14T02:48:24',3,'sys.index.sideTheme','深色主题theme-dark，浅色主题theme-light','Y','');
INSERT INTO `sys_config`(`config_name`,`create_by`,`config_value`,`create_time`,`config_id`,`config_key`,`remark`,`config_type`,`update_by`) VALUES ('账号自助-验证码开关','admin','true','2024-08-14T02:48:24',4,'sys.account.captchaEnabled','是否开启验证码功能（true开启，false关闭）','Y','');
INSERT INTO `sys_config`(`config_name`,`create_by`,`config_value`,`create_time`,`config_id`,`config_key`,`remark`,`config_type`,`update_by`) VALUES ('账号自助-是否开启用户注册功能','admin','false','2024-08-14T02:48:24',5,'sys.account.registerUser','是否开启注册用户功能（true开启，false关闭）','Y','');
INSERT INTO `sys_config`(`config_name`,`create_by`,`config_value`,`create_time`,`config_id`,`config_key`,`remark`,`config_type`,`update_by`) VALUES ('用户登录-黑名单列表','admin','','2024-08-14T02:48:24',6,'sys.login.blackIPList','设置登录IP黑名单限制，多个匹配项以;分隔，支持匹配（*通配、网段）','Y','');

####################
##  sys_dept
####################
DROP TABLE IF EXISTS `sys_dept`;

####################
##  table sys_dept ddl
####################
CREATE TABLE `sys_dept` (
  `dept_id` bigint NOT NULL AUTO_INCREMENT COMMENT '部门id',
  `parent_id` bigint DEFAULT '0' COMMENT '父部门id',
  `ancestors` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '祖级列表',
  `dept_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '部门名称',
  `order_num` int DEFAULT '0' COMMENT '显示顺序',
  `leader` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '邮箱',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`dept_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=204 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='部门表';

####################
##  sys_dept data
####################

####################
##  sys_dept data
####################
INSERT INTO `sys_dept`(`leader`,`del_flag`,`create_time`,`dept_name`,`create_by`,`phone`,`parent_id`,`order_num`,`dept_id`,`ancestors`,`update_by`,`email`,`status`) VALUES ('若依','0','2024-08-14T02:48:23','智慧养老院','admin','15888888888',0,0,100,'0','','ry@qq.com','0');
INSERT INTO `sys_dept`(`leader`,`del_flag`,`create_time`,`dept_name`,`create_by`,`update_time`,`phone`,`parent_id`,`order_num`,`dept_id`,`ancestors`,`update_by`,`email`,`status`) VALUES ('若依','0','2024-08-14T02:48:23','高层办公室','admin','2025-05-04T04:10:38','15888888888',100,1,101,'0,100','admin','ry@qq.com','0');
INSERT INTO `sys_dept`(`leader`,`del_flag`,`create_time`,`dept_name`,`create_by`,`update_time`,`phone`,`parent_id`,`order_num`,`dept_id`,`ancestors`,`update_by`,`email`,`status`) VALUES ('若依','0','2024-08-14T02:48:23','财务部','admin','2025-05-04T04:11:21','15888888888',100,2,102,'0,100','admin','ry@qq.com','0');
INSERT INTO `sys_dept`(`leader`,`del_flag`,`create_time`,`dept_name`,`create_by`,`update_time`,`phone`,`parent_id`,`order_num`,`dept_id`,`ancestors`,`update_by`,`email`,`status`) VALUES ('若依','0','2024-08-14T02:48:23','院长办公室','admin','2025-05-04T04:11:06','15888888888',101,1,103,'0,100,101','admin','ry@qq.com','0');
INSERT INTO `sys_dept`(`leader`,`del_flag`,`create_time`,`dept_name`,`create_by`,`phone`,`parent_id`,`order_num`,`dept_id`,`ancestors`,`update_by`,`email`,`status`) VALUES ('若依','2','2024-08-14T02:48:23','市场部门','admin','15888888888',101,2,104,'0,100,101','','ry@qq.com','0');
INSERT INTO `sys_dept`(`leader`,`del_flag`,`create_time`,`dept_name`,`create_by`,`phone`,`parent_id`,`order_num`,`dept_id`,`ancestors`,`update_by`,`email`,`status`) VALUES ('若依','2','2024-08-14T02:48:23','测试部门','admin','15888888888',101,3,105,'0,100,101','','ry@qq.com','0');
INSERT INTO `sys_dept`(`leader`,`del_flag`,`create_time`,`dept_name`,`create_by`,`phone`,`parent_id`,`order_num`,`dept_id`,`ancestors`,`update_by`,`email`,`status`) VALUES ('若依','2','2024-08-14T02:48:23','财务部门','admin','15888888888',101,4,106,'0,100,101','','ry@qq.com','0');
INSERT INTO `sys_dept`(`leader`,`del_flag`,`create_time`,`dept_name`,`create_by`,`phone`,`parent_id`,`order_num`,`dept_id`,`ancestors`,`update_by`,`email`,`status`) VALUES ('若依','2','2024-08-14T02:48:23','运维部门','admin','15888888888',101,5,107,'0,100,101','','ry@qq.com','0');
INSERT INTO `sys_dept`(`leader`,`del_flag`,`create_time`,`dept_name`,`create_by`,`phone`,`parent_id`,`order_num`,`dept_id`,`ancestors`,`update_by`,`email`,`status`) VALUES ('若依','2','2024-08-14T02:48:23','市场部门','admin','15888888888',102,1,108,'0,100,102','','ry@qq.com','0');
INSERT INTO `sys_dept`(`leader`,`del_flag`,`create_time`,`dept_name`,`create_by`,`phone`,`parent_id`,`order_num`,`dept_id`,`ancestors`,`update_by`,`email`,`status`) VALUES ('若依','2','2024-08-14T02:48:23','财务部门','admin','15888888888',102,2,109,'0,100,102','','ry@qq.com','0');
INSERT INTO `sys_dept`(`del_flag`,`create_time`,`dept_name`,`create_by`,`parent_id`,`order_num`,`dept_id`,`ancestors`,`update_by`,`status`) VALUES ('0','2025-05-04T04:11:40','行政部','admin',100,3,200,'0,100','','0');
INSERT INTO `sys_dept`(`del_flag`,`create_time`,`dept_name`,`create_by`,`parent_id`,`order_num`,`dept_id`,`ancestors`,`update_by`,`status`) VALUES ('0','2025-05-04T04:11:59','护理部','admin',100,4,201,'0,100','','0');
INSERT INTO `sys_dept`(`del_flag`,`create_time`,`dept_name`,`create_by`,`parent_id`,`order_num`,`dept_id`,`ancestors`,`update_by`,`status`) VALUES ('0','2025-05-04T04:12:07','后勤部','admin',100,5,202,'0,100','','0');
INSERT INTO `sys_dept`(`del_flag`,`create_time`,`dept_name`,`create_by`,`parent_id`,`order_num`,`dept_id`,`ancestors`,`update_by`,`status`) VALUES ('0','2025-05-04T04:12:16','销售部','admin',100,6,203,'0,100','','0');

####################
##  sys_dict_data
####################
DROP TABLE IF EXISTS `sys_dict_data`;

####################
##  table sys_dict_data ddl
####################
CREATE TABLE `sys_dict_data` (
  `dict_code` bigint NOT NULL AUTO_INCREMENT COMMENT '字典编码',
  `dict_sort` int DEFAULT '0' COMMENT '字典排序',
  `dict_label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '字典类型',
  `css_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '表格回显样式',
  `is_default` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_code`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=121 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='字典数据表';

####################
##  sys_dict_data data
####################

####################
##  sys_dict_data data
####################
INSERT INTO `sys_dict_data`(`dict_type`,`create_time`,`dict_sort`,`remark`,`is_default`,`dict_code`,`dict_label`,`css_class`,`create_by`,`dict_value`,`update_by`,`list_class`,`status`) VALUES ('sys_user_sex','2024-08-14T02:48:24',1,'性别男','Y',1,'男','','admin','0','','','0');
INSERT INTO `sys_dict_data`(`dict_type`,`create_time`,`dict_sort`,`remark`,`is_default`,`dict_code`,`dict_label`,`css_class`,`create_by`,`dict_value`,`update_by`,`list_class`,`status`) VALUES ('sys_user_sex','2024-08-14T02:48:24',2,'性别女','N',2,'女','','admin','1','','','0');
INSERT INTO `sys_dict_data`(`dict_type`,`create_time`,`dict_sort`,`remark`,`is_default`,`dict_code`,`dict_label`,`css_class`,`create_by`,`dict_value`,`update_by`,`list_class`,`status`) VALUES ('sys_user_sex','2024-08-14T02:48:24',3,'性别未知','N',3,'未知','','admin','2','','','0');
INSERT INTO `sys_dict_data`(`dict_type`,`create_time`,`dict_sort`,`remark`,`is_default`,`dict_code`,`dict_label`,`css_class`,`create_by`,`dict_value`,`update_by`,`list_class`,`status`) VALUES ('sys_show_hide','2024-08-14T02:48:24',1,'显示菜单','Y',4,'显示','','admin','0','','primary','0');
INSERT INTO `sys_dict_data`(`dict_type`,`create_time`,`dict_sort`,`remark`,`is_default`,`dict_code`,`dict_label`,`css_class`,`create_by`,`dict_value`,`update_by`,`list_class`,`status`) VALUES ('sys_show_hide','2024-08-14T02:48:24',2,'隐藏菜单','N',5,'隐藏','','admin','1','','danger','0');
INSERT INTO `sys_dict_data`(`dict_type`,`create_time`,`dict_sort`,`remark`,`is_default`,`dict_code`,`dict_label`,`css_class`,`create_by`,`dict_value`,`update_by`,`list_class`,`status`) VALUES ('sys_normal_disable','2024-08-14T02:48:24',1,'正常状态','Y',6,'正常','','admin','0','','primary','0');
INSERT INTO `sys_dict_data`(`dict_type`,`create_time`,`dict_sort`,`remark`,`is_default`,`dict_code`,`dict_label`,`css_class`,`create_by`,`dict_value`,`update_by`,`list_class`,`status`) VALUES ('sys_normal_disable','2024-08-14T02:48:24',2,'停用状态','N',7,'停用','','admin','1','','danger','0');
INSERT INTO `sys_dict_data`(`dict_type`,`create_time`,`dict_sort`,`remark`,`is_default`,`dict_code`,`dict_label`,`css_class`,`create_by`,`dict_value`,`update_by`,`list_class`,`status`) VALUES ('sys_job_status','2024-08-14T02:48:24',1,'正常状态','Y',8,'正常','','admin','0','','primary','0');
INSERT INTO `sys_dict_data`(`dict_type`,`create_time`,`dict_sort`,`remark`,`is_default`,`dict_code`,`dict_label`,`css_class`,`create_by`,`dict_value`,`update_by`,`list_class`,`status`) VALUES ('sys_job_status','2024-08-14T02:48:24',2,'停用状态','N',9,'暂停','','admin','1','','danger','0');
INSERT INTO `sys_dict_data`(`dict_type`,`create_time`,`dict_sort`,`remark`,`is_default`,`dict_code`,`dict_label`,`css_class`,`create_by`,`dict_value`,`update_by`,`list_class`,`status`) VALUES ('sys_job_group','2024-08-14T02:48:24',1,'默认分组','Y',10,'默认','','admin','DEFAULT','','','0');
INSERT INTO `sys_dict_data`(`dict_type`,`create_time`,`dict_sort`,`remark`,`is_default`,`dict_code`,`dict_label`,`css_class`,`create_by`,`dict_value`,`update_by`,`list_class`,`status`) VALUES ('sys_job_group','2024-08-14T02:48:24',2,'系统分组','N',11,'系统','','admin','SYSTEM','','','0');
INSERT INTO `sys_dict_data`(`dict_type`,`create_time`,`dict_sort`,`remark`,`is_default`,`dict_code`,`dict_label`,`css_class`,`create_by`,`dict_value`,`update_by`,`list_class`,`status`) VALUES ('sys_yes_no','2024-08-14T02:48:24',1,'系统默认是','Y',12,'是','','admin','Y','','primary','0');
INSERT INTO `sys_dict_data`(`dict_type`,`create_time`,`dict_sort`,`remark`,`is_default`,`dict_code`,`dict_label`,`css_class`,`create_by`,`dict_value`,`update_by`,`list_class`,`status`) VALUES ('sys_yes_no','2024-08-14T02:48:24',2,'系统默认否','N',13,'否','','admin','N','','danger','0');
INSERT INTO `sys_dict_data`(`dict_type`,`create_time`,`dict_sort`,`remark`,`is_default`,`dict_code`,`dict_label`,`css_class`,`create_by`,`dict_value`,`update_by`,`list_class`,`status`) VALUES ('sys_notice_type','2024-08-14T02:48:24',1,'通知','Y',14,'通知','','admin','1','','warning','0');
INSERT INTO `sys_dict_data`(`dict_type`,`create_time`,`dict_sort`,`remark`,`is_default`,`dict_code`,`dict_label`,`css_class`,`create_by`,`dict_value`,`update_by`,`list_class`,`status`) VALUES ('sys_notice_type','2024-08-14T02:48:24',2,'公告','N',15,'公告','','admin','2','','success','0');
INSERT INTO `sys_dict_data`(`dict_type`,`create_time`,`dict_sort`,`remark`,`is_default`,`dict_code`,`dict_label`,`css_class`,`create_by`,`dict_value`,`update_by`,`list_class`,`status`) VALUES ('sys_notice_status','2024-08-14T02:48:24',1,'正常状态','Y',16,'正常','','admin','0','','primary','0');
INSERT INTO `sys_dict_data`(`dict_type`,`create_time`,`dict_sort`,`remark`,`is_default`,`dict_code`,`dict_label`,`css_class`,`create_by`,`dict_value`,`update_by`,`list_class`,`status`) VALUES ('sys_notice_status','2024-08-14T02:48:24',2,'关闭状态','N',17,'关闭','','admin','1','','danger','0');
INSERT INTO `sys_dict_data`(`dict_type`,`create_time`,`dict_sort`,`remark`,`is_default`,`dict_code`,`dict_label`,`css_class`,`create_by`,`dict_value`,`update_by`,`list_class`,`status`) VALUES ('sys_oper_type','2024-08-14T02:48:24',99,'其他操作','N',18,'其他','','admin','0','','info','0');
INSERT INTO `sys_dict_data`(`dict_type`,`create_time`,`dict_sort`,`remark`,`is_default`,`dict_code`,`dict_label`,`css_class`,`create_by`,`dict_value`,`update_by`,`list_class`,`status`) VALUES ('sys_oper_type','2024-08-14T02:48:24',1,'新增操作','N',19,'新增','','admin','1','','info','0');
INSERT INTO `sys_dict_data`(`dict_type`,`create_time`,`dict_sort`,`remark`,`is_default`,`dict_code`,`dict_label`,`css_class`,`create_by`,`dict_value`,`update_by`,`list_class`,`status`) VALUES ('sys_oper_type','2024-08-14T02:48:24',2,'修改操作','N',20,'修改','','admin','2','','info','0');
INSERT INTO `sys_dict_data`(`dict_type`,`create_time`,`dict_sort`,`remark`,`is_default`,`dict_code`,`dict_label`,`css_class`,`create_by`,`dict_value`,`update_by`,`list_class`,`status`) VALUES ('sys_oper_type','2024-08-14T02:48:24',3,'删除操作','N',21,'删除','','admin','3','','danger','0');
INSERT INTO `sys_dict_data`(`dict_type`,`create_time`,`dict_sort`,`remark`,`is_default`,`dict_code`,`dict_label`,`css_class`,`create_by`,`dict_value`,`update_by`,`list_class`,`status`) VALUES ('sys_oper_type','2024-08-14T02:48:24',4,'授权操作','N',22,'授权','','admin','4','','primary','0');
INSERT INTO `sys_dict_data`(`dict_type`,`create_time`,`dict_sort`,`remark`,`is_default`,`dict_code`,`dict_label`,`css_class`,`create_by`,`dict_value`,`update_by`,`list_class`,`status`) VALUES ('sys_oper_type','2024-08-14T02:48:24',5,'导出操作','N',23,'导出','','admin','5','','warning','0');
INSERT INTO `sys_dict_data`(`dict_type`,`create_time`,`dict_sort`,`remark`,`is_default`,`dict_code`,`dict_label`,`css_class`,`create_by`,`dict_value`,`update_by`,`list_class`,`status`) VALUES ('sys_oper_type','2024-08-14T02:48:24',6,'导入操作','N',24,'导入','','admin','6','','warning','0');
INSERT INTO `sys_dict_data`(`dict_type`,`create_time`,`dict_sort`,`remark`,`is_default`,`dict_code`,`dict_label`,`css_class`,`create_by`,`dict_value`,`update_by`,`list_class`,`status`) VALUES ('sys_oper_type','2024-08-14T02:48:24',7,'强退操作','N',25,'强退','','admin','7','','danger','0');
INSERT INTO `sys_dict_data`(`dict_type`,`create_time`,`dict_sort`,`remark`,`is_default`,`dict_code`,`dict_label`,`css_class`,`create_by`,`dict_value`,`update_by`,`list_class`,`status`) VALUES ('sys_oper_type','2024-08-14T02:48:24',8,'生成操作','N',26,'生成代码','','admin','8','','warning','0');
INSERT INTO `sys_dict_data`(`dict_type`,`create_time`,`dict_sort`,`remark`,`is_default`,`dict_code`,`dict_label`,`css_class`,`create_by`,`dict_value`,`update_by`,`list_class`,`status`) VALUES ('sys_oper_type','2024-08-14T02:48:24',9,'清空操作','N',27,'清空数据','','admin','9','','danger','0');
INSERT INTO `sys_dict_data`(`dict_type`,`create_time`,`dict_sort`,`remark`,`is_default`,`dict_code`,`dict_label`,`css_class`,`create_by`,`dict_value`,`update_by`,`list_class`,`status`) VALUES ('sys_common_status','2024-08-14T02:48:24',1,'正常状态','N',28,'成功','','admin','0','','primary','0');
INSERT INTO `sys_dict_data`(`dict_type`,`create_time`,`dict_sort`,`remark`,`is_default`,`dict_code`,`dict_label`,`css_class`,`create_by`,`dict_value`,`update_by`,`list_class`,`status`) VALUES ('sys_common_status','2024-08-14T02:48:24',2,'停用状态','N',29,'失败','','admin','1','','danger','0');
INSERT INTO `sys_dict_data`(`dict_type`,`create_time`,`dict_sort`,`is_default`,`dict_code`,`dict_label`,`create_by`,`dict_value`,`update_by`,`list_class`,`status`) VALUES ('nursing_project_status','2024-08-18T02:41:15',0,'N',100,'启用','admin','1','','default','0');
INSERT INTO `sys_dict_data`(`dict_type`,`create_time`,`dict_sort`,`is_default`,`dict_code`,`dict_label`,`create_by`,`dict_value`,`update_by`,`list_class`,`status`) VALUES ('nursing_project_status','2024-08-18T02:41:30',0,'N',101,'禁用','admin','0','','default','0');
INSERT INTO `sys_dict_data`(`dict_type`,`create_time`,`dict_sort`,`is_default`,`dict_code`,`dict_label`,`create_by`,`dict_value`,`update_by`,`list_class`,`status`) VALUES ('nursing_plan_status','2024-08-19T11:00:04',0,'N',103,'启用','admin','1','','default','0');
INSERT INTO `sys_dict_data`(`dict_type`,`create_time`,`dict_sort`,`is_default`,`dict_code`,`dict_label`,`create_by`,`dict_value`,`update_by`,`list_class`,`status`) VALUES ('nursing_plan_status','2024-08-19T11:00:10',0,'N',104,'禁用','admin','2','','default','0');
INSERT INTO `sys_dict_data`(`dict_type`,`create_time`,`dict_sort`,`is_default`,`dict_code`,`dict_label`,`create_by`,`dict_value`,`update_by`,`list_class`,`status`) VALUES ('nursing_level_status','2024-08-20T03:04:14',0,'N',105,'启用','admin','1','','default','0');
INSERT INTO `sys_dict_data`(`dict_type`,`create_time`,`dict_sort`,`is_default`,`dict_code`,`dict_label`,`create_by`,`dict_value`,`update_by`,`list_class`,`status`) VALUES ('nursing_level_status','2024-08-20T03:04:21',0,'N',106,'禁用','admin','0','','default','0');
INSERT INTO `sys_dict_data`(`dict_type`,`create_time`,`dict_sort`,`is_default`,`dict_code`,`dict_label`,`create_by`,`dict_value`,`update_by`,`list_class`,`status`) VALUES ('admission_status','2026-03-21T12:58:22',0,'N',114,'已入住','admin','0','','default','0');
INSERT INTO `sys_dict_data`(`dict_type`,`create_time`,`dict_sort`,`is_default`,`dict_code`,`dict_label`,`create_by`,`dict_value`,`update_by`,`list_class`,`status`) VALUES ('admission_status','2026-03-21T12:58:28',0,'N',115,'未入住','admin','1','','default','0');
INSERT INTO `sys_dict_data`(`dict_type`,`create_time`,`dict_sort`,`is_default`,`dict_code`,`dict_label`,`create_by`,`dict_value`,`update_by`,`list_class`,`status`) VALUES ('device_location_type','2026-03-21T12:58:44',0,'N',116,'随身设备','admin','0','','default','0');
INSERT INTO `sys_dict_data`(`dict_type`,`create_time`,`dict_sort`,`is_default`,`dict_code`,`dict_label`,`create_by`,`dict_value`,`update_by`,`list_class`,`status`) VALUES ('device_location_type','2026-03-21T12:58:51',0,'N',117,'固定设备','admin','1','','default','0');
INSERT INTO `sys_dict_data`(`dict_type`,`create_time`,`dict_sort`,`is_default`,`dict_code`,`dict_label`,`create_by`,`dict_value`,`update_by`,`list_class`,`status`) VALUES ('evaluation_progress','2026-03-21T12:59:03',0,'N',118,'评估中','admin','0','','default','0');
INSERT INTO `sys_dict_data`(`dict_type`,`create_time`,`dict_sort`,`is_default`,`dict_code`,`dict_label`,`create_by`,`dict_value`,`update_by`,`list_class`,`status`) VALUES ('evaluation_progress','2026-03-21T12:59:09',0,'N',119,'已完成','admin','1','','default','0');
INSERT INTO `sys_dict_data`(`dict_type`,`create_time`,`dict_sort`,`is_default`,`dict_code`,`dict_label`,`create_by`,`dict_value`,`update_by`,`list_class`,`status`) VALUES ('evaluation_progress','2026-03-21T12:59:15',0,'N',120,'已取消','admin','2','','default','0');

####################
##  sys_dict_type
####################
DROP TABLE IF EXISTS `sys_dict_type`;

####################
##  table sys_dict_type ddl
####################
CREATE TABLE `sys_dict_type` (
  `dict_id` bigint NOT NULL AUTO_INCREMENT COMMENT '字典主键',
  `dict_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '字典类型',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`) USING BTREE,
  UNIQUE KEY `dict_type` (`dict_type`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=109 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='字典类型表';

####################
##  sys_dict_type data
####################

####################
##  sys_dict_type data
####################
INSERT INTO `sys_dict_type`(`dict_type`,`create_by`,`dict_id`,`dict_name`,`create_time`,`remark`,`update_by`,`status`) VALUES ('sys_user_sex','admin',1,'用户性别','2024-08-14T02:48:24','用户性别列表','','0');
INSERT INTO `sys_dict_type`(`dict_type`,`create_by`,`dict_id`,`dict_name`,`create_time`,`remark`,`update_by`,`status`) VALUES ('sys_show_hide','admin',2,'菜单状态','2024-08-14T02:48:24','菜单状态列表','','0');
INSERT INTO `sys_dict_type`(`dict_type`,`create_by`,`dict_id`,`dict_name`,`create_time`,`remark`,`update_by`,`status`) VALUES ('sys_normal_disable','admin',3,'系统开关','2024-08-14T02:48:24','系统开关列表','','0');
INSERT INTO `sys_dict_type`(`dict_type`,`create_by`,`dict_id`,`dict_name`,`create_time`,`remark`,`update_by`,`status`) VALUES ('sys_job_status','admin',4,'任务状态','2024-08-14T02:48:24','任务状态列表','','0');
INSERT INTO `sys_dict_type`(`dict_type`,`create_by`,`dict_id`,`dict_name`,`create_time`,`remark`,`update_by`,`status`) VALUES ('sys_job_group','admin',5,'任务分组','2024-08-14T02:48:24','任务分组列表','','0');
INSERT INTO `sys_dict_type`(`dict_type`,`create_by`,`dict_id`,`dict_name`,`create_time`,`remark`,`update_by`,`status`) VALUES ('sys_yes_no','admin',6,'系统是否','2024-08-14T02:48:24','系统是否列表','','0');
INSERT INTO `sys_dict_type`(`dict_type`,`create_by`,`dict_id`,`dict_name`,`create_time`,`remark`,`update_by`,`status`) VALUES ('sys_notice_type','admin',7,'通知类型','2024-08-14T02:48:24','通知类型列表','','0');
INSERT INTO `sys_dict_type`(`dict_type`,`create_by`,`dict_id`,`dict_name`,`create_time`,`remark`,`update_by`,`status`) VALUES ('sys_notice_status','admin',8,'通知状态','2024-08-14T02:48:24','通知状态列表','','0');
INSERT INTO `sys_dict_type`(`dict_type`,`create_by`,`dict_id`,`dict_name`,`create_time`,`remark`,`update_by`,`status`) VALUES ('sys_oper_type','admin',9,'操作类型','2024-08-14T02:48:24','操作类型列表','','0');
INSERT INTO `sys_dict_type`(`dict_type`,`create_by`,`dict_id`,`dict_name`,`create_time`,`remark`,`update_by`,`status`) VALUES ('sys_common_status','admin',10,'系统状态','2024-08-14T02:48:24','登录状态列表','','0');
INSERT INTO `sys_dict_type`(`dict_type`,`create_by`,`dict_id`,`dict_name`,`create_time`,`update_by`,`status`) VALUES ('nursing_project_status','admin',100,'护理项目状态','2024-08-18T02:40:48','','0');
INSERT INTO `sys_dict_type`(`dict_type`,`create_by`,`dict_id`,`dict_name`,`create_time`,`update_by`,`status`) VALUES ('nursing_plan_status','admin',101,'护理计划状态','2024-08-19T10:59:40','','0');
INSERT INTO `sys_dict_type`(`dict_type`,`create_by`,`dict_id`,`dict_name`,`create_time`,`update_by`,`status`) VALUES ('nursing_level_status','admin',102,'护理等级状态','2024-08-20T03:04:03','','0');
INSERT INTO `sys_dict_type`(`dict_type`,`create_by`,`dict_id`,`dict_name`,`create_time`,`update_by`,`status`) VALUES ('admission_status','admin',106,'健康评估-入住状态','2026-03-21T12:57:21','','0');
INSERT INTO `sys_dict_type`(`dict_type`,`create_by`,`dict_id`,`dict_name`,`create_time`,`update_by`,`status`) VALUES ('device_location_type','admin',107,'设备位置','2026-03-21T12:57:33','','0');
INSERT INTO `sys_dict_type`(`dict_type`,`create_by`,`dict_id`,`dict_name`,`create_time`,`update_by`,`status`) VALUES ('evaluation_progress','admin',108,'评估进度','2026-03-21T12:57:41','','0');

####################
##  sys_job
####################
DROP TABLE IF EXISTS `sys_job`;

####################
##  table sys_job ddl
####################
CREATE TABLE `sys_job` (
  `job_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'DEFAULT' COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调用目标字符串',
  `cron_expression` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'cron执行表达式',
  `misfire_policy` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '3' COMMENT '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
  `concurrent` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '1' COMMENT '是否并发执行（0允许 1禁止）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '状态（0正常 1暂停）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '备注信息',
  PRIMARY KEY (`job_id`,`job_name`,`job_group`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=112 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='定时任务调度表';

####################
##  sys_job data
####################

####################
##  sys_job data
####################
INSERT INTO `sys_job`(`misfire_policy`,`create_time`,`job_group`,`concurrent`,`remark`,`invoke_target`,`create_by`,`job_name`,`cron_expression`,`job_id`,`update_by`,`status`) VALUES ('3','2024-08-14T02:48:24','DEFAULT','1','','ryTask.ryNoParams','admin','系统默认（无参）','0/10 * * * * ?',1,'','1');
INSERT INTO `sys_job`(`misfire_policy`,`create_time`,`job_group`,`concurrent`,`remark`,`invoke_target`,`create_by`,`job_name`,`cron_expression`,`job_id`,`update_by`,`status`) VALUES ('3','2024-08-14T02:48:24','DEFAULT','1','','ryTask.ryParams(\'ry\')','admin','系统默认（有参）','0/15 * * * * ?',2,'','1');
INSERT INTO `sys_job`(`misfire_policy`,`create_time`,`job_group`,`concurrent`,`remark`,`invoke_target`,`create_by`,`job_name`,`cron_expression`,`job_id`,`update_by`,`status`) VALUES ('3','2024-08-14T02:48:24','DEFAULT','1','','ryTask.ryMultipleParams(\'ry\', true, 2000L, 316.50D, 100)','admin','系统默认（多参）','0/20 * * * * ?',3,'','1');
INSERT INTO `sys_job`(`misfire_policy`,`create_time`,`job_group`,`concurrent`,`remark`,`invoke_target`,`create_by`,`update_time`,`job_name`,`cron_expression`,`job_id`,`update_by`,`status`) VALUES ('1','2026-04-04T01:11:49','DEFAULT','1','','helloJob.hello','admin','2026-04-04T01:42:56','测试任务','0/5 * * * * ?',108,'admin','1');
INSERT INTO `sys_job`(`misfire_policy`,`create_time`,`job_group`,`concurrent`,`remark`,`invoke_target`,`create_by`,`update_time`,`job_name`,`cron_expression`,`job_id`,`update_by`,`status`) VALUES ('1','2026-04-04T01:42:28','DEFAULT','1','','contractStatusJob.updateContractStatus','admin','2026-04-04T01:43:12','定时更新合同状态','0 0 1 * * ?',109,'admin','1');
INSERT INTO `sys_job`(`misfire_policy`,`create_time`,`job_group`,`concurrent`,`remark`,`invoke_target`,`create_by`,`job_name`,`cron_expression`,`job_id`,`update_by`,`status`) VALUES ('1','2026-04-10T02:35:55','DEFAULT','1','','alertJob.deviceDataAlertFilter','admin','设备数据报警过滤定时任务','0 1 * * * ?',111,'','1');
INSERT INTO `sys_job`(`misfire_policy`,`create_time`,`job_group`,`concurrent`,`remark`,`invoke_target`,`create_by`,`job_name`,`cron_expression`,`job_id`,`update_by`,`status`) VALUES ('1','2026-04-11T11:04:28','DEFAULT','1','','createNursingTaskJob.createNursingTaskJob','admin','月度护理任务定时生成','0 0 1 1 * ?',112,'','1');


####################
##  sys_job_log
####################
DROP TABLE IF EXISTS `sys_job_log`;

####################
##  table sys_job_log ddl
####################
CREATE TABLE `sys_job_log` (
  `job_log_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务日志ID',
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调用目标字符串',
  `job_message` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '日志信息',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '执行状态（0正常 1失败）',
  `exception_info` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '异常信息',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`job_log_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='定时任务调度日志表';

####################
##  sys_job_log data
####################

####################
##  sys_job_log data
####################

####################
##  sys_logininfor
####################
DROP TABLE IF EXISTS `sys_logininfor`;

####################
##  table sys_logininfor ddl
####################
CREATE TABLE `sys_logininfor` (
  `info_id` bigint NOT NULL AUTO_INCREMENT COMMENT '访问ID',
  `user_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '用户账号',
  `ipaddr` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '登录IP地址',
  `login_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '操作系统',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
  `msg` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '提示消息',
  `login_time` datetime DEFAULT NULL COMMENT '访问时间',
  PRIMARY KEY (`info_id`) USING BTREE,
  KEY `idx_sys_logininfor_s` (`status`) USING BTREE,
  KEY `idx_sys_logininfor_lt` (`login_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='系统访问记录';

####################
##  sys_logininfor data
####################

####################
##  sys_logininfor data
####################

####################
##  sys_menu
####################
DROP TABLE IF EXISTS `sys_menu`;

####################
##  table sys_menu ddl
####################
CREATE TABLE `sys_menu` (
  `menu_id` bigint NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `menu_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '菜单名称',
  `parent_id` bigint DEFAULT '0' COMMENT '父菜单ID',
  `order_num` int DEFAULT '0' COMMENT '显示顺序',
  `path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '路由地址',
  `component` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '组件路径',
  `query` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '路由参数',
  `route_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '路由名称',
  `is_frame` int DEFAULT '1' COMMENT '是否为外链（0是 1否）',
  `is_cache` int DEFAULT '0' COMMENT '是否缓存（0缓存 1不缓存）',
  `menu_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `visible` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '菜单状态（0显示 1隐藏）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '菜单状态（0正常 1停用）',
  `perms` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '#' COMMENT '菜单图标',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2065 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='菜单权限表';

####################
##  sys_menu data
####################

####################
##  sys_menu data
####################
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`query`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`update_time`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-14T02:48:23','','M','',0,'icon_xtgl','系统管理目录',1,'admin','system','2026-03-10T11:02:46',0,'系统管理','',6,'admin',1,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`query`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`update_time`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-14T02:48:23','','M','',0,'icon_xtjk','系统监控目录',1,'admin','monitor','2026-03-10T11:03:03',0,'系统监控','',7,'admin',2,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`query`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`update_time`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-14T02:48:23','','M','',0,'icon_xtgj','系统工具目录',1,'admin','tool','2026-03-10T11:03:21',0,'系统工具','',8,'admin',3,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`query`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`update_time`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('1','2024-08-14T02:48:23','','M','',0,'guide','若依官网地址',0,'admin','http://ruoyi.vip','2024-08-20T01:57:10',0,'若依官网','',4,'admin',4,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`query`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-14T02:48:23','','C','',0,'user','用户管理菜单',1,'admin','user','system/user/index',1,'用户管理','system:user:list',1,'',100,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`query`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-14T02:48:23','','C','',0,'peoples','角色管理菜单',1,'admin','role','system/role/index',1,'角色管理','system:role:list',2,'',101,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`query`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-14T02:48:23','','C','',0,'tree-table','菜单管理菜单',1,'admin','menu','system/menu/index',1,'菜单管理','system:menu:list',3,'',102,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`query`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-14T02:48:23','','C','',0,'tree','部门管理菜单',1,'admin','dept','system/dept/index',1,'部门管理','system:dept:list',4,'',103,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`query`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-14T02:48:23','','C','',0,'post','岗位管理菜单',1,'admin','post','system/post/index',1,'岗位管理','system:post:list',5,'',104,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`query`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-14T02:48:23','','C','',0,'dict','字典管理菜单',1,'admin','dict','system/dict/index',1,'字典管理','system:dict:list',6,'',105,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`query`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-14T02:48:23','','C','',0,'edit','参数设置菜单',1,'admin','config','system/config/index',1,'参数设置','system:config:list',7,'',106,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`query`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-14T02:48:23','','C','',0,'message','通知公告菜单',1,'admin','notice','system/notice/index',1,'通知公告','system:notice:list',8,'',107,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`query`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-14T02:48:23','','M','',0,'log','日志管理菜单',1,'admin','log','',1,'日志管理','',9,'',108,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`query`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-14T02:48:23','','C','',0,'online','在线用户菜单',1,'admin','online','monitor/online/index',2,'在线用户','monitor:online:list',1,'',109,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`query`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-14T02:48:23','','C','',0,'job','定时任务菜单',1,'admin','job','monitor/job/index',2,'定时任务','monitor:job:list',2,'',110,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`query`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-14T02:48:23','','C','',0,'druid','数据监控菜单',1,'admin','druid','monitor/druid/index',2,'数据监控','monitor:druid:list',3,'',111,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`query`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-14T02:48:23','','C','',0,'server','服务监控菜单',1,'admin','server','monitor/server/index',2,'服务监控','monitor:server:list',4,'',112,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`query`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-14T02:48:23','','C','',0,'redis','缓存监控菜单',1,'admin','cache','monitor/cache/index',2,'缓存监控','monitor:cache:list',5,'',113,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`query`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-14T02:48:23','','C','',0,'redis-list','缓存列表菜单',1,'admin','cacheList','monitor/cache/list',2,'缓存列表','monitor:cache:list',6,'',114,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`query`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-14T02:48:23','','C','',0,'build','表单构建菜单',1,'admin','build','tool/build/index',3,'表单构建','tool:build:list',1,'',115,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`query`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-14T02:48:23','','C','',0,'code','代码生成菜单',1,'admin','gen','tool/gen/index',3,'代码生成','tool:gen:list',2,'',116,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`query`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-14T02:48:23','','C','',0,'swagger','系统接口菜单',1,'admin','swagger','tool/swagger/index',3,'系统接口','tool:swagger:list',3,'',117,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`query`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-14T02:48:23','','C','',0,'form','操作日志菜单',1,'admin','operlog','monitor/operlog/index',108,'操作日志','monitor:operlog:list',1,'',500,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`query`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-14T02:48:23','','C','',0,'logininfor','登录日志菜单',1,'admin','logininfor','monitor/logininfor/index',108,'登录日志','monitor:logininfor:list',2,'',501,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`query`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-14T02:48:23','','F','',0,'#','',1,'admin','','',100,'用户查询','system:user:query',1,'',1000,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`query`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-14T02:48:23','','F','',0,'#','',1,'admin','','',100,'用户新增','system:user:add',2,'',1001,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`query`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-14T02:48:23','','F','',0,'#','',1,'admin','','',100,'用户修改','system:user:edit',3,'',1002,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`query`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-14T02:48:23','','F','',0,'#','',1,'admin','','',100,'用户删除','system:user:remove',4,'',1003,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`query`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-14T02:48:23','','F','',0,'#','',1,'admin','','',100,'用户导出','system:user:export',5,'',1004,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`query`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-14T02:48:23','','F','',0,'#','',1,'admin','','',100,'用户导入','system:user:import',6,'',1005,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`query`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-14T02:48:23','','F','',0,'#','',1,'admin','','',100,'重置密码','system:user:resetPwd',7,'',1006,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`query`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-14T02:48:23','','F','',0,'#','',1,'admin','','',101,'角色查询','system:role:query',1,'',1007,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`query`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-14T02:48:23','','F','',0,'#','',1,'admin','','',101,'角色新增','system:role:add',2,'',1008,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`query`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-14T02:48:23','','F','',0,'#','',1,'admin','','',101,'角色修改','system:role:edit',3,'',1009,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`query`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-14T02:48:23','','F','',0,'#','',1,'admin','','',101,'角色删除','system:role:remove',4,'',1010,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`query`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-14T02:48:23','','F','',0,'#','',1,'admin','','',101,'角色导出','system:role:export',5,'',1011,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`query`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-14T02:48:23','','F','',0,'#','',1,'admin','','',102,'菜单查询','system:menu:query',1,'',1012,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`query`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-14T02:48:23','','F','',0,'#','',1,'admin','','',102,'菜单新增','system:menu:add',2,'',1013,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`query`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-14T02:48:23','','F','',0,'#','',1,'admin','','',102,'菜单修改','system:menu:edit',3,'',1014,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`query`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-14T02:48:23','','F','',0,'#','',1,'admin','','',102,'菜单删除','system:menu:remove',4,'',1015,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`query`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-14T02:48:23','','F','',0,'#','',1,'admin','','',103,'部门查询','system:dept:query',1,'',1016,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`query`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-14T02:48:23','','F','',0,'#','',1,'admin','','',103,'部门新增','system:dept:add',2,'',1017,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`query`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-14T02:48:23','','F','',0,'#','',1,'admin','','',103,'部门修改','system:dept:edit',3,'',1018,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`query`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-14T02:48:23','','F','',0,'#','',1,'admin','','',103,'部门删除','system:dept:remove',4,'',1019,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`query`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-14T02:48:23','','F','',0,'#','',1,'admin','','',104,'岗位查询','system:post:query',1,'',1020,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`query`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-14T02:48:23','','F','',0,'#','',1,'admin','','',104,'岗位新增','system:post:add',2,'',1021,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`query`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-14T02:48:23','','F','',0,'#','',1,'admin','','',104,'岗位修改','system:post:edit',3,'',1022,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`query`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-14T02:48:23','','F','',0,'#','',1,'admin','','',104,'岗位删除','system:post:remove',4,'',1023,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`query`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-14T02:48:23','','F','',0,'#','',1,'admin','','',104,'岗位导出','system:post:export',5,'',1024,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`query`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-14T02:48:23','','F','',0,'#','',1,'admin','#','',105,'字典查询','system:dict:query',1,'',1025,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`query`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-14T02:48:23','','F','',0,'#','',1,'admin','#','',105,'字典新增','system:dict:add',2,'',1026,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`query`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-14T02:48:23','','F','',0,'#','',1,'admin','#','',105,'字典修改','system:dict:edit',3,'',1027,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`query`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-14T02:48:23','','F','',0,'#','',1,'admin','#','',105,'字典删除','system:dict:remove',4,'',1028,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`query`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-14T02:48:23','','F','',0,'#','',1,'admin','#','',105,'字典导出','system:dict:export',5,'',1029,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`query`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-14T02:48:23','','F','',0,'#','',1,'admin','#','',106,'参数查询','system:config:query',1,'',1030,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`query`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-14T02:48:23','','F','',0,'#','',1,'admin','#','',106,'参数新增','system:config:add',2,'',1031,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`query`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-14T02:48:23','','F','',0,'#','',1,'admin','#','',106,'参数修改','system:config:edit',3,'',1032,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`query`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-14T02:48:23','','F','',0,'#','',1,'admin','#','',106,'参数删除','system:config:remove',4,'',1033,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`query`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-14T02:48:23','','F','',0,'#','',1,'admin','#','',106,'参数导出','system:config:export',5,'',1034,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`query`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-14T02:48:23','','F','',0,'#','',1,'admin','#','',107,'公告查询','system:notice:query',1,'',1035,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`query`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-14T02:48:23','','F','',0,'#','',1,'admin','#','',107,'公告新增','system:notice:add',2,'',1036,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`query`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-14T02:48:23','','F','',0,'#','',1,'admin','#','',107,'公告修改','system:notice:edit',3,'',1037,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`query`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-14T02:48:23','','F','',0,'#','',1,'admin','#','',107,'公告删除','system:notice:remove',4,'',1038,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`query`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-14T02:48:23','','F','',0,'#','',1,'admin','#','',500,'操作查询','monitor:operlog:query',1,'',1039,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`query`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-14T02:48:23','','F','',0,'#','',1,'admin','#','',500,'操作删除','monitor:operlog:remove',2,'',1040,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`query`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-14T02:48:23','','F','',0,'#','',1,'admin','#','',500,'日志导出','monitor:operlog:export',3,'',1041,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`query`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-14T02:48:23','','F','',0,'#','',1,'admin','#','',501,'登录查询','monitor:logininfor:query',1,'',1042,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`query`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-14T02:48:23','','F','',0,'#','',1,'admin','#','',501,'登录删除','monitor:logininfor:remove',2,'',1043,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`query`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-14T02:48:23','','F','',0,'#','',1,'admin','#','',501,'日志导出','monitor:logininfor:export',3,'',1044,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`query`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-14T02:48:23','','F','',0,'#','',1,'admin','#','',501,'账户解锁','monitor:logininfor:unlock',4,'',1045,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`query`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-14T02:48:23','','F','',0,'#','',1,'admin','#','',109,'在线查询','monitor:online:query',1,'',1046,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`query`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-14T02:48:23','','F','',0,'#','',1,'admin','#','',109,'批量强退','monitor:online:batchLogout',2,'',1047,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`query`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-14T02:48:23','','F','',0,'#','',1,'admin','#','',109,'单条强退','monitor:online:forceLogout',3,'',1048,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`query`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-14T02:48:23','','F','',0,'#','',1,'admin','#','',110,'任务查询','monitor:job:query',1,'',1049,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`query`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-14T02:48:23','','F','',0,'#','',1,'admin','#','',110,'任务新增','monitor:job:add',2,'',1050,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`query`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-14T02:48:23','','F','',0,'#','',1,'admin','#','',110,'任务修改','monitor:job:edit',3,'',1051,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`query`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-14T02:48:23','','F','',0,'#','',1,'admin','#','',110,'任务删除','monitor:job:remove',4,'',1052,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`query`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-14T02:48:23','','F','',0,'#','',1,'admin','#','',110,'状态修改','monitor:job:changeStatus',5,'',1053,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`query`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-14T02:48:23','','F','',0,'#','',1,'admin','#','',110,'任务导出','monitor:job:export',6,'',1054,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`query`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-14T02:48:23','','F','',0,'#','',1,'admin','#','',116,'生成查询','tool:gen:query',1,'',1055,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`query`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-14T02:48:23','','F','',0,'#','',1,'admin','#','',116,'生成修改','tool:gen:edit',2,'',1056,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`query`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-14T02:48:23','','F','',0,'#','',1,'admin','#','',116,'生成删除','tool:gen:remove',3,'',1057,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`query`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-14T02:48:23','','F','',0,'#','',1,'admin','#','',116,'导入代码','tool:gen:import',4,'',1058,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`query`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-14T02:48:23','','F','',0,'#','',1,'admin','#','',116,'预览代码','tool:gen:preview',5,'',1059,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`query`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-14T02:48:23','','F','',0,'#','',1,'admin','#','',116,'生成代码','tool:gen:code',6,'',1060,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`update_time`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-14T02:59:12','','M',0,'icon_fwgl','',1,'admin','serve','2026-03-09T11:33:57',0,'服务管理','',4,'admin',2000,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`update_time`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-14T03:00:15','','C',0,'color','护理项目菜单',1,'admin','project','nursing/project/index','2025-04-18T10:24',2000,'护理项目','nursing:project:list',1,'admin',2001,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`update_time`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-14T03:00:15','','F',0,'#','',1,'admin','#','','2025-04-18T10:24:09',2001,'护理项目查询','nursing:project:query',1,'admin',2002,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`update_time`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-14T03:00:15','','F',0,'#','',1,'admin','#','','2025-04-18T10:24:13',2001,'护理项目新增','nursing:project:add',2,'admin',2003,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`update_time`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-14T03:00:15','','F',0,'#','',1,'admin','#','','2025-04-18T10:24:18',2001,'护理项目修改','nursing:project:edit',3,'admin',2004,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`update_time`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-14T03:00:15','','F',0,'#','',1,'admin','#','','2025-04-18T10:24:21',2001,'护理项目删除','nursing:project:remove',4,'admin',2005,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`update_time`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-14T03:00:15','','F',0,'#','',1,'admin','#','','2025-04-18T10:24:25',2001,'护理项目导出','nursing:project:export',5,'admin',2006,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`update_time`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-14T08:29:05','','C',0,'guide','护理等级菜单',1,'admin','nursingLevel','nursing/nursingLevel/index','2024-08-22T12:16:22',2000,'护理等级','nursing:nursingLevel:list',1,'admin',2007,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-14T08:29:05','','F',0,'#','',1,'admin','#','',2007,'护理等级查询','nursing:nursingLevel:query',1,'',2008,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-14T08:29:05','','F',0,'#','',1,'admin','#','',2007,'护理等级新增','nursing:nursingLevel:add',2,'',2009,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-14T08:29:05','','F',0,'#','',1,'admin','#','',2007,'护理等级修改','nursing:nursingLevel:edit',3,'',2010,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-14T08:29:05','','F',0,'#','',1,'admin','#','',2007,'护理等级删除','nursing:nursingLevel:remove',4,'',2011,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-14T08:29:05','','F',0,'#','',1,'admin','#','',2007,'护理等级导出','nursing:nursingLevel:export',5,'',2012,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`update_time`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-14T08:29:10','','C',0,'druid','护理计划菜单',1,'admin','nursingPlan','nursing/nursingPlan/index','2024-08-22T12:16:43',2000,'护理计划','nursing:nursingPlan:list',1,'admin',2013,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-14T08:29:10','','F',0,'#','',1,'admin','#','',2013,'护理计划查询','nursing:nursingPlan:query',1,'',2014,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-14T08:29:10','','F',0,'#','',1,'admin','#','',2013,'护理计划新增','nursing:nursingPlan:add',2,'',2015,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-14T08:29:10','','F',0,'#','',1,'admin','#','',2013,'护理计划修改','nursing:nursingPlan:edit',3,'',2016,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-14T08:29:10','','F',0,'#','',1,'admin','#','',2013,'护理计划删除','nursing:nursingPlan:remove',4,'',2017,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-14T08:29:10','','F',0,'#','',1,'admin','#','',2013,'护理计划导出','nursing:nursingPlan:export',5,'',2018,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`update_time`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-22T06:49:19','','M',0,'icon_zzgl','',1,'admin','liveIn','2026-03-09T11:32:42',0,'在住管理','',3,'admin',2019,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`parent_id`,`menu_name`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-22T06:50:50','','C',0,'size','',1,'admin','houseSet','nursing/roomType/index',2019,'房型设置',0,'',2020,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`parent_id`,`menu_name`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-22T08:15:05','','C',0,'tree-table','',1,'admin','floor','nursing/floor/index',2019,'床位预览',2,'',2021,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`update_time`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-23T12:52:34','','M',0,'component','',1,'admin','enterQuit','2024-08-29T06:42:15',0,'入退管理','',2,'admin',2022,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`update_time`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-23T13:13:48','','C',0,'edit','入住菜单',1,'admin','checkIn','nursing/checkIn/index','2024-08-24T02:58:12',2022,'入住办理','nursing:checkIn:list',1,'admin',2023,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-23T13:13:48','','F',0,'#','',1,'admin','#','',2023,'入住查询','nursing:checkIn:query',1,'',2024,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`update_time`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-23T13:13:48','','F',0,'#','',1,'admin','#','','2026-03-18T16:57:30',2023,'入住申请','nursing:checkIn:add',2,'admin',2025,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`update_time`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-23T13:13:48','','F',0,'#','',1,'admin','#','','2026-03-18T16:57:51',2023,'入住详情','nursing:checkIn:edit',3,'admin',2026,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-23T13:13:48','','F',0,'#','',1,'admin','#','',2023,'入住删除','nursing:checkIn:remove',4,'',2027,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-23T13:13:48','','F',0,'#','',1,'admin','#','',2023,'入住导出','nursing:checkIn:export',5,'',2028,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`parent_id`,`menu_name`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('1','2024-08-24T03:44:48','','C',0,'checkbox','',1,'admin','checkInInfo','nursing/checkIn/details',2022,'入住详情',0,'',2035,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`update_time`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-29T06:43:14','','M',0,'icon_znjc','',1,'admin','intelligence','2026-03-09T11:35:17',0,'智能监测','',5,'admin',2037,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`update_time`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-29T06:48:51','','C',0,'eye','',1,'admin','healthAssessment','nursing/healthAssessment/index','2026-03-06T16:51:20',2022,'健康评估','',0,'admin',2039,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`update_time`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('1','2024-08-29T06:49:53','','F',0,'#','',1,'admin','healthDetails','nursing/healthAssessment/details','2026-03-18T16:37:46',2022,'评估详情','enterQuit:healthAssessment:details',2,'admin',2040,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`update_time`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-29T06:52:12','','C',0,'peoples','',1,'admin','oldPeople','nursing/oldPeople/index','2024-08-29T06:52:23',2000,'负责老人','',4,'admin',2041,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`parent_id`,`menu_name`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-29T06:53:06','','C',0,'redis-list','',1,'admin','arrange','nursing/arrange/index',2000,'任务安排',5,'',2042,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`parent_id`,`menu_name`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('1','2024-08-29T06:53:37','','C',0,'#','',1,'admin','arrangeDetails','nursing/arrange/details',2000,'任务安排详情',1,'',2043,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`update_time`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-29T06:54:54','','C',0,'tool','',1,'admin','device','nursing/device/index','2024-08-29T07:13:42',2037,'设备管理','',0,'admin',2044,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`parent_id`,`menu_name`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('1','2024-08-29T06:55:25','','C',0,'#','',1,'admin','details','nursing/device/details',2037,'设备详情',0,'',2045,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`parent_id`,`menu_name`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('1','2024-08-29T06:56:01','','C',0,'#','',1,'admin','ruleDetails','nursing/alertRule/details',2037,'新增报警规则',0,'',2046,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`parent_id`,`menu_name`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-29T06:56:48','','C',0,'nested','',1,'admin','alertRule','nursing/alertRule/index',2037,'报警规则',1,'',2047,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`parent_id`,`menu_name`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2024-08-29T06:57:25','','C',0,'skill','',1,'admin','alertData','nursing/alertData/index',2037,'报警数据',2,'',2048,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`parent_id`,`menu_name`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2025-05-04T01:06:31','','C',0,'example','',1,'admin','smartBed','nursing/smartBed/index',2019,'智能床位',3,'',2050,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`update_time`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2025-07-16T22:26:29','','M',0,'icon_xhzx','',1,'admin','zhixun','2026-03-10T11:02:23',0,'星海智询','',0,'admin',2052,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`update_time`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2025-07-16T22:27:41','','C',0,'drag','',1,'admin','xiaozhi','nursing/zhixun/index','2025-07-16T23:33:43',2052,'小智','',1,'admin',2053,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`update_time`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2025-07-21T23:06:50','','C',0,'education','知识库菜单',1,'admin','knowledgeBase','nursing/knowledgeBase/index','2025-07-21T23:12:37',2052,'知识库','nursing:knowledgeBase:list',1,'admin',2055,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2025-07-21T23:06:50','','F',0,'#','',1,'admin','#','',2055,'知识库查询','nursing:knowledgeBase:query',1,'',2056,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2025-07-21T23:06:50','','F',0,'#','',1,'admin','#','',2055,'知识库新增','nursing:knowledgeBase:add',2,'',2057,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2025-07-21T23:06:50','','F',0,'#','',1,'admin','#','',2055,'知识库修改','nursing:knowledgeBase:edit',3,'',2058,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2025-07-21T23:06:50','','F',0,'#','',1,'admin','#','',2055,'知识库删除','nursing:knowledgeBase:remove',4,'',2059,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2025-07-21T23:06:50','','F',0,'#','',1,'admin','#','',2055,'知识库导出','nursing:knowledgeBase:export',5,'',2060,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`update_time`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('1','2026-02-05T11:51:18','','F',0,'drag','',1,'admin','detailsSteps','nursing/healthAssessment/detailsSteps','2026-03-18T16:36:39',2022,'新增修改评估','enterQuit:healthAssessment:detailsSteps',3,'admin',2061,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`update_time`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2026-03-10T17:00:58','','M',0,'icon_laifang','',1,'admin','appointment','2026-03-11T09:42:29',0,'来访管理','',1,'admin',2062,'0');
INSERT INTO `sys_menu`(`visible`,`create_time`,`route_name`,`menu_type`,`is_cache`,`icon`,`remark`,`is_frame`,`create_by`,`path`,`component`,`update_time`,`parent_id`,`menu_name`,`perms`,`order_num`,`update_by`,`menu_id`,`status`) VALUES ('0','2026-03-10T17:03:30','','C',0,'#','',1,'admin','reservation','nursing/reservation/index','2026-03-10T17:07:15',2062,'预约登记','',0,'admin',2063,'0');

####################
##  sys_notice
####################
DROP TABLE IF EXISTS `sys_notice`;

####################
##  table sys_notice ddl
####################
CREATE TABLE `sys_notice` (
  `notice_id` int NOT NULL AUTO_INCREMENT COMMENT '公告ID',
  `notice_title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '公告标题',
  `notice_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '公告类型（1通知 2公告）',
  `notice_content` longblob COMMENT '公告内容',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '公告状态（0正常 1关闭）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`notice_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='通知公告表';

####################
##  sys_notice data
####################

####################
##  sys_notice data
####################
INSERT INTO `sys_notice`(`notice_title`,`create_by`,`notice_content`,`create_time`,`remark`,`update_by`,`notice_id`,`notice_type`,`status`) VALUES ('温馨提醒：2018-07-01 若依新版本发布啦','admin',0xE696B0E78988E69CACE58685E5AEB9,'2024-08-14T02:48:24','管理员','',1,'2','0');
INSERT INTO `sys_notice`(`notice_title`,`create_by`,`notice_content`,`create_time`,`remark`,`update_by`,`notice_id`,`notice_type`,`status`) VALUES ('维护通知：2018-07-01 若依系统凌晨维护','admin',0xE7BBB4E68AA4E58685E5AEB9,'2024-08-14T02:48:24','管理员','',2,'1','0');

####################
##  sys_oper_log
####################
DROP TABLE IF EXISTS `sys_oper_log`;

####################
##  table sys_oper_log ddl
####################
CREATE TABLE `sys_oper_log` (
  `oper_id` bigint NOT NULL AUTO_INCREMENT COMMENT '日志主键',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '模块标题',
  `business_type` int DEFAULT '0' COMMENT '业务类型（0其它 1新增 2修改 3删除）',
  `method` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '方法名称',
  `request_method` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '请求方式',
  `operator_type` int DEFAULT '0' COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
  `oper_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '操作人员',
  `dept_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '部门名称',
  `oper_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '请求URL',
  `oper_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '主机地址',
  `oper_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '操作地点',
  `oper_param` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '请求参数',
  `json_result` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '返回参数',
  `status` int DEFAULT '0' COMMENT '操作状态（0正常 1异常）',
  `error_msg` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '错误消息',
  `oper_time` datetime DEFAULT NULL COMMENT '操作时间',
  `cost_time` bigint DEFAULT '0' COMMENT '消耗时间',
  PRIMARY KEY (`oper_id`) USING BTREE,
  KEY `idx_sys_oper_log_bt` (`business_type`) USING BTREE,
  KEY `idx_sys_oper_log_s` (`status`) USING BTREE,
  KEY `idx_sys_oper_log_ot` (`oper_time`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='操作日志记录';

####################
##  sys_oper_log data
####################

####################
##  sys_oper_log data
####################
INSERT INTO `sys_oper_log`(`oper_time`,`method`,`oper_param`,`oper_name`,`dept_name`,`request_method`,`title`,`oper_location`,`operator_type`,`oper_ip`,`json_result`,`cost_time`,`business_type`,`oper_url`,`oper_id`,`status`) VALUES ('2026-04-11T08:35:46','com.xhzb.web.controller.monitor.SysOperlogController.clean()','','admin','院长办公室','DELETE','操作日志','内网IP',1,'127.0.0.1','{`msg`:`操作成功`,`code`:200}',75,9,'/monitor/operlog/clean',1,0);
INSERT INTO `sys_oper_log`(`oper_time`,`method`,`oper_param`,`oper_name`,`dept_name`,`request_method`,`title`,`oper_location`,`operator_type`,`oper_ip`,`json_result`,`cost_time`,`business_type`,`oper_url`,`oper_id`,`status`) VALUES ('2026-04-11T08:35:50','com.xhzb.web.controller.monitor.SysLogininforController.clean()','','admin','院长办公室','DELETE','登录日志','内网IP',1,'127.0.0.1','{`msg`:`操作成功`,`code`:200}',54,9,'/monitor/logininfor/clean',2,0);
INSERT INTO `sys_oper_log`(`oper_time`,`method`,`oper_param`,`oper_name`,`dept_name`,`request_method`,`title`,`oper_location`,`operator_type`,`oper_ip`,`json_result`,`cost_time`,`business_type`,`oper_url`,`oper_id`,`status`) VALUES ('2026-04-11T08:35:59','com.xhzb.quartz.controller.SysJobLogController.clean()','','admin','院长办公室','DELETE','调度日志','内网IP',1,'127.0.0.1','{`msg`:`操作成功`,`code`:200}',47,9,'/monitor/jobLog/clean',3,0);

####################
##  sys_post
####################
DROP TABLE IF EXISTS `sys_post`;

####################
##  table sys_post ddl
####################
CREATE TABLE `sys_post` (
  `post_id` bigint NOT NULL AUTO_INCREMENT COMMENT '岗位ID',
  `post_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '岗位编码',
  `post_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '岗位名称',
  `post_sort` int NOT NULL COMMENT '显示顺序',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`post_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='岗位信息表';

####################
##  sys_post data
####################

####################
##  sys_post data
####################
INSERT INTO `sys_post`(`create_by`,`post_id`,`create_time`,`post_name`,`post_code`,`remark`,`update_by`,`post_sort`,`status`) VALUES ('admin',1,'2024-08-14T02:48:23','董事长','ceo','','',1,'0');
INSERT INTO `sys_post`(`create_by`,`post_id`,`create_time`,`post_name`,`post_code`,`remark`,`update_by`,`post_sort`,`status`) VALUES ('admin',2,'2024-08-14T02:48:23','项目经理','se','','',2,'0');
INSERT INTO `sys_post`(`create_by`,`post_id`,`create_time`,`post_name`,`post_code`,`remark`,`update_by`,`post_sort`,`status`) VALUES ('admin',3,'2024-08-14T02:48:23','人力资源','hr','','',3,'0');
INSERT INTO `sys_post`(`create_by`,`post_id`,`create_time`,`post_name`,`post_code`,`remark`,`update_by`,`post_sort`,`status`) VALUES ('admin',4,'2024-08-14T02:48:23','普通员工','user','','',4,'0');

####################
##  sys_role
####################
DROP TABLE IF EXISTS `sys_role`;

####################
##  table sys_role ddl
####################
CREATE TABLE `sys_role` (
  `role_id` bigint NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色名称',
  `role_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色权限字符串',
  `role_sort` int NOT NULL COMMENT '显示顺序',
  `data_scope` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  `menu_check_strictly` tinyint(1) DEFAULT '1' COMMENT '菜单树选择项是否关联显示',
  `dept_check_strictly` tinyint(1) DEFAULT '1' COMMENT '部门树选择项是否关联显示',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=105 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='角色信息表';

####################
##  sys_role data
####################

####################
##  sys_role data
####################
INSERT INTO `sys_role`(`role_sort`,`del_flag`,`create_time`,`menu_check_strictly`,`remark`,`dept_check_strictly`,`role_name`,`create_by`,`role_id`,`role_key`,`update_by`,`data_scope`,`status`) VALUES (1,'0','2024-08-14T02:48:23',true,'超级管理员',true,'超级管理员','admin',1,'admin','','1','0');
INSERT INTO `sys_role`(`role_sort`,`del_flag`,`create_time`,`menu_check_strictly`,`remark`,`dept_check_strictly`,`role_name`,`create_by`,`role_id`,`role_key`,`update_by`,`data_scope`,`status`) VALUES (2,'0','2024-08-14T02:48:23',true,'普通角色',true,'普通角色','admin',2,'common','','2','0');
INSERT INTO `sys_role`(`role_sort`,`del_flag`,`create_time`,`menu_check_strictly`,`dept_check_strictly`,`role_name`,`create_by`,`update_time`,`role_id`,`role_key`,`update_by`,`data_scope`,`status`) VALUES (0,'0','2025-04-25T15:21:26',true,true,'行政主管','admin','2025-07-16T19:25:31',100,'sys_role','admin','1','0');
INSERT INTO `sys_role`(`role_sort`,`del_flag`,`create_time`,`menu_check_strictly`,`dept_check_strictly`,`role_name`,`create_by`,`update_time`,`role_id`,`role_key`,`update_by`,`data_scope`,`status`) VALUES (0,'0','2025-04-26T01:33:42',true,true,'院长','admin','2026-04-06T01:38:22',101,'yuanzhang','admin','1','0');
INSERT INTO `sys_role`(`role_sort`,`del_flag`,`create_time`,`menu_check_strictly`,`dept_check_strictly`,`role_name`,`create_by`,`update_time`,`role_id`,`role_key`,`update_by`,`data_scope`,`status`) VALUES (5,'0','2025-05-04T04:14:26',true,true,'护理员','admin','2026-03-30T02:24:18',102,'nursing_elder','admin','1','0');
INSERT INTO `sys_role`(`role_sort`,`del_flag`,`create_time`,`menu_check_strictly`,`dept_check_strictly`,`role_name`,`create_by`,`update_time`,`role_id`,`role_key`,`update_by`,`data_scope`,`status`) VALUES (77,'0','2025-05-04T04:15:38',true,true,'行政','admin','2025-07-16T19:25:15',103,'administrator','admin','1','0');
INSERT INTO `sys_role`(`role_sort`,`del_flag`,`create_time`,`menu_check_strictly`,`dept_check_strictly`,`role_name`,`create_by`,`update_time`,`role_id`,`role_key`,`update_by`,`data_scope`,`status`) VALUES (0,'0','2026-03-10T15:14:27',true,true,'测试','admin','2026-03-16T17:56:55',104,'123','admin','1','0');

####################
##  sys_role_dept
####################
DROP TABLE IF EXISTS `sys_role_dept`;

####################
##  table sys_role_dept ddl
####################
CREATE TABLE `sys_role_dept` (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `dept_id` bigint NOT NULL COMMENT '部门ID',
  PRIMARY KEY (`role_id`,`dept_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='角色和部门关联表';

####################
##  sys_role_dept data
####################

####################
##  sys_role_dept data
####################
INSERT INTO `sys_role_dept`(`role_id`,`dept_id`) VALUES (2,100);
INSERT INTO `sys_role_dept`(`role_id`,`dept_id`) VALUES (2,101);
INSERT INTO `sys_role_dept`(`role_id`,`dept_id`) VALUES (2,105);

####################
##  sys_role_menu
####################
DROP TABLE IF EXISTS `sys_role_menu`;

####################
##  table sys_role_menu ddl
####################
CREATE TABLE `sys_role_menu` (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `menu_id` bigint NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`,`menu_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='角色和菜单关联表';

####################
##  sys_role_menu data
####################

####################
##  sys_role_menu data
####################
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (2,1);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (2,2);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (2,3);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (2,4);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (2,100);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (2,101);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (2,102);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (2,103);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (2,104);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (2,105);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (2,106);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (2,107);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (2,108);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (2,109);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (2,110);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (2,111);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (2,112);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (2,113);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (2,114);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (2,115);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (2,116);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (2,117);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (2,500);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (2,501);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (2,1000);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (2,1001);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (2,1002);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (2,1003);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (2,1004);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (2,1005);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (2,1006);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (2,1007);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (2,1008);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (2,1009);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (2,1010);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (2,1011);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (2,1012);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (2,1013);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (2,1014);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (2,1015);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (2,1016);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (2,1017);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (2,1018);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (2,1019);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (2,1020);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (2,1021);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (2,1022);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (2,1023);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (2,1024);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (2,1025);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (2,1026);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (2,1027);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (2,1028);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (2,1029);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (2,1030);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (2,1031);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (2,1032);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (2,1033);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (2,1034);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (2,1035);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (2,1036);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (2,1037);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (2,1038);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (2,1039);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (2,1040);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (2,1041);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (2,1042);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (2,1043);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (2,1044);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (2,1045);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (2,1046);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (2,1047);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (2,1048);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (2,1049);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (2,1050);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (2,1051);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (2,1052);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (2,1053);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (2,1054);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (2,1055);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (2,1056);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (2,1057);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (2,1058);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (2,1059);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (2,1060);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (100,1);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (100,2);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (100,3);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (100,100);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (100,101);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (100,102);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (100,103);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (100,104);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (100,105);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (100,106);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (100,107);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (100,108);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (100,109);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (100,110);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (100,111);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (100,112);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (100,113);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (100,114);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (100,115);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (100,116);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (100,117);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (100,500);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (100,501);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (100,1000);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (100,1001);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (100,1002);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (100,1003);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (100,1004);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (100,1005);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (100,1006);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (100,1007);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (100,1008);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (100,1009);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (100,1010);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (100,1011);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (100,1012);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (100,1013);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (100,1014);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (100,1015);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (100,1016);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (100,1017);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (100,1018);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (100,1019);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (100,1020);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (100,1021);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (100,1022);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (100,1023);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (100,1024);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (100,1025);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (100,1026);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (100,1027);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (100,1028);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (100,1029);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (100,1030);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (100,1031);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (100,1032);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (100,1033);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (100,1034);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (100,1035);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (100,1036);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (100,1037);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (100,1038);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (100,1039);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (100,1040);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (100,1041);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (100,1042);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (100,1043);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (100,1044);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (100,1045);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (100,1046);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (100,1047);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (100,1048);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (100,1049);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (100,1050);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (100,1051);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (100,1052);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (100,1053);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (100,1054);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (100,1055);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (100,1056);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (100,1057);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (100,1058);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (100,1059);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (100,1060);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (100,2000);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (100,2001);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (100,2002);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (100,2003);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (100,2004);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (100,2005);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (100,2006);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (100,2007);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (100,2008);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (100,2009);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (100,2010);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (100,2011);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (100,2012);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (100,2013);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (100,2014);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (100,2015);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (100,2016);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (100,2017);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (100,2018);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (100,2037);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (100,2041);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (100,2042);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (100,2043);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (100,2044);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (100,2045);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (100,2046);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (100,2047);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (100,2048);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,1);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,2);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,3);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,100);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,101);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,102);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,103);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,104);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,105);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,106);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,107);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,108);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,109);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,110);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,111);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,112);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,113);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,114);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,115);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,116);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,117);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,500);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,501);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,1000);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,1001);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,1002);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,1003);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,1004);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,1005);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,1006);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,1007);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,1008);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,1009);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,1010);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,1011);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,1012);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,1013);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,1014);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,1015);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,1016);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,1017);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,1018);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,1019);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,1020);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,1021);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,1022);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,1023);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,1024);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,1025);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,1026);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,1027);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,1028);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,1029);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,1030);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,1031);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,1032);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,1033);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,1034);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,1035);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,1036);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,1037);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,1038);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,1039);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,1040);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,1041);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,1042);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,1043);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,1044);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,1045);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,1046);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,1047);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,1048);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,1049);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,1050);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,1051);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,1052);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,1053);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,1054);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,1055);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,1056);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,1057);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,1058);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,1059);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,1060);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,2000);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,2001);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,2002);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,2003);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,2004);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,2005);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,2006);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,2007);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,2008);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,2009);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,2010);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,2011);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,2012);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,2013);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,2014);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,2015);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,2016);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,2017);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,2018);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,2019);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,2020);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,2021);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,2022);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,2023);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,2024);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,2025);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,2026);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,2027);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,2028);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,2035);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,2037);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,2039);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,2040);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,2041);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,2042);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,2043);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,2044);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,2045);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,2046);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,2047);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (101,2048);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (102,2000);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (102,2001);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (102,2002);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (102,2003);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (102,2004);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (102,2005);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (102,2006);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (102,2007);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (102,2008);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (102,2009);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (102,2010);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (102,2011);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (102,2012);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (102,2013);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (102,2014);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (102,2015);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (102,2016);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (102,2017);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (102,2018);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (102,2019);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (102,2020);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (102,2021);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (102,2037);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (102,2041);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (102,2042);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (102,2043);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (102,2048);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (102,2050);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (102,2052);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (102,2053);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (103,1);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (103,2);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (103,3);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (103,100);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (103,101);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (103,102);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (103,103);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (103,104);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (103,105);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (103,106);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (103,107);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (103,108);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (103,109);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (103,110);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (103,111);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (103,112);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (103,113);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (103,114);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (103,115);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (103,116);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (103,117);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (103,500);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (103,501);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (103,1000);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (103,1001);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (103,1002);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (103,1003);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (103,1004);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (103,1005);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (103,1006);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (103,1007);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (103,1008);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (103,1009);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (103,1010);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (103,1011);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (103,1012);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (103,1013);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (103,1014);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (103,1015);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (103,1016);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (103,1017);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (103,1018);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (103,1019);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (103,1020);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (103,1021);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (103,1022);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (103,1023);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (103,1024);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (103,1025);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (103,1026);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (103,1027);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (103,1028);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (103,1029);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (103,1030);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (103,1031);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (103,1032);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (103,1033);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (103,1034);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (103,1035);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (103,1036);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (103,1037);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (103,1038);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (103,1039);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (103,1040);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (103,1041);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (103,1042);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (103,1043);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (103,1044);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (103,1045);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (103,1046);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (103,1047);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (103,1048);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (103,1049);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (103,1050);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (103,1051);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (103,1052);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (103,1053);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (103,1054);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (103,1055);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (103,1056);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (103,1057);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (103,1058);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (103,1059);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (103,1060);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (103,2037);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (103,2044);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (103,2045);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (103,2046);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (103,2047);
INSERT INTO `sys_role_menu`(`role_id`,`menu_id`) VALUES (103,2048);

####################
##  sys_user
####################
DROP TABLE IF EXISTS `sys_user`;

####################
##  table sys_user ddl
####################
CREATE TABLE `sys_user` (
  `user_id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `dept_id` bigint DEFAULT NULL COMMENT '部门ID',
  `user_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_eo_0900_ai_ci NOT NULL COMMENT '用户账号',
  `nick_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_eo_0900_ai_ci NOT NULL COMMENT '用户昵称',
  `user_type` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_eo_0900_ai_ci DEFAULT '00' COMMENT '用户类型（00系统用户）',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_eo_0900_ai_ci DEFAULT '' COMMENT '用户邮箱',
  `phonenumber` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_eo_0900_ai_ci DEFAULT '' COMMENT '手机号码',
  `sex` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_eo_0900_ai_ci DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
  `avatar` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_eo_0900_ai_ci DEFAULT '' COMMENT '头像地址',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_eo_0900_ai_ci DEFAULT '' COMMENT '密码',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_eo_0900_ai_ci DEFAULT '0' COMMENT '账号状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_eo_0900_ai_ci DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `login_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_eo_0900_ai_ci DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime DEFAULT NULL COMMENT '最后登录时间',
  `pwd_update_date` datetime DEFAULT NULL COMMENT '密码最后更新时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_eo_0900_ai_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_eo_0900_ai_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_eo_0900_ai_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=109 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_eo_0900_ai_ci COMMENT='用户信息表';

####################
##  sys_user data
####################

####################
##  sys_user data
####################
INSERT INTO `sys_user`(`del_flag`,`create_time`,`user_name`,`sex`,`phonenumber`,`login_date`,`remark`,`avatar`,`login_ip`,`create_by`,`password`,`update_time`,`user_type`,`user_id`,`nick_name`,`dept_id`,`update_by`,`email`,`pwd_update_date`,`status`) VALUES ('0','2025-06-13T17:13:43','admin','0','15888888888','2026-04-11T16:12:19','管理员','','127.0.0.1','admin','$2a$10$jUXh5TJxP0A04bhrmZCDOOGrAvj8oii7HvovUH7L8rT.jvQpgcQm2','2026-04-11T08:12:19','00',1,'admin',103,'','ry@163.com','2025-06-13T17:13:43','0');
INSERT INTO `sys_user`(`del_flag`,`create_time`,`user_name`,`sex`,`phonenumber`,`login_date`,`remark`,`avatar`,`login_ip`,`create_by`,`password`,`user_type`,`user_id`,`nick_name`,`dept_id`,`update_by`,`email`,`pwd_update_date`,`status`) VALUES ('0','2025-06-13T17:13:43','ry','1','15666666666','2025-06-13T17:13:43','测试员','','127.0.0.1','admin','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','00',2,'若依',105,'','ry@qq.com','2025-06-13T17:13:43','0');
INSERT INTO `sys_user`(`del_flag`,`create_time`,`user_name`,`sex`,`phonenumber`,`login_date`,`avatar`,`login_ip`,`create_by`,`password`,`update_time`,`user_type`,`user_id`,`nick_name`,`dept_id`,`update_by`,`email`,`status`) VALUES ('0','2026-03-01T21:44:50','xiaobai','0','','2026-04-06T09:00:26','','127.0.0.1','admin','$2a$10$2bkX7Yl06FUbYiKtqpzH7enQTBmgSXufSZSTqm4AFNeN96n6zfWNG','2026-04-06T01:00:24','00',100,'小白',201,'admin','','0');
INSERT INTO `sys_user`(`del_flag`,`create_time`,`user_name`,`sex`,`phonenumber`,`avatar`,`login_ip`,`create_by`,`password`,`update_time`,`user_type`,`user_id`,`nick_name`,`dept_id`,`update_by`,`email`,`status`) VALUES ('0','2026-03-01T21:45:07','xiaoqing','0','','','','admin','$2a$10$AZhhxUbX.IWNdlKeCH.CjeLHR3uktv/kFPM8ycZDIT.wnfeKOgxyG','2026-03-01T21:45:47','00',101,'小青',201,'admin','','0');
INSERT INTO `sys_user`(`del_flag`,`create_time`,`user_name`,`sex`,`phonenumber`,`avatar`,`login_ip`,`create_by`,`password`,`user_type`,`user_id`,`nick_name`,`dept_id`,`update_by`,`email`,`status`) VALUES ('0','2026-04-10T09:13:15','laozhang','0','','','','admin','$2a$10$Wdd6TVwEFAjVFbFOFYNDa.akX14eZyfpQJM6k/G5xFcl4RcMIiC/.','00',108,'老张',200,'','','0');

####################
##  sys_user_post
####################
DROP TABLE IF EXISTS `sys_user_post`;

####################
##  table sys_user_post ddl
####################
CREATE TABLE `sys_user_post` (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `post_id` bigint NOT NULL COMMENT '岗位ID',
  PRIMARY KEY (`user_id`,`post_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='用户与岗位关联表';

####################
##  sys_user_post data
####################

####################
##  sys_user_post data
####################
INSERT INTO `sys_user_post`(`post_id`,`user_id`) VALUES (1,1);
INSERT INTO `sys_user_post`(`post_id`,`user_id`) VALUES (4,108);

####################
##  sys_user_role
####################
DROP TABLE IF EXISTS `sys_user_role`;

####################
##  table sys_user_role ddl
####################
CREATE TABLE `sys_user_role` (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `role_id` bigint NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`,`role_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='用户和角色关联表';

####################
##  sys_user_role data
####################

####################
##  sys_user_role data
####################
INSERT INTO `sys_user_role`(`user_id`,`role_id`) VALUES (1,1);
INSERT INTO `sys_user_role`(`user_id`,`role_id`) VALUES (100,102);
INSERT INTO `sys_user_role`(`user_id`,`role_id`) VALUES (101,102);
INSERT INTO `sys_user_role`(`user_id`,`role_id`) VALUES (108,103);

