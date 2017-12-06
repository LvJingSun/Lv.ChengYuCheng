//
//  HH_RelseaeQuanViewController.h
//  HuiHui
//
//  Created by mac on 15-3-19.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//  发布券券、编辑券券的页面

#import "BaseViewController.h"

#import "HH_shopListViewController.h"

@interface HH_RelseaeQuanViewController : BaseViewController<UITextFieldDelegate,UITextViewDelegate,HHShopListListDelegate,UIAlertViewDelegate>

// 日期的pickView
@property (nonatomic, strong) UIDatePicker          *m_datePicker;
// 加在pickview上方的view
@property (nonatomic, strong) UIToolbar             *m_toolbar;

// 用于判断时间的pickerView是否被选择
@property (nonatomic, assign) BOOL                  isSelected;

@property (nonatomic, assign) BOOL                  isEndSelected;

// 生效日期的记录值
@property (nonatomic, strong) NSString              *m_dateString;
// 失效日期的记录值
@property (nonatomic, strong) NSString              *m_EndDataString;
// 店铺名称的记录值
//@property (nonatomic, strong) NSString              *m_shopString;
// 店铺Id的记录值
@property (nonatomic, strong) NSString              *m_shopId;

@property (nonatomic, assign) BOOL                  isSelectedShop;

// 存放店铺列表的数组
@property (nonatomic, strong) NSMutableArray        *m_shopList;

// 用于记录是开始时间的选择还是截止时间的选择
@property (nonatomic, strong) NSString              *m_typeString;

// 判断来自于发布券券还是编辑券券的类型  1表示发布   2表示编辑
@property (nonatomic, strong) NSString              *m_type;

// 记录是新增还是编辑
@property (nonatomic, strong) NSString              *m_voucherId;

// 存放编辑状态时传递过来的值
@property (nonatomic, strong) NSMutableDictionary   *m_dic;



// 发布券券请求接口
- (void)releaseQuanSubmit;


@end
