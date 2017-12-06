//
//  T_Detail1Cell.h
//  HuiHui
//
//  Created by mac on 2017/3/22.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class T_Detail1Frame;

@interface T_Detail1Cell : UITableViewCell

+ (instancetype)T_Detail1CellWithTableview:(UITableView *)tableview;

@property (nonatomic, strong) T_Detail1Frame *frameModel;

@end
