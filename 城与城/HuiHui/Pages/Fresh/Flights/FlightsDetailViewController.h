//
//  FlightsDetailViewController.h
//  HuiHui
//
//  Created by mac on 14-12-10.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//  机票详情

#import "BaseViewController.h"

@interface FlightsDetailViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>

// 存放请求数据参数的字典
@property (nonatomic, strong) NSMutableDictionary *m_dic;

// 存放数据的数组
@property (nonatomic, strong) NSMutableArray      *m_list;


// 请求数据
- (void)requestDetailSubmit;

@end
