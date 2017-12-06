//
//  CommonUtil.h
//  bazhifuApp
//
//  Created by mac on 13-6-8.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *const  MEMBERCODE    =    @"memberCode";

static NSString * const MEMBER_ID = @"memberId";

static NSString * const ACCOUNT = @"account";

static NSString * const PWD = @"pwd";

static NSString * const NICK = @"nick";

static NSString * const Ctrip_RealName = @"Ctrip_realName";//用于携程购买时显示的会员真实姓名；


static NSString * const IsDaiLiAndMct = @"IsDaiLiAndMct";//是否商户或代理商（1是；0:否）

static NSString * const IsMemDaren = @"IsMemDaren";//是否已经是生活达人

static NSString * const IsResDaren = @"IsResDaren";//是否已经是资源达人

static NSString * const XiaoFeiFanLiBiLi = @"XiaoFeiFanLiBiLi";//消费返利比例

static NSString * const LifFanLiBiLi = @"LifFanLiBiLi";//生活达人返利比例

static NSString * const MemResNo = @"MemResNo";//设置不要提醒；

static NSString * const DaiLiLevel = @"DaiLiLevel";//（代理等级）

static NSString * const SERVER_TIME_DIFF = @"serverTimeDiff";

static NSString * const LOGINSELF = @"loginself";

static NSString * const OPERATION_INCOME = @"Income";

static NSString * const OPERATION_EXPENDITURE = @"Expenditure";

static NSString * const KEY_TYPE_ACTIVITY = @"Activity";//活动

static NSString * const KEY_TYPE_SERVICE = @"Service";//服务资源

static NSString * const KEY_TYPE_BUY = @"PanicBuyGoods";//抢购

static NSString * const KEY_TYPE_OTHER = @"Other";//其他key


static NSString * const LOCK_STATUS = @"lockStatus";

static NSString * const LOCK_MESSAGE = @"lockMessage";

static NSString * const VLD_STATUS_AUDIT = @"Audit";//审核中

static NSString * const VLD_STATUS_INVALID = @"Invalid";//无效

static NSString * const VLD_STATUS_VALID = @"Valid";//有效

static NSString * const VLD_STATUS_NOT_CERTIFIED = @"NotCertified";//未认证

static NSString * const REAL_ACCOUNT_NAME = @"realAccountName";

static NSString * const REAL_ACCOUNT_IDCARD = @"realAccountIdcard";

static NSString * const TYPE_CITY = @"city";

static NSString * const TYPE_CATEGORY = @"category";

static NSString * const VERSION_NUM = @"versionNumber";

static NSString * const VERSION_APPURL = @"appPkgUrl";

static NSString * const TYPE_FLIGHTSCITY = @"flightsCity";

static NSString * const TYPE_SCENERYCITY = @"sceneryCity";

// 用于微信支付那边的赋值
static NSString * const WEIXIN_NAME = @"weixinNameKey";
static NSString * const WEIXIN_PRICE = @"weixinPriceKey";
static NSString * const WEIXIN_OREDENO = @"weixinOrderNoKey";

// 判断是购买什么商品
static NSString * const WEIXIN_PAYTYPE = @"weixinPayTypeKey";

// 大众点评返利的比例
static NSString * const DZDP_FANLI = @"dzdpfanliKey";


// 需要修改Type类型的值===
//static NSString * const INTEGRATION_INCOME =  @"Income"; 
//
//static NSString * const INTEGRATION_EXPENDITURE = @"Expenditure";
//
//static NSString * const WAITFORPAY = @"WaitForPay";
//
//static NSString * const TRANSFER = @"Transfer";
//// 需要修改Type类型的值===
//static NSString * const  JOINED_FRIENDS  =  @"Joined";
//
//static NSString * const  NOTINVIDATE_FRIENDS  =  @"Invitation";

