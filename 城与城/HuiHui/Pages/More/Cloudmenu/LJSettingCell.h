//
//  LJSettingCell.h
//  HuiHui
//
//  Created by mac on 16/5/27.
//  Copyright © 2016年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LJSettingCell : UITableViewCell

+ (instancetype)LJSettingCellWithTableview:(UITableView *)tableview;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, weak) UILabel *titleLabel;

@property (nonatomic, weak) UISwitch *LJswitch;

@end
