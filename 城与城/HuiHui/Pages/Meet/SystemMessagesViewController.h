//
//  SystemMessagesViewController.h
//  HuiHui
//
//  Created by mac on 13-12-11.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import "BaseViewController.h"

#import "PullTableView.h"

@interface SystemMessagesViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,PullTableViewDelegate>{
    
    // 用于分页请求的参数
    NSInteger pageIndex;
    
    
}


@property (nonatomic, strong) NSMutableArray *m_array;


// 请求数据
- (void)requestMessageList;


@end
