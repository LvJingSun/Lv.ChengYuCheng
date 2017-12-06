//
//  RH_HomePersonHeadView.h
//  HuiHui
//
//  Created by mac on 2017/6/8.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RH_HomeBtnView;

//@protocol RH_HomeBtnView_EditDelegate <NSObject>
//
//- (void)RH_HomeBtnViewEditClick;
//
//@end

@interface RH_HomePersonHeadView : UIView

//@property (nonatomic, copy) id<RH_HomeBtnView_EditDelegate> delegate;

@property (nonatomic, weak) UIImageView *iconImg;

@property (nonatomic, weak) UILabel *editLab;

@property (nonatomic, weak) UIImageView *editImg;

@property (nonatomic, weak) UIButton *editBtn;

@property (nonatomic, weak) UILabel *modelTitleLab;

@property (nonatomic, weak) UILabel *modelLab;

@property (nonatomic, weak) UILabel *mileageTitleLab;

@property (nonatomic, weak) UILabel *mileageLab;

@property (nonatomic, weak) UILabel *timeTitleLab;

@property (nonatomic, weak) UILabel *timeLab;

@property (nonatomic, weak) UILabel *countTitleLab;

@property (nonatomic, weak) UILabel *countLab;

@property (nonatomic, weak) RH_HomeBtnView *youfeiView;

@property (nonatomic, weak) RH_HomeBtnView *luntaiView;

@property (nonatomic, weak) RH_HomeBtnView *baoyangView;

@property (nonatomic, weak) RH_HomeBtnView *xiuliView;

@property (nonatomic, weak) RH_HomeBtnView *baoxianView;

@property (nonatomic, weak) RH_HomeBtnView *shenghuoView;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, copy) dispatch_block_t EditBlock;

@end
