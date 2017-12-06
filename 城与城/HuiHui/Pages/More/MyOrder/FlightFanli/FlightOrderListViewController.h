//
//  FlightOrderListViewController.h
//  HuiHui
//
//  Created by mac on 15-3-31.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//  机票订单列表的页面

#import "BaseViewController.h"

@interface FlightOrderListViewController : BaseViewController<UIActionSheetDelegate>

// 拨打电话使用的webView
@property (strong, nonatomic) UIWebView *m_webView;


@end
