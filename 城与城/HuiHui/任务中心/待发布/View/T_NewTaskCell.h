//
//  T_NewTaskCell.h
//  HuiHui
//
//  Created by mac on 2017/3/23.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class T_NewTaskFrame;

@interface T_NewTaskCell : UITableViewCell

+ (instancetype)T_NewTaskCellWithTableview:(UITableView *)tableview;

@property (nonatomic, strong) T_NewTaskFrame *frameModel;

@end
