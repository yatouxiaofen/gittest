-- 未上线
-- （1）支付宝先享后付、郑州跨度
	-- 支付宝先享后付:28d9172e5a46336e ACARD_CHANNEL:14  ACARD_PRODUCTCHANNEL:14  呼叫中心:010171 
	-- 郑州跨度:1d07d7773d62d5fe ACARD_CHANNEL:15 ACARD_PRODUCTCHANNEL:15  呼叫中心:010171 
	-- 河南恒迈 openId:eed7b912fc0aa880  ACARD_CHANNEL:21  ACARD_PRODUCTCHANNEL:21  呼叫中心:010171 
-- （2）H5:建行APP发卡、车轮APP
	-- 建行APP发卡 openId:7b9a30d117a2b45c ACARD_CHANNEL:19 ACARD_PRODUCTCHANNEL:19  呼叫中心:010171   busitype:10
	-- 车轮APP openId:7031caad240becf6 ACARD_CHANNEL:20 ACARD_PRODUCTCHANNEL:20  呼叫中心:010171  busitype:12
-- （3）其它：工行E生活
	-- 工行E生活：openId：3b1c216930a87e55 ACARD_CHANNEL：17 ACARD_PRODUCTCHANNEL：17  

-- 已上线
-- （1）微信ETC小助手、支付宝小程序、山东远联
	-- 微信ETC小助手 openId:203048ef84471c3f ACARD_CHANNEL:09 ACARD_PRODUCTCHANNEL:11 呼叫中心:010171
	-- 支付宝小程序 openId:361c5ffb66a7697c ACARD_CHANNEL:12 ACARD_PRODUCTCHANNEL:10 呼叫中心:010171
	-- 山东远联 openId:9f25a32373bfbda5 ACARD_CHANNEL:13 ACARD_PRODUCTCHANNEL:13 呼叫中心:010171

-- （2）H5：微车发卡、汽车之家违章查询APP、滴滴出行、
	-- 微车发卡: openId:428b97739ae78370  ACARD_CHANNEL:11 ACARD_PRODUCTCHANNEL:11  烟台：010006 busitype:02
	-- 汽车之家违章查询APP: openId:1970261da2e8fb91  ACARD_CHANNEL:16 ACARD_PRODUCTCHANNEL:16  枣庄:010004 busitype:07
	-- 滴滴出行: openId:4c2a2507dc7660e0  ACARD_CHANNEL:18 ACARD_PRODUCTCHANNEL:18 青岛:010002 busitype:09
-- （3）其它：支付宝货车A卡
	-- 支付宝货车A卡 openId:49d7f3b533bc20c4  ACARD_CHANNEL:10 ACARD_PRODUCTCHANNEL:  呼叫中心:010171
	
-- 补卡失败时通知互联网支付的
ALTER TABLE `ltchdb`.`t_changecard_notice`   
  CHANGE `busitype` `busitype` VARCHAR(2) CHARSET utf8 COLLATE utf8_general_ci NOT NULL  COMMENT '开卡渠道（用于前台页面展示区分）：开卡渠道（用于前台页面展示区分）：01:ETC小助手开卡,02:微车开卡,07:汽车之家,09:滴滴出行,10:建行,12:车轮APP',
  CHANGE `receiveplatform` `receiveplatform` VARCHAR(2) CHARSET utf8 COLLATE utf8_general_ci NOT NULL  COMMENT '接收平台（用于后台发送通知时候区分）开卡渠道（用于前台页面展示区分）：01:ETC小助手开卡,02:微车开卡,07:汽车之家,09:滴滴出行,10:建行,12:车轮APP';

-- 配置信息 根据openId进行配置
insert into `oe_common_openinfo` (`openId`, `openName`, `IP`, `cerFile`, `status`, `orgId`) 
values('7031caad240becf6','车轮APP','127.0.0.1,10.180.29.19','','1','010171');
INSERT INTO `int_common_encrypt` (`plateFlag`, `desSeed`, `desKey`, `md5Suffix`) 
VALUES('7031caad240becf6','XLAPITEST','267A0794D901AB37C4FBCB680862F8BC8C6EA89E3D8A62F8','70aab3cb8aa5dd38110efc027939dbc1');

