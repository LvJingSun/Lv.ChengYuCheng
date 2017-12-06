//
//  Fl_orderPayViewController.h
//  HuiHui
//
//  Created by mac on 15-1-8.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//  订单去支付的页面

#import "BaseViewController.h"

@interface Fl_orderPayViewController : BaseViewController<UITextFieldDelegate>

@property (nonatomic, strong) NSMutableDictionary   *appMore;

// 请求数据的参数oId
@property (nonatomic, strong) NSString  *m_orderId;
// 显示的支付价钱
@property (nonatomic, strong) NSString  *m_priceString;

// 用于判断用户是否填写过安全支付问题
@property (nonatomic, strong) NSString              *m_securityString;
@end
