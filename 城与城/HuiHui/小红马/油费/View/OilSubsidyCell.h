//
//  OilSubsidyCell.h
//  HuiHui
//
//  Created by mac on 2017/6/7.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OilSubsidyFrame;

@interface OilSubsidyCell : UITableViewCell

+ (instancetype)OilSubsidyCellWithTableview:(UITableView *)tableview;

@property (nonatomic, strong) OilSubsidyFrame *frameModel;

@end
