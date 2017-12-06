//
//  CtriphoteldetailCell.h
//  HuiHui
//
//  Created by 冯海强 on 14-9-16.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CtriphoteldetailCell0 : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *CPD_PhotoBtn;

@property (weak, nonatomic) IBOutlet UIImageView *CPD_PhotoIMG;

@property (weak, nonatomic) IBOutlet UILabel *hotel_HI;//一共几张图片

@property (weak, nonatomic) IBOutlet UILabel *hotel_name;

@property (weak, nonatomic) IBOutlet UILabel *hotel_type;

@property (weak, nonatomic) IBOutlet UILabel *hotel_secoreA;

@property (weak, nonatomic) IBOutlet UILabel *hotel_HP;//几个人评的

@property (weak, nonatomic) IBOutlet UILabel *hotel_secore1;

@property (weak, nonatomic) IBOutlet UILabel *hotel_secore2;

@property (weak, nonatomic) IBOutlet UILabel *hotel_secore3;

@property (weak, nonatomic) IBOutlet UILabel *hotel_secore4;

@property (weak, nonatomic) IBOutlet UIButton *hotel_PingjiaBtn;//评价按钮

@end



@interface CtriphoteldetailCell1 : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *hotel_address;


@end



@interface CtriphoteldetailCell2 : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *hotel_WhenBuild;

@end



@interface CtriphoteldetailCell3 : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *hotel_StartTimeANDendTime;

@end



@interface CtriphoteldetailCell4 : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *hotel_RoomTypeName;
@property (weak, nonatomic) IBOutlet UIImageView *hotel_ImgView;
@property (weak, nonatomic) IBOutlet UILabel *hotel_ListPrice;
@property (weak, nonatomic) IBOutlet UILabel *hotel_BreakFastBedTypeName;

@property (weak, nonatomic) IBOutlet UIButton *hotel_RoomPOBtn;
@property (weak, nonatomic) IBOutlet UIView *hotel_ActivingView;

@end

