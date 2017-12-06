//
//  ActivitySaleViewController.h
//  baozhifu
//
//  Created by mac on 14-3-6.
//  Copyright (c) 2014年 mac. All rights reserved.
//  活动价钱数据等设置

#import "BaseViewController.h"

@interface ActivitySaleViewController : BaseViewController<UITextFieldDelegate>


// 日期的pickView
@property (nonatomic, strong) UIDatePicker          *m_datePicker;
// 加在pickview上方的view
@property (nonatomic, strong) UIToolbar             *m_toolbar;
// 记录是属于哪个日期
@property (nonatomic, strong) NSString              *m_dateString;

// 用于进行比较KEY值的开始日期和结束日期
@property (nonatomic, strong) NSDate                *m_StartDate;

@property (nonatomic, strong) NSDate                *m_EndDate;

// 设置键盘小数点
@property (nonatomic, strong) UIButton *doneButton;

@property (nonatomic, assign) BOOL needDone;

@property (nonatomic, assign) BOOL keyShow;
// 当前活动的textField
@property (nonatomic, strong) UITextField *m_activityField;

// 记录是否选择了过期退款、随时退款及免预约
@property (nonatomic, assign) BOOL  isSelected;

@property (nonatomic, assign) BOOL  isSelected1;

@property (nonatomic, assign) BOOL  isSelected2;

// 存储数据的字典
@property (nonatomic,strong) NSMutableDictionary *m_dic;

@property (nonatomic, strong) NSString          *LimitRebate;
@property (nonatomic, strong) NSString          *RebatesType;


@end
