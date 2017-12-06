//
//  AddressListCell.h
//  HuiHui
//
//  Created by mac on 15-2-15.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddressListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *m_name;

@property (weak, nonatomic) IBOutlet UILabel *m_phone;

@property (weak, nonatomic) IBOutlet UILabel *m_address;

@property (weak, nonatomic) IBOutlet UIImageView *m_line;

@end

@interface AddressDetailCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *m_name;

@property (weak, nonatomic) IBOutlet UILabel *m_phone;

@property (weak, nonatomic) IBOutlet UILabel *m_code;

@property (weak, nonatomic) IBOutlet UILabel *m_province;

@property (weak, nonatomic) IBOutlet UILabel *m_street;

@property (weak, nonatomic) IBOutlet UILabel *m_area;



@end

@interface AddressDeleteCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *m_deleteBtn;

@property (weak, nonatomic) IBOutlet UIButton *m_defaultBtn;



@end


@interface ChooseAddressCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *m_name;

@property (weak, nonatomic) IBOutlet UILabel *m_phone;

@property (weak, nonatomic) IBOutlet UILabel *m_address;

@property (weak, nonatomic) IBOutlet UIImageView *m_line;

@property (weak, nonatomic) IBOutlet UIImageView *m_gouxuanImagV;


@end