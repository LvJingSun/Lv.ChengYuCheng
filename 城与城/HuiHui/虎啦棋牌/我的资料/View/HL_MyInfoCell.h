//
//  HL_MyInfoCell.h
//  HuiHui
//
//  Created by mac on 2017/12/7.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HL_MyInfoFrame;

@interface HL_MyInfoCell : UITableViewCell

+ (instancetype)HL_MyInfoCellWithTableview:(UITableView *)tableview;

@property (nonatomic, strong) HL_MyInfoFrame *frameModel;

@end
