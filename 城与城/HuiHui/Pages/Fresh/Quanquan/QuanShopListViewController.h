//
//  QuanShopListViewController.h
//  HuiHui
//
//  Created by mac on 15-5-12.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "BaseViewController.h"

@interface QuanShopListViewController : BaseViewController

@property (nonatomic, strong) NSMutableArray    *m_shopList;

// 拨打电话的UIWebView
@property (nonatomic, strong) UIWebView      *m_webView;

@end
