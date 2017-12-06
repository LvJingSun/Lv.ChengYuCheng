//
//  ShareGameView.h
//  HuiHui
//
//  Created by mac on 2017/6/2.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShareGameView : UIView

- (instancetype)initWithCancle:(NSString *)cancleText;

- (void)show;

@property (nonatomic, copy) dispatch_block_t QQBlock;

@property (nonatomic, copy) dispatch_block_t QQZoneBlock;

@property (nonatomic, copy) dispatch_block_t WeChatBlock;

@property (nonatomic, copy) dispatch_block_t WeChatZoneBlock;

@property (nonatomic, copy) dispatch_block_t HuiHuiBlock;

@property (nonatomic, copy) dispatch_block_t HuiHuiZoneBlock;

@property (nonatomic, copy) dispatch_block_t CancleBlock;

@end
