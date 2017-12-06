//
//  SponsorViewController.h
//  HuiHuiApp
//
//  Created by mac on 13-10-16.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//  赞助控制器

#import "BaseViewController.h"

#import "SponsorTypeViewController.h"


@interface SponsorViewController : BaseViewController<UIActionSheetDelegate,UITextFieldDelegate,TypeDelegate>

// 日期的pickView
@property (nonatomic, strong) UIDatePicker          *m_datePicker;
// 加在pickview上方的view
@property (nonatomic, strong) UIToolbar                *m_toolbar;
// 赞助额度
@property (weak, nonatomic) IBOutlet UILabel        *m_sponsorCredit;
// 赞助数量
@property (weak, nonatomic) IBOutlet UILabel        *m_sponsorCount;
// 地区
@property (weak, nonatomic) IBOutlet UILabel        *m_areaLabel;
// 性别
@property (weak, nonatomic) IBOutlet UILabel        *m_sexLabel;
// 时间
@property (weak, nonatomic) IBOutlet UILabel        *m_timeLabel;
// 留言
@property (weak, nonatomic) IBOutlet UITextField    *m_messageLabel;
// 滚动的scrollerView
@property (weak, nonatomic) IBOutlet UIScrollView   *m_scrollerView;
// 赞助额度的-按钮
@property (weak, nonatomic) IBOutlet UIButton       *m_minuCreditBtn;
// 赞助额度的+按钮
@property (weak, nonatomic) IBOutlet UIButton       *m_plustCreditBtn;
// 赞助数量的-按钮
@property (weak, nonatomic) IBOutlet UIButton       *m_minuCountBtn;
// 赞助数量的+按钮
@property (weak, nonatomic) IBOutlet UIButton       *m_plusCountBtn;

// 用于存储性别的字符
@property (nonatomic, strong) NSString    *m_sexString;

@property (nonatomic, strong) NSString    *m_sexCopyString;
// 用于判断时间的pickerView是否被选择
@property (nonatomic, assign) BOOL        isSelected;
// 标志赞助额度的值
@property (nonatomic, assign) NSInteger   m_Credit;
// 标志赞助数量的值
@property (nonatomic, assign) NSInteger   m_count;



@end
