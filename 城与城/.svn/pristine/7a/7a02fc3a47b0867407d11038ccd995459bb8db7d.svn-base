//
//  HH_partyViewController.h
//  HuiHui
//
//  Created by mac on 14-10-16.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//  发起活动的页面

#import "BaseViewController.h"

#import "BBMapViewController.h"

#import "MHImagePickerMutilSelector.h"


@interface HH_partyViewController : BaseViewController<UITextFieldDelegate,UITextViewDelegate,ChosesMapDelegate,UIActionSheetDelegate,MHImagePickerMutilSelectorDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    
    int pickerorphoto;

}


// 用于显示键盘上面的完成按钮
@property (nonatomic, strong) UIToolbar             *m_textToolBar;
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
// 存放图片的数组
@property (nonatomic, strong) NSMutableArray        *m_imageArray;

// 选择图片时候用于计算view的大小
@property (nonatomic, assign) BOOL                  isChoosePhoto;
// 存放图片的字典
@property (nonatomic,strong) NSMutableDictionary    *ImageDic;

@end
