/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 80033
 Source Host           : localhost:3306
 Source Schema         : rms

 Target Server Type    : MySQL
 Target Server Version : 80033
 File Encoding         : 65001

 Date: 30/05/2024 22:52:44
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for sys_apply
-- ----------------------------
DROP TABLE IF EXISTS `sys_apply`;
CREATE TABLE `sys_apply`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '标题',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '内容',
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '申请需要提交的房产证链接',
  `create_time` datetime NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `status` int NOT NULL DEFAULT 0 COMMENT '0待审核     1审核通过      2审核不通过',
  `user_id` int NULL DEFAULT NULL COMMENT '申请人id',
  `admin_id` int NULL DEFAULT NULL COMMENT '审核人id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_apply
-- ----------------------------
INSERT INTO `sys_apply` VALUES (2, '我要成为房东', '<p><img src=\"https://glut-1.oss-cn-shenzhen.aliyuncs.com/rms/640 (9).gif\" alt=\"\" data-href=\"\" style=\"\"/></p>', NULL, '2024-05-28 13:51:48', '2024-05-28 17:17:03', 1, 24, NULL);

-- ----------------------------
-- Table structure for sys_carousel
-- ----------------------------
DROP TABLE IF EXISTS `sys_carousel`;
CREATE TABLE `sys_carousel`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '描述',
  `create_time` datetime NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `status` int NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_carousel
-- ----------------------------
INSERT INTO `sys_carousel` VALUES (7, 'https://glut-1.oss-cn-shenzhen.aliyuncs.com/rms/97a1e84cc33c15f361804f07e0795586.jpg', NULL, '2024-05-14 23:05:17', NULL, 1);
INSERT INTO `sys_carousel` VALUES (8, 'https://glut-1.oss-cn-shenzhen.aliyuncs.com/rms/640 (2).jpg', NULL, '2024-05-14 23:16:44', NULL, 1);
INSERT INTO `sys_carousel` VALUES (9, 'https://glut-1.oss-cn-shenzhen.aliyuncs.com/rms/22222.png', NULL, '2024-05-14 23:17:13', '2024-05-14 23:17:50', 1);
INSERT INTO `sys_carousel` VALUES (10, 'https://glut-1.oss-cn-shenzhen.aliyuncs.com/rms/6401.jpg', NULL, '2024-05-14 23:18:09', NULL, 1);
INSERT INTO `sys_carousel` VALUES (12, 'https://glut-1.oss-cn-shenzhen.aliyuncs.com/rms/3feed8d1747545428ce4da418ff9fa41_IMG_20230120_160246.jpg', NULL, '2024-05-26 20:05:25', NULL, 1);

-- ----------------------------
-- Table structure for sys_comment
-- ----------------------------
DROP TABLE IF EXISTS `sys_comment`;
CREATE TABLE `sys_comment`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '评论ID',
  `parent_id` int NULL DEFAULT NULL COMMENT '父节点',
  `house_id` bigint NULL DEFAULT NULL COMMENT '房屋ID',
  `user_id` bigint NULL DEFAULT NULL COMMENT '用户ID',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '地址',
  `content` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '评论内容',
  `likes` int NULL DEFAULT 0 COMMENT '点赞数',
  `content_img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '图片',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `uid`(`user_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 128 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_comment
-- ----------------------------
INSERT INTO `sys_comment` VALUES (102, NULL, 1, 26, '来自江苏', '这是测试111', 0, '', '2024-05-12 16:40:19', NULL);
INSERT INTO `sys_comment` VALUES (103, NULL, 1, 26, '来自江苏', '测试222', 0, '', '2024-05-12 16:40:21', NULL);
INSERT INTO `sys_comment` VALUES (104, NULL, 1, 26, '来自江苏', '333', 0, '', '2024-05-12 16:40:23', NULL);
INSERT INTO `sys_comment` VALUES (105, 102, 1, 26, '来自江苏', '回复测试111', 0, '', '2024-05-12 16:54:46', NULL);
INSERT INTO `sys_comment` VALUES (106, 102, 1, 26, '来自江苏', '回复测试111', 0, '', '2024-05-12 16:55:45', NULL);
INSERT INTO `sys_comment` VALUES (107, NULL, 1, 25, '来自桂林理工', '在测试一下[狗头]', 0, '', '2024-05-13 00:00:10', NULL);
INSERT INTO `sys_comment` VALUES (108, NULL, 1, 25, '来自桂林理工', '在测试！！！[tv_doge]', 0, '', '2024-05-13 00:01:24', NULL);
INSERT INTO `sys_comment` VALUES (109, 108, 1, 25, '来自桂林理工', '[tv_doge]测试回复', 0, '', '2024-05-13 10:31:05', NULL);
INSERT INTO `sys_comment` VALUES (110, 107, 1, 25, '来自桂林理工', '[哦呼][哦呼][哦呼][哦呼][哦呼][哦呼][哦呼][哦呼]回复你一下', 0, '', '2024-05-13 10:31:20', NULL);
INSERT INTO `sys_comment` VALUES (111, NULL, 1, 26, '来自桂林理工', '我是0503，呼叫，我是0503[狗头][狗头][狗头]', 0, '', '2024-05-13 10:44:11', NULL);
INSERT INTO `sys_comment` VALUES (112, 111, 1, 16, '来自桂林理工', '我看到你的消息了，我是梅兰竹菊[tv_斜眼笑]', 0, '', '2024-05-13 11:12:21', NULL);
INSERT INTO `sys_comment` VALUES (113, NULL, 18, 16, '来自桂林理工', '沙发[偷笑][tv_大佬]', 0, '', '2024-05-13 12:16:22', NULL);
INSERT INTO `sys_comment` VALUES (114, NULL, 89, 16, '来自桂林理工', '这个房屋怎么样？[狗头]', 0, '', '2024-05-15 22:45:23', NULL);
INSERT INTO `sys_comment` VALUES (115, NULL, 16, 16, '来自桂林理工', 'test', 0, '', '2024-05-19 21:08:22', NULL);
INSERT INTO `sys_comment` VALUES (116, NULL, 16, 16, '来自桂林理工', '[星星眼][星星眼][星星眼][星星眼][星星眼][星星眼][星星眼][星星眼][星星眼][星星眼]', 0, '', '2024-05-19 21:08:45', NULL);
INSERT INTO `sys_comment` VALUES (117, NULL, 16, 16, '来自桂林理工', '[吃瓜][吃瓜][吃瓜][吃瓜][吃瓜][tv_斜眼笑][tv_斜眼笑][tv_斜眼笑]', 0, '', '2024-05-19 21:08:55', NULL);
INSERT INTO `sys_comment` VALUES (122, 121, 13, 16, '来自桂林理工', '?[脸红]', 0, '', '2024-05-19 21:22:21', NULL);
INSERT INTO `sys_comment` VALUES (123, NULL, 96, 24, '来自桂林理工', '和v计划<div><br></div>', 0, '', '2024-05-26 20:45:33', NULL);
INSERT INTO `sys_comment` VALUES (124, NULL, 5, 24, '来自桂林理工', '哈哈哈哈[乖][滑稽]', 0, '', '2024-05-27 17:27:01', NULL);
INSERT INTO `sys_comment` VALUES (125, NULL, 5, 24, '来自桂林理工', '回复 <span style=\"color: var(--u-color-success-dark-2);\">@租户-0501:</span> [星星眼][星星眼][星星眼]', 0, '', '2024-05-27 17:27:09', NULL);
INSERT INTO `sys_comment` VALUES (126, NULL, 12, 24, '来自桂林理工', '嘿嘿嘿[星星眼]', 0, '', '2024-05-29 10:00:31', NULL);
INSERT INTO `sys_comment` VALUES (127, NULL, 12, 24, '来自桂林理工', '666', 0, '', '2024-05-29 12:27:41', NULL);

-- ----------------------------
-- Table structure for sys_favor
-- ----------------------------
DROP TABLE IF EXISTS `sys_favor`;
CREATE TABLE `sys_favor`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '这个字段是用于模糊查询的',
  `house_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '这个字段是用于模糊查询的',
  `house_id` bigint NULL DEFAULT NULL,
  `user_id` bigint NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 110 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_favor
-- ----------------------------
INSERT INTO `sys_favor` VALUES (21, NULL, '学区房|三室一厅', 11, 16, NULL, NULL);
INSERT INTO `sys_favor` VALUES (22, NULL, '学区房|两室一厅|近西山小学', 14, 16, NULL, NULL);
INSERT INTO `sys_favor` VALUES (23, NULL, '学区房|两室一厅一卫一阳台', 13, 51, NULL, NULL);
INSERT INTO `sys_favor` VALUES (24, NULL, '学区房|两室一厅一卫生间', 12, 51, NULL, NULL);
INSERT INTO `sys_favor` VALUES (25, NULL, '学区房|靠近桂林理工大学', 18, 51, NULL, NULL);
INSERT INTO `sys_favor` VALUES (26, NULL, '学区房|两室一厅一卫生间|近平南镇镇中', 16, 51, NULL, NULL);
INSERT INTO `sys_favor` VALUES (27, NULL, '学区房|三室一厅', 11, 51, NULL, NULL);
INSERT INTO `sys_favor` VALUES (28, NULL, '学区房|两室一厅|近西山小学', 14, 51, NULL, NULL);
INSERT INTO `sys_favor` VALUES (29, NULL, '学区房|两室一厅一卫生间|近平南镇四中', 15, 51, NULL, NULL);
INSERT INTO `sys_favor` VALUES (30, NULL, '学区房[123m]', 1, 51, NULL, NULL);
INSERT INTO `sys_favor` VALUES (31, NULL, '学区房|三室一厅两卫带阳台有电梯', 17, 51, NULL, NULL);
INSERT INTO `sys_favor` VALUES (37, NULL, '学区房|两室一厅一卫一阳台', 13, 43, NULL, NULL);
INSERT INTO `sys_favor` VALUES (38, NULL, '学区房|两室一厅一卫生间', 12, 43, NULL, NULL);
INSERT INTO `sys_favor` VALUES (39, NULL, '学区房|三室一厅', 11, 43, NULL, NULL);
INSERT INTO `sys_favor` VALUES (40, NULL, '学区房|靠近桂林理工大学', 18, 43, NULL, NULL);
INSERT INTO `sys_favor` VALUES (41, NULL, '学区房|两室一厅|近西山小学', 14, 43, NULL, NULL);
INSERT INTO `sys_favor` VALUES (42, NULL, '学区房|两室一厅一卫生间|近平南镇四中', 15, 43, NULL, NULL);
INSERT INTO `sys_favor` VALUES (43, NULL, '学区房|靠近桂林理工大学', 18, 24, NULL, NULL);
INSERT INTO `sys_favor` VALUES (44, NULL, '学区房|三室一厅两卫带阳台有电梯', 17, 24, NULL, NULL);
INSERT INTO `sys_favor` VALUES (45, NULL, '爱情公寓', 5, 24, NULL, NULL);
INSERT INTO `sys_favor` VALUES (46, NULL, '爱情公寓', 5, 25, NULL, NULL);
INSERT INTO `sys_favor` VALUES (47, NULL, '学生公寓', 4, 25, NULL, NULL);
INSERT INTO `sys_favor` VALUES (48, NULL, '居民平房11', 3, 25, NULL, NULL);
INSERT INTO `sys_favor` VALUES (49, NULL, '海景房', 2, 25, NULL, NULL);
INSERT INTO `sys_favor` VALUES (50, NULL, '学区房|三室一厅两卫带阳台有电梯', 17, 20, NULL, NULL);
INSERT INTO `sys_favor` VALUES (51, NULL, '爱情公寓', 5, 20, NULL, NULL);
INSERT INTO `sys_favor` VALUES (52, NULL, '学生公寓', 4, 20, NULL, NULL);
INSERT INTO `sys_favor` VALUES (53, NULL, '居民平房11', 3, 20, NULL, NULL);
INSERT INTO `sys_favor` VALUES (55, NULL, '海景房', 2, 20, NULL, NULL);
INSERT INTO `sys_favor` VALUES (56, NULL, '学区房|靠近桂林理工大学', 18, 21, NULL, NULL);
INSERT INTO `sys_favor` VALUES (57, NULL, '学区房|三室一厅两卫带阳台有电梯', 17, 21, NULL, NULL);
INSERT INTO `sys_favor` VALUES (58, NULL, '学区房|两室一厅一卫生间|近平南镇镇中', 16, 21, NULL, NULL);
INSERT INTO `sys_favor` VALUES (59, NULL, '学区房|两室一厅一卫生间|近平南镇四中', 15, 21, NULL, NULL);
INSERT INTO `sys_favor` VALUES (60, NULL, '学区房|两室一厅|近西山小学', 14, 21, NULL, NULL);
INSERT INTO `sys_favor` VALUES (61, NULL, '学区房[123m]', 1, 22, NULL, NULL);
INSERT INTO `sys_favor` VALUES (62, NULL, '海景房', 2, 22, NULL, NULL);
INSERT INTO `sys_favor` VALUES (63, NULL, '学区房|三室一厅', 11, 22, NULL, NULL);
INSERT INTO `sys_favor` VALUES (64, NULL, '爱情公寓', 5, 22, NULL, NULL);
INSERT INTO `sys_favor` VALUES (66, NULL, '学区房|靠近桂林理工大学', 18, 25, NULL, NULL);
INSERT INTO `sys_favor` VALUES (67, NULL, '学区房|三室一厅两卫带阳台有电梯', 17, 25, NULL, NULL);
INSERT INTO `sys_favor` VALUES (68, NULL, '学区房|三室一厅', 11, 25, NULL, NULL);
INSERT INTO `sys_favor` VALUES (69, NULL, '学区房|靠近桂林理工大学', 18, 26, NULL, NULL);
INSERT INTO `sys_favor` VALUES (70, NULL, '学区房|两室一厅一卫生间', 12, 26, NULL, NULL);
INSERT INTO `sys_favor` VALUES (72, NULL, '学区房|两室一厅|近西山小学', 14, 26, NULL, NULL);
INSERT INTO `sys_favor` VALUES (73, NULL, '学区房|两室一厅一卫生间|近平南镇镇中', 16, 26, NULL, NULL);
INSERT INTO `sys_favor` VALUES (74, NULL, '学区房|三室一厅', 11, 26, NULL, NULL);
INSERT INTO `sys_favor` VALUES (75, NULL, '学区房|两室一厅一卫生间|近平南镇四中', 15, 26, NULL, NULL);
INSERT INTO `sys_favor` VALUES (76, NULL, '学区房[123m]', 1, 26, NULL, NULL);
INSERT INTO `sys_favor` VALUES (77, NULL, '学区房|两室一厅一卫一阳台', 13, 26, NULL, NULL);
INSERT INTO `sys_favor` VALUES (78, NULL, '学区房|三室一厅两卫带阳台有电梯', 17, 26, NULL, NULL);
INSERT INTO `sys_favor` VALUES (79, NULL, '学区房|两室一厅一卫一阳台', 13, 17, NULL, NULL);
INSERT INTO `sys_favor` VALUES (80, NULL, '学区房|两室一卫一厅，适合陪读', 74, 16, NULL, NULL);
INSERT INTO `sys_favor` VALUES (81, NULL, '学区房[123m]', 1, 29, NULL, NULL);
INSERT INTO `sys_favor` VALUES (82, NULL, '学区房|三室一厅', 11, 29, NULL, NULL);
INSERT INTO `sys_favor` VALUES (83, NULL, '学区房|两室一卫一厅，888', 76, 30, NULL, NULL);
INSERT INTO `sys_favor` VALUES (84, NULL, '学区房|两室一厅一卫生间|近平南镇镇中', 16, 30, NULL, NULL);
INSERT INTO `sys_favor` VALUES (85, NULL, '学区房|两室一厅一卫生间|近平南镇四中', 15, 30, NULL, NULL);
INSERT INTO `sys_favor` VALUES (86, NULL, '学区房[123m]', 1, 31, NULL, NULL);
INSERT INTO `sys_favor` VALUES (93, NULL, '学区房|三室一厅两卫带阳台有电梯', 17, 16, '2024-05-14 22:40:32', NULL);
INSERT INTO `sys_favor` VALUES (94, NULL, '学区房|靠近桂林理工大学', 18, 16, '2024-05-15 22:12:56', NULL);
INSERT INTO `sys_favor` VALUES (96, NULL, '爱情公寓', 5, 16, '2024-05-15 22:18:09', NULL);
INSERT INTO `sys_favor` VALUES (98, NULL, '学区房[123m]', 1, 16, '2024-05-15 22:35:48', NULL);
INSERT INTO `sys_favor` VALUES (103, NULL, '学生公寓', 4, 16, '2024-05-24 13:07:45', NULL);
INSERT INTO `sys_favor` VALUES (106, NULL, '学区房|两室一厅一卫生间|近平南镇镇中', 16, 16, '2024-05-24 14:49:38', NULL);
INSERT INTO `sys_favor` VALUES (107, NULL, '学区房|两室一厅一卫生间|近平南镇四中', 15, 16, '2024-05-24 14:49:48', NULL);
INSERT INTO `sys_favor` VALUES (108, NULL, '海景房', 2, 16, '2024-05-24 14:49:59', NULL);

-- ----------------------------
-- Table structure for sys_feedback
-- ----------------------------
DROP TABLE IF EXISTS `sys_feedback`;
CREATE TABLE `sys_feedback`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '标题',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '内容',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `status` int NOT NULL DEFAULT 0 COMMENT '0未处理  1已处理',
  `create_time` datetime NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `suggestion` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `comment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `type_id` int NULL DEFAULT NULL COMMENT '反馈类型id',
  `user_id` int NULL DEFAULT NULL COMMENT '发起人id',
  `admin_id` int NULL DEFAULT NULL COMMENT '处理人id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_feedback
-- ----------------------------

