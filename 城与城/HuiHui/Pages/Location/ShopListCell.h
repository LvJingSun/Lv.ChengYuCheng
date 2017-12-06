//
//  ShopListCell.h
//  HuiHui
//
//  Created by mac on 13-11-25.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *m_nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_addressLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_timeLable;

@property (weak, nonatomic) IBOutlet UILabel *m_phoneLabel;

@property (weak, nonatomic) IBOutlet UIButton *m_addressBtn;

@property (weak, nonatomic) IBOutlet UIButton *m_phoneBtn;


@end
