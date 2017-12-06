//
//  MenuOrderListTableViewCell.h
//  HuiHui
//
//  Created by mac on 15-10-17.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuOrderListTableViewCell : UITableViewCell

@property (nonatomic,weak) IBOutlet UILabel *NickName;
@property (nonatomic,weak) IBOutlet UILabel *Account;
@property (nonatomic,weak) IBOutlet UILabel *CreateDate;
@property (nonatomic,weak) IBOutlet UILabel *CloudMenuPerson;
@property (nonatomic,weak) IBOutlet UILabel *OrderNumber;
@property (nonatomic,weak) IBOutlet UILabel *Status;
@property (nonatomic,weak) IBOutlet UILabel *PriceAmount;

@end
@interface MenuOrderListTableViewCell1 : UITableViewCell

@property (nonatomic,weak) IBOutlet UILabel *NickName;
@property (nonatomic,weak) IBOutlet UILabel *Account;
@property (nonatomic,weak) IBOutlet UILabel *CreateDate;
@property (nonatomic,weak) IBOutlet UILabel *PeiSongTime;
@property (nonatomic,weak) IBOutlet UILabel *OrderNumber;
@property (nonatomic,weak) IBOutlet UILabel *Status;
@property (nonatomic,weak) IBOutlet UILabel *PriceAmount;
@property (nonatomic,weak) IBOutlet UILabel *Address;

@end
@interface MenuOrderListTableViewCell2 : UITableViewCell

@property (nonatomic,weak) IBOutlet UILabel *NickName;
@property (nonatomic,weak) IBOutlet UILabel *Account;
@property (nonatomic,weak) IBOutlet UILabel *CreateDate;
@property (nonatomic,weak) IBOutlet UILabel *PriceAmount;
@property (nonatomic,weak) IBOutlet UILabel *OrderNumber;
@property (nonatomic,weak) IBOutlet UILabel *Status;
@property (nonatomic,weak) IBOutlet UILabel *Address;

@end