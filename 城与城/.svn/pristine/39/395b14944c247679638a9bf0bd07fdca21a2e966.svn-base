//
//  HH_MenuOrderListViewController.h
//  HuiHui
//
//  Created by mac on 15-6-19.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//  菜单订单列表页面

#import "BaseViewController.h"

@interface HH_MenuOrderListViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UIAlertViewDelegate>{
    
    NSInteger   m_index;
    
}

// 存放菜单列表的数据的数组
@property (nonatomic, strong) NSMutableArray    *m_orderList;
// 存放请求数据的店铺id
@property (nonatomic, strong) NSString          *m_shopId;
// 用于请求数据的状态值 0未支付，1已支付，2已取消
@property (nonatomic, strong) NSString          *m_status;
// 预定的菜单的数组
@property (nonatomic, strong) NSMutableArray    *m_menuOrderList;

@property (nonatomic, strong) NSString          *m_isWaiMai;

@property (nonatomic, strong) NSString          *m_merchantId;



// 订单列表请求数据
- (void)menuOrderList;
// 取消订单请求数据
- (void)cancelOrderRequest;

- (void)setNotPay:(BOOL)aNotPay withPayed:(BOOL)aPayed withCancel:(BOOL)aCancel;

@end
