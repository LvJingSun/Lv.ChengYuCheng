//
//  PaymentQueViewController.m
//  baozhifu
//
//  Created by mac on 13-11-13.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "PaymentQueViewController.h"

//#import "AppHttpClient.h"

#import "CommonUtil.h"

#import "SVProgressHUD.h"


@interface PaymentQueViewController ()

@property (weak, nonatomic) IBOutlet UIView *m_titleView;

@property (weak, nonatomic) IBOutlet UIScrollView *m_scrollerView;

@property (weak, nonatomic) IBOutlet UITextField *payPassword;

@property (weak, nonatomic) IBOutlet UITextField *payConfrimPassword;

@property (weak, nonatomic) IBOutlet UITextField *firstSecurityQ;

@property (weak, nonatomic) IBOutlet UITextField *firstSecurityA;

@property (weak, nonatomic) IBOutlet UITextField *secondSecurityQ;

@property (weak, nonatomic) IBOutlet UITextField *secondSecurityA;

@property (weak, nonatomic) IBOutlet UITextField *thirdSecurityQ;

@property (weak, nonatomic) IBOutlet UITextField *thirdSecurityA;

@property (weak, nonatomic) IBOutlet UITextField *m_validateCode;

@property (nonatomic, strong) NSString *m_FirstId;

@property (nonatomic, strong) NSString *m_SecondId;

@property (nonatomic, strong) NSString *m_ThirdId;


// 保存提交安全问题请求数据
- (IBAction)Safesubmit:(id)sender;
// 获取短信验证码
- (IBAction)sendSMS:(id)sender;

- (IBAction)selectQuestion:(id)sender;

@end

@implementation PaymentQueViewController

@synthesize m_array;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        m_array = [[NSArray alloc]init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self  setTitle:@"设置支付密码"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
   
    self.payPassword.delegate = self;
    
    self.payConfrimPassword.delegate = self;

    self.firstSecurityA.delegate = self;

    self.secondSecurityA.delegate = self;

    self.thirdSecurityA.delegate = self;
    
    self.m_validateCode.delegate = self;
    
    // 设置scrollerView的滚动范围
    if ( isIOS7 ) {
                
        if ( iPhone5 ) {
            
            [self.m_scrollerView setContentSize:CGSizeMake(WindowSizeWidth, 680)];
            
        }else{
                        
            [self.m_scrollerView setContentSize:CGSizeMake(WindowSizeWidth, 700)];
            
        }
       
    }else{
        
        [self.m_scrollerView setContentSize:CGSizeMake(WindowSizeWidth, 700)];
        
    }
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tableviewClick:)];
    
    [self.m_scrollerView addGestureRecognizer:tap];
    
    // 请求问题数据
    [self questionSubmit];
 
}

- (void)tableviewClick:(UITapGestureRecognizer *)recognizer {
    
    [self hidenKeyboard];
    
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    
    
    
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UIScrollViewCellContentView"]) {
        
        return NO;
        
    }
    
    return YES;
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
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

- (void)leftClicked{
    
    [self goBack];
}


- (void)viewDidUnload {
    [self setM_titleView:nil];
    [self setM_scrollerView:nil];
    [self setPayPassword:nil];
    [self setPayConfrimPassword:nil];
    [self setFirstSecurityQ:nil];
    [self setFirstSecurityA:nil];
    [self setSecondSecurityQ:nil];
    [self setSecondSecurityA:nil];
    [self setThirdSecurityQ:nil];
    [self setThirdSecurityA:nil];
    [self setM_validateCode:nil];
    [super viewDidUnload];
}

