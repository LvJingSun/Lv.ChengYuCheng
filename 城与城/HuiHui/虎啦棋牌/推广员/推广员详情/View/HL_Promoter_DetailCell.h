//
//  HL_Promoter_DetailCell.h
//  HuiHui
//
//  Created by mac on 2017/12/18.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HL_Promoter_DetailFrame;

@interface HL_Promoter_DetailCell : UITableViewCell

+ (instancetype)HL_Promoter_DetailCellWithTableview:(UITableView *)tableview;

@property (nonatomic, strong) HL_Promoter_DetailFrame *frameModel;

@end
