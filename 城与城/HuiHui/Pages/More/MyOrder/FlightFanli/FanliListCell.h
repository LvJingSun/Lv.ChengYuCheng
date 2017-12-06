//
//  FanliListCell.h
//  HuiHui
//
//  Created by mac on 15-3-31.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FanliListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *m_orderId;

@property (weak, nonatomic) IBOutlet UILabel *m_time;

@property (weak, nonatomic) IBOutlet UILabel *m_status;

@property (weak, nonatomic) IBOutlet UILabel *m_fanli;


@end
