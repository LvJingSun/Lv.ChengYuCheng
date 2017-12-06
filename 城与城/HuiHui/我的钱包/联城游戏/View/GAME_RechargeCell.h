//
//  GAME_RechargeCell.h
//  HuiHui
//
//  Created by mac on 2017/9/14.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GAME_RechargeFrame;

@protocol RechargeFieldDelegate <NSObject>

- (void)CountFieldChange:(UITextField *)field;

@end

@interface GAME_RechargeCell : UITableViewCell

+ (instancetype)GAME_RechargeCellWithTableview:(UITableView *)tableview;

@property (nonatomic, strong) GAME_RechargeFrame *frameModel;

@property (nonatomic, strong) id<RechargeFieldDelegate> delegate;

@property (nonatomic, copy) dispatch_block_t sureBlock;

@end
