//
//  MactQuanquanViewController.h
//  HuiHui
//
//  Created by mac on 15-3-24.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//  商户发布的券券列表

#import "BaseViewController.h"

#import "PullTableView.h"

@interface MactQuanquanViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,PullTableViewDelegate>{
    
    NSInteger   m_pageIndex;
}

// 存放券券列表的数据
@property (nonatomic, strong) NSMutableArray *m_vocherList;


// 券券列表请求数据
- (void)quanquanRequestSubmit;

@end
