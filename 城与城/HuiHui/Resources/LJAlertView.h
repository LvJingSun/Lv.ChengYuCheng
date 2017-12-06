//
//  LJAlertView.h
//  Receiving System
//
//  Created by mac on 2016/11/8.
//  Copyright © 2016年 lvjing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LJAlertView : NSObject<UIAlertViewDelegate>

+ (void)alertViewDisplayTitle:(NSString *)title andMessage:(NSString *)message;

+ (void)alertViewDisplayTitle:(NSString *)title andMessage:(NSString *)message andDisplayValue:(double)value;

@end