-(IBAction)selectQuestion:(id)sender {
    
    //    [self.payPassword resignFirstResponder];
    //    [self.payConfrimPassword resignFirstResponder];
    //    [self.txtSmsCode resignFirstResponder];
    
    
    [self.view endEditing:YES];
    
    QuestionViewController *viewController = [[QuestionViewController alloc] initWithNibName:@"QuestionViewController" bundle:nil];
    UIButton *button = (UIButton *)sender;
    
    self.m_index = button.tag;
    
    switch (button.tag) {
        case 101:
            viewController.m_delegate = self;
            viewController.txtQuestion = self.firstSecurityQ;
            
            break;
        case 102:
            viewController.m_delegate = self;
            
            viewController.txtQuestion = self.secondSecurityQ;
            
            break;
        case 103:
            viewController.m_delegate = self;
            
            viewController.txtQuestion = self.thirdSecurityQ;
            
            break;
        default:
            break;
            
    }
    
    viewController.questions = self.m_array;
    
    [self.navigationController pushViewController:viewController animated:YES];
    
}

- (void)getValueId:(NSString *)valueId{
    
    if ( self.m_index == 101 ) {
        
        self.m_FirstId = [NSString stringWithFormat:@"%@",valueId];
        
    }else if ( self.m_index == 102 ){
        
        self.m_SecondId = [NSString stringWithFormat:@"%@",valueId];
        
    }else{
        
        self.m_ThirdId = [NSString stringWithFormat:@"%@",valueId];
        
    }
}

// 请求数据
- (void)questionSubmit{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }

    AppHttpClient* httpClient = [AppHttpClient sharedClient];

    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"MemberSecurityQuestion.ashx" parameters:nil success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            [SVProgressHUD dismiss];

            self.m_array = [json valueForKey:@"Questions"];
            
        } else {
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
    } failure:^(NSError *error) {

        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];
    
    
}

- (IBAction)Safesubmit:(id)sender {
    
    [self.view endEditing:YES];

    NSString *txtpayPassword = self.payPassword.text;
    if (txtpayPassword.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入支付密码"];
        return;
    }
    NSString *txtpayConfrimPassword = self.payConfrimPassword.text;
    if (txtpayConfrimPassword.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入确认支付密码"];
        return;
    }
    if (![txtpayPassword isEqualToString:txtpayConfrimPassword]) {
        [SVProgressHUD showErrorWithStatus:@"输入支付密码和确认支付密码不一致，请重新输入支付密码"];
        return;
    }
    NSString *txtfirstSecurityQ = self.firstSecurityQ.text;
    if (txtfirstSecurityQ.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择第一个提示问题"];
        return;
    }
    NSString *txtfirstSecurityA = self.firstSecurityA.text;
    if (txtfirstSecurityA.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请回答第一个提示问题"];
        return;
    }
    NSString *txtsecondSecurityQ = self.secondSecurityQ.text;
    if (txtsecondSecurityQ.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择第二个提示问题"];
        return;
    }
    NSString *txtsecondSecurityA = self.secondSecurityA.text;
    if (txtsecondSecurityA.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请回答第二个提示问题"];
        return;
    }
    NSString *txtthirdSecurityQ = self.thirdSecurityQ.text;
    if (txtthirdSecurityQ.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择第三个提示问题"];
        return;
    }
    NSString *txtthirdSecurityA = self.thirdSecurityA.text;
    if (txtthirdSecurityA.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请回答第三个提示问题"];
        return;
    }
    
    if ([self.m_FirstId isEqualToString:self.m_SecondId] || [self.m_FirstId isEqualToString:self.m_ThirdId] || [self.m_SecondId isEqualToString:self.m_ThirdId]) {
        [SVProgressHUD showErrorWithStatus:@"您填写的安全问题重复，请重新选择"];
        
        return;
    }
    
    NSString *txtSmsCode = self.m_validateCode.text;
    if (txtSmsCode.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入短信验证码"];
        return;
    }
    
   
    
    NSString *questionAnswer = [NSString stringWithFormat:@"%@,%@|%@,%@|%@,%@",
                                self.m_FirstId, txtfirstSecurityA,
                                self.m_SecondId, txtsecondSecurityA,
                                self.m_ThirdId, txtthirdSecurityA];
    
//    memberId	会员ID
//    psdConfirm	确认密码
//    password	新密码
//    smsCode	短信验证码
//    questionAnswer	密保问题Q1,A1|Q2,A2
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,                            @"memberId",
                           key,                                 @"key",
                           self.payPassword.text,               @"password",
                           self.payConfrimPassword.text,        @"psdConfirm",
                           self.m_validateCode.text,            @"smsCode",
                           questionAnswer,                      @"questionAnswer",
                           nil];
    
    [SVProgressHUD showWithStatus:@"信息提交中"];
  
    [httpClient request:@"PaymentSecuritySettings.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showSuccessWithStatus:msg];

            [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(BackLast) userInfo:self repeats:NO];
           
        } else {
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
    } failure:^(NSError *error) {

        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];
    
}

