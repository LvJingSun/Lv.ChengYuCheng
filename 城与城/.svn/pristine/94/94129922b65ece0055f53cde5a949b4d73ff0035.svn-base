//
//  PanicBuyingViewController.h
//  HuiHui
//
//  Created by mac on 14-2-13.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//  立即抢购的付款的页面

#import "BaseViewController.h"

#import "LTInterface.h"

@interface PanicBuyingViewController : BaseViewController<LTInterfaceDelegate>


// 存储商品信息的字典
@property (strong, nonatomic) NSMutableDictionary *m_items;

@property (nonatomic, strong) NSString *m_payTypeString;

@property (nonatomic, assign) BOOL  isCharge;



// 令牌请求数据
- (void)toekenRequestSubmit;
// 判断余额不足和支付密码未设置的情况
- (void)safeRequestSubmit;
// 获取诲诲余额的数据请求-请求更多的接口
- (void)balanceRequestSubmit;

@end
