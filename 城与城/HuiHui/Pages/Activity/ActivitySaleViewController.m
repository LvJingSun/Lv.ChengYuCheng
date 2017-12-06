//
//  ActivitySaleViewController.m
//  baozhifu
//
//  Created by mac on 14-3-6.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "ActivitySaleViewController.h"

#import "NextPartyViewController.h"

#import "SVProgressHUD.h"

#import "CommonUtil.h"

#import "AppHttpClient.h"


@interface ActivitySaleViewController ()

@property (weak, nonatomic) IBOutlet UIView *m_titleView;

@property (weak, nonatomic) IBOutlet UIView *m_tempView;

@property (weak, nonatomic) IBOutlet UITextField *m_orignPriceTextField;

@property (weak, nonatomic) IBOutlet UITextField *m_cityPriceTextField;
// 返利比例
@property (weak, nonatomic) IBOutlet UITextField *m_Proportion;
// key值有效时间
@property (weak, nonatomic) IBOutlet UITextField *m_startTextField;
// key值截止时间
@property (weak, nonatomic) IBOutlet UITextField *m_endTextField;
// 过期退款按钮
@property (weak, nonatomic) IBOutlet UIButton *m_ExpiredBtn;
// 随时按钮
@property (weak, nonatomic) IBOutlet UIButton *m_anyTimeBtn;
// 免预约的按钮
@property (weak, nonatomic) IBOutlet UIButton *m_ReservationBtn;

@property (weak, nonatomic) IBOutlet UIScrollView *m_scrollerView;

@property (weak, nonatomic) IBOutlet UIView *m_backVIew;

@property (weak, nonatomic) IBOutlet UIView *m_backView1;


// 按钮触发的事件
- (IBAction)btnClicked:(id)sender;
// 日期选择按钮触发的事件
- (IBAction)dateChoose:(id)sender;
// 下一步按钮触发的事件
- (IBAction)nextStep:(id)sender;

@end

@implementation ActivitySaleViewController

@synthesize m_datePicker;

@synthesize m_toolbar;

@synthesize keyShow;

