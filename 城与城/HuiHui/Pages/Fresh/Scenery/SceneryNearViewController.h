//
//  SceneryNearViewController.h
//  HuiHui
//
//  Created by mac on 15-1-19.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//  景点周边页面

#import "BaseViewController.h"

#import "PullTableView.h"

@interface SceneryNearViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,PullTableViewDelegate>{
    
    int  m_pageIndex;

}

// 用于请求数据的sceneryId
@property (nonatomic, strong) NSString              *m_sceneryId;
// 存放数据的数组
@property (nonatomic, strong) NSMutableArray        *m_nearList;

// 记录显示图片的url字符
@property (nonatomic, strong) NSString              *m_imageUrl;

// 请求数据
- (void)nearRequest;

@end
