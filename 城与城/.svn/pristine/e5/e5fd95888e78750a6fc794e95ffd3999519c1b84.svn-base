//
//  AddAddressViewController.h
//  HuiHui
//
//  Created by mac on 15-2-15.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//  添加/编辑修改地址的页面

#import "BaseViewController.h"

#import "AreaDB.h"


@interface AddAddressViewController : BaseViewController<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>{
    
    AreaDB *dbhelp;

}

// 记录是添加的类型还是标记修改地址的类型  1表示新增 2表示编辑修改
@property (nonatomic, strong) NSString   *m_stringType;


@property (nonatomic, strong) NSMutableArray        *m_provinceArray;

@property (nonatomic, strong) NSMutableArray        *m_CityArray;

@property (nonatomic, strong) NSMutableArray        *m_AreaArray;
// 显示地区的pickerView
@property (nonatomic, strong) UIPickerView          *m_pickerView;

@property (nonatomic, strong) UIToolbar             *m_pickerToolBar;

// 滚动了pickerView
@property (nonatomic, assign) BOOL                  isSelectedArea;

// 地区的记录值
@property (nonatomic, strong) NSString              *m_areaString;

@property (nonatomic, strong) NSMutableDictionary   *m_dic;

// 记录是否设置为默认地址
@property (nonatomic, strong) NSString              *isDefault;

//点击成功时存放选择的数据的字符
@property (nonatomic, strong) NSString              *m_provinceName;

@property (nonatomic, strong) NSString              *m_cityName;

@property (nonatomic, strong) NSString              *m_areaName;

@property (nonatomic, strong) NSString              *m_provinceId;

@property (nonatomic, strong) NSString              *m_cityId;

@property (nonatomic, strong) NSString              *m_areaId;

// 点击取消时存放原来值的字符
@property (nonatomic, strong) NSString              *m_provinceName1;

@property (nonatomic, strong) NSString              *m_cityName1;

@property (nonatomic, strong) NSString              *m_areaName1;

@property (nonatomic, strong) NSString              *m_provinceId1;

@property (nonatomic, strong) NSString              *m_cityId1;

@property (nonatomic, strong) NSString              *m_areaId1;

// 存放最终的数据
@property (nonatomic, strong) NSString              *m_provinceName2;

@property (nonatomic, strong) NSString              *m_cityName2;

@property (nonatomic, strong) NSString              *m_areaName2;

@property (nonatomic, strong) NSString              *m_provinceId2;

@property (nonatomic, strong) NSString              *m_cityId2;

@property (nonatomic, strong) NSString              *m_areaId2;




// 新增数据请求接口
- (void)addAddressRequest;


@end
