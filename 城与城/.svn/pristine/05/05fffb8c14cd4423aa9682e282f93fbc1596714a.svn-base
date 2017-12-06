//
//  LaunchActivityViewController.h
//  baozhifu
//
//  Created by mac on 14-3-4.
//  Copyright (c) 2014年 mac. All rights reserved.
//  发起活动

#import "BaseViewController.h"

#import "DBHelper.h"

@interface LaunchActivityViewController : BaseViewController<UITextFieldDelegate,UITextViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UIAlertViewDelegate>{
    
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

// 存放商户的数组
@property (nonatomic, strong) NSMutableArray    *m_merchantArray;

// 判断是属于哪个类型的
@property (nonatomic, strong) NSString          *m_typeString;

// 商户标志的字符
@property (nonatomic, strong) NSString          *m_merchantString;


@property (nonatomic, strong) NSString          *m_merchantString1;

// 用于存储商户的Id
@property (nonatomic, strong) NSString          *m_merchantId;

@property (nonatomic, strong) NSString          *m_merchantId1;

@property (nonatomic, strong) NSString          *m_merchantId2;

// 用于存储产品、活动的Id
@property (nonatomic, strong) NSString          *m_serviceId;

@property (nonatomic, strong) NSString          *m_serviceId1;

@property (nonatomic, strong) NSString          *m_serviceId2;


// 用于存储商户的最低返利设置
@property (nonatomic, strong) NSString          *LimitRebate;

@property (nonatomic, strong) NSString          *LimitRebate1;

@property (nonatomic, strong) NSString          *LimitRebate2;

// 用于存储商户的最低返利类别
@property (nonatomic, strong) NSString          *RebatesType;

@property (nonatomic, strong) NSString          *RebatesType1;

@property (nonatomic, strong) NSString          *RebatesType2;


@property (nonatomic, strong) NSString          *m_productId;

@property (nonatomic, strong) NSString          *m_productId1;

@property (nonatomic, strong) NSString          *m_productId2;

// 存储模板的数组
@property (nonatomic, strong) NSMutableArray    *m_modelArray;

@property (nonatomic, strong) NSString          *m_modelString;

@property (nonatomic, strong) NSString          *m_modelString1;
// 判断是否是特殊商户
@property (nonatomic, strong) NSString          *m_IsSpecial;

@property (nonatomic, strong) NSString          *m_IsSpecial1;

@property (nonatomic, strong) NSString          *m_IsSpecial2;

// 存储模板选择的Id
@property (nonatomic, strong) NSString          *m_modelId;
@property (nonatomic, strong) NSString          *m_modelId1;
@property (nonatomic, strong) NSString          *m_modelId2;


// 存储数据的字典
@property (nonatomic, strong) NSMutableDictionary *m_dic;

// 记录来自于新增活动还是编辑活动的字符  1表示新增 2表示编辑
@property (nonatomic, strong) NSString          *m_StringType;

// 用于显示键盘上面的完成按钮
@property (nonatomic, strong) UIToolbar  *m_textToolBar;



// 商户数据请求数据
- (void)MerchantRequestSubmit;

// 选择模板请求数据
- (void)modelRequestSubmit;
// 选择模板后请求的接口
- (void)TemplateRequestSubmit;
// 编辑请求数据
- (void)editDataRequestSubmit;

@end

