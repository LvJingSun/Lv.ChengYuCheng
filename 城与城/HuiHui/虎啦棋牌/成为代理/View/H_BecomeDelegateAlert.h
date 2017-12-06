//
//  H_BecomeDelegateAlert.h
//  HuiHui
//
//  Created by mac on 2017/11/15.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface H_BecomeDelegateAlert : UIView

- (instancetype)initWithContent:(NSString *)contentText;

- (void)showInView:(UIView *)view;

@end
