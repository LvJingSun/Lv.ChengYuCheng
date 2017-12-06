//
//  GoldPriceRecordCell.h
//  HuiHui
//
//  Created by mac on 2017/9/15.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GoldPriceRecordFrame;

@interface GoldPriceRecordCell : UITableViewCell

+ (instancetype)GoldPriceRecordCellWithTableview:(UITableView *)tableview;

@property (nonatomic, strong) GoldPriceRecordFrame *frameModel;

@end
