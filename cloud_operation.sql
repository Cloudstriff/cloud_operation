/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50617
Source Host           : localhost:3306
Source Database       : cloud_operation

Target Server Type    : MYSQL
Target Server Version : 50617
File Encoding         : 65001

Date: 2016-03-15 09:49:59
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for co_apply
-- ----------------------------
DROP TABLE IF EXISTS `co_apply`;
CREATE TABLE `co_apply` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `msg_id` int(10) unsigned NOT NULL,
  `group_id` int(10) unsigned NOT NULL,
  `applier` int(10) unsigned NOT NULL COMMENT '申请者',
  `state` tinyint(1) DEFAULT NULL COMMENT '加群状态：1为允许，0为拒绝，null为还没确定',
  `operator` int(10) unsigned DEFAULT NULL COMMENT '操作者，指管理员和群主',
  `auth` varchar(200) DEFAULT NULL COMMENT '验证消息，可为空',
  `time` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_a_msg_id` (`msg_id`),
  KEY `fk_a_group_id` (`group_id`),
  KEY `fk_a_user_id1` (`applier`),
  KEY `fk_a_user_id2` (`operator`),
  CONSTRAINT `fk_a_group_id` FOREIGN KEY (`group_id`) REFERENCES `co_group` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_a_msg_id` FOREIGN KEY (`msg_id`) REFERENCES `co_msg` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_a_user_id1` FOREIGN KEY (`applier`) REFERENCES `co_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_a_user_id2` FOREIGN KEY (`operator`) REFERENCES `co_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of co_apply
-- ----------------------------
INSERT INTO `co_apply` VALUES ('3', '5', '170804', '170801', null, null, null, '2321323');

-- ----------------------------
-- Table structure for co_at
-- ----------------------------
DROP TABLE IF EXISTS `co_at`;
CREATE TABLE `co_at` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `msg_id` int(10) unsigned NOT NULL,
  `group_id` int(10) unsigned NOT NULL,
  `subject` int(10) unsigned NOT NULL COMMENT '被@的人',
  `object` int(10) unsigned NOT NULL COMMENT '@人的人，主体',
  `time` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_at_msg_id` (`msg_id`),
  KEY `fk_at_group_id` (`group_id`),
  KEY `fk_at_user_id1` (`subject`),
  KEY `fk_at_user_id2` (`object`),
  CONSTRAINT `fk_at_group_id` FOREIGN KEY (`group_id`) REFERENCES `co_group` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_at_msg_id` FOREIGN KEY (`msg_id`) REFERENCES `co_msg` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_at_user_id1` FOREIGN KEY (`subject`) REFERENCES `co_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_at_user_id2` FOREIGN KEY (`object`) REFERENCES `co_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of co_at
-- ----------------------------

-- ----------------------------
-- Table structure for co_delete_file
-- ----------------------------
DROP TABLE IF EXISTS `co_delete_file`;
CREATE TABLE `co_delete_file` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `msg_id` int(10) unsigned NOT NULL,
  `group_id` int(10) unsigned NOT NULL,
  `file_id` int(10) unsigned NOT NULL,
  `operator` int(10) unsigned NOT NULL,
  `time` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_df_msg_id` (`msg_id`),
  KEY `fk_df_group_id` (`group_id`),
  KEY `fk_df_file_id` (`file_id`),
  KEY `fk_df_user_id` (`operator`),
  CONSTRAINT `fk_df_file_id` FOREIGN KEY (`file_id`) REFERENCES `co_file` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_df_group_id` FOREIGN KEY (`group_id`) REFERENCES `co_group` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_df_msg_id` FOREIGN KEY (`msg_id`) REFERENCES `co_msg` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_df_user_id` FOREIGN KEY (`operator`) REFERENCES `co_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of co_delete_file
-- ----------------------------

-- ----------------------------
-- Table structure for co_dispatch
-- ----------------------------
DROP TABLE IF EXISTS `co_dispatch`;
CREATE TABLE `co_dispatch` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `msg_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `read` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否阅读，0代表未阅读，1代表已阅读',
  PRIMARY KEY (`id`),
  KEY `fk_d_msg_id` (`msg_id`),
  KEY `fk_d_user_id` (`user_id`),
  CONSTRAINT `fk_d_msg_id` FOREIGN KEY (`msg_id`) REFERENCES `co_msg` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_d_user_id` FOREIGN KEY (`user_id`) REFERENCES `co_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=224 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of co_dispatch
