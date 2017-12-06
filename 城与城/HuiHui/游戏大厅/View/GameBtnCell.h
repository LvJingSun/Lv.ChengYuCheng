//
//  GameBtnCell.h
//  HuiHui
//
//  Created by mac on 2017/5/18.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GameBtnCellFrame;

@protocol GameBtnCellDelegate <NSObject>

- (void)GameBtnClick:(UIButton *)sender;

@end

@interface GameBtnCell : UITableViewCell

+ (instancetype)GameBtnCellWithTableview:(UITableView *)tableview;

@property (nonatomic, strong) GameBtnCellFrame *frameModel;

@property (nonatomic, strong) id<GameBtnCellDelegate> delegate;

@end
