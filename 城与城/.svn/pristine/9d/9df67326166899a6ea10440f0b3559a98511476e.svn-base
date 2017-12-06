//
//  Fl_ContactViewController.h
//  HuiHui
//
//  Created by mac on 14-12-29.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//  添加机票乘机人的页面|编辑乘机人

#import "BaseViewController.h"


typedef enum
{
    IdCardType = 0,
    PassPortType = 1,
    OtherType
    
} FlightsCertifier;

@protocol FlightsTrideDelegate <NSObject>

- (void)flightsTride:(NSDictionary *)dic;

- (void)EditTride:(NSDictionary *)dic;

@end

@interface Fl_ContactViewController : BaseViewController<UIActionSheetDelegate,UITextFieldDelegate>

// 编辑状态下传递过来的信息
@property (nonatomic, strong) NSMutableDictionary *m_dic;

// 标志是添加联系人还是编辑联系人的状态  1表示添加乘机人 2表示编辑乘机人
@property (nonatomic, strong) NSString            *m_stringType;

// 记录是省份证、护照还是其他的类型
@property (nonatomic, assign) FlightsCertifier    m_type;

// 日期的pickView
@property (nonatomic, strong) UIDatePicker          *m_datePicker;
// 加在pickview上方的view
@property (nonatomic, strong) UIToolbar             *m_toolbar;
// 用于判断时间的pickerView是否被选择
@property (nonatomic, assign) BOOL                  isSelected;
// 生日的记录值
@property (nonatomic, strong) NSString              *m_birthString;
// 设置代理
@property (nonatomic, assign) id<FlightsTrideDelegate>delegate;

@end
