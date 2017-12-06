//
//  RH_Get_RecordCell.h
//  HuiHui
//
//  Created by mac on 2017/8/4.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RH_Get_RecordFrame;

@interface RH_Get_RecordCell : UITableViewCell

+ (instancetype)RH_Get_RecordCellWithTableview:(UITableView *)tableview;

@property (nonatomic, strong) RH_Get_RecordFrame *frameModel;

@end
