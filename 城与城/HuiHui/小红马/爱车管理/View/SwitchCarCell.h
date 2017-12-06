//
//  SwitchCarCell.h
//  HuiHui
//
//  Created by mac on 2017/6/21.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  SwitchCarFrame;

@interface SwitchCarCell : UITableViewCell

+ (instancetype)SwitchCarCellWithTableview:(UITableView *)tableview;

@property (nonatomic, strong) SwitchCarFrame *frameModel;

@end
