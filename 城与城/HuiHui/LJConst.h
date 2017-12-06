//
//  LJConst.h
//  HuiHui
//
//  Created by mac on 2017/5/16.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#ifndef LJConst_h
#define LJConst_h

#import <MJRefresh.h>
#import <MBProgressHUD.h>

//粉丝宝

//粉丝宝基础页面
//#import "FSB_BasicViewController.h"
//页面yanse
#define FSB_ViewBGCOLOR [UIColor colorWithRed:244/255. green:244/255. blue:244/255. alpha:1.]
//主题色
#define FSB_StyleCOLOR [UIColor colorWithRed:72/255.f green:162/255.f blue:245/255.f alpha:1.0]
//系统屏幕宽度
#define _WindowViewWidth ([UIScreen mainScreen].bounds.size.width)
//系统屏幕高度
#define _WindowViewHeight ([UIScreen mainScreen].bounds.size.height)
//标题字体大小
#define FSB_NAVFont [UIFont systemFontOfSize:20]
//标题字体颜色
#define FSB_NAVTextColor [UIColor whiteColor]
//线的颜色
#define FSB_LineCOLOR [UIColor colorWithRed:239/255.f green:239/255.f blue:239/255.f alpha:1.0]

#import "CommonUtil.h"

#import "AppHttpClient.h"

#import "SVProgressHUD.h"

#import "UIImageView+AFNetworking.h"
//
////粉丝宝首页
//#import "FSB_HomeViewController.h"
////首页自定义titleview
//#import "FSB_NavTitleView.h"
//
////账户财富模型
//#import "FSB_AllWealthModel.h"
////账户财富模型frame
//#import "FSB_ALLWealthFrame.h"
////账户财富cell
//#import "FSB_AllWealthCell.h"
//昨日收益数字字体大小
#define FSB_YesterdayProfitFont [UIFont systemFontOfSize:40]
//昨日收益数字颜色
#define FSB_YesterdayProfitColor [UIColor colorWithRed:255/255.f green:255/255.f blue:255/255.f alpha:1.0]
//昨日收益标题字体大小
#define FSB_YesterdayProfitTitleFont [UIFont systemFontOfSize:15]
//总额度字体大小
#define FSB_AllQuotaFont [UIFont systemFontOfSize:18]
//累计收益数字字体大小
#define FSB_CumulativeProfitFont [UIFont systemFontOfSize:25]
//累计收益标题字体大小
#define FSB_CumulativeProfitTextFont [UIFont systemFontOfSize:17]
//累计收益标题字体颜色
#define FSB_CumulativeProfitTitleCOLOR [UIColor colorWithRed:130/255.f green:130/255.f blue:138/255.f alpha:1.0]



//累计收益页面
//#import "FSB_CumulativeProfitViewController.h"
////收益model
//#import "FSB_ProfitModel.h"
////收益frame
//#import "FSB_ProfitFrame.h"
////收益cell
//#import "FSB_ProfitCell.h"
////收益页面headview
//#import "FSB_ProfitHeadView.h"
//
//
//
////累计消费页面
//#import "FSB_CumulativeConsumptionViewController.h"
//订单状态颜色
#define FSB_ConsumptionOrderStatusCOLOR [UIColor colorWithRed:95/255.f green:95/255.f blue:95/255.f alpha:1.0]
//订单状态font
#define FSB_ConsumptionOrderStatusFont [UIFont systemFontOfSize:17]
//日期颜色
#define FSB_ConsumptionOrderDateCOLOR [UIColor colorWithRed:166/255.f green:166/255.f blue:166/255.f alpha:1.0]
//日期font
#define FSB_ConsumptionOrderDateFont [UIFont systemFontOfSize:15]
//累计消费model
//#import "FSB_ConsumptionModel.h"
////消费frame
//#import "FSB_ConsumptionFrame.h"
////消费cell
//#import "FSB_ConsumptionCell.h"
//
//
////总额度页面
//#import "FSB_AllQuotaViewController.h"
////额度model
//#import "FSB_QuotaModel.h"
////额度frame
//#import "FSB_QuotaFrame.h"
////额度cell
//#import "FSB_QuotaCell.h"
//
//
////明细页面
//#import "FSB_DetailedViewController.h"
////明细model
//#import "FSB_DetailedModel.h"
////明细frame
//#import "FSB_DetailedFrame.h"
////明细cell
//#import "FSB_DetailedCell.h"

