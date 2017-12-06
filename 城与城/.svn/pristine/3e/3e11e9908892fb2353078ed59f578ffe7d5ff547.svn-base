//
//  ApplicationCodeViewController.m
//  baozhifu
//
//  Created by mac on 13-12-24.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "ApplicationCodeViewController.h"

#import "CommonUtil.h"

#import "SVProgressHUD.h"

#import "AppHttpClient.h"

#import <QuartzCore/QuartzCore.h>

@interface ApplicationCodeViewController ()

@property (weak, nonatomic) IBOutlet UIView *m_titleView;

@property (weak, nonatomic) IBOutlet UIView *m_tempView;

@property (weak, nonatomic) IBOutlet UILabel *m_memberLabel;

@property (weak, nonatomic) IBOutlet UITextField *m_maxCount;

@property (weak, nonatomic) IBOutlet UITextField *m_timeTextField;

@property (weak, nonatomic) IBOutlet UITextView *m_description;

@property (weak, nonatomic) IBOutlet UIButton *m_timeBtn;

@property (weak, nonatomic) IBOutlet UIButton *m_submitBtn;

// 有效时间选择
- (IBAction)timeChoose:(id)sender;
// 提交申请
- (IBAction)submit:(id)sender;

@end

@implementation ApplicationCodeViewController

@synthesize m_datePicker;

@synthesize m_toolbar;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.isSelected = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   
    [self setTitle:@"立即申请"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    // 初始化pickerView
    [self initWithPickerView];
    
    [self.m_datePicker setHidden:YES];
    
    [self.m_toolbar setHidden:YES];
    
    // 赋值
    self.m_memberLabel.text = [NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:MEMBERCODE]];
    
    // 设置textView的边框
    self.m_description.layer.borderWidth = 1.0f;
    self.m_description.layer.borderColor = [UIColor colorWithRed:215/255.0 green:215/255.0 blue:215/255.0 alpha:1.0].CGColor;
    self.m_description.layer.cornerRadius = 2.0f;
    
    self.m_maxCount.layer.borderWidth = 1.0f;
    self.m_maxCount.layer.borderColor = [UIColor colorWithRed:215/255.0 green:215/255.0 blue:215/255.0 alpha:1.0].CGColor;
    
    self.m_timeTextField.layer.borderWidth = 1.0f;
    self.m_timeTextField.layer.borderColor = [UIColor colorWithRed:215/255.0 green:215/255.0 blue:215/255.0 alpha:1.0].CGColor;
    
    self.m_timeTextField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 5,  self.m_timeTextField.frame.size.height)];
    self.m_timeTextField.leftViewMode = UITextFieldViewModeAlways;
    
    self.m_maxCount.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 5,  self.m_maxCount.frame.size.height)];
    self.m_maxCount.leftViewMode = UITextFieldViewModeAlways;
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self hideTabBar:YES];

}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [self hideTabBar:NO];

    
    // 隐藏pickerView和toolBar
    [m_datePicker setHidden:YES];
    
	[m_toolbar setHidden:YES];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setM_titleView:nil];
    [self setM_tempView:nil];
    [self setM_memberLabel:nil];
    [self setM_maxCount:nil];
    [self setM_timeTextField:nil];
    [self setM_description:nil];
    [self setM_submitBtn:nil];
    [self setM_timeBtn:nil];
    [super viewDidUnload];
}

- (void)leftClicked{
    
    [self goBack];
}

- (void)requestSubmitCode{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    //邀请上限人数、有效日期、描述
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,     @"memberId",
                           key,   @"key",
                           [NSString stringWithFormat:@"%@",self.m_maxCount.text],@"maxInvitedNumber",
                           [NSString stringWithFormat:@"%@",self.m_timeTextField.text],@"expirationDate",
                           [NSString stringWithFormat:@"%@",self.m_description.text],@"descript",
                           @"0",@"publicInviteCodeId",
                           nil];
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"MemberInviteCodeAdd.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
                        
            NSString *msg = [json valueForKey:@"msg"];
            
            NSLog(@"msg = %@",msg);
            
            [SVProgressHUD showSuccessWithStatus:@"申请成功,正在审核中"];
            
            // 提交成功
            [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(LastView) userInfo:nil repeats:NO];
            
            
        } else {
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
    } failure:^(NSError *error) {
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];
    
}

- (void)LastView{
    
    // 返回付款页面
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count - 3] animated:YES];
}


#pragma mark - BtnClicked
- (IBAction)timeChoose:(id)sender {
    
    [self.view endEditing:YES];
    
    self.m_datePicker.hidden = NO;
    
    self.m_toolbar.hidden = NO;
    
}

