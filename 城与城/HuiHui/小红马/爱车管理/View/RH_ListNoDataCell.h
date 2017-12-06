//
//  RH_ListNoDataCell.h
//  HuiHui
//
//  Created by mac on 2017/6/15.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RH_ListNoDataCell : UITableViewCell

+ (instancetype)RH_ListNoDataCellWithTableview:(UITableView *)tableview;

@property (nonatomic, copy) NSString *titleText;

@property (nonatomic, assign) CGFloat height;

@end
