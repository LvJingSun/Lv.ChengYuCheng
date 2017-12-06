//
//  Wallet_FSB_HeadView.h
//  HuiHui
//
//  Created by mac on 2017/9/11.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Wallet_FSB_HeadView : UIView

@property (nonatomic, weak) UILabel *titleLab;

@property (nonatomic, weak) UILabel *balanceLab;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, copy) dispatch_block_t countBlock;

@end
