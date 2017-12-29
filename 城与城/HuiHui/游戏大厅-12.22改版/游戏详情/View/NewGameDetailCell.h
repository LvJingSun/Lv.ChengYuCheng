//
//  NewGameDetailCell.h
//  HuiHui
//
//  Created by mac on 2017/12/25.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NewGameDetailFrame;

@interface NewGameDetailCell : UITableViewCell

+ (instancetype)NewGameDetailCellWithTableview:(UITableView *)tableview;

@property (nonatomic, strong) NewGameDetailFrame *frameModel;

@property (nonatomic, copy) dispatch_block_t reloadBlock;

@property (nonatomic, copy) dispatch_block_t rechargeBlock;

@property (nonatomic, copy) dispatch_block_t sendBlock;

@property (nonatomic, copy) dispatch_block_t bindBlock;

@property (nonatomic, copy) dispatch_block_t tiyanBlock;

@end
