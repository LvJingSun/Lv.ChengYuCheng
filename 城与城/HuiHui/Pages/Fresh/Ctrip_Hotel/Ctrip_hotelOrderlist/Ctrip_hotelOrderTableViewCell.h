//
//  Ctrip_hotelOrderTableViewCell.h
//  HuiHui
//
//  Created by 冯海强 on 15-1-8.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageCache.h"
#import "UIImageView+AFNetworking.h"

@interface Ctrip_hotelOrderTableViewCell : UITableViewCell
{
    ImageCache *imagechage;
}

@property (nonatomic ,weak) IBOutlet UILabel *HotelName;
@property (nonatomic ,weak) IBOutlet UILabel *RoomName;
@property (nonatomic ,weak) IBOutlet UILabel *TimeName;
@property (nonatomic ,weak) IBOutlet UIImageView *PhotoIMG;

-(void)setCtrip_hotelImage:(NSString *)imagepath;

@end