-- ----------------------------
INSERT INTO `co_dispatch` VALUES ('1', '1', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('2', '2', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('3', '3', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('4', '4', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('5', '5', '170801', '0');
INSERT INTO `co_dispatch` VALUES ('6', '6', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('7', '7', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('8', '8', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('9', '9', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('11', '10', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('12', '11', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('13', '12', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('14', '1', '170802', '0');
INSERT INTO `co_dispatch` VALUES ('15', '2', '170802', '0');
INSERT INTO `co_dispatch` VALUES ('16', '3', '170802', '0');
INSERT INTO `co_dispatch` VALUES ('18', '6', '170802', '0');
INSERT INTO `co_dispatch` VALUES ('19', '7', '170802', '0');
INSERT INTO `co_dispatch` VALUES ('20', '8', '170802', '0');
INSERT INTO `co_dispatch` VALUES ('21', '9', '170802', '0');
INSERT INTO `co_dispatch` VALUES ('22', '10', '170802', '0');
INSERT INTO `co_dispatch` VALUES ('23', '11', '170802', '0');
INSERT INTO `co_dispatch` VALUES ('24', '12', '170802', '0');
INSERT INTO `co_dispatch` VALUES ('25', '13', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('26', '13', '170802', '0');
INSERT INTO `co_dispatch` VALUES ('29', '15', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('30', '15', '170802', '0');
INSERT INTO `co_dispatch` VALUES ('45', '23', '170802', '0');
INSERT INTO `co_dispatch` VALUES ('47', '23', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('222', '126', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('223', '126', '170802', '0');

-- ----------------------------
-- Table structure for co_file
-- ----------------------------
DROP TABLE IF EXISTS `co_file`;
CREATE TABLE `co_file` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '文件ID',
  `name` varchar(30) NOT NULL COMMENT '文件名称（可修改）',
  `type` varchar(10) NOT NULL COMMENT '文件类型code，作为file_type表的code属性外键',
  `group_id` int(11) unsigned NOT NULL COMMENT '群组ID',
  `share` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否分享',
  `star` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否星标文件',
  `belong` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '0代表根目录',
  `ext` varchar(10) NOT NULL COMMENT '文件后缀',
  `state` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '1代表文件正常显示，0代表文件进入回收站',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_name` (`name`) USING BTREE,
  KEY `fk_file_type` (`type`),
  KEY `fk_f_group_id` (`group_id`),
  CONSTRAINT `fk_file_type` FOREIGN KEY (`type`) REFERENCES `co_file_type` (`code`) ON UPDATE CASCADE,
  CONSTRAINT `fk_f_group_id` FOREIGN KEY (`group_id`) REFERENCES `co_group` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=170905 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of co_file
-- ----------------------------
INSERT INTO `co_file` VALUES ('170800', '上传文件.docx', 'office', '170802', '0', '0', '0', 'docx', '1');
INSERT INTO `co_file` VALUES ('170801', 'test.note', 'note', '170802', '0', '0', '0', 'note', '1');
INSERT INTO `co_file` VALUES ('170804', 'Test11.note', 'note', '170802', '0', '0', '0', 'note', '1');
INSERT INTO `co_file` VALUES ('170805', '上传文件2.docx', 'office', '170802', '0', '0', '0', 'docx', '1');
INSERT INTO `co_file` VALUES ('170806', 'testImage.PNG', 'image', '170802', '1', '0', '0', 'PNG', '1');
INSERT INTO `co_file` VALUES ('170807', 'another.note', 'note', '170802', '1', '0', '0', 'note', '1');
INSERT INTO `co_file` VALUES ('170808', '需要修改FormData的地方.txt', 'text', '170802', '0', '0', '0', 'text', '1');
INSERT INTO `co_file` VALUES ('170904', '测试文件夹', 'folder', '170802', '0', '0', '0', 'dir', '1');

-- ----------------------------
-- Table structure for co_file_type
-- ----------------------------
DROP TABLE IF EXISTS `co_file_type`;
CREATE TABLE `co_file_type` (
  `code` varchar(10) NOT NULL,
  `name` varchar(10) NOT NULL,
  `ext_list` varchar(100) DEFAULT NULL,
  `state` tinyint(1) NOT NULL,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of co_file_type
-- ----------------------------
INSERT INTO `co_file_type` VALUES ('folder', '文件夹', 'dir', '1');
INSERT INTO `co_file_type` VALUES ('image', '图片', 'jpg,png,gif,bmp', '1');
INSERT INTO `co_file_type` VALUES ('md', 'Markdown', 'md', '1');
INSERT INTO `co_file_type` VALUES ('note', '云笔记', 'note', '1');
INSERT INTO `co_file_type` VALUES ('office', 'office文件', 'doc,docx,xls,xlsx,ppt,pptx', '1');
INSERT INTO `co_file_type` VALUES ('other', '其他类型', null, '1');
INSERT INTO `co_file_type` VALUES ('pdf', 'pdf文档', 'pdf', '1');
INSERT INTO `co_file_type` VALUES ('table', '云表格', 'table', '1');
INSERT INTO `co_file_type` VALUES ('text', '文本', 'txt', '1');

-- ----------------------------
-- Table structure for co_group
-- ----------------------------
DROP TABLE IF EXISTS `co_group`;
CREATE TABLE `co_group` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `validate` tinyint(2) NOT NULL,
  `capacity` int(11) NOT NULL,
  `create_time` int(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=170805 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of co_group
-- ----------------------------
INSERT INTO `co_group` VALUES ('170801', '测试群1', '2', '200', '1121212142');
INSERT INTO `co_group` VALUES ('170802', '测试群2', '1', '200', '353453428');
INSERT INTO `co_group` VALUES ('170803', '测试群3', '3', '200', '433434213');
INSERT INTO `co_group` VALUES ('170804', '测试加群', '2', '200', '2342342');

-- ----------------------------
-- Table structure for co_invite
-- ----------------------------
DROP TABLE IF EXISTS `co_invite`;
CREATE TABLE `co_invite` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `msg_id` int(10) unsigned NOT NULL,
  `group_id` int(10) unsigned NOT NULL,
  `invitor` int(10) unsigned NOT NULL,
  `invited` int(10) unsigned NOT NULL,
  `state` tinyint(1) DEFAULT NULL COMMENT '邀请状态：1为接受，0为拒绝，null为还没确定',
  `time` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_i_msg_id` (`msg_id`),
  KEY `fk_i_group_id` (`group_id`),
  KEY `fk_i_user_id1` (`invitor`),
  KEY `fk_i_user_id2` (`invited`),
  CONSTRAINT `fk_i_group_id` FOREIGN KEY (`group_id`) REFERENCES `co_group` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_i_msg_id` FOREIGN KEY (`msg_id`) REFERENCES `co_msg` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_i_user_id1` FOREIGN KEY (`invitor`) REFERENCES `co_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_i_user_id2` FOREIGN KEY (`invited`) REFERENCES `co_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of co_invite
-- ----------------------------

-- ----------------------------
-- Table structure for co_join
-- ----------------------------
DROP TABLE IF EXISTS `co_join`;
CREATE TABLE `co_join` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `msg_id` int(10) unsigned NOT NULL,
  `group_id` int(10) unsigned NOT NULL,
  `joiner` int(10) unsigned NOT NULL,
  `time` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_j_msg_id` (`msg_id`),
  KEY `fk_j_group_id` (`group_id`),
  KEY `fk_j_user_id` (`joiner`),
  CONSTRAINT `fk_j_group_id` FOREIGN KEY (`group_id`) REFERENCES `co_group` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_j_msg_id` FOREIGN KEY (`msg_id`) REFERENCES `co_msg` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_j_user_id` FOREIGN KEY (`joiner`) REFERENCES `co_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of co_join
-- ----------------------------

-- ----------------------------
-- Table structure for co_member
-- ----------------------------
DROP TABLE IF EXISTS `co_member`;
CREATE TABLE `co_member` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID标识符',
  `user_id` int(11) unsigned NOT NULL COMMENT '用户ID',
  `group_id` int(11) unsigned NOT NULL COMMENT '群组ID',
  `role` tinyint(2) NOT NULL COMMENT '用户在该群组的角色，3表示群主，2为管理员，1为编辑者',
  PRIMARY KEY (`id`),
  KEY `fk_m_user_id` (`user_id`),
  KEY `fk_m_group_id` (`group_id`),
  CONSTRAINT `fk_m_group_id` FOREIGN KEY (`group_id`) REFERENCES `co_group` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_m_user_id` FOREIGN KEY (`user_id`) REFERENCES `co_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of co_member
-- ----------------------------
INSERT INTO `co_member` VALUES ('1', '170801', '170801', '3');
INSERT INTO `co_member` VALUES ('2', '170801', '170802', '3');
INSERT INTO `co_member` VALUES ('3', '170801', '170803', '3');
INSERT INTO `co_member` VALUES ('4', '170802', '170801', '2');
INSERT INTO `co_member` VALUES ('5', '170802', '170802', '2');

-- ----------------------------
-- Table structure for co_mod_file
-- ----------------------------
DROP TABLE IF EXISTS `co_mod_file`;
CREATE TABLE `co_mod_file` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `file_id` int(10) unsigned NOT NULL,
  `name` varchar(30) NOT NULL,
  `msg_id` int(10) unsigned NOT NULL,
  `content` mediumtext COMMENT '文档内容',
  `object` int(10) unsigned NOT NULL COMMENT '主体，即用户ID，修改或者创建了某文件',
  `type` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '类型：创建为0，修改为1',
  `time` int(10) unsigned NOT NULL COMMENT '创建or修改时间',
  PRIMARY KEY (`id`),
  KEY `fk_mo_file_id` (`file_id`),
  KEY `fk_mo_user_id` (`object`),
  KEY `fk_mo_msg_id` (`msg_id`),
  CONSTRAINT `fk_mo_file_id` FOREIGN KEY (`file_id`) REFERENCES `co_file` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_mo_msg_id` FOREIGN KEY (`msg_id`) REFERENCES `co_msg` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_mo_user_id` FOREIGN KEY (`object`) REFERENCES `co_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=95 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of co_mod_file
-- ----------------------------
INSERT INTO `co_mod_file` VALUES ('1', '170801', 'test改.note', '2', 'Just for test', '170801', '0', '2424234234');
INSERT INTO `co_mod_file` VALUES ('2', '170801', 'sdasd.note', '3', 'Just for modify', '170801', '1', '4294967295');
INSERT INTO `co_mod_file` VALUES ('3', '170804', 'Test11改.note', '6', 'Testing', '170801', '0', '324234234');
INSERT INTO `co_mod_file` VALUES ('4', '170804', 'Test11改改.note', '7', 'TEstyjtgy', '170801', '1', '343434324');
INSERT INTO `co_mod_file` VALUES ('5', '170807', 'another.note', '10', 'sdwdwsdwed', '170801', '0', '435345145');
INSERT INTO `co_mod_file` VALUES ('6', '170807', 'another改.note', '11', '3rwwerfwerwer', '170801', '1', '3424234234');
INSERT INTO `co_mod_file` VALUES ('94', '170904', '测试文件夹', '126', null, '170801', '0', '1457950802');

-- ----------------------------
-- Table structure for co_msg
-- ----------------------------
DROP TABLE IF EXISTS `co_msg`;
CREATE TABLE `co_msg` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(10) NOT NULL COMMENT '消息类型（type:upload/create/modify/delete/send/：群通知\r\ntype:apply有人申请入群/invite有人邀请你入群/remove移除成员/delete解散群组：群消息\r\ntype:有人@你@:个人消息）',
  `group_id` int(10) unsigned NOT NULL,
  `time` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_msg_group_id` (`group_id`),
  KEY `fk_msg_type` (`type`),
  CONSTRAINT `fk_msg_group_id` FOREIGN KEY (`group_id`) REFERENCES `co_group` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_msg_type` FOREIGN KEY (`type`) REFERENCES `co_msg_type` (`code`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=127 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of co_msg
-- ----------------------------
INSERT INTO `co_msg` VALUES ('1', 'upload', '170802', '45345345');
INSERT INTO `co_msg` VALUES ('2', 'create', '170802', '34234234');
INSERT INTO `co_msg` VALUES ('3', 'modify', '170802', '4294967295');
INSERT INTO `co_msg` VALUES ('4', 'send', '170803', '45345345');
INSERT INTO `co_msg` VALUES ('5', 'apply', '170802', '453453453');
INSERT INTO `co_msg` VALUES ('6', 'create', '170802', '4294967295');
INSERT INTO `co_msg` VALUES ('7', 'modify', '170802', '3434353');
INSERT INTO `co_msg` VALUES ('8', 'upload', '170802', '4294967295');
INSERT INTO `co_msg` VALUES ('9', 'upload', '170802', '4294967295');
INSERT INTO `co_msg` VALUES ('10', 'create', '170802', '454545435');
INSERT INTO `co_msg` VALUES ('11', 'modify', '170802', '3434343');
INSERT INTO `co_msg` VALUES ('12', 'upload', '170802', '4294967295');
INSERT INTO `co_msg` VALUES ('13', 'send', '170802', '4294967295');
INSERT INTO `co_msg` VALUES ('15', 'new', '170801', '4294967295');
INSERT INTO `co_msg` VALUES ('23', 'send', '170802', '23123123');
INSERT INTO `co_msg` VALUES ('126', 'create', '170802', '1457950802');

-- ----------------------------
-- Table structure for co_msg_type
-- ----------------------------
DROP TABLE IF EXISTS `co_msg_type`;
CREATE TABLE `co_msg_type` (
  `code` varchar(10) NOT NULL,
  `type` varchar(4) NOT NULL COMMENT 'msg代表个人/群消息，noti代表群通知',
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of co_msg_type
-- ----------------------------
INSERT INTO `co_msg_type` VALUES ('@', 'msg');
INSERT INTO `co_msg_type` VALUES ('apply', 'msg');
INSERT INTO `co_msg_type` VALUES ('create', 'noti');
INSERT INTO `co_msg_type` VALUES ('delete', 'noti');
INSERT INTO `co_msg_type` VALUES ('invite', 'msg');
INSERT INTO `co_msg_type` VALUES ('join', 'msg');
INSERT INTO `co_msg_type` VALUES ('modify', 'noti');
INSERT INTO `co_msg_type` VALUES ('new', 'noti');
INSERT INTO `co_msg_type` VALUES ('remove', 'msg');
INSERT INTO `co_msg_type` VALUES ('send', 'noti');
INSERT INTO `co_msg_type` VALUES ('upload', 'noti');

-- ----------------------------
-- Table structure for co_remove
-- ----------------------------
DROP TABLE IF EXISTS `co_remove`;
CREATE TABLE `co_remove` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `msg_id` int(10) unsigned NOT NULL,
  `group_id` int(10) unsigned NOT NULL,
  `remover` int(10) unsigned NOT NULL,
  `operator` int(10) unsigned NOT NULL,
  `time` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_r_msg_id` (`msg_id`),
  KEY `fk_r_group_id` (`group_id`),
  KEY `fk_r_user_id1` (`remover`),
  KEY `fk_r_user_id2` (`operator`),
  CONSTRAINT `fk_r_group_id` FOREIGN KEY (`group_id`) REFERENCES `co_group` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_r_msg_id` FOREIGN KEY (`msg_id`) REFERENCES `co_msg` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_r_user_id1` FOREIGN KEY (`remover`) REFERENCES `co_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_r_user_id2` FOREIGN KEY (`operator`) REFERENCES `co_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of co_remove
-- ----------------------------

-- ----------------------------
-- Table structure for co_send_msg
-- ----------------------------
DROP TABLE IF EXISTS `co_send_msg`;
CREATE TABLE `co_send_msg` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `msg_id` int(10) unsigned NOT NULL,
  `object` int(10) unsigned NOT NULL COMMENT '发送消息的主体，即用户ID',
  `content` varchar(200) NOT NULL COMMENT '消息内容',
  PRIMARY KEY (`id`),
  KEY `fk_s_msg_id` (`msg_id`),
  KEY `fk_s_user_id` (`object`),
  CONSTRAINT `fk_s_msg_id` FOREIGN KEY (`msg_id`) REFERENCES `co_msg` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_s_user_id` FOREIGN KEY (`object`) REFERENCES `co_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of co_send_msg
-- ----------------------------
INSERT INTO `co_send_msg` VALUES ('1', '4', '170801', 'Test send msg');
INSERT INTO `co_send_msg` VALUES ('2', '13', '170801', 'Test for sending message');
INSERT INTO `co_send_msg` VALUES ('11', '23', '170802', '测试发送消息和通知推送接口');

-- ----------------------------
-- Table structure for co_share
-- ----------------------------
DROP TABLE IF EXISTS `co_share`;
CREATE TABLE `co_share` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fid` int(10) unsigned NOT NULL COMMENT '文件ID',
  `token` varchar(60) DEFAULT NULL,
  `uid` int(10) unsigned DEFAULT NULL,
  `time` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_share_fid` (`fid`),
  KEY `fk_share_uid` (`uid`),
  CONSTRAINT `fk_share_fid` FOREIGN KEY (`fid`) REFERENCES `co_file` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_share_uid` FOREIGN KEY (`uid`) REFERENCES `co_user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of co_share
-- ----------------------------
INSERT INTO `co_share` VALUES ('23', '170806', '$2y$10$9myKNsA55TmzpekzGPCuxe1znxrA8KObwikkmYOmUdznEjRxOFnc.', '170801', '1457599785');
INSERT INTO `co_share` VALUES ('24', '170807', '$2y$10$a0Zncb1UO9l18wXy95FvZuh5tQOmqa59BOp14qbAiM4FJBQIK1ecW', '170801', '1457608277');

-- ----------------------------
-- Table structure for co_unmod_file
-- ----------------------------
DROP TABLE IF EXISTS `co_unmod_file`;
CREATE TABLE `co_unmod_file` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增量主键ID',
  `file_id` int(11) unsigned NOT NULL COMMENT '文件ID',
  `name` varchar(30) NOT NULL COMMENT '文件名',
  `msg_id` int(10) unsigned NOT NULL,
  `url` varchar(200) NOT NULL COMMENT '文件存放真实地址',
  `size` float unsigned NOT NULL COMMENT '文件大小',
  `uploader` int(11) unsigned NOT NULL COMMENT '上传者',
  `time` int(10) unsigned NOT NULL COMMENT '上传时间',
  PRIMARY KEY (`id`),
  KEY `fk_um_file_id` (`file_id`),
  KEY `fk_um_user_id` (`uploader`),
  KEY `fk_um_msg_id` (`msg_id`),
  CONSTRAINT `fk_um_file_id` FOREIGN KEY (`file_id`) REFERENCES `co_file` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_um_msg_id` FOREIGN KEY (`msg_id`) REFERENCES `co_msg` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_um_user_id` FOREIGN KEY (`uploader`) REFERENCES `co_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of co_unmod_file
-- ----------------------------
INSERT INTO `co_unmod_file` VALUES ('1', '170800', '上传文件.docx', '1', '/public/uploads/directory/xddsasasaddasaS.docx', '15000', '170801', '2242342342');
INSERT INTO `co_unmod_file` VALUES ('3', '170805', 'test改改.note', '8', '/public/uploads/directory/dfgdfhgdfhgedfhbdhdttfh.doc', '56000', '170801', '4294967293');
INSERT INTO `co_unmod_file` VALUES ('5', '170806', 'testImage.png', '9', '/public/uploads/directory/dsfsdfvsgvdfgdfgdfhdfhfgh.PNG', '8000', '170801', '4294967294');
INSERT INTO `co_unmod_file` VALUES ('6', '170808', '需要修改FormData的地方.txt', '12', '/public/uploads/directory/dfdsfsdfsdfsdfsfsf.txt', '65', '170801', '3423423423');

-- ----------------------------
-- Table structure for co_user
-- ----------------------------
DROP TABLE IF EXISTS `co_user`;
CREATE TABLE `co_user` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `account` varchar(320) NOT NULL COMMENT '账号',
  `user_name` varchar(30) NOT NULL COMMENT '昵称',
  `pass` varchar(60) NOT NULL COMMENT '密码',
  `sex` tinyint(1) DEFAULT NULL COMMENT '性别：1为男，0为女',
  `avatar_url` varchar(200) DEFAULT NULL COMMENT '个人头像地址',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=170803 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of co_user
-- ----------------------------
INSERT INTO `co_user` VALUES ('170801', 'chenjiongwendao@qq.com', 'Cloudstriff', '$2y$10$SqQOFzsYHir6zSoIPq7/a.DUUt.XWlnrFrkJS0qzvCa332N29PVjG', '1', '/public/uploads/avatar/user_hd_618a30cbb633caefa557de9272178b4e.png');
INSERT INTO `co_user` VALUES ('170802', '394950633@qq.com', 'Cloud', '$2y$10$SqQOFzsYHir6zSoIPq7/a.DUUt.XWlnrFrkJS0qzvCa332N29PVjG', '1', '/public/uploads/avatar/2015-07-30/55ba363510f74.PNG');

-- ----------------------------
-- View structure for co_view_group_member
-- ----------------------------
DROP VIEW IF EXISTS `co_view_group_member`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER  VIEW `co_view_group_member` AS select `co_group`.`id` AS `id`,`co_user`.`account` AS `account`,`co_user`.`user_name` AS `user_name`,`co_user`.`sex` AS `sex`,`co_user`.`avatar_url` AS `avatar_url`,`co_member`.`role` AS `role` from ((`co_group` join `co_member`) join `co_user`) where ((`co_group`.`id` = `co_member`.`group_id`) and (`co_member`.`user_id` = `co_user`.`id`)) ; ;

-- ----------------------------
-- View structure for co_view_group_modfile
-- ----------------------------
DROP VIEW IF EXISTS `co_view_group_modfile`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER  VIEW `co_view_group_modfile` AS select `co_group`.`id` AS `id`,`co_file`.`id` AS `fid`,`co_file`.`type` AS `type`,`co_file`.`share` AS `share`,`co_file`.`star` AS `star`,`co_file`.`belong` AS `belong`,`co_file`.`ext` AS `ext`,length(`co_mod_file`.`content`) AS `size`,`co_mod_file`.`object` AS `object`,`co_mod_file`.`time` AS `time`,`co_mod_file`.`name` AS `name`,`co_user`.`user_name` AS `user_name`
from (((`co_group` join `co_file`) join `co_mod_file`) join `co_user`)
WHERE
((co_group.id = co_file.group_id) AND
(co_file.id = co_mod_file.file_id) AND
(co_file.belong = 0) AND
(co_mod_file.object = co_user.id))
order by `co_mod_file`.`id` desc ;

-- ----------------------------
-- View structure for co_view_group_msg_apply
-- ----------------------------
DROP VIEW IF EXISTS `co_view_group_msg_apply`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER  VIEW `co_view_group_msg_apply` AS SELECT
co_msg.id,
co_msg.type,
co_msg.time,
co_apply.applier,
co_apply.operator,
co_apply.state,
co_apply.auth
FROM
co_msg
INNER JOIN co_apply ON co_apply.msg_id = co_msg.id ;

-- ----------------------------
-- View structure for co_view_group_msg_invite
-- ----------------------------
DROP VIEW IF EXISTS `co_view_group_msg_invite`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost`  VIEW `co_view_group_msg_invite` AS SELECT
co_msg.id,
co_msg.type,
co_msg.time,
co_invite.invitor,
co_invite.invited,
co_invite.state
FROM
co_msg
INNER JOIN co_invite ON co_invite.msg_id = co_msg.id ;

-- ----------------------------
-- View structure for co_view_group_msg_remove
-- ----------------------------
DROP VIEW IF EXISTS `co_view_group_msg_remove`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost`  VIEW `co_view_group_msg_remove` AS SELECT
co_msg.id,
co_msg.type,
co_msg.time,
co_remove.remover,
co_remove.operator
FROM
co_msg
INNER JOIN co_remove ON co_remove.msg_id = co_msg.id ;

-- ----------------------------
-- View structure for co_view_group_noti
-- ----------------------------
DROP VIEW IF EXISTS `co_view_group_noti`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost`  VIEW `co_view_group_noti` AS SELECT *
FROM
co_view_group_noti_unmodfile UNION
select * from co_view_group_noti_modfile
ORDER BY id ;

-- ----------------------------
-- View structure for co_view_group_noti_create_group
-- ----------------------------
DROP VIEW IF EXISTS `co_view_group_noti_create_group`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER  VIEW `co_view_group_noti_create_group` AS SELECT
co_msg.id,
co_msg.type,
co_msg.group_id,
co_msg.time,
co_group.`name`,
co_member.role,
co_member.user_id,
co_user.user_name,
co_user.avatar_url
FROM
co_msg
INNER JOIN co_group ON co_msg.group_id = co_group.id
INNER JOIN co_member ON co_member.group_id = co_group.id
INNER JOIN co_user ON co_member.user_id = co_user.id
WHERE
co_member.role = 3 AND
co_msg.type = 'new' ;

-- ----------------------------
-- View structure for co_view_group_noti_modfile
-- ----------------------------
DROP VIEW IF EXISTS `co_view_group_noti_modfile`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER  VIEW `co_view_group_noti_modfile` AS SELECT
co_msg.id,
co_msg.type,
co_msg.time,
co_mod_file.file_id,
co_mod_file.`name`,
co_mod_file.object,
co_user.user_name,
co_file.type AS file_type,
co_file.belong,
co_msg.group_id,
co_user.avatar_url
FROM
co_msg
INNER JOIN co_mod_file ON co_mod_file.msg_id = co_msg.id
INNER JOIN co_user ON co_mod_file.object = co_user.id
INNER JOIN co_file ON co_mod_file.file_id = co_file.id
ORDER BY
co_msg.id ASC ;

-- ----------------------------
-- View structure for co_view_group_noti_sendmsg
-- ----------------------------
DROP VIEW IF EXISTS `co_view_group_noti_sendmsg`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER  VIEW `co_view_group_noti_sendmsg` AS SELECT
co_msg.id,
co_msg.type,
co_msg.time,
co_msg.group_id,
co_send_msg.object,
co_send_msg.content,
co_user.user_name,
co_user.avatar_url
FROM
co_msg
INNER JOIN co_send_msg ON co_send_msg.msg_id = co_msg.id
INNER JOIN co_user ON co_send_msg.object = co_user.id
ORDER BY
co_msg.id ASC ;

-- ----------------------------
-- View structure for co_view_group_noti_unmodfile
-- ----------------------------
DROP VIEW IF EXISTS `co_view_group_noti_unmodfile`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER  VIEW `co_view_group_noti_unmodfile` AS SELECT
co_msg.id,
co_msg.type,
co_msg.time,
co_unmod_file.file_id,
co_unmod_file.`name`,
co_unmod_file.uploader AS object,
co_user.user_name,
co_file.type AS file_type,
co_file.belong,
co_msg.group_id,
co_user.avatar_url
FROM
co_msg
INNER JOIN co_unmod_file ON co_unmod_file.msg_id = co_msg.id
INNER JOIN co_user ON co_unmod_file.uploader = co_user.id
INNER JOIN co_file ON co_unmod_file.file_id = co_file.id ;

-- ----------------------------
-- View structure for co_view_group_unmodfile
-- ----------------------------
DROP VIEW IF EXISTS `co_view_group_unmodfile`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER  VIEW `co_view_group_unmodfile` AS SELECT
co_group.id AS id,
co_file.id AS fid,
co_file.ext AS ext,
co_file.type AS type,
co_file.belong AS belong,
co_file.star AS star,
co_file.`share` AS `share`,
co_unmod_file.uploader AS object,
co_unmod_file.time AS time,
co_unmod_file.size AS size,
co_user.user_name AS user_name,
co_unmod_file.url AS url,
co_unmod_file.`name`
from (((`co_group` join `co_file`) join `co_unmod_file`) join `co_user`)
WHERE
((co_group.id = co_file.group_id) AND
(co_file.id = co_unmod_file.file_id) AND
(co_file.belong = 0) AND
(co_unmod_file.uploader = co_user.id))
ORDER BY
time DESC ;

-- ----------------------------
-- View structure for co_view_msg_comet
-- ----------------------------
DROP VIEW IF EXISTS `co_view_msg_comet`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER  VIEW `co_view_msg_comet` AS SELECT
co_dispatch.id,
co_dispatch.msg_id,
co_dispatch.user_id,
co_msg.type AS `code`,
co_msg_type.type
FROM
co_dispatch
INNER JOIN co_msg ON co_dispatch.msg_id = co_msg.id
INNER JOIN co_msg_type ON co_msg.type = co_msg_type.`code`
WHERE
co_msg_type.type = 'msg' AND
co_dispatch.`read` = 0 ;

-- ----------------------------
-- View structure for co_view_noti_comet
-- ----------------------------
DROP VIEW IF EXISTS `co_view_noti_comet`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER  VIEW `co_view_noti_comet` AS SELECT
co_dispatch.id,
co_dispatch.msg_id,
co_dispatch.user_id,
co_msg.group_id,
co_msg_type.type,
co_msg.type AS `code`
FROM
co_dispatch
INNER JOIN co_msg ON co_dispatch.msg_id = co_msg.id
INNER JOIN co_msg_type ON co_msg.type = co_msg_type.`code`
WHERE
co_dispatch.`read` = 0 AND
co_msg_type.type = 'noti' ;

-- ----------------------------
-- Procedure structure for add_mod_file
-- ----------------------------
DROP PROCEDURE IF EXISTS `add_mod_file`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_mod_file`(IN `msgType` varchar(10),IN `object` int,IN `name` varchar(30),IN `belong` int,IN `gid` int,IN `type` varchar(10),IN `ext` varchar(10),IN `content` mediumtext,IN `_time` int,OUT `flag` tinyint)
BEGIN
	/* 定义变量 */  
	#declare P_ID INT;
	declare currentTime int;
	declare msgId int;
	declare fileId int;
	declare modFileId int;
	declare dId int;
	declare userId int;
	declare _done int default 0;
	declare _Cur CURSOR FOR SELECT user_id FROM co_member WHERE group_id=gid;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET _done = 1;
	DECLARE CONTINUE HANDLER FOR 1329 SET _done = 1;
	#declare CONTINUE HANDLER FOR SQLSTATE '02000' SET userId = 0;
	set currentTime=_time;
	set flag=0;
	START TRANSACTION;
		INSERT INTO co_msg VALUES(null,msgType,gid,currentTime);
		set msgId=LAST_INSERT_ID();
		if msgId>=1 THEN
			INSERT INTO co_file VALUES(null,name,type,gid,0,0,belong,ext,1);
			SET fileId=LAST_INSERT_ID();
			if fileId>=1 THEN
				INSERT INTO co_mod_file VALUES(null,fileId,name,msgId,NULL,object,0,currentTime);
				set modFileId=LAST_INSERT_ID();
				if modFileId>=1 THEN						
						OPEN _Cur;  
						/* 循环执行 */  
						REPEAT  
							FETCH _Cur INTO userId;  
								IF NOT _done THEN  
									INSERT INTO co_dispatch VALUES(null,msgId,userId,0);
									set dId=LAST_INSERT_ID();
									if dId<1 THEN	
										ROLLBACK;
									end IF;
								END IF;  
						UNTIL _done END REPEAT; #当_done=1时退出被循  
						/*关闭光标*/  
						CLOSE _Cur;  
						SET _done = 0;#只有定义为0，新的循环才能继续。
						COMMIT;
						set flag=1;
						#SELECT group_id as id,co_file.id as fid,type,share,star,belong,ext,length(co_mod_file.content) AS size,co_mod_file.object,co_mod_file.time,co_mod_file.name,co_user.user_name from ((co_file join co_mod_file) join co_user) WHERE co_file.id = co_mod_file.file_id AND co_mod_file.object = co_user.id AND co_file.id=fileId;
				ELSE
					ROLLBACK;
				end IF;
			ELSE
				ROLLBACK;
			end IF;
		end IF;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for get_group_info
-- ----------------------------
DROP PROCEDURE IF EXISTS `get_group_info`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_group_info`(IN `gid` int)
BEGIN
	#Routine body goes here...
	
	SELECT * from co_view_group_unmodfile WHERE id=gid;
SELECT * from co_view_group_modfile WHERE id=gid;
	SELECT account,user_name,sex,avatar_url,role from co_view_group_member WHERE group_id=gid;
	SELECT co_group.id,name,validate,capacity,count(user_id) as count from co_group join co_member on co_group.id=co_member.group_id WHERE co_group.id=gid;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for get_group_msg
-- ----------------------------
DROP PROCEDURE IF EXISTS `get_group_msg`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_group_msg`(IN `gid` int)
BEGIN
	#Routine body goes here...
	SELECT * from co_view_group_noti WHERE group_id=gid ORDER BY id ASC;
	SELECT * from co_view_group_noti_sendmsg WHERE group_id=gid;
	SELECT * from co_view_group_noti_create_group WHERE group_id=gid;
END
;;
DELIMITER ;
