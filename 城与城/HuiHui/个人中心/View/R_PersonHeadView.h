//
//  R_PersonHeadView.h
//  HuiHui
//
//  Created by mac on 2017/11/16.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface R_PersonHeadView : UIView

@property (nonatomic, weak) UIImageView *contentImg;

@property (nonatomic, weak) UIImageView *iconImg;

@property (nonatomic, weak) UILabel *balanceLab;

@property (nonatomic, weak) UILabel *nameLab;

@property (nonatomic, weak) UILabel *phoneLab;

@property (nonatomic, weak) UILabel *fsbCount;

@property (nonatomic, weak) UILabel *hhCount;

@property (nonatomic, weak) UILabel *jljCount;

@property (nonatomic, weak) UILabel *jfCount;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, copy) dispatch_block_t iconBlock;

@property (nonatomic, copy) dispatch_block_t balanceBlock;

@property (nonatomic, copy) dispatch_block_t fsbBlock;

@property (nonatomic, copy) dispatch_block_t hhBlock;

@property (nonatomic, copy) dispatch_block_t jljBlock;

@property (nonatomic, copy) dispatch_block_t jfBlock;

@end
