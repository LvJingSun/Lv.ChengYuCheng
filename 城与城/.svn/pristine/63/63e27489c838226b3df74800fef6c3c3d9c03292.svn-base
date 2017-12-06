//
//  Fl_orderListViewController.h
//  HuiHui
//
//  Created by mac on 15-1-7.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//  机票的订单列表页面

#import "BaseViewController.h"

typedef enum
{
    NotPaidOrder = 0,
    PaidOrder = 1,
    DealOrder = 2,
    RefundOrder
    
} FlightsOrderType;

@interface Fl_orderListViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>

// 记录查看哪种类型的订单
@property (nonatomic, assign) FlightsOrderType  m_type;
// 存放订单的数组
@property (nonatomic, strong) NSMutableArray    *m_orderList;
// 判断来自于哪个页面  1表示订单支付方式选择的页面 2表示订单支付成功的页面
@property (nonatomic, strong) NSString          *m_typeString;


// 判断选中了哪个
- (void)setUnPaid:(BOOL)aUnpaid withPaid:(BOOL)aPaid withDeal:(BOOL)aDeal withRefund:(BOOL)aRefund;

// 订单请求接口
- (void)requestOrderSubmit;

@end
