//
//  Add_ContactCell.h
//  HuiHui
//
//  Created by mac on 2017/3/31.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Add_ContactFrame;

@interface Add_ContactCell : UITableViewCell

+ (instancetype)Add_ContactCellWithTableview:(UITableView *)tableview;

@property (nonatomic, strong) Add_ContactFrame *frameModel;

@end
