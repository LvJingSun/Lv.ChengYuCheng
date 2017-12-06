//
//  FSB_ProfitCell.h
//  HuiHui
//
//  Created by mac on 2017/5/16.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FSB_ProfitFrame;

@interface FSB_ProfitCell : UITableViewCell

+ (instancetype)FSB_ProfitCellWithTableview:(UITableView *)tableview;

@property (nonatomic, strong) FSB_ProfitFrame *frameModel;

@end
