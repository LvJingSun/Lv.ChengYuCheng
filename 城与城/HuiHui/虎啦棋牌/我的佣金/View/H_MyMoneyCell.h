//
//  H_MyMoneyCell.h
//  HuiHui
//
//  Created by mac on 2017/11/3.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class H_MyMoneyFrame;

@interface H_MyMoneyCell : UITableViewCell

+ (instancetype)H_MyMoneyCellWithTableview:(UITableView *)tableview;

@property (nonatomic, strong) H_MyMoneyFrame *frameModel;

@end
