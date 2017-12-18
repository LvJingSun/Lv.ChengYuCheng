//
//  HL_PromoterCell.h
//  HuiHui
//
//  Created by mac on 2017/12/18.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HL_PromoterFrame;

@interface HL_PromoterCell : UITableViewCell

+ (instancetype)HL_PromoterCellWithTableview:(UITableView *)tableview;

@property (nonatomic, strong) HL_PromoterFrame *frameModel;

@end
