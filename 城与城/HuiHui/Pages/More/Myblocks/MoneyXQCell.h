//
//  MoneyXQCell.h
//  HuiHui
//
//  Created by mac on 2016/12/5.
//  Copyright © 2016年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoneyXQCell : UITableViewCell

+ (instancetype)MoneyXQCellWithTableview:(UITableView *)tableview;

@property (nonatomic, weak) UILabel *NOLab;

@property (nonatomic, weak) UILabel *timeLab;

@property (nonatomic, weak) UILabel *moneyLab;

@property (nonatomic, weak) UILabel *typeLab;

@property (nonatomic, weak) UILabel *statusLab;

@property (nonatomic, weak) UILabel *countLab;

@property (nonatomic, weak) UILabel *descLab;

@property (nonatomic, assign) CGFloat height;

@end
