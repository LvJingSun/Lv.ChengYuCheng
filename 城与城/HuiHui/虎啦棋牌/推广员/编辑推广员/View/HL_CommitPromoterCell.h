//
//  HL_CommitPromoterCell.h
//  HuiHui
//
//  Created by mac on 2017/12/19.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HL_CommitPromoterFrame;

@interface HL_CommitPromoterCell : UITableViewCell

+ (instancetype)HL_CommitPromoterCellWithTableview:(UITableView *)tableview;

@property (nonatomic, strong) HL_CommitPromoterFrame *frameModel;

@end
