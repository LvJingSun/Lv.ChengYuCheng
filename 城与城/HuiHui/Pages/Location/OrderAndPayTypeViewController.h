//
//  OrderAndPayTypeViewController.h
//  HuiHui
//
//  Created by mac on 14-6-25.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "BaseViewController.h"

#import "LTInterface.h"

@interface OrderAndPayTypeViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,LTInterfaceDelegate,UIAlertViewDelegate>


@property (nonatomic, strong) NSMutableDictionary       *m_dic;

// 存储选择某个支付方式所在的临时字典
@property (nonatomic, strong) NSMutableDictionary       *m_typeDic;

// 存储选择某个物流方式是否物流所在的临时字典
@property (nonatomic, strong) NSMutableDictionary       *m_WuliutypeDic;

// 用于判断选择的是 诲诲支付0 还是银联支付1 还是支付宝支付2
@property (nonatomic, strong) NSString                  *m_typeString;

// 用于判断选择的是 自取0 物流1
@property (nonatomic, strong) NSString                  *m_WuliutypeString;

// 订单号
@property (nonatomic, strong) NSString                  *m_orderId;

@property (nonatomic, assign) BOOL                      isCharge;

// 记录是否支持支付宝支付
@property (nonatomic, strong) NSString                  *m_zhifubao;

@property (nonatomic, copy) NSString *ruKou;

// 验证用户是否填写了支付问题的网络请求
- (void)paymentSafeRequest;

// 请求银联的接口，请求服务器返回报文提交启动银联支付的插件
- (void)requestRechargeSubmit;


@end
