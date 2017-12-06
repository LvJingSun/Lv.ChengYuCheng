//
//  R_PersonCell.h
//  HuiHui
//
//  Created by mac on 2017/11/16.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class R_PersonFrame;

@interface R_PersonCell : UITableViewCell

+ (instancetype)R_PersonCellWithTableview:(UITableView *)tableview;

@property (nonatomic, strong) R_PersonFrame *frameModel;

@end
