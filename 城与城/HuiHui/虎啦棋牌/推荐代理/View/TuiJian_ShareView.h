//
//  TuiJian_ShareView.h
//  HuiHui
//
//  Created by mac on 2017/11/20.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TuiJian_ShareView : UIView

- (void)showInView:(UIView *)view;

@property (nonatomic, copy) dispatch_block_t QQ_Block;

@property (nonatomic, copy) dispatch_block_t QZone_Block;

@property (nonatomic, copy) dispatch_block_t WX_Block;

@property (nonatomic, copy) dispatch_block_t WXFriends_Block;

@end
