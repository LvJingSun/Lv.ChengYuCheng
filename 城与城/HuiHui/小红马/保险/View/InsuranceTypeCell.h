//
//  InsuranceTypeCell.h
//  HuiHui
//
//  Created by mac on 2017/6/27.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class InsuranceTypeFrame;

@interface InsuranceTypeCell : UITableViewCell

+ (instancetype)InsuranceTypeCellWithTableview:(UITableView *)tableview;

@property (nonatomic, strong) InsuranceTypeFrame *frameModel;

@end
