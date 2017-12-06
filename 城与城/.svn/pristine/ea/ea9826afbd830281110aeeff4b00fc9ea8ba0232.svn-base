//
//  MyOrderListViewController.h
//  HuiHui
//
//  Created by mac on 13-11-21.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import "BaseViewController.h"

@interface MyOrderListViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,DPRequestDelegate>

// 记录是哪个类型
@property (nonatomic, strong) NSString          *m_typeString;

// 存放服务器返回的数据数组
@property (nonatomic, strong) NSMutableArray    *m_productList;

//点评数组
@property (nonatomic, strong) NSMutableArray    *dp_productList;

// 记录选中的是第几个订单
@property (nonatomic, assign) NSInteger         m_cancelIndex;

@property (nonatomic, assign) NSInteger         m_payIndex;

// 订单请求数据
- (void)requestOrderSubmit;

// 取消订单请求数据
- (void)cancelOrderRequest:(NSString *)orderId;


@end
