//
//  FlightsOrderCell.h
//  HuiHui
//
//  Created by mac on 14-12-29.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//  填写机票订单的cell

#import <UIKit/UIKit.h>

@interface FlightsOrderCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *m_btn;

@property (weak, nonatomic) IBOutlet UIButton *m_clickBtn;

@property (weak, nonatomic) IBOutlet UIImageView *m_imgV;

@property (weak, nonatomic) IBOutlet UILabel *m_countLabel;

@end

@interface FlightsContactCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextField *m_contactTextField;

@property (weak, nonatomic) IBOutlet UIButton *m_addBtn;

@property (weak, nonatomic) IBOutlet UIImageView *m_imgV;


@end

@interface FlightsPhoneCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextField *m_phoneTextField;

@property (weak, nonatomic) IBOutlet UIImageView *m_imgV;



@end


@interface FlightsIdCardCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *m_imgV;

@property (weak, nonatomic) IBOutlet UIButton *m_deleteBtn;

@property (weak, nonatomic) IBOutlet UILabel *m_nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_idCard;


@end