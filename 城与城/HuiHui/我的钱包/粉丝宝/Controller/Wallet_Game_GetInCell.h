//
//  Wallet_Game_GetInCell.h
//  HuiHui
//
//  Created by mac on 2017/9/22.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GameBtnCellFrame;

@protocol GameBtnCellDelegate <NSObject>

- (void)GameBtnClick:(UIButton *)sender;

@end

@interface Wallet_Game_GetInCell : UITableViewCell

+ (instancetype)Wallet_Game_GetInCellWithTableview:(UITableView *)tableview;

@property (nonatomic, strong) GameBtnCellFrame *frameModel;

@property (nonatomic, strong) id<GameBtnCellDelegate> delegate;

@end