@synthesize m_dic;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.isSelected = NO;
        
        self.isSelected1 = NO;
        
        self.isSelected2 = NO;
        
        m_dic = [[NSMutableDictionary alloc]initWithCapacity:0];
        
        // 发送键盘通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setTitle:@"策划活动"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    self.needDone = YES;
    
    keyShow = NO;
    
    // 设置textField的边框颜色
    self.m_orignPriceTextField.layer.borderColor = [UIColor colorWithRed:213/255.0 green:213/255.0 blue:213/255.0 alpha:1.0].CGColor;
    self.m_orignPriceTextField.layer.borderWidth = 1.0f;
    self.m_orignPriceTextField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 5, self.m_orignPriceTextField.frame.size.height)];
    self.m_orignPriceTextField.leftViewMode = UITextFieldViewModeAlways;
    
    self.m_cityPriceTextField.layer.borderColor = [UIColor colorWithRed:213/255.0 green:213/255.0 blue:213/255.0 alpha:1.0].CGColor;
    self.m_cityPriceTextField.layer.borderWidth = 1.0f;
    self.m_cityPriceTextField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 5, self.m_cityPriceTextField.frame.size.height)];
    self.m_cityPriceTextField.leftViewMode = UITextFieldViewModeAlways;
    
    self.m_Proportion.layer.borderColor = [UIColor colorWithRed:213/255.0 green:213/255.0 blue:213/255.0 alpha:1.0].CGColor;
    self.m_Proportion.layer.borderWidth = 1.0f;
    self.m_Proportion.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 5, self.m_Proportion.frame.size.height)];
    self.m_Proportion.leftViewMode = UITextFieldViewModeAlways;
    
    
    self.m_backVIew.layer.borderColor = [UIColor colorWithRed:213/255.0 green:213/255.0 blue:213/255.0 alpha:1.0].CGColor;
    self.m_backVIew.layer.borderWidth = 1.0f;
    self.m_backVIew.layer.cornerRadius = 5.0f;
    self.m_backVIew.backgroundColor = [UIColor whiteColor];

    self.m_backView1.layer.borderColor = [UIColor colorWithRed:213/255.0 green:213/255.0 blue:213/255.0 alpha:1.0].CGColor;
    self.m_backView1.layer.borderWidth = 1.0f;
    self.m_backView1.layer.cornerRadius = 5.0f;
    self.m_backView1.backgroundColor = [UIColor whiteColor];
    
    
    // 初始化
    [self initWithPickerView];
    
    [self.m_datePicker setHidden:YES];
    
    [self.m_toolbar setHidden:YES];
    
    [self.m_scrollerView setContentSize:CGSizeMake(WindowSizeWidth, 800)];
    
    
    NSString *typeString = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"typeString"]];
  
    if ( [typeString isEqualToString:@"1"] ) {
        
        // 新增 存储数据 - 默认为False
        [self.m_dic setObject:@"No" forKey:@"isExpiredReturn"];
        [self.m_dic setObject:@"No" forKey:@"isAnyTimeReturn"];
        [self.m_dic setObject:@"No" forKey:@"isReservation"];
        
    }else{
        // 编辑 - 赋值
        self.m_orignPriceTextField.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"OriginalPrice"]];
        self.m_cityPriceTextField.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"Price"]];
        self.m_Proportion.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"Brokerage"]];
        // key值
        self.m_startTextField.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"KeyDateS"]];
        self.m_endTextField.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"KeyDateE"]];
        
        // 活动特色
        if ( [[self.m_dic objectForKey:@"IsAnyTimeReturn"]isEqualToString:@"Yes"] ) {
            
            self.isSelected1 = YES;
            
            [self.m_anyTimeBtn setImage:[UIImage imageNamed:@"login_gouxuan1.png"] forState:UIControlStateNormal];

        }else{
            self.isSelected1 = NO;

            [self.m_anyTimeBtn setImage:[UIImage imageNamed:@"login_gouxuan2.png"] forState:UIControlStateNormal];

        }
        
        if ( [[self.m_dic objectForKey:@"IsExpiredReturn"]isEqualToString:@"Yes"] ) {
            
            self.isSelected = YES;
            
            [self.m_ExpiredBtn setImage:[UIImage imageNamed:@"login_gouxuan1.png"] forState:UIControlStateNormal];
            
        }else{
            self.isSelected = NO;
            
            [self.m_ExpiredBtn setImage:[UIImage imageNamed:@"login_gouxuan2.png"] forState:UIControlStateNormal];
            
        }
        if ( [[self.m_dic objectForKey:@"IsReservation"]isEqualToString:@"Yes"] ) {
            
            self.isSelected2 = YES;
            
            [self.m_ReservationBtn setImage:[UIImage imageNamed:@"login_gouxuan1.png"] forState:UIControlStateNormal];
            
        }else{
            self.isSelected2 = NO;
            
            [self.m_ReservationBtn setImage:[UIImage imageNamed:@"login_gouxuan2.png"] forState:UIControlStateNormal];
            
        }
        
        
        [self.m_dic setObject:[NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"IsExpiredReturn"]]  forKey:@"isExpiredReturn"];
        [self.m_dic setObject:[NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"IsAnyTimeReturn"]]  forKey:@"isAnyTimeReturn"];
        [self.m_dic setObject:[NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"IsReservation"]] forKey:@"isReservation"];
        
        
    }

    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear: animated];
    
    [self hideTabBar:YES];

}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [self hideTabBar:NO];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
}

- (void)leftClicked{
    
    [self goBack];
}

