//
//  Car_DetailCell.h
//  HuiHui
//
//  Created by mac on 2017/6/15.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Car_DetailFrame;

@interface Car_DetailCell : UITableViewCell

+ (instancetype)Car_DetailCellWithTableview:(UITableView *)tableview;

@property (nonatomic, strong) Car_DetailFrame *frameModel;

@end
