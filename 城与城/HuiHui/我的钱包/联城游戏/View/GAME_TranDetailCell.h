//
//  GAME_TranDetailCell.h
//  HuiHui
//
//  Created by mac on 2017/9/14.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GAME_TranDetailFrame;

@interface GAME_TranDetailCell : UITableViewCell

+ (instancetype)GAME_TranDetailCellWithTableview:(UITableView *)tableview;

@property (nonatomic, strong) GAME_TranDetailFrame *frameModel;

@end
