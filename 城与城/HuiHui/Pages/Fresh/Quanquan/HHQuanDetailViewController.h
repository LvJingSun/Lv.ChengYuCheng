//
//  HHQuanDetailViewController.h
//  HuiHui
//
//  Created by mac on 15-2-11.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//  券券详情

#import "BaseViewController.h"

#import "ImageCache.h"

#import "CommonShareView.h"

@interface HHQuanDetailViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,CommonShareDelegate>


// 用于请求数据的券券id
@property (nonatomic, strong) NSString      *m_counponId;

@property (nonatomic, strong) ImageCache    *imagechage;

// 存放店铺数组
@property (nonatomic, strong) NSMutableArray    *m_shopList;

// 记录来自于哪个页面 1表示券券列表   2表示我的券券-已领取、已使用的页面
@property (nonatomic, strong) NSString      *m_typeString;

@property (strong, nonatomic) CommonShareView   *m_sharingView;
// 存放分享的地址链接
@property (strong, nonatomic) NSString          *m_urlString;

@property (nonatomic, strong) NSString          *m_titleString;

// 动画的三个数组
@property (nonatomic, strong) NSArray           *m_values;

@property (nonatomic, strong) NSArray           *m_keyTimes;

@property (nonatomic, strong) NSArray           *m_Funtions;


// 请求券券详情数据
- (void)quanquandetailRequest;

@end