-- ----------------------------
-- Table structure for sys_history
-- ----------------------------
DROP TABLE IF EXISTS `sys_history`;
CREATE TABLE `sys_history`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '这个字段是用于模糊查询的',
  `house_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '这个字段是用于模糊查询的',
  `user_id` bigint NULL DEFAULT NULL,
  `house_id` bigint NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 244 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_history
-- ----------------------------
INSERT INTO `sys_history` VALUES (2, '租户-0528', '学区房[123m]', 51, 1, '2024-05-10 21:56:22', NULL);
INSERT INTO `sys_history` VALUES (3, '租户-0528', '海景房', 51, 2, '2024-05-10 22:49:49', NULL);
INSERT INTO `sys_history` VALUES (10, '租户-梅兰竹菊', '学区房|靠近桂林理工大学', 16, 18, '2024-05-11 13:43:51', NULL);
INSERT INTO `sys_history` VALUES (11, '租户-梅兰竹菊', '学区房|三室一厅两卫带阳台有电梯', 16, 17, '2024-05-11 13:43:53', NULL);
INSERT INTO `sys_history` VALUES (12, '租户-梅兰竹菊', '学区房|三室一厅', 16, 11, '2024-05-11 13:44:00', NULL);
INSERT INTO `sys_history` VALUES (13, '租户-梅兰竹菊', '学区房|两室一厅一卫生间', 16, 12, '2024-05-11 13:44:06', NULL);
INSERT INTO `sys_history` VALUES (14, '租户-梅兰竹菊', '学区房|两室一厅一卫一阳台', 16, 13, '2024-05-11 13:44:10', NULL);
INSERT INTO `sys_history` VALUES (15, '租户-梅兰竹菊', '学区房[123m]', 16, 1, '2024-05-11 13:44:18', NULL);
INSERT INTO `sys_history` VALUES (16, '租户-梅兰竹菊', '学区房|两室一厅一卫生间|近平南镇四中', 16, 15, '2024-05-11 13:44:55', NULL);
INSERT INTO `sys_history` VALUES (17, '租户-梅兰竹菊', '学区房|两室一厅一卫生间|近平南镇镇中', 16, 16, '2024-05-11 13:44:59', NULL);
INSERT INTO `sys_history` VALUES (18, '租户-梅兰竹菊', '学区房|两室一厅|近西山小学', 16, 14, '2024-05-11 13:45:03', NULL);
INSERT INTO `sys_history` VALUES (19, '租户-0528', '学区房|靠近桂林理工大学', 51, 18, '2024-05-11 13:57:11', NULL);
INSERT INTO `sys_history` VALUES (20, '租户-0528', '学区房|三室一厅两卫带阳台有电梯', 51, 17, '2024-05-11 13:57:13', NULL);
INSERT INTO `sys_history` VALUES (21, '租户-0528', '爱情公寓', 51, 5, '2024-05-11 13:57:15', NULL);
INSERT INTO `sys_history` VALUES (22, '租户-0528', '学生公寓', 51, 4, '2024-05-11 13:57:17', NULL);
INSERT INTO `sys_history` VALUES (23, '租户-0528', '学区房|三室一厅', 51, 11, '2024-05-11 13:57:20', NULL);
INSERT INTO `sys_history` VALUES (24, '租户-0528', '学区房|两室一厅一卫生间', 51, 12, '2024-05-11 13:57:23', NULL);
INSERT INTO `sys_history` VALUES (25, '租户-0528', '学区房|两室一厅一卫一阳台', 51, 13, '2024-05-11 13:57:26', NULL);
INSERT INTO `sys_history` VALUES (26, '租户-0528', '学区房|两室一厅一卫生间|近平南镇镇中', 51, 16, '2024-05-11 14:01:18', NULL);
INSERT INTO `sys_history` VALUES (27, '租户-0528', '学区房|两室一厅|近西山小学', 51, 14, '2024-05-11 14:02:56', NULL);
INSERT INTO `sys_history` VALUES (28, '租户-0528', '学区房|两室一厅一卫生间|近平南镇四中', 51, 15, '2024-05-11 14:03:00', NULL);
INSERT INTO `sys_history` VALUES (29, '租户-0528', '学区房[123m]', 51, 1, '2024-05-11 14:05:02', NULL);
INSERT INTO `sys_history` VALUES (36, '租户-0520', '学区房|靠近桂林理工大学', 43, 18, '2024-05-11 14:06:34', NULL);
INSERT INTO `sys_history` VALUES (37, '租户-0520', '学区房|两室一厅一卫一阳台', 43, 13, '2024-05-11 14:06:38', NULL);
INSERT INTO `sys_history` VALUES (38, '租户-0520', '学区房|两室一厅一卫生间', 43, 12, '2024-05-11 14:06:41', NULL);
INSERT INTO `sys_history` VALUES (39, '租户-0520', '学区房|三室一厅', 43, 11, '2024-05-11 14:06:44', NULL);
INSERT INTO `sys_history` VALUES (40, '租户-0520', '学区房|两室一厅|近西山小学', 43, 14, '2024-05-11 14:06:51', NULL);
INSERT INTO `sys_history` VALUES (41, '租户-0520', '学区房|两室一厅一卫生间|近平南镇四中', 43, 15, '2024-05-11 14:06:54', NULL);
INSERT INTO `sys_history` VALUES (42, '租户-0520', '学区房|两室一厅一卫生间|近平南镇镇中', 43, 16, '2024-05-11 14:06:58', NULL);
INSERT INTO `sys_history` VALUES (43, '租户-0501', '学区房|靠近桂林理工大学', 24, 18, '2024-05-11 14:07:17', NULL);
INSERT INTO `sys_history` VALUES (44, '租户-0501', '学区房|三室一厅两卫带阳台有电梯', 24, 17, '2024-05-11 14:07:20', NULL);
INSERT INTO `sys_history` VALUES (45, '租户-0501', '爱情公寓', 24, 5, '2024-05-11 14:07:23', NULL);
INSERT INTO `sys_history` VALUES (46, '租户-0502', '学区房|靠近桂林理工大学', 25, 18, '2024-05-11 14:07:48', NULL);
INSERT INTO `sys_history` VALUES (47, '租户-0502', '爱情公寓', 25, 5, '2024-05-11 14:08:47', NULL);
INSERT INTO `sys_history` VALUES (48, '租户-0502', '学生公寓', 25, 4, '2024-05-11 14:08:51', NULL);
INSERT INTO `sys_history` VALUES (49, '租户-0502', '居民平房11', 25, 3, '2024-05-11 14:08:56', NULL);
INSERT INTO `sys_history` VALUES (50, '租户-0502', '海景房', 25, 2, '2024-05-11 14:09:03', NULL);
INSERT INTO `sys_history` VALUES (51, '租户-0502', '学区房|三室一厅两卫带阳台有电梯', 25, 17, '2024-05-11 14:09:12', NULL);
INSERT INTO `sys_history` VALUES (52, '租户-毛笔', '学区房|三室一厅两卫带阳台有电梯', 20, 17, '2024-05-11 14:09:36', NULL);
INSERT INTO `sys_history` VALUES (53, '租户-毛笔', '爱情公寓', 20, 5, '2024-05-11 14:09:38', NULL);
INSERT INTO `sys_history` VALUES (54, '租户-毛笔', '学生公寓', 20, 4, '2024-05-11 14:09:41', NULL);
INSERT INTO `sys_history` VALUES (55, '租户-毛笔', '居民平房11', 20, 3, '2024-05-11 14:09:46', NULL);
INSERT INTO `sys_history` VALUES (56, '租户-毛笔', '海景房', 20, 2, '2024-05-11 14:09:49', NULL);
INSERT INTO `sys_history` VALUES (57, '租户-墨水', '学区房|靠近桂林理工大学', 21, 18, '2024-05-11 14:10:12', NULL);
INSERT INTO `sys_history` VALUES (58, '租户-墨水', '学区房|三室一厅两卫带阳台有电梯', 21, 17, '2024-05-11 14:10:16', NULL);
INSERT INTO `sys_history` VALUES (59, '租户-墨水', '学区房|两室一厅一卫生间|近平南镇镇中', 21, 16, '2024-05-11 14:10:19', NULL);
INSERT INTO `sys_history` VALUES (60, '租户-墨水', '学区房|两室一厅一卫生间|近平南镇四中', 21, 15, '2024-05-11 14:10:22', NULL);
INSERT INTO `sys_history` VALUES (61, '租户-墨水', '学区房|两室一厅|近西山小学', 21, 14, '2024-05-11 14:10:26', NULL);
INSERT INTO `sys_history` VALUES (62, '租户-宣纸', '学区房[123m]', 22, 1, '2024-05-11 14:11:28', NULL);
INSERT INTO `sys_history` VALUES (63, '租户-宣纸', '海景房', 22, 2, '2024-05-11 14:11:31', NULL);
INSERT INTO `sys_history` VALUES (64, '租户-宣纸', '学生公寓', 22, 4, '2024-05-11 14:11:35', NULL);
INSERT INTO `sys_history` VALUES (65, '租户-宣纸', '学区房|三室一厅', 22, 11, '2024-05-11 14:11:37', NULL);
INSERT INTO `sys_history` VALUES (66, '租户-宣纸', '爱情公寓', 22, 5, '2024-05-11 14:11:41', NULL);
INSERT INTO `sys_history` VALUES (67, '租户-宣纸', '学区房|两室一厅一卫生间|近平南镇镇中', 22, 16, '2024-05-11 14:11:45', NULL);
INSERT INTO `sys_history` VALUES (68, '租户-宣纸', '学区房|靠近桂林理工大学', 22, 18, '2024-05-11 14:11:50', NULL);
INSERT INTO `sys_history` VALUES (69, '租户-梅兰竹菊', '爱情公寓', 16, 5, '2024-05-11 14:15:17', NULL);
INSERT INTO `sys_history` VALUES (70, '租户-0502', '学区房[123m]', 25, 1, '2024-05-11 14:19:09', NULL);
INSERT INTO `sys_history` VALUES (71, '租户-0502', '学区房|三室一厅', 25, 11, '2024-05-11 14:19:12', NULL);
INSERT INTO `sys_history` VALUES (72, '租户-0503', '学区房|靠近桂林理工大学', 26, 18, '2024-05-11 14:19:30', NULL);
INSERT INTO `sys_history` VALUES (73, '租户-0503', '学区房|两室一厅一卫生间', 26, 12, '2024-05-11 14:19:33', NULL);
INSERT INTO `sys_history` VALUES (74, '租户-0503', '学区房|两室一厅一卫一阳台', 26, 13, '2024-05-11 14:19:36', NULL);
INSERT INTO `sys_history` VALUES (75, '租户-0503', '学区房|两室一厅|近西山小学', 26, 14, '2024-05-11 14:19:41', NULL);
INSERT INTO `sys_history` VALUES (76, '租户-0503', '学区房|两室一厅一卫生间|近平南镇镇中', 26, 16, '2024-05-11 14:19:45', NULL);
INSERT INTO `sys_history` VALUES (77, '租户-0503', '学区房[123m]', 26, 1, '2024-05-11 23:38:29', NULL);
INSERT INTO `sys_history` VALUES (78, '租户-0503', '海景房', 26, 2, '2024-05-11 23:38:33', NULL);
INSERT INTO `sys_history` VALUES (79, '租户-0503', '学生公寓', 26, 4, '2024-05-11 23:38:36', NULL);
INSERT INTO `sys_history` VALUES (80, '租户-0503', '学区房|两室一卫一厅，适合陪读', 26, 70, '2024-05-11 23:39:07', NULL);
INSERT INTO `sys_history` VALUES (81, '租户-0503', '学区房|两室一卫一厅，适合陪读', 26, 44, '2024-05-11 23:39:12', NULL);
INSERT INTO `sys_history` VALUES (82, '租户-0503', '学区房|两室一卫一厅，适合陪读', 26, 62, '2024-05-11 23:39:14', NULL);
INSERT INTO `sys_history` VALUES (83, '租户-0503', '学区房|两室一卫一厅，适合陪读', 26, 55, '2024-05-11 23:39:19', NULL);
INSERT INTO `sys_history` VALUES (84, '租户-0503', '学区房|两室一卫一厅，适合陪读', 26, 52, '2024-05-11 23:45:39', NULL);
INSERT INTO `sys_history` VALUES (85, '租户-0503', '学区房|两室一卫一厅，适合陪读', 26, 65, '2024-05-11 23:45:41', NULL);
INSERT INTO `sys_history` VALUES (86, '租户-0503', '学区房|两室一卫一厅，适合陪读', 26, 56, '2024-05-11 23:45:43', NULL);
INSERT INTO `sys_history` VALUES (87, '租户-0503', '学区房|三室一厅', 26, 11, '2024-05-12 09:57:49', NULL);
INSERT INTO `sys_history` VALUES (88, '租户-0503', '学区房|两室一厅一卫生间|近平南镇四中', 26, 15, '2024-05-12 09:58:00', NULL);
INSERT INTO `sys_history` VALUES (89, '租户-0503', '学区房[123m]', 26, 1, '2024-05-12 09:58:08', NULL);
INSERT INTO `sys_history` VALUES (90, '租户-0503', '学区房|两室一厅一卫一阳台', 26, 13, '2024-05-12 10:29:45', NULL);
INSERT INTO `sys_history` VALUES (91, '租户-0503', '学区房|两室一厅|近西山小学', 26, 14, '2024-05-12 10:49:19', NULL);
INSERT INTO `sys_history` VALUES (92, '租户-0503', '学区房|两室一厅一卫生间', 26, 12, '2024-05-12 10:55:06', NULL);
INSERT INTO `sys_history` VALUES (93, '租户-0503', '学区房|两室一厅一卫生间|近平南镇镇中', 26, 16, '2024-05-12 10:55:08', NULL);
INSERT INTO `sys_history` VALUES (94, '租户-0503', '学区房|两室一卫一厅，适合陪读', 26, 26, '2024-05-12 12:21:20', NULL);
INSERT INTO `sys_history` VALUES (95, '租户-0503', '学区房|两室一卫一厅，适合陪读', 26, 72, '2024-05-12 12:29:32', NULL);
INSERT INTO `sys_history` VALUES (96, '租户-0503', '学区房|两室一卫一厅，适合陪读', 26, 71, '2024-05-12 12:31:31', NULL);
INSERT INTO `sys_history` VALUES (97, '租户-0503', '海景房', 26, 2, '2024-05-12 12:31:40', NULL);
INSERT INTO `sys_history` VALUES (98, '租户-0503', '爱情公寓', 26, 5, '2024-05-12 12:32:45', NULL);
INSERT INTO `sys_history` VALUES (99, '租户-0503', '学区房|三室一厅两卫带阳台有电梯', 26, 17, '2024-05-12 14:26:00', NULL);
INSERT INTO `sys_history` VALUES (100, '租户-0503', '居民平房11', 26, 3, '2024-05-12 14:35:24', NULL);
INSERT INTO `sys_history` VALUES (101, '租户-0503', '学区房|两室一卫一厅，适合陪读', 26, 82, '2024-05-12 14:37:02', NULL);
INSERT INTO `sys_history` VALUES (102, '租户-0502', '学区房|三室一厅两卫带阳台有电梯', 25, 17, '2024-05-12 21:23:53', NULL);
INSERT INTO `sys_history` VALUES (103, '租户-0502', '爱情公寓', 25, 5, '2024-05-12 22:34:44', NULL);
INSERT INTO `sys_history` VALUES (104, '租户-0502', '学区房[123m]', 25, 1, '2024-05-12 22:35:06', NULL);
INSERT INTO `sys_history` VALUES (105, '租户-0502', '学区房[123m]', 25, 1, '2024-05-13 00:00:41', NULL);
INSERT INTO `sys_history` VALUES (106, '租户-0503', '学区房[123m]', 26, 1, '2024-05-13 10:43:38', NULL);
INSERT INTO `sys_history` VALUES (107, '租户-宣纸', '居民平房11', 22, 3, '2024-05-13 11:08:41', NULL);
INSERT INTO `sys_history` VALUES (108, '租户-宣纸', '学区房|两室一厅一卫生间', 22, 12, '2024-05-13 11:08:44', NULL);
INSERT INTO `sys_history` VALUES (109, '租户-宣纸', '学区房|两室一厅一卫一阳台', 22, 13, '2024-05-13 11:08:45', NULL);
INSERT INTO `sys_history` VALUES (110, '租户-宣纸', '学区房|两室一厅|近西山小学', 22, 14, '2024-05-13 11:08:47', NULL);
INSERT INTO `sys_history` VALUES (111, '租户-宣纸', '学区房|两室一厅一卫生间|近平南镇四中', 22, 15, '2024-05-13 11:08:49', NULL);
INSERT INTO `sys_history` VALUES (112, '租户-宣纸', '学区房|三室一厅两卫带阳台有电梯', 22, 17, '2024-05-13 11:09:52', NULL);
INSERT INTO `sys_history` VALUES (113, '租户-宣纸', '学区房|两室一卫一厅，适合陪读', 22, 82, '2024-05-13 11:09:54', NULL);
INSERT INTO `sys_history` VALUES (114, '租户-0503', '学区房|两室一厅一卫生间|近平南镇镇中', 26, 16, '2024-05-13 11:11:07', NULL);
INSERT INTO `sys_history` VALUES (115, '租户-梅兰竹菊', '学区房[123m]', 16, 1, '2024-05-13 11:11:20', NULL);
INSERT INTO `sys_history` VALUES (116, '租户-梅兰竹菊', '学区房|三室一厅', 16, 11, '2024-05-13 11:11:27', NULL);
INSERT INTO `sys_history` VALUES (117, '租户-梅兰竹菊', '学区房|两室一卫一厅，适合陪读', 16, 74, '2024-05-13 11:11:28', NULL);
INSERT INTO `sys_history` VALUES (118, '租户-梅兰竹菊', '学区房|两室一卫一厅，适合陪读', 16, 75, '2024-05-13 11:11:30', NULL);
INSERT INTO `sys_history` VALUES (119, '租户-梅兰竹菊', '学区房|两室一卫一厅，适合陪读', 16, 84, '2024-05-13 11:11:31', NULL);
INSERT INTO `sys_history` VALUES (120, '租户-梅兰竹菊', '学区房|两室一厅一卫生间|近平南镇四中', 16, 15, '2024-05-13 11:11:37', NULL);
INSERT INTO `sys_history` VALUES (121, '租户-梅兰竹菊', '学区房|两室一厅|近西山小学', 16, 14, '2024-05-13 11:11:42', NULL);
INSERT INTO `sys_history` VALUES (122, '租户-梅兰竹菊', '学区房|靠近桂林理工大学', 16, 18, '2024-05-13 11:11:44', NULL);
INSERT INTO `sys_history` VALUES (123, '租户-梅兰竹菊', '学区房|三室一厅两卫带阳台有电梯', 16, 17, '2024-05-13 11:11:46', NULL);
INSERT INTO `sys_history` VALUES (124, '租户-梅兰竹菊', '学生公寓', 16, 4, '2024-05-13 11:11:48', NULL);
INSERT INTO `sys_history` VALUES (125, '租户-兰花', '学生公寓', 17, 4, '2024-05-13 11:19:13', NULL);
INSERT INTO `sys_history` VALUES (126, '租户-兰花', '爱情公寓', 17, 5, '2024-05-13 11:19:15', NULL);
INSERT INTO `sys_history` VALUES (127, '租户-兰花', '学区房[123m]', 17, 1, '2024-05-13 11:19:16', NULL);
INSERT INTO `sys_history` VALUES (128, '租户-兰花', '学区房|三室一厅', 17, 11, '2024-05-13 11:19:18', NULL);
INSERT INTO `sys_history` VALUES (129, '租户-兰花', '学区房|两室一厅一卫一阳台', 17, 13, '2024-05-13 11:19:19', NULL);
INSERT INTO `sys_history` VALUES (130, '租户-兰花', '学区房|两室一厅一卫生间|近平南镇四中', 17, 15, '2024-05-13 11:19:21', NULL);
INSERT INTO `sys_history` VALUES (131, '租户-兰花', '学区房|两室一厅一卫生间', 17, 12, '2024-05-13 11:19:23', NULL);
INSERT INTO `sys_history` VALUES (132, '租户-兰花', '学区房|三室一厅两卫带阳台有电梯', 17, 17, '2024-05-13 11:19:25', NULL);
INSERT INTO `sys_history` VALUES (133, '租户-兰花', '学区房|靠近桂林理工大学', 17, 18, '2024-05-13 11:19:27', NULL);
INSERT INTO `sys_history` VALUES (134, '租户-兰花', '学区房|两室一厅|近西山小学', 17, 14, '2024-05-13 11:19:29', NULL);
INSERT INTO `sys_history` VALUES (135, '租户-兰花', '学区房|两室一卫一厅，适合陪读', 17, 81, '2024-05-13 11:19:30', NULL);
INSERT INTO `sys_history` VALUES (136, '租户-兰花', '居民平房11', 17, 3, '2024-05-13 11:19:32', NULL);
INSERT INTO `sys_history` VALUES (137, '租户-兰花', '学区房|两室一卫一厅，适合陪读', 17, 74, '2024-05-13 11:19:36', NULL);
INSERT INTO `sys_history` VALUES (138, '租户-梅兰竹菊', '学区房|两室一厅一卫生间|近平南镇镇中', 16, 16, '2024-05-13 12:38:08', NULL);
INSERT INTO `sys_history` VALUES (139, '租户-兰花', '学区房|两室一厅一卫生间|近平南镇镇中', 17, 16, '2024-05-13 13:10:02', NULL);
INSERT INTO `sys_history` VALUES (140, '租户-0505', '学区房|靠近桂林理工大学', 28, 18, '2024-05-13 13:53:54', NULL);
INSERT INTO `sys_history` VALUES (141, '租户-0505', '学生公寓', 28, 4, '2024-05-13 13:53:58', NULL);
INSERT INTO `sys_history` VALUES (142, '租户-0505', '学区房|两室一厅一卫生间', 28, 12, '2024-05-13 13:54:00', NULL);
INSERT INTO `sys_history` VALUES (143, '租户-0505', '学区房|三室一厅两卫带阳台有电梯', 28, 17, '2024-05-13 13:54:03', NULL);
INSERT INTO `sys_history` VALUES (144, '租户-0505', '学区房|三室一厅', 28, 11, '2024-05-13 13:54:05', NULL);
INSERT INTO `sys_history` VALUES (145, '租户-0505', '学区房|两室一厅|近西山小学', 28, 14, '2024-05-13 13:54:07', NULL);
INSERT INTO `sys_history` VALUES (146, '租户-0506', '学区房|两室一厅|近西山小学', 29, 14, '2024-05-13 15:20:12', NULL);
INSERT INTO `sys_history` VALUES (147, '租户-0506', '学区房[123m]', 29, 1, '2024-05-13 15:20:22', NULL);
INSERT INTO `sys_history` VALUES (148, '租户-0506', '学区房|三室一厅', 29, 11, '2024-05-13 15:20:29', NULL);
INSERT INTO `sys_history` VALUES (149, '租户-0506', '学区房|两室一厅一卫生间|近平南镇镇中', 29, 16, '2024-05-13 15:20:34', NULL);
INSERT INTO `sys_history` VALUES (150, '租户-0506', '学区房|靠近桂林理工大学', 29, 18, '2024-05-13 15:20:36', NULL);
INSERT INTO `sys_history` VALUES (151, '租户-0507', '学区房|两室一卫一厅，888', 30, 76, '2024-05-13 15:20:57', NULL);
INSERT INTO `sys_history` VALUES (152, '租户-0507', '学区房|两室一厅一卫生间|近平南镇镇中', 30, 16, '2024-05-13 15:21:02', NULL);
INSERT INTO `sys_history` VALUES (153, '租户-0507', '学区房|两室一厅一卫生间|近平南镇四中', 30, 15, '2024-05-13 15:21:07', NULL);
INSERT INTO `sys_history` VALUES (154, '租户-0507', '学区房|两室一卫一厅，101010', 30, 74, '2024-05-13 15:21:11', NULL);
INSERT INTO `sys_history` VALUES (155, '租户-0507', '学区房|靠近桂林理工大学', 30, 18, '2024-05-13 15:21:14', NULL);
INSERT INTO `sys_history` VALUES (156, '租户-0508', '学区房[123m]', 31, 1, '2024-05-13 15:21:30', NULL);
INSERT INTO `sys_history` VALUES (157, '租户-0508', '学区房|两室一厅一卫生间', 31, 12, '2024-05-13 15:21:45', NULL);
INSERT INTO `sys_history` VALUES (158, '租户-0508', '学区房|两室一卫一厅，101010', 31, 74, '2024-05-13 15:21:48', NULL);
INSERT INTO `sys_history` VALUES (159, '租户-0508', '学区房|三室一厅两卫带阳台有电梯', 31, 17, '2024-05-13 15:21:51', NULL);
INSERT INTO `sys_history` VALUES (160, '租户-0508', '学区房|两室一厅|近西山小学', 31, 14, '2024-05-13 15:21:53', NULL);
INSERT INTO `sys_history` VALUES (173, '租户-梅兰竹菊', '学区房|两室一卫一厅，101010', 16, 74, '2024-05-14 22:40:25', NULL);
INSERT INTO `sys_history` VALUES (174, '租户-梅兰竹菊', '学区房|两室一卫一厅，888', 16, 76, '2024-05-14 22:40:28', NULL);
INSERT INTO `sys_history` VALUES (175, '租户-梅兰竹菊', '学区房|三室一厅两卫带阳台有电梯', 16, 17, '2024-05-14 22:40:31', NULL);
INSERT INTO `sys_history` VALUES (176, '租户-梅兰竹菊', '学区房|靠近桂林理工大学', 16, 18, '2024-05-15 22:12:53', NULL);
INSERT INTO `sys_history` VALUES (177, '租户-梅兰竹菊', '海景房', 16, 2, '2024-05-15 22:13:52', NULL);
INSERT INTO `sys_history` VALUES (178, '租户-梅兰竹菊', '学区房|两室一厅一卫生间|近平南镇四中', 16, 15, '2024-05-15 22:16:48', NULL);
INSERT INTO `sys_history` VALUES (179, '租户-梅兰竹菊', '爱情公寓', 16, 5, '2024-05-15 22:18:06', NULL);
INSERT INTO `sys_history` VALUES (180, '租户-梅兰竹菊', '学区房[123m]', 16, 1, '2024-05-15 22:18:20', NULL);
INSERT INTO `sys_history` VALUES (181, '租户-梅兰竹菊', '学区房|两室一厅一卫生间', 16, 12, '2024-05-15 22:39:31', NULL);
INSERT INTO `sys_history` VALUES (182, '租户-梅兰竹菊', '学区房|两室一厅一卫一阳台', 16, 13, '2024-05-15 22:39:35', NULL);
INSERT INTO `sys_history` VALUES (183, '租户-梅兰竹菊', '学区房|两室一卫一厅，888', 16, 76, '2024-05-15 22:39:48', NULL);
INSERT INTO `sys_history` VALUES (184, '租户-梅兰竹菊', '测试房屋', 16, 89, '2024-05-15 22:45:12', NULL);
INSERT INTO `sys_history` VALUES (185, '租户-梅兰竹菊', '学区房|两室一厅一卫生间|近平南镇四中', 16, 15, '2024-05-16 11:13:18', NULL);
INSERT INTO `sys_history` VALUES (186, '租户-梅兰竹菊', '海景房', 16, 2, '2024-05-16 11:15:05', NULL);
INSERT INTO `sys_history` VALUES (187, '租户-梅兰竹菊', '居民平房11', 16, 3, '2024-05-16 11:15:09', NULL);
INSERT INTO `sys_history` VALUES (188, '租户-梅兰竹菊', '学区房|靠近桂林理工大学', 16, 18, '2024-05-16 11:15:13', NULL);
INSERT INTO `sys_history` VALUES (189, '租户-梅兰竹菊', '学区房|两室一厅一卫生间', 16, 12, '2024-05-17 10:50:19', NULL);
INSERT INTO `sys_history` VALUES (190, '租户-梅兰竹菊', '学区房[123m]', 16, 1, '2024-05-17 10:51:45', NULL);
INSERT INTO `sys_history` VALUES (191, '租户-梅兰竹菊', '学生公寓', 16, 4, '2024-05-17 17:23:27', NULL);
INSERT INTO `sys_history` VALUES (192, '租户-梅兰竹菊', '学区房|两室一厅一卫生间|近平南镇镇中', 16, 16, '2024-05-19 21:08:17', NULL);
INSERT INTO `sys_history` VALUES (195, '租户-梅兰竹菊', '学区房|两室一厅一卫生间', 16, 12, '2024-05-19 21:13:26', NULL);
INSERT INTO `sys_history` VALUES (196, '租户-梅兰竹菊', '海景房', 16, 2, '2024-05-19 21:20:26', NULL);
INSERT INTO `sys_history` VALUES (197, '啾啾', '海景房', 55, 2, '2024-05-19 21:20:46', NULL);
INSERT INTO `sys_history` VALUES (200, '租户-梅兰竹菊', '学区房|两室一厅一卫一阳台', 16, 13, '2024-05-19 21:22:10', NULL);
INSERT INTO `sys_history` VALUES (201, '租户-梅兰竹菊', '测试房屋', 16, 89, '2024-05-21 09:40:41', NULL);
INSERT INTO `sys_history` VALUES (202, '租户-梅兰竹菊', '学区房|靠近桂林理工大学', 16, 18, '2024-05-21 10:07:22', NULL);
INSERT INTO `sys_history` VALUES (203, '租户-梅兰竹菊', '学区房|靠近桂林理工大学', 16, 18, '2024-05-22 15:06:00', NULL);
INSERT INTO `sys_history` VALUES (204, '租户-梅兰竹菊', '学区房|两室一厅一卫生间|近平南镇镇中', 16, 16, '2024-05-22 16:33:52', NULL);
INSERT INTO `sys_history` VALUES (205, '租户-梅兰竹菊', '海景房', 16, 2, '2024-05-22 17:07:09', NULL);
INSERT INTO `sys_history` VALUES (206, '租户-梅兰竹菊', '学区房|两室一卫一厅，555', 16, 79, '2024-05-22 17:14:19', NULL);
INSERT INTO `sys_history` VALUES (207, '租户-梅兰竹菊', '学区房[123m]', 16, 1, '2024-05-22 21:13:07', NULL);
INSERT INTO `sys_history` VALUES (208, '租户-梅兰竹菊', '学区房|两室一厅一卫生间|近平南镇四中', 16, 15, '2024-05-24 13:07:24', NULL);
INSERT INTO `sys_history` VALUES (209, '租户-梅兰竹菊', '学生公寓', 16, 4, '2024-05-24 13:07:45', NULL);
INSERT INTO `sys_history` VALUES (210, '租户-梅兰竹菊', '学区房|两室一厅一卫一阳台', 16, 13, '2024-05-24 13:36:13', NULL);
INSERT INTO `sys_history` VALUES (211, '租户-梅兰竹菊', '爱情公寓', 16, 5, '2024-05-24 13:36:18', NULL);
INSERT INTO `sys_history` VALUES (212, '租户-梅兰竹菊', '测试房屋', 16, 89, '2024-05-24 14:47:55', NULL);
INSERT INTO `sys_history` VALUES (213, '租户-梅兰竹菊', '学区房|两室一厅一卫生间|近平南镇镇中', 16, 16, '2024-05-24 14:48:02', NULL);
INSERT INTO `sys_history` VALUES (214, '租户-梅兰竹菊', '学区房|两室一卫一厅，888', 16, 76, '2024-05-24 14:48:08', NULL);
INSERT INTO `sys_history` VALUES (215, '租户-梅兰竹菊', '海景房', 16, 2, '2024-05-24 14:49:58', NULL);
INSERT INTO `sys_history` VALUES (216, '租户-梅兰竹菊', '学区房|三室一厅', 16, 11, '2024-05-24 16:40:49', NULL);
INSERT INTO `sys_history` VALUES (217, '两人', '测试房屋', 57, 89, '2024-05-24 16:48:24', NULL);
INSERT INTO `sys_history` VALUES (218, '租户-梅兰竹菊', '学区房|两室一卫一厅，111', 16, 83, '2024-05-24 20:18:46', NULL);
INSERT INTO `sys_history` VALUES (219, '租户-梅兰竹菊', '学区房|靠近桂林理工大学', 16, 18, '2024-05-24 20:34:27', NULL);
INSERT INTO `sys_history` VALUES (220, '租户-0501', '居民平房11', 24, 3, '2024-05-26 16:53:29', NULL);
INSERT INTO `sys_history` VALUES (221, '租户-0501', '海景房', 24, 2, '2024-05-26 16:57:54', NULL);
INSERT INTO `sys_history` VALUES (222, '租户-0501', '学区房|批量导入999', 24, 98, '2024-05-26 19:31:19', NULL);
INSERT INTO `sys_history` VALUES (223, '租户-0501', '学生公寓', 24, 4, '2024-05-26 19:34:35', NULL);
INSERT INTO `sys_history` VALUES (224, '租户-0501', '学区房|两室一卫一厅，777', 24, 77, '2024-05-26 19:38:38', NULL);
INSERT INTO `sys_history` VALUES (225, '租户-0501', '学区房|批量导入777', 24, 96, '2024-05-26 19:39:17', NULL);
INSERT INTO `sys_history` VALUES (226, '租户-0501', '学区房|两室一厅|近西山小学', 24, 14, '2024-05-26 19:57:52', NULL);
INSERT INTO `sys_history` VALUES (227, '租户-0501', '学区房|两室一厅一卫生间|近平南镇四中', 24, 15, '2024-05-26 19:57:57', NULL);
INSERT INTO `sys_history` VALUES (228, '租户-0501', '学区房|批量导入888', 24, 97, '2024-05-26 20:42:20', NULL);
INSERT INTO `sys_history` VALUES (229, '租户-0501', '学区房|批量导入666', 24, 95, '2024-05-27 00:03:31', NULL);
INSERT INTO `sys_history` VALUES (230, '租户-0501', '学区房|批量导入999', 24, 98, '2024-05-27 00:03:47', NULL);
INSERT INTO `sys_history` VALUES (231, '租户-梅兰竹菊', '海景房', 16, 2, '2024-05-27 10:50:41', NULL);
INSERT INTO `sys_history` VALUES (232, '租户-0501', '爱情公寓', 24, 5, '2024-05-27 17:26:43', NULL);
INSERT INTO `sys_history` VALUES (233, '租户-0501', '学区房|三室一厅', 24, 11, '2024-05-28 00:45:54', NULL);
INSERT INTO `sys_history` VALUES (234, '租户-0501', '学区房|两室一厅一卫一阳台', 24, 13, '2024-05-28 00:46:05', NULL);
INSERT INTO `sys_history` VALUES (235, '租户-0501', '学区房[123m]', 24, 1, '2024-05-28 00:47:40', NULL);
INSERT INTO `sys_history` VALUES (236, '租户-0501', '测试房屋', 24, 89, '2024-05-28 01:06:01', NULL);
INSERT INTO `sys_history` VALUES (237, '租户-0501', '学区房|靠近桂林理工大学', 24, 18, '2024-05-28 09:32:25', NULL);
INSERT INTO `sys_history` VALUES (238, '租户-0501', '学区房|批量导入777', 24, 96, '2024-05-28 09:46:51', NULL);
INSERT INTO `sys_history` VALUES (239, '租户-0501', '学区房|两室一厅一卫生间', 24, 12, '2024-05-29 09:59:54', NULL);
INSERT INTO `sys_history` VALUES (240, '租户-0501', '学区房[123m]', 24, 1, '2024-05-29 12:28:55', NULL);
INSERT INTO `sys_history` VALUES (241, '房东-南宁', '学区房|两室一厅一卫生间', 10, 12, '2024-05-29 12:49:48', NULL);
INSERT INTO `sys_history` VALUES (242, '租户-梅兰竹菊', '学区房[123m]', 16, 1, '2024-05-29 23:34:09', NULL);
INSERT INTO `sys_history` VALUES (243, '租户-梅兰竹菊', '学区房|批量导入111', 16, 90, '2024-05-30 20:12:31', NULL);
INSERT INTO `sys_history` VALUES (244, '租户-梅兰竹菊', '居民平房11', 16, 3, '2024-05-30 20:15:25', NULL);

-- ----------------------------
-- Table structure for sys_house
-- ----------------------------
DROP TABLE IF EXISTS `sys_house`;
CREATE TABLE `sys_house`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '名称',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '描述',
  `detail` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '宝贝详情，下面描述的详情',
  `area` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '面积',
  `city_codeOne` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `city_codeTwo` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `city_codeThree` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `city` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '所处城市',
  `location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '所处位置',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '详细地址',
  `jingdu` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '经度',
  `weidu` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '维度',
  `price` decimal(10, 2) NULL DEFAULT NULL COMMENT '月租金',
  `favor` int NOT NULL DEFAULT 0 COMMENT '收藏数量',
  `pay_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '支付方式  押一付二等',
  `watched` int NOT NULL DEFAULT 0 COMMENT '浏览数量',
  `create_time` datetime NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `status` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '0：未出租   1：已出租   2：已下架',
  `type_id` bigint NULL DEFAULT NULL COMMENT '类型id',
  `owner_id` bigint NULL DEFAULT NULL COMMENT '房东id',
  `user_id` bigint NULL DEFAULT NULL COMMENT '租户id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 99 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_house
-- ----------------------------
INSERT INTO `sys_house` VALUES (1, '学区房[123m]', '这是一间学区房', '<h3><span style=\"color: rgb(225, 60, 57);\"><strong>这里是宝贝详情</strong></span></h3><p><img src=\"https://glut-1.oss-cn-shenzhen.aliyuncs.com/image/0bbc7bb978074d55948abe75e4984843.gif\" alt=\"\" data-href=\"\" style=\"\"/> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<img src=\"https://glut-1.oss-cn-shenzhen.aliyuncs.com/image/0f501ea472884945850c2e7215d3bfa4.gif\" alt=\"\" data-href=\"\" style=\"width: 233.00px;height: 179.47px;\"/></p><div data-w-e-type=\"video\" data-w-e-is-void>\n<video poster=\"null\" controls=\"true\" width=\"500\" height=\"auto\"><source src=\"https://glut-1.oss-cn-shenzhen.aliyuncs.com/video/4265eca5ca6145c2b1d674106c2d2aaa.mp4\" type=\"video/mp4\"/></video>\n</div><p><br></p>', NULL, '450000', '450300', '450311', NULL, '广西壮族自治区桂林市雁山区雁山镇雁山街道319号桂林理工大学', '雁山镇雁山街道319号桂林理工大学', NULL, NULL, 5000.00, 1, NULL, 106, '2024-04-01 23:22:11', '2024-05-21 09:39:23', 0, NULL, 10, 0);
INSERT INTO `sys_house` VALUES (2, '海景房', '这是海景房', NULL, '120m²', '450000', '450300', '450305', NULL, NULL, '七星景区门口左手边50米', NULL, NULL, 800.00, 1, NULL, 25, '2024-04-01 23:22:14', '2024-05-21 09:39:18', 0, NULL, 12, 0);
INSERT INTO `sys_house` VALUES (3, '居民平房11', '这是居民平房', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 300.00, 0, NULL, 22, '2024-04-01 23:22:16', '2024-05-30 20:16:13', 0, NULL, 11, 0);
INSERT INTO `sys_house` VALUES (4, '学生公寓', '这是学生公寓', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 450.00, 0, NULL, 18, '2024-04-01 23:22:19', '2024-05-02 15:02:01', 0, NULL, 15, NULL);
INSERT INTO `sys_house` VALUES (5, '爱情公寓', '这是爱情公寓', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 800.00, 0, NULL, 19, '2024-04-01 23:22:22', '2024-05-21 09:35:33', 0, NULL, 10, 0);
INSERT INTO `sys_house` VALUES (11, '学区房|三室一厅', '靠近县中心、楼下附件有超市', '<p>hahahah<img src=\"https://glut-1.oss-cn-shenzhen.aliyuncs.com/~H67PWQCECSOQDP4DAW1I3.gif\" alt=\"\" data-href=\"\" style=\"width: 30%;\"/></p>', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 800.00, 0, NULL, 46, NULL, '2024-05-21 09:39:28', 0, NULL, 10, 0);
INSERT INTO `sys_house` VALUES (12, '学区房|两室一厅一卫生间', '靠近地铁口、离生态公园500米', '<p>1312313123😀😀😃</p>', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 600.00, 0, NULL, 904, NULL, '2024-05-21 09:39:38', 0, NULL, 10, 0);
INSERT INTO `sys_house` VALUES (13, '学区房|两室一厅一卫一阳台', '靠近工业园，采光好，附近绿化好', '<p>😍😍😍</p>', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 650.00, 0, NULL, 27, NULL, '2024-05-09 16:43:20', 0, NULL, 10, 0);
INSERT INTO `sys_house` VALUES (14, '学区房|两室一厅|近西山小学', '靠近西山小学', '<table style=\"width: auto;\"><tbody><tr><th colSpan=\"1\" rowSpan=\"1\" width=\"auto\">121231</th><th colSpan=\"1\" rowSpan=\"1\" width=\"auto\">1231231</th><th colSpan=\"1\" rowSpan=\"1\" width=\"auto\">123123</th><th colSpan=\"1\" rowSpan=\"1\" width=\"auto\">123123</th><th colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></th><th colSpan=\"1\" rowSpan=\"1\" width=\"auto\">1</th><th colSpan=\"1\" rowSpan=\"1\" width=\"auto\">11</th><th colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></th><th colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></th><th colSpan=\"1\" rowSpan=\"1\" width=\"auto\">11</th></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">1</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">1</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">111</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">11</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">11</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">1</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">11</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">1</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">1</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">1</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">1</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">1</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\">1</td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td></tr></tbody></table><p><br></p>', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 660.00, 0, NULL, 21, NULL, '2024-05-09 16:43:36', 0, NULL, 11, 0);
INSERT INTO `sys_house` VALUES (15, '学区房|两室一厅一卫生间|近平南镇四中', '靠近平南镇第四初级中学', '<div data-w-e-type=\"todo\"><input type=\"checkbox\" disabled >daibannnnnnn</div><div data-w-e-type=\"todo\"><input type=\"checkbox\" disabled >待办</div>', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 700.00, 0, NULL, 23, NULL, '2024-05-09 16:45:23', 0, NULL, 2, 0);
INSERT INTO `sys_house` VALUES (16, '学区房|两室一厅一卫生间|近平南镇镇中', '靠近平南镇镇中', '<p>😍<span style=\"background-color: rgb(225, 60, 57);\">阿三大苏打撒旦阿松大阿三啊</span></p>', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 780.00, 0, NULL, 24, NULL, '2024-05-09 16:43:06', 0, NULL, 2, 0);
INSERT INTO `sys_house` VALUES (17, '学区房|三室一厅两卫带阳台有电梯', '靠近西山生态公园，离中心广场500m', '<p><br></p>', '150m²', '450000', '450300', '450312', NULL, '广西壮族自治区桂林市临桂区临桂街道桂林市人民政府旁边临桂街道桂林市人民政府旁边', '临桂街道桂林市人民政府旁边', NULL, NULL, 600.00, 0, NULL, 21, '2024-05-10 10:54:23', '2024-05-21 09:39:09', 0, NULL, 12, 0);
INSERT INTO `sys_house` VALUES (18, '学区房|靠近桂林理工大学', '靠近桂林理工大学、通勤、接送小孩上桂工都挺方便', '<p>😀😀😀😀😊😀😀</p>', '80', '450000', '450300', '450311', NULL, '广西壮族自治区桂林市雁山区雁山街道桂林理工大学南门对面的云姨客栈雁山街道桂林理工大学南门对面的云姨客栈', '雁山街道桂林理工大学南门对面的云姨客栈', NULL, NULL, 600.00, 0, NULL, 29, '2024-05-10 13:00:07', '2024-05-21 09:35:26', 0, NULL, 2, 0);
INSERT INTO `sys_house` VALUES (74, '学区房|两室一卫一厅，101010', '这是房屋的描述', '<p>101010💩🤔</p>', '101', '450000', '450300', '450311', NULL, '广西壮族自治区桂林市雁山区广西师范大学广西师范大学广西师范大学广西师范大学广西师范大学广西师范大学', '广西师范大学', NULL, NULL, 500.00, 0, NULL, 11, '2024-05-12 14:22:00', '2024-05-21 09:34:42', 0, 1790307387427672065, 10, 0);
INSERT INTO `sys_house` VALUES (75, '学区房|两室一卫一厅，999', '这是999房屋的描述', '<p>😚999999😚</p><p style=\"text-align: center;\"><img src=\"https://glut-1.oss-cn-shenzhen.aliyuncs.com/rms/640 (7).webp\" alt=\"\" data-href=\"\" style=\"width: 30%;\"></p><p><br></p>', '99', '450000', '450800', '450803', NULL, '广西壮族自治区贵港市港南区', '1123', NULL, NULL, 501.00, 0, NULL, 1, '2024-05-12 14:22:00', '2024-05-21 09:34:52', 0, 1790306095649193985, 11, 0);
INSERT INTO `sys_house` VALUES (76, '学区房|两室一卫一厅，888', '这是房屋的描述', '<p>888😆😍</p>', '88', '410000', '410300', '410303', NULL, '河南省洛阳市西工区', '123', NULL, NULL, 502.00, 0, NULL, 7, '2024-05-12 14:22:00', '2024-05-21 09:35:02', 0, 1790306950553161730, 2, 0);
INSERT INTO `sys_house` VALUES (77, '学区房|两室一卫一厅，777', '这是房屋的描述', '<p>777😎😎</p>', '77', '460000', '460100', '460106', NULL, '海南省海口市龙华区', '77', NULL, NULL, 503.00, 0, NULL, 1, '2024-05-12 14:22:00', '2024-05-18 21:36:17', 0, 1790307346566762498, 1, 0);
INSERT INTO `sys_house` VALUES (78, '学区房|两室一卫一厅，666', '这是房屋的描述', '<p>666🙂</p>', '666', '450000', '450200', '450204', NULL, '广西壮族自治区柳州市柳南区', NULL, NULL, NULL, 504.00, 0, NULL, 0, '2024-05-12 14:22:00', '2024-05-18 21:35:18', 0, 1790307229117861889, 1, 0);
INSERT INTO `sys_house` VALUES (79, '学区房|两室一卫一厅，555', '这是房屋的描述', '<p>555</p>', '99', '450000', '450400', '450405', NULL, '广西壮族自治区梧州市长洲区', NULL, NULL, NULL, 505.00, 0, NULL, 1, '2024-05-12 14:22:00', '2024-05-18 21:36:25', 0, 1790307346566762498, 1, 0);
INSERT INTO `sys_house` VALUES (80, '学区房|两室一卫一厅，444', '这是房屋的描述', '<p>444</p>', '76', '350000', '350300', '350304', NULL, '福建省莆田市荔城区', NULL, NULL, NULL, 506.00, 0, NULL, 0, '2024-05-12 14:22:00', '2024-05-18 21:36:29', 0, NULL, 1, 0);
INSERT INTO `sys_house` VALUES (81, '学区房|两室一卫一厅，333', '这是房屋的描述', '<p>333</p>', '88', '230000', '230300', '230302', NULL, '黑龙江省鸡西市鸡冠区null', NULL, NULL, NULL, 507.00, 0, NULL, 1, '2024-05-12 14:22:00', '2024-05-13 14:26:46', 1, NULL, 1, 0);
INSERT INTO `sys_house` VALUES (82, '学区房|两室一卫一厅，222', '这是房屋的描述', '<p>222</p>', '100', '150000', '150300', '150302', NULL, '内蒙古自治区乌海市海勃湾区null', NULL, NULL, NULL, 508.00, 0, NULL, 3, '2024-05-12 14:22:00', '2024-05-13 14:22:57', 1, NULL, 1, 0);
INSERT INTO `sys_house` VALUES (83, '学区房|两室一卫一厅，111', '这是房屋的描述', '<p>111</p>', '100', '210000', '210300', '210301', NULL, '辽宁省鞍山市市辖区null', NULL, NULL, NULL, 509.00, 0, NULL, 1, '2024-05-12 14:22:00', '2024-05-21 09:38:55', 0, NULL, 12, 0);
INSERT INTO `sys_house` VALUES (84, '学区房|000', '这是房屋的描述', '<p>000</p>', '70', '450000', '450300', '450301', NULL, '广西壮族自治区桂林市市辖区nullnull', NULL, NULL, NULL, 510.00, 0, NULL, 2, '2024-05-12 14:22:00', '2024-05-21 09:39:02', 0, NULL, 12, 0);
INSERT INTO `sys_house` VALUES (89, '测试房屋', '测试房屋', '<p>😀😀<img src=\"https://glut-1.oss-cn-shenzhen.aliyuncs.com/rms/640 (1).gif\" alt=\"\" data-href=\"\" style=\"width: 30%;\"/></p><div data-w-e-type=\"video\" data-w-e-is-void>\n<video poster=\"\" controls=\"true\" width=\"auto\" height=\"300\"><source src=\"https://glut-1.oss-cn-shenzhen.aliyuncs.com/rms/2024-03-06 17.46.05_我呢_永远明媚_分享照片_video.mp4\" type=\"video/mp4\"/></video>\n</div><p><br></p>', NULL, '450000', '450300', '450311', NULL, '广西壮族自治区桂林市雁山区桂林理工大学桂林理工大学', '桂林理工大学', NULL, NULL, 600.00, 0, NULL, 8, '2024-05-15 22:43:44', '2024-05-17 10:30:28', 0, 1790306950553161730, 2, 0);
INSERT INTO `sys_house` VALUES (90, '学区房|批量导入111', '这是房屋的描述111', '<h3 style=\"text-align: center;\"><span style=\"color: rgb(231, 95, 51);\"><strong>欢迎来到平南镇中学</strong></span></h3><p style=\"text-align: center;\">看个美女</p><div data-w-e-type=\"video\" data-w-e-is-void>\n<video poster=\"\" controls=\"true\" width=\"auto\" height=\"300\"><source src=\"https://glut-1.oss-cn-shenzhen.aliyuncs.com/rms/a8357002d17c4234a6f451285296f152_13360067189693499.mp4\" type=\"video/mp4\"/></video>\n</div><p><br></p>', '1000', '450000', '450800', '450821', NULL, '广西壮族自治区贵港市平南县', '平南镇中学', NULL, NULL, 700.00, 0, NULL, 3, '2024-05-22 21:56:20', '2024-05-30 20:11:40', 0, 1790307387427672065, 14, 0);
INSERT INTO `sys_house` VALUES (91, '学区房|批量导入222', '这是房屋的描述222', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 800.00, 0, NULL, 0, '2024-05-22 21:56:20', '2024-05-26 20:42:03', 0, NULL, 12, 0);
INSERT INTO `sys_house` VALUES (92, '学区房|批量导入333', '这是房屋的描述333', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 900.00, 0, NULL, 0, '2024-05-22 21:56:20', NULL, 0, NULL, 12, NULL);
INSERT INTO `sys_house` VALUES (93, '学区房|批量导入444', '这是房屋的描述444', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1000.00, 0, NULL, 0, '2024-05-22 21:56:20', NULL, 0, NULL, 12, NULL);
INSERT INTO `sys_house` VALUES (94, '学区房|批量导入555', '这是房屋的描述555', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1100.00, 0, NULL, 0, '2024-05-22 21:56:20', NULL, 0, NULL, 12, NULL);
INSERT INTO `sys_house` VALUES (95, '学区房|批量导入666', '这是房屋的描述666', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1200.00, 0, NULL, 1, '2024-05-22 21:56:21', '2024-05-26 20:41:50', 0, NULL, 12, 0);
INSERT INTO `sys_house` VALUES (96, '学区房|批量导入777', '这是房屋的描述777', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1300.00, 0, NULL, 11, '2024-05-22 21:56:21', '2024-05-26 20:41:44', 0, NULL, 12, 0);
INSERT INTO `sys_house` VALUES (97, '学区房|批量导入888', '这是房屋的描述888', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1400.00, 0, NULL, 1, '2024-05-22 21:56:21', '2024-05-26 20:41:36', 0, NULL, 12, 0);
INSERT INTO `sys_house` VALUES (98, '学区房|批量导入999', '这是房屋的描述999', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1500.00, 0, NULL, 4, '2024-05-22 21:56:21', '2024-05-26 20:41:27', 0, NULL, 12, 0);

-- ----------------------------
-- Table structure for sys_house_live_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_house_live_type`;
CREATE TABLE `sys_house_live_type`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '租住方式',
  `create_time` datetime NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_house_live_type
-- ----------------------------

