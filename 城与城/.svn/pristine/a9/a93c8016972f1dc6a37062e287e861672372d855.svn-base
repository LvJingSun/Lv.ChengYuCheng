//
//  SceneryOrderListViewController.h
//  HuiHui
//
//  Created by mac on 15-1-29.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "BaseViewController.h"

#import "PullTableView.h"

typedef enum
{
    SceneryOrderEndType = 0,
    SceneryOrderInProType
    
} SceneryOrderType;

@interface SceneryOrderListViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,PullTableViewDelegate>{
    
    NSInteger   m_pageIndex;
    
}

// 判断来自于哪个页面  1表示我的订单  2表示预订成功后
@property (nonatomic, strong) NSString              *m_stringType;

// 存放数据的数组
@property (nonatomic, strong) NSMutableArray        *m_orderList;

@property (nonatomic, assign) SceneryOrderType      m_type;

// 请求数据
- (void)orderListRequest;

- (void)setLeft:(BOOL)aLeft withRight:(BOOL)aRight;

@end
