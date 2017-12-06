//
//  YCB_TranCell.h
//  HuiHui
//
//  Created by mac on 2017/9/12.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YCB_TranFrame;

@interface YCB_TranCell : UITableViewCell

+ (instancetype)YCB_TranCellWithTableview:(UITableView *)tableview;

@property (nonatomic, strong) YCB_TranFrame *frameModel;

@end
