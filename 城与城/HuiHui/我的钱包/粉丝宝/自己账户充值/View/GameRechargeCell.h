//
//  GameRechargeCell.h
//  HuiHui
//
//  Created by mac on 2017/10/27.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GameRechargeFrame;

@protocol GameRechargeDelegate <NSObject>

- (void)IDFieldChange:(UITextField *)field;

- (void)CountFieldChange:(UITextField *)field;

@end

@interface GameRechargeCell : UITableViewCell

+ (instancetype)GameRechargeCellWithTableview:(UITableView *)tableview;

@property (nonatomic, weak) UITextField *qipaiIDField;

@property (nonatomic, weak) UILabel *noticeLab;

@property (nonatomic, weak) UILabel *nickLab;

@property (nonatomic, strong) GameRechargeFrame *frameModel;

@property (nonatomic, strong) id<GameRechargeDelegate> delegate;

@property (nonatomic, copy) dispatch_block_t sureBlock;

@property (nonatomic, copy) dispatch_block_t noticeBlock;

//@property (nonatomic, copy) dispatch_block_t ybBlock;
//
//@property (nonatomic, copy) dispatch_block_t fkBlock;

@end
