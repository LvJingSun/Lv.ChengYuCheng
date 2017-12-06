//
//  FSB_BasicViewController.h
//  HuiHui
//
//  Created by mac on 2017/5/12.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FSB_BasicViewController : UIViewController

- (UIBarButtonItem *)SetNavigationBarRightImage:(NSString *)aImageName andaction:(SEL)Saction;

- (UIBarButtonItem *)SetNavigationBarRightTitle:(NSString *)title andaction:(SEL)Saction;

@end
