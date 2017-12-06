//
//  CustomerserviceListTableViewCell.h
//  HuiHui
//
//  Created by fenghq on 15/9/17.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomerserviceListTableViewCell : UITableViewCell

@property(nonatomic,weak)IBOutlet UILabel *Name;
@property(nonatomic,weak)IBOutlet UILabel *Phone;
@property(nonatomic,weak)IBOutlet UILabel *Status;
@property(nonatomic,weak)IBOutlet UIImageView *ImageV;

@end
