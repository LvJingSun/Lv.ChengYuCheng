//
//  NoticeAlertView.h
//  HuiHui
//
//  Created by mac on 2017/11/2.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoticeAlertView : UIView

- (instancetype)initWithImg:(NSString *)imgName;

- (void)showInView:(UIView *)view;

- (void)dismissFromView;

@end
