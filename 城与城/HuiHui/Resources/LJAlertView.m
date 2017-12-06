//
//  LJAlertView.m
//  Receiving System
//
//  Created by mac on 2016/11/8.
//  Copyright © 2016年 lvjing. All rights reserved.
//

#import "LJAlertView.h"

@implementation LJAlertView

+ (void)alertViewDisplayTitle:(NSString *)title andMessage:(NSString *)message {
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:title message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
    
}

+ (void)alertViewDisplayTitle:(NSString *)title andMessage:(NSString *)message andDisplayValue:(double)value{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:title message:message delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
    [alert show];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(value * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [alert dismissWithClickedButtonIndex:[alert cancelButtonIndex] animated:YES];
    });
    
}

@end
