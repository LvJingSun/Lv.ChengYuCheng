//
//  GameTranCell.h
//  HuiHui
//
//  Created by mac on 2017/12/7.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GameTranFrame;

@interface GameTranCell : UITableViewCell

+ (instancetype)GameTranCellWithTableview:(UITableView *)tableview;

@property (nonatomic, strong) GameTranFrame *frameModel;

@end