insert into s_dictitem(DICTID,DICTNAME,GROUPID,SORTORDER,STATUS,STATUSDATE,DESCRIPTION)
values('20','车轮APP','ACARD_CHANNEL','20','1',NOW(),'A卡平台类型');
INSERT INTO s_dictitem(DICTID,DICTNAME,GROUPID,SORTORDER,STATUS,STATUSDATE,DESCRIPTION)
VALUES('20','车轮APP','ACARD_PRODUCTCHANNEL','20','1',NOW(),'A卡产品渠道');
-- withholdType扣款类型：1 互联网批扣，每天一次  dataTransType数据导入类型，1:每天一次 2实时   withholdType=1则dataTransType=1
INSERT INTO a_dict_rate(platformname,ratenum,platformid,withholdType,dataTransType)
VALUES('车轮APP',0.01000,'20',0,2);

-- H5类:微车发卡接口配置
insert into `oe_common_bizauth` (`openId`, `bizId`, `status`) values('428b97739ae78370','acardbilldetailquery','1');
insert into `oe_common_bizauth` (`openId`, `bizId`, `status`) values('428b97739ae78370','acardinfo','1');
insert into `oe_common_bizauth` (`openId`, `bizId`, `status`) values('428b97739ae78370','acardorderapply','1');
insert into `oe_common_bizauth` (`openId`, `bizId`, `status`) values('428b97739ae78370','acardorderquery','1');
insert into `oe_common_bizauth` (`openId`, `bizId`, `status`) values('428b97739ae78370','acardunbinding','1');
insert into `oe_common_bizauth` (`openId`, `bizId`, `status`) values('428b97739ae78370','changebanknum','1');
insert into `oe_common_bizauth` (`openId`, `bizId`, `status`) values('428b97739ae78370','obunotify','1');
insert into `oe_common_bizauth` (`openId`, `bizId`, `status`) values('428b97739ae78370','obutype','1');
insert into `oe_common_bizauth` (`openId`, `bizId`, `status`) values('428b97739ae78370','signapply','1');
insert into `oe_common_bizauth` (`openId`, `bizId`, `status`) values('428b97739ae78370','singInfo','1');
-- H5类:菜单配置
insert into `t_right` (`RightName`, `IsMenu`, `MenuName`, `URL`, `RightMemo`, `ParentID`, `DisplayOrder`) 
values('违章查询app','0','违章查询app','','','332','6');
-- 418
INSERT INTO `t_right` (`RightName`, `IsMenu`, `MenuName`, `URL`, `RightMemo`, `ParentID`, `DisplayOrder`) VALUES('正式解约','1','正式解约','acardnewmgr/acard!relieveConventionSearch.action?adict.channel=16','','418','3');
INSERT INTO `t_right` (`RightName`, `IsMenu`, `MenuName`, `URL`, `RightMemo`, `ParentID`, `DisplayOrder`) VALUES('A卡申请售后','1','A卡售后管理','acardnewmgr/acard!open.action?openId=1970261da2e8fb91','','418','2');
INSERT INTO `t_right` (`RightName`, `IsMenu`, `MenuName`, `URL`, `RightMemo`, `ParentID`, `DisplayOrder`) VALUES('A卡申请订单处理','1','A卡申请订单处理','acardnewmgr/apply!open.action?openId=1970261da2e8fb91','','418','1');
INSERT INTO `t_right` (`RightName`, `IsMenu`, `MenuName`, `URL`, `RightMemo`, `ParentID`, `DisplayOrder`) VALUES('补换卡通知记录','1','补换卡通知记录','acardnewmgr/notice!openChangeCardNoticePage.action?busitype=07','补换卡通知记录','418','4');
INSERT INTO `t_right` (`RightName`, `IsMenu`, `MenuName`, `URL`, `RightMemo`, `ParentID`, `DisplayOrder`) VALUES('A卡申请信息导入导出','1','A卡申请信息导入导出','acardnewmgr/apply!exportView.action?openId=1970261da2e8fb91','A卡申请信息导入导出','418','9');
INSERT INTO `t_right` (`RightName`, `IsMenu`, `MenuName`, `URL`, `RightMemo`, `ParentID`, `DisplayOrder`) VALUES('订单通知记录','1','订单通知记录','acardnewmgr/notice!toQuery.action?openId=1970261da2e8fb91','订单通知记录','418','9');

