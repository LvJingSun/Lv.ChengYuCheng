//
//  OilHeadView.h
//  HuiHui
//
//  Created by mac on 2017/6/7.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OilHeadView : UIView

@property (nonatomic, weak) UIImageView *iconImg;

@property (nonatomic, weak) UILabel *carModel;

@property (nonatomic, weak) UIButton *switchBtn;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, copy) dispatch_block_t switchBlock;

@end
