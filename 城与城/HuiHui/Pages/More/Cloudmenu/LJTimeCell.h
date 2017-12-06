//
//  LJTimeCell.h
//  HuiHui
//
//  Created by mac on 16/5/30.
//  Copyright © 2016年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LJTimeCell : UITableViewCell

+ (instancetype)LJTimeCellWithTableView:(UITableView *)tableview;

@property (nonatomic, weak) UILabel *title;

@property (nonatomic, weak) UITextField *timeField;

@end
