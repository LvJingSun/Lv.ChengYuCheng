//
//  Ctrip_hotelPOTableViewCell.h
//  HuiHui
//
//  Created by 冯海强 on 15-1-4.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Ctrip_hotelPOTableViewCell : UITableViewCell

@property (nonatomic ,weak) IBOutlet UILabel *title;
@property (nonatomic ,weak) IBOutlet UILabel *detail;
@property (nonatomic ,weak) IBOutlet UIImageView *detailRight;

@end

@interface Ctrip_hotelPOTableViewCell1 : UITableViewCell
@property (nonatomic ,weak) IBOutlet UILabel *title;
@property (nonatomic ,weak) IBOutlet UITextField *detail;
@property (nonatomic ,weak) IBOutlet UIImageView *titleIMG;
@property (nonatomic ,weak) IBOutlet UIButton *titleBtn;

@property (nonatomic ,weak) IBOutlet UIView *titleView;//

@end

@interface Ctrip_hotelPOTableViewCell2 : UITableViewCell
@property (nonatomic ,weak) IBOutlet UILabel *title;
@property (nonatomic ,weak) IBOutlet UITextField *detail;

@end

@interface Ctrip_hotelPOTableViewCell3 : UITableViewCell

@property (nonatomic ,weak) IBOutlet UILabel *title;
@property (nonatomic ,weak) IBOutlet UILabel *title2;


@end
