//
//  T_CommissionCell.h
//  HuiHui
//
//  Created by mac on 2017/3/28.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class T_CommissionFrame;

@interface T_CommissionCell : UITableViewCell

+ (instancetype)T_CommissionCellWithTableview:(UITableView *)tableview;

@property (nonatomic, strong) T_CommissionFrame *frameModel;

@end
