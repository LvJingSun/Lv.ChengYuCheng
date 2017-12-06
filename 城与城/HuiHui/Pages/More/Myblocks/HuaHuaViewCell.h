//
//  HuaHuaViewCell.h
//  HuiHui
//
//  Created by mac on 16/7/31.
//  Copyright © 2016年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HuaHuaViewCell : UITableViewCell

+ (instancetype)HuaHuaViewCellWithTableview:(UITableView *)tableview;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, weak) UILabel *countLab;

@property (nonatomic, weak) UILabel *nameLab;

@property (nonatomic, weak) UILabel *timeLab;

@end
