//
//  LaunchPartyViewController.h
//  baozhifu
//
//  Created by mac on 14-3-4.
//  Copyright (c) 2014年 mac. All rights reserved.
//  发起聚会

#import "BaseViewController.h"

#import "DBHelper.h"

@interface LaunchPartyViewController : BaseViewController<UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate,UITextViewDelegate>{
    
    DBHelper *dbhelp;
    
  
}

// 一级类型
@property (nonatomic, strong) NSMutableArray    *m_oneArray;
// 二级类型
@property (nonatomic, strong) NSMutableArray    *m_twoArray;

// 显示地区的pickerView
@property (nonatomic, strong) UIPickerView      *m_pickerView;

@property (nonatomic, strong) UIToolbar         *m_pickerToolBar;

@property (nonatomic, strong) NSString          *m_categoryString;

//@property (nonatomic, strong) NSString          *m_projectString;

@property (nonatomic, strong) NSString          *m_categoryString1;

@property (nonatomic, strong) NSString          *m_projectString1;

// BOOL判断是否滚动了pickerView
@property (nonatomic, assign) BOOL              isSelected;

// classId
@property (nonatomic, strong) NSString *m_classId;

@property (nonatomic, strong) NSString *m_classId1;

@property (nonatomic, strong) NSString *m_classId2;

// 存储参数的字典
@property (nonatomic, strong) NSMutableDictionary *m_items;

// 判断是属于编辑状态还是属于新增的状态 1表示新增 2表示编辑
@property (nonatomic,strong) NSString *m_typeString;

// 用于显示键盘上面的完成按钮
@property (nonatomic, strong) UIToolbar  *m_textToolBar;


// 编辑数据请求网络
- (void)editDataRequestSubmit;

@end
