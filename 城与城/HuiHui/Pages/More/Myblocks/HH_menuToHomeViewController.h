//
//  HH_menuToHomeViewController.h
//  HuiHui
//
//  Created by mac on 15-7-23.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//  送货上门的页面

#import "BaseViewController.h"

#import "ChooseAddressViewController.h"


@protocol HH_toHomeDelegate <NSObject>

- (void)getFlagDic:(NSMutableDictionary *)falgDic withCoutDic:(NSMutableDictionary *)countDic;

//
//- (void)addMenuTohome:(UIButton *)button;
//
//
//- (void)minuMenuTohome:(UIButton *)button;

@end

@interface HH_menuToHomeViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate,ChooseAddressDelegate>{
    
    NSInteger  m_index;
    
    // 计算有多少个商品
    NSInteger  m_count;
    
}

// 存放菜单的数组
@property (nonatomic, strong) NSMutableArray        *m_menuList;

// 数组
@property (nonatomic, strong) NSMutableArray        *m_menuOrder;

// 字典
@property (nonatomic, strong) NSMutableDictionary   *m_dic;

@property (nonatomic, strong) NSMutableDictionary   *m_countDic;

@property (nonatomic, assign) id<HH_toHomeDelegate> delegate;

// 存放总价的数据
@property (nonatomic, assign) float                 m_totalPrice;

// 字段记录是否有优惠
@property (nonatomic, strong) NSString              *isYouhui;

@property (nonatomic, strong) NSMutableArray        *m_todayArray;

@property (nonatomic, strong) NSMutableArray        *m_timeList;

// 显示地区的pickerView
@property (nonatomic, strong) UIPickerView          *m_pickerView;

@property (nonatomic, strong) UIToolbar             *m_pickerToolBar;
// 滚动了pickerView
@property (nonatomic, assign) BOOL                  isSelectedArea;

@property (nonatomic, strong) NSString              *m_timeString;

@property (nonatomic, strong) NSString              *m_timeString1;

@property (nonatomic, strong) NSString              *m_timeString2;

@property (nonatomic, strong) UIControl             *m_view;

// 用于请求数据的menuId
@property (nonatomic, strong) NSString              *m_menuId;

// 存放默认地址的数组
@property (nonatomic, strong) NSMutableDictionary   *m_defaultDic;

@property (nonatomic, strong) NSString              *m_addressId;

// 标记特殊要求的字符
@property (nonatomic, strong) NSString              *m_special;

@property (nonatomic, strong) NSString              *m_date;

// 存放商户的id
@property (nonatomic, strong) NSString              *m_merchantId;

@property (nonatomic, strong) NSString                      *m_ModelType;

// 存放请求数据的shopId
@property (nonatomic, strong) NSString                      *m_shopId;

@end
