//
//  RH_FilpCell.h
//  HuiHui
//
//  Created by mac on 2017/6/6.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RH_FilpCellFrame;

@interface RH_FilpCell : UITableViewCell

@property (nonatomic, strong) RH_FilpCellFrame *frameModel;

+ (instancetype)RH_FilpCellWithTableview:(UITableView *)tableview;

@property (nonatomic, copy) dispatch_block_t flip1Block;

@property (nonatomic, copy) dispatch_block_t click1Block;

@property (nonatomic, copy) dispatch_block_t flip2Block;

@property (nonatomic, copy) dispatch_block_t click2Block;

@property (nonatomic, copy) dispatch_block_t flip3Block;

@property (nonatomic, copy) dispatch_block_t click3Block;

@property (nonatomic, copy) dispatch_block_t flip4Block;

@property (nonatomic, copy) dispatch_block_t click4Block;

@end
