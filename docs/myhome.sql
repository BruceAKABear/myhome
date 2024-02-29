/*
 Navicat Premium Data Transfer

 Source Server         : 本地MySQL
 Source Server Type    : MySQL
 Source Server Version : 50717
 Source Host           : localhost:3306
 Source Schema         : myhome

 Target Server Type    : MySQL
 Target Server Version : 50717
 File Encoding         : 65001

 Date: 29/02/2024 23:08:10
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for device_device
-- ----------------------------
DROP TABLE IF EXISTS `device_device`;
CREATE TABLE `device_device`  (
  `id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `family_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `room_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `online` tinyint(1) NOT NULL COMMENT '是否在线',
  `enable` tinyint(1) NOT NULL COMMENT '是否启用',
  `frameware_version` int(11) NULL DEFAULT NULL COMMENT '版本号',
  `product_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '所属分类ID',
  `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '起的别名',
  `floor_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '所属楼层ID',
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  `gateway` tinyint(1) UNSIGNED ZEROFILL NOT NULL DEFAULT 0,
  `power_level` int(11) NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `floor_id`(`floor_id`) USING BTREE,
  INDEX `room_id`(`room_id`) USING BTREE,
  INDEX `chip_id`(`family_id`) USING BTREE,
  INDEX `product_id`(`product_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of device_device
-- ----------------------------
INSERT INTO `device_device` VALUES ('1233', '1', '1723693447949438977', 1, 1, 1, '1728784044125143041', '窗帘', '1720784834390978562', '2024-01-05 22:32:22', '2024-01-05 22:32:22', 0, 0);
INSERT INTO `device_device` VALUES ('222333', '1', '1723693447949438977', 1, 1, 1, '1718634062311182337', '开关', '1720784834390978562', '2024-01-06 22:11:09', '2024-01-06 22:11:09', 0, 0);

-- ----------------------------
-- Table structure for device_frameware
-- ----------------------------
DROP TABLE IF EXISTS `device_frameware`;
CREATE TABLE `device_frameware`  (
  `id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `product_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '产品ID',
  `note` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '描述',
  `version` int(11) NOT NULL COMMENT '版本',
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT 'url地址',
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of device_frameware
-- ----------------------------
INSERT INTO `device_frameware` VALUES ('1730932692858556418', '1718634062311182337', '测试固件', 1, 'https://smartcampus.minthgroup.com/smart-office/api/file/preview?fileName=beacon.PNG', '2023-12-02 20:51:28', '2023-12-02 20:51:28');

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
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `update_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
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
  `can_control` tinyint(4) NOT NULL COMMENT '平台是否可控',
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
INSERT INTO `device_product` VALUES ('1718634062311182337', NULL, '智能开关', NULL, 1, 'normal', '2023-10-29 22:21:06', '2023-11-26 22:36:05', 1, NULL);
INSERT INTO `device_product` VALUES ('1723664937932402689', NULL, '智能插座', NULL, 1, 'normal', '2023-11-12 19:32:00', '2023-11-26 22:27:20', 1, NULL);
INSERT INTO `device_product` VALUES ('1728784044125143041', NULL, '智能窗帘', NULL, 1, 'normal', '2023-11-26 22:33:30', '2023-11-26 22:33:30', 1, NULL);
INSERT INTO `device_product` VALUES ('1736006208083550210', NULL, '智能门锁', NULL, 1, 'normal', '2023-12-16 20:51:48', '2023-12-16 20:51:48', 1, NULL);

-- ----------------------------
-- Table structure for device_product_field
-- ----------------------------
DROP TABLE IF EXISTS `device_product_field`;
CREATE TABLE `device_product_field`  (
  `id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `product_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `field` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `label` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `create_time` datetime NOT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `product_id`(`product_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of device_product_field
-- ----------------------------
INSERT INTO `device_product_field` VALUES ('1718634062378291202', '1718634062311182337', 'open', '开关', '2023-11-26 22:36:05', '2023-11-26 22:36:05');
INSERT INTO `device_product_field` VALUES ('1723664937999511553', '1723664937932402689', 'open', '开关', '2023-11-26 22:27:20', '2023-11-26 22:27:20');
INSERT INTO `device_product_field` VALUES ('1728784044192251906', '1728784044125143041', 'rate', '开关状态', '2023-11-26 22:33:30', '2023-11-26 22:33:30');
INSERT INTO `device_product_field` VALUES ('1736006208083550211', '1736006208083550210', 'open', '开关', '2023-12-16 20:51:48', '2023-12-16 20:51:48');

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
INSERT INTO `family` VALUES ('1', 'MyHome', NULL, NULL, '2023-08-11 10:39:42', '2023-11-04 21:36:26', '1', '1');
INSERT INTO `family` VALUES ('1691278951178121218', '大熊家', 'string', 'string', '2023-08-15 10:41:39', '2023-08-15 10:41:39', 'string', 'string');
INSERT INTO `family` VALUES ('1691348775652667393', '测试家4', 'string', 'string', '2023-08-15 15:19:06', '2023-08-15 15:19:06', 'string', 'string');
INSERT INTO `family` VALUES ('1723339263115853826', '家庭1', NULL, NULL, '2023-11-11 21:57:53', '2023-11-11 21:57:53', '1', '1');
INSERT INTO `family` VALUES ('1723339289787432962', '家庭2', NULL, NULL, '2023-11-11 21:57:59', '2023-11-11 21:57:59', '2', '2');
INSERT INTO `family` VALUES ('1723339317583085570', '家庭3', NULL, NULL, '2023-11-11 21:58:06', '2023-11-11 21:58:06', '3', '3');
INSERT INTO `family` VALUES ('1723339344737009666', '家庭4', NULL, NULL, '2023-11-11 21:58:13', '2023-11-11 21:58:13', '4', '4');
INSERT INTO `family` VALUES ('1723339373941948417', '家庭5', NULL, NULL, '2023-11-11 21:58:20', '2023-11-11 21:58:20', '5', '5');
INSERT INTO `family` VALUES ('1723339398495404034', '家庭6', NULL, NULL, '2023-11-11 21:58:25', '2023-11-11 21:58:25', '6', '6');
INSERT INTO `family` VALUES ('1723339425536081921', '家庭7', NULL, NULL, '2023-11-11 21:58:32', '2023-11-11 21:58:32', '7', '7');
INSERT INTO `family` VALUES ('1723339468359925761', '家庭8', NULL, NULL, '2023-11-11 21:58:42', '2023-11-11 21:58:42', '8', '8');
INSERT INTO `family` VALUES ('1723339503269117953', '家庭9', NULL, NULL, '2023-11-11 21:58:50', '2023-11-11 21:58:50', '9', '9');
INSERT INTO `family` VALUES ('1723339566477279234', '家庭10', NULL, NULL, '2023-11-11 21:59:05', '2023-11-11 21:59:05', '10', '10');
INSERT INTO `family` VALUES ('1723339933885726721', '家庭11', NULL, NULL, '2023-11-11 22:00:33', '2023-11-11 22:00:33', '11', '11');
INSERT INTO `family` VALUES ('1733746414249406465', '家庭x', NULL, NULL, '2023-12-10 15:12:11', '2023-12-10 15:12:11', '1', '1');

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
INSERT INTO `family_floor` VALUES ('1720784834390978562', '阁楼', '2023-11-04 20:47:30', '2023-11-04 20:47:30', '1');
INSERT INTO `family_floor` VALUES ('1723346775353393154', '车库', '2023-11-11 22:27:44', '2023-11-11 22:27:44', '1691278951178121218');
INSERT INTO `family_floor` VALUES ('1733745767982657538', '居住层', '2023-12-10 15:09:37', '2023-12-10 15:09:37', '1');
INSERT INTO `family_floor` VALUES ('1733745908105965570', '车库', '2023-12-10 15:10:11', '2023-12-10 15:10:11', '1');
INSERT INTO `family_floor` VALUES ('1733752593159647233', '11', '2023-12-10 15:36:44', '2023-12-10 15:36:44', '1');
INSERT INTO `family_floor` VALUES ('1733752862475907073', '22', '2023-12-10 15:37:49', '2023-12-10 15:37:49', '1');
INSERT INTO `family_floor` VALUES ('1733753272397819905', '33', '2023-12-10 15:39:26', '2023-12-10 15:39:26', '1');
INSERT INTO `family_floor` VALUES ('1733753468213096450', '44', '2023-12-10 15:40:13', '2023-12-10 15:40:13', '1');
INSERT INTO `family_floor` VALUES ('1733753612388102145', '55', '2023-12-10 15:40:47', '2023-12-10 15:40:47', '1');
INSERT INTO `family_floor` VALUES ('1733754141944147970', '66', '2023-12-10 15:42:54', '2023-12-10 15:42:54', '1');
INSERT INTO `family_floor` VALUES ('1733754172352851970', '77', '2023-12-10 15:43:01', '2023-12-10 15:43:01', '1');
INSERT INTO `family_floor` VALUES ('1733754195920646145', '88', '2023-12-10 15:43:07', '2023-12-10 15:43:07', '1');
INSERT INTO `family_floor` VALUES ('1733754217462591489', '99', '2023-12-10 15:43:12', '2023-12-10 15:43:12', '1');
INSERT INTO `family_floor` VALUES ('1733754239960838146', '101', '2023-12-10 15:43:17', '2023-12-10 15:43:17', '1');
INSERT INTO `family_floor` VALUES ('1733754264925335553', '102', '2023-12-10 15:43:23', '2023-12-10 15:43:23', '1');
INSERT INTO `family_floor` VALUES ('1733754294788780033', '103', '2023-12-10 15:43:30', '2023-12-10 15:43:30', '1');
INSERT INTO `family_floor` VALUES ('1733754330666856450', '104', '2023-12-10 15:43:39', '2023-12-10 15:43:39', '1');
INSERT INTO `family_floor` VALUES ('1733754354863796225', '105', '2023-12-10 15:43:44', '2023-12-10 15:43:44', '1');

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
  `beacon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `sequence` int(11) NOT NULL,
  `family_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `floor_id`(`floor_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of family_room
-- ----------------------------
INSERT INTO `family_room` VALUES ('1723693447949438977', '工作室', '1720784834390978562', '2023-11-12 21:25:17', '2023-11-12 21:25:17', NULL, 1, '1');
INSERT INTO `family_room` VALUES ('1723693495202467842', '小露台', '1720784834390978562', '2023-11-12 21:25:29', '2023-11-12 21:25:29', NULL, 2, '1');
INSERT INTO `family_room` VALUES ('1723693534142386177', '大露台', '1720784834390978562', '2023-11-12 21:25:38', '2023-11-12 21:25:38', NULL, 3, '1');
INSERT INTO `family_room` VALUES ('1733746028402798594', '主卧', '1733745767982657538', '2023-12-10 15:10:39', '2023-12-10 15:10:39', NULL, 1, '1');
INSERT INTO `family_room` VALUES ('1738932433672314882', 'workshop', '1723346775353393154', '2023-12-24 22:39:35', '2023-12-24 22:39:35', NULL, 1, '1691278951178121218');

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
INSERT INTO `perm_permission_function` VALUES ('3', NULL, 'menu', '/dashboard', NULL, NULL, '2023-09-13 14:01:21', '2023-09-13 14:01:23');
INSERT INTO `perm_permission_function` VALUES ('4', NULL, 'menu', '/family', NULL, NULL, '2023-10-24 23:18:23', '2023-10-24 23:18:27');
INSERT INTO `perm_permission_function` VALUES ('41', '4', 'menu', '/family/family', NULL, NULL, NULL, NULL);
INSERT INTO `perm_permission_function` VALUES ('42', '4', 'menu', '/family/floor', NULL, NULL, NULL, NULL);
INSERT INTO `perm_permission_function` VALUES ('43', '4', 'menu', '/family/room', NULL, NULL, NULL, NULL);
INSERT INTO `perm_permission_function` VALUES ('44', '4', 'menu', '/family/members', NULL, NULL, '2023-12-10 14:15:16', '2023-12-10 14:15:18');
INSERT INTO `perm_permission_function` VALUES ('5', NULL, 'menu', '/device', NULL, NULL, '2023-10-29 22:04:33', '2023-10-29 22:04:36');
INSERT INTO `perm_permission_function` VALUES ('51', '5', 'menu', '/device/product', 'el-icon-menu', NULL, '2023-10-29 22:12:58', '2023-10-29 22:13:01');
INSERT INTO `perm_permission_function` VALUES ('511', '51', 'button', '/abc', NULL, NULL, NULL, NULL);
INSERT INTO `perm_permission_function` VALUES ('52', '5', 'menu', '/device/firmware', NULL, NULL, '2023-11-11 22:08:35', '2023-11-11 22:08:37');
INSERT INTO `perm_permission_function` VALUES ('53', '5', 'menu', '/device/device', NULL, NULL, '2023-11-11 22:09:06', '2023-11-11 22:09:09');
INSERT INTO `perm_permission_function` VALUES ('54', '5', 'menu', '/device/debug', NULL, NULL, '2023-11-11 22:09:34', '2023-11-11 22:09:37');
INSERT INTO `perm_permission_function` VALUES ('7', NULL, 'menu', '/system', NULL, NULL, '2023-10-31 21:47:51', '2023-10-31 21:47:55');
INSERT INTO `perm_permission_function` VALUES ('71', '7', 'menu', '/system/systeminfo', NULL, NULL, '2023-12-10 14:46:48', '2023-12-10 14:46:51');
INSERT INTO `perm_permission_function` VALUES ('72', '7', 'menu', '/system/personal', NULL, NULL, '2023-12-10 14:47:12', '2023-12-10 14:47:15');
INSERT INTO `perm_permission_function` VALUES ('73', '7', 'menu', '/system/rolemanage', NULL, NULL, '2023-12-10 14:47:37', '2023-12-10 14:47:41');

-- ----------------------------
-- Table structure for perm_role
-- ----------------------------
DROP TABLE IF EXISTS `perm_role`;
CREATE TABLE `perm_role`  (
  `id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `can_del` tinyint(3) UNSIGNED NOT NULL DEFAULT 1,
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
  `order_number` int(11) NULL DEFAULT NULL,
  `condition_group_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `operator` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `scene_id`(`scene_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of scene_condition
-- ----------------------------

-- ----------------------------
-- Table structure for scene_condition_group
-- ----------------------------
DROP TABLE IF EXISTS `scene_condition_group`;
CREATE TABLE `scene_condition_group`  (
  `id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `scene_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `order_number` int(11) NOT NULL,
  `relation` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of scene_condition_group
-- ----------------------------

-- ----------------------------
-- Table structure for scene_scene
-- ----------------------------
DROP TABLE IF EXISTS `scene_scene`;
CREATE TABLE `scene_scene`  (
  `id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
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
  `version_code` int(11) NULL DEFAULT NULL,
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
  `take_time` int(11) NULL DEFAULT NULL,
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
INSERT INTO `system_operation_log` VALUES ('1715729393045856257', NULL, '登录', '0:0:0:0:0:0:0:1', '2023-10-21 21:58:59', '2023-10-21 21:58:59', '/user/login', 'POST', 0, '用户名或密码错误', 179);
INSERT INTO `system_operation_log` VALUES ('1715729426734505985', NULL, '登录', '0:0:0:0:0:0:0:1', '2023-10-21 21:59:07', '2023-10-21 21:59:07', '/user/login', 'POST', 0, '用户名或密码错误', 97);
INSERT INTO `system_operation_log` VALUES ('1715729445524987905', NULL, '登录', '0:0:0:0:0:0:0:1', '2023-10-21 21:59:11', '2023-10-21 21:59:11', '/user/login', 'POST', 0, '用户名或密码错误', 95);
INSERT INTO `system_operation_log` VALUES ('1715729604182925313', NULL, '登录', '0:0:0:0:0:0:0:1', '2023-10-21 21:59:49', '2023-10-21 21:59:49', '/user/login', 'POST', 1, NULL, 114);
INSERT INTO `system_operation_log` VALUES ('1715729638244868098', NULL, '登录', '0:0:0:0:0:0:0:1', '2023-10-21 21:59:57', '2023-10-21 21:59:57', '/user/login', 'POST', 0, '用户名或密码错误', 96);
INSERT INTO `system_operation_log` VALUES ('1715729685908938753', NULL, '登录', '0:0:0:0:0:0:0:1', '2023-10-21 22:00:08', '2023-10-21 22:00:08', '/user/login', 'POST', 1, NULL, 94);
INSERT INTO `system_operation_log` VALUES ('1715729685976047617', '1', '查询个人信息', '0:0:0:0:0:0:0:1', '2023-10-21 22:00:09', '2023-10-21 22:00:09', '/user/info', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1715729686106071042', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-10-21 22:00:09', '2023-10-21 22:00:09', '/permission/getPerm', 'GET', 1, NULL, 41);
INSERT INTO `system_operation_log` VALUES ('1715741145271754753', NULL, '登录', '0:0:0:0:0:0:0:1', '2023-10-21 22:45:41', '2023-10-21 22:45:41', '/user/login', 'POST', 1, NULL, 101);
INSERT INTO `system_operation_log` VALUES ('1715741145338863618', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-10-21 22:45:41', '2023-10-21 22:45:41', '/permission/getPerm', 'GET', 1, NULL, 7);
INSERT INTO `system_operation_log` VALUES ('1715741145338863619', '1', '查询个人信息', '0:0:0:0:0:0:0:1', '2023-10-21 22:45:41', '2023-10-21 22:45:41', '/user/info', 'GET', 1, NULL, 6);
INSERT INTO `system_operation_log` VALUES ('1715741145540190210', '1', '查询是否是第一次登陆', '0:0:0:0:0:0:0:1', '2023-10-21 22:45:41', '2023-10-21 22:45:41', '/family/checkIsFirst', 'GET', 1, NULL, 44);
INSERT INTO `system_operation_log` VALUES ('1715742115976306690', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2023-10-21 22:49:32', '2023-10-21 22:49:32', '/dashboard/dashboardInfo', 'GET', 1, NULL, 147);
INSERT INTO `system_operation_log` VALUES ('1715742115976306691', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-10-21 22:49:32', '2023-10-21 22:49:32', '/floor/floorList', 'GET', 1, NULL, 147);
INSERT INTO `system_operation_log` VALUES ('1715742240702324737', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-10-21 22:50:02', '2023-10-21 22:50:02', '/floor/floorList', 'GET', 1, NULL, 1);
INSERT INTO `system_operation_log` VALUES ('1715742240807182337', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2023-10-21 22:50:02', '2023-10-21 22:50:02', '/dashboard/dashboardInfo', 'GET', 1, NULL, 26);
INSERT INTO `system_operation_log` VALUES ('1715742613877940226', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-10-21 22:51:31', '2023-10-21 22:51:31', '/floor/floorList', 'GET', 1, NULL, 1);
INSERT INTO `system_operation_log` VALUES ('1715742613877940227', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2023-10-21 22:51:31', '2023-10-21 22:51:31', '/dashboard/dashboardInfo', 'GET', 1, NULL, 22);
INSERT INTO `system_operation_log` VALUES ('1716097527665668098', NULL, '登录', '0:0:0:0:0:0:0:1', '2023-10-22 22:21:49', '2023-10-22 22:21:49', '/user/login', 'POST', 0, '用户名或密码错误', 894);
INSERT INTO `system_operation_log` VALUES ('1716097613283995649', NULL, '登录', '0:0:0:0:0:0:0:1', '2023-10-22 22:22:09', '2023-10-22 22:22:09', '/user/login', 'POST', 0, '用户名或密码错误', 122);
INSERT INTO `system_operation_log` VALUES ('1716097650860765185', NULL, '登录', '0:0:0:0:0:0:0:1', '2023-10-22 22:22:18', '2023-10-22 22:22:18', '/user/login', 'POST', 0, '用户名或密码错误', 100);
INSERT INTO `system_operation_log` VALUES ('1716097666958503937', NULL, '登录', '0:0:0:0:0:0:0:1', '2023-10-22 22:22:22', '2023-10-22 22:22:22', '/user/login', 'POST', 0, '用户名或密码错误', 101);
INSERT INTO `system_operation_log` VALUES ('1716097896785391617', NULL, '登录', '0:0:0:0:0:0:0:1', '2023-10-22 22:23:17', '2023-10-22 22:23:17', '/user/login', 'POST', 1, NULL, 132);
INSERT INTO `system_operation_log` VALUES ('1716097913130594305', NULL, '登录', '0:0:0:0:0:0:0:1', '2023-10-22 22:23:21', '2023-10-22 22:23:21', '/user/login', 'POST', 1, NULL, 96);
INSERT INTO `system_operation_log` VALUES ('1716097913206091778', '1', '查询个人信息', '0:0:0:0:0:0:0:1', '2023-10-22 22:23:21', '2023-10-22 22:23:21', '/user/info', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1716097913591967745', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-10-22 22:23:21', '2023-10-22 22:23:21', '/permission/getPerm', 'GET', 1, NULL, 101);
INSERT INTO `system_operation_log` VALUES ('1716097938824900609', NULL, '登录', '0:0:0:0:0:0:0:1', '2023-10-22 22:23:22', '2023-10-22 22:23:22', '/user/login', 'POST', 1, NULL, 98);
INSERT INTO `system_operation_log` VALUES ('1716097955161714690', '1', '查询个人信息', '0:0:0:0:0:0:0:1', '2023-10-22 22:23:22', '2023-10-22 22:23:22', '/user/info', 'GET', 1, NULL, 7);
INSERT INTO `system_operation_log` VALUES ('1716097955224629250', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-10-22 22:23:22', '2023-10-22 22:23:22', '/permission/getPerm', 'GET', 1, NULL, 8);
INSERT INTO `system_operation_log` VALUES ('1716097955673419777', '1', '查询是否是第一次登陆', '0:0:0:0:0:0:0:1', '2023-10-22 22:23:22', '2023-10-22 22:23:22', '/family/checkIsFirst', 'GET', 1, NULL, 56);
INSERT INTO `system_operation_log` VALUES ('1716098004956491777', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2023-10-22 22:23:43', '2023-10-22 22:23:43', '/dashboard/dashboardInfo', 'GET', 1, NULL, 101);
INSERT INTO `system_operation_log` VALUES ('1716098005057155074', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-10-22 22:23:43', '2023-10-22 22:23:43', '/floor/floorList', 'GET', 1, NULL, 130);
INSERT INTO `system_operation_log` VALUES ('1716098389498671105', NULL, '登录', '0:0:0:0:0:0:0:1', '2023-10-22 22:25:14', '2023-10-22 22:25:14', '/user/login', 'POST', 1, NULL, 102);
INSERT INTO `system_operation_log` VALUES ('1716098389691609090', '1', '查询个人信息', '0:0:0:0:0:0:0:1', '2023-10-22 22:25:14', '2023-10-22 22:25:14', '/user/info', 'GET', 1, NULL, 20);
INSERT INTO `system_operation_log` VALUES ('1716098389691609091', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-10-22 22:25:14', '2023-10-22 22:25:14', '/permission/getPerm', 'GET', 1, NULL, 22);
INSERT INTO `system_operation_log` VALUES ('1716098389758717954', '1', '查询是否是第一次登陆', '0:0:0:0:0:0:0:1', '2023-10-22 22:25:14', '2023-10-22 22:25:14', '/family/checkIsFirst', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1716098431571734530', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-10-22 22:25:15', '2023-10-22 22:25:15', '/floor/floorList', 'GET', 1, NULL, 1);
INSERT INTO `system_operation_log` VALUES ('1716098431697563649', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2023-10-22 22:25:15', '2023-10-22 22:25:15', '/dashboard/dashboardInfo', 'GET', 1, NULL, 22);
INSERT INTO `system_operation_log` VALUES ('1716820750611038210', NULL, '登录', '0:0:0:0:0:0:0:1', '2023-10-24 22:15:39', '2023-10-24 22:15:39', '/user/login', 'POST', 0, '用户名或密码错误', 797);
INSERT INTO `system_operation_log` VALUES ('1716820888326815745', NULL, '登录', '0:0:0:0:0:0:0:1', '2023-10-24 22:16:11', '2023-10-24 22:16:11', '/user/login', 'POST', 1, NULL, 112);
INSERT INTO `system_operation_log` VALUES ('1716821098792796161', NULL, '登录', '0:0:0:0:0:0:0:1', '2023-10-24 22:17:02', '2023-10-24 22:17:02', '/user/login', 'POST', 1, NULL, 102);
INSERT INTO `system_operation_log` VALUES ('1716821098872487937', '1', '查询个人信息', '0:0:0:0:0:0:0:1', '2023-10-24 22:17:02', '2023-10-24 22:17:02', '/user/info', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1716821536254509058', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-10-24 22:18:46', '2023-10-24 22:18:46', '/permission/getPerm', 'GET', 1, NULL, 104274);
INSERT INTO `system_operation_log` VALUES ('1716821611231887361', NULL, '登录', '0:0:0:0:0:0:0:1', '2023-10-24 22:19:04', '2023-10-24 22:19:04', '/user/login', 'POST', 1, NULL, 102);
INSERT INTO `system_operation_log` VALUES ('1716821611366105089', '1', '查询个人信息', '0:0:0:0:0:0:0:1', '2023-10-24 22:19:04', '2023-10-24 22:19:04', '/user/info', 'GET', 1, NULL, 9);
INSERT INTO `system_operation_log` VALUES ('1716821611366105090', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-10-24 22:19:04', '2023-10-24 22:19:04', '/permission/getPerm', 'GET', 1, NULL, 10);
INSERT INTO `system_operation_log` VALUES ('1716821611554848770', '1', '查询是否是第一次登陆', '0:0:0:0:0:0:0:1', '2023-10-24 22:19:04', '2023-10-24 22:19:04', '/family/checkIsFirst', 'GET', 1, NULL, 35);
INSERT INTO `system_operation_log` VALUES ('1716829864602943489', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2023-10-24 22:51:52', '2023-10-24 22:51:52', '/dashboard/dashboardInfo', 'GET', 1, NULL, 92);
INSERT INTO `system_operation_log` VALUES ('1716829864602943490', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-10-24 22:51:52', '2023-10-24 22:51:52', '/floor/floorList', 'GET', 1, NULL, 110);
INSERT INTO `system_operation_log` VALUES ('1716832508889317377', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-10-24 23:02:22', '2023-10-24 23:02:22', '/floor/floorList', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1716832509036118017', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2023-10-24 23:02:22', '2023-10-24 23:02:22', '/dashboard/dashboardInfo', 'GET', 1, NULL, 20);
INSERT INTO `system_operation_log` VALUES ('1716832835197779970', NULL, '登录', '0:0:0:0:0:0:0:1', '2023-10-24 23:03:40', '2023-10-24 23:03:40', '/user/login', 'POST', 1, NULL, 98);
INSERT INTO `system_operation_log` VALUES ('1716832835260694529', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-10-24 23:03:40', '2023-10-24 23:03:40', '/permission/getPerm', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1716832835260694530', '1', '查询个人信息', '0:0:0:0:0:0:0:1', '2023-10-24 23:03:40', '2023-10-24 23:03:40', '/user/info', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1716832835382329345', '1', '查询是否是第一次登陆', '0:0:0:0:0:0:0:1', '2023-10-24 23:03:40', '2023-10-24 23:03:40', '/family/checkIsFirst', 'GET', 1, NULL, 7);
INSERT INTO `system_operation_log` VALUES ('1716832877245677569', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-10-24 23:03:40', '2023-10-24 23:03:40', '/floor/floorList', 'GET', 1, NULL, 1);
INSERT INTO `system_operation_log` VALUES ('1716832877308592130', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2023-10-24 23:03:40', '2023-10-24 23:03:40', '/dashboard/dashboardInfo', 'GET', 1, NULL, 18);
INSERT INTO `system_operation_log` VALUES ('1716833153042137090', NULL, '登录', '0:0:0:0:0:0:0:1', '2023-10-24 23:04:56', '2023-10-24 23:04:56', '/user/login', 'POST', 1, NULL, 104);
INSERT INTO `system_operation_log` VALUES ('1716833153130217474', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-10-24 23:04:56', '2023-10-24 23:04:56', '/permission/getPerm', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1716833153130217475', '1', '查询个人信息', '0:0:0:0:0:0:0:1', '2023-10-24 23:04:56', '2023-10-24 23:04:56', '/user/info', 'GET', 1, NULL, 11);
INSERT INTO `system_operation_log` VALUES ('1716833153251852290', '1', '查询是否是第一次登陆', '0:0:0:0:0:0:0:1', '2023-10-24 23:04:56', '2023-10-24 23:04:56', '/family/checkIsFirst', 'GET', 1, NULL, 6);
INSERT INTO `system_operation_log` VALUES ('1716833195081646081', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-10-24 23:04:56', '2023-10-24 23:04:56', '/floor/floorList', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1716833195148754946', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2023-10-24 23:04:56', '2023-10-24 23:04:56', '/dashboard/dashboardInfo', 'GET', 1, NULL, 16);
INSERT INTO `system_operation_log` VALUES ('1716833528713363457', NULL, '登录', '0:0:0:0:0:0:0:1', '2023-10-24 23:06:25', '2023-10-24 23:06:25', '/user/login', 'POST', 1, NULL, 96);
INSERT INTO `system_operation_log` VALUES ('1716833528713363458', '1', '查询个人信息', '0:0:0:0:0:0:0:1', '2023-10-24 23:06:25', '2023-10-24 23:06:25', '/user/info', 'GET', 1, NULL, 2);
INSERT INTO `system_operation_log` VALUES ('1716833528713363459', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-10-24 23:06:25', '2023-10-24 23:06:25', '/permission/getPerm', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1716833528847581185', '1', '查询是否是第一次登陆', '0:0:0:0:0:0:0:1', '2023-10-24 23:06:25', '2023-10-24 23:06:25', '/family/checkIsFirst', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1716833570752872449', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-10-24 23:06:25', '2023-10-24 23:06:25', '/floor/floorList', 'GET', 1, NULL, 1);
INSERT INTO `system_operation_log` VALUES ('1716833570815787009', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2023-10-24 23:06:25', '2023-10-24 23:06:25', '/dashboard/dashboardInfo', 'GET', 1, NULL, 18);
INSERT INTO `system_operation_log` VALUES ('1716835914399924226', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-10-24 23:15:54', '2023-10-24 23:15:54', '/floor/floorList', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1716835914399924227', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2023-10-24 23:15:54', '2023-10-24 23:15:54', '/dashboard/dashboardInfo', 'GET', 1, NULL, 22);
INSERT INTO `system_operation_log` VALUES ('1716836105614049281', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-10-24 23:16:39', '2023-10-24 23:16:39', '/floor/floorList', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1716836105660186626', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2023-10-24 23:16:40', '2023-10-24 23:16:40', '/dashboard/dashboardInfo', 'GET', 1, NULL, 21);
INSERT INTO `system_operation_log` VALUES ('1716836586281287681', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-10-24 23:18:34', '2023-10-24 23:18:34', '/floor/floorList', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1716836586281287682', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2023-10-24 23:18:34', '2023-10-24 23:18:34', '/dashboard/dashboardInfo', 'GET', 1, NULL, 14);
INSERT INTO `system_operation_log` VALUES ('1716836787331055618', NULL, '登录', '0:0:0:0:0:0:0:1', '2023-10-24 23:19:22', '2023-10-24 23:19:22', '/user/login', 'POST', 1, NULL, 96);
INSERT INTO `system_operation_log` VALUES ('1716836802472493057', NULL, '登录', '0:0:0:0:0:0:0:1', '2023-10-24 23:19:26', '2023-10-24 23:19:26', '/user/login', 'POST', 1, NULL, 133);
INSERT INTO `system_operation_log` VALUES ('1716836802547990529', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-10-24 23:19:26', '2023-10-24 23:19:26', '/permission/getPerm', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1716836802619293697', '1', '查询个人信息', '0:0:0:0:0:0:0:1', '2023-10-24 23:19:26', '2023-10-24 23:19:26', '/user/info', 'GET', 1, NULL, 2);
INSERT INTO `system_operation_log` VALUES ('1716836854100180993', NULL, '登录', '0:0:0:0:0:0:0:1', '2023-10-24 23:19:38', '2023-10-24 23:19:38', '/user/login', 'POST', 1, NULL, 97);
INSERT INTO `system_operation_log` VALUES ('1716836854100180994', '1', '查询个人信息', '0:0:0:0:0:0:0:1', '2023-10-24 23:19:38', '2023-10-24 23:19:38', '/user/info', 'GET', 1, NULL, 2);
INSERT INTO `system_operation_log` VALUES ('1716836854100180995', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-10-24 23:19:38', '2023-10-24 23:19:38', '/permission/getPerm', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1716836854234398721', '1', '查询是否是第一次登陆', '0:0:0:0:0:0:0:1', '2023-10-24 23:19:38', '2023-10-24 23:19:38', '/family/checkIsFirst', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1716836896118718466', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-10-24 23:19:42', '2023-10-24 23:19:42', '/floor/floorList', 'GET', 1, NULL, 1);
INSERT INTO `system_operation_log` VALUES ('1716836896181633026', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2023-10-24 23:19:42', '2023-10-24 23:19:42', '/dashboard/dashboardInfo', 'GET', 1, NULL, 17);
INSERT INTO `system_operation_log` VALUES ('1718626012783300610', NULL, '登录', '0:0:0:0:0:0:0:1', '2023-10-29 21:49:07', '2023-10-29 21:49:07', '/user/login', 'POST', 0, '用户不存在', 821);
INSERT INTO `system_operation_log` VALUES ('1718626081188204546', NULL, '登录', '0:0:0:0:0:0:0:1', '2023-10-29 21:49:23', '2023-10-29 21:49:23', '/user/login', 'POST', 0, '用户不存在', 5);
INSERT INTO `system_operation_log` VALUES ('1718626287883505665', NULL, '登录', '0:0:0:0:0:0:0:1', '2023-10-29 21:50:12', '2023-10-29 21:50:12', '/user/login', 'POST', 1, NULL, 122);
INSERT INTO `system_operation_log` VALUES ('1718626591458840577', NULL, '登录', '0:0:0:0:0:0:0:1', '2023-10-29 21:51:25', '2023-10-29 21:51:25', '/user/login', 'POST', 1, NULL, 98);
INSERT INTO `system_operation_log` VALUES ('1718626788138143745', '1', '查询个人信息', '0:0:0:0:0:0:0:1', '2023-10-29 21:52:11', '2023-10-29 21:52:11', '/user/info', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1718626788234612738', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-10-29 21:52:12', '2023-10-29 21:52:12', '/permission/getPerm', 'GET', 1, NULL, 19963);
INSERT INTO `system_operation_log` VALUES ('1718626829099716610', NULL, '登录', '0:0:0:0:0:0:0:1', '2023-10-29 21:52:21', '2023-10-29 21:52:21', '/user/login', 'POST', 1, NULL, 93);
INSERT INTO `system_operation_log` VALUES ('1718626875580993537', '1', '查询个人信息', '0:0:0:0:0:0:0:1', '2023-10-29 21:52:32', '2023-10-29 21:52:32', '/user/info', 'GET', 1, NULL, 7);
INSERT INTO `system_operation_log` VALUES ('1718626875580993538', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-10-29 21:52:32', '2023-10-29 21:52:32', '/permission/getPerm', 'GET', 1, NULL, 10);
INSERT INTO `system_operation_log` VALUES ('1718626897055830017', NULL, '登录', '0:0:0:0:0:0:0:1', '2023-10-29 21:52:37', '2023-10-29 21:52:37', '/user/login', 'POST', 1, NULL, 96);
INSERT INTO `system_operation_log` VALUES ('1718626897122938881', '1', '查询个人信息', '0:0:0:0:0:0:0:1', '2023-10-29 21:52:37', '2023-10-29 21:52:37', '/user/info', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1718626917637279746', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-10-29 21:52:37', '2023-10-29 21:52:37', '/permission/getPerm', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1718627244495196161', NULL, '登录', '0:0:0:0:0:0:0:1', '2023-10-29 21:54:00', '2023-10-29 21:54:00', '/user/login', 'POST', 1, NULL, 103);
INSERT INTO `system_operation_log` VALUES ('1718627259233980417', NULL, '登录', '0:0:0:0:0:0:0:1', '2023-10-29 21:54:04', '2023-10-29 21:54:04', '/user/login', 'POST', 1, NULL, 96);
INSERT INTO `system_operation_log` VALUES ('1718627259322060802', '1', '查询个人信息', '0:0:0:0:0:0:0:1', '2023-10-29 21:54:04', '2023-10-29 21:54:04', '/user/info', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1718627259322060803', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-10-29 21:54:04', '2023-10-29 21:54:04', '/permission/getPerm', 'GET', 1, NULL, 7);
INSERT INTO `system_operation_log` VALUES ('1718627286538899457', '1', '查询是否是第一次登陆', '0:0:0:0:0:0:0:1', '2023-10-29 21:54:04', '2023-10-29 21:54:04', '/family/checkIsFirst', 'GET', 1, NULL, 29);
INSERT INTO `system_operation_log` VALUES ('1718627849565491201', NULL, '登录', '0:0:0:0:0:0:0:1', '2023-10-29 21:56:25', '2023-10-29 21:56:25', '/user/login', 'POST', 1, NULL, 109);
INSERT INTO `system_operation_log` VALUES ('1718627849695514626', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-10-29 21:56:25', '2023-10-29 21:56:25', '/permission/getPerm', 'GET', 1, NULL, 16);
INSERT INTO `system_operation_log` VALUES ('1718627849695514627', '1', '查询个人信息', '0:0:0:0:0:0:0:1', '2023-10-29 21:56:25', '2023-10-29 21:56:25', '/user/info', 'GET', 1, NULL, 13);
INSERT INTO `system_operation_log` VALUES ('1718627850022670337', '1', '查询是否是第一次登陆', '0:0:0:0:0:0:0:1', '2023-10-29 21:56:25', '2023-10-29 21:56:25', '/family/checkIsFirst', 'GET', 1, NULL, 21);
INSERT INTO `system_operation_log` VALUES ('1718627891567251458', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2023-10-29 21:56:25', '2023-10-29 21:56:25', '/dashboard/dashboardInfo', 'GET', 1, NULL, 92);
INSERT INTO `system_operation_log` VALUES ('1718627891768578049', NULL, '登录', '0:0:0:0:0:0:0:1', '2023-10-29 21:56:31', '2023-10-29 21:56:31', '/user/login', 'POST', 1, NULL, 106);
INSERT INTO `system_operation_log` VALUES ('1718627891768578050', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-10-29 21:56:25', '2023-10-29 21:56:25', '/floor/floorList', 'GET', 1, NULL, 103);
INSERT INTO `system_operation_log` VALUES ('1718627892037013506', '1', '查询个人信息', '0:0:0:0:0:0:0:1', '2023-10-29 21:56:31', '2023-10-29 21:56:31', '/user/info', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1718627933556428802', '1', '查询是否是第一次登陆', '0:0:0:0:0:0:0:1', '2023-10-29 21:56:31', '2023-10-29 21:56:31', '/family/checkIsFirst', 'GET', 1, NULL, 6);
INSERT INTO `system_operation_log` VALUES ('1718627933753561089', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2023-10-29 21:56:35', '2023-10-29 21:56:35', '/dashboard/dashboardInfo', 'GET', 1, NULL, 21);
INSERT INTO `system_operation_log` VALUES ('1718627933753561090', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-10-29 21:56:35', '2023-10-29 21:56:35', '/floor/floorList', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1718627958227324929', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-10-29 21:56:50', '2023-10-29 21:56:50', '/floor/floorList', 'GET', 1, NULL, 1);
INSERT INTO `system_operation_log` VALUES ('1718627975579160578', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2023-10-29 21:56:51', '2023-10-29 21:56:51', '/dashboard/dashboardInfo', 'GET', 1, NULL, 26);
INSERT INTO `system_operation_log` VALUES ('1718627996450017281', NULL, '', '0:0:0:0:0:0:0:1', '2023-10-29 21:57:00', '2023-10-29 21:57:00', '/error', 'GET', 0, '系统错误请联系管理员', 15);
INSERT INTO `system_operation_log` VALUES ('1718628010660319234', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-10-29 21:57:03', '2023-10-29 21:57:03', '/floor/floorList', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1718628010781954050', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2023-10-29 21:57:03', '2023-10-29 21:57:03', '/dashboard/dashboardInfo', 'GET', 1, NULL, 20);
INSERT INTO `system_operation_log` VALUES ('1718629664428249089', NULL, '', '0:0:0:0:0:0:0:1', '2023-10-29 22:03:37', '2023-10-29 22:03:37', '/error', 'GET', 0, '系统错误请联系管理员', 1);
INSERT INTO `system_operation_log` VALUES ('1718629702558666753', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-10-29 22:03:46', '2023-10-29 22:03:46', '/floor/floorList', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1718629702558666754', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2023-10-29 22:03:46', '2023-10-29 22:03:46', '/dashboard/dashboardInfo', 'GET', 1, NULL, 16);
INSERT INTO `system_operation_log` VALUES ('1718629951633215489', NULL, '登录', '0:0:0:0:0:0:0:1', '2023-10-29 22:04:46', '2023-10-29 22:04:46', '/user/login', 'POST', 1, NULL, 96);
INSERT INTO `system_operation_log` VALUES ('1718629951717101570', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-10-29 22:04:46', '2023-10-29 22:04:46', '/permission/getPerm', 'GET', 1, NULL, 8);
INSERT INTO `system_operation_log` VALUES ('1718629951717101571', '1', '查询个人信息', '0:0:0:0:0:0:0:1', '2023-10-29 22:04:46', '2023-10-29 22:04:46', '/user/info', 'GET', 1, NULL, 11);
INSERT INTO `system_operation_log` VALUES ('1718629951910039554', '1', '查询是否是第一次登陆', '0:0:0:0:0:0:0:1', '2023-10-29 22:04:46', '2023-10-29 22:04:46', '/family/checkIsFirst', 'GET', 1, NULL, 7);
INSERT INTO `system_operation_log` VALUES ('1718629993676918786', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2023-10-29 22:04:46', '2023-10-29 22:04:46', '/dashboard/dashboardInfo', 'GET', 1, NULL, 14);
INSERT INTO `system_operation_log` VALUES ('1718629993802747905', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-10-29 22:04:50', '2023-10-29 22:04:50', '/floor/floorList', 'GET', 1, NULL, 1);
INSERT INTO `system_operation_log` VALUES ('1718629993802747906', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-10-29 22:04:46', '2023-10-29 22:04:46', '/floor/floorList', 'GET', 1, NULL, 6);
INSERT INTO `system_operation_log` VALUES ('1718629993932771330', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2023-10-29 22:04:50', '2023-10-29 22:04:50', '/dashboard/dashboardInfo', 'GET', 1, NULL, 19);
INSERT INTO `system_operation_log` VALUES ('1718630182907138049', NULL, '', '0:0:0:0:0:0:0:1', '2023-10-29 22:05:41', '2023-10-29 22:05:41', '/error', 'GET', 0, '系统错误请联系管理员', 0);
INSERT INTO `system_operation_log` VALUES ('1718630200019898370', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-10-29 22:05:45', '2023-10-29 22:05:45', '/floor/floorList', 'GET', 1, NULL, 2);
INSERT INTO `system_operation_log` VALUES ('1718630200137338882', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2023-10-29 22:05:45', '2023-10-29 22:05:45', '/dashboard/dashboardInfo', 'GET', 1, NULL, 18);
INSERT INTO `system_operation_log` VALUES ('1718630207854858241', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-10-29 22:05:47', '2023-10-29 22:05:47', '/product/page', 'GET', 1, NULL, 214);
INSERT INTO `system_operation_log` VALUES ('1718632121237622785', NULL, '登录', '0:0:0:0:0:0:0:1', '2023-10-29 22:13:23', '2023-10-29 22:13:23', '/user/login', 'POST', 1, NULL, 97);
INSERT INTO `system_operation_log` VALUES ('1718632121304731649', '1', '查询个人信息', '0:0:0:0:0:0:0:1', '2023-10-29 22:13:23', '2023-10-29 22:13:23', '/user/info', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1718632121304731650', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-10-29 22:13:23', '2023-10-29 22:13:23', '/permission/getPerm', 'GET', 1, NULL, 8);
INSERT INTO `system_operation_log` VALUES ('1718632121430560770', '1', '查询是否是第一次登陆', '0:0:0:0:0:0:0:1', '2023-10-29 22:13:23', '2023-10-29 22:13:23', '/family/checkIsFirst', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1718632163272937474', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-10-29 22:13:23', '2023-10-29 22:13:23', '/floor/floorList', 'GET', 1, NULL, 1);
INSERT INTO `system_operation_log` VALUES ('1718632163402960897', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2023-10-29 22:13:23', '2023-10-29 22:13:23', '/dashboard/dashboardInfo', 'GET', 1, NULL, 18);
INSERT INTO `system_operation_log` VALUES ('1718632206105169922', NULL, '登录', '0:0:0:0:0:0:0:1', '2023-10-29 22:13:43', '2023-10-29 22:13:43', '/user/login', 'POST', 1, NULL, 96);
INSERT INTO `system_operation_log` VALUES ('1718632206172278785', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-10-29 22:13:43', '2023-10-29 22:13:43', '/permission/getPerm', 'GET', 1, NULL, 6);
INSERT INTO `system_operation_log` VALUES ('1718632206172278786', '1', '查询个人信息', '0:0:0:0:0:0:0:1', '2023-10-29 22:13:43', '2023-10-29 22:13:43', '/user/info', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1718632206235193345', '1', '查询是否是第一次登陆', '0:0:0:0:0:0:0:1', '2023-10-29 22:13:43', '2023-10-29 22:13:43', '/family/checkIsFirst', 'GET', 1, NULL, 6);
INSERT INTO `system_operation_log` VALUES ('1718632248144678913', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-10-29 22:13:43', '2023-10-29 22:13:43', '/floor/floorList', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1718632248211787777', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-10-29 22:13:46', '2023-10-29 22:13:46', '/product/page', 'GET', 1, NULL, 18);
INSERT INTO `system_operation_log` VALUES ('1718632248211787778', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2023-10-29 22:13:43', '2023-10-29 22:13:43', '/dashboard/dashboardInfo', 'GET', 1, NULL, 14);
INSERT INTO `system_operation_log` VALUES ('1718632248278896641', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-10-29 22:13:49', '2023-10-29 22:13:49', '/product/page', 'GET', 1, NULL, 28);
INSERT INTO `system_operation_log` VALUES ('1718633119326785537', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-10-29 22:17:21', '2023-10-29 22:17:21', '/product/page', 'GET', 1, NULL, 23);
INSERT INTO `system_operation_log` VALUES ('1718633336465903618', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-10-29 22:18:13', '2023-10-29 22:18:13', '/product/page', 'GET', 1, NULL, 26);
INSERT INTO `system_operation_log` VALUES ('1718633754319245313', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-10-29 22:19:52', '2023-10-29 22:19:52', '/product/page', 'GET', 1, NULL, 21);
INSERT INTO `system_operation_log` VALUES ('1718633975233236993', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-10-29 22:20:45', '2023-10-29 22:20:45', '/product/page', 'GET', 1, NULL, 18);
INSERT INTO `system_operation_log` VALUES ('1718634062378291203', NULL, '新增或修改产品', '0:0:0:0:0:0:0:1', '2023-10-29 22:21:06', '2023-10-29 22:21:06', '/product/addUpdate', 'POST', 1, NULL, 45);
INSERT INTO `system_operation_log` VALUES ('1718634062642532353', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-10-29 22:21:06', '2023-10-29 22:21:06', '/product/page', 'GET', 1, NULL, 36);
INSERT INTO `system_operation_log` VALUES ('1718634872474554369', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-10-29 22:24:19', '2023-10-29 22:24:19', '/product/page', 'GET', 1, NULL, 21);
INSERT INTO `system_operation_log` VALUES ('1719349181186891777', NULL, '登录', '0:0:0:0:0:0:0:1', '2023-10-31 21:42:43', '2023-10-31 21:42:43', '/user/login', 'POST', 1, NULL, 852);
INSERT INTO `system_operation_log` VALUES ('1719349368315764737', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-10-31 21:43:28', '2023-10-31 21:43:28', '/permission/getPerm', 'GET', 1, NULL, 44519);
INSERT INTO `system_operation_log` VALUES ('1719349462037487618', NULL, '登录', '0:0:0:0:0:0:0:1', '2023-10-31 21:43:50', '2023-10-31 21:43:50', '/user/login', 'POST', 1, NULL, 113);
INSERT INTO `system_operation_log` VALUES ('1719349462167511042', '1', '查询个人信息', '0:0:0:0:0:0:0:1', '2023-10-31 21:43:50', '2023-10-31 21:43:50', '/user/info', 'GET', 1, NULL, 12);
INSERT INTO `system_operation_log` VALUES ('1719349462238814210', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-10-31 21:43:50', '2023-10-31 21:43:50', '/permission/getPerm', 'GET', 1, NULL, 19);
INSERT INTO `system_operation_log` VALUES ('1719349814950400001', NULL, '登录', '0:0:0:0:0:0:0:1', '2023-10-31 21:45:14', '2023-10-31 21:45:14', '/user/login', 'POST', 1, NULL, 775);
INSERT INTO `system_operation_log` VALUES ('1719349815478882306', '1', '查询个人信息', '0:0:0:0:0:0:0:1', '2023-10-31 21:45:15', '2023-10-31 21:45:15', '/user/info', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1719349815587934209', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-10-31 21:45:15', '2023-10-31 21:45:15', '/permission/getPerm', 'GET', 1, NULL, 34);
INSERT INTO `system_operation_log` VALUES ('1719349815722151938', '1', '查询是否是第一次登陆', '0:0:0:0:0:0:0:1', '2023-10-31 21:45:15', '2023-10-31 21:45:15', '/family/checkIsFirst', 'GET', 1, NULL, 34);
INSERT INTO `system_operation_log` VALUES ('1719349856964743169', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2023-10-31 21:45:15', '2023-10-31 21:45:15', '/dashboard/dashboardInfo', 'GET', 1, NULL, 37);
INSERT INTO `system_operation_log` VALUES ('1719349857484836866', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-10-31 21:45:15', '2023-10-31 21:45:15', '/floor/floorList', 'GET', 1, NULL, 49);
INSERT INTO `system_operation_log` VALUES ('1719349899784392706', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-10-31 21:45:35', '2023-10-31 21:45:35', '/floor/floorList', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1719349899914416130', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2023-10-31 21:45:35', '2023-10-31 21:45:35', '/dashboard/dashboardInfo', 'GET', 1, NULL, 19);
INSERT INTO `system_operation_log` VALUES ('1719349918155444225', NULL, '', '0:0:0:0:0:0:0:1', '2023-10-31 21:45:39', '2023-10-31 21:45:39', '/error', 'GET', 0, '系统错误请联系管理员', 7);
INSERT INTO `system_operation_log` VALUES ('1719349942176223233', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-10-31 21:45:45', '2023-10-31 21:45:45', '/product/page', 'GET', 1, NULL, 104);
INSERT INTO `system_operation_log` VALUES ('1719350530431553537', NULL, '登录', '0:0:0:0:0:0:0:1', '2023-10-31 21:48:05', '2023-10-31 21:48:05', '/user/login', 'POST', 1, NULL, 94);
INSERT INTO `system_operation_log` VALUES ('1719350530494468097', '1', '查询个人信息', '0:0:0:0:0:0:0:1', '2023-10-31 21:48:05', '2023-10-31 21:48:05', '/user/info', 'GET', 1, NULL, 2);
INSERT INTO `system_operation_log` VALUES ('1719350530494468098', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-10-31 21:48:05', '2023-10-31 21:48:05', '/permission/getPerm', 'GET', 1, NULL, 6);
INSERT INTO `system_operation_log` VALUES ('1719350530561576961', '1', '查询是否是第一次登陆', '0:0:0:0:0:0:0:1', '2023-10-31 21:48:05', '2023-10-31 21:48:05', '/family/checkIsFirst', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1719350572475256833', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-10-31 21:48:05', '2023-10-31 21:48:05', '/floor/floorList', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1719350572542365698', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-10-31 21:48:09', '2023-10-31 21:48:09', '/floor/floorList', 'GET', 1, NULL, 1);
INSERT INTO `system_operation_log` VALUES ('1719350572542365699', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2023-10-31 21:48:05', '2023-10-31 21:48:05', '/dashboard/dashboardInfo', 'GET', 1, NULL, 15);
INSERT INTO `system_operation_log` VALUES ('1719350572609474562', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2023-10-31 21:48:09', '2023-10-31 21:48:09', '/dashboard/dashboardInfo', 'GET', 1, NULL, 19);
INSERT INTO `system_operation_log` VALUES ('1719350614472822785', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2023-10-31 21:48:16', '2023-10-31 21:48:16', '/product/list', 'GET', 1, NULL, 9);
INSERT INTO `system_operation_log` VALUES ('1719350614539931649', NULL, '', '0:0:0:0:0:0:0:1', '2023-10-31 21:48:16', '2023-10-31 21:48:16', '/error', 'GET', 0, '系统错误请联系管理员', 0);
INSERT INTO `system_operation_log` VALUES ('1719350614539931650', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-10-31 21:48:20', '2023-10-31 21:48:20', '/product/page', 'GET', 1, NULL, 17);
INSERT INTO `system_operation_log` VALUES ('1719351501517787137', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-10-31 21:51:57', '2023-10-31 21:51:57', '/product/page', 'GET', 1, NULL, 24);
INSERT INTO `system_operation_log` VALUES ('1719351781042982913', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-10-31 21:53:03', '2023-10-31 21:53:03', '/product/page', 'GET', 1, NULL, 29);
INSERT INTO `system_operation_log` VALUES ('1719351837343125506', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-10-31 21:53:17', '2023-10-31 21:53:17', '/product/page', 'GET', 1, NULL, 38);
INSERT INTO `system_operation_log` VALUES ('1719351999335534594', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-10-31 21:53:55', '2023-10-31 21:53:55', '/product/page', 'GET', 1, NULL, 32);
INSERT INTO `system_operation_log` VALUES ('1719352422284955650', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-10-31 21:55:36', '2023-10-31 21:55:36', '/product/page', 'GET', 1, NULL, 24);
INSERT INTO `system_operation_log` VALUES ('1719352828989837313', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-10-31 21:57:13', '2023-10-31 21:57:13', '/product/page', 'GET', 1, NULL, 18);
INSERT INTO `system_operation_log` VALUES ('1719354180713353217', NULL, '登录', '0:0:0:0:0:0:0:1', '2023-10-31 22:02:35', '2023-10-31 22:02:35', '/user/login', 'POST', 1, NULL, 98);
INSERT INTO `system_operation_log` VALUES ('1719354180784656386', '1', '查询个人信息', '0:0:0:0:0:0:0:1', '2023-10-31 22:02:35', '2023-10-31 22:02:35', '/user/info', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1719354180784656387', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-10-31 22:02:35', '2023-10-31 22:02:35', '/permission/getPerm', 'GET', 1, NULL, 6);
INSERT INTO `system_operation_log` VALUES ('1719354180847570945', '1', '查询是否是第一次登陆', '0:0:0:0:0:0:0:1', '2023-10-31 22:02:35', '2023-10-31 22:02:35', '/family/checkIsFirst', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1719354222731890689', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-10-31 22:02:36', '2023-10-31 22:02:36', '/floor/floorList', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1719354222794805250', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2023-10-31 22:02:36', '2023-10-31 22:02:36', '/dashboard/dashboardInfo', 'GET', 1, NULL, 16);
INSERT INTO `system_operation_log` VALUES ('1719354222794805251', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2023-10-31 22:02:41', '2023-10-31 22:02:41', '/product/list', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1719354222861914114', NULL, '', '0:0:0:0:0:0:0:1', '2023-10-31 22:02:41', '2023-10-31 22:02:41', '/error', 'GET', 0, '系统错误请联系管理员', 0);
INSERT INTO `system_operation_log` VALUES ('1719354264721068034', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-10-31 22:02:43', '2023-10-31 22:02:43', '/product/page', 'GET', 1, NULL, 17);
INSERT INTO `system_operation_log` VALUES ('1719354264788176898', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-10-31 22:02:46', '2023-10-31 22:02:46', '/product/page', 'GET', 1, NULL, 23);
INSERT INTO `system_operation_log` VALUES ('1720711021333667842', NULL, '登录', '0:0:0:0:0:0:0:1', '2023-11-04 15:54:11', '2023-11-04 15:54:11', '/user/login', 'POST', 1, NULL, 481);
INSERT INTO `system_operation_log` VALUES ('1720711021534994434', '1', '查询个人信息', '0:0:0:0:0:0:0:1', '2023-11-04 15:54:11', '2023-11-04 15:54:11', '/user/info', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1720711021606297602', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-11-04 15:54:11', '2023-11-04 15:54:11', '/permission/getPerm', 'GET', 1, NULL, 29);
INSERT INTO `system_operation_log` VALUES ('1720711021799235586', '1', '查询是否是第一次登陆', '0:0:0:0:0:0:0:1', '2023-11-04 15:54:12', '2023-11-04 15:54:12', '/family/checkIsFirst', 'GET', 1, NULL, 29);
INSERT INTO `system_operation_log` VALUES ('1720711063293485057', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-04 15:54:12', '2023-11-04 15:54:12', '/floor/floorList', 'GET', 1, NULL, 20);
INSERT INTO `system_operation_log` VALUES ('1720711063620640769', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2023-11-04 15:54:12', '2023-11-04 15:54:12', '/dashboard/dashboardInfo', 'GET', 1, NULL, 36);
INSERT INTO `system_operation_log` VALUES ('1720711063683555329', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-04 15:54:16', '2023-11-04 15:54:16', '/floor/floorList', 'GET', 1, NULL, 1);
INSERT INTO `system_operation_log` VALUES ('1720711063817773058', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2023-11-04 15:54:16', '2023-11-04 15:54:16', '/dashboard/dashboardInfo', 'GET', 1, NULL, 18);
INSERT INTO `system_operation_log` VALUES ('1720711105320411138', NULL, '', '0:0:0:0:0:0:0:1', '2023-11-04 15:54:19', '2023-11-04 15:54:19', '/error', 'GET', 0, '系统错误请联系管理员', 2);
INSERT INTO `system_operation_log` VALUES ('1720711105647566850', NULL, '', '0:0:0:0:0:0:0:1', '2023-11-04 15:54:25', '2023-11-04 15:54:25', '/error', 'GET', 0, '系统错误请联系管理员', 0);
INSERT INTO `system_operation_log` VALUES ('1720711105647566851', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2023-11-04 15:54:25', '2023-11-04 15:54:25', '/product/list', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1720711105848893441', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-11-04 15:54:31', '2023-11-04 15:54:31', '/product/page', 'GET', 1, NULL, 16);
INSERT INTO `system_operation_log` VALUES ('1720775729366495233', NULL, '登录', '0:0:0:0:0:0:0:1', '2023-11-04 20:11:19', '2023-11-04 20:11:19', '/user/login', 'POST', 1, NULL, 846);
INSERT INTO `system_operation_log` VALUES ('1720775730360545281', '1', '查询个人信息', '0:0:0:0:0:0:0:1', '2023-11-04 20:11:19', '2023-11-04 20:11:19', '/user/info', 'GET', 1, NULL, 8);
INSERT INTO `system_operation_log` VALUES ('1720775730473791490', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-11-04 20:11:19', '2023-11-04 20:11:19', '/permission/getPerm', 'GET', 1, NULL, 53);
INSERT INTO `system_operation_log` VALUES ('1720775730788364290', '1', '查询是否是第一次登陆', '0:0:0:0:0:0:0:1', '2023-11-04 20:11:19', '2023-11-04 20:11:19', '/family/checkIsFirst', 'GET', 1, NULL, 35);
INSERT INTO `system_operation_log` VALUES ('1720775771666051074', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-04 20:11:20', '2023-11-04 20:11:20', '/floor/floorList', 'GET', 1, NULL, 37);
INSERT INTO `system_operation_log` VALUES ('1720775772467163138', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-04 20:11:28', '2023-11-04 20:11:28', '/floor/floorList', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1720775772467163139', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2023-11-04 20:11:20', '2023-11-04 20:11:20', '/dashboard/dashboardInfo', 'GET', 1, NULL, 49);
INSERT INTO `system_operation_log` VALUES ('1720775772790124545', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2023-11-04 20:11:28', '2023-11-04 20:11:28', '/dashboard/dashboardInfo', 'GET', 1, NULL, 18);
INSERT INTO `system_operation_log` VALUES ('1720775813676199937', NULL, '', '0:0:0:0:0:0:0:1', '2023-11-04 20:11:32', '2023-11-04 20:11:32', '/error', 'GET', 0, '系统错误请联系管理员', 21);
INSERT INTO `system_operation_log` VALUES ('1720776599860736001', NULL, '登录', '0:0:0:0:0:0:0:1', '2023-11-04 20:14:47', '2023-11-04 20:14:47', '/user/login', 'POST', 1, NULL, 94);
INSERT INTO `system_operation_log` VALUES ('1720776599927844865', '1', '查询个人信息', '0:0:0:0:0:0:0:1', '2023-11-04 20:14:47', '2023-11-04 20:14:47', '/user/info', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1720776600007536641', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-11-04 20:14:47', '2023-11-04 20:14:47', '/permission/getPerm', 'GET', 1, NULL, 9);
INSERT INTO `system_operation_log` VALUES ('1720776600007536642', '1', '查询是否是第一次登陆', '0:0:0:0:0:0:0:1', '2023-11-04 20:14:47', '2023-11-04 20:14:47', '/family/checkIsFirst', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1720776641900244994', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-04 20:14:47', '2023-11-04 20:14:47', '/floor/floorList', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1720776641967353857', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2023-11-04 20:14:47', '2023-11-04 20:14:47', '/dashboard/dashboardInfo', 'GET', 1, NULL, 17);
INSERT INTO `system_operation_log` VALUES ('1720776642034462722', NULL, '', '0:0:0:0:0:0:0:1', '2023-11-04 20:14:52', '2023-11-04 20:14:52', '/error', 'GET', 0, '系统错误请联系管理员', 0);
INSERT INTO `system_operation_log` VALUES ('1720776642034462723', NULL, '', '0:0:0:0:0:0:0:1', '2023-11-04 20:14:50', '2023-11-04 20:14:50', '/error', 'GET', 0, '系统错误请联系管理员', 0);
INSERT INTO `system_operation_log` VALUES ('1720776683902005249', '1', '楼层分页查询', '0:0:0:0:0:0:0:1', '2023-11-04 20:14:55', '2023-11-04 20:14:55', '/floor/page', 'GET', 1, NULL, 85);
INSERT INTO `system_operation_log` VALUES ('1720776683969114113', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-04 20:14:59', '2023-11-04 20:14:59', '/floor/floorList', 'GET', 1, NULL, 1);
INSERT INTO `system_operation_log` VALUES ('1720776684036222977', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-11-04 20:15:00', '2023-11-04 20:15:00', '/room/page', 'GET', 1, NULL, 29);
INSERT INTO `system_operation_log` VALUES ('1720776824662847489', NULL, '', '0:0:0:0:0:0:0:1', '2023-11-04 20:15:40', '2023-11-04 20:15:40', '/error', 'GET', 0, '系统错误请联系管理员', 0);
INSERT INTO `system_operation_log` VALUES ('1720776861606277122', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-04 20:15:49', '2023-11-04 20:15:49', '/floor/floorList', 'GET', 1, NULL, 1);
INSERT INTO `system_operation_log` VALUES ('1720776861677580289', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-11-04 20:15:49', '2023-11-04 20:15:49', '/room/page', 'GET', 1, NULL, 14);
INSERT INTO `system_operation_log` VALUES ('1720776865137881090', '1', '楼层分页查询', '0:0:0:0:0:0:0:1', '2023-11-04 20:15:50', '2023-11-04 20:15:50', '/floor/page', 'GET', 1, NULL, 22);
INSERT INTO `system_operation_log` VALUES ('1720776871177678850', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-04 20:15:51', '2023-11-04 20:15:51', '/floor/floorList', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1720776903633203201', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-11-04 20:15:51', '2023-11-04 20:15:51', '/room/page', 'GET', 1, NULL, 14);
INSERT INTO `system_operation_log` VALUES ('1720776906988646402', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-04 20:16:00', '2023-11-04 20:16:00', '/floor/floorList', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1720776907177390081', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2023-11-04 20:16:00', '2023-11-04 20:16:00', '/dashboard/dashboardInfo', 'GET', 1, NULL, 26);
INSERT INTO `system_operation_log` VALUES ('1720776913192022018', NULL, '', '0:0:0:0:0:0:0:1', '2023-11-04 20:16:01', '2023-11-04 20:16:01', '/error', 'GET', 0, '系统错误请联系管理员', 0);
INSERT INTO `system_operation_log` VALUES ('1720776953427980290', '1', '楼层分页查询', '0:0:0:0:0:0:0:1', '2023-11-04 20:16:11', '2023-11-04 20:16:11', '/floor/page', 'GET', 1, NULL, 17);
INSERT INTO `system_operation_log` VALUES ('1720776961791422465', NULL, '', '0:0:0:0:0:0:0:1', '2023-11-04 20:16:13', '2023-11-04 20:16:13', '/error', 'GET', 0, '系统错误请联系管理员', 1);
INSERT INTO `system_operation_log` VALUES ('1720777503909408769', '1', '楼层分页查询', '0:0:0:0:0:0:0:1', '2023-11-04 20:18:22', '2023-11-04 20:18:22', '/floor/page', 'GET', 1, NULL, 17);
INSERT INTO `system_operation_log` VALUES ('1720777508921602050', NULL, '', '0:0:0:0:0:0:0:1', '2023-11-04 20:18:23', '2023-11-04 20:18:23', '/error', 'GET', 0, '系统错误请联系管理员', 0);
INSERT INTO `system_operation_log` VALUES ('1720777515372441602', NULL, '', '0:0:0:0:0:0:0:1', '2023-11-04 20:18:25', '2023-11-04 20:18:25', '/error', 'GET', 0, '系统错误请联系管理员', 0);
INSERT INTO `system_operation_log` VALUES ('1720777673157963777', NULL, '', '0:0:0:0:0:0:0:1', '2023-11-04 20:19:02', '2023-11-04 20:19:02', '/error', 'GET', 0, '系统错误请联系管理员', 1);
INSERT INTO `system_operation_log` VALUES ('1720780009922162690', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-04 20:28:20', '2023-11-04 20:28:20', '/family/page', 'GET', 1, NULL, 24);
INSERT INTO `system_operation_log` VALUES ('1720780091790782466', '1', '楼层分页查询', '0:0:0:0:0:0:0:1', '2023-11-04 20:28:39', '2023-11-04 20:28:39', '/floor/page', 'GET', 1, NULL, 17);
INSERT INTO `system_operation_log` VALUES ('1720780209545867265', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-04 20:29:07', '2023-11-04 20:29:07', '/family/page', 'GET', 1, NULL, 16);
INSERT INTO `system_operation_log` VALUES ('1720780603667836930', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-04 20:30:41', '2023-11-04 20:30:41', '/family/page', 'GET', 1, NULL, 16);
INSERT INTO `system_operation_log` VALUES ('1720780786862452738', '1', '楼层分页查询', '0:0:0:0:0:0:0:1', '2023-11-04 20:31:25', '2023-11-04 20:31:25', '/floor/page', 'GET', 1, NULL, 14);
INSERT INTO `system_operation_log` VALUES ('1720780914297991169', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-04 20:31:55', '2023-11-04 20:31:55', '/floor/floorList', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1720780914360905730', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-11-04 20:31:55', '2023-11-04 20:31:55', '/room/page', 'GET', 1, NULL, 18);
INSERT INTO `system_operation_log` VALUES ('1720781989084196865', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-04 20:36:11', '2023-11-04 20:36:11', '/family/page', 'GET', 1, NULL, 16);
INSERT INTO `system_operation_log` VALUES ('1720781996898185217', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-04 20:36:13', '2023-11-04 20:36:13', '/floor/floorList', 'GET', 1, NULL, 1);
INSERT INTO `system_operation_log` VALUES ('1720781996986265601', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-11-04 20:36:13', '2023-11-04 20:36:13', '/room/page', 'GET', 1, NULL, 16);
INSERT INTO `system_operation_log` VALUES ('1720781999293132802', '1', '楼层分页查询', '0:0:0:0:0:0:0:1', '2023-11-04 20:36:14', '2023-11-04 20:36:14', '/floor/page', 'GET', 1, NULL, 14);
INSERT INTO `system_operation_log` VALUES ('1720782031241146370', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-04 20:36:19', '2023-11-04 20:36:19', '/family/page', 'GET', 1, NULL, 16);
INSERT INTO `system_operation_log` VALUES ('1720782038933499905', '1', '楼层分页查询', '0:0:0:0:0:0:0:1', '2023-11-04 20:36:22', '2023-11-04 20:36:22', '/floor/page', 'GET', 1, NULL, 13);
INSERT INTO `system_operation_log` VALUES ('1720783277565997058', '1', '楼层分页查询', '0:0:0:0:0:0:0:1', '2023-11-04 20:41:19', '2023-11-04 20:41:19', '/floor/page', 'GET', 1, NULL, 70);
INSERT INTO `system_operation_log` VALUES ('1720783277729574914', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-11-04 20:41:19', '2023-11-04 20:41:19', '/family/list', 'GET', 1, NULL, 96);
INSERT INTO `system_operation_log` VALUES ('1720783512887422977', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-11-04 20:42:15', '2023-11-04 20:42:15', '/family/list', 'GET', 1, NULL, 6);
INSERT INTO `system_operation_log` VALUES ('1720783513017446402', '1', '楼层分页查询', '0:0:0:0:0:0:0:1', '2023-11-04 20:42:15', '2023-11-04 20:42:15', '/floor/page', 'GET', 1, NULL, 37);
INSERT INTO `system_operation_log` VALUES ('1720783784783179778', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-11-04 20:43:20', '2023-11-04 20:43:20', '/family/list', 'GET', 1, NULL, 6);
INSERT INTO `system_operation_log` VALUES ('1720783784921591809', '1', '楼层分页查询', '0:0:0:0:0:0:0:1', '2023-11-04 20:43:20', '2023-11-04 20:43:20', '/floor/page', 'GET', 1, NULL, 31);
INSERT INTO `system_operation_log` VALUES ('1720783959308169217', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-11-04 20:44:01', '2023-11-04 20:44:01', '/family/list', 'GET', 1, NULL, 26);
INSERT INTO `system_operation_log` VALUES ('1720783959308169218', '1', '楼层分页查询', '0:0:0:0:0:0:0:1', '2023-11-04 20:44:01', '2023-11-04 20:44:01', '/floor/page', 'GET', 1, NULL, 39);
INSERT INTO `system_operation_log` VALUES ('1720784112932941825', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-11-04 20:44:38', '2023-11-04 20:44:38', '/family/list', 'GET', 1, NULL, 17);
INSERT INTO `system_operation_log` VALUES ('1720784112932941826', '1', '楼层分页查询', '0:0:0:0:0:0:0:1', '2023-11-04 20:44:38', '2023-11-04 20:44:38', '/floor/page', 'GET', 1, NULL, 30);
INSERT INTO `system_operation_log` VALUES ('1720784240414617602', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-04 20:45:08', '2023-11-04 20:45:08', '/floor/floorList', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1720784240611749889', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-11-04 20:45:08', '2023-11-04 20:45:08', '/room/page', 'GET', 1, NULL, 34);
INSERT INTO `system_operation_log` VALUES ('1720784257967779841', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-11-04 20:45:12', '2023-11-04 20:45:12', '/family/list', 'GET', 1, NULL, 15);
INSERT INTO `system_operation_log` VALUES ('1720784258026500098', '1', '楼层分页查询', '0:0:0:0:0:0:0:1', '2023-11-04 20:45:12', '2023-11-04 20:45:12', '/floor/page', 'GET', 1, NULL, 22);
INSERT INTO `system_operation_log` VALUES ('1720784390151270401', '1', '楼层分页查询', '0:0:0:0:0:0:0:1', '2023-11-04 20:45:44', '2023-11-04 20:45:44', '/floor/page', 'GET', 1, NULL, 38);
INSERT INTO `system_operation_log` VALUES ('1720784390151270402', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-11-04 20:45:44', '2023-11-04 20:45:44', '/family/list', 'GET', 1, NULL, 10);
INSERT INTO `system_operation_log` VALUES ('1720784512583004161', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-11-04 20:46:13', '2023-11-04 20:46:13', '/family/list', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1720784512784330753', '1', '楼层分页查询', '0:0:0:0:0:0:0:1', '2023-11-04 20:46:13', '2023-11-04 20:46:13', '/floor/page', 'GET', 1, NULL, 35);
INSERT INTO `system_operation_log` VALUES ('1720784763276554242', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-11-04 20:47:13', '2023-11-04 20:47:13', '/family/list', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1720784763356246017', '1', '楼层分页查询', '0:0:0:0:0:0:0:1', '2023-11-04 20:47:13', '2023-11-04 20:47:13', '/floor/page', 'GET', 1, NULL, 33);
INSERT INTO `system_operation_log` VALUES ('1720784834390978563', '1', '新增或修改楼层', '0:0:0:0:0:0:0:1', '2023-11-04 20:47:30', '2023-11-04 20:47:30', '/floor/addUpdate', 'POST', 1, NULL, 51);
INSERT INTO `system_operation_log` VALUES ('1720784834588110850', '1', '楼层分页查询', '0:0:0:0:0:0:0:1', '2023-11-04 20:47:30', '2023-11-04 20:47:30', '/floor/page', 'GET', 1, NULL, 25);
INSERT INTO `system_operation_log` VALUES ('1720785626430763010', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-11-04 20:50:39', '2023-11-04 20:50:39', '/family/list', 'GET', 1, NULL, 17);
INSERT INTO `system_operation_log` VALUES ('1720785626623700993', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-11-04 20:50:39', '2023-11-04 20:50:39', '/floor/pageBackend', 'GET', 1, NULL, 75);
INSERT INTO `system_operation_log` VALUES ('1720785973199040514', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-11-04 20:52:01', '2023-11-04 20:52:01', '/family/list', 'GET', 1, NULL, 9);
INSERT INTO `system_operation_log` VALUES ('1720785973459087362', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-11-04 20:52:01', '2023-11-04 20:52:01', '/floor/pageBackend', 'GET', 1, NULL, 23);
INSERT INTO `system_operation_log` VALUES ('1720786602092982274', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-11-04 20:54:31', '2023-11-04 20:54:31', '/family/list', 'GET', 1, NULL, 13);
INSERT INTO `system_operation_log` VALUES ('1720786614533287937', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-11-04 20:54:34', '2023-11-04 20:54:34', '/family/list', 'GET', 1, NULL, 10);
INSERT INTO `system_operation_log` VALUES ('1720786936622280706', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-11-04 20:55:51', '2023-11-04 20:55:51', '/family/list', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1720787484973002753', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-11-04 20:58:02', '2023-11-04 20:58:02', '/floor/pageBackend', 'GET', 1, NULL, 20);
INSERT INTO `system_operation_log` VALUES ('1720787485031723010', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-11-04 20:58:02', '2023-11-04 20:58:02', '/family/list', 'GET', 1, NULL, 18);
INSERT INTO `system_operation_log` VALUES ('1720787867694854146', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-11-04 20:59:33', '2023-11-04 20:59:33', '/family/list', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1720787867824877569', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-11-04 20:59:33', '2023-11-04 20:59:33', '/floor/pageBackend', 'GET', 1, NULL, 32);
INSERT INTO `system_operation_log` VALUES ('1720787910338342913', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-11-04 20:59:43', '2023-11-04 20:59:43', '/family/list', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1720787910338342914', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-11-04 20:59:43', '2023-11-04 20:59:43', '/floor/pageBackend', 'GET', 1, NULL, 37);
INSERT INTO `system_operation_log` VALUES ('1720788162088857602', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-11-04 21:00:43', '2023-11-04 21:00:43', '/family/list', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1720788265696555009', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-11-04 21:01:08', '2023-11-04 21:01:08', '/family/list', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1720788265830772738', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-11-04 21:01:08', '2023-11-04 21:01:08', '/floor/pageBackend', 'GET', 1, NULL, 29);
INSERT INTO `system_operation_log` VALUES ('1720788363839074306', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-04 21:01:31', '2023-11-04 21:01:31', '/floor/floorList', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1720788363910377473', '1', '分页查询', '0:0:0:0:0:0:0:1', '2023-11-04 21:01:31', '2023-11-04 21:01:31', '/room/page', 'GET', 1, NULL, 27);
INSERT INTO `system_operation_log` VALUES ('1720788464003248129', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-04 21:01:55', '2023-11-04 21:01:55', '/family/page', 'GET', 1, NULL, 17);
INSERT INTO `system_operation_log` VALUES ('1720790277192478722', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-04 21:09:07', '2023-11-04 21:09:07', '/family/page', 'GET', 1, NULL, 6326);
INSERT INTO `system_operation_log` VALUES ('1720792301145485313', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-04 21:17:10', '2023-11-04 21:17:10', '/family/page', 'GET', 1, NULL, 24);
INSERT INTO `system_operation_log` VALUES ('1720792647024570369', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-04 21:18:33', '2023-11-04 21:18:33', '/family/page', 'GET', 1, NULL, 27);
INSERT INTO `system_operation_log` VALUES ('1720792857310195714', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-04 21:19:23', '2023-11-04 21:19:23', '/family/page', 'GET', 1, NULL, 16);
INSERT INTO `system_operation_log` VALUES ('1720793253713866754', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-04 21:20:57', '2023-11-04 21:20:57', '/family/page', 'GET', 1, NULL, 19);
INSERT INTO `system_operation_log` VALUES ('1720793302162272259', '1', '新增或修改家庭', '0:0:0:0:0:0:0:1', '2023-11-04 21:21:09', '2023-11-04 21:21:09', '/family/addUpdate', 'POST', 1, NULL, 19);
INSERT INTO `system_operation_log` VALUES ('1720793302363598850', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-04 21:21:09', '2023-11-04 21:21:09', '/family/page', 'GET', 1, NULL, 20);
INSERT INTO `system_operation_log` VALUES ('1720793350681980929', '1', '新增或修改家庭', '0:0:0:0:0:0:0:1', '2023-11-04 21:21:20', '2023-11-04 21:21:20', '/family/addUpdate', 'POST', 0, '家庭名称已存在', 7);
INSERT INTO `system_operation_log` VALUES ('1720793373532549121', '1', '新增或修改家庭', '0:0:0:0:0:0:0:1', '2023-11-04 21:21:26', '2023-11-04 21:21:26', '/family/addUpdate', 'POST', 0, '家庭名称已存在', 8);
INSERT INTO `system_operation_log` VALUES ('1720794039776768001', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-04 21:24:05', '2023-11-04 21:24:05', '/family/page', 'GET', 1, NULL, 20);
INSERT INTO `system_operation_log` VALUES ('1720794150950989826', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-04 21:24:31', '2023-11-04 21:24:31', '/family/page', 'GET', 1, NULL, 18);
INSERT INTO `system_operation_log` VALUES ('1720796115974025217', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-04 21:32:20', '2023-11-04 21:32:20', '/family/page', 'GET', 1, NULL, 18);
INSERT INTO `system_operation_log` VALUES ('1720796429305311234', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-04 21:33:34', '2023-11-04 21:33:34', '/family/page', 'GET', 1, NULL, 23);
INSERT INTO `system_operation_log` VALUES ('1720796650503442433', NULL, '登录', '0:0:0:0:0:0:0:1', '2023-11-04 21:34:27', '2023-11-04 21:34:27', '/user/login', 'POST', 1, NULL, 780);
INSERT INTO `system_operation_log` VALUES ('1720796650524413953', '1', '查询个人信息', '0:0:0:0:0:0:0:1', '2023-11-04 21:34:27', '2023-11-04 21:34:27', '/user/info', 'GET', 1, NULL, 8);
INSERT INTO `system_operation_log` VALUES ('1720796650780266498', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-11-04 21:34:27', '2023-11-04 21:34:27', '/permission/getPerm', 'GET', 1, NULL, 68);
INSERT INTO `system_operation_log` VALUES ('1720796650910289922', '1', '查询是否是第一次登陆', '0:0:0:0:0:0:0:1', '2023-11-04 21:34:27', '2023-11-04 21:34:27', '/family/checkIsFirst', 'GET', 1, NULL, 37);
INSERT INTO `system_operation_log` VALUES ('1720796692580700161', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-04 21:34:28', '2023-11-04 21:34:28', '/floor/floorList', 'GET', 1, NULL, 37);
INSERT INTO `system_operation_log` VALUES ('1720796692580700162', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2023-11-04 21:34:28', '2023-11-04 21:34:28', '/dashboard/dashboardInfo', 'GET', 1, NULL, 41);
INSERT INTO `system_operation_log` VALUES ('1720796692782026754', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-11-04 21:34:30', '2023-11-04 21:34:30', '/product/page', 'GET', 1, NULL, 125);
INSERT INTO `system_operation_log` VALUES ('1720796692979159042', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-04 21:34:31', '2023-11-04 21:34:31', '/family/page', 'GET', 1, NULL, 19);
INSERT INTO `system_operation_log` VALUES ('1720796734561488898', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-04 21:34:34', '2023-11-04 21:34:34', '/family/page', 'GET', 1, NULL, 21);
INSERT INTO `system_operation_log` VALUES ('1720796734561488899', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-04 21:34:44', '2023-11-04 21:34:44', '/family/page', 'GET', 1, NULL, 37);
INSERT INTO `system_operation_log` VALUES ('1720797148287635457', '1', '新增或修改家庭', '0:0:0:0:0:0:0:1', '2023-11-04 21:36:26', '2023-11-04 21:36:26', '/family/addUpdate', 'POST', 1, NULL, 36);
INSERT INTO `system_operation_log` VALUES ('1720797148417658882', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-04 21:36:26', '2023-11-04 21:36:26', '/family/page', 'GET', 1, NULL, 19);
INSERT INTO `system_operation_log` VALUES ('1720797561279778818', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-11-04 21:38:04', '2023-11-04 21:38:04', '/family/list', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1720797561451745281', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-11-04 21:38:04', '2023-11-04 21:38:04', '/floor/pageBackend', 'GET', 1, NULL, 46);
INSERT INTO `system_operation_log` VALUES ('1720797600001593346', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-04 21:38:13', '2023-11-04 21:38:13', '/family/page', 'GET', 1, NULL, 22);
INSERT INTO `system_operation_log` VALUES ('1720797604112011266', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-11-04 21:38:14', '2023-11-04 21:38:14', '/family/list', 'GET', 1, NULL, 6);
INSERT INTO `system_operation_log` VALUES ('1720797604174925826', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-11-04 21:38:14', '2023-11-04 21:38:14', '/floor/pageBackend', 'GET', 1, NULL, 25);
INSERT INTO `system_operation_log` VALUES ('1720797604883763202', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-04 21:38:15', '2023-11-04 21:38:15', '/floor/floorList', 'GET', 1, NULL, 1);
INSERT INTO `system_operation_log` VALUES ('1720797642074656770', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-11-04 21:38:15', '2023-11-04 21:38:15', '/room/page', 'GET', 1, NULL, 39);
INSERT INTO `system_operation_log` VALUES ('1720798828232216577', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-11-04 21:43:06', '2023-11-04 21:43:06', '/permission/getPerm', 'GET', 1, NULL, 6);
INSERT INTO `system_operation_log` VALUES ('1720798829574393857', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-04 21:43:07', '2023-11-04 21:43:07', '/floor/floorList', 'GET', 1, NULL, 1);
INSERT INTO `system_operation_log` VALUES ('1720798829574393858', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-11-04 21:43:07', '2023-11-04 21:43:07', '/room/page', 'GET', 1, NULL, 15);
INSERT INTO `system_operation_log` VALUES ('1720798890173698049', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-11-04 21:43:21', '2023-11-04 21:43:21', '/permission/getPerm', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1720798891436183553', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-04 21:43:21', '2023-11-04 21:43:21', '/floor/floorList', 'GET', 1, NULL, 1);
INSERT INTO `system_operation_log` VALUES ('1720798891436183554', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-11-04 21:43:21', '2023-11-04 21:43:21', '/room/page', 'GET', 1, NULL, 33);
INSERT INTO `system_operation_log` VALUES ('1720799018792030210', NULL, '登录', '0:0:0:0:0:0:0:1', '2023-11-04 21:43:52', '2023-11-04 21:43:52', '/user/login', 'POST', 1, NULL, 104);
INSERT INTO `system_operation_log` VALUES ('1720799018859139074', '1', '查询个人信息', '0:0:0:0:0:0:0:1', '2023-11-04 21:43:52', '2023-11-04 21:43:52', '/user/info', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1720799019022716930', '1', '查询是否是第一次登陆', '0:0:0:0:0:0:0:1', '2023-11-04 21:43:52', '2023-11-04 21:43:52', '/family/checkIsFirst', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1720799020620746753', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-04 21:43:52', '2023-11-04 21:43:52', '/floor/floorList', 'GET', 1, NULL, 1);
INSERT INTO `system_operation_log` VALUES ('1720799060844122114', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2023-11-04 21:43:52', '2023-11-04 21:43:52', '/dashboard/dashboardInfo', 'GET', 1, NULL, 21);
INSERT INTO `system_operation_log` VALUES ('1720799060907036674', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-11-04 21:43:56', '2023-11-04 21:43:56', '/permission/getPerm', 'GET', 1, NULL, 6);
INSERT INTO `system_operation_log` VALUES ('1720799061037060097', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-04 21:43:56', '2023-11-04 21:43:56', '/floor/floorList', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1720799062727364610', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2023-11-04 21:43:56', '2023-11-04 21:43:56', '/dashboard/dashboardInfo', 'GET', 1, NULL, 15);
INSERT INTO `system_operation_log` VALUES ('1720799377614737410', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-04 21:45:17', '2023-11-04 21:45:17', '/floor/floorList', 'GET', 1, NULL, 1);
INSERT INTO `system_operation_log` VALUES ('1720799377614737411', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-11-04 21:45:17', '2023-11-04 21:45:17', '/permission/getPerm', 'GET', 1, NULL, 7);
INSERT INTO `system_operation_log` VALUES ('1720799377711206401', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2023-11-04 21:45:17', '2023-11-04 21:45:17', '/dashboard/dashboardInfo', 'GET', 1, NULL, 14);
INSERT INTO `system_operation_log` VALUES ('1720799390784851970', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-11-04 21:45:20', '2023-11-04 21:45:20', '/permission/getPerm', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1720799419700383746', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2023-11-04 21:45:21', '2023-11-04 21:45:21', '/dashboard/dashboardInfo', 'GET', 1, NULL, 16);
INSERT INTO `system_operation_log` VALUES ('1720799419700383747', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-04 21:45:24', '2023-11-04 21:45:24', '/family/page', 'GET', 1, NULL, 18);
INSERT INTO `system_operation_log` VALUES ('1720799419700383748', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-04 21:45:21', '2023-11-04 21:45:21', '/floor/floorList', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1720799691000549377', NULL, '登录', '0:0:0:0:0:0:0:1', '2023-11-04 21:46:32', '2023-11-04 21:46:32', '/user/login', 'POST', 1, NULL, 100);
INSERT INTO `system_operation_log` VALUES ('1720799691071852546', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-11-04 21:46:32', '2023-11-04 21:46:32', '/permission/getPerm', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1720799691071852547', '1', '查询个人信息', '0:0:0:0:0:0:0:1', '2023-11-04 21:46:32', '2023-11-04 21:46:32', '/user/info', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1720799691134767105', '1', '查询是否是第一次登陆', '0:0:0:0:0:0:0:1', '2023-11-04 21:46:32', '2023-11-04 21:46:32', '/family/checkIsFirst', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1720799733006503938', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-04 21:46:32', '2023-11-04 21:46:32', '/floor/floorList', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1720799733073612801', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2023-11-04 21:46:32', '2023-11-04 21:46:32', '/dashboard/dashboardInfo', 'GET', 1, NULL, 14);
INSERT INTO `system_operation_log` VALUES ('1720802043971538945', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-11-04 21:55:53', '2023-11-04 21:55:53', '/permission/getPerm', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1720802046546841601', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-04 21:55:54', '2023-11-04 21:55:54', '/floor/floorList', 'GET', 1, NULL, 1);
INSERT INTO `system_operation_log` VALUES ('1720802046647504898', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2023-11-04 21:55:54', '2023-11-04 21:55:54', '/dashboard/dashboardInfo', 'GET', 1, NULL, 14);
INSERT INTO `system_operation_log` VALUES ('1720802083330887681', NULL, '登录', '0:0:0:0:0:0:0:1', '2023-11-04 21:56:02', '2023-11-04 21:56:02', '/user/login', 'POST', 1, NULL, 100);
INSERT INTO `system_operation_log` VALUES ('1720802086006853634', '1', '查询个人信息', '0:0:0:0:0:0:0:1', '2023-11-04 21:56:02', '2023-11-04 21:56:02', '/user/info', 'GET', 1, NULL, 2);
INSERT INTO `system_operation_log` VALUES ('1720802088598933506', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-11-04 21:56:02', '2023-11-04 21:56:02', '/permission/getPerm', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1720802088666042369', '1', '查询是否是第一次登陆', '0:0:0:0:0:0:0:1', '2023-11-04 21:56:02', '2023-11-04 21:56:02', '/family/checkIsFirst', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1720802125391368194', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-04 21:56:02', '2023-11-04 21:56:02', '/floor/floorList', 'GET', 1, NULL, 1);
INSERT INTO `system_operation_log` VALUES ('1720802127979253762', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2023-11-04 21:56:02', '2023-11-04 21:56:02', '/dashboard/dashboardInfo', 'GET', 1, NULL, 13);
INSERT INTO `system_operation_log` VALUES ('1720802180571631618', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-11-04 21:56:25', '2023-11-04 21:56:25', '/permission/getPerm', 'GET', 1, NULL, 6);
INSERT INTO `system_operation_log` VALUES ('1720802183323095042', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-04 21:56:26', '2023-11-04 21:56:26', '/floor/floorList', 'GET', 1, NULL, 1);
INSERT INTO `system_operation_log` VALUES ('1720802183323095043', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2023-11-04 21:56:26', '2023-11-04 21:56:26', '/dashboard/dashboardInfo', 'GET', 1, NULL, 11);
INSERT INTO `system_operation_log` VALUES ('1720802211961802754', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-11-04 21:56:33', '2023-11-04 21:56:33', '/permission/getPerm', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1720802222619529217', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-04 21:56:34', '2023-11-04 21:56:34', '/floor/floorList', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1720802225354215426', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2023-11-04 21:56:34', '2023-11-04 21:56:34', '/dashboard/dashboardInfo', 'GET', 1, NULL, 15);
INSERT INTO `system_operation_log` VALUES ('1720802230425128962', NULL, '登录', '0:0:0:0:0:0:0:1', '2023-11-04 21:56:37', '2023-11-04 21:56:37', '/user/login', 'POST', 1, NULL, 107);
INSERT INTO `system_operation_log` VALUES ('1720802254005506050', '1', '查询个人信息', '0:0:0:0:0:0:0:1', '2023-11-04 21:56:37', '2023-11-04 21:56:37', '/user/info', 'GET', 1, NULL, 2);
INSERT INTO `system_operation_log` VALUES ('1720802264642260993', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-11-04 21:56:37', '2023-11-04 21:56:37', '/permission/getPerm', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1720802267376947202', '1', '查询是否是第一次登陆', '0:0:0:0:0:0:0:1', '2023-11-04 21:56:37', '2023-11-04 21:56:37', '/family/checkIsFirst', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1720802272460443650', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-04 21:56:38', '2023-11-04 21:56:38', '/floor/floorList', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1720802296003072001', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2023-11-04 21:56:38', '2023-11-04 21:56:38', '/dashboard/dashboardInfo', 'GET', 1, NULL, 12);
INSERT INTO `system_operation_log` VALUES ('1720802451427201025', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-11-04 21:57:30', '2023-11-04 21:57:30', '/permission/getPerm', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1720802453998309377', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-04 21:57:31', '2023-11-04 21:57:31', '/floor/floorList', 'GET', 1, NULL, 1);
INSERT INTO `system_operation_log` VALUES ('1720802453998309378', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2023-11-04 21:57:31', '2023-11-04 21:57:31', '/dashboard/dashboardInfo', 'GET', 1, NULL, 11);
INSERT INTO `system_operation_log` VALUES ('1720802472558104577', NULL, '登录', '0:0:0:0:0:0:0:1', '2023-11-04 21:57:35', '2023-11-04 21:57:35', '/user/login', 'POST', 1, NULL, 99);
INSERT INTO `system_operation_log` VALUES ('1720802493424766977', '1', '查询个人信息', '0:0:0:0:0:0:0:1', '2023-11-04 21:57:35', '2023-11-04 21:57:35', '/user/info', 'GET', 1, NULL, 2);
INSERT INTO `system_operation_log` VALUES ('1720802496092344322', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-11-04 21:57:35', '2023-11-04 21:57:35', '/permission/getPerm', 'GET', 1, NULL, 7);
INSERT INTO `system_operation_log` VALUES ('1720802496155258882', '1', '查询是否是第一次登陆', '0:0:0:0:0:0:0:1', '2023-11-04 21:57:35', '2023-11-04 21:57:35', '/family/checkIsFirst', 'GET', 1, NULL, 2);
INSERT INTO `system_operation_log` VALUES ('1720802539327229954', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-11-04 21:57:51', '2023-11-04 21:57:51', '/permission/getPerm', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1720802546004561921', NULL, '登录', '0:0:0:0:0:0:0:1', '2023-11-04 21:57:53', '2023-11-04 21:57:53', '/user/login', 'POST', 1, NULL, 99);
INSERT INTO `system_operation_log` VALUES ('1720802546004561922', '1', '查询个人信息', '0:0:0:0:0:0:0:1', '2023-11-04 21:57:53', '2023-11-04 21:57:53', '/user/info', 'GET', 1, NULL, 1);
INSERT INTO `system_operation_log` VALUES ('1720802546084253698', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-11-04 21:57:53', '2023-11-04 21:57:53', '/permission/getPerm', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1720802581345767426', '1', '查询是否是第一次登陆', '0:0:0:0:0:0:0:1', '2023-11-04 21:57:53', '2023-11-04 21:57:53', '/family/checkIsFirst', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1720802680855629826', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-11-04 21:58:25', '2023-11-04 21:58:25', '/permission/getPerm', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1720802709431422977', NULL, '登录', '0:0:0:0:0:0:0:1', '2023-11-04 21:58:32', '2023-11-04 21:58:32', '/user/login', 'POST', 1, NULL, 98);
INSERT INTO `system_operation_log` VALUES ('1720802709431422978', '1', '查询个人信息', '0:0:0:0:0:0:0:1', '2023-11-04 21:58:32', '2023-11-04 21:58:32', '/user/info', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1720802709515309057', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-11-04 21:58:32', '2023-11-04 21:58:32', '/permission/getPerm', 'GET', 1, NULL, 7);
INSERT INTO `system_operation_log` VALUES ('1720802866923343873', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-11-04 21:59:09', '2023-11-04 21:59:09', '/permission/getPerm', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1720802877761425409', NULL, '登录', '0:0:0:0:0:0:0:1', '2023-11-04 21:59:12', '2023-11-04 21:59:12', '/user/login', 'POST', 1, NULL, 92);
INSERT INTO `system_operation_log` VALUES ('1720802877828534273', '1', '查询个人信息', '0:0:0:0:0:0:0:1', '2023-11-04 21:59:12', '2023-11-04 21:59:12', '/user/info', 'GET', 1, NULL, 2);
INSERT INTO `system_operation_log` VALUES ('1720802877828534274', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-11-04 21:59:12', '2023-11-04 21:59:12', '/permission/getPerm', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1720802908916715521', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-04 21:59:12', '2023-11-04 21:59:12', '/floor/floorList', 'GET', 1, NULL, 1);
INSERT INTO `system_operation_log` VALUES ('1720802919842877442', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2023-11-04 21:59:12', '2023-11-04 21:59:12', '/dashboard/dashboardInfo', 'GET', 1, NULL, 11);
INSERT INTO `system_operation_log` VALUES ('1720803566126403585', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-11-04 22:01:56', '2023-11-04 22:01:56', '/permission/getPerm', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1720803568915615746', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-04 22:01:56', '2023-11-04 22:01:56', '/floor/floorList', 'GET', 1, NULL, 1);
INSERT INTO `system_operation_log` VALUES ('1720803569007890433', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2023-11-04 22:01:57', '2023-11-04 22:01:57', '/dashboard/dashboardInfo', 'GET', 1, NULL, 8);
INSERT INTO `system_operation_log` VALUES ('1720803594811248642', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-04 22:02:03', '2023-11-04 22:02:03', '/family/page', 'GET', 1, NULL, 20);
INSERT INTO `system_operation_log` VALUES ('1720803608149135361', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-11-04 22:02:05', '2023-11-04 22:02:05', '/family/list', 'GET', 1, NULL, 2);
INSERT INTO `system_operation_log` VALUES ('1720803611001262082', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-11-04 22:02:05', '2023-11-04 22:02:05', '/floor/pageBackend', 'GET', 1, NULL, 25);
INSERT INTO `system_operation_log` VALUES ('1720803611068370946', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-04 22:02:06', '2023-11-04 22:02:06', '/floor/floorList', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1720803636842369025', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-11-04 22:02:06', '2023-11-04 22:02:06', '/room/page', 'GET', 1, NULL, 14);
INSERT INTO `system_operation_log` VALUES ('1720805509909483521', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-11-04 22:09:39', '2023-11-04 22:09:39', '/product/page', 'GET', 1, NULL, 20);
INSERT INTO `system_operation_log` VALUES ('1720805519334084609', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-04 22:09:41', '2023-11-04 22:09:41', '/family/page', 'GET', 1, NULL, 16);
INSERT INTO `system_operation_log` VALUES ('1720805526531510273', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-11-04 22:09:43', '2023-11-04 22:09:43', '/family/list', 'GET', 1, NULL, 2);
INSERT INTO `system_operation_log` VALUES ('1720805526665728001', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-11-04 22:09:43', '2023-11-04 22:09:43', '/floor/pageBackend', 'GET', 1, NULL, 27);
INSERT INTO `system_operation_log` VALUES ('1720805551974158338', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-04 22:09:45', '2023-11-04 22:09:45', '/floor/floorList', 'GET', 1, NULL, 1);
INSERT INTO `system_operation_log` VALUES ('1720805561264541697', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-11-04 22:09:45', '2023-11-04 22:09:45', '/room/page', 'GET', 1, NULL, 15);
INSERT INTO `system_operation_log` VALUES ('1720805568600379394', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-11-04 22:09:46', '2023-11-04 22:09:46', '/family/list', 'GET', 1, NULL, 2);
INSERT INTO `system_operation_log` VALUES ('1720805568675876866', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-11-04 22:09:46', '2023-11-04 22:09:46', '/floor/pageBackend', 'GET', 1, NULL, 20);
INSERT INTO `system_operation_log` VALUES ('1720805593984307202', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-04 22:09:48', '2023-11-04 22:09:48', '/family/page', 'GET', 1, NULL, 17);
INSERT INTO `system_operation_log` VALUES ('1720805603316633601', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-04 22:09:51', '2023-11-04 22:09:51', '/floor/floorList', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1720805610618916865', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-11-04 22:09:53', '2023-11-04 22:09:53', '/family/list', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1720805610690220034', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-04 22:09:54', '2023-11-04 22:09:54', '/family/page', 'GET', 1, NULL, 14);
INSERT INTO `system_operation_log` VALUES ('1720805635948318721', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-11-04 22:09:58', '2023-11-04 22:09:58', '/product/page', 'GET', 1, NULL, 16);
INSERT INTO `system_operation_log` VALUES ('1720805645318393858', NULL, '', '0:0:0:0:0:0:0:1', '2023-11-04 22:10:00', '2023-11-04 22:10:00', '/error', 'GET', 0, '系统错误请联系管理员', 7);
INSERT INTO `system_operation_log` VALUES ('1720805652641648641', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-04 22:10:04', '2023-11-04 22:10:04', '/family/page', 'GET', 1, NULL, 15);
INSERT INTO `system_operation_log` VALUES ('1720808694640316418', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-11-04 22:22:19', '2023-11-04 22:22:19', '/family/list', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1720808694711619585', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-11-04 22:22:19', '2023-11-04 22:22:19', '/floor/pageBackend', 'GET', 1, NULL, 20);
INSERT INTO `system_operation_log` VALUES ('1720808699270828034', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-04 22:22:20', '2023-11-04 22:22:20', '/floor/floorList', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1720808699337936898', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-11-04 22:22:20', '2023-11-04 22:22:20', '/room/page', 'GET', 1, NULL, 14);
INSERT INTO `system_operation_log` VALUES ('1720808736663048193', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-11-04 22:22:21', '2023-11-04 22:22:21', '/family/list', 'GET', 1, NULL, 2);
INSERT INTO `system_operation_log` VALUES ('1720808736793071618', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-11-04 22:22:21', '2023-11-04 22:22:21', '/floor/pageBackend', 'GET', 1, NULL, 20);
INSERT INTO `system_operation_log` VALUES ('1720808741285171201', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-04 22:22:28', '2023-11-04 22:22:28', '/floor/floorList', 'GET', 1, NULL, 1);
INSERT INTO `system_operation_log` VALUES ('1720808741348085762', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-11-04 22:22:28', '2023-11-04 22:22:28', '/room/page', 'GET', 1, NULL, 21);
INSERT INTO `system_operation_log` VALUES ('1723310051607719937', NULL, '登录', '0:0:0:0:0:0:0:1', '2023-11-11 20:01:48', '2023-11-11 20:01:48', '/user/login', 'POST', 1, NULL, 505);
INSERT INTO `system_operation_log` VALUES ('1723310052018761729', '1', '查询个人信息', '0:0:0:0:0:0:0:1', '2023-11-11 20:01:49', '2023-11-11 20:01:49', '/user/info', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1723310052077481985', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-11-11 20:01:49', '2023-11-11 20:01:49', '/permission/getPerm', 'GET', 1, NULL, 27);
INSERT INTO `system_operation_log` VALUES ('1723310053415464961', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2023-11-11 20:01:49', '2023-11-11 20:01:49', '/dashboard/dashboardInfo', 'GET', 1, NULL, 22);
INSERT INTO `system_operation_log` VALUES ('1723310093634646018', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-11 20:01:49', '2023-11-11 20:01:49', '/floor/floorList', 'GET', 1, NULL, 21);
INSERT INTO `system_operation_log` VALUES ('1723310094020521985', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-11 20:01:53', '2023-11-11 20:01:53', '/floor/floorList', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1723310094020521986', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-11-11 20:01:52', '2023-11-11 20:01:52', '/permission/getPerm', 'GET', 1, NULL, 13);
INSERT INTO `system_operation_log` VALUES ('1723310095413030914', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2023-11-11 20:01:53', '2023-11-11 20:01:53', '/dashboard/dashboardInfo', 'GET', 1, NULL, 18);
INSERT INTO `system_operation_log` VALUES ('1723310135611240450', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-11-11 20:01:58', '2023-11-11 20:01:58', '/product/page', 'GET', 1, NULL, 28);
INSERT INTO `system_operation_log` VALUES ('1723310136072613890', NULL, '', '0:0:0:0:0:0:0:1', '2023-11-11 20:02:00', '2023-11-11 20:02:00', '/error', 'GET', 0, '系统错误请联系管理员', 2);
INSERT INTO `system_operation_log` VALUES ('1723310136072613891', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2023-11-11 20:02:00', '2023-11-11 20:02:00', '/product/list', 'GET', 1, NULL, 2);
INSERT INTO `system_operation_log` VALUES ('1723310137393819649', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-11 20:02:02', '2023-11-11 20:02:02', '/family/page', 'GET', 1, NULL, 18);
INSERT INTO `system_operation_log` VALUES ('1723335572936732674', NULL, '登录', '0:0:0:0:0:0:0:1', '2023-11-11 21:43:13', '2023-11-11 21:43:13', '/user/login', 'POST', 1, NULL, 104);
INSERT INTO `system_operation_log` VALUES ('1723335573003841537', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-11-11 21:43:13', '2023-11-11 21:43:13', '/permission/getPerm', 'GET', 1, NULL, 6);
INSERT INTO `system_operation_log` VALUES ('1723335573003841538', '1', '查询个人信息', '0:0:0:0:0:0:0:1', '2023-11-11 21:43:13', '2023-11-11 21:43:13', '/user/info', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1723335573884645377', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-11 21:43:14', '2023-11-11 21:43:14', '/floor/floorList', 'GET', 1, NULL, 1);
INSERT INTO `system_operation_log` VALUES ('1723335614963658753', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2023-11-11 21:43:14', '2023-11-11 21:43:14', '/dashboard/dashboardInfo', 'GET', 1, NULL, 17);
INSERT INTO `system_operation_log` VALUES ('1723335615026573314', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-11-11 21:43:19', '2023-11-11 21:43:19', '/permission/getPerm', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1723335615026573315', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-11 21:43:16', '2023-11-11 21:43:16', '/family/page', 'GET', 1, NULL, 22);
INSERT INTO `system_operation_log` VALUES ('1723335615999651841', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-11 21:43:19', '2023-11-11 21:43:19', '/family/page', 'GET', 1, NULL, 22);
INSERT INTO `system_operation_log` VALUES ('1723335702037409794', '1', '新增或修改家庭', '0:0:0:0:0:0:0:1', '2023-11-11 21:43:44', '2023-11-11 21:43:44', '/family/addUpdate', 'POST', 1, NULL, 29);
INSERT INTO `system_operation_log` VALUES ('1723335702163238914', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-11 21:43:44', '2023-11-11 21:43:44', '/family/page', 'GET', 1, NULL, 18);
INSERT INTO `system_operation_log` VALUES ('1723336179089158146', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-11 21:45:38', '2023-11-11 21:45:38', '/family/page', 'GET', 1, NULL, 16);
INSERT INTO `system_operation_log` VALUES ('1723336310899355650', '1', '新增或修改家庭', '0:0:0:0:0:0:0:1', '2023-11-11 21:46:09', '2023-11-11 21:46:09', '/family/addUpdate', 'POST', 1, NULL, 9);
INSERT INTO `system_operation_log` VALUES ('1723336311088099329', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-11 21:46:09', '2023-11-11 21:46:09', '/family/page', 'GET', 1, NULL, 16);
INSERT INTO `system_operation_log` VALUES ('1723336360031432705', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-11 21:46:21', '2023-11-11 21:46:21', '/family/page', 'GET', 1, NULL, 27);
INSERT INTO `system_operation_log` VALUES ('1723336370265534465', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-11 21:46:23', '2023-11-11 21:46:23', '/family/page', 'GET', 1, NULL, 17);
INSERT INTO `system_operation_log` VALUES ('1723337253556596738', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-11-11 21:49:54', '2023-11-11 21:49:54', '/permission/getPerm', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1723337254823276546', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-11 21:49:54', '2023-11-11 21:49:54', '/family/page', 'GET', 1, NULL, 20);
INSERT INTO `system_operation_log` VALUES ('1723338507653492738', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-11 21:54:53', '2023-11-11 21:54:53', '/family/page', 'GET', 1, NULL, 21);
INSERT INTO `system_operation_log` VALUES ('1723338521092042753', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-11 21:54:56', '2023-11-11 21:54:56', '/family/page', 'GET', 1, NULL, 17);
INSERT INTO `system_operation_log` VALUES ('1723338887033585666', NULL, '登录', '0:0:0:0:0:0:0:1', '2023-11-11 21:56:23', '2023-11-11 21:56:23', '/user/login', 'POST', 1, NULL, 717);
INSERT INTO `system_operation_log` VALUES ('1723338887083917314', '1', '查询个人信息', '0:0:0:0:0:0:0:1', '2023-11-11 21:56:23', '2023-11-11 21:56:23', '/user/info', 'GET', 1, NULL, 13);
INSERT INTO `system_operation_log` VALUES ('1723338887281049602', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-11-11 21:56:23', '2023-11-11 21:56:23', '/permission/getPerm', 'GET', 1, NULL, 50);
INSERT INTO `system_operation_log` VALUES ('1723338889122349057', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2023-11-11 21:56:24', '2023-11-11 21:56:24', '/dashboard/dashboardInfo', 'GET', 1, NULL, 32);
INSERT INTO `system_operation_log` VALUES ('1723338929215700994', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-11 21:56:28', '2023-11-11 21:56:28', '/floor/floorList', 'GET', 1, NULL, 1);
INSERT INTO `system_operation_log` VALUES ('1723338929215700995', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-11 21:56:24', '2023-11-11 21:56:24', '/floor/floorList', 'GET', 1, NULL, 41);
INSERT INTO `system_operation_log` VALUES ('1723338929341530114', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-11-11 21:56:28', '2023-11-11 21:56:28', '/permission/getPerm', 'GET', 1, NULL, 14);
INSERT INTO `system_operation_log` VALUES ('1723338931115720706', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2023-11-11 21:56:28', '2023-11-11 21:56:28', '/dashboard/dashboardInfo', 'GET', 1, NULL, 17);
INSERT INTO `system_operation_log` VALUES ('1723339035910406146', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-11 21:56:59', '2023-11-11 21:56:59', '/floor/floorList', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1723339035910406147', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-11-11 21:56:59', '2023-11-11 21:56:59', '/permission/getPerm', 'GET', 1, NULL, 8);
INSERT INTO `system_operation_log` VALUES ('1723339035969126401', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2023-11-11 21:56:59', '2023-11-11 21:56:59', '/dashboard/dashboardInfo', 'GET', 1, NULL, 24);
INSERT INTO `system_operation_log` VALUES ('1723339047578959873', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-11-11 21:57:02', '2023-11-11 21:57:02', '/permission/getPerm', 'GET', 1, NULL, 8);
INSERT INTO `system_operation_log` VALUES ('1723339077954109441', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-11 21:57:02', '2023-11-11 21:57:02', '/floor/floorList', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1723339077954109442', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2023-11-11 21:57:02', '2023-11-11 21:57:02', '/dashboard/dashboardInfo', 'GET', 1, NULL, 29);
INSERT INTO `system_operation_log` VALUES ('1723339078021218305', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-11 21:57:05', '2023-11-11 21:57:05', '/family/page', 'GET', 1, NULL, 96);
INSERT INTO `system_operation_log` VALUES ('1723339121138663426', '1', '删除家庭', '0:0:0:0:0:0:0:1', '2023-11-11 21:57:19', '2023-11-11 21:57:19', '/family/delete/1720793302162272258', 'DELETE', 1, NULL, 28);
INSERT INTO `system_operation_log` VALUES ('1723339121272881153', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-11 21:57:19', '2023-11-11 21:57:19', '/family/page', 'GET', 1, NULL, 18);
INSERT INTO `system_operation_log` VALUES ('1723339178793566209', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-11-11 21:57:33', '2023-11-11 21:57:33', '/family/list', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1723339178927783938', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-11-11 21:57:33', '2023-11-11 21:57:33', '/floor/pageBackend', 'GET', 1, NULL, 40);
INSERT INTO `system_operation_log` VALUES ('1723339185265377281', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-11 21:57:35', '2023-11-11 21:57:35', '/floor/floorList', 'GET', 1, NULL, 1);
INSERT INTO `system_operation_log` VALUES ('1723339185458315266', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-11-11 21:57:35', '2023-11-11 21:57:35', '/room/page', 'GET', 1, NULL, 35);
INSERT INTO `system_operation_log` VALUES ('1723339220761772034', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-11-11 21:57:36', '2023-11-11 21:57:36', '/family/list', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1723339220958904321', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-11-11 21:57:36', '2023-11-11 21:57:36', '/floor/pageBackend', 'GET', 1, NULL, 24);
INSERT INTO `system_operation_log` VALUES ('1723339235450224641', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-11 21:57:46', '2023-11-11 21:57:46', '/family/page', 'GET', 1, NULL, 16);
INSERT INTO `system_operation_log` VALUES ('1723339263115853827', '1', '新增或修改家庭', '0:0:0:0:0:0:0:1', '2023-11-11 21:57:53', '2023-11-11 21:57:53', '/family/addUpdate', 'POST', 1, NULL, 14);
INSERT INTO `system_operation_log` VALUES ('1723339263241682946', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-11 21:57:53', '2023-11-11 21:57:53', '/family/page', 'GET', 1, NULL, 18);
INSERT INTO `system_operation_log` VALUES ('1723339289787432963', '1', '新增或修改家庭', '0:0:0:0:0:0:0:1', '2023-11-11 21:57:59', '2023-11-11 21:57:59', '/family/addUpdate', 'POST', 1, NULL, 9);
INSERT INTO `system_operation_log` VALUES ('1723339289913262082', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-11 21:57:59', '2023-11-11 21:57:59', '/family/page', 'GET', 1, NULL, 16);
INSERT INTO `system_operation_log` VALUES ('1723339317583085571', '1', '新增或修改家庭', '0:0:0:0:0:0:0:1', '2023-11-11 21:58:06', '2023-11-11 21:58:06', '/family/addUpdate', 'POST', 1, NULL, 9);
INSERT INTO `system_operation_log` VALUES ('1723339317717303298', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-11 21:58:06', '2023-11-11 21:58:06', '/family/page', 'GET', 1, NULL, 15);
INSERT INTO `system_operation_log` VALUES ('1723339344737009667', '1', '新增或修改家庭', '0:0:0:0:0:0:0:1', '2023-11-11 21:58:13', '2023-11-11 21:58:13', '/family/addUpdate', 'POST', 1, NULL, 9);
INSERT INTO `system_operation_log` VALUES ('1723339344934141954', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-11 21:58:13', '2023-11-11 21:58:13', '/family/page', 'GET', 1, NULL, 20);
INSERT INTO `system_operation_log` VALUES ('1723339373941948418', '1', '新增或修改家庭', '0:0:0:0:0:0:0:1', '2023-11-11 21:58:20', '2023-11-11 21:58:20', '/family/addUpdate', 'POST', 1, NULL, 8);
INSERT INTO `system_operation_log` VALUES ('1723339374084554754', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-11 21:58:20', '2023-11-11 21:58:20', '/family/page', 'GET', 1, NULL, 24);
INSERT INTO `system_operation_log` VALUES ('1723339398495404035', '1', '新增或修改家庭', '0:0:0:0:0:0:0:1', '2023-11-11 21:58:25', '2023-11-11 21:58:25', '/family/addUpdate', 'POST', 1, NULL, 9);
INSERT INTO `system_operation_log` VALUES ('1723339398629621761', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-11 21:58:25', '2023-11-11 21:58:25', '/family/page', 'GET', 1, NULL, 19);
INSERT INTO `system_operation_log` VALUES ('1723339425598996481', '1', '新增或修改家庭', '0:0:0:0:0:0:0:1', '2023-11-11 21:58:32', '2023-11-11 21:58:32', '/family/addUpdate', 'POST', 1, NULL, 12);
INSERT INTO `system_operation_log` VALUES ('1723339425729019906', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-11 21:58:32', '2023-11-11 21:58:32', '/family/page', 'GET', 1, NULL, 18);
INSERT INTO `system_operation_log` VALUES ('1723339468422840321', '1', '新增或修改家庭', '0:0:0:0:0:0:0:1', '2023-11-11 21:58:42', '2023-11-11 21:58:42', '/family/addUpdate', 'POST', 1, NULL, 9);
INSERT INTO `system_operation_log` VALUES ('1723339468565446657', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-11 21:58:42', '2023-11-11 21:58:42', '/family/page', 'GET', 1, NULL, 18);
INSERT INTO `system_operation_log` VALUES ('1723339503336226817', '1', '新增或修改家庭', '0:0:0:0:0:0:0:1', '2023-11-11 21:58:50', '2023-11-11 21:58:50', '/family/addUpdate', 'POST', 1, NULL, 9);
INSERT INTO `system_operation_log` VALUES ('1723339503462055938', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-11 21:58:50', '2023-11-11 21:58:50', '/family/page', 'GET', 1, NULL, 16);
INSERT INTO `system_operation_log` VALUES ('1723339566477279235', '1', '新增或修改家庭', '0:0:0:0:0:0:0:1', '2023-11-11 21:59:05', '2023-11-11 21:59:05', '/family/addUpdate', 'POST', 1, NULL, 10);
INSERT INTO `system_operation_log` VALUES ('1723339566678605826', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-11 21:59:05', '2023-11-11 21:59:05', '/family/page', 'GET', 1, NULL, 19);
INSERT INTO `system_operation_log` VALUES ('1723339794827771906', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-11 22:00:00', '2023-11-11 22:00:00', '/family/page', 'GET', 1, NULL, 24);
INSERT INTO `system_operation_log` VALUES ('1723339799294705665', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-11 22:00:01', '2023-11-11 22:00:01', '/family/page', 'GET', 1, NULL, 21);
INSERT INTO `system_operation_log` VALUES ('1723339801714819074', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-11 22:00:02', '2023-11-11 22:00:02', '/family/page', 'GET', 1, NULL, 18);
INSERT INTO `system_operation_log` VALUES ('1723339890378211329', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-11 22:00:23', '2023-11-11 22:00:23', '/family/page', 'GET', 1, NULL, 20);
INSERT INTO `system_operation_log` VALUES ('1723339933965418498', '1', '新增或修改家庭', '0:0:0:0:0:0:0:1', '2023-11-11 22:00:33', '2023-11-11 22:00:33', '/family/addUpdate', 'POST', 1, NULL, 11);
INSERT INTO `system_operation_log` VALUES ('1723339934082859010', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-11 22:00:33', '2023-11-11 22:00:33', '/family/page', 'GET', 1, NULL, 18);
INSERT INTO `system_operation_log` VALUES ('1723339965481418755', '1', '新增或修改家庭', '0:0:0:0:0:0:0:1', '2023-11-11 22:00:41', '2023-11-11 22:00:41', '/family/addUpdate', 'POST', 1, NULL, 9);
INSERT INTO `system_operation_log` VALUES ('1723339965670162433', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-11 22:00:41', '2023-11-11 22:00:41', '/family/page', 'GET', 1, NULL, 19);
INSERT INTO `system_operation_log` VALUES ('1723340008414314498', '1', '新增或修改家庭', '0:0:0:0:0:0:0:1', '2023-11-11 22:00:51', '2023-11-11 22:00:51', '/family/addUpdate', 'POST', 1, NULL, 11);
INSERT INTO `system_operation_log` VALUES ('1723340008540143617', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-11 22:00:51', '2023-11-11 22:00:51', '/family/page', 'GET', 1, NULL, 17);
INSERT INTO `system_operation_log` VALUES ('1723340689254711298', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-11 22:03:33', '2023-11-11 22:03:33', '/family/page', 'GET', 1, NULL, 19);
INSERT INTO `system_operation_log` VALUES ('1723340700428337153', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-11 22:03:36', '2023-11-11 22:03:36', '/family/page', 'GET', 1, NULL, 19);
INSERT INTO `system_operation_log` VALUES ('1723340709186043905', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-11 22:03:38', '2023-11-11 22:03:38', '/family/page', 'GET', 1, NULL, 17);
INSERT INTO `system_operation_log` VALUES ('1723340984089116674', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-11 22:04:43', '2023-11-11 22:04:43', '/family/page', 'GET', 1, NULL, 19);
INSERT INTO `system_operation_log` VALUES ('1723340988736405506', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-11 22:04:45', '2023-11-11 22:04:45', '/family/page', 'GET', 1, NULL, 18);
INSERT INTO `system_operation_log` VALUES ('1723340994176417793', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-11 22:04:46', '2023-11-11 22:04:46', '/family/page', 'GET', 1, NULL, 15);
INSERT INTO `system_operation_log` VALUES ('1723341000727920641', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-11 22:04:47', '2023-11-11 22:04:47', '/family/page', 'GET', 1, NULL, 17);
INSERT INTO `system_operation_log` VALUES ('1723341047867703297', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-11-11 22:04:59', '2023-11-11 22:04:59', '/family/list', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1723341047997726721', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-11-11 22:04:59', '2023-11-11 22:04:59', '/floor/pageBackend', 'GET', 1, NULL, 27);
INSERT INTO `system_operation_log` VALUES ('1723341052837953538', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-11 22:05:00', '2023-11-11 22:05:00', '/family/page', 'GET', 1, NULL, 16);
INSERT INTO `system_operation_log` VALUES ('1723341437107503105', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-11 22:06:31', '2023-11-11 22:06:31', '/floor/floorList', 'GET', 1, NULL, 7);
INSERT INTO `system_operation_log` VALUES ('1723341437107503106', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2023-11-11 22:06:31', '2023-11-11 22:06:31', '/dashboard/dashboardInfo', 'GET', 1, NULL, 23);
INSERT INTO `system_operation_log` VALUES ('1723341477062443009', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-11-11 22:06:41', '2023-11-11 22:06:41', '/product/page', 'GET', 1, NULL, 37);
INSERT INTO `system_operation_log` VALUES ('1723342265566429185', NULL, '登录', '0:0:0:0:0:0:0:1', '2023-11-11 22:09:49', '2023-11-11 22:09:49', '/user/login', 'POST', 1, NULL, 92);
INSERT INTO `system_operation_log` VALUES ('1723342265566429186', '1', '查询个人信息', '0:0:0:0:0:0:0:1', '2023-11-11 22:09:49', '2023-11-11 22:09:49', '/user/info', 'GET', 1, NULL, 1);
INSERT INTO `system_operation_log` VALUES ('1723342265566429187', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-11-11 22:09:49', '2023-11-11 22:09:49', '/permission/getPerm', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1723342265893584897', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-11 22:09:49', '2023-11-11 22:09:49', '/floor/floorList', 'GET', 1, NULL, 1);
INSERT INTO `system_operation_log` VALUES ('1723342307589160962', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2023-11-11 22:09:49', '2023-11-11 22:09:49', '/dashboard/dashboardInfo', 'GET', 1, NULL, 14);
INSERT INTO `system_operation_log` VALUES ('1723342307589160963', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-11-11 22:09:54', '2023-11-11 22:09:54', '/permission/getPerm', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1723342307660464129', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-11 22:09:54', '2023-11-11 22:09:54', '/floor/floorList', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1723342308121837570', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2023-11-11 22:09:54', '2023-11-11 22:09:54', '/dashboard/dashboardInfo', 'GET', 1, NULL, 11);
INSERT INTO `system_operation_log` VALUES ('1723342349607698433', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2023-11-11 22:10:01', '2023-11-11 22:10:01', '/product/list', 'GET', 1, NULL, 2);
INSERT INTO `system_operation_log` VALUES ('1723342349607698434', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-11 22:09:57', '2023-11-11 22:09:57', '/family/page', 'GET', 1, NULL, 19);
INSERT INTO `system_operation_log` VALUES ('1723342349670612993', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-11-11 22:10:01', '2023-11-11 22:10:01', '/frameware/page', 'GET', 1, NULL, 38);
INSERT INTO `system_operation_log` VALUES ('1723342350140375041', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-11 22:10:03', '2023-11-11 22:10:03', '/floor/floorList', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1723342391571709954', '1', '查询调试所有设备', '0:0:0:0:0:0:0:1', '2023-11-11 22:10:04', '2023-11-11 22:10:04', '/device/debugDeviceList', 'GET', 1, NULL, 2);
INSERT INTO `system_operation_log` VALUES ('1723343056062709762', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2023-11-11 22:12:57', '2023-11-11 22:12:57', '/product/list', 'GET', 1, NULL, 2);
INSERT INTO `system_operation_log` VALUES ('1723343056201121793', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-11-11 22:12:57', '2023-11-11 22:12:57', '/frameware/page', 'GET', 1, NULL, 19);
INSERT INTO `system_operation_log` VALUES ('1723343060823244802', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-11-11 22:12:59', '2023-11-11 22:12:59', '/product/page', 'GET', 1, NULL, 16);
INSERT INTO `system_operation_log` VALUES ('1723343195720450050', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-11 22:13:31', '2023-11-11 22:13:31', '/floor/floorList', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1723343195795947522', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2023-11-11 22:13:31', '2023-11-11 22:13:31', '/dashboard/dashboardInfo', 'GET', 1, NULL, 12);
INSERT INTO `system_operation_log` VALUES ('1723343205224742914', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-11 22:13:33', '2023-11-11 22:13:33', '/family/page', 'GET', 1, NULL, 14);
INSERT INTO `system_operation_log` VALUES ('1723343209712648194', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-11-11 22:13:34', '2023-11-11 22:13:34', '/product/page', 'GET', 1, NULL, 15);
INSERT INTO `system_operation_log` VALUES ('1723343237776736258', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2023-11-11 22:13:35', '2023-11-11 22:13:35', '/product/list', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1723343237776736259', NULL, '', '0:0:0:0:0:0:0:1', '2023-11-11 22:13:35', '2023-11-11 22:13:35', '/error', 'GET', 0, '系统错误请联系管理员', 9);
INSERT INTO `system_operation_log` VALUES ('1723343255157932033', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-11 22:13:45', '2023-11-11 22:13:45', '/floor/floorList', 'GET', 1, NULL, 1);
INSERT INTO `system_operation_log` VALUES ('1723343255246012417', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2023-11-11 22:13:45', '2023-11-11 22:13:45', '/dashboard/dashboardInfo', 'GET', 1, NULL, 14);
INSERT INTO `system_operation_log` VALUES ('1723343279740747777', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-11 22:13:48', '2023-11-11 22:13:48', '/family/page', 'GET', 1, NULL, 15);
INSERT INTO `system_operation_log` VALUES ('1723343279803662337', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-11 22:13:49', '2023-11-11 22:13:49', '/floor/floorList', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1723343297184858114', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2023-11-11 22:13:49', '2023-11-11 22:13:49', '/dashboard/dashboardInfo', 'GET', 1, NULL, 11);
INSERT INTO `system_operation_log` VALUES ('1723343515464826881', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-11-11 22:14:47', '2023-11-11 22:14:47', '/family/list', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1723343519587827713', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-11 22:14:48', '2023-11-11 22:14:48', '/floor/floorList', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1723343586260484098', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-11-11 22:15:04', '2023-11-11 22:15:04', '/room/page', 'GET', 1, NULL, 45);
INSERT INTO `system_operation_log` VALUES ('1723343586315010049', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-11-11 22:15:04', '2023-11-11 22:15:04', '/floor/pageBackend', 'GET', 1, NULL, 66);
INSERT INTO `system_operation_log` VALUES ('1723343586382118914', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-11 22:15:04', '2023-11-11 22:15:04', '/family/page', 'GET', 1, NULL, 89);
INSERT INTO `system_operation_log` VALUES ('1723343592719712257', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-11-11 22:15:05', '2023-11-11 22:15:05', '/permission/getPerm', 'GET', 1, NULL, 12);
INSERT INTO `system_operation_log` VALUES ('1723343628299993090', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-11 22:15:06', '2023-11-11 22:15:06', '/floor/floorList', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1723343628299993091', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-11-11 22:15:06', '2023-11-11 22:15:06', '/room/page', 'GET', 1, NULL, 36);
INSERT INTO `system_operation_log` VALUES ('1723343674382811138', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-11-11 22:15:25', '2023-11-11 22:15:25', '/product/page', 'GET', 1, NULL, 49);
INSERT INTO `system_operation_log` VALUES ('1723343688551170049', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2023-11-11 22:15:28', '2023-11-11 22:15:28', '/product/list', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1723343688626667521', NULL, '', '0:0:0:0:0:0:0:1', '2023-11-11 22:15:28', '2023-11-11 22:15:28', '/error', 'GET', 0, '系统错误请联系管理员', 1);
INSERT INTO `system_operation_log` VALUES ('1723343694037319681', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-11-11 22:15:29', '2023-11-11 22:15:29', '/product/page', 'GET', 1, NULL, 31);
INSERT INTO `system_operation_log` VALUES ('1723343716418125826', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2023-11-11 22:15:32', '2023-11-11 22:15:32', '/product/list', 'GET', 1, NULL, 12);
INSERT INTO `system_operation_log` VALUES ('1723343730615844865', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-11-11 22:15:32', '2023-11-11 22:15:32', '/frameware/page', 'GET', 1, NULL, 26);
INSERT INTO `system_operation_log` VALUES ('1723343850778460161', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2023-11-11 22:16:07', '2023-11-11 22:16:07', '/product/list', 'GET', 1, NULL, 24);
INSERT INTO `system_operation_log` VALUES ('1723343850778460162', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-11 22:16:07', '2023-11-11 22:16:07', '/floor/floorList', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1723343851235639297', '1', '分页查询', '0:0:0:0:0:0:0:1', '2023-11-11 22:16:07', '2023-11-11 22:16:07', '/device/page', 'GET', 1, NULL, 51);
INSERT INTO `system_operation_log` VALUES ('1723343865697599490', NULL, '根据楼层id查询房间列表', '0:0:0:0:0:0:0:1', '2023-11-11 22:16:10', '2023-11-11 22:16:10', '/room/roomListByFloorId', 'GET', 1, NULL, 16);
INSERT INTO `system_operation_log` VALUES ('1723343893023490050', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-11 22:16:15', '2023-11-11 22:16:15', '/family/page', 'GET', 1, NULL, 41);
INSERT INTO `system_operation_log` VALUES ('1723343963844313090', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-11-11 22:16:34', '2023-11-11 22:16:34', '/product/page', 'GET', 1, NULL, 27);
INSERT INTO `system_operation_log` VALUES ('1723343972727848961', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-11 22:16:36', '2023-11-11 22:16:36', '/floor/floorList', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1723343972887232513', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2023-11-11 22:16:36', '2023-11-11 22:16:36', '/product/list', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1723343972983701505', '1', '分页查询', '0:0:0:0:0:0:0:1', '2023-11-11 22:16:36', '2023-11-11 22:16:36', '/device/page', 'GET', 1, NULL, 32);
INSERT INTO `system_operation_log` VALUES ('1723344035524968450', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-11 22:16:51', '2023-11-11 22:16:51', '/family/page', 'GET', 1, NULL, 34);
INSERT INTO `system_operation_log` VALUES ('1723344040012873729', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-11-11 22:16:52', '2023-11-11 22:16:52', '/family/list', 'GET', 1, NULL, 7);
INSERT INTO `system_operation_log` VALUES ('1723344040075788290', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-11-11 22:16:52', '2023-11-11 22:16:52', '/floor/pageBackend', 'GET', 1, NULL, 28);
INSERT INTO `system_operation_log` VALUES ('1723344047134801922', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-11 22:16:54', '2023-11-11 22:16:54', '/floor/floorList', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1723344077581254658', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-11-11 22:16:54', '2023-11-11 22:16:54', '/room/page', 'GET', 1, NULL, 23);
INSERT INTO `system_operation_log` VALUES ('1723344131041853442', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-11 22:17:14', '2023-11-11 22:17:14', '/family/page', 'GET', 1, NULL, 23);
INSERT INTO `system_operation_log` VALUES ('1723344136783855617', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-11-11 22:17:15', '2023-11-11 22:17:15', '/family/list', 'GET', 1, NULL, 6);
INSERT INTO `system_operation_log` VALUES ('1723344136846770177', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-11-11 22:17:15', '2023-11-11 22:17:15', '/floor/pageBackend', 'GET', 1, NULL, 30);
INSERT INTO `system_operation_log` VALUES ('1723344561037705218', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-11-11 22:18:56', '2023-11-11 22:18:56', '/family/list', 'GET', 1, NULL, 18);
INSERT INTO `system_operation_log` VALUES ('1723344561075453954', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-11-11 22:18:56', '2023-11-11 22:18:56', '/floor/pageBackend', 'GET', 1, NULL, 25);
INSERT INTO `system_operation_log` VALUES ('1723344594944458754', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-11 22:19:04', '2023-11-11 22:19:04', '/family/page', 'GET', 1, NULL, 25);
INSERT INTO `system_operation_log` VALUES ('1723344601617596417', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-11-11 22:19:06', '2023-11-11 22:19:06', '/family/list', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1723344603043659778', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-11-11 22:19:06', '2023-11-11 22:19:06', '/floor/pageBackend', 'GET', 1, NULL, 26);
INSERT INTO `system_operation_log` VALUES ('1723344966069059586', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-11-11 22:20:33', '2023-11-11 22:20:33', '/floor/pageBackend', 'GET', 1, NULL, 26);
INSERT INTO `system_operation_log` VALUES ('1723344966069059587', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-11-11 22:20:33', '2023-11-11 22:20:33', '/family/list', 'GET', 1, NULL, 11);
INSERT INTO `system_operation_log` VALUES ('1723344987753611265', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-11 22:20:38', '2023-11-11 22:20:38', '/family/page', 'GET', 1, NULL, 24);
INSERT INTO `system_operation_log` VALUES ('1723345000583987201', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-11-11 22:20:41', '2023-11-11 22:20:41', '/family/list', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1723345008238592002', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-11-11 22:20:41', '2023-11-11 22:20:41', '/floor/pageBackend', 'GET', 1, NULL, 31);
INSERT INTO `system_operation_log` VALUES ('1723345249834696706', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-11-11 22:21:40', '2023-11-11 22:21:40', '/floor/pageBackend', 'GET', 1, NULL, 31);
INSERT INTO `system_operation_log` VALUES ('1723345254939164674', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-11-11 22:21:42', '2023-11-11 22:21:42', '/floor/pageBackend', 'GET', 1, NULL, 25);
INSERT INTO `system_operation_log` VALUES ('1723345281153564674', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-11-11 22:21:48', '2023-11-11 22:21:48', '/floor/pageBackend', 'GET', 1, NULL, 29);
INSERT INTO `system_operation_log` VALUES ('1723345289370206209', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-11-11 22:21:50', '2023-11-11 22:21:50', '/floor/pageBackend', 'GET', 1, NULL, 22);
INSERT INTO `system_operation_log` VALUES ('1723345294717943810', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-11-11 22:21:51', '2023-11-11 22:21:51', '/floor/pageBackend', 'GET', 1, NULL, 27);
INSERT INTO `system_operation_log` VALUES ('1723345430793748481', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-11-11 22:22:24', '2023-11-11 22:22:24', '/floor/pageBackend', 'GET', 1, NULL, 28);
INSERT INTO `system_operation_log` VALUES ('1723345596376481793', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-11-11 22:23:03', '2023-11-11 22:23:03', '/floor/pageBackend', 'GET', 1, NULL, 24);
INSERT INTO `system_operation_log` VALUES ('1723345626038599682', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-11-11 22:23:10', '2023-11-11 22:23:10', '/floor/pageBackend', 'GET', 1, NULL, 31);
INSERT INTO `system_operation_log` VALUES ('1723345727196823554', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-11-11 22:23:34', '2023-11-11 22:23:34', '/floor/pageBackend', 'GET', 1, NULL, 24);
INSERT INTO `system_operation_log` VALUES ('1723345988619403265', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-11-11 22:24:37', '2023-11-11 22:24:37', '/family/list', 'GET', 1, NULL, 6);
INSERT INTO `system_operation_log` VALUES ('1723345988741038082', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-11-11 22:24:37', '2023-11-11 22:24:37', '/floor/pageBackend', 'GET', 1, NULL, 32);
INSERT INTO `system_operation_log` VALUES ('1723346141950574593', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-11-11 22:25:13', '2023-11-11 22:25:13', '/family/list', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1723346142147706881', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-11-11 22:25:13', '2023-11-11 22:25:13', '/floor/pageBackend', 'GET', 1, NULL, 26);
INSERT INTO `system_operation_log` VALUES ('1723346180001300481', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-11-11 22:25:22', '2023-11-11 22:25:22', '/permission/getPerm', 'GET', 1, NULL, 6);
INSERT INTO `system_operation_log` VALUES ('1723346181309923330', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-11-11 22:25:23', '2023-11-11 22:25:23', '/family/list', 'GET', 1, NULL, 7);
INSERT INTO `system_operation_log` VALUES ('1723346184132689922', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-11-11 22:25:23', '2023-11-11 22:25:23', '/floor/pageBackend', 'GET', 1, NULL, 26);
INSERT INTO `system_operation_log` VALUES ('1723346311048134658', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-11-11 22:25:53', '2023-11-11 22:25:53', '/family/list', 'GET', 1, NULL, 6);
INSERT INTO `system_operation_log` VALUES ('1723346311115243521', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-11-11 22:25:53', '2023-11-11 22:25:53', '/floor/pageBackend', 'GET', 1, NULL, 29);
INSERT INTO `system_operation_log` VALUES ('1723346440836677633', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-11-11 22:26:24', '2023-11-11 22:26:24', '/permission/getPerm', 'GET', 1, NULL, 7);
INSERT INTO `system_operation_log` VALUES ('1723346442224992257', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-11-11 22:26:25', '2023-11-11 22:26:25', '/family/list', 'GET', 1, NULL, 8);
INSERT INTO `system_operation_log` VALUES ('1723346442350821377', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-11-11 22:26:25', '2023-11-11 22:26:25', '/floor/pageBackend', 'GET', 1, NULL, 36);
INSERT INTO `system_operation_log` VALUES ('1723346775420502018', '1', '新增或修改楼层', '0:0:0:0:0:0:0:1', '2023-11-11 22:27:44', '2023-11-11 22:27:44', '/floor/addUpdate', 'POST', 1, NULL, 15);
INSERT INTO `system_operation_log` VALUES ('1723346775554719745', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-11-11 22:27:44', '2023-11-11 22:27:44', '/floor/pageBackend', 'GET', 1, NULL, 21);
INSERT INTO `system_operation_log` VALUES ('1723346788049551362', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-11-11 22:27:47', '2023-11-11 22:27:47', '/floor/pageBackend', 'GET', 1, NULL, 23);
INSERT INTO `system_operation_log` VALUES ('1723346794445864962', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-11-11 22:27:49', '2023-11-11 22:27:49', '/floor/pageBackend', 'GET', 1, NULL, 28);
INSERT INTO `system_operation_log` VALUES ('1723347752953380866', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-11-11 22:31:37', '2023-11-11 22:31:37', '/floor/pageBackend', 'GET', 1, NULL, 37);
INSERT INTO `system_operation_log` VALUES ('1723347772473671681', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-11 22:31:42', '2023-11-11 22:31:42', '/family/page', 'GET', 1, NULL, 19);
INSERT INTO `system_operation_log` VALUES ('1723347785719283714', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-11 22:31:45', '2023-11-11 22:31:45', '/floor/floorList', 'GET', 1, NULL, 1);
INSERT INTO `system_operation_log` VALUES ('1723347785853501441', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-11-11 22:31:45', '2023-11-11 22:31:45', '/room/page', 'GET', 1, NULL, 18);
INSERT INTO `system_operation_log` VALUES ('1723347795013861377', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-11-11 22:31:47', '2023-11-11 22:31:47', '/family/list', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1723347814496403457', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-11-11 22:31:47', '2023-11-11 22:31:47', '/floor/pageBackend', 'GET', 1, NULL, 27);
INSERT INTO `system_operation_log` VALUES ('1723347827771375618', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-11 22:31:52', '2023-11-11 22:31:52', '/floor/floorList', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1723347827838484482', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-11-11 22:31:52', '2023-11-11 22:31:52', '/room/page', 'GET', 1, NULL, 22);
INSERT INTO `system_operation_log` VALUES ('1723347848323465218', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-11-11 22:32:00', '2023-11-11 22:32:00', '/family/list', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1723347856472997889', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-11-11 22:32:00', '2023-11-11 22:32:00', '/floor/pageBackend', 'GET', 1, NULL, 32);
INSERT INTO `system_operation_log` VALUES ('1723347869802496001', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-11-11 22:32:04', '2023-11-11 22:32:04', '/room/page', 'GET', 1, NULL, 15);
INSERT INTO `system_operation_log` VALUES ('1723347869802496002', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-11 22:32:03', '2023-11-11 22:32:03', '/floor/floorList', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1723347890312642562', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-11-11 22:32:05', '2023-11-11 22:32:05', '/family/list', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1723347898491535361', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-11-11 22:32:05', '2023-11-11 22:32:05', '/floor/pageBackend', 'GET', 1, NULL, 23);
INSERT INTO `system_operation_log` VALUES ('1723347911770701826', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-11 22:32:06', '2023-11-11 22:32:06', '/floor/floorList', 'GET', 1, NULL, 1);
INSERT INTO `system_operation_log` VALUES ('1723347911829422081', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-11-11 22:32:06', '2023-11-11 22:32:06', '/room/page', 'GET', 1, NULL, 14);
INSERT INTO `system_operation_log` VALUES ('1723347932280848385', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-11-11 22:32:07', '2023-11-11 22:32:07', '/family/list', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1723347972038656002', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-11 22:32:29', '2023-11-11 22:32:29', '/floor/floorList', 'GET', 1, NULL, 1);
INSERT INTO `system_operation_log` VALUES ('1723347972118347777', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-11-11 22:32:29', '2023-11-11 22:32:29', '/room/page', 'GET', 1, NULL, 16);
INSERT INTO `system_operation_log` VALUES ('1723347979487739906', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-11-11 22:32:31', '2023-11-11 22:32:31', '/family/list', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1723347979617763330', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-11-11 22:32:31', '2023-11-11 22:32:31', '/floor/pageBackend', 'GET', 1, NULL, 22);
INSERT INTO `system_operation_log` VALUES ('1723350120449245186', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-11 22:41:02', '2023-11-11 22:41:02', '/floor/floorList', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1723350120516354050', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-11-11 22:41:02', '2023-11-11 22:41:02', '/room/page', 'GET', 1, NULL, 16);
INSERT INTO `system_operation_log` VALUES ('1723350170961248257', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-11-11 22:41:14', '2023-11-11 22:41:14', '/family/list', 'GET', 1, NULL, 7);
INSERT INTO `system_operation_log` VALUES ('1723350171019968514', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-11-11 22:41:14', '2023-11-11 22:41:14', '/floor/pageBackend', 'GET', 1, NULL, 27);
INSERT INTO `system_operation_log` VALUES ('1723350175579176962', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-11 22:41:15', '2023-11-11 22:41:15', '/floor/floorList', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1723350175642091521', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-11-11 22:41:15', '2023-11-11 22:41:15', '/room/page', 'GET', 1, NULL, 15);
INSERT INTO `system_operation_log` VALUES ('1723351188973355009', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-11 22:45:16', '2023-11-11 22:45:16', '/floor/floorList', 'GET', 1, NULL, 12);
INSERT INTO `system_operation_log` VALUES ('1723351189359230978', NULL, '后台分页查询', '0:0:0:0:0:0:0:1', '2023-11-11 22:45:17', '2023-11-11 22:45:17', '/room/pageBackend', 'GET', 1, NULL, 107);
INSERT INTO `system_operation_log` VALUES ('1723351536412721153', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-11 22:46:39', '2023-11-11 22:46:39', '/floor/floorList', 'GET', 1, NULL, 8);
INSERT INTO `system_operation_log` VALUES ('1723351536492412929', NULL, '后台分页查询', '0:0:0:0:0:0:0:1', '2023-11-11 22:46:39', '2023-11-11 22:46:39', '/room/pageBackend', 'GET', 1, NULL, 40);
INSERT INTO `system_operation_log` VALUES ('1723351632252567553', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-11 22:47:02', '2023-11-11 22:47:02', '/floor/floorList', 'GET', 1, NULL, 1);
INSERT INTO `system_operation_log` VALUES ('1723351632323870721', NULL, '后台分页查询', '0:0:0:0:0:0:0:1', '2023-11-11 22:47:02', '2023-11-11 22:47:02', '/room/pageBackend', 'GET', 1, NULL, 17);
INSERT INTO `system_operation_log` VALUES ('1723351711386501121', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-11-11 22:47:21', '2023-11-11 22:47:21', '/permission/getPerm', 'GET', 1, NULL, 7);
INSERT INTO `system_operation_log` VALUES ('1723351712695123969', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-11 22:47:21', '2023-11-11 22:47:21', '/floor/floorList', 'GET', 1, NULL, 2);
INSERT INTO `system_operation_log` VALUES ('1723351712774815746', NULL, '后台分页查询', '0:0:0:0:0:0:0:1', '2023-11-11 22:47:21', '2023-11-11 22:47:21', '/room/pageBackend', 'GET', 1, NULL, 19);
INSERT INTO `system_operation_log` VALUES ('1723351807247319042', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-11 22:47:44', '2023-11-11 22:47:44', '/floor/floorList', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1723351807247319043', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-11-11 22:47:44', '2023-11-11 22:47:44', '/family/list', 'GET', 1, NULL, 13);
INSERT INTO `system_operation_log` VALUES ('1723351807339593729', NULL, '后台分页查询', '0:0:0:0:0:0:0:1', '2023-11-11 22:47:44', '2023-11-11 22:47:44', '/room/pageBackend', 'GET', 1, NULL, 21);
INSERT INTO `system_operation_log` VALUES ('1723351815132610562', NULL, '后台分页查询', '0:0:0:0:0:0:0:1', '2023-11-11 22:47:46', '2023-11-11 22:47:46', '/room/pageBackend', 'GET', 1, NULL, 20);
INSERT INTO `system_operation_log` VALUES ('1723605933612969985', NULL, '登录', '0:0:0:0:0:0:0:1', '2023-11-12 15:37:32', '2023-11-12 15:37:32', '/user/login', 'POST', 1, NULL, 984);
INSERT INTO `system_operation_log` VALUES ('1723605934128869377', '1', '查询个人信息', '0:0:0:0:0:0:0:1', '2023-11-12 15:37:32', '2023-11-12 15:37:32', '/user/info', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1723605934191783938', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-11-12 15:37:32', '2023-11-12 15:37:32', '/permission/getPerm', 'GET', 1, NULL, 33);
INSERT INTO `system_operation_log` VALUES ('1723605935622041602', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2023-11-12 15:37:33', '2023-11-12 15:37:33', '/dashboard/dashboardInfo', 'GET', 1, NULL, 35);
INSERT INTO `system_operation_log` VALUES ('1723605975698616322', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-12 15:37:33', '2023-11-12 15:37:33', '/floor/floorList', 'GET', 1, NULL, 48);
INSERT INTO `system_operation_log` VALUES ('1723605976159989761', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-12 15:37:36', '2023-11-12 15:37:36', '/family/page', 'GET', 1, NULL, 115);
INSERT INTO `system_operation_log` VALUES ('1723605976227098626', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-11-12 15:37:37', '2023-11-12 15:37:37', '/permission/getPerm', 'GET', 1, NULL, 8);
INSERT INTO `system_operation_log` VALUES ('1723605977602830337', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-12 15:37:37', '2023-11-12 15:37:37', '/family/page', 'GET', 1, NULL, 38);
INSERT INTO `system_operation_log` VALUES ('1723607512244137986', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-11-12 15:43:49', '2023-11-12 15:43:49', '/product/page', 'GET', 1, NULL, 44);
INSERT INTO `system_operation_log` VALUES ('1723607520678883329', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-12 15:43:51', '2023-11-12 15:43:51', '/family/page', 'GET', 1, NULL, 27);
INSERT INTO `system_operation_log` VALUES ('1723607572122021889', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-12 15:44:03', '2023-11-12 15:44:03', '/floor/floorList', 'GET', 1, NULL, 2);
INSERT INTO `system_operation_log` VALUES ('1723607572168159234', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2023-11-12 15:44:03', '2023-11-12 15:44:03', '/dashboard/dashboardInfo', 'GET', 1, NULL, 17);
INSERT INTO `system_operation_log` VALUES ('1723608279654969346', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2023-11-12 15:46:52', '2023-11-12 15:46:52', '/product/list', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1723608279722078210', NULL, '', '0:0:0:0:0:0:0:1', '2023-11-12 15:46:52', '2023-11-12 15:46:52', '/error', 'GET', 0, '系统错误请联系管理员', 8);
INSERT INTO `system_operation_log` VALUES ('1723609221884391425', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-11-12 15:50:36', '2023-11-12 15:50:36', '/product/page', 'GET', 1, NULL, 19);
INSERT INTO `system_operation_log` VALUES ('1723664937999511554', NULL, '新增或修改产品', '0:0:0:0:0:0:0:1', '2023-11-12 19:32:00', '2023-11-12 19:32:00', '/product/addUpdate', 'POST', 1, NULL, 52);
INSERT INTO `system_operation_log` VALUES ('1723664938196643841', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-11-12 19:32:00', '2023-11-12 19:32:00', '/product/page', 'GET', 1, NULL, 20);
INSERT INTO `system_operation_log` VALUES ('1723665008828723201', NULL, '登录', '0:0:0:0:0:0:0:1', '2023-11-12 19:32:17', '2023-11-12 19:32:17', '/user/login', 'POST', 1, NULL, 92);
INSERT INTO `system_operation_log` VALUES ('1723665008895832065', '1', '查询个人信息', '0:0:0:0:0:0:0:1', '2023-11-12 19:32:17', '2023-11-12 19:32:17', '/user/info', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1723665008895832066', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-11-12 19:32:17', '2023-11-12 19:32:17', '/permission/getPerm', 'GET', 1, NULL, 7);
INSERT INTO `system_operation_log` VALUES ('1723665009512394753', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-12 19:32:17', '2023-11-12 19:32:17', '/floor/floorList', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1723665050847260673', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2023-11-12 19:32:17', '2023-11-12 19:32:17', '/dashboard/dashboardInfo', 'GET', 1, NULL, 15);
INSERT INTO `system_operation_log` VALUES ('1723665050910175234', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-12 19:32:20', '2023-11-12 19:32:20', '/family/page', 'GET', 1, NULL, 16);
INSERT INTO `system_operation_log` VALUES ('1723665050977284097', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-11-12 19:32:21', '2023-11-12 19:32:21', '/permission/getPerm', 'GET', 1, NULL, 6);
INSERT INTO `system_operation_log` VALUES ('1723665051497377793', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-12 19:32:21', '2023-11-12 19:32:21', '/family/page', 'GET', 1, NULL, 21);
INSERT INTO `system_operation_log` VALUES ('1723665099211780098', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-11-12 19:32:38', '2023-11-12 19:32:38', '/family/list', 'GET', 1, NULL, 6);
INSERT INTO `system_operation_log` VALUES ('1723665099278888962', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-11-12 19:32:38', '2023-11-12 19:32:38', '/floor/pageBackend', 'GET', 1, NULL, 25);
INSERT INTO `system_operation_log` VALUES ('1723665103905206274', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-12 19:32:40', '2023-11-12 19:32:40', '/floor/floorList', 'GET', 1, NULL, 1);
INSERT INTO `system_operation_log` VALUES ('1723665103972315138', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-11-12 19:32:40', '2023-11-12 19:32:40', '/family/list', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1723665141242900481', NULL, '后台分页查询', '0:0:0:0:0:0:0:1', '2023-11-12 19:32:40', '2023-11-12 19:32:40', '/room/pageBackend', 'GET', 1, NULL, 37);
INSERT INTO `system_operation_log` VALUES ('1723665574246068225', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-12 19:34:32', '2023-11-12 19:34:32', '/family/page', 'GET', 1, NULL, 21);
INSERT INTO `system_operation_log` VALUES ('1723667523020369921', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-11-12 19:42:16', '2023-11-12 19:42:16', '/permission/getPerm', 'GET', 1, NULL, 15);
INSERT INTO `system_operation_log` VALUES ('1723667523213307905', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-12 19:42:16', '2023-11-12 19:42:16', '/family/page', 'GET', 1, NULL, 57);
INSERT INTO `system_operation_log` VALUES ('1723667549817778177', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-11-12 19:42:23', '2023-11-12 19:42:23', '/permission/getPerm', 'GET', 1, NULL, 17);
INSERT INTO `system_operation_log` VALUES ('1723667551331921921', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-12 19:42:23', '2023-11-12 19:42:23', '/family/page', 'GET', 1, NULL, 61);
INSERT INTO `system_operation_log` VALUES ('1723668627959427074', '1', '上报选择的语言', '0:0:0:0:0:0:0:1', '2023-11-12 19:46:40', '2023-11-12 19:46:40', '/user/updateLang', 'GET', 1, NULL, 4596);
INSERT INTO `system_operation_log` VALUES ('1723669022408552449', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-11-12 19:48:14', '2023-11-12 19:48:14', '/permission/getPerm', 'GET', 1, NULL, 37);
INSERT INTO `system_operation_log` VALUES ('1723669022576324610', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-12 19:48:14', '2023-11-12 19:48:14', '/family/page', 'GET', 1, NULL, 84);
INSERT INTO `system_operation_log` VALUES ('1723669121473818625', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-11-12 19:48:37', '2023-11-12 19:48:37', '/permission/getPerm', 'GET', 1, NULL, 8);
INSERT INTO `system_operation_log` VALUES ('1723669123227037697', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-12 19:48:38', '2023-11-12 19:48:38', '/family/page', 'GET', 1, NULL, 44);
INSERT INTO `system_operation_log` VALUES ('1723669138188120065', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-11-12 19:48:41', '2023-11-12 19:48:41', '/permission/getPerm', 'GET', 1, NULL, 6);
INSERT INTO `system_operation_log` VALUES ('1723669139643543553', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-12 19:48:42', '2023-11-12 19:48:42', '/family/page', 'GET', 1, NULL, 31);
INSERT INTO `system_operation_log` VALUES ('1723669163517521921', '1', '上报选择的语言', '0:0:0:0:0:0:0:1', '2023-11-12 19:48:47', '2023-11-12 19:48:47', '/user/updateLang', 'GET', 1, NULL, 41);
INSERT INTO `system_operation_log` VALUES ('1723669173936173057', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-11-12 19:48:50', '2023-11-12 19:48:50', '/permission/getPerm', 'GET', 1, NULL, 7);
INSERT INTO `system_operation_log` VALUES ('1723669180223434754', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-12 19:48:50', '2023-11-12 19:48:50', '/family/page', 'GET', 1, NULL, 68);
INSERT INTO `system_operation_log` VALUES ('1723669185063661569', '1', '上报选择的语言', '0:0:0:0:0:0:0:1', '2023-11-12 19:48:53', '2023-11-12 19:48:53', '/user/updateLang', 'GET', 1, NULL, 9);
INSERT INTO `system_operation_log` VALUES ('1723669409475702786', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-11-12 19:49:46', '2023-11-12 19:49:46', '/permission/getPerm', 'GET', 1, NULL, 6);
INSERT INTO `system_operation_log` VALUES ('1723669411128258562', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-12 19:49:47', '2023-11-12 19:49:47', '/family/page', 'GET', 1, NULL, 35);
INSERT INTO `system_operation_log` VALUES ('1723669419974045697', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-11-12 19:49:49', '2023-11-12 19:49:49', '/permission/getPerm', 'GET', 1, NULL, 7);
INSERT INTO `system_operation_log` VALUES ('1723669421156839426', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-12 19:49:49', '2023-11-12 19:49:49', '/family/page', 'GET', 1, NULL, 37);
INSERT INTO `system_operation_log` VALUES ('1723669451578126337', '1', '上报选择的语言', '0:0:0:0:0:0:0:1', '2023-11-12 19:49:55', '2023-11-12 19:49:55', '/user/updateLang', 'GET', 1, NULL, 10);
INSERT INTO `system_operation_log` VALUES ('1723669473464004609', '1', '上报选择的语言', '0:0:0:0:0:0:0:1', '2023-11-12 19:50:01', '2023-11-12 19:50:01', '/user/updateLang', 'GET', 1, NULL, 10);
INSERT INTO `system_operation_log` VALUES ('1723669731505975298', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-11-12 19:51:03', '2023-11-12 19:51:03', '/product/page', 'GET', 1, NULL, 40);
INSERT INTO `system_operation_log` VALUES ('1723669736815964161', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-12 19:51:04', '2023-11-12 19:51:04', '/family/page', 'GET', 1, NULL, 33);
INSERT INTO `system_operation_log` VALUES ('1723669796500910081', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-11-12 19:51:18', '2023-11-12 19:51:18', '/product/page', 'GET', 1, NULL, 31);
INSERT INTO `system_operation_log` VALUES ('1723669805850013698', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-12 19:51:21', '2023-11-12 19:51:21', '/family/page', 'GET', 1, NULL, 26);
INSERT INTO `system_operation_log` VALUES ('1723669879921422337', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-11-12 19:51:38', '2023-11-12 19:51:38', '/permission/getPerm', 'GET', 1, NULL, 6);
INSERT INTO `system_operation_log` VALUES ('1723669881041301505', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-12 19:51:39', '2023-11-12 19:51:39', '/family/page', 'GET', 1, NULL, 23);
INSERT INTO `system_operation_log` VALUES ('1723669893875871746', '1', '上报选择的语言', '0:0:0:0:0:0:0:1', '2023-11-12 19:51:42', '2023-11-12 19:51:42', '/user/updateLang', 'GET', 1, NULL, 8);
INSERT INTO `system_operation_log` VALUES ('1723669935055548418', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-11-12 19:51:51', '2023-11-12 19:51:51', '/product/page', 'GET', 1, NULL, 24);
INSERT INTO `system_operation_log` VALUES ('1723669972116418562', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2023-11-12 19:52:00', '2023-11-12 19:52:00', '/product/list', 'GET', 1, NULL, 7);
INSERT INTO `system_operation_log` VALUES ('1723669972116418563', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-12 19:52:00', '2023-11-12 19:52:00', '/floor/floorList', 'GET', 1, NULL, 6);
INSERT INTO `system_operation_log` VALUES ('1723669972477128705', '1', '分页查询', '0:0:0:0:0:0:0:1', '2023-11-12 19:52:00', '2023-11-12 19:52:00', '/device/page', 'GET', 1, NULL, 91);
INSERT INTO `system_operation_log` VALUES ('1723669984934211585', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-11-12 19:52:03', '2023-11-12 19:52:03', '/product/page', 'GET', 1, NULL, 26);
INSERT INTO `system_operation_log` VALUES ('1723670014113984513', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-12 19:52:05', '2023-11-12 19:52:05', '/floor/floorList', 'GET', 1, NULL, 1);
INSERT INTO `system_operation_log` VALUES ('1723670014176899073', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2023-11-12 19:52:05', '2023-11-12 19:52:05', '/product/list', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1723670014508249089', '1', '分页查询', '0:0:0:0:0:0:0:1', '2023-11-12 19:52:05', '2023-11-12 19:52:05', '/device/page', 'GET', 1, NULL, 33);
INSERT INTO `system_operation_log` VALUES ('1723670048402419713', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-12 19:52:18', '2023-11-12 19:52:18', '/family/page', 'GET', 1, NULL, 25);
INSERT INTO `system_operation_log` VALUES ('1723670056124133378', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-11-12 19:52:20', '2023-11-12 19:52:20', '/family/list', 'GET', 1, NULL, 8);
INSERT INTO `system_operation_log` VALUES ('1723670056187047937', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-11-12 19:52:20', '2023-11-12 19:52:20', '/floor/pageBackend', 'GET', 1, NULL, 27);
INSERT INTO `system_operation_log` VALUES ('1723670065926221826', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-11-12 19:52:23', '2023-11-12 19:52:23', '/floor/pageBackend', 'GET', 1, NULL, 26);
INSERT INTO `system_operation_log` VALUES ('1723670090483871745', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-11-12 19:52:25', '2023-11-12 19:52:25', '/floor/pageBackend', 'GET', 1, NULL, 24);
INSERT INTO `system_operation_log` VALUES ('1723670098138476546', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-11-12 19:52:27', '2023-11-12 19:52:27', '/floor/pageBackend', 'GET', 1, NULL, 25);
INSERT INTO `system_operation_log` VALUES ('1723670098205585409', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-11-12 19:52:29', '2023-11-12 19:52:29', '/floor/pageBackend', 'GET', 1, NULL, 21);
INSERT INTO `system_operation_log` VALUES ('1723670110763331585', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-11-12 19:52:33', '2023-11-12 19:52:33', '/floor/pageBackend', 'GET', 1, NULL, 19);
INSERT INTO `system_operation_log` VALUES ('1723670150495973378', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-12 19:52:43', '2023-11-12 19:52:43', '/floor/floorList', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1723670150646968321', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-11-12 19:52:43', '2023-11-12 19:52:43', '/family/list', 'GET', 1, NULL, 19);
INSERT INTO `system_operation_log` VALUES ('1723670150693105665', NULL, '后台分页查询', '0:0:0:0:0:0:0:1', '2023-11-12 19:52:43', '2023-11-12 19:52:43', '/room/pageBackend', 'GET', 1, NULL, 31);
INSERT INTO `system_operation_log` VALUES ('1723670166543380481', NULL, '后台分页查询', '0:0:0:0:0:0:0:1', '2023-11-12 19:52:47', '2023-11-12 19:52:47', '/room/pageBackend', 'GET', 1, NULL, 16);
INSERT INTO `system_operation_log` VALUES ('1723670620077666305', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-12 19:54:35', '2023-11-12 19:54:35', '/floor/floorList', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1723670620077666306', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-11-12 19:54:35', '2023-11-12 19:54:35', '/family/list', 'GET', 1, NULL, 7);
INSERT INTO `system_operation_log` VALUES ('1723670620140580865', NULL, '后台分页查询', '0:0:0:0:0:0:0:1', '2023-11-12 19:54:35', '2023-11-12 19:54:35', '/room/pageBackend', 'GET', 1, NULL, 20);
INSERT INTO `system_operation_log` VALUES ('1723670697290608641', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-11-12 19:54:53', '2023-11-12 19:54:53', '/permission/getPerm', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1723670698502762497', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-12 19:54:53', '2023-11-12 19:54:53', '/floor/floorList', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1723670698502762498', NULL, '后台分页查询', '0:0:0:0:0:0:0:1', '2023-11-12 19:54:53', '2023-11-12 19:54:53', '/room/pageBackend', 'GET', 1, NULL, 20);
INSERT INTO `system_operation_log` VALUES ('1723670698502762499', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-11-12 19:54:53', '2023-11-12 19:54:53', '/family/list', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1723671160815726594', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-11-12 19:56:44', '2023-11-12 19:56:44', '/permission/getPerm', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1723671162141126658', NULL, '后台分页查询', '0:0:0:0:0:0:0:1', '2023-11-12 19:56:44', '2023-11-12 19:56:44', '/room/pageBackend', 'GET', 1, NULL, 26);
INSERT INTO `system_operation_log` VALUES ('1723671162141126659', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-12 19:56:44', '2023-11-12 19:56:44', '/floor/floorList', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1723671162141126660', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-11-12 19:56:44', '2023-11-12 19:56:44', '/family/list', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1723671299525554178', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-12 19:57:17', '2023-11-12 19:57:17', '/floor/floorList', 'GET', 1, NULL, 8);
INSERT INTO `system_operation_log` VALUES ('1723671299684937730', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-11-12 19:57:17', '2023-11-12 19:57:17', '/family/list', 'GET', 1, NULL, 8);
INSERT INTO `system_operation_log` VALUES ('1723671299684937731', NULL, '后台分页查询', '0:0:0:0:0:0:0:1', '2023-11-12 19:57:17', '2023-11-12 19:57:17', '/room/pageBackend', 'GET', 1, NULL, 17);
INSERT INTO `system_operation_log` VALUES ('1723671402105647105', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-11-12 19:57:41', '2023-11-12 19:57:41', '/permission/getPerm', 'GET', 1, NULL, 6);
INSERT INTO `system_operation_log` VALUES ('1723671403439435777', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-12 19:57:42', '2023-11-12 19:57:42', '/floor/floorList', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1723671403439435778', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-11-12 19:57:42', '2023-11-12 19:57:42', '/family/list', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1723671403439435779', NULL, '后台分页查询', '0:0:0:0:0:0:0:1', '2023-11-12 19:57:42', '2023-11-12 19:57:42', '/room/pageBackend', 'GET', 1, NULL, 13);
INSERT INTO `system_operation_log` VALUES ('1723672200478830594', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-12 20:00:52', '2023-11-12 20:00:52', '/floor/floorList', 'GET', 1, NULL, 1);
INSERT INTO `system_operation_log` VALUES ('1723672200478830595', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-11-12 20:00:52', '2023-11-12 20:00:52', '/family/list', 'GET', 1, NULL, 12);
INSERT INTO `system_operation_log` VALUES ('1723672200613048321', NULL, '后台分页查询', '0:0:0:0:0:0:0:1', '2023-11-12 20:00:52', '2023-11-12 20:00:52', '/room/pageBackend', 'GET', 1, NULL, 23);
INSERT INTO `system_operation_log` VALUES ('1723672431169744897', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-12 20:01:47', '2023-11-12 20:01:47', '/floor/floorList', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1723672431169744898', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-11-12 20:01:47', '2023-11-12 20:01:47', '/family/list', 'GET', 1, NULL, 6);
INSERT INTO `system_operation_log` VALUES ('1723672431282991105', NULL, '后台分页查询', '0:0:0:0:0:0:0:1', '2023-11-12 20:01:47', '2023-11-12 20:01:47', '/room/pageBackend', 'GET', 1, NULL, 24);
INSERT INTO `system_operation_log` VALUES ('1723672608655912961', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-12 20:02:29', '2023-11-12 20:02:29', '/floor/floorList', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1723672608655912962', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-11-12 20:02:29', '2023-11-12 20:02:29', '/family/list', 'GET', 1, NULL, 13);
INSERT INTO `system_operation_log` VALUES ('1723672608769159169', NULL, '后台分页查询', '0:0:0:0:0:0:0:1', '2023-11-12 20:02:29', '2023-11-12 20:02:29', '/room/pageBackend', 'GET', 1, NULL, 37);
INSERT INTO `system_operation_log` VALUES ('1723672894782943233', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-12 20:03:37', '2023-11-12 20:03:37', '/floor/floorList', 'GET', 1, NULL, 1);
INSERT INTO `system_operation_log` VALUES ('1723672894782943234', NULL, '后台分页查询', '0:0:0:0:0:0:0:1', '2023-11-12 20:03:37', '2023-11-12 20:03:37', '/room/pageBackend', 'GET', 1, NULL, 30);
INSERT INTO `system_operation_log` VALUES ('1723672894782943235', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-11-12 20:03:37', '2023-11-12 20:03:37', '/family/list', 'GET', 1, NULL, 9);
INSERT INTO `system_operation_log` VALUES ('1723672966128054274', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-11-12 20:03:54', '2023-11-12 20:03:54', '/permission/getPerm', 'GET', 1, NULL, 7);
INSERT INTO `system_operation_log` VALUES ('1723672967436677122', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-12 20:03:54', '2023-11-12 20:03:54', '/floor/floorList', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1723672967436677123', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-11-12 20:03:54', '2023-11-12 20:03:54', '/family/list', 'GET', 1, NULL, 12);
INSERT INTO `system_operation_log` VALUES ('1723672967436677124', NULL, '后台分页查询', '0:0:0:0:0:0:0:1', '2023-11-12 20:03:54', '2023-11-12 20:03:54', '/room/pageBackend', 'GET', 1, NULL, 24);
INSERT INTO `system_operation_log` VALUES ('1723673100756824065', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-12 20:04:26', '2023-11-12 20:04:26', '/floor/floorList', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1723673100891041793', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-11-12 20:04:26', '2023-11-12 20:04:26', '/family/list', 'GET', 1, NULL, 13);
INSERT INTO `system_operation_log` VALUES ('1723673100891041794', NULL, '后台分页查询', '0:0:0:0:0:0:0:1', '2023-11-12 20:04:26', '2023-11-12 20:04:26', '/room/pageBackend', 'GET', 1, NULL, 21);
INSERT INTO `system_operation_log` VALUES ('1723673719966117890', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-12 20:06:54', '2023-11-12 20:06:54', '/floor/floorList', 'GET', 1, NULL, 2);
INSERT INTO `system_operation_log` VALUES ('1723673719966117891', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-11-12 20:06:54', '2023-11-12 20:06:54', '/family/list', 'GET', 1, NULL, 7);
INSERT INTO `system_operation_log` VALUES ('1723673720029032450', NULL, '后台分页查询', '0:0:0:0:0:0:0:1', '2023-11-12 20:06:54', '2023-11-12 20:06:54', '/room/pageBackend', 'GET', 1, NULL, 19);
INSERT INTO `system_operation_log` VALUES ('1723673905652150274', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-12 20:07:38', '2023-11-12 20:07:38', '/floor/floorList', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1723673905652150275', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-11-12 20:07:38', '2023-11-12 20:07:38', '/family/list', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1723673905698287617', NULL, '后台分页查询', '0:0:0:0:0:0:0:1', '2023-11-12 20:07:38', '2023-11-12 20:07:38', '/room/pageBackend', 'GET', 1, NULL, 8);
INSERT INTO `system_operation_log` VALUES ('1723674931159478273', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-12 20:11:43', '2023-11-12 20:11:43', '/floor/floorList', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1723674931159478274', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-11-12 20:11:43', '2023-11-12 20:11:43', '/family/list', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1723674931230781442', NULL, '后台分页查询', '0:0:0:0:0:0:0:1', '2023-11-12 20:11:43', '2023-11-12 20:11:43', '/room/pageBackend', 'GET', 1, NULL, 19);
INSERT INTO `system_operation_log` VALUES ('1723675128438566914', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-12 20:12:30', '2023-11-12 20:12:30', '/floor/floorList', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1723675128438566915', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-11-12 20:12:30', '2023-11-12 20:12:30', '/family/list', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1723675128509870081', NULL, '后台分页查询', '0:0:0:0:0:0:0:1', '2023-11-12 20:12:30', '2023-11-12 20:12:30', '/room/pageBackend', 'GET', 1, NULL, 19);
INSERT INTO `system_operation_log` VALUES ('1723675297976528898', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-12 20:13:10', '2023-11-12 20:13:10', '/floor/floorList', 'GET', 1, NULL, 1);
INSERT INTO `system_operation_log` VALUES ('1723675297993306114', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-11-12 20:13:10', '2023-11-12 20:13:10', '/family/list', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1723675298035249153', NULL, '后台分页查询', '0:0:0:0:0:0:0:1', '2023-11-12 20:13:10', '2023-11-12 20:13:10', '/room/pageBackend', 'GET', 1, NULL, 19);
INSERT INTO `system_operation_log` VALUES ('1723675366318518274', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-12 20:13:26', '2023-11-12 20:13:26', '/floor/floorList', 'GET', 1, NULL, 1);
INSERT INTO `system_operation_log` VALUES ('1723675366318518275', NULL, '后台分页查询', '0:0:0:0:0:0:0:1', '2023-11-12 20:13:26', '2023-11-12 20:13:26', '/room/pageBackend', 'GET', 1, NULL, 13);
INSERT INTO `system_operation_log` VALUES ('1723675366494679041', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-11-12 20:13:26', '2023-11-12 20:13:26', '/family/list', 'GET', 1, NULL, 11);
INSERT INTO `system_operation_log` VALUES ('1723675424099250177', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-12 20:13:40', '2023-11-12 20:13:40', '/floor/floorList', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1723675424212496386', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-11-12 20:13:40', '2023-11-12 20:13:40', '/family/list', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1723675424233467905', NULL, '后台分页查询', '0:0:0:0:0:0:0:1', '2023-11-12 20:13:40', '2023-11-12 20:13:40', '/room/pageBackend', 'GET', 1, NULL, 18);
INSERT INTO `system_operation_log` VALUES ('1723675516927586305', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-12 20:14:02', '2023-11-12 20:14:02', '/floor/floorList', 'GET', 1, NULL, 1);
INSERT INTO `system_operation_log` VALUES ('1723675516927586306', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-11-12 20:14:02', '2023-11-12 20:14:02', '/family/list', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1723675516927586307', NULL, '后台分页查询', '0:0:0:0:0:0:0:1', '2023-11-12 20:14:02', '2023-11-12 20:14:02', '/room/pageBackend', 'GET', 1, NULL, 23);
INSERT INTO `system_operation_log` VALUES ('1723675736868499458', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-12 20:14:55', '2023-11-12 20:14:55', '/floor/floorList', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1723675736868499459', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-11-12 20:14:55', '2023-11-12 20:14:55', '/family/list', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1723675736935608322', NULL, '后台分页查询', '0:0:0:0:0:0:0:1', '2023-11-12 20:14:55', '2023-11-12 20:14:55', '/room/pageBackend', 'GET', 1, NULL, 21);
INSERT INTO `system_operation_log` VALUES ('1723675827536769026', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-12 20:15:16', '2023-11-12 20:15:16', '/floor/floorList', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1723675827624849410', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-11-12 20:15:16', '2023-11-12 20:15:16', '/family/list', 'GET', 1, NULL, 10);
INSERT INTO `system_operation_log` VALUES ('1723675827675181058', NULL, '后台分页查询', '0:0:0:0:0:0:0:1', '2023-11-12 20:15:16', '2023-11-12 20:15:16', '/room/pageBackend', 'GET', 1, NULL, 22);
INSERT INTO `system_operation_log` VALUES ('1723679892185337858', NULL, '新增或修改房间', '0:0:0:0:0:0:0:1', '2023-11-12 20:31:25', '2023-11-12 20:31:25', '/room/addUpdate', 'POST', 1, NULL, 69392);
INSERT INTO `system_operation_log` VALUES ('1723679934195486722', NULL, '登录', '0:0:0:0:0:0:0:1', '2023-11-12 20:31:35', '2023-11-12 20:31:35', '/user/login', 'POST', 1, NULL, 166);
INSERT INTO `system_operation_log` VALUES ('1723679934392619009', '1', '查询个人信息', '0:0:0:0:0:0:0:1', '2023-11-12 20:31:35', '2023-11-12 20:31:35', '/user/info', 'GET', 1, NULL, 6);
INSERT INTO `system_operation_log` VALUES ('1723679934778494978', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-11-12 20:31:36', '2023-11-12 20:31:36', '/permission/getPerm', 'GET', 1, NULL, 98);
INSERT INTO `system_operation_log` VALUES ('1723679936699486210', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2023-11-12 20:31:36', '2023-11-12 20:31:36', '/dashboard/dashboardInfo', 'GET', 1, NULL, 48);
INSERT INTO `system_operation_log` VALUES ('1723679976331464706', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-12 20:31:36', '2023-11-12 20:31:36', '/floor/floorList', 'GET', 1, NULL, 74);
INSERT INTO `system_operation_log` VALUES ('1723679976457293825', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-12 20:31:38', '2023-11-12 20:31:38', '/family/page', 'GET', 1, NULL, 129);
INSERT INTO `system_operation_log` VALUES ('1723679976851558401', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-11-12 20:31:39', '2023-11-12 20:31:39', '/product/page', 'GET', 1, NULL, 71);
INSERT INTO `system_operation_log` VALUES ('1723679978680274946', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-12 20:31:41', '2023-11-12 20:31:41', '/family/page', 'GET', 1, NULL, 30);
INSERT INTO `system_operation_log` VALUES ('1723680018358390785', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-12 20:31:42', '2023-11-12 20:31:42', '/floor/floorList', 'GET', 1, NULL, 1);
INSERT INTO `system_operation_log` VALUES ('1723680023198617602', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-11-12 20:31:57', '2023-11-12 20:31:57', '/family/list', 'GET', 1, NULL, 19);
INSERT INTO `system_operation_log` VALUES ('1723680023257337857', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-11-12 20:31:57', '2023-11-12 20:31:57', '/floor/pageBackend', 'GET', 1, NULL, 46);
INSERT INTO `system_operation_log` VALUES ('1723680031192961026', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-12 20:31:59', '2023-11-12 20:31:59', '/floor/floorList', 'GET', 1, NULL, 1);
INSERT INTO `system_operation_log` VALUES ('1723680060347568129', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-11-12 20:31:59', '2023-11-12 20:31:59', '/family/list', 'GET', 1, NULL, 9);
INSERT INTO `system_operation_log` VALUES ('1723680065187794945', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-11-12 20:31:59', '2023-11-12 20:31:59', '/room/pageBackend', 'GET', 1, NULL, 34);
INSERT INTO `system_operation_log` VALUES ('1723684655253737473', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-11-12 20:50:21', '2023-11-12 20:50:21', '/permission/getPerm', 'GET', 1, NULL, 11);
INSERT INTO `system_operation_log` VALUES ('1723684655660584961', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-12 20:50:21', '2023-11-12 20:50:21', '/floor/floorList', 'GET', 1, NULL, 1);
INSERT INTO `system_operation_log` VALUES ('1723684655748665345', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-11-12 20:50:21', '2023-11-12 20:50:21', '/family/list', 'GET', 1, NULL, 7);
INSERT INTO `system_operation_log` VALUES ('1723684655782219777', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-11-12 20:50:21', '2023-11-12 20:50:21', '/room/pageBackend', 'GET', 1, NULL, 29);
INSERT INTO `system_operation_log` VALUES ('1723685265906651138', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-11-12 20:52:47', '2023-11-12 20:52:47', '/permission/getPerm', 'GET', 1, NULL, 8);
INSERT INTO `system_operation_log` VALUES ('1723685266695180289', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-12 20:52:47', '2023-11-12 20:52:47', '/floor/floorList', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1723685266695180290', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-11-12 20:52:47', '2023-11-12 20:52:47', '/room/pageBackend', 'GET', 1, NULL, 27);
INSERT INTO `system_operation_log` VALUES ('1723685266695180291', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-11-12 20:52:47', '2023-11-12 20:52:47', '/family/list', 'GET', 1, NULL, 8);
INSERT INTO `system_operation_log` VALUES ('1723686017236557825', NULL, '登录', '0:0:0:0:0:0:0:1', '2023-11-12 20:55:46', '2023-11-12 20:55:46', '/user/login', 'POST', 1, NULL, 840);
INSERT INTO `system_operation_log` VALUES ('1723686017236557826', '1', '查询个人信息', '0:0:0:0:0:0:0:1', '2023-11-12 20:55:46', '2023-11-12 20:55:46', '/user/info', 'GET', 1, NULL, 11);
INSERT INTO `system_operation_log` VALUES ('1723686017379164161', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-11-12 20:55:46', '2023-11-12 20:55:46', '/permission/getPerm', 'GET', 1, NULL, 63);
INSERT INTO `system_operation_log` VALUES ('1723686019195297794', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2023-11-12 20:55:46', '2023-11-12 20:55:46', '/dashboard/dashboardInfo', 'GET', 1, NULL, 40);
INSERT INTO `system_operation_log` VALUES ('1723686059301232641', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-12 20:55:49', '2023-11-12 20:55:49', '/family/page', 'GET', 1, NULL, 125);
INSERT INTO `system_operation_log` VALUES ('1723686059301232642', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-12 20:55:46', '2023-11-12 20:55:46', '/floor/floorList', 'GET', 1, NULL, 71);
INSERT INTO `system_operation_log` VALUES ('1723686059435450370', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-12 20:55:50', '2023-11-12 20:55:50', '/floor/floorList', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1723686061222223873', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-11-12 20:55:50', '2023-11-12 20:55:50', '/family/list', 'GET', 1, NULL, 18);
INSERT INTO `system_operation_log` VALUES ('1723686101294604290', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-11-12 20:55:50', '2023-11-12 20:55:50', '/room/pageBackend', 'GET', 1, NULL, 85);
INSERT INTO `system_operation_log` VALUES ('1723686101357518850', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-11-12 20:55:57', '2023-11-12 20:55:57', '/family/list', 'GET', 1, NULL, 10);
INSERT INTO `system_operation_log` VALUES ('1723686101428822017', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-11-12 20:55:59', '2023-11-12 20:55:59', '/floor/pageBackend', 'GET', 1, NULL, 33);
INSERT INTO `system_operation_log` VALUES ('1723686103249149953', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-12 20:56:00', '2023-11-12 20:56:00', '/floor/floorList', 'GET', 1, NULL, 1);
INSERT INTO `system_operation_log` VALUES ('1723686143304753154', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-11-12 20:56:00', '2023-11-12 20:56:00', '/room/pageBackend', 'GET', 1, NULL, 29);
INSERT INTO `system_operation_log` VALUES ('1723687044350332930', NULL, '登录', '0:0:0:0:0:0:0:1', '2023-11-12 20:59:51', '2023-11-12 20:59:51', '/user/login', 'POST', 1, NULL, 419);
INSERT INTO `system_operation_log` VALUES ('1723687044459384833', '1', '查询个人信息', '0:0:0:0:0:0:0:1', '2023-11-12 20:59:51', '2023-11-12 20:59:51', '/user/info', 'GET', 1, NULL, 7);
INSERT INTO `system_operation_log` VALUES ('1723687044669100034', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-11-12 20:59:51', '2023-11-12 20:59:51', '/permission/getPerm', 'GET', 1, NULL, 66);
INSERT INTO `system_operation_log` VALUES ('1723687044719431681', '1', '查询个人信息', '0:0:0:0:0:0:0:1', '2023-11-12 20:59:51', '2023-11-12 20:59:51', '/user/info', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1723687086498893826', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2023-11-12 20:59:51', '2023-11-12 20:59:51', '/dashboard/dashboardInfo', 'GET', 1, NULL, 44);
INSERT INTO `system_operation_log` VALUES ('1723687086498893827', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-11-12 20:59:51', '2023-11-12 20:59:51', '/permission/getPerm', 'GET', 1, NULL, 9);
INSERT INTO `system_operation_log` VALUES ('1723687086691831810', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-12 20:59:51', '2023-11-12 20:59:51', '/floor/floorList', 'GET', 1, NULL, 83);
INSERT INTO `system_operation_log` VALUES ('1723687086754746370', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-12 20:59:54', '2023-11-12 20:59:54', '/family/page', 'GET', 1, NULL, 96);
INSERT INTO `system_operation_log` VALUES ('1723687128513236994', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-11-12 20:59:56', '2023-11-12 20:59:56', '/family/list', 'GET', 1, NULL, 10);
INSERT INTO `system_operation_log` VALUES ('1723687341311250433', '1', '新增或修改房间', '0:0:0:0:0:0:0:1', '2023-11-12 21:01:01', '2023-11-12 21:01:01', '/room/addUpdate', 'POST', 0, '不能修改为已存在名称', 34150);
INSERT INTO `system_operation_log` VALUES ('1723687996058882049', '1', '新增或修改房间', '0:0:0:0:0:0:0:1', '2023-11-12 21:03:37', '2023-11-12 21:03:37', '/room/addUpdate', 'POST', 0, '不能修改为已存在名称', 48769);
INSERT INTO `system_operation_log` VALUES ('1723689475410874370', '1', '新增或修改房间', '0:0:0:0:0:0:0:1', '2023-11-12 21:09:30', '2023-11-12 21:09:30', '/room/addUpdate', 'POST', 0, '不能修改为已存在名称', 330875);
INSERT INTO `system_operation_log` VALUES ('1723690018715848706', '1', '新增或修改房间', '0:0:0:0:0:0:0:1', '2023-11-12 21:11:40', '2023-11-12 21:11:40', '/room/addUpdate', 'POST', 1, NULL, 62);
INSERT INTO `system_operation_log` VALUES ('1723690019114307585', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-11-12 21:11:40', '2023-11-12 21:11:40', '/room/pageBackend', 'GET', 1, NULL, 60);
INSERT INTO `system_operation_log` VALUES ('1723690040790470658', '1', '新增或修改房间', '0:0:0:0:0:0:0:1', '2023-11-12 21:11:45', '2023-11-12 21:11:45', '/room/addUpdate', 'POST', 1, NULL, 14);
INSERT INTO `system_operation_log` VALUES ('1723690041058906113', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-11-12 21:11:45', '2023-11-12 21:11:45', '/room/pageBackend', 'GET', 1, NULL, 28);
INSERT INTO `system_operation_log` VALUES ('1723690193995812867', '1', '新增或修改房间', '0:0:0:0:0:0:0:1', '2023-11-12 21:12:22', '2023-11-12 21:12:22', '/room/addUpdate', 'POST', 1, NULL, 24);
INSERT INTO `system_operation_log` VALUES ('1723690194243276801', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-11-12 21:12:22', '2023-11-12 21:12:22', '/room/pageBackend', 'GET', 1, NULL, 32);
INSERT INTO `system_operation_log` VALUES ('1723690237276835841', '1', '新增或修改房间', '0:0:0:0:0:0:0:1', '2023-11-12 21:12:32', '2023-11-12 21:12:32', '/room/addUpdate', 'POST', 0, '不能修改为已存在名称', 10);
INSERT INTO `system_operation_log` VALUES ('1723690566722637825', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-11-12 21:13:50', '2023-11-12 21:13:50', '/permission/getPerm', 'GET', 1, NULL, 16);
INSERT INTO `system_operation_log` VALUES ('1723690568228392962', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-11-12 21:13:51', '2023-11-12 21:13:51', '/room/pageBackend', 'GET', 1, NULL, 35);
INSERT INTO `system_operation_log` VALUES ('1723690568228392963', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-12 21:13:51', '2023-11-12 21:13:51', '/floor/floorList', 'GET', 1, NULL, 18);
INSERT INTO `system_operation_log` VALUES ('1723690568228392964', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-11-12 21:13:51', '2023-11-12 21:13:51', '/family/list', 'GET', 1, NULL, 21);
INSERT INTO `system_operation_log` VALUES ('1723693358451380225', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-12 21:24:56', '2023-11-12 21:24:56', '/floor/floorList', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1723693358522683393', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-11-12 21:24:56', '2023-11-12 21:24:56', '/family/list', 'GET', 1, NULL, 11);
INSERT INTO `system_operation_log` VALUES ('1723693358581403649', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-11-12 21:24:56', '2023-11-12 21:24:56', '/room/pageBackend', 'GET', 1, NULL, 32);
INSERT INTO `system_operation_log` VALUES ('1723693385517223937', '1', '删除房间', '0:0:0:0:0:0:0:1', '2023-11-12 21:25:02', '2023-11-12 21:25:02', '/room/delete/1723690193995812866', 'DELETE', 1, NULL, 22);
INSERT INTO `system_operation_log` VALUES ('1723693400520249345', '1', '删除房间', '0:0:0:0:0:0:0:1', '2023-11-12 21:25:05', '2023-11-12 21:25:05', '/room/delete/1723679891690409986', 'DELETE', 1, NULL, 16);
INSERT INTO `system_operation_log` VALUES ('1723693400520249346', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-11-12 21:25:02', '2023-11-12 21:25:02', '/room/pageBackend', 'GET', 1, NULL, 20);
INSERT INTO `system_operation_log` VALUES ('1723693400650272769', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-11-12 21:25:05', '2023-11-12 21:25:05', '/room/pageBackend', 'GET', 1, NULL, 16);
INSERT INTO `system_operation_log` VALUES ('1723693447949438978', '1', '新增或修改房间', '0:0:0:0:0:0:0:1', '2023-11-12 21:25:17', '2023-11-12 21:25:17', '/room/addUpdate', 'POST', 1, NULL, 17);
INSERT INTO `system_operation_log` VALUES ('1723693448343703554', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-11-12 21:25:17', '2023-11-12 21:25:17', '/room/pageBackend', 'GET', 1, NULL, 26);
INSERT INTO `system_operation_log` VALUES ('1723693495202467843', '1', '新增或修改房间', '0:0:0:0:0:0:0:1', '2023-11-12 21:25:29', '2023-11-12 21:25:29', '/room/addUpdate', 'POST', 1, NULL, 17);
INSERT INTO `system_operation_log` VALUES ('1723693495475097601', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-11-12 21:25:29', '2023-11-12 21:25:29', '/room/pageBackend', 'GET', 1, NULL, 27);
INSERT INTO `system_operation_log` VALUES ('1723693534213689346', '1', '新增或修改房间', '0:0:0:0:0:0:0:1', '2023-11-12 21:25:38', '2023-11-12 21:25:38', '/room/addUpdate', 'POST', 1, NULL, 22);
INSERT INTO `system_operation_log` VALUES ('1723693534410821633', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-11-12 21:25:38', '2023-11-12 21:25:38', '/room/pageBackend', 'GET', 1, NULL, 22);
INSERT INTO `system_operation_log` VALUES ('1723694186532818946', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-11-12 21:28:13', '2023-11-12 21:28:13', '/product/page', 'GET', 1, NULL, 66);
INSERT INTO `system_operation_log` VALUES ('1723694195940642817', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2023-11-12 21:28:16', '2023-11-12 21:28:16', '/product/list', 'GET', 1, NULL, 6);
INSERT INTO `system_operation_log` VALUES ('1723694196188106753', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-11-12 21:28:16', '2023-11-12 21:28:16', '/frameware/page', 'GET', 1, NULL, 60);
INSERT INTO `system_operation_log` VALUES ('1723694200181084162', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-12 21:28:17', '2023-11-12 21:28:17', '/floor/floorList', 'GET', 1, NULL, 1);
INSERT INTO `system_operation_log` VALUES ('1723694228547162113', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2023-11-12 21:28:17', '2023-11-12 21:28:17', '/product/list', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1723694237988540417', '1', '分页查询', '0:0:0:0:0:0:0:1', '2023-11-12 21:28:17', '2023-11-12 21:28:17', '/device/page', 'GET', 1, NULL, 125);
INSERT INTO `system_operation_log` VALUES ('1723694238181478402', '1', '根据楼层id查询房间列表', '0:0:0:0:0:0:0:1', '2023-11-12 21:28:20', '2023-11-12 21:28:20', '/room/roomListByFloorId', 'GET', 1, NULL, 10);
INSERT INTO `system_operation_log` VALUES ('1723694313435680769', '1', '添加或修改设备', '0:0:0:0:0:0:0:1', '2023-11-12 21:28:44', '2023-11-12 21:28:44', '/device/addUpdate', 'POST', 1, NULL, 13);
INSERT INTO `system_operation_log` VALUES ('1723694313695727617', '1', '分页查询', '0:0:0:0:0:0:0:1', '2023-11-12 21:28:44', '2023-11-12 21:28:44', '/device/page', 'GET', 1, NULL, 33);
INSERT INTO `system_operation_log` VALUES ('1727333692720898049', NULL, '登录', '0:0:0:0:0:0:0:1', '2023-11-22 22:30:19', '2023-11-22 22:30:19', '/user/login', 'POST', 1, NULL, 1071);
INSERT INTO `system_operation_log` VALUES ('1727333693043859458', '1', '查询个人信息', '0:0:0:0:0:0:0:1', '2023-11-22 22:30:19', '2023-11-22 22:30:19', '/user/info', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1727333693169688578', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-11-22 22:30:19', '2023-11-22 22:30:19', '/permission/getPerm', 'GET', 1, NULL, 37);
INSERT INTO `system_operation_log` VALUES ('1727333694558003201', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2023-11-22 22:30:20', '2023-11-22 22:30:20', '/dashboard/dashboardInfo', 'GET', 1, NULL, 34);
INSERT INTO `system_operation_log` VALUES ('1727333734768795649', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-22 22:30:20', '2023-11-22 22:30:20', '/floor/floorList', 'GET', 1, NULL, 49);
INSERT INTO `system_operation_log` VALUES ('1727333735095951362', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-22 22:30:27', '2023-11-22 22:30:27', '/family/page', 'GET', 1, NULL, 164);
INSERT INTO `system_operation_log` VALUES ('1727334404330708994', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-11-22 22:33:09', '2023-11-22 22:33:09', '/permission/getPerm', 'GET', 1, NULL, 8);
INSERT INTO `system_operation_log` VALUES ('1727334420575248385', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-11-22 22:33:13', '2023-11-22 22:33:13', '/floor/pageBackend', 'GET', 1, NULL, 34);
INSERT INTO `system_operation_log` VALUES ('1727334726038020098', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-11-22 22:34:26', '2023-11-22 22:34:26', '/family/list', 'GET', 1, NULL, 7);
INSERT INTO `system_operation_log` VALUES ('1727334726100934657', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-11-22 22:34:26', '2023-11-22 22:34:26', '/floor/pageBackend', 'GET', 1, NULL, 22);
INSERT INTO `system_operation_log` VALUES ('1727334736179847170', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-22 22:34:28', '2023-11-22 22:34:28', '/family/page', 'GET', 1, NULL, 19);
INSERT INTO `system_operation_log` VALUES ('1727335204503248898', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-11-22 22:36:20', '2023-11-22 22:36:20', '/family/list', 'GET', 1, NULL, 6);
INSERT INTO `system_operation_log` VALUES ('1727335204637466625', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-11-22 22:36:20', '2023-11-22 22:36:20', '/floor/pageBackend', 'GET', 1, NULL, 21);
INSERT INTO `system_operation_log` VALUES ('1727335238938484738', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-22 22:36:28', '2023-11-22 22:36:28', '/floor/floorList', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1727335238938484739', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-11-22 22:36:28', '2023-11-22 22:36:28', '/family/list', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1727335246588895234', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-11-22 22:36:28', '2023-11-22 22:36:28', '/room/pageBackend', 'GET', 1, NULL, 41);
INSERT INTO `system_operation_log` VALUES ('1727335307402108929', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-11-22 22:36:44', '2023-11-22 22:36:44', '/product/page', 'GET', 1, NULL, 39);
INSERT INTO `system_operation_log` VALUES ('1727335461291122690', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2023-11-22 22:37:21', '2023-11-22 22:37:21', '/product/list', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1727335461416951810', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-11-22 22:37:21', '2023-11-22 22:37:21', '/frameware/page', 'GET', 1, NULL, 33);
INSERT INTO `system_operation_log` VALUES ('1727335470388568065', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-22 22:37:23', '2023-11-22 22:37:23', '/family/page', 'GET', 1, NULL, 18);
INSERT INTO `system_operation_log` VALUES ('1727337147489411074', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-11-22 22:44:03', '2023-11-22 22:44:03', '/product/page', 'GET', 1, NULL, 20);
INSERT INTO `system_operation_log` VALUES ('1727337283791708162', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2023-11-22 22:44:35', '2023-11-22 22:44:35', '/product/list', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1727337283863011330', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-11-22 22:44:36', '2023-11-22 22:44:36', '/frameware/page', 'GET', 1, NULL, 13);
INSERT INTO `system_operation_log` VALUES ('1727337449819037698', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-22 22:45:15', '2023-11-22 22:45:15', '/floor/floorList', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1727337449819037699', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2023-11-22 22:45:15', '2023-11-22 22:45:15', '/product/list', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1727337450083278850', '1', '分页查询', '0:0:0:0:0:0:0:1', '2023-11-22 22:45:15', '2023-11-22 22:45:15', '/device/page', 'GET', 1, NULL, 56);
INSERT INTO `system_operation_log` VALUES ('1728370100748218369', NULL, '登录', '0:0:0:0:0:0:0:1', '2023-11-25 19:08:38', '2023-11-25 19:08:38', '/user/login', 'POST', 1, NULL, 889);
INSERT INTO `system_operation_log` VALUES ('1728370101096345602', '1', '查询个人信息', '0:0:0:0:0:0:0:1', '2023-11-25 19:08:38', '2023-11-25 19:08:38', '/user/info', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1728370101285089281', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-11-25 19:08:38', '2023-11-25 19:08:38', '/permission/getPerm', 'GET', 1, NULL, 41);
INSERT INTO `system_operation_log` VALUES ('1728370102476271617', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2023-11-25 19:08:39', '2023-11-25 19:08:39', '/dashboard/dashboardInfo', 'GET', 1, NULL, 40);
INSERT INTO `system_operation_log` VALUES ('1728370142842253313', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-25 19:08:39', '2023-11-25 19:08:39', '/floor/floorList', 'GET', 1, NULL, 53);
INSERT INTO `system_operation_log` VALUES ('1728370160479301633', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-25 19:08:52', '2023-11-25 19:08:52', '/family/page', 'GET', 1, NULL, 104);
INSERT INTO `system_operation_log` VALUES ('1728370259112554497', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-25 19:09:16', '2023-11-25 19:09:16', '/family/page', 'GET', 1, NULL, 19);
INSERT INTO `system_operation_log` VALUES ('1728370265013940225', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-25 19:09:17', '2023-11-25 19:09:17', '/family/page', 'GET', 1, NULL, 33);
INSERT INTO `system_operation_log` VALUES ('1728370269149523970', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-25 19:09:18', '2023-11-25 19:09:18', '/family/page', 'GET', 1, NULL, 16);
INSERT INTO `system_operation_log` VALUES ('1728370273079586817', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-25 19:09:19', '2023-11-25 19:09:19', '/family/page', 'GET', 1, NULL, 18);
INSERT INTO `system_operation_log` VALUES ('1728370302297108482', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-11-25 19:09:26', '2023-11-25 19:09:26', '/family/list', 'GET', 1, NULL, 6);
INSERT INTO `system_operation_log` VALUES ('1728370307007311874', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-11-25 19:09:26', '2023-11-25 19:09:26', '/floor/pageBackend', 'GET', 1, NULL, 23);
INSERT INTO `system_operation_log` VALUES ('1728370319023992834', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-11-25 19:09:30', '2023-11-25 19:09:30', '/floor/pageBackend', 'GET', 1, NULL, 25);
INSERT INTO `system_operation_log` VALUES ('1728370469494648833', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-25 19:10:06', '2023-11-25 19:10:06', '/family/page', 'GET', 1, NULL, 28);
INSERT INTO `system_operation_log` VALUES ('1728370490319368193', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-25 19:10:11', '2023-11-25 19:10:11', '/family/page', 'GET', 1, NULL, 28);
INSERT INTO `system_operation_log` VALUES ('1728370511131504642', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-25 19:10:16', '2023-11-25 19:10:16', '/family/page', 'GET', 1, NULL, 17);
INSERT INTO `system_operation_log` VALUES ('1728370760650649602', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-11-25 19:11:16', '2023-11-25 19:11:16', '/permission/getPerm', 'GET', 1, NULL, 7);
INSERT INTO `system_operation_log` VALUES ('1728370761355292674', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-25 19:11:16', '2023-11-25 19:11:16', '/family/page', 'GET', 1, NULL, 32);
INSERT INTO `system_operation_log` VALUES ('1728371556838600706', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-11-25 19:14:25', '2023-11-25 19:14:25', '/family/list', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1728371556905709569', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-11-25 19:14:25', '2023-11-25 19:14:25', '/floor/pageBackend', 'GET', 1, NULL, 19);
INSERT INTO `system_operation_log` VALUES ('1728371561678827521', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-25 19:14:27', '2023-11-25 19:14:27', '/family/page', 'GET', 1, NULL, 18);
INSERT INTO `system_operation_log` VALUES ('1728372715217285122', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-25 19:19:02', '2023-11-25 19:19:02', '/family/page', 'GET', 1, NULL, 17);
INSERT INTO `system_operation_log` VALUES ('1728373279015628802', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-11-25 19:21:16', '2023-11-25 19:21:16', '/family/list', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1728373279082737666', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-11-25 19:21:16', '2023-11-25 19:21:16', '/floor/pageBackend', 'GET', 1, NULL, 20);
INSERT INTO `system_operation_log` VALUES ('1728373482204491778', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-11-25 19:22:04', '2023-11-25 19:22:04', '/family/list', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1728373482271600642', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-11-25 19:22:04', '2023-11-25 19:22:04', '/floor/pageBackend', 'GET', 1, NULL, 20);
INSERT INTO `system_operation_log` VALUES ('1728374628457443329', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-25 19:26:38', '2023-11-25 19:26:38', '/family/page', 'GET', 1, NULL, 17);
INSERT INTO `system_operation_log` VALUES ('1728375132533092353', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-25 19:28:38', '2023-11-25 19:28:38', '/family/page', 'GET', 1, NULL, 18);
INSERT INTO `system_operation_log` VALUES ('1728375132730224642', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-25 19:28:38', '2023-11-25 19:28:38', '/family/page', 'GET', 1, NULL, 17);
INSERT INTO `system_operation_log` VALUES ('1728375186018856961', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-11-25 19:28:51', '2023-11-25 19:28:51', '/permission/getPerm', 'GET', 1, NULL, 8);
INSERT INTO `system_operation_log` VALUES ('1728375186815774722', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-25 19:28:51', '2023-11-25 19:28:51', '/family/page', 'GET', 1, NULL, 20);
INSERT INTO `system_operation_log` VALUES ('1728433931386155009', NULL, '登录', '0:0:0:0:0:0:0:1', '2023-11-25 23:22:17', '2023-11-25 23:22:17', '/user/login', 'POST', 1, NULL, 94);
INSERT INTO `system_operation_log` VALUES ('1728433931465846786', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-11-25 23:22:17', '2023-11-25 23:22:17', '/permission/getPerm', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1728433931465846787', '1', '查询个人信息', '0:0:0:0:0:0:0:1', '2023-11-25 23:22:17', '2023-11-25 23:22:17', '/user/info', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1728433932636057601', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-25 23:22:17', '2023-11-25 23:22:17', '/floor/floorList', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1728433973413081090', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2023-11-25 23:22:17', '2023-11-25 23:22:17', '/dashboard/dashboardInfo', 'GET', 1, NULL, 13);
INSERT INTO `system_operation_log` VALUES ('1728434161045270529', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-25 23:23:11', '2023-11-25 23:23:11', '/family/page', 'GET', 1, NULL, 16);
INSERT INTO `system_operation_log` VALUES ('1728434180133548034', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-11-25 23:23:16', '2023-11-25 23:23:16', '/family/list', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1728434180221628417', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-11-25 23:23:16', '2023-11-25 23:23:16', '/floor/pageBackend', 'GET', 1, NULL, 19);
INSERT INTO `system_operation_log` VALUES ('1728434198357798914', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-11-25 23:23:20', '2023-11-25 23:23:20', '/floor/pageBackend', 'GET', 1, NULL, 15);
INSERT INTO `system_operation_log` VALUES ('1728434207660765185', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-11-25 23:23:23', '2023-11-25 23:23:23', '/floor/pageBackend', 'GET', 1, NULL, 15);
INSERT INTO `system_operation_log` VALUES ('1728434222139502594', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-11-25 23:23:24', '2023-11-25 23:23:24', '/floor/pageBackend', 'GET', 1, NULL, 17);
INSERT INTO `system_operation_log` VALUES ('1728434265617657857', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-11-25 23:23:36', '2023-11-25 23:23:36', '/floor/pageBackend', 'GET', 1, NULL, 17);
INSERT INTO `system_operation_log` VALUES ('1728434276216664065', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-11-25 23:23:39', '2023-11-25 23:23:39', '/floor/pageBackend', 'GET', 1, NULL, 15);
INSERT INTO `system_operation_log` VALUES ('1728434723459493890', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-25 23:25:25', '2023-11-25 23:25:25', '/floor/floorList', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1728434723459493891', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-11-25 23:25:26', '2023-11-25 23:25:26', '/family/list', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1728434723652431873', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-11-25 23:25:26', '2023-11-25 23:25:26', '/room/pageBackend', 'GET', 1, NULL, 39);
INSERT INTO `system_operation_log` VALUES ('1728434730845663233', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-11-25 23:25:27', '2023-11-25 23:25:27', '/family/list', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1728434765486419970', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-11-25 23:25:27', '2023-11-25 23:25:27', '/floor/pageBackend', 'GET', 1, NULL, 20);
INSERT INTO `system_operation_log` VALUES ('1728434765486419971', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-25 23:25:29', '2023-11-25 23:25:29', '/floor/floorList', 'GET', 1, NULL, 1);
INSERT INTO `system_operation_log` VALUES ('1728434765687746561', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-11-25 23:25:29', '2023-11-25 23:25:29', '/family/list', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1728434772855812097', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-11-25 23:25:29', '2023-11-25 23:25:29', '/room/pageBackend', 'GET', 1, NULL, 18);
INSERT INTO `system_operation_log` VALUES ('1728434807496568833', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-25 23:25:29', '2023-11-25 23:25:29', '/family/page', 'GET', 1, NULL, 15);
INSERT INTO `system_operation_log` VALUES ('1728435045460406273', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-25 23:26:42', '2023-11-25 23:26:42', '/family/page', 'GET', 1, NULL, 19);
INSERT INTO `system_operation_log` VALUES ('1728435964348526593', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-11-25 23:30:21', '2023-11-25 23:30:21', '/permission/getPerm', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1728435965137055746', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-25 23:30:22', '2023-11-25 23:30:22', '/family/page', 'GET', 1, NULL, 21);
INSERT INTO `system_operation_log` VALUES ('1728436252228775937', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-25 23:31:30', '2023-11-25 23:31:30', '/family/page', 'GET', 1, NULL, 15);
INSERT INTO `system_operation_log` VALUES ('1728436299578273794', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-25 23:31:41', '2023-11-25 23:31:41', '/family/page', 'GET', 1, NULL, 15);
INSERT INTO `system_operation_log` VALUES ('1728436457179246593', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-11-25 23:32:19', '2023-11-25 23:32:19', '/family/list', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1728436457242161153', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-11-25 23:32:19', '2023-11-25 23:32:19', '/floor/pageBackend', 'GET', 1, NULL, 18);
INSERT INTO `system_operation_log` VALUES ('1728436460840873986', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-25 23:32:20', '2023-11-25 23:32:20', '/floor/floorList', 'GET', 1, NULL, 1);
INSERT INTO `system_operation_log` VALUES ('1728436460840873987', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-11-25 23:32:20', '2023-11-25 23:32:20', '/family/list', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1728436499201978370', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-11-25 23:32:20', '2023-11-25 23:32:20', '/room/pageBackend', 'GET', 1, NULL, 19);
INSERT INTO `system_operation_log` VALUES ('1728436499264892929', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-11-25 23:32:22', '2023-11-25 23:32:22', '/product/page', 'GET', 1, NULL, 40);
INSERT INTO `system_operation_log` VALUES ('1728436502863605762', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2023-11-25 23:32:27', '2023-11-25 23:32:27', '/product/list', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1728436502863605763', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-25 23:32:27', '2023-11-25 23:32:27', '/floor/floorList', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1728436541186961409', '1', '分页查询', '0:0:0:0:0:0:0:1', '2023-11-25 23:32:27', '2023-11-25 23:32:27', '/device/page', 'GET', 1, NULL, 52);
INSERT INTO `system_operation_log` VALUES ('1728436550032748545', '1', '查询调试所有设备', '0:0:0:0:0:0:0:1', '2023-11-25 23:32:41', '2023-11-25 23:32:41', '/device/debugDeviceList', 'GET', 1, NULL, 2);
INSERT INTO `system_operation_log` VALUES ('1728436557918040065', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2023-11-25 23:32:43', '2023-11-25 23:32:43', '/product/list', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1728436558052257793', NULL, '', '0:0:0:0:0:0:0:1', '2023-11-25 23:32:43', '2023-11-25 23:32:43', '/error', 'GET', 0, '系统错误请联系管理员', 7);
INSERT INTO `system_operation_log` VALUES ('1728769236252323841', NULL, '登录', '0:0:0:0:0:0:0:1', '2023-11-26 21:34:39', '2023-11-26 21:34:39', '/user/login', 'POST', 1, NULL, 824);
INSERT INTO `system_operation_log` VALUES ('1728769236474621954', '1', '查询个人信息', '0:0:0:0:0:0:0:1', '2023-11-26 21:34:40', '2023-11-26 21:34:40', '/user/info', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1728769236667559937', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-11-26 21:34:40', '2023-11-26 21:34:40', '/permission/getPerm', 'GET', 1, NULL, 49);
INSERT INTO `system_operation_log` VALUES ('1728769238022320129', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2023-11-26 21:34:40', '2023-11-26 21:34:40', '/dashboard/dashboardInfo', 'GET', 1, NULL, 36);
INSERT INTO `system_operation_log` VALUES ('1728769278275055617', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-26 21:34:40', '2023-11-26 21:34:40', '/floor/floorList', 'GET', 1, NULL, 38);
INSERT INTO `system_operation_log` VALUES ('1728769278535102466', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-26 21:34:42', '2023-11-26 21:34:42', '/family/page', 'GET', 1, NULL, 102);
INSERT INTO `system_operation_log` VALUES ('1728769278728040450', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-26 21:34:43', '2023-11-26 21:34:43', '/floor/floorList', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1728769280028274690', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-11-26 21:34:43', '2023-11-26 21:34:43', '/family/list', 'GET', 1, NULL, 13);
INSERT INTO `system_operation_log` VALUES ('1728769320301981697', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2023-11-26 21:34:48', '2023-11-26 21:34:48', '/product/list', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1728769320562028545', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-11-26 21:34:50', '2023-11-26 21:34:50', '/product/page', 'GET', 1, NULL, 22);
INSERT INTO `system_operation_log` VALUES ('1728769393333202945', '1', '分页', '0:0:0:0:0:0:0:1', '2023-11-26 21:35:17', '2023-11-26 21:35:17', '/family/page', 'GET', 1, NULL, 19);
INSERT INTO `system_operation_log` VALUES ('1728770589330599937', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-11-26 21:40:02', '2023-11-26 21:40:02', '/product/page', 'GET', 1, NULL, 20);
INSERT INTO `system_operation_log` VALUES ('1728771113773789185', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-11-26 21:42:07', '2023-11-26 21:42:07', '/product/page', 'GET', 1, NULL, 33);
INSERT INTO `system_operation_log` VALUES ('1728771694827499521', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-11-26 21:44:26', '2023-11-26 21:44:26', '/product/page', 'GET', 1, NULL, 22);
INSERT INTO `system_operation_log` VALUES ('1728772428482572290', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-11-26 21:47:21', '2023-11-26 21:47:21', '/product/page', 'GET', 1, NULL, 21);
INSERT INTO `system_operation_log` VALUES ('1728772777708711938', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-11-26 21:48:44', '2023-11-26 21:48:44', '/permission/getPerm', 'GET', 1, NULL, 8);
INSERT INTO `system_operation_log` VALUES ('1728772779608731649', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-11-26 21:48:44', '2023-11-26 21:48:44', '/product/page', 'GET', 1, NULL, 28);
INSERT INTO `system_operation_log` VALUES ('1728772858805579777', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-11-26 21:49:03', '2023-11-26 21:49:03', '/permission/getPerm', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1728772860240031745', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-11-26 21:49:04', '2023-11-26 21:49:04', '/product/page', 'GET', 1, NULL, 26);
INSERT INTO `system_operation_log` VALUES ('1728773461673865217', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-11-26 21:51:27', '2023-11-26 21:51:27', '/product/page', 'GET', 1, NULL, 19);
INSERT INTO `system_operation_log` VALUES ('1728773963144851457', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-11-26 21:53:27', '2023-11-26 21:53:27', '/permission/getPerm', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1728773964872904706', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-11-26 21:53:27', '2023-11-26 21:53:27', '/product/page', 'GET', 1, NULL, 26);
INSERT INTO `system_operation_log` VALUES ('1728775060857122817', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-11-26 21:57:48', '2023-11-26 21:57:48', '/product/page', 'GET', 1, NULL, 25);
INSERT INTO `system_operation_log` VALUES ('1728775260006871042', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-11-26 21:58:36', '2023-11-26 21:58:36', '/product/page', 'GET', 1, NULL, 19);
INSERT INTO `system_operation_log` VALUES ('1728775663469555713', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-11-26 22:00:12', '2023-11-26 22:00:12', '/product/page', 'GET', 1, NULL, 21);
INSERT INTO `system_operation_log` VALUES ('1728776838570930178', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-11-26 22:04:52', '2023-11-26 22:04:52', '/product/page', 'GET', 1, NULL, 20);
INSERT INTO `system_operation_log` VALUES ('1728781508328648706', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-11-26 22:23:25', '2023-11-26 22:23:25', '/product/page', 'GET', 1, NULL, 28);
INSERT INTO `system_operation_log` VALUES ('1728782494115917826', NULL, '新增或修改产品', '0:0:0:0:0:0:0:1', '2023-11-26 22:27:20', '2023-11-26 22:27:20', '/product/addUpdate', 'POST', 1, NULL, 55);
INSERT INTO `system_operation_log` VALUES ('1728782494317244418', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-11-26 22:27:21', '2023-11-26 22:27:21', '/product/page', 'GET', 1, NULL, 28);
INSERT INTO `system_operation_log` VALUES ('1728782548398600194', NULL, '新增或修改产品', '0:0:0:0:0:0:0:1', '2023-11-26 22:27:33', '2023-11-26 22:27:33', '/product/addUpdate', 'POST', 1, NULL, 13);
INSERT INTO `system_operation_log` VALUES ('1728782548578955265', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-11-26 22:27:33', '2023-11-26 22:27:33', '/product/page', 'GET', 1, NULL, 23);
INSERT INTO `system_operation_log` VALUES ('1728783706789855233', NULL, '新增或修改产品', '0:0:0:0:0:0:0:1', '2023-11-26 22:32:10', '2023-11-26 22:32:10', '/product/addUpdate', 'POST', 1, NULL, 9751);
INSERT INTO `system_operation_log` VALUES ('1728783732970700802', NULL, '新增或修改产品', '0:0:0:0:0:0:0:1', '2023-11-26 22:32:16', '2023-11-26 22:32:16', '/product/addUpdate', 'POST', 0, '同名产品已存在，不能继续新增', 6);
INSERT INTO `system_operation_log` VALUES ('1728783780345364482', NULL, '新增或修改产品', '0:0:0:0:0:0:0:1', '2023-11-26 22:32:27', '2023-11-26 22:32:27', '/product/addUpdate', 'POST', 0, '同名产品已存在，不能继续新增', 9);
INSERT INTO `system_operation_log` VALUES ('1728784044192251907', NULL, '新增或修改产品', '0:0:0:0:0:0:0:1', '2023-11-26 22:33:30', '2023-11-26 22:33:30', '/product/addUpdate', 'POST', 1, NULL, 17);
INSERT INTO `system_operation_log` VALUES ('1728784044850757633', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-11-26 22:33:30', '2023-11-26 22:33:30', '/product/page', 'GET', 1, NULL, 130);
INSERT INTO `system_operation_log` VALUES ('1728784692157693953', NULL, '新增或修改产品', '0:0:0:0:0:0:0:1', '2023-11-26 22:36:05', '2023-11-26 22:36:05', '/product/addUpdate', 'POST', 1, NULL, 98);
INSERT INTO `system_operation_log` VALUES ('1728784692560347138', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-11-26 22:36:05', '2023-11-26 22:36:05', '/product/page', 'GET', 1, NULL, 45);
INSERT INTO `system_operation_log` VALUES ('1728784762458423297', NULL, '新增或修改产品', '0:0:0:0:0:0:0:1', '2023-11-26 22:36:21', '2023-11-26 22:36:21', '/product/addUpdate', 'POST', 0, '同名产品已存在', 19);
INSERT INTO `system_operation_log` VALUES ('1728785231704571906', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2023-11-26 22:38:13', '2023-11-26 22:38:13', '/product/list', 'GET', 1, NULL, 10);
INSERT INTO `system_operation_log` VALUES ('1728785232098836481', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-11-26 22:38:13', '2023-11-26 22:38:13', '/frameware/page', 'GET', 1, NULL, 59);
INSERT INTO `system_operation_log` VALUES ('1728785238709059585', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-11-26 22:38:15', '2023-11-26 22:38:15', '/product/page', 'GET', 1, NULL, 55);
INSERT INTO `system_operation_log` VALUES ('1728785265984618497', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2023-11-26 22:38:21', '2023-11-26 22:38:21', '/product/list', 'GET', 1, NULL, 15);
INSERT INTO `system_operation_log` VALUES ('1728785273823772674', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-11-26 22:38:21', '2023-11-26 22:38:21', '/frameware/page', 'GET', 1, NULL, 33);
INSERT INTO `system_operation_log` VALUES ('1728785274079625217', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2023-11-26 22:38:23', '2023-11-26 22:38:23', '/product/list', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1728785291360157697', NULL, '登录', '0:0:0:0:0:0:0:1', '2023-11-26 22:38:27', '2023-11-26 22:38:27', '/user/login', 'POST', 1, NULL, 145);
INSERT INTO `system_operation_log` VALUES ('1728785308040904705', '1', '查询个人信息', '0:0:0:0:0:0:0:1', '2023-11-26 22:38:27', '2023-11-26 22:38:27', '/user/info', 'GET', 1, NULL, 8);
INSERT INTO `system_operation_log` VALUES ('1728785315846504449', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-11-26 22:38:27', '2023-11-26 22:38:27', '/permission/getPerm', 'GET', 1, NULL, 62);
INSERT INTO `system_operation_log` VALUES ('1728785316102356994', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2023-11-26 22:38:28', '2023-11-26 22:38:28', '/dashboard/dashboardInfo', 'GET', 1, NULL, 55);
INSERT INTO `system_operation_log` VALUES ('1728785333370306561', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-11-26 22:38:28', '2023-11-26 22:38:28', '/floor/floorList', 'GET', 1, NULL, 62);
INSERT INTO `system_operation_log` VALUES ('1728785350063636481', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-11-26 22:38:30', '2023-11-26 22:38:30', '/product/page', 'GET', 1, NULL, 32);
INSERT INTO `system_operation_log` VALUES ('1728785357873430530', '1', '分页查询', '0:0:0:0:0:0:0:1', '2023-11-26 22:38:32', '2023-11-26 22:38:32', '/device/page', 'GET', 1, NULL, 100);
INSERT INTO `system_operation_log` VALUES ('1730919629241569282', NULL, '登录', '0:0:0:0:0:0:0:1', '2023-12-02 19:59:33', '2023-12-02 19:59:33', '/user/login', 'POST', 1, NULL, 867);
INSERT INTO `system_operation_log` VALUES ('1730919629535170562', '1', '查询个人信息', '0:0:0:0:0:0:0:1', '2023-12-02 19:59:33', '2023-12-02 19:59:33', '/user/info', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1730919629669388290', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-12-02 19:59:33', '2023-12-02 19:59:33', '/permission/getPerm', 'GET', 1, NULL, 38);
INSERT INTO `system_operation_log` VALUES ('1730919631112228866', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2023-12-02 19:59:34', '2023-12-02 19:59:34', '/dashboard/dashboardInfo', 'GET', 1, NULL, 35);
INSERT INTO `system_operation_log` VALUES ('1730919671264301058', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-12-02 19:59:34', '2023-12-02 19:59:34', '/floor/floorList', 'GET', 1, NULL, 44);
INSERT INTO `system_operation_log` VALUES ('1730919671587262466', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-12-02 19:59:36', '2023-12-02 19:59:36', '/product/page', 'GET', 1, NULL, 118);
INSERT INTO `system_operation_log` VALUES ('1730919690105114625', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2023-12-02 19:59:48', '2023-12-02 19:59:48', '/product/list', 'GET', 1, NULL, 8);
INSERT INTO `system_operation_log` VALUES ('1730919690214166529', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-12-02 19:59:48', '2023-12-02 19:59:48', '/frameware/page', 'GET', 1, NULL, 42);
INSERT INTO `system_operation_log` VALUES ('1730921216970182658', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2023-12-02 20:05:52', '2023-12-02 20:05:52', '/product/list', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1730921216970182659', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-12-02 20:05:52', '2023-12-02 20:05:52', '/frameware/page', 'GET', 1, NULL, 10);
INSERT INTO `system_operation_log` VALUES ('1730929359678722050', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2023-12-02 20:38:13', '2023-12-02 20:38:13', '/product/list', 'GET', 1, NULL, 9);
INSERT INTO `system_operation_log` VALUES ('1730929359745830914', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-12-02 20:38:13', '2023-12-02 20:38:13', '/frameware/page', 'GET', 1, NULL, 21);
INSERT INTO `system_operation_log` VALUES ('1730929388778803201', '1', '上传文件', '0:0:0:0:0:0:0:1', '2023-12-02 20:38:20', '2023-12-02 20:38:20', '/file/uploadFile', 'POST', 1, NULL, 23);
INSERT INTO `system_operation_log` VALUES ('1730929412879273986', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2023-12-02 20:38:26', '2023-12-02 20:38:26', '/product/list', 'GET', 1, NULL, 18);
INSERT INTO `system_operation_log` VALUES ('1730929412937994241', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-12-02 20:38:26', '2023-12-02 20:38:26', '/frameware/page', 'GET', 1, NULL, 27);
INSERT INTO `system_operation_log` VALUES ('1730932680955121665', '1', '上传文件', '0:0:0:0:0:0:0:1', '2023-12-02 20:51:25', '2023-12-02 20:51:25', '/file/uploadFile', 'POST', 1, NULL, 13);
INSERT INTO `system_operation_log` VALUES ('1730932692925665281', NULL, '添加固件', '0:0:0:0:0:0:0:1', '2023-12-02 20:51:28', '2023-12-02 20:51:28', '/frameware/add', 'POST', 1, NULL, 36);
INSERT INTO `system_operation_log` VALUES ('1730932693059883009', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-12-02 20:51:28', '2023-12-02 20:51:28', '/frameware/page', 'GET', 1, NULL, 18);
INSERT INTO `system_operation_log` VALUES ('1730932775645728769', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-12-02 20:51:48', '2023-12-02 20:51:48', '/floor/floorList', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1730932775645728770', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2023-12-02 20:51:48', '2023-12-02 20:51:48', '/product/list', 'GET', 1, NULL, 6);
INSERT INTO `system_operation_log` VALUES ('1730932776039993345', '1', '分页查询', '0:0:0:0:0:0:0:1', '2023-12-02 20:51:48', '2023-12-02 20:51:48', '/device/page', 'GET', 1, NULL, 71);
INSERT INTO `system_operation_log` VALUES ('1730933002754707457', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-12-02 20:52:42', '2023-12-02 20:52:42', '/floor/floorList', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1730933002838593538', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2023-12-02 20:52:42', '2023-12-02 20:52:42', '/product/list', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1730933002960228354', '1', '分页查询', '0:0:0:0:0:0:0:1', '2023-12-02 20:52:42', '2023-12-02 20:52:42', '/device/page', 'GET', 1, NULL, 28);
INSERT INTO `system_operation_log` VALUES ('1730933202357440514', '1', '分页查询', '0:0:0:0:0:0:0:1', '2023-12-02 20:53:29', '2023-12-02 20:53:29', '/device/page', 'GET', 1, NULL, 27);
INSERT INTO `system_operation_log` VALUES ('1730933212037894145', '1', '分页查询', '0:0:0:0:0:0:0:1', '2023-12-02 20:53:32', '2023-12-02 20:53:32', '/device/page', 'GET', 1, NULL, 21);
INSERT INTO `system_operation_log` VALUES ('1730933218878803969', '1', '分页查询', '0:0:0:0:0:0:0:1', '2023-12-02 20:53:33', '2023-12-02 20:53:33', '/device/page', 'GET', 1, NULL, 22);
INSERT INTO `system_operation_log` VALUES ('1730933227061891073', '1', '分页查询', '0:0:0:0:0:0:0:1', '2023-12-02 20:53:35', '2023-12-02 20:53:35', '/device/page', 'GET', 1, NULL, 17);
INSERT INTO `system_operation_log` VALUES ('1730933244422115329', '1', '分页查询', '0:0:0:0:0:0:0:1', '2023-12-02 20:53:37', '2023-12-02 20:53:37', '/device/page', 'GET', 1, NULL, 23);
INSERT INTO `system_operation_log` VALUES ('1730933351687245825', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-12-02 20:54:05', '2023-12-02 20:54:05', '/floor/floorList', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1730933351687245826', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2023-12-02 20:54:05', '2023-12-02 20:54:05', '/product/list', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1730933351917932545', '1', '分页查询', '0:0:0:0:0:0:0:1', '2023-12-02 20:54:05', '2023-12-02 20:54:05', '/device/page', 'GET', 1, NULL, 54);
INSERT INTO `system_operation_log` VALUES ('1730933511343427586', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-12-02 20:54:43', '2023-12-02 20:54:43', '/product/page', 'GET', 1, NULL, 30);
INSERT INTO `system_operation_log` VALUES ('1730933518016565250', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2023-12-02 20:54:45', '2023-12-02 20:54:45', '/product/list', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1730933518125617153', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-12-02 20:54:45', '2023-12-02 20:54:45', '/frameware/page', 'GET', 1, NULL, 20);
INSERT INTO `system_operation_log` VALUES ('1730933528720429057', '1', '分页', '0:0:0:0:0:0:0:1', '2023-12-02 20:54:47', '2023-12-02 20:54:47', '/family/page', 'GET', 1, NULL, 42);
INSERT INTO `system_operation_log` VALUES ('1730933553349382145', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-02 20:54:48', '2023-12-02 20:54:48', '/family/list', 'GET', 1, NULL, 8);
INSERT INTO `system_operation_log` VALUES ('1730933560056074241', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-02 20:54:48', '2023-12-02 20:54:48', '/floor/pageBackend', 'GET', 1, NULL, 26);
INSERT INTO `system_operation_log` VALUES ('1730933953293045762', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-12-02 20:56:28', '2023-12-02 20:56:28', '/product/page', 'GET', 1, NULL, 29);
INSERT INTO `system_operation_log` VALUES ('1730933965532024833', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-02 20:56:31', '2023-12-02 20:56:31', '/family/list', 'GET', 1, NULL, 10);
INSERT INTO `system_operation_log` VALUES ('1730933965532024834', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-12-02 20:56:31', '2023-12-02 20:56:31', '/floor/floorList', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1730933965532024835', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2023-12-02 20:56:31', '2023-12-02 20:56:31', '/product/list', 'GET', 1, NULL, 7);
INSERT INTO `system_operation_log` VALUES ('1730933995303194626', '1', '分页查询', '0:0:0:0:0:0:0:1', '2023-12-02 20:56:31', '2023-12-02 20:56:31', '/device/page', 'GET', 1, NULL, 27);
INSERT INTO `system_operation_log` VALUES ('1730935186699440130', '1', '分页', '0:0:0:0:0:0:0:1', '2023-12-02 21:01:22', '2023-12-02 21:01:22', '/family/page', 'GET', 1, NULL, 57);
INSERT INTO `system_operation_log` VALUES ('1730935191002796034', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-12-02 21:01:23', '2023-12-02 21:01:23', '/product/page', 'GET', 1, NULL, 53);
INSERT INTO `system_operation_log` VALUES ('1730935210258845698', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2023-12-02 21:01:28', '2023-12-02 21:01:28', '/product/list', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1730935210388869122', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-12-02 21:01:28', '2023-12-02 21:01:28', '/frameware/page', 'GET', 1, NULL, 31);
INSERT INTO `system_operation_log` VALUES ('1730935228663451650', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-02 21:01:29', '2023-12-02 21:01:29', '/family/list', 'GET', 1, NULL, 10);
INSERT INTO `system_operation_log` VALUES ('1730935233063276545', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2023-12-02 21:01:29', '2023-12-02 21:01:29', '/product/list', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1730935252315131906', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-12-02 21:01:29', '2023-12-02 21:01:29', '/floor/floorList', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1730935252449349634', '1', '分页查询', '0:0:0:0:0:0:0:1', '2023-12-02 21:01:29', '2023-12-02 21:01:29', '/device/page', 'GET', 1, NULL, 215);
INSERT INTO `system_operation_log` VALUES ('1730935270719737857', '1', '分页查询', '0:0:0:0:0:0:0:1', '2023-12-02 21:01:32', '2023-12-02 21:01:32', '/device/page', 'GET', 1, NULL, 28);
INSERT INTO `system_operation_log` VALUES ('1730935862728970242', '1', '分页查询', '0:0:0:0:0:0:0:1', '2023-12-02 21:04:04', '2023-12-02 21:04:04', '/device/page', 'GET', 1, NULL, 99);
INSERT INTO `system_operation_log` VALUES ('1730935876356263938', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-12-02 21:04:07', '2023-12-02 21:04:07', '/permission/getPerm', 'GET', 1, NULL, 10);
INSERT INTO `system_operation_log` VALUES ('1730935878772183041', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-12-02 21:04:07', '2023-12-02 21:04:07', '/floor/floorList', 'GET', 1, NULL, 2);
INSERT INTO `system_operation_log` VALUES ('1730935878772183042', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-02 21:04:07', '2023-12-02 21:04:07', '/family/list', 'GET', 1, NULL, 11);
INSERT INTO `system_operation_log` VALUES ('1730935904755896322', '1', '分页查询', '0:0:0:0:0:0:0:1', '2023-12-02 21:04:07', '2023-12-02 21:04:07', '/device/page', 'GET', 1, NULL, 31);
INSERT INTO `system_operation_log` VALUES ('1730935918420938754', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2023-12-02 21:04:07', '2023-12-02 21:04:07', '/product/list', 'GET', 1, NULL, 10);
INSERT INTO `system_operation_log` VALUES ('1730935920824274945', '1', '分页查询', '0:0:0:0:0:0:0:1', '2023-12-02 21:04:12', '2023-12-02 21:04:12', '/device/page', 'GET', 1, NULL, 31);
INSERT INTO `system_operation_log` VALUES ('1730936037950119937', NULL, '登录', '0:0:0:0:0:0:0:1', '2023-12-02 21:04:45', '2023-12-02 21:04:45', '/user/login', 'POST', 1, NULL, 790);
INSERT INTO `system_operation_log` VALUES ('1730936037987868673', '1', '查询个人信息', '0:0:0:0:0:0:0:1', '2023-12-02 21:04:45', '2023-12-02 21:04:45', '/user/info', 'GET', 1, NULL, 9);
INSERT INTO `system_operation_log` VALUES ('1730936038105309185', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-12-02 21:04:45', '2023-12-02 21:04:45', '/permission/getPerm', 'GET', 1, NULL, 57);
INSERT INTO `system_operation_log` VALUES ('1730936039996940290', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2023-12-02 21:04:46', '2023-12-02 21:04:46', '/dashboard/dashboardInfo', 'GET', 1, NULL, 47);
INSERT INTO `system_operation_log` VALUES ('1730936080031571970', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-12-02 21:04:46', '2023-12-02 21:04:46', '/floor/floorList', 'GET', 1, NULL, 63);
INSERT INTO `system_operation_log` VALUES ('1730936080031571971', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-12-02 21:04:48', '2023-12-02 21:04:48', '/product/page', 'GET', 1, NULL, 113);
INSERT INTO `system_operation_log` VALUES ('1730936080094486530', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-02 21:04:49', '2023-12-02 21:04:49', '/family/list', 'GET', 1, NULL, 74);
INSERT INTO `system_operation_log` VALUES ('1730936082053226497', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-12-02 21:04:49', '2023-12-02 21:04:49', '/floor/floorList', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1730936122083663874', '1', '分页查询', '0:0:0:0:0:0:0:1', '2023-12-02 21:05:01', '2023-12-02 21:05:01', '/device/page', 'GET', 1, NULL, 20);
INSERT INTO `system_operation_log` VALUES ('1730936122083663875', '1', '分页查询', '0:0:0:0:0:0:0:1', '2023-12-02 21:04:53', '2023-12-02 21:04:53', '/device/page', 'GET', 1, NULL, 33);
INSERT INTO `system_operation_log` VALUES ('1730936122146578434', '1', '分页查询', '0:0:0:0:0:0:0:1', '2023-12-02 21:05:03', '2023-12-02 21:05:03', '/device/page', 'GET', 1, NULL, 24);
INSERT INTO `system_operation_log` VALUES ('1730936124046598146', '1', '分页查询', '0:0:0:0:0:0:0:1', '2023-12-02 21:05:06', '2023-12-02 21:05:06', '/device/page', 'GET', 1, NULL, 19);
INSERT INTO `system_operation_log` VALUES ('1730936265243648002', '1', '分页查询', '0:0:0:0:0:0:0:1', '2023-12-02 21:05:40', '2023-12-02 21:05:40', '/device/page', 'GET', 1, NULL, 25);
INSERT INTO `system_operation_log` VALUES ('1730936612733345793', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-02 21:07:02', '2023-12-02 21:07:02', '/family/list', 'GET', 1, NULL, 44);
INSERT INTO `system_operation_log` VALUES ('1730936613064695810', '1', '分页查询', '0:0:0:0:0:0:0:1', '2023-12-02 21:07:02', '2023-12-02 21:07:02', '/device/page', 'GET', 1, NULL, 30);
INSERT INTO `system_operation_log` VALUES ('1730936613064695811', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-12-02 21:07:02', '2023-12-02 21:07:02', '/floor/floorList', 'GET', 1, NULL, 1);
INSERT INTO `system_operation_log` VALUES ('1730936613064695812', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2023-12-02 21:07:02', '2023-12-02 21:07:02', '/product/list', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1730936903407001602', '1', '查询调试所有设备', '0:0:0:0:0:0:0:1', '2023-12-02 21:08:12', '2023-12-02 21:08:12', '/device/debugDeviceList', 'GET', 1, NULL, 6);
INSERT INTO `system_operation_log` VALUES ('1730936913112621057', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-02 21:08:14', '2023-12-02 21:08:14', '/family/list', 'GET', 1, NULL, 11);
INSERT INTO `system_operation_log` VALUES ('1730936913112621058', '1', '分页查询', '0:0:0:0:0:0:0:1', '2023-12-02 21:08:14', '2023-12-02 21:08:14', '/device/page', 'GET', 1, NULL, 30);
INSERT INTO `system_operation_log` VALUES ('1730936913297170434', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-12-02 21:08:14', '2023-12-02 21:08:14', '/floor/floorList', 'GET', 1, NULL, 1);
INSERT INTO `system_operation_log` VALUES ('1730936945438121985', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2023-12-02 21:08:14', '2023-12-02 21:08:14', '/product/list', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1730937569542168577', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2023-12-02 21:10:50', '2023-12-02 21:10:50', '/product/list', 'GET', 1, NULL, 20);
INSERT INTO `system_operation_log` VALUES ('1730937569542168578', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-02 21:10:51', '2023-12-02 21:10:51', '/family/list', 'GET', 1, NULL, 39);
INSERT INTO `system_operation_log` VALUES ('1730937569659609090', '1', '分页查询', '0:0:0:0:0:0:0:1', '2023-12-02 21:10:51', '2023-12-02 21:10:51', '/device/page', 'GET', 1, NULL, 61);
INSERT INTO `system_operation_log` VALUES ('1730937569995153410', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-12-02 21:10:51', '2023-12-02 21:10:51', '/floor/floorList', 'GET', 1, NULL, 139);
INSERT INTO `system_operation_log` VALUES ('1730937687767015425', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-12-02 21:11:19', '2023-12-02 21:11:19', '/permission/getPerm', 'GET', 1, NULL, 18);
INSERT INTO `system_operation_log` VALUES ('1730937689138552834', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-12-02 21:11:19', '2023-12-02 21:11:19', '/floor/floorList', 'GET', 1, NULL, 1);
INSERT INTO `system_operation_log` VALUES ('1730937689138552835', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-02 21:11:19', '2023-12-02 21:11:19', '/family/list', 'GET', 1, NULL, 25);
INSERT INTO `system_operation_log` VALUES ('1730937689797058562', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2023-12-02 21:11:19', '2023-12-02 21:11:19', '/product/list', 'GET', 1, NULL, 31);
INSERT INTO `system_operation_log` VALUES ('1730937729923964929', '1', '分页查询', '0:0:0:0:0:0:0:1', '2023-12-02 21:11:19', '2023-12-02 21:11:19', '/device/page', 'GET', 1, NULL, 142);
INSERT INTO `system_operation_log` VALUES ('1730937773532143617', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-12-02 21:11:39', '2023-12-02 21:11:39', '/floor/floorList', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1730937773532143618', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-02 21:11:39', '2023-12-02 21:11:39', '/family/list', 'GET', 1, NULL, 10);
INSERT INTO `system_operation_log` VALUES ('1730937773532143619', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2023-12-02 21:11:39', '2023-12-02 21:11:39', '/product/list', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1730937773683138562', '1', '分页查询', '0:0:0:0:0:0:0:1', '2023-12-02 21:11:39', '2023-12-02 21:11:39', '/device/page', 'GET', 1, NULL, 37);
INSERT INTO `system_operation_log` VALUES ('1730938190336909314', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2023-12-02 21:13:19', '2023-12-02 21:13:19', '/product/list', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1730938190336909315', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-02 21:13:19', '2023-12-02 21:13:19', '/family/list', 'GET', 1, NULL, 12);
INSERT INTO `system_operation_log` VALUES ('1730938190534041601', '1', '分页查询', '0:0:0:0:0:0:0:1', '2023-12-02 21:13:19', '2023-12-02 21:13:19', '/device/page', 'GET', 1, NULL, 36);
INSERT INTO `system_operation_log` VALUES ('1730938210859638785', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-12-02 21:13:23', '2023-12-02 21:13:23', '/floor/floorList', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1730938232460304386', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-12-02 21:13:26', '2023-12-02 21:13:26', '/floor/floorList', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1730938234158997505', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-12-02 21:13:29', '2023-12-02 21:13:29', '/floor/floorList', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1730938281395249153', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-12-02 21:13:40', '2023-12-02 21:13:40', '/floor/floorList', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1730938303759278081', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-12-02 21:13:46', '2023-12-02 21:13:46', '/floor/floorList', 'GET', 1, NULL, 1);
INSERT INTO `system_operation_log` VALUES ('1730938330867064834', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-12-02 21:13:52', '2023-12-02 21:13:52', '/floor/floorList', 'GET', 1, NULL, 2);
INSERT INTO `system_operation_log` VALUES ('1730938535372939265', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-12-02 21:14:41', '2023-12-02 21:14:41', '/floor/floorList', 'GET', 1, NULL, 34);
INSERT INTO `system_operation_log` VALUES ('1730938545661566978', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-12-02 21:14:43', '2023-12-02 21:14:43', '/floor/floorList', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1730939173922230273', '1', '查询个人信息', '0:0:0:0:0:0:0:1', '2023-12-02 21:17:13', '2023-12-02 21:17:13', '/user/info', 'GET', 1, NULL, 14);
INSERT INTO `system_operation_log` VALUES ('1730939173943201794', NULL, '登录', '0:0:0:0:0:0:0:1', '2023-12-02 21:17:13', '2023-12-02 21:17:13', '/user/login', 'POST', 1, NULL, 860);
INSERT INTO `system_operation_log` VALUES ('1730939174194860034', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-12-02 21:17:13', '2023-12-02 21:17:13', '/permission/getPerm', 'GET', 1, NULL, 80);
INSERT INTO `system_operation_log` VALUES ('1730939175901941762', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2023-12-02 21:17:13', '2023-12-02 21:17:13', '/dashboard/dashboardInfo', 'GET', 1, NULL, 39);
INSERT INTO `system_operation_log` VALUES ('1730939215970127874', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-12-02 21:17:13', '2023-12-02 21:17:13', '/floor/floorList', 'GET', 1, NULL, 42);
INSERT INTO `system_operation_log` VALUES ('1730939216037236737', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-12-02 21:17:15', '2023-12-02 21:17:15', '/product/page', 'GET', 1, NULL, 113);
INSERT INTO `system_operation_log` VALUES ('1730939216246951937', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2023-12-02 21:17:19', '2023-12-02 21:17:19', '/product/list', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1730939217882730498', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-02 21:17:19', '2023-12-02 21:17:19', '/family/list', 'GET', 1, NULL, 40);
INSERT INTO `system_operation_log` VALUES ('1730939257984471041', '1', '分页查询', '0:0:0:0:0:0:0:1', '2023-12-02 21:17:23', '2023-12-02 21:17:23', '/device/page', 'GET', 1, NULL, 47);
INSERT INTO `system_operation_log` VALUES ('1730939258047385601', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-12-02 21:17:26', '2023-12-02 21:17:26', '/floor/floorList', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1730939258240323586', '1', '分页查询', '0:0:0:0:0:0:0:1', '2023-12-02 21:17:27', '2023-12-02 21:17:27', '/device/page', 'GET', 1, NULL, 27);
INSERT INTO `system_operation_log` VALUES ('1730939259884490754', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-12-02 21:17:30', '2023-12-02 21:17:30', '/floor/floorList', 'GET', 1, NULL, 6);
INSERT INTO `system_operation_log` VALUES ('1730939299994619906', '1', '分页查询', '0:0:0:0:0:0:0:1', '2023-12-02 21:17:31', '2023-12-02 21:17:31', '/device/page', 'GET', 1, NULL, 20);
INSERT INTO `system_operation_log` VALUES ('1730939300061728769', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-12-02 21:17:36', '2023-12-02 21:17:36', '/floor/floorList', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1730939300263055361', '1', '分页查询', '0:0:0:0:0:0:0:1', '2023-12-02 21:17:37', '2023-12-02 21:17:37', '/device/page', 'GET', 1, NULL, 29);
INSERT INTO `system_operation_log` VALUES ('1730939301894639617', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-12-02 21:17:40', '2023-12-02 21:17:40', '/floor/floorList', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1730939341971214338', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-12-02 21:17:44', '2023-12-02 21:17:44', '/floor/floorList', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1730939342034128898', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-12-02 21:17:47', '2023-12-02 21:17:47', '/floor/floorList', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1730939342231261185', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-12-02 21:17:50', '2023-12-02 21:17:50', '/floor/floorList', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1730939349017645058', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-12-02 21:17:55', '2023-12-02 21:17:55', '/floor/floorList', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1730939426595491841', '1', '分页查询', '0:0:0:0:0:0:0:1', '2023-12-02 21:18:13', '2023-12-02 21:18:13', '/device/page', 'GET', 1, NULL, 21);
INSERT INTO `system_operation_log` VALUES ('1730939436204642305', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-12-02 21:18:16', '2023-12-02 21:18:16', '/floor/floorList', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1730939440067596289', '1', '分页查询', '0:0:0:0:0:0:0:1', '2023-12-02 21:18:16', '2023-12-02 21:18:16', '/device/page', 'GET', 1, NULL, 22);
INSERT INTO `system_operation_log` VALUES ('1730939478504198146', '1', '分页查询', '0:0:0:0:0:0:0:1', '2023-12-02 21:18:26', '2023-12-02 21:18:26', '/device/page', 'GET', 1, NULL, 18);
INSERT INTO `system_operation_log` VALUES ('1730939502696943618', '1', '分页查询', '0:0:0:0:0:0:0:1', '2023-12-02 21:18:31', '2023-12-02 21:18:31', '/device/page', 'GET', 1, NULL, 26);
INSERT INTO `system_operation_log` VALUES ('1730939605117652993', '1', '分页查询', '0:0:0:0:0:0:0:1', '2023-12-02 21:18:56', '2023-12-02 21:18:56', '/device/page', 'GET', 1, NULL, 26);
INSERT INTO `system_operation_log` VALUES ('1730943296902090753', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-12-02 21:33:36', '2023-12-02 21:33:36', '/floor/floorList', 'GET', 1, NULL, 13);
INSERT INTO `system_operation_log` VALUES ('1730943296969199617', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2023-12-02 21:33:36', '2023-12-02 21:33:36', '/dashboard/dashboardInfo', 'GET', 1, NULL, 35);
INSERT INTO `system_operation_log` VALUES ('1730943308377706498', '1', '分页', '0:0:0:0:0:0:0:1', '2023-12-02 21:33:39', '2023-12-02 21:33:39', '/family/page', 'GET', 1, NULL, 40);
INSERT INTO `system_operation_log` VALUES ('1730944827021938690', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-12-02 21:39:41', '2023-12-02 21:39:41', '/permission/getPerm', 'GET', 1, NULL, 13);
INSERT INTO `system_operation_log` VALUES ('1730944828418641921', '1', '分页', '0:0:0:0:0:0:0:1', '2023-12-02 21:39:41', '2023-12-02 21:39:41', '/family/page', 'GET', 1, NULL, 31);
INSERT INTO `system_operation_log` VALUES ('1730946016367169538', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-12-02 21:44:24', '2023-12-02 21:44:24', '/permission/getPerm', 'GET', 1, NULL, 10);
INSERT INTO `system_operation_log` VALUES ('1730946017826787329', '1', '分页', '0:0:0:0:0:0:0:1', '2023-12-02 21:44:25', '2023-12-02 21:44:25', '/family/page', 'GET', 1, NULL, 24);
INSERT INTO `system_operation_log` VALUES ('1730948866342211585', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-12-02 21:55:44', '2023-12-02 21:55:44', '/permission/getPerm', 'GET', 1, NULL, 12);
INSERT INTO `system_operation_log` VALUES ('1730948867906686978', '1', '分页', '0:0:0:0:0:0:0:1', '2023-12-02 21:55:44', '2023-12-02 21:55:44', '/family/page', 'GET', 1, NULL, 30);
INSERT INTO `system_operation_log` VALUES ('1730949625125359618', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-12-02 21:58:45', '2023-12-02 21:58:45', '/permission/getPerm', 'GET', 1, NULL, 8);
INSERT INTO `system_operation_log` VALUES ('1730949626454953986', '1', '分页', '0:0:0:0:0:0:0:1', '2023-12-02 21:58:45', '2023-12-02 21:58:45', '/family/page', 'GET', 1, NULL, 21);
INSERT INTO `system_operation_log` VALUES ('1730949684772556801', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-12-02 21:58:59', '2023-12-02 21:58:59', '/permission/getPerm', 'GET', 1, NULL, 7);
INSERT INTO `system_operation_log` VALUES ('1730949688547430401', '1', '分页', '0:0:0:0:0:0:0:1', '2023-12-02 21:59:00', '2023-12-02 21:59:00', '/family/page', 'GET', 1, NULL, 23);
INSERT INTO `system_operation_log` VALUES ('1730950609541091330', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-12-02 22:02:39', '2023-12-02 22:02:39', '/permission/getPerm', 'GET', 1, NULL, 6);
INSERT INTO `system_operation_log` VALUES ('1730950611013292034', '1', '分页', '0:0:0:0:0:0:0:1', '2023-12-02 22:02:40', '2023-12-02 22:02:40', '/family/page', 'GET', 1, NULL, 23);
INSERT INTO `system_operation_log` VALUES ('1730951298031898625', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-12-02 22:05:24', '2023-12-02 22:05:24', '/permission/getPerm', 'GET', 1, NULL, 7);
INSERT INTO `system_operation_log` VALUES ('1730951299361492993', '1', '分页', '0:0:0:0:0:0:0:1', '2023-12-02 22:05:24', '2023-12-02 22:05:24', '/family/page', 'GET', 1, NULL, 29);
INSERT INTO `system_operation_log` VALUES ('1730951317619298306', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-12-02 22:05:28', '2023-12-02 22:05:28', '/permission/getPerm', 'GET', 1, NULL, 6);
INSERT INTO `system_operation_log` VALUES ('1730951318743371778', '1', '分页', '0:0:0:0:0:0:0:1', '2023-12-02 22:05:29', '2023-12-02 22:05:29', '/family/page', 'GET', 1, NULL, 27);
INSERT INTO `system_operation_log` VALUES ('1730951533302992897', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-12-02 22:06:20', '2023-12-02 22:06:20', '/permission/getPerm', 'GET', 1, NULL, 6);
INSERT INTO `system_operation_log` VALUES ('1730951534506758145', '1', '分页', '0:0:0:0:0:0:0:1', '2023-12-02 22:06:20', '2023-12-02 22:06:20', '/family/page', 'GET', 1, NULL, 26);
INSERT INTO `system_operation_log` VALUES ('1730951640647815170', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-12-02 22:06:45', '2023-12-02 22:06:45', '/permission/getPerm', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1730951641864163330', '1', '分页', '0:0:0:0:0:0:0:1', '2023-12-02 22:06:46', '2023-12-02 22:06:46', '/family/page', 'GET', 1, NULL, 25);
INSERT INTO `system_operation_log` VALUES ('1730951994940674050', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-12-02 22:08:10', '2023-12-02 22:08:10', '/permission/getPerm', 'GET', 1, NULL, 6);
INSERT INTO `system_operation_log` VALUES ('1730951996169605122', '1', '分页', '0:0:0:0:0:0:0:1', '2023-12-02 22:08:10', '2023-12-02 22:08:10', '/family/page', 'GET', 1, NULL, 28);
INSERT INTO `system_operation_log` VALUES ('1730952065715359745', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-12-02 22:08:27', '2023-12-02 22:08:27', '/permission/getPerm', 'GET', 1, NULL, 6);
INSERT INTO `system_operation_log` VALUES ('1730952066919124993', '1', '分页', '0:0:0:0:0:0:0:1', '2023-12-02 22:08:27', '2023-12-02 22:08:27', '/family/page', 'GET', 1, NULL, 26);
INSERT INTO `system_operation_log` VALUES ('1730952097038422018', '1', '分页', '0:0:0:0:0:0:0:1', '2023-12-02 22:08:34', '2023-12-02 22:08:34', '/family/page', 'GET', 1, NULL, 18);
INSERT INTO `system_operation_log` VALUES ('1730952201476591618', '1', '分页', '0:0:0:0:0:0:0:1', '2023-12-02 22:08:59', '2023-12-02 22:08:59', '/family/page', 'GET', 1, NULL, 19);
INSERT INTO `system_operation_log` VALUES ('1730952256572968961', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-12-02 22:09:12', '2023-12-02 22:09:12', '/permission/getPerm', 'GET', 1, NULL, 6);
INSERT INTO `system_operation_log` VALUES ('1730952258154221569', '1', '分页', '0:0:0:0:0:0:0:1', '2023-12-02 22:09:13', '2023-12-02 22:09:13', '/family/page', 'GET', 1, NULL, 27);
INSERT INTO `system_operation_log` VALUES ('1730952358389698561', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-12-02 22:09:36', '2023-12-02 22:09:36', '/permission/getPerm', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1730952359887065089', '1', '分页', '0:0:0:0:0:0:0:1', '2023-12-02 22:09:37', '2023-12-02 22:09:37', '/family/page', 'GET', 1, NULL, 26);
INSERT INTO `system_operation_log` VALUES ('1730952695272001538', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-12-02 22:10:57', '2023-12-02 22:10:57', '/permission/getPerm', 'GET', 1, NULL, 7);
INSERT INTO `system_operation_log` VALUES ('1730952696710647809', '1', '分页', '0:0:0:0:0:0:0:1', '2023-12-02 22:10:57', '2023-12-02 22:10:57', '/family/page', 'GET', 1, NULL, 21);
INSERT INTO `system_operation_log` VALUES ('1730953471482482689', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-12-02 22:14:02', '2023-12-02 22:14:02', '/permission/getPerm', 'GET', 1, NULL, 6);
INSERT INTO `system_operation_log` VALUES ('1730953472942100482', '1', '分页', '0:0:0:0:0:0:0:1', '2023-12-02 22:14:02', '2023-12-02 22:14:02', '/family/page', 'GET', 1, NULL, 25);
INSERT INTO `system_operation_log` VALUES ('1730953619495276546', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-12-02 22:14:37', '2023-12-02 22:14:37', '/permission/getPerm', 'GET', 1, NULL, 6);
INSERT INTO `system_operation_log` VALUES ('1730953620678070273', '1', '分页', '0:0:0:0:0:0:0:1', '2023-12-02 22:14:37', '2023-12-02 22:14:37', '/family/page', 'GET', 1, NULL, 21);
INSERT INTO `system_operation_log` VALUES ('1730953731499970561', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-12-02 22:15:04', '2023-12-02 22:15:04', '/permission/getPerm', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1730953732733095937', '1', '分页', '0:0:0:0:0:0:0:1', '2023-12-02 22:15:04', '2023-12-02 22:15:04', '/family/page', 'GET', 1, NULL, 27);
INSERT INTO `system_operation_log` VALUES ('1730953871363231745', '1', '分页', '0:0:0:0:0:0:0:1', '2023-12-02 22:15:37', '2023-12-02 22:15:37', '/family/page', 'GET', 1, NULL, 18);
INSERT INTO `system_operation_log` VALUES ('1730954320346697729', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-12-02 22:17:24', '2023-12-02 22:17:24', '/permission/getPerm', 'GET', 1, NULL, 8);
INSERT INTO `system_operation_log` VALUES ('1730954321814704130', '1', '分页', '0:0:0:0:0:0:0:1', '2023-12-02 22:17:25', '2023-12-02 22:17:25', '/family/page', 'GET', 1, NULL, 39);
INSERT INTO `system_operation_log` VALUES ('1730954744235642882', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-12-02 22:19:05', '2023-12-02 22:19:05', '/permission/getPerm', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1730954745619763202', '1', '分页', '0:0:0:0:0:0:0:1', '2023-12-02 22:19:06', '2023-12-02 22:19:06', '/family/page', 'GET', 1, NULL, 21);
INSERT INTO `system_operation_log` VALUES ('1730955848205815810', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-12-02 22:23:28', '2023-12-02 22:23:28', '/permission/getPerm', 'GET', 1, NULL, 34);
INSERT INTO `system_operation_log` VALUES ('1730955849489272834', '1', '分页', '0:0:0:0:0:0:0:1', '2023-12-02 22:23:29', '2023-12-02 22:23:29', '/family/page', 'GET', 1, NULL, 25);
INSERT INTO `system_operation_log` VALUES ('1730956209121480706', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-12-02 22:24:55', '2023-12-02 22:24:55', '/permission/getPerm', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1730956210455269378', '1', '分页', '0:0:0:0:0:0:0:1', '2023-12-02 22:24:55', '2023-12-02 22:24:55', '/family/page', 'GET', 1, NULL, 18);
INSERT INTO `system_operation_log` VALUES ('1730956539364200450', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-12-02 22:26:13', '2023-12-02 22:26:13', '/permission/getPerm', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1730956540924481537', '1', '分页', '0:0:0:0:0:0:0:1', '2023-12-02 22:26:14', '2023-12-02 22:26:14', '/family/page', 'GET', 1, NULL, 27);
INSERT INTO `system_operation_log` VALUES ('1730956722407821313', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-12-02 22:26:57', '2023-12-02 22:26:57', '/permission/getPerm', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1730956723863244802', '1', '分页', '0:0:0:0:0:0:0:1', '2023-12-02 22:26:57', '2023-12-02 22:26:57', '/family/page', 'GET', 1, NULL, 20);
INSERT INTO `system_operation_log` VALUES ('1730957239540338690', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-12-02 22:29:00', '2023-12-02 22:29:00', '/permission/getPerm', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1730957240865738753', '1', '分页', '0:0:0:0:0:0:0:1', '2023-12-02 22:29:01', '2023-12-02 22:29:01', '/family/page', 'GET', 1, NULL, 25);
INSERT INTO `system_operation_log` VALUES ('1730957884771094529', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-12-02 22:31:34', '2023-12-02 22:31:34', '/floor/floorList', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1730957884838203393', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2023-12-02 22:31:34', '2023-12-02 22:31:34', '/dashboard/dashboardInfo', 'GET', 1, NULL, 21);
INSERT INTO `system_operation_log` VALUES ('1730957897987346433', '1', '分页', '0:0:0:0:0:0:0:1', '2023-12-02 22:31:37', '2023-12-02 22:31:37', '/family/page', 'GET', 1, NULL, 16);
INSERT INTO `system_operation_log` VALUES ('1730958037699612673', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-12-02 22:32:10', '2023-12-02 22:32:10', '/permission/getPerm', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1730958039029207042', '1', '分页', '0:0:0:0:0:0:0:1', '2023-12-02 22:32:11', '2023-12-02 22:32:11', '/family/page', 'GET', 1, NULL, 21);
INSERT INTO `system_operation_log` VALUES ('1730958190179340290', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-12-02 22:32:47', '2023-12-02 22:32:47', '/permission/getPerm', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1730958191487963138', '1', '分页', '0:0:0:0:0:0:0:1', '2023-12-02 22:32:47', '2023-12-02 22:32:47', '/family/page', 'GET', 1, NULL, 23);
INSERT INTO `system_operation_log` VALUES ('1730958213826826242', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-12-02 22:32:52', '2023-12-02 22:32:52', '/permission/getPerm', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1730958215101894657', '1', '分页', '0:0:0:0:0:0:0:1', '2023-12-02 22:32:53', '2023-12-02 22:32:53', '/family/page', 'GET', 1, NULL, 20);
INSERT INTO `system_operation_log` VALUES ('1733705750330527745', NULL, '登录', '0:0:0:0:0:0:0:1', '2023-12-10 12:30:36', '2023-12-10 12:30:36', '/user/login', 'POST', 1, NULL, 585);
INSERT INTO `system_operation_log` VALUES ('1733705751135834113', '1', '查询个人信息', '0:0:0:0:0:0:0:1', '2023-12-10 12:30:36', '2023-12-10 12:30:36', '/user/info', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1733705751265857537', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-12-10 12:30:36', '2023-12-10 12:30:36', '/permission/getPerm', 'GET', 1, NULL, 31);
INSERT INTO `system_operation_log` VALUES ('1733705752872275970', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2023-12-10 12:30:37', '2023-12-10 12:30:37', '/dashboard/dashboardInfo', 'GET', 1, NULL, 33);
INSERT INTO `system_operation_log` VALUES ('1733705792604917761', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-12-10 12:30:37', '2023-12-10 12:30:37', '/floor/floorList', 'GET', 1, NULL, 32);
INSERT INTO `system_operation_log` VALUES ('1733709591985836033', '1', '分页', '0:0:0:0:0:0:0:1', '2023-12-10 12:45:52', '2023-12-10 12:45:52', '/family/page', 'GET', 1, NULL, 78);
INSERT INTO `system_operation_log` VALUES ('1733709894005084161', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-10 12:47:04', '2023-12-10 12:47:04', '/family/list', 'GET', 1, NULL, 8);
INSERT INTO `system_operation_log` VALUES ('1733709894072193025', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 12:47:04', '2023-12-10 12:47:04', '/floor/pageBackend', 'GET', 1, NULL, 25);
INSERT INTO `system_operation_log` VALUES ('1733709898451046402', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-12-10 12:47:05', '2023-12-10 12:47:05', '/floor/floorList', 'GET', 1, NULL, 2);
INSERT INTO `system_operation_log` VALUES ('1733709898451046403', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-10 12:47:05', '2023-12-10 12:47:05', '/family/list', 'GET', 1, NULL, 10);
INSERT INTO `system_operation_log` VALUES ('1733709935994261506', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 12:47:05', '2023-12-10 12:47:05', '/room/pageBackend', 'GET', 1, NULL, 39);
INSERT INTO `system_operation_log` VALUES ('1733709936061370370', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-10 12:47:07', '2023-12-10 12:47:07', '/family/list', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1733709940440223746', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 12:47:07', '2023-12-10 12:47:07', '/floor/pageBackend', 'GET', 1, NULL, 18);
INSERT INTO `system_operation_log` VALUES ('1733709940503138305', '1', '分页', '0:0:0:0:0:0:0:1', '2023-12-10 12:47:08', '2023-12-10 12:47:08', '/family/page', 'GET', 1, NULL, 15);
INSERT INTO `system_operation_log` VALUES ('1733709977970855937', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-10 12:47:11', '2023-12-10 12:47:11', '/family/list', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1733709978033770497', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 12:47:16', '2023-12-10 12:47:16', '/floor/pageBackend', 'GET', 1, NULL, 18);
INSERT INTO `system_operation_log` VALUES ('1733709982412623874', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 12:47:19', '2023-12-10 12:47:19', '/floor/pageBackend', 'GET', 1, NULL, 14);
INSERT INTO `system_operation_log` VALUES ('1733709982546841601', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 12:47:21', '2023-12-10 12:47:21', '/floor/pageBackend', 'GET', 1, NULL, 15);
INSERT INTO `system_operation_log` VALUES ('1733710019947450370', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 12:47:23', '2023-12-10 12:47:23', '/floor/pageBackend', 'GET', 1, NULL, 16);
INSERT INTO `system_operation_log` VALUES ('1733710020010364929', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 12:47:25', '2023-12-10 12:47:25', '/floor/pageBackend', 'GET', 1, NULL, 14);
INSERT INTO `system_operation_log` VALUES ('1733710035604787201', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 12:47:38', '2023-12-10 12:47:38', '/floor/pageBackend', 'GET', 1, NULL, 18);
INSERT INTO `system_operation_log` VALUES ('1733710047327866881', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 12:47:41', '2023-12-10 12:47:41', '/floor/pageBackend', 'GET', 1, NULL, 14);
INSERT INTO `system_operation_log` VALUES ('1733710085374398465', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-12-10 12:47:50', '2023-12-10 12:47:50', '/floor/floorList', 'GET', 1, NULL, 2);
INSERT INTO `system_operation_log` VALUES ('1733710085374398466', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-10 12:47:50', '2023-12-10 12:47:50', '/family/list', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1733710085374398467', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 12:47:50', '2023-12-10 12:47:50', '/room/pageBackend', 'GET', 1, NULL, 15);
INSERT INTO `system_operation_log` VALUES ('1733715946868101121', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 13:11:07', '2023-12-10 13:11:07', '/product/page', 'GET', 1, NULL, 42);
INSERT INTO `system_operation_log` VALUES ('1733715953415409666', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2023-12-10 13:11:09', '2023-12-10 13:11:09', '/product/list', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1733715953482518529', NULL, '', '0:0:0:0:0:0:0:1', '2023-12-10 13:11:09', '2023-12-10 13:11:09', '/error', 'GET', 0, '系统错误请联系管理员', 2);
INSERT INTO `system_operation_log` VALUES ('1733715966912679938', '1', '分页', '0:0:0:0:0:0:0:1', '2023-12-10 13:11:12', '2023-12-10 13:11:12', '/family/page', 'GET', 1, NULL, 19);
INSERT INTO `system_operation_log` VALUES ('1733715988949553154', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-10 13:11:17', '2023-12-10 13:11:17', '/family/list', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1733715995404587009', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 13:11:17', '2023-12-10 13:11:17', '/floor/pageBackend', 'GET', 1, NULL, 23);
INSERT INTO `system_operation_log` VALUES ('1733715996197310466', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-12-10 13:11:19', '2023-12-10 13:11:19', '/floor/floorList', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1733716008960577537', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-10 13:11:19', '2023-12-10 13:11:19', '/family/list', 'GET', 1, NULL, 7);
INSERT INTO `system_operation_log` VALUES ('1733716030938730498', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 13:11:19', '2023-12-10 13:11:19', '/room/pageBackend', 'GET', 1, NULL, 19);
INSERT INTO `system_operation_log` VALUES ('1733716303170031617', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-10 13:12:32', '2023-12-10 13:12:32', '/family/list', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1733716303170031618', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-12-10 13:12:32', '2023-12-10 13:12:32', '/floor/floorList', 'GET', 1, NULL, 9);
INSERT INTO `system_operation_log` VALUES ('1733716303237140481', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 13:12:32', '2023-12-10 13:12:32', '/room/pageBackend', 'GET', 1, NULL, 18);
INSERT INTO `system_operation_log` VALUES ('1733724034056634369', NULL, '登录', '0:0:0:0:0:0:0:1', '2023-12-10 13:43:15', '2023-12-10 13:43:15', '/user/login', 'POST', 1, NULL, 419);
INSERT INTO `system_operation_log` VALUES ('1733724034069217282', '1', '查询个人信息', '0:0:0:0:0:0:0:1', '2023-12-10 13:43:15', '2023-12-10 13:43:15', '/user/info', 'GET', 1, NULL, 6);
INSERT INTO `system_operation_log` VALUES ('1733724034123743233', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-12-10 13:43:15', '2023-12-10 13:43:15', '/permission/getPerm', 'GET', 1, NULL, 21);
INSERT INTO `system_operation_log` VALUES ('1733724035440754690', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2023-12-10 13:43:16', '2023-12-10 13:43:16', '/dashboard/dashboardInfo', 'GET', 1, NULL, 25);
INSERT INTO `system_operation_log` VALUES ('1733724076029034497', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-12-10 13:43:16', '2023-12-10 13:43:16', '/floor/floorList', 'GET', 1, NULL, 26);
INSERT INTO `system_operation_log` VALUES ('1733724076029034498', '1', '分页', '0:0:0:0:0:0:0:1', '2023-12-10 13:43:18', '2023-12-10 13:43:18', '/family/page', 'GET', 1, NULL, 70);
INSERT INTO `system_operation_log` VALUES ('1733724076108726274', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-12-10 13:43:19', '2023-12-10 13:43:19', '/floor/floorList', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1733724077354434562', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-10 13:43:19', '2023-12-10 13:43:19', '/family/list', 'GET', 1, NULL, 8);
INSERT INTO `system_operation_log` VALUES ('1733725564142919681', NULL, '登录', '0:0:0:0:0:0:0:1', '2023-12-10 13:49:20', '2023-12-10 13:49:20', '/user/login', 'POST', 1, NULL, 382);
INSERT INTO `system_operation_log` VALUES ('1733725564163891202', '1', '查询个人信息', '0:0:0:0:0:0:0:1', '2023-12-10 13:49:20', '2023-12-10 13:49:20', '/user/info', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1733725564172279809', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-12-10 13:49:20', '2023-12-10 13:49:20', '/permission/getPerm', 'GET', 1, NULL, 22);
INSERT INTO `system_operation_log` VALUES ('1733725565317324802', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2023-12-10 13:49:21', '2023-12-10 13:49:21', '/dashboard/dashboardInfo', 'GET', 1, NULL, 31);
INSERT INTO `system_operation_log` VALUES ('1733725606182428674', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-12-10 13:49:21', '2023-12-10 13:49:21', '/floor/floorList', 'GET', 1, NULL, 20);
INSERT INTO `system_operation_log` VALUES ('1733725606182428675', '1', '分页', '0:0:0:0:0:0:0:1', '2023-12-10 13:49:23', '2023-12-10 13:49:23', '/family/page', 'GET', 1, NULL, 72);
INSERT INTO `system_operation_log` VALUES ('1733725606249537538', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-12-10 13:49:24', '2023-12-10 13:49:24', '/floor/floorList', 'GET', 1, NULL, 2);
INSERT INTO `system_operation_log` VALUES ('1733725607365222402', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-10 13:49:24', '2023-12-10 13:49:24', '/family/list', 'GET', 1, NULL, 13);
INSERT INTO `system_operation_log` VALUES ('1733725648175800321', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 13:49:24', '2023-12-10 13:49:24', '/room/pageBackend', 'GET', 1, NULL, 34);
INSERT INTO `system_operation_log` VALUES ('1733725934558683138', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 13:50:49', '2023-12-10 13:50:49', '/room/pageBackend', 'GET', 1, NULL, 20);
INSERT INTO `system_operation_log` VALUES ('1733725943354138625', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 13:50:51', '2023-12-10 13:50:51', '/room/pageBackend', 'GET', 1, NULL, 14);
INSERT INTO `system_operation_log` VALUES ('1733725968557711361', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 13:50:57', '2023-12-10 13:50:57', '/room/pageBackend', 'GET', 1, NULL, 14);
INSERT INTO `system_operation_log` VALUES ('1733725979517427713', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 13:50:59', '2023-12-10 13:50:59', '/room/pageBackend', 'GET', 1, NULL, 15);
INSERT INTO `system_operation_log` VALUES ('1733727188382949378', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-10 13:55:47', '2023-12-10 13:55:47', '/family/list', 'GET', 1, NULL, 12);
INSERT INTO `system_operation_log` VALUES ('1733727188517167105', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 13:55:48', '2023-12-10 13:55:48', '/floor/pageBackend', 'GET', 1, NULL, 32);
INSERT INTO `system_operation_log` VALUES ('1733727195983028226', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 13:55:49', '2023-12-10 13:55:49', '/floor/pageBackend', 'GET', 1, NULL, 16);
INSERT INTO `system_operation_log` VALUES ('1733728713956171777', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-10 14:01:51', '2023-12-10 14:01:51', '/family/list', 'GET', 1, NULL, 6);
INSERT INTO `system_operation_log` VALUES ('1733728713956171778', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 14:01:51', '2023-12-10 14:01:51', '/room/pageBackend', 'GET', 1, NULL, 18);
INSERT INTO `system_operation_log` VALUES ('1733728879169806338', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 14:02:31', '2023-12-10 14:02:31', '/room/pageBackend', 'GET', 1, NULL, 15);
INSERT INTO `system_operation_log` VALUES ('1733728902389473281', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 14:02:36', '2023-12-10 14:02:36', '/room/pageBackend', 'GET', 1, NULL, 13);
INSERT INTO `system_operation_log` VALUES ('1733728982408404994', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 14:02:55', '2023-12-10 14:02:55', '/room/pageBackend', 'GET', 1, NULL, 17);
INSERT INTO `system_operation_log` VALUES ('1733729135223676929', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-10 14:03:32', '2023-12-10 14:03:32', '/family/list', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1733729135223676930', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 14:03:32', '2023-12-10 14:03:32', '/room/pageBackend', 'GET', 1, NULL, 34);
INSERT INTO `system_operation_log` VALUES ('1733729149094240258', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 14:03:35', '2023-12-10 14:03:35', '/room/pageBackend', 'GET', 1, NULL, 18);
INSERT INTO `system_operation_log` VALUES ('1733729167863750657', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 14:03:39', '2023-12-10 14:03:39', '/room/pageBackend', 'GET', 1, NULL, 11);
INSERT INTO `system_operation_log` VALUES ('1733729177598730242', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 14:03:42', '2023-12-10 14:03:42', '/room/pageBackend', 'GET', 1, NULL, 13);
INSERT INTO `system_operation_log` VALUES ('1733729414648209410', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-10 14:04:38', '2023-12-10 14:04:38', '/family/list', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1733729414711123970', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 14:04:38', '2023-12-10 14:04:38', '/room/pageBackend', 'GET', 1, NULL, 21);
INSERT INTO `system_operation_log` VALUES ('1733729422709661697', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-12-10 14:04:40', '2023-12-10 14:04:40', '/permission/getPerm', 'GET', 1, NULL, 7);
INSERT INTO `system_operation_log` VALUES ('1733729423980535810', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-10 14:04:40', '2023-12-10 14:04:40', '/family/list', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1733729456645775361', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 14:04:41', '2023-12-10 14:04:41', '/room/pageBackend', 'GET', 1, NULL, 21);
INSERT INTO `system_operation_log` VALUES ('1733729456708689922', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-12-10 14:04:46', '2023-12-10 14:04:46', '/floor/floorList', 'GET', 1, NULL, 2);
INSERT INTO `system_operation_log` VALUES ('1733729464728199170', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 14:04:46', '2023-12-10 14:04:46', '/room/pageBackend', 'GET', 1, NULL, 19);
INSERT INTO `system_operation_log` VALUES ('1733729466158456833', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-12-10 14:04:50', '2023-12-10 14:04:50', '/floor/floorList', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1733729498567843841', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 14:04:50', '2023-12-10 14:04:50', '/room/pageBackend', 'GET', 1, NULL, 18);
INSERT INTO `system_operation_log` VALUES ('1733729498697867265', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-12-10 14:04:53', '2023-12-10 14:04:53', '/floor/floorList', 'GET', 1, NULL, 2);
INSERT INTO `system_operation_log` VALUES ('1733729506721570818', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 14:04:53', '2023-12-10 14:04:53', '/room/pageBackend', 'GET', 1, NULL, 15);
INSERT INTO `system_operation_log` VALUES ('1733729508151828482', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-12-10 14:04:57', '2023-12-10 14:04:57', '/floor/floorList', 'GET', 1, NULL, 2);
INSERT INTO `system_operation_log` VALUES ('1733729540653490178', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 14:04:57', '2023-12-10 14:04:57', '/room/pageBackend', 'GET', 1, NULL, 16);
INSERT INTO `system_operation_log` VALUES ('1733730994986459138', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-10 14:10:55', '2023-12-10 14:10:55', '/family/list', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1733730995040985090', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 14:10:55', '2023-12-10 14:10:55', '/room/pageBackend', 'GET', 1, NULL, 18);
INSERT INTO `system_operation_log` VALUES ('1733731022119411713', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-12-10 14:11:02', '2023-12-10 14:11:02', '/floor/floorList', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1733731022186520577', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 14:11:02', '2023-12-10 14:11:02', '/room/pageBackend', 'GET', 1, NULL, 19);
INSERT INTO `system_operation_log` VALUES ('1733731036958859265', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 14:11:03', '2023-12-10 14:11:03', '/room/pageBackend', 'GET', 1, NULL, 16);
INSERT INTO `system_operation_log` VALUES ('1733731048321228801', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-12-10 14:11:08', '2023-12-10 14:11:08', '/permission/getPerm', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1733731064171503618', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-10 14:11:08', '2023-12-10 14:11:08', '/family/list', 'GET', 1, NULL, 7);
INSERT INTO `system_operation_log` VALUES ('1733731064171503619', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 14:11:08', '2023-12-10 14:11:08', '/room/pageBackend', 'GET', 1, NULL, 30);
INSERT INTO `system_operation_log` VALUES ('1733731078973202433', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-12-10 14:11:10', '2023-12-10 14:11:10', '/floor/floorList', 'GET', 1, NULL, 2);
INSERT INTO `system_operation_log` VALUES ('1733731090356543489', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 14:11:10', '2023-12-10 14:11:10', '/room/pageBackend', 'GET', 1, NULL, 18);
INSERT INTO `system_operation_log` VALUES ('1733731106135515137', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 14:11:11', '2023-12-10 14:11:11', '/room/pageBackend', 'GET', 1, NULL, 15);
INSERT INTO `system_operation_log` VALUES ('1733731106135515138', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-12-10 14:11:15', '2023-12-10 14:11:15', '/floor/floorList', 'GET', 1, NULL, 2);
INSERT INTO `system_operation_log` VALUES ('1733731120937213954', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 14:11:15', '2023-12-10 14:11:15', '/room/pageBackend', 'GET', 1, NULL, 16);
INSERT INTO `system_operation_log` VALUES ('1733731132266029058', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 14:11:17', '2023-12-10 14:11:17', '/room/pageBackend', 'GET', 1, NULL, 14);
INSERT INTO `system_operation_log` VALUES ('1733731148120498178', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 14:11:18', '2023-12-10 14:11:18', '/room/pageBackend', 'GET', 1, NULL, 12);
INSERT INTO `system_operation_log` VALUES ('1733731148183412737', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 14:11:25', '2023-12-10 14:11:25', '/room/pageBackend', 'GET', 1, NULL, 13);
INSERT INTO `system_operation_log` VALUES ('1733731162930585601', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-12-10 14:11:30', '2023-12-10 14:11:30', '/floor/floorList', 'GET', 1, NULL, 1);
INSERT INTO `system_operation_log` VALUES ('1733731174292955138', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 14:11:30', '2023-12-10 14:11:30', '/room/pageBackend', 'GET', 1, NULL, 16);
INSERT INTO `system_operation_log` VALUES ('1733731190118064129', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 14:11:32', '2023-12-10 14:11:32', '/room/pageBackend', 'GET', 1, NULL, 16);
INSERT INTO `system_operation_log` VALUES ('1733731190180978690', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 14:11:40', '2023-12-10 14:11:40', '/room/pageBackend', 'GET', 1, NULL, 18);
INSERT INTO `system_operation_log` VALUES ('1733731204907180033', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-12-10 14:11:44', '2023-12-10 14:11:44', '/floor/floorList', 'GET', 1, NULL, 2);
INSERT INTO `system_operation_log` VALUES ('1733731216290521089', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 14:11:44', '2023-12-10 14:11:44', '/room/pageBackend', 'GET', 1, NULL, 20);
INSERT INTO `system_operation_log` VALUES ('1733731232094658562', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-12-10 14:11:51', '2023-12-10 14:11:51', '/floor/floorList', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1733731232161767426', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 14:11:51', '2023-12-10 14:11:51', '/room/pageBackend', 'GET', 1, NULL, 21);
INSERT INTO `system_operation_log` VALUES ('1733731246900551682', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-12-10 14:11:54', '2023-12-10 14:11:54', '/floor/floorList', 'GET', 1, NULL, 2);
INSERT INTO `system_operation_log` VALUES ('1733731258296475649', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 14:11:54', '2023-12-10 14:11:54', '/room/pageBackend', 'GET', 1, NULL, 20);
INSERT INTO `system_operation_log` VALUES ('1733731303691427842', '1', '分页', '0:0:0:0:0:0:0:1', '2023-12-10 14:12:09', '2023-12-10 14:12:09', '/family/page', 'GET', 1, NULL, 18);
INSERT INTO `system_operation_log` VALUES ('1733731308254830594', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-10 14:12:10', '2023-12-10 14:12:10', '/family/list', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1733731308326133761', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 14:12:10', '2023-12-10 14:12:10', '/floor/pageBackend', 'GET', 1, NULL, 21);
INSERT INTO `system_operation_log` VALUES ('1733731312512049154', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-10 14:12:11', '2023-12-10 14:12:11', '/family/list', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1733731345772879874', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 14:12:11', '2023-12-10 14:12:11', '/room/pageBackend', 'GET', 1, NULL, 23);
INSERT INTO `system_operation_log` VALUES ('1733731444074782721', '1', '分页', '0:0:0:0:0:0:0:1', '2023-12-10 14:12:42', '2023-12-10 14:12:42', '/family/page', 'GET', 1, NULL, 17);
INSERT INTO `system_operation_log` VALUES ('1733732148487168002', NULL, '登录', '0:0:0:0:0:0:0:1', '2023-12-10 14:15:30', '2023-12-10 14:15:30', '/user/login', 'POST', 1, NULL, 101);
INSERT INTO `system_operation_log` VALUES ('1733732148562665473', '1', '查询个人信息', '0:0:0:0:0:0:0:1', '2023-12-10 14:15:30', '2023-12-10 14:15:30', '/user/info', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1733732148562665474', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-12-10 14:15:30', '2023-12-10 14:15:30', '/permission/getPerm', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1733732150135529474', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-12-10 14:15:30', '2023-12-10 14:15:30', '/floor/floorList', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1733732190493122561', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2023-12-10 14:15:30', '2023-12-10 14:15:30', '/dashboard/dashboardInfo', 'GET', 1, NULL, 15);
INSERT INTO `system_operation_log` VALUES ('1733732190572814338', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-12-10 14:15:36', '2023-12-10 14:15:36', '/floor/floorList', 'GET', 1, NULL, 2);
INSERT INTO `system_operation_log` VALUES ('1733732190572814339', '1', '分页', '0:0:0:0:0:0:0:1', '2023-12-10 14:15:32', '2023-12-10 14:15:32', '/family/page', 'GET', 1, NULL, 16);
INSERT INTO `system_operation_log` VALUES ('1733732192191815681', '1', '角色下拉列表', '0:0:0:0:0:0:0:1', '2023-12-10 14:15:36', '2023-12-10 14:15:36', '/permission/roleList', 'GET', 1, NULL, 8);
INSERT INTO `system_operation_log` VALUES ('1733732232499077122', '1', '分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 14:15:36', '2023-12-10 14:15:36', '/user/page', 'GET', 1, NULL, 38);
INSERT INTO `system_operation_log` VALUES ('1733732232561991682', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-10 14:15:40', '2023-12-10 14:15:40', '/family/list', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1733732309686853634', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-10 14:16:08', '2023-12-10 14:16:08', '/family/list', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1733732309825265666', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 14:16:09', '2023-12-10 14:16:09', '/floor/pageBackend', 'GET', 1, NULL, 27);
INSERT INTO `system_operation_log` VALUES ('1733732338564636673', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-10 14:16:15', '2023-12-10 14:16:15', '/family/list', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1733732338665299970', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 14:16:15', '2023-12-10 14:16:15', '/room/pageBackend', 'GET', 1, NULL, 20);
INSERT INTO `system_operation_log` VALUES ('1733732351717974018', '1', '角色下拉列表', '0:0:0:0:0:0:0:1', '2023-12-10 14:16:17', '2023-12-10 14:16:17', '/permission/roleList', 'GET', 1, NULL, 1);
INSERT INTO `system_operation_log` VALUES ('1733732351852191746', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-12-10 14:16:17', '2023-12-10 14:16:17', '/floor/floorList', 'GET', 1, NULL, 2);
INSERT INTO `system_operation_log` VALUES ('1733732380637700097', '1', '根据楼层id查询房间设备树', '0:0:0:0:0:0:0:1', '2023-12-10 14:16:17', '2023-12-10 14:16:17', '/device/roomDeviceTree', 'GET', 1, NULL, 18);
INSERT INTO `system_operation_log` VALUES ('1733732380700614658', '1', '分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 14:16:17', '2023-12-10 14:16:17', '/user/page', 'GET', 1, NULL, 27);
INSERT INTO `system_operation_log` VALUES ('1733732393686179842', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-10 14:16:18', '2023-12-10 14:16:18', '/family/list', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1733732393753288705', '1', '分页', '0:0:0:0:0:0:0:1', '2023-12-10 14:16:28', '2023-12-10 14:16:28', '/family/page', 'GET', 1, NULL, 14);
INSERT INTO `system_operation_log` VALUES ('1733732623064276994', '1', '角色下拉列表', '0:0:0:0:0:0:0:1', '2023-12-10 14:17:23', '2023-12-10 14:17:23', '/permission/roleList', 'GET', 1, NULL, 2);
INSERT INTO `system_operation_log` VALUES ('1733732623064276995', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-12-10 14:17:23', '2023-12-10 14:17:23', '/floor/floorList', 'GET', 1, NULL, 2);
INSERT INTO `system_operation_log` VALUES ('1733732623064276996', '1', '分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 14:17:23', '2023-12-10 14:17:23', '/user/page', 'GET', 1, NULL, 21);
INSERT INTO `system_operation_log` VALUES ('1733732623064276997', '1', '根据楼层id查询房间设备树', '0:0:0:0:0:0:0:1', '2023-12-10 14:17:23', '2023-12-10 14:17:23', '/device/roomDeviceTree', 'GET', 1, NULL, 13);
INSERT INTO `system_operation_log` VALUES ('1733735526697050113', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 14:28:55', '2023-12-10 14:28:55', '/room/pageBackend', 'GET', 1, NULL, 26);
INSERT INTO `system_operation_log` VALUES ('1733735526764158978', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-10 14:28:55', '2023-12-10 14:28:55', '/family/list', 'GET', 1, NULL, 10);
INSERT INTO `system_operation_log` VALUES ('1733736000674373634', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-10 14:30:48', '2023-12-10 14:30:48', '/family/list', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1733736000745676802', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 14:30:48', '2023-12-10 14:30:48', '/room/pageBackend', 'GET', 1, NULL, 17);
INSERT INTO `system_operation_log` VALUES ('1733736287824814082', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-10 14:31:57', '2023-12-10 14:31:57', '/family/list', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1733736287891922946', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 14:31:57', '2023-12-10 14:31:57', '/room/pageBackend', 'GET', 1, NULL, 19);
INSERT INTO `system_operation_log` VALUES ('1733736409346383874', '1', '分页', '0:0:0:0:0:0:0:1', '2023-12-10 14:32:26', '2023-12-10 14:32:26', '/family/page', 'GET', 1, NULL, 13);
INSERT INTO `system_operation_log` VALUES ('1733736597477695490', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-12-10 14:33:11', '2023-12-10 14:33:11', '/permission/getPerm', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1733736598761152514', '1', '分页', '0:0:0:0:0:0:0:1', '2023-12-10 14:33:11', '2023-12-10 14:33:11', '/family/page', 'GET', 1, NULL, 19);
INSERT INTO `system_operation_log` VALUES ('1733736877367795714', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-10 14:34:17', '2023-12-10 14:34:17', '/family/list', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1733736877434904577', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 14:34:18', '2023-12-10 14:34:18', '/floor/pageBackend', 'GET', 1, NULL, 24);
INSERT INTO `system_operation_log` VALUES ('1733736881218166786', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-10 14:34:18', '2023-12-10 14:34:18', '/family/list', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1733736881373356034', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 14:34:18', '2023-12-10 14:34:18', '/room/pageBackend', 'GET', 1, NULL, 25);
INSERT INTO `system_operation_log` VALUES ('1733736919377944578', '1', '角色下拉列表', '0:0:0:0:0:0:0:1', '2023-12-10 14:34:19', '2023-12-10 14:34:19', '/permission/roleList', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1733736919377944579', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-12-10 14:34:19', '2023-12-10 14:34:19', '/floor/floorList', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1733736923308007426', '1', '根据楼层id查询房间设备树', '0:0:0:0:0:0:0:1', '2023-12-10 14:34:19', '2023-12-10 14:34:19', '/device/roomDeviceTree', 'GET', 1, NULL, 10);
INSERT INTO `system_operation_log` VALUES ('1733736923375116290', '1', '分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 14:34:19', '2023-12-10 14:34:19', '/user/page', 'GET', 1, NULL, 26);
INSERT INTO `system_operation_log` VALUES ('1733736961320984578', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 14:34:22', '2023-12-10 14:34:22', '/room/pageBackend', 'GET', 1, NULL, 14);
INSERT INTO `system_operation_log` VALUES ('1733736961396482050', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-10 14:34:28', '2023-12-10 14:34:28', '/family/list', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1733736965267824641', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-10 14:34:28', '2023-12-10 14:34:28', '/family/list', 'GET', 1, NULL, 2);
INSERT INTO `system_operation_log` VALUES ('1733736965334933506', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 14:34:31', '2023-12-10 14:34:31', '/product/page', 'GET', 1, NULL, 30);
INSERT INTO `system_operation_log` VALUES ('1733737003373076481', '1', '分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 14:34:36', '2023-12-10 14:34:36', '/device/page', 'GET', 1, NULL, 23);
INSERT INTO `system_operation_log` VALUES ('1733737003440185345', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2023-12-10 14:34:38', '2023-12-10 14:34:38', '/product/list', 'GET', 1, NULL, 8);
INSERT INTO `system_operation_log` VALUES ('1733737007236030465', '1', '查询调试所有设备', '0:0:0:0:0:0:0:1', '2023-12-10 14:34:46', '2023-12-10 14:34:46', '/device/debugDeviceList', 'GET', 1, NULL, 2);
INSERT INTO `system_operation_log` VALUES ('1733737011971399681', NULL, '查询产品字段集合', '0:0:0:0:0:0:0:1', '2023-12-10 14:34:50', '2023-12-10 14:34:50', '/productField/fieldList', 'GET', 1, NULL, 10);
INSERT INTO `system_operation_log` VALUES ('1733737045370642433', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 14:34:50', '2023-12-10 14:34:50', '/deviceLog/page', 'GET', 1, NULL, 31);
INSERT INTO `system_operation_log` VALUES ('1733737045437751297', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 14:34:56', '2023-12-10 14:34:56', '/deviceLog/page', 'GET', 1, NULL, 10);
INSERT INTO `system_operation_log` VALUES ('1733737085250084866', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 14:35:07', '2023-12-10 14:35:07', '/deviceLog/page', 'GET', 1, NULL, 9);
INSERT INTO `system_operation_log` VALUES ('1733737127214096385', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 14:35:17', '2023-12-10 14:35:17', '/deviceLog/page', 'GET', 1, NULL, 10);
INSERT INTO `system_operation_log` VALUES ('1733737168444104706', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 14:35:27', '2023-12-10 14:35:27', '/deviceLog/page', 'GET', 1, NULL, 14);
INSERT INTO `system_operation_log` VALUES ('1733737211116953602', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 14:35:37', '2023-12-10 14:35:37', '/deviceLog/page', 'GET', 1, NULL, 7);
INSERT INTO `system_operation_log` VALUES ('1733737253022244865', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 14:35:47', '2023-12-10 14:35:47', '/deviceLog/page', 'GET', 1, NULL, 10);
INSERT INTO `system_operation_log` VALUES ('1733737294948507650', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 14:35:57', '2023-12-10 14:35:57', '/deviceLog/page', 'GET', 1, NULL, 8);
INSERT INTO `system_operation_log` VALUES ('1733737336920907778', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 14:36:07', '2023-12-10 14:36:07', '/deviceLog/page', 'GET', 1, NULL, 8);
INSERT INTO `system_operation_log` VALUES ('1733737378863947777', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 14:36:17', '2023-12-10 14:36:17', '/deviceLog/page', 'GET', 1, NULL, 9);
INSERT INTO `system_operation_log` VALUES ('1733737420790210561', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 14:36:27', '2023-12-10 14:36:27', '/deviceLog/page', 'GET', 1, NULL, 11);
INSERT INTO `system_operation_log` VALUES ('1733737504726622210', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 14:36:47', '2023-12-10 14:36:47', '/deviceLog/page', 'GET', 1, NULL, 9);
INSERT INTO `system_operation_log` VALUES ('1733737533797343233', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-12-10 14:36:54', '2023-12-10 14:36:54', '/permission/getPerm', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1733737534992719873', '1', '查询调试所有设备', '0:0:0:0:0:0:0:1', '2023-12-10 14:36:54', '2023-12-10 14:36:54', '/device/debugDeviceList', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1733737979479891970', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-12-10 14:38:40', '2023-12-10 14:38:40', '/permission/getPerm', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1733737980721405954', '1', '查询调试所有设备', '0:0:0:0:0:0:0:1', '2023-12-10 14:38:41', '2023-12-10 14:38:41', '/device/debugDeviceList', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1733737994071875586', NULL, '查询产品字段集合', '0:0:0:0:0:0:0:1', '2023-12-10 14:38:44', '2023-12-10 14:38:44', '/productField/fieldList', 'GET', 1, NULL, 2);
INSERT INTO `system_operation_log` VALUES ('1733737994134790146', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 14:38:44', '2023-12-10 14:38:44', '/deviceLog/page', 'GET', 1, NULL, 14);
INSERT INTO `system_operation_log` VALUES ('1733738024832901122', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 14:38:51', '2023-12-10 14:38:51', '/deviceLog/page', 'GET', 1, NULL, 11);
INSERT INTO `system_operation_log` VALUES ('1733738064641040385', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 14:39:01', '2023-12-10 14:39:01', '/deviceLog/page', 'GET', 1, NULL, 10);
INSERT INTO `system_operation_log` VALUES ('1733738106584080386', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 14:39:11', '2023-12-10 14:39:11', '/deviceLog/page', 'GET', 1, NULL, 11);
INSERT INTO `system_operation_log` VALUES ('1733738148531314689', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 14:39:21', '2023-12-10 14:39:21', '/deviceLog/page', 'GET', 1, NULL, 11);
INSERT INTO `system_operation_log` VALUES ('1733738190474354690', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 14:39:31', '2023-12-10 14:39:31', '/deviceLog/page', 'GET', 1, NULL, 13);
INSERT INTO `system_operation_log` VALUES ('1733738196073750529', '1', '下发debug命令', '0:0:0:0:0:0:0:1', '2023-12-10 14:39:32', '2023-12-10 14:39:32', '/device/sendDebug', 'POST', 1, NULL, 14);
INSERT INTO `system_operation_log` VALUES ('1733738232371257346', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 14:39:41', '2023-12-10 14:39:41', '/deviceLog/page', 'GET', 1, NULL, 14);
INSERT INTO `system_operation_log` VALUES ('1733738239237332994', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2023-12-10 14:39:42', '2023-12-10 14:39:42', '/product/list', 'GET', 1, NULL, 1);
INSERT INTO `system_operation_log` VALUES ('1733738239346384898', NULL, '', '0:0:0:0:0:0:0:1', '2023-12-10 14:39:42', '2023-12-10 14:39:42', '/error', 'GET', 0, '系统错误请联系管理员', 3);
INSERT INTO `system_operation_log` VALUES ('1733738245189050369', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 14:39:44', '2023-12-10 14:39:44', '/product/page', 'GET', 1, NULL, 17);
INSERT INTO `system_operation_log` VALUES ('1733738274473680898', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-10 14:39:47', '2023-12-10 14:39:47', '/family/list', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1733738281293619201', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2023-12-10 14:39:47', '2023-12-10 14:39:47', '/product/list', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1733738281427836929', '1', '分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 14:39:47', '2023-12-10 14:39:47', '/device/page', 'GET', 1, NULL, 26);
INSERT INTO `system_operation_log` VALUES ('1733738287144673281', '1', '查询调试所有设备', '0:0:0:0:0:0:0:1', '2023-12-10 14:39:52', '2023-12-10 14:39:52', '/device/debugDeviceList', 'GET', 1, NULL, 1);
INSERT INTO `system_operation_log` VALUES ('1733740277543247873', NULL, '登录', '0:0:0:0:0:0:0:1', '2023-12-10 14:47:48', '2023-12-10 14:47:48', '/user/login', 'POST', 1, NULL, 95);
INSERT INTO `system_operation_log` VALUES ('1733740277606162434', '1', '查询个人信息', '0:0:0:0:0:0:0:1', '2023-12-10 14:47:48', '2023-12-10 14:47:48', '/user/info', 'GET', 1, NULL, 2);
INSERT INTO `system_operation_log` VALUES ('1733740277606162435', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-12-10 14:47:48', '2023-12-10 14:47:48', '/permission/getPerm', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1733740279350992898', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-12-10 14:47:49', '2023-12-10 14:47:49', '/floor/floorList', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1733740319536619521', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2023-12-10 14:47:49', '2023-12-10 14:47:49', '/dashboard/dashboardInfo', 'GET', 1, NULL, 10);
INSERT INTO `system_operation_log` VALUES ('1733740327463854081', '1', '权限树', '0:0:0:0:0:0:0:1', '2023-12-10 14:48:00', '2023-12-10 14:48:00', '/permission/allPermTree', 'GET', 1, NULL, 8);
INSERT INTO `system_operation_log` VALUES ('1733740327572905985', '1', '角色分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 14:48:00', '2023-12-10 14:48:00', '/permission/rolePage', 'GET', 1, NULL, 33);
INSERT INTO `system_operation_log` VALUES ('1733740557068443650', NULL, '', '0:0:0:0:0:0:0:1', '2023-12-10 14:48:55', '2023-12-10 14:48:55', '/error', 'GET', 0, '系统错误请联系管理员', 1);
INSERT INTO `system_operation_log` VALUES ('1733740557068443651', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2023-12-10 14:48:55', '2023-12-10 14:48:55', '/product/list', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1733740560860094466', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 14:48:56', '2023-12-10 14:48:56', '/product/page', 'GET', 1, NULL, 18);
INSERT INTO `system_operation_log` VALUES ('1733740573992460290', '1', '分页', '0:0:0:0:0:0:0:1', '2023-12-10 14:48:59', '2023-12-10 14:48:59', '/family/page', 'GET', 1, NULL, 16);
INSERT INTO `system_operation_log` VALUES ('1733740599133118466', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-10 14:49:01', '2023-12-10 14:49:01', '/family/list', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1733740599133118467', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 14:49:01', '2023-12-10 14:49:01', '/room/pageBackend', 'GET', 1, NULL, 15);
INSERT INTO `system_operation_log` VALUES ('1733740602845077505', '1', '角色下拉列表', '0:0:0:0:0:0:0:1', '2023-12-10 14:49:02', '2023-12-10 14:49:02', '/permission/roleList', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1733740616052940802', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-12-10 14:49:02', '2023-12-10 14:49:02', '/floor/floorList', 'GET', 1, NULL, 2);
INSERT INTO `system_operation_log` VALUES ('1733740641147461634', '1', '根据楼层id查询房间设备树', '0:0:0:0:0:0:0:1', '2023-12-10 14:49:02', '2023-12-10 14:49:02', '/device/roomDeviceTree', 'GET', 1, NULL, 9);
INSERT INTO `system_operation_log` VALUES ('1733741138835185666', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 14:51:14', '2023-12-10 14:51:14', '/product/page', 'GET', 1, NULL, 21);
INSERT INTO `system_operation_log` VALUES ('1733741152722526210', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2023-12-10 14:51:17', '2023-12-10 14:51:17', '/product/list', 'GET', 1, NULL, 2);
INSERT INTO `system_operation_log` VALUES ('1733741152722526211', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 14:51:17', '2023-12-10 14:51:17', '/frameware/page', 'GET', 1, NULL, 15);
INSERT INTO `system_operation_log` VALUES ('1733741165280272386', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2023-12-10 14:51:20', '2023-12-10 14:51:20', '/product/list', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1733741180908249089', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-10 14:51:20', '2023-12-10 14:51:20', '/family/list', 'GET', 1, NULL, 18);
INSERT INTO `system_operation_log` VALUES ('1733741194732675074', '1', '分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 14:51:20', '2023-12-10 14:51:20', '/device/page', 'GET', 1, NULL, 35);
INSERT INTO `system_operation_log` VALUES ('1733741257739509762', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-12-10 14:51:42', '2023-12-10 14:51:42', '/floor/floorList', 'GET', 1, NULL, 2);
INSERT INTO `system_operation_log` VALUES ('1733741273241657345', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-12-10 14:51:46', '2023-12-10 14:51:46', '/floor/floorList', 'GET', 1, NULL, 1);
INSERT INTO `system_operation_log` VALUES ('1733742951655317505', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 14:58:26', '2023-12-10 14:58:26', '/product/page', 'GET', 1, NULL, 20);
INSERT INTO `system_operation_log` VALUES ('1733742970315776001', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2023-12-10 14:58:30', '2023-12-10 14:58:30', '/product/list', 'GET', 1, NULL, 2);
INSERT INTO `system_operation_log` VALUES ('1733742970445799426', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 14:58:30', '2023-12-10 14:58:30', '/frameware/page', 'GET', 1, NULL, 17);
INSERT INTO `system_operation_log` VALUES ('1733742975093088258', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-10 14:58:31', '2023-12-10 14:58:31', '/family/list', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1733742993770323970', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2023-12-10 14:58:31', '2023-12-10 14:58:31', '/product/list', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1733743012355284993', '1', '分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 14:58:31', '2023-12-10 14:58:31', '/device/page', 'GET', 1, NULL, 25);
INSERT INTO `system_operation_log` VALUES ('1733743022383865858', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-12-10 14:58:43', '2023-12-10 14:58:43', '/floor/floorList', 'GET', 1, NULL, 1);
INSERT INTO `system_operation_log` VALUES ('1733743035528814593', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-12-10 14:58:46', '2023-12-10 14:58:46', '/floor/floorList', 'GET', 1, NULL, 2);
INSERT INTO `system_operation_log` VALUES ('1733743044366213121', '1', '楼层集合', '0:0:0:0:0:0:0:1', '2023-12-10 14:58:48', '2023-12-10 14:58:48', '/floor/floorList', 'GET', 1, NULL, 1);
INSERT INTO `system_operation_log` VALUES ('1733743087697567746', '1', '分页', '0:0:0:0:0:0:0:1', '2023-12-10 14:58:58', '2023-12-10 14:58:58', '/family/page', 'GET', 1, NULL, 17);
INSERT INTO `system_operation_log` VALUES ('1733743099177377793', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-10 14:59:01', '2023-12-10 14:59:01', '/family/list', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1733743099244486658', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 14:59:01', '2023-12-10 14:59:01', '/floor/pageBackend', 'GET', 1, NULL, 18);
INSERT INTO `system_operation_log` VALUES ('1733745289819418626', NULL, '登录', '0:0:0:0:0:0:0:1', '2023-12-10 15:07:43', '2023-12-10 15:07:43', '/user/login', 'POST', 1, NULL, 1142);
INSERT INTO `system_operation_log` VALUES ('1733745289878138881', '1', '查询个人信息', '0:0:0:0:0:0:0:1', '2023-12-10 15:07:43', '2023-12-10 15:07:43', '/user/info', 'GET', 1, NULL, 6);
INSERT INTO `system_operation_log` VALUES ('1733745290003968001', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-12-10 15:07:43', '2023-12-10 15:07:43', '/permission/getPerm', 'GET', 1, NULL, 46);
INSERT INTO `system_operation_log` VALUES ('1733745291786547201', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2023-12-10 15:07:44', '2023-12-10 15:07:44', '/dashboard/dashboardInfo', 'GET', 1, NULL, 44);
INSERT INTO `system_operation_log` VALUES ('1733745331884093442', '1', '根据家庭ID楼层集合', '0:0:0:0:0:0:0:1', '2023-12-10 15:07:44', '2023-12-10 15:07:44', '/floor/floorList', 'GET', 1, NULL, 39);
INSERT INTO `system_operation_log` VALUES ('1733745331884093443', '1', '分页', '0:0:0:0:0:0:0:1', '2023-12-10 15:07:47', '2023-12-10 15:07:47', '/family/page', 'GET', 1, NULL, 182);
INSERT INTO `system_operation_log` VALUES ('1733745334144823297', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-10 15:07:54', '2023-12-10 15:07:54', '/family/list', 'GET', 1, NULL, 9);
INSERT INTO `system_operation_log` VALUES ('1733745334245486594', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:07:54', '2023-12-10 15:07:54', '/floor/pageBackend', 'GET', 1, NULL, 38);
INSERT INTO `system_operation_log` VALUES ('1733745373919408130', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:07:59', '2023-12-10 15:07:59', '/floor/pageBackend', 'GET', 1, NULL, 17);
INSERT INTO `system_operation_log` VALUES ('1733745373919408131', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:07:57', '2023-12-10 15:07:57', '/floor/pageBackend', 'GET', 1, NULL, 31);
INSERT INTO `system_operation_log` VALUES ('1733745376142389249', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:08:00', '2023-12-10 15:08:00', '/floor/pageBackend', 'GET', 1, NULL, 13);
INSERT INTO `system_operation_log` VALUES ('1733745376272412674', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:08:02', '2023-12-10 15:08:02', '/floor/pageBackend', 'GET', 1, NULL, 16);
INSERT INTO `system_operation_log` VALUES ('1733745415883419649', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:08:13', '2023-12-10 15:08:13', '/floor/pageBackend', 'GET', 1, NULL, 18);
INSERT INTO `system_operation_log` VALUES ('1733745415883419650', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:08:11', '2023-12-10 15:08:11', '/floor/pageBackend', 'GET', 1, NULL, 17);
INSERT INTO `system_operation_log` VALUES ('1733745427396784129', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-10 15:08:16', '2023-12-10 15:08:16', '/family/list', 'GET', 1, NULL, 8);
INSERT INTO `system_operation_log` VALUES ('1733745427598110721', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:08:16', '2023-12-10 15:08:16', '/room/pageBackend', 'GET', 1, NULL, 39);
INSERT INTO `system_operation_log` VALUES ('1733745458006814721', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:08:18', '2023-12-10 15:08:18', '/room/pageBackend', 'GET', 1, NULL, 18);
INSERT INTO `system_operation_log` VALUES ('1733745458006814722', '1', '根据家庭ID楼层集合', '0:0:0:0:0:0:0:1', '2023-12-10 15:08:18', '2023-12-10 15:08:18', '/floor/floorList', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1733745469453070338', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:08:20', '2023-12-10 15:08:20', '/room/pageBackend', 'GET', 1, NULL, 18);
INSERT INTO `system_operation_log` VALUES ('1733745511526133762', '1', '根据家庭ID楼层集合', '0:0:0:0:0:0:0:1', '2023-12-10 15:08:36', '2023-12-10 15:08:36', '/floor/floorList', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1733745511568076802', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:08:36', '2023-12-10 15:08:36', '/room/pageBackend', 'GET', 1, NULL, 24);
INSERT INTO `system_operation_log` VALUES ('1733745519801495554', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:08:38', '2023-12-10 15:08:38', '/room/pageBackend', 'GET', 1, NULL, 19);
INSERT INTO `system_operation_log` VALUES ('1733745547408404482', '1', '根据家庭ID楼层集合', '0:0:0:0:0:0:0:1', '2023-12-10 15:08:45', '2023-12-10 15:08:45', '/floor/floorList', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1733745553574031361', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:08:45', '2023-12-10 15:08:45', '/room/pageBackend', 'GET', 1, NULL, 19);
INSERT INTO `system_operation_log` VALUES ('1733745556707176450', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:08:47', '2023-12-10 15:08:47', '/room/pageBackend', 'GET', 1, NULL, 19);
INSERT INTO `system_operation_log` VALUES ('1733745561887141889', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:08:48', '2023-12-10 15:08:48', '/room/pageBackend', 'GET', 1, NULL, 23);
INSERT INTO `system_operation_log` VALUES ('1733745589422747650', '1', '根据家庭ID楼层集合', '0:0:0:0:0:0:0:1', '2023-12-10 15:08:50', '2023-12-10 15:08:50', '/floor/floorList', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1733745595554820098', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:08:50', '2023-12-10 15:08:50', '/room/pageBackend', 'GET', 1, NULL, 22);
INSERT INTO `system_operation_log` VALUES ('1733745605709230081', '1', '根据家庭ID楼层集合', '0:0:0:0:0:0:0:1', '2023-12-10 15:08:59', '2023-12-10 15:08:59', '/floor/floorList', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1733745605843447809', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:08:59', '2023-12-10 15:08:59', '/room/pageBackend', 'GET', 1, NULL, 24);
INSERT INTO `system_operation_log` VALUES ('1733745631386759170', '1', '根据家庭ID楼层集合', '0:0:0:0:0:0:0:1', '2023-12-10 15:09:00', '2023-12-10 15:09:00', '/floor/floorList', 'GET', 1, NULL, 2);
INSERT INTO `system_operation_log` VALUES ('1733745637535608834', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:09:00', '2023-12-10 15:09:00', '/room/pageBackend', 'GET', 1, NULL, 24);
INSERT INTO `system_operation_log` VALUES ('1733745676727185409', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-10 15:09:15', '2023-12-10 15:09:15', '/family/list', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1733745676853014530', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:09:15', '2023-12-10 15:09:15', '/floor/pageBackend', 'GET', 1, NULL, 23);
INSERT INTO `system_operation_log` VALUES ('1733745724479336449', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:09:27', '2023-12-10 15:09:27', '/floor/pageBackend', 'GET', 1, NULL, 23);
INSERT INTO `system_operation_log` VALUES ('1733745767982657539', '1', '新增或修改楼层', '0:0:0:0:0:0:0:1', '2023-12-10 15:09:37', '2023-12-10 15:09:37', '/floor/addUpdate', 'POST', 1, NULL, 34);
INSERT INTO `system_operation_log` VALUES ('1733745768179789825', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:09:37', '2023-12-10 15:09:37', '/floor/pageBackend', 'GET', 1, NULL, 20);
INSERT INTO `system_operation_log` VALUES ('1733745844163801090', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-12-10 15:09:55', '2023-12-10 15:09:55', '/permission/getPerm', 'GET', 1, NULL, 6);
INSERT INTO `system_operation_log` VALUES ('1733745845510172674', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-10 15:09:56', '2023-12-10 15:09:56', '/family/list', 'GET', 1, NULL, 10);
INSERT INTO `system_operation_log` VALUES ('1733745845510172675', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:09:56', '2023-12-10 15:09:56', '/floor/pageBackend', 'GET', 1, NULL, 28);
INSERT INTO `system_operation_log` VALUES ('1733745871502274561', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:10:02', '2023-12-10 15:10:02', '/floor/pageBackend', 'GET', 1, NULL, 30);
INSERT INTO `system_operation_log` VALUES ('1733745908105965571', '1', '新增或修改楼层', '0:0:0:0:0:0:0:1', '2023-12-10 15:10:11', '2023-12-10 15:10:11', '/floor/addUpdate', 'POST', 1, NULL, 11);
INSERT INTO `system_operation_log` VALUES ('1733745908303097858', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:10:11', '2023-12-10 15:10:11', '/floor/pageBackend', 'GET', 1, NULL, 19);
INSERT INTO `system_operation_log` VALUES ('1733745921611624449', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-10 15:10:14', '2023-12-10 15:10:14', '/family/list', 'GET', 1, NULL, 6);
INSERT INTO `system_operation_log` VALUES ('1733745921771008001', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:10:14', '2023-12-10 15:10:14', '/room/pageBackend', 'GET', 1, NULL, 25);
INSERT INTO `system_operation_log` VALUES ('1733745950187417602', '1', '根据家庭ID楼层集合', '0:0:0:0:0:0:0:1', '2023-12-10 15:10:16', '2023-12-10 15:10:16', '/floor/floorList', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1733745950317441026', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:10:16', '2023-12-10 15:10:16', '/room/pageBackend', 'GET', 1, NULL, 24);
INSERT INTO `system_operation_log` VALUES ('1733745963672104962', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:10:18', '2023-12-10 15:10:18', '/room/pageBackend', 'GET', 1, NULL, 16);
INSERT INTO `system_operation_log` VALUES ('1733746028402798595', '1', '新增或修改房间', '0:0:0:0:0:0:0:1', '2023-12-10 15:10:39', '2023-12-10 15:10:39', '/room/addUpdate', 'POST', 1, NULL, 19);
INSERT INTO `system_operation_log` VALUES ('1733746028599930881', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:10:39', '2023-12-10 15:10:39', '/room/pageBackend', 'GET', 1, NULL, 24);
INSERT INTO `system_operation_log` VALUES ('1733746044609589249', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:10:43', '2023-12-10 15:10:43', '/room/pageBackend', 'GET', 1, NULL, 22);
INSERT INTO `system_operation_log` VALUES ('1733746061160312833', '1', '根据家庭ID楼层集合', '0:0:0:0:0:0:0:1', '2023-12-10 15:10:47', '2023-12-10 15:10:47', '/floor/floorList', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1733746070429724674', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:10:47', '2023-12-10 15:10:47', '/room/pageBackend', 'GET', 1, NULL, 21);
INSERT INTO `system_operation_log` VALUES ('1733746070626856961', '1', '根据家庭ID楼层集合', '0:0:0:0:0:0:0:1', '2023-12-10 15:10:48', '2023-12-10 15:10:48', '/floor/floorList', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1733746086665875458', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:10:49', '2023-12-10 15:10:49', '/room/pageBackend', 'GET', 1, NULL, 27);
INSERT INTO `system_operation_log` VALUES ('1733746242903699457', '1', '分页', '0:0:0:0:0:0:0:1', '2023-12-10 15:11:30', '2023-12-10 15:11:30', '/family/page', 'GET', 1, NULL, 19);
INSERT INTO `system_operation_log` VALUES ('1733746414312321026', '1', '新增或修改家庭', '0:0:0:0:0:0:0:1', '2023-12-10 15:12:11', '2023-12-10 15:12:11', '/family/addUpdate', 'POST', 1, NULL, 10);
INSERT INTO `system_operation_log` VALUES ('1733746414379429889', '1', '分页', '0:0:0:0:0:0:0:1', '2023-12-10 15:12:11', '2023-12-10 15:12:11', '/family/page', 'GET', 1, NULL, 22);
INSERT INTO `system_operation_log` VALUES ('1733746422101143553', '1', '分页', '0:0:0:0:0:0:0:1', '2023-12-10 15:12:13', '2023-12-10 15:12:13', '/family/page', 'GET', 1, NULL, 23);
INSERT INTO `system_operation_log` VALUES ('1733746442825199618', '1', '删除家庭', '0:0:0:0:0:0:0:1', '2023-12-10 15:12:18', '2023-12-10 15:12:18', '/family/delete/1723339965481418754', 'DELETE', 1, NULL, 11);
INSERT INTO `system_operation_log` VALUES ('1733746456301498370', '1', '分页', '0:0:0:0:0:0:0:1', '2023-12-10 15:12:18', '2023-12-10 15:12:18', '/family/page', 'GET', 1, NULL, 18);
INSERT INTO `system_operation_log` VALUES ('1733746456494436354', '1', '删除家庭', '0:0:0:0:0:0:0:1', '2023-12-10 15:12:20', '2023-12-10 15:12:20', '/family/delete/1723340008338817025', 'DELETE', 1, NULL, 8);
INSERT INTO `system_operation_log` VALUES ('1733746464174206977', '1', '分页', '0:0:0:0:0:0:0:1', '2023-12-10 15:12:20', '2023-12-10 15:12:20', '/family/page', 'GET', 1, NULL, 17);
INSERT INTO `system_operation_log` VALUES ('1733747143873753089', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-12-10 15:15:05', '2023-12-10 15:15:05', '/permission/getPerm', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1733747145262067714', '1', '分页', '0:0:0:0:0:0:0:1', '2023-12-10 15:15:06', '2023-12-10 15:15:06', '/family/page', 'GET', 1, NULL, 24);
INSERT INTO `system_operation_log` VALUES ('1733747160411893762', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-10 15:15:09', '2023-12-10 15:15:09', '/family/list', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1733747160546111489', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:15:09', '2023-12-10 15:15:09', '/floor/pageBackend', 'GET', 1, NULL, 21);
INSERT INTO `system_operation_log` VALUES ('1733747185909067778', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:15:12', '2023-12-10 15:15:12', '/floor/pageBackend', 'GET', 1, NULL, 17);
INSERT INTO `system_operation_log` VALUES ('1733747187347714050', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:15:14', '2023-12-10 15:15:14', '/floor/pageBackend', 'GET', 1, NULL, 19);
INSERT INTO `system_operation_log` VALUES ('1733747214036070401', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:15:22', '2023-12-10 15:15:22', '/floor/pageBackend', 'GET', 1, NULL, 26);
INSERT INTO `system_operation_log` VALUES ('1733747226795143170', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:15:25', '2023-12-10 15:15:25', '/floor/pageBackend', 'GET', 1, NULL, 16);
INSERT INTO `system_operation_log` VALUES ('1733747236911804418', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:15:27', '2023-12-10 15:15:27', '/floor/pageBackend', 'GET', 1, NULL, 15);
INSERT INTO `system_operation_log` VALUES ('1733747715284758530', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-10 15:17:21', '2023-12-10 15:17:21', '/family/list', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1733747715351867393', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:17:21', '2023-12-10 15:17:21', '/floor/pageBackend', 'GET', 1, NULL, 18);
INSERT INTO `system_operation_log` VALUES ('1733747894985519106', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-10 15:18:04', '2023-12-10 15:18:04', '/family/list', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1733747895052627970', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:18:04', '2023-12-10 15:18:04', '/floor/pageBackend', 'GET', 1, NULL, 21);
INSERT INTO `system_operation_log` VALUES ('1733747904649195521', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:18:07', '2023-12-10 15:18:07', '/floor/pageBackend', 'GET', 1, NULL, 16);
INSERT INTO `system_operation_log` VALUES ('1733747967307902977', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-10 15:18:22', '2023-12-10 15:18:22', '/family/list', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1733747967370817538', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:18:22', '2023-12-10 15:18:22', '/floor/pageBackend', 'GET', 1, NULL, 19);
INSERT INTO `system_operation_log` VALUES ('1733747975348383746', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:18:23', '2023-12-10 15:18:23', '/floor/pageBackend', 'GET', 1, NULL, 17);
INSERT INTO `system_operation_log` VALUES ('1733751356838211586', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-10 15:31:50', '2023-12-10 15:31:50', '/family/list', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1733751356964040705', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:31:50', '2023-12-10 15:31:50', '/floor/pageBackend', 'GET', 1, NULL, 20);
INSERT INTO `system_operation_log` VALUES ('1733751363586846722', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-12-10 15:31:51', '2023-12-10 15:31:51', '/permission/getPerm', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1733751364895469569', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-10 15:31:52', '2023-12-10 15:31:52', '/family/list', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1733751398907080706', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:31:52', '2023-12-10 15:31:52', '/floor/pageBackend', 'GET', 1, NULL, 23);
INSERT INTO `system_operation_log` VALUES ('1733751492029018113', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-10 15:32:22', '2023-12-10 15:32:22', '/family/list', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1733751492083544066', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:32:22', '2023-12-10 15:32:22', '/floor/pageBackend', 'GET', 1, NULL, 20);
INSERT INTO `system_operation_log` VALUES ('1733751503882121217', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:32:25', '2023-12-10 15:32:25', '/floor/pageBackend', 'GET', 1, NULL, 16);
INSERT INTO `system_operation_log` VALUES ('1733751554008248322', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-10 15:32:37', '2023-12-10 15:32:37', '/family/list', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1733751554146660354', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:32:37', '2023-12-10 15:32:37', '/floor/pageBackend', 'GET', 1, NULL, 18);
INSERT INTO `system_operation_log` VALUES ('1733751560341647362', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:32:38', '2023-12-10 15:32:38', '/floor/pageBackend', 'GET', 1, NULL, 16);
INSERT INTO `system_operation_log` VALUES ('1733751642357067777', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-10 15:32:58', '2023-12-10 15:32:58', '/family/list', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1733751642415788034', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:32:58', '2023-12-10 15:32:58', '/floor/pageBackend', 'GET', 1, NULL, 19);
INSERT INTO `system_operation_log` VALUES ('1733751650233970690', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:33:00', '2023-12-10 15:33:00', '/floor/pageBackend', 'GET', 1, NULL, 18);
INSERT INTO `system_operation_log` VALUES ('1733751868794957825', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-10 15:33:52', '2023-12-10 15:33:52', '/family/list', 'GET', 1, NULL, 2);
INSERT INTO `system_operation_log` VALUES ('1733751868866260994', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:33:52', '2023-12-10 15:33:52', '/floor/pageBackend', 'GET', 1, NULL, 16);
INSERT INTO `system_operation_log` VALUES ('1733751876114018306', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:33:53', '2023-12-10 15:33:53', '/floor/pageBackend', 'GET', 1, NULL, 16);
INSERT INTO `system_operation_log` VALUES ('1733751888583684098', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:33:56', '2023-12-10 15:33:56', '/floor/pageBackend', 'GET', 1, NULL, 17);
INSERT INTO `system_operation_log` VALUES ('1733751910880604162', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:34:01', '2023-12-10 15:34:01', '/floor/pageBackend', 'GET', 1, NULL, 15);
INSERT INTO `system_operation_log` VALUES ('1733751910880604163', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:33:58', '2023-12-10 15:33:58', '/floor/pageBackend', 'GET', 1, NULL, 16);
INSERT INTO `system_operation_log` VALUES ('1733751918115778561', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:34:03', '2023-12-10 15:34:03', '/floor/pageBackend', 'GET', 1, NULL, 16);
INSERT INTO `system_operation_log` VALUES ('1733751935140458497', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:34:08', '2023-12-10 15:34:08', '/floor/pageBackend', 'GET', 1, NULL, 17);
INSERT INTO `system_operation_log` VALUES ('1733751957403824130', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:34:13', '2023-12-10 15:34:13', '/floor/pageBackend', 'GET', 1, NULL, 17);
INSERT INTO `system_operation_log` VALUES ('1733752082129842177', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-10 15:34:43', '2023-12-10 15:34:43', '/family/list', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1733752082196951042', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:34:43', '2023-12-10 15:34:43', '/floor/pageBackend', 'GET', 1, NULL, 20);
INSERT INTO `system_operation_log` VALUES ('1733752089834778626', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:34:44', '2023-12-10 15:34:44', '/floor/pageBackend', 'GET', 1, NULL, 16);
INSERT INTO `system_operation_log` VALUES ('1733752320898985985', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-10 15:35:40', '2023-12-10 15:35:40', '/family/list', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1733752320936734721', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:35:40', '2023-12-10 15:35:40', '/floor/pageBackend', 'GET', 1, NULL, 20);
INSERT INTO `system_operation_log` VALUES ('1733752328842997762', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:35:41', '2023-12-10 15:35:41', '/floor/pageBackend', 'GET', 1, NULL, 15);
INSERT INTO `system_operation_log` VALUES ('1733752346291302401', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-12-10 15:35:46', '2023-12-10 15:35:46', '/permission/getPerm', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1733752362892357634', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-10 15:35:46', '2023-12-10 15:35:46', '/family/list', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1733752362955272194', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:35:46', '2023-12-10 15:35:46', '/floor/pageBackend', 'GET', 1, NULL, 23);
INSERT INTO `system_operation_log` VALUES ('1733752370916061186', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:35:50', '2023-12-10 15:35:50', '/floor/pageBackend', 'GET', 1, NULL, 16);
INSERT INTO `system_operation_log` VALUES ('1733752388335005697', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:35:52', '2023-12-10 15:35:52', '/floor/pageBackend', 'GET', 1, NULL, 16);
INSERT INTO `system_operation_log` VALUES ('1733752430651338754', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-10 15:36:06', '2023-12-10 15:36:06', '/family/list', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1733752430705864706', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:36:06', '2023-12-10 15:36:06', '/floor/pageBackend', 'GET', 1, NULL, 19);
INSERT INTO `system_operation_log` VALUES ('1733752438813454338', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:36:08', '2023-12-10 15:36:08', '/floor/pageBackend', 'GET', 1, NULL, 15);
INSERT INTO `system_operation_log` VALUES ('1733752466835599362', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:36:14', '2023-12-10 15:36:14', '/floor/pageBackend', 'GET', 1, NULL, 18);
INSERT INTO `system_operation_log` VALUES ('1733752477287804930', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:36:17', '2023-12-10 15:36:17', '/floor/pageBackend', 'GET', 1, NULL, 16);
INSERT INTO `system_operation_log` VALUES ('1733752503166660609', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:36:23', '2023-12-10 15:36:23', '/floor/pageBackend', 'GET', 1, NULL, 17);
INSERT INTO `system_operation_log` VALUES ('1733752512037613569', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:36:25', '2023-12-10 15:36:25', '/floor/pageBackend', 'GET', 1, NULL, 13);
INSERT INTO `system_operation_log` VALUES ('1733752555721289730', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:36:36', '2023-12-10 15:36:36', '/floor/pageBackend', 'GET', 1, NULL, 16);
INSERT INTO `system_operation_log` VALUES ('1733752593159647234', '1', '新增或修改楼层', '0:0:0:0:0:0:0:1', '2023-12-10 15:36:44', '2023-12-10 15:36:44', '/floor/addUpdate', 'POST', 1, NULL, 9);
INSERT INTO `system_operation_log` VALUES ('1733752593293864962', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:36:44', '2023-12-10 15:36:44', '/floor/pageBackend', 'GET', 1, NULL, 17);
INSERT INTO `system_operation_log` VALUES ('1733752839692447745', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-10 15:37:43', '2023-12-10 15:37:43', '/family/list', 'GET', 1, NULL, 10);
INSERT INTO `system_operation_log` VALUES ('1733752839726002178', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:37:43', '2023-12-10 15:37:43', '/floor/pageBackend', 'GET', 1, NULL, 26);
INSERT INTO `system_operation_log` VALUES ('1733752862475907074', '1', '新增或修改楼层', '0:0:0:0:0:0:0:1', '2023-12-10 15:37:49', '2023-12-10 15:37:49', '/floor/addUpdate', 'POST', 1, NULL, 6);
INSERT INTO `system_operation_log` VALUES ('1733752862610124801', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:37:49', '2023-12-10 15:37:49', '/floor/pageBackend', 'GET', 1, NULL, 16);
INSERT INTO `system_operation_log` VALUES ('1733753246686736385', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-10 15:39:20', '2023-12-10 15:39:20', '/family/list', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1733753246766428161', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:39:20', '2023-12-10 15:39:20', '/floor/pageBackend', 'GET', 1, NULL, 21);
INSERT INTO `system_operation_log` VALUES ('1733753272460734466', '1', '新增或修改楼层', '0:0:0:0:0:0:0:1', '2023-12-10 15:39:26', '2023-12-10 15:39:26', '/floor/addUpdate', 'POST', 1, NULL, 7);
INSERT INTO `system_operation_log` VALUES ('1733753272590757890', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:39:26', '2023-12-10 15:39:26', '/floor/pageBackend', 'GET', 1, NULL, 15);
INSERT INTO `system_operation_log` VALUES ('1733753446692122625', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-12-10 15:40:08', '2023-12-10 15:40:08', '/permission/getPerm', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1733753448030105601', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-10 15:40:08', '2023-12-10 15:40:08', '/family/list', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1733753448155934721', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:40:08', '2023-12-10 15:40:08', '/floor/pageBackend', 'GET', 1, NULL, 24);
INSERT INTO `system_operation_log` VALUES ('1733753468280205314', '1', '新增或修改楼层', '0:0:0:0:0:0:0:1', '2023-12-10 15:40:13', '2023-12-10 15:40:13', '/floor/addUpdate', 'POST', 1, NULL, 9);
INSERT INTO `system_operation_log` VALUES ('1733753488693882881', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:40:13', '2023-12-10 15:40:13', '/floor/pageBackend', 'GET', 1, NULL, 14);
INSERT INTO `system_operation_log` VALUES ('1733753560785580033', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-10 15:40:35', '2023-12-10 15:40:35', '/family/list', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1733753560856883201', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:40:35', '2023-12-10 15:40:35', '/floor/pageBackend', 'GET', 1, NULL, 18);
INSERT INTO `system_operation_log` VALUES ('1733753612451016705', '1', '新增或修改楼层', '0:0:0:0:0:0:0:1', '2023-12-10 15:40:47', '2023-12-10 15:40:47', '/floor/addUpdate', 'POST', 1, NULL, 9);
INSERT INTO `system_operation_log` VALUES ('1733753612581040130', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:40:47', '2023-12-10 15:40:47', '/floor/pageBackend', 'GET', 1, NULL, 15);
INSERT INTO `system_operation_log` VALUES ('1733754096989597697', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-10 15:42:43', '2023-12-10 15:42:43', '/family/list', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1733754097044123649', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:42:43', '2023-12-10 15:42:43', '/floor/pageBackend', 'GET', 1, NULL, 21);
INSERT INTO `system_operation_log` VALUES ('1733754141944147971', '1', '新增或修改楼层', '0:0:0:0:0:0:0:1', '2023-12-10 15:42:54', '2023-12-10 15:42:54', '/floor/addUpdate', 'POST', 1, NULL, 7);
INSERT INTO `system_operation_log` VALUES ('1733754142074171394', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:42:54', '2023-12-10 15:42:54', '/floor/pageBackend', 'GET', 1, NULL, 16);
INSERT INTO `system_operation_log` VALUES ('1733754172419960833', '1', '新增或修改楼层', '0:0:0:0:0:0:0:1', '2023-12-10 15:43:01', '2023-12-10 15:43:01', '/floor/addUpdate', 'POST', 1, NULL, 6);
INSERT INTO `system_operation_log` VALUES ('1733754172554178561', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:43:01', '2023-12-10 15:43:01', '/floor/pageBackend', 'GET', 1, NULL, 15);
INSERT INTO `system_operation_log` VALUES ('1733754195983560706', '1', '新增或修改楼层', '0:0:0:0:0:0:0:1', '2023-12-10 15:43:07', '2023-12-10 15:43:07', '/floor/addUpdate', 'POST', 1, NULL, 9);
INSERT INTO `system_operation_log` VALUES ('1733754196050669569', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:43:07', '2023-12-10 15:43:07', '/floor/pageBackend', 'GET', 1, NULL, 15);
INSERT INTO `system_operation_log` VALUES ('1733754217462591490', '1', '新增或修改楼层', '0:0:0:0:0:0:0:1', '2023-12-10 15:43:12', '2023-12-10 15:43:12', '/floor/addUpdate', 'POST', 1, NULL, 9);
INSERT INTO `system_operation_log` VALUES ('1733754217718444033', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:43:12', '2023-12-10 15:43:12', '/floor/pageBackend', 'GET', 1, NULL, 15);
INSERT INTO `system_operation_log` VALUES ('1733754239960838147', '1', '新增或修改楼层', '0:0:0:0:0:0:0:1', '2023-12-10 15:43:17', '2023-12-10 15:43:17', '/floor/addUpdate', 'POST', 1, NULL, 7);
INSERT INTO `system_operation_log` VALUES ('1733754240095055874', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:43:17', '2023-12-10 15:43:17', '/floor/pageBackend', 'GET', 1, NULL, 16);
INSERT INTO `system_operation_log` VALUES ('1733754264992444417', '1', '新增或修改楼层', '0:0:0:0:0:0:0:1', '2023-12-10 15:43:23', '2023-12-10 15:43:23', '/floor/addUpdate', 'POST', 1, NULL, 8);
INSERT INTO `system_operation_log` VALUES ('1733754265059553282', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:43:23', '2023-12-10 15:43:23', '/floor/pageBackend', 'GET', 1, NULL, 15);
INSERT INTO `system_operation_log` VALUES ('1733754294788780034', '1', '新增或修改楼层', '0:0:0:0:0:0:0:1', '2023-12-10 15:43:30', '2023-12-10 15:43:30', '/floor/addUpdate', 'POST', 1, NULL, 7);
INSERT INTO `system_operation_log` VALUES ('1733754294922997762', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:43:30', '2023-12-10 15:43:30', '/floor/pageBackend', 'GET', 1, NULL, 15);
INSERT INTO `system_operation_log` VALUES ('1733754330666856451', '1', '新增或修改楼层', '0:0:0:0:0:0:0:1', '2023-12-10 15:43:39', '2023-12-10 15:43:39', '/floor/addUpdate', 'POST', 1, NULL, 7);
INSERT INTO `system_operation_log` VALUES ('1733754330792685570', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:43:39', '2023-12-10 15:43:39', '/floor/pageBackend', 'GET', 1, NULL, 16);
INSERT INTO `system_operation_log` VALUES ('1733754354863796226', '1', '新增或修改楼层', '0:0:0:0:0:0:0:1', '2023-12-10 15:43:44', '2023-12-10 15:43:44', '/floor/addUpdate', 'POST', 1, NULL, 8);
INSERT INTO `system_operation_log` VALUES ('1733754354989625346', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:43:44', '2023-12-10 15:43:44', '/floor/pageBackend', 'GET', 1, NULL, 14);
INSERT INTO `system_operation_log` VALUES ('1733754410211831810', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-10 15:43:58', '2023-12-10 15:43:58', '/family/list', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1733754410274746369', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:43:58', '2023-12-10 15:43:58', '/floor/pageBackend', 'GET', 1, NULL, 19);
INSERT INTO `system_operation_log` VALUES ('1733754416746557442', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:43:59', '2023-12-10 15:43:59', '/floor/pageBackend', 'GET', 1, NULL, 14);
INSERT INTO `system_operation_log` VALUES ('1733754422555668482', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:44:01', '2023-12-10 15:44:01', '/floor/pageBackend', 'GET', 1, NULL, 13);
INSERT INTO `system_operation_log` VALUES ('1733754548133130241', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-10 15:44:31', '2023-12-10 15:44:31', '/family/list', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1733754548133130242', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:44:31', '2023-12-10 15:44:31', '/floor/pageBackend', 'GET', 1, NULL, 17);
INSERT INTO `system_operation_log` VALUES ('1733754554734964738', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:44:32', '2023-12-10 15:44:32', '/floor/pageBackend', 'GET', 1, NULL, 12);
INSERT INTO `system_operation_log` VALUES ('1733754559512276993', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:44:33', '2023-12-10 15:44:33', '/floor/pageBackend', 'GET', 1, NULL, 16);
INSERT INTO `system_operation_log` VALUES ('1733754599542714370', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:44:43', '2023-12-10 15:44:43', '/floor/pageBackend', 'GET', 1, NULL, 15);
INSERT INTO `system_operation_log` VALUES ('1733754605486043137', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:44:44', '2023-12-10 15:44:44', '/floor/pageBackend', 'GET', 1, NULL, 15);
INSERT INTO `system_operation_log` VALUES ('1733754611135770626', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:44:46', '2023-12-10 15:44:46', '/floor/pageBackend', 'GET', 1, NULL, 14);
INSERT INTO `system_operation_log` VALUES ('1733754617796325378', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:44:47', '2023-12-10 15:44:47', '/floor/pageBackend', 'GET', 1, NULL, 15);
INSERT INTO `system_operation_log` VALUES ('1733754641523503106', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:44:48', '2023-12-10 15:44:48', '/floor/pageBackend', 'GET', 1, NULL, 16);
INSERT INTO `system_operation_log` VALUES ('1733754647525552130', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:44:53', '2023-12-10 15:44:53', '/floor/pageBackend', 'GET', 1, NULL, 14);
INSERT INTO `system_operation_log` VALUES ('1733754653129142274', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:44:54', '2023-12-10 15:44:54', '/floor/pageBackend', 'GET', 1, NULL, 15);
INSERT INTO `system_operation_log` VALUES ('1733754697848811522', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:45:06', '2023-12-10 15:45:06', '/floor/pageBackend', 'GET', 1, NULL, 15);
INSERT INTO `system_operation_log` VALUES ('1733754702886170625', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:45:07', '2023-12-10 15:45:07', '/floor/pageBackend', 'GET', 1, NULL, 16);
INSERT INTO `system_operation_log` VALUES ('1733754715372613634', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:45:10', '2023-12-10 15:45:10', '/product/page', 'GET', 1, NULL, 55);
INSERT INTO `system_operation_log` VALUES ('1733754719722106882', '1', '分页', '0:0:0:0:0:0:0:1', '2023-12-10 15:45:11', '2023-12-10 15:45:11', '/family/page', 'GET', 1, NULL, 16);
INSERT INTO `system_operation_log` VALUES ('1733754959472717825', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-10 15:46:09', '2023-12-10 15:46:09', '/family/list', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1733754959539826689', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:46:09', '2023-12-10 15:46:09', '/floor/pageBackend', 'GET', 1, NULL, 18);
INSERT INTO `system_operation_log` VALUES ('1733754969429995522', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:46:11', '2023-12-10 15:46:11', '/floor/pageBackend', 'GET', 1, NULL, 15);
INSERT INTO `system_operation_log` VALUES ('1733754978510663681', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:46:13', '2023-12-10 15:46:13', '/floor/pageBackend', 'GET', 1, NULL, 15);
INSERT INTO `system_operation_log` VALUES ('1733755001524809730', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:46:15', '2023-12-10 15:46:15', '/floor/pageBackend', 'GET', 1, NULL, 17);
INSERT INTO `system_operation_log` VALUES ('1733755001659027458', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:46:19', '2023-12-10 15:46:19', '/floor/pageBackend', 'GET', 1, NULL, 17);
INSERT INTO `system_operation_log` VALUES ('1733755015399567361', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:46:22', '2023-12-10 15:46:22', '/floor/pageBackend', 'GET', 1, NULL, 14);
INSERT INTO `system_operation_log` VALUES ('1733755162833547266', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-10 15:46:57', '2023-12-10 15:46:57', '/family/list', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1733755162971959297', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:46:57', '2023-12-10 15:46:57', '/room/pageBackend', 'GET', 1, NULL, 17);
INSERT INTO `system_operation_log` VALUES ('1733755183821844481', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-10 15:47:02', '2023-12-10 15:47:02', '/family/list', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1733755183901536257', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:47:02', '2023-12-10 15:47:02', '/floor/pageBackend', 'GET', 1, NULL, 18);
INSERT INTO `system_operation_log` VALUES ('1733755230252789762', '1', '分页', '0:0:0:0:0:0:0:1', '2023-12-10 15:47:13', '2023-12-10 15:47:13', '/family/page', 'GET', 1, NULL, 17);
INSERT INTO `system_operation_log` VALUES ('1733755554409574402', '1', '分页', '0:0:0:0:0:0:0:1', '2023-12-10 15:48:30', '2023-12-10 15:48:30', '/family/page', 'GET', 1, NULL, 16);
INSERT INTO `system_operation_log` VALUES ('1733755567818764290', '1', '分页', '0:0:0:0:0:0:0:1', '2023-12-10 15:48:34', '2023-12-10 15:48:34', '/family/page', 'GET', 1, NULL, 16);
INSERT INTO `system_operation_log` VALUES ('1733755576538722306', '1', '分页', '0:0:0:0:0:0:0:1', '2023-12-10 15:48:36', '2023-12-10 15:48:36', '/family/page', 'GET', 1, NULL, 17);
INSERT INTO `system_operation_log` VALUES ('1733755713356918786', '1', '分页', '0:0:0:0:0:0:0:1', '2023-12-10 15:49:08', '2023-12-10 15:49:08', '/family/page', 'GET', 1, NULL, 16);
INSERT INTO `system_operation_log` VALUES ('1733755724689928193', '1', '分页', '0:0:0:0:0:0:0:1', '2023-12-10 15:49:11', '2023-12-10 15:49:11', '/family/page', 'GET', 1, NULL, 16);
INSERT INTO `system_operation_log` VALUES ('1733755731535032322', '1', '分页', '0:0:0:0:0:0:0:1', '2023-12-10 15:49:13', '2023-12-10 15:49:13', '/family/page', 'GET', 1, NULL, 15);
INSERT INTO `system_operation_log` VALUES ('1733755738187198466', '1', '分页', '0:0:0:0:0:0:0:1', '2023-12-10 15:49:14', '2023-12-10 15:49:14', '/family/page', 'GET', 1, NULL, 19);
INSERT INTO `system_operation_log` VALUES ('1733755755396427778', '1', '分页', '0:0:0:0:0:0:0:1', '2023-12-10 15:49:15', '2023-12-10 15:49:15', '/family/page', 'GET', 1, NULL, 15);
INSERT INTO `system_operation_log` VALUES ('1733755933218140161', '1', '分页', '0:0:0:0:0:0:0:1', '2023-12-10 15:50:01', '2023-12-10 15:50:01', '/family/page', 'GET', 1, NULL, 16);
INSERT INTO `system_operation_log` VALUES ('1733755954021888002', '1', '分页', '0:0:0:0:0:0:0:1', '2023-12-10 15:50:06', '2023-12-10 15:50:06', '/family/page', 'GET', 1, NULL, 15);
INSERT INTO `system_operation_log` VALUES ('1733755962171420673', '1', '分页', '0:0:0:0:0:0:0:1', '2023-12-10 15:50:08', '2023-12-10 15:50:08', '/family/page', 'GET', 1, NULL, 14);
INSERT INTO `system_operation_log` VALUES ('1733756007427960833', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-10 15:50:18', '2023-12-10 15:50:18', '/family/list', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1733756007566372866', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:50:18', '2023-12-10 15:50:18', '/floor/pageBackend', 'GET', 1, NULL, 20);
INSERT INTO `system_operation_log` VALUES ('1733756019817934850', '1', '分页', '0:0:0:0:0:0:0:1', '2023-12-10 15:50:21', '2023-12-10 15:50:21', '/family/page', 'GET', 1, NULL, 15);
INSERT INTO `system_operation_log` VALUES ('1733756027518676993', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-10 15:50:23', '2023-12-10 15:50:23', '/family/list', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1733756049513607170', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:50:23', '2023-12-10 15:50:23', '/floor/pageBackend', 'GET', 1, NULL, 18);
INSERT INTO `system_operation_log` VALUES ('1733756049580716033', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:50:26', '2023-12-10 15:50:26', '/floor/pageBackend', 'GET', 1, NULL, 15);
INSERT INTO `system_operation_log` VALUES ('1733756287091568642', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-10 15:51:25', '2023-12-10 15:51:25', '/family/list', 'GET', 1, NULL, 2);
INSERT INTO `system_operation_log` VALUES ('1733756287158677506', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:51:25', '2023-12-10 15:51:25', '/floor/pageBackend', 'GET', 1, NULL, 19);
INSERT INTO `system_operation_log` VALUES ('1733756296063184898', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:51:27', '2023-12-10 15:51:27', '/floor/pageBackend', 'GET', 1, NULL, 17);
INSERT INTO `system_operation_log` VALUES ('1733756301171847169', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:51:28', '2023-12-10 15:51:28', '/floor/pageBackend', 'GET', 1, NULL, 17);
INSERT INTO `system_operation_log` VALUES ('1733756329072357378', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:51:30', '2023-12-10 15:51:30', '/floor/pageBackend', 'GET', 1, NULL, 15);
INSERT INTO `system_operation_log` VALUES ('1733756642407837698', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-12-10 15:52:50', '2023-12-10 15:52:50', '/permission/getPerm', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1733756643712266242', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-10 15:52:50', '2023-12-10 15:52:50', '/family/list', 'GET', 1, NULL, 2);
INSERT INTO `system_operation_log` VALUES ('1733756643712266243', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:52:50', '2023-12-10 15:52:50', '/floor/pageBackend', 'GET', 1, NULL, 22);
INSERT INTO `system_operation_log` VALUES ('1733756920024625154', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-12-10 15:53:56', '2023-12-10 15:53:56', '/permission/getPerm', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1733756921492631553', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-10 15:53:56', '2023-12-10 15:53:56', '/family/list', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1733756921559740418', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:53:56', '2023-12-10 15:53:56', '/floor/pageBackend', 'GET', 1, NULL, 19);
INSERT INTO `system_operation_log` VALUES ('1733757306659762178', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-12-10 15:55:28', '2023-12-10 15:55:28', '/permission/getPerm', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1733757308056465410', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-10 15:55:29', '2023-12-10 15:55:29', '/family/list', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1733757308190683138', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:55:29', '2023-12-10 15:55:29', '/floor/pageBackend', 'GET', 1, NULL, 24);
INSERT INTO `system_operation_log` VALUES ('1733757327799054337', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:55:33', '2023-12-10 15:55:33', '/floor/pageBackend', 'GET', 1, NULL, 14);
INSERT INTO `system_operation_log` VALUES ('1733757348623773698', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:55:35', '2023-12-10 15:55:35', '/floor/pageBackend', 'GET', 1, NULL, 17);
INSERT INTO `system_operation_log` VALUES ('1733757350133723137', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:55:36', '2023-12-10 15:55:36', '/floor/pageBackend', 'GET', 1, NULL, 14);
INSERT INTO `system_operation_log` VALUES ('1733757350196637697', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:55:37', '2023-12-10 15:55:37', '/floor/pageBackend', 'GET', 1, NULL, 17);
INSERT INTO `system_operation_log` VALUES ('1733757369834369026', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:55:42', '2023-12-10 15:55:42', '/floor/pageBackend', 'GET', 1, NULL, 15);
INSERT INTO `system_operation_log` VALUES ('1733757405435621377', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:55:52', '2023-12-10 15:55:52', '/floor/pageBackend', 'GET', 1, NULL, 17);
INSERT INTO `system_operation_log` VALUES ('1733757688043630593', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-12-10 15:56:59', '2023-12-10 15:56:59', '/permission/getPerm', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1733757689436139522', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-10 15:56:59', '2023-12-10 15:56:59', '/family/list', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1733757689520025601', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:57:00', '2023-12-10 15:57:00', '/floor/pageBackend', 'GET', 1, NULL, 21);
INSERT INTO `system_operation_log` VALUES ('1733757714622935041', '1', '分页', '0:0:0:0:0:0:0:1', '2023-12-10 15:57:05', '2023-12-10 15:57:05', '/family/page', 'GET', 1, NULL, 16);
INSERT INTO `system_operation_log` VALUES ('1733757899793068033', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-12-10 15:57:50', '2023-12-10 15:57:50', '/permission/getPerm', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1733757901181382657', '1', '分页', '0:0:0:0:0:0:0:1', '2023-12-10 15:57:50', '2023-12-10 15:57:50', '/family/page', 'GET', 1, NULL, 19);
INSERT INTO `system_operation_log` VALUES ('1733758009885159426', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-10 15:58:16', '2023-12-10 15:58:16', '/family/list', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1733758009948073986', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:58:16', '2023-12-10 15:58:16', '/floor/pageBackend', 'GET', 1, NULL, 22);
INSERT INTO `system_operation_log` VALUES ('1733758018122772481', '1', '分页', '0:0:0:0:0:0:0:1', '2023-12-10 15:58:18', '2023-12-10 15:58:18', '/family/page', 'GET', 1, NULL, 17);
INSERT INTO `system_operation_log` VALUES ('1733758061579956225', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-10 15:58:28', '2023-12-10 15:58:28', '/family/list', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1733758061642870785', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:58:28', '2023-12-10 15:58:28', '/floor/pageBackend', 'GET', 1, NULL, 19);
INSERT INTO `system_operation_log` VALUES ('1733758138679652353', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:58:47', '2023-12-10 15:58:47', '/floor/pageBackend', 'GET', 1, NULL, 16);
INSERT INTO `system_operation_log` VALUES ('1733758144094498818', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:58:48', '2023-12-10 15:58:48', '/floor/pageBackend', 'GET', 1, NULL, 15);
INSERT INTO `system_operation_log` VALUES ('1733758151078014978', '1', '分页', '0:0:0:0:0:0:0:1', '2023-12-10 15:58:50', '2023-12-10 15:58:50', '/family/page', 'GET', 1, NULL, 16);
INSERT INTO `system_operation_log` VALUES ('1733758156232814593', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-10 15:58:51', '2023-12-10 15:58:51', '/family/list', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1733758180719161346', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:58:51', '2023-12-10 15:58:51', '/floor/pageBackend', 'GET', 1, NULL, 18);
INSERT INTO `system_operation_log` VALUES ('1733758241628844034', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-10 15:59:11', '2023-12-10 15:59:11', '/family/list', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1733758241704341505', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:59:11', '2023-12-10 15:59:11', '/room/pageBackend', 'GET', 1, NULL, 20);
INSERT INTO `system_operation_log` VALUES ('1733758264315834369', '1', '根据家庭ID楼层集合', '0:0:0:0:0:0:0:1', '2023-12-10 15:59:17', '2023-12-10 15:59:17', '/floor/floorList', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1733758264382943233', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:59:17', '2023-12-10 15:59:17', '/room/pageBackend', 'GET', 1, NULL, 19);
INSERT INTO `system_operation_log` VALUES ('1733758283685130242', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 15:59:20', '2023-12-10 15:59:20', '/room/pageBackend', 'GET', 1, NULL, 16);
INSERT INTO `system_operation_log` VALUES ('1733758477952708610', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-10 16:00:07', '2023-12-10 16:00:07', '/family/list', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1733758478015623169', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 16:00:07', '2023-12-10 16:00:07', '/room/pageBackend', 'GET', 1, NULL, 17);
INSERT INTO `system_operation_log` VALUES ('1733758482486751234', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-10 16:00:09', '2023-12-10 16:00:09', '/family/list', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1733758482553860098', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 16:00:09', '2023-12-10 16:00:09', '/floor/pageBackend', 'GET', 1, NULL, 19);
INSERT INTO `system_operation_log` VALUES ('1733758553777336322', '1', '分页', '0:0:0:0:0:0:0:1', '2023-12-10 16:00:26', '2023-12-10 16:00:26', '/family/page', 'GET', 1, NULL, 15);
INSERT INTO `system_operation_log` VALUES ('1733758593224765442', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-10 16:00:35', '2023-12-10 16:00:35', '/family/list', 'GET', 1, NULL, 2);
INSERT INTO `system_operation_log` VALUES ('1733758593358983169', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 16:00:35', '2023-12-10 16:00:35', '/floor/pageBackend', 'GET', 1, NULL, 20);
INSERT INTO `system_operation_log` VALUES ('1733758834544046082', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-10 16:01:33', '2023-12-10 16:01:33', '/family/list', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1733758834678263810', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 16:01:33', '2023-12-10 16:01:33', '/floor/pageBackend', 'GET', 1, NULL, 20);
INSERT INTO `system_operation_log` VALUES ('1733758839371689986', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-12-10 16:01:34', '2023-12-10 16:01:34', '/permission/getPerm', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1733758840709672961', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-10 16:01:34', '2023-12-10 16:01:34', '/family/list', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1733758876625498114', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 16:01:34', '2023-12-10 16:01:34', '/floor/pageBackend', 'GET', 1, NULL, 22);
INSERT INTO `system_operation_log` VALUES ('1733759221443424258', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-12-10 16:03:05', '2023-12-10 16:03:05', '/permission/getPerm', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1733759222970150913', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-10 16:03:05', '2023-12-10 16:03:05', '/family/list', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1733759223091785730', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 16:03:05', '2023-12-10 16:03:05', '/floor/pageBackend', 'GET', 1, NULL, 28);
INSERT INTO `system_operation_log` VALUES ('1733759412493971457', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-12-10 16:03:50', '2023-12-10 16:03:50', '/permission/getPerm', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1733759413886480385', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-10 16:03:51', '2023-12-10 16:03:51', '/family/list', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1733759413953589250', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 16:03:51', '2023-12-10 16:03:51', '/floor/pageBackend', 'GET', 1, NULL, 22);
INSERT INTO `system_operation_log` VALUES ('1733759778459578369', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-12-10 16:05:18', '2023-12-10 16:05:18', '/permission/getPerm', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1733759779915001857', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-10 16:05:18', '2023-12-10 16:05:18', '/family/list', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1733759780049219586', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 16:05:18', '2023-12-10 16:05:18', '/floor/pageBackend', 'GET', 1, NULL, 24);
INSERT INTO `system_operation_log` VALUES ('1733759877768114177', '1', '分页', '0:0:0:0:0:0:0:1', '2023-12-10 16:05:41', '2023-12-10 16:05:41', '/family/page', 'GET', 1, NULL, 17);
INSERT INTO `system_operation_log` VALUES ('1733760252483039233', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-12-10 16:07:11', '2023-12-10 16:07:11', '/permission/getPerm', 'GET', 1, NULL, 7);
INSERT INTO `system_operation_log` VALUES ('1733760254148177922', '1', '分页', '0:0:0:0:0:0:0:1', '2023-12-10 16:07:11', '2023-12-10 16:07:11', '/family/page', 'GET', 1, NULL, 20);
INSERT INTO `system_operation_log` VALUES ('1733761600544927746', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-10 16:12:32', '2023-12-10 16:12:32', '/family/list', 'GET', 1, NULL, 9);
INSERT INTO `system_operation_log` VALUES ('1733761600607842305', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 16:12:32', '2023-12-10 16:12:32', '/room/pageBackend', 'GET', 1, NULL, 17);
INSERT INTO `system_operation_log` VALUES ('1733761677065809921', '1', '根据家庭ID楼层集合', '0:0:0:0:0:0:0:1', '2023-12-10 16:12:50', '2023-12-10 16:12:50', '/floor/floorList', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1733761703565422593', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-10 16:12:57', '2023-12-10 16:12:57', '/family/list', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1733761703632531458', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 16:12:57', '2023-12-10 16:12:57', '/floor/pageBackend', 'GET', 1, NULL, 19);
INSERT INTO `system_operation_log` VALUES ('1733761713292013570', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 16:12:59', '2023-12-10 16:12:59', '/floor/pageBackend', 'GET', 1, NULL, 17);
INSERT INTO `system_operation_log` VALUES ('1733761722276212737', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 16:13:01', '2023-12-10 16:13:01', '/floor/pageBackend', 'GET', 1, NULL, 16);
INSERT INTO `system_operation_log` VALUES ('1733761745621708801', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 16:13:03', '2023-12-10 16:13:03', '/floor/pageBackend', 'GET', 1, NULL, 17);
INSERT INTO `system_operation_log` VALUES ('1733761765599178753', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-10 16:13:11', '2023-12-10 16:13:11', '/family/list', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1733761765666287617', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 16:13:11', '2023-12-10 16:13:11', '/room/pageBackend', 'GET', 1, NULL, 17);
INSERT INTO `system_operation_log` VALUES ('1733761792270757889', '1', '根据家庭ID楼层集合', '0:0:0:0:0:0:0:1', '2023-12-10 16:13:18', '2023-12-10 16:13:18', '/floor/floorList', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1733761812747350018', '1', '根据家庭ID楼层集合', '0:0:0:0:0:0:0:1', '2023-12-10 16:13:23', '2023-12-10 16:13:23', '/floor/floorList', 'GET', 1, NULL, 2);
INSERT INTO `system_operation_log` VALUES ('1733761977629634561', '1', '根据家庭ID楼层集合', '0:0:0:0:0:0:0:1', '2023-12-10 16:14:02', '2023-12-10 16:14:02', '/floor/floorList', 'GET', 1, NULL, 2);
INSERT INTO `system_operation_log` VALUES ('1733762032159780866', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-10 16:14:15', '2023-12-10 16:14:15', '/family/list', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1733762032226889730', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 16:14:15', '2023-12-10 16:14:15', '/floor/pageBackend', 'GET', 1, NULL, 21);
INSERT INTO `system_operation_log` VALUES ('1733762040376422401', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 16:14:17', '2023-12-10 16:14:17', '/floor/pageBackend', 'GET', 1, NULL, 17);
INSERT INTO `system_operation_log` VALUES ('1733762046240059393', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 16:14:18', '2023-12-10 16:14:18', '/floor/pageBackend', 'GET', 1, NULL, 17);
INSERT INTO `system_operation_log` VALUES ('1733762074186706946', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 16:14:19', '2023-12-10 16:14:19', '/floor/pageBackend', 'GET', 1, NULL, 16);
INSERT INTO `system_operation_log` VALUES ('1733762601792401410', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-12-10 16:16:31', '2023-12-10 16:16:31', '/permission/getPerm', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1733762603533037570', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-10 16:16:31', '2023-12-10 16:16:31', '/family/list', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1733762603533037571', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 16:16:31', '2023-12-10 16:16:31', '/floor/pageBackend', 'GET', 1, NULL, 29);
INSERT INTO `system_operation_log` VALUES ('1733762809716633601', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-12-10 16:17:20', '2023-12-10 16:17:20', '/permission/getPerm', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1733762810970730498', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-10 16:17:21', '2023-12-10 16:17:21', '/family/list', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1733762811037839361', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 16:17:21', '2023-12-10 16:17:21', '/floor/pageBackend', 'GET', 1, NULL, 18);
INSERT INTO `system_operation_log` VALUES ('1733762935461867522', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-12-10 16:17:50', '2023-12-10 16:17:50', '/permission/getPerm', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1733762937051508737', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-10 16:17:51', '2023-12-10 16:17:51', '/family/list', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1733762937118617602', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 16:17:51', '2023-12-10 16:17:51', '/floor/pageBackend', 'GET', 1, NULL, 17);
INSERT INTO `system_operation_log` VALUES ('1733763111874293761', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-12-10 16:18:32', '2023-12-10 16:18:32', '/permission/getPerm', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1733763113270996994', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-10 16:18:33', '2023-12-10 16:18:33', '/family/list', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1733763113409409025', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 16:18:33', '2023-12-10 16:18:33', '/floor/pageBackend', 'GET', 1, NULL, 30);
INSERT INTO `system_operation_log` VALUES ('1733763122511048706', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-10 16:18:35', '2023-12-10 16:18:35', '/family/list', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1733763153880248321', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 16:18:35', '2023-12-10 16:18:35', '/room/pageBackend', 'GET', 1, NULL, 20);
INSERT INTO `system_operation_log` VALUES ('1733763382998298626', '1', '根据家庭ID楼层集合', '0:0:0:0:0:0:0:1', '2023-12-10 16:19:37', '2023-12-10 16:19:37', '/floor/floorList', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1733763393354035202', '1', '根据家庭ID楼层集合', '0:0:0:0:0:0:0:1', '2023-12-10 16:19:39', '2023-12-10 16:19:39', '/floor/floorList', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1733763402711527426', '1', '根据家庭ID楼层集合', '0:0:0:0:0:0:0:1', '2023-12-10 16:19:42', '2023-12-10 16:19:42', '/floor/floorList', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1733763413226647554', '1', '根据家庭ID楼层集合', '0:0:0:0:0:0:0:1', '2023-12-10 16:19:44', '2023-12-10 16:19:44', '/floor/floorList', 'GET', 1, NULL, 2);
INSERT INTO `system_operation_log` VALUES ('1733763829750394881', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-10 16:21:23', '2023-12-10 16:21:23', '/family/list', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1733763829813309442', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 16:21:23', '2023-12-10 16:21:23', '/room/pageBackend', 'GET', 1, NULL, 20);
INSERT INTO `system_operation_log` VALUES ('1733763849702699009', '1', '根据家庭ID楼层集合', '0:0:0:0:0:0:0:1', '2023-12-10 16:21:28', '2023-12-10 16:21:28', '/floor/floorList', 'GET', 1, NULL, 2);
INSERT INTO `system_operation_log` VALUES ('1733763856329699329', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 16:21:30', '2023-12-10 16:21:30', '/room/pageBackend', 'GET', 1, NULL, 15);
INSERT INTO `system_operation_log` VALUES ('1733763871777320961', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 16:21:32', '2023-12-10 16:21:32', '/room/pageBackend', 'GET', 1, NULL, 14);
INSERT INTO `system_operation_log` VALUES ('1733763871840235521', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 16:21:33', '2023-12-10 16:21:33', '/room/pageBackend', 'GET', 1, NULL, 14);
INSERT INTO `system_operation_log` VALUES ('1733763891729625090', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 16:21:34', '2023-12-10 16:21:34', '/room/pageBackend', 'GET', 1, NULL, 14);
INSERT INTO `system_operation_log` VALUES ('1733763898314682369', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-10 16:21:35', '2023-12-10 16:21:35', '/room/pageBackend', 'GET', 1, NULL, 14);
INSERT INTO `system_operation_log` VALUES ('1735996630839156738', NULL, '登录', '0:0:0:0:0:0:0:1', '2023-12-16 20:13:45', '2023-12-16 20:13:45', '/user/login', 'POST', 1, NULL, 165);
INSERT INTO `system_operation_log` VALUES ('1735996631124369410', '1', '查询个人信息', '0:0:0:0:0:0:0:1', '2023-12-16 20:13:45', '2023-12-16 20:13:45', '/user/info', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1735996631187283970', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-12-16 20:13:45', '2023-12-16 20:13:45', '/permission/getPerm', 'GET', 1, NULL, 36);
INSERT INTO `system_operation_log` VALUES ('1735996632432992258', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2023-12-16 20:13:45', '2023-12-16 20:13:45', '/dashboard/dashboardInfo', 'GET', 1, NULL, 33);
INSERT INTO `system_operation_log` VALUES ('1735996672874471426', '1', '根据家庭ID楼层集合', '0:0:0:0:0:0:0:1', '2023-12-16 20:13:45', '2023-12-16 20:13:45', '/floor/floorList', 'GET', 1, NULL, 41);
INSERT INTO `system_operation_log` VALUES ('1735996673130323969', '1', '分页', '0:0:0:0:0:0:0:1', '2023-12-16 20:13:48', '2023-12-16 20:13:48', '/family/page', 'GET', 1, NULL, 101);
INSERT INTO `system_operation_log` VALUES ('1735996673193238530', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-16 20:13:51', '2023-12-16 20:13:51', '/family/list', 'GET', 1, NULL, 11);
INSERT INTO `system_operation_log` VALUES ('1735996674434752513', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-16 20:13:51', '2023-12-16 20:13:51', '/floor/pageBackend', 'GET', 1, NULL, 29);
INSERT INTO `system_operation_log` VALUES ('1735996714792345602', '1', '分页查询', '0:0:0:0:0:0:0:1', '2023-12-16 20:13:53', '2023-12-16 20:13:53', '/user/page', 'GET', 1, NULL, 40);
INSERT INTO `system_operation_log` VALUES ('1735996715115307010', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-12-16 20:13:55', '2023-12-16 20:13:55', '/product/page', 'GET', 1, NULL, 60);
INSERT INTO `system_operation_log` VALUES ('1735996715245330433', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2023-12-16 20:13:57', '2023-12-16 20:13:57', '/product/list', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1735996716419735554', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-12-16 20:13:57', '2023-12-16 20:13:57', '/frameware/page', 'GET', 1, NULL, 33);
INSERT INTO `system_operation_log` VALUES ('1735996756823465985', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-16 20:13:58', '2023-12-16 20:13:58', '/family/list', 'GET', 1, NULL, 6);
INSERT INTO `system_operation_log` VALUES ('1735996757083512833', NULL, '', '0:0:0:0:0:0:0:1', '2023-12-16 20:14:05', '2023-12-16 20:14:05', '/error', 'GET', 0, '系统错误请联系管理员', 11);
INSERT INTO `system_operation_log` VALUES ('1735996757209341953', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2023-12-16 20:14:05', '2023-12-16 20:14:05', '/product/list', 'GET', 1, NULL, 2);
INSERT INTO `system_operation_log` VALUES ('1735996758442467330', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-12-16 20:14:06', '2023-12-16 20:14:06', '/product/page', 'GET', 1, NULL, 22);
INSERT INTO `system_operation_log` VALUES ('1735996798854586370', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-12-16 20:14:08', '2023-12-16 20:14:08', '/frameware/page', 'GET', 1, NULL, 12);
INSERT INTO `system_operation_log` VALUES ('1735997096285265922', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2023-12-16 20:15:36', '2023-12-16 20:15:36', '/product/list', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1735997096285265923', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-12-16 20:15:36', '2023-12-16 20:15:36', '/frameware/page', 'GET', 1, NULL, 13);
INSERT INTO `system_operation_log` VALUES ('1735997110638174209', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2023-12-16 20:15:39', '2023-12-16 20:15:39', '/product/list', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1735997110638174210', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-16 20:15:39', '2023-12-16 20:15:39', '/family/list', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1735997138295414785', '1', '分页查询', '0:0:0:0:0:0:0:1', '2023-12-16 20:15:39', '2023-12-16 20:15:39', '/device/page', 'GET', 1, NULL, 24);
INSERT INTO `system_operation_log` VALUES ('1735997151511666690', '1', '根据家庭ID楼层集合', '0:0:0:0:0:0:0:1', '2023-12-16 20:15:49', '2023-12-16 20:15:49', '/floor/floorList', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1735997174903300097', '1', '根据家庭ID楼层集合', '0:0:0:0:0:0:0:1', '2023-12-16 20:15:54', '2023-12-16 20:15:54', '/floor/floorList', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1735997181144424449', '1', '查询调试所有设备', '0:0:0:0:0:0:0:1', '2023-12-16 20:15:56', '2023-12-16 20:15:56', '/device/debugDeviceList', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1735997188387987458', '1', '分页', '0:0:0:0:0:0:0:1', '2023-12-16 20:15:58', '2023-12-16 20:15:58', '/family/page', 'GET', 1, NULL, 16);
INSERT INTO `system_operation_log` VALUES ('1735997193597313026', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-16 20:15:59', '2023-12-16 20:15:59', '/family/list', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1735997216972169217', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-16 20:15:59', '2023-12-16 20:15:59', '/floor/pageBackend', 'GET', 1, NULL, 19);
INSERT INTO `system_operation_log` VALUES ('1735997223200710658', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-16 20:16:05', '2023-12-16 20:16:05', '/floor/pageBackend', 'GET', 1, NULL, 22);
INSERT INTO `system_operation_log` VALUES ('1735997230398136321', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-16 20:16:08', '2023-12-16 20:16:08', '/floor/pageBackend', 'GET', 1, NULL, 16);
INSERT INTO `system_operation_log` VALUES ('1735997252787331074', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-16 20:16:13', '2023-12-16 20:16:13', '/floor/pageBackend', 'GET', 1, NULL, 20);
INSERT INTO `system_operation_log` VALUES ('1735997274035675137', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-16 20:16:18', '2023-12-16 20:16:18', '/floor/pageBackend', 'GET', 1, NULL, 16);
INSERT INTO `system_operation_log` VALUES ('1735997283665797122', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-16 20:16:20', '2023-12-16 20:16:20', '/floor/pageBackend', 'GET', 1, NULL, 14);
INSERT INTO `system_operation_log` VALUES ('1735997297871904769', '1', '分页', '0:0:0:0:0:0:0:1', '2023-12-16 20:16:24', '2023-12-16 20:16:24', '/family/page', 'GET', 1, NULL, 16);
INSERT INTO `system_operation_log` VALUES ('1735997311977349121', '1', '分页', '0:0:0:0:0:0:0:1', '2023-12-16 20:16:27', '2023-12-16 20:16:27', '/family/page', 'GET', 1, NULL, 22);
INSERT INTO `system_operation_log` VALUES ('1735997317375418369', '1', '分页', '0:0:0:0:0:0:0:1', '2023-12-16 20:16:28', '2023-12-16 20:16:28', '/family/page', 'GET', 1, NULL, 14);
INSERT INTO `system_operation_log` VALUES ('1735997325692723202', '1', '分页', '0:0:0:0:0:0:0:1', '2023-12-16 20:16:30', '2023-12-16 20:16:30', '/family/page', 'GET', 1, NULL, 17);
INSERT INTO `system_operation_log` VALUES ('1735997339907219457', '1', '分页', '0:0:0:0:0:0:0:1', '2023-12-16 20:16:31', '2023-12-16 20:16:31', '/family/page', 'GET', 1, NULL, 17);
INSERT INTO `system_operation_log` VALUES ('1735997353979109378', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-16 20:16:32', '2023-12-16 20:16:32', '/family/list', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1735997359427510274', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-16 20:16:32', '2023-12-16 20:16:32', '/floor/pageBackend', 'GET', 1, NULL, 19);
INSERT INTO `system_operation_log` VALUES ('1735997564533170178', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-12-16 20:17:27', '2023-12-16 20:17:27', '/permission/getPerm', 'GET', 1, NULL, 6);
INSERT INTO `system_operation_log` VALUES ('1735997565187481602', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-16 20:17:28', '2023-12-16 20:17:28', '/family/list', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1735997565187481603', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-16 20:17:28', '2023-12-16 20:17:28', '/floor/pageBackend', 'GET', 1, NULL, 26);
INSERT INTO `system_operation_log` VALUES ('1735997570350669826', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-16 20:17:29', '2023-12-16 20:17:29', '/floor/pageBackend', 'GET', 1, NULL, 17);
INSERT INTO `system_operation_log` VALUES ('1735997606560096258', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-16 20:17:30', '2023-12-16 20:17:30', '/floor/pageBackend', 'GET', 1, NULL, 16);
INSERT INTO `system_operation_log` VALUES ('1735997607277322241', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-16 20:17:31', '2023-12-16 20:17:31', '/floor/pageBackend', 'GET', 1, NULL, 16);
INSERT INTO `system_operation_log` VALUES ('1735997607277322242', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-16 20:17:32', '2023-12-16 20:17:32', '/floor/pageBackend', 'GET', 1, NULL, 16);
INSERT INTO `system_operation_log` VALUES ('1735997612419538946', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-16 20:17:34', '2023-12-16 20:17:34', '/family/list', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1735997648536690689', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-16 20:17:34', '2023-12-16 20:17:34', '/room/pageBackend', 'GET', 1, NULL, 17);
INSERT INTO `system_operation_log` VALUES ('1735997649258110977', '1', '根据家庭ID楼层集合', '0:0:0:0:0:0:0:1', '2023-12-16 20:17:41', '2023-12-16 20:17:41', '/floor/floorList', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1735997649258110978', '1', '根据家庭ID楼层集合', '0:0:0:0:0:0:0:1', '2023-12-16 20:17:42', '2023-12-16 20:17:42', '/floor/floorList', 'GET', 1, NULL, 2);
INSERT INTO `system_operation_log` VALUES ('1735997654379356162', '1', '根据家庭ID楼层集合', '0:0:0:0:0:0:0:1', '2023-12-16 20:17:44', '2023-12-16 20:17:44', '/floor/floorList', 'GET', 1, NULL, 2);
INSERT INTO `system_operation_log` VALUES ('1735997690437787649', '1', '根据家庭ID楼层集合', '0:0:0:0:0:0:0:1', '2023-12-16 20:17:46', '2023-12-16 20:17:46', '/floor/floorList', 'GET', 1, NULL, 2);
INSERT INTO `system_operation_log` VALUES ('1735997691343757314', '1', '根据家庭ID楼层集合', '0:0:0:0:0:0:0:1', '2023-12-16 20:17:48', '2023-12-16 20:17:48', '/floor/floorList', 'GET', 1, NULL, 2);
INSERT INTO `system_operation_log` VALUES ('1735997772742615041', '1', '根据家庭ID楼层集合', '0:0:0:0:0:0:0:1', '2023-12-16 20:18:17', '2023-12-16 20:18:17', '/floor/floorList', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1735997782414680065', '1', '根据家庭ID楼层集合', '0:0:0:0:0:0:0:1', '2023-12-16 20:18:19', '2023-12-16 20:18:19', '/floor/floorList', 'GET', 1, NULL, 2);
INSERT INTO `system_operation_log` VALUES ('1735997898244579329', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-16 20:18:47', '2023-12-16 20:18:47', '/room/pageBackend', 'GET', 1, NULL, 15);
INSERT INTO `system_operation_log` VALUES ('1735997903692980226', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-16 20:18:48', '2023-12-16 20:18:48', '/room/pageBackend', 'GET', 1, NULL, 14);
INSERT INTO `system_operation_log` VALUES ('1735997924819689473', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-16 20:18:53', '2023-12-16 20:18:53', '/room/pageBackend', 'GET', 1, NULL, 14);
INSERT INTO `system_operation_log` VALUES ('1735997934630166530', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-16 20:18:56', '2023-12-16 20:18:56', '/room/pageBackend', 'GET', 1, NULL, 12);
INSERT INTO `system_operation_log` VALUES ('1735998006210158593', '1', '根据家庭ID楼层集合', '0:0:0:0:0:0:0:1', '2023-12-16 20:19:13', '2023-12-16 20:19:13', '/floor/floorList', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1735998013692796930', '1', '根据家庭ID楼层集合', '0:0:0:0:0:0:0:1', '2023-12-16 20:19:14', '2023-12-16 20:19:14', '/floor/floorList', 'GET', 1, NULL, 2);
INSERT INTO `system_operation_log` VALUES ('1735998019464159233', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-16 20:19:16', '2023-12-16 20:19:16', '/room/pageBackend', 'GET', 1, NULL, 15);
INSERT INTO `system_operation_log` VALUES ('1735998023553605633', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-16 20:19:17', '2023-12-16 20:19:17', '/room/pageBackend', 'GET', 1, NULL, 14);
INSERT INTO `system_operation_log` VALUES ('1735998048258056194', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-16 20:19:22', '2023-12-16 20:19:22', '/room/pageBackend', 'GET', 1, NULL, 17);
INSERT INTO `system_operation_log` VALUES ('1735998055749083138', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-16 20:19:23', '2023-12-16 20:19:23', '/room/pageBackend', 'GET', 1, NULL, 15);
INSERT INTO `system_operation_log` VALUES ('1735998061533028354', '1', '根据家庭ID楼层集合', '0:0:0:0:0:0:0:1', '2023-12-16 20:19:26', '2023-12-16 20:19:26', '/floor/floorList', 'GET', 1, NULL, 2);
INSERT INTO `system_operation_log` VALUES ('1735998066616524802', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-16 20:19:27', '2023-12-16 20:19:27', '/room/pageBackend', 'GET', 1, NULL, 15);
INSERT INTO `system_operation_log` VALUES ('1735998090222067714', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-16 20:19:29', '2023-12-16 20:19:29', '/room/pageBackend', 'GET', 1, NULL, 13);
INSERT INTO `system_operation_log` VALUES ('1735998097759232001', '1', '根据家庭ID楼层集合', '0:0:0:0:0:0:0:1', '2023-12-16 20:19:30', '2023-12-16 20:19:30', '/floor/floorList', 'GET', 1, NULL, 2);
INSERT INTO `system_operation_log` VALUES ('1735998103543177217', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-16 20:19:32', '2023-12-16 20:19:32', '/room/pageBackend', 'GET', 1, NULL, 16);
INSERT INTO `system_operation_log` VALUES ('1735998108618285057', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-16 20:19:33', '2023-12-16 20:19:33', '/room/pageBackend', 'GET', 1, NULL, 14);
INSERT INTO `system_operation_log` VALUES ('1735998132232216577', '1', '根据家庭ID楼层集合', '0:0:0:0:0:0:0:1', '2023-12-16 20:19:38', '2023-12-16 20:19:38', '/floor/floorList', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1735998139765186562', '1', '角色下拉列表', '0:0:0:0:0:0:0:1', '2023-12-16 20:19:38', '2023-12-16 20:19:38', '/permission/roleList', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1735998145519771650', '1', '根据楼层id查询房间设备树', '0:0:0:0:0:0:0:1', '2023-12-16 20:19:38', '2023-12-16 20:19:38', '/device/roomDeviceTree', 'GET', 1, NULL, 15);
INSERT INTO `system_operation_log` VALUES ('1735998150641016834', '1', '分页查询', '0:0:0:0:0:0:0:1', '2023-12-16 20:19:38', '2023-12-16 20:19:38', '/user/page', 'GET', 1, NULL, 22);
INSERT INTO `system_operation_log` VALUES ('1735998303405957122', '1', '角色下拉列表', '0:0:0:0:0:0:0:1', '2023-12-16 20:20:23', '2023-12-16 20:20:23', '/permission/roleList', 'GET', 1, NULL, 2);
INSERT INTO `system_operation_log` VALUES ('1735998303506620418', '1', '根据家庭ID楼层集合', '0:0:0:0:0:0:0:1', '2023-12-16 20:20:24', '2023-12-16 20:20:24', '/floor/floorList', 'GET', 1, NULL, 12);
INSERT INTO `system_operation_log` VALUES ('1735998303556952066', '1', '分页查询', '0:0:0:0:0:0:0:1', '2023-12-16 20:20:24', '2023-12-16 20:20:24', '/user/page', 'GET', 1, NULL, 27);
INSERT INTO `system_operation_log` VALUES ('1735998526756839426', '1', '根据家庭ID楼层集合', '0:0:0:0:0:0:0:1', '2023-12-16 20:21:17', '2023-12-16 20:21:17', '/floor/floorList', 'GET', 1, NULL, 2);
INSERT INTO `system_operation_log` VALUES ('1735998526756839427', '1', '角色下拉列表', '0:0:0:0:0:0:0:1', '2023-12-16 20:21:17', '2023-12-16 20:21:17', '/permission/roleList', 'GET', 1, NULL, 2);
INSERT INTO `system_operation_log` VALUES ('1735998526857502721', '1', '分页查询', '0:0:0:0:0:0:0:1', '2023-12-16 20:21:17', '2023-12-16 20:21:17', '/user/page', 'GET', 1, NULL, 20);
INSERT INTO `system_operation_log` VALUES ('1735998526857502722', '1', '根据楼层id查询房间设备树', '0:0:0:0:0:0:0:1', '2023-12-16 20:21:17', '2023-12-16 20:21:17', '/device/roomDeviceTree', 'GET', 1, NULL, 17);
INSERT INTO `system_operation_log` VALUES ('1735998568758599682', '1', '分页查询', '0:0:0:0:0:0:0:1', '2023-12-16 20:21:19', '2023-12-16 20:21:19', '/user/page', 'GET', 1, NULL, 16);
INSERT INTO `system_operation_log` VALUES ('1735998568825708545', '1', '分页查询', '0:0:0:0:0:0:0:1', '2023-12-16 20:21:20', '2023-12-16 20:21:20', '/user/page', 'GET', 1, NULL, 13);
INSERT INTO `system_operation_log` VALUES ('1735998568888623105', '1', '分页查询', '0:0:0:0:0:0:0:1', '2023-12-16 20:21:25', '2023-12-16 20:21:25', '/user/page', 'GET', 1, NULL, 29);
INSERT INTO `system_operation_log` VALUES ('1735998568888623106', '1', '分页查询', '0:0:0:0:0:0:0:1', '2023-12-16 20:21:22', '2023-12-16 20:21:22', '/user/page', 'GET', 1, NULL, 31);
INSERT INTO `system_operation_log` VALUES ('1735998610764554242', '1', '分页查询', '0:0:0:0:0:0:0:1', '2023-12-16 20:21:27', '2023-12-16 20:21:27', '/user/page', 'GET', 1, NULL, 9);
INSERT INTO `system_operation_log` VALUES ('1735998610831663105', '1', '分页查询', '0:0:0:0:0:0:0:1', '2023-12-16 20:21:29', '2023-12-16 20:21:29', '/user/page', 'GET', 1, NULL, 13);
INSERT INTO `system_operation_log` VALUES ('1735998610898771969', '1', '分页查询', '0:0:0:0:0:0:0:1', '2023-12-16 20:21:36', '2023-12-16 20:21:36', '/user/page', 'GET', 1, NULL, 14);
INSERT INTO `system_operation_log` VALUES ('1735998610898771970', '1', '分页查询', '0:0:0:0:0:0:0:1', '2023-12-16 20:21:31', '2023-12-16 20:21:31', '/user/page', 'GET', 1, NULL, 18);
INSERT INTO `system_operation_log` VALUES ('1735998652720177153', '1', '分页查询', '0:0:0:0:0:0:0:1', '2023-12-16 20:21:36', '2023-12-16 20:21:36', '/user/page', 'GET', 1, NULL, 10);
INSERT INTO `system_operation_log` VALUES ('1735998652850200577', '1', '分页查询', '0:0:0:0:0:0:0:1', '2023-12-16 20:21:38', '2023-12-16 20:21:38', '/user/page', 'GET', 1, NULL, 14);
INSERT INTO `system_operation_log` VALUES ('1735998652850200578', '1', '分页查询', '0:0:0:0:0:0:0:1', '2023-12-16 20:21:39', '2023-12-16 20:21:39', '/user/page', 'GET', 1, NULL, 10);
INSERT INTO `system_operation_log` VALUES ('1735998652850200579', '1', '分页查询', '0:0:0:0:0:0:0:1', '2023-12-16 20:21:40', '2023-12-16 20:21:40', '/user/page', 'GET', 1, NULL, 14);
INSERT INTO `system_operation_log` VALUES ('1735998912020439042', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-16 20:22:49', '2023-12-16 20:22:49', '/family/list', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1735998912083353601', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-16 20:22:49', '2023-12-16 20:22:49', '/floor/pageBackend', 'GET', 1, NULL, 18);
INSERT INTO `system_operation_log` VALUES ('1735998922552336385', '1', '分页', '0:0:0:0:0:0:0:1', '2023-12-16 20:22:51', '2023-12-16 20:22:51', '/family/page', 'GET', 1, NULL, 14);
INSERT INTO `system_operation_log` VALUES ('1735998930538291202', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-16 20:22:53', '2023-12-16 20:22:53', '/family/list', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1735998954030587906', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-16 20:22:53', '2023-12-16 20:22:53', '/room/pageBackend', 'GET', 1, NULL, 16);
INSERT INTO `system_operation_log` VALUES ('1735998954101891074', '1', '角色下拉列表', '0:0:0:0:0:0:0:1', '2023-12-16 20:22:57', '2023-12-16 20:22:57', '/permission/roleList', 'GET', 1, NULL, 2);
INSERT INTO `system_operation_log` VALUES ('1735998964566679554', '1', '根据家庭ID楼层集合', '0:0:0:0:0:0:0:1', '2023-12-16 20:22:57', '2023-12-16 20:22:57', '/floor/floorList', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1735998972632326146', '1', '根据楼层id查询房间设备树', '0:0:0:0:0:0:0:1', '2023-12-16 20:22:58', '2023-12-16 20:22:58', '/device/roomDeviceTree', 'GET', 1, NULL, 13);
INSERT INTO `system_operation_log` VALUES ('1735998996028153857', '1', '分页查询', '0:0:0:0:0:0:0:1', '2023-12-16 20:22:58', '2023-12-16 20:22:58', '/user/page', 'GET', 1, NULL, 20);
INSERT INTO `system_operation_log` VALUES ('1735998996091068418', '1', '分页', '0:0:0:0:0:0:0:1', '2023-12-16 20:22:59', '2023-12-16 20:22:59', '/family/page', 'GET', 1, NULL, 14);
INSERT INTO `system_operation_log` VALUES ('1735999006547468290', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-16 20:23:00', '2023-12-16 20:23:00', '/family/list', 'GET', 1, NULL, 2);
INSERT INTO `system_operation_log` VALUES ('1735999042828197889', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-16 20:23:20', '2023-12-16 20:23:20', '/family/list', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1735999042891112449', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-16 20:23:20', '2023-12-16 20:23:20', '/room/pageBackend', 'GET', 1, NULL, 16);
INSERT INTO `system_operation_log` VALUES ('1735999248634306561', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-12-16 20:24:09', '2023-12-16 20:24:09', '/permission/getPerm', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1735999249225703426', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-16 20:24:09', '2023-12-16 20:24:09', '/family/list', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1735999249292812290', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-16 20:24:09', '2023-12-16 20:24:09', '/room/pageBackend', 'GET', 1, NULL, 18);
INSERT INTO `system_operation_log` VALUES ('1735999259887624193', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-12-16 20:24:12', '2023-12-16 20:24:12', '/permission/getPerm', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1735999290657038337', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-16 20:24:12', '2023-12-16 20:24:12', '/family/list', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1735999291248435201', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-16 20:24:12', '2023-12-16 20:24:12', '/room/pageBackend', 'GET', 1, NULL, 25);
INSERT INTO `system_operation_log` VALUES ('1735999867596136449', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-12-16 20:26:36', '2023-12-16 20:26:36', '/permission/getPerm', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1735999868133007361', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-16 20:26:37', '2023-12-16 20:26:37', '/family/list', 'GET', 1, NULL, 7);
INSERT INTO `system_operation_log` VALUES ('1735999868242059265', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-16 20:26:37', '2023-12-16 20:26:37', '/room/pageBackend', 'GET', 1, NULL, 21);
INSERT INTO `system_operation_log` VALUES ('1735999873816289281', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-12-16 20:26:38', '2023-12-16 20:26:38', '/permission/getPerm', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1735999909618868226', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-16 20:26:38', '2023-12-16 20:26:38', '/family/list', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1735999910210265089', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-16 20:26:38', '2023-12-16 20:26:38', '/room/pageBackend', 'GET', 1, NULL, 19);
INSERT INTO `system_operation_log` VALUES ('1736000119577337858', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-12-16 20:27:36', '2023-12-16 20:27:36', '/permission/getPerm', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1736000120147763201', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-16 20:27:37', '2023-12-16 20:27:37', '/family/list', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1736000120147763202', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-16 20:27:37', '2023-12-16 20:27:37', '/room/pageBackend', 'GET', 1, NULL, 25);
INSERT INTO `system_operation_log` VALUES ('1736000615243407362', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-16 20:29:35', '2023-12-16 20:29:35', '/family/list', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1736000615260184578', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-16 20:29:35', '2023-12-16 20:29:35', '/floor/pageBackend', 'GET', 1, NULL, 18);
INSERT INTO `system_operation_log` VALUES ('1736000624177274881', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-16 20:29:37', '2023-12-16 20:29:37', '/family/list', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1736000624177274882', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-16 20:29:37', '2023-12-16 20:29:37', '/room/pageBackend', 'GET', 1, NULL, 16);
INSERT INTO `system_operation_log` VALUES ('1736001090978144257', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-12-16 20:31:28', '2023-12-16 20:31:28', '/permission/getPerm', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1736001091280134145', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-16 20:31:28', '2023-12-16 20:31:28', '/family/list', 'GET', 1, NULL, 6);
INSERT INTO `system_operation_log` VALUES ('1736001091351437313', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-16 20:31:28', '2023-12-16 20:31:28', '/room/pageBackend', 'GET', 1, NULL, 25);
INSERT INTO `system_operation_log` VALUES ('1736001181797408769', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-12-16 20:31:50', '2023-12-16 20:31:50', '/permission/getPerm', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1736001182132953089', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-16 20:31:50', '2023-12-16 20:31:50', '/family/list', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1736001182212644866', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-16 20:31:50', '2023-12-16 20:31:50', '/room/pageBackend', 'GET', 1, NULL, 19);
INSERT INTO `system_operation_log` VALUES ('1736001377105174529', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-12-16 20:32:36', '2023-12-16 20:32:36', '/permission/getPerm', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1736001377390387202', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-16 20:32:36', '2023-12-16 20:32:36', '/family/list', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1736001377461690370', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-16 20:32:36', '2023-12-16 20:32:36', '/room/pageBackend', 'GET', 1, NULL, 19);
INSERT INTO `system_operation_log` VALUES ('1736002374619717633', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-16 20:36:34', '2023-12-16 20:36:34', '/family/list', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1736002374636494849', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-16 20:36:34', '2023-12-16 20:36:34', '/room/pageBackend', 'GET', 1, NULL, 19);
INSERT INTO `system_operation_log` VALUES ('1736002405103919106', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-12-16 20:36:41', '2023-12-16 20:36:41', '/permission/getPerm', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1736002405766619138', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-16 20:36:42', '2023-12-16 20:36:42', '/family/list', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1736002416625672194', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-16 20:36:42', '2023-12-16 20:36:42', '/room/pageBackend', 'GET', 1, NULL, 19);
INSERT INTO `system_operation_log` VALUES ('1736002536905728001', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-16 20:37:13', '2023-12-16 20:37:13', '/family/list', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1736002536964448257', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-16 20:37:13', '2023-12-16 20:37:13', '/room/pageBackend', 'GET', 1, NULL, 17);
INSERT INTO `system_operation_log` VALUES ('1736002629700509698', '1', '角色下拉列表', '0:0:0:0:0:0:0:1', '2023-12-16 20:37:35', '2023-12-16 20:37:35', '/permission/roleList', 'GET', 1, NULL, 1);
INSERT INTO `system_operation_log` VALUES ('1736002629700509699', '1', '根据家庭ID楼层集合', '0:0:0:0:0:0:0:1', '2023-12-16 20:37:35', '2023-12-16 20:37:35', '/floor/floorList', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1736002629851504641', '1', '根据楼层id查询房间设备树', '0:0:0:0:0:0:0:1', '2023-12-16 20:37:35', '2023-12-16 20:37:35', '/device/roomDeviceTree', 'GET', 1, NULL, 20);
INSERT INTO `system_operation_log` VALUES ('1736002629851504642', '1', '分页查询', '0:0:0:0:0:0:0:1', '2023-12-16 20:37:35', '2023-12-16 20:37:35', '/user/page', 'GET', 1, NULL, 23);
INSERT INTO `system_operation_log` VALUES ('1736002709958516737', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-12-16 20:37:54', '2023-12-16 20:37:54', '/product/page', 'GET', 1, NULL, 19);
INSERT INTO `system_operation_log` VALUES ('1736002765344301057', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2023-12-16 20:38:07', '2023-12-16 20:38:07', '/product/list', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1736002765344301058', NULL, '', '0:0:0:0:0:0:0:1', '2023-12-16 20:38:07', '2023-12-16 20:38:07', '/error', 'GET', 0, '系统错误请联系管理员', 0);
INSERT INTO `system_operation_log` VALUES ('1736002779550408706', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-12-16 20:38:11', '2023-12-16 20:38:11', '/product/page', 'GET', 1, NULL, 17);
INSERT INTO `system_operation_log` VALUES ('1736004609294557186', NULL, '', '0:0:0:0:0:0:0:1', '2023-12-16 20:45:27', '2023-12-16 20:45:27', '/', 'GET', 0, '此接口没有任何数据', 0);
INSERT INTO `system_operation_log` VALUES ('1736004610259247105', NULL, '', '0:0:0:0:0:0:0:1', '2023-12-16 20:45:27', '2023-12-16 20:45:27', '/error', 'GET', 0, '系统错误请联系管理员', 0);
INSERT INTO `system_operation_log` VALUES ('1736004678022422529', NULL, '登录', '0:0:0:0:0:0:0:1', '2023-12-16 20:45:43', '2023-12-16 20:45:43', '/user/login', 'POST', 1, NULL, 94);
INSERT INTO `system_operation_log` VALUES ('1736004864685727745', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-12-16 20:46:28', '2023-12-16 20:46:28', '/scene/page', 'GET', 1, NULL, 30);
INSERT INTO `system_operation_log` VALUES ('1736005615319343106', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-12-16 20:49:27', '2023-12-16 20:49:27', '/permission/getPerm', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1736005616032374785', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-12-16 20:49:27', '2023-12-16 20:49:27', '/product/page', 'GET', 1, NULL, 26);
INSERT INTO `system_operation_log` VALUES ('1736005634449563650', '1', '分页', '0:0:0:0:0:0:0:1', '2023-12-16 20:49:31', '2023-12-16 20:49:31', '/family/page', 'GET', 1, NULL, 16);
INSERT INTO `system_operation_log` VALUES ('1736005645321199617', '1', '角色下拉列表', '0:0:0:0:0:0:0:1', '2023-12-16 20:49:34', '2023-12-16 20:49:34', '/permission/roleList', 'GET', 1, NULL, 1);
INSERT INTO `system_operation_log` VALUES ('1736005657312714753', '1', '根据家庭ID楼层集合', '0:0:0:0:0:0:0:1', '2023-12-16 20:49:34', '2023-12-16 20:49:34', '/floor/floorList', 'GET', 1, NULL, 2);
INSERT INTO `system_operation_log` VALUES ('1736005658025746434', '1', '分页查询', '0:0:0:0:0:0:0:1', '2023-12-16 20:49:34', '2023-12-16 20:49:34', '/user/page', 'GET', 1, NULL, 19);
INSERT INTO `system_operation_log` VALUES ('1736005676526821378', '1', '根据楼层id查询房间设备树', '0:0:0:0:0:0:0:1', '2023-12-16 20:49:34', '2023-12-16 20:49:34', '/device/roomDeviceTree', 'GET', 1, NULL, 12);
INSERT INTO `system_operation_log` VALUES ('1736005731946160129', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-16 20:49:55', '2023-12-16 20:49:55', '/family/list', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1736005732017463297', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-16 20:49:55', '2023-12-16 20:49:55', '/room/pageBackend', 'GET', 1, NULL, 24);
INSERT INTO `system_operation_log` VALUES ('1736005741794385922', '1', '角色下拉列表', '0:0:0:0:0:0:0:1', '2023-12-16 20:49:57', '2023-12-16 20:49:57', '/permission/roleList', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1736005741794385923', '1', '根据家庭ID楼层集合', '0:0:0:0:0:0:0:1', '2023-12-16 20:49:57', '2023-12-16 20:49:57', '/floor/floorList', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1736005774006640642', '1', '根据楼层id查询房间设备树', '0:0:0:0:0:0:0:1', '2023-12-16 20:49:57', '2023-12-16 20:49:57', '/device/roomDeviceTree', 'GET', 1, NULL, 14);
INSERT INTO `system_operation_log` VALUES ('1736005774073749505', '1', '分页查询', '0:0:0:0:0:0:0:1', '2023-12-16 20:49:57', '2023-12-16 20:49:57', '/user/page', 'GET', 1, NULL, 22);
INSERT INTO `system_operation_log` VALUES ('1736006052793638914', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-12-16 20:51:11', '2023-12-16 20:51:11', '/product/page', 'GET', 1, NULL, 18);
INSERT INTO `system_operation_log` VALUES ('1736006208146464769', NULL, '新增或修改产品', '0:0:0:0:0:0:0:1', '2023-12-16 20:51:48', '2023-12-16 20:51:48', '/product/addUpdate', 'POST', 1, NULL, 46);
INSERT INTO `system_operation_log` VALUES ('1736006208276488194', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-12-16 20:51:48', '2023-12-16 20:51:48', '/product/page', 'GET', 1, NULL, 22);
INSERT INTO `system_operation_log` VALUES ('1736006518206193665', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2023-12-16 20:53:02', '2023-12-16 20:53:02', '/product/list', 'GET', 1, NULL, 2);
INSERT INTO `system_operation_log` VALUES ('1736006518273302530', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-12-16 20:53:02', '2023-12-16 20:53:02', '/frameware/page', 'GET', 1, NULL, 15);
INSERT INTO `system_operation_log` VALUES ('1736006541803347970', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2023-12-16 20:53:08', '2023-12-16 20:53:08', '/product/list', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1736006541929177090', '1', '分页查询', '0:0:0:0:0:0:0:1', '2023-12-16 20:53:08', '2023-12-16 20:53:08', '/device/page', 'GET', 1, NULL, 23);
INSERT INTO `system_operation_log` VALUES ('1736006560270868482', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2023-12-16 20:53:10', '2023-12-16 20:53:10', '/product/list', 'GET', 1, NULL, 1);
INSERT INTO `system_operation_log` VALUES ('1736006560329588738', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-12-16 20:53:10', '2023-12-16 20:53:10', '/frameware/page', 'GET', 1, NULL, 13);
INSERT INTO `system_operation_log` VALUES ('1736006583805108225', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-16 20:53:11', '2023-12-16 20:53:11', '/family/list', 'GET', 1, NULL, 2);
INSERT INTO `system_operation_log` VALUES ('1736006583939325953', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2023-12-16 20:53:11', '2023-12-16 20:53:11', '/product/list', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1736006602276823042', '1', '分页查询', '0:0:0:0:0:0:0:1', '2023-12-16 20:53:11', '2023-12-16 20:53:11', '/device/page', 'GET', 1, NULL, 22);
INSERT INTO `system_operation_log` VALUES ('1736006602339737601', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-12-16 20:53:12', '2023-12-16 20:53:12', '/product/page', 'GET', 1, NULL, 19);
INSERT INTO `system_operation_log` VALUES ('1736006625869783042', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-16 20:53:18', '2023-12-16 20:53:18', '/family/list', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1736006625932697601', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2023-12-16 20:53:18', '2023-12-16 20:53:18', '/product/list', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1736007162019274753', '1', '根据家庭ID楼层集合', '0:0:0:0:0:0:0:1', '2023-12-16 20:55:36', '2023-12-16 20:55:36', '/floor/floorList', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1736007589028782081', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-16 20:57:17', '2023-12-16 20:57:17', '/family/list', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1736007589028782082', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2023-12-16 20:57:17', '2023-12-16 20:57:17', '/product/list', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1736007589154611201', '1', '分页查询', '0:0:0:0:0:0:0:1', '2023-12-16 20:57:17', '2023-12-16 20:57:17', '/device/page', 'GET', 1, NULL, 24);
INSERT INTO `system_operation_log` VALUES ('1736019694352162818', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2023-12-16 21:45:23', '2023-12-16 21:45:23', '/product/list', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1736019694352162819', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-16 21:45:23', '2023-12-16 21:45:23', '/family/list', 'GET', 1, NULL, 6);
INSERT INTO `system_operation_log` VALUES ('1736019694469603330', '1', '分页查询', '0:0:0:0:0:0:0:1', '2023-12-16 21:45:24', '2023-12-16 21:45:24', '/device/page', 'GET', 1, NULL, 28);
INSERT INTO `system_operation_log` VALUES ('1736040763930796033', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2023-12-16 23:09:07', '2023-12-16 23:09:07', '/product/list', 'GET', 1, NULL, 7);
INSERT INTO `system_operation_log` VALUES ('1736040770964643841', NULL, '登录', '0:0:0:0:0:0:0:1', '2023-12-16 23:09:09', '2023-12-16 23:09:09', '/user/login', 'POST', 1, NULL, 98);
INSERT INTO `system_operation_log` VALUES ('1736040771023364098', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-12-16 23:09:09', '2023-12-16 23:09:09', '/permission/getPerm', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1736040771023364099', '1', '查询个人信息', '0:0:0:0:0:0:0:1', '2023-12-16 23:09:09', '2023-12-16 23:09:09', '/user/info', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1736040806020636673', '1', '根据家庭ID楼层集合', '0:0:0:0:0:0:0:1', '2023-12-16 23:09:09', '2023-12-16 23:09:09', '/floor/floorList', 'GET', 1, NULL, 2);
INSERT INTO `system_operation_log` VALUES ('1736040812958015489', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2023-12-16 23:09:09', '2023-12-16 23:09:09', '/dashboard/dashboardInfo', 'GET', 1, NULL, 14);
INSERT INTO `system_operation_log` VALUES ('1736040813088038914', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-12-16 23:09:12', '2023-12-16 23:09:12', '/product/page', 'GET', 1, NULL, 22);
INSERT INTO `system_operation_log` VALUES ('1736040813088038915', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-16 23:09:15', '2023-12-16 23:09:15', '/family/list', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1736040848018202626', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2023-12-16 23:09:15', '2023-12-16 23:09:15', '/product/list', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1736040854980747266', '1', '根据楼层id查询房间列表', '0:0:0:0:0:0:0:1', '2023-12-16 23:09:18', '2023-12-16 23:09:18', '/room/roomListByFloorId', 'GET', 1, NULL, 11);
INSERT INTO `system_operation_log` VALUES ('1736040855110770689', '1', '根据楼层id查询房间列表', '0:0:0:0:0:0:0:1', '2023-12-16 23:09:21', '2023-12-16 23:09:21', '/room/roomListByFloorId', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1736040860647251970', '1', '根据楼层id查询房间列表', '0:0:0:0:0:0:0:1', '2023-12-16 23:09:30', '2023-12-16 23:09:30', '/room/roomListByFloorId', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1736041029237301250', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2023-12-16 23:10:10', '2023-12-16 23:10:10', '/product/list', 'GET', 1, NULL, 6);
INSERT INTO `system_operation_log` VALUES ('1736041029237301251', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-16 23:10:10', '2023-12-16 23:10:10', '/family/list', 'GET', 1, NULL, 13);
INSERT INTO `system_operation_log` VALUES ('1736041029363130370', '1', '分页查询', '0:0:0:0:0:0:0:1', '2023-12-16 23:10:10', '2023-12-16 23:10:10', '/device/page', 'GET', 1, NULL, 36);
INSERT INTO `system_operation_log` VALUES ('1736041046626885634', '1', '根据家庭ID楼层集合', '0:0:0:0:0:0:0:1', '2023-12-16 23:10:14', '2023-12-16 23:10:14', '/floor/floorList', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1736041071255838722', '1', '根据楼层id查询房间列表', '0:0:0:0:0:0:0:1', '2023-12-16 23:10:16', '2023-12-16 23:10:16', '/room/roomListByFloorId', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1736041071318753282', '1', '根据家庭ID楼层集合', '0:0:0:0:0:0:0:1', '2023-12-16 23:10:18', '2023-12-16 23:10:18', '/floor/floorList', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1736041071385862146', '1', '根据楼层id查询房间列表', '0:0:0:0:0:0:0:1', '2023-12-16 23:10:20', '2023-12-16 23:10:20', '/room/roomListByFloorId', 'GET', 1, NULL, 11);
INSERT INTO `system_operation_log` VALUES ('1736041114054516738', '1', '根据家庭ID楼层集合', '0:0:0:0:0:0:0:1', '2023-12-16 23:10:30', '2023-12-16 23:10:30', '/floor/floorList', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1736041127140745217', '1', '根据楼层id查询房间列表', '0:0:0:0:0:0:0:1', '2023-12-16 23:10:33', '2023-12-16 23:10:33', '/room/roomListByFloorId', 'GET', 1, NULL, 6);
INSERT INTO `system_operation_log` VALUES ('1736041204852809730', '1', '添加或修改设备', '0:0:0:0:0:0:0:1', '2023-12-16 23:10:52', '2023-12-16 23:10:52', '/device/addUpdate', 'POST', 1, NULL, 14);
INSERT INTO `system_operation_log` VALUES ('1736041205117050882', '1', '分页查询', '0:0:0:0:0:0:0:1', '2023-12-16 23:10:52', '2023-12-16 23:10:52', '/device/page', 'GET', 1, NULL, 24);
INSERT INTO `system_operation_log` VALUES ('1738471729954598913', NULL, '登录', '0:0:0:0:0:0:0:1', '2023-12-23 16:08:54', '2023-12-23 16:08:54', '/user/login', 'POST', 1, NULL, 465);
INSERT INTO `system_operation_log` VALUES ('1738471730311114754', '1', '查询个人信息', '0:0:0:0:0:0:0:1', '2023-12-23 16:08:54', '2023-12-23 16:08:54', '/user/info', 'GET', 1, NULL, 8);
INSERT INTO `system_operation_log` VALUES ('1738471730399195137', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-12-23 16:08:54', '2023-12-23 16:08:54', '/permission/getPerm', 'GET', 1, NULL, 40);
INSERT INTO `system_operation_log` VALUES ('1738471731804286977', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2023-12-23 16:08:55', '2023-12-23 16:08:55', '/dashboard/dashboardInfo', 'GET', 1, NULL, 29);
INSERT INTO `system_operation_log` VALUES ('1738471771989913602', '1', '根据家庭ID楼层集合', '0:0:0:0:0:0:0:1', '2023-12-23 16:08:55', '2023-12-23 16:08:55', '/floor/floorList', 'GET', 1, NULL, 36);
INSERT INTO `system_operation_log` VALUES ('1738471772321263617', '1', '分页', '0:0:0:0:0:0:0:1', '2023-12-23 16:09:03', '2023-12-23 16:09:03', '/family/page', 'GET', 1, NULL, 93);
INSERT INTO `system_operation_log` VALUES ('1738471775584432130', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-23 16:09:05', '2023-12-23 16:09:05', '/family/list', 'GET', 1, NULL, 8);
INSERT INTO `system_operation_log` VALUES ('1738471775651540994', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-23 16:09:05', '2023-12-23 16:09:05', '/floor/pageBackend', 'GET', 1, NULL, 28);
INSERT INTO `system_operation_log` VALUES ('1738471813907787777', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-23 16:09:06', '2023-12-23 16:09:06', '/family/list', 'GET', 1, NULL, 7);
INSERT INTO `system_operation_log` VALUES ('1738471814306246657', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-23 16:09:06', '2023-12-23 16:09:06', '/room/pageBackend', 'GET', 1, NULL, 48);
INSERT INTO `system_operation_log` VALUES ('1738471817623941122', '1', '根据家庭ID楼层集合', '0:0:0:0:0:0:0:1', '2023-12-23 16:09:07', '2023-12-23 16:09:07', '/floor/floorList', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1738471817691049986', '1', '角色下拉列表', '0:0:0:0:0:0:0:1', '2023-12-23 16:09:07', '2023-12-23 16:09:07', '/permission/roleList', 'GET', 1, NULL, 7);
INSERT INTO `system_operation_log` VALUES ('1738471855959879681', '1', '分页查询', '0:0:0:0:0:0:0:1', '2023-12-23 16:09:07', '2023-12-23 16:09:07', '/user/page', 'GET', 1, NULL, 38);
INSERT INTO `system_operation_log` VALUES ('1738471856282841089', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-23 16:09:16', '2023-12-23 16:09:16', '/family/list', 'GET', 1, NULL, 15);
INSERT INTO `system_operation_log` VALUES ('1738471859613118465', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-23 16:09:18', '2023-12-23 16:09:18', '/room/pageBackend', 'GET', 1, NULL, 15);
INSERT INTO `system_operation_log` VALUES ('1738471859676033025', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-12-23 16:09:21', '2023-12-23 16:09:21', '/product/page', 'GET', 1, NULL, 43);
INSERT INTO `system_operation_log` VALUES ('1738472046268035073', '1', '根据家庭ID楼层集合', '0:0:0:0:0:0:0:1', '2023-12-23 16:10:10', '2023-12-23 16:10:10', '/floor/floorList', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1738472046326755330', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2023-12-23 16:10:10', '2023-12-23 16:10:10', '/dashboard/dashboardInfo', 'GET', 1, NULL, 23);
INSERT INTO `system_operation_log` VALUES ('1738472050495893505', '1', '分页', '0:0:0:0:0:0:0:1', '2023-12-23 16:10:11', '2023-12-23 16:10:11', '/family/page', 'GET', 1, NULL, 16);
INSERT INTO `system_operation_log` VALUES ('1738472131508875265', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-12-23 16:10:30', '2023-12-23 16:10:30', '/product/page', 'GET', 1, NULL, 21);
INSERT INTO `system_operation_log` VALUES ('1738472144553160706', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2023-12-23 16:10:33', '2023-12-23 16:10:33', '/product/list', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1738472144687378434', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-12-23 16:10:33', '2023-12-23 16:10:33', '/frameware/page', 'GET', 1, NULL, 28);
INSERT INTO `system_operation_log` VALUES ('1738472163930845185', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-12-23 16:10:38', '2023-12-23 16:10:38', '/product/page', 'GET', 1, NULL, 25);
INSERT INTO `system_operation_log` VALUES ('1738472207580966914', '1', '分页', '0:0:0:0:0:0:0:1', '2023-12-23 16:10:48', '2023-12-23 16:10:48', '/family/page', 'GET', 1, NULL, 16);
INSERT INTO `system_operation_log` VALUES ('1738472213016784897', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-23 16:10:49', '2023-12-23 16:10:49', '/family/list', 'GET', 1, NULL, 6);
INSERT INTO `system_operation_log` VALUES ('1738472213083893761', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-23 16:10:50', '2023-12-23 16:10:50', '/floor/pageBackend', 'GET', 1, NULL, 22);
INSERT INTO `system_operation_log` VALUES ('1738472220931436546', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-23 16:10:51', '2023-12-23 16:10:51', '/floor/pageBackend', 'GET', 1, NULL, 18);
INSERT INTO `system_operation_log` VALUES ('1738472249616281602', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-23 16:10:53', '2023-12-23 16:10:53', '/floor/pageBackend', 'GET', 1, NULL, 17);
INSERT INTO `system_operation_log` VALUES ('1738472255010156546', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-23 16:10:59', '2023-12-23 16:10:59', '/floor/pageBackend', 'GET', 1, NULL, 20);
INSERT INTO `system_operation_log` VALUES ('1738472261410664450', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-23 16:11:01', '2023-12-23 16:11:01', '/floor/pageBackend', 'GET', 1, NULL, 17);
INSERT INTO `system_operation_log` VALUES ('1738472268947828737', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-23 16:11:03', '2023-12-23 16:11:03', '/family/list', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1738472291580293121', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-23 16:11:03', '2023-12-23 16:11:03', '/room/pageBackend', 'GET', 1, NULL, 18);
INSERT INTO `system_operation_log` VALUES ('1738472297003528193', '1', '根据家庭ID楼层集合', '0:0:0:0:0:0:0:1', '2023-12-23 16:11:04', '2023-12-23 16:11:04', '/floor/floorList', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1738472303504699393', '1', '根据家庭ID楼层集合', '0:0:0:0:0:0:0:1', '2023-12-23 16:11:06', '2023-12-23 16:11:06', '/floor/floorList', 'GET', 1, NULL, 2);
INSERT INTO `system_operation_log` VALUES ('1738472310987337730', '1', '根据家庭ID楼层集合', '0:0:0:0:0:0:0:1', '2023-12-23 16:11:09', '2023-12-23 16:11:09', '/floor/floorList', 'GET', 1, NULL, 2);
INSERT INTO `system_operation_log` VALUES ('1738472333582053377', '1', '根据家庭ID楼层集合', '0:0:0:0:0:0:0:1', '2023-12-23 16:11:11', '2023-12-23 16:11:11', '/floor/floorList', 'GET', 1, NULL, 1);
INSERT INTO `system_operation_log` VALUES ('1738472338988511233', '1', '根据家庭ID楼层集合', '0:0:0:0:0:0:0:1', '2023-12-23 16:11:12', '2023-12-23 16:11:12', '/floor/floorList', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1738472345527431169', '1', '根据家庭ID楼层集合', '0:0:0:0:0:0:0:1', '2023-12-23 16:11:16', '2023-12-23 16:11:16', '/floor/floorList', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1738472352989097985', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-23 16:11:17', '2023-12-23 16:11:17', '/room/pageBackend', 'GET', 1, NULL, 16);
INSERT INTO `system_operation_log` VALUES ('1738472375583813633', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-23 16:11:19', '2023-12-23 16:11:19', '/room/pageBackend', 'GET', 1, NULL, 17);
INSERT INTO `system_operation_log` VALUES ('1738472380977688577', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-23 16:11:21', '2023-12-23 16:11:21', '/room/pageBackend', 'GET', 1, NULL, 14);
INSERT INTO `system_operation_log` VALUES ('1738472387495636993', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-23 16:11:22', '2023-12-23 16:11:22', '/room/pageBackend', 'GET', 1, NULL, 16);
INSERT INTO `system_operation_log` VALUES ('1738472394969886722', '1', '根据家庭ID楼层集合', '0:0:0:0:0:0:0:1', '2023-12-23 16:11:23', '2023-12-23 16:11:23', '/floor/floorList', 'GET', 1, NULL, 2);
INSERT INTO `system_operation_log` VALUES ('1738472417589768193', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-12-23 16:11:32', '2023-12-23 16:11:32', '/product/page', 'GET', 1, NULL, 23);
INSERT INTO `system_operation_log` VALUES ('1738472422987837441', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2023-12-23 16:11:37', '2023-12-23 16:11:37', '/product/list', 'GET', 1, NULL, 2);
INSERT INTO `system_operation_log` VALUES ('1738472429509980161', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-12-23 16:11:37', '2023-12-23 16:11:37', '/frameware/page', 'GET', 1, NULL, 12);
INSERT INTO `system_operation_log` VALUES ('1738472436996812802', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2023-12-23 16:11:40', '2023-12-23 16:11:40', '/product/list', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1738472459566362625', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-23 16:11:40', '2023-12-23 16:11:40', '/family/list', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1738472464951848961', '1', '分页查询', '0:0:0:0:0:0:0:1', '2023-12-23 16:11:40', '2023-12-23 16:11:40', '/device/page', 'GET', 1, NULL, 22);
INSERT INTO `system_operation_log` VALUES ('1738472471532711938', '1', '根据家庭ID楼层集合', '0:0:0:0:0:0:0:1', '2023-12-23 16:11:48', '2023-12-23 16:11:48', '/floor/floorList', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1738472478994378754', '1', '根据家庭ID楼层集合', '0:0:0:0:0:0:0:1', '2023-12-23 16:11:51', '2023-12-23 16:11:51', '/floor/floorList', 'GET', 1, NULL, 7);
INSERT INTO `system_operation_log` VALUES ('1738472501542957057', '1', '根据家庭ID楼层集合', '0:0:0:0:0:0:0:1', '2023-12-23 16:11:54', '2023-12-23 16:11:54', '/floor/floorList', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1738472506970386433', '1', '根据楼层id查询房间列表', '0:0:0:0:0:0:0:1', '2023-12-23 16:11:57', '2023-12-23 16:11:57', '/room/roomListByFloorId', 'GET', 1, NULL, 8);
INSERT INTO `system_operation_log` VALUES ('1738476814059220993', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-12-23 16:29:06', '2023-12-23 16:29:06', '/permission/getPerm', 'GET', 1, NULL, 42);
INSERT INTO `system_operation_log` VALUES ('1738476814151495682', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2023-12-23 16:29:06', '2023-12-23 16:29:06', '/product/list', 'GET', 1, NULL, 73);
INSERT INTO `system_operation_log` VALUES ('1738476814193438722', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-23 16:29:06', '2023-12-23 16:29:06', '/family/list', 'GET', 1, NULL, 76);
INSERT INTO `system_operation_log` VALUES ('1738476814860333058', '1', '分页查询', '0:0:0:0:0:0:0:1', '2023-12-23 16:29:07', '2023-12-23 16:29:07', '/device/page', 'GET', 1, NULL, 243);
INSERT INTO `system_operation_log` VALUES ('1738476950298603522', '1', '根据家庭ID楼层集合', '0:0:0:0:0:0:0:1', '2023-12-23 16:29:39', '2023-12-23 16:29:39', '/floor/floorList', 'GET', 1, NULL, 13);
INSERT INTO `system_operation_log` VALUES ('1738476959660290050', '1', '根据楼层id查询房间列表', '0:0:0:0:0:0:0:1', '2023-12-23 16:29:41', '2023-12-23 16:29:41', '/room/roomListByFloorId', 'GET', 1, NULL, 7);
INSERT INTO `system_operation_log` VALUES ('1738477246802341890', '1', '添加或修改设备', '0:0:0:0:0:0:0:1', '2023-12-23 16:30:50', '2023-12-23 16:30:50', '/device/addUpdate', 'POST', 1, NULL, 59);
INSERT INTO `system_operation_log` VALUES ('1738477247003668481', '1', '分页查询', '0:0:0:0:0:0:0:1', '2023-12-23 16:30:50', '2023-12-23 16:30:50', '/device/page', 'GET', 1, NULL, 31);
INSERT INTO `system_operation_log` VALUES ('1738477299507965954', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-12-23 16:31:02', '2023-12-23 16:31:02', '/permission/getPerm', 'GET', 1, NULL, 17);
INSERT INTO `system_operation_log` VALUES ('1738477300137111554', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-23 16:31:02', '2023-12-23 16:31:02', '/family/list', 'GET', 1, NULL, 13);
INSERT INTO `system_operation_log` VALUES ('1738477300137111555', '1', '查询产品下拉', '0:0:0:0:0:0:0:1', '2023-12-23 16:31:02', '2023-12-23 16:31:02', '/product/list', 'GET', 1, NULL, 19);
INSERT INTO `system_operation_log` VALUES ('1738477300342632449', '1', '分页查询', '0:0:0:0:0:0:0:1', '2023-12-23 16:31:02', '2023-12-23 16:31:02', '/device/page', 'GET', 1, NULL, 36);
INSERT INTO `system_operation_log` VALUES ('1738477485491793921', '1', '分页查询', '0:0:0:0:0:0:0:1', '2023-12-23 16:31:47', '2023-12-23 16:31:47', '/device/page', 'GET', 1, NULL, 27);
INSERT INTO `system_operation_log` VALUES ('1738478090528534529', '1', '查询调试所有设备', '0:0:0:0:0:0:0:1', '2023-12-23 16:34:11', '2023-12-23 16:34:11', '/device/debugDeviceList', 'GET', 1, NULL, 14);
INSERT INTO `system_operation_log` VALUES ('1738478140755324930', NULL, '查询产品字段集合', '0:0:0:0:0:0:0:1', '2023-12-23 16:34:23', '2023-12-23 16:34:23', '/productField/fieldList', 'GET', 1, NULL, 40);
INSERT INTO `system_operation_log` VALUES ('1738478141153783809', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-12-23 16:34:23', '2023-12-23 16:34:23', '/deviceLog/page', 'GET', 1, NULL, 79);
INSERT INTO `system_operation_log` VALUES ('1738478174351699969', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-12-23 16:34:31', '2023-12-23 16:34:31', '/deviceLog/page', 'GET', 1, NULL, 17);
INSERT INTO `system_operation_log` VALUES ('1738478216324100098', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-12-23 16:34:41', '2023-12-23 16:34:41', '/deviceLog/page', 'GET', 1, NULL, 19);
INSERT INTO `system_operation_log` VALUES ('1738478231322931202', '1', '下发debug命令', '0:0:0:0:0:0:0:1', '2023-12-23 16:34:44', '2023-12-23 16:34:44', '/device/sendDebug', 'POST', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1738478258258751490', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-12-23 16:34:51', '2023-12-23 16:34:51', '/deviceLog/page', 'GET', 1, NULL, 13);
INSERT INTO `system_operation_log` VALUES ('1738478297068646401', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2023-12-23 16:35:00', '2023-12-23 16:35:00', '/product/list', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1738478376416489473', NULL, '', '0:0:0:0:0:0:0:1', '2023-12-23 16:35:19', '2023-12-23 16:35:19', '/error', 'GET', 0, '系统错误请联系管理员', 18861);
INSERT INTO `system_operation_log` VALUES ('1738478437733019649', '1', '权限树', '0:0:0:0:0:0:0:1', '2023-12-23 16:35:34', '2023-12-23 16:35:34', '/permission/allPermTree', 'GET', 1, NULL, 14);
INSERT INTO `system_operation_log` VALUES ('1738478437854654466', '1', '角色分页查询', '0:0:0:0:0:0:0:1', '2023-12-23 16:35:34', '2023-12-23 16:35:34', '/permission/rolePage', 'GET', 1, NULL, 56);
INSERT INTO `system_operation_log` VALUES ('1738478627227480065', '1', '根据家庭ID楼层集合', '0:0:0:0:0:0:0:1', '2023-12-23 16:36:19', '2023-12-23 16:36:19', '/floor/floorList', 'GET', 1, NULL, 22);
INSERT INTO `system_operation_log` VALUES ('1738478627227480066', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2023-12-23 16:36:19', '2023-12-23 16:36:19', '/dashboard/dashboardInfo', 'GET', 1, NULL, 32);
INSERT INTO `system_operation_log` VALUES ('1738478633128865794', '1', '分页', '0:0:0:0:0:0:0:1', '2023-12-23 16:36:20', '2023-12-23 16:36:20', '/family/page', 'GET', 1, NULL, 23);
INSERT INTO `system_operation_log` VALUES ('1738478652921786370', '1', '分页', '0:0:0:0:0:0:0:1', '2023-12-23 16:36:25', '2023-12-23 16:36:25', '/family/page', 'GET', 1, NULL, 25);
INSERT INTO `system_operation_log` VALUES ('1738478669346680834', '1', '分页', '0:0:0:0:0:0:0:1', '2023-12-23 16:36:27', '2023-12-23 16:36:27', '/family/page', 'GET', 1, NULL, 21);
INSERT INTO `system_operation_log` VALUES ('1738478669409595393', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-23 16:36:29', '2023-12-23 16:36:29', '/family/list', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1738478675151597570', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-23 16:36:29', '2023-12-23 16:36:29', '/floor/pageBackend', 'GET', 1, NULL, 25);
INSERT INTO `system_operation_log` VALUES ('1738478694969683970', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-23 16:36:34', '2023-12-23 16:36:34', '/floor/pageBackend', 'GET', 1, NULL, 22);
INSERT INTO `system_operation_log` VALUES ('1738478711348441089', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-23 16:36:36', '2023-12-23 16:36:36', '/floor/pageBackend', 'GET', 1, NULL, 21);
INSERT INTO `system_operation_log` VALUES ('1738478711411355649', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-23 16:36:38', '2023-12-23 16:36:38', '/family/list', 'GET', 1, NULL, 6);
INSERT INTO `system_operation_log` VALUES ('1738478717123997698', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-23 16:36:38', '2023-12-23 16:36:38', '/room/pageBackend', 'GET', 1, NULL, 27);
INSERT INTO `system_operation_log` VALUES ('1738478736963055617', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-23 16:36:44', '2023-12-23 16:36:44', '/room/pageBackend', 'GET', 1, NULL, 23);
INSERT INTO `system_operation_log` VALUES ('1738478753333424129', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-23 16:36:44', '2023-12-23 16:36:44', '/room/pageBackend', 'GET', 1, NULL, 21);
INSERT INTO `system_operation_log` VALUES ('1738478753396338689', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-23 16:36:46', '2023-12-23 16:36:46', '/room/pageBackend', 'GET', 1, NULL, 19);
INSERT INTO `system_operation_log` VALUES ('1738478769682821121', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-23 16:36:53', '2023-12-23 16:36:53', '/room/pageBackend', 'GET', 1, NULL, 23);
INSERT INTO `system_operation_log` VALUES ('1738478778952232962', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-23 16:36:54', '2023-12-23 16:36:54', '/room/pageBackend', 'GET', 1, NULL, 20);
INSERT INTO `system_operation_log` VALUES ('1738478829548122113', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-23 16:37:07', '2023-12-23 16:37:07', '/room/pageBackend', 'GET', 1, NULL, 22);
INSERT INTO `system_operation_log` VALUES ('1738478837026566146', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-23 16:37:09', '2023-12-23 16:37:09', '/room/pageBackend', 'GET', 1, NULL, 20);
INSERT INTO `system_operation_log` VALUES ('1738478845046075393', '1', '角色下拉列表', '0:0:0:0:0:0:0:1', '2023-12-23 16:37:11', '2023-12-23 16:37:11', '/permission/roleList', 'GET', 1, NULL, 2);
INSERT INTO `system_operation_log` VALUES ('1738478845046075394', '1', '根据家庭ID楼层集合', '0:0:0:0:0:0:0:1', '2023-12-23 16:37:11', '2023-12-23 16:37:11', '/floor/floorList', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1738478871596019713', '1', '分页查询', '0:0:0:0:0:0:0:1', '2023-12-23 16:37:11', '2023-12-23 16:37:11', '/user/page', 'GET', 1, NULL, 26);
INSERT INTO `system_operation_log` VALUES ('1738478879061880833', '1', '根据楼层id查询房间设备树', '0:0:0:0:0:0:0:1', '2023-12-23 16:37:11', '2023-12-23 16:37:11', '/device/roomDeviceTree', 'GET', 1, NULL, 42);
INSERT INTO `system_operation_log` VALUES ('1738478887060418562', '1', '分页查询', '0:0:0:0:0:0:0:1', '2023-12-23 16:37:16', '2023-12-23 16:37:16', '/user/page', 'GET', 1, NULL, 21);
INSERT INTO `system_operation_log` VALUES ('1738478887060418563', '1', '分页查询', '0:0:0:0:0:0:0:1', '2023-12-23 16:37:19', '2023-12-23 16:37:19', '/user/page', 'GET', 1, NULL, 21);
INSERT INTO `system_operation_log` VALUES ('1738478913564225538', '1', '分页查询', '0:0:0:0:0:0:0:1', '2023-12-23 16:37:21', '2023-12-23 16:37:21', '/user/page', 'GET', 1, NULL, 21);
INSERT INTO `system_operation_log` VALUES ('1738478921025892354', '1', '分页查询', '0:0:0:0:0:0:0:1', '2023-12-23 16:37:23', '2023-12-23 16:37:23', '/user/page', 'GET', 1, NULL, 23);
INSERT INTO `system_operation_log` VALUES ('1738478929032818689', '1', '分页查询', '0:0:0:0:0:0:0:1', '2023-12-23 16:37:24', '2023-12-23 16:37:24', '/user/page', 'GET', 1, NULL, 22);
INSERT INTO `system_operation_log` VALUES ('1738478929032818690', '1', '分页查询', '0:0:0:0:0:0:0:1', '2023-12-23 16:37:27', '2023-12-23 16:37:27', '/user/page', 'GET', 1, NULL, 22);
INSERT INTO `system_operation_log` VALUES ('1738478955591151617', '1', '分页查询', '0:0:0:0:0:0:0:1', '2023-12-23 16:37:28', '2023-12-23 16:37:28', '/user/page', 'GET', 1, NULL, 18);
INSERT INTO `system_operation_log` VALUES ('1738478963031846913', '1', '分页查询', '0:0:0:0:0:0:0:1', '2023-12-23 16:37:30', '2023-12-23 16:37:30', '/user/page', 'GET', 1, NULL, 19);
INSERT INTO `system_operation_log` VALUES ('1738478971038773250', '1', '分页查询', '0:0:0:0:0:0:0:1', '2023-12-23 16:37:31', '2023-12-23 16:37:31', '/user/page', 'GET', 1, NULL, 14);
INSERT INTO `system_operation_log` VALUES ('1738478971038773251', '1', '分页查询', '0:0:0:0:0:0:0:1', '2023-12-23 16:37:32', '2023-12-23 16:37:32', '/user/page', 'GET', 1, NULL, 19);
INSERT INTO `system_operation_log` VALUES ('1738479429132267522', '1', '角色下拉列表', '0:0:0:0:0:0:0:1', '2023-12-23 16:39:30', '2023-12-23 16:39:30', '/permission/roleList', 'GET', 1, NULL, 29);
INSERT INTO `system_operation_log` VALUES ('1738479429182599169', '1', '根据家庭ID楼层集合', '0:0:0:0:0:0:0:1', '2023-12-23 16:39:30', '2023-12-23 16:39:30', '/floor/floorList', 'GET', 1, NULL, 37);
INSERT INTO `system_operation_log` VALUES ('1738479429253902338', '1', '分页查询', '0:0:0:0:0:0:0:1', '2023-12-23 16:39:30', '2023-12-23 16:39:30', '/user/page', 'GET', 1, NULL, 57);
INSERT INTO `system_operation_log` VALUES ('1738479429283262466', '1', '根据楼层id查询房间设备树', '0:0:0:0:0:0:0:1', '2023-12-23 16:39:30', '2023-12-23 16:39:30', '/device/roomDeviceTree', 'GET', 1, NULL, 57);
INSERT INTO `system_operation_log` VALUES ('1738479619557863426', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-23 16:40:15', '2023-12-23 16:40:15', '/family/list', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1738479619687886849', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-23 16:40:15', '2023-12-23 16:40:15', '/room/pageBackend', 'GET', 1, NULL, 29);
INSERT INTO `system_operation_log` VALUES ('1738479628407844865', '1', '分页查询', '0:0:0:0:0:0:0:1', '2023-12-23 16:40:17', '2023-12-23 16:40:17', '/user/page', 'GET', 1, NULL, 19);
INSERT INTO `system_operation_log` VALUES ('1738479628407844866', '1', '角色下拉列表', '0:0:0:0:0:0:0:1', '2023-12-23 16:40:17', '2023-12-23 16:40:17', '/permission/roleList', 'GET', 1, NULL, 1);
INSERT INTO `system_operation_log` VALUES ('1738479661593178113', '1', '根据家庭ID楼层集合', '0:0:0:0:0:0:0:1', '2023-12-23 16:40:18', '2023-12-23 16:40:18', '/floor/floorList', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1738479661719007233', '1', '根据楼层id查询房间设备树', '0:0:0:0:0:0:0:1', '2023-12-23 16:40:18', '2023-12-23 16:40:18', '/device/roomDeviceTree', 'GET', 1, NULL, 18);
INSERT INTO `system_operation_log` VALUES ('1738479716710526978', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-23 16:40:39', '2023-12-23 16:40:39', '/family/list', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1738479716777635842', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-23 16:40:39', '2023-12-23 16:40:39', '/room/pageBackend', 'GET', 1, NULL, 23);
INSERT INTO `system_operation_log` VALUES ('1738479725933801474', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-23 16:40:41', '2023-12-23 16:40:41', '/family/list', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1738479725975744513', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-23 16:40:41', '2023-12-23 16:40:41', '/floor/pageBackend', 'GET', 1, NULL, 28);
INSERT INTO `system_operation_log` VALUES ('1738479758741647361', '1', '分页', '0:0:0:0:0:0:0:1', '2023-12-23 16:40:42', '2023-12-23 16:40:42', '/family/page', 'GET', 1, NULL, 18);
INSERT INTO `system_operation_log` VALUES ('1738479758812950530', '1', '角色下拉列表', '0:0:0:0:0:0:0:1', '2023-12-23 16:40:45', '2023-12-23 16:40:45', '/permission/roleList', 'GET', 1, NULL, 2);
INSERT INTO `system_operation_log` VALUES ('1738479767918784513', '1', '根据家庭ID楼层集合', '0:0:0:0:0:0:0:1', '2023-12-23 16:40:45', '2023-12-23 16:40:45', '/floor/floorList', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1738479767990087681', '1', '根据楼层id查询房间设备树', '0:0:0:0:0:0:0:1', '2023-12-23 16:40:45', '2023-12-23 16:40:45', '/device/roomDeviceTree', 'GET', 1, NULL, 18);
INSERT INTO `system_operation_log` VALUES ('1738479800743407618', '1', '分页查询', '0:0:0:0:0:0:0:1', '2023-12-23 16:40:45', '2023-12-23 16:40:45', '/user/page', 'GET', 1, NULL, 35);
INSERT INTO `system_operation_log` VALUES ('1738479917013708801', '1', '权限树', '0:0:0:0:0:0:0:1', '2023-12-23 16:41:26', '2023-12-23 16:41:26', '/permission/allPermTree', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1738479917147926530', '1', '角色分页查询', '0:0:0:0:0:0:0:1', '2023-12-23 16:41:26', '2023-12-23 16:41:26', '/permission/rolePage', 'GET', 1, NULL, 26);
INSERT INTO `system_operation_log` VALUES ('1738480230441463809', '1', '分页', '0:0:0:0:0:0:0:1', '2023-12-23 16:42:41', '2023-12-23 16:42:41', '/family/page', 'GET', 1, NULL, 18);
INSERT INTO `system_operation_log` VALUES ('1738480283138699265', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-12-23 16:42:54', '2023-12-23 16:42:54', '/product/page', 'GET', 1, NULL, 21);
INSERT INTO `system_operation_log` VALUES ('1738480289048473602', '1', '分页', '0:0:0:0:0:0:0:1', '2023-12-23 16:42:55', '2023-12-23 16:42:55', '/family/page', 'GET', 1, NULL, 21);
INSERT INTO `system_operation_log` VALUES ('1738480293863534594', '1', '根据家庭ID楼层集合', '0:0:0:0:0:0:0:1', '2023-12-23 16:42:56', '2023-12-23 16:42:56', '/floor/floorList', 'GET', 1, NULL, 6);
INSERT INTO `system_operation_log` VALUES ('1738480293863534595', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2023-12-23 16:42:56', '2023-12-23 16:42:56', '/dashboard/dashboardInfo', 'GET', 1, NULL, 12);
INSERT INTO `system_operation_log` VALUES ('1738480325220151298', '1', '分页', '0:0:0:0:0:0:0:1', '2023-12-23 16:42:57', '2023-12-23 16:42:57', '/family/page', 'GET', 1, NULL, 20);
INSERT INTO `system_operation_log` VALUES ('1738480552031334402', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-12-23 16:43:58', '2023-12-23 16:43:58', '/permission/getPerm', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1738480553268654082', '1', '分页', '0:0:0:0:0:0:0:1', '2023-12-23 16:43:58', '2023-12-23 16:43:58', '/family/page', 'GET', 1, NULL, 27);
INSERT INTO `system_operation_log` VALUES ('1738480597136879618', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-12-23 16:44:08', '2023-12-23 16:44:08', '/product/page', 'GET', 1, NULL, 26);
INSERT INTO `system_operation_log` VALUES ('1738480683946389505', '1', '分页', '0:0:0:0:0:0:0:1', '2023-12-23 16:44:29', '2023-12-23 16:44:29', '/family/page', 'GET', 1, NULL, 21);
INSERT INTO `system_operation_log` VALUES ('1738480690577584129', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-12-23 16:44:31', '2023-12-23 16:44:31', '/product/page', 'GET', 1, NULL, 25);
INSERT INTO `system_operation_log` VALUES ('1738480733061689346', '1', '权限树', '0:0:0:0:0:0:0:1', '2023-12-23 16:44:41', '2023-12-23 16:44:41', '/permission/allPermTree', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1738480733183324162', '1', '角色分页查询', '0:0:0:0:0:0:0:1', '2023-12-23 16:44:41', '2023-12-23 16:44:41', '/permission/rolePage', 'GET', 1, NULL, 32);
INSERT INTO `system_operation_log` VALUES ('1738480848346329090', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-12-23 16:45:08', '2023-12-23 16:45:08', '/permission/getPerm', 'GET', 1, NULL, 6);
INSERT INTO `system_operation_log` VALUES ('1738481005909553154', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-12-23 16:45:46', '2023-12-23 16:45:46', '/permission/getPerm', 'GET', 1, NULL, 7);
INSERT INTO `system_operation_log` VALUES ('1738481028630097922', '1', '分页', '0:0:0:0:0:0:0:1', '2023-12-23 16:45:51', '2023-12-23 16:45:51', '/family/page', 'GET', 1, NULL, 22);
INSERT INTO `system_operation_log` VALUES ('1738481413864337410', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-12-23 16:47:23', '2023-12-23 16:47:23', '/product/page', 'GET', 1, NULL, 27);
INSERT INTO `system_operation_log` VALUES ('1738481423616094210', '1', '分页', '0:0:0:0:0:0:0:1', '2023-12-23 16:47:25', '2023-12-23 16:47:25', '/family/page', 'GET', 1, NULL, 18);
INSERT INTO `system_operation_log` VALUES ('1738481427802009602', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-12-23 16:47:26', '2023-12-23 16:47:26', '/product/page', 'GET', 1, NULL, 26);
INSERT INTO `system_operation_log` VALUES ('1738481520408047617', NULL, '', '0:0:0:0:0:0:0:1', '2023-12-23 16:47:49', '2023-12-23 16:47:49', '/error', 'GET', 0, '系统错误请联系管理员', 1);
INSERT INTO `system_operation_log` VALUES ('1738481520408047618', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2023-12-23 16:47:49', '2023-12-23 16:47:49', '/product/list', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1738481556550365186', '1', '权限树', '0:0:0:0:0:0:0:1', '2023-12-23 16:47:57', '2023-12-23 16:47:57', '/permission/allPermTree', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1738481556680388609', '1', '角色分页查询', '0:0:0:0:0:0:0:1', '2023-12-23 16:47:57', '2023-12-23 16:47:57', '/permission/rolePage', 'GET', 1, NULL, 30);
INSERT INTO `system_operation_log` VALUES ('1738481594307489793', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-12-23 16:48:06', '2023-12-23 16:48:06', '/product/page', 'GET', 1, NULL, 30);
INSERT INTO `system_operation_log` VALUES ('1738848240418283522', NULL, '登录', '0:0:0:0:0:0:0:1', '2023-12-24 17:05:01', '2023-12-24 17:05:01', '/user/login', 'POST', 1, NULL, 207);
INSERT INTO `system_operation_log` VALUES ('1738848241882095617', '1', '查询个人信息', '0:0:0:0:0:0:0:1', '2023-12-24 17:05:02', '2023-12-24 17:05:02', '/user/info', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1738848242007924737', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-12-24 17:05:02', '2023-12-24 17:05:02', '/permission/getPerm', 'GET', 1, NULL, 37);
INSERT INTO `system_operation_log` VALUES ('1738848243182329858', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2023-12-24 17:05:02', '2023-12-24 17:05:02', '/dashboard/dashboardInfo', 'GET', 1, NULL, 38);
INSERT INTO `system_operation_log` VALUES ('1738848282411655170', '1', '根据家庭ID楼层集合', '0:0:0:0:0:0:0:1', '2023-12-24 17:05:02', '2023-12-24 17:05:02', '/floor/floorList', 'GET', 1, NULL, 43);
INSERT INTO `system_operation_log` VALUES ('1738848283925798913', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-12-24 17:05:06', '2023-12-24 17:05:06', '/product/page', 'GET', 1, NULL, 124);
INSERT INTO `system_operation_log` VALUES ('1738848284055822338', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2023-12-24 17:05:10', '2023-12-24 17:05:10', '/product/list', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1738848285163118594', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-12-24 17:05:10', '2023-12-24 17:05:10', '/frameware/page', 'GET', 1, NULL, 37);
INSERT INTO `system_operation_log` VALUES ('1738848324480524289', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2023-12-24 17:05:11', '2023-12-24 17:05:11', '/product/list', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1738848325919170561', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-24 17:05:11', '2023-12-24 17:05:11', '/family/list', 'GET', 1, NULL, 30);
INSERT INTO `system_operation_log` VALUES ('1738848360148885506', '1', '分页', '0:0:0:0:0:0:0:1', '2023-12-24 17:05:30', '2023-12-24 17:05:30', '/family/page', 'GET', 1, NULL, 19);
INSERT INTO `system_operation_log` VALUES ('1738848365827973121', '1', '根据家庭ID楼层集合', '0:0:0:0:0:0:0:1', '2023-12-24 17:05:31', '2023-12-24 17:05:31', '/floor/floorList', 'GET', 1, NULL, 2);
INSERT INTO `system_operation_log` VALUES ('1738848366478090241', '1', '角色下拉列表', '0:0:0:0:0:0:0:1', '2023-12-24 17:05:31', '2023-12-24 17:05:31', '/permission/roleList', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1738848367912542210', '1', '根据楼层id查询房间设备树', '0:0:0:0:0:0:0:1', '2023-12-24 17:05:31', '2023-12-24 17:05:31', '/device/roomDeviceTree', 'GET', 1, NULL, 30);
INSERT INTO `system_operation_log` VALUES ('1738848402154840065', '1', '分页查询', '0:0:0:0:0:0:0:1', '2023-12-24 17:05:31', '2023-12-24 17:05:31', '/user/page', 'GET', 1, NULL, 43);
INSERT INTO `system_operation_log` VALUES ('1738849020328140802', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-12-24 17:08:07', '2023-12-24 17:08:07', '/product/page', 'GET', 1, NULL, 27);
INSERT INTO `system_operation_log` VALUES ('1738849037763862530', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2023-12-24 17:08:12', '2023-12-24 17:08:12', '/product/list', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1738849037898080257', NULL, '', '0:0:0:0:0:0:0:1', '2023-12-24 17:08:12', '2023-12-24 17:08:12', '/error', 'GET', 0, '系统错误请联系管理员', 7);
INSERT INTO `system_operation_log` VALUES ('1738849064901009409', '1', '权限树', '0:0:0:0:0:0:0:1', '2023-12-24 17:08:18', '2023-12-24 17:08:18', '/permission/allPermTree', 'GET', 1, NULL, 10);
INSERT INTO `system_operation_log` VALUES ('1738849065035227137', '1', '角色分页查询', '0:0:0:0:0:0:0:1', '2023-12-24 17:08:18', '2023-12-24 17:08:18', '/permission/rolePage', 'GET', 1, NULL, 42);
INSERT INTO `system_operation_log` VALUES ('1738849607610392577', '1', '权限树', '0:0:0:0:0:0:0:1', '2023-12-24 17:10:27', '2023-12-24 17:10:27', '/permission/allPermTree', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1738849607744610306', '1', '角色分页查询', '0:0:0:0:0:0:0:1', '2023-12-24 17:10:27', '2023-12-24 17:10:27', '/permission/rolePage', 'GET', 1, NULL, 29);
INSERT INTO `system_operation_log` VALUES ('1738859314479751170', NULL, '', '0:0:0:0:0:0:0:1', '2023-12-24 17:49:02', '2023-12-24 17:49:02', '/error', 'GET', 0, '系统错误请联系管理员', 0);
INSERT INTO `system_operation_log` VALUES ('1738859314551054337', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2023-12-24 17:49:02', '2023-12-24 17:49:02', '/product/list', 'GET', 1, NULL, 23);
INSERT INTO `system_operation_log` VALUES ('1738859329268867074', '1', '根据家庭ID楼层集合', '0:0:0:0:0:0:0:1', '2023-12-24 17:49:05', '2023-12-24 17:49:05', '/floor/floorList', 'GET', 1, NULL, 15);
INSERT INTO `system_operation_log` VALUES ('1738859329403084801', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2023-12-24 17:49:05', '2023-12-24 17:49:05', '/dashboard/dashboardInfo', 'GET', 1, NULL, 38);
INSERT INTO `system_operation_log` VALUES ('1738859356565397505', '1', '分页', '0:0:0:0:0:0:0:1', '2023-12-24 17:49:07', '2023-12-24 17:49:07', '/family/page', 'GET', 1, NULL, 35);
INSERT INTO `system_operation_log` VALUES ('1738859356565397506', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-24 17:49:10', '2023-12-24 17:49:10', '/family/list', 'GET', 1, NULL, 13);
INSERT INTO `system_operation_log` VALUES ('1738859371308376066', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-24 17:49:10', '2023-12-24 17:49:10', '/floor/pageBackend', 'GET', 1, NULL, 28);
INSERT INTO `system_operation_log` VALUES ('1738859371434205186', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-24 17:49:11', '2023-12-24 17:49:11', '/family/list', 'GET', 1, NULL, 8);
INSERT INTO `system_operation_log` VALUES ('1738859398533603329', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-24 17:49:11', '2023-12-24 17:49:11', '/room/pageBackend', 'GET', 1, NULL, 55);
INSERT INTO `system_operation_log` VALUES ('1738859398596517890', '1', '根据家庭ID楼层集合', '0:0:0:0:0:0:0:1', '2023-12-24 17:49:13', '2023-12-24 17:49:13', '/floor/floorList', 'GET', 1, NULL, 9);
INSERT INTO `system_operation_log` VALUES ('1738859413318524929', '1', '根据楼层id查询房间设备树', '0:0:0:0:0:0:0:1', '2023-12-24 17:49:13', '2023-12-24 17:49:13', '/device/roomDeviceTree', 'GET', 1, NULL, 107);
INSERT INTO `system_operation_log` VALUES ('1738859420612419586', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-12-24 17:49:27', '2023-12-24 17:49:27', '/product/page', 'GET', 1, NULL, 34);
INSERT INTO `system_operation_log` VALUES ('1738859440531169282', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2023-12-24 17:49:31', '2023-12-24 17:49:31', '/product/list', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1738859440598278145', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-12-24 17:49:31', '2023-12-24 17:49:31', '/frameware/page', 'GET', 1, NULL, 21);
INSERT INTO `system_operation_log` VALUES ('1738859455307702273', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2023-12-24 17:49:32', '2023-12-24 17:49:32', '/product/list', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1738859462618374145', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-24 17:49:32', '2023-12-24 17:49:32', '/family/list', 'GET', 1, NULL, 11);
INSERT INTO `system_operation_log` VALUES ('1738859482507763713', '1', '分页查询', '0:0:0:0:0:0:0:1', '2023-12-24 17:49:32', '2023-12-24 17:49:32', '/device/page', 'GET', 1, NULL, 29);
INSERT INTO `system_operation_log` VALUES ('1738859482574872578', '1', '查询调试所有设备', '0:0:0:0:0:0:0:1', '2023-12-24 17:49:33', '2023-12-24 17:49:33', '/device/debugDeviceList', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1738859497330434050', '1', '权限树', '0:0:0:0:0:0:0:1', '2023-12-24 17:49:43', '2023-12-24 17:49:43', '/permission/allPermTree', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1738859504628523009', '1', '角色分页查询', '0:0:0:0:0:0:0:1', '2023-12-24 17:49:43', '2023-12-24 17:49:43', '/permission/rolePage', 'GET', 1, NULL, 32);
INSERT INTO `system_operation_log` VALUES ('1738859731846553601', NULL, '查询系统基础信息', '0:0:0:0:0:0:0:1', '2023-12-24 17:50:41', '2023-12-24 17:50:41', '/systemInfo/basicInfo', 'GET', 1, NULL, 15);
INSERT INTO `system_operation_log` VALUES ('1738859768823537665', NULL, '查询系统基础信息', '0:0:0:0:0:0:0:1', '2023-12-24 17:50:50', '2023-12-24 17:50:50', '/systemInfo/basicInfo', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1738859834841882625', NULL, '查询系统基础信息', '0:0:0:0:0:0:0:1', '2023-12-24 17:51:06', '2023-12-24 17:51:06', '/systemInfo/basicInfo', 'GET', 1, NULL, 1);
INSERT INTO `system_operation_log` VALUES ('1738859861337300993', '1', '分页', '0:0:0:0:0:0:0:1', '2023-12-24 17:51:12', '2023-12-24 17:51:12', '/family/page', 'GET', 1, NULL, 31);
INSERT INTO `system_operation_log` VALUES ('1738859937937874945', NULL, '查询系统基础信息', '0:0:0:0:0:0:0:1', '2023-12-24 17:51:30', '2023-12-24 17:51:30', '/systemInfo/basicInfo', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1738860689875918849', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-12-24 17:54:30', '2023-12-24 17:54:30', '/permission/getPerm', 'GET', 1, NULL, 14);
INSERT INTO `system_operation_log` VALUES ('1738860691339730946', NULL, '查询系统基础信息', '0:0:0:0:0:0:0:1', '2023-12-24 17:54:30', '2023-12-24 17:54:30', '/systemInfo/basicInfo', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1738861087894396930', '1', '权限树', '0:0:0:0:0:0:0:1', '2023-12-24 17:56:04', '2023-12-24 17:56:04', '/permission/allPermTree', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1738861088095723521', '1', '角色分页查询', '0:0:0:0:0:0:0:1', '2023-12-24 17:56:05', '2023-12-24 17:56:05', '/permission/rolePage', 'GET', 1, NULL, 45);
INSERT INTO `system_operation_log` VALUES ('1738861413879898114', '1', '权限树', '0:0:0:0:0:0:0:1', '2023-12-24 17:57:22', '2023-12-24 17:57:22', '/permission/allPermTree', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1738861414018310146', '1', '角色分页查询', '0:0:0:0:0:0:0:1', '2023-12-24 17:57:22', '2023-12-24 17:57:22', '/permission/rolePage', 'GET', 1, NULL, 34);
INSERT INTO `system_operation_log` VALUES ('1738861427943399425', '1', '角色分页查询', '0:0:0:0:0:0:0:1', '2023-12-24 17:57:26', '2023-12-24 17:57:26', '/permission/rolePage', 'GET', 1, NULL, 30);
INSERT INTO `system_operation_log` VALUES ('1738861434390044673', '1', '角色分页查询', '0:0:0:0:0:0:0:1', '2023-12-24 17:57:27', '2023-12-24 17:57:27', '/permission/rolePage', 'GET', 1, NULL, 28);
INSERT INTO `system_operation_log` VALUES ('1738883116660023298', NULL, '登录', '0:0:0:0:0:0:0:1', '2023-12-24 19:23:37', '2023-12-24 19:23:37', '/user/login', 'POST', 1, NULL, 105);
INSERT INTO `system_operation_log` VALUES ('1738883116790046722', '1', '查询个人信息', '0:0:0:0:0:0:0:1', '2023-12-24 19:23:37', '2023-12-24 19:23:37', '/user/info', 'GET', 1, NULL, 6);
INSERT INTO `system_operation_log` VALUES ('1738883116857155585', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-12-24 19:23:37', '2023-12-24 19:23:37', '/permission/getPerm', 'GET', 1, NULL, 23);
INSERT INTO `system_operation_log` VALUES ('1738883118652317698', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2023-12-24 19:23:37', '2023-12-24 19:23:37', '/dashboard/dashboardInfo', 'GET', 1, NULL, 19);
INSERT INTO `system_operation_log` VALUES ('1738883158728892418', '1', '根据家庭ID楼层集合', '0:0:0:0:0:0:0:1', '2023-12-24 19:23:37', '2023-12-24 19:23:37', '/floor/floorList', 'GET', 1, NULL, 27);
INSERT INTO `system_operation_log` VALUES ('1738883158858915841', '1', '权限树', '0:0:0:0:0:0:0:1', '2023-12-24 19:23:41', '2023-12-24 19:23:41', '/permission/allPermTree', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1738883158858915842', '1', '角色分页查询', '0:0:0:0:0:0:0:1', '2023-12-24 19:23:41', '2023-12-24 19:23:41', '/permission/rolePage', 'GET', 1, NULL, 36);
INSERT INTO `system_operation_log` VALUES ('1738883307005927425', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-12-24 19:24:22', '2023-12-24 19:24:22', '/permission/getPerm', 'GET', 1, NULL, 6);
INSERT INTO `system_operation_log` VALUES ('1738883308289384450', '1', '权限树', '0:0:0:0:0:0:0:1', '2023-12-24 19:24:22', '2023-12-24 19:24:22', '/permission/allPermTree', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1738883308406824962', '1', '角色分页查询', '0:0:0:0:0:0:0:1', '2023-12-24 19:24:22', '2023-12-24 19:24:22', '/permission/rolePage', 'GET', 1, NULL, 32);
INSERT INTO `system_operation_log` VALUES ('1738884781156982785', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-12-24 19:30:13', '2023-12-24 19:30:13', '/permission/getPerm', 'GET', 1, NULL, 11);
INSERT INTO `system_operation_log` VALUES ('1738884782423662593', '1', '权限树', '0:0:0:0:0:0:0:1', '2023-12-24 19:30:14', '2023-12-24 19:30:14', '/permission/allPermTree', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1738884782553686018', '1', '角色分页查询', '0:0:0:0:0:0:0:1', '2023-12-24 19:30:14', '2023-12-24 19:30:14', '/permission/rolePage', 'GET', 1, NULL, 33);
INSERT INTO `system_operation_log` VALUES ('1738885435275468802', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-12-24 19:32:49', '2023-12-24 19:32:49', '/permission/getPerm', 'GET', 1, NULL, 35);
INSERT INTO `system_operation_log` VALUES ('1738885436508594177', '1', '角色分页查询', '0:0:0:0:0:0:0:1', '2023-12-24 19:32:50', '2023-12-24 19:32:50', '/permission/rolePage', 'GET', 1, NULL, 42);
INSERT INTO `system_operation_log` VALUES ('1738885436533760002', '1', '权限树', '0:0:0:0:0:0:0:1', '2023-12-24 19:32:50', '2023-12-24 19:32:50', '/permission/allPermTree', 'GET', 1, NULL, 1);
INSERT INTO `system_operation_log` VALUES ('1738895585436590081', NULL, '登录', '0:0:0:0:0:0:0:1', '2023-12-24 20:13:09', '2023-12-24 20:13:09', '/user/login', 'POST', 1, NULL, 178);
INSERT INTO `system_operation_log` VALUES ('1738895585436590082', '1', '查询个人信息', '0:0:0:0:0:0:0:1', '2023-12-24 20:13:09', '2023-12-24 20:13:09', '/user/info', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1738895585646305281', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-12-24 20:13:09', '2023-12-24 20:13:09', '/permission/getPerm', 'GET', 1, NULL, 45);
INSERT INTO `system_operation_log` VALUES ('1738895587428884482', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2023-12-24 20:13:10', '2023-12-24 20:13:10', '/dashboard/dashboardInfo', 'GET', 1, NULL, 42);
INSERT INTO `system_operation_log` VALUES ('1738895627526430721', '1', '根据家庭ID楼层集合', '0:0:0:0:0:0:0:1', '2023-12-24 20:13:10', '2023-12-24 20:13:10', '/floor/floorList', 'GET', 1, NULL, 39);
INSERT INTO `system_operation_log` VALUES ('1738895636728733697', '1', '权限树', '0:0:0:0:0:0:0:1', '2023-12-24 20:13:22', '2023-12-24 20:13:22', '/permission/allPermTree', 'GET', 1, NULL, 13);
INSERT INTO `system_operation_log` VALUES ('1738895637118803970', '1', '角色分页查询', '0:0:0:0:0:0:0:1', '2023-12-24 20:13:22', '2023-12-24 20:13:22', '/permission/rolePage', 'GET', 1, NULL, 108);
INSERT INTO `system_operation_log` VALUES ('1738896078200201218', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-12-24 20:15:07', '2023-12-24 20:15:07', '/permission/getPerm', 'GET', 1, NULL, 6);
INSERT INTO `system_operation_log` VALUES ('1738896079454298114', '1', '权限树', '0:0:0:0:0:0:0:1', '2023-12-24 20:15:07', '2023-12-24 20:15:07', '/permission/allPermTree', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1738896079454298115', '1', '角色分页查询', '0:0:0:0:0:0:0:1', '2023-12-24 20:15:07', '2023-12-24 20:15:07', '/permission/rolePage', 'GET', 1, NULL, 33);
INSERT INTO `system_operation_log` VALUES ('1738896091936546817', '1', '家庭设备树', '0:0:0:0:0:0:0:1', '2023-12-24 20:15:10', '2023-12-24 20:15:10', '/device/familyDeviceTree', 'GET', 1, NULL, 2926);
INSERT INTO `system_operation_log` VALUES ('1738896623057068034', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-12-24 20:17:17', '2023-12-24 20:17:17', '/permission/getPerm', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1738896624248250369', '1', '权限树', '0:0:0:0:0:0:0:1', '2023-12-24 20:17:17', '2023-12-24 20:17:17', '/permission/allPermTree', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1738896624248250370', '1', '角色分页查询', '0:0:0:0:0:0:0:1', '2023-12-24 20:17:17', '2023-12-24 20:17:17', '/permission/rolePage', 'GET', 1, NULL, 21);
INSERT INTO `system_operation_log` VALUES ('1738896624843841537', '1', '家庭设备树', '0:0:0:0:0:0:0:1', '2023-12-24 20:17:17', '2023-12-24 20:17:17', '/device/familyDeviceTree', 'GET', 1, NULL, 103);
INSERT INTO `system_operation_log` VALUES ('1738897647482265602', '1', '权限树', '0:0:0:0:0:0:0:1', '2023-12-24 20:21:21', '2023-12-24 20:21:21', '/permission/allPermTree', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1738897647608094721', '1', '角色分页查询', '0:0:0:0:0:0:0:1', '2023-12-24 20:21:21', '2023-12-24 20:21:21', '/permission/rolePage', 'GET', 1, NULL, 26);
INSERT INTO `system_operation_log` VALUES ('1738897647868141570', '1', '家庭设备树', '0:0:0:0:0:0:0:1', '2023-12-24 20:21:21', '2023-12-24 20:21:21', '/device/familyDeviceTree', 'GET', 1, NULL, 85);
INSERT INTO `system_operation_log` VALUES ('1738898744804466689', '1', '权限树', '0:0:0:0:0:0:0:1', '2023-12-24 20:25:43', '2023-12-24 20:25:43', '/permission/allPermTree', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1738898744900935682', '1', '角色分页查询', '0:0:0:0:0:0:0:1', '2023-12-24 20:25:43', '2023-12-24 20:25:43', '/permission/rolePage', 'GET', 1, NULL, 28);
INSERT INTO `system_operation_log` VALUES ('1738898745026764802', '1', '家庭设备树', '0:0:0:0:0:0:0:1', '2023-12-24 20:25:43', '2023-12-24 20:25:43', '/device/familyDeviceTree', 'GET', 1, NULL, 82);
INSERT INTO `system_operation_log` VALUES ('1738900734682947585', '1', '权限树', '0:0:0:0:0:0:0:1', '2023-12-24 20:33:37', '2023-12-24 20:33:37', '/permission/allPermTree', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1738900734812971009', '1', '角色分页查询', '0:0:0:0:0:0:0:1', '2023-12-24 20:33:37', '2023-12-24 20:33:37', '/permission/rolePage', 'GET', 1, NULL, 29);
INSERT INTO `system_operation_log` VALUES ('1738900735073017857', '1', '家庭设备树', '0:0:0:0:0:0:0:1', '2023-12-24 20:33:37', '2023-12-24 20:33:37', '/device/familyDeviceTree', 'GET', 1, NULL, 77);
INSERT INTO `system_operation_log` VALUES ('1738901764221001729', '1', '权限树', '0:0:0:0:0:0:0:1', '2023-12-24 20:37:42', '2023-12-24 20:37:42', '/permission/allPermTree', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1738901764221001730', '1', '角色分页查询', '0:0:0:0:0:0:0:1', '2023-12-24 20:37:43', '2023-12-24 20:37:43', '/permission/rolePage', 'GET', 1, NULL, 27);
INSERT INTO `system_operation_log` VALUES ('1738901764678180866', '1', '家庭设备树', '0:0:0:0:0:0:0:1', '2023-12-24 20:37:43', '2023-12-24 20:37:43', '/device/familyDeviceTree', 'GET', 1, NULL, 98);
INSERT INTO `system_operation_log` VALUES ('1738902280795676673', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-12-24 20:39:46', '2023-12-24 20:39:46', '/permission/getPerm', 'GET', 1, NULL, 14);
INSERT INTO `system_operation_log` VALUES ('1738902281911361537', '1', '权限树', '0:0:0:0:0:0:0:1', '2023-12-24 20:39:46', '2023-12-24 20:39:46', '/permission/allPermTree', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1738902281911361538', '1', '角色分页查询', '0:0:0:0:0:0:0:1', '2023-12-24 20:39:46', '2023-12-24 20:39:46', '/permission/rolePage', 'GET', 1, NULL, 37);
INSERT INTO `system_operation_log` VALUES ('1738902282494369794', '1', '家庭设备树', '0:0:0:0:0:0:0:1', '2023-12-24 20:39:46', '2023-12-24 20:39:46', '/device/familyDeviceTree', 'GET', 1, NULL, 104);
INSERT INTO `system_operation_log` VALUES ('1738902385703608321', '1', '权限树', '0:0:0:0:0:0:0:1', '2023-12-24 20:40:11', '2023-12-24 20:40:11', '/permission/allPermTree', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1738902385800077313', '1', '角色分页查询', '0:0:0:0:0:0:0:1', '2023-12-24 20:40:11', '2023-12-24 20:40:11', '/permission/rolePage', 'GET', 1, NULL, 20);
INSERT INTO `system_operation_log` VALUES ('1738902386034958338', '1', '家庭设备树', '0:0:0:0:0:0:0:1', '2023-12-24 20:40:11', '2023-12-24 20:40:11', '/device/familyDeviceTree', 'GET', 1, NULL, 79);
INSERT INTO `system_operation_log` VALUES ('1738903987231481857', '1', '权限树', '0:0:0:0:0:0:0:1', '2023-12-24 20:46:33', '2023-12-24 20:46:33', '/permission/allPermTree', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1738903987420225538', '1', '角色分页查询', '0:0:0:0:0:0:0:1', '2023-12-24 20:46:33', '2023-12-24 20:46:33', '/permission/rolePage', 'GET', 1, NULL, 36);
INSERT INTO `system_operation_log` VALUES ('1738903987684466690', '1', '家庭设备树', '0:0:0:0:0:0:0:1', '2023-12-24 20:46:33', '2023-12-24 20:46:33', '/device/familyDeviceTree', 'GET', 1, NULL, 96);
INSERT INTO `system_operation_log` VALUES ('1738904055443447810', '1', '权限树', '0:0:0:0:0:0:0:1', '2023-12-24 20:46:49', '2023-12-24 20:46:49', '/permission/allPermTree', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1738904055443447811', '1', '角色分页查询', '0:0:0:0:0:0:0:1', '2023-12-24 20:46:49', '2023-12-24 20:46:49', '/permission/rolePage', 'GET', 1, NULL, 39);
INSERT INTO `system_operation_log` VALUES ('1738904055858683906', '1', '家庭设备树', '0:0:0:0:0:0:0:1', '2023-12-24 20:46:49', '2023-12-24 20:46:49', '/device/familyDeviceTree', 'GET', 1, NULL, 93);
INSERT INTO `system_operation_log` VALUES ('1738904449879990274', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-12-24 20:48:23', '2023-12-24 20:48:23', '/permission/getPerm', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1738904451071172610', '1', '权限树', '0:0:0:0:0:0:0:1', '2023-12-24 20:48:23', '2023-12-24 20:48:23', '/permission/allPermTree', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1738904451071172611', '1', '角色分页查询', '0:0:0:0:0:0:0:1', '2023-12-24 20:48:23', '2023-12-24 20:48:23', '/permission/rolePage', 'GET', 1, NULL, 27);
INSERT INTO `system_operation_log` VALUES ('1738904451503185921', '1', '家庭设备树', '0:0:0:0:0:0:0:1', '2023-12-24 20:48:23', '2023-12-24 20:48:23', '/device/familyDeviceTree', 'GET', 1, NULL, 75);
INSERT INTO `system_operation_log` VALUES ('1738907016349442050', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-12-24 20:58:35', '2023-12-24 20:58:35', '/permission/getPerm', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1738907017607733250', '1', '权限树', '0:0:0:0:0:0:0:1', '2023-12-24 20:58:35', '2023-12-24 20:58:35', '/permission/allPermTree', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1738907017607733251', '1', '角色分页查询', '0:0:0:0:0:0:0:1', '2023-12-24 20:58:35', '2023-12-24 20:58:35', '/permission/rolePage', 'GET', 1, NULL, 20);
INSERT INTO `system_operation_log` VALUES ('1738907017943277569', '1', '家庭设备树', '0:0:0:0:0:0:0:1', '2023-12-24 20:58:35', '2023-12-24 20:58:35', '/device/familyDeviceTree', 'GET', 1, NULL, 69);
INSERT INTO `system_operation_log` VALUES ('1738907632538836993', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-12-24 21:01:02', '2023-12-24 21:01:02', '/permission/getPerm', 'GET', 1, NULL, 32);
INSERT INTO `system_operation_log` VALUES ('1738907634023620609', '1', '权限树', '0:0:0:0:0:0:0:1', '2023-12-24 21:01:02', '2023-12-24 21:01:02', '/permission/allPermTree', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1738907634023620610', '1', '角色分页查询', '0:0:0:0:0:0:0:1', '2023-12-24 21:01:02', '2023-12-24 21:01:02', '/permission/rolePage', 'GET', 1, NULL, 94);
INSERT INTO `system_operation_log` VALUES ('1738907635718119425', '1', '家庭设备树', '0:0:0:0:0:0:0:1', '2023-12-24 21:01:02', '2023-12-24 21:01:02', '/device/familyDeviceTree', 'GET', 1, NULL, 346);
INSERT INTO `system_operation_log` VALUES ('1738909023424569345', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-12-24 21:06:33', '2023-12-24 21:06:33', '/permission/getPerm', 'GET', 1, NULL, 10);
INSERT INTO `system_operation_log` VALUES ('1738909024888381441', '1', '权限树', '0:0:0:0:0:0:0:1', '2023-12-24 21:06:34', '2023-12-24 21:06:34', '/permission/allPermTree', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1738909024888381442', '1', '角色分页查询', '0:0:0:0:0:0:0:1', '2023-12-24 21:06:34', '2023-12-24 21:06:34', '/permission/rolePage', 'GET', 1, NULL, 31);
INSERT INTO `system_operation_log` VALUES ('1738909025744019457', '1', '家庭设备树', '0:0:0:0:0:0:0:1', '2023-12-24 21:06:34', '2023-12-24 21:06:34', '/device/familyDeviceTree', 'GET', 1, NULL, 129);
INSERT INTO `system_operation_log` VALUES ('1738915318621888514', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-12-24 21:31:34', '2023-12-24 21:31:34', '/permission/getPerm', 'GET', 1, NULL, 15);
INSERT INTO `system_operation_log` VALUES ('1738915319938899969', '1', '权限树', '0:0:0:0:0:0:0:1', '2023-12-24 21:31:34', '2023-12-24 21:31:34', '/permission/allPermTree', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1738915320412856322', '1', '角色分页查询', '0:0:0:0:0:0:0:1', '2023-12-24 21:31:35', '2023-12-24 21:31:35', '/permission/rolePage', 'GET', 1, NULL, 67);
INSERT INTO `system_operation_log` VALUES ('1738915321004253186', '1', '家庭设备树', '0:0:0:0:0:0:0:1', '2023-12-24 21:31:35', '2023-12-24 21:31:35', '/device/familyDeviceTree', 'GET', 1, NULL, 211);
INSERT INTO `system_operation_log` VALUES ('1738915579151044609', NULL, '登录', '0:0:0:0:0:0:0:1', '2023-12-24 21:32:36', '2023-12-24 21:32:36', '/user/login', 'POST', 1, NULL, 170);
INSERT INTO `system_operation_log` VALUES ('1738915579260096513', '1', '查询个人信息', '0:0:0:0:0:0:0:1', '2023-12-24 21:32:36', '2023-12-24 21:32:36', '/user/info', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1738915579390119938', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-12-24 21:32:36', '2023-12-24 21:32:36', '/permission/getPerm', 'GET', 1, NULL, 42);
INSERT INTO `system_operation_log` VALUES ('1738915581038481409', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2023-12-24 21:32:37', '2023-12-24 21:32:37', '/dashboard/dashboardInfo', 'GET', 1, NULL, 42);
INSERT INTO `system_operation_log` VALUES ('1738915621228302338', '1', '根据家庭ID楼层集合', '0:0:0:0:0:0:0:1', '2023-12-24 21:32:37', '2023-12-24 21:32:37', '/floor/floorList', 'GET', 1, NULL, 36);
INSERT INTO `system_operation_log` VALUES ('1738915621295411201', '1', '权限树', '0:0:0:0:0:0:0:1', '2023-12-24 21:32:44', '2023-12-24 21:32:44', '/permission/allPermTree', 'GET', 1, NULL, 11);
INSERT INTO `system_operation_log` VALUES ('1738915621425434626', '1', '角色分页查询', '0:0:0:0:0:0:0:1', '2023-12-24 21:32:44', '2023-12-24 21:32:44', '/permission/rolePage', 'GET', 1, NULL, 110);
INSERT INTO `system_operation_log` VALUES ('1738915623052824578', '1', '家庭设备树', '0:0:0:0:0:0:0:1', '2023-12-24 21:32:44', '2023-12-24 21:32:44', '/device/familyDeviceTree', 'GET', 1, NULL, 191);
INSERT INTO `system_operation_log` VALUES ('1738917237125861377', '1', '权限树', '0:0:0:0:0:0:0:1', '2023-12-24 21:39:12', '2023-12-24 21:39:12', '/permission/allPermTree', 'GET', 1, NULL, 1);
INSERT INTO `system_operation_log` VALUES ('1738917237318799362', '1', '角色分页查询', '0:0:0:0:0:0:0:1', '2023-12-24 21:39:12', '2023-12-24 21:39:12', '/permission/rolePage', 'GET', 1, NULL, 44);
INSERT INTO `system_operation_log` VALUES ('1738917237578846210', '1', '家庭设备树', '0:0:0:0:0:0:0:1', '2023-12-24 21:39:12', '2023-12-24 21:39:12', '/device/familyDeviceTree', 'GET', 1, NULL, 107);
INSERT INTO `system_operation_log` VALUES ('1738918805296435201', '1', '权限树', '0:0:0:0:0:0:0:1', '2023-12-24 21:45:25', '2023-12-24 21:45:25', '/permission/allPermTree', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1738918805405487105', '1', '角色分页查询', '0:0:0:0:0:0:0:1', '2023-12-24 21:45:25', '2023-12-24 21:45:25', '/permission/rolePage', 'GET', 1, NULL, 32);
INSERT INTO `system_operation_log` VALUES ('1738918805896220674', '1', '家庭设备树', '0:0:0:0:0:0:0:1', '2023-12-24 21:45:26', '2023-12-24 21:45:26', '/device/familyDeviceTree', 'GET', 1, NULL, 118);
INSERT INTO `system_operation_log` VALUES ('1738918980182134785', '1', '权限树', '0:0:0:0:0:0:0:1', '2023-12-24 21:46:07', '2023-12-24 21:46:07', '/permission/allPermTree', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1738918980307963906', '1', '角色分页查询', '0:0:0:0:0:0:0:1', '2023-12-24 21:46:07', '2023-12-24 21:46:07', '/permission/rolePage', 'GET', 1, NULL, 21);
INSERT INTO `system_operation_log` VALUES ('1738918980572205058', '1', '家庭设备树', '0:0:0:0:0:0:0:1', '2023-12-24 21:46:07', '2023-12-24 21:46:07', '/device/familyDeviceTree', 'GET', 1, NULL, 81);
INSERT INTO `system_operation_log` VALUES ('1738919380817858562', '1', '权限树', '0:0:0:0:0:0:0:1', '2023-12-24 21:47:43', '2023-12-24 21:47:43', '/permission/allPermTree', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1738919380817858563', '1', '角色分页查询', '0:0:0:0:0:0:0:1', '2023-12-24 21:47:43', '2023-12-24 21:47:43', '/permission/rolePage', 'GET', 1, NULL, 39);
INSERT INTO `system_operation_log` VALUES ('1738919381480558594', '1', '家庭设备树', '0:0:0:0:0:0:0:1', '2023-12-24 21:47:43', '2023-12-24 21:47:43', '/device/familyDeviceTree', 'GET', 1, NULL, 113);
INSERT INTO `system_operation_log` VALUES ('1738919505258663937', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-12-24 21:48:12', '2023-12-24 21:48:12', '/permission/getPerm', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1738919506646978562', '1', '权限树', '0:0:0:0:0:0:0:1', '2023-12-24 21:48:13', '2023-12-24 21:48:13', '/permission/allPermTree', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1738919506701504514', '1', '角色分页查询', '0:0:0:0:0:0:0:1', '2023-12-24 21:48:13', '2023-12-24 21:48:13', '/permission/rolePage', 'GET', 1, NULL, 25);
INSERT INTO `system_operation_log` VALUES ('1738919507058020353', '1', '家庭设备树', '0:0:0:0:0:0:0:1', '2023-12-24 21:48:13', '2023-12-24 21:48:13', '/device/familyDeviceTree', 'GET', 1, NULL, 90);
INSERT INTO `system_operation_log` VALUES ('1738919663555891201', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-12-24 21:48:50', '2023-12-24 21:48:50', '/permission/getPerm', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1738919664948400130', '1', '权限树', '0:0:0:0:0:0:0:1', '2023-12-24 21:48:50', '2023-12-24 21:48:50', '/permission/allPermTree', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1738919664948400131', '1', '角色分页查询', '0:0:0:0:0:0:0:1', '2023-12-24 21:48:50', '2023-12-24 21:48:50', '/permission/rolePage', 'GET', 1, NULL, 19);
INSERT INTO `system_operation_log` VALUES ('1738919665468493825', '1', '家庭设备树', '0:0:0:0:0:0:0:1', '2023-12-24 21:48:50', '2023-12-24 21:48:50', '/device/familyDeviceTree', 'GET', 1, NULL, 106);
INSERT INTO `system_operation_log` VALUES ('1738921707847077889', '1', '权限树', '0:0:0:0:0:0:0:1', '2023-12-24 21:56:57', '2023-12-24 21:56:57', '/permission/allPermTree', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1738921708002267138', '1', '角色分页查询', '0:0:0:0:0:0:0:1', '2023-12-24 21:56:57', '2023-12-24 21:56:57', '/permission/rolePage', 'GET', 1, NULL, 25);
INSERT INTO `system_operation_log` VALUES ('1738921708245536770', '1', '家庭设备树', '0:0:0:0:0:0:0:1', '2023-12-24 21:56:58', '2023-12-24 21:56:58', '/device/familyDeviceTree', 'GET', 1, NULL, 81);
INSERT INTO `system_operation_log` VALUES ('1738922135330541570', '1', '权限树', '0:0:0:0:0:0:0:1', '2023-12-24 21:58:39', '2023-12-24 21:58:39', '/permission/allPermTree', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1738922135418621953', '1', '角色分页查询', '0:0:0:0:0:0:0:1', '2023-12-24 21:58:39', '2023-12-24 21:58:39', '/permission/rolePage', 'GET', 1, NULL, 19);
INSERT INTO `system_operation_log` VALUES ('1738922135666085890', '1', '家庭设备树', '0:0:0:0:0:0:0:1', '2023-12-24 21:58:39', '2023-12-24 21:58:39', '/device/familyDeviceTree', 'GET', 1, NULL, 66);
INSERT INTO `system_operation_log` VALUES ('1738924828983873538', '1', '权限树', '0:0:0:0:0:0:0:1', '2023-12-24 22:09:22', '2023-12-24 22:09:22', '/permission/allPermTree', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1738924829252308994', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-12-24 22:09:22', '2023-12-24 22:09:22', '/permission/getPerm', 'GET', 1, NULL, 40);
INSERT INTO `system_operation_log` VALUES ('1738924829386526722', '1', '角色分页查询', '0:0:0:0:0:0:0:1', '2023-12-24 22:09:22', '2023-12-24 22:09:22', '/permission/rolePage', 'GET', 1, NULL, 95);
INSERT INTO `system_operation_log` VALUES ('1738924830179250178', '1', '家庭设备树', '0:0:0:0:0:0:0:1', '2023-12-24 22:09:22', '2023-12-24 22:09:22', '/device/familyDeviceTree', 'GET', 1, NULL, 292);
INSERT INTO `system_operation_log` VALUES ('1738924912865759233', '1', '分页', '0:0:0:0:0:0:0:1', '2023-12-24 22:09:42', '2023-12-24 22:09:42', '/family/page', 'GET', 1, NULL, 75);
INSERT INTO `system_operation_log` VALUES ('1738924914899996674', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-12-24 22:09:42', '2023-12-24 22:09:42', '/product/page', 'GET', 1, NULL, 68);
INSERT INTO `system_operation_log` VALUES ('1738924923003392002', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2023-12-24 22:09:44', '2023-12-24 22:09:44', '/product/list', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1738924923003392003', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-24 22:09:44', '2023-12-24 22:09:44', '/family/list', 'GET', 1, NULL, 13);
INSERT INTO `system_operation_log` VALUES ('1738925113307353090', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-12-24 22:10:29', '2023-12-24 22:10:29', '/permission/getPerm', 'GET', 1, NULL, 10);
INSERT INTO `system_operation_log` VALUES ('1738925114695667713', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-24 22:10:30', '2023-12-24 22:10:30', '/family/list', 'GET', 1, NULL, 8);
INSERT INTO `system_operation_log` VALUES ('1738925114758582273', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2023-12-24 22:10:30', '2023-12-24 22:10:30', '/product/list', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1738925296225206273', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2023-12-24 22:11:13', '2023-12-24 22:11:13', '/product/list', 'GET', 1, NULL, 156);
INSERT INTO `system_operation_log` VALUES ('1738925348192632833', NULL, '登录', '0:0:0:0:0:0:0:1', '2023-12-24 22:11:25', '2023-12-24 22:11:25', '/user/login', 'POST', 1, NULL, 157);
INSERT INTO `system_operation_log` VALUES ('1738925348398153729', '1', '查询个人信息', '0:0:0:0:0:0:0:1', '2023-12-24 22:11:25', '2023-12-24 22:11:25', '/user/info', 'GET', 1, NULL, 7);
INSERT INTO `system_operation_log` VALUES ('1738925348528177154', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-12-24 22:11:25', '2023-12-24 22:11:25', '/permission/getPerm', 'GET', 1, NULL, 44);
INSERT INTO `system_operation_log` VALUES ('1738925350310756353', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2023-12-24 22:11:26', '2023-12-24 22:11:26', '/dashboard/dashboardInfo', 'GET', 1, NULL, 43);
INSERT INTO `system_operation_log` VALUES ('1738925390181810178', '1', '根据家庭ID楼层集合', '0:0:0:0:0:0:0:1', '2023-12-24 22:11:26', '2023-12-24 22:11:26', '/floor/floorList', 'GET', 1, NULL, 33);
INSERT INTO `system_operation_log` VALUES ('1738925390441857025', '1', '权限树', '0:0:0:0:0:0:0:1', '2023-12-24 22:11:30', '2023-12-24 22:11:30', '/permission/allPermTree', 'GET', 1, NULL, 16);
INSERT INTO `system_operation_log` VALUES ('1738925390576074753', '1', '角色分页查询', '0:0:0:0:0:0:0:1', '2023-12-24 22:11:30', '2023-12-24 22:11:30', '/permission/rolePage', 'GET', 1, NULL, 138);
INSERT INTO `system_operation_log` VALUES ('1738925392350265346', '1', '家庭设备树', '0:0:0:0:0:0:0:1', '2023-12-24 22:11:30', '2023-12-24 22:11:30', '/device/familyDeviceTree', 'GET', 1, NULL, 195);
INSERT INTO `system_operation_log` VALUES ('1738925432158404609', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-12-24 22:11:33', '2023-12-24 22:11:33', '/product/page', 'GET', 1, NULL, 39);
INSERT INTO `system_operation_log` VALUES ('1738927222987800577', '1', '权限树', '0:0:0:0:0:0:0:1', '2023-12-24 22:18:52', '2023-12-24 22:18:52', '/permission/allPermTree', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1738927223390453762', '1', '角色分页查询', '0:0:0:0:0:0:0:1', '2023-12-24 22:18:52', '2023-12-24 22:18:52', '/permission/rolePage', 'GET', 1, NULL, 87);
INSERT INTO `system_operation_log` VALUES ('1738927224313200642', '1', '家庭设备树', '0:0:0:0:0:0:0:1', '2023-12-24 22:18:53', '2023-12-24 22:18:53', '/device/familyDeviceTree', 'GET', 1, NULL, 321);
INSERT INTO `system_operation_log` VALUES ('1738927243879628801', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-12-24 22:18:57', '2023-12-24 22:18:57', '/permission/getPerm', 'GET', 1, NULL, 9);
INSERT INTO `system_operation_log` VALUES ('1738927265052475394', '1', '权限树', '0:0:0:0:0:0:0:1', '2023-12-24 22:18:58', '2023-12-24 22:18:58', '/permission/allPermTree', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1738927265379631105', '1', '角色分页查询', '0:0:0:0:0:0:0:1', '2023-12-24 22:18:58', '2023-12-24 22:18:58', '/permission/rolePage', 'GET', 1, NULL, 34);
INSERT INTO `system_operation_log` VALUES ('1738927266361098242', '1', '家庭设备树', '0:0:0:0:0:0:0:1', '2023-12-24 22:18:58', '2023-12-24 22:18:58', '/device/familyDeviceTree', 'GET', 1, NULL, 132);
INSERT INTO `system_operation_log` VALUES ('1738927471605161986', NULL, '登录', '0:0:0:0:0:0:0:1', '2023-12-24 22:19:52', '2023-12-24 22:19:52', '/user/login', 'POST', 1, NULL, 161);
INSERT INTO `system_operation_log` VALUES ('1738927471730991106', '1', '查询个人信息', '0:0:0:0:0:0:0:1', '2023-12-24 22:19:52', '2023-12-24 22:19:52', '/user/info', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1738927471844237314', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-12-24 22:19:52', '2023-12-24 22:19:52', '/permission/getPerm', 'GET', 1, NULL, 46);
INSERT INTO `system_operation_log` VALUES ('1738927473433878529', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2023-12-24 22:19:52', '2023-12-24 22:19:52', '/dashboard/dashboardInfo', 'GET', 1, NULL, 36);
INSERT INTO `system_operation_log` VALUES ('1738927513669836801', '1', '根据家庭ID楼层集合', '0:0:0:0:0:0:0:1', '2023-12-24 22:19:52', '2023-12-24 22:19:52', '/floor/floorList', 'GET', 1, NULL, 39);
INSERT INTO `system_operation_log` VALUES ('1738927513732751362', '1', '权限树', '0:0:0:0:0:0:0:1', '2023-12-24 22:19:55', '2023-12-24 22:19:55', '/permission/allPermTree', 'GET', 1, NULL, 17);
INSERT INTO `system_operation_log` VALUES ('1738927513862774785', '1', '角色分页查询', '0:0:0:0:0:0:0:1', '2023-12-24 22:19:56', '2023-12-24 22:19:56', '/permission/rolePage', 'GET', 1, NULL, 110);
INSERT INTO `system_operation_log` VALUES ('1738927515494359042', '1', '家庭设备树', '0:0:0:0:0:0:0:1', '2023-12-24 22:19:56', '2023-12-24 22:19:56', '/device/familyDeviceTree', 'GET', 1, NULL, 189);
INSERT INTO `system_operation_log` VALUES ('1738928481354489857', '1', '权限树', '0:0:0:0:0:0:0:1', '2023-12-24 22:23:52', '2023-12-24 22:23:52', '/permission/allPermTree', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1738928481622925313', '1', '角色分页查询', '0:0:0:0:0:0:0:1', '2023-12-24 22:23:52', '2023-12-24 22:23:52', '/permission/rolePage', 'GET', 1, NULL, 51);
INSERT INTO `system_operation_log` VALUES ('1738928482474369025', '1', '家庭设备树', '0:0:0:0:0:0:0:1', '2023-12-24 22:23:53', '2023-12-24 22:23:53', '/device/familyDeviceTree', 'GET', 1, NULL, 256);
INSERT INTO `system_operation_log` VALUES ('1738928667774525442', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-12-24 22:24:37', '2023-12-24 22:24:37', '/permission/getPerm', 'GET', 1, NULL, 24);
INSERT INTO `system_operation_log` VALUES ('1738928669104119810', '1', '角色分页查询', '0:0:0:0:0:0:0:1', '2023-12-24 22:24:37', '2023-12-24 22:24:37', '/permission/rolePage', 'GET', 1, NULL, 31);
INSERT INTO `system_operation_log` VALUES ('1738928669104119811', '1', '权限树', '0:0:0:0:0:0:0:1', '2023-12-24 22:24:37', '2023-12-24 22:24:37', '/permission/allPermTree', 'GET', 1, NULL, 1);
INSERT INTO `system_operation_log` VALUES ('1738928996092059649', '1', '家庭设备树', '0:0:0:0:0:0:0:1', '2023-12-24 22:25:55', '2023-12-24 22:25:55', '/device/familyDeviceTree', 'GET', 1, NULL, 77899);
INSERT INTO `system_operation_log` VALUES ('1738929069412687874', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-12-24 22:26:13', '2023-12-24 22:26:13', '/product/page', 'GET', 1, NULL, 93);
INSERT INTO `system_operation_log` VALUES ('1738929075683172353', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2023-12-24 22:26:14', '2023-12-24 22:26:14', '/product/list', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1738929075871916033', '1', '分页查询', '0:0:0:0:0:0:0:1', '2023-12-24 22:26:14', '2023-12-24 22:26:14', '/device/page', 'GET', 1, NULL, 61);
INSERT INTO `system_operation_log` VALUES ('1738929075943219201', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-24 22:26:14', '2023-12-24 22:26:14', '/family/list', 'GET', 1, NULL, 61);
INSERT INTO `system_operation_log` VALUES ('1738929373487144961', '1', '权限树', '0:0:0:0:0:0:0:1', '2023-12-24 22:27:25', '2023-12-24 22:27:25', '/permission/allPermTree', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1738929374586052609', '1', '角色分页查询', '0:0:0:0:0:0:0:1', '2023-12-24 22:27:25', '2023-12-24 22:27:25', '/permission/rolePage', 'GET', 1, NULL, 251);
INSERT INTO `system_operation_log` VALUES ('1738929639292772353', '1', '家庭设备树', '0:0:0:0:0:0:0:1', '2023-12-24 22:28:28', '2023-12-24 22:28:28', '/device/familyDeviceTree', 'GET', 1, NULL, 63348);
INSERT INTO `system_operation_log` VALUES ('1738929639426990081', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-12-24 22:28:28', '2023-12-24 22:28:28', '/product/page', 'GET', 1, NULL, 32);
INSERT INTO `system_operation_log` VALUES ('1738929664743809025', '1', '分页', '0:0:0:0:0:0:0:1', '2023-12-24 22:28:34', '2023-12-24 22:28:34', '/family/page', 'GET', 1, NULL, 25);
INSERT INTO `system_operation_log` VALUES ('1738929673019170818', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-12-24 22:28:36', '2023-12-24 22:28:36', '/product/page', 'GET', 1, NULL, 27);
INSERT INTO `system_operation_log` VALUES ('1738929681298726913', '1', '查询调试所有设备', '0:0:0:0:0:0:0:1', '2023-12-24 22:28:38', '2023-12-24 22:28:38', '/device/debugDeviceList', 'GET', 1, NULL, 8);
INSERT INTO `system_operation_log` VALUES ('1738929682917728257', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-24 22:28:39', '2023-12-24 22:28:39', '/family/list', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1738929706770735106', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2023-12-24 22:28:39', '2023-12-24 22:28:39', '/product/list', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1738929715046096898', '1', '分页查询', '0:0:0:0:0:0:0:1', '2023-12-24 22:28:39', '2023-12-24 22:28:39', '/device/page', 'GET', 1, NULL, 32);
INSERT INTO `system_operation_log` VALUES ('1738930586525999106', '1', '权限树', '0:0:0:0:0:0:0:1', '2023-12-24 22:32:14', '2023-12-24 22:32:14', '/permission/allPermTree', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1738930587838816258', '1', '角色分页查询', '0:0:0:0:0:0:0:1', '2023-12-24 22:32:15', '2023-12-24 22:32:15', '/permission/rolePage', 'GET', 1, NULL, 270);
INSERT INTO `system_operation_log` VALUES ('1738930845872398337', '1', '家庭设备树', '0:0:0:0:0:0:0:1', '2023-12-24 22:33:16', '2023-12-24 22:33:16', '/device/familyDeviceTree', 'GET', 1, NULL, 61832);
INSERT INTO `system_operation_log` VALUES ('1738930860820897794', '1', '分页', '0:0:0:0:0:0:0:1', '2023-12-24 22:33:20', '2023-12-24 22:33:20', '/family/page', 'GET', 1, NULL, 20);
INSERT INTO `system_operation_log` VALUES ('1738930869360500737', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-24 22:33:22', '2023-12-24 22:33:22', '/family/list', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1738930869490524161', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-24 22:33:22', '2023-12-24 22:33:22', '/floor/pageBackend', 'GET', 1, NULL, 35);
INSERT INTO `system_operation_log` VALUES ('1738930887882547201', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-24 22:33:25', '2023-12-24 22:33:25', '/floor/pageBackend', 'GET', 1, NULL, 23);
INSERT INTO `system_operation_log` VALUES ('1738930902881378305', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-24 22:33:27', '2023-12-24 22:33:27', '/family/list', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1738930911412592641', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-24 22:33:28', '2023-12-24 22:33:28', '/room/pageBackend', 'GET', 1, NULL, 86);
INSERT INTO `system_operation_log` VALUES ('1738930911546810369', '1', '根据家庭ID楼层集合', '0:0:0:0:0:0:0:1', '2023-12-24 22:33:29', '2023-12-24 22:33:29', '/floor/floorList', 'GET', 1, NULL, 8);
INSERT INTO `system_operation_log` VALUES ('1738930929871724546', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-24 22:33:30', '2023-12-24 22:33:30', '/room/pageBackend', 'GET', 1, NULL, 20);
INSERT INTO `system_operation_log` VALUES ('1738930958116167681', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-12-24 22:33:43', '2023-12-24 22:33:43', '/product/page', 'GET', 1, NULL, 28);
INSERT INTO `system_operation_log` VALUES ('1738930971047206913', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-24 22:33:46', '2023-12-24 22:33:46', '/family/list', 'GET', 1, NULL, 6);
INSERT INTO `system_operation_log` VALUES ('1738930971047206914', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2023-12-24 22:33:46', '2023-12-24 22:33:46', '/product/list', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1738930971831541761', '1', '分页查询', '0:0:0:0:0:0:0:1', '2023-12-24 22:33:46', '2023-12-24 22:33:46', '/device/page', 'GET', 1, NULL, 35);
INSERT INTO `system_operation_log` VALUES ('1738931235154141185', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-12-24 22:34:49', '2023-12-24 22:34:49', '/permission/getPerm', 'GET', 1, NULL, 7);
INSERT INTO `system_operation_log` VALUES ('1738931236546650114', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-24 22:34:49', '2023-12-24 22:34:49', '/family/list', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1738931236546650115', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2023-12-24 22:34:49', '2023-12-24 22:34:49', '/product/list', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1738931236546650116', '1', '分页查询', '0:0:0:0:0:0:0:1', '2023-12-24 22:34:49', '2023-12-24 22:34:49', '/device/page', 'GET', 1, NULL, 38);
INSERT INTO `system_operation_log` VALUES ('1738931416285159426', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-12-24 22:35:32', '2023-12-24 22:35:32', '/permission/getPerm', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1738931417631531010', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-24 22:35:32', '2023-12-24 22:35:32', '/family/list', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1738931417631531011', '1', '分页查询', '0:0:0:0:0:0:0:1', '2023-12-24 22:35:32', '2023-12-24 22:35:32', '/device/page', 'GET', 1, NULL, 29);
INSERT INTO `system_operation_log` VALUES ('1738931417631531012', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2023-12-24 22:35:32', '2023-12-24 22:35:32', '/product/list', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1738931527698456578', '1', '权限树', '0:0:0:0:0:0:0:1', '2023-12-24 22:35:59', '2023-12-24 22:35:59', '/permission/allPermTree', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1738931528440848385', '1', '角色分页查询', '0:0:0:0:0:0:0:1', '2023-12-24 22:35:59', '2023-12-24 22:35:59', '/permission/rolePage', 'GET', 1, NULL, 159);
INSERT INTO `system_operation_log` VALUES ('1738931859505651714', '1', '家庭设备树', '0:0:0:0:0:0:0:1', '2023-12-24 22:37:18', '2023-12-24 22:37:18', '/device/familyDeviceTree', 'GET', 1, NULL, 79090);
INSERT INTO `system_operation_log` VALUES ('1738931882633043969', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-12-24 22:37:23', '2023-12-24 22:37:23', '/product/page', 'GET', 1, NULL, 25);
INSERT INTO `system_operation_log` VALUES ('1738931902245609474', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-24 22:37:28', '2023-12-24 22:37:28', '/family/list', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1738931902245609475', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2023-12-24 22:37:28', '2023-12-24 22:37:28', '/product/list', 'GET', 1, NULL, 2);
INSERT INTO `system_operation_log` VALUES ('1738931902245609476', '1', '分页查询', '0:0:0:0:0:0:0:1', '2023-12-24 22:37:28', '2023-12-24 22:37:28', '/device/page', 'GET', 1, NULL, 33);
INSERT INTO `system_operation_log` VALUES ('1738931989986254849', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-12-24 22:37:49', '2023-12-24 22:37:49', '/permission/getPerm', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1738931991496204289', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-24 22:37:49', '2023-12-24 22:37:49', '/family/list', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1738931991496204290', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2023-12-24 22:37:49', '2023-12-24 22:37:49', '/product/list', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1738931991496204291', '1', '分页查询', '0:0:0:0:0:0:0:1', '2023-12-24 22:37:49', '2023-12-24 22:37:49', '/device/page', 'GET', 1, NULL, 38);
INSERT INTO `system_operation_log` VALUES ('1738932032004792321', '1', '根据家庭ID楼层集合', '0:0:0:0:0:0:0:1', '2023-12-24 22:37:58', '2023-12-24 22:37:58', '/floor/floorList', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1738932033946755073', '1', '根据楼层id查询房间列表', '0:0:0:0:0:0:0:1', '2023-12-24 22:37:59', '2023-12-24 22:37:59', '/room/roomListByFloorId', 'GET', 1, NULL, 13);
INSERT INTO `system_operation_log` VALUES ('1738932249785638913', '1', '分页', '0:0:0:0:0:0:0:1', '2023-12-24 22:38:51', '2023-12-24 22:38:51', '/family/page', 'GET', 1, NULL, 20);
INSERT INTO `system_operation_log` VALUES ('1738932268114747393', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-24 22:38:55', '2023-12-24 22:38:55', '/family/list', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1738932268248965122', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2023-12-24 22:38:55', '2023-12-24 22:38:55', '/floor/pageBackend', 'GET', 1, NULL, 27);
INSERT INTO `system_operation_log` VALUES ('1738932272468434946', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-24 22:38:56', '2023-12-24 22:38:56', '/family/list', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1738932291762233346', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-24 22:38:56', '2023-12-24 22:38:56', '/room/pageBackend', 'GET', 1, NULL, 20);
INSERT INTO `system_operation_log` VALUES ('1738932338298036226', '1', '根据家庭ID楼层集合', '0:0:0:0:0:0:0:1', '2023-12-24 22:39:12', '2023-12-24 22:39:12', '/floor/floorList', 'GET', 1, NULL, 2);
INSERT INTO `system_operation_log` VALUES ('1738932344375582721', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-24 22:39:13', '2023-12-24 22:39:13', '/room/pageBackend', 'GET', 1, NULL, 19);
INSERT INTO `system_operation_log` VALUES ('1738932433672314883', '1', '新增或修改房间', '0:0:0:0:0:0:0:1', '2023-12-24 22:39:35', '2023-12-24 22:39:35', '/room/addUpdate', 'POST', 1, NULL, 38);
INSERT INTO `system_operation_log` VALUES ('1738932433886224386', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2023-12-24 22:39:35', '2023-12-24 22:39:35', '/room/pageBackend', 'GET', 1, NULL, 29);
INSERT INTO `system_operation_log` VALUES ('1738932456015372290', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-12-24 22:39:40', '2023-12-24 22:39:40', '/product/page', 'GET', 1, NULL, 25);
INSERT INTO `system_operation_log` VALUES ('1738932461912563714', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2023-12-24 22:39:41', '2023-12-24 22:39:41', '/product/list', 'GET', 1, NULL, 2);
INSERT INTO `system_operation_log` VALUES ('1738932475674075137', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-24 22:39:41', '2023-12-24 22:39:41', '/family/list', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1738932475934121986', '1', '分页查询', '0:0:0:0:0:0:0:1', '2023-12-24 22:39:41', '2023-12-24 22:39:41', '/device/page', 'GET', 1, NULL, 36);
INSERT INTO `system_operation_log` VALUES ('1738932498046492674', '1', '根据家庭ID楼层集合', '0:0:0:0:0:0:0:1', '2023-12-24 22:39:47', '2023-12-24 22:39:47', '/floor/floorList', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1738932504031764481', '1', '根据楼层id查询房间列表', '0:0:0:0:0:0:0:1', '2023-12-24 22:39:49', '2023-12-24 22:39:49', '/room/roomListByFloorId', 'GET', 1, NULL, 1);
INSERT INTO `system_operation_log` VALUES ('1738932970253713409', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2023-12-24 22:41:43', '2023-12-24 22:41:43', '/product/list', 'GET', 1, NULL, 182);
INSERT INTO `system_operation_log` VALUES ('1738932975811166209', NULL, '登录', '0:0:0:0:0:0:0:1', '2023-12-24 22:41:44', '2023-12-24 22:41:44', '/user/login', 'POST', 1, NULL, 160);
INSERT INTO `system_operation_log` VALUES ('1738932976033464322', '1', '查询个人信息', '0:0:0:0:0:0:0:1', '2023-12-24 22:41:44', '2023-12-24 22:41:44', '/user/info', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1738932976096378882', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-12-24 22:41:44', '2023-12-24 22:41:44', '/permission/getPerm', 'GET', 1, NULL, 45);
INSERT INTO `system_operation_log` VALUES ('1738933012305805313', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2023-12-24 22:41:44', '2023-12-24 22:41:44', '/dashboard/dashboardInfo', 'GET', 1, NULL, 41);
INSERT INTO `system_operation_log` VALUES ('1738933017875841025', '1', '根据家庭ID楼层集合', '0:0:0:0:0:0:0:1', '2023-12-24 22:41:44', '2023-12-24 22:41:44', '/floor/floorList', 'GET', 1, NULL, 29);
INSERT INTO `system_operation_log` VALUES ('1738933018072973314', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2023-12-24 22:41:50', '2023-12-24 22:41:50', '/product/page', 'GET', 1, NULL, 94);
INSERT INTO `system_operation_log` VALUES ('1738933018135887874', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2023-12-24 22:41:52', '2023-12-24 22:41:52', '/product/list', 'GET', 1, NULL, 7);
INSERT INTO `system_operation_log` VALUES ('1738933054290788354', '1', '下拉', '0:0:0:0:0:0:0:1', '2023-12-24 22:41:52', '2023-12-24 22:41:52', '/family/list', 'GET', 1, NULL, 49);
INSERT INTO `system_operation_log` VALUES ('1738933059839852546', '1', '根据家庭ID楼层集合', '0:0:0:0:0:0:0:1', '2023-12-24 22:41:56', '2023-12-24 22:41:56', '/floor/floorList', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1738933060095705090', '1', '根据楼层id查询房间列表', '0:0:0:0:0:0:0:1', '2023-12-24 22:41:57', '2023-12-24 22:41:57', '/room/roomListByFloorId', 'GET', 1, NULL, 30);
INSERT INTO `system_operation_log` VALUES ('1738933078177349633', '1', '添加或修改设备', '0:0:0:0:0:0:0:1', '2023-12-24 22:42:08', '2023-12-24 22:42:08', '/device/addUpdate', 'POST', 1, NULL, 39);
INSERT INTO `system_operation_log` VALUES ('1738933096267382786', '1', '分页查询', '0:0:0:0:0:0:0:1', '2023-12-24 22:42:08', '2023-12-24 22:42:08', '/device/page', 'GET', 1, NULL, 44);
INSERT INTO `system_operation_log` VALUES ('1738933112306401282', '1', '权限树', '0:0:0:0:0:0:0:1', '2023-12-24 22:42:16', '2023-12-24 22:42:16', '/permission/allPermTree', 'GET', 1, NULL, 7);
INSERT INTO `system_operation_log` VALUES ('1738933112574836738', '1', '角色分页查询', '0:0:0:0:0:0:0:1', '2023-12-24 22:42:17', '2023-12-24 22:42:17', '/permission/rolePage', 'GET', 1, NULL, 65);
INSERT INTO `system_operation_log` VALUES ('1738933120170721282', '1', '家庭设备树', '0:0:0:0:0:0:0:1', '2023-12-24 22:42:17', '2023-12-24 22:42:17', '/device/familyDeviceTree', 'GET', 1, NULL, 131);
INSERT INTO `system_operation_log` VALUES ('1738935340169748481', NULL, '登录', '0:0:0:0:0:0:0:1', '2023-12-24 22:51:08', '2023-12-24 22:51:08', '/user/login', 'POST', 1, NULL, 166);
INSERT INTO `system_operation_log` VALUES ('1738935340241051650', '1', '查询个人信息', '0:0:0:0:0:0:0:1', '2023-12-24 22:51:08', '2023-12-24 22:51:08', '/user/info', 'GET', 1, NULL, 6);
INSERT INTO `system_operation_log` VALUES ('1738935340375269378', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-12-24 22:51:08', '2023-12-24 22:51:08', '/permission/getPerm', 'GET', 1, NULL, 41);
INSERT INTO `system_operation_log` VALUES ('1738935342019436545', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2023-12-24 22:51:08', '2023-12-24 22:51:08', '/dashboard/dashboardInfo', 'GET', 1, NULL, 34);
INSERT INTO `system_operation_log` VALUES ('1738935382205063170', '1', '根据家庭ID楼层集合', '0:0:0:0:0:0:0:1', '2023-12-24 22:51:08', '2023-12-24 22:51:08', '/floor/floorList', 'GET', 1, NULL, 44);
INSERT INTO `system_operation_log` VALUES ('1738935382267977730', '1', '权限树', '0:0:0:0:0:0:0:1', '2023-12-24 22:51:13', '2023-12-24 22:51:13', '/permission/allPermTree', 'GET', 1, NULL, 10);
INSERT INTO `system_operation_log` VALUES ('1738935382398001154', '1', '角色分页查询', '0:0:0:0:0:0:0:1', '2023-12-24 22:51:13', '2023-12-24 22:51:13', '/permission/rolePage', 'GET', 1, NULL, 103);
INSERT INTO `system_operation_log` VALUES ('1738935384029585410', '1', '家庭设备树', '0:0:0:0:0:0:0:1', '2023-12-24 22:51:13', '2023-12-24 22:51:13', '/device/familyDeviceTree', 'GET', 1, NULL, 173);
INSERT INTO `system_operation_log` VALUES ('1738936245673844738', '1', '权限树', '0:0:0:0:0:0:0:1', '2023-12-24 22:54:43', '2023-12-24 22:54:43', '/permission/allPermTree', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1738936245791285249', '1', '角色分页查询', '0:0:0:0:0:0:0:1', '2023-12-24 22:54:44', '2023-12-24 22:54:44', '/permission/rolePage', 'GET', 1, NULL, 26);
INSERT INTO `system_operation_log` VALUES ('1738936246181355522', '1', '家庭设备树', '0:0:0:0:0:0:0:1', '2023-12-24 22:54:44', '2023-12-24 22:54:44', '/device/familyDeviceTree', 'GET', 1, NULL, 129);
INSERT INTO `system_operation_log` VALUES ('1738937335760871425', '1', '权限树', '0:0:0:0:0:0:0:1', '2023-12-24 22:59:03', '2023-12-24 22:59:03', '/permission/allPermTree', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1738937335886700545', '1', '角色分页查询', '0:0:0:0:0:0:0:1', '2023-12-24 22:59:03', '2023-12-24 22:59:03', '/permission/rolePage', 'GET', 1, NULL, 24);
INSERT INTO `system_operation_log` VALUES ('1738937336155136001', '1', '家庭设备树', '0:0:0:0:0:0:0:1', '2023-12-24 22:59:03', '2023-12-24 22:59:03', '/device/familyDeviceTree', 'GET', 1, NULL, 93);
INSERT INTO `system_operation_log` VALUES ('1738937782479413249', '1', '权限树', '0:0:0:0:0:0:0:1', '2023-12-24 23:00:50', '2023-12-24 23:00:50', '/permission/allPermTree', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1738937782613630977', '1', '角色分页查询', '0:0:0:0:0:0:0:1', '2023-12-24 23:00:50', '2023-12-24 23:00:50', '/permission/rolePage', 'GET', 1, NULL, 23);
INSERT INTO `system_operation_log` VALUES ('1738937782890455042', '1', '家庭设备树', '0:0:0:0:0:0:0:1', '2023-12-24 23:00:50', '2023-12-24 23:00:50', '/device/familyDeviceTree', 'GET', 1, NULL, 88);
INSERT INTO `system_operation_log` VALUES ('1738937849458253826', '1', '权限树', '0:0:0:0:0:0:0:1', '2023-12-24 23:01:06', '2023-12-24 23:01:06', '/permission/allPermTree', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1738937849579888641', '1', '角色分页查询', '0:0:0:0:0:0:0:1', '2023-12-24 23:01:06', '2023-12-24 23:01:06', '/permission/rolePage', 'GET', 1, NULL, 22);
INSERT INTO `system_operation_log` VALUES ('1738937849848324098', '1', '家庭设备树', '0:0:0:0:0:0:0:1', '2023-12-24 23:01:06', '2023-12-24 23:01:06', '/device/familyDeviceTree', 'GET', 1, NULL, 83);
INSERT INTO `system_operation_log` VALUES ('1738939144080515074', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2023-12-24 23:06:15', '2023-12-24 23:06:15', '/permission/getPerm', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1738939145296863234', '1', '权限树', '0:0:0:0:0:0:0:1', '2023-12-24 23:06:15', '2023-12-24 23:06:15', '/permission/allPermTree', 'GET', 1, NULL, 0);
INSERT INTO `system_operation_log` VALUES ('1738939145296863235', '1', '角色分页查询', '0:0:0:0:0:0:0:1', '2023-12-24 23:06:15', '2023-12-24 23:06:15', '/permission/rolePage', 'GET', 1, NULL, 21);
INSERT INTO `system_operation_log` VALUES ('1738939145842122754', '1', '家庭设备树', '0:0:0:0:0:0:0:1', '2023-12-24 23:06:15', '2023-12-24 23:06:15', '/device/familyDeviceTree', 'GET', 1, NULL, 110);
INSERT INTO `system_operation_log` VALUES ('1742916845145505793', NULL, '登录', '0:0:0:0:0:0:0:1', '2024-01-04 22:32:12', '2024-01-04 22:32:12', '/user/login', 'POST', 1, NULL, 138);
INSERT INTO `system_operation_log` VALUES ('1742916845346832386', '1', '查询个人信息', '0:0:0:0:0:0:0:1', '2024-01-04 22:32:12', '2024-01-04 22:32:12', '/user/info', 'GET', 1, NULL, 2);
INSERT INTO `system_operation_log` VALUES ('1742916845401358337', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2024-01-04 22:32:12', '2024-01-04 22:32:12', '/permission/getPerm', 'GET', 1, NULL, 28);
INSERT INTO `system_operation_log` VALUES ('1742916846970028034', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2024-01-04 22:32:13', '2024-01-04 22:32:13', '/dashboard/dashboardInfo', 'GET', 1, NULL, 42);
INSERT INTO `system_operation_log` VALUES ('1742916887159848962', '1', '根据家庭ID楼层集合', '0:0:0:0:0:0:0:1', '2024-01-04 22:32:13', '2024-01-04 22:32:13', '/floor/floorList', 'GET', 1, NULL, 38);
INSERT INTO `system_operation_log` VALUES ('1742917107948011522', '1', '分页', '0:0:0:0:0:0:0:1', '2024-01-04 22:33:15', '2024-01-04 22:33:15', '/family/page', 'GET', 1, NULL, 161);
INSERT INTO `system_operation_log` VALUES ('1742917164319457282', '1', '下拉', '0:0:0:0:0:0:0:1', '2024-01-04 22:33:28', '2024-01-04 22:33:28', '/family/list', 'GET', 1, NULL, 16);
INSERT INTO `system_operation_log` VALUES ('1742917164453675009', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2024-01-04 22:33:29', '2024-01-04 22:33:29', '/floor/pageBackend', 'GET', 1, NULL, 55);
INSERT INTO `system_operation_log` VALUES ('1742917171760152577', '1', '下拉', '0:0:0:0:0:0:0:1', '2024-01-04 22:33:30', '2024-01-04 22:33:30', '/family/list', 'GET', 1, NULL, 7);
INSERT INTO `system_operation_log` VALUES ('1742917171890176002', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2024-01-04 22:33:30', '2024-01-04 22:33:30', '/room/pageBackend', 'GET', 1, NULL, 31);
INSERT INTO `system_operation_log` VALUES ('1742917206438658050', '1', '根据家庭ID楼层集合', '0:0:0:0:0:0:0:1', '2024-01-04 22:33:32', '2024-01-04 22:33:32', '/floor/floorList', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1742917206639984642', '1', '角色下拉列表', '0:0:0:0:0:0:0:1', '2024-01-04 22:33:32', '2024-01-04 22:33:32', '/permission/roleList', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1742917213774495745', '1', '分页查询', '0:0:0:0:0:0:0:1', '2024-01-04 22:33:32', '2024-01-04 22:33:32', '/user/page', 'GET', 1, NULL, 55);
INSERT INTO `system_operation_log` VALUES ('1742917213904519170', '1', '根据楼层id查询房间设备树', '0:0:0:0:0:0:0:1', '2024-01-04 22:33:32', '2024-01-04 22:33:32', '/device/roomDeviceTree', 'GET', 1, NULL, 70);
INSERT INTO `system_operation_log` VALUES ('1742917248469778433', '1', '分页', '0:0:0:0:0:0:0:1', '2024-01-04 22:33:37', '2024-01-04 22:33:37', '/family/page', 'GET', 1, NULL, 66);
INSERT INTO `system_operation_log` VALUES ('1742917248662716417', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2024-01-04 22:33:45', '2024-01-04 22:33:45', '/product/page', 'GET', 1, NULL, 78);
INSERT INTO `system_operation_log` VALUES ('1742917369068601345', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2024-01-04 22:34:17', '2024-01-04 22:34:17', '/product/list', 'GET', 1, NULL, 6);
INSERT INTO `system_operation_log` VALUES ('1742917369068601346', '1', '下拉', '0:0:0:0:0:0:0:1', '2024-01-04 22:34:17', '2024-01-04 22:34:17', '/family/list', 'GET', 1, NULL, 12);
INSERT INTO `system_operation_log` VALUES ('1742917369190236161', '1', '分页查询', '0:0:0:0:0:0:0:1', '2024-01-04 22:34:17', '2024-01-04 22:34:17', '/device/page', 'GET', 1, NULL, 53);
INSERT INTO `system_operation_log` VALUES ('1742917390350499841', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2024-01-04 22:34:22', '2024-01-04 22:34:22', '/product/page', 'GET', 1, NULL, 78);
INSERT INTO `system_operation_log` VALUES ('1742917430255108098', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2024-01-04 22:34:32', '2024-01-04 22:34:32', '/product/list', 'GET', 1, NULL, 9);
INSERT INTO `system_operation_log` VALUES ('1742917430380937218', NULL, '', '0:0:0:0:0:0:0:1', '2024-01-04 22:34:32', '2024-01-04 22:34:32', '/error', 'GET', 0, '系统错误请联系管理员', 5);
INSERT INTO `system_operation_log` VALUES ('1742917440476626945', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2024-01-04 22:34:34', '2024-01-04 22:34:34', '/product/page', 'GET', 1, NULL, 31);
INSERT INTO `system_operation_log` VALUES ('1742917937908498434', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2024-01-04 22:36:33', '2024-01-04 22:36:33', '/product/page', 'GET', 1, NULL, 59);
INSERT INTO `system_operation_log` VALUES ('1742917947127578626', '1', '分页', '0:0:0:0:0:0:0:1', '2024-01-04 22:36:35', '2024-01-04 22:36:35', '/family/page', 'GET', 1, NULL, 52);
INSERT INTO `system_operation_log` VALUES ('1742917956698980354', '1', '根据家庭ID楼层集合', '0:0:0:0:0:0:0:1', '2024-01-04 22:36:37', '2024-01-04 22:36:37', '/floor/floorList', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1742917956837392386', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2024-01-04 22:36:37', '2024-01-04 22:36:37', '/dashboard/dashboardInfo', 'GET', 1, NULL, 18);
INSERT INTO `system_operation_log` VALUES ('1742917979922841601', '1', '分页', '0:0:0:0:0:0:0:1', '2024-01-04 22:36:39', '2024-01-04 22:36:39', '/family/page', 'GET', 1, NULL, 39);
INSERT INTO `system_operation_log` VALUES ('1742917989204836354', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2024-01-04 22:36:42', '2024-01-04 22:36:42', '/product/page', 'GET', 1, NULL, 85);
INSERT INTO `system_operation_log` VALUES ('1742917998822375426', '1', '分页', '0:0:0:0:0:0:0:1', '2024-01-04 22:36:44', '2024-01-04 22:36:44', '/family/page', 'GET', 1, NULL, 39);
INSERT INTO `system_operation_log` VALUES ('1742917998885289986', '1', '根据家庭ID楼层集合', '0:0:0:0:0:0:0:1', '2024-01-04 22:36:45', '2024-01-04 22:36:45', '/floor/floorList', 'GET', 1, NULL, 2);
INSERT INTO `system_operation_log` VALUES ('1742918021924601857', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2024-01-04 22:36:45', '2024-01-04 22:36:45', '/dashboard/dashboardInfo', 'GET', 1, NULL, 9);
INSERT INTO `system_operation_log` VALUES ('1742918055923630081', '1', '分页', '0:0:0:0:0:0:0:1', '2024-01-04 22:37:01', '2024-01-04 22:37:01', '/family/page', 'GET', 1, NULL, 61);
INSERT INTO `system_operation_log` VALUES ('1742918077473964034', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2024-01-04 22:37:06', '2024-01-04 22:37:06', '/product/page', 'GET', 1, NULL, 48);
INSERT INTO `system_operation_log` VALUES ('1742918084449091585', '1', '分页', '0:0:0:0:0:0:0:1', '2024-01-04 22:37:08', '2024-01-04 22:37:08', '/family/page', 'GET', 1, NULL, 23);
INSERT INTO `system_operation_log` VALUES ('1742918103377985537', '1', '分页', '0:0:0:0:0:0:0:1', '2024-01-04 22:37:12', '2024-01-04 22:37:12', '/family/page', 'GET', 1, NULL, 48);
INSERT INTO `system_operation_log` VALUES ('1742918334840651778', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2024-01-04 22:38:08', '2024-01-04 22:38:08', '/permission/getPerm', 'GET', 1, NULL, 12);
INSERT INTO `system_operation_log` VALUES ('1742918354604212226', '1', '分页', '0:0:0:0:0:0:0:1', '2024-01-04 22:38:12', '2024-01-04 22:38:12', '/family/page', 'GET', 1, NULL, 65);
INSERT INTO `system_operation_log` VALUES ('1742918361998770177', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2024-01-04 22:38:14', '2024-01-04 22:38:14', '/product/page', 'GET', 1, NULL, 71);
INSERT INTO `system_operation_log` VALUES ('1742918373356945410', '1', '分页', '0:0:0:0:0:0:0:1', '2024-01-04 22:38:17', '2024-01-04 22:38:17', '/family/page', 'GET', 1, NULL, 34);
INSERT INTO `system_operation_log` VALUES ('1742918380864749569', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2024-01-04 22:38:19', '2024-01-04 22:38:19', '/product/page', 'GET', 1, NULL, 70);
INSERT INTO `system_operation_log` VALUES ('1742918396647915521', '1', '分页', '0:0:0:0:0:0:0:1', '2024-01-04 22:38:20', '2024-01-04 22:38:20', '/family/page', 'GET', 1, NULL, 35);
INSERT INTO `system_operation_log` VALUES ('1742918403962781698', '1', '分页', '0:0:0:0:0:0:0:1', '2024-01-04 22:38:24', '2024-01-04 22:38:24', '/family/page', 'GET', 1, NULL, 43);
INSERT INTO `system_operation_log` VALUES ('1742918415455174658', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2024-01-04 22:38:26', '2024-01-04 22:38:26', '/product/page', 'GET', 1, NULL, 38);
INSERT INTO `system_operation_log` VALUES ('1742918422891675650', '1', '分页', '0:0:0:0:0:0:0:1', '2024-01-04 22:38:28', '2024-01-04 22:38:28', '/family/page', 'GET', 1, NULL, 62);
INSERT INTO `system_operation_log` VALUES ('1742918438687424514', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2024-01-04 22:38:29', '2024-01-04 22:38:29', '/product/page', 'GET', 1, NULL, 39);
INSERT INTO `system_operation_log` VALUES ('1742918446035845121', '1', '分页', '0:0:0:0:0:0:0:1', '2024-01-04 22:38:31', '2024-01-04 22:38:31', '/family/page', 'GET', 1, NULL, 64);
INSERT INTO `system_operation_log` VALUES ('1742918457473712129', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2024-01-04 22:38:32', '2024-01-04 22:38:32', '/product/page', 'GET', 1, NULL, 47);
INSERT INTO `system_operation_log` VALUES ('1742919332007067649', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2024-01-04 22:42:05', '2024-01-04 22:42:05', '/product/page', 'GET', 1, NULL, 21);
INSERT INTO `system_operation_log` VALUES ('1742919361937620993', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2024-01-04 22:42:12', '2024-01-04 22:42:12', '/product/list', 'GET', 1, NULL, 2);
INSERT INTO `system_operation_log` VALUES ('1742919361937620994', '1', '下拉', '0:0:0:0:0:0:0:1', '2024-01-04 22:42:12', '2024-01-04 22:42:12', '/family/list', 'GET', 1, NULL, 2);
INSERT INTO `system_operation_log` VALUES ('1742919362013118465', '1', '分页查询', '0:0:0:0:0:0:0:1', '2024-01-04 22:42:12', '2024-01-04 22:42:12', '/device/page', 'GET', 1, NULL, 21);
INSERT INTO `system_operation_log` VALUES ('1742919407148023809', '1', '根据家庭ID楼层集合', '0:0:0:0:0:0:0:1', '2024-01-04 22:42:23', '2024-01-04 22:42:23', '/floor/floorList', 'GET', 1, NULL, 2);
INSERT INTO `system_operation_log` VALUES ('1742919415331110913', '1', '根据楼层id查询房间列表', '0:0:0:0:0:0:0:1', '2024-01-04 22:42:25', '2024-01-04 22:42:25', '/room/roomListByFloorId', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1743273789601439745', NULL, '登录', '0:0:0:0:0:0:0:1', '2024-01-05 22:10:35', '2024-01-05 22:10:35', '/user/login', 'POST', 1, NULL, 209);
INSERT INTO `system_operation_log` VALUES ('1743273790041841666', '1', '查询个人信息', '0:0:0:0:0:0:0:1', '2024-01-05 22:10:35', '2024-01-05 22:10:35', '/user/info', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1743273790041841667', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2024-01-05 22:10:35', '2024-01-05 22:10:35', '/permission/getPerm', 'GET', 1, NULL, 40);
INSERT INTO `system_operation_log` VALUES ('1743273792155770881', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2024-01-05 22:10:35', '2024-01-05 22:10:35', '/dashboard/dashboardInfo', 'GET', 1, NULL, 28);
INSERT INTO `system_operation_log` VALUES ('1743273831557062658', '1', '根据家庭ID楼层集合', '0:0:0:0:0:0:0:1', '2024-01-05 22:10:35', '2024-01-05 22:10:35', '/floor/floorList', 'GET', 1, NULL, 33);
INSERT INTO `system_operation_log` VALUES ('1743273853677821954', '1', '分页', '0:0:0:0:0:0:0:1', '2024-01-05 22:10:50', '2024-01-05 22:10:50', '/family/page', 'GET', 1, NULL, 82);
INSERT INTO `system_operation_log` VALUES ('1743273864901779457', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2024-01-05 22:10:53', '2024-01-05 22:10:53', '/product/page', 'GET', 1, NULL, 50);
INSERT INTO `system_operation_log` VALUES ('1743273886645051394', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2024-01-05 22:10:58', '2024-01-05 22:10:58', '/product/list', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1743273886703771650', NULL, '', '0:0:0:0:0:0:0:1', '2024-01-05 22:10:58', '2024-01-05 22:10:58', '/error', 'GET', 0, '系统错误请联系管理员', 4);
INSERT INTO `system_operation_log` VALUES ('1743273902176559105', NULL, '查询系统基础信息', '0:0:0:0:0:0:0:1', '2024-01-05 22:11:01', '2024-01-05 22:11:01', '/systemInfo/basicInfo', 'GET', 1, NULL, 6);
INSERT INTO `system_operation_log` VALUES ('1743273948947243010', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2024-01-05 22:11:13', '2024-01-05 22:11:13', '/product/page', 'GET', 1, NULL, 27);
INSERT INTO `system_operation_log` VALUES ('1743273955121258498', '1', '查询调试所有设备', '0:0:0:0:0:0:0:1', '2024-01-05 22:11:14', '2024-01-05 22:11:14', '/device/debugDeviceList', 'GET', 1, NULL, 21);
INSERT INTO `system_operation_log` VALUES ('1743273973731385346', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2024-01-05 22:11:18', '2024-01-05 22:11:18', '/product/list', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1743273973731385347', '1', '下拉', '0:0:0:0:0:0:0:1', '2024-01-05 22:11:18', '2024-01-05 22:11:18', '/family/list', 'GET', 1, NULL, 6);
INSERT INTO `system_operation_log` VALUES ('1743273990978363394', '1', '分页查询', '0:0:0:0:0:0:0:1', '2024-01-05 22:11:19', '2024-01-05 22:11:19', '/device/page', 'GET', 1, NULL, 49);
INSERT INTO `system_operation_log` VALUES ('1743273997173350402', '1', '查询调试所有设备', '0:0:0:0:0:0:0:1', '2024-01-05 22:11:24', '2024-01-05 22:11:24', '/device/debugDeviceList', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1743274057596493826', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2024-01-05 22:11:38', '2024-01-05 22:11:38', '/product/list', 'GET', 1, NULL, 7);
INSERT INTO `system_operation_log` VALUES ('1743274057596493827', '1', '下拉', '0:0:0:0:0:0:0:1', '2024-01-05 22:11:38', '2024-01-05 22:11:38', '/family/list', 'GET', 1, NULL, 19);
INSERT INTO `system_operation_log` VALUES ('1743274057667796993', '1', '分页查询', '0:0:0:0:0:0:0:1', '2024-01-05 22:11:38', '2024-01-05 22:11:38', '/device/page', 'GET', 1, NULL, 30);
INSERT INTO `system_operation_log` VALUES ('1743274076877709313', '1', '根据家庭ID楼层集合', '0:0:0:0:0:0:0:1', '2024-01-05 22:11:43', '2024-01-05 22:11:43', '/floor/floorList', 'GET', 1, NULL, 10);
INSERT INTO `system_operation_log` VALUES ('1743274099644391426', '1', '根据楼层id查询房间列表', '0:0:0:0:0:0:0:1', '2024-01-05 22:11:45', '2024-01-05 22:11:45', '/room/roomListByFloorId', 'GET', 1, NULL, 16);
INSERT INTO `system_operation_log` VALUES ('1743274154010959873', '1', '添加或修改设备', '0:0:0:0:0:0:0:1', '2024-01-05 22:12:01', '2024-01-05 22:12:01', '/device/addUpdate', 'POST', 1, NULL, 35);
INSERT INTO `system_operation_log` VALUES ('1743274154254229505', '1', '分页查询', '0:0:0:0:0:0:0:1', '2024-01-05 22:12:02', '2024-01-05 22:12:02', '/device/page', 'GET', 1, NULL, 25);
INSERT INTO `system_operation_log` VALUES ('1743274573810458625', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2024-01-05 22:13:42', '2024-01-05 22:13:42', '/permission/getPerm', 'GET', 1, NULL, 6);
INSERT INTO `system_operation_log` VALUES ('1743274575769198593', '1', '分页查询', '0:0:0:0:0:0:0:1', '2024-01-05 22:13:42', '2024-01-05 22:13:42', '/device/page', 'GET', 1, NULL, 37);
INSERT INTO `system_operation_log` VALUES ('1743274577144930306', '1', '下拉', '0:0:0:0:0:0:0:1', '2024-01-05 22:13:42', '2024-01-05 22:13:42', '/family/list', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1743274577144930307', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2024-01-05 22:13:42', '2024-01-05 22:13:42', '/product/list', 'GET', 1, NULL, 219);
INSERT INTO `system_operation_log` VALUES ('1743274796246982657', '1', '根据家庭ID楼层集合', '0:0:0:0:0:0:0:1', '2024-01-05 22:14:35', '2024-01-05 22:14:35', '/floor/floorList', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1743274802513272834', '1', '根据楼层id查询房间列表', '0:0:0:0:0:0:0:1', '2024-01-05 22:14:36', '2024-01-05 22:14:36', '/room/roomListByFloorId', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1743274846566047746', '1', '添加或修改设备', '0:0:0:0:0:0:0:1', '2024-01-05 22:14:47', '2024-01-05 22:14:47', '/device/addUpdate', 'POST', 1, NULL, 20);
INSERT INTO `system_operation_log` VALUES ('1743274846918369282', '1', '分页查询', '0:0:0:0:0:0:0:1', '2024-01-05 22:14:47', '2024-01-05 22:14:47', '/device/page', 'GET', 1, NULL, 23);
INSERT INTO `system_operation_log` VALUES ('1743278198511161346', NULL, '登录', '0:0:0:0:0:0:0:1', '2024-01-05 22:28:06', '2024-01-05 22:28:06', '/user/login', 'POST', 1, NULL, 170);
INSERT INTO `system_operation_log` VALUES ('1743278198691516418', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2024-01-05 22:28:06', '2024-01-05 22:28:06', '/permission/getPerm', 'GET', 1, NULL, 18);
INSERT INTO `system_operation_log` VALUES ('1743278198758625281', '1', '查询个人信息', '0:0:0:0:0:0:0:1', '2024-01-05 22:28:06', '2024-01-05 22:28:06', '/user/info', 'GET', 1, NULL, 6);
INSERT INTO `system_operation_log` VALUES ('1743278201178738689', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2024-01-05 22:28:06', '2024-01-05 22:28:06', '/dashboard/dashboardInfo', 'GET', 1, NULL, 29);
INSERT INTO `system_operation_log` VALUES ('1743278240617779201', '1', '根据家庭ID楼层集合', '0:0:0:0:0:0:0:1', '2024-01-05 22:28:06', '2024-01-05 22:28:06', '/floor/floorList', 'GET', 1, NULL, 37);
INSERT INTO `system_operation_log` VALUES ('1743278240743608321', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2024-01-05 22:28:08', '2024-01-05 22:28:08', '/product/page', 'GET', 1, NULL, 107);
INSERT INTO `system_operation_log` VALUES ('1743278240814911489', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2024-01-05 22:28:13', '2024-01-05 22:28:13', '/product/list', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1743278243205664770', '1', '下拉', '0:0:0:0:0:0:0:1', '2024-01-05 22:28:13', '2024-01-05 22:28:13', '/family/list', 'GET', 1, NULL, 38);
INSERT INTO `system_operation_log` VALUES ('1743278282606956545', '1', '分页查询', '0:0:0:0:0:0:0:1', '2024-01-05 22:28:13', '2024-01-05 22:28:13', '/device/page', 'GET', 1, NULL, 92);
INSERT INTO `system_operation_log` VALUES ('1743278282669871105', '1', '根据家庭ID楼层集合', '0:0:0:0:0:0:0:1', '2024-01-05 22:28:17', '2024-01-05 22:28:17', '/floor/floorList', 'GET', 1, NULL, 7);
INSERT INTO `system_operation_log` VALUES ('1743278282669871106', '1', '根据楼层id查询房间列表', '0:0:0:0:0:0:0:1', '2024-01-05 22:28:18', '2024-01-05 22:28:18', '/room/roomListByFloorId', 'GET', 1, NULL, 31);
INSERT INTO `system_operation_log` VALUES ('1743278321140027394', '1', '添加或修改设备', '0:0:0:0:0:0:0:1', '2024-01-05 22:28:35', '2024-01-05 22:28:35', '/device/addUpdate', 'POST', 1, NULL, 30);
INSERT INTO `system_operation_log` VALUES ('1743278324617105410', '1', '分页查询', '0:0:0:0:0:0:0:1', '2024-01-05 22:28:35', '2024-01-05 22:28:35', '/device/page', 'GET', 1, NULL, 63);
INSERT INTO `system_operation_log` VALUES ('1743279155156369409', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2024-01-05 22:31:54', '2024-01-05 22:31:54', '/product/list', 'GET', 1, NULL, 352);
INSERT INTO `system_operation_log` VALUES ('1743279160869011458', NULL, '登录', '0:0:0:0:0:0:0:1', '2024-01-05 22:31:55', '2024-01-05 22:31:55', '/user/login', 'POST', 1, NULL, 175);
INSERT INTO `system_operation_log` VALUES ('1743279161133252609', '1', '查询个人信息', '0:0:0:0:0:0:0:1', '2024-01-05 22:31:55', '2024-01-05 22:31:55', '/user/info', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1743279161259081729', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2024-01-05 22:31:55', '2024-01-05 22:31:55', '/permission/getPerm', 'GET', 1, NULL, 33);
INSERT INTO `system_operation_log` VALUES ('1743279197242015746', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2024-01-05 22:31:56', '2024-01-05 22:31:56', '/dashboard/dashboardInfo', 'GET', 1, NULL, 32);
INSERT INTO `system_operation_log` VALUES ('1743279202916909058', '1', '根据家庭ID楼层集合', '0:0:0:0:0:0:0:1', '2024-01-05 22:31:56', '2024-01-05 22:31:56', '/floor/floorList', 'GET', 1, NULL, 29);
INSERT INTO `system_operation_log` VALUES ('1743279203176955906', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2024-01-05 22:31:58', '2024-01-05 22:31:58', '/product/page', 'GET', 1, NULL, 94);
INSERT INTO `system_operation_log` VALUES ('1743279203306979330', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2024-01-05 22:32:00', '2024-01-05 22:32:00', '/product/list', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1743279239268941826', '1', '下拉', '0:0:0:0:0:0:0:1', '2024-01-05 22:32:00', '2024-01-05 22:32:00', '/family/list', 'GET', 1, NULL, 31);
INSERT INTO `system_operation_log` VALUES ('1743279244885114882', '1', '根据家庭ID楼层集合', '0:0:0:0:0:0:0:1', '2024-01-05 22:32:07', '2024-01-05 22:32:07', '/floor/floorList', 'GET', 1, NULL, 6);
INSERT INTO `system_operation_log` VALUES ('1743279245078052865', '1', '根据楼层id查询房间列表', '0:0:0:0:0:0:0:1', '2024-01-05 22:32:09', '2024-01-05 22:32:09', '/room/roomListByFloorId', 'GET', 1, NULL, 23);
INSERT INTO `system_operation_log` VALUES ('1743279275490951170', '1', '添加或修改设备', '0:0:0:0:0:0:0:1', '2024-01-05 22:32:22', '2024-01-05 22:32:22', '/device/addUpdate', 'POST', 1, NULL, 30);
INSERT INTO `system_operation_log` VALUES ('1743279281232953345', '1', '分页查询', '0:0:0:0:0:0:0:1', '2024-01-05 22:32:23', '2024-01-05 22:32:23', '/device/page', 'GET', 1, NULL, 52);
INSERT INTO `system_operation_log` VALUES ('1743279741998219266', '1', '下拉', '0:0:0:0:0:0:0:1', '2024-01-05 22:34:14', '2024-01-05 22:34:14', '/family/list', 'GET', 1, NULL, 8);
INSERT INTO `system_operation_log` VALUES ('1743279741998219267', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2024-01-05 22:34:14', '2024-01-05 22:34:14', '/product/list', 'GET', 1, NULL, 12);
INSERT INTO `system_operation_log` VALUES ('1743279741998219268', '1', '分页查询', '0:0:0:0:0:0:0:1', '2024-01-05 22:34:14', '2024-01-05 22:34:14', '/device/page', 'GET', 1, NULL, 37);
INSERT INTO `system_operation_log` VALUES ('1743279765784117249', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2024-01-05 22:34:19', '2024-01-05 22:34:19', '/permission/getPerm', 'GET', 1, NULL, 6);
INSERT INTO `system_operation_log` VALUES ('1743279784121614337', '1', '分页查询', '0:0:0:0:0:0:0:1', '2024-01-05 22:34:20', '2024-01-05 22:34:20', '/device/page', 'GET', 1, NULL, 34);
INSERT INTO `system_operation_log` VALUES ('1743279784251637761', '1', '下拉', '0:0:0:0:0:0:0:1', '2024-01-05 22:34:20', '2024-01-05 22:34:20', '/family/list', 'GET', 1, NULL, 10);
INSERT INTO `system_operation_log` VALUES ('1743279784251637762', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2024-01-05 22:34:20', '2024-01-05 22:34:20', '/product/list', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1743280048547315714', '1', '分页查询', '0:0:0:0:0:0:0:1', '2024-01-05 22:35:27', '2024-01-05 22:35:27', '/device/page', 'GET', 1, NULL, 30);
INSERT INTO `system_operation_log` VALUES ('1743280048740253697', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2024-01-05 22:35:27', '2024-01-05 22:35:27', '/product/list', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1743280048740253698', '1', '下拉', '0:0:0:0:0:0:0:1', '2024-01-05 22:35:27', '2024-01-05 22:35:27', '/family/list', 'GET', 1, NULL, 6);
INSERT INTO `system_operation_log` VALUES ('1743280095351554049', '1', '下拉', '0:0:0:0:0:0:0:1', '2024-01-05 22:35:38', '2024-01-05 22:35:38', '/family/list', 'GET', 1, NULL, 12);
INSERT INTO `system_operation_log` VALUES ('1743280095351554050', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2024-01-05 22:35:38', '2024-01-05 22:35:38', '/product/list', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1743280095406080002', '1', '分页查询', '0:0:0:0:0:0:0:1', '2024-01-05 22:35:38', '2024-01-05 22:35:38', '/device/page', 'GET', 1, NULL, 37);
INSERT INTO `system_operation_log` VALUES ('1743280310443851777', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2024-01-05 22:36:29', '2024-01-05 22:36:29', '/permission/getPerm', 'GET', 1, NULL, 6);
INSERT INTO `system_operation_log` VALUES ('1743280312608112642', '1', '分页查询', '0:0:0:0:0:0:0:1', '2024-01-05 22:36:30', '2024-01-05 22:36:30', '/device/page', 'GET', 1, NULL, 30);
INSERT INTO `system_operation_log` VALUES ('1743280312608112643', '1', '下拉', '0:0:0:0:0:0:0:1', '2024-01-05 22:36:30', '2024-01-05 22:36:30', '/family/list', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1743280312608112644', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2024-01-05 22:36:30', '2024-01-05 22:36:30', '/product/list', 'GET', 1, NULL, 7);
INSERT INTO `system_operation_log` VALUES ('1743280448910409729', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2024-01-05 22:37:02', '2024-01-05 22:37:02', '/permission/getPerm', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1743280451234054145', '1', '下拉', '0:0:0:0:0:0:0:1', '2024-01-05 22:37:03', '2024-01-05 22:37:03', '/family/list', 'GET', 1, NULL, 6);
INSERT INTO `system_operation_log` VALUES ('1743280451234054146', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2024-01-05 22:37:03', '2024-01-05 22:37:03', '/product/list', 'GET', 1, NULL, 11);
INSERT INTO `system_operation_log` VALUES ('1743280451234054147', '1', '分页查询', '0:0:0:0:0:0:0:1', '2024-01-05 22:37:03', '2024-01-05 22:37:03', '/device/page', 'GET', 1, NULL, 37);
INSERT INTO `system_operation_log` VALUES ('1743280631022895106', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2024-01-05 22:37:46', '2024-01-05 22:37:46', '/permission/getPerm', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1743280633027772417', '1', '分页查询', '0:0:0:0:0:0:0:1', '2024-01-05 22:37:46', '2024-01-05 22:37:46', '/device/page', 'GET', 1, NULL, 40);
INSERT INTO `system_operation_log` VALUES ('1743280633027772418', '1', '下拉', '0:0:0:0:0:0:0:1', '2024-01-05 22:37:46', '2024-01-05 22:37:46', '/family/list', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1743280633027772419', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2024-01-05 22:37:46', '2024-01-05 22:37:46', '/product/list', 'GET', 1, NULL, 6);
INSERT INTO `system_operation_log` VALUES ('1743281313125777409', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2024-01-05 22:40:28', '2024-01-05 22:40:28', '/permission/getPerm', 'GET', 1, NULL, 6);
INSERT INTO `system_operation_log` VALUES ('1743281315319398402', '1', '分页查询', '0:0:0:0:0:0:0:1', '2024-01-05 22:40:29', '2024-01-05 22:40:29', '/device/page', 'GET', 1, NULL, 32);
INSERT INTO `system_operation_log` VALUES ('1743281315562668034', '1', '下拉', '0:0:0:0:0:0:0:1', '2024-01-05 22:40:29', '2024-01-05 22:40:29', '/family/list', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1743281315562668035', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2024-01-05 22:40:29', '2024-01-05 22:40:29', '/product/list', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1743281654793781249', '1', '下拉', '0:0:0:0:0:0:0:1', '2024-01-05 22:41:50', '2024-01-05 22:41:50', '/family/list', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1743281655137714178', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2024-01-05 22:41:50', '2024-01-05 22:41:50', '/product/list', 'GET', 1, NULL, 34);
INSERT INTO `system_operation_log` VALUES ('1743281655137714179', '1', '分页查询', '0:0:0:0:0:0:0:1', '2024-01-05 22:41:50', '2024-01-05 22:41:50', '/device/page', 'GET', 1, NULL, 68);
INSERT INTO `system_operation_log` VALUES ('1743281783944790018', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2024-01-05 22:42:21', '2024-01-05 22:42:21', '/permission/getPerm', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1743281786796916737', '1', '下拉', '0:0:0:0:0:0:0:1', '2024-01-05 22:42:21', '2024-01-05 22:42:21', '/family/list', 'GET', 1, NULL, 7);
INSERT INTO `system_operation_log` VALUES ('1743281786796916738', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2024-01-05 22:42:21', '2024-01-05 22:42:21', '/product/list', 'GET', 1, NULL, 7);
INSERT INTO `system_operation_log` VALUES ('1743281786914357250', '1', '分页查询', '0:0:0:0:0:0:0:1', '2024-01-05 22:42:21', '2024-01-05 22:42:21', '/device/page', 'GET', 1, NULL, 140);
INSERT INTO `system_operation_log` VALUES ('1743282050316648449', '1', '下拉', '0:0:0:0:0:0:0:1', '2024-01-05 22:43:24', '2024-01-05 22:43:24', '/family/list', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1743282050316648450', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2024-01-05 22:43:24', '2024-01-05 22:43:24', '/product/list', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1743282050316648451', '1', '分页查询', '0:0:0:0:0:0:0:1', '2024-01-05 22:43:24', '2024-01-05 22:43:24', '/device/page', 'GET', 1, NULL, 40);
INSERT INTO `system_operation_log` VALUES ('1743282504446525442', '1', '查询调试所有设备', '0:0:0:0:0:0:0:1', '2024-01-05 22:45:12', '2024-01-05 22:45:12', '/device/debugDeviceList', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1743284223171678210', NULL, '登录', '0:0:0:0:0:0:0:1', '2024-01-05 22:52:02', '2024-01-05 22:52:02', '/user/login', 'POST', 1, NULL, 236);
INSERT INTO `system_operation_log` VALUES ('1743284223364616194', '1', '查询个人信息', '0:0:0:0:0:0:0:1', '2024-01-05 22:52:02', '2024-01-05 22:52:02', '/user/info', 'GET', 1, NULL, 6);
INSERT INTO `system_operation_log` VALUES ('1743284223578525698', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2024-01-05 22:52:02', '2024-01-05 22:52:02', '/permission/getPerm', 'GET', 1, NULL, 42);
INSERT INTO `system_operation_log` VALUES ('1743284226585841666', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2024-01-05 22:52:03', '2024-01-05 22:52:03', '/dashboard/dashboardInfo', 'GET', 1, NULL, 32);
INSERT INTO `system_operation_log` VALUES ('1743284265311850498', '1', '根据家庭ID楼层集合', '0:0:0:0:0:0:0:1', '2024-01-05 22:52:03', '2024-01-05 22:52:03', '/floor/floorList', 'GET', 1, NULL, 45);
INSERT INTO `system_operation_log` VALUES ('1743284265496399873', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2024-01-05 22:52:05', '2024-01-05 22:52:05', '/product/page', 'GET', 1, NULL, 117);
INSERT INTO `system_operation_log` VALUES ('1743284265622228993', '1', '查询调试所有设备', '0:0:0:0:0:0:0:1', '2024-01-05 22:52:07', '2024-01-05 22:52:07', '/device/debugDeviceList', 'GET', 1, NULL, 35);
INSERT INTO `system_operation_log` VALUES ('1743284391908528129', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2024-01-05 22:52:42', '2024-01-05 22:52:42', '/permission/getPerm', 'GET', 1, NULL, 12);
INSERT INTO `system_operation_log` VALUES ('1743284394760654850', '1', '查询调试所有设备', '0:0:0:0:0:0:0:1', '2024-01-05 22:52:43', '2024-01-05 22:52:43', '/device/debugDeviceList', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1743284858415796226', '1', '查询调试所有设备', '0:0:0:0:0:0:0:1', '2024-01-05 22:54:34', '2024-01-05 22:54:34', '/device/debugDeviceList', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1743285029795057665', '1', '查询调试所有设备', '0:0:0:0:0:0:0:1', '2024-01-05 22:55:14', '2024-01-05 22:55:14', '/device/debugDeviceList', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1743285079812132866', '1', '查询调试所有设备', '0:0:0:0:0:0:0:1', '2024-01-05 22:55:26', '2024-01-05 22:55:26', '/device/debugDeviceList', 'GET', 1, NULL, 6);
INSERT INTO `system_operation_log` VALUES ('1743285089257705474', NULL, '查询产品字段集合', '0:0:0:0:0:0:0:1', '2024-01-05 22:55:29', '2024-01-05 22:55:29', '/productField/fieldList', 'GET', 1, NULL, 16);
INSERT INTO `system_operation_log` VALUES ('1743285089383534593', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2024-01-05 22:55:29', '2024-01-05 22:55:29', '/deviceLog/page', 'GET', 1, NULL, 40);
INSERT INTO `system_operation_log` VALUES ('1743285113710497793', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2024-01-05 22:55:34', '2024-01-05 22:55:34', '/deviceLog/page', 'GET', 1, NULL, 16);
INSERT INTO `system_operation_log` VALUES ('1743285155636760578', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2024-01-05 22:55:44', '2024-01-05 22:55:44', '/deviceLog/page', 'GET', 1, NULL, 17);
INSERT INTO `system_operation_log` VALUES ('1743285197600772097', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2024-01-05 22:55:54', '2024-01-05 22:55:54', '/deviceLog/page', 'GET', 1, NULL, 16);
INSERT INTO `system_operation_log` VALUES ('1743285239543812097', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2024-01-05 22:56:04', '2024-01-05 22:56:04', '/deviceLog/page', 'GET', 1, NULL, 16);
INSERT INTO `system_operation_log` VALUES ('1743285281449103361', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2024-01-05 22:56:14', '2024-01-05 22:56:14', '/deviceLog/page', 'GET', 1, NULL, 17);
INSERT INTO `system_operation_log` VALUES ('1743285323434086402', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2024-01-05 22:56:24', '2024-01-05 22:56:24', '/deviceLog/page', 'GET', 1, NULL, 16);
INSERT INTO `system_operation_log` VALUES ('1743285365356154882', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2024-01-05 22:56:34', '2024-01-05 22:56:34', '/deviceLog/page', 'GET', 1, NULL, 12);
INSERT INTO `system_operation_log` VALUES ('1743285407336943618', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2024-01-05 22:56:44', '2024-01-05 22:56:44', '/deviceLog/page', 'GET', 1, NULL, 17);
INSERT INTO `system_operation_log` VALUES ('1743285449259012098', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2024-01-05 22:56:54', '2024-01-05 22:56:54', '/deviceLog/page', 'GET', 1, NULL, 15);
INSERT INTO `system_operation_log` VALUES ('1743285491176886274', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2024-01-05 22:57:04', '2024-01-05 22:57:04', '/deviceLog/page', 'GET', 1, NULL, 21);
INSERT INTO `system_operation_log` VALUES ('1743285533136703489', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2024-01-05 22:57:14', '2024-01-05 22:57:14', '/deviceLog/page', 'GET', 1, NULL, 15);
INSERT INTO `system_operation_log` VALUES ('1743285575000051713', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2024-01-05 22:57:24', '2024-01-05 22:57:24', '/deviceLog/page', 'GET', 1, NULL, 12);
INSERT INTO `system_operation_log` VALUES ('1743285617039560706', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2024-01-05 22:57:34', '2024-01-05 22:57:34', '/deviceLog/page', 'GET', 1, NULL, 14);
INSERT INTO `system_operation_log` VALUES ('1743285658978406401', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2024-01-05 22:57:44', '2024-01-05 22:57:44', '/deviceLog/page', 'GET', 1, NULL, 16);
INSERT INTO `system_operation_log` VALUES ('1743285700883697665', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2024-01-05 22:57:54', '2024-01-05 22:57:54', '/deviceLog/page', 'GET', 1, NULL, 12);
INSERT INTO `system_operation_log` VALUES ('1743285742856097794', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2024-01-05 22:58:04', '2024-01-05 22:58:04', '/deviceLog/page', 'GET', 1, NULL, 18);
INSERT INTO `system_operation_log` VALUES ('1743285756135264257', '1', '查询调试所有设备', '0:0:0:0:0:0:0:1', '2024-01-05 22:58:08', '2024-01-05 22:58:08', '/device/debugDeviceList', 'GET', 1, NULL, 12);
INSERT INTO `system_operation_log` VALUES ('1743285784773971970', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2024-01-05 22:58:14', '2024-01-05 22:58:14', '/deviceLog/page', 'GET', 1, NULL, 17);
INSERT INTO `system_operation_log` VALUES ('1743285790390145025', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2024-01-05 22:58:16', '2024-01-05 22:58:16', '/permission/getPerm', 'GET', 1, NULL, 6);
INSERT INTO `system_operation_log` VALUES ('1743285792327913474', '1', '查询调试所有设备', '0:0:0:0:0:0:0:1', '2024-01-05 22:58:16', '2024-01-05 22:58:16', '/device/debugDeviceList', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1743285804512366593', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2024-01-05 22:58:19', '2024-01-05 22:58:19', '/deviceLog/page', 'GET', 1, NULL, 15);
INSERT INTO `system_operation_log` VALUES ('1743285826834452482', NULL, '查询产品字段集合', '0:0:0:0:0:0:0:1', '2024-01-05 22:58:19', '2024-01-05 22:58:19', '/productField/fieldList', 'GET', 1, NULL, 6);
INSERT INTO `system_operation_log` VALUES ('1743285834317090818', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2024-01-05 22:58:26', '2024-01-05 22:58:26', '/deviceLog/page', 'GET', 1, NULL, 13);
INSERT INTO `system_operation_log` VALUES ('1743285876176244738', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2024-01-05 22:58:36', '2024-01-05 22:58:36', '/deviceLog/page', 'GET', 1, NULL, 14);
INSERT INTO `system_operation_log` VALUES ('1743285918211559426', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2024-01-05 22:58:46', '2024-01-05 22:58:46', '/deviceLog/page', 'GET', 1, NULL, 12);
INSERT INTO `system_operation_log` VALUES ('1743285960171376641', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2024-01-05 22:58:56', '2024-01-05 22:58:56', '/deviceLog/page', 'GET', 1, NULL, 14);
INSERT INTO `system_operation_log` VALUES ('1743286002097639426', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2024-01-05 22:59:06', '2024-01-05 22:59:06', '/deviceLog/page', 'GET', 1, NULL, 14);
INSERT INTO `system_operation_log` VALUES ('1743286044028096513', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2024-01-05 22:59:16', '2024-01-05 22:59:16', '/deviceLog/page', 'GET', 1, NULL, 13);
INSERT INTO `system_operation_log` VALUES ('1743286085945970690', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2024-01-05 22:59:26', '2024-01-05 22:59:26', '/deviceLog/page', 'GET', 1, NULL, 13);
INSERT INTO `system_operation_log` VALUES ('1743286128681734146', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2024-01-05 22:59:36', '2024-01-05 22:59:36', '/deviceLog/page', 'GET', 1, NULL, 11);
INSERT INTO `system_operation_log` VALUES ('1743286170607996929', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2024-01-05 22:59:46', '2024-01-05 22:59:46', '/deviceLog/page', 'GET', 1, NULL, 17);
INSERT INTO `system_operation_log` VALUES ('1743286212576202754', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2024-01-05 22:59:56', '2024-01-05 22:59:56', '/deviceLog/page', 'GET', 1, NULL, 11);
INSERT INTO `system_operation_log` VALUES ('1743286254460522498', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2024-01-05 23:00:06', '2024-01-05 23:00:06', '/deviceLog/page', 'GET', 1, NULL, 13);
INSERT INTO `system_operation_log` VALUES ('1743286296445505538', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2024-01-05 23:00:16', '2024-01-05 23:00:16', '/deviceLog/page', 'GET', 1, NULL, 11);
INSERT INTO `system_operation_log` VALUES ('1743286338396934145', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2024-01-05 23:00:26', '2024-01-05 23:00:26', '/deviceLog/page', 'GET', 1, NULL, 13);
INSERT INTO `system_operation_log` VALUES ('1743286455564816385', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2024-01-05 23:00:54', '2024-01-05 23:00:54', '/deviceLog/page', 'GET', 1, NULL, 26);
INSERT INTO `system_operation_log` VALUES ('1743286463496245249', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2024-01-05 23:00:56', '2024-01-05 23:00:56', '/deviceLog/page', 'GET', 1, NULL, 13);
INSERT INTO `system_operation_log` VALUES ('1743634168189923329', NULL, '登录', '0:0:0:0:0:0:0:1', '2024-01-06 22:02:36', '2024-01-06 22:02:36', '/user/login', 'POST', 1, NULL, 192);
INSERT INTO `system_operation_log` VALUES ('1743634168575799297', '1', '查询个人信息', '0:0:0:0:0:0:0:1', '2024-01-06 22:02:36', '2024-01-06 22:02:36', '/user/info', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1743634168701628418', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2024-01-06 22:02:36', '2024-01-06 22:02:36', '/permission/getPerm', 'GET', 1, NULL, 39);
INSERT INTO `system_operation_log` VALUES ('1743634170366767105', '1', '根据家庭ID楼层集合', '0:0:0:0:0:0:0:1', '2024-01-06 22:02:36', '2024-01-06 22:02:36', '/floor/floorList', 'GET', 1, NULL, 24);
INSERT INTO `system_operation_log` VALUES ('1743634210304929794', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2024-01-06 22:02:36', '2024-01-06 22:02:36', '/dashboard/dashboardInfo', 'GET', 1, NULL, 25);
INSERT INTO `system_operation_log` VALUES ('1743634210690805761', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2024-01-06 22:02:38', '2024-01-06 22:02:38', '/product/page', 'GET', 1, NULL, 94);
INSERT INTO `system_operation_log` VALUES ('1743634210690805762', '1', '查询调试所有设备', '0:0:0:0:0:0:0:1', '2024-01-06 22:02:40', '2024-01-06 22:02:40', '/device/debugDeviceList', 'GET', 1, NULL, 20);
INSERT INTO `system_operation_log` VALUES ('1743634212431441922', NULL, '查询产品字段集合', '0:0:0:0:0:0:0:1', '2024-01-06 22:02:41', '2024-01-06 22:02:41', '/productField/fieldList', 'GET', 1, NULL, 8);
INSERT INTO `system_operation_log` VALUES ('1743634252273135617', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2024-01-06 22:02:41', '2024-01-06 22:02:41', '/deviceLog/page', 'GET', 1, NULL, 21);
INSERT INTO `system_operation_log` VALUES ('1743634252721926146', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2024-01-06 22:02:50', '2024-01-06 22:02:50', '/deviceLog/page', 'GET', 1, NULL, 17);
INSERT INTO `system_operation_log` VALUES ('1743634273303375873', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2024-01-06 22:03:01', '2024-01-06 22:03:01', '/deviceLog/page', 'GET', 1, NULL, 12);
INSERT INTO `system_operation_log` VALUES ('1743634320959057921', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2024-01-06 22:03:12', '2024-01-06 22:03:12', '/deviceLog/page', 'GET', 1, NULL, 16);
INSERT INTO `system_operation_log` VALUES ('1743634354219888642', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2024-01-06 22:03:20', '2024-01-06 22:03:20', '/deviceLog/page', 'GET', 1, NULL, 15);
INSERT INTO `system_operation_log` VALUES ('1743634396116791298', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2024-01-06 22:03:30', '2024-01-06 22:03:30', '/deviceLog/page', 'GET', 1, NULL, 19);
INSERT INTO `system_operation_log` VALUES ('1743634441000038401', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2024-01-06 22:03:41', '2024-01-06 22:03:41', '/deviceLog/page', 'GET', 1, NULL, 9);
INSERT INTO `system_operation_log` VALUES ('1743634483018575873', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2024-01-06 22:03:51', '2024-01-06 22:03:51', '/deviceLog/page', 'GET', 1, NULL, 10);
INSERT INTO `system_operation_log` VALUES ('1743634524953227265', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2024-01-06 22:04:01', '2024-01-06 22:04:01', '/deviceLog/page', 'GET', 1, NULL, 11);
INSERT INTO `system_operation_log` VALUES ('1743634566929821698', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2024-01-06 22:04:11', '2024-01-06 22:04:11', '/deviceLog/page', 'GET', 1, NULL, 9);
INSERT INTO `system_operation_log` VALUES ('1743634615009128450', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2024-01-06 22:04:22', '2024-01-06 22:04:22', '/deviceLog/page', 'GET', 1, NULL, 17);
INSERT INTO `system_operation_log` VALUES ('1743634650815901698', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2024-01-06 22:04:31', '2024-01-06 22:04:31', '/deviceLog/page', 'GET', 1, NULL, 13);
INSERT INTO `system_operation_log` VALUES ('1743634758278164482', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2024-01-06 22:04:56', '2024-01-06 22:04:56', '/deviceLog/page', 'GET', 1, NULL, 12);
INSERT INTO `system_operation_log` VALUES ('1743634764166967297', '1', '查询调试所有设备', '0:0:0:0:0:0:0:1', '2024-01-06 22:04:58', '2024-01-06 22:04:58', '/device/debugDeviceList', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1743634785239150593', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2024-01-06 22:05:03', '2024-01-06 22:05:03', '/deviceLog/page', 'GET', 1, NULL, 18);
INSERT INTO `system_operation_log` VALUES ('1743634785239150594', NULL, '查询产品字段集合', '0:0:0:0:0:0:0:1', '2024-01-06 22:05:03', '2024-01-06 22:05:03', '/productField/fieldList', 'GET', 1, NULL, 9);
INSERT INTO `system_operation_log` VALUES ('1743634806231642113', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2024-01-06 22:05:08', '2024-01-06 22:05:08', '/deviceLog/page', 'GET', 1, NULL, 10);
INSERT INTO `system_operation_log` VALUES ('1743634852155076610', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2024-01-06 22:05:19', '2024-01-06 22:05:19', '/deviceLog/page', 'GET', 1, NULL, 10);
INSERT INTO `system_operation_log` VALUES ('1743634895004086273', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2024-01-06 22:05:29', '2024-01-06 22:05:29', '/deviceLog/page', 'GET', 1, NULL, 12);
INSERT INTO `system_operation_log` VALUES ('1743634936301203458', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2024-01-06 22:05:39', '2024-01-06 22:05:39', '/deviceLog/page', 'GET', 1, NULL, 10);
INSERT INTO `system_operation_log` VALUES ('1743634942236143618', '1', '查询调试所有设备', '0:0:0:0:0:0:0:1', '2024-01-06 22:05:40', '2024-01-06 22:05:40', '/device/debugDeviceList', 'GET', 1, NULL, 2);
INSERT INTO `system_operation_log` VALUES ('1743634951702687745', NULL, '查询产品字段集合', '0:0:0:0:0:0:0:1', '2024-01-06 22:05:42', '2024-01-06 22:05:42', '/productField/fieldList', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1743634951828516866', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2024-01-06 22:05:42', '2024-01-06 22:05:42', '/deviceLog/page', 'GET', 1, NULL, 53);
INSERT INTO `system_operation_log` VALUES ('1743635510371397634', '1', '查询调试所有设备', '0:0:0:0:0:0:0:1', '2024-01-06 22:07:56', '2024-01-06 22:07:56', '/device/debugDeviceList', 'GET', 1, NULL, 2);
INSERT INTO `system_operation_log` VALUES ('1743635518193774593', NULL, '查询产品字段集合', '0:0:0:0:0:0:0:1', '2024-01-06 22:07:57', '2024-01-06 22:07:57', '/productField/fieldList', 'GET', 1, NULL, 2);
INSERT INTO `system_operation_log` VALUES ('1743635518269272065', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2024-01-06 22:07:57', '2024-01-06 22:07:57', '/deviceLog/page', 'GET', 1, NULL, 14);
INSERT INTO `system_operation_log` VALUES ('1743635895202983938', '1', '查询调试所有设备', '0:0:0:0:0:0:0:1', '2024-01-06 22:09:27', '2024-01-06 22:09:27', '/device/debugDeviceList', 'GET', 1, NULL, 2);
INSERT INTO `system_operation_log` VALUES ('1743635909392314369', NULL, '查询产品字段集合', '0:0:0:0:0:0:0:1', '2024-01-06 22:09:31', '2024-01-06 22:09:31', '/productField/fieldList', 'GET', 1, NULL, 2);
INSERT INTO `system_operation_log` VALUES ('1743635909501366273', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2024-01-06 22:09:31', '2024-01-06 22:09:31', '/deviceLog/page', 'GET', 1, NULL, 14);
INSERT INTO `system_operation_log` VALUES ('1743636258463264769', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2024-01-06 22:10:54', '2024-01-06 22:10:54', '/product/list', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1743636258513596418', '1', '下拉', '0:0:0:0:0:0:0:1', '2024-01-06 22:10:54', '2024-01-06 22:10:54', '/family/list', 'GET', 1, NULL, 24);
INSERT INTO `system_operation_log` VALUES ('1743636258672979969', '1', '分页查询', '0:0:0:0:0:0:0:1', '2024-01-06 22:10:54', '2024-01-06 22:10:54', '/device/page', 'GET', 1, NULL, 47);
INSERT INTO `system_operation_log` VALUES ('1743636275232092161', '1', '根据家庭ID楼层集合', '0:0:0:0:0:0:0:1', '2024-01-06 22:10:58', '2024-01-06 22:10:58', '/floor/floorList', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1743636300473413634', '1', '根据楼层id查询房间列表', '0:0:0:0:0:0:0:1', '2024-01-06 22:10:59', '2024-01-06 22:10:59', '/room/roomListByFloorId', 'GET', 1, NULL, 24);
INSERT INTO `system_operation_log` VALUES ('1743636324032819201', '1', '添加或修改设备', '0:0:0:0:0:0:0:1', '2024-01-06 22:11:10', '2024-01-06 22:11:10', '/device/addUpdate', 'POST', 1, NULL, 31);
INSERT INTO `system_operation_log` VALUES ('1743636324355780610', '1', '分页查询', '0:0:0:0:0:0:0:1', '2024-01-06 22:11:10', '2024-01-06 22:11:10', '/device/page', 'GET', 1, NULL, 43);
INSERT INTO `system_operation_log` VALUES ('1743636419109302274', '1', '查询调试所有设备', '0:0:0:0:0:0:0:1', '2024-01-06 22:11:32', '2024-01-06 22:11:32', '/device/debugDeviceList', 'GET', 1, NULL, 2);
INSERT INTO `system_operation_log` VALUES ('1743636428882030594', NULL, '查询产品字段集合', '0:0:0:0:0:0:0:1', '2024-01-06 22:11:35', '2024-01-06 22:11:35', '/productField/fieldList', 'GET', 1, NULL, 2);
INSERT INTO `system_operation_log` VALUES ('1743636428882030595', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2024-01-06 22:11:35', '2024-01-06 22:11:35', '/deviceLog/page', 'GET', 1, NULL, 16);
INSERT INTO `system_operation_log` VALUES ('1743636935386181633', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2024-01-06 22:13:35', '2024-01-06 22:13:35', '/permission/getPerm', 'GET', 1, NULL, 6);
INSERT INTO `system_operation_log` VALUES ('1743636937785323522', '1', '查询调试所有设备', '0:0:0:0:0:0:0:1', '2024-01-06 22:13:36', '2024-01-06 22:13:36', '/device/debugDeviceList', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1743636953451048962', NULL, '查询产品字段集合', '0:0:0:0:0:0:0:1', '2024-01-06 22:13:40', '2024-01-06 22:13:40', '/productField/fieldList', 'GET', 1, NULL, 7);
INSERT INTO `system_operation_log` VALUES ('1743636953451048963', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2024-01-06 22:13:40', '2024-01-06 22:13:40', '/deviceLog/page', 'GET', 1, NULL, 20);
INSERT INTO `system_operation_log` VALUES ('1743636977358581762', NULL, '查询产品字段集合', '0:0:0:0:0:0:0:1', '2024-01-06 22:13:41', '2024-01-06 22:13:41', '/productField/fieldList', 'GET', 1, NULL, 2);
INSERT INTO `system_operation_log` VALUES ('1743636979883552770', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2024-01-06 22:13:41', '2024-01-06 22:13:41', '/deviceLog/page', 'GET', 1, NULL, 19);
INSERT INTO `system_operation_log` VALUES ('1743637107549777922', '1', '查询调试所有设备', '0:0:0:0:0:0:0:1', '2024-01-06 22:14:16', '2024-01-06 22:14:16', '/device/debugDeviceList', 'GET', 1, NULL, 9);
INSERT INTO `system_operation_log` VALUES ('1743637123706236930', NULL, '查询产品字段集合', '0:0:0:0:0:0:0:1', '2024-01-06 22:14:20', '2024-01-06 22:14:20', '/productField/fieldList', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1743637123706236931', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2024-01-06 22:14:20', '2024-01-06 22:14:20', '/deviceLog/page', 'GET', 1, NULL, 15);
INSERT INTO `system_operation_log` VALUES ('1743637368984940546', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2024-01-06 22:15:19', '2024-01-06 22:15:19', '/permission/getPerm', 'GET', 1, NULL, 9);
INSERT INTO `system_operation_log` VALUES ('1743637371044343809', '1', '查询调试所有设备', '0:0:0:0:0:0:0:1', '2024-01-06 22:15:19', '2024-01-06 22:15:19', '/device/debugDeviceList', 'GET', 1, NULL, 8);
INSERT INTO `system_operation_log` VALUES ('1743637380997427201', NULL, '查询产品字段集合', '0:0:0:0:0:0:0:1', '2024-01-06 22:15:22', '2024-01-06 22:15:22', '/productField/fieldList', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1743637381064536066', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2024-01-06 22:15:22', '2024-01-06 22:15:22', '/deviceLog/page', 'GET', 1, NULL, 16);
INSERT INTO `system_operation_log` VALUES ('1743637539101716481', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2024-01-06 22:15:59', '2024-01-06 22:15:59', '/permission/getPerm', 'GET', 1, NULL, 6);
INSERT INTO `system_operation_log` VALUES ('1743637541245005826', '1', '查询调试所有设备', '0:0:0:0:0:0:0:1', '2024-01-06 22:16:00', '2024-01-06 22:16:00', '/device/debugDeviceList', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1743637564821188610', NULL, '查询产品字段集合', '0:0:0:0:0:0:0:1', '2024-01-06 22:16:05', '2024-01-06 22:16:05', '/productField/fieldList', 'GET', 1, NULL, 2);
INSERT INTO `system_operation_log` VALUES ('1743637564858937345', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2024-01-06 22:16:05', '2024-01-06 22:16:05', '/deviceLog/page', 'GET', 1, NULL, 20);
INSERT INTO `system_operation_log` VALUES ('1743637730248732674', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2024-01-06 22:16:45', '2024-01-06 22:16:45', '/permission/getPerm', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1743637733025361922', '1', '查询调试所有设备', '0:0:0:0:0:0:0:1', '2024-01-06 22:16:45', '2024-01-06 22:16:45', '/device/debugDeviceList', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1743637748305211393', NULL, '查询产品字段集合', '0:0:0:0:0:0:0:1', '2024-01-06 22:16:49', '2024-01-06 22:16:49', '/productField/fieldList', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1743637748397486081', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2024-01-06 22:16:49', '2024-01-06 22:16:49', '/deviceLog/page', 'GET', 1, NULL, 15);
INSERT INTO `system_operation_log` VALUES ('1743637845856333825', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2024-01-06 22:17:12', '2024-01-06 22:17:12', '/permission/getPerm', 'GET', 1, NULL, 13);
INSERT INTO `system_operation_log` VALUES ('1743637847685050370', '1', '查询调试所有设备', '0:0:0:0:0:0:0:1', '2024-01-06 22:17:13', '2024-01-06 22:17:13', '/device/debugDeviceList', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1743637858342776834', NULL, '查询产品字段集合', '0:0:0:0:0:0:0:1', '2024-01-06 22:17:15', '2024-01-06 22:17:15', '/productField/fieldList', 'GET', 1, NULL, 2);
INSERT INTO `system_operation_log` VALUES ('1743637858393108481', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2024-01-06 22:17:15', '2024-01-06 22:17:15', '/deviceLog/page', 'GET', 1, NULL, 15);
INSERT INTO `system_operation_log` VALUES ('1743638245426704385', '1', '查询调试所有设备', '0:0:0:0:0:0:0:1', '2024-01-06 22:18:48', '2024-01-06 22:18:48', '/device/debugDeviceList', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1743638251923681281', NULL, '查询产品字段集合', '0:0:0:0:0:0:0:1', '2024-01-06 22:18:49', '2024-01-06 22:18:49', '/productField/fieldList', 'GET', 1, NULL, 2);
INSERT INTO `system_operation_log` VALUES ('1743638252024344577', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2024-01-06 22:18:49', '2024-01-06 22:18:49', '/deviceLog/page', 'GET', 1, NULL, 17);
INSERT INTO `system_operation_log` VALUES ('1743638706623983618', '1', '查询调试所有设备', '0:0:0:0:0:0:0:1', '2024-01-06 22:20:38', '2024-01-06 22:20:38', '/device/debugDeviceList', 'GET', 1, NULL, 2);
INSERT INTO `system_operation_log` VALUES ('1743638867056111617', NULL, '查询产品字段集合', '0:0:0:0:0:0:0:1', '2024-01-06 22:21:16', '2024-01-06 22:21:16', '/productField/fieldList', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1743638867114831873', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2024-01-06 22:21:16', '2024-01-06 22:21:16', '/deviceLog/page', 'GET', 1, NULL, 15);
INSERT INTO `system_operation_log` VALUES ('1743638967614550017', '1', '下发debug命令', '0:0:0:0:0:0:0:1', '2024-01-06 22:21:40', '2024-01-06 22:21:40', '/device/sendDebug', 'POST', 1, NULL, 20577);
INSERT INTO `system_operation_log` VALUES ('1743640272403816449', NULL, '登录', '0:0:0:0:0:0:0:1', '2024-01-06 22:26:51', '2024-01-06 22:26:51', '/user/login', 'POST', 1, NULL, 182);
INSERT INTO `system_operation_log` VALUES ('1743640272525451266', '1', '查询个人信息', '0:0:0:0:0:0:0:1', '2024-01-06 22:26:51', '2024-01-06 22:26:51', '/user/info', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1743640272588365826', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2024-01-06 22:26:51', '2024-01-06 22:26:51', '/permission/getPerm', 'GET', 1, NULL, 35);
INSERT INTO `system_operation_log` VALUES ('1743640275293691905', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2024-01-06 22:26:52', '2024-01-06 22:26:52', '/dashboard/dashboardInfo', 'GET', 1, NULL, 23);
INSERT INTO `system_operation_log` VALUES ('1743640314493657090', '1', '根据家庭ID楼层集合', '0:0:0:0:0:0:0:1', '2024-01-06 22:26:52', '2024-01-06 22:26:52', '/floor/floorList', 'GET', 1, NULL, 28);
INSERT INTO `system_operation_log` VALUES ('1743640314556571650', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2024-01-06 22:26:53', '2024-01-06 22:26:53', '/product/page', 'GET', 1, NULL, 115);
INSERT INTO `system_operation_log` VALUES ('1743640314619486209', '1', '查询调试所有设备', '0:0:0:0:0:0:0:1', '2024-01-06 22:26:55', '2024-01-06 22:26:55', '/device/debugDeviceList', 'GET', 1, NULL, 28);
INSERT INTO `system_operation_log` VALUES ('1743640317333200897', NULL, '查询产品字段集合', '0:0:0:0:0:0:0:1', '2024-01-06 22:26:56', '2024-01-06 22:26:56', '/productField/fieldList', 'GET', 1, NULL, 10);
INSERT INTO `system_operation_log` VALUES ('1743640356474445825', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2024-01-06 22:26:56', '2024-01-06 22:26:56', '/deviceLog/page', 'GET', 1, NULL, 27);
INSERT INTO `system_operation_log` VALUES ('1743640356537360385', '1', '下发debug命令', '0:0:0:0:0:0:0:1', '2024-01-06 22:27:05', '2024-01-06 22:27:05', '/device/sendDebug', 'POST', 1, NULL, 2745);
INSERT INTO `system_operation_log` VALUES ('1743640362732347393', '1', '下发debug命令', '0:0:0:0:0:0:0:1', '2024-01-06 22:27:12', '2024-01-06 22:27:12', '/device/sendDebug', 'POST', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1743640674633375746', '1', '下发debug命令', '0:0:0:0:0:0:0:1', '2024-01-06 22:28:27', '2024-01-06 22:28:27', '/device/sendDebug', 'POST', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1743640741603827713', '1', '下发debug命令', '0:0:0:0:0:0:0:1', '2024-01-06 22:28:43', '2024-01-06 22:28:43', '/device/sendDebug', 'POST', 1, NULL, 7);
INSERT INTO `system_operation_log` VALUES ('1743640788550672386', '1', '下发debug命令', '0:0:0:0:0:0:0:1', '2024-01-06 22:28:54', '2024-01-06 22:28:54', '/device/sendDebug', 'POST', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1744007789408256002', NULL, '登录', '0:0:0:0:0:0:0:1', '2024-01-07 22:47:14', '2024-01-07 22:47:14', '/user/login', 'POST', 1, NULL, 739);
INSERT INTO `system_operation_log` VALUES ('1744007789655719937', '1', '查询个人信息', '0:0:0:0:0:0:0:1', '2024-01-07 22:47:14', '2024-01-07 22:47:14', '/user/info', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1744007790041595905', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2024-01-07 22:47:14', '2024-01-07 22:47:14', '/permission/getPerm', 'GET', 1, NULL, 101);
INSERT INTO `system_operation_log` VALUES ('1744007791551545346', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2024-01-07 22:47:14', '2024-01-07 22:47:14', '/dashboard/dashboardInfo', 'GET', 1, NULL, 61);
INSERT INTO `system_operation_log` VALUES ('1744007831443570690', '1', '根据家庭ID楼层集合', '0:0:0:0:0:0:0:1', '2024-01-07 22:47:14', '2024-01-07 22:47:14', '/floor/floorList', 'GET', 1, NULL, 79);
INSERT INTO `system_operation_log` VALUES ('1744007831703617538', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2024-01-07 22:47:22', '2024-01-07 22:47:22', '/permission/getPerm', 'GET', 1, NULL, 20);
INSERT INTO `system_operation_log` VALUES ('1744007832089493506', '1', '根据家庭ID楼层集合', '0:0:0:0:0:0:0:1', '2024-01-07 22:47:22', '2024-01-07 22:47:22', '/floor/floorList', 'GET', 1, NULL, 8);
INSERT INTO `system_operation_log` VALUES ('1744007833574277121', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2024-01-07 22:47:22', '2024-01-07 22:47:22', '/dashboard/dashboardInfo', 'GET', 1, NULL, 31);
INSERT INTO `system_operation_log` VALUES ('1744008346348912641', NULL, '登录', '0:0:0:0:0:0:0:1', '2024-01-07 22:49:27', '2024-01-07 22:49:27', '/user/login', 'POST', 1, NULL, 1799);
INSERT INTO `system_operation_log` VALUES ('1744008346604765185', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2024-01-07 22:49:27', '2024-01-07 22:49:27', '/permission/getPerm', 'GET', 1, NULL, 15);
INSERT INTO `system_operation_log` VALUES ('1744008346604765186', '1', '查询个人信息', '0:0:0:0:0:0:0:1', '2024-01-07 22:49:27', '2024-01-07 22:49:27', '/user/info', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1744008348114714626', '1', '根据家庭ID楼层集合', '0:0:0:0:0:0:0:1', '2024-01-07 22:49:27', '2024-01-07 22:49:27', '/floor/floorList', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1744008388266786818', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2024-01-07 22:49:27', '2024-01-07 22:49:27', '/dashboard/dashboardInfo', 'GET', 1, NULL, 21);
INSERT INTO `system_operation_log` VALUES ('1744008494202322946', NULL, '登录', '0:0:0:0:0:0:0:1', '2024-01-07 22:50:02', '2024-01-07 22:50:02', '/user/login', 'POST', 1, NULL, 1800);
INSERT INTO `system_operation_log` VALUES ('1744008494483341313', '1', '查询个人信息', '0:0:0:0:0:0:0:1', '2024-01-07 22:50:02', '2024-01-07 22:50:02', '/user/info', 'GET', 1, NULL, 6);
INSERT INTO `system_operation_log` VALUES ('1744008494483341314', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2024-01-07 22:50:02', '2024-01-07 22:50:02', '/permission/getPerm', 'GET', 1, NULL, 10);
INSERT INTO `system_operation_log` VALUES ('1744008496618242049', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2024-01-07 22:50:02', '2024-01-07 22:50:02', '/dashboard/dashboardInfo', 'GET', 1, NULL, 301);
INSERT INTO `system_operation_log` VALUES ('1744008536069865473', '1', '根据家庭ID楼层集合', '0:0:0:0:0:0:0:1', '2024-01-07 22:50:02', '2024-01-07 22:50:02', '/floor/floorList', 'GET', 1, NULL, 307);
INSERT INTO `system_operation_log` VALUES ('1744008546668871682', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2024-01-07 22:50:14', '2024-01-07 22:50:14', '/permission/getPerm', 'GET', 1, NULL, 8);
INSERT INTO `system_operation_log` VALUES ('1744008552763195393', '1', '根据家庭ID楼层集合', '0:0:0:0:0:0:0:1', '2024-01-07 22:50:16', '2024-01-07 22:50:16', '/floor/floorList', 'GET', 1, NULL, 11);
INSERT INTO `system_operation_log` VALUES ('1744008552763195394', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2024-01-07 22:50:16', '2024-01-07 22:50:16', '/dashboard/dashboardInfo', 'GET', 1, NULL, 17);
INSERT INTO `system_operation_log` VALUES ('1744008597931655170', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2024-01-07 22:50:27', '2024-01-07 22:50:27', '/product/page', 'GET', 1, NULL, 1026);
INSERT INTO `system_operation_log` VALUES ('1744008635651031041', '1', '分页', '0:0:0:0:0:0:0:1', '2024-01-07 22:50:36', '2024-01-07 22:50:36', '/family/page', 'GET', 1, NULL, 133);
INSERT INTO `system_operation_log` VALUES ('1744008644400349186', '1', '下拉', '0:0:0:0:0:0:0:1', '2024-01-07 22:50:38', '2024-01-07 22:50:38', '/family/list', 'GET', 1, NULL, 9);
INSERT INTO `system_operation_log` VALUES ('1744008645142740994', '1', '后台楼层分页查询', '0:0:0:0:0:0:0:1', '2024-01-07 22:50:38', '2024-01-07 22:50:38', '/floor/pageBackend', 'GET', 1, NULL, 199);
INSERT INTO `system_operation_log` VALUES ('1744008649114746882', '1', '下拉', '0:0:0:0:0:0:0:1', '2024-01-07 22:50:39', '2024-01-07 22:50:39', '/family/list', 'GET', 1, NULL, 12);
INSERT INTO `system_operation_log` VALUES ('1744008677577293826', '1', '后台分页查询', '0:0:0:0:0:0:0:1', '2024-01-07 22:50:39', '2024-01-07 22:50:39', '/room/pageBackend', 'GET', 1, NULL, 172);
INSERT INTO `system_operation_log` VALUES ('1744008686385332225', '1', '根据家庭ID楼层集合', '0:0:0:0:0:0:0:1', '2024-01-07 22:50:40', '2024-01-07 22:50:40', '/floor/floorList', 'GET', 1, NULL, 10);
INSERT INTO `system_operation_log` VALUES ('1744008687161278466', '1', '角色下拉列表', '0:0:0:0:0:0:0:1', '2024-01-07 22:50:40', '2024-01-07 22:50:40', '/permission/roleList', 'GET', 1, NULL, 11);
INSERT INTO `system_operation_log` VALUES ('1744008690931957762', '1', '分页查询', '0:0:0:0:0:0:0:1', '2024-01-07 22:50:40', '2024-01-07 22:50:40', '/user/page', 'GET', 1, NULL, 58);
INSERT INTO `system_operation_log` VALUES ('1744008719683911681', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2024-01-07 22:50:42', '2024-01-07 22:50:42', '/product/page', 'GET', 1, NULL, 36);
INSERT INTO `system_operation_log` VALUES ('1744008728336760833', '1', '查询调试所有设备', '0:0:0:0:0:0:0:1', '2024-01-07 22:50:48', '2024-01-07 22:50:48', '/device/debugDeviceList', 'GET', 1, NULL, 11);
INSERT INTO `system_operation_log` VALUES ('1744008729297256450', NULL, '查询产品字段集合', '0:0:0:0:0:0:0:1', '2024-01-07 22:50:51', '2024-01-07 22:50:51', '/productField/fieldList', 'GET', 1, NULL, 21);
INSERT INTO `system_operation_log` VALUES ('1744008733109878785', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2024-01-07 22:50:51', '2024-01-07 22:50:51', '/deviceLog/page', 'GET', 1, NULL, 130);
INSERT INTO `system_operation_log` VALUES ('1746154369422737410', NULL, '登录', '0:0:0:0:0:0:0:1', '2024-01-13 20:56:58', '2024-01-13 20:56:58', '/user/login', 'POST', 1, NULL, 187);
INSERT INTO `system_operation_log` VALUES ('1746154370152546305', '1', '查询个人信息', '0:0:0:0:0:0:0:1', '2024-01-13 20:56:58', '2024-01-13 20:56:58', '/user/info', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1746154370282569729', '1', '获取个人权限', '0:0:0:0:0:0:0:1', '2024-01-13 20:56:59', '2024-01-13 20:56:59', '/permission/getPerm', 'GET', 1, NULL, 31);
INSERT INTO `system_operation_log` VALUES ('1746154372992090113', NULL, '查询dashboard信息', '0:0:0:0:0:0:0:1', '2024-01-13 20:56:59', '2024-01-13 20:56:59', '/dashboard/dashboardInfo', 'GET', 1, NULL, 24);
INSERT INTO `system_operation_log` VALUES ('1746154411420303361', '1', '根据家庭ID楼层集合', '0:0:0:0:0:0:0:1', '2024-01-13 20:56:59', '2024-01-13 20:56:59', '/floor/floorList', 'GET', 1, NULL, 24);
INSERT INTO `system_operation_log` VALUES ('1746154412196249602', '1', '分页', '0:0:0:0:0:0:0:1', '2024-01-13 20:57:01', '2024-01-13 20:57:01', '/family/page', 'GET', 1, NULL, 132);
INSERT INTO `system_operation_log` VALUES ('1746154412196249603', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2024-01-13 20:57:05', '2024-01-13 20:57:05', '/product/page', 'GET', 1, NULL, 38);
INSERT INTO `system_operation_log` VALUES ('1746154417237803010', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2024-01-13 20:57:10', '2024-01-13 20:57:10', '/product/list', 'GET', 1, NULL, 6);
INSERT INTO `system_operation_log` VALUES ('1746154453354954753', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2024-01-13 20:57:10', '2024-01-13 20:57:10', '/frameware/page', 'GET', 1, NULL, 42);
INSERT INTO `system_operation_log` VALUES ('1746154454198009857', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2024-01-13 20:57:11', '2024-01-13 20:57:11', '/product/list', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1746154454198009858', '1', '下拉', '0:0:0:0:0:0:0:1', '2024-01-13 20:57:11', '2024-01-13 20:57:11', '/family/list', 'GET', 1, NULL, 12);
INSERT INTO `system_operation_log` VALUES ('1746154459310866433', '1', '分页查询', '0:0:0:0:0:0:0:1', '2024-01-13 20:57:11', '2024-01-13 20:57:11', '/device/page', 'GET', 1, NULL, 53);
INSERT INTO `system_operation_log` VALUES ('1746154495419629569', '1', '查询调试所有设备', '0:0:0:0:0:0:0:1', '2024-01-13 20:57:12', '2024-01-13 20:57:12', '/device/debugDeviceList', 'GET', 1, NULL, 2);
INSERT INTO `system_operation_log` VALUES ('1746154661925109762', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2024-01-13 20:58:08', '2024-01-13 20:58:08', '/product/list', 'GET', 1, NULL, 5);
INSERT INTO `system_operation_log` VALUES ('1746154662025773057', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2024-01-13 20:58:08', '2024-01-13 20:58:08', '/frameware/page', 'GET', 1, NULL, 15);
INSERT INTO `system_operation_log` VALUES ('1746154667792941058', '1', '下拉', '0:0:0:0:0:0:0:1', '2024-01-13 20:58:09', '2024-01-13 20:58:09', '/family/list', 'GET', 1, NULL, 6);
INSERT INTO `system_operation_log` VALUES ('1746154667922964482', NULL, '查询产品下拉', '0:0:0:0:0:0:0:1', '2024-01-13 20:58:09', '2024-01-13 20:58:09', '/product/list', 'GET', 1, NULL, 4);
INSERT INTO `system_operation_log` VALUES ('1746154704002367490', '1', '分页查询', '0:0:0:0:0:0:0:1', '2024-01-13 20:58:09', '2024-01-13 20:58:09', '/device/page', 'GET', 1, NULL, 28);
INSERT INTO `system_operation_log` VALUES ('1746154704002367491', '1', '查询调试所有设备', '0:0:0:0:0:0:0:1', '2024-01-13 20:58:11', '2024-01-13 20:58:11', '/device/debugDeviceList', 'GET', 1, NULL, 3);
INSERT INTO `system_operation_log` VALUES ('1746154716266512386', '1', '权限树', '0:0:0:0:0:0:0:1', '2024-01-13 20:58:21', '2024-01-13 20:58:21', '/permission/allPermTree', 'GET', 1, NULL, 16);
INSERT INTO `system_operation_log` VALUES ('1746154716396535810', '1', '角色分页查询', '0:0:0:0:0:0:0:1', '2024-01-13 20:58:21', '2024-01-13 20:58:21', '/permission/rolePage', 'GET', 1, NULL, 39);
INSERT INTO `system_operation_log` VALUES ('1746154745974767618', '1', '家庭设备树', '0:0:0:0:0:0:0:1', '2024-01-13 20:58:21', '2024-01-13 20:58:21', '/device/familyDeviceTree', 'GET', 1, NULL, 109);
INSERT INTO `system_operation_log` VALUES ('1746154748675899393', NULL, '查询系统基础信息', '0:0:0:0:0:0:0:1', '2024-01-13 20:58:29', '2024-01-13 20:58:29', '/systemInfo/basicInfo', 'GET', 1, NULL, 2);
INSERT INTO `system_operation_log` VALUES ('1746154798831386625', '1', '分页', '0:0:0:0:0:0:0:1', '2024-01-13 20:58:41', '2024-01-13 20:58:41', '/family/page', 'GET', 1, NULL, 19);
INSERT INTO `system_operation_log` VALUES ('1746158400404733953', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2024-01-13 21:12:59', '2024-01-13 21:12:59', '/product/page', 'GET', 1, NULL, 31);
INSERT INTO `system_operation_log` VALUES ('1746158442918199298', NULL, '分页查询', '0:0:0:0:0:0:0:1', '2024-01-13 21:13:10', '2024-01-13 21:13:10', '/product/page', 'GET', 1, NULL, 24);
INSERT INTO `system_operation_log` VALUES ('1746158445116014593', '1', '分页', '0:0:0:0:0:0:0:1', '2024-01-13 21:13:10', '2024-01-13 21:13:10', '/family/page', 'GET', 1, NULL, 24);

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
  `gender` tinyint(1) NULL DEFAULT NULL COMMENT '性别1男2女',
  `height` int(11) NULL DEFAULT NULL COMMENT '身高',
  `weight` int(11) NULL DEFAULT NULL COMMENT '体重',
  `age` int(11) NULL DEFAULT NULL COMMENT '年龄',
  `selected_floor_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '选择的楼层ID',
  `selected_room_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '选择的房间ID',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `super_admin` tinyint(1) NOT NULL COMMENT '是否是超级管理员',
  `enable` tinyint(1) NOT NULL COMMENT '是否启用',
  `select_lang` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '选中的语言',
  `display_mode` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `selected_family_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '选中的家庭',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of system_user
-- ----------------------------
INSERT INTO `system_user` VALUES ('1', NULL, 'BLab', NULL, '$2a$10$WQpAjiS1yrbtAAtIX7wageoOcdCF2Fqqsf2E6nwlQQ69r9HIIj.RO', 'abc@abc.com', NULL, NULL, NULL, NULL, NULL, NULL, '2023-08-11 10:39:42', '2023-08-11 10:39:42', 1, 1, 'zh-CN', NULL, NULL);
INSERT INTO `system_user` VALUES ('2', NULL, 'a', NULL, '1', '1', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-13 14:48:53', '2023-09-13 14:48:56', 0, 1, NULL, NULL, NULL);

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
