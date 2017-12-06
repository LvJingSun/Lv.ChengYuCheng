//
//  T_Detail2Cell.h
//  HuiHui
//
//  Created by mac on 2017/3/22.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class T_Detail2Frame;

@interface T_Detail2Cell : UITableViewCell

+ (instancetype)T_Detail2CellWithTableview:(UITableView *)tableview;

@property (nonatomic, strong) T_Detail2Frame *frameModel;

@end
