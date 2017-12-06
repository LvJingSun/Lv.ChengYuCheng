//
//  MenuSettingTableViewCell.h
//  HuiHui
//
//  Created by fenghq on 15/9/16.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuSettingTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel   *m_titleLabel;

@property (weak, nonatomic) IBOutlet UISwitch *m_switcher;

@property (weak, nonatomic) IBOutlet UIImageView *m_imglin;


@end

@interface MenuSettingTableViewCell1: UITableViewCell

@property (weak, nonatomic) IBOutlet UITextField *m_total;

@property (weak, nonatomic) IBOutlet UITextField *m_jian;

@end

@interface MenuSettingTableViewCell2 : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextView *m_TejiaTextview;

@end

@interface MenuSettingTableViewCell3 : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *PsMinutes;
@property (weak, nonatomic) IBOutlet UITextField *PsPrice;
@property (weak, nonatomic) IBOutlet UITextField *QsPrice;

@end
@interface MenuSettingTableViewCell4 : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *FirstBuyYHPrice;

@end
@interface MenuSettingTableViewCell5 : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *ManPrice;
@property (weak, nonatomic) IBOutlet UITextField *ZengPin;

@end
@interface MenuSettingTableViewCell6 : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *PsPrice;

@end