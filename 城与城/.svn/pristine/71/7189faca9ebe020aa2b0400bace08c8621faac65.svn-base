//
//  PBaseViewController.h
//  baozhifu
//
//  Created by 冯海强 on 14-1-12.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "BaseViewController.h"
#import "ChoseShopViewController.h"
#import "DowncellViewController.h"

@interface PBaseViewController : BaseViewController<UITextFieldDelegate,UITextViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate,ChosesshopDelegate,ChosesDelegate,UIActionSheetDelegate>
{
    
    NSString *IsSpecial;//是否是特殊商户
    
    UILabel *KEYlabel;

    NSString *BusinessID;
    
    NSString *ShopID;
    
    NSString *oneID;
    
    NSString *twoID;
    
    
    NSString * isActionInView;//返回窗口提示使用模板；
    
}

@property (weak, nonatomic) IBOutlet UIScrollView *P_BasicScrollView;

@property (nonatomic,strong) NSMutableArray *Pbasearray;
@property (nonatomic,strong) NSMutableDictionary *Pbasedic;

@property (nonatomic, strong) NSString          *m_merchantID;

@property (nonatomic, strong) UIToolbar         *m_pickerToolBar;
// 显示的pickerView
@property (nonatomic, strong) UIPickerView      *m_pickerView;
// BOOL判断是否滚动了pickerView
@property (nonatomic, assign) BOOL              isSelected;

// 存放商户的数组
@property (nonatomic, strong) NSMutableArray    *chosearrayname;
@property (nonatomic, strong) NSMutableArray    *chosearraycode;

//最低返利，返利类别
@property (nonatomic, strong) NSString          *LimitRebate;
@property (nonatomic, strong) NSString          *RebatesType;

@end
