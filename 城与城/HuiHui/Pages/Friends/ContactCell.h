//
//  ContactCell.h
//  HuiHui
//
//  Created by mac on 13-12-3.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ImageCache.h"

@interface ContactCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *m_nameLabel;

@property (weak, nonatomic) IBOutlet UIButton *m_addBtn;

@property (weak, nonatomic) IBOutlet UIButton *m_inviteBtn;

@property (weak, nonatomic) IBOutlet UILabel *m_inviteLabel;

@end


@interface UserDetailsCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *m_titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_subLabel;

@property (weak, nonatomic) IBOutlet UIImageView *m_rightImgv;

@end
