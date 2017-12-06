//
//  FlightsListViewController.h
//  HuiHui
//
//  Created by mac on 14-12-10.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//  机票搜索结果页面

#import "BaseViewController.h"

@interface FlightsListViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>{
    
    NSInteger       m_index;
    
}

// 记录请求数据的参数
@property (nonatomic, strong) NSMutableDictionary   *m_dictionary;

// 存放请求下来的数据的数组
@property (nonatomic, strong) NSMutableArray        *m_list;

// 记录当前的时间
@property (nonatomic, strong) NSString              *m_currentDateString;


// 请求数据
- (void)requestSubmit;


@end