// 用于记录支付密码设置
// 邀请码
static NSString * const  R_INVIDATECODE         =    @"R_InvidataCode";
// 昵称
static NSString * const  R_USERNAME             =    @"R_UserName";
// 邮箱
static NSString * const  R_EMAIL                =    @"R_email";
// 登录密码
static NSString * const  R_LOGINPASSW           =    @"R_loginPassW";
// 确认登录密码
static NSString * const  R_AGAINPASSW           =    @"R_AgainPassW";
// 验证码
static NSString * const  R_VALIDATECODE         =    @"R_ValidateCode";
// 支付密码
static NSString * const  R_PAYPASSW             =    @"R_PayPassW";
// 确认支付密码
static NSString * const  R_AGAINPAYPASSW        =    @"R_AgainPayPassW";
// 问题一
static NSString * const  R_QUESTION_FIRST       =    @"R_Question_First";
// 问题二
static NSString * const  R_QUESTION_SECOND      =    @"R_Question_Second";
// 问题三
static NSString * const  R_QUESTION_THIRD       =    @"R_Question_Third";
// 答案一
static NSString * const  R_ANSWER_FIRST         =    @"R_Answer_First";
// 答案二
static NSString * const  R_ANSWER_SECOND        =    @"R_Answer_Second";
// 答案三
static NSString * const  R_ANSWER_THIRD         =    @"R_Answer_Third";
// 问题一id
static NSString * const  R_QUESTION_FIRST_ID    =    @"R_Question_First_id";
// 问题二id
static NSString * const  R_QUESTION_SECOND_ID   =    @"R_Question_Second_id";
// 问题三id
static NSString * const  R_QUESTION_THIRD_ID    =    @"R_Question_Third_id";
// ============
// 用户个人信息
static NSString * const  USER_SEX           =    @"UserSex";
static NSString * const  USER_EMAIL         =    @"UserEmail";
static NSString * const  USER_PHOTO         =    @"UserPhoto";
static NSString * const  USER_AREA          =    @"UserArea";
static NSString * const  USER_BIRTHDAY      =    @"UserBirthday";
static NSString * const  USER_NAME          =    @"UserName";

// 用户实名认证的状态
static NSString * const  USER_REALAUSTATUS  =    @"realAuStatus";

// 存储的cityId
static NSString * const  CITYID       =         @"cityId";

static NSString * const  MERCHANTCITYID         =         @"MerchantCityId";

// 引导页和APP风格的RGB值及商户id
static NSString * const  MERCHANTID             =         @"MerchantId";

static NSString * const  LOADINGPAGEIMAGE       =         @"MaxBgImg";
//运动养生URL
static NSString * const  YunDongYSUrl           =         @"YunDongYSUrl";

//static NSString * const  LOADINGPAGERGB         =         @"Rgb";

static NSString * const  TOKENNOUSEDTOTAL       =         @"TokenNoUsedTotal";
static NSString * const  TOKENUSEDTOTAL         =         @"TokenUsedTotal";


// 我的聚会状态值
static NSString * const  STATUS_PLAN            =       @"plan";
static NSString * const  STATUS_AUDIT           =       @"audit";
static NSString * const  STATUS_CONDUCT         =       @"conduct";
static NSString * const  STATUS_END             =       @"end";

static NSString * const  REALAUSTATUS  =    @"realAuStatus";

// 活动和个人聚会
static NSString * const MERCHANTACTIVITY = @"MerchantActivity";

static NSString * const PARTY = @"Party";


// 记录聊天对方的memberId
static NSString *const  OTHERMEMBERID   = @"OtherMemberId";
// 保存聊天人的昵称
static NSString *const  OTHERUSERNAME   = @"OtherUserName";
// 头像
static NSString *const  OTHERHEADERIMAGE   = @"OtherHeaderImage";

// 记录聊天登录的密码
static NSString *const  LOGINPASSWORD   = @"LoginPassWord";

// ============
// 公众邀请码的状态
static NSString * const  NOPublicCode               =    @"noPublicKey";
// 审核中
static NSString * const  PublicInviteCodePending    =    @"PublicInviteCodePending";
// 已通过
static NSString * const  PublicInviteCodePassed     =    @"PublicInviteCodePassed";
// 已禁用
static NSString * const  PublicInviteCodeStopped    =    @"PublicInviteCodeStopped";
// 已退回
static NSString * const  PublicInviteCodeReturened  =    @"PublicInviteCodeReturened";

// 转发的内容
static NSString * const  FORWARDCONTENT = @"forwardContent";

