//
//  RootViewController.h
//  HuiHui
//
//  Created by mac on 13-11-19.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MLNavigationController.h"

#define isIOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 ? YES : NO)

@interface RootViewController : UITabBarController<UITabBarControllerDelegate,IChatManagerDelegate>
{
    BOOL * ReqYES;//表示是否请求成功，成功显示姓名，不成功有可能姓名就是数据 显示数据；
    EMConnectionState _connectionState;

}

@property (nonatomic, strong) UITabBarController        *m_tabBar;


- (void)jumpToChatList;

- (void)setupUntreatedApplyCount;

- (void)networkChanged:(EMConnectionState)connectionState;

@end
