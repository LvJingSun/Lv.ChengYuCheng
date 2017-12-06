//
//  TongchenghotelorderTableViewCell.h
//  HuiHui
//
//  Created by 冯海强 on 15-3-19.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TongchenghotelorderTableViewCell : UITableViewCell

@property (nonatomic ,weak) IBOutlet UILabel *HotelName;
@property (nonatomic ,weak) IBOutlet UILabel *RoomName;
@property (nonatomic ,weak) IBOutlet UILabel *roomCount;
@property (nonatomic ,weak) IBOutlet UILabel *TimeName;
@property (nonatomic ,weak) IBOutlet UILabel *payAmount;
@property (nonatomic ,weak) IBOutlet UILabel *orderStatus;

@end