- (IBAction)submit:(id)sender {
    
    [self hidenKeyboard];
    
    if ( self.m_maxCount.text.length == 0 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请输入邀请上限"];
        
        return;
    }
    
    if ( self.m_description.text.length == 0 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请输入申请描述"];
        
        return;
    }
    
    // 提交服务器
    [self requestSubmitCode];
    
    
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
    
    
//    UIView *view = [[UIView alloc]initWithFrame: CGRectMake(0, m_datePicker.frame.origin.y - 44, 320, 44)];
//    view.backgroundColor = [UIColor blackColor];
//    view.alpha = 0.6;
    
    // view上面的取消、确定按钮
//    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    
//    cancelBtn.backgroundColor = [UIColor blackColor];
//    
//    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
//    
//    [cancelBtn setBackgroundImage:[UIImage imageNamed:@"button_m.png"] forState:UIControlStateNormal];
//
//    [cancelBtn setFrame:CGRectMake(20, 7, 60, 30)];
//    
//    [cancelBtn addTarget:self action:@selector(doPCAPickerCancel:) forControlEvents:UIControlEventTouchUpInside];
//    
//    [view addSubview:cancelBtn];
//    
//    
//    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    
//    sureBtn.backgroundColor = [UIColor blackColor];
//    
//    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
//    
//    [sureBtn setBackgroundImage:[UIImage imageNamed:@"button_m.png"] forState:UIControlStateNormal];
//    
//    [sureBtn setFrame:CGRectMake(240, 7, 60, 30)];
//    
//    [sureBtn addTarget:self action:@selector(doPCAPickerDone:) forControlEvents:UIControlEventTouchUpInside];
//    
//    [view addSubview:sureBtn];
//    
//    self.m_toolbar = view;
    
    UIToolbar *pickerBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.m_datePicker.frame.origin.y - 44, WindowSizeWidth, 44)];
    pickerBar.barStyle = UIBarStyleBlackTranslucent;
    
    UIBarButtonItem *cancelBarButton = [[UIBarButtonItem alloc] initWithTitle:@"取消"
                                                                        style:UIBarButtonItemStyleDone
                                                                       target:self
                                                                       action:@selector(doPCAPickerCancel:)];
    
    UIBarButtonItem *spaceButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                    target:nil
                                                                                    action:nil];
    
    
    UIBarButtonItem *lastButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成"
                                                                       style:UIBarButtonItemStyleDone
                                                                      target:self
                                                                      action:@selector(doPCAPickerDone:)];
    
    NSArray *pickArray = [NSArray arrayWithObjects: cancelBarButton, spaceButtonItem, lastButtonItem, nil];
    [pickerBar setItems:pickArray animated:YES];
    [window addSubview:pickerBar];
    pickerBar.backgroundColor = [UIColor clearColor];
    self.m_toolbar = pickerBar;
    
    [window addSubview:self.m_toolbar];
    
    // 赋值
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYY-MM-dd"];
    
    NSString *str = [formatter stringFromDate:m_datePicker.date];

    self.m_timeTextField.text = [NSString stringWithFormat:@"%@",str];
    
    self.m_temporaryDate = [NSString stringWithFormat:@"%@",str];
}

#pragma mark - PickerBar按钮
- (void)doPCAPickerDone:(id)sender{
    
    [self.m_datePicker setHidden:YES];
    
    [self.m_toolbar setHidden:YES];
        
    if ( self.isSelected ) {
        
        self.m_timeTextField.text = [NSString stringWithFormat:@"%@",self.m_dataString];

    }else{
        
        self.m_timeTextField.text = [NSString stringWithFormat:@"%@",self.m_temporaryDate];
        
    }
    
    self.m_temporaryDate = [NSString stringWithFormat:@"%@",self.m_timeTextField.text];
    
}

- (void)doPCAPickerCancel:(id)sender{

    [self.m_datePicker setHidden:YES];
    
    [self.m_toolbar setHidden:YES];
    
    self.m_timeTextField.text = [NSString stringWithFormat:@"%@",self.m_temporaryDate];

}

// pickerView的选择事件
- (void) togglePicker:(id)sender{
    
    self.isSelected = YES;
    
    // 判断不能选择今天日期以后的时间
    if ( [m_datePicker.date compare:[NSDate date]] == NSOrderedAscending ) {
        [m_datePicker setDate:[NSDate date] animated:YES];
    }
    
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYY-MM-dd"];
    
    NSString *str = [formatter stringFromDate:m_datePicker.date];
    
    self.m_dataString = [NSString stringWithFormat:@"%@",str];
    
//    self.m_timeTextField.text = [NSString stringWithFormat:@"%@",self.m_dataString];
    
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)sender {
    
    [self hidenKeyboard];
    
    return YES;
    
}

//UITextField的协议方法，当开始编辑时监听
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    if ( textField == self.m_maxCount ) {
        
//        NSTimeInterval animationDuration=0.30f;
//        [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
//        [UIView setAnimationDuration:animationDuration];
//        float width = self.view.frame.size.width;
//        float height = self.view.frame.size.height;
//        CGRect rect=CGRectMake(0.0f,0,width,height);
//        self.view.frame=rect;
//        [UIView commitAnimations];
        
        
    }
    
    return YES;
    
}

//恢复原始视图位置
-(void)resumeView {
    NSTimeInterval animationDuration=0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    float width = self.view.frame.size.width;
    float height = self.view.frame.size.height;
    float Y = 0.0f;
    CGRect rect=CGRectMake(0.0f,Y,width,height);
    self.view.frame=rect;
    [UIView commitAnimations];
}


#pragma mark - UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView{
    
    if ( textView == self.m_description ) {
        
        [self hiddenNumPadDone:nil];
    }
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    
//    NSTimeInterval animationDuration=0.30f;
//    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
//    [UIView setAnimationDuration:animationDuration];
//    float width = self.view.frame.size.width;
//    float height = self.view.frame.size.height;
//    CGRect rect=CGRectMake(0.0f,-90,width,height);
//    self.view.frame=rect;
//    [UIView commitAnimations];
    
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    
    [textView resignFirstResponder];
    
//    [self resumeView];
    
}

-(void)hidenKeyboard {
    
    [self.view endEditing:YES];
    
//    [self resumeView];
}

@end