-- 接口类:微信ETC小助手接口配置
insert into `oe_common_bizauth` (`openId`, `bizId`, `status`) values('203048ef84471c3f','aCardApplyAfterSale','1');
insert into `oe_common_bizauth` (`openId`, `bizId`, `status`) values('203048ef84471c3f','aCardInfoQuery','1');
insert into `oe_common_bizauth` (`openId`, `bizId`, `status`) values('203048ef84471c3f','acardorderapply','1');
insert into `oe_common_bizauth` (`openId`, `bizId`, `status`) values('203048ef84471c3f','acardorderquery','1');
insert into `oe_common_bizauth` (`openId`, `bizId`, `status`) values('203048ef84471c3f','acardorderstatusmodify','1');
insert into `oe_common_bizauth` (`openId`, `bizId`, `status`) values('203048ef84471c3f','obunotify','1');
-- 接口类:菜单配置
SELECT * FROM t_right r WHERE r.`MenuName` LIKE '%新发A卡管理%';
-- 332
SELECT * FROM t_right r WHERE r.`ParentID`='332';
INSERT INTO `t_right` (`RightName`, `IsMenu`, `MenuName`, `URL`, `RightMemo`, `ParentID`, `DisplayOrder`) 
VALUES('','0','','','','332','13');
-- 441
SELECT * FROM t_right r WHERE r.`ParentID`='441';
INSERT INTO `t_right` (`RightName`, `IsMenu`, `MenuName`, `URL`, `RightMemo`, `ParentID`, `DisplayOrder`) VALUES('A卡申请订单处理','1','A卡申请订单处理','acardnewmgr/apply!open.action?openId=7b9a30d117a2b45c','','441','1');
INSERT INTO `t_right` (`RightName`, `IsMenu`, `MenuName`, `URL`, `RightMemo`, `ParentID`, `DisplayOrder`) VALUES('A卡申请信息导入导出','1','A卡申请信息导入导出','acardnewmgr/apply!exportView.action?openId=7b9a30d117a2b45c','A卡申请信息导入导出','441','2');
INSERT INTO `t_right` (`RightName`, `IsMenu`, `MenuName`, `URL`, `RightMemo`, `ParentID`, `DisplayOrder`) VALUES('A卡申请售后','1','A卡售后管理','acardnewmgr/acard!open.action?openId=7b9a30d117a2b45c','','441','3');
INSERT INTO `t_right` (`RightName`, `IsMenu`, `MenuName`, `URL`, `RightMemo`, `ParentID`, `DisplayOrder`) VALUES('订单通知记录','1','订单通知记录','acardnewmgr/notice!toQuery.action?openId=9f25a32373bfbda5','订单通知记录','441','4');

-- 支付宝货车A卡接口配置
insert into `oe_common_bizauth` (`openId`, `bizId`, `status`) values('7031caad240becf6','acardbilldetailquery','1');
insert into `oe_common_bizauth` (`openId`, `bizId`, `status`) values('49d7f3b533bc20c4','acardinfoquerynew','1');
insert into `oe_common_bizauth` (`openId`, `bizId`, `status`) values('49d7f3b533bc20c4','acardorderapply','1');
insert into `oe_common_bizauth` (`openId`, `bizId`, `status`) values('49d7f3b533bc20c4','acardorderquery','1');
insert into `oe_common_bizauth` (`openId`, `bizId`, `status`) values('49d7f3b533bc20c4','freezenotify','1');
insert into `oe_common_bizauth` (`openId`, `bizId`, `status`) values('49d7f3b533bc20c4','withholdsign','1');
insert into `oe_common_bizauth` (`openId`, `bizId`, `status`) values('49d7f3b533bc20c4','zfbAsyncNotice','1');
insert into `oe_common_bizauth` (`openId`, `bizId`, `status`) values('49d7f3b533bc20c4','zfbUserCarInfoQuery','1');