- (IBAction)nextStep:(id)sender {
    
    
    if ( self.m_orignPriceTextField.text.length == 0 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请输入原价格"];
        
        return;
    }
    
    if ( self.m_cityPriceTextField.text.length == 0 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请输入城与城价格"];
        
        return;
    }
    
    if ( self.m_Proportion.text.length == 0 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请输入返利比例"];
        
        return;
    }
    
    // 根据商户是否是特殊商户来判断输入的返利比例 特殊商户的话返利比例可以输入为0
    
    NSString *IsSpecial = [self.m_dic objectForKey:@"IsSpecial"];
    
    //没有最低返利设置
    if ([self.LimitRebate isEqualToString:@""]) {
        // 如果IsSpecial为Yes的话则返利可输入0
        if ( [IsSpecial isEqualToString:@"False"] ) {
            
            if ( [self.m_Proportion.text isEqualToString:@"0"] ) {
                
                [SVProgressHUD showErrorWithStatus:@"您暂时不是特殊商户，返利比例不能输入0"];
                
                return;
            }
        }
    }//有最低返利设定
    else{
        
        if ([self.m_Proportion.text floatValue]<[self.LimitRebate floatValue]*100) {
            
            self.m_Proportion.text= [NSString stringWithFormat:@"%.0f",[self.LimitRebate floatValue]*100] ;
            
            NSNumber *f =[NSNumber numberWithFloat:[self.LimitRebate floatValue]];
            
            NSString *percentStr = [NSNumberFormatter localizedStringFromNumber:f numberStyle:NSNumberFormatterPercentStyle];
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:[NSString stringWithFormat:@"您有最低返利设定，您所策划活动的返利比例最低设置为%@",percentStr] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alert show];
            
        }
        
    }
    
    
    // 判断输入多个小数点的情况
    NSArray *array = [self.m_orignPriceTextField.text componentsSeparatedByString:@"."];
    NSArray *array1 = [self.m_cityPriceTextField.text componentsSeparatedByString:@"."];
    NSArray *array2 = [self.m_Proportion.text componentsSeparatedByString:@"."];

    
    if ( array.count > 2 || array1.count > 2 || array2.count > 2 ) {
        
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示"
                                                           message:@"您输入的内容有误,请重新输入"
                                                          delegate:nil
                                                 cancelButtonTitle:@"确定"
                                                 otherButtonTitles: nil];
        [alertView show];
        
        return;
        
    }
    
    if ( array2.count > 1  ) {
        
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示"
                                                           message:@"返利比例不能为小数"
                                                          delegate:nil
                                                 cancelButtonTitle:@"确定"
                                                 otherButtonTitles: nil];
        [alertView show];
        
        return;
        
    }
    
    if ( self.m_startTextField.text.length == 0 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请选择KEY有效日期"];
        
        return;
    }
  
    if ( self.m_endTextField.text.length == 0 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请选择KEY失效日期"];
        
        return;
    }
    
    if ( [self.m_EndDate compare:self.m_StartDate] == NSOrderedAscending ) {
        
        [SVProgressHUD showErrorWithStatus:@"KEY值的有效时间不能晚于失效时间"];
        
        return;
        
    }
    
    // 存储数据
    [self.m_dic setObject:self.m_orignPriceTextField.text forKey:@"originalPrice"];
    [self.m_dic setObject:self.m_cityPriceTextField.text forKey:@"price"];
    [self.m_dic setObject:self.m_Proportion.text forKey:@"brokerage"];
    [self.m_dic setObject:self.m_startTextField.text forKey:@"keyVaildDateS"];
    [self.m_dic setObject:self.m_endTextField.text forKey:@"keyVaildDateE"];
  
    // 进入下一步
    NextPartyViewController *VC = [[NextPartyViewController alloc]initWithNibName:@"NextPartyViewController" bundle:nil];
    VC.m_typeString = @"2";
    VC.m_dic = self.m_dic;
    [self.navigationController pushViewController:VC animated:YES];
    
    
}

