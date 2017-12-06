//
//  PersonalViewController.h
//  HuiHui
//
//  Created by mac on 13-11-19.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//  个人信息页面

#import "BaseViewController.h"

#import "AreaViewController.h"

#import "UserNameViewController.h"

#import "AreaDB.h"

@interface PersonalViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,AreaListDelegate,UserInformationDelegate,UIAlertViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate>{
    
    AreaDB *dbhelp;
}


// 日期的pickView
@property (nonatomic, strong) UIDatePicker          *m_datePicker;
// 加在pickview上方的view
@property (nonatomic, strong) UIToolbar             *m_toolbar;
// 生日的记录值
@property (nonatomic, strong) NSString              *m_birthString;
// 性别的记录值
@property (nonatomic, strong) NSString              *m_sexString;
// 手机号的记录值
@property (nonatomic, strong) NSString              *m_phoneString;
// 邮箱的记录值
@property (nonatomic, strong) NSString              *m_emailString;
// 用户名的记录值
@property (nonatomic, strong) NSString              *m_userString;
// 地区的记录值
@property (nonatomic, strong) NSString              *m_areaString;

// 用于判断时间的pickerView是否被选择
@property (nonatomic, assign) BOOL                  isSelected;

@property (nonatomic, weak) UIImageView             *m_imgV;

@property (nonatomic, strong) UIImage               *m_image;

// 身份状态-判断是否实名认证成功
@property (nonatomic, strong) NSString              *m_statuString;

// 存放图片的字典
@property (nonatomic, strong) NSMutableDictionary   *m_imagDic;


// 用来记录是否设置了安全问题
@property (nonatomic, strong) NSString              *m_securityString;

@property (nonatomic, strong) NSMutableArray        *m_provinceArray;

@property (nonatomic, strong) NSMutableArray        *m_CityArray;

@property (nonatomic, strong) NSMutableArray        *m_AreaArray;

// 显示地区的pickerView
@property (nonatomic, strong) UIPickerView          *m_pickerView;

@property (nonatomic, strong) UIToolbar             *m_pickerToolBar;

// 用于请求网络的三个id
@property (nonatomic, strong) NSString              *m_provinceId;

@property (nonatomic, strong) NSString              *m_cityId;

@property (nonatomic, strong) NSString              *m_areaId;
// 滚动了pickerView
@property (nonatomic, assign) BOOL                  isSelectedArea;
// 进来请求地区的数据
@property (nonatomic, assign) BOOL                  isRequest;


// 验证用户是否填写了支付问题的网络请求
- (void)paymentSafeRequest;

// 修改用户信息
- (void)modifyUserInfo;

// 请求地区数据
- (void)requestAreaSubmit;

- (void)initpickerView;

@end
