//
//  FlightsPayViewController.h
//  HuiHui
//
//  Created by mac on 14-12-31.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//  机票下单成功后的支付页面

#import "BaseViewController.h"

@interface FlightsPayViewController : BaseViewController<UITextFieldDelegate,UIAlertViewDelegate>

@property (nonatomic, strong) NSMutableDictionary   *appMore;

// 订单的价钱
@property (nonatomic, strong) NSString              *m_priceString;

// 记录是展开的还是收起
@property (nonatomic, assign) BOOL                  isClose;

// 记录传递过来的字典
@property (nonatomic, strong) NSMutableDictionary   *m_dic;
// 联系人所在的字典
@property (nonatomic, strong) NSMutableDictionary   *m_contactDic;
// 订单号所在的字典
@property (nonatomic, strong) NSMutableDictionary   *m_orderdic;
// 传递手机号的值
@property (nonatomic, strong) NSString              *m_phoneString;
// 用于判断用户是否填写过安全支付问题
@property (nonatomic, strong) NSString              *m_securityString;

// 支付请求接口
- (void)requestSubmit;

@end
