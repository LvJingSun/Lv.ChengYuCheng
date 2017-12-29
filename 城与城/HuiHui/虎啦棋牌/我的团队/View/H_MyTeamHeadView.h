//
//  H_MyTeamHeadView.h
//  HuiHui
//
//  Created by mac on 2017/12/27.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class H_MyTeamCountView;

@interface H_MyTeamHeadView : UIView

@property (nonatomic, weak) H_MyTeamCountView *oneView;

@property (nonatomic, weak) H_MyTeamCountView *twoView;

@property (nonatomic, weak) H_MyTeamCountView *threeView;

@property (nonatomic, weak) H_MyTeamCountView *fourView;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, copy) dispatch_block_t oneBlock;

@property (nonatomic, copy) dispatch_block_t twoBlock;

@property (nonatomic, copy) dispatch_block_t threeBlock;

@property (nonatomic, copy) dispatch_block_t fourBlock;

@end
