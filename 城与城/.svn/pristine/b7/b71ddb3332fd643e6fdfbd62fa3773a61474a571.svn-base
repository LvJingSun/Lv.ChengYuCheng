//
//  SceneryOutPViewController.h
//  HuiHui
//
//  Created by mac on 15-1-28.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//  景区选择出行人的信息填写页面

#import "BaseViewController.h"

@protocol SceneryOutPeopleDelegate <NSObject>

- (void)SceneryOutPeople:(NSDictionary *)dic;

@end

@interface SceneryOutPViewController : BaseViewController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>

// 代理
@property (nonatomic, assign) id<SceneryOutPeopleDelegate>delegate;

// 记录几张票的字段
@property (nonatomic, assign) int                       m_count;
// 记录是实名制还是身份证类型的字段
@property (nonatomic, assign) int                       realNameIndex;
// 存放填写的处刑人信息的字典
@property (nonatomic, strong) NSMutableDictionary       *m_infoDic;

// 添加出行人信息请求数据
- (void)AddPeopleRequest;


@end
