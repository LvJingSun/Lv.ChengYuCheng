//
//  M_Record_Cell.h
//  HuiHui
//
//  Created by mac on 2017/10/12.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class M_Record_Frame;

@interface M_Record_Cell : UITableViewCell

+ (instancetype)M_Record_CellWithTableview:(UITableView *)tableview;

@property (nonatomic, strong) M_Record_Frame *frameModel;

@end
