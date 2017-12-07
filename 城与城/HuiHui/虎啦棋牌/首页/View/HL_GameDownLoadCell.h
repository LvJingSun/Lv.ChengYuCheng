//
//  HL_GameDownLoadCell.h
//  HuiHui
//
//  Created by mac on 2017/12/7.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HL_GameDownLoadFrame;

@interface HL_GameDownLoadCell : UITableViewCell

+ (instancetype)HL_GameDownLoadCellWithTableivew:(UITableView *)tableview;

@property (nonatomic, strong) HL_GameDownLoadFrame *frameModel;

@property (nonatomic, copy) dispatch_block_t downloadBlock;

@end
