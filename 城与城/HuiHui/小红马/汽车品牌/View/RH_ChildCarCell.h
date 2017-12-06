//
//  RH_ChildCarCell.h
//  HuiHui
//
//  Created by mac on 2017/6/14.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RH_ChildCarFrame;

@interface RH_ChildCarCell : UITableViewCell

+ (instancetype)RH_ChildCarCellWithTableview:(UITableView *)tableview;

@property (nonatomic, strong) RH_ChildCarFrame *frameModel;

@end
