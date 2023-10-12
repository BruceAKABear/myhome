/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 80028
 Source Host           : localhost:3306
 Source Schema         : myhome

 Target Server Type    : MySQL
 Target Server Version : 80028
 File Encoding         : 65001

 Date: 12/10/2023 11:34:07
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for device_device
-- ----------------------------
DROP TABLE IF EXISTS `device_device`;
CREATE TABLE `device_device`  (
  `id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `chip_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `room_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `online` tinyint(1) NOT NULL COMMENT '是否在线',
  `enable` tinyint(1) NOT NULL COMMENT '是否启用',
  `frameware_version` int NULL DEFAULT NULL COMMENT '版本号',
  `product_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '所属分类ID',
  `nick_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '起的别名',
  `floor_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '所属楼层ID',
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  `gateway` tinyint(1) UNSIGNED ZEROFILL NOT NULL DEFAULT 0,
  `power_level` int NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `floor_id`(`floor_id`) USING BTREE,
  INDEX `room_id`(`room_id`) USING BTREE,
  INDEX `chip_id`(`chip_id`) USING BTREE,
  INDEX `product_id`(`product_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of device_device
-- ----------------------------

-- ----------------------------
-- Table structure for device_frameware
-- ----------------------------
DROP TABLE IF EXISTS `device_frameware`;
CREATE TABLE `device_frameware`  (
  `id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `product_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '产品ID',
  `note` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '描述',
  `version` int NOT NULL COMMENT '版本',
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT 'url地址',
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of device_frameware
-- ----------------------------

-- ----------------------------
-- Table structure for device_log
-- ----------------------------
DROP TABLE IF EXISTS `device_log`;
CREATE TABLE `device_log`  (
  `id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `device_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `topic_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `product_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `payload` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `direction` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `order_from` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `user_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `create_time` timestamp NOT NULL,
  `update_time` timestamp NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `device_id`(`device_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of device_log
-- ----------------------------

-- ----------------------------
-- Table structure for device_product
-- ----------------------------
DROP TABLE IF EXISTS `device_product`;
CREATE TABLE `device_product`  (
  `id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '产品标识',
  `name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '产品名',
  `note` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '描述',
  `can_control` tinyint NOT NULL COMMENT '平台是否可控',
  `type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '产品类型:1.普通产品，2.网关产品',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `detail_page` tinyint(1) NOT NULL COMMENT '是否有详情页',
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '图标',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of device_product
-- ----------------------------

-- ----------------------------
-- Table structure for device_product_field
-- ----------------------------
DROP TABLE IF EXISTS `device_product_field`;
CREATE TABLE `device_product_field`  (
  `id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `product_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `field` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `field_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `label` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `create_time` datetime NOT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `product_id`(`product_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of device_product_field
-- ----------------------------

-- ----------------------------
-- Table structure for device_user_favorite
-- ----------------------------
DROP TABLE IF EXISTS `device_user_favorite`;
CREATE TABLE `device_user_favorite`  (
  `id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `device_id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `user_id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of device_user_favorite
-- ----------------------------

-- ----------------------------
-- Table structure for family
-- ----------------------------
DROP TABLE IF EXISTS `family`;
CREATE TABLE `family`  (
  `id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `name` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `app_id` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '天气appid',
  `app_secret` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '天气secret',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `longitude` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '经度',
  `latitude` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '维度',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of family
-- ----------------------------
INSERT INTO `family` VALUES ('1', 'MyHome', NULL, NULL, '2023-08-11 10:39:42', '2023-08-11 10:39:42', NULL, NULL);
INSERT INTO `family` VALUES ('1691278951178121218', '大熊家', 'string', 'string', '2023-08-15 10:41:39', '2023-08-15 10:41:39', 'string', 'string');
INSERT INTO `family` VALUES ('1691348775652667393', '测试家4', 'string', 'string', '2023-08-15 15:19:06', '2023-08-15 15:19:06', 'string', 'string');

-- ----------------------------
-- Table structure for family_floor
-- ----------------------------
DROP TABLE IF EXISTS `family_floor`;
CREATE TABLE `family_floor`  (
  `id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '主键',
  `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '楼层名',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `family_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of family_floor
-- ----------------------------

-- ----------------------------
-- Table structure for family_room
-- ----------------------------
DROP TABLE IF EXISTS `family_room`;
CREATE TABLE `family_room`  (
  `id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '主键',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '房间名',
  `floor_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '楼层ID',
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  `beacon_uuid` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `sequence` int NOT NULL,
  `family_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `floor_id`(`floor_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of family_room
-- ----------------------------

-- ----------------------------
-- Table structure for feed_back
-- ----------------------------
DROP TABLE IF EXISTS `feed_back`;
CREATE TABLE `feed_back`  (
  `id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `user_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `description` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of feed_back
-- ----------------------------

-- ----------------------------
-- Table structure for message
-- ----------------------------
DROP TABLE IF EXISTS `message`;
CREATE TABLE `message`  (
  `id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `from_user_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `to_user_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `has_read` tinyint(1) NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `type` tinyint(1) NULL DEFAULT NULL,
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of message
-- ----------------------------
INSERT INTO `message` VALUES ('1411663049996742658', 'system', '1411663049942216706', 1, '2021-07-04 20:27:53', '2021-07-04 20:27:53', 0, '【MyHome开发团队】欢迎你加入MyHome大家庭！系统的成长离不开您的支持如有问题请在【我的】【设置】中提交自己的问题。');

-- ----------------------------
-- Table structure for message_message
-- ----------------------------
DROP TABLE IF EXISTS `message_message`;
CREATE TABLE `message_message`  (
  `id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `from_user_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `user_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `readed` tinyint(1) NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of message_message
-- ----------------------------

-- ----------------------------
-- Table structure for perm_permission_function
-- ----------------------------
DROP TABLE IF EXISTS `perm_permission_function`;
CREATE TABLE `perm_permission_function`  (
  `id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `parent_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `symbol` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `menu_icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `uris` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of perm_permission_function
-- ----------------------------
INSERT INTO `perm_permission_function` VALUES ('1', NULL, 'button', 'a', NULL, NULL, '2023-09-13 14:00:53', '2023-09-13 14:00:56');
INSERT INTO `perm_permission_function` VALUES ('2', NULL, 'button', 'a', NULL, NULL, '2023-09-13 14:01:07', '2023-09-13 14:01:10');
INSERT INTO `perm_permission_function` VALUES ('3', NULL, 'memu', 'a', NULL, NULL, '2023-09-13 14:01:21', '2023-09-13 14:01:23');
INSERT INTO `perm_permission_function` VALUES ('4', NULL, 'menu', 'a', NULL, NULL, '2023-09-13 14:01:45', '2023-09-13 14:01:48');

-- ----------------------------
-- Table structure for perm_role
-- ----------------------------
DROP TABLE IF EXISTS `perm_role`;
CREATE TABLE `perm_role`  (
  `id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `can_del` tinyint UNSIGNED NOT NULL DEFAULT 1,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `describ` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of perm_role
-- ----------------------------
INSERT INTO `perm_role` VALUES ('1', 1, '角色1', NULL, '2023-09-13 13:58:44', '2023-09-13 13:58:47');
INSERT INTO `perm_role` VALUES ('2', 1, '角色2', NULL, '2023-09-13 13:58:56', '2023-09-13 13:58:58');

-- ----------------------------
-- Table structure for perm_role_device
-- ----------------------------
DROP TABLE IF EXISTS `perm_role_device`;
CREATE TABLE `perm_role_device`  (
  `id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `role_id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `device_id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of perm_role_device
-- ----------------------------

-- ----------------------------
-- Table structure for perm_role_permission_function
-- ----------------------------
DROP TABLE IF EXISTS `perm_role_permission_function`;
CREATE TABLE `perm_role_permission_function`  (
  `id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `role_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `permission_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `role_id`(`role_id`) USING BTREE,
  INDEX `permission_id`(`permission_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of perm_role_permission_function
-- ----------------------------
INSERT INTO `perm_role_permission_function` VALUES ('1', '1', '1', '2023-09-13 13:59:37', '2023-09-13 13:59:44');
INSERT INTO `perm_role_permission_function` VALUES ('2', '2', '2', '2023-09-13 16:54:12', '2023-09-13 16:54:16');
INSERT INTO `perm_role_permission_function` VALUES ('3', '3', '3', '2023-09-13 16:54:31', '2023-09-13 16:54:35');

-- ----------------------------
-- Table structure for perm_user_device
-- ----------------------------
DROP TABLE IF EXISTS `perm_user_device`;
CREATE TABLE `perm_user_device`  (
  `id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `user_id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `device_id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of perm_user_device
-- ----------------------------

-- ----------------------------
-- Table structure for perm_user_role
-- ----------------------------
DROP TABLE IF EXISTS `perm_user_role`;
CREATE TABLE `perm_user_role`  (
  `id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `user_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '1',
  `role_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `role_id`(`role_id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of perm_user_role
-- ----------------------------
INSERT INTO `perm_user_role` VALUES ('1', '1', '1');
INSERT INTO `perm_user_role` VALUES ('2', '1', '2');

-- ----------------------------
-- Table structure for room_location_anchor
-- ----------------------------
DROP TABLE IF EXISTS `room_location_anchor`;
CREATE TABLE `room_location_anchor`  (
  `id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `room_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '房间ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of room_location_anchor
-- ----------------------------

-- ----------------------------
-- Table structure for scene_action
-- ----------------------------
DROP TABLE IF EXISTS `scene_action`;
CREATE TABLE `scene_action`  (
  `id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `scene_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'device-设备控制',
  `device_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `device_property` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `property_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `scene_id`(`scene_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of scene_action
-- ----------------------------

-- ----------------------------
-- Table structure for scene_condition
-- ----------------------------
DROP TABLE IF EXISTS `scene_condition`;
CREATE TABLE `scene_condition`  (
  `id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `scene_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `start_time` time NULL DEFAULT NULL,
  `end_time` time NULL DEFAULT NULL,
  `device_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `device_property` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `relation` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `property_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `scene_id`(`scene_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of scene_condition
-- ----------------------------

-- ----------------------------
-- Table structure for scene_scene
-- ----------------------------
DROP TABLE IF EXISTS `scene_scene`;
CREATE TABLE `scene_scene`  (
  `id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `enable` tinyint(1) NOT NULL,
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of scene_scene
-- ----------------------------

-- ----------------------------
-- Table structure for system_app_version
-- ----------------------------
DROP TABLE IF EXISTS `system_app_version`;
CREATE TABLE `system_app_version`  (
  `id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `version` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `version_code` int NULL DEFAULT NULL,
  `update_type` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `wget_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `note` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of system_app_version
-- ----------------------------

-- ----------------------------
-- Table structure for system_operation_log
-- ----------------------------
DROP TABLE IF EXISTS `system_operation_log`;
CREATE TABLE `system_operation_log`  (
  `id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `u_id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `op_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `op_ip` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  `request_uri` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `request_method` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `status` tinyint(1) NOT NULL,
  `error` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `take_time` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of system_operation_log
-- ----------------------------
INSERT INTO `system_operation_log` VALUES ('1691294154909396994', NULL, '登录', '0:0:0:0:0:0:0:1', '2023-08-15 11:42:04', '2023-08-15 11:42:04', '/user/login', 'POST', 0, 'system.login.usernameorpassworderror', 3333);
INSERT INTO `system_operation_log` VALUES ('1691295776540569601', NULL, '登录', '0:0:0:0:0:0:0:1', '2023-08-15 11:48:31', '2023-08-15 11:48:31', '/user/login', 'POST', 0, '用户名或密码错误', 148);
INSERT INTO `system_operation_log` VALUES ('1691295931734011905', NULL, '登录', '0:0:0:0:0:0:0:1', '2023-08-15 11:49:08', '2023-08-15 11:49:08', '/user/login', 'POST', 1, NULL, 182);
INSERT INTO `system_operation_log` VALUES ('1691296109664776194', '1', '根据id查询家庭信息', '0:0:0:0:0:0:0:1', '2023-08-15 11:49:50', '2023-08-15 11:49:50', '/family/infoById', 'GET', 1, NULL, 87);
INSERT INTO `system_operation_log` VALUES ('1691296154959065090', '1', '查询家庭信息集合', '0:0:0:0:0:0:0:1', '2023-08-15 11:50:01', '2023-08-15 11:50:01', '/family/infoList', 'GET', 1, NULL, 2);
INSERT INTO `system_operation_log` VALUES ('1691296656853676034', '1', '查询家庭信息集合', '0:0:0:0:0:0:0:1', '2023-08-15 11:52:00', '2023-08-15 11:52:00', '/family/infoList', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1691314953565351938', NULL, '登录', '0:0:0:0:0:0:0:1', '2023-08-15 13:04:43', '2023-08-15 13:04:43', '/user/login', 'POST', 1, NULL, 138);
INSERT INTO `system_operation_log` VALUES ('1691314988210302977', '1', '查询家庭信息集合', '0:0:0:0:0:0:0:1', '2023-08-15 13:04:51', '2023-08-15 13:04:51', '/family/infoList', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1691315140941688833', '1', '根据id查询家庭信息', '0:0:0:0:0:0:0:1', '2023-08-15 13:05:27', '2023-08-15 13:05:27', '/family/infoById', 'GET', 1, NULL, 1);
INSERT INTO `system_operation_log` VALUES ('1691348599080857601', NULL, '登录', '0:0:0:0:0:0:0:1', '2023-08-15 15:18:24', '2023-08-15 15:18:24', '/user/login', 'POST', 1, NULL, 170);
INSERT INTO `system_operation_log` VALUES ('1691348633843249154', '1', '查询是否是第一次登陆', '0:0:0:0:0:0:0:1', '2023-08-15 15:18:33', '2023-08-15 15:18:33', '/family/checkIsFirst', 'GET', 1, NULL, 48);
INSERT INTO `system_operation_log` VALUES ('1691348775782690818', '1', '新增或修改家庭', '0:0:0:0:0:0:0:1', '2023-08-15 15:19:07', '2023-08-15 15:19:07', '/family/addUpdate', 'POST', 1, NULL, 183);
INSERT INTO `system_operation_log` VALUES ('1691348823367069697', '1', '查询家庭信息集合', '0:0:0:0:0:0:0:1', '2023-08-15 15:19:18', '2023-08-15 15:19:18', '/family/infoList', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1693515287045951490', NULL, '登录', '0:0:0:0:0:0:0:1', '2023-08-21 14:48:03', '2023-08-21 14:48:03', '/user/login', 'POST', 1, NULL, 300);
INSERT INTO `system_operation_log` VALUES ('1693515622665768962', '1', '查询家庭信息集合', '0:0:0:0:0:0:0:1', '2023-08-21 14:49:23', '2023-08-21 14:49:23', '/family/infoList', 'GET', 1, NULL, 59);
INSERT INTO `system_operation_log` VALUES ('1693516553155334145', '1', '根据id查询家庭信息', '0:0:0:0:0:0:0:1', '2023-08-21 14:53:05', '2023-08-21 14:53:05', '/family/infoById', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1693516592539848706', '1', '根据id查询家庭信息', '0:0:0:0:0:0:0:1', '2023-08-21 14:53:14', '2023-08-21 14:53:14', '/family/infoById', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1693521731354886146', NULL, '楼层分页查询', '0:0:0:0:0:0:0:1', '2023-08-21 15:13:40', '2023-08-21 15:13:40', '/floor/page', 'GET', 1, NULL, 530);
INSERT INTO `system_operation_log` VALUES ('1693522578428133377', NULL, '新增或修改楼层', '0:0:0:0:0:0:0:1', '2023-08-21 15:17:01', '2023-08-21 15:17:01', '/floor/addUpdate', 'POST', 1, NULL, 89);
INSERT INTO `system_operation_log` VALUES ('1693522599710031873', NULL, '楼层分页查询', '0:0:0:0:0:0:0:1', '2023-08-21 15:17:07', '2023-08-21 15:17:07', '/floor/page', 'GET', 1, NULL, 34);
INSERT INTO `system_operation_log` VALUES ('1693523729647140865', NULL, '登录', '0:0:0:0:0:0:0:1', '2023-08-21 15:21:36', '2023-08-21 15:21:36', '/user/login', 'POST', 1, NULL, 211);
INSERT INTO `system_operation_log` VALUES ('1693523791278243841', '1', '查询家庭信息集合', '0:0:0:0:0:0:0:1', '2023-08-21 15:21:51', '2023-08-21 15:21:51', '/family/infoList', 'GET', 1, NULL, 65);
INSERT INTO `system_operation_log` VALUES ('1693523865630670849', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-08-21 15:22:08', '2023-08-21 15:22:08', '/floor/floorList', 'GET', 1, NULL, 53);
INSERT INTO `system_operation_log` VALUES ('1693524176676061186', NULL, '楼层集合', '0:0:0:0:0:0:0:1', '2023-08-21 15:23:23', '2023-08-21 15:23:23', '/floor/floorList', 'GET', 1, NULL, 45);
INSERT INTO `system_operation_log` VALUES ('1693524499771686913', NULL, '楼层集合', '0:0:0:0:0:0:0:1', '2023-08-21 15:24:40', '2023-08-21 15:24:40', '/floor/floorList', 'GET', 1, NULL, 47744);
INSERT INTO `system_operation_log` VALUES ('1693524590016331778', NULL, '楼层集合', '0:0:0:0:0:0:0:1', '2023-08-21 15:25:01', '2023-08-21 15:25:01', '/floor/floorList', 'GET', 1, NULL, 9495);
INSERT INTO `system_operation_log` VALUES ('1693524712586477570', NULL, '楼层集合', '0:0:0:0:0:0:0:1', '2023-08-21 15:25:30', '2023-08-21 15:25:30', '/floor/floorList', 'GET', 1, NULL, 2981);
INSERT INTO `system_operation_log` VALUES ('1693531941175820290', '1', '删除楼层', '0:0:0:0:0:0:0:1', '2023-08-21 15:54:14', '2023-08-21 15:54:14', '/floor/delete/1693522578361024514', 'DELETE', 1, NULL, 2933);
INSERT INTO `system_operation_log` VALUES ('1693531962210254849', '1', '删除楼层', '0:0:0:0:0:0:0:1', '2023-08-21 15:54:19', '2023-08-21 15:54:19', '/floor/delete/1693522578361024514', 'DELETE', 1, NULL, 8);
INSERT INTO `system_operation_log` VALUES ('1693531986935676929', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-08-21 15:54:25', '2023-08-21 15:54:25', '/floor/floorList', 'GET', 1, NULL, 6);
INSERT INTO `system_operation_log` VALUES ('1704419642007707650', NULL, '', '0:0:0:0:0:0:0:1', '2023-09-20 16:57:52', '2023-09-20 16:57:52', '/error', 'GET', 0, '系统错误请联系管理员', 1563);
INSERT INTO `system_operation_log` VALUES ('1704420686670430209', NULL, '', '0:0:0:0:0:0:0:1', '2023-09-20 17:02:13', '2023-09-20 17:02:13', '/', 'GET', 0, '此接口没有任何数据', 6);

-- ----------------------------
-- Table structure for system_user
-- ----------------------------
DROP TABLE IF EXISTS `system_user`;
CREATE TABLE `system_user`  (
  `id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '主键',
  `role_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '昵称',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '头像',
  `passw` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '密码',
  `email` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '邮箱',
  `sex` tinyint(1) NULL DEFAULT NULL COMMENT '性别1男2女',
  `height` int NULL DEFAULT NULL COMMENT '身高',
  `weight` int NULL DEFAULT NULL COMMENT '体重',
  `age` int NULL DEFAULT NULL COMMENT '年龄',
  `selected_floor_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '选择的楼层ID',
  `selected_room_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '选择的房间ID',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `super_admin` tinyint(1) NOT NULL COMMENT '是否是超级管理员',
  `enable` tinyint(1) NOT NULL COMMENT '是否启用',
  `select_lang` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '选中的语言',
  `display_mode` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of system_user
-- ----------------------------
INSERT INTO `system_user` VALUES ('1', NULL, 'BLab', NULL, '$2a$10$WQpAjiS1yrbtAAtIX7wageoOcdCF2Fqqsf2E6nwlQQ69r9HIIj.RO', 'abc@abc.com', NULL, NULL, NULL, NULL, NULL, NULL, '2023-08-11 10:39:42', '2023-08-11 10:39:42', 1, 1, NULL, NULL);
INSERT INTO `system_user` VALUES ('2', NULL, 'a', NULL, '1', '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 14:48:53', '2023-09-13 14:48:56', 0, 1, NULL, NULL);

-- ----------------------------
-- Table structure for task_schedule
-- ----------------------------
DROP TABLE IF EXISTS `task_schedule`;
CREATE TABLE `task_schedule`  (
  `id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of task_schedule
-- ----------------------------

-- ----------------------------
-- Table structure for task_schedule_device
-- ----------------------------
DROP TABLE IF EXISTS `task_schedule_device`;
CREATE TABLE `task_schedule_device`  (
  `id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `device_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `task_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `device_id`(`device_id`) USING BTREE,
  INDEX `task_id`(`task_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of task_schedule_device
-- ----------------------------
INSERT INTO `task_schedule_device` VALUES ('1554091194042032130', '6584669', '1554091194042032129', '2022-08-01 21:06:29', '2022-08-01 21:06:29');

SET FOREIGN_KEY_CHECKS = 1;