- (IBAction)btnClicked:(id)sender {
    
    UIButton *btn = (UIButton *)sender;
    
    if ( btn.tag == 11 ) {
        // 过期退款
        self.isSelected = !self.isSelected;
        
        if ( self.isSelected ) {
            
            [self.m_ExpiredBtn setImage:[UIImage imageNamed:@"login_gouxuan1.png"] forState:UIControlStateNormal];
            
            // 存储数据
            [self.m_dic setObject:@"Yes" forKey:@"isExpiredReturn"];
            
        }else{
            
            [self.m_ExpiredBtn setImage:[UIImage imageNamed:@"login_gouxuan2.png"] forState:UIControlStateNormal];
            
            // 存储数据
            [self.m_dic setObject:@"No" forKey:@"isExpiredReturn"];

        }
        
        
    }else if ( btn.tag == 22 ){
        // 随时退款
        self.isSelected1 = !self.isSelected1;
        
        if ( self.isSelected1 ) {
            
            [self.m_anyTimeBtn setImage:[UIImage imageNamed:@"login_gouxuan1.png"] forState:UIControlStateNormal];
            // 存储数据
            [self.m_dic setObject:@"Yes" forKey:@"isAnyTimeReturn"];
            
        }else{
            
            [self.m_anyTimeBtn setImage:[UIImage imageNamed:@"login_gouxuan2.png"] forState:UIControlStateNormal];
            
            // 存储数据
            [self.m_dic setObject:@"No" forKey:@"isAnyTimeReturn"];
            
        }

    
    }else{
        
        // 免预约
        self.isSelected2 = !self.isSelected2;
        
        if ( self.isSelected2 ) {
            
            [self.m_ReservationBtn setImage:[UIImage imageNamed:@"login_gouxuan1.png"] forState:UIControlStateNormal];
            
            // 存储数据
            [self.m_dic setObject:@"Yes" forKey:@"isReservation"];
            
        }else{
            
            [self.m_ReservationBtn setImage:[UIImage imageNamed:@"login_gouxuan2.png"] forState:UIControlStateNormal];
            
            // 存储数据
            [self.m_dic setObject:@"No" forKey:@"isReservation"];
            
        }

        
    }
    
    
}

- (IBAction)dateChoose:(id)sender {
    
    [self.view endEditing:YES];
    
    self.view.userInteractionEnabled = NO;

    [self.m_scrollerView setContentOffset:CGPointMake(0, 200)];
    
    [self.view endEditing:YES];

    UIButton *btn = (UIButton *)sender;
    
    self.m_dateString = [NSString stringWithFormat:@"%i",btn.tag];
    
    
    [self.m_datePicker setHidden:NO];
    
    [self.m_toolbar setHidden:NO];
    
}


#pragma 初始化pickerView
- (void)initWithPickerView{
    
    UIWindow *window = self.navigationController.view.window;
	//  datePickerView初始化
	m_datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 210, WindowSizeWidth, 200)];
    [m_datePicker setDatePickerMode:UIDatePickerModeDate];
	[m_datePicker addTarget:self action:@selector(togglePicker:) forControlEvents:UIControlEventValueChanged];
    m_datePicker.backgroundColor = [UIColor whiteColor];
    
	[window addSubview:m_datePicker];
    UIToolbar *pickerBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.m_datePicker.frame.origin.y - 44, WindowSizeWidth, 44)];
    pickerBar.barStyle = UIBarStyleBlackTranslucent;
    
    
    UIBarButtonItem *cancelBarButton = [[UIBarButtonItem alloc] initWithTitle:@"取消"
                                                                        style:UIBarButtonItemStylePlain
                                                                       target:self
                                                                       action:@selector(doPCAPickerCancel:)];
    cancelBarButton.style = UIBarButtonItemStyleBordered;
    
    UIBarButtonItem *spaceButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                    target:nil
                                                                                    action:nil];
    
    
    UIBarButtonItem *lastButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成"
                                                                       style:UIBarButtonItemStylePlain
                                                                      target:self
                                                                      action:@selector(doPCAPickerDone:)];
    lastButtonItem.style = UIBarButtonItemStyleBordered;
    
    NSArray *pickArray = [NSArray arrayWithObjects: cancelBarButton, spaceButtonItem, lastButtonItem, nil];
    [pickerBar setItems:pickArray animated:YES];
    [window addSubview:pickerBar];
    pickerBar.backgroundColor = [UIColor clearColor];
    self.m_toolbar = pickerBar;
    
    [window addSubview:self.m_toolbar];
}
#pragma mark - PickerBar按钮
- (void)doPCAPickerDone:(id)sender{
    
    self.view.userInteractionEnabled = YES;
    
    [self.m_scrollerView setContentOffset:CGPointMake(0, 0)];

    
    [self.m_datePicker setHidden:YES];
    
    [self.m_toolbar setHidden:YES];
    
    
    // 判断是否滚动了pickerView
    //    if ( !self.isSelected ) {
    
    //     }
    
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone systemTimeZone]];
    
    [formatter setDateFormat:@"YYY-MM-dd"];
    
    if ( [self.m_dateString isEqualToString:@"111"] ) {
        
        self.m_startTextField.text = [formatter stringFromDate:m_datePicker.date];
        
        self.m_StartDate = m_datePicker.date;
        
    }else if ( [self.m_dateString isEqualToString:@"222"] ) {
        
        self.m_endTextField.text = [formatter stringFromDate:m_datePicker.date];
        
        self.m_EndDate = m_datePicker.date;
        
    }else {
        
        
    }
    
}

