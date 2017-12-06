//
//  HuLaHomeBindAlertView.h
//  HuiHui
//
//  Created by mac on 2017/11/8.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HuLaHomeBindAlertView : UIView

@property (nonatomic, weak) UITextField *IDfield;

@property (nonatomic, weak) UILabel *noticeLab;

@property (nonatomic, copy) dispatch_block_t bindClickBlock;

- (void)showInView:(UIView *)view;

- (void)dismiss;

@end
