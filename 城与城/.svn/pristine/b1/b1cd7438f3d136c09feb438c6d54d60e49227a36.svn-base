//
//  SceneryListViewController.h
//  HuiHui
//
//  Created by mac on 15-1-13.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//  景点列表页面

#import "BaseViewController.h"

#import "PullTableView.h"

#import "SceneryFilterViewController.h"


typedef enum
{
    SceneryMoreType = 0,
    ScenerySaleType = 1,
    SceneryGoodType
    
} SceneryType;

@interface SceneryListViewController : BaseViewController<PullTableViewDelegate,UITableViewDataSource,UITableViewDelegate,SceneryDelegate>{
    
    NSInteger  m_pageIndex;
    
}

// 存放数据的数组
@property (nonatomic, strong) NSMutableArray  *m_sceneryList;

// 搜索类型
@property (nonatomic, assign) SceneryType     m_type;

- (void)setmore:(BOOL)aMoren withSale:(BOOL)aSale withGood:(BOOL)aGood;

@end
