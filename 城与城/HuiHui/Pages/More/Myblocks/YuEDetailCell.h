//
//  YuEDetailCell.h
//  HuiHui
//
//  Created by mac on 2016/11/7.
//  Copyright © 2016年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YuEDetailCell : UITableViewCell

+ (instancetype)YuEDetailCellWithTableview:(UITableView *)tableview;

@property (nonatomic, weak) UILabel *typeLab;

@property (nonatomic, weak) UILabel *countLab;

@property (nonatomic, weak) UILabel *timeLab;

@property (nonatomic, assign) CGFloat height;

@end
