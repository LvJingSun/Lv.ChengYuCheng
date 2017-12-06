//
//  FSB_GameHeadView.h
//  HuiHui
//
//  Created by mac on 2017/5/17.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FSB_ScrollView;

@interface FSB_GameHeadView : UIView

@property (nonatomic, weak) UIImageView *iconImageview;

@property (nonatomic, weak) UILabel *nameLab;

@property (nonatomic, weak) UILabel *zhanghuLab;

@property (nonatomic, weak) UILabel *countLab;

@property (nonatomic, copy) dispatch_block_t rechargeBlock;

@property (nonatomic, assign) CGFloat height;

@end
