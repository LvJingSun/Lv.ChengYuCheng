//
//  HH_CustomMenuCell.h
//  HuiHui
//
//  Created by mac on 15-7-15.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HH_CustomMenuCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextField *m_textField;

@property (weak, nonatomic) IBOutlet UIButton *m_deleteBtn;

@end


@interface HH_CustomCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel   *m_titleLabel;

@property (weak, nonatomic) IBOutlet UISwitch *m_switcher;

@property (weak, nonatomic) IBOutlet UIScrollView *m_scrollerView;

@property (weak, nonatomic) IBOutlet UIImageView *m_lineImagV;


@end

@interface HH_CustomBuyedCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel   *m_titleLabel;

@property (weak, nonatomic) IBOutlet UISwitch *m_switcher;

@property (weak, nonatomic) IBOutlet UITextField *m_totalTextField;

@property (weak, nonatomic) IBOutlet UITextField *m_usedTextField;

@property (weak, nonatomic) IBOutlet UIImageView *m_totalImagV;

@property (weak, nonatomic) IBOutlet UIImageView *m_usedImagV;

//频率几天几份
@property (weak, nonatomic) IBOutlet UITextField *m_pinlvdayTextField;
@property (weak, nonatomic) IBOutlet UITextField *m_pinlvnumTextField;

//频率
@property (weak, nonatomic) IBOutlet UISwitch *m_PinglvSer;
@property (weak, nonatomic) IBOutlet UIView *m_PinglvSerYES;//使用频率显示的view
@property (weak, nonatomic) IBOutlet UIView *m_PinglvSerNO;//不使用频率

@end

@interface HH_OrignCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextField *m_textField;

@property (weak, nonatomic) IBOutlet UILabel   *m_titleLabel;

@property (weak, nonatomic) IBOutlet UISwitch *m_switcher;

@end
/**
 *  特价区
 */
@interface HH_TejiaCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UISwitch *m_switcher;

@end