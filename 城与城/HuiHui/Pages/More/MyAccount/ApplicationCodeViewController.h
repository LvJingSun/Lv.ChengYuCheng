//
//  ApplicationCodeViewController.h
//  baozhifu
//
//  Created by mac on 13-12-24.
//  Copyright (c) 2013年 mac. All rights reserved.
//  公众邀请码申请页面

#import "BaseViewController.h"

@interface ApplicationCodeViewController : BaseViewController<UITextFieldDelegate,UITextViewDelegate>


// 日期的pickView
@property (nonatomic, strong) UIDatePicker          *m_datePicker;
// 加在pickview上方的view
@property (nonatomic, strong) UIToolbar             *m_toolbar;
// 日期的记录值
@property (nonatomic, strong) NSString              *m_dataString;
// 临时记录日期的值
@property (nonatomic, strong) NSString              *m_temporaryDate;
// 判断是否滚动选择了日期
@property (nonatomic, assign) BOOL                  isSelected;



- (void)requestSubmitCode;

@end
