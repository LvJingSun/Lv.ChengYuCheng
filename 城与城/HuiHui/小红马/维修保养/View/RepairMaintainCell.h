//
//  RepairMaintainCell.h
//  HuiHui
//
//  Created by mac on 2017/6/7.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RepairMaintainFrame;

@interface RepairMaintainCell : UITableViewCell

+ (instancetype)RepairMaintainCellWithTableview:(UITableView *)tableview;

@property (nonatomic, strong) RepairMaintainFrame *frameModel;

@end
