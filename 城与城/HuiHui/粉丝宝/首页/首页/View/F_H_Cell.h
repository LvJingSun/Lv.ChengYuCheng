//
//  F_H_Cell.h
//  HuiHui
//
//  Created by mac on 2017/6/26.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class F_H_CellFrame;

@interface F_H_Cell : UITableViewCell

+ (instancetype)F_H_CellWithTableview:(UITableView *)tableview;

@property (nonatomic, strong) F_H_CellFrame *frameModel;

@property (nonatomic, copy) dispatch_block_t getMoneyBlock;

@property (nonatomic, copy) dispatch_block_t adImgBlock;

@property (nonatomic, copy) dispatch_block_t shopIconBlock;

@end
