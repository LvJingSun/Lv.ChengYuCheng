//
//  StatusUtility.h
//  HuiHui
//
//  Created by mac on 13-10-11.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StatusUtility : NSObject


+ (StatusUtility *)currentStatusUtility;

// 导航条背景
- (UINavigationController *)customizedNavigationController;

@end
