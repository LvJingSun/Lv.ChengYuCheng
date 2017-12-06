//
//  CtriphotellistCell.h
//  HuiHui
//
//  Created by 冯海强 on 14-9-16.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ImageCache.h"

#import "UIImageView+AFNetworking.h"

@interface CtriphotellistCell : UITableViewCell
{
    ImageCache *imagechage;
}


@property (weak, nonatomic) IBOutlet UIImageView *hotel_imageview;

@property (weak, nonatomic) IBOutlet UILabel *hotel_name;

@property (weak, nonatomic) IBOutlet UILabel *hotel_score;//4.9

@property (weak, nonatomic) IBOutlet UILabel *hotel_pice;//99元起

@property (weak, nonatomic) IBOutlet UILabel *hotel_type;//三星级酒店

@property (weak, nonatomic) IBOutlet UILabel *hotel_area;//苏州新区

@property (weak, nonatomic) IBOutlet UILabel *hotel_distance;//距离 ，多少米


-(void)setCtrip_hotelImage:(NSString *)imagepath;

@end
