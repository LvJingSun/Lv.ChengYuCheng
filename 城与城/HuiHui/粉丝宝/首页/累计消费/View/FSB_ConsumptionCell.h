//
//  FSB_ConsumptionCell.h
//  HuiHui
//
//  Created by mac on 2017/5/16.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FSB_ConsumptionFrame;

@interface FSB_ConsumptionCell : UITableViewCell

+ (instancetype)FSB_ConsumptionCellWithTableview:(UITableView *)tableview;

@property (nonatomic, strong) FSB_ConsumptionFrame *frameModel;

@end
