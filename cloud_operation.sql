/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50617
Source Host           : localhost:3306
Source Database       : cloud_operation

Target Server Type    : MYSQL
Target Server Version : 50617
File Encoding         : 65001

Date: 2016-03-17 14:38:48
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of co_apply
-- ----------------------------

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
  `file_id` int(10) unsigned NOT NULL,
  `operator` int(10) unsigned NOT NULL,
  `time` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_df_msg_id` (`msg_id`),
  KEY `fk_df_file_id` (`file_id`),
  KEY `fk_df_user_id` (`operator`),
  CONSTRAINT `fk_df_file_id` FOREIGN KEY (`file_id`) REFERENCES `co_file` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_df_msg_id` FOREIGN KEY (`msg_id`) REFERENCES `co_msg` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_df_user_id` FOREIGN KEY (`operator`) REFERENCES `co_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of co_delete_file
-- ----------------------------
INSERT INTO `co_delete_file` VALUES ('1', '334', '171004', '170801', '1458048485');
INSERT INTO `co_delete_file` VALUES ('2', '335', '171005', '170801', '1458048485');
INSERT INTO `co_delete_file` VALUES ('3', '336', '170999', '170801', '1458048488');
INSERT INTO `co_delete_file` VALUES ('4', '337', '170998', '170801', '1458048488');
INSERT INTO `co_delete_file` VALUES ('5', '348', '171014', '170801', '1458106204');
INSERT INTO `co_delete_file` VALUES ('6', '349', '171006', '170801', '1458106204');
INSERT INTO `co_delete_file` VALUES ('7', '350', '171015', '170801', '1458106207');
INSERT INTO `co_delete_file` VALUES ('8', '351', '171016', '170801', '1458106207');
INSERT INTO `co_delete_file` VALUES ('9', '354', '171018', '170801', '1458106906');
INSERT INTO `co_delete_file` VALUES ('10', '355', '171017', '170801', '1458106906');
INSERT INTO `co_delete_file` VALUES ('11', '358', '171020', '170801', '1458108678');
INSERT INTO `co_delete_file` VALUES ('12', '359', '171019', '170801', '1458108678');
INSERT INTO `co_delete_file` VALUES ('13', '366', '171022', '170801', '1458108980');
INSERT INTO `co_delete_file` VALUES ('14', '367', '171021', '170801', '1458108981');
INSERT INTO `co_delete_file` VALUES ('15', '370', '171024', '170801', '1458109126');
INSERT INTO `co_delete_file` VALUES ('16', '373', '171025', '170801', '1458109252');
INSERT INTO `co_delete_file` VALUES ('17', '374', '171023', '170801', '1458109252');
INSERT INTO `co_delete_file` VALUES ('18', '376', '170996', '170801', '1458109277');
INSERT INTO `co_delete_file` VALUES ('19', '377', '171027', '170801', '1458112051');
INSERT INTO `co_delete_file` VALUES ('20', '378', '171026', '170801', '1458112051');
INSERT INTO `co_delete_file` VALUES ('21', '381', '171028', '170801', '1458112151');
INSERT INTO `co_delete_file` VALUES ('22', '384', '171030', '170801', '1458113941');
INSERT INTO `co_delete_file` VALUES ('23', '385', '171029', '170801', '1458113941');
INSERT INTO `co_delete_file` VALUES ('24', '388', '171032', '170801', '1458114058');
INSERT INTO `co_delete_file` VALUES ('25', '389', '171031', '170801', '1458114059');
INSERT INTO `co_delete_file` VALUES ('26', '392', '171034', '170801', '1458114172');
INSERT INTO `co_delete_file` VALUES ('27', '393', '171035', '170801', '1458114172');
INSERT INTO `co_delete_file` VALUES ('28', '403', '171040', '170801', '1458131138');
INSERT INTO `co_delete_file` VALUES ('29', '416', '171002', '170802', '1458179770');
INSERT INTO `co_delete_file` VALUES ('30', '421', '171037', '170801', '1458183003');

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
) ENGINE=InnoDB AUTO_INCREMENT=753 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of co_dispatch
-- ----------------------------
INSERT INTO `co_dispatch` VALUES ('554', '322', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('555', '322', '170802', '1');
INSERT INTO `co_dispatch` VALUES ('556', '323', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('557', '323', '170802', '1');
INSERT INTO `co_dispatch` VALUES ('558', '324', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('559', '324', '170802', '1');
INSERT INTO `co_dispatch` VALUES ('560', '325', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('561', '325', '170802', '1');
INSERT INTO `co_dispatch` VALUES ('562', '326', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('563', '326', '170802', '1');
INSERT INTO `co_dispatch` VALUES ('564', '328', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('565', '328', '170802', '1');
INSERT INTO `co_dispatch` VALUES ('566', '329', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('567', '329', '170802', '1');
INSERT INTO `co_dispatch` VALUES ('568', '330', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('569', '331', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('570', '331', '170802', '1');
INSERT INTO `co_dispatch` VALUES ('571', '332', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('572', '332', '170802', '1');
INSERT INTO `co_dispatch` VALUES ('573', '333', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('574', '333', '170802', '1');
INSERT INTO `co_dispatch` VALUES ('575', '334', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('576', '334', '170802', '1');
INSERT INTO `co_dispatch` VALUES ('577', '335', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('578', '335', '170802', '1');
INSERT INTO `co_dispatch` VALUES ('579', '336', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('580', '336', '170802', '1');
INSERT INTO `co_dispatch` VALUES ('581', '337', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('582', '337', '170802', '1');
INSERT INTO `co_dispatch` VALUES ('589', '343', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('590', '344', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('591', '345', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('592', '345', '170802', '1');
INSERT INTO `co_dispatch` VALUES ('593', '346', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('594', '346', '170802', '1');
INSERT INTO `co_dispatch` VALUES ('595', '347', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('596', '347', '170802', '1');
INSERT INTO `co_dispatch` VALUES ('597', '348', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('598', '348', '170802', '1');
INSERT INTO `co_dispatch` VALUES ('599', '349', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('600', '349', '170802', '1');
INSERT INTO `co_dispatch` VALUES ('601', '350', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('602', '350', '170802', '1');
INSERT INTO `co_dispatch` VALUES ('603', '351', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('604', '351', '170802', '1');
INSERT INTO `co_dispatch` VALUES ('605', '352', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('606', '352', '170802', '1');
INSERT INTO `co_dispatch` VALUES ('607', '353', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('608', '353', '170802', '1');
INSERT INTO `co_dispatch` VALUES ('609', '354', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('610', '354', '170802', '1');
INSERT INTO `co_dispatch` VALUES ('611', '355', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('612', '355', '170802', '1');
INSERT INTO `co_dispatch` VALUES ('613', '356', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('614', '356', '170802', '1');
INSERT INTO `co_dispatch` VALUES ('615', '357', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('616', '357', '170802', '1');
INSERT INTO `co_dispatch` VALUES ('617', '358', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('618', '358', '170802', '1');
INSERT INTO `co_dispatch` VALUES ('619', '359', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('620', '359', '170802', '1');
INSERT INTO `co_dispatch` VALUES ('621', '360', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('622', '360', '170802', '1');
INSERT INTO `co_dispatch` VALUES ('623', '361', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('624', '361', '170802', '1');
INSERT INTO `co_dispatch` VALUES ('625', '366', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('626', '366', '170802', '1');
INSERT INTO `co_dispatch` VALUES ('627', '367', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('628', '367', '170802', '1');
INSERT INTO `co_dispatch` VALUES ('629', '368', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('630', '368', '170802', '1');
INSERT INTO `co_dispatch` VALUES ('631', '369', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('632', '369', '170802', '1');
INSERT INTO `co_dispatch` VALUES ('633', '370', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('634', '370', '170802', '1');
INSERT INTO `co_dispatch` VALUES ('635', '371', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('636', '371', '170802', '1');
INSERT INTO `co_dispatch` VALUES ('637', '372', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('638', '372', '170802', '1');
INSERT INTO `co_dispatch` VALUES ('639', '373', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('640', '373', '170802', '1');
INSERT INTO `co_dispatch` VALUES ('641', '374', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('642', '374', '170802', '1');
INSERT INTO `co_dispatch` VALUES ('643', '375', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('644', '375', '170802', '1');
INSERT INTO `co_dispatch` VALUES ('645', '376', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('646', '376', '170802', '1');
INSERT INTO `co_dispatch` VALUES ('647', '377', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('648', '377', '170802', '1');
INSERT INTO `co_dispatch` VALUES ('649', '378', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('650', '378', '170802', '1');
INSERT INTO `co_dispatch` VALUES ('651', '379', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('652', '379', '170802', '1');
INSERT INTO `co_dispatch` VALUES ('653', '380', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('654', '380', '170802', '1');
INSERT INTO `co_dispatch` VALUES ('655', '381', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('656', '381', '170802', '1');
INSERT INTO `co_dispatch` VALUES ('657', '382', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('658', '382', '170802', '1');
INSERT INTO `co_dispatch` VALUES ('659', '383', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('660', '383', '170802', '1');
INSERT INTO `co_dispatch` VALUES ('661', '384', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('662', '384', '170802', '1');
INSERT INTO `co_dispatch` VALUES ('663', '385', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('664', '385', '170802', '1');
INSERT INTO `co_dispatch` VALUES ('665', '386', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('666', '386', '170802', '1');
INSERT INTO `co_dispatch` VALUES ('667', '387', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('668', '387', '170802', '1');
INSERT INTO `co_dispatch` VALUES ('669', '388', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('670', '388', '170802', '1');
INSERT INTO `co_dispatch` VALUES ('671', '389', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('672', '389', '170802', '1');
INSERT INTO `co_dispatch` VALUES ('673', '390', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('674', '390', '170802', '1');
INSERT INTO `co_dispatch` VALUES ('675', '391', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('676', '391', '170802', '1');
INSERT INTO `co_dispatch` VALUES ('677', '392', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('678', '392', '170802', '1');
INSERT INTO `co_dispatch` VALUES ('679', '393', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('680', '393', '170802', '1');
INSERT INTO `co_dispatch` VALUES ('681', '394', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('682', '394', '170802', '1');
INSERT INTO `co_dispatch` VALUES ('683', '395', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('684', '395', '170802', '1');
INSERT INTO `co_dispatch` VALUES ('685', '396', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('686', '396', '170802', '1');
INSERT INTO `co_dispatch` VALUES ('687', '397', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('688', '397', '170802', '1');
INSERT INTO `co_dispatch` VALUES ('689', '398', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('690', '398', '170802', '1');
INSERT INTO `co_dispatch` VALUES ('691', '399', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('692', '399', '170802', '1');
INSERT INTO `co_dispatch` VALUES ('693', '400', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('694', '400', '170802', '1');
INSERT INTO `co_dispatch` VALUES ('695', '401', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('696', '401', '170802', '1');
INSERT INTO `co_dispatch` VALUES ('697', '402', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('698', '402', '170802', '1');
INSERT INTO `co_dispatch` VALUES ('699', '403', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('700', '403', '170802', '1');
INSERT INTO `co_dispatch` VALUES ('701', '404', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('702', '404', '170802', '1');
INSERT INTO `co_dispatch` VALUES ('703', '405', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('704', '405', '170802', '1');
INSERT INTO `co_dispatch` VALUES ('705', '406', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('706', '406', '170802', '1');
INSERT INTO `co_dispatch` VALUES ('707', '407', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('708', '407', '170802', '1');
INSERT INTO `co_dispatch` VALUES ('709', '408', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('710', '408', '170802', '1');
INSERT INTO `co_dispatch` VALUES ('711', '409', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('712', '409', '170802', '1');
INSERT INTO `co_dispatch` VALUES ('713', '410', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('714', '410', '170802', '1');
INSERT INTO `co_dispatch` VALUES ('715', '411', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('716', '411', '170802', '1');
INSERT INTO `co_dispatch` VALUES ('717', '412', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('718', '412', '170802', '1');
INSERT INTO `co_dispatch` VALUES ('719', '413', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('720', '413', '170802', '1');
INSERT INTO `co_dispatch` VALUES ('721', '414', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('722', '414', '170802', '1');
INSERT INTO `co_dispatch` VALUES ('723', '415', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('724', '415', '170802', '1');
INSERT INTO `co_dispatch` VALUES ('725', '416', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('726', '416', '170802', '1');
INSERT INTO `co_dispatch` VALUES ('727', '417', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('728', '417', '170802', '1');
INSERT INTO `co_dispatch` VALUES ('729', '418', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('730', '418', '170802', '1');
INSERT INTO `co_dispatch` VALUES ('731', '419', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('732', '419', '170802', '1');
INSERT INTO `co_dispatch` VALUES ('733', '420', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('734', '420', '170802', '1');
INSERT INTO `co_dispatch` VALUES ('735', '421', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('736', '421', '170802', '1');
INSERT INTO `co_dispatch` VALUES ('737', '422', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('738', '422', '170802', '1');
INSERT INTO `co_dispatch` VALUES ('739', '423', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('740', '423', '170802', '1');
INSERT INTO `co_dispatch` VALUES ('741', '424', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('742', '424', '170802', '1');
INSERT INTO `co_dispatch` VALUES ('743', '425', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('744', '425', '170802', '1');
INSERT INTO `co_dispatch` VALUES ('745', '426', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('746', '426', '170802', '1');
INSERT INTO `co_dispatch` VALUES ('747', '427', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('748', '427', '170802', '0');
INSERT INTO `co_dispatch` VALUES ('749', '428', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('750', '428', '170802', '0');
INSERT INTO `co_dispatch` VALUES ('751', '429', '170801', '1');
INSERT INTO `co_dispatch` VALUES ('752', '429', '170802', '0');

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
  KEY `fk_file_type` (`type`),
  KEY `fk_f_group_id` (`group_id`),
  CONSTRAINT `fk_file_type` FOREIGN KEY (`type`) REFERENCES `co_file_type` (`code`) ON UPDATE CASCADE,
  CONSTRAINT `fk_f_group_id` FOREIGN KEY (`group_id`) REFERENCES `co_group` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=171052 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of co_file
-- ----------------------------
INSERT INTO `co_file` VALUES ('170995', '新建文件夹', 'folder', '170802', '0', '0', '0', 'dir', '1');
INSERT INTO `co_file` VALUES ('170996', '第三方士大夫', 'note', '170802', '0', '0', '0', 'note', '0');
INSERT INTO `co_file` VALUES ('170997', '第三方第三方', 'folder', '170801', '0', '0', '0', 'dir', '1');
INSERT INTO `co_file` VALUES ('170998', '水电费水电费', 'folder', '170802', '0', '0', '0', 'dir', '0');
INSERT INTO `co_file` VALUES ('170999', '按时打算', 'folder', '170802', '0', '0', '0', 'dir', '0');
INSERT INTO `co_file` VALUES ('171001', '该方法和发挥', 'folder', '170802', '0', '0', '0', 'dir', '1');
INSERT INTO `co_file` VALUES ('171002', '是的发送到', 'folder', '170801', '0', '0', '0', 'dir', '0');
INSERT INTO `co_file` VALUES ('171004', 'bcvbf', 'note', '170802', '0', '0', '0', 'note', '0');
INSERT INTO `co_file` VALUES ('171005', 'fdgdg', 'note', '170802', '0', '0', '0', 'note', '0');
INSERT INTO `co_file` VALUES ('171006', 'fdgdfgfdgd', 'note', '170802', '0', '0', '0', 'note', '0');
INSERT INTO `co_file` VALUES ('171012', '111', 'folder', '170803', '0', '0', '0', 'dir', '1');
INSERT INTO `co_file` VALUES ('171013', '222', 'folder', '170803', '0', '0', '0', 'dir', '1');
INSERT INTO `co_file` VALUES ('171014', 'ddd', 'note', '170802', '0', '0', '0', 'note', '0');
INSERT INTO `co_file` VALUES ('171015', 'dddddd', 'note', '170802', '0', '0', '0', 'note', '0');
INSERT INTO `co_file` VALUES ('171016', 'asaa', 'note', '170802', '0', '0', '0', 'note', '0');
INSERT INTO `co_file` VALUES ('171017', 'dddd', 'note', '170802', '0', '0', '0', 'note', '0');
INSERT INTO `co_file` VALUES ('171018', 'ccc', 'note', '170802', '0', '0', '0', 'note', '0');
INSERT INTO `co_file` VALUES ('171019', 'dddd', 'note', '170802', '0', '0', '0', 'note', '0');
INSERT INTO `co_file` VALUES ('171020', 'dsadad', 'note', '170802', '0', '0', '0', 'note', '0');
INSERT INTO `co_file` VALUES ('171021', 'df', 'note', '170802', '0', '0', '0', 'note', '0');
INSERT INTO `co_file` VALUES ('171022', 'fdgfd', 'note', '170802', '0', '0', '0', 'note', '0');
INSERT INTO `co_file` VALUES ('171023', '2323', 'note', '170802', '0', '0', '0', 'note', '0');
INSERT INTO `co_file` VALUES ('171024', '6666', 'note', '170802', '0', '0', '0', 'note', '0');
INSERT INTO `co_file` VALUES ('171025', 'dfd', 'note', '170802', '0', '0', '0', 'note', '0');
INSERT INTO `co_file` VALUES ('171026', 'ffdfvgdg', 'note', '170802', '0', '0', '0', 'note', '0');
INSERT INTO `co_file` VALUES ('171027', 'sdsfc', 'note', '170802', '0', '0', '0', 'note', '0');
INSERT INTO `co_file` VALUES ('171028', '454', 'note', '170802', '0', '0', '0', 'note', '0');
INSERT INTO `co_file` VALUES ('171029', '还没那么不好吗', 'note', '170802', '0', '0', '0', 'note', '0');
INSERT INTO `co_file` VALUES ('171030', 'gggg', 'note', '170802', '0', '0', '0', 'note', '0');
INSERT INTO `co_file` VALUES ('171031', 'ffff', 'note', '170802', '0', '0', '0', 'note', '0');
INSERT INTO `co_file` VALUES ('171032', '2334', 'note', '170802', '0', '0', '0', 'note', '0');
INSERT INTO `co_file` VALUES ('171033', '111', 'note', '170802', '0', '0', '0', 'note', '1');
INSERT INTO `co_file` VALUES ('171034', '333', 'note', '170802', '0', '0', '0', 'note', '0');
INSERT INTO `co_file` VALUES ('171035', '444423423435', 'note', '170802', '0', '0', '0', 'note', '0');
INSERT INTO `co_file` VALUES ('171036', '54545', 'note', '170802', '0', '0', '0', 'note', '1');
INSERT INTO `co_file` VALUES ('171037', '6767', 'note', '170802', '0', '0', '0', 'note', '0');
INSERT INTO `co_file` VALUES ('171038', '法师法师打发', 'note', '170802', '0', '0', '0', 'note', '1');
INSERT INTO `co_file` VALUES ('171039', '云笔记', 'note', '170801', '0', '0', '0', 'note', '1');
INSERT INTO `co_file` VALUES ('171040', '123123', 'folder', '170802', '0', '0', '0', 'dir', '0');
INSERT INTO `co_file` VALUES ('171041', '34234', 'note', '170802', '0', '0', '0', 'note', '1');
INSERT INTO `co_file` VALUES ('171042', '123123', 'folder', '170802', '0', '0', '171001', 'dir', '1');
INSERT INTO `co_file` VALUES ('171043', '3464565', 'folder', '170802', '0', '0', '171001', 'dir', '1');
INSERT INTO `co_file` VALUES ('171044', '啥子？', 'note', '170802', '0', '0', '0', 'note', '1');
INSERT INTO `co_file` VALUES ('171045', '测试一下', 'note', '170802', '0', '0', '0', 'note', '1');
INSERT INTO `co_file` VALUES ('171046', '啥跟啥', 'note', '170802', '0', '0', '171001', 'note', '1');
INSERT INTO `co_file` VALUES ('171047', '2234234', 'folder', '170802', '0', '0', '171043', 'dir', '1');
INSERT INTO `co_file` VALUES ('171048', '35345', 'note', '170802', '0', '0', '171047', 'note', '1');
INSERT INTO `co_file` VALUES ('171049', '2222222222222222222', 'note', '170802', '0', '0', '0', 'note', '1');
INSERT INTO `co_file` VALUES ('171050', '哈哈哈', 'folder', '170802', '0', '0', '0', 'dir', '1');
INSERT INTO `co_file` VALUES ('171051', '个和规范化个', 'note', '170802', '0', '0', '171001', 'note', '1');

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
  `content` text COMMENT '文档内容',
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
) ENGINE=InnoDB AUTO_INCREMENT=250 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of co_mod_file
-- ----------------------------
INSERT INTO `co_mod_file` VALUES ('177', '170995', '新建文件夹', '322', null, '170801', '0', '1458047332');
INSERT INTO `co_mod_file` VALUES ('178', '170996', '第三方士大夫', '323', '<div tabindex=\\\"1\\\" spellcheck=\\\"false\\\" contenteditable=\\\"true\\\" class=\\\"note-view\\\"><div tabindex=\\\"1\\\" class=\\\"block-view paragraph-view\\\" data-yne-cid=\\\"view32\\\"><div class=\\\"para-text\\\" style=\\\"font-size: 14px;\\\"><span style=\\\"font-size:14px;font-family:Microsoft YaHei;color:#000000;background-color:transparent;font-weight:normal;font-style:normal;text-decoration:none\\\">的发生地方</span></div></div></div>', '170801', '0', '1458047356');
INSERT INTO `co_mod_file` VALUES ('179', '170997', '第三方第三方', '324', null, '170801', '0', '1458047454');
INSERT INTO `co_mod_file` VALUES ('180', '170998', '水电费水电费', '325', null, '170801', '0', '1458047463');
INSERT INTO `co_mod_file` VALUES ('181', '170999', '按时打算', '326', null, '170801', '0', '1458047606');
INSERT INTO `co_mod_file` VALUES ('182', '171001', '该方法和发挥', '328', null, '170801', '0', '1458047616');
INSERT INTO `co_mod_file` VALUES ('183', '171002', '是的发送到', '329', null, '170801', '0', '1458047622');
INSERT INTO `co_mod_file` VALUES ('185', '171004', 'bcvbf', '331', '<div tabindex=\\\"1\\\" spellcheck=\\\"false\\\" contenteditable=\\\"true\\\" class=\\\"note-view\\\"><div tabindex=\\\"1\\\" class=\\\"block-view paragraph-view\\\" data-yne-cid=\\\"view32\\\"><div class=\\\"para-text\\\" style=\\\"font-size: 14px;\\\"><span style=\\\"font-size:14px;font-family:Microsoft YaHei;color:#000000;background-color:transparent;font-weight:normal;font-style:normal;text-decoration:none\\\">fdgdfg</span></div></div></div>', '170801', '0', '1458048472');
INSERT INTO `co_mod_file` VALUES ('186', '171005', 'fdgdg', '332', '<div tabindex=\\\"1\\\" spellcheck=\\\"false\\\" contenteditable=\\\"true\\\" class=\\\"note-view\\\"><div tabindex=\\\"1\\\" class=\\\"block-view paragraph-view\\\" data-yne-cid=\\\"view32\\\"><div class=\\\"para-text\\\" style=\\\"font-size: 14px;\\\"><span style=\\\"font-size:14px;font-family:Microsoft YaHei;color:#000000;background-color:transparent;font-weight:normal;font-style:normal;text-decoration:none\\\">dfgdfg</span></div></div></div>', '170801', '0', '1458048476');
INSERT INTO `co_mod_file` VALUES ('187', '171006', 'fdgdfgfdgd', '333', '<div tabindex=\\\"1\\\" spellcheck=\\\"false\\\" contenteditable=\\\"true\\\" class=\\\"note-view\\\"><div tabindex=\\\"1\\\" class=\\\"block-view paragraph-view\\\" data-yne-cid=\\\"view32\\\"><div class=\\\"para-text\\\" style=\\\"font-size: 14px;\\\"><span style=\\\"font-size:14px;font-family:Microsoft YaHei;color:#000000;background-color:transparent;font-weight:normal;font-style:normal;text-decoration:none\\\">fdgdfgdfgdfg</span></div></div></div>', '170801', '0', '1458048481');
INSERT INTO `co_mod_file` VALUES ('193', '171012', '111', '343', null, '170801', '0', '1458094002');
INSERT INTO `co_mod_file` VALUES ('194', '171013', '222', '344', null, '170801', '0', '1458094009');
INSERT INTO `co_mod_file` VALUES ('195', '171014', 'ddd', '345', '<div tabindex=\\\"1\\\" spellcheck=\\\"false\\\" contenteditable=\\\"true\\\" class=\\\"note-view\\\"><div tabindex=\\\"1\\\" class=\\\"block-view paragraph-view\\\" data-yne-cid=\\\"view32\\\"><div class=\\\"para-text\\\" style=\\\"font-size: 14px;\\\"><span style=\\\"font-size:14px;font-family:Microsoft YaHei;color:#000000;background-color:transparent;font-weight:normal;font-style:normal;text-decoration:none\\\">dddd</span></div></div></div>', '170801', '0', '1458106181');
INSERT INTO `co_mod_file` VALUES ('196', '171015', 'dddddd', '346', '<div tabindex=\\\"1\\\" spellcheck=\\\"false\\\" contenteditable=\\\"true\\\" class=\\\"note-view\\\"><div tabindex=\\\"1\\\" class=\\\"block-view paragraph-view\\\" data-yne-cid=\\\"view32\\\"><div class=\\\"para-text\\\" style=\\\"font-size: 14px;\\\"><span style=\\\"font-size:14px;font-family:Microsoft YaHei;color:#000000;background-color:transparent;font-weight:normal;font-style:normal;text-decoration:none\\\">ddddd</span></div></div></div>', '170801', '0', '1458106189');
INSERT INTO `co_mod_file` VALUES ('197', '171016', 'asaa', '347', '<div tabindex=\\\"1\\\" spellcheck=\\\"false\\\" contenteditable=\\\"true\\\" class=\\\"note-view\\\"><div tabindex=\\\"1\\\" class=\\\"block-view paragraph-view\\\" data-yne-cid=\\\"view32\\\"><div class=\\\"para-text\\\" style=\\\"font-size: 14px;\\\"><span style=\\\"font-size:14px;font-family:Microsoft YaHei;color:#000000;background-color:transparent;font-weight:normal;font-style:normal;text-decoration:none\\\">dfdssd</span></div></div></div>', '170801', '0', '1458106196');
INSERT INTO `co_mod_file` VALUES ('198', '171017', 'dddd', '352', '<div tabindex=\\\"1\\\" spellcheck=\\\"false\\\" contenteditable=\\\"true\\\" class=\\\"note-view\\\"><div tabindex=\\\"1\\\" class=\\\"block-view paragraph-view\\\" data-yne-cid=\\\"view32\\\"><div class=\\\"para-text\\\" style=\\\"font-size: 14px;\\\"><span style=\\\"font-size:14px;font-family:Microsoft YaHei;color:#000000;background-color:transparent;font-weight:normal;font-style:normal;text-decoration:none\\\">sssss</span></div></div></div>', '170801', '0', '1458106213');
INSERT INTO `co_mod_file` VALUES ('199', '171018', 'ccc', '353', '<div tabindex=\\\"1\\\" spellcheck=\\\"false\\\" contenteditable=\\\"true\\\" class=\\\"note-view\\\"><div tabindex=\\\"1\\\" class=\\\"block-view paragraph-view\\\" data-yne-cid=\\\"view32\\\"><div class=\\\"para-text\\\" style=\\\"font-size: 14px;\\\"><span style=\\\"font-size:14px;font-family:Microsoft YaHei;color:#000000;background-color:transparent;font-weight:normal;font-style:normal;text-decoration:none\\\">vvvv</span></div></div></div>', '170801', '0', '1458106219');
INSERT INTO `co_mod_file` VALUES ('200', '171019', 'dddd', '356', '<div tabindex=\\\"1\\\" spellcheck=\\\"false\\\" contenteditable=\\\"true\\\" class=\\\"note-view\\\"><div tabindex=\\\"1\\\" class=\\\"block-view paragraph-view\\\" data-yne-cid=\\\"view32\\\"><div class=\\\"para-text\\\" style=\\\"font-size: 14px;\\\"><span style=\\\"font-size:14px;font-family:Microsoft YaHei;color:#000000;background-color:transparent;font-weight:normal;font-style:normal;text-decoration:none\\\">aaa</span></div></div></div>', '170801', '0', '1458106914');
INSERT INTO `co_mod_file` VALUES ('201', '171020', 'dsadad', '357', '<div tabindex=\\\"1\\\" spellcheck=\\\"false\\\" contenteditable=\\\"true\\\" class=\\\"note-view\\\"><div tabindex=\\\"1\\\" class=\\\"block-view paragraph-view\\\" data-yne-cid=\\\"view32\\\"><div class=\\\"para-text\\\" style=\\\"font-size: 14px;\\\"><span style=\\\"font-size:14px;font-family:Microsoft YaHei;color:#000000;background-color:transparent;font-weight:normal;font-style:normal;text-decoration:none\\\">asdasd</span></div></div></div>', '170801', '0', '1458106919');
INSERT INTO `co_mod_file` VALUES ('202', '171021', 'df', '360', '<div tabindex=\\\"1\\\" spellcheck=\\\"false\\\" contenteditable=\\\"true\\\" class=\\\"note-view\\\"><div tabindex=\\\"1\\\" class=\\\"block-view paragraph-view\\\" data-yne-cid=\\\"view32\\\"><div class=\\\"para-text\\\" style=\\\"font-size: 14px;\\\"><span style=\\\"font-size:14px;font-family:Microsoft YaHei;color:#000000;background-color:transparent;font-weight:normal;font-style:normal;text-decoration:none\\\">fdss</span></div></div></div>', '170801', '0', '1458108685');
INSERT INTO `co_mod_file` VALUES ('203', '171022', 'fdgfd', '361', '<div tabindex=\\\"1\\\" spellcheck=\\\"false\\\" contenteditable=\\\"true\\\" class=\\\"note-view\\\"><div tabindex=\\\"1\\\" class=\\\"block-view paragraph-view\\\" data-yne-cid=\\\"view32\\\"><div class=\\\"para-text\\\" style=\\\"font-size: 14px;\\\"><span style=\\\"font-size:14px;font-family:Microsoft YaHei;color:#000000;background-color:transparent;font-weight:normal;font-style:normal;text-decoration:none\\\">gdfgdfg</span></div></div></div>', '170801', '0', '1458108690');
INSERT INTO `co_mod_file` VALUES ('204', '171023', '2323', '368', '<div tabindex=\\\"1\\\" spellcheck=\\\"false\\\" contenteditable=\\\"true\\\" class=\\\"note-view\\\"><div tabindex=\\\"1\\\" class=\\\"block-view paragraph-view\\\" data-yne-cid=\\\"view32\\\"><div class=\\\"para-text\\\" style=\\\"font-size: 14px;\\\"><span style=\\\"font-size:14px;font-family:Microsoft YaHei;color:#000000;background-color:transparent;font-weight:normal;font-style:normal;text-decoration:none\\\">232423</span></div></div></div>', '170801', '0', '1458108987');
INSERT INTO `co_mod_file` VALUES ('205', '171024', '6666', '369', '<div tabindex=\\\"1\\\" spellcheck=\\\"false\\\" contenteditable=\\\"true\\\" class=\\\"note-view\\\"><div tabindex=\\\"1\\\" class=\\\"block-view paragraph-view\\\" data-yne-cid=\\\"view32\\\"><div class=\\\"para-text\\\" style=\\\"font-size: 14px;\\\"><span style=\\\"font-size:14px;font-family:Microsoft YaHei;color:#000000;background-color:transparent;font-weight:normal;font-style:normal;text-decoration:none\\\">666</span></div></div></div>', '170801', '0', '1458108993');
INSERT INTO `co_mod_file` VALUES ('206', '171025', 'dfd', '371', '<div tabindex=\\\"1\\\" spellcheck=\\\"false\\\" contenteditable=\\\"true\\\" class=\\\"note-view\\\"><div tabindex=\\\"1\\\" class=\\\"block-view paragraph-view\\\" data-yne-cid=\\\"view32\\\"><div class=\\\"para-text\\\" style=\\\"font-size: 14px;\\\"><span style=\\\"font-size:14px;font-family:Microsoft YaHei;color:#000000;background-color:transparent;font-weight:normal;font-style:normal;text-decoration:none\\\">dfgdfgdfg</span></div></div></div>', '170801', '0', '1458109136');
INSERT INTO `co_mod_file` VALUES ('207', '171026', 'ffdfvgdg', '372', '<div tabindex=\\\"1\\\" spellcheck=\\\"false\\\" contenteditable=\\\"true\\\" class=\\\"note-view\\\"><div tabindex=\\\"1\\\" class=\\\"block-view paragraph-view\\\" data-yne-cid=\\\"view32\\\"><div class=\\\"para-text\\\" style=\\\"font-size: 14px;\\\"><span style=\\\"font-size:14px;font-family:Microsoft YaHei;color:#000000;background-color:transparent;font-weight:normal;font-style:normal;text-decoration:none\\\">dfsdfsd</span></div></div></div>', '170801', '0', '1458109141');
INSERT INTO `co_mod_file` VALUES ('208', '171027', 'sdsfc', '375', '<div tabindex=\\\"1\\\" spellcheck=\\\"false\\\" contenteditable=\\\"true\\\" class=\\\"note-view\\\"><div tabindex=\\\"1\\\" class=\\\"block-view paragraph-view\\\" data-yne-cid=\\\"view32\\\"><div class=\\\"para-text\\\" style=\\\"font-size: 14px;\\\"><span style=\\\"font-size:14px;font-family:Microsoft YaHei;color:#000000;background-color:transparent;font-weight:normal;font-style:normal;text-decoration:none\\\">sdfsdfsdf</span></div></div></div>', '170801', '0', '1458109266');
INSERT INTO `co_mod_file` VALUES ('209', '171028', '454', '379', '<div tabindex=\\\"1\\\" spellcheck=\\\"false\\\" contenteditable=\\\"true\\\" class=\\\"note-view\\\"><div tabindex=\\\"1\\\" class=\\\"block-view paragraph-view\\\" data-yne-cid=\\\"view32\\\"><div class=\\\"para-text\\\" style=\\\"font-size: 14px;\\\"><span style=\\\"font-size:14px;font-family:Microsoft YaHei;color:#000000;background-color:transparent;font-weight:normal;font-style:normal;text-decoration:none\\\">454</span></div></div></div>', '170801', '0', '1458112058');
INSERT INTO `co_mod_file` VALUES ('210', '171029', '21212', '380', '<div tabindex=\\\"1\\\" spellcheck=\\\"false\\\" contenteditable=\\\"true\\\" class=\\\"note-view\\\"><div tabindex=\\\"1\\\" class=\\\"block-view paragraph-view\\\" data-yne-cid=\\\"view32\\\"><div class=\\\"para-text\\\" style=\\\"font-size: 14px;\\\"><span style=\\\"font-size:14px;font-family:Microsoft YaHei;color:#000000;background-color:transparent;font-weight:normal;font-style:normal;text-decoration:none\\\">返回结果 </span></div></div></div>', '170801', '0', '1458112073');
INSERT INTO `co_mod_file` VALUES ('211', '171030', 'gggg', '382', '<div tabindex=\\\"1\\\" spellcheck=\\\"false\\\" contenteditable=\\\"true\\\" class=\\\"note-view\\\"><div tabindex=\\\"1\\\" class=\\\"block-view paragraph-view\\\" data-yne-cid=\\\"view32\\\"><div class=\\\"para-text\\\" style=\\\"font-size: 14px;\\\"><span style=\\\"font-size:14px;font-family:Microsoft YaHei;color:#000000;background-color:transparent;font-weight:normal;font-style:normal;text-decoration:none\\\">ggggg</span></div></div></div>', '170801', '0', '1458113640');
INSERT INTO `co_mod_file` VALUES ('212', '171031', 'ffff', '383', '<div tabindex=\\\"1\\\" spellcheck=\\\"false\\\" contenteditable=\\\"true\\\" class=\\\"note-view\\\"><div tabindex=\\\"1\\\" class=\\\"block-view paragraph-view\\\" data-yne-cid=\\\"view32\\\"><div class=\\\"para-text\\\" style=\\\"font-size: 14px;\\\"><span style=\\\"font-size:14px;font-family:Microsoft YaHei;color:#000000;background-color:transparent;font-weight:normal;font-style:normal;text-decoration:none\\\">ffff</span></div></div></div>', '170801', '0', '1458113652');
INSERT INTO `co_mod_file` VALUES ('213', '171032', '2334', '386', '<div tabindex=\\\"1\\\" spellcheck=\\\"false\\\" contenteditable=\\\"true\\\" class=\\\"note-view\\\"><div tabindex=\\\"1\\\" class=\\\"block-view paragraph-view\\\" data-yne-cid=\\\"view32\\\"><div class=\\\"para-text\\\" style=\\\"font-size: 14px;\\\"><span style=\\\"font-size:14px;font-family:Microsoft YaHei;color:#000000;background-color:transparent;font-weight:normal;font-style:normal;text-decoration:none\\\">3433</span></div></div></div>', '170801', '0', '1458113952');
INSERT INTO `co_mod_file` VALUES ('214', '171033', '111', '387', '<div tabindex=\\\"1\\\" spellcheck=\\\"false\\\" contenteditable=\\\"true\\\" class=\\\"note-view\\\"><div tabindex=\\\"1\\\" class=\\\"block-view paragraph-view\\\" data-yne-cid=\\\"view32\\\"><div class=\\\"para-text\\\" style=\\\"font-size: 14px;\\\"><span style=\\\"font-size:14px;font-family:Microsoft YaHei;color:#000000;background-color:transparent;font-weight:normal;font-style:normal;text-decoration:none\\\">111</span></div></div></div>', '170801', '0', '1458113958');
INSERT INTO `co_mod_file` VALUES ('215', '171034', '333', '390', '<div tabindex=\\\"1\\\" spellcheck=\\\"false\\\" contenteditable=\\\"true\\\" class=\\\"note-view\\\"><div tabindex=\\\"1\\\" class=\\\"block-view paragraph-view\\\" data-yne-cid=\\\"view32\\\"><div class=\\\"para-text\\\" style=\\\"font-size: 14px;\\\"><span style=\\\"font-size:14px;font-family:Microsoft YaHei;color:#000000;background-color:transparent;font-weight:normal;font-style:normal;text-decoration:none\\\">334343</span></div></div></div>', '170801', '0', '1458114068');
INSERT INTO `co_mod_file` VALUES ('216', '171035', '444423423435', '391', '<div tabindex=\\\"1\\\" spellcheck=\\\"false\\\" contenteditable=\\\"true\\\" class=\\\"note-view\\\"><div tabindex=\\\"1\\\" class=\\\"block-view paragraph-view\\\" data-yne-cid=\\\"view32\\\"><div class=\\\"para-text\\\" style=\\\"font-size: 14px;\\\"><span style=\\\"font-size:14px;font-family:Microsoft YaHei;color:#000000;background-color:transparent;font-weight:normal;font-style:normal;text-decoration:none\\\">34234</span></div></div></div>', '170801', '0', '1458114075');
INSERT INTO `co_mod_file` VALUES ('217', '171036', '54545', '394', '<div tabindex=\\\"1\\\" spellcheck=\\\"false\\\" contenteditable=\\\"true\\\" class=\\\"note-view\\\"><div tabindex=\\\"1\\\" class=\\\"block-view paragraph-view\\\" data-yne-cid=\\\"view32\\\"><div class=\\\"para-text\\\" style=\\\"font-size: 14px;\\\"><span style=\\\"font-size:14px;font-family:Microsoft YaHei;color:#000000;background-color:transparent;font-weight:normal;font-style:normal;text-decoration:none\\\">4534</span></div></div></div>', '170801', '0', '1458114177');
INSERT INTO `co_mod_file` VALUES ('218', '171037', '67673434', '395', '<div tabindex=\\\"1\\\" spellcheck=\\\"false\\\" contenteditable=\\\"true\\\" class=\\\"note-view\\\"><div tabindex=\\\"1\\\" class=\\\"block-view paragraph-view\\\" data-yne-cid=\\\"view32\\\"><div class=\\\"para-text\\\" style=\\\"font-size: 14px;\\\"><span style=\\\"font-size:14px;font-family:Microsoft YaHei;color:#000000;background-color:transparent;font-weight:normal;font-style:normal;text-decoration:none\\\">67676</span></div></div></div>', '170801', '0', '1458114182');
INSERT INTO `co_mod_file` VALUES ('219', '171038', '法师法师打发', '396', '<div yne-bulb-block=\\\"paragraph\\\" style=\\\"line-height: 1.5; font-size: 14px;\\\"><span style=\\\"font-size:42px\\\">施工方的规定</span></div>', '170801', '0', '1458121558');
INSERT INTO `co_mod_file` VALUES ('220', '171038', '法骑', '397', '<div yne-bulb-block=\"paragraph\" style=\"line-height: 1.5; font-size: 14px;\"><span style=\"font-size:42px\">施工方</span></div>', '170801', '1', '1458124558');
INSERT INTO `co_mod_file` VALUES ('221', '171038', '法骑2', '398', '<div yne-bulb-block=\"paragraph\" style=\"line-height: 1.5; font-size: 14px;\"><span style=\"font-size:42px\">施工方</span></div>', '170801', '1', '1458124558');
INSERT INTO `co_mod_file` VALUES ('222', '171038', '法骑3', '399', '<div yne-bulb-block=\\\"paragraph\\\" style=\\\"line-height: 1.5; font-size: 14px;\\\"><span style=\\\"font-size:42px\\\">施工方3</span></div>', '170801', '1', '1458126155');
INSERT INTO `co_mod_file` VALUES ('223', '171038', '法骑4', '400', '<div yne-bulb-block=\\\"paragraph\\\" style=\\\"line-height: 1.5; font-size: 14px;\\\"><span style=\\\"font-size:42px\\\">施工方4</span></div>', '170801', '1', '1458126164');
INSERT INTO `co_mod_file` VALUES ('224', '171039', '云笔记', '401', '<div yne-bulb-block=\\\"paragraph\\\" style=\\\"line-height: 1.5; font-size: 14px;\\\"><span style=\\\"font-size:18px;font-weight:bold\\\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;云笔记</span></div><div yne-bulb-block=\\\"paragraph\\\" style=\\\"line-height: 1.5; font-size: 14px;\\\"><br></div><div yne-bulb-block=\\\"paragraph\\\" style=\\\"line-height: 1.5; font-size: 14px;\\\"><span style=\\\"font-size:18px;font-weight:bold\\\">云笔记的主体内容</span></div>', '170801', '0', '1458126305');
INSERT INTO `co_mod_file` VALUES ('225', '171040', '123123', '402', null, '170801', '0', '1458131134');
INSERT INTO `co_mod_file` VALUES ('226', '171041', '34234', '404', '<div yne-bulb-block=\\\"paragraph\\\" style=\\\"line-height: 1.5; font-size: 14px;\\\">345345</div>', '170801', '0', '1458131152');
INSERT INTO `co_mod_file` VALUES ('227', '171042', '123123', '405', null, '170801', '0', '1458131229');
INSERT INTO `co_mod_file` VALUES ('228', '171043', '3464565', '406', null, '170801', '0', '1458131898');
INSERT INTO `co_mod_file` VALUES ('229', '171044', '啥子？???', '407', '<div yne-bulb-block=\\\"paragraph\\\" style=\\\"line-height: 1.5; font-size: 14px;\\\">成功了好像</div>', '170801', '0', '1458131917');
INSERT INTO `co_mod_file` VALUES ('230', '171045', '测试一下', '408', '<div yne-bulb-block=\\\"paragraph\\\" style=\\\"line-height: 1.5; font-size: 14px;\\\">测试一下</div>', '170801', '0', '1458132030');
INSERT INTO `co_mod_file` VALUES ('231', '171046', '啥跟啥', '409', '<div yne-bulb-block=\\\"paragraph\\\" style=\\\"line-height: 1.5; font-size: 14px;\\\">啥跟啥</div>', '170801', '0', '1458132333');
INSERT INTO `co_mod_file` VALUES ('232', '171046', '啥跟啥121', '410', '<div yne-bulb-block=\\\"paragraph\\\" style=\\\"line-height: 1.5; font-size: 14px;\\\">啥跟啥</div>', '170801', '1', '1458132412');
INSERT INTO `co_mod_file` VALUES ('233', '171047', '2234234', '411', null, '170801', '0', '1458132447');
INSERT INTO `co_mod_file` VALUES ('234', '171048', '35345', '412', '<div yne-bulb-block=\\\"paragraph\\\" style=\\\"line-height: 1.5; font-size: 14px;\\\">3454354</div>', '170801', '0', '1458132455');
INSERT INTO `co_mod_file` VALUES ('235', '171048', '35345', '413', '<div yne-bulb-block=\\\"paragraph\\\" style=\\\"line-height: 1.5; font-size: 14px;\\\"><span style=\\\"font-size:26px\\\">3454354</span></div>', '170801', '1', '1458132490');
INSERT INTO `co_mod_file` VALUES ('236', '171049', '2222222222222222222', '414', '<div yne-bulb-block=\\\"paragraph\\\" style=\\\"line-height: 1.5; font-size: 14px;\\\">222222222222</div>', '170802', '0', '1458179740');
INSERT INTO `co_mod_file` VALUES ('237', '171050', '哈哈哈', '415', null, '170801', '0', '1458179757');
INSERT INTO `co_mod_file` VALUES ('238', '171039', '云笔记', '417', '<div yne-bulb-block=\\\"paragraph\\\" style=\\\"line-height: 1.5; font-size: 14px;\\\"><span style=\\\"font-size:18px;font-weight:bold\\\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span style=\\\"font-size:42px;font-weight:bold\\\">云笔记</span></div><div yne-bulb-block=\\\"paragraph\\\" style=\\\"line-height: 1.5; font-size: 14px;\\\"><br></div><div yne-bulb-block=\\\"paragraph\\\" style=\\\"line-height: 1.5; font-size: 14px;\\\"><span style=\\\"font-size:18px;font-weight:bold\\\">云笔记的主体内容</span></div>', '170801', '1', '1458179831');
INSERT INTO `co_mod_file` VALUES ('239', '171037', '6767343456', '418', '<div yne-bulb-block=\\\"paragraph\\\" style=\\\"line-height: 1.5; font-size: 14px;\\\">67676456456456</div>', '170801', '1', '1458182624');
INSERT INTO `co_mod_file` VALUES ('240', '171037', '6767343456', '419', '<div yne-bulb-block=\\\"paragraph\\\" style=\\\"line-height: 1.5; font-size: 14px;\\\"><span style=\\\"font-size:42px\\\">67676456456456</span></div>', '170801', '1', '1458182946');
INSERT INTO `co_mod_file` VALUES ('241', '171037', '67', '420', '<div yne-bulb-block=\\\"paragraph\\\" style=\\\"line-height: 1.5; font-size: 14px;\\\"><span style=\\\"font-size:42px\\\">67676456456456</span></div>', '170801', '1', '1458182958');
INSERT INTO `co_mod_file` VALUES ('242', '171044', '啥子', '422', '<div yne-bulb-block=\\\"paragraph\\\" style=\\\"line-height: 1.5; font-size: 14px;\\\">成功了好像</div>', '170801', '1', '1458183023');
INSERT INTO `co_mod_file` VALUES ('243', '171044', '啥子子', '423', '<div yne-bulb-block=\\\"paragraph\\\" style=\\\"line-height: 1.5; font-size: 14px;\\\">成功了好像</div>', '170801', '1', '1458183421');
INSERT INTO `co_mod_file` VALUES ('244', '171046', '啥跟啥', '424', '<div yne-bulb-block=\\\"paragraph\\\" style=\\\"line-height: 1.5; font-size: 14px;\\\"><span style=\\\"font-size:42px\\\">啥跟啥</span></div><div yne-bulb-block=\\\"paragraph\\\" style=\\\"line-height: 1.5; font-size: 14px;\\\"><br></div><hr yne-bulb-block=\\\"hr\\\" style=\\\"clear: both;\\\"><div yne-bulb-block=\\\"paragraph\\\" style=\\\"line-height: 1.5; font-size: 14px;\\\"><br></div><div style=\\\"font-size: 12px; width: 100%; overflow: auto; font-family: \\\'Microsoft YaHei\\\', 微软雅黑, 华文黑体, STHeiti, \\\'Microsoft JhengHei\\\', sans-serif;\\\"><table cellspacing=\\\"0\\\" cellpadding=\\\"0\\\" border=\\\"1\\\" style=\\\"table-layout:fixed;border-collapse:collapse;border:1px solid #ccc;width:350px\\\"><tbody><tr><td style=\\\"word-wrap: break-word; width: 70px; height: 23px;\\\"><br></td><td style=\\\"word-wrap: break-word; width: 70px; height: 23px;\\\"><br></td><td style=\\\"word-wrap: break-word; width: 70px; height: 23px;\\\"><br></td><td style=\\\"word-wrap: break-word; width: 70px; height: 23px;\\\"><br></td><td style=\\\"word-wrap: break-word; width: 70px; height: 23px;\\\"><br></td></tr><tr><td style=\\\"word-wrap: break-word; width: 70px; height: 23px;\\\"><br></td><td style=\\\"word-wrap: break-word; width: 70px; height: 23px;\\\"><br></td><td style=\\\"word-wrap: break-word; width: 70px; height: 23px;\\\"><br></td><td style=\\\"word-wrap: break-word; width: 70px; height: 23px;\\\"><br></td><td style=\\\"word-wrap: break-word; width: 70px; height: 23px;\\\"><br></td></tr><tr><td style=\\\"word-wrap: break-word; width: 70px; height: 23px;\\\"><br></td><td style=\\\"word-wrap: break-word; width: 70px; height: 23px;\\\"><br></td><td style=\\\"word-wrap: break-word; width: 70px; height: 23px;\\\"><br></td><td style=\\\"word-wrap: break-word; width: 70px; height: 23px;\\\"><br></td><td style=\\\"word-wrap: break-word; width: 70px; height: 23px;\\\"><br></td></tr><tr><td style=\\\"word-wrap: break-word; width: 70px; height: 23px;\\\"><br></td><td style=\\\"word-wrap: break-word; width: 70px; height: 23px;\\\"><br></td><td style=\\\"word-wrap: break-word; width: 70px; height: 23px;\\\"><br></td><td style=\\\"word-wrap: break-word; width: 70px; height: 23px;\\\"><br></td><td style=\\\"word-wrap: break-word; width: 70px; height: 23px;\\\"><br></td></tr><tr><td style=\\\"word-wrap: break-word; width: 70px; height: 23px;\\\"><br></td><td style=\\\"word-wrap: break-word; width: 70px; height: 23px;\\\"><br></td><td style=\\\"word-wrap: break-word; width: 70px; height: 23px;\\\"><br></td><td style=\\\"word-wrap: break-word; width: 70px; height: 23px;\\\"><br></td><td style=\\\"word-wrap: break-word; width: 70px; height: 23px;\\\"><br></td></tr><tr><td style=\\\"word-wrap: break-word; width: 70px; height: 23px;\\\"><br></td><td style=\\\"word-wrap: break-word; width: 70px; height: 23px;\\\"><br></td><td style=\\\"word-wrap: break-word; width: 70px; height: 23px;\\\"><br></td><td style=\\\"word-wrap: break-word; width: 70px; height: 23px;\\\"><br></td><td style=\\\"word-wrap: break-word; width: 70px; height: 23px;\\\"><br></td></tr></tbody></table></div><div yne-bulb-block=\\\"paragraph\\\" style=\\\"line-height: 1.5; font-size: 14px;\\\"><br></div>', '170801', '1', '1458183539');
INSERT INTO `co_mod_file` VALUES ('245', '171051', '个和规范化个', '425', '<div yne-bulb-block=\\\"paragraph\\\" style=\\\"line-height: 1.5; font-size: 14px;\\\">返回法国恢复</div>', '170801', '0', '1458183553');
INSERT INTO `co_mod_file` VALUES ('246', '171046', '啥跟啥111', '426', '<div yne-bulb-block=\\\"paragraph\\\" style=\\\"line-height: 1.5; font-size: 14px;\\\"><span style=\\\"font-size:42px\\\">啥跟啥</span></div><div yne-bulb-block=\\\"paragraph\\\" style=\\\"line-height: 1.5; font-size: 14px;\\\"><br></div><hr yne-bulb-block=\\\"hr\\\" style=\\\"clear: both;\\\"><div yne-bulb-block=\\\"paragraph\\\" style=\\\"line-height: 1.5; font-size: 14px;\\\"><br></div><div style=\\\"font-size: 12px; width: 100%; overflow: auto; font-family: \\\'Microsoft YaHei\\\', 微软雅黑, 华文黑体, STHeiti, \\\'Microsoft JhengHei\\\', sans-serif;\\\"><table cellspacing=\\\"0\\\" cellpadding=\\\"0\\\" border=\\\"1\\\" style=\\\"table-layout:fixed;border-collapse:collapse;border:1px solid #ccc;width:360px\\\"><tbody><tr><td style=\\\"word-wrap: break-word; width: 72px; height: 32px; vertical-align: middle; white-space: normal;\\\"><br></td><td style=\\\"word-wrap: break-word; width: 72px; height: 32px; vertical-align: middle; white-space: normal;\\\"><br></td><td style=\\\"word-wrap: break-word; width: 72px; height: 32px; vertical-align: middle; white-space: normal;\\\"><br></td><td style=\\\"word-wrap: break-word; width: 72px; height: 32px; vertical-align: middle; white-space: normal;\\\"><br></td><td style=\\\"word-wrap: break-word; width: 72px; height: 32px; vertical-align: middle; white-space: normal;\\\"><br></td></tr><tr><td style=\\\"word-wrap: break-word; width: 72px; height: 32px; vertical-align: middle; white-space: normal;\\\"><br></td><td style=\\\"word-wrap: break-word; width: 72px; height: 32px; vertical-align: middle; white-space: normal;\\\"><br></td><td style=\\\"word-wrap: break-word; width: 72px; height: 32px; vertical-align: middle; white-space: normal;\\\"><br></td><td style=\\\"word-wrap: break-word; width: 72px; height: 32px; vertical-align: middle; white-space: normal;\\\"><br></td><td style=\\\"word-wrap: break-word; width: 72px; height: 32px; vertical-align: middle; white-space: normal;\\\"><br></td></tr><tr><td style=\\\"word-wrap: break-word; width: 72px; height: 32px; vertical-align: middle; white-space: normal;\\\"><br></td><td style=\\\"word-wrap: break-word; width: 72px; height: 32px; vertical-align: middle; white-space: normal;\\\"><br></td><td style=\\\"word-wrap: break-word; width: 72px; height: 32px; vertical-align: middle; white-space: normal;\\\"><br></td><td style=\\\"word-wrap: break-word; width: 72px; height: 32px; vertical-align: middle; white-space: normal;\\\"><br></td><td style=\\\"word-wrap: break-word; width: 72px; height: 32px; vertical-align: middle; white-space: normal;\\\"><br></td></tr><tr><td style=\\\"word-wrap: break-word; width: 72px; height: 32px; vertical-align: middle; white-space: normal;\\\"><br></td><td style=\\\"word-wrap: break-word; width: 72px; height: 32px; vertical-align: middle; white-space: normal;\\\"><br></td><td style=\\\"word-wrap: break-word; width: 72px; height: 32px; vertical-align: middle; white-space: normal;\\\"><br></td><td style=\\\"word-wrap: break-word; width: 72px; height: 32px; vertical-align: middle; white-space: normal;\\\"><br></td><td style=\\\"word-wrap: break-word; width: 72px; height: 32px; vertical-align: middle; white-space: normal;\\\"><br></td></tr><tr><td style=\\\"word-wrap: break-word; width: 72px; height: 32px; vertical-align: middle; white-space: normal;\\\"><br></td><td style=\\\"word-wrap: break-word; width: 72px; height: 32px; vertical-align: middle; white-space: normal;\\\"><br></td><td style=\\\"word-wrap: break-word; width: 72px; height: 32px; vertical-align: middle; white-space: normal;\\\"><br></td><td style=\\\"word-wrap: break-word; width: 72px; height: 32px; vertical-align: middle; white-space: normal;\\\"><br></td><td style=\\\"word-wrap: break-word; width: 72px; height: 32px; vertical-align: middle; white-space: normal;\\\"><br></td></tr><tr><td style=\\\"word-wrap: break-word; width: 72px; height: 32px; vertical-align: middle; white-space: normal;\\\"><br></td><td style=\\\"word-wrap: break-word; width: 72px; height: 32px; vertical-align: middle; white-space: normal;\\\"><br></td><td style=\\\"word-wrap: break-word; width: 72px; height: 32px; vertical-align: middle; white-space: normal;\\\"><br></td><td style=\\\"word-wrap: break-word; width: 72px; height: 32px; vertical-align: middle; white-space: normal;\\\"><br></td><td style=\\\"word-wrap: break-word; width: 72px; height: 32px; vertical-align: middle; white-space: normal;\\\"><br></td></tr></tbody></table></div><div yne-bulb-block=\\\"paragraph\\\" style=\\\"line-height: 1.5; font-size: 14px;\\\"><br></div>', '170801', '1', '1458183564');
INSERT INTO `co_mod_file` VALUES ('247', '171049', '2222', '427', '<div yne-bulb-block=\\\"paragraph\\\" style=\\\"line-height: 1.5; font-size: 14px;\\\">222222222222</div>', '170801', '1', '1458186005');
INSERT INTO `co_mod_file` VALUES ('248', '171044', '啥', '428', '<div yne-bulb-block=\\\"paragraph\\\" style=\\\"line-height: 1.5; font-size: 14px;\\\">成功了好像</div>', '170801', '1', '1458186016');
INSERT INTO `co_mod_file` VALUES ('249', '171039', '云笔记', '429', '<div yne-bulb-block=\\\"paragraph\\\" style=\\\"line-height: 1.5; font-size: 14px;\\\"><span style=\\\"font-size:18px;font-weight:bold\\\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span style=\\\"font-size:42px;font-weight:bold\\\">云笔记</span></div><div yne-bulb-block=\\\"paragraph\\\" style=\\\"line-height: 1.5; font-size: 14px;\\\"><br></div><div yne-bulb-block=\\\"paragraph\\\" style=\\\"line-height: 1.5; font-size: 14px;\\\"><span style=\\\"font-size:18px;font-weight:bold\\\">云笔记的主体内容</span></div><div yne-bulb-block=\\\"paragraph\\\" style=\\\"line-height: 1.5; font-size: 14px;\\\"><br></div><hr yne-bulb-block=\\\"hr\\\" style=\\\"clear: both;\\\"><div yne-bulb-block=\\\"paragraph\\\" style=\\\"line-height: 1.5; font-size: 14px;\\\"><br></div><div style=\\\"font-size: 12px; width: 100%; overflow: auto; font-family: \\\'Microsoft YaHei\\\', 微软雅黑, 华文黑体, STHeiti, \\\'Microsoft JhengHei\\\', sans-serif;\\\"><table cellspacing=\\\"0\\\" cellpadding=\\\"0\\\" border=\\\"1\\\" style=\\\"table-layout:fixed;border-collapse:collapse;border:1px solid #ccc;width:700px\\\"><tbody><tr><td style=\\\"word-wrap: break-word; width: 70px; height: 142px;\\\"><br></td><td style=\\\"word-wrap: break-word; width: 70px; height: 142px;\\\"><br></td><td style=\\\"word-wrap: break-word; width: 70px; height: 142px;\\\">sdsd</td><td style=\\\"word-wrap: break-word; width: 70px; height: 142px;\\\">sdsd</td><td style=\\\"word-wrap: break-word; width: 70px; height: 142px;\\\"><br></td><td style=\\\"word-wrap: break-word; width: 70px; height: 142px;\\\"><br></td><td style=\\\"word-wrap: break-word; width: 70px; height: 142px;\\\"><br></td><td style=\\\"word-wrap: break-word; width: 70px; height: 142px;\\\"><br></td><td style=\\\"word-wrap: break-word; width: 70px; height: 142px;\\\"><br></td><td style=\\\"word-wrap: break-word; width: 70px; height: 142px;\\\"><br></td></tr><tr><td style=\\\"word-wrap: break-word; width: 70px; height: 23px;\\\"><br></td><td style=\\\"word-wrap: break-word; width: 70px; height: 23px;\\\"><br></td><td style=\\\"word-wrap: break-word; width: 70px; height: 23px;\\\"><br></td><td style=\\\"word-wrap: break-word; width: 70px; height: 23px;\\\"><br></td><td style=\\\"word-wrap: break-word; width: 70px; height: 23px;\\\"><br></td><td style=\\\"word-wrap: break-word; width: 70px; height: 23px;\\\"><br></td><td style=\\\"word-wrap: break-word; width: 70px; height: 23px;\\\"><br></td><td style=\\\"word-wrap: break-word; width: 70px; height: 23px;\\\"><br></td><td style=\\\"word-wrap: break-word; width: 70px; height: 23px;\\\"><br></td><td style=\\\"word-wrap: break-word; width: 70px; height: 23px;\\\"><br></td></tr><tr><td style=\\\"word-wrap: break-word; width: 70px; height: 23px;\\\"><br></td><td style=\\\"word-wrap: break-word; width: 70px; height: 23px;\\\"><br></td><td style=\\\"word-wrap: break-word; width: 70px; height: 23px;\\\"><br></td><td style=\\\"word-wrap: break-word; width: 70px; height: 23px;\\\"><br></td><td style=\\\"word-wrap: break-word; width: 70px; height: 23px;\\\"><br></td><td style=\\\"word-wrap: break-word; width: 70px; height: 23px;\\\"><br></td><td style=\\\"word-wrap: break-word; width: 70px; height: 23px;\\\"><br></td><td style=\\\"word-wrap: break-word; width: 70px; height: 23px;\\\"><br></td><td style=\\\"word-wrap: break-word; width: 70px; height: 23px;\\\"><br></td><td style=\\\"word-wrap: break-word; width: 70px; height: 23px;\\\"><br></td></tr><tr><td style=\\\"word-wrap: break-word; width: 70px; height: 23px;\\\"><br></td><td style=\\\"word-wrap: break-word; width: 70px; height: 23px;\\\"><br></td><td style=\\\"word-wrap: break-word; width: 70px; height: 23px;\\\"><br></td><td style=\\\"word-wrap: break-word; width: 70px; height: 23px;\\\"><br></td><td style=\\\"word-wrap: break-word; width: 70px; height: 23px;\\\"><br></td><td style=\\\"word-wrap: break-word; width: 70px; height: 23px;\\\"><br></td><td style=\\\"word-wrap: break-word; width: 70px; height: 23px;\\\"><br></td><td style=\\\"word-wrap: break-word; width: 70px; height: 23px;\\\"><br></td><td style=\\\"word-wrap: break-word; width: 70px; height: 23px;\\\"><br></td><td style=\\\"word-wrap: break-word; width: 70px; height: 23px;\\\"><br></td></tr><tr><td style=\\\"word-wrap: break-word; width: 70px; height: 23px;\\\"><br></td><td style=\\\"word-wrap: break-word; width: 70px; height: 23px;\\\"><br></td><td style=\\\"word-wrap: break-word; width: 70px; height: 23px;\\\"><br></td><td style=\\\"word-wrap: break-word; width: 70px; height: 23px;\\\"><br></td><td style=\\\"word-wrap: break-word; width: 70px; height: 23px;\\\"><br></td><td style=\\\"word-wrap: break-word; width: 70px; height: 23px;\\\"><br></td><td style=\\\"word-wrap: break-word; width: 70px; height: 23px;\\\"><br></td><td style=\\\"word-wrap: break-word; width: 70px; height: 23px;\\\"><br></td><td style=\\\"word-wrap: break-word; width: 70px; height: 23px;\\\"><br></td><td style=\\\"word-wrap: break-word; width: 70px; height: 23px;\\\"><br></td></tr><tr><td style=\\\"word-wrap: break-word; width: 70px; height: 23px;\\\"><br></td><td style=\\\"word-wrap: break-word; width: 70px; height: 23px;\\\"><br></td><td style=\\\"word-wrap: break-word; width: 70px; height: 23px;\\\"><br></td><td style=\\\"word-wrap: break-word; width: 70px; height: 23px;\\\"><br></td><td style=\\\"word-wrap: break-word; width: 70px; height: 23px;\\\"><br></td><td style=\\\"word-wrap: break-word; width: 70px; height: 23px;\\\"><br></td><td style=\\\"word-wrap: break-word; width: 70px; height: 23px;\\\"><br></td><td style=\\\"word-wrap: break-word; width: 70px; height: 23px;\\\"><br></td><td style=\\\"word-wrap: break-word; width: 70px; height: 23px;\\\"><br></td><td style=\\\"word-wrap: break-word; width: 70px; height: 23px;\\\">sd</td></tr></tbody></table></div><div yne-bulb-block=\\\"paragraph\\\" style=\\\"line-height: 1.5; font-size: 14px;\\\"><br></div>', '170801', '1', '1458187641');

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
) ENGINE=InnoDB AUTO_INCREMENT=430 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of co_msg
-- ----------------------------
INSERT INTO `co_msg` VALUES ('322', 'create', '170802', '1458047332');
INSERT INTO `co_msg` VALUES ('323', 'create', '170802', '1458047356');
INSERT INTO `co_msg` VALUES ('324', 'create', '170801', '1458047454');
INSERT INTO `co_msg` VALUES ('325', 'create', '170802', '1458047463');
INSERT INTO `co_msg` VALUES ('326', 'create', '170802', '1458047606');
INSERT INTO `co_msg` VALUES ('328', 'create', '170802', '1458047616');
INSERT INTO `co_msg` VALUES ('329', 'create', '170801', '1458047622');
INSERT INTO `co_msg` VALUES ('330', 'create', '170803', '1458048424');
INSERT INTO `co_msg` VALUES ('331', 'create', '170802', '1458048472');
INSERT INTO `co_msg` VALUES ('332', 'create', '170802', '1458048476');
INSERT INTO `co_msg` VALUES ('333', 'create', '170802', '1458048481');
INSERT INTO `co_msg` VALUES ('334', 'delete', '170802', '1458048485');
INSERT INTO `co_msg` VALUES ('335', 'delete', '170802', '1458048485');
INSERT INTO `co_msg` VALUES ('336', 'delete', '170802', '1458048488');
INSERT INTO `co_msg` VALUES ('337', 'delete', '170802', '1458048488');
INSERT INTO `co_msg` VALUES ('343', 'create', '170803', '1458094002');
INSERT INTO `co_msg` VALUES ('344', 'create', '170803', '1458094009');
INSERT INTO `co_msg` VALUES ('345', 'create', '170802', '1458106181');
INSERT INTO `co_msg` VALUES ('346', 'create', '170802', '1458106189');
INSERT INTO `co_msg` VALUES ('347', 'create', '170802', '1458106196');
INSERT INTO `co_msg` VALUES ('348', 'delete', '170802', '1458106204');
INSERT INTO `co_msg` VALUES ('349', 'delete', '170802', '1458106204');
INSERT INTO `co_msg` VALUES ('350', 'delete', '170802', '1458106207');
INSERT INTO `co_msg` VALUES ('351', 'delete', '170802', '1458106207');
INSERT INTO `co_msg` VALUES ('352', 'create', '170802', '1458106213');
INSERT INTO `co_msg` VALUES ('353', 'create', '170802', '1458106219');
INSERT INTO `co_msg` VALUES ('354', 'delete', '170802', '1458106906');
INSERT INTO `co_msg` VALUES ('355', 'delete', '170802', '1458106906');
INSERT INTO `co_msg` VALUES ('356', 'create', '170802', '1458106914');
INSERT INTO `co_msg` VALUES ('357', 'create', '170802', '1458106919');
INSERT INTO `co_msg` VALUES ('358', 'delete', '170802', '1458108678');
INSERT INTO `co_msg` VALUES ('359', 'delete', '170802', '1458108678');
INSERT INTO `co_msg` VALUES ('360', 'create', '170802', '1458108685');
INSERT INTO `co_msg` VALUES ('361', 'create', '170802', '1458108690');
INSERT INTO `co_msg` VALUES ('366', 'delete', '170802', '1458108980');
INSERT INTO `co_msg` VALUES ('367', 'delete', '170802', '1458108981');
INSERT INTO `co_msg` VALUES ('368', 'create', '170802', '1458108987');
INSERT INTO `co_msg` VALUES ('369', 'create', '170802', '1458108993');
INSERT INTO `co_msg` VALUES ('370', 'delete', '170802', '1458109126');
INSERT INTO `co_msg` VALUES ('371', 'create', '170802', '1458109136');
INSERT INTO `co_msg` VALUES ('372', 'create', '170802', '1458109141');
INSERT INTO `co_msg` VALUES ('373', 'delete', '170802', '1458109252');
INSERT INTO `co_msg` VALUES ('374', 'delete', '170802', '1458109252');
INSERT INTO `co_msg` VALUES ('375', 'create', '170802', '1458109266');
INSERT INTO `co_msg` VALUES ('376', 'delete', '170802', '1458109277');
INSERT INTO `co_msg` VALUES ('377', 'delete', '170802', '1458112051');
INSERT INTO `co_msg` VALUES ('378', 'delete', '170802', '1458112051');
INSERT INTO `co_msg` VALUES ('379', 'create', '170802', '1458112058');
INSERT INTO `co_msg` VALUES ('380', 'create', '170802', '1458112073');
INSERT INTO `co_msg` VALUES ('381', 'delete', '170802', '1458112151');
INSERT INTO `co_msg` VALUES ('382', 'create', '170802', '1458113640');
INSERT INTO `co_msg` VALUES ('383', 'create', '170802', '1458113652');
INSERT INTO `co_msg` VALUES ('384', 'delete', '170802', '1458113941');
INSERT INTO `co_msg` VALUES ('385', 'delete', '170802', '1458113941');
INSERT INTO `co_msg` VALUES ('386', 'create', '170802', '1458113952');
INSERT INTO `co_msg` VALUES ('387', 'create', '170802', '1458113958');
INSERT INTO `co_msg` VALUES ('388', 'delete', '170802', '1458114058');
INSERT INTO `co_msg` VALUES ('389', 'delete', '170802', '1458114059');
INSERT INTO `co_msg` VALUES ('390', 'create', '170802', '1458114068');
INSERT INTO `co_msg` VALUES ('391', 'create', '170802', '1458114075');
INSERT INTO `co_msg` VALUES ('392', 'delete', '170802', '1458114172');
INSERT INTO `co_msg` VALUES ('393', 'delete', '170802', '1458114172');
INSERT INTO `co_msg` VALUES ('394', 'create', '170802', '1458114177');
INSERT INTO `co_msg` VALUES ('395', 'create', '170802', '1458114182');
INSERT INTO `co_msg` VALUES ('396', 'create', '170802', '1458121558');
INSERT INTO `co_msg` VALUES ('397', 'modify', '170802', '1458124558');
INSERT INTO `co_msg` VALUES ('398', 'modify', '170802', '1458124558');
INSERT INTO `co_msg` VALUES ('399', 'modify', '170802', '1458126155');
INSERT INTO `co_msg` VALUES ('400', 'modify', '170802', '1458126164');
INSERT INTO `co_msg` VALUES ('401', 'create', '170801', '1458126305');
INSERT INTO `co_msg` VALUES ('402', 'create', '170802', '1458131134');
INSERT INTO `co_msg` VALUES ('403', 'delete', '170802', '1458131138');
INSERT INTO `co_msg` VALUES ('404', 'create', '170802', '1458131152');
INSERT INTO `co_msg` VALUES ('405', 'create', '170802', '1458131229');
INSERT INTO `co_msg` VALUES ('406', 'create', '170802', '1458131898');
INSERT INTO `co_msg` VALUES ('407', 'create', '170802', '1458131917');
INSERT INTO `co_msg` VALUES ('408', 'create', '170802', '1458132030');
INSERT INTO `co_msg` VALUES ('409', 'create', '170802', '1458132333');
INSERT INTO `co_msg` VALUES ('410', 'modify', '170802', '1458132412');
INSERT INTO `co_msg` VALUES ('411', 'create', '170802', '1458132447');
INSERT INTO `co_msg` VALUES ('412', 'create', '170802', '1458132455');
INSERT INTO `co_msg` VALUES ('413', 'modify', '170802', '1458132490');
INSERT INTO `co_msg` VALUES ('414', 'create', '170802', '1458179740');
INSERT INTO `co_msg` VALUES ('415', 'create', '170802', '1458179757');
INSERT INTO `co_msg` VALUES ('416', 'delete', '170801', '1458179770');
INSERT INTO `co_msg` VALUES ('417', 'modify', '170801', '1458179831');
INSERT INTO `co_msg` VALUES ('418', 'modify', '170802', '1458182624');
INSERT INTO `co_msg` VALUES ('419', 'modify', '170802', '1458182946');
INSERT INTO `co_msg` VALUES ('420', 'modify', '170802', '1458182958');
INSERT INTO `co_msg` VALUES ('421', 'delete', '170802', '1458183003');
INSERT INTO `co_msg` VALUES ('422', 'modify', '170802', '1458183023');
INSERT INTO `co_msg` VALUES ('423', 'modify', '170802', '1458183421');
INSERT INTO `co_msg` VALUES ('424', 'modify', '170802', '1458183539');
INSERT INTO `co_msg` VALUES ('425', 'create', '170802', '1458183553');
INSERT INTO `co_msg` VALUES ('426', 'modify', '170802', '1458183564');
INSERT INTO `co_msg` VALUES ('427', 'modify', '170802', '1458186005');
INSERT INTO `co_msg` VALUES ('428', 'modify', '170802', '1458186016');
INSERT INTO `co_msg` VALUES ('429', 'modify', '170801', '1458187641');

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of co_send_msg
-- ----------------------------

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of co_share
-- ----------------------------

-- ----------------------------
-- Table structure for co_unmod_file
-- ----------------------------
DROP TABLE IF EXISTS `co_unmod_file`;
CREATE TABLE `co_unmod_file` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增量主键ID',
  `file_id` int(11) unsigned NOT NULL COMMENT '文件ID',
  `name` varchar(30) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '文件名',
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of co_unmod_file
-- ----------------------------

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
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER  VIEW `co_view_group_modfile` AS SELECT
co_group.id AS id,
co_mod_file.file_id AS fid,
co_file.type AS type,
co_file.`share` AS `share`,
co_file.star AS star,
co_file.belong AS belong,
co_file.ext AS ext,
length(`co_mod_file`.`content`) AS size,
co_mod_file.object AS object,
co_mod_file.time AS time,
co_mod_file.`name` AS `name`,
co_user.user_name AS user_name,
co_file.state
from (((`co_group` join `co_file`) join `co_mod_file`) join `co_user`)
WHERE
((co_group.id = co_file.group_id) AND
(co_file.id = co_mod_file.file_id) AND
(co_mod_file.object = co_user.id))
ORDER BY
co_file.id DESC ;

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
-- View structure for co_view_group_noti_delfile
-- ----------------------------
DROP VIEW IF EXISTS `co_view_group_noti_delfile`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost`  VIEW `co_view_group_noti_delfile` AS SELECT
co_msg.id,
co_msg.type,
co_msg.group_id,
co_msg.time,
co_delete_file.file_id,
co_delete_file.operator AS object,
co_user.user_name,
co_user.avatar_url,
co_file.type AS file_type,
co_file.belong,
co_file.`name`
FROM
co_msg
INNER JOIN co_delete_file ON co_delete_file.msg_id = co_msg.id
INNER JOIN co_user ON co_delete_file.operator = co_user.id
INNER JOIN co_file ON co_delete_file.file_id = co_file.id ;

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
co_unmod_file.`name`,
co_file.state
from (((`co_group` join `co_file`) join `co_unmod_file`) join `co_user`)
WHERE
((co_group.id = co_file.group_id) AND
(co_file.id = co_unmod_file.file_id) AND
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
co_msg_type.type = 'noti'
ORDER BY
co_dispatch.id DESC ;

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
				INSERT INTO co_mod_file VALUES(null,fileId,name,msgId,content,object,0,currentTime);
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
	SELECT * from co_view_group_noti_sendmsg WHERE group_id=gid ORDER BY id ASC;
	SELECT * from co_view_group_noti_delfile WHERE group_id=gid ORDER BY id ASC;
	SELECT * from co_view_group_noti_create_group WHERE group_id=gid;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for modify_file
-- ----------------------------
DROP PROCEDURE IF EXISTS `modify_file`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `modify_file`(IN `msgType` varchar(10),IN `_object` int,IN `_name` varchar(10),IN `gid` int,IN `fid` int,IN `_type` tinyint,IN `_content` text,IN `_time` int,OUT `flag` tinyint)
BEGIN
	/* 定义变量 */  
	#declare P_ID INT;
	declare currentTime int;
	declare msgId int;
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
				INSERT INTO co_mod_file VALUES(null,fid,_name,msgId,_content,_object,_type,currentTime);
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
		end IF;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for set_file_state
-- ----------------------------
DROP PROCEDURE IF EXISTS `set_file_state`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `set_file_state`(IN `msgType` varchar(10),IN `fid` int,IN `object` int,IN `gid` int,IN `_state` tinyint,IN `_time` int,OUT `flag` tinyint)
BEGIN
	/* 定义变量 */  
	#declare P_ID INT;
	declare currentTime int;
	declare msgId int;
	declare re int;
	declare delFileId int;
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
			UPDATE co_file SET state=_state WHERE id=fid;
			SET re=ROW_COUNT();
			if re>=1 THEN
				INSERT INTO co_delete_file VALUES(null,msgId,fid,object,currentTime);
				set delFileId=LAST_INSERT_ID();
				if delFileId>=1 THEN						
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
