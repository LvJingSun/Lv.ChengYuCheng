//
//  HH_AdvertViewController.h
//  HuiHui
//
//  Created by mac on 15-4-15.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//  广告设置页面-新增/编辑

#import "BaseViewController.h"

#import "HH_advCityListViewController.h"


@interface HH_AdvertViewController : BaseViewController<UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,HH_AdvCityDelegate,UIAlertViewDelegate>{
    
    BOOL  pickerorphoto;
    
    NSString *weizhi;
    
}

@property (nonatomic, assign) BOOL      isSelected;

@property (nonatomic, assign) BOOL      isUrlSelected;

@property (nonatomic, assign) BOOL      isMenuSelected;


@property (nonatomic, assign) BOOL      ispickerSelected;


// 存放产品数据的数组
@property (nonatomic, strong) NSMutableArray        *m_productList;

@property (nonatomic, strong) UIToolbar             *m_pickerToolBar;
// 显示的pickerView
@property (nonatomic, strong) UIPickerView          *m_pickerView;

// 存放产品的id
@property (nonatomic, strong) NSString              *m_productId;

@property (nonatomic, strong) NSString              *m_productName;

// 存放图片的字典,用于请求数据
@property (strong, nonatomic)  NSMutableDictionary  *ImageDiction;

// 记录类型 是 1 新增还是  2 编辑
@property (nonatomic, strong) NSString              *m_type;

// 记录类型 是 1 全返付  空是首页
@property (nonatomic, strong) NSString              *gldtype;

// 记录是选择的原生产品还是跳转地址 0表示跳转原生数据；1表示跳转到Web
@property (nonatomic, strong) NSString              *m_webString;
// 存放广告Id
@property (nonatomic, strong) NSString              *m_appMctIndexID;
// 存放城市id
@property (nonatomic, strong) NSString              *m_cityId;

// 存放编辑时候的字典
@property (strong, nonatomic)  NSMutableDictionary  *m_dic;

@property (nonatomic, strong) NSString              *m_isChange;

// 记录是适用于app还是微网站还是不限
@property (nonatomic, strong) NSString              *m_commonString;

// 请求产品数据
- (void)productListRequest;
// 新增广告和修改广告的请求数据
- (void)settingRequestSubmit;

@end
