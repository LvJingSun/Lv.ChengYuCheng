//
//  ZanListViewController.h
//  HuiHui
//
//  Created by mac on 14-6-12.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//  赞的列表

#import "BaseViewController.h"

@interface ZanListViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>


@property (nonatomic, strong) NSMutableArray    *m_zanList;

@property (nonatomic, strong) NSString          *m_dynimacId;


// 赞的人的数据请求
- (void)zanRequestSubmit;

@end
