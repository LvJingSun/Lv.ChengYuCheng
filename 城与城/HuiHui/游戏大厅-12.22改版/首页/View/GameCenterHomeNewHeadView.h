//
//  GameCenterHomeNewHeadView.h
//  HuiHui
//
//  Created by mac on 2017/12/22.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameCenterHomeNewHeadView : UIView

@property (nonatomic, copy) NSString *count;

@property (nonatomic, copy) dispatch_block_t RecordBlock; //记录block

@property (nonatomic, copy) dispatch_block_t RechargeBlock; //充值block

@property (nonatomic, copy) dispatch_block_t MyInfoBlock; //我的资料block

@property (nonatomic, copy) dispatch_block_t MyTeamBlock; //我的团队block

@property (nonatomic, copy) dispatch_block_t MyInvitationBlock; //我的邀请block

@property (nonatomic, copy) dispatch_block_t MyCommissionBlock; //我的佣金block

@property (nonatomic, assign) CGFloat height;

@end
