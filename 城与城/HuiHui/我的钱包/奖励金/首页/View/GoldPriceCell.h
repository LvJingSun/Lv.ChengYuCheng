//
//  GoldPriceCell.h
//  HuiHui
//
//  Created by mac on 2017/9/1.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GoldPriceFrame;

@interface GoldPriceCell : UITableViewCell

+ (instancetype)GoldPriceCellWithTableview:(UITableView *)tableview;

@property (nonatomic, strong) GoldPriceFrame *frameModel;

@end
