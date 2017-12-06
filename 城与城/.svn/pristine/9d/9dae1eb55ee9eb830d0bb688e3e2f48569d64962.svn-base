//
//  PExpenseSetViewController.h
//  baozhifu
//
//  Created by 冯海强 on 14-1-12.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "BaseViewController.h"

@interface PExpenseSetViewController : BaseViewController<UITextFieldDelegate>
{
    UILabel *KEYlabel;
    NSArray *array1 ;
    NSArray *array2 ;
}

// 日期的pickView
@property (nonatomic, strong) UIDatePicker          *m_datePicker;
@property (nonatomic,weak)NSString *KeyString;

// 加在pickview上方的view
@property (nonatomic, strong) UIToolbar             *m_toolbar;
// 日期的记录值
@property (nonatomic, strong) NSString              *m_dataString;
// 临时记录日期的值
@property (nonatomic, strong) NSString              *m_temporaryDate;
// 判断是否滚动选择了日期
@property (nonatomic, assign) BOOL                  isSelected;


@property (weak, nonatomic) IBOutlet UIScrollView *P_ExpenseSetScrollView;

@property (nonatomic,strong) NSMutableDictionary *Pexpensedic;

//最低返利，返利类别
@property (nonatomic, strong) NSString          *LimitRebate;
@property (nonatomic, strong) NSString          *RebatesType;

@property (nonatomic,weak)IBOutlet UILabel *RebatesTypeLabel;//返利类别标签


@end