- (void)doPCAPickerCancel:(id)sender{
    
    self.view.userInteractionEnabled = YES;

    
    [self.m_scrollerView setContentOffset:CGPointMake(0, 0)];

    
    [self.m_datePicker setHidden:YES];
    
    [self.m_toolbar setHidden:YES];
    
}

// pickerView的选择事件
- (void) togglePicker:(id)sender{
    

    
    
    
}


// 完成按钮改为小数点
- (void)handleKeyboardWillHide:(NSNotification *)notification
{
    if (self.doneButton.superview)
    {
        [self.doneButton removeFromSuperview];
    }
    if (!keyShow) {
        return;
    }

    keyShow = NO;
}
- (void)handleKeyboardDidShow:(NSNotification *)notification
{
    // create custom button
    if (self.doneButton == nil)
    {
        self.doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;
//        if (screenHeight==568.0f) {//爱疯5
//            self.doneButton.frame = CGRectMake(0, 568 - 53, 106, 53);
//        } else {//3.5寸
//            self.doneButton.frame = CGRectMake(0, 480 - 53, 106, 53);
//        }
        
        if ( screenHeight == 736.0f ) {
            
            self.doneButton.frame = CGRectMake(self.view.frame.origin.x, screenHeight - 57, WindowSizeWidth/3 - 2, 57);
            
        }else{
            
            self.doneButton.frame = CGRectMake(self.view.frame.origin.x, screenHeight - 53, WindowSizeWidth/3 - 2, 53);
            
        }

        
        
        self.doneButton.adjustsImageWhenHighlighted = NO;
        self.doneButton.hidden=self.needDone;
        [self.doneButton setBackgroundImage:[UIImage imageNamed:@"btn_done_normal.png"] forState:UIControlStateNormal];
        [self.doneButton setBackgroundImage:[UIImage imageNamed:@"btn_done_selected.png"] forState:UIControlStateHighlighted];
        [self.doneButton addTarget:self action:@selector(finishAction) forControlEvents:UIControlEventTouchUpInside];
    }
    
    // locate keyboard view
    UIWindow* tempWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:1];
    if (self.doneButton.superview == nil)
    {
        [tempWindow addSubview:self.doneButton];    // 注意这里直接加到window上
    }
    self.doneButton.hidden=self.needDone;
    if (keyShow) {
        return;
    }
  
    keyShow = YES;
  
}

- (void)finishAction
{
    
    // 赋值
    if ( self.m_activityField == self.m_orignPriceTextField ) {
        
        self.m_orignPriceTextField.text = [self.m_orignPriceTextField.text stringByAppendingString:@"."];
        
    }else if ( self.m_activityField == self.m_cityPriceTextField ){
        
        self.m_cityPriceTextField.text = [self.m_cityPriceTextField.text stringByAppendingString:@"."];
        
    }else{
        
        self.m_Proportion.text = [self.m_Proportion.text stringByAppendingString:@"."];

    }
}

- (IBAction)showKeyboard:(id)sender
{
    self.needDone = NO;
    self.doneButton.hidden = self.needDone;
}

- (IBAction)hideKeyboard:(id)sender
{
    self.needDone = YES;
    self.doneButton.hidden = self.needDone;
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    self.m_activityField = textField;
    
    if ( textField == self.m_orignPriceTextField || textField == self.m_cityPriceTextField || textField == self.m_Proportion ) {
        
        self.doneButton.userInteractionEnabled = YES;
        
        [self showKeyboard:nil];
        
    }else{
        
        [self hideKeyboard:nil];
    }

}

- (void)textFieldDidEndEditing:(UITextField *)textField{


}

@end
