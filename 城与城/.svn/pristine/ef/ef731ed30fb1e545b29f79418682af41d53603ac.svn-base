//
//  HH_ShareMenuViewController.h
//  HuiHui
//
//  Created by mac on 15-8-24.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//  下单成功后进行显示分享的页面

#import "BaseViewController.h"

#import "CommonShareView.h"

@interface HH_ShareMenuViewController : BaseViewController<CommonShareDelegate>

@property (strong, nonatomic) CommonShareView       *m_sharingView;

// 存放分享的地址链接
@property (strong, nonatomic) NSString              *m_urlString;

@property (nonatomic, strong) NSString              *m_titleString;

// 动画的三个数组
@property (nonatomic, strong) NSArray               *m_values;

@property (nonatomic, strong) NSArray               *m_keyTimes;

@property (nonatomic, strong) NSArray               *m_Funtions;

// 存放订单id的值
@property (nonatomic, strong) NSString              *m_orderId;

@property (nonatomic, strong) NSMutableDictionary   *m_dic;
// 记录是会员卡支付还是微信支付还是现场支付的值  1 现场支付 2 微信支付 3 会员卡支付 4 美容模式下会员卡支付  5 美容模式下微信支付
@property (nonatomic, strong) NSString              *m_typeString;


// 现场支付条转过来后请求数据进行赋值
- (void)infoRequestSubmit;

@end