//明细 返利来源font
#define FSB_DetailedSourceFont [UIFont systemFontOfSize:17]
//明细 返利来源color
#define FSB_DetailedSourceCOLOR [UIColor colorWithRed:63/255.f green:68/255.f blue:70/255.f alpha:1.0]
//明细 已完成color
#define FSB_DetailedYiWanChengCOLOR [UIColor colorWithRed:255/255.f green:99/255.f blue:27/255.f alpha:1.0]
//明细 已冻结color
#define FSB_DetailedDongJieCOLOR [UIColor colorWithRed:229/255.f green:37/255.f blue:32/255.f alpha:1.0]
//明细 背景框color
#define FSB_DetailedBGCOLOR [UIColor colorWithRed:250/255.f green:250/255.f blue:250/255.f alpha:1.0]
//明细 进度条背景color
#define FSB_DetailedProgressBGCOLOR [UIColor colorWithRed:217/255.f green:217/255.f blue:217/255.f alpha:1.0]
//明细 进度条color
#define FSB_DetailedProgressCOLOR [UIColor colorWithRed:255/255.f green:134/255.f blue:0/255.f alpha:1.0]
//明细 返利金额font
#define FSB_DetailedCountFont [UIFont systemFontOfSize:15]
//明细 总返利颜色
#define FSB_DetailedTotalCountCOLOR [UIColor colorWithRed:89/255.f green:94/255.f blue:95/255.f alpha:1.0]
//明细 返利号颜色
#define FSB_DetailedFanliCOLOR [UIColor colorWithRed:166/255.f green:166/255.f blue:166/255.f alpha:1.0]
//明细 返利号font
#define FSB_DetailedFanliFont [UIFont systemFontOfSize:14]
//明细 分割线颜色
#define FSB_DetailedLineCOLOR [UIColor colorWithRed:240/255.f green:240/255.f blue:240/255.f alpha:1.0]


//首页 游戏名称font
#define FSB_HomeGameNameFont [UIFont systemFontOfSize:16]
//明细 游戏名称color
#define FSB_HomeGameNameCOLOR [UIColor colorWithRed:255/255.f green:255/255.f blue:255/255.f alpha:1.0]
//首页 用户名font
#define FSB_GamePersonFont [UIFont systemFontOfSize:18]
//首页 用户名Color
#define FSB_GamePersonCOLOR [UIColor colorWithRed:67/255.f green:67/255.f blue:67/255.f alpha:1.0]
//首页 账户余额标题font
#define FSB_GameYuEFont [UIFont systemFontOfSize:16]
//首页 账户余额标题Color
#define FSB_GameYuECOLOR [UIColor colorWithRed:106/255.f green:106/255.f blue:106/255.f alpha:1.0]
//首页 账户余额font
#define FSB_GameCountFont [UIFont systemFontOfSize:18]
//首页 账户余额Color
#define FSB_GameCOuntCOLOR [UIColor colorWithRed:255/255.f green:64/255.f blue:1/255.f alpha:1.0]
//热游推荐color
#define GameCenterTitleCOLOR [UIColor colorWithRed:0/255.f green:0/255.f blue:0/255.f alpha:1.0]
//热游推荐font
#define GameCenterTitleFont [UIFont systemFontOfSize:22]

//充值话费color
#define RechargePhoneCOLOR [UIColor colorWithRed:0/255.f green:0/255.f blue:0/255.f alpha:1.0]
//充值话费font
#define RechargePhoneFont [UIFont systemFontOfSize:24]
//话费充值key
#define RechargeKey @"d26c2485d424a1a73282b71e40382dac"

//弹框 标题Color
#define AlertTitleCOLOR [UIColor colorWithRed:13/255.f green:13/255.f blue:13/255.f alpha:1.0]
//弹框 标题Font
#define AlertTitleFont [UIFont systemFontOfSize:20]
//弹框 数字Color
#define AlertCountCOLOR [UIColor colorWithRed:5/255.f green:5/255.f blue:5/255.f alpha:1.0]
//弹框 数字Font
#define AlertCountFont [UIFont systemFontOfSize:35]
//弹框 订单标题Color
#define AlertNoTitleCOLOR [UIColor colorWithRed:132/255.f green:132/255.f blue:132/255.f alpha:1.0]
//弹框 订单标题Font
#define AlertNoTitleFont [UIFont systemFontOfSize:15]
//弹框 订单号Color
#define AlertNoCOLOR [UIColor colorWithRed:26/255.f green:26/255.f blue:26/255.f alpha:1.0]
//弹框 订单号Font
#define AlertNoFont [UIFont systemFontOfSize:16]

//
//
////粉丝宝协议
//#import "FSB_AgreementViewController.h"

#endif /* LJConst_h */
