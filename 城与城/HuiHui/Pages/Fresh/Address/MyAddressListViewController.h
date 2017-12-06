//
//  MyAddressListViewController.h
//  HuiHui
//
//  Created by mac on 15-2-14.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//  我的地址列表页面

#import "BaseViewController.h"

@interface MyAddressListViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>

// 存放地址的数据列表
@property (nonatomic, strong) NSMutableArray    *m_addressList;

@end