static NSString * const  Spaceuploadtime = @"Spaceuploadtime";//空间上一次更新的时间（分钟）

static NSString * const  Spacedp = @"Spacedp";//需要从数据库捞数据

// 记录是从哪边进行发起聊天的
static NSString * const  kFromMessage = @"SendMessageFrom";

static NSString * const  kFriendFlag = @"messageFriendFlag";

// 记录是否支持支付宝支付
static NSString * const  kIsAlipay = @"IsAlipay";
// 保存支付宝的地址
static NSString * const  kAlipayUrl = @"AlipayUrl";

// 存储百度push的三个值
static NSString * const  BPush_kAppIdKey        = @"BPush_AppId";
static NSString * const  BPush_kUserIdKey       = @"BPush_UserId";
static NSString * const  BPush_kChannelIdKey    = @"BPush_ChannelId";

static NSString * const  BPush_devicetoken      = @"dvicetoken";

// 新评论的数据
static NSString * const  DynamicComments        = @"DynamicComments";
// 新评论的头像
static NSString * const  CommentPhotoMid        = @"CommentPhotoMid";

// 群主的名称
static NSString * const  GroupNickName          = @"GroupNickName";

#pragma mark - 携程酒店请求的参数
static NSString * const  Ctrip_hotel_cityid     = @"Ctrip_hotel_cityid";//城市id
static NSString * const  Ctrip_hotel_areaid        = @"Ctrip_hotel_areaid";//行政区域id
static NSString * const  Ctrip_hotel_keyword        = @"Ctrip_hotel_keyword";//关键字
static NSString * const  Ctrip_hotel_starts        = @"Ctrip_hotel_starts";//酒店星级

// QQ登录保存的token及openId
static NSString *const QQAccessTokenKey = @"QQAccessTokenKey";
static NSString *const QQCurrentUserIdKey = @"QQCurrentUserIdKey";
// qqtoken失效时间
static NSString *const QQExpirationDateKey = @"QQExpirationDateKey";
// 临时存储下qq token的值
//static NSString *const QQTokenKey = @"QQTokenKey";
// 标志景区城市的Id
static NSString *const SceneryCityId = @"sceneryCityId";
// 图片路径地址
static NSString *const SceneryImageUrl = @"SceneryImageUrl";

// 记录是qq登录还是微信登录
static NSString *const wxQqType = @"wxQqType";

// 是否是qq还是微信登录
static NSString *const weixinOrQqOrAccount   = @"weixinOrQqOrAccount";

// 新增、编辑、删除广告后的标记值请求数据
static NSString *const AdvertsKey   = @"AdvertsKey";
// 记录注册、忘记密码页面上面状态栏值的删除
static NSString *const ApplicationStatusKey   = @"ApplicationStatusKey";
// 新增、编辑菜单后标记值来请求数据
static NSString *const MenuListKey   = @"MenuListKey";

// 菜单类别的名称
static NSString *const MENUCLASSNAME   = @"MenuClassName";

static NSString *const ADDRESSMODIFY   = @"addressModify";

// 满立减的参数，用于下订单时候的赋值
static NSString *const YHDESCRIPTION   = @"YHDescriptionKey";

static NSString *const MANKEY   = @"manKey";

static NSString *const JIANKEY   = @"jianKey";

static NSString *const GameAlert   = @"GameAlert";

static NSString *const GameLink   = @"GameLink";



@interface CommonUtil : NSObject

+ (NSString *) getServerKey;

+ (NSString *) getDocumentPath:(NSString *)fileName;

+ (id) getValueByKey:(NSString *)key;

+ (void) addValue:(id)object andKey:(NSString *)key;

+ (NSDictionary *) transactionTypeDict;

+ (NSDictionary *) operationsDict;

+ (NSDictionary *) statusDict;

+ (NSDictionary *) keyStatusDict;

+ (NSDictionary *) bankcardStatusDict;

+ (UIColor *)colorWithHexValue:(NSUInteger)hexValue alpha:(CGFloat)alpha;

+ (UIColor *)selectBackgroundColor;

+ (UIColor *)selectTabBarTitleColor;

+ (UIImage *)scaleImage:(UIImage *)image toSize:(CGSize)reSize;

@end





