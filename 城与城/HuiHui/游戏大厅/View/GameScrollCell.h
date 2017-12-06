//
//  GameScrollCell.h
//  HuiHui
//
//  Created by mac on 2017/5/17.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GameScrollFrame;

@protocol GameScrollDelegate <NSObject>

- (void)scrollImageClick:(NSInteger)pageNumber;

@end

@interface GameScrollCell : UITableViewCell

+ (instancetype)GameScrollCellWithTableview:(UITableView *)tableview;

@property (nonatomic, strong) GameScrollFrame *frameModel;

@property (nonnull, assign) id<GameScrollDelegate> delegate;

@end
