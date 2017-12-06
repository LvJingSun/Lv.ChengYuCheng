//
//  FSB_QuotaCell.h
//  HuiHui
//
//  Created by mac on 2017/5/16.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FSB_QuotaFrame;

@interface FSB_QuotaCell : UITableViewCell

+ (instancetype)FSB_QuotaCellWithTableview:(UITableView *)tableview;

@property (nonatomic, strong) FSB_QuotaFrame *frameModel;

@end
