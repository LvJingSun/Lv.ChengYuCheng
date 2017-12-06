//
//  MoreCell.h
//  HuiHui
//
//  Created by mac on 13-11-19.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoreCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *m_titleLabel;

@property (weak, nonatomic) IBOutlet UIImageView *m_imageView;

@property (weak, nonatomic) IBOutlet UIImageView *m_numImgV;


@end


@interface UserInfoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *m_imageView;

@property (weak, nonatomic) IBOutlet UILabel *m_nameLabel;

@property (weak, nonatomic) IBOutlet UIImageView *m_sexImgV;

@property (weak, nonatomic) IBOutlet UILabel *m_accountLabel;



@end


@interface MyBalanceCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *m_balanceLabel;

@property (weak, nonatomic) IBOutlet UIButton *m_RechargeBtn;

@property (weak, nonatomic) IBOutlet UIButton *m_payBtn;

@property (weak, nonatomic) IBOutlet UIImageView *m_imageView;



@end