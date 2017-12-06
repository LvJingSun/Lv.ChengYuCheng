//
//  AddFriend_ChooseCell.h
//  HuiHui
//
//  Created by mac on 2017/3/30.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddFriend_ChooseCell : UITableViewCell

+ (instancetype)AddFriend_ChooseCellWithTableview:(UITableView *)tableview;

@property (nonatomic, weak) UIImageView *iconImageview;

@property (nonatomic, weak) UILabel *titleLab;

@property (nonatomic, assign) CGFloat height;

@end
