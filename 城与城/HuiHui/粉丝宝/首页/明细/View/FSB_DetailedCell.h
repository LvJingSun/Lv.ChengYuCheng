//
//  FSB_DetailedCell.h
//  HuiHui
//
//  Created by mac on 2017/5/16.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FSB_DetailedFrame;

@interface FSB_DetailedCell : UITableViewCell

+ (instancetype)FSB_DetailedCellWithTableview:(UITableView *)tableview;

@property (nonatomic, strong) FSB_DetailedFrame *frameModel;

@property (nonatomic, copy) dispatch_block_t phoneBlock;

@end
