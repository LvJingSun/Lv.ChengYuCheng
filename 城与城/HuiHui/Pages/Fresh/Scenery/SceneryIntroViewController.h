//
//  SceneryIntroViewController.h
//  HuiHui
//
//  Created by mac on 15-1-19.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//  图文景区简介

#import "BaseViewController.h"

@interface SceneryIntroViewController : BaseViewController<UIWebViewDelegate>

// 用于webView请求数据的info
@property (nonatomic, strong) NSString *m_infoString;


@end
