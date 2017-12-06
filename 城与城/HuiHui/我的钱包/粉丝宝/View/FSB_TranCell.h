//
//  FSB_TranCell.h
//  HuiHui
//
//  Created by mac on 2017/9/12.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FSB_TranFrame;

@interface FSB_TranCell : UITableViewCell

+ (instancetype)FSB_TranCellWithTableview:(UITableView *)tableview;

@property (nonatomic, strong) FSB_TranFrame *frameModel;

@end
