//
//  FSB_TranDetailCell.h
//  HuiHui
//
//  Created by mac on 2017/9/14.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FSB_TranDetailFrame;

@interface FSB_TranDetailCell : UITableViewCell

+ (instancetype)FSB_TranDetailCellWithTableview:(UITableView *)tableview;

@property (nonatomic, strong) FSB_TranDetailFrame *frameModel;

@end
