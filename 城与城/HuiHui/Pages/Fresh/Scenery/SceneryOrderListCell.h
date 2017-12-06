//
//  SceneryOrderListCell.h
//  HuiHui
//
//  Created by mac on 15-1-30.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SceneryOrderListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *m_sceneryName;

@property (weak, nonatomic) IBOutlet UILabel *m_outDate;

@property (weak, nonatomic) IBOutlet UILabel *m_orderDate;

@property (weak, nonatomic) IBOutlet UILabel *m_price;

@property (weak, nonatomic) IBOutlet UILabel *m_orderStatus;

@property (weak, nonatomic) IBOutlet UILabel *m_fanli;

@end

@interface ScenerySureOrderCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *m_sceneryName;

@property (weak, nonatomic) IBOutlet UILabel *m_price;

@property (weak, nonatomic) IBOutlet UILabel *m_orderNum;

@property (weak, nonatomic) IBOutlet UILabel *m_date;

@property (weak, nonatomic) IBOutlet UILabel *m_style;

@property (weak, nonatomic) IBOutlet UILabel *m_count;

@property (weak, nonatomic) IBOutlet UILabel *m_fanliPrice;

@end

@interface ScenerySureTravellerCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *m_travellerName;

@property (weak, nonatomic) IBOutlet UILabel *m_phone;

@end
