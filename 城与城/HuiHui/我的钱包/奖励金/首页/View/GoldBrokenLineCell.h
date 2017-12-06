//
//  GoldBrokenLineCell.h
//  HuiHui
//
//  Created by mac on 2017/9/11.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GoldBrokenLineFrame;

@interface GoldBrokenLineCell : UITableViewCell

+ (instancetype)GoldBrokenLineCellWithTableview:(UITableView *)tableview;

@property (nonatomic, strong) GoldBrokenLineFrame *frameModel;

@end
