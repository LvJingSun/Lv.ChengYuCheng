//
//  RH_Send_RecordCell.h
//  HuiHui
//
//  Created by mac on 2017/8/4.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RH_Send_RecordFrame;

@interface RH_Send_RecordCell : UITableViewCell

+ (instancetype)RH_Send_RecordCellWithTableview:(UITableView *)tableview;

@property (nonatomic, strong) RH_Send_RecordFrame *frameModel;

@end
