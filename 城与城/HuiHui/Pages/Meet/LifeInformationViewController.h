//
//  LifeInformationViewController.h
//  HuiHui
//
//  Created by mac on 13-12-11.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//  生活资讯

#import "BaseViewController.h"

#import "PullTableView.h"

@interface LifeInformationViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,PullTableViewDelegate>{
    
    // 用于分页请求的参数
    NSInteger pageIndex;

    
}

// 数组
@property (nonatomic, strong) NSMutableArray *m_array;


// 请求数据
- (void)requestInfoList;

@end
