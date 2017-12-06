//
//  NextPartyViewController.h
//  baozhifu
//
//  Created by mac on 14-3-4.
//  Copyright (c) 2014年 mac. All rights reserved.
//  聚会的下一步信息填写

#import "BaseViewController.h"

#import "DBHelper.h"

@interface NextPartyViewController : BaseViewController<UIActionSheetDelegate,UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>{
    
    DBHelper *dbhelp;
    
}


// 日期的pickView
@property (nonatomic, strong) UIDatePicker          *m_datePicker;
// 加在pickview上方的view
@property (nonatomic, strong) UIToolbar             *m_toolbar;
// 显示时间的dataPickerView
@property (nonatomic, strong) UIDatePicker          *m_timePicker;
@property (nonatomic, strong) UIToolbar             *m_timeToolbar;

// 用于判断时间的pickerView是否被选择
@property (nonatomic, assign) BOOL                  isSelected;
// 记录是属于哪个日期
@property (nonatomic, strong) NSString              *m_dateString;


// 用于进行比较聚会开始时间和结束时间以及报名截止时间的
@property (nonatomic, strong) NSDate                *m_Deadline;

@property (nonatomic, strong) NSDate                *m_PartystartDate;

@property (nonatomic, strong) NSDate                *m_PartyEndDate;

// 标志来自于哪个页面  1表示发起的聚会 2表示发起的活动
@property (nonatomic, strong) NSString              *m_typeString;

@property (nonatomic, strong) NSMutableArray        *m_cityArray;

@property (nonatomic, strong) NSMutableArray        *m_areaArray;

@property (nonatomic, strong) NSMutableArray        *m_addressArray;

// 显示地区的pickerView
@property (nonatomic, strong) UIPickerView          *m_pickerView;

@property (nonatomic, strong) UIToolbar             *m_pickerToolBar;

@property (nonatomic, strong) NSString              *m_cityString;
@property (nonatomic, strong) NSString              *m_areaString;
@property (nonatomic, strong) NSString              *m_addressString;

@property (nonatomic, strong) NSMutableDictionary   *m_dic;

// 城市的Id
@property (nonatomic, strong) NSString              *m_cityId;
@property (nonatomic, strong) NSString              *m_cityId1;
@property (nonatomic, strong) NSString              *m_cityId2;

@property (nonatomic, strong) NSString              *m_areaId;
@property (nonatomic, strong) NSString              *m_areaId1;
@property (nonatomic, strong) NSString              *m_areaId2;

@property (nonatomic, strong) NSString              *m_districtId;
@property (nonatomic, strong) NSString              *m_districtId1;
@property (nonatomic, strong) NSString              *m_districtId2;


// 存放请求数据的参数
@property (nonatomic, strong) NSString              *m_activityId;

// 海报的数组
@property (nonatomic, strong)NSMutableArray         *m_postList;

// 上传信息
- (void)PartyRequestSubmit;
- (void)activityRequestSubmit;
// 详情请求数据
- (void)DetailActRequestSubmit;


@end
