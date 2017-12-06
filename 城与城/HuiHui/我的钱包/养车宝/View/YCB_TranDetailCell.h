//
//  YCB_TranDetailCell.h
//  HuiHui
//
//  Created by mac on 2017/9/14.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YCB_TranDetailFrame;

@interface YCB_TranDetailCell : UITableViewCell

+ (instancetype)YCB_TranDetailCellWithTableview:(UITableView *)tableview;

@property (nonatomic, strong) YCB_TranDetailFrame *frameModel;

@end
