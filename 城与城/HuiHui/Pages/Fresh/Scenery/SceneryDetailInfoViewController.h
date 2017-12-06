//
//  SceneryDetailInfoViewController.h
//  HuiHui
//
//  Created by mac on 15-1-26.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//  景区简介

#import "BaseViewController.h"

@interface SceneryDetailInfoViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UIWebViewDelegate>

// 传递过来的字典
@property (nonatomic, strong) NSMutableDictionary   *m_dic;

// 传递到更多图文详情的字段
@property (nonatomic, strong) NSString *m_info;

// 购买须知
@property (nonatomic, strong) NSString              *m_noticeString;

@property (nonatomic, strong) UIWebView             *m_noticeWebView;

@property (nonatomic, strong) UIWebView             *m_routeWebView;


// 显示公交路线的参数
@property (nonatomic, strong) NSString              *m_routeString;


// 公交路线请求数据
- (void)sceneryRouteRequest;

@end
