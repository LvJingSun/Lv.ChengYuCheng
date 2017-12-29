//
//  GameCenterGameArrayCell.h
//  HuiHui
//
//  Created by mac on 2017/12/22.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GameCenterGameArrayFrame;

@interface GameCenterGameArrayCell : UITableViewCell

+ (instancetype)GameCenterGameArrayCellWithTableview:(UITableView *)tableview;

@property (nonatomic, strong) GameCenterGameArrayFrame *frameModel;

@property (nonatomic, copy) dispatch_block_t game1Block;

@property (nonatomic, copy) dispatch_block_t game2Block;

@property (nonatomic, copy) dispatch_block_t game3Block;

@property (nonatomic, copy) dispatch_block_t game4Block;

@property (nonatomic, copy) dispatch_block_t game5Block;

@property (nonatomic, copy) dispatch_block_t game6Block;

@end
