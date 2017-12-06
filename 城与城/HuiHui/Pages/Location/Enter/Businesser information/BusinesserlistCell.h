//
//  BusinesserlistCell.h
//  Receive
//
//  Created by 冯海强 on 13-12-25.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BusinesserlistCell : UITableViewCell


@property(nonatomic,weak)IBOutlet UILabel *BL_Name;

@property(nonatomic,weak)IBOutlet UILabel *BL_faren;//法人手机名字

@property(nonatomic,weak)IBOutlet UILabel *BL_states;//状态

@property(nonatomic,weak)IBOutlet UILabel *BL_Data;//日期

@end
