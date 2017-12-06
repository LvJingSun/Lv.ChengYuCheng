//
//  RH_InsListCell.h
//  HuiHui
//
//  Created by mac on 2017/6/26.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RH_InsListFrame;

@interface RH_InsListCell : UITableViewCell

+ (instancetype)RH_InsListCellWithTableview:(UITableView *)tableview;

@property (nonatomic, strong) RH_InsListFrame *frameModel;

@end
