//
//  SetYongjinCell.h
//  HuiHui
//
//  Created by mac on 16/5/27.
//  Copyright © 2016年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetYongjinCell : UITableViewCell<UITextFieldDelegate>

+ (instancetype)SetYongjinCellWithTableView:(UITableView *)tableview;

@property (nonatomic, weak) UILabel *levelNameLabel;

@property (nonatomic, weak) UITextField *countField;

@end