-- ----------------------------
-- Table structure for sys_house_room
-- ----------------------------
DROP TABLE IF EXISTS `sys_house_room`;
CREATE TABLE `sys_house_room`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '厅室',
  `create_time` datetime NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_house_room
-- ----------------------------

-- ----------------------------
-- Table structure for sys_house_show
-- ----------------------------
DROP TABLE IF EXISTS `sys_house_show`;
CREATE TABLE `sys_house_show`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '链接',
  `house_id` bigint NULL DEFAULT NULL COMMENT '房屋id',
  `create_time` datetime NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 50 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_house_show
-- ----------------------------
INSERT INTO `sys_house_show` VALUES (6, 'https://glut-1.oss-cn-shenzhen.aliyuncs.com/image/b4dba0f86d22493382d8883a32e1d20e.gif', 1, NULL, NULL);
INSERT INTO `sys_house_show` VALUES (7, 'https://glut-1.oss-cn-shenzhen.aliyuncs.com/image/f9dc9a908083419e835d228dee05b5e3.gif', 1, NULL, NULL);
INSERT INTO `sys_house_show` VALUES (8, 'https://glut-1.oss-cn-shenzhen.aliyuncs.com/image/54c88be4607347c1ac5d233f786ad0fe.gif', 1, NULL, NULL);
INSERT INTO `sys_house_show` VALUES (9, 'https://glut-1.oss-cn-shenzhen.aliyuncs.com/image/ade3199c538d4b31aca85c422e9663a6.jpg', 3, NULL, NULL);
INSERT INTO `sys_house_show` VALUES (11, 'https://glut-1.oss-cn-shenzhen.aliyuncs.com/image/fa9904a3e714460b8bea532709b00054.png', 2, NULL, NULL);
INSERT INTO `sys_house_show` VALUES (12, 'https://glut-1.oss-cn-shenzhen.aliyuncs.com/image/44baa430935f4d53838a3637b5ca7fae.gif', 4, NULL, NULL);
INSERT INTO `sys_house_show` VALUES (13, 'https://glut-1.oss-cn-shenzhen.aliyuncs.com/image/2791f0a73d0f4d4ba61576a7961fbec5.gif', 4, NULL, NULL);
INSERT INTO `sys_house_show` VALUES (14, 'https://glut-1.oss-cn-shenzhen.aliyuncs.com/image/b9586b1551a04706830fffe7e93f22d6.gif', 5, NULL, NULL);
INSERT INTO `sys_house_show` VALUES (15, 'https://glut-1.oss-cn-shenzhen.aliyuncs.com/image/3b2511b0237a480ba7f8f7881a92898e.gif', 5, NULL, NULL);
INSERT INTO `sys_house_show` VALUES (17, 'https://glut-1.oss-cn-shenzhen.aliyuncs.com/image/daee3f470469402b8672e7fbffb0f86a.gif', 2, NULL, NULL);
INSERT INTO `sys_house_show` VALUES (18, 'https://glut-1.oss-cn-shenzhen.aliyuncs.com/~H67PWQCECSOQDP4DAW1I3.gif', 11, NULL, NULL);
INSERT INTO `sys_house_show` VALUES (19, 'https://glut-1.oss-cn-shenzhen.aliyuncs.com/640 (13).gif', 12, NULL, NULL);
INSERT INTO `sys_house_show` VALUES (20, 'https://glut-1.oss-cn-shenzhen.aliyuncs.com/QQ图片20240508204633.gif', 16, NULL, NULL);
INSERT INTO `sys_house_show` VALUES (21, 'https://glut-1.oss-cn-shenzhen.aliyuncs.com/QQ图片20240508204502.jpg', 13, NULL, NULL);
INSERT INTO `sys_house_show` VALUES (22, 'https://glut-1.oss-cn-shenzhen.aliyuncs.com/QQ图片20240509150359.gif', 14, NULL, NULL);
INSERT INTO `sys_house_show` VALUES (23, 'https://glut-1.oss-cn-shenzhen.aliyuncs.com/QQ图片20240509164105.gif', 15, NULL, NULL);
INSERT INTO `sys_house_show` VALUES (26, 'https://glut-1.oss-cn-shenzhen.aliyuncs.com/rms/QQ图片20240508204724.gif', 17, NULL, NULL);
INSERT INTO `sys_house_show` VALUES (27, 'https://glut-1.oss-cn-shenzhen.aliyuncs.com/rms/640 (18).gif', 18, NULL, NULL);
INSERT INTO `sys_house_show` VALUES (28, 'https://glut-1.oss-cn-shenzhen.aliyuncs.com/rms/13360054635431209.jpeg', 84, NULL, NULL);
INSERT INTO `sys_house_show` VALUES (29, 'https://glut-1.oss-cn-shenzhen.aliyuncs.com/rms/13360054640833717.jpeg', 83, NULL, NULL);
INSERT INTO `sys_house_show` VALUES (30, 'https://glut-1.oss-cn-shenzhen.aliyuncs.com/rms/13360054642096572.jpeg', 82, NULL, NULL);
INSERT INTO `sys_house_show` VALUES (31, 'https://glut-1.oss-cn-shenzhen.aliyuncs.com/rms/13360054645673554.jpeg', 81, NULL, NULL);
INSERT INTO `sys_house_show` VALUES (32, 'https://glut-1.oss-cn-shenzhen.aliyuncs.com/rms/13360054647714386.jpeg', 80, NULL, NULL);
INSERT INTO `sys_house_show` VALUES (33, 'https://glut-1.oss-cn-shenzhen.aliyuncs.com/rms/13360054649916648.jpeg', 79, NULL, NULL);
INSERT INTO `sys_house_show` VALUES (34, 'https://glut-1.oss-cn-shenzhen.aliyuncs.com/rms/13360054652302639.jpeg', 78, NULL, NULL);
INSERT INTO `sys_house_show` VALUES (35, 'https://glut-1.oss-cn-shenzhen.aliyuncs.com/rms/13360054655033618.jpeg', 77, NULL, NULL);
INSERT INTO `sys_house_show` VALUES (36, 'https://glut-1.oss-cn-shenzhen.aliyuncs.com/rms/13360054656908257.jpeg', 76, NULL, NULL);
INSERT INTO `sys_house_show` VALUES (37, 'https://glut-1.oss-cn-shenzhen.aliyuncs.com/rms/13360054660134506.jpeg', 75, NULL, NULL);
INSERT INTO `sys_house_show` VALUES (38, 'https://glut-1.oss-cn-shenzhen.aliyuncs.com/rms/13360054662577535.jpeg', 74, NULL, NULL);
INSERT INTO `sys_house_show` VALUES (39, 'https://glut-1.oss-cn-shenzhen.aliyuncs.com/rms/13360054635431209.jpeg', 89, NULL, NULL);
INSERT INTO `sys_house_show` VALUES (40, 'https://glut-1.oss-cn-shenzhen.aliyuncs.com/rms/13360054640833717.jpeg', 89, NULL, NULL);
INSERT INTO `sys_house_show` VALUES (44, 'https://glut-1.oss-cn-shenzhen.aliyuncs.com/rms/311.jpg', 98, NULL, NULL);
INSERT INTO `sys_house_show` VALUES (45, 'https://glut-1.oss-cn-shenzhen.aliyuncs.com/rms/1.jpg', 97, NULL, NULL);
INSERT INTO `sys_house_show` VALUES (46, 'https://glut-1.oss-cn-shenzhen.aliyuncs.com/rms/2.jpg', 96, NULL, NULL);
INSERT INTO `sys_house_show` VALUES (47, 'https://glut-1.oss-cn-shenzhen.aliyuncs.com/rms/3.jpg', 95, NULL, NULL);
INSERT INTO `sys_house_show` VALUES (48, 'https://glut-1.oss-cn-shenzhen.aliyuncs.com/rms/5.jpg', 91, NULL, NULL);
INSERT INTO `sys_house_show` VALUES (49, 'https://glut-1.oss-cn-shenzhen.aliyuncs.com/rms/3feed8d1747545428ce4da418ff9fa41_IMG_20230120_160246.jpg', 90, NULL, NULL);

-- ----------------------------
-- Table structure for sys_house_show_video
-- ----------------------------
DROP TABLE IF EXISTS `sys_house_show_video`;
CREATE TABLE `sys_house_show_video`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `house_id` bigint NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_house_show_video
-- ----------------------------
INSERT INTO `sys_house_show_video` VALUES (4, 'https://glut-1.oss-cn-shenzhen.aliyuncs.com/video/10edd8dec72b4ba4925c76563956b38d.mp4', 4, NULL, NULL);
INSERT INTO `sys_house_show_video` VALUES (6, 'https://glut-1.oss-cn-shenzhen.aliyuncs.com/video/968c8b5d861845508293bdd5a4774a47.mp4', 1, NULL, NULL);
INSERT INTO `sys_house_show_video` VALUES (7, 'https://glut-1.oss-cn-shenzhen.aliyuncs.com/video/4a148c1b7d8e45ecb6d6f0edf68709c4.mp4', NULL, NULL, NULL);
INSERT INTO `sys_house_show_video` VALUES (10, 'https://glut-1.oss-cn-shenzhen.aliyuncs.com/video/34adc7892c7d4daa8c3029eb1fb357ec.mp4', 2, NULL, NULL);
INSERT INTO `sys_house_show_video` VALUES (11, 'https://glut-1.oss-cn-shenzhen.aliyuncs.com/rms/2023-11-07 14.15.16_秋天_video.mp4', 89, NULL, NULL);
INSERT INTO `sys_house_show_video` VALUES (12, 'https://glut-1.oss-cn-shenzhen.aliyuncs.com/rms/70d8fd849529449caa0d207e2afe95a3_2024-03-16 21.16.22_风轻轻我听见你声音_video.mp4', 3, NULL, NULL);

-- ----------------------------
-- Table structure for sys_house_towards
-- ----------------------------
DROP TABLE IF EXISTS `sys_house_towards`;
CREATE TABLE `sys_house_towards`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '朝向',
  `create_time` datetime NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_house_towards
-- ----------------------------

-- ----------------------------
-- Table structure for sys_house_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_house_type`;
CREATE TABLE `sys_house_type`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '类型名称',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '描述',
  `create_time` datetime NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1790307534337363970 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_house_type
-- ----------------------------
INSERT INTO `sys_house_type` VALUES (1790306095649193985, '住宅小区', '通常是由多层或高层住宅楼组成的社区，配备了绿化、公共设施等，是较常见的租赁房源类型。', '2024-05-14 17:00:10', '2024-05-14 17:03:12');
INSERT INTO `sys_house_type` VALUES (1790306950553161730, '长租公寓', '这是近年来兴起的一种租赁方式，通常由专业的运营商管理，提供高品质的居住环境和服务。长租公寓包含了酒店式公寓、分散式长租公寓（小区房改建）和集中式长租公寓（民房改建）等。', '2024-05-14 17:03:34', NULL);
INSERT INTO `sys_house_type` VALUES (1790307052848041985, '独栋', '也称为别墅或独栋住宅，是一栋完整的房屋，通常有自己的花园或院子，并且与其他房屋相互独立。', '2024-05-14 17:03:58', NULL);
INSERT INTO `sys_house_type` VALUES (1790307154408919042, '公寓式酒店', '提供类似酒店服务的长期住宿场所，通常配有家具、厨房设备、清洁服务等。', '2024-05-14 17:04:23', NULL);
INSERT INTO `sys_house_type` VALUES (1790307229117861889, '复式公寓', '一种分为两层的公寓，通常楼下为起居区和厨房，楼上为卧室区。', '2024-05-14 17:04:40', NULL);
INSERT INTO `sys_house_type` VALUES (1790307291013206018, 'Loft', '一种较为开放的居住空间，通常位于工业区或改造过的仓库，拥有高天花板和大面积的空间。', '2024-05-14 17:04:55', NULL);
INSERT INTO `sys_house_type` VALUES (1790307346566762498, '共享房屋', '多个租客共享同一栋房屋的不同区域，例如共享厨房、客厅等，通常出租给学生或年轻专业人士。', '2024-05-14 17:05:08', NULL);
INSERT INTO `sys_house_type` VALUES (1790307387427672065, '学生公寓', '专为学生设计的住宿场所，通常位于大学校园附近或者城市中心，提供简单的住宿设施和服务。', '2024-05-14 17:05:18', NULL);

-- ----------------------------
-- Table structure for sys_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_log`;
CREATE TABLE `sys_log`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `operate_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '操作名称',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '日志',
  `create_time` datetime NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户名称',
  `ip` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '登录的ip地址',
  `uri` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '请求接口',
  `method` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '请求方式',
  `method_description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '描述',
  `params` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '参数',
  `browser` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '浏览器类型',
  `user_id` bigint NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 217 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_log