- (void)BackLast{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)sendSMS:(id)sender {
    
    [self.view endEditing:YES];
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    if (self.clickDateTime != nil) {
        NSTimeInterval timeDiff = [self.clickDateTime timeIntervalSinceNow];
        //NSLog(@"%.0f", ABS(timeDiff));
        if (ABS(timeDiff) < 120) {
            [SVProgressHUD showErrorWithStatus:@"短信已发送，请过2分钟后再发送。"];
            return;
        }
    }
    
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,     @"memberId",
                           key,   @"key",
                           nil];
    [SVProgressHUD showWithStatus:@"验证码发送中"];
    [httpClient request:@"ChangePayPasswordSendSmsCode.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            self.clickDateTime = [[NSDate alloc] init];
            
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showSuccessWithStatus:msg];
            
            //            [SVProgressHUD dismiss];
        } else {
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
    } failure:^(NSError *error) {
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];

    
}

//隐藏键盘的方法
-(void)hidenKeyboard {
    
    if ( isIOS7 ) {
        
        if ( iPhone5 ) {
            
            [self.m_scrollerView setContentSize:CGSizeMake(WindowSizeWidth, 700)];
            
        }else{
            
            [self.m_scrollerView setContentSize:CGSizeMake(WindowSizeWidth, 700)];
            
        }
    }else{
        
        [self.m_scrollerView setContentSize:CGSizeMake(WindowSizeWidth, 640)];
        
    }
    
    [self.payConfrimPassword resignFirstResponder];
    [self.payPassword resignFirstResponder];
    [self.firstSecurityA resignFirstResponder];
    [self.firstSecurityQ resignFirstResponder];
    
    [self.secondSecurityA resignFirstResponder];
    [self.secondSecurityQ resignFirstResponder];
    [self.thirdSecurityA resignFirstResponder];
    [self.thirdSecurityQ resignFirstResponder];
    [self.m_validateCode resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)sender {
    [self hidenKeyboard];
    return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField == self.payPassword || textField == self.payConfrimPassword) {
        
        NSInteger existedLength = textField.text.length;
        
        NSInteger selectedLength = range.length;
        
        NSInteger replaceLength = string.length;
        
        if (replaceLength == 0) {
            
            return YES;
            
        }
        
        if (existedLength - selectedLength + replaceLength > 6) {
            
            [self hidenKeyboard];
            
            return NO;
            
        }
        
    }

    return YES;
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    [self hidenKeyboard];
    
}

//UITextField的协议方法，当开始编辑时监听
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    
    
    if (textField == self.payPassword
        || textField == self.payConfrimPassword
        || textField == self.firstSecurityA
        || textField == self.secondSecurityA
        || textField == self.thirdSecurityA) {

        [self hiddenNumPadDone:nil];
    }
    if (textField == self.m_validateCode) {

        [self showNumPadDone:nil];
    }

    if ( isIOS7 ) {
        
        if ( iPhone5 ) {
            
            [self.m_scrollerView setContentSize:CGSizeMake(WindowSizeWidth, 800)];

        }else{
            
            [self.m_scrollerView setContentSize:CGSizeMake(WindowSizeWidth, 800)];

        }
    }else{
        
        [self.m_scrollerView setContentSize:CGSizeMake(WindowSizeWidth, 800)];

    }
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
}

@end
