//
//  flightsOrderListCell.h
//  HuiHui
//
//  Created by mac on 15-1-7.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//  机票订单的cell

#import <UIKit/UIKit.h>

@interface flightsOrderListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *m_cityName;
@property (weak, nonatomic) IBOutlet UILabel *m_dptTime;
@property (weak, nonatomic) IBOutlet UILabel *m_airPort;
@property (weak, nonatomic) IBOutlet UILabel *m_flightsNum;
@property (weak, nonatomic) IBOutlet UILabel *m_price;
@property (weak, nonatomic) IBOutlet UILabel *m_status;

@end


@interface flightsOrderPriceCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *m_price;

@property (weak, nonatomic) IBOutlet UILabel *m_orderNo;

@property (weak, nonatomic) IBOutlet UIImageView *m_imageV;

@end


@interface flightsOrderRideCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *m_name;

@property (weak, nonatomic) IBOutlet UILabel *m_birthDay;

@property (weak, nonatomic) IBOutlet UILabel *m_cardType;

@property (weak, nonatomic) IBOutlet UILabel *m_cardId;

@property (weak, nonatomic) IBOutlet UIImageView *m_imageV;

@end


@interface flightsOrderContactCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *m_imageV;

@property (weak, nonatomic) IBOutlet UILabel *m_phone;


@end