//
//  SceneryOutListViewController.h
//  HuiHui
//
//  Created by mac on 15-1-29.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//  景区出行人列表页面

#import "BaseViewController.h"

#import "SceneryOutPViewController.h"

@protocol SceneryTravellerDelegate <NSObject>

- (void)SceneryTraveller:(NSMutableArray *)arr;

@end

@interface SceneryOutListViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,SceneryOutPeopleDelegate>

// 记录几张票的字段
@property (nonatomic, assign) int                       m_count;
// 记录是实名制还是身份证类型的字段
@property (nonatomic, assign) int                       realNameIndex;

// 存放联系人的数组
@property (nonatomic, strong) NSMutableArray            *m_list;

@property (nonatomic, assign) id<SceneryTravellerDelegate> delegate;

// 存放是否选中的某个数据的字典
@property (nonatomic, strong) NSMutableDictionary       *m_selectedDic;

// 存放选择的旅客信息的数组
@property (nonatomic, strong) NSMutableArray            *m_travellerList;

// 保证筛选只初始化一次
+ (SceneryOutListViewController *)shareobject;

// 请求数据
- (void)PeopleRequest;

@end
