//
//  GoldTranCell.h
//  HuiHui
//
//  Created by mac on 2017/9/11.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GoldTranFrame;

@interface GoldTranCell : UITableViewCell

+ (instancetype)GoldTranCellWithTableview:(UITableView *)tableview;

@property (nonatomic, strong) GoldTranFrame *frameModel;

@end