-- ----------------------------
INSERT INTO `sys_log` VALUES (9, '用户登录', NULL, '2024-05-01 11:17:44', NULL, '租户-兰花', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, 17);
INSERT INTO `sys_log` VALUES (10, '删除用户', NULL, '2024-05-13 12:03:41', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (11, '用户登录', NULL, '2024-05-01 12:07:38', NULL, '租户-梅兰竹菊', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, 16);
INSERT INTO `sys_log` VALUES (12, '用户登录', NULL, '2024-05-01 12:07:44', NULL, '租户-梅兰竹菊', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, 16);
INSERT INTO `sys_log` VALUES (13, '用户登录', NULL, '2024-05-02 12:53:50', NULL, '房东-广州', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (14, '用户登录', NULL, '2024-05-02 13:07:52', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO `sys_log` VALUES (15, '用户登录', NULL, '2024-05-04 13:53:41', NULL, '租户-0505', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, 28);
INSERT INTO `sys_log` VALUES (16, '用户登录', NULL, '2024-05-05 13:54:30', NULL, '租户-0506', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, 29);
INSERT INTO `sys_log` VALUES (17, '修改商品', NULL, '2024-05-13 14:21:52', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (18, '修改商品', NULL, '2024-05-13 14:22:41', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (19, '修改商品', NULL, '2024-05-13 14:22:57', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (20, '修改商品', NULL, '2024-05-13 14:23:15', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (21, '修改商品', NULL, '2024-05-13 14:26:46', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (22, '修改商品', NULL, '2024-05-13 14:27:25', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (23, '修改商品', NULL, '2024-05-13 14:27:56', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (24, '修改商品', NULL, '2024-05-13 14:28:16', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (25, '修改商品', NULL, '2024-05-13 14:28:59', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (26, '修改商品', NULL, '2024-05-13 14:29:38', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (27, '修改商品', NULL, '2024-05-13 14:29:39', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (28, '修改商品', NULL, '2024-05-13 14:31:14', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (29, '修改商品', NULL, '2024-05-13 14:32:17', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (30, '用户登录', NULL, '2024-05-09 14:37:42', NULL, '租户-梅兰竹菊', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, 16);
INSERT INTO `sys_log` VALUES (31, '用户登录', NULL, '2024-05-09 14:37:55', NULL, '租户-梅兰竹菊', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, 16);
INSERT INTO `sys_log` VALUES (32, '用户登录', NULL, '2024-05-13 15:20:10', NULL, '租户-0506', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, 29);
INSERT INTO `sys_log` VALUES (33, '用户登录', NULL, '2024-05-13 15:20:54', NULL, '租户-0507', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, 30);
INSERT INTO `sys_log` VALUES (34, '用户登录', NULL, '2024-05-13 15:21:28', NULL, '租户-0508', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, 31);
INSERT INTO `sys_log` VALUES (35, '更新用户信息', NULL, '2024-05-14 00:02:10', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (36, '更新用户信息', NULL, '2024-05-14 00:03:34', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (37, '更新用户信息', NULL, '2024-05-14 00:03:50', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (38, '更新用户信息', NULL, '2024-05-14 00:04:10', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (39, '更新用户信息', NULL, '2024-05-14 00:04:17', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (40, '用户登录', NULL, '2024-05-14 08:45:35', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO `sys_log` VALUES (41, '用户登录', NULL, '2024-05-14 12:13:20', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO `sys_log` VALUES (43, '用户登录', NULL, '2024-05-14 14:28:05', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO `sys_log` VALUES (44, '用户登录', NULL, '2024-05-14 14:28:11', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO `sys_log` VALUES (46, '更新用户信息', NULL, '2024-05-14 15:10:20', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (47, '更新用户信息', NULL, '2024-05-14 15:10:22', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (48, '更新用户信息', NULL, '2024-05-14 15:10:23', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (49, '更新用户信息', NULL, '2024-05-14 15:10:23', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (50, '更新用户信息', NULL, '2024-05-14 15:10:23', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (51, '更新用户信息', NULL, '2024-05-14 15:10:23', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (52, '更新用户信息', NULL, '2024-05-14 15:10:23', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (53, '更新用户信息', NULL, '2024-05-14 15:10:23', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (54, '更新用户信息', NULL, '2024-05-14 15:10:24', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (55, '更新用户信息', NULL, '2024-05-14 15:10:24', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (56, '更新用户信息', NULL, '2024-05-14 15:10:24', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (58, '用户登录', NULL, '2024-05-14 15:43:58', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO `sys_log` VALUES (59, '删除用户', NULL, '2024-05-14 15:44:08', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (61, '用户登录', NULL, '2024-05-14 15:53:56', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO `sys_log` VALUES (62, '删除用户', NULL, '2024-05-14 15:54:15', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (63, '修改商品', NULL, '2024-05-14 21:17:19', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (64, '修改商品', NULL, '2024-05-14 21:20:23', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (65, '修改商品', NULL, '2024-05-14 22:37:11', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (66, '修改商品', NULL, '2024-05-14 22:37:26', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (67, '修改商品', NULL, '2024-05-14 22:37:50', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (68, '修改商品', NULL, '2024-05-14 22:37:55', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (69, '修改商品', NULL, '2024-05-14 22:38:01', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (70, '修改商品', NULL, '2024-05-14 22:38:05', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (71, '用户登录', NULL, '2024-05-14 22:39:37', NULL, '租户-梅兰竹菊', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, 16);
INSERT INTO `sys_log` VALUES (72, '删除用户', NULL, '2024-05-15 00:02:50', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (73, '用户登录', NULL, '2024-05-15 19:04:18', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO `sys_log` VALUES (74, '用户登录', NULL, '2024-05-15 22:13:21', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO `sys_log` VALUES (75, '用户登录', NULL, '2024-05-15 22:13:28', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO `sys_log` VALUES (76, '更新用户信息', NULL, '2024-05-15 22:37:52', NULL, '租户-梅兰竹菊', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (77, '更新用户信息', NULL, '2024-05-15 22:41:02', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (78, '用户登录', NULL, '2024-05-15 22:41:51', NULL, '房东-广州', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (79, '用户登录', NULL, '2024-05-15 22:41:58', NULL, '房东-广州', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (80, '新增商品', NULL, '2024-05-15 22:43:44', NULL, '房东-广州', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (81, '修改商品', NULL, '2024-05-15 22:44:50', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (82, '修改商品', NULL, '2024-05-15 22:45:05', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (83, '用户登录', NULL, '2024-05-16 15:34:07', NULL, '啾啾', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, 55);
INSERT INTO `sys_log` VALUES (84, '用户登录', NULL, '2024-05-16 15:34:15', NULL, '啾啾', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, 55);
INSERT INTO `sys_log` VALUES (85, '更新用户信息', NULL, '2024-05-16 15:35:04', NULL, '啾啾', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (86, '用户登录', NULL, '2024-05-16 23:06:42', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO `sys_log` VALUES (87, '更新用户信息', NULL, '2024-05-16 23:06:52', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (88, '用户登录', NULL, '2024-05-17 10:07:06', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO `sys_log` VALUES (89, '用户登录', NULL, '2024-05-17 10:07:13', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO `sys_log` VALUES (90, '修改商品', NULL, '2024-05-17 10:30:28', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (91, '用户登录', NULL, '2024-05-17 11:16:56', NULL, '租户-梅兰竹菊', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, 16);
INSERT INTO `sys_log` VALUES (92, '用户登录', NULL, '2024-05-17 12:54:55', NULL, '房东-广州', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (93, '用户登录', NULL, '2024-05-18 19:51:56', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO `sys_log` VALUES (94, '修改商品', NULL, '2024-05-18 20:45:41', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (95, '修改商品', NULL, '2024-05-18 20:45:51', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (96, '修改商品', NULL, '2024-05-18 20:45:58', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (97, '修改商品', NULL, '2024-05-18 21:31:28', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (98, '修改商品', NULL, '2024-05-18 21:32:46', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (99, '修改商品', NULL, '2024-05-18 21:32:49', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (100, '修改商品', NULL, '2024-05-18 21:32:59', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (101, '修改商品', NULL, '2024-05-18 21:33:04', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (102, '修改商品', NULL, '2024-05-18 21:33:22', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (103, '修改商品', NULL, '2024-05-18 21:33:27', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (104, '修改商品', NULL, '2024-05-18 21:35:18', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (105, '修改商品', NULL, '2024-05-18 21:36:17', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (106, '修改商品', NULL, '2024-05-18 21:36:25', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (107, '修改商品', NULL, '2024-05-18 21:36:29', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (108, '用户登录', NULL, '2024-05-18 23:21:49', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO `sys_log` VALUES (109, '用户登录', NULL, '2024-05-18 23:27:46', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO `sys_log` VALUES (110, '用户登录', NULL, '2024-05-18 23:34:21', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO `sys_log` VALUES (111, '用户登录', NULL, '2024-05-18 23:34:42', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO `sys_log` VALUES (112, '用户登录', NULL, '2024-05-18 23:34:58', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO `sys_log` VALUES (113, '用户登录', NULL, '2024-05-18 23:37:22', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO `sys_log` VALUES (114, '用户登录', NULL, '2024-05-18 23:38:15', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO `sys_log` VALUES (115, '用户登录', NULL, '2024-05-18 23:42:52', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO `sys_log` VALUES (116, '用户登录', NULL, '2024-05-18 23:43:01', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO `sys_log` VALUES (117, '用户登录', NULL, '2024-05-18 23:45:05', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO `sys_log` VALUES (118, '用户登录', NULL, '2024-05-19 00:12:02', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO `sys_log` VALUES (119, '用户登录', NULL, '2024-05-19 00:12:09', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO `sys_log` VALUES (120, '用户登录', NULL, '2024-05-19 00:15:44', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO `sys_log` VALUES (121, '用户登录', NULL, '2024-05-19 00:21:29', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO `sys_log` VALUES (122, '用户登录', NULL, '2024-05-19 00:22:20', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO `sys_log` VALUES (123, '用户登录', NULL, '2024-05-19 09:57:54', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO `sys_log` VALUES (124, '用户登录', NULL, '2024-05-19 10:03:18', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO `sys_log` VALUES (125, '用户登录', NULL, '2024-05-19 10:03:25', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO `sys_log` VALUES (126, '用户登录', NULL, '2024-05-19 10:04:10', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO `sys_log` VALUES (127, '用户登录', NULL, '2024-05-19 19:18:55', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO `sys_log` VALUES (128, '用户登录', NULL, '2024-05-19 19:19:48', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO `sys_log` VALUES (129, '用户登录', NULL, '2024-05-19 21:10:09', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO `sys_log` VALUES (130, '用户登录', NULL, '2024-05-19 21:10:15', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO `sys_log` VALUES (132, '删除用户', NULL, '2024-05-19 21:11:36', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (133, '用户登录', NULL, '2024-05-19 21:12:51', NULL, '租户-梅兰竹菊', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, 16);
INSERT INTO `sys_log` VALUES (134, '用户登录', NULL, '2024-05-19 21:20:05', NULL, '租户-梅兰竹菊', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, 16);
INSERT INTO `sys_log` VALUES (135, '用户登录', NULL, '2024-05-19 21:20:10', NULL, '租户-梅兰竹菊', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, 16);
INSERT INTO `sys_log` VALUES (137, '更新用户信息', NULL, '2024-05-19 21:21:43', NULL, '两人', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (138, '删除用户', NULL, '2024-05-19 21:23:20', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (139, '用户登录', NULL, '2024-05-19 21:51:52', NULL, '租户-梅兰竹菊', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, 16);
INSERT INTO `sys_log` VALUES (140, '用户登录', NULL, '2024-05-20 20:38:09', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO `sys_log` VALUES (141, '用户登录', NULL, '2024-05-21 09:31:36', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO `sys_log` VALUES (142, '用户登录', NULL, '2024-05-21 09:31:51', NULL, '房东-广州', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (143, '用户登录', NULL, '2024-05-21 09:34:08', NULL, '租户-梅兰竹菊', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, 16);
INSERT INTO `sys_log` VALUES (144, '修改商品', NULL, '2024-05-21 09:34:41', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (145, '修改商品', NULL, '2024-05-21 09:34:42', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (146, '修改商品', NULL, '2024-05-21 09:34:52', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (147, '修改商品', NULL, '2024-05-21 09:35:02', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (148, '修改商品', NULL, '2024-05-21 09:35:26', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (149, '修改商品', NULL, '2024-05-21 09:35:33', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (150, '更新用户信息', NULL, '2024-05-21 09:37:03', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (151, '更新用户信息', NULL, '2024-05-21 09:37:21', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (152, '更新用户信息', NULL, '2024-05-21 09:37:31', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (153, '更新用户信息', NULL, '2024-05-21 09:37:57', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (154, '更新用户信息', NULL, '2024-05-21 09:38:07', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (155, '修改商品', NULL, '2024-05-21 09:38:55', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (156, '修改商品', NULL, '2024-05-21 09:39:02', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (157, '修改商品', NULL, '2024-05-21 09:39:09', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (158, '修改商品', NULL, '2024-05-21 09:39:18', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (159, '修改商品', NULL, '2024-05-21 09:39:23', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (160, '修改商品', NULL, '2024-05-21 09:39:28', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (161, '修改商品', NULL, '2024-05-21 09:39:38', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (162, '用户登录', NULL, '2024-05-21 14:29:56', NULL, '租户-梅兰竹菊', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, 16);
INSERT INTO `sys_log` VALUES (163, '用户登录', NULL, '2024-05-21 18:40:44', NULL, '房东-广州', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (164, '用户登录', NULL, '2024-05-21 21:47:49', NULL, '房东-桂林', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, 12);
INSERT INTO `sys_log` VALUES (165, '用户登录', NULL, '2024-05-21 21:48:40', NULL, '房东-百色', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, 15);
INSERT INTO `sys_log` VALUES (166, '用户登录', NULL, '2024-05-22 10:24:46', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO `sys_log` VALUES (167, '用户登录', NULL, '2024-05-22 10:25:52', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO `sys_log` VALUES (168, '用户登录', NULL, '2024-05-22 10:26:53', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO `sys_log` VALUES (169, '用户登录', NULL, '2024-05-22 10:37:33', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO `sys_log` VALUES (170, '用户登录', NULL, '2024-05-22 12:40:52', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO `sys_log` VALUES (171, '用户登录', NULL, '2024-05-22 12:40:58', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO `sys_log` VALUES (172, '用户登录', NULL, '2024-05-22 12:43:05', NULL, '房东-广州', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (173, '用户登录', NULL, '2024-05-22 13:00:40', NULL, '啾啾', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, 55);
INSERT INTO `sys_log` VALUES (174, '用户登录', NULL, '2024-05-22 13:01:17', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO `sys_log` VALUES (175, '用户登录', NULL, '2024-05-22 13:32:53', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO `sys_log` VALUES (176, '用户登录', NULL, '2024-05-22 13:40:32', NULL, '房东-贵港', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, 14);
INSERT INTO `sys_log` VALUES (177, '用户登录', NULL, '2024-05-22 19:43:46', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO `sys_log` VALUES (178, '用户登录', NULL, '2024-05-22 21:12:55', NULL, '租户-梅兰竹菊', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, 16);
INSERT INTO `sys_log` VALUES (179, '用户登录', NULL, '2024-05-22 21:26:28', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO `sys_log` VALUES (180, '用户登录', NULL, '2024-05-22 21:26:40', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO `sys_log` VALUES (181, '用户登录', NULL, '2024-05-22 21:47:59', NULL, '房东-桂林', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, 12);
INSERT INTO `sys_log` VALUES (182, '新增商品', NULL, '2024-05-22 21:56:20', NULL, '房东-桂林', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (183, '新增商品', NULL, '2024-05-22 21:56:20', NULL, '房东-桂林', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (184, '新增商品', NULL, '2024-05-22 21:56:20', NULL, '房东-桂林', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (185, '新增商品', NULL, '2024-05-22 21:56:20', NULL, '房东-桂林', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (186, '新增商品', NULL, '2024-05-22 21:56:20', NULL, '房东-桂林', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (187, '新增商品', NULL, '2024-05-22 21:56:21', NULL, '房东-桂林', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (188, '新增商品', NULL, '2024-05-22 21:56:21', NULL, '房东-桂林', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (189, '新增商品', NULL, '2024-05-22 21:56:21', NULL, '房东-桂林', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (190, '新增商品', NULL, '2024-05-22 21:56:21', NULL, '房东-桂林', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (191, '用户登录', NULL, '2024-05-24 16:42:00', NULL, '两人', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, 57);
INSERT INTO `sys_log` VALUES (192, '用户登录', NULL, '2024-05-24 16:52:00', NULL, '啾啾', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, 55);
INSERT INTO `sys_log` VALUES (193, '用户登录', NULL, '2024-05-24 16:52:20', NULL, '两人', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, 57);
INSERT INTO `sys_log` VALUES (194, '用户登录', NULL, '2024-05-24 20:18:25', NULL, '租户-梅兰竹菊', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, 16);
INSERT INTO `sys_log` VALUES (195, '用户登录', NULL, '2024-05-25 10:27:07', NULL, '租户-0506', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, 29);
INSERT INTO `sys_log` VALUES (196, '用户登录', NULL, '2024-05-25 10:55:53', NULL, '租户-0506', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, 29);
INSERT INTO `sys_log` VALUES (197, '用户登录', NULL, '2024-05-25 10:56:42', NULL, '租户-0501', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, 24);
INSERT INTO `sys_log` VALUES (198, '用户登录', NULL, '2024-05-25 11:27:50', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO `sys_log` VALUES (199, '修改商品', NULL, '2024-05-26 19:30:26', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (200, '修改商品', NULL, '2024-05-26 19:30:40', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (201, '修改商品', NULL, '2024-05-26 19:31:14', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (202, '修改商品', NULL, '2024-05-26 20:41:27', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (203, '修改商品', NULL, '2024-05-26 20:41:36', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (204, '修改商品', NULL, '2024-05-26 20:41:44', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (205, '修改商品', NULL, '2024-05-26 20:41:50', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (206, '修改商品', NULL, '2024-05-26 20:42:03', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (207, '用户登录', NULL, '2024-05-27 10:26:10', NULL, '房东-桂林', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, 12);
INSERT INTO `sys_log` VALUES (208, '用户登录', NULL, '2024-05-27 21:11:59', NULL, '房东-柳州', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, 13);
INSERT INTO `sys_log` VALUES (209, '用户登录', NULL, '2024-05-27 21:42:10', NULL, '房东-贵港', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, 14);
INSERT INTO `sys_log` VALUES (210, '用户登录', NULL, '2024-05-27 21:42:44', NULL, '房东-广州', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, 2);
INSERT INTO `sys_log` VALUES (211, '用户登录', NULL, '2024-05-27 21:43:01', NULL, '房东-桂林', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, 12);
INSERT INTO `sys_log` VALUES (212, '更新用户信息', NULL, '2024-05-28 11:18:10', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (213, '用户登录', NULL, '2024-05-28 11:18:44', NULL, '房东-南宁', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, 10);
INSERT INTO `sys_log` VALUES (214, '删除用户', NULL, '2024-05-28 17:08:22', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (215, '用户登录', NULL, '2024-05-29 08:07:03', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO `sys_log` VALUES (216, '修改商品', NULL, '2024-05-30 20:11:40', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES (217, '修改商品', NULL, '2024-05-30 20:16:13', NULL, 'admin', '0:0:0:0:0:0:0:1', NULL, NULL, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `parent_id` bigint NULL DEFAULT NULL COMMENT '父菜单ID，一级菜单为0',
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '菜单名称',
  `path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '菜单URL',
  `perms` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '授权（多个用逗号分隔，如：user:list,user:create）',
  `component` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '组成',
  `type` int NOT NULL COMMENT '类型 0：目录  1：菜单  2：按钮',
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '菜单图标',
  `order_num` int NULL DEFAULT NULL COMMENT '排序',
  `created` datetime NOT NULL COMMENT '创建时间',
  `updated` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `statu` int NOT NULL DEFAULT 1 COMMENT '状态  1：正常     0：禁用',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 30 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '菜单表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, 0, '系统管理', NULL, 'sys:manage', NULL, 0, 'Setting', 1, '2024-03-25 21:28:45', '2024-03-25 21:28:48', 1);
INSERT INTO `sys_menu` VALUES (2, 1, '用户管理', '/sys/users', 'sys:user:list', 'sys/User', 1, 'User', 1, '2024-03-25 21:30:01', '2024-03-25 21:30:03', 1);
INSERT INTO `sys_menu` VALUES (3, 1, '角色管理', '/sys/roles', 'sys:role:list', 'sys/Role', 1, 'Medal', 2, '2024-03-25 21:31:37', '2024-03-25 21:31:39', 1);
INSERT INTO `sys_menu` VALUES (4, 1, '菜单管理', '/sys/menus', 'sys:menu:list', 'sys/Menu', 1, 'FolderOpened', 3, '2024-03-25 21:32:52', '2024-03-25 21:32:55', 1);
INSERT INTO `sys_menu` VALUES (5, 0, '系统工具', NULL, 'sys:tools', NULL, 0, 'PieChart', 2, '2024-03-25 21:34:00', NULL, 1);
INSERT INTO `sys_menu` VALUES (6, 5, '数字字典', '/sys/dicts', 'sys:dict:list', 'sys/Dict', 1, 'Memo', 1, '2024-03-25 21:35:10', '2024-03-25 21:35:16', 1);
INSERT INTO `sys_menu` VALUES (7, 3, '添加角色', NULL, 'sys:role:save', NULL, 2, NULL, 1, '2024-03-25 21:36:12', '2024-03-25 21:36:15', 1);
INSERT INTO `sys_menu` VALUES (8, 2, '添加用户', NULL, 'sys:user:save', NULL, 2, NULL, 1, '2024-03-01 21:37:34', '2024-04-27 20:43:12', 1);
INSERT INTO `sys_menu` VALUES (9, 2, '修改用户', NULL, 'sys:user:update', NULL, 2, NULL, 2, '2024-03-25 21:38:24', '2024-03-25 21:38:30', 1);
INSERT INTO `sys_menu` VALUES (10, 2, '删除用户', NULL, 'sys:user:delete', NULL, 2, NULL, 3, '2024-03-25 21:39:15', NULL, 1);
INSERT INTO `sys_menu` VALUES (11, 2, '分配角色', NULL, 'sys:user:role', NULL, 2, NULL, 4, '2024-03-25 21:40:05', NULL, 1);
INSERT INTO `sys_menu` VALUES (12, 2, '重置密码', NULL, 'sys:user:repass', NULL, 2, NULL, 5, '2024-03-25 21:41:03', NULL, 1);
INSERT INTO `sys_menu` VALUES (13, 3, '修改角色', NULL, 'sys:role:update', NULL, 2, NULL, 2, '2024-03-25 21:42:35', NULL, 1);
INSERT INTO `sys_menu` VALUES (14, 3, '删除角色', NULL, 'sys:role:delete', NULL, 2, NULL, 3, '2024-03-25 21:43:31', NULL, 1);
INSERT INTO `sys_menu` VALUES (15, 3, '分配权限', NULL, 'sys:role:perm', NULL, 2, NULL, 5, '2024-03-25 21:44:18', NULL, 1);
INSERT INTO `sys_menu` VALUES (16, 4, '添加菜单', NULL, 'sys:menu:save', NULL, 2, NULL, 1, '2024-03-25 21:45:09', '2024-03-25 21:45:16', 1);
INSERT INTO `sys_menu` VALUES (17, 4, '修改菜单', NULL, 'sys:menu:update', NULL, 2, NULL, 2, '2024-03-25 21:45:53', NULL, 1);
INSERT INTO `sys_menu` VALUES (18, 4, '删除菜单', NULL, 'sys:menu:delete', NULL, 2, NULL, 3, '2024-03-25 21:46:25', NULL, 1);
INSERT INTO `sys_menu` VALUES (19, 21, '出租房管理', '/sys/house', 'sys:house:list', 'sys/House', 1, 'House', 4, '2024-04-01 21:06:42', '2024-04-28 21:56:21', 1);
INSERT INTO `sys_menu` VALUES (21, 0, '商品管理', NULL, 'sys:houseManage', NULL, 0, 'Goods', NULL, '2024-04-28 22:01:14', NULL, 1);
INSERT INTO `sys_menu` VALUES (22, 21, '我的商品', '/sys/myhouse', 'sys:owner:list', 'sys/MyHouse', 1, 'Suitcase', 2, '2024-04-01 22:09:01', '2024-05-02 19:46:03', 1);
INSERT INTO `sys_menu` VALUES (23, 0, '订单管理', NULL, 'sys:order', NULL, 0, 'Wallet', NULL, '2024-05-02 19:43:12', NULL, 1);
INSERT INTO `sys_menu` VALUES (24, 23, '订单管理', '/sys/order', 'sys:order:list', 'sys/Order', 1, 'Van', NULL, '2024-05-02 19:45:54', NULL, 1);
INSERT INTO `sys_menu` VALUES (25, 5, '公告管理', '/sys/notice', 'sys:notice', 'sys/Notice', 1, 'Bell', NULL, '2024-05-03 19:22:46', NULL, 1);
INSERT INTO `sys_menu` VALUES (26, 5, '轮播图管理', '/sys/carousel', 'sys:carousel', 'sys/Carousel', 1, 'Picture', NULL, '2024-05-03 19:24:19', '2024-05-03 19:24:45', 1);
INSERT INTO `sys_menu` VALUES (27, 1, '用户日志', '/sys/log', 'sys:log', 'sys/Log', 1, 'Compass', NULL, '2024-05-13 10:48:36', NULL, 1);
INSERT INTO `sys_menu` VALUES (28, 21, '用户推荐', '/sys/userRecommend', 'sys:userRecommend', 'sys/UserRecommend', 1, 'Sunrise', NULL, '2024-05-13 14:43:17', NULL, 1);
INSERT INTO `sys_menu` VALUES (29, 1, '商家入驻申请', '/sys/apply', 'sys:apply', 'sys/Apply', 1, 'Position', NULL, '2024-05-28 13:16:31', NULL, 1);

-- ----------------------------
-- Table structure for sys_message
-- ----------------------------
DROP TABLE IF EXISTS `sys_message`;
CREATE TABLE `sys_message`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `status` int NOT NULL DEFAULT 0 COMMENT '0：未读   1：已读',
  `sender_id` bigint NULL DEFAULT NULL COMMENT '发送者id',
  `receiver_id` bigint NULL DEFAULT NULL COMMENT '接收者id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1786727759094132850 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_message
-- ----------------------------
INSERT INTO `sys_message` VALUES (1786727759094132753, '订单提醒', '您有一笔订单需要处理，请及时处理。\n订单号：1786287821120606208\n房屋信息：爱情公寓\n应付金额：￥ 100 元', '2024-05-05 11:25:35', NULL, 1, 1, 12);
INSERT INTO `sys_message` VALUES (1786727759094132754, '订单提醒', '您有一笔订单需要处理，请及时处理。\n订单号：1786287821120606208\n房屋信息：爱情公寓\n应付金额：￥ 100 元', '2024-05-05 11:26:03', NULL, 1, 1, 12);
INSERT INTO `sys_message` VALUES (1786727759094132755, '订单提醒', '您有一笔订单需要处理，请及时处理。\n订单号：1786287708344160256\n房屋信息：学生公寓\n应付金额：￥ 100 元', '2024-05-05 11:26:04', NULL, 1, 1, 13);
INSERT INTO `sys_message` VALUES (1786727759094132756, '订单提醒', '您有一笔订单需要处理，请及时处理。\n订单号：1786287658478080000\n房屋信息：居民平房11\n应付金额：￥ 100 元', '2024-05-05 11:26:06', NULL, 1, 1, 13);
INSERT INTO `sys_message` VALUES (1786727759094132757, '订单提醒', '您有一笔订单需要处理，请及时处理。\n订单号：1786287609341808640\n房屋信息：学区房[123m]\n应付金额：￥ 100 元', '2024-05-05 11:26:07', NULL, 1, 13, 1);
INSERT INTO `sys_message` VALUES (1786727759094132758, '订单提醒', '您有一笔订单需要处理，请及时处理。\n订单号：1786287821120606208\n房屋信息：爱情公寓\n应付金额：￥ 100 元', '2024-05-05 11:26:21', NULL, 1, 12, 1);
INSERT INTO `sys_message` VALUES (1786727759094132774, '订单提醒', '您有一笔订单需要处理，请及时处理。\n订单号：1788524559029243904\n房屋信息：学区房|两室一厅一卫生间|近平南镇镇中\n应付金额：￥ 100 元', '2024-05-13 13:09:21', NULL, 1, 2, 14);
INSERT INTO `sys_message` VALUES (1786727759094132810, NULL, '123', '2024-05-27 21:04:02', NULL, 1, 12, 1);
INSERT INTO `sys_message` VALUES (1786727759094132811, NULL, '666', '2024-05-27 21:04:36', NULL, 1, 12, 1);
INSERT INTO `sys_message` VALUES (1786727759094132812, NULL, '777', '2024-05-27 21:04:45', NULL, 1, 12, 1);
INSERT INTO `sys_message` VALUES (1786727759094132813, NULL, '123', '2024-05-27 21:07:01', NULL, 1, 1, 12);
INSERT INTO `sys_message` VALUES (1786727759094132814, NULL, '123', '2024-05-27 21:07:03', NULL, 1, 1, 12);
INSERT INTO `sys_message` VALUES (1786727759094132815, NULL, '123', '2024-05-27 21:11:33', NULL, 1, 12, 1);
INSERT INTO `sys_message` VALUES (1786727759094132816, NULL, '123456789', '2024-05-27 21:12:13', NULL, 1, 13, 1);
INSERT INTO `sys_message` VALUES (1786727759094132817, NULL, '123123123', '2024-05-27 21:41:50', NULL, 1, 13, 1);
INSERT INTO `sys_message` VALUES (1786727759094132818, NULL, '123123123', '2024-05-27 21:43:07', NULL, 1, 12, 1);
INSERT INTO `sys_message` VALUES (1786727759094132819, NULL, '哈哈哈哈哈哈哈哈哈', '2024-05-27 22:11:21', NULL, 1, 12, 1);
INSERT INTO `sys_message` VALUES (1786727759094132820, NULL, '毕业喽！', '2024-05-27 22:20:50', NULL, 1, 12, 1);
INSERT INTO `sys_message` VALUES (1786727759094132821, NULL, '没收到吗？', '2024-05-27 22:21:30', NULL, 1, 12, 1);
INSERT INTO `sys_message` VALUES (1786727759094132822, NULL, '哈喽', '2024-05-27 22:22:26', NULL, 1, 12, 1);
INSERT INTO `sys_message` VALUES (1786727759094132823, NULL, '呵呵', '2024-05-27 22:23:05', NULL, 1, 12, 1);
INSERT INTO `sys_message` VALUES (1786727759094132824, NULL, '收到了', '2024-05-27 23:08:43', NULL, 1, 1, 12);
INSERT INTO `sys_message` VALUES (1786727759094132825, NULL, '那就好', '2024-05-27 23:45:14', NULL, 1, 12, 1);
INSERT INTO `sys_message` VALUES (1786727759094132826, NULL, '那就好噢', '2024-05-27 23:47:20', NULL, 1, 12, 1);
INSERT INTO `sys_message` VALUES (1786727759094132827, NULL, '123', '2024-05-27 23:48:17', NULL, 1, 12, 1);
INSERT INTO `sys_message` VALUES (1786727759094132828, NULL, '今天天气是🌤', '2024-05-27 23:57:12', NULL, 1, 1, 12);
INSERT INTO `sys_message` VALUES (1786727759094132829, NULL, '你好，这个房怎么样', '2024-05-28 09:40:33', NULL, 0, 24, 2);
INSERT INTO `sys_message` VALUES (1786727759094132830, NULL, '哈喽啊', '2024-05-28 09:47:01', NULL, 1, 24, 12);
INSERT INTO `sys_message` VALUES (1786727759094132831, NULL, '我这有个房，你看看吗', '2024-05-28 10:06:04', NULL, 1, 1, 16);
INSERT INTO `sys_message` VALUES (1786727759094132832, NULL, '是什么房？', '2024-05-28 10:07:12', NULL, 1, 16, 1);
INSERT INTO `sys_message` VALUES (1786727759094132833, NULL, '哈喽？', '2024-05-28 23:30:48', NULL, 1, 16, 1);
INSERT INTO `sys_message` VALUES (1786727759094132834, NULL, '还在吗?', '2024-05-28 23:31:26', NULL, 1, 16, 1);
INSERT INTO `sys_message` VALUES (1786727759094132835, NULL, '111', '2024-05-28 23:31:35', NULL, 1, 1, 16);
INSERT INTO `sys_message` VALUES (1786727759094132836, NULL, '111', '2024-05-28 23:31:41', NULL, 1, 1, 16);
INSERT INTO `sys_message` VALUES (1786727759094132837, NULL, '哈哈哈哈', '2024-05-28 23:34:21', NULL, 1, 16, 1);
INSERT INTO `sys_message` VALUES (1786727759094132838, NULL, '好的，什么时候可以看房， 约个时间吧', '2024-05-28 23:34:39', NULL, 1, 16, 1);
INSERT INTO `sys_message` VALUES (1786727759094132839, NULL, '好的，这周周末吧，先加个微信！', '2024-05-28 23:34:57', NULL, 1, 1, 16);
INSERT INTO `sys_message` VALUES (1786727759094132840, NULL, '你好你好，做一下websocket测试', '2024-05-29 00:21:56', NULL, 1, 16, 1);
INSERT INTO `sys_message` VALUES (1786727759094132841, NULL, '这是你不在线的测试', '2024-05-29 00:23:04', NULL, 0, 16, 1);
INSERT INTO `sys_message` VALUES (1786727759094132842, NULL, '123', '2024-05-29 00:29:34', NULL, 0, 16, 1);
INSERT INTO `sys_message` VALUES (1786727759094132843, NULL, '123', '2024-05-29 00:29:47', NULL, 0, 16, 1);
INSERT INTO `sys_message` VALUES (1786727759094132844, NULL, '123', '2024-05-29 00:32:40', NULL, 0, 16, 1);
INSERT INTO `sys_message` VALUES (1786727759094132845, NULL, '123', '2024-05-29 00:33:05', NULL, 0, 16, 1);
INSERT INTO `sys_message` VALUES (1786727759094132846, NULL, '666', '2024-05-29 00:33:44', NULL, 0, 16, 1);
INSERT INTO `sys_message` VALUES (1786727759094132847, NULL, '999', '2024-05-29 00:34:34', NULL, 0, 16, 1);
INSERT INTO `sys_message` VALUES (1786727759094132848, NULL, '？', '2024-05-29 00:34:46', NULL, 0, 16, 1);
INSERT INTO `sys_message` VALUES (1786727759094132849, NULL, '你好，这个房还在出租吗？', '2024-05-29 23:34:29', NULL, 0, 16, 10);

-- ----------------------------
-- Table structure for sys_notice
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice`;
CREATE TABLE `sys_notice`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '标题',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `status` int NOT NULL DEFAULT 1,
  `create_time` datetime NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `publisher_id` int NULL DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_notice
-- ----------------------------
INSERT INTO `sys_notice` VALUES (1, '第一个公告', '<p>999<img src=\"https://glut-1.oss-cn-shenzhen.aliyuncs.com/image/0c79d348e8ad40aca735ea52c387d2b9.gif\" alt=\"{(8RT{2{RAN6PI@JKT{XTXU.gif\" data-href=\"https://glut-1.oss-cn-shenzhen.aliyuncs.com/image/0c79d348e8ad40aca735ea52c387d2b9.gif\" style=\"\"/>啊啊啊啊啊啊冲冲冲翠翠此翠翠初次啊实打实打算</p><p><img src=\"https://glut-1.oss-cn-shenzhen.aliyuncs.com/image/d245f4a91a42495ab3e7307454c79f3a.jpg\" alt=\"\" data-href=\"\" style=\"width: 30%;\"/></p><p style=\"text-align: center;\"><br></p><div data-w-e-type=\"video\" data-w-e-is-void>\n<video poster=\"null\" controls=\"true\" width=\"auto\" height=\"300\"><source src=\"https://glut-1.oss-cn-shenzhen.aliyuncs.com/video/b2a65e26d4464cca8494e79650b82d32.mp4\" type=\"video/mp4\"/></video>\n</div><p><br></p><div data-w-e-type=\"video\" data-w-e-is-void>\n<video poster=\"\" controls=\"true\" width=\"500\" height=\"auto\"><source src=\"https://glut-1.oss-cn-shenzhen.aliyuncs.com/video/71b8876c02c9436c8f7e8aae57495790.mp4\" type=\"video/mp4\"/></video>\n</div><p><br></p><p><br></p>', 1, '2024-05-03 23:01:39', '2024-05-09 11:23:21', 1);
INSERT INTO `sys_notice` VALUES (8, '第二个公告', '<p><br></p><div data-w-e-type=\"video\" data-w-e-is-void>\n<video poster=\"\" controls=\"true\" width=\"auto\" height=\"auto\"><source src=\"https://www.douyin.com/video/7364786899635932426\" type=\"video/mp4\"/></video>\n</div><p><br></p>', 1, '2024-05-04 11:09:44', '2024-05-09 11:23:31', 1);
INSERT INTO `sys_notice` VALUES (9, '第三个公告', '<p>抖音发的</p><p><img src=\"https://glut-1.oss-cn-shenzhen.aliyuncs.com/video/49539cf5b5c34d84a956cce6b8e91113.webp\" alt=\"\" data-href=\"\" style=\"width: 122.28px;height: 265.00px;\"/></p><p><br></p><div data-w-e-type=\"video\" data-w-e-is-void>\n<video poster=\"\" controls=\"true\" width=\"auto\" height=\"300\"><source src=\"https://glut-1.oss-cn-shenzhen.aliyuncs.com/video/902ac16505dd4d2ca523ad3563ba0b18.mp4\" type=\"video/mp4\"/></video>\n</div><p><br></p>', 1, '2024-05-04 11:11:11', '2024-05-09 11:24:35', 1);
INSERT INTO `sys_notice` VALUES (11, '第四个公告', '<p><img src=\"https://glut-1.oss-cn-shenzhen.aliyuncs.com/image/64d8d9372fd5425f990847919a9dcd5b.gif\" alt=\"\" data-href=\"\" style=\"\"/></p><p><img src=\"https://glut-1.oss-cn-shenzhen.aliyuncs.com/image/292e1ea5239f4fc09d57cf36aa7d164d.jpg\" alt=\"\" data-href=\"\" style=\"width: 30%;\"/></p><div data-w-e-type=\"video\" data-w-e-is-void>\n<video poster=\"\" controls=\"true\" width=\"auto\" height=\"300\"><source src=\"https://glut-1.oss-cn-shenzhen.aliyuncs.com/video/01cb44df46c34338a45af0ba398ed7b5.mp4\" type=\"video/mp4\"/></video>\n</div><p><br></p>', 1, '2024-05-09 11:26:33', NULL, 1);
INSERT INTO `sys_notice` VALUES (12, '第五个公告', '<p style=\"text-align: center;\"><img src=\"https://glut-1.oss-cn-shenzhen.aliyuncs.com//2024-05-09-13-19-522024-03-2720.28.50_假日.jpg\" alt=\"\" data-href=\"\" style=\"width: 30%;\"></p><p style=\"text-align: center;\"><img src=\"https://glut-1.oss-cn-shenzhen.aliyuncs.com//2024-05-09-13-20-212024-03-2720.28.50_假日1.jpg\" alt=\"\" data-href=\"\" style=\"width: 30%;\"></p><div data-w-e-type=\"video\" data-w-e-is-void>\n<video poster=\"\" controls=\"true\" width=\"auto\" height=\"300\"><source src=\"https://glut-1.oss-cn-shenzhen.aliyuncs.com/video/003896451afa4d90a38c197a93a72a69.mp4\" type=\"video/mp4\"/></video>\n</div><p>123</p>', 1, '2024-05-09 13:20:47', '2024-05-09 13:20:55', 1);
INSERT INTO `sys_notice` VALUES (13, '第六个公告', '<p style=\"text-align: center;\"><img src=\"https://glut-1.oss-cn-shenzhen.aliyuncs.com/image/209104cb1aba43608e61617089cacf98.jpg\" alt=\"\" data-href=\"\" style=\"width: 30%;\"></p>', 1, '2024-05-09 13:36:46', NULL, 1);
INSERT INTO `sys_notice` VALUES (14, '第七个公告', '<p style=\"text-align: center;\"><img src=\"https://glut-1.oss-cn-shenzhen.aliyuncs.com/2024-05-0119.02.56_盛夏___三亚的夏季永不停歇__几乎每天都可以晒太阳_穿漂亮小裙.jpg\" alt=\"\" data-href=\"\" style=\"width: 30%;\"></p><p style=\"text-align: center;\"><img src=\"https://glut-1.oss-cn-shenzhen.aliyuncs.com/2024-05-0119.02.56_盛夏___三亚的夏季永不停歇__几乎每天都可以晒太阳_穿漂亮小裙子.jpg\" alt=\"\" data-href=\"\" style=\"width: 30%;\"></p>', 1, '2024-05-09 13:41:14', NULL, 1);
INSERT INTO `sys_notice` VALUES (15, '第八个公告', '<p style=\"text-align: center;\"><img src=\"https://glut-1.oss-cn-shenzhen.aliyuncs.com/2024-05-0119.02.56_盛夏___三亚的夏季永不停歇__几乎每天都可以晒太阳_穿漂亮小裙.jpg\" alt=\"\" data-href=\"\" style=\"width: 30%;\"></p><p style=\"text-align: center;\"><img src=\"https://glut-1.oss-cn-shenzhen.aliyuncs.com/2024-05-0119.02.56_盛夏___三亚的夏季永不停歇__几乎每天都可以晒太阳_穿漂亮小裙子.jpg\" alt=\"\" data-href=\"\" style=\"width: 30%;\"></p>', 1, '2024-05-09 13:42:14', NULL, 1);
INSERT INTO `sys_notice` VALUES (16, '第九个公告', '<p style=\"text-align: center;\"><img src=\"https://glut-1.oss-cn-shenzhen.aliyuncs.com/2024-05-0119.02.56_盛夏___三亚的夏季永不停歇__几乎每天都可以晒太阳_穿漂亮小裙.jpg\" alt=\"\" data-href=\"\" style=\"width: 30%;\"></p><p style=\"text-align: center;\"><img src=\"https://glut-1.oss-cn-shenzhen.aliyuncs.com/2024-05-0119.02.56_盛夏___三亚的夏季永不停歇__几乎每天都可以晒太阳_穿漂亮小裙子.jpg\" alt=\"\" data-href=\"\" style=\"width: 30%;\"></p>', 1, '2024-05-09 13:43:15', NULL, 1);
INSERT INTO `sys_notice` VALUES (17, '第十个公告', '<p style=\"text-align: center;\"><img src=\"https://glut-1.oss-cn-shenzhen.aliyuncs.com/640 (6).webp\" alt=\"\" data-href=\"\" style=\"width: 30%;\"></p><p style=\"text-align: center;\"><br></p><div data-w-e-type=\"video\" data-w-e-is-void>\n<video poster=\"\" controls=\"true\" width=\"auto\" height=\"300\"><source src=\"https://glut-1.oss-cn-shenzhen.aliyuncs.com/2024-03-16 21.16.22_风轻轻我听见你声音_video.mp4\" type=\"video/mp4\"/></video>\n</div><p><br></p>', 1, '2024-05-09 13:45:44', NULL, 1);
INSERT INTO `sys_notice` VALUES (18, '第十一条公告', '<p style=\"text-align: center;\"><img src=\"https://glut-1.oss-cn-shenzhen.aliyuncs.com/2024-03-2720.28.50_假日.jpg\" alt=\"\" data-href=\"\" style=\"width: 30%;\"></p><p style=\"text-align: center;\"><img src=\"https://glut-1.oss-cn-shenzhen.aliyuncs.com/2024-05-0119.02.56_盛夏___三亚的夏季永不停歇__几乎每天都可以晒太阳_穿漂亮小裙.jpg\" alt=\"\" data-href=\"\" style=\"width: 30%;\"></p><p style=\"text-align: center;\"><br></p><div data-w-e-type=\"video\" data-w-e-is-void>\n<video poster=\"\" controls=\"true\" width=\"auto\" height=\"300\"><source src=\"https://glut-1.oss-cn-shenzhen.aliyuncs.com/2024-05-04 19.12.01__红色很适合你__.mp4\" type=\"video/mp4\"/></video>\n</div><p><br></p>', 1, '2024-05-09 13:48:49', '2024-05-09 13:50:15', 1);
INSERT INTO `sys_notice` VALUES (19, '这是一条xss攻击', '<p><img src=\"\" onerror=\"alert(\'xss攻击啦\')\" /></p>', 1, '2024-05-19 10:39:21', '2024-05-19 13:13:13', 1);

-- ----------------------------
-- Table structure for sys_order
-- ----------------------------
DROP TABLE IF EXISTS `sys_order`;
CREATE TABLE `sys_order`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `order_no` bigint NULL DEFAULT NULL,
  `alipay_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '阿里支付的支付号码',
  `create_time` datetime NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `payment_time` datetime NULL DEFAULT NULL COMMENT '支付时间',
  `status` int NOT NULL DEFAULT 0 COMMENT '0：未支付   1：已支付   2：已退款',
  `money` decimal(10, 3) NOT NULL DEFAULT 0.000 COMMENT '订单金额',
  `pay_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '支付方式',
  `house_id` bigint NULL DEFAULT NULL COMMENT '房屋的id',
  `owner_id` bigint NULL DEFAULT NULL COMMENT '房东id',
  `user_id` bigint NULL DEFAULT NULL COMMENT '租户id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1795134345609093123 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_order
-- ----------------------------
INSERT INTO `sys_order` VALUES (1786287609344094210, 1786287609341808640, NULL, '2024-05-03 14:52:08', '2024-05-03 15:04:44', NULL, 0, 100.000, NULL, 1, 1, 12);
INSERT INTO `sys_order` VALUES (1786287633402621953, 1786287633442279424, '2024050322001443630502869261', '2024-05-03 14:52:14', '2024-05-03 17:09:47', NULL, 1, 100.000, NULL, 2, 1, 13);
INSERT INTO `sys_order` VALUES (1786287658451005441, 1786287658478080001, '2024050522001443630502891910', '2024-05-03 14:52:20', '2024-05-05 13:54:15', NULL, 1, 100.000, NULL, 3, 11, 14);
INSERT INTO `sys_order` VALUES (1786287708308697089, 1786287708344160256, NULL, '2024-05-03 14:52:32', '2024-05-03 15:04:40', NULL, 0, 100.000, NULL, 4, 15, 15);
INSERT INTO `sys_order` VALUES (1786287821097725954, 1786287821120606208, NULL, '2024-05-03 14:52:59', NULL, NULL, 0, 100.000, NULL, 5, 15, 12);
INSERT INTO `sys_order` VALUES (1788492941998886913, 1788492941975621632, NULL, '2024-05-09 16:55:21', NULL, NULL, 0, 100.000, NULL, 12, 1, 15);
INSERT INTO `sys_order` VALUES (1788493323626024962, 1788493323657285632, NULL, '2024-05-09 16:56:52', NULL, NULL, 0, 100.000, NULL, 13, 10, 2);
INSERT INTO `sys_order` VALUES (1788522937383587841, 1788522937364516864, NULL, '2024-05-09 18:54:32', NULL, NULL, 0, 100.000, NULL, 16, 2, 13);
INSERT INTO `sys_order` VALUES (1788524494950961154, 1788524494986416128, NULL, '2024-05-09 19:00:43', NULL, NULL, 0, 100.000, NULL, 15, 2, 14);
INSERT INTO `sys_order` VALUES (1788524559002177538, 1788524559029243904, NULL, '2024-05-09 19:00:59', '2024-05-09 20:28:44', NULL, 0, 100.000, NULL, 16, 2, 14);
INSERT INTO `sys_order` VALUES (1788761149565743105, 1788761149462810624, NULL, '2024-05-10 10:41:06', NULL, NULL, 0, 100.000, NULL, 1, 1, 1);
INSERT INTO `sys_order` VALUES (1789877470630166529, 1789877470619504640, '2024051522001443630503014713', '2024-05-13 12:36:58', '2024-05-15 22:03:41', NULL, 2, 100.000, NULL, 11, 1, 16);
INSERT INTO `sys_order` VALUES (1789885795748958209, 1789885795738324992, NULL, '2024-05-13 13:10:03', NULL, NULL, 4, 100.000, NULL, 16, 2, 17);
INSERT INTO `sys_order` VALUES (1789918609672409090, 1789918609657565184, NULL, '2024-05-13 15:20:26', NULL, NULL, 0, 100.000, NULL, 1, 1, 29);
INSERT INTO `sys_order` VALUES (1790747437084905473, 1790747437070028800, '2024051522001443630503013256', '2024-05-15 22:13:54', '2024-05-15 22:15:08', '2024-05-15 22:15:08', 2, 100.000, NULL, 2, 1, 16);
INSERT INTO `sys_order` VALUES (1790748171566260225, 1790748171551379456, '2024051522001443630503009202', '2024-05-15 22:16:49', '2024-05-16 10:41:11', '2024-05-15 22:17:13', 2, 100.000, NULL, 15, 2, 16);
INSERT INTO `sys_order` VALUES (1790748794613342209, 1790748794640404480, '2024051522001443630503018766', '2024-05-15 22:19:18', '2024-05-16 10:37:37', '2024-05-15 22:19:57', 2, 100.000, NULL, 1, 1, 16);
INSERT INTO `sys_order` VALUES (1790751524899725314, 1790751524947759104, '2024051522001443630503014714', '2024-05-15 22:30:09', '2024-05-16 00:14:06', '2024-05-15 22:38:57', 2, 100.000, NULL, 18, 1, 16);
INSERT INTO `sys_order` VALUES (1790943590413942786, 1790943590390697984, '2024052122001443630503087712', '2024-05-16 11:13:21', '2024-05-21 09:59:55', '2024-05-21 09:48:49', 2, 100.000, NULL, 15, 2, 16);
INSERT INTO `sys_order` VALUES (1790944030270603266, 1790944030272524288, '2024051622001443630503018771', '2024-05-16 11:15:06', '2024-05-16 12:39:09', '2024-05-16 12:39:01', 2, 100.000, NULL, 2, 1, 16);
INSERT INTO `sys_order` VALUES (1790944047639216129, 1790944047687274496, '2024051622001443630503028142', '2024-05-16 11:15:10', '2024-05-16 12:23:57', '2024-05-16 12:23:44', 2, 100.000, NULL, 3, 11, 16);
INSERT INTO `sys_order` VALUES (1791300188915269633, 1791300188887846912, '2024052122001443630503086179', '2024-05-17 10:50:20', '2024-05-21 10:25:32', '2024-05-21 09:49:16', 2, 100.000, NULL, 12, 1, 16);
INSERT INTO `sys_order` VALUES (1791399128931155970, 1791399128907911168, '2024052122001443630503094271', '2024-05-17 17:23:30', '2024-05-21 10:25:42', '2024-05-21 09:43:06', 2, 100.000, NULL, 4, 15, 16);
INSERT INTO `sys_order` VALUES (1791399510453420033, 1791399510425997312, '2024052122001443630503092352', '2024-05-17 17:25:01', '2024-05-22 17:12:14', '2024-05-21 09:42:47', 2, 100.000, NULL, 4, 15, 16);
INSERT INTO `sys_order` VALUES (1792732223210983425, 1792732223191912448, '2024052122001443630503086178', '2024-05-21 09:40:44', '2024-05-21 10:01:34', '2024-05-21 09:42:23', 2, 100.000, NULL, 89, 2, 16);
INSERT INTO `sys_order` VALUES (1792738993388068866, 1792738993368993792, '2024052122001443630503091109', '2024-05-21 10:07:38', '2024-05-21 10:24:30', '2024-05-21 10:24:30', 1, 100.000, NULL, 18, 2, 16);
INSERT INTO `sys_order` VALUES (1793176477553008642, 1793176477521416192, NULL, '2024-05-22 15:06:03', NULL, NULL, 0, 100.000, NULL, 18, 2, 16);
INSERT INTO `sys_order` VALUES (1793206961582551042, 1793206961588670464, '2024052222001443630503106154', '2024-05-22 17:07:10', '2024-05-22 17:13:11', '2024-05-22 17:07:31', 2, 100.000, NULL, 2, 12, 16);
INSERT INTO `sys_order` VALUES (1793208761677164546, 1793208761721032704, '2024052222001443630503108914', '2024-05-22 17:14:20', '2024-05-22 17:14:59', '2024-05-22 17:14:59', 1, 100.000, NULL, 79, 1, 16);
INSERT INTO `sys_order` VALUES (1794711507785986050, 1794711507657822208, NULL, '2024-05-26 20:45:42', NULL, NULL, 4, 100.000, NULL, 96, 12, 24);
INSERT INTO `sys_order` VALUES (1795134345609093122, 1795134345577500672, NULL, '2024-05-28 00:45:55', NULL, NULL, 4, 100.000, NULL, 11, 10, 24);

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色名称',
  `code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '唯一编码',
  `remark` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `created` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `updated` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `statu` int NOT NULL DEFAULT 1 COMMENT '状态  1：正常  0：禁用',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '普通用户', 'normal', '只能查看基本功能', '2024-03-25 22:21:19', '2024-03-25 22:21:23', 1);
INSERT INTO `sys_role` VALUES (2, '超级管理员', 'admin', '系统默认最高权限，不可改动', '2024-03-25 22:22:41', '2024-03-25 22:22:44', 1);
INSERT INTO `sys_role` VALUES (3, '房东', 'fd', '可以出租房', '2024-04-01 15:30:05', '2024-04-27 15:30:49', 1);

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '角色菜单表主键',
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `menu_id` bigint NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `f_m_rid`(`role_id` ASC) USING BTREE,
  INDEX `f_mid`(`menu_id` ASC) USING BTREE,
  CONSTRAINT `f_m_rid` FOREIGN KEY (`role_id`) REFERENCES `sys_role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `f_mid` FOREIGN KEY (`menu_id`) REFERENCES `sys_menu` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 392 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色菜单表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (299, 3, 21);
INSERT INTO `sys_role_menu` VALUES (300, 3, 28);
INSERT INTO `sys_role_menu` VALUES (301, 3, 22);
INSERT INTO `sys_role_menu` VALUES (302, 3, 23);
INSERT INTO `sys_role_menu` VALUES (303, 3, 24);
INSERT INTO `sys_role_menu` VALUES (304, 3, 9);
INSERT INTO `sys_role_menu` VALUES (305, 3, 12);
INSERT INTO `sys_role_menu` VALUES (360, 1, 23);
INSERT INTO `sys_role_menu` VALUES (361, 1, 24);
INSERT INTO `sys_role_menu` VALUES (362, 1, 8);
INSERT INTO `sys_role_menu` VALUES (363, 1, 9);
INSERT INTO `sys_role_menu` VALUES (364, 1, 12);
INSERT INTO `sys_role_menu` VALUES (365, 2, 21);
INSERT INTO `sys_role_menu` VALUES (366, 2, 28);
INSERT INTO `sys_role_menu` VALUES (367, 2, 22);
INSERT INTO `sys_role_menu` VALUES (368, 2, 19);
INSERT INTO `sys_role_menu` VALUES (369, 2, 23);
INSERT INTO `sys_role_menu` VALUES (370, 2, 24);
INSERT INTO `sys_role_menu` VALUES (371, 2, 1);
INSERT INTO `sys_role_menu` VALUES (372, 2, 27);
INSERT INTO `sys_role_menu` VALUES (373, 2, 29);
INSERT INTO `sys_role_menu` VALUES (374, 2, 2);
INSERT INTO `sys_role_menu` VALUES (375, 2, 8);
INSERT INTO `sys_role_menu` VALUES (376, 2, 9);
INSERT INTO `sys_role_menu` VALUES (377, 2, 10);
INSERT INTO `sys_role_menu` VALUES (378, 2, 11);
INSERT INTO `sys_role_menu` VALUES (379, 2, 12);
INSERT INTO `sys_role_menu` VALUES (380, 2, 3);
INSERT INTO `sys_role_menu` VALUES (381, 2, 7);
INSERT INTO `sys_role_menu` VALUES (382, 2, 13);
INSERT INTO `sys_role_menu` VALUES (383, 2, 14);
INSERT INTO `sys_role_menu` VALUES (384, 2, 15);
INSERT INTO `sys_role_menu` VALUES (385, 2, 4);
INSERT INTO `sys_role_menu` VALUES (386, 2, 16);
INSERT INTO `sys_role_menu` VALUES (387, 2, 17);
INSERT INTO `sys_role_menu` VALUES (388, 2, 18);
INSERT INTO `sys_role_menu` VALUES (389, 2, 5);
INSERT INTO `sys_role_menu` VALUES (390, 2, 25);
INSERT INTO `sys_role_menu` VALUES (391, 2, 26);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户表主键ID',
  `username` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户名',
  `password` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '密码',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户头像',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '手机号',
  `city_codeOne` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `city_codeTwo` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `city_codeThree` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `city` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '城市',
  `created` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `updated` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `last_login` datetime NULL DEFAULT NULL COMMENT '最近登录时间',
  `statu` int NOT NULL DEFAULT 1 COMMENT '状态  1：正常   0：禁用',
  `age` int NULL DEFAULT NULL COMMENT '年龄',
  `gender` int NOT NULL DEFAULT 1 COMMENT '0：女   1男',
  `id_card` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '身份证号',
  `introduction` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '个人介绍',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `邮箱唯一`(`email` ASC) USING BTREE COMMENT '让邮箱号唯一'
) ENGINE = InnoDB AUTO_INCREMENT = 59 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 'admin', '$2a$10$WF340hmlPNYaT2QfDFmqV.UbLCvAgMX1MxyqUaC2N3rrhN./P9sz6', 'https://glut-1.oss-cn-shenzhen.aliyuncs.com/image/efec2d468f964e2eb1097e15765d1c09.gif', '21839995181@qq.com', '18888888888', '440000', '440100', NULL, '广东省广州市', '2024-03-01 20:09:13', '2024-05-14 00:02:10', '2024-05-29 08:07:03', 1, 18, 1, '450821200000000000', '这个人很懒，什么也没有留下');
INSERT INTO `sys_user` VALUES (2, '房东-广州', '$2a$10$WF340hmlPNYaT2QfDFmqV.UbLCvAgMX1MxyqUaC2N3rrhN./P9sz6', 'https://glut-1.oss-cn-shenzhen.aliyuncs.com/rms/640 (1).gif', '21839995182@qq.com', '18787875698', '450000', '450300', NULL, '广西壮族自治区桂林市', '2024-03-24 20:12:46', '2024-05-16 23:06:52', '2024-05-27 21:42:44', 1, 18, 1, '450822100000000111', NULL);
INSERT INTO `sys_user` VALUES (10, '房东-南宁', '$2a$10$78uRLjbQFO6bhMVZOBGE4eIB689MQwuwx/dBIfDEnKNEAfFmwWGLK', 'https://cube.elemecdn.com/0/88/03b0d39583f48206768a7534e55bcpng.png', '21839995183@qq.com', '14788990909', '450000', '450100', NULL, '广西壮族自治区南宁市', '2024-03-30 17:37:39', '2024-05-14 00:04:17', '2024-05-28 11:18:44', 1, NULL, 0, NULL, NULL);
INSERT INTO `sys_user` VALUES (11, '房东-深圳', '$2a$10$78uRLjbQFO6bhMVZOBGE4eIB689MQwuwx/dBIfDEnKNEAfFmwWGLK', 'https://cube.elemecdn.com/0/88/03b0d39583f48206768a7534e55bcpng.png', '21839995184@qq.com', '18896969696', '440000', '440300', NULL, '广东省深圳市', '2024-04-27 10:38:57', '2024-05-14 00:04:10', NULL, 1, NULL, 0, NULL, NULL);
INSERT INTO `sys_user` VALUES (12, '房东-桂林', '$2a$10$78uRLjbQFO6bhMVZOBGE4eIB689MQwuwx/dBIfDEnKNEAfFmwWGLK', 'https://glut-1.oss-cn-shenzhen.aliyuncs.com/rms/QQ图片20240510112738.gif', '21839995185@qq.com', '19985689642', NULL, NULL, NULL, NULL, '2024-04-27 10:44:17', '2024-05-21 09:37:21', '2024-05-27 21:43:01', 1, 18, 0, NULL, NULL);
INSERT INTO `sys_user` VALUES (13, '房东-柳州', '$2a$10$78uRLjbQFO6bhMVZOBGE4eIB689MQwuwx/dBIfDEnKNEAfFmwWGLK', 'https://glut-1.oss-cn-shenzhen.aliyuncs.com/image/a2653b0b9fce4d31a7a3531e44a7b898.jpg', '21839995186@qq.com', '18989898989', NULL, NULL, NULL, NULL, '2024-04-01 14:22:09', '2024-05-21 09:37:31', '2024-05-27 21:11:59', 1, NULL, 0, NULL, NULL);
INSERT INTO `sys_user` VALUES (14, '房东-贵港', '$2a$10$78uRLjbQFO6bhMVZOBGE4eIB689MQwuwx/dBIfDEnKNEAfFmwWGLK', 'https://glut-1.oss-cn-shenzhen.aliyuncs.com/rms/QQ图片20240521131131.gif', '21839995187@qq.com', '18477581529', NULL, NULL, NULL, NULL, '2024-04-28 12:06:47', '2024-05-28 11:18:10', '2024-05-27 21:42:10', 1, NULL, 1, NULL, NULL);
INSERT INTO `sys_user` VALUES (15, '房东-百色', '$2a$10$78uRLjbQFO6bhMVZOBGE4eIB689MQwuwx/dBIfDEnKNEAfFmwWGLK', 'https://glut-1.oss-cn-shenzhen.aliyuncs.com/image/fcc09c1e12a84acd89f8a52e87de04b4.gif', '21839995188@qq.com', '18655888888', NULL, NULL, NULL, NULL, '2024-04-01 13:46:26', '2024-05-21 09:38:07', '2024-05-21 21:48:40', 1, NULL, 1, NULL, NULL);
INSERT INTO `sys_user` VALUES (16, '租户-梅兰竹菊', '$2a$10$78uRLjbQFO6bhMVZOBGE4eIB689MQwuwx/dBIfDEnKNEAfFmwWGLK', 'https://glut-1.oss-cn-shenzhen.aliyuncs.com/image/fcc09c1e12a84acd89f8a52e87de04b4.gif', NULL, '18477587878', NULL, NULL, NULL, NULL, NULL, '2024-05-15 22:37:52', '2024-05-24 20:18:25', 1, NULL, 1, '450821200100000000', NULL);
INSERT INTO `sys_user` VALUES (17, '租户-兰花', '$2a$10$78uRLjbQFO6bhMVZOBGE4eIB689MQwuwx/dBIfDEnKNEAfFmwWGLK', 'https://cube.elemecdn.com/0/88/03b0d39583f48206768a7534e55bcpng.png', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-05-13 11:17:44', 1, NULL, 1, NULL, NULL);
INSERT INTO `sys_user` VALUES (18, '租户-竹子', '$2a$10$78uRLjbQFO6bhMVZOBGE4eIB689MQwuwx/dBIfDEnKNEAfFmwWGLK', 'https://glut-1.oss-cn-shenzhen.aliyuncs.com/image/a2653b0b9fce4d31a7a3531e44a7b898.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, 1, NULL, NULL);
INSERT INTO `sys_user` VALUES (19, '租户-菊花', '$2a$10$78uRLjbQFO6bhMVZOBGE4eIB689MQwuwx/dBIfDEnKNEAfFmwWGLK', 'https://cube.elemecdn.com/0/88/03b0d39583f48206768a7534e55bcpng.png', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, 1, NULL, NULL);
INSERT INTO `sys_user` VALUES (20, '租户-毛笔', '$2a$10$78uRLjbQFO6bhMVZOBGE4eIB689MQwuwx/dBIfDEnKNEAfFmwWGLK', 'https://glut-1.oss-cn-shenzhen.aliyuncs.com/image/efec2d468f964e2eb1097e15765d1c09.gif', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-05-11 14:09:29', 1, NULL, 1, NULL, NULL);
INSERT INTO `sys_user` VALUES (21, '租户-墨水', '$2a$10$WF340hmlPNYaT2QfDFmqV.UbLCvAgMX1MxyqUaC2N3rrhN./P9sz6', 'https://cube.elemecdn.com/0/88/03b0d39583f48206768a7534e55bcpng.png', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-05-11 14:10:09', 1, NULL, 1, NULL, NULL);
INSERT INTO `sys_user` VALUES (24, '租户-0501', '$2a$10$WF340hmlPNYaT2QfDFmqV.UbLCvAgMX1MxyqUaC2N3rrhN./P9sz6', 'https://glut-1.oss-cn-shenzhen.aliyuncs.com/image/efec2d468f964e2eb1097e15765d1c09.gif', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-05-25 10:56:42', 1, NULL, 1, NULL, NULL);
INSERT INTO `sys_user` VALUES (25, '租户-0502', '$2a$10$WF340hmlPNYaT2QfDFmqV.UbLCvAgMX1MxyqUaC2N3rrhN./P9sz6', 'https://cube.elemecdn.com/0/88/03b0d39583f48206768a7534e55bcpng.png', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-05-12 20:02:08', 1, NULL, 1, NULL, NULL);
INSERT INTO `sys_user` VALUES (26, '租户-0503', '$2a$10$WF340hmlPNYaT2QfDFmqV.UbLCvAgMX1MxyqUaC2N3rrhN./P9sz6', 'https://cube.elemecdn.com/0/88/03b0d39583f48206768a7534e55bcpng.png', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-05-13 10:42:19', 1, NULL, 1, NULL, NULL);
INSERT INTO `sys_user` VALUES (27, '租户-0504', '$2a$10$WF340hmlPNYaT2QfDFmqV.UbLCvAgMX1MxyqUaC2N3rrhN./P9sz6', 'https://cube.elemecdn.com/0/88/03b0d39583f48206768a7534e55bcpng.png', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, 1, NULL, NULL);
INSERT INTO `sys_user` VALUES (28, '租户-0505', '$2a$10$WF340hmlPNYaT2QfDFmqV.UbLCvAgMX1MxyqUaC2N3rrhN./P9sz6', 'https://cube.elemecdn.com/0/88/03b0d39583f48206768a7534e55bcpng.png', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-05-13 13:53:41', 1, NULL, 1, NULL, NULL);
INSERT INTO `sys_user` VALUES (29, '租户-0506', '$2a$10$WF340hmlPNYaT2QfDFmqV.UbLCvAgMX1MxyqUaC2N3rrhN./P9sz6', 'https://cube.elemecdn.com/0/88/03b0d39583f48206768a7534e55bcpng.png', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-05-25 10:55:53', 1, NULL, 1, NULL, NULL);
INSERT INTO `sys_user` VALUES (30, '租户-0507', '$2a$10$WF340hmlPNYaT2QfDFmqV.UbLCvAgMX1MxyqUaC2N3rrhN./P9sz6', 'https://cube.elemecdn.com/0/88/03b0d39583f48206768a7534e55bcpng.png', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-05-13 15:20:54', 1, NULL, 1, NULL, NULL);
INSERT INTO `sys_user` VALUES (31, '租户-0508', '$2a$10$WF340hmlPNYaT2QfDFmqV.UbLCvAgMX1MxyqUaC2N3rrhN./P9sz6', 'https://cube.elemecdn.com/0/88/03b0d39583f48206768a7534e55bcpng.png', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-05-13 15:21:28', 1, NULL, 1, NULL, NULL);
INSERT INTO `sys_user` VALUES (32, '租户-0509', '$2a$10$WF340hmlPNYaT2QfDFmqV.UbLCvAgMX1MxyqUaC2N3rrhN./P9sz6', 'https://cube.elemecdn.com/0/88/03b0d39583f48206768a7534e55bcpng.png', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, 1, NULL, NULL);
INSERT INTO `sys_user` VALUES (33, '租户-0510', '$2a$10$WF340hmlPNYaT2QfDFmqV.UbLCvAgMX1MxyqUaC2N3rrhN./P9sz6', 'https://cube.elemecdn.com/0/88/03b0d39583f48206768a7534e55bcpng.png', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, 1, NULL, NULL);
INSERT INTO `sys_user` VALUES (34, '租户-0511', '$2a$10$WF340hmlPNYaT2QfDFmqV.UbLCvAgMX1MxyqUaC2N3rrhN./P9sz6', 'https://cube.elemecdn.com/0/88/03b0d39583f48206768a7534e55bcpng.png', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, 1, NULL, NULL);
INSERT INTO `sys_user` VALUES (35, '租户-0512', '$2a$10$WF340hmlPNYaT2QfDFmqV.UbLCvAgMX1MxyqUaC2N3rrhN./P9sz6', 'https://cube.elemecdn.com/0/88/03b0d39583f48206768a7534e55bcpng.png', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, 1, NULL, NULL);
INSERT INTO `sys_user` VALUES (36, '租户-0513', '$2a$10$WF340hmlPNYaT2QfDFmqV.UbLCvAgMX1MxyqUaC2N3rrhN./P9sz6', 'https://cube.elemecdn.com/0/88/03b0d39583f48206768a7534e55bcpng.png', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, 1, NULL, NULL);
INSERT INTO `sys_user` VALUES (37, '租户-0514', '$2a$10$WF340hmlPNYaT2QfDFmqV.UbLCvAgMX1MxyqUaC2N3rrhN./P9sz6', 'https://cube.elemecdn.com/0/88/03b0d39583f48206768a7534e55bcpng.png', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, 1, NULL, NULL);
INSERT INTO `sys_user` VALUES (38, '租户-0515', '$2a$10$WF340hmlPNYaT2QfDFmqV.UbLCvAgMX1MxyqUaC2N3rrhN./P9sz6', 'https://cube.elemecdn.com/0/88/03b0d39583f48206768a7534e55bcpng.png', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, 1, NULL, NULL);
INSERT INTO `sys_user` VALUES (39, '租户-0516', '$2a$10$WF340hmlPNYaT2QfDFmqV.UbLCvAgMX1MxyqUaC2N3rrhN./P9sz6', 'https://cube.elemecdn.com/0/88/03b0d39583f48206768a7534e55bcpng.png', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, 1, NULL, NULL);
INSERT INTO `sys_user` VALUES (40, '租户-0517', '$2a$10$WF340hmlPNYaT2QfDFmqV.UbLCvAgMX1MxyqUaC2N3rrhN./P9sz6', 'https://cube.elemecdn.com/0/88/03b0d39583f48206768a7534e55bcpng.png', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, 1, NULL, NULL);
INSERT INTO `sys_user` VALUES (41, '租户-0518', '$2a$10$WF340hmlPNYaT2QfDFmqV.UbLCvAgMX1MxyqUaC2N3rrhN./P9sz6', 'https://cube.elemecdn.com/0/88/03b0d39583f48206768a7534e55bcpng.png', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, 1, NULL, NULL);
INSERT INTO `sys_user` VALUES (42, '租户-0519', '$2a$10$WF340hmlPNYaT2QfDFmqV.UbLCvAgMX1MxyqUaC2N3rrhN./P9sz6', 'https://cube.elemecdn.com/0/88/03b0d39583f48206768a7534e55bcpng.png', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, 1, NULL, NULL);
INSERT INTO `sys_user` VALUES (43, '租户-0520', '$2a$10$WF340hmlPNYaT2QfDFmqV.UbLCvAgMX1MxyqUaC2N3rrhN./P9sz6', 'https://cube.elemecdn.com/0/88/03b0d39583f48206768a7534e55bcpng.png', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-05-11 14:06:29', 1, NULL, 1, NULL, NULL);
INSERT INTO `sys_user` VALUES (44, '租户-0521', '$2a$10$WF340hmlPNYaT2QfDFmqV.UbLCvAgMX1MxyqUaC2N3rrhN./P9sz6', 'https://cube.elemecdn.com/0/88/03b0d39583f48206768a7534e55bcpng.png', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, 1, NULL, NULL);
INSERT INTO `sys_user` VALUES (45, '租户-0522', '$2a$10$WF340hmlPNYaT2QfDFmqV.UbLCvAgMX1MxyqUaC2N3rrhN./P9sz6', 'https://cube.elemecdn.com/0/88/03b0d39583f48206768a7534e55bcpng.png', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, 1, NULL, NULL);
INSERT INTO `sys_user` VALUES (46, '租户-0523', '$2a$10$WF340hmlPNYaT2QfDFmqV.UbLCvAgMX1MxyqUaC2N3rrhN./P9sz6', 'https://cube.elemecdn.com/0/88/03b0d39583f48206768a7534e55bcpng.png', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, 1, NULL, NULL);
INSERT INTO `sys_user` VALUES (47, '租户-0524', '$2a$10$WF340hmlPNYaT2QfDFmqV.UbLCvAgMX1MxyqUaC2N3rrhN./P9sz6', 'https://cube.elemecdn.com/0/88/03b0d39583f48206768a7534e55bcpng.png', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, 1, NULL, NULL);
INSERT INTO `sys_user` VALUES (48, '租户-0525', '$2a$10$WF340hmlPNYaT2QfDFmqV.UbLCvAgMX1MxyqUaC2N3rrhN./P9sz6', 'https://cube.elemecdn.com/0/88/03b0d39583f48206768a7534e55bcpng.png', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, 1, NULL, NULL);
INSERT INTO `sys_user` VALUES (49, '租户-0526', '$2a$10$WF340hmlPNYaT2QfDFmqV.UbLCvAgMX1MxyqUaC2N3rrhN./P9sz6', 'https://cube.elemecdn.com/0/88/03b0d39583f48206768a7534e55bcpng.png', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, 1, NULL, NULL);
INSERT INTO `sys_user` VALUES (50, '租户-0527', '$2a$10$WF340hmlPNYaT2QfDFmqV.UbLCvAgMX1MxyqUaC2N3rrhN./P9sz6', 'https://cube.elemecdn.com/0/88/03b0d39583f48206768a7534e55bcpng.png', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, 1, NULL, NULL);
INSERT INTO `sys_user` VALUES (51, '租户-0528', '$2a$10$WF340hmlPNYaT2QfDFmqV.UbLCvAgMX1MxyqUaC2N3rrhN./P9sz6', 'https://cube.elemecdn.com/0/88/03b0d39583f48206768a7534e55bcpng.png', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-05-11 14:04:15', 1, NULL, 1, NULL, NULL);
INSERT INTO `sys_user` VALUES (55, '啾啾', '$2a$10$f88TMe7dgjI8xvPLB/TZ5epekREMjeH6g/scrmLtIUtsPZgZb1O7u', 'https://glut-1.oss-cn-shenzhen.aliyuncs.com/rms/QQ图片20240516113348.gif', '766435465@qq.com', '19999999999', NULL, NULL, NULL, NULL, '2024-05-16 15:33:36', '2024-05-16 15:35:04', '2024-05-24 16:52:00', 1, NULL, 0, '450821200001012222', NULL);
INSERT INTO `sys_user` VALUES (57, '两人', '$2a$10$xJQ3MYf4nR1Oke5hN0Hf2en9Mfvw1C11W5Lyvb4LhrWQFeI.IyKkG', 'https://cube.elemecdn.com/0/88/03b0d39583f48206768a7534e55bcpng.png', '2183999518@qq.com', '19988889989', NULL, NULL, NULL, NULL, '2024-05-22 19:42:11', NULL, '2024-05-24 16:52:20', 1, NULL, 1, NULL, NULL);

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户角色表主键',
  `user_id` bigint NOT NULL COMMENT '（外键）用户id',
  `role_id` bigint NOT NULL DEFAULT 1 COMMENT '（外键）角色id',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `f_uid`(`user_id` ASC) USING BTREE,
  INDEX `f_rid`(`role_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 85 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户角色表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (32, 2, 3);
INSERT INTO `sys_user_role` VALUES (33, 10, 3);
INSERT INTO `sys_user_role` VALUES (34, 11, 3);
INSERT INTO `sys_user_role` VALUES (37, 1, 2);
INSERT INTO `sys_user_role` VALUES (39, 16, 1);
INSERT INTO `sys_user_role` VALUES (40, 18, 1);
INSERT INTO `sys_user_role` VALUES (41, 19, 1);
INSERT INTO `sys_user_role` VALUES (42, 20, 1);
INSERT INTO `sys_user_role` VALUES (43, 21, 1);
INSERT INTO `sys_user_role` VALUES (45, 24, 3);
INSERT INTO `sys_user_role` VALUES (47, 25, 1);
INSERT INTO `sys_user_role` VALUES (48, 26, 1);
INSERT INTO `sys_user_role` VALUES (49, 27, 1);
INSERT INTO `sys_user_role` VALUES (50, 28, 1);
INSERT INTO `sys_user_role` VALUES (51, 29, 1);
INSERT INTO `sys_user_role` VALUES (52, 30, 1);
INSERT INTO `sys_user_role` VALUES (53, 31, 1);
INSERT INTO `sys_user_role` VALUES (54, 32, 1);
INSERT INTO `sys_user_role` VALUES (55, 33, 1);
INSERT INTO `sys_user_role` VALUES (56, 34, 1);
INSERT INTO `sys_user_role` VALUES (57, 35, 1);
INSERT INTO `sys_user_role` VALUES (58, 36, 1);
INSERT INTO `sys_user_role` VALUES (59, 37, 1);
INSERT INTO `sys_user_role` VALUES (60, 17, 1);
INSERT INTO `sys_user_role` VALUES (61, 38, 1);
INSERT INTO `sys_user_role` VALUES (62, 39, 1);
INSERT INTO `sys_user_role` VALUES (63, 40, 1);
INSERT INTO `sys_user_role` VALUES (64, 41, 1);
INSERT INTO `sys_user_role` VALUES (65, 42, 1);
INSERT INTO `sys_user_role` VALUES (66, 44, 1);
INSERT INTO `sys_user_role` VALUES (67, 43, 1);
INSERT INTO `sys_user_role` VALUES (68, 45, 1);
INSERT INTO `sys_user_role` VALUES (69, 46, 1);
INSERT INTO `sys_user_role` VALUES (70, 47, 1);
INSERT INTO `sys_user_role` VALUES (71, 51, 1);
INSERT INTO `sys_user_role` VALUES (72, 50, 1);
INSERT INTO `sys_user_role` VALUES (73, 49, 1);
INSERT INTO `sys_user_role` VALUES (74, 48, 1);
INSERT INTO `sys_user_role` VALUES (77, 55, 1);
INSERT INTO `sys_user_role` VALUES (79, 12, 3);
INSERT INTO `sys_user_role` VALUES (80, 13, 3);
INSERT INTO `sys_user_role` VALUES (81, 14, 3);
INSERT INTO `sys_user_role` VALUES (82, 15, 3);
INSERT INTO `sys_user_role` VALUES (83, 57, 1);

-- ----------------------------
-- Table structure for test
-- ----------------------------
DROP TABLE IF EXISTS `test`;
CREATE TABLE `test`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `order_no` bigint NULL DEFAULT NULL,
  `alipay_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '阿里支付的支付号码',
  `create_time` datetime NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `payment_time` datetime NULL DEFAULT NULL COMMENT '支付时间',
  `status` int NOT NULL DEFAULT 0 COMMENT '0：未支付   1：已支付   2：已退款',
  `money` decimal(10, 3) NOT NULL DEFAULT 0.000 COMMENT '订单金额',
  `pay_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '支付方式',
  `house_id` bigint NULL DEFAULT NULL COMMENT '房屋的id',
  `owner_id` bigint NULL DEFAULT NULL COMMENT '房东id',
  `user_id` bigint NULL DEFAULT NULL COMMENT '租户id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1793208761677170546 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of test
-- ----------------------------

-- ----------------------------
-- Table structure for user_house_operation
-- ----------------------------
DROP TABLE IF EXISTS `user_house_operation`;
CREATE TABLE `user_house_operation`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NULL DEFAULT NULL,
  `item_id` bigint NULL DEFAULT NULL,
  `operation_type` int NULL DEFAULT NULL COMMENT '1浏览  2收藏',
  `create_time` datetime NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1446 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user_house_operation
-- ----------------------------
INSERT INTO `user_house_operation` VALUES (475, 16, 4, 1, '2024-05-24 13:07:44', NULL);
INSERT INTO `user_house_operation` VALUES (476, 16, 4, 2, '2024-05-24 13:07:45', NULL);
INSERT INTO `user_house_operation` VALUES (477, 16, 13, 1, '2024-05-24 13:36:13', NULL);
INSERT INTO `user_house_operation` VALUES (478, 16, 4, 1, '2024-05-24 13:36:15', NULL);
INSERT INTO `user_house_operation` VALUES (479, 16, 5, 1, '2024-05-24 13:36:18', NULL);
INSERT INTO `user_house_operation` VALUES (480, 16, 89, 1, '2024-05-24 14:47:55', NULL);
INSERT INTO `user_house_operation` VALUES (483, 16, 89, 1, '2024-05-24 14:48:15', NULL);
INSERT INTO `user_house_operation` VALUES (487, 16, 16, 2, '2024-05-24 14:49:38', NULL);
INSERT INTO `user_house_operation` VALUES (489, 16, 15, 2, '2024-05-24 14:49:48', NULL);
INSERT INTO `user_house_operation` VALUES (490, 16, 2, 1, '2024-05-24 14:49:58', NULL);
INSERT INTO `user_house_operation` VALUES (491, 16, 2, 2, '2024-05-24 14:50:00', NULL);
INSERT INTO `user_house_operation` VALUES (494, 17, 2, 1, NULL, NULL);
INSERT INTO `user_house_operation` VALUES (495, 18, 76, 1, NULL, NULL);
INSERT INTO `user_house_operation` VALUES (496, 19, 15, 2, NULL, NULL);
INSERT INTO `user_house_operation` VALUES (497, 17, 16, 2, NULL, NULL);
INSERT INTO `user_house_operation` VALUES (498, 18, 89, 1, NULL, NULL);
INSERT INTO `user_house_operation` VALUES (499, 19, 89, 2, NULL, NULL);
INSERT INTO `user_house_operation` VALUES (500, 17, 15, 2, NULL, NULL);
INSERT INTO `user_house_operation` VALUES (501, 18, 16, 2, NULL, NULL);
INSERT INTO `user_house_operation` VALUES (502, 19, 16, 1, NULL, NULL);
INSERT INTO `user_house_operation` VALUES (503, 17, 2, 1, NULL, NULL);
INSERT INTO `user_house_operation` VALUES (504, 18, 76, 2, NULL, NULL);
INSERT INTO `user_house_operation` VALUES (505, 19, 76, 1, NULL, NULL);
INSERT INTO `user_house_operation` VALUES (506, 16, 11, 1, '2024-05-24 16:40:49', NULL);
INSERT INTO `user_house_operation` VALUES (507, 16, 11, 1, '2024-05-24 16:41:40', NULL);
INSERT INTO `user_house_operation` VALUES (508, 57, 89, 1, '2024-05-24 16:48:24', NULL);
INSERT INTO `user_house_operation` VALUES (509, 16, 83, 1, '2024-05-24 20:18:46', NULL);
INSERT INTO `user_house_operation` VALUES (510, 16, 89, 1, '2024-05-24 20:18:59', NULL);
INSERT INTO `user_house_operation` VALUES (511, 16, 16, 1, '2024-05-24 20:34:24', NULL);
INSERT INTO `user_house_operation` VALUES (512, 16, 18, 1, '2024-05-24 20:34:27', NULL);
INSERT INTO `user_house_operation` VALUES (513, 16, 15, 1, '2024-05-24 20:34:30', NULL);
INSERT INTO `user_house_operation` VALUES (515, 16, 89, 1, '2024-05-24 20:34:36', NULL);
INSERT INTO `user_house_operation` VALUES (516, 24, 3, 1, '2024-05-26 16:53:29', NULL);
INSERT INTO `user_house_operation` VALUES (517, 24, 3, 1, '2024-05-26 16:55:59', NULL);
INSERT INTO `user_house_operation` VALUES (518, 24, 3, 1, '2024-05-26 16:56:04', NULL);
INSERT INTO `user_house_operation` VALUES (519, 24, 3, 1, '2024-05-26 16:56:06', NULL);
INSERT INTO `user_house_operation` VALUES (520, 24, 3, 1, '2024-05-26 16:56:10', NULL);
INSERT INTO `user_house_operation` VALUES (521, 24, 3, 1, '2024-05-26 16:56:24', NULL);
INSERT INTO `user_house_operation` VALUES (522, 24, 3, 1, '2024-05-26 16:56:48', NULL);
INSERT INTO `user_house_operation` VALUES (523, 24, 3, 1, '2024-05-26 16:56:54', NULL);
INSERT INTO `user_house_operation` VALUES (524, 24, 2, 1, '2024-05-26 16:57:54', NULL);
INSERT INTO `user_house_operation` VALUES (525, 24, 2, 1, '2024-05-26 19:04:02', NULL);
INSERT INTO `user_house_operation` VALUES (526, 24, 2, 1, '2024-05-26 19:08:20', NULL);
INSERT INTO `user_house_operation` VALUES (527, 24, 2, 1, '2024-05-26 19:08:28', NULL);
INSERT INTO `user_house_operation` VALUES (528, 24, 2, 1, '2024-05-26 19:09:19', NULL);
INSERT INTO `user_house_operation` VALUES (529, 24, 2, 1, '2024-05-26 19:09:56', NULL);
INSERT INTO `user_house_operation` VALUES (530, 24, 2, 1, '2024-05-26 19:11:01', NULL);
INSERT INTO `user_house_operation` VALUES (531, 24, 98, 1, '2024-05-26 19:31:19', NULL);
INSERT INTO `user_house_operation` VALUES (532, 24, 4, 1, '2024-05-26 19:34:35', NULL);
INSERT INTO `user_house_operation` VALUES (533, 24, 77, 1, '2024-05-26 19:38:38', NULL);
INSERT INTO `user_house_operation` VALUES (534, 24, 96, 1, '2024-05-26 19:39:17', NULL);
INSERT INTO `user_house_operation` VALUES (535, 24, 96, 1, '2024-05-26 19:39:47', NULL);
INSERT INTO `user_house_operation` VALUES (536, 24, 14, 1, '2024-05-26 19:57:52', NULL);
INSERT INTO `user_house_operation` VALUES (537, 24, 15, 1, '2024-05-26 19:57:57', NULL);
INSERT INTO `user_house_operation` VALUES (538, 24, 15, 1, '2024-05-26 19:58:18', NULL);
INSERT INTO `user_house_operation` VALUES (539, 24, 96, 1, '2024-05-26 20:26:09', NULL);
INSERT INTO `user_house_operation` VALUES (540, 24, 2, 1, '2024-05-26 20:40:17', NULL);
INSERT INTO `user_house_operation` VALUES (541, 24, 97, 1, '2024-05-26 20:42:20', NULL);
INSERT INTO `user_house_operation` VALUES (542, 24, 98, 1, '2024-05-26 20:42:41', NULL);
INSERT INTO `user_house_operation` VALUES (543, 24, 98, 1, '2024-05-26 20:43:34', NULL);
INSERT INTO `user_house_operation` VALUES (544, 24, 96, 1, '2024-05-26 20:44:39', NULL);
INSERT INTO `user_house_operation` VALUES (545, 24, 96, 1, '2024-05-26 20:44:44', NULL);
INSERT INTO `user_house_operation` VALUES (546, 24, 96, 1, '2024-05-26 20:45:23', NULL);
INSERT INTO `user_house_operation` VALUES (547, 24, 96, 1, '2024-05-26 20:45:38', NULL);
INSERT INTO `user_house_operation` VALUES (548, 24, 95, 1, '2024-05-27 00:03:31', NULL);
INSERT INTO `user_house_operation` VALUES (549, 24, 98, 1, '2024-05-27 00:03:47', NULL);
INSERT INTO `user_house_operation` VALUES (550, 16, 2, 1, '2024-05-27 10:50:41', NULL);
INSERT INTO `user_house_operation` VALUES (551, 24, 5, 1, '2024-05-27 17:26:43', NULL);
INSERT INTO `user_house_operation` VALUES (552, 24, 5, 1, '2024-05-27 17:27:13', NULL);
INSERT INTO `user_house_operation` VALUES (553, 24, 5, 1, '2024-05-27 20:58:35', NULL);
INSERT INTO `user_house_operation` VALUES (554, 24, 5, 1, '2024-05-27 22:09:22', NULL);
INSERT INTO `user_house_operation` VALUES (555, 24, 11, 1, '2024-05-28 00:45:54', NULL);
INSERT INTO `user_house_operation` VALUES (556, 24, 13, 1, '2024-05-28 00:46:05', NULL);
INSERT INTO `user_house_operation` VALUES (557, 24, 1, 1, '2024-05-28 00:47:40', NULL);
INSERT INTO `user_house_operation` VALUES (558, 24, 89, 1, '2024-05-28 01:06:01', NULL);
INSERT INTO `user_house_operation` VALUES (559, 24, 18, 1, '2024-05-28 09:32:25', NULL);
INSERT INTO `user_house_operation` VALUES (560, 24, 96, 1, '2024-05-28 09:46:51', NULL);
INSERT INTO `user_house_operation` VALUES (561, 24, 96, 1, '2024-05-28 09:47:16', NULL);
INSERT INTO `user_house_operation` VALUES (562, 24, 96, 1, '2024-05-28 10:05:39', NULL);
INSERT INTO `user_house_operation` VALUES (563, 24, 96, 1, '2024-05-28 10:05:43', NULL);
INSERT INTO `user_house_operation` VALUES (564, 24, 12, 1, '2024-05-29 09:59:54', NULL);
INSERT INTO `user_house_operation` VALUES (565, 24, 12, 1, '2024-05-29 10:00:04', NULL);
INSERT INTO `user_house_operation` VALUES (566, 24, 12, 1, '2024-05-29 10:00:35', NULL);
INSERT INTO `user_house_operation` VALUES (567, 24, 12, 1, '2024-05-29 12:26:44', NULL);
INSERT INTO `user_house_operation` VALUES (568, 24, 12, 1, '2024-05-29 12:26:47', NULL);
INSERT INTO `user_house_operation` VALUES (569, 24, 12, 1, '2024-05-29 12:26:54', NULL);
INSERT INTO `user_house_operation` VALUES (570, 24, 12, 1, '2024-05-29 12:27:45', NULL);
INSERT INTO `user_house_operation` VALUES (571, 24, 12, 1, '2024-05-29 12:28:32', NULL);
INSERT INTO `user_house_operation` VALUES (572, 24, 1, 1, '2024-05-29 12:28:55', NULL);
INSERT INTO `user_house_operation` VALUES (573, 10, 12, 1, '2024-05-29 12:49:48', NULL);
INSERT INTO `user_house_operation` VALUES (574, 10, 12, 1, '2024-05-29 12:49:48', NULL);
INSERT INTO `user_house_operation` VALUES (575, 10, 12, 1, '2024-05-29 12:49:48', NULL);
INSERT INTO `user_house_operation` VALUES (576, 10, 12, 1, '2024-05-29 12:49:48', NULL);
INSERT INTO `user_house_operation` VALUES (577, 10, 12, 1, '2024-05-29 12:49:48', NULL);
INSERT INTO `user_house_operation` VALUES (578, 10, 12, 1, '2024-05-29 12:49:48', NULL);
INSERT INTO `user_house_operation` VALUES (579, 10, 12, 1, '2024-05-29 12:49:48', NULL);
INSERT INTO `user_house_operation` VALUES (580, 10, 12, 1, '2024-05-29 12:49:48', NULL);
INSERT INTO `user_house_operation` VALUES (581, 10, 12, 1, '2024-05-29 12:49:48', NULL);
INSERT INTO `user_house_operation` VALUES (582, 10, 12, 1, '2024-05-29 12:49:48', NULL);
INSERT INTO `user_house_operation` VALUES (583, 10, 12, 1, '2024-05-29 12:49:48', NULL);
INSERT INTO `user_house_operation` VALUES (584, 10, 12, 1, '2024-05-29 12:49:48', NULL);
INSERT INTO `user_house_operation` VALUES (585, 10, 12, 1, '2024-05-29 12:49:48', NULL);
INSERT INTO `user_house_operation` VALUES (586, 10, 12, 1, '2024-05-29 12:49:49', NULL);
INSERT INTO `user_house_operation` VALUES (587, 10, 12, 1, '2024-05-29 12:49:49', NULL);
INSERT INTO `user_house_operation` VALUES (588, 10, 12, 1, '2024-05-29 12:49:49', NULL);
INSERT INTO `user_house_operation` VALUES (589, 10, 12, 1, '2024-05-29 12:49:49', NULL);
INSERT INTO `user_house_operation` VALUES (590, 10, 12, 1, '2024-05-29 12:49:49', NULL);
INSERT INTO `user_house_operation` VALUES (591, 10, 12, 1, '2024-05-29 12:49:50', NULL);
INSERT INTO `user_house_operation` VALUES (592, 10, 12, 1, '2024-05-29 12:49:50', NULL);
INSERT INTO `user_house_operation` VALUES (593, 10, 12, 1, '2024-05-29 12:49:50', NULL);
INSERT INTO `user_house_operation` VALUES (594, 10, 12, 1, '2024-05-29 12:49:50', NULL);
INSERT INTO `user_house_operation` VALUES (595, 10, 12, 1, '2024-05-29 12:49:50', NULL);
INSERT INTO `user_house_operation` VALUES (596, 10, 12, 1, '2024-05-29 12:49:50', NULL);
INSERT INTO `user_house_operation` VALUES (597, 10, 12, 1, '2024-05-29 12:49:50', NULL);
INSERT INTO `user_house_operation` VALUES (598, 10, 12, 1, '2024-05-29 12:49:50', NULL);
INSERT INTO `user_house_operation` VALUES (599, 10, 12, 1, '2024-05-29 12:49:51', NULL);
INSERT INTO `user_house_operation` VALUES (600, 10, 12, 1, '2024-05-29 12:49:51', NULL);
INSERT INTO `user_house_operation` VALUES (601, 10, 12, 1, '2024-05-29 12:49:51', NULL);
INSERT INTO `user_house_operation` VALUES (602, 10, 12, 1, '2024-05-29 12:49:51', NULL);
INSERT INTO `user_house_operation` VALUES (603, 10, 12, 1, '2024-05-29 12:49:51', NULL);
INSERT INTO `user_house_operation` VALUES (604, 10, 12, 1, '2024-05-29 12:49:51', NULL);
INSERT INTO `user_house_operation` VALUES (605, 10, 12, 1, '2024-05-29 12:49:51', NULL);
INSERT INTO `user_house_operation` VALUES (606, 10, 12, 1, '2024-05-29 12:49:51', NULL);
INSERT INTO `user_house_operation` VALUES (607, 10, 12, 1, '2024-05-29 12:49:51', NULL);
INSERT INTO `user_house_operation` VALUES (608, 10, 12, 1, '2024-05-29 12:49:51', NULL);
INSERT INTO `user_house_operation` VALUES (609, 10, 12, 1, '2024-05-29 12:49:52', NULL);
INSERT INTO `user_house_operation` VALUES (610, 10, 12, 1, '2024-05-29 12:49:52', NULL);
INSERT INTO `user_house_operation` VALUES (611, 10, 12, 1, '2024-05-29 12:49:52', NULL);
INSERT INTO `user_house_operation` VALUES (612, 10, 12, 1, '2024-05-29 12:49:52', NULL);
INSERT INTO `user_house_operation` VALUES (613, 10, 12, 1, '2024-05-29 12:49:52', NULL);
INSERT INTO `user_house_operation` VALUES (614, 10, 12, 1, '2024-05-29 12:49:52', NULL);
INSERT INTO `user_house_operation` VALUES (615, 10, 12, 1, '2024-05-29 12:49:52', NULL);
INSERT INTO `user_house_operation` VALUES (616, 10, 12, 1, '2024-05-29 12:49:52', NULL);
INSERT INTO `user_house_operation` VALUES (617, 10, 12, 1, '2024-05-29 12:49:52', NULL);
INSERT INTO `user_house_operation` VALUES (618, 10, 12, 1, '2024-05-29 12:49:52', NULL);
INSERT INTO `user_house_operation` VALUES (619, 10, 12, 1, '2024-05-29 12:49:53', NULL);
INSERT INTO `user_house_operation` VALUES (620, 10, 12, 1, '2024-05-29 12:49:53', NULL);
INSERT INTO `user_house_operation` VALUES (621, 10, 12, 1, '2024-05-29 12:49:53', NULL);
INSERT INTO `user_house_operation` VALUES (622, 10, 12, 1, '2024-05-29 12:49:53', NULL);
INSERT INTO `user_house_operation` VALUES (623, 10, 12, 1, '2024-05-29 12:49:53', NULL);
INSERT INTO `user_house_operation` VALUES (624, 10, 12, 1, '2024-05-29 12:49:53', NULL);
INSERT INTO `user_house_operation` VALUES (625, 10, 12, 1, '2024-05-29 12:49:53', NULL);
INSERT INTO `user_house_operation` VALUES (626, 10, 12, 1, '2024-05-29 12:49:53', NULL);
INSERT INTO `user_house_operation` VALUES (627, 10, 12, 1, '2024-05-29 12:49:53', NULL);
INSERT INTO `user_house_operation` VALUES (628, 10, 12, 1, '2024-05-29 12:49:53', NULL);
INSERT INTO `user_house_operation` VALUES (629, 10, 12, 1, '2024-05-29 12:49:54', NULL);
INSERT INTO `user_house_operation` VALUES (630, 10, 12, 1, '2024-05-29 12:49:54', NULL);
INSERT INTO `user_house_operation` VALUES (631, 10, 12, 1, '2024-05-29 12:49:54', NULL);
INSERT INTO `user_house_operation` VALUES (632, 10, 12, 1, '2024-05-29 12:49:54', NULL);
INSERT INTO `user_house_operation` VALUES (633, 10, 12, 1, '2024-05-29 12:49:54', NULL);
INSERT INTO `user_house_operation` VALUES (634, 10, 12, 1, '2024-05-29 12:49:54', NULL);
INSERT INTO `user_house_operation` VALUES (635, 10, 12, 1, '2024-05-29 12:49:54', NULL);
INSERT INTO `user_house_operation` VALUES (636, 10, 12, 1, '2024-05-29 12:49:54', NULL);
INSERT INTO `user_house_operation` VALUES (637, 10, 12, 1, '2024-05-29 12:49:55', NULL);
INSERT INTO `user_house_operation` VALUES (638, 10, 12, 1, '2024-05-29 12:49:55', NULL);
INSERT INTO `user_house_operation` VALUES (639, 10, 12, 1, '2024-05-29 12:49:55', NULL);
INSERT INTO `user_house_operation` VALUES (640, 10, 12, 1, '2024-05-29 12:49:55', NULL);
INSERT INTO `user_house_operation` VALUES (641, 10, 12, 1, '2024-05-29 12:49:55', NULL);
INSERT INTO `user_house_operation` VALUES (642, 10, 12, 1, '2024-05-29 12:49:55', NULL);
INSERT INTO `user_house_operation` VALUES (643, 10, 12, 1, '2024-05-29 12:49:55', NULL);
INSERT INTO `user_house_operation` VALUES (644, 10, 12, 1, '2024-05-29 12:49:55', NULL);
INSERT INTO `user_house_operation` VALUES (645, 10, 12, 1, '2024-05-29 12:49:56', NULL);
INSERT INTO `user_house_operation` VALUES (646, 10, 12, 1, '2024-05-29 12:49:56', NULL);
INSERT INTO `user_house_operation` VALUES (647, 10, 12, 1, '2024-05-29 12:49:56', NULL);
INSERT INTO `user_house_operation` VALUES (648, 10, 12, 1, '2024-05-29 12:49:56', NULL);
INSERT INTO `user_house_operation` VALUES (649, 10, 12, 1, '2024-05-29 12:49:56', NULL);
INSERT INTO `user_house_operation` VALUES (650, 10, 12, 1, '2024-05-29 12:49:56', NULL);
INSERT INTO `user_house_operation` VALUES (651, 10, 12, 1, '2024-05-29 12:49:56', NULL);
INSERT INTO `user_house_operation` VALUES (652, 10, 12, 1, '2024-05-29 12:49:56', NULL);
INSERT INTO `user_house_operation` VALUES (653, 10, 12, 1, '2024-05-29 12:49:57', NULL);
INSERT INTO `user_house_operation` VALUES (654, 10, 12, 1, '2024-05-29 12:49:57', NULL);
INSERT INTO `user_house_operation` VALUES (655, 10, 12, 1, '2024-05-29 12:49:57', NULL);
INSERT INTO `user_house_operation` VALUES (656, 10, 12, 1, '2024-05-29 12:49:57', NULL);
INSERT INTO `user_house_operation` VALUES (657, 10, 12, 1, '2024-05-29 12:49:57', NULL);
INSERT INTO `user_house_operation` VALUES (658, 10, 12, 1, '2024-05-29 12:49:57', NULL);
INSERT INTO `user_house_operation` VALUES (659, 10, 12, 1, '2024-05-29 12:49:57', NULL);
INSERT INTO `user_house_operation` VALUES (660, 10, 12, 1, '2024-05-29 12:49:57', NULL);
INSERT INTO `user_house_operation` VALUES (661, 10, 12, 1, '2024-05-29 12:49:58', NULL);
INSERT INTO `user_house_operation` VALUES (662, 10, 12, 1, '2024-05-29 12:49:58', NULL);
INSERT INTO `user_house_operation` VALUES (663, 10, 12, 1, '2024-05-29 12:49:58', NULL);
INSERT INTO `user_house_operation` VALUES (664, 10, 12, 1, '2024-05-29 12:49:58', NULL);
INSERT INTO `user_house_operation` VALUES (665, 10, 12, 1, '2024-05-29 12:49:58', NULL);
INSERT INTO `user_house_operation` VALUES (666, 10, 12, 1, '2024-05-29 12:49:58', NULL);
INSERT INTO `user_house_operation` VALUES (667, 10, 12, 1, '2024-05-29 12:49:58', NULL);
INSERT INTO `user_house_operation` VALUES (668, 10, 12, 1, '2024-05-29 12:49:58', NULL);
INSERT INTO `user_house_operation` VALUES (669, 10, 12, 1, '2024-05-29 12:49:58', NULL);
INSERT INTO `user_house_operation` VALUES (670, 10, 12, 1, '2024-05-29 12:49:59', NULL);
INSERT INTO `user_house_operation` VALUES (671, 10, 12, 1, '2024-05-29 12:49:59', NULL);
INSERT INTO `user_house_operation` VALUES (672, 10, 12, 1, '2024-05-29 12:49:59', NULL);
INSERT INTO `user_house_operation` VALUES (673, 10, 12, 1, '2024-05-29 12:49:59', NULL);
INSERT INTO `user_house_operation` VALUES (674, 10, 12, 1, '2024-05-29 12:49:59', NULL);
INSERT INTO `user_house_operation` VALUES (675, 10, 12, 1, '2024-05-29 12:49:59', NULL);
INSERT INTO `user_house_operation` VALUES (676, 10, 12, 1, '2024-05-29 12:49:59', NULL);
INSERT INTO `user_house_operation` VALUES (677, 10, 12, 1, '2024-05-29 12:49:59', NULL);
INSERT INTO `user_house_operation` VALUES (678, 10, 12, 1, '2024-05-29 12:49:59', NULL);
INSERT INTO `user_house_operation` VALUES (679, 10, 12, 1, '2024-05-29 12:49:59', NULL);
INSERT INTO `user_house_operation` VALUES (680, 10, 12, 1, '2024-05-29 12:50:00', NULL);
INSERT INTO `user_house_operation` VALUES (681, 10, 12, 1, '2024-05-29 12:50:00', NULL);
INSERT INTO `user_house_operation` VALUES (682, 10, 12, 1, '2024-05-29 12:50:00', NULL);
INSERT INTO `user_house_operation` VALUES (683, 10, 12, 1, '2024-05-29 12:50:00', NULL);
INSERT INTO `user_house_operation` VALUES (684, 10, 12, 1, '2024-05-29 12:50:00', NULL);
INSERT INTO `user_house_operation` VALUES (685, 10, 12, 1, '2024-05-29 12:50:00', NULL);
INSERT INTO `user_house_operation` VALUES (686, 10, 12, 1, '2024-05-29 12:50:00', NULL);
INSERT INTO `user_house_operation` VALUES (687, 10, 12, 1, '2024-05-29 12:50:00', NULL);
INSERT INTO `user_house_operation` VALUES (688, 10, 12, 1, '2024-05-29 12:50:00', NULL);
INSERT INTO `user_house_operation` VALUES (689, 10, 12, 1, '2024-05-29 12:50:00', NULL);
INSERT INTO `user_house_operation` VALUES (690, 10, 12, 1, '2024-05-29 12:50:01', NULL);
INSERT INTO `user_house_operation` VALUES (691, 10, 12, 1, '2024-05-29 12:50:01', NULL);
INSERT INTO `user_house_operation` VALUES (692, 10, 12, 1, '2024-05-29 12:50:01', NULL);
INSERT INTO `user_house_operation` VALUES (693, 10, 12, 1, '2024-05-29 12:50:01', NULL);
INSERT INTO `user_house_operation` VALUES (694, 10, 12, 1, '2024-05-29 12:50:01', NULL);
INSERT INTO `user_house_operation` VALUES (695, 10, 12, 1, '2024-05-29 12:50:01', NULL);
INSERT INTO `user_house_operation` VALUES (696, 10, 12, 1, '2024-05-29 12:50:01', NULL);
INSERT INTO `user_house_operation` VALUES (697, 10, 12, 1, '2024-05-29 12:50:01', NULL);
INSERT INTO `user_house_operation` VALUES (698, 10, 12, 1, '2024-05-29 12:50:01', NULL);
INSERT INTO `user_house_operation` VALUES (699, 10, 12, 1, '2024-05-29 12:50:02', NULL);
INSERT INTO `user_house_operation` VALUES (700, 10, 12, 1, '2024-05-29 12:50:02', NULL);
INSERT INTO `user_house_operation` VALUES (701, 10, 12, 1, '2024-05-29 12:50:02', NULL);
INSERT INTO `user_house_operation` VALUES (702, 10, 12, 1, '2024-05-29 12:50:02', NULL);
INSERT INTO `user_house_operation` VALUES (703, 10, 12, 1, '2024-05-29 12:50:02', NULL);
INSERT INTO `user_house_operation` VALUES (704, 10, 12, 1, '2024-05-29 12:50:02', NULL);
INSERT INTO `user_house_operation` VALUES (705, 10, 12, 1, '2024-05-29 12:50:02', NULL);
INSERT INTO `user_house_operation` VALUES (706, 10, 12, 1, '2024-05-29 12:50:02', NULL);
INSERT INTO `user_house_operation` VALUES (707, 10, 12, 1, '2024-05-29 12:50:03', NULL);
INSERT INTO `user_house_operation` VALUES (708, 10, 12, 1, '2024-05-29 12:50:03', NULL);
INSERT INTO `user_house_operation` VALUES (709, 10, 12, 1, '2024-05-29 12:50:03', NULL);
INSERT INTO `user_house_operation` VALUES (710, 10, 12, 1, '2024-05-29 12:50:03', NULL);
INSERT INTO `user_house_operation` VALUES (711, 10, 12, 1, '2024-05-29 12:50:03', NULL);
INSERT INTO `user_house_operation` VALUES (712, 10, 12, 1, '2024-05-29 12:50:03', NULL);
INSERT INTO `user_house_operation` VALUES (713, 10, 12, 1, '2024-05-29 12:50:03', NULL);
INSERT INTO `user_house_operation` VALUES (714, 10, 12, 1, '2024-05-29 12:50:04', NULL);
INSERT INTO `user_house_operation` VALUES (715, 10, 12, 1, '2024-05-29 12:50:04', NULL);
INSERT INTO `user_house_operation` VALUES (716, 10, 12, 1, '2024-05-29 12:50:04', NULL);
INSERT INTO `user_house_operation` VALUES (717, 10, 12, 1, '2024-05-29 12:50:04', NULL);
INSERT INTO `user_house_operation` VALUES (718, 10, 12, 1, '2024-05-29 12:50:04', NULL);
INSERT INTO `user_house_operation` VALUES (719, 10, 12, 1, '2024-05-29 12:50:04', NULL);
INSERT INTO `user_house_operation` VALUES (720, 10, 12, 1, '2024-05-29 12:50:04', NULL);
INSERT INTO `user_house_operation` VALUES (721, 10, 12, 1, '2024-05-29 12:50:04', NULL);
INSERT INTO `user_house_operation` VALUES (722, 10, 12, 1, '2024-05-29 12:50:04', NULL);
INSERT INTO `user_house_operation` VALUES (723, 10, 12, 1, '2024-05-29 12:50:05', NULL);
INSERT INTO `user_house_operation` VALUES (724, 10, 12, 1, '2024-05-29 12:50:05', NULL);
INSERT INTO `user_house_operation` VALUES (725, 10, 12, 1, '2024-05-29 12:50:05', NULL);
INSERT INTO `user_house_operation` VALUES (726, 10, 12, 1, '2024-05-29 12:50:05', NULL);
INSERT INTO `user_house_operation` VALUES (727, 10, 12, 1, '2024-05-29 12:50:05', NULL);
INSERT INTO `user_house_operation` VALUES (728, 10, 12, 1, '2024-05-29 12:50:05', NULL);
INSERT INTO `user_house_operation` VALUES (729, 10, 12, 1, '2024-05-29 12:50:05', NULL);
INSERT INTO `user_house_operation` VALUES (730, 10, 12, 1, '2024-05-29 12:50:05', NULL);
INSERT INTO `user_house_operation` VALUES (731, 10, 12, 1, '2024-05-29 12:50:05', NULL);
INSERT INTO `user_house_operation` VALUES (732, 10, 12, 1, '2024-05-29 12:50:05', NULL);
INSERT INTO `user_house_operation` VALUES (733, 10, 12, 1, '2024-05-29 12:50:06', NULL);
INSERT INTO `user_house_operation` VALUES (734, 10, 12, 1, '2024-05-29 12:50:06', NULL);
INSERT INTO `user_house_operation` VALUES (735, 10, 12, 1, '2024-05-29 12:50:06', NULL);
INSERT INTO `user_house_operation` VALUES (736, 10, 12, 1, '2024-05-29 12:50:06', NULL);
INSERT INTO `user_house_operation` VALUES (737, 10, 12, 1, '2024-05-29 12:50:06', NULL);
INSERT INTO `user_house_operation` VALUES (738, 10, 12, 1, '2024-05-29 12:50:06', NULL);
INSERT INTO `user_house_operation` VALUES (739, 10, 12, 1, '2024-05-29 12:50:06', NULL);
INSERT INTO `user_house_operation` VALUES (740, 10, 12, 1, '2024-05-29 12:50:06', NULL);
INSERT INTO `user_house_operation` VALUES (741, 10, 12, 1, '2024-05-29 12:50:06', NULL);
INSERT INTO `user_house_operation` VALUES (742, 10, 12, 1, '2024-05-29 12:50:06', NULL);
INSERT INTO `user_house_operation` VALUES (743, 10, 12, 1, '2024-05-29 12:50:07', NULL);
INSERT INTO `user_house_operation` VALUES (744, 10, 12, 1, '2024-05-29 12:50:07', NULL);
INSERT INTO `user_house_operation` VALUES (745, 10, 12, 1, '2024-05-29 12:50:07', NULL);
INSERT INTO `user_house_operation` VALUES (746, 10, 12, 1, '2024-05-29 12:50:07', NULL);
INSERT INTO `user_house_operation` VALUES (747, 10, 12, 1, '2024-05-29 12:50:07', NULL);
INSERT INTO `user_house_operation` VALUES (748, 10, 12, 1, '2024-05-29 12:50:07', NULL);
INSERT INTO `user_house_operation` VALUES (749, 10, 12, 1, '2024-05-29 12:50:07', NULL);
INSERT INTO `user_house_operation` VALUES (750, 10, 12, 1, '2024-05-29 12:50:07', NULL);
INSERT INTO `user_house_operation` VALUES (751, 10, 12, 1, '2024-05-29 12:50:07', NULL);
INSERT INTO `user_house_operation` VALUES (752, 10, 12, 1, '2024-05-29 12:50:07', NULL);
INSERT INTO `user_house_operation` VALUES (753, 10, 12, 1, '2024-05-29 12:50:07', NULL);
INSERT INTO `user_house_operation` VALUES (754, 10, 12, 1, '2024-05-29 12:50:08', NULL);
INSERT INTO `user_house_operation` VALUES (755, 10, 12, 1, '2024-05-29 12:50:08', NULL);
INSERT INTO `user_house_operation` VALUES (756, 10, 12, 1, '2024-05-29 12:50:08', NULL);
INSERT INTO `user_house_operation` VALUES (757, 10, 12, 1, '2024-05-29 12:50:08', NULL);
INSERT INTO `user_house_operation` VALUES (758, 10, 12, 1, '2024-05-29 12:50:08', NULL);
INSERT INTO `user_house_operation` VALUES (759, 10, 12, 1, '2024-05-29 12:50:08', NULL);
INSERT INTO `user_house_operation` VALUES (760, 10, 12, 1, '2024-05-29 12:50:08', NULL);
INSERT INTO `user_house_operation` VALUES (761, 10, 12, 1, '2024-05-29 12:50:08', NULL);
INSERT INTO `user_house_operation` VALUES (762, 10, 12, 1, '2024-05-29 12:50:09', NULL);
INSERT INTO `user_house_operation` VALUES (763, 10, 12, 1, '2024-05-29 12:50:09', NULL);
INSERT INTO `user_house_operation` VALUES (764, 10, 12, 1, '2024-05-29 12:50:09', NULL);
INSERT INTO `user_house_operation` VALUES (765, 10, 12, 1, '2024-05-29 12:50:09', NULL);
INSERT INTO `user_house_operation` VALUES (766, 10, 12, 1, '2024-05-29 12:50:09', NULL);
INSERT INTO `user_house_operation` VALUES (767, 10, 12, 1, '2024-05-29 12:50:09', NULL);
INSERT INTO `user_house_operation` VALUES (768, 10, 12, 1, '2024-05-29 12:50:09', NULL);
INSERT INTO `user_house_operation` VALUES (769, 10, 12, 1, '2024-05-29 12:50:09', NULL);
INSERT INTO `user_house_operation` VALUES (770, 10, 12, 1, '2024-05-29 12:50:10', NULL);
INSERT INTO `user_house_operation` VALUES (771, 10, 12, 1, '2024-05-29 12:50:10', NULL);
INSERT INTO `user_house_operation` VALUES (772, 10, 12, 1, '2024-05-29 12:50:10', NULL);
INSERT INTO `user_house_operation` VALUES (773, 10, 12, 1, '2024-05-29 12:50:10', NULL);
INSERT INTO `user_house_operation` VALUES (774, 10, 12, 1, '2024-05-29 12:50:10', NULL);
INSERT INTO `user_house_operation` VALUES (775, 10, 12, 1, '2024-05-29 12:50:10', NULL);
INSERT INTO `user_house_operation` VALUES (776, 10, 12, 1, '2024-05-29 12:50:10', NULL);
INSERT INTO `user_house_operation` VALUES (777, 10, 12, 1, '2024-05-29 12:50:10', NULL);
INSERT INTO `user_house_operation` VALUES (778, 10, 12, 1, '2024-05-29 12:50:11', NULL);
INSERT INTO `user_house_operation` VALUES (779, 10, 12, 1, '2024-05-29 12:50:11', NULL);
INSERT INTO `user_house_operation` VALUES (780, 10, 12, 1, '2024-05-29 12:50:11', NULL);
INSERT INTO `user_house_operation` VALUES (781, 10, 12, 1, '2024-05-29 12:50:11', NULL);
INSERT INTO `user_house_operation` VALUES (782, 10, 12, 1, '2024-05-29 12:50:11', NULL);
INSERT INTO `user_house_operation` VALUES (783, 10, 12, 1, '2024-05-29 12:50:11', NULL);
INSERT INTO `user_house_operation` VALUES (784, 10, 12, 1, '2024-05-29 12:50:11', NULL);
INSERT INTO `user_house_operation` VALUES (785, 10, 12, 1, '2024-05-29 12:50:11', NULL);
INSERT INTO `user_house_operation` VALUES (786, 10, 12, 1, '2024-05-29 12:50:11', NULL);
INSERT INTO `user_house_operation` VALUES (787, 10, 12, 1, '2024-05-29 12:50:12', NULL);
INSERT INTO `user_house_operation` VALUES (788, 10, 12, 1, '2024-05-29 12:50:12', NULL);
INSERT INTO `user_house_operation` VALUES (789, 10, 12, 1, '2024-05-29 12:50:12', NULL);
INSERT INTO `user_house_operation` VALUES (790, 10, 12, 1, '2024-05-29 12:50:12', NULL);
INSERT INTO `user_house_operation` VALUES (791, 10, 12, 1, '2024-05-29 12:50:12', NULL);
INSERT INTO `user_house_operation` VALUES (792, 10, 12, 1, '2024-05-29 12:50:12', NULL);
INSERT INTO `user_house_operation` VALUES (793, 10, 12, 1, '2024-05-29 12:50:12', NULL);
INSERT INTO `user_house_operation` VALUES (794, 10, 12, 1, '2024-05-29 12:50:12', NULL);
INSERT INTO `user_house_operation` VALUES (795, 10, 12, 1, '2024-05-29 12:50:13', NULL);
INSERT INTO `user_house_operation` VALUES (796, 10, 12, 1, '2024-05-29 12:50:13', NULL);
INSERT INTO `user_house_operation` VALUES (797, 10, 12, 1, '2024-05-29 12:50:13', NULL);
INSERT INTO `user_house_operation` VALUES (798, 10, 12, 1, '2024-05-29 12:50:13', NULL);
INSERT INTO `user_house_operation` VALUES (799, 10, 12, 1, '2024-05-29 12:50:13', NULL);
INSERT INTO `user_house_operation` VALUES (800, 10, 12, 1, '2024-05-29 12:50:13', NULL);
INSERT INTO `user_house_operation` VALUES (801, 10, 12, 1, '2024-05-29 12:50:13', NULL);
INSERT INTO `user_house_operation` VALUES (802, 10, 12, 1, '2024-05-29 12:50:13', NULL);
INSERT INTO `user_house_operation` VALUES (803, 10, 12, 1, '2024-05-29 12:50:13', NULL);
INSERT INTO `user_house_operation` VALUES (804, 10, 12, 1, '2024-05-29 12:50:13', NULL);
INSERT INTO `user_house_operation` VALUES (805, 10, 12, 1, '2024-05-29 12:50:13', NULL);
INSERT INTO `user_house_operation` VALUES (806, 10, 12, 1, '2024-05-29 12:50:14', NULL);
INSERT INTO `user_house_operation` VALUES (807, 10, 12, 1, '2024-05-29 12:50:14', NULL);
INSERT INTO `user_house_operation` VALUES (808, 10, 12, 1, '2024-05-29 12:50:14', NULL);
INSERT INTO `user_house_operation` VALUES (809, 10, 12, 1, '2024-05-29 12:50:14', NULL);
INSERT INTO `user_house_operation` VALUES (810, 10, 12, 1, '2024-05-29 12:50:14', NULL);
INSERT INTO `user_house_operation` VALUES (811, 10, 12, 1, '2024-05-29 12:50:14', NULL);
INSERT INTO `user_house_operation` VALUES (812, 10, 12, 1, '2024-05-29 12:50:14', NULL);
INSERT INTO `user_house_operation` VALUES (813, 10, 12, 1, '2024-05-29 12:50:14', NULL);
INSERT INTO `user_house_operation` VALUES (814, 10, 12, 1, '2024-05-29 12:50:14', NULL);
INSERT INTO `user_house_operation` VALUES (815, 10, 12, 1, '2024-05-29 12:50:15', NULL);
INSERT INTO `user_house_operation` VALUES (816, 10, 12, 1, '2024-05-29 12:50:15', NULL);
INSERT INTO `user_house_operation` VALUES (817, 10, 12, 1, '2024-05-29 12:50:15', NULL);
INSERT INTO `user_house_operation` VALUES (818, 10, 12, 1, '2024-05-29 12:50:15', NULL);
INSERT INTO `user_house_operation` VALUES (819, 10, 12, 1, '2024-05-29 12:50:15', NULL);
INSERT INTO `user_house_operation` VALUES (820, 10, 12, 1, '2024-05-29 12:50:15', NULL);
INSERT INTO `user_house_operation` VALUES (821, 10, 12, 1, '2024-05-29 12:50:15', NULL);
INSERT INTO `user_house_operation` VALUES (822, 10, 12, 1, '2024-05-29 12:50:15', NULL);
INSERT INTO `user_house_operation` VALUES (823, 10, 12, 1, '2024-05-29 12:50:15', NULL);
INSERT INTO `user_house_operation` VALUES (824, 10, 12, 1, '2024-05-29 12:50:15', NULL);
INSERT INTO `user_house_operation` VALUES (825, 10, 12, 1, '2024-05-29 12:50:16', NULL);
INSERT INTO `user_house_operation` VALUES (826, 10, 12, 1, '2024-05-29 12:50:16', NULL);
INSERT INTO `user_house_operation` VALUES (827, 10, 12, 1, '2024-05-29 12:50:16', NULL);
INSERT INTO `user_house_operation` VALUES (828, 10, 12, 1, '2024-05-29 12:50:16', NULL);
INSERT INTO `user_house_operation` VALUES (829, 10, 12, 1, '2024-05-29 12:50:16', NULL);
INSERT INTO `user_house_operation` VALUES (830, 10, 12, 1, '2024-05-29 12:50:16', NULL);
INSERT INTO `user_house_operation` VALUES (831, 10, 12, 1, '2024-05-29 12:50:16', NULL);
INSERT INTO `user_house_operation` VALUES (832, 10, 12, 1, '2024-05-29 12:50:16', NULL);
INSERT INTO `user_house_operation` VALUES (833, 10, 12, 1, '2024-05-29 12:50:17', NULL);
INSERT INTO `user_house_operation` VALUES (834, 10, 12, 1, '2024-05-29 12:50:17', NULL);
INSERT INTO `user_house_operation` VALUES (835, 10, 12, 1, '2024-05-29 12:50:17', NULL);
INSERT INTO `user_house_operation` VALUES (836, 10, 12, 1, '2024-05-29 12:50:17', NULL);
INSERT INTO `user_house_operation` VALUES (837, 10, 12, 1, '2024-05-29 12:50:17', NULL);
INSERT INTO `user_house_operation` VALUES (838, 10, 12, 1, '2024-05-29 12:50:17', NULL);
INSERT INTO `user_house_operation` VALUES (839, 10, 12, 1, '2024-05-29 12:50:17', NULL);
INSERT INTO `user_house_operation` VALUES (840, 10, 12, 1, '2024-05-29 12:50:17', NULL);
INSERT INTO `user_house_operation` VALUES (841, 10, 12, 1, '2024-05-29 12:50:17', NULL);
INSERT INTO `user_house_operation` VALUES (842, 10, 12, 1, '2024-05-29 12:50:18', NULL);
INSERT INTO `user_house_operation` VALUES (843, 10, 12, 1, '2024-05-29 12:50:18', NULL);
INSERT INTO `user_house_operation` VALUES (844, 10, 12, 1, '2024-05-29 12:50:18', NULL);
INSERT INTO `user_house_operation` VALUES (845, 10, 12, 1, '2024-05-29 12:50:18', NULL);
INSERT INTO `user_house_operation` VALUES (846, 10, 12, 1, '2024-05-29 12:50:18', NULL);
INSERT INTO `user_house_operation` VALUES (847, 10, 12, 1, '2024-05-29 12:50:18', NULL);
INSERT INTO `user_house_operation` VALUES (848, 10, 12, 1, '2024-05-29 12:50:18', NULL);
INSERT INTO `user_house_operation` VALUES (849, 10, 12, 1, '2024-05-29 12:50:18', NULL);
INSERT INTO `user_house_operation` VALUES (850, 10, 12, 1, '2024-05-29 12:50:19', NULL);
INSERT INTO `user_house_operation` VALUES (851, 10, 12, 1, '2024-05-29 12:50:19', NULL);
INSERT INTO `user_house_operation` VALUES (852, 10, 12, 1, '2024-05-29 12:50:19', NULL);
INSERT INTO `user_house_operation` VALUES (853, 10, 12, 1, '2024-05-29 12:50:19', NULL);
INSERT INTO `user_house_operation` VALUES (854, 10, 12, 1, '2024-05-29 12:50:19', NULL);
INSERT INTO `user_house_operation` VALUES (855, 10, 12, 1, '2024-05-29 12:50:19', NULL);
INSERT INTO `user_house_operation` VALUES (856, 10, 12, 1, '2024-05-29 12:50:19', NULL);
INSERT INTO `user_house_operation` VALUES (857, 10, 12, 1, '2024-05-29 12:50:19', NULL);
INSERT INTO `user_house_operation` VALUES (858, 10, 12, 1, '2024-05-29 12:50:20', NULL);
INSERT INTO `user_house_operation` VALUES (859, 10, 12, 1, '2024-05-29 12:50:20', NULL);
INSERT INTO `user_house_operation` VALUES (860, 10, 12, 1, '2024-05-29 12:50:20', NULL);
INSERT INTO `user_house_operation` VALUES (861, 10, 12, 1, '2024-05-29 12:50:20', NULL);
INSERT INTO `user_house_operation` VALUES (862, 10, 12, 1, '2024-05-29 12:50:20', NULL);
INSERT INTO `user_house_operation` VALUES (863, 10, 12, 1, '2024-05-29 12:50:20', NULL);
INSERT INTO `user_house_operation` VALUES (864, 10, 12, 1, '2024-05-29 12:50:20', NULL);
INSERT INTO `user_house_operation` VALUES (865, 10, 12, 1, '2024-05-29 12:50:20', NULL);
INSERT INTO `user_house_operation` VALUES (866, 10, 12, 1, '2024-05-29 12:50:21', NULL);
INSERT INTO `user_house_operation` VALUES (867, 10, 12, 1, '2024-05-29 12:50:21', NULL);
INSERT INTO `user_house_operation` VALUES (868, 10, 12, 1, '2024-05-29 12:50:21', NULL);
INSERT INTO `user_house_operation` VALUES (869, 10, 12, 1, '2024-05-29 12:50:21', NULL);
INSERT INTO `user_house_operation` VALUES (870, 10, 12, 1, '2024-05-29 12:50:21', NULL);
INSERT INTO `user_house_operation` VALUES (871, 10, 12, 1, '2024-05-29 12:50:21', NULL);
INSERT INTO `user_house_operation` VALUES (872, 10, 12, 1, '2024-05-29 12:50:21', NULL);
INSERT INTO `user_house_operation` VALUES (873, 10, 12, 1, '2024-05-29 12:50:21', NULL);
INSERT INTO `user_house_operation` VALUES (874, 10, 12, 1, '2024-05-29 12:50:21', NULL);
INSERT INTO `user_house_operation` VALUES (875, 10, 12, 1, '2024-05-29 12:50:21', NULL);
INSERT INTO `user_house_operation` VALUES (876, 10, 12, 1, '2024-05-29 12:50:22', NULL);
INSERT INTO `user_house_operation` VALUES (877, 10, 12, 1, '2024-05-29 12:50:22', NULL);
INSERT INTO `user_house_operation` VALUES (878, 10, 12, 1, '2024-05-29 12:50:22', NULL);
INSERT INTO `user_house_operation` VALUES (879, 10, 12, 1, '2024-05-29 12:50:22', NULL);
INSERT INTO `user_house_operation` VALUES (880, 10, 12, 1, '2024-05-29 12:50:22', NULL);
INSERT INTO `user_house_operation` VALUES (881, 10, 12, 1, '2024-05-29 12:50:22', NULL);
INSERT INTO `user_house_operation` VALUES (882, 10, 12, 1, '2024-05-29 12:50:22', NULL);
INSERT INTO `user_house_operation` VALUES (883, 10, 12, 1, '2024-05-29 12:50:22', NULL);
INSERT INTO `user_house_operation` VALUES (884, 10, 12, 1, '2024-05-29 12:50:23', NULL);
INSERT INTO `user_house_operation` VALUES (885, 10, 12, 1, '2024-05-29 12:50:23', NULL);
INSERT INTO `user_house_operation` VALUES (886, 10, 12, 1, '2024-05-29 12:50:23', NULL);
INSERT INTO `user_house_operation` VALUES (887, 10, 12, 1, '2024-05-29 12:50:23', NULL);
INSERT INTO `user_house_operation` VALUES (888, 10, 12, 1, '2024-05-29 12:50:23', NULL);
INSERT INTO `user_house_operation` VALUES (889, 10, 12, 1, '2024-05-29 12:50:23', NULL);
INSERT INTO `user_house_operation` VALUES (890, 10, 12, 1, '2024-05-29 12:50:23', NULL);
INSERT INTO `user_house_operation` VALUES (891, 10, 12, 1, '2024-05-29 12:50:23', NULL);
INSERT INTO `user_house_operation` VALUES (892, 10, 12, 1, '2024-05-29 12:50:23', NULL);
INSERT INTO `user_house_operation` VALUES (893, 10, 12, 1, '2024-05-29 12:50:24', NULL);
INSERT INTO `user_house_operation` VALUES (894, 10, 12, 1, '2024-05-29 12:50:24', NULL);
INSERT INTO `user_house_operation` VALUES (895, 10, 12, 1, '2024-05-29 12:50:24', NULL);
INSERT INTO `user_house_operation` VALUES (896, 10, 12, 1, '2024-05-29 12:50:24', NULL);
INSERT INTO `user_house_operation` VALUES (897, 10, 12, 1, '2024-05-29 12:50:24', NULL);
INSERT INTO `user_house_operation` VALUES (898, 10, 12, 1, '2024-05-29 12:50:24', NULL);
INSERT INTO `user_house_operation` VALUES (899, 10, 12, 1, '2024-05-29 12:50:24', NULL);
INSERT INTO `user_house_operation` VALUES (900, 10, 12, 1, '2024-05-29 12:50:25', NULL);
INSERT INTO `user_house_operation` VALUES (901, 10, 12, 1, '2024-05-29 12:50:25', NULL);
INSERT INTO `user_house_operation` VALUES (902, 10, 12, 1, '2024-05-29 12:50:25', NULL);
INSERT INTO `user_house_operation` VALUES (903, 10, 12, 1, '2024-05-29 12:50:25', NULL);
INSERT INTO `user_house_operation` VALUES (904, 10, 12, 1, '2024-05-29 12:50:25', NULL);
INSERT INTO `user_house_operation` VALUES (905, 10, 12, 1, '2024-05-29 12:50:25', NULL);
INSERT INTO `user_house_operation` VALUES (906, 10, 12, 1, '2024-05-29 12:50:25', NULL);
INSERT INTO `user_house_operation` VALUES (907, 10, 12, 1, '2024-05-29 12:50:26', NULL);
INSERT INTO `user_house_operation` VALUES (908, 10, 12, 1, '2024-05-29 12:50:26', NULL);
INSERT INTO `user_house_operation` VALUES (909, 10, 12, 1, '2024-05-29 12:50:26', NULL);
INSERT INTO `user_house_operation` VALUES (910, 10, 12, 1, '2024-05-29 12:50:26', NULL);
INSERT INTO `user_house_operation` VALUES (911, 10, 12, 1, '2024-05-29 12:50:26', NULL);
INSERT INTO `user_house_operation` VALUES (912, 10, 12, 1, '2024-05-29 12:50:26', NULL);
INSERT INTO `user_house_operation` VALUES (913, 10, 12, 1, '2024-05-29 12:50:26', NULL);
INSERT INTO `user_house_operation` VALUES (914, 10, 12, 1, '2024-05-29 12:50:27', NULL);
INSERT INTO `user_house_operation` VALUES (915, 10, 12, 1, '2024-05-29 12:50:27', NULL);
INSERT INTO `user_house_operation` VALUES (916, 10, 12, 1, '2024-05-29 12:50:27', NULL);
INSERT INTO `user_house_operation` VALUES (917, 10, 12, 1, '2024-05-29 12:50:27', NULL);
INSERT INTO `user_house_operation` VALUES (918, 10, 12, 1, '2024-05-29 12:50:27', NULL);
INSERT INTO `user_house_operation` VALUES (919, 10, 12, 1, '2024-05-29 12:50:27', NULL);
INSERT INTO `user_house_operation` VALUES (920, 10, 12, 1, '2024-05-29 12:50:27', NULL);
INSERT INTO `user_house_operation` VALUES (921, 10, 12, 1, '2024-05-29 12:50:27', NULL);
INSERT INTO `user_house_operation` VALUES (922, 10, 12, 1, '2024-05-29 12:50:28', NULL);
INSERT INTO `user_house_operation` VALUES (923, 10, 12, 1, '2024-05-29 12:50:28', NULL);
INSERT INTO `user_house_operation` VALUES (924, 10, 12, 1, '2024-05-29 12:50:28', NULL);
INSERT INTO `user_house_operation` VALUES (925, 10, 12, 1, '2024-05-29 12:50:28', NULL);
INSERT INTO `user_house_operation` VALUES (926, 10, 12, 1, '2024-05-29 12:50:28', NULL);
INSERT INTO `user_house_operation` VALUES (927, 10, 12, 1, '2024-05-29 12:50:28', NULL);
INSERT INTO `user_house_operation` VALUES (928, 10, 12, 1, '2024-05-29 12:50:28', NULL);
INSERT INTO `user_house_operation` VALUES (929, 10, 12, 1, '2024-05-29 12:50:28', NULL);
INSERT INTO `user_house_operation` VALUES (930, 10, 12, 1, '2024-05-29 12:50:29', NULL);
INSERT INTO `user_house_operation` VALUES (931, 10, 12, 1, '2024-05-29 12:50:29', NULL);
INSERT INTO `user_house_operation` VALUES (932, 10, 12, 1, '2024-05-29 12:50:29', NULL);
INSERT INTO `user_house_operation` VALUES (933, 10, 12, 1, '2024-05-29 12:50:29', NULL);
INSERT INTO `user_house_operation` VALUES (934, 10, 12, 1, '2024-05-29 12:50:29', NULL);
INSERT INTO `user_house_operation` VALUES (935, 10, 12, 1, '2024-05-29 12:50:29', NULL);
INSERT INTO `user_house_operation` VALUES (936, 10, 12, 1, '2024-05-29 12:50:29', NULL);
INSERT INTO `user_house_operation` VALUES (937, 10, 12, 1, '2024-05-29 12:50:30', NULL);
INSERT INTO `user_house_operation` VALUES (938, 10, 12, 1, '2024-05-29 12:50:30', NULL);
INSERT INTO `user_house_operation` VALUES (939, 10, 12, 1, '2024-05-29 12:50:30', NULL);
INSERT INTO `user_house_operation` VALUES (940, 10, 12, 1, '2024-05-29 12:50:30', NULL);
INSERT INTO `user_house_operation` VALUES (941, 10, 12, 1, '2024-05-29 12:50:30', NULL);
INSERT INTO `user_house_operation` VALUES (942, 10, 12, 1, '2024-05-29 12:50:30', NULL);
INSERT INTO `user_house_operation` VALUES (943, 10, 12, 1, '2024-05-29 12:50:30', NULL);
INSERT INTO `user_house_operation` VALUES (944, 10, 12, 1, '2024-05-29 12:50:30', NULL);
INSERT INTO `user_house_operation` VALUES (945, 10, 12, 1, '2024-05-29 12:50:30', NULL);
INSERT INTO `user_house_operation` VALUES (946, 10, 12, 1, '2024-05-29 12:50:31', NULL);
INSERT INTO `user_house_operation` VALUES (947, 10, 12, 1, '2024-05-29 12:50:31', NULL);
INSERT INTO `user_house_operation` VALUES (948, 10, 12, 1, '2024-05-29 12:50:31', NULL);
INSERT INTO `user_house_operation` VALUES (949, 10, 12, 1, '2024-05-29 12:50:31', NULL);
INSERT INTO `user_house_operation` VALUES (950, 10, 12, 1, '2024-05-29 12:50:31', NULL);
INSERT INTO `user_house_operation` VALUES (951, 10, 12, 1, '2024-05-29 12:50:31', NULL);
INSERT INTO `user_house_operation` VALUES (952, 10, 12, 1, '2024-05-29 12:50:31', NULL);
INSERT INTO `user_house_operation` VALUES (953, 10, 12, 1, '2024-05-29 12:50:31', NULL);
INSERT INTO `user_house_operation` VALUES (954, 10, 12, 1, '2024-05-29 12:50:31', NULL);
INSERT INTO `user_house_operation` VALUES (955, 10, 12, 1, '2024-05-29 12:50:32', NULL);
INSERT INTO `user_house_operation` VALUES (956, 10, 12, 1, '2024-05-29 12:50:32', NULL);
INSERT INTO `user_house_operation` VALUES (957, 10, 12, 1, '2024-05-29 12:50:32', NULL);
INSERT INTO `user_house_operation` VALUES (958, 10, 12, 1, '2024-05-29 12:50:32', NULL);
INSERT INTO `user_house_operation` VALUES (959, 10, 12, 1, '2024-05-29 12:50:32', NULL);
INSERT INTO `user_house_operation` VALUES (960, 10, 12, 1, '2024-05-29 12:50:32', NULL);
INSERT INTO `user_house_operation` VALUES (961, 10, 12, 1, '2024-05-29 12:50:32', NULL);
INSERT INTO `user_house_operation` VALUES (962, 10, 12, 1, '2024-05-29 12:50:32', NULL);
INSERT INTO `user_house_operation` VALUES (963, 10, 12, 1, '2024-05-29 12:50:33', NULL);
INSERT INTO `user_house_operation` VALUES (964, 10, 12, 1, '2024-05-29 12:50:33', NULL);
INSERT INTO `user_house_operation` VALUES (965, 10, 12, 1, '2024-05-29 12:50:33', NULL);
INSERT INTO `user_house_operation` VALUES (966, 10, 12, 1, '2024-05-29 12:50:33', NULL);
INSERT INTO `user_house_operation` VALUES (967, 10, 12, 1, '2024-05-29 12:50:33', NULL);
INSERT INTO `user_house_operation` VALUES (968, 10, 12, 1, '2024-05-29 12:50:33', NULL);
INSERT INTO `user_house_operation` VALUES (969, 10, 12, 1, '2024-05-29 12:50:33', NULL);
INSERT INTO `user_house_operation` VALUES (970, 10, 12, 1, '2024-05-29 12:50:34', NULL);
INSERT INTO `user_house_operation` VALUES (971, 10, 12, 1, '2024-05-29 12:50:34', NULL);
INSERT INTO `user_house_operation` VALUES (972, 10, 12, 1, '2024-05-29 12:50:34', NULL);
INSERT INTO `user_house_operation` VALUES (973, 10, 12, 1, '2024-05-29 12:50:34', NULL);
INSERT INTO `user_house_operation` VALUES (974, 10, 12, 1, '2024-05-29 12:50:34', NULL);
INSERT INTO `user_house_operation` VALUES (975, 10, 12, 1, '2024-05-29 12:50:34', NULL);
INSERT INTO `user_house_operation` VALUES (976, 10, 12, 1, '2024-05-29 12:50:34', NULL);
INSERT INTO `user_house_operation` VALUES (977, 10, 12, 1, '2024-05-29 12:50:34', NULL);
INSERT INTO `user_house_operation` VALUES (978, 10, 12, 1, '2024-05-29 12:50:35', NULL);
INSERT INTO `user_house_operation` VALUES (979, 10, 12, 1, '2024-05-29 12:50:35', NULL);
INSERT INTO `user_house_operation` VALUES (980, 10, 12, 1, '2024-05-29 12:50:35', NULL);
INSERT INTO `user_house_operation` VALUES (981, 10, 12, 1, '2024-05-29 12:50:35', NULL);
INSERT INTO `user_house_operation` VALUES (982, 10, 12, 1, '2024-05-29 12:50:35', NULL);
INSERT INTO `user_house_operation` VALUES (983, 10, 12, 1, '2024-05-29 12:50:35', NULL);
INSERT INTO `user_house_operation` VALUES (984, 10, 12, 1, '2024-05-29 12:50:35', NULL);
INSERT INTO `user_house_operation` VALUES (985, 10, 12, 1, '2024-05-29 12:50:35', NULL);
INSERT INTO `user_house_operation` VALUES (986, 10, 12, 1, '2024-05-29 12:50:36', NULL);
INSERT INTO `user_house_operation` VALUES (987, 10, 12, 1, '2024-05-29 12:50:36', NULL);
INSERT INTO `user_house_operation` VALUES (988, 10, 12, 1, '2024-05-29 12:50:36', NULL);
INSERT INTO `user_house_operation` VALUES (989, 10, 12, 1, '2024-05-29 12:50:36', NULL);
INSERT INTO `user_house_operation` VALUES (990, 10, 12, 1, '2024-05-29 12:50:36', NULL);
INSERT INTO `user_house_operation` VALUES (991, 10, 12, 1, '2024-05-29 12:50:36', NULL);
INSERT INTO `user_house_operation` VALUES (992, 10, 12, 1, '2024-05-29 12:50:36', NULL);
INSERT INTO `user_house_operation` VALUES (993, 10, 12, 1, '2024-05-29 12:50:36', NULL);
INSERT INTO `user_house_operation` VALUES (994, 10, 12, 1, '2024-05-29 12:50:37', NULL);
INSERT INTO `user_house_operation` VALUES (995, 10, 12, 1, '2024-05-29 12:50:37', NULL);
INSERT INTO `user_house_operation` VALUES (996, 10, 12, 1, '2024-05-29 12:50:37', NULL);
INSERT INTO `user_house_operation` VALUES (997, 10, 12, 1, '2024-05-29 12:50:37', NULL);
INSERT INTO `user_house_operation` VALUES (998, 10, 12, 1, '2024-05-29 12:50:37', NULL);
INSERT INTO `user_house_operation` VALUES (999, 10, 12, 1, '2024-05-29 12:50:37', NULL);
INSERT INTO `user_house_operation` VALUES (1000, 10, 12, 1, '2024-05-29 12:50:37', NULL);
INSERT INTO `user_house_operation` VALUES (1001, 10, 12, 1, '2024-05-29 12:50:37', NULL);
INSERT INTO `user_house_operation` VALUES (1002, 10, 12, 1, '2024-05-29 12:50:37', NULL);
INSERT INTO `user_house_operation` VALUES (1003, 10, 12, 1, '2024-05-29 12:50:38', NULL);
INSERT INTO `user_house_operation` VALUES (1004, 10, 12, 1, '2024-05-29 12:50:38', NULL);
INSERT INTO `user_house_operation` VALUES (1005, 10, 12, 1, '2024-05-29 12:50:38', NULL);
INSERT INTO `user_house_operation` VALUES (1006, 10, 12, 1, '2024-05-29 12:50:38', NULL);
INSERT INTO `user_house_operation` VALUES (1007, 10, 12, 1, '2024-05-29 12:50:38', NULL);
INSERT INTO `user_house_operation` VALUES (1008, 10, 12, 1, '2024-05-29 12:50:38', NULL);
INSERT INTO `user_house_operation` VALUES (1009, 10, 12, 1, '2024-05-29 12:50:38', NULL);
INSERT INTO `user_house_operation` VALUES (1010, 10, 12, 1, '2024-05-29 12:50:38', NULL);
INSERT INTO `user_house_operation` VALUES (1011, 10, 12, 1, '2024-05-29 12:50:38', NULL);
INSERT INTO `user_house_operation` VALUES (1012, 10, 12, 1, '2024-05-29 12:50:39', NULL);
INSERT INTO `user_house_operation` VALUES (1013, 10, 12, 1, '2024-05-29 12:50:39', NULL);
INSERT INTO `user_house_operation` VALUES (1014, 10, 12, 1, '2024-05-29 12:50:39', NULL);
INSERT INTO `user_house_operation` VALUES (1015, 10, 12, 1, '2024-05-29 12:50:39', NULL);
INSERT INTO `user_house_operation` VALUES (1016, 10, 12, 1, '2024-05-29 12:50:39', NULL);
INSERT INTO `user_house_operation` VALUES (1017, 10, 12, 1, '2024-05-29 12:50:39', NULL);
INSERT INTO `user_house_operation` VALUES (1018, 10, 12, 1, '2024-05-29 12:50:39', NULL);
INSERT INTO `user_house_operation` VALUES (1019, 10, 12, 1, '2024-05-29 12:50:39', NULL);
INSERT INTO `user_house_operation` VALUES (1020, 10, 12, 1, '2024-05-29 12:50:39', NULL);
INSERT INTO `user_house_operation` VALUES (1021, 10, 12, 1, '2024-05-29 12:50:40', NULL);
INSERT INTO `user_house_operation` VALUES (1022, 10, 12, 1, '2024-05-29 12:50:40', NULL);
INSERT INTO `user_house_operation` VALUES (1023, 10, 12, 1, '2024-05-29 12:50:40', NULL);
INSERT INTO `user_house_operation` VALUES (1024, 10, 12, 1, '2024-05-29 12:50:40', NULL);
INSERT INTO `user_house_operation` VALUES (1025, 10, 12, 1, '2024-05-29 12:50:40', NULL);
INSERT INTO `user_house_operation` VALUES (1026, 10, 12, 1, '2024-05-29 12:50:40', NULL);
INSERT INTO `user_house_operation` VALUES (1027, 10, 12, 1, '2024-05-29 12:50:41', NULL);
INSERT INTO `user_house_operation` VALUES (1028, 10, 12, 1, '2024-05-29 12:50:41', NULL);
INSERT INTO `user_house_operation` VALUES (1029, 10, 12, 1, '2024-05-29 12:50:41', NULL);
INSERT INTO `user_house_operation` VALUES (1030, 10, 12, 1, '2024-05-29 12:50:41', NULL);
INSERT INTO `user_house_operation` VALUES (1031, 10, 12, 1, '2024-05-29 12:50:41', NULL);
INSERT INTO `user_house_operation` VALUES (1032, 10, 12, 1, '2024-05-29 12:50:41', NULL);
INSERT INTO `user_house_operation` VALUES (1033, 10, 12, 1, '2024-05-29 12:50:41', NULL);
INSERT INTO `user_house_operation` VALUES (1034, 10, 12, 1, '2024-05-29 12:50:41', NULL);
INSERT INTO `user_house_operation` VALUES (1035, 10, 12, 1, '2024-05-29 12:50:41', NULL);
INSERT INTO `user_house_operation` VALUES (1036, 10, 12, 1, '2024-05-29 12:50:42', NULL);
INSERT INTO `user_house_operation` VALUES (1037, 10, 12, 1, '2024-05-29 12:50:42', NULL);
INSERT INTO `user_house_operation` VALUES (1038, 10, 12, 1, '2024-05-29 12:50:42', NULL);
INSERT INTO `user_house_operation` VALUES (1039, 10, 12, 1, '2024-05-29 12:50:42', NULL);
INSERT INTO `user_house_operation` VALUES (1040, 10, 12, 1, '2024-05-29 12:50:42', NULL);
INSERT INTO `user_house_operation` VALUES (1041, 10, 12, 1, '2024-05-29 12:50:42', NULL);
INSERT INTO `user_house_operation` VALUES (1042, 10, 12, 1, '2024-05-29 12:50:42', NULL);
INSERT INTO `user_house_operation` VALUES (1043, 10, 12, 1, '2024-05-29 12:50:43', NULL);
INSERT INTO `user_house_operation` VALUES (1044, 10, 12, 1, '2024-05-29 12:50:43', NULL);
INSERT INTO `user_house_operation` VALUES (1045, 10, 12, 1, '2024-05-29 12:50:43', NULL);
INSERT INTO `user_house_operation` VALUES (1046, 10, 12, 1, '2024-05-29 12:50:43', NULL);
INSERT INTO `user_house_operation` VALUES (1047, 10, 12, 1, '2024-05-29 12:50:43', NULL);
INSERT INTO `user_house_operation` VALUES (1048, 10, 12, 1, '2024-05-29 12:50:43', NULL);
INSERT INTO `user_house_operation` VALUES (1049, 10, 12, 1, '2024-05-29 12:50:43', NULL);
INSERT INTO `user_house_operation` VALUES (1050, 10, 12, 1, '2024-05-29 12:50:43', NULL);
INSERT INTO `user_house_operation` VALUES (1051, 10, 12, 1, '2024-05-29 12:50:44', NULL);
INSERT INTO `user_house_operation` VALUES (1052, 10, 12, 1, '2024-05-29 12:50:44', NULL);
INSERT INTO `user_house_operation` VALUES (1053, 10, 12, 1, '2024-05-29 12:50:44', NULL);
INSERT INTO `user_house_operation` VALUES (1054, 10, 12, 1, '2024-05-29 12:50:44', NULL);
INSERT INTO `user_house_operation` VALUES (1055, 10, 12, 1, '2024-05-29 12:50:44', NULL);
INSERT INTO `user_house_operation` VALUES (1056, 10, 12, 1, '2024-05-29 12:50:44', NULL);
INSERT INTO `user_house_operation` VALUES (1057, 10, 12, 1, '2024-05-29 12:50:44', NULL);
INSERT INTO `user_house_operation` VALUES (1058, 10, 12, 1, '2024-05-29 12:50:45', NULL);
INSERT INTO `user_house_operation` VALUES (1059, 10, 12, 1, '2024-05-29 12:50:45', NULL);
INSERT INTO `user_house_operation` VALUES (1060, 10, 12, 1, '2024-05-29 12:50:45', NULL);
INSERT INTO `user_house_operation` VALUES (1061, 10, 12, 1, '2024-05-29 12:50:45', NULL);
INSERT INTO `user_house_operation` VALUES (1062, 10, 12, 1, '2024-05-29 12:50:45', NULL);
INSERT INTO `user_house_operation` VALUES (1063, 10, 12, 1, '2024-05-29 12:50:45', NULL);
INSERT INTO `user_house_operation` VALUES (1064, 10, 12, 1, '2024-05-29 12:50:45', NULL);
INSERT INTO `user_house_operation` VALUES (1065, 10, 12, 1, '2024-05-29 12:50:46', NULL);
INSERT INTO `user_house_operation` VALUES (1066, 10, 12, 1, '2024-05-29 12:50:46', NULL);
INSERT INTO `user_house_operation` VALUES (1067, 10, 12, 1, '2024-05-29 12:50:46', NULL);
INSERT INTO `user_house_operation` VALUES (1068, 10, 12, 1, '2024-05-29 12:50:46', NULL);
INSERT INTO `user_house_operation` VALUES (1069, 10, 12, 1, '2024-05-29 12:50:46', NULL);
INSERT INTO `user_house_operation` VALUES (1070, 10, 12, 1, '2024-05-29 12:50:46', NULL);
INSERT INTO `user_house_operation` VALUES (1071, 10, 12, 1, '2024-05-29 12:50:46', NULL);
INSERT INTO `user_house_operation` VALUES (1072, 10, 12, 1, '2024-05-29 12:50:46', NULL);
INSERT INTO `user_house_operation` VALUES (1073, 10, 12, 1, '2024-05-29 12:50:46', NULL);
INSERT INTO `user_house_operation` VALUES (1074, 10, 12, 1, '2024-05-29 12:50:47', NULL);
INSERT INTO `user_house_operation` VALUES (1075, 10, 12, 1, '2024-05-29 12:50:47', NULL);
INSERT INTO `user_house_operation` VALUES (1076, 10, 12, 1, '2024-05-29 12:50:47', NULL);
INSERT INTO `user_house_operation` VALUES (1077, 10, 12, 1, '2024-05-29 12:50:47', NULL);
INSERT INTO `user_house_operation` VALUES (1078, 10, 12, 1, '2024-05-29 12:50:47', NULL);
INSERT INTO `user_house_operation` VALUES (1079, 10, 12, 1, '2024-05-29 12:50:47', NULL);
INSERT INTO `user_house_operation` VALUES (1080, 10, 12, 1, '2024-05-29 12:50:47', NULL);
INSERT INTO `user_house_operation` VALUES (1081, 10, 12, 1, '2024-05-29 12:50:47', NULL);
INSERT INTO `user_house_operation` VALUES (1082, 10, 12, 1, '2024-05-29 12:50:48', NULL);
INSERT INTO `user_house_operation` VALUES (1083, 10, 12, 1, '2024-05-29 12:50:48', NULL);
INSERT INTO `user_house_operation` VALUES (1084, 10, 12, 1, '2024-05-29 12:50:48', NULL);
INSERT INTO `user_house_operation` VALUES (1085, 10, 12, 1, '2024-05-29 12:50:48', NULL);
INSERT INTO `user_house_operation` VALUES (1086, 10, 12, 1, '2024-05-29 12:50:48', NULL);
INSERT INTO `user_house_operation` VALUES (1087, 10, 12, 1, '2024-05-29 12:50:48', NULL);
INSERT INTO `user_house_operation` VALUES (1088, 10, 12, 1, '2024-05-29 12:50:48', NULL);
INSERT INTO `user_house_operation` VALUES (1089, 10, 12, 1, '2024-05-29 12:50:48', NULL);
INSERT INTO `user_house_operation` VALUES (1090, 10, 12, 1, '2024-05-29 12:50:49', NULL);
INSERT INTO `user_house_operation` VALUES (1091, 10, 12, 1, '2024-05-29 12:50:49', NULL);
INSERT INTO `user_house_operation` VALUES (1092, 10, 12, 1, '2024-05-29 12:50:49', NULL);
INSERT INTO `user_house_operation` VALUES (1093, 10, 12, 1, '2024-05-29 12:50:49', NULL);
INSERT INTO `user_house_operation` VALUES (1094, 10, 12, 1, '2024-05-29 12:50:49', NULL);
INSERT INTO `user_house_operation` VALUES (1095, 10, 12, 1, '2024-05-29 12:50:49', NULL);
INSERT INTO `user_house_operation` VALUES (1096, 10, 12, 1, '2024-05-29 12:50:49', NULL);
INSERT INTO `user_house_operation` VALUES (1097, 10, 12, 1, '2024-05-29 12:50:49', NULL);
INSERT INTO `user_house_operation` VALUES (1098, 10, 12, 1, '2024-05-29 12:50:49', NULL);
INSERT INTO `user_house_operation` VALUES (1099, 10, 12, 1, '2024-05-29 12:50:50', NULL);
INSERT INTO `user_house_operation` VALUES (1100, 10, 12, 1, '2024-05-29 12:50:50', NULL);
INSERT INTO `user_house_operation` VALUES (1101, 10, 12, 1, '2024-05-29 12:50:50', NULL);
INSERT INTO `user_house_operation` VALUES (1102, 10, 12, 1, '2024-05-29 12:50:50', NULL);
INSERT INTO `user_house_operation` VALUES (1103, 10, 12, 1, '2024-05-29 12:50:50', NULL);
INSERT INTO `user_house_operation` VALUES (1104, 10, 12, 1, '2024-05-29 12:50:50', NULL);
INSERT INTO `user_house_operation` VALUES (1105, 10, 12, 1, '2024-05-29 12:50:51', NULL);
INSERT INTO `user_house_operation` VALUES (1106, 10, 12, 1, '2024-05-29 12:50:51', NULL);
INSERT INTO `user_house_operation` VALUES (1107, 10, 12, 1, '2024-05-29 12:50:51', NULL);
INSERT INTO `user_house_operation` VALUES (1108, 10, 12, 1, '2024-05-29 12:50:51', NULL);
INSERT INTO `user_house_operation` VALUES (1109, 10, 12, 1, '2024-05-29 12:50:51', NULL);
INSERT INTO `user_house_operation` VALUES (1110, 10, 12, 1, '2024-05-29 12:50:51', NULL);
INSERT INTO `user_house_operation` VALUES (1111, 10, 12, 1, '2024-05-29 12:50:51', NULL);
INSERT INTO `user_house_operation` VALUES (1112, 10, 12, 1, '2024-05-29 12:50:52', NULL);
INSERT INTO `user_house_operation` VALUES (1113, 10, 12, 1, '2024-05-29 12:50:52', NULL);
INSERT INTO `user_house_operation` VALUES (1114, 10, 12, 1, '2024-05-29 12:50:52', NULL);
INSERT INTO `user_house_operation` VALUES (1115, 10, 12, 1, '2024-05-29 12:50:52', NULL);
INSERT INTO `user_house_operation` VALUES (1116, 10, 12, 1, '2024-05-29 12:50:52', NULL);
INSERT INTO `user_house_operation` VALUES (1117, 10, 12, 1, '2024-05-29 12:50:52', NULL);
INSERT INTO `user_house_operation` VALUES (1118, 10, 12, 1, '2024-05-29 12:50:53', NULL);
INSERT INTO `user_house_operation` VALUES (1119, 10, 12, 1, '2024-05-29 12:50:53', NULL);
INSERT INTO `user_house_operation` VALUES (1120, 10, 12, 1, '2024-05-29 12:50:53', NULL);
INSERT INTO `user_house_operation` VALUES (1121, 10, 12, 1, '2024-05-29 12:50:53', NULL);
INSERT INTO `user_house_operation` VALUES (1122, 10, 12, 1, '2024-05-29 12:50:53', NULL);
INSERT INTO `user_house_operation` VALUES (1123, 10, 12, 1, '2024-05-29 12:50:53', NULL);
INSERT INTO `user_house_operation` VALUES (1124, 10, 12, 1, '2024-05-29 12:50:53', NULL);
INSERT INTO `user_house_operation` VALUES (1125, 10, 12, 1, '2024-05-29 12:50:53', NULL);
INSERT INTO `user_house_operation` VALUES (1126, 10, 12, 1, '2024-05-29 12:50:53', NULL);
INSERT INTO `user_house_operation` VALUES (1127, 10, 12, 1, '2024-05-29 12:50:54', NULL);
INSERT INTO `user_house_operation` VALUES (1128, 10, 12, 1, '2024-05-29 12:50:54', NULL);
INSERT INTO `user_house_operation` VALUES (1129, 10, 12, 1, '2024-05-29 12:50:54', NULL);
INSERT INTO `user_house_operation` VALUES (1130, 10, 12, 1, '2024-05-29 12:50:54', NULL);
INSERT INTO `user_house_operation` VALUES (1131, 10, 12, 1, '2024-05-29 12:50:54', NULL);
INSERT INTO `user_house_operation` VALUES (1132, 10, 12, 1, '2024-05-29 12:50:54', NULL);
INSERT INTO `user_house_operation` VALUES (1133, 10, 12, 1, '2024-05-29 12:50:54', NULL);
INSERT INTO `user_house_operation` VALUES (1134, 10, 12, 1, '2024-05-29 12:50:54', NULL);
INSERT INTO `user_house_operation` VALUES (1135, 10, 12, 1, '2024-05-29 12:50:54', NULL);
INSERT INTO `user_house_operation` VALUES (1136, 10, 12, 1, '2024-05-29 12:50:55', NULL);
INSERT INTO `user_house_operation` VALUES (1137, 10, 12, 1, '2024-05-29 12:50:55', NULL);
INSERT INTO `user_house_operation` VALUES (1138, 10, 12, 1, '2024-05-29 12:50:55', NULL);
INSERT INTO `user_house_operation` VALUES (1139, 10, 12, 1, '2024-05-29 12:50:55', NULL);
INSERT INTO `user_house_operation` VALUES (1140, 10, 12, 1, '2024-05-29 12:50:55', NULL);
INSERT INTO `user_house_operation` VALUES (1141, 10, 12, 1, '2024-05-29 12:50:55', NULL);
INSERT INTO `user_house_operation` VALUES (1142, 10, 12, 1, '2024-05-29 12:50:56', NULL);
INSERT INTO `user_house_operation` VALUES (1143, 10, 12, 1, '2024-05-29 12:50:56', NULL);
INSERT INTO `user_house_operation` VALUES (1144, 10, 12, 1, '2024-05-29 12:50:56', NULL);
INSERT INTO `user_house_operation` VALUES (1145, 10, 12, 1, '2024-05-29 12:50:56', NULL);
INSERT INTO `user_house_operation` VALUES (1146, 10, 12, 1, '2024-05-29 12:50:56', NULL);
INSERT INTO `user_house_operation` VALUES (1147, 10, 12, 1, '2024-05-29 12:50:56', NULL);
INSERT INTO `user_house_operation` VALUES (1148, 10, 12, 1, '2024-05-29 12:50:56', NULL);
INSERT INTO `user_house_operation` VALUES (1149, 10, 12, 1, '2024-05-29 12:50:56', NULL);
INSERT INTO `user_house_operation` VALUES (1150, 10, 12, 1, '2024-05-29 12:50:57', NULL);
INSERT INTO `user_house_operation` VALUES (1151, 10, 12, 1, '2024-05-29 12:50:57', NULL);
INSERT INTO `user_house_operation` VALUES (1152, 10, 12, 1, '2024-05-29 12:50:57', NULL);
INSERT INTO `user_house_operation` VALUES (1153, 10, 12, 1, '2024-05-29 12:50:57', NULL);
INSERT INTO `user_house_operation` VALUES (1154, 10, 12, 1, '2024-05-29 12:50:57', NULL);
INSERT INTO `user_house_operation` VALUES (1155, 10, 12, 1, '2024-05-29 12:50:57', NULL);
INSERT INTO `user_house_operation` VALUES (1156, 10, 12, 1, '2024-05-29 12:50:57', NULL);
INSERT INTO `user_house_operation` VALUES (1157, 10, 12, 1, '2024-05-29 12:50:57', NULL);
INSERT INTO `user_house_operation` VALUES (1158, 10, 12, 1, '2024-05-29 12:50:57', NULL);
INSERT INTO `user_house_operation` VALUES (1159, 10, 12, 1, '2024-05-29 12:50:57', NULL);
INSERT INTO `user_house_operation` VALUES (1160, 10, 12, 1, '2024-05-29 12:50:58', NULL);
INSERT INTO `user_house_operation` VALUES (1161, 10, 12, 1, '2024-05-29 12:50:58', NULL);
INSERT INTO `user_house_operation` VALUES (1162, 10, 12, 1, '2024-05-29 12:50:58', NULL);
INSERT INTO `user_house_operation` VALUES (1163, 10, 12, 1, '2024-05-29 12:50:58', NULL);
INSERT INTO `user_house_operation` VALUES (1164, 10, 12, 1, '2024-05-29 12:50:58', NULL);
INSERT INTO `user_house_operation` VALUES (1165, 10, 12, 1, '2024-05-29 12:50:58', NULL);
INSERT INTO `user_house_operation` VALUES (1166, 10, 12, 1, '2024-05-29 12:50:59', NULL);
INSERT INTO `user_house_operation` VALUES (1167, 10, 12, 1, '2024-05-29 12:50:59', NULL);
INSERT INTO `user_house_operation` VALUES (1168, 10, 12, 1, '2024-05-29 12:50:59', NULL);
INSERT INTO `user_house_operation` VALUES (1169, 10, 12, 1, '2024-05-29 12:50:59', NULL);
INSERT INTO `user_house_operation` VALUES (1170, 10, 12, 1, '2024-05-29 12:50:59', NULL);
INSERT INTO `user_house_operation` VALUES (1171, 10, 12, 1, '2024-05-29 12:50:59', NULL);
INSERT INTO `user_house_operation` VALUES (1172, 10, 12, 1, '2024-05-29 12:50:59', NULL);
INSERT INTO `user_house_operation` VALUES (1173, 10, 12, 1, '2024-05-29 12:51:00', NULL);
INSERT INTO `user_house_operation` VALUES (1174, 10, 12, 1, '2024-05-29 12:51:00', NULL);
INSERT INTO `user_house_operation` VALUES (1175, 10, 12, 1, '2024-05-29 12:51:00', NULL);
INSERT INTO `user_house_operation` VALUES (1176, 10, 12, 1, '2024-05-29 12:51:00', NULL);
INSERT INTO `user_house_operation` VALUES (1177, 10, 12, 1, '2024-05-29 12:51:00', NULL);
INSERT INTO `user_house_operation` VALUES (1178, 10, 12, 1, '2024-05-29 12:51:00', NULL);
INSERT INTO `user_house_operation` VALUES (1179, 10, 12, 1, '2024-05-29 12:51:01', NULL);
INSERT INTO `user_house_operation` VALUES (1180, 10, 12, 1, '2024-05-29 12:51:01', NULL);
INSERT INTO `user_house_operation` VALUES (1181, 10, 12, 1, '2024-05-29 12:51:01', NULL);
INSERT INTO `user_house_operation` VALUES (1182, 10, 12, 1, '2024-05-29 12:51:01', NULL);
INSERT INTO `user_house_operation` VALUES (1183, 10, 12, 1, '2024-05-29 12:51:01', NULL);
INSERT INTO `user_house_operation` VALUES (1184, 10, 12, 1, '2024-05-29 12:51:01', NULL);
INSERT INTO `user_house_operation` VALUES (1185, 10, 12, 1, '2024-05-29 12:51:01', NULL);
INSERT INTO `user_house_operation` VALUES (1186, 10, 12, 1, '2024-05-29 12:51:02', NULL);
INSERT INTO `user_house_operation` VALUES (1187, 10, 12, 1, '2024-05-29 12:51:02', NULL);
INSERT INTO `user_house_operation` VALUES (1188, 10, 12, 1, '2024-05-29 12:51:02', NULL);
INSERT INTO `user_house_operation` VALUES (1189, 10, 12, 1, '2024-05-29 12:51:02', NULL);
INSERT INTO `user_house_operation` VALUES (1190, 10, 12, 1, '2024-05-29 12:51:02', NULL);
INSERT INTO `user_house_operation` VALUES (1191, 10, 12, 1, '2024-05-29 12:51:02', NULL);
INSERT INTO `user_house_operation` VALUES (1192, 10, 12, 1, '2024-05-29 12:51:02', NULL);
INSERT INTO `user_house_operation` VALUES (1193, 10, 12, 1, '2024-05-29 12:51:02', NULL);
INSERT INTO `user_house_operation` VALUES (1194, 10, 12, 1, '2024-05-29 12:51:03', NULL);
INSERT INTO `user_house_operation` VALUES (1195, 10, 12, 1, '2024-05-29 12:51:03', NULL);
INSERT INTO `user_house_operation` VALUES (1196, 10, 12, 1, '2024-05-29 12:51:03', NULL);
INSERT INTO `user_house_operation` VALUES (1197, 10, 12, 1, '2024-05-29 12:51:03', NULL);
INSERT INTO `user_house_operation` VALUES (1198, 10, 12, 1, '2024-05-29 12:51:03', NULL);
INSERT INTO `user_house_operation` VALUES (1199, 10, 12, 1, '2024-05-29 12:51:03', NULL);
INSERT INTO `user_house_operation` VALUES (1200, 10, 12, 1, '2024-05-29 12:51:03', NULL);
INSERT INTO `user_house_operation` VALUES (1201, 10, 12, 1, '2024-05-29 12:51:03', NULL);
INSERT INTO `user_house_operation` VALUES (1202, 10, 12, 1, '2024-05-29 12:51:03', NULL);
INSERT INTO `user_house_operation` VALUES (1203, 10, 12, 1, '2024-05-29 12:51:04', NULL);
INSERT INTO `user_house_operation` VALUES (1204, 10, 12, 1, '2024-05-29 12:51:04', NULL);
INSERT INTO `user_house_operation` VALUES (1205, 10, 12, 1, '2024-05-29 12:51:04', NULL);
INSERT INTO `user_house_operation` VALUES (1206, 10, 12, 1, '2024-05-29 12:51:04', NULL);
INSERT INTO `user_house_operation` VALUES (1207, 10, 12, 1, '2024-05-29 12:51:04', NULL);
INSERT INTO `user_house_operation` VALUES (1208, 10, 12, 1, '2024-05-29 12:51:04', NULL);
INSERT INTO `user_house_operation` VALUES (1209, 10, 12, 1, '2024-05-29 12:51:04', NULL);
INSERT INTO `user_house_operation` VALUES (1210, 10, 12, 1, '2024-05-29 12:51:04', NULL);
INSERT INTO `user_house_operation` VALUES (1211, 10, 12, 1, '2024-05-29 12:51:05', NULL);
INSERT INTO `user_house_operation` VALUES (1212, 10, 12, 1, '2024-05-29 12:51:05', NULL);
INSERT INTO `user_house_operation` VALUES (1213, 10, 12, 1, '2024-05-29 12:51:05', NULL);
INSERT INTO `user_house_operation` VALUES (1214, 10, 12, 1, '2024-05-29 12:51:05', NULL);
INSERT INTO `user_house_operation` VALUES (1215, 10, 12, 1, '2024-05-29 12:51:05', NULL);
INSERT INTO `user_house_operation` VALUES (1216, 10, 12, 1, '2024-05-29 12:51:05', NULL);
INSERT INTO `user_house_operation` VALUES (1217, 10, 12, 1, '2024-05-29 12:51:05', NULL);
INSERT INTO `user_house_operation` VALUES (1218, 10, 12, 1, '2024-05-29 12:51:06', NULL);
INSERT INTO `user_house_operation` VALUES (1219, 10, 12, 1, '2024-05-29 12:51:06', NULL);
INSERT INTO `user_house_operation` VALUES (1220, 10, 12, 1, '2024-05-29 12:51:06', NULL);
INSERT INTO `user_house_operation` VALUES (1221, 10, 12, 1, '2024-05-29 12:51:06', NULL);
INSERT INTO `user_house_operation` VALUES (1222, 10, 12, 1, '2024-05-29 12:51:06', NULL);
INSERT INTO `user_house_operation` VALUES (1223, 10, 12, 1, '2024-05-29 12:51:06', NULL);
INSERT INTO `user_house_operation` VALUES (1224, 10, 12, 1, '2024-05-29 12:51:06', NULL);
INSERT INTO `user_house_operation` VALUES (1225, 10, 12, 1, '2024-05-29 12:51:06', NULL);
INSERT INTO `user_house_operation` VALUES (1226, 10, 12, 1, '2024-05-29 12:51:06', NULL);
INSERT INTO `user_house_operation` VALUES (1227, 10, 12, 1, '2024-05-29 12:51:07', NULL);
INSERT INTO `user_house_operation` VALUES (1228, 10, 12, 1, '2024-05-29 12:51:07', NULL);
INSERT INTO `user_house_operation` VALUES (1229, 10, 12, 1, '2024-05-29 12:51:07', NULL);
INSERT INTO `user_house_operation` VALUES (1230, 10, 12, 1, '2024-05-29 12:51:07', NULL);
INSERT INTO `user_house_operation` VALUES (1231, 10, 12, 1, '2024-05-29 12:51:07', NULL);
INSERT INTO `user_house_operation` VALUES (1232, 10, 12, 1, '2024-05-29 12:51:07', NULL);
INSERT INTO `user_house_operation` VALUES (1233, 10, 12, 1, '2024-05-29 12:51:07', NULL);
INSERT INTO `user_house_operation` VALUES (1234, 10, 12, 1, '2024-05-29 12:51:07', NULL);
INSERT INTO `user_house_operation` VALUES (1235, 10, 12, 1, '2024-05-29 12:51:08', NULL);
INSERT INTO `user_house_operation` VALUES (1236, 10, 12, 1, '2024-05-29 12:51:08', NULL);
INSERT INTO `user_house_operation` VALUES (1237, 10, 12, 1, '2024-05-29 12:51:08', NULL);
INSERT INTO `user_house_operation` VALUES (1238, 10, 12, 1, '2024-05-29 12:51:08', NULL);
INSERT INTO `user_house_operation` VALUES (1239, 10, 12, 1, '2024-05-29 12:51:08', NULL);
INSERT INTO `user_house_operation` VALUES (1240, 10, 12, 1, '2024-05-29 12:51:08', NULL);
INSERT INTO `user_house_operation` VALUES (1241, 10, 12, 1, '2024-05-29 12:51:08', NULL);
INSERT INTO `user_house_operation` VALUES (1242, 10, 12, 1, '2024-05-29 12:51:09', NULL);
INSERT INTO `user_house_operation` VALUES (1243, 10, 12, 1, '2024-05-29 12:51:09', NULL);
INSERT INTO `user_house_operation` VALUES (1244, 10, 12, 1, '2024-05-29 12:51:09', NULL);
INSERT INTO `user_house_operation` VALUES (1245, 10, 12, 1, '2024-05-29 12:51:09', NULL);
INSERT INTO `user_house_operation` VALUES (1246, 10, 12, 1, '2024-05-29 12:51:09', NULL);
INSERT INTO `user_house_operation` VALUES (1247, 10, 12, 1, '2024-05-29 12:51:09', NULL);
INSERT INTO `user_house_operation` VALUES (1248, 10, 12, 1, '2024-05-29 12:51:09', NULL);
INSERT INTO `user_house_operation` VALUES (1249, 10, 12, 1, '2024-05-29 12:51:10', NULL);
INSERT INTO `user_house_operation` VALUES (1250, 10, 12, 1, '2024-05-29 12:51:10', NULL);
INSERT INTO `user_house_operation` VALUES (1251, 10, 12, 1, '2024-05-29 12:51:10', NULL);
INSERT INTO `user_house_operation` VALUES (1252, 10, 12, 1, '2024-05-29 12:51:10', NULL);
INSERT INTO `user_house_operation` VALUES (1253, 10, 12, 1, '2024-05-29 12:51:10', NULL);
INSERT INTO `user_house_operation` VALUES (1254, 10, 12, 1, '2024-05-29 12:51:10', NULL);
INSERT INTO `user_house_operation` VALUES (1255, 10, 12, 1, '2024-05-29 12:51:10', NULL);
INSERT INTO `user_house_operation` VALUES (1256, 10, 12, 1, '2024-05-29 12:51:11', NULL);
INSERT INTO `user_house_operation` VALUES (1257, 10, 12, 1, '2024-05-29 12:51:11', NULL);
INSERT INTO `user_house_operation` VALUES (1258, 10, 12, 1, '2024-05-29 12:51:11', NULL);
INSERT INTO `user_house_operation` VALUES (1259, 10, 12, 1, '2024-05-29 12:51:11', NULL);
INSERT INTO `user_house_operation` VALUES (1260, 10, 12, 1, '2024-05-29 12:51:11', NULL);
INSERT INTO `user_house_operation` VALUES (1261, 10, 12, 1, '2024-05-29 12:51:11', NULL);
INSERT INTO `user_house_operation` VALUES (1262, 10, 12, 1, '2024-05-29 12:51:11', NULL);
INSERT INTO `user_house_operation` VALUES (1263, 10, 12, 1, '2024-05-29 12:51:11', NULL);
INSERT INTO `user_house_operation` VALUES (1264, 10, 12, 1, '2024-05-29 12:51:12', NULL);
INSERT INTO `user_house_operation` VALUES (1265, 10, 12, 1, '2024-05-29 12:51:12', NULL);
INSERT INTO `user_house_operation` VALUES (1266, 10, 12, 1, '2024-05-29 12:51:12', NULL);
INSERT INTO `user_house_operation` VALUES (1267, 10, 12, 1, '2024-05-29 12:51:12', NULL);
INSERT INTO `user_house_operation` VALUES (1268, 10, 12, 1, '2024-05-29 12:51:12', NULL);
INSERT INTO `user_house_operation` VALUES (1269, 10, 12, 1, '2024-05-29 12:51:12', NULL);
INSERT INTO `user_house_operation` VALUES (1270, 10, 12, 1, '2024-05-29 12:51:12', NULL);
INSERT INTO `user_house_operation` VALUES (1271, 10, 12, 1, '2024-05-29 12:51:12', NULL);
INSERT INTO `user_house_operation` VALUES (1272, 10, 12, 1, '2024-05-29 12:51:12', NULL);
INSERT INTO `user_house_operation` VALUES (1273, 10, 12, 1, '2024-05-29 12:51:13', NULL);
INSERT INTO `user_house_operation` VALUES (1274, 10, 12, 1, '2024-05-29 12:51:13', NULL);
INSERT INTO `user_house_operation` VALUES (1275, 10, 12, 1, '2024-05-29 12:51:13', NULL);
INSERT INTO `user_house_operation` VALUES (1276, 10, 12, 1, '2024-05-29 12:51:13', NULL);
INSERT INTO `user_house_operation` VALUES (1277, 10, 12, 1, '2024-05-29 12:51:13', NULL);
INSERT INTO `user_house_operation` VALUES (1278, 10, 12, 1, '2024-05-29 12:51:13', NULL);
INSERT INTO `user_house_operation` VALUES (1279, 10, 12, 1, '2024-05-29 12:51:13', NULL);
INSERT INTO `user_house_operation` VALUES (1280, 10, 12, 1, '2024-05-29 12:51:13', NULL);
INSERT INTO `user_house_operation` VALUES (1281, 10, 12, 1, '2024-05-29 12:51:13', NULL);
INSERT INTO `user_house_operation` VALUES (1282, 10, 12, 1, '2024-05-29 12:51:14', NULL);
INSERT INTO `user_house_operation` VALUES (1283, 10, 12, 1, '2024-05-29 12:51:14', NULL);
INSERT INTO `user_house_operation` VALUES (1284, 10, 12, 1, '2024-05-29 12:51:14', NULL);
INSERT INTO `user_house_operation` VALUES (1285, 10, 12, 1, '2024-05-29 12:51:14', NULL);
INSERT INTO `user_house_operation` VALUES (1286, 10, 12, 1, '2024-05-29 12:51:14', NULL);
INSERT INTO `user_house_operation` VALUES (1287, 10, 12, 1, '2024-05-29 12:51:14', NULL);
INSERT INTO `user_house_operation` VALUES (1288, 10, 12, 1, '2024-05-29 12:51:14', NULL);
INSERT INTO `user_house_operation` VALUES (1289, 10, 12, 1, '2024-05-29 12:51:14', NULL);
INSERT INTO `user_house_operation` VALUES (1290, 10, 12, 1, '2024-05-29 12:51:14', NULL);
INSERT INTO `user_house_operation` VALUES (1291, 10, 12, 1, '2024-05-29 12:51:15', NULL);
INSERT INTO `user_house_operation` VALUES (1292, 10, 12, 1, '2024-05-29 12:51:15', NULL);
INSERT INTO `user_house_operation` VALUES (1293, 10, 12, 1, '2024-05-29 12:51:15', NULL);
INSERT INTO `user_house_operation` VALUES (1294, 10, 12, 1, '2024-05-29 12:51:15', NULL);
INSERT INTO `user_house_operation` VALUES (1295, 10, 12, 1, '2024-05-29 12:51:15', NULL);
INSERT INTO `user_house_operation` VALUES (1296, 10, 12, 1, '2024-05-29 12:51:16', NULL);
INSERT INTO `user_house_operation` VALUES (1297, 10, 12, 1, '2024-05-29 12:51:16', NULL);
INSERT INTO `user_house_operation` VALUES (1298, 10, 12, 1, '2024-05-29 12:51:16', NULL);
INSERT INTO `user_house_operation` VALUES (1299, 10, 12, 1, '2024-05-29 12:51:16', NULL);
INSERT INTO `user_house_operation` VALUES (1300, 10, 12, 1, '2024-05-29 12:51:16', NULL);
INSERT INTO `user_house_operation` VALUES (1301, 10, 12, 1, '2024-05-29 12:51:16', NULL);
INSERT INTO `user_house_operation` VALUES (1302, 10, 12, 1, '2024-05-29 12:51:16', NULL);
INSERT INTO `user_house_operation` VALUES (1303, 10, 12, 1, '2024-05-29 12:51:16', NULL);
INSERT INTO `user_house_operation` VALUES (1304, 10, 12, 1, '2024-05-29 12:51:17', NULL);
INSERT INTO `user_house_operation` VALUES (1305, 10, 12, 1, '2024-05-29 12:51:17', NULL);
INSERT INTO `user_house_operation` VALUES (1306, 10, 12, 1, '2024-05-29 12:51:17', NULL);
INSERT INTO `user_house_operation` VALUES (1307, 10, 12, 1, '2024-05-29 12:51:17', NULL);
INSERT INTO `user_house_operation` VALUES (1308, 10, 12, 1, '2024-05-29 12:51:17', NULL);
INSERT INTO `user_house_operation` VALUES (1309, 10, 12, 1, '2024-05-29 12:51:17', NULL);
INSERT INTO `user_house_operation` VALUES (1310, 10, 12, 1, '2024-05-29 12:51:17', NULL);
INSERT INTO `user_house_operation` VALUES (1311, 10, 12, 1, '2024-05-29 12:51:18', NULL);
INSERT INTO `user_house_operation` VALUES (1312, 10, 12, 1, '2024-05-29 12:51:18', NULL);
INSERT INTO `user_house_operation` VALUES (1313, 10, 12, 1, '2024-05-29 12:51:18', NULL);
INSERT INTO `user_house_operation` VALUES (1314, 10, 12, 1, '2024-05-29 12:51:18', NULL);
INSERT INTO `user_house_operation` VALUES (1315, 10, 12, 1, '2024-05-29 12:51:18', NULL);
INSERT INTO `user_house_operation` VALUES (1316, 10, 12, 1, '2024-05-29 12:51:18', NULL);
INSERT INTO `user_house_operation` VALUES (1317, 10, 12, 1, '2024-05-29 12:51:18', NULL);
INSERT INTO `user_house_operation` VALUES (1318, 10, 12, 1, '2024-05-29 12:51:18', NULL);
INSERT INTO `user_house_operation` VALUES (1319, 10, 12, 1, '2024-05-29 12:51:19', NULL);
INSERT INTO `user_house_operation` VALUES (1320, 10, 12, 1, '2024-05-29 12:51:19', NULL);
INSERT INTO `user_house_operation` VALUES (1321, 10, 12, 1, '2024-05-29 12:51:19', NULL);
INSERT INTO `user_house_operation` VALUES (1322, 10, 12, 1, '2024-05-29 12:51:19', NULL);
INSERT INTO `user_house_operation` VALUES (1323, 10, 12, 1, '2024-05-29 12:51:19', NULL);
INSERT INTO `user_house_operation` VALUES (1324, 10, 12, 1, '2024-05-29 12:51:19', NULL);
INSERT INTO `user_house_operation` VALUES (1325, 10, 12, 1, '2024-05-29 12:51:19', NULL);
INSERT INTO `user_house_operation` VALUES (1326, 10, 12, 1, '2024-05-29 12:51:19', NULL);
INSERT INTO `user_house_operation` VALUES (1327, 10, 12, 1, '2024-05-29 12:51:20', NULL);
INSERT INTO `user_house_operation` VALUES (1328, 10, 12, 1, '2024-05-29 12:51:20', NULL);
INSERT INTO `user_house_operation` VALUES (1329, 10, 12, 1, '2024-05-29 12:51:20', NULL);
INSERT INTO `user_house_operation` VALUES (1330, 10, 12, 1, '2024-05-29 12:51:20', NULL);
INSERT INTO `user_house_operation` VALUES (1331, 10, 12, 1, '2024-05-29 12:51:20', NULL);
INSERT INTO `user_house_operation` VALUES (1332, 10, 12, 1, '2024-05-29 12:51:20', NULL);
INSERT INTO `user_house_operation` VALUES (1333, 10, 12, 1, '2024-05-29 12:51:20', NULL);
INSERT INTO `user_house_operation` VALUES (1334, 10, 12, 1, '2024-05-29 12:51:20', NULL);
INSERT INTO `user_house_operation` VALUES (1335, 10, 12, 1, '2024-05-29 12:51:21', NULL);
INSERT INTO `user_house_operation` VALUES (1336, 10, 12, 1, '2024-05-29 12:51:21', NULL);
INSERT INTO `user_house_operation` VALUES (1337, 10, 12, 1, '2024-05-29 12:51:21', NULL);
INSERT INTO `user_house_operation` VALUES (1338, 10, 12, 1, '2024-05-29 12:51:21', NULL);
INSERT INTO `user_house_operation` VALUES (1339, 10, 12, 1, '2024-05-29 12:51:21', NULL);
INSERT INTO `user_house_operation` VALUES (1340, 10, 12, 1, '2024-05-29 12:51:21', NULL);
INSERT INTO `user_house_operation` VALUES (1341, 10, 12, 1, '2024-05-29 12:51:21', NULL);
INSERT INTO `user_house_operation` VALUES (1342, 10, 12, 1, '2024-05-29 12:51:21', NULL);
INSERT INTO `user_house_operation` VALUES (1343, 10, 12, 1, '2024-05-29 12:51:21', NULL);
INSERT INTO `user_house_operation` VALUES (1344, 10, 12, 1, '2024-05-29 12:51:21', NULL);
INSERT INTO `user_house_operation` VALUES (1345, 10, 12, 1, '2024-05-29 12:51:22', NULL);
INSERT INTO `user_house_operation` VALUES (1346, 10, 12, 1, '2024-05-29 12:51:22', NULL);
INSERT INTO `user_house_operation` VALUES (1347, 10, 12, 1, '2024-05-29 12:51:22', NULL);
INSERT INTO `user_house_operation` VALUES (1348, 10, 12, 1, '2024-05-29 12:51:22', NULL);
INSERT INTO `user_house_operation` VALUES (1349, 10, 12, 1, '2024-05-29 12:51:22', NULL);
INSERT INTO `user_house_operation` VALUES (1350, 10, 12, 1, '2024-05-29 12:51:22', NULL);
INSERT INTO `user_house_operation` VALUES (1351, 10, 12, 1, '2024-05-29 12:51:22', NULL);
INSERT INTO `user_house_operation` VALUES (1352, 10, 12, 1, '2024-05-29 12:51:22', NULL);
INSERT INTO `user_house_operation` VALUES (1353, 10, 12, 1, '2024-05-29 12:51:22', NULL);
INSERT INTO `user_house_operation` VALUES (1354, 10, 12, 1, '2024-05-29 12:51:22', NULL);
INSERT INTO `user_house_operation` VALUES (1355, 10, 12, 1, '2024-05-29 12:51:23', NULL);
INSERT INTO `user_house_operation` VALUES (1356, 10, 12, 1, '2024-05-29 12:51:23', NULL);
INSERT INTO `user_house_operation` VALUES (1357, 10, 12, 1, '2024-05-29 12:51:23', NULL);
INSERT INTO `user_house_operation` VALUES (1358, 10, 12, 1, '2024-05-29 12:51:23', NULL);
INSERT INTO `user_house_operation` VALUES (1359, 10, 12, 1, '2024-05-29 12:51:23', NULL);
INSERT INTO `user_house_operation` VALUES (1360, 10, 12, 1, '2024-05-29 12:51:23', NULL);
INSERT INTO `user_house_operation` VALUES (1361, 10, 12, 1, '2024-05-29 12:51:23', NULL);
INSERT INTO `user_house_operation` VALUES (1362, 10, 12, 1, '2024-05-29 12:51:24', NULL);
INSERT INTO `user_house_operation` VALUES (1363, 10, 12, 1, '2024-05-29 12:51:24', NULL);
INSERT INTO `user_house_operation` VALUES (1364, 10, 12, 1, '2024-05-29 12:51:24', NULL);
INSERT INTO `user_house_operation` VALUES (1365, 10, 12, 1, '2024-05-29 12:51:24', NULL);
INSERT INTO `user_house_operation` VALUES (1366, 10, 12, 1, '2024-05-29 12:51:24', NULL);
INSERT INTO `user_house_operation` VALUES (1367, 10, 12, 1, '2024-05-29 12:51:24', NULL);
INSERT INTO `user_house_operation` VALUES (1368, 10, 12, 1, '2024-05-29 12:51:24', NULL);
INSERT INTO `user_house_operation` VALUES (1369, 10, 12, 1, '2024-05-29 12:51:24', NULL);
INSERT INTO `user_house_operation` VALUES (1370, 10, 12, 1, '2024-05-29 12:51:24', NULL);
INSERT INTO `user_house_operation` VALUES (1371, 10, 12, 1, '2024-05-29 12:51:24', NULL);
INSERT INTO `user_house_operation` VALUES (1372, 10, 12, 1, '2024-05-29 12:51:24', NULL);
INSERT INTO `user_house_operation` VALUES (1373, 10, 12, 1, '2024-05-29 12:51:25', NULL);
INSERT INTO `user_house_operation` VALUES (1374, 10, 12, 1, '2024-05-29 12:51:25', NULL);
INSERT INTO `user_house_operation` VALUES (1375, 10, 12, 1, '2024-05-29 12:51:25', NULL);
INSERT INTO `user_house_operation` VALUES (1376, 10, 12, 1, '2024-05-29 12:51:25', NULL);
INSERT INTO `user_house_operation` VALUES (1377, 10, 12, 1, '2024-05-29 12:51:25', NULL);
INSERT INTO `user_house_operation` VALUES (1378, 10, 12, 1, '2024-05-29 12:51:25', NULL);
INSERT INTO `user_house_operation` VALUES (1379, 10, 12, 1, '2024-05-29 12:51:25', NULL);
INSERT INTO `user_house_operation` VALUES (1380, 10, 12, 1, '2024-05-29 12:51:25', NULL);
INSERT INTO `user_house_operation` VALUES (1381, 10, 12, 1, '2024-05-29 12:51:25', NULL);
INSERT INTO `user_house_operation` VALUES (1382, 10, 12, 1, '2024-05-29 12:51:25', NULL);
INSERT INTO `user_house_operation` VALUES (1383, 10, 12, 1, '2024-05-29 12:51:25', NULL);
INSERT INTO `user_house_operation` VALUES (1384, 10, 12, 1, '2024-05-29 12:51:25', NULL);
INSERT INTO `user_house_operation` VALUES (1385, 10, 12, 1, '2024-05-29 12:51:25', NULL);
INSERT INTO `user_house_operation` VALUES (1386, 10, 12, 1, '2024-05-29 12:51:25', NULL);
INSERT INTO `user_house_operation` VALUES (1387, 10, 12, 1, '2024-05-29 12:51:25', NULL);
INSERT INTO `user_house_operation` VALUES (1388, 10, 12, 1, '2024-05-29 12:51:25', NULL);
INSERT INTO `user_house_operation` VALUES (1389, 10, 12, 1, '2024-05-29 12:51:26', NULL);
INSERT INTO `user_house_operation` VALUES (1390, 10, 12, 1, '2024-05-29 12:51:26', NULL);
INSERT INTO `user_house_operation` VALUES (1391, 10, 12, 1, '2024-05-29 12:51:26', NULL);
INSERT INTO `user_house_operation` VALUES (1392, 10, 12, 1, '2024-05-29 12:51:26', NULL);
INSERT INTO `user_house_operation` VALUES (1393, 10, 12, 1, '2024-05-29 12:51:26', NULL);
INSERT INTO `user_house_operation` VALUES (1394, 10, 12, 1, '2024-05-29 12:51:26', NULL);
INSERT INTO `user_house_operation` VALUES (1395, 10, 12, 1, '2024-05-29 12:51:26', NULL);
INSERT INTO `user_house_operation` VALUES (1396, 10, 12, 1, '2024-05-29 12:51:26', NULL);
INSERT INTO `user_house_operation` VALUES (1397, 10, 12, 1, '2024-05-29 12:51:26', NULL);
INSERT INTO `user_house_operation` VALUES (1398, 10, 12, 1, '2024-05-29 12:51:27', NULL);
INSERT INTO `user_house_operation` VALUES (1399, 10, 12, 1, '2024-05-29 12:51:27', NULL);
INSERT INTO `user_house_operation` VALUES (1400, 10, 12, 1, '2024-05-29 12:51:27', NULL);
INSERT INTO `user_house_operation` VALUES (1401, 10, 12, 1, '2024-05-29 12:51:27', NULL);
INSERT INTO `user_house_operation` VALUES (1402, 10, 12, 1, '2024-05-29 12:51:27', NULL);
INSERT INTO `user_house_operation` VALUES (1403, 10, 12, 1, '2024-05-29 12:51:27', NULL);
INSERT INTO `user_house_operation` VALUES (1404, 10, 12, 1, '2024-05-29 12:51:27', NULL);
INSERT INTO `user_house_operation` VALUES (1405, 10, 12, 1, '2024-05-29 12:51:27', NULL);
INSERT INTO `user_house_operation` VALUES (1406, 10, 12, 1, '2024-05-29 12:51:27', NULL);
INSERT INTO `user_house_operation` VALUES (1407, 10, 12, 1, '2024-05-29 12:51:27', NULL);
INSERT INTO `user_house_operation` VALUES (1408, 10, 12, 1, '2024-05-29 12:51:28', NULL);
INSERT INTO `user_house_operation` VALUES (1409, 10, 12, 1, '2024-05-29 12:51:28', NULL);
INSERT INTO `user_house_operation` VALUES (1410, 10, 12, 1, '2024-05-29 12:51:28', NULL);
INSERT INTO `user_house_operation` VALUES (1411, 10, 12, 1, '2024-05-29 12:51:28', NULL);
INSERT INTO `user_house_operation` VALUES (1412, 10, 12, 1, '2024-05-29 12:51:28', NULL);
INSERT INTO `user_house_operation` VALUES (1413, 10, 12, 1, '2024-05-29 12:51:28', NULL);
INSERT INTO `user_house_operation` VALUES (1414, 10, 12, 1, '2024-05-29 12:51:28', NULL);
INSERT INTO `user_house_operation` VALUES (1415, 10, 12, 1, '2024-05-29 12:51:28', NULL);
INSERT INTO `user_house_operation` VALUES (1416, 10, 12, 1, '2024-05-29 12:51:28', NULL);
INSERT INTO `user_house_operation` VALUES (1417, 10, 12, 1, '2024-05-29 12:51:29', NULL);
INSERT INTO `user_house_operation` VALUES (1418, 10, 12, 1, '2024-05-29 12:51:29', NULL);
INSERT INTO `user_house_operation` VALUES (1419, 10, 12, 1, '2024-05-29 12:51:29', NULL);
INSERT INTO `user_house_operation` VALUES (1420, 10, 12, 1, '2024-05-29 12:51:29', NULL);
INSERT INTO `user_house_operation` VALUES (1421, 10, 12, 1, '2024-05-29 12:51:29', NULL);
INSERT INTO `user_house_operation` VALUES (1422, 10, 12, 1, '2024-05-29 12:51:29', NULL);
INSERT INTO `user_house_operation` VALUES (1423, 10, 12, 1, '2024-05-29 12:51:29', NULL);
INSERT INTO `user_house_operation` VALUES (1424, 10, 12, 1, '2024-05-29 12:51:29', NULL);
INSERT INTO `user_house_operation` VALUES (1425, 10, 12, 1, '2024-05-29 12:51:30', NULL);
INSERT INTO `user_house_operation` VALUES (1426, 10, 12, 1, '2024-05-29 12:51:30', NULL);
INSERT INTO `user_house_operation` VALUES (1427, 10, 12, 1, '2024-05-29 12:51:30', NULL);
INSERT INTO `user_house_operation` VALUES (1428, 10, 12, 1, '2024-05-29 12:51:30', NULL);
INSERT INTO `user_house_operation` VALUES (1429, 10, 12, 1, '2024-05-29 12:51:30', NULL);
INSERT INTO `user_house_operation` VALUES (1430, 10, 12, 1, '2024-05-29 12:51:30', NULL);
INSERT INTO `user_house_operation` VALUES (1431, 10, 12, 1, '2024-05-29 12:51:31', NULL);
INSERT INTO `user_house_operation` VALUES (1432, 10, 12, 1, '2024-05-29 12:51:31', NULL);
INSERT INTO `user_house_operation` VALUES (1433, 10, 12, 1, '2024-05-29 12:51:31', NULL);
INSERT INTO `user_house_operation` VALUES (1434, 10, 12, 1, '2024-05-29 12:51:31', NULL);
INSERT INTO `user_house_operation` VALUES (1435, 10, 12, 1, '2024-05-29 12:51:31', NULL);
INSERT INTO `user_house_operation` VALUES (1436, 10, 12, 1, '2024-05-29 12:51:31', NULL);
INSERT INTO `user_house_operation` VALUES (1437, 10, 12, 1, '2024-05-29 12:51:31', NULL);
INSERT INTO `user_house_operation` VALUES (1438, 10, 12, 1, '2024-05-29 12:51:31', NULL);
INSERT INTO `user_house_operation` VALUES (1439, 10, 12, 1, '2024-05-29 12:51:31', NULL);
INSERT INTO `user_house_operation` VALUES (1440, 10, 12, 1, '2024-05-29 12:51:32', NULL);
INSERT INTO `user_house_operation` VALUES (1441, 10, 12, 1, '2024-05-29 12:51:32', NULL);
INSERT INTO `user_house_operation` VALUES (1442, 10, 12, 1, '2024-05-29 12:51:32', NULL);
INSERT INTO `user_house_operation` VALUES (1443, 10, 12, 1, '2024-05-29 12:51:32', NULL);
INSERT INTO `user_house_operation` VALUES (1444, 16, 1, 1, '2024-05-29 23:34:09', NULL);
INSERT INTO `user_house_operation` VALUES (1445, 16, 90, 1, '2024-05-30 20:12:31', NULL);
INSERT INTO `user_house_operation` VALUES (1446, 16, 3, 1, '2024-05-30 20:15:25', NULL);
INSERT INTO `user_house_operation` VALUES (1447, 16, 3, 1, '2024-05-30 20:16:17', NULL);
INSERT INTO `user_house_operation` VALUES (1448, 16, 90, 1, '2024-05-30 20:17:41', NULL);
INSERT INTO `user_house_operation` VALUES (1449, 16, 90, 1, '2024-05-30 21:27:36', NULL);

SET FOREIGN_KEY_CHECKS = 1;
