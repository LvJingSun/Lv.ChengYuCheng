//
//  InsurecountViewController.h
//  HuiHui
//
//  Created by 冯海强 on 14-7-15.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "BaseViewController.h"

@interface InsurecountViewController : BaseViewController<UITextFieldDelegate,UIActionSheetDelegate,UIAlertViewDelegate,UIScrollViewDelegate,QQApiInterfaceDelegate,TencentSessionDelegate>
{
    TencentOAuth                *tencentOAuth;
}

@property (strong, nonatomic) NSString *InsureTitle;//标题
@property (strong, nonatomic) NSString *InsuresimpleTitle;//标题
@property (strong, nonatomic) NSString *Insuremctid;//商户网站ID
@property (strong, nonatomic) NSString *InsureMerchantID;//商户网站ID
@property (strong, nonatomic) NSString *InsureServiceID;//产品ID



@property (weak, nonatomic) IBOutlet UIScrollView *Workscroll;

@property (weak, nonatomic) IBOutlet UITextField *InsureName;
@property (weak, nonatomic) IBOutlet UITextField *InsureSex;
@property (weak, nonatomic) IBOutlet UITextField *InsureAge;
@property (weak, nonatomic) IBOutlet UITextField *InsureClass;
@property (weak, nonatomic) IBOutlet UITextField *InsureYear;
@property (weak, nonatomic) IBOutlet UITextField *Insurecoverage;//保额

@property (strong, nonatomic) IBOutlet UIView *WorkoverView;//结果弹出来的视图

@property (weak, nonatomic) IBOutlet UIScrollView *InsureScroll;

@property (weak, nonatomic) IBOutlet UIButton *Workout;

@property (weak, nonatomic) IBOutlet UIView *m_explainview;//结果说明视图

@property (weak, nonatomic) IBOutlet UILabel *workoverstring;//返回结果
@property (weak, nonatomic) IBOutlet UITextView *exaple1;
@property (weak, nonatomic) IBOutlet UITextView *exaple2;

@property (strong, nonatomic) NSMutableArray *AgeArray;//年龄数组
@property (strong, nonatomic) NSMutableArray *YearArray1;//1年交年限数组
@property (strong, nonatomic) NSMutableArray *YearArray3;//3年交年限数组
@property (strong, nonatomic) NSMutableArray *YearArray5;//4年交年限数组
@property (strong, nonatomic) NSMutableArray *YearArray10;//10年交年限数组
@property (strong, nonatomic) NSMutableArray *YearArray15;//15年交年限数组
@property (strong, nonatomic) NSMutableArray *YearArray20;//20年交年限数组


@property (nonatomic, strong) NSArray           *m_values;

@property (nonatomic, strong) NSArray           *m_keyTimes;

@property (nonatomic, strong) NSArray           *m_Funtions;

@property (strong, nonatomic) IBOutlet UIView *m_showview;

@end
