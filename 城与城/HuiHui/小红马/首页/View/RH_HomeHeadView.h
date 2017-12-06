//
//  RH_HomeHeadView.h
//  HuiHui
//
//  Created by mac on 2017/6/6.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RH_HomeBtnView;

@interface RH_HomeHeadView : UIView

@property (nonatomic, weak) UILabel *phoneLab;

@property (nonatomic, weak) UIButton *phoneBtn;

@property (nonatomic, weak) UIImageView *redHorseImg;

@property (nonatomic, weak) UILabel *redHorseTitleLab;

@property (nonatomic, weak) UILabel *descTitleLab;

@property (nonatomic, weak) UILabel *descContentLab;

@property (nonatomic, weak) UIButton *detailBtn;

@property (nonatomic, weak) RH_HomeBtnView *youfeiView;

@property (nonatomic, weak) RH_HomeBtnView *luntaiView;

@property (nonatomic, weak) RH_HomeBtnView *baoyangView;

@property (nonatomic, weak) RH_HomeBtnView *xiuliView;

@property (nonatomic, weak) RH_HomeBtnView *baoxianView;

@property (nonatomic, weak) RH_HomeBtnView *shenghuoView;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, copy) dispatch_block_t detailBlock;

@end
