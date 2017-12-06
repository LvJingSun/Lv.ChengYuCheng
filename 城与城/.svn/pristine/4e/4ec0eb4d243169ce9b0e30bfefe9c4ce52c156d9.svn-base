//
//  ResultViewController.h
//  HuiHui
//
//  Created by mac on 14-1-6.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "BaseViewController.h"

@interface ResultViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *m_array;

// 记录上个页面搜索输入的值，用于刷新数据
@property (nonatomic, strong) NSString *m_searchString;
// 记录来自于哪个页面 1表示来自于好友搜索 2表示来自于扫描页面
@property (nonatomic, strong) NSString *m_typeString;


// 请求数据
- (void)requestFriendsSubmit;

@end
