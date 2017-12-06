//
//  GAME_TranCell.h
//  HuiHui
//
//  Created by mac on 2017/9/12.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GAME_TranFrame;

@interface GAME_TranCell : UITableViewCell

+ (instancetype)GAME_TranCellWithTableview:(UITableView *)tableview;

@property (nonatomic, strong) GAME_TranFrame *frameModel;

@end
