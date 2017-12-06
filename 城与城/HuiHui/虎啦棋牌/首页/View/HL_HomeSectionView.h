//
//  HL_HomeSectionView.h
//  HuiHui
//
//  Created by mac on 2017/11/6.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HL_HomeSectionView : UIView

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, weak) UIButton *becomeDelegateBtn;

@property (nonatomic, weak) UILabel *becomeDelegateLine;

@property (nonatomic, weak) UIButton *tuijianDelegateBtn;

@property (nonatomic, weak) UILabel *tuijianDelegateLine;

@property (nonatomic, weak) UIButton *myTeamBtn;

@property (nonatomic, weak) UILabel *myTeamLine;

@property (nonatomic, weak) UIButton *myMoneyBtn;

@property (nonatomic, weak) UILabel *myMoneyBLine;

@property (nonatomic, copy) dispatch_block_t becomeDelegateBlock;

@property (nonatomic, copy) dispatch_block_t tuijianDelegateBlock;

@property (nonatomic, copy) dispatch_block_t myTeamBlock;

@property (nonatomic, copy) dispatch_block_t myMoneyBlock;

@end
