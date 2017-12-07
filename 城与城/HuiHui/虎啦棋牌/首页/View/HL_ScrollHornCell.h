//
//  HL_ScrollHornCell.h
//  HuiHui
//
//  Created by mac on 2017/12/7.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HL_ScrollHornFrame;

@interface HL_ScrollHornCell : UITableViewCell

+ (instancetype)HL_ScrollHornCellWithTableview:(UITableView *)tableview;

@property (nonatomic, strong) HL_ScrollHornFrame *frameModel;

@end
