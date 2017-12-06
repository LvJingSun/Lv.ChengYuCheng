//
//  RH_CarBrandCell.h
//  HuiHui
//
//  Created by mac on 2017/6/14.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RH_CarBrandFrame;

@interface RH_CarBrandCell : UITableViewCell

+ (instancetype)RH_CarBrandCellWithTableview:(UITableView *)tableview;

@property (nonatomic, strong) RH_CarBrandFrame *frameModel;

@end
