//
//  SceneryOrderDetailViewController.h
//  HuiHui
//
//  Created by mac on 15-1-30.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//  景区订单详情

#import "BaseViewController.h"


@interface SceneryOrderDetailViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>{
    // 记录选择了哪个取消订单的原因
    NSInteger  m_index;
}

@property (nonatomic, strong) NSMutableDictionary   *m_dic;

// 记录取消原因的参数
@property (nonatomic, strong) NSString              *m_cancelReson;

// 存放订单数据的字典
@property (nonatomic, strong) NSMutableDictionary   *m_orderDic;

@property (nonatomic, assign) int                   m_type;

// 请求订单详情数据
- (void)SceneryDetailRequest;

// 取消订单请求数据
- (void)cancelOrderRequest;

@end
