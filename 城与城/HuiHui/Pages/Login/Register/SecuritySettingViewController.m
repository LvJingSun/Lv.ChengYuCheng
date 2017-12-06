//
//  SecuritySettingViewController.m
//  baozhifu
//
//  Created by mac on 13-9-8.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "SecuritySettingViewController.h"
#import "QuestionViewController.h"
#import "CommonUtil.h"
#import "AppHttpClient.h"
#import "SVProgressHUD.h"
#import "AgreementViewController.h"
#import "PictureViewController.h"

@interface SecuritySettingViewController ()

@property (weak, nonatomic) IBOutlet UITextField *payPassword;

@property (weak, nonatomic) IBOutlet UITextField *payConfrimPassword;

@property (weak, nonatomic) IBOutlet UITextField *firstSecurityQ;

@property (weak, nonatomic) IBOutlet UITextField *firstSecurityA;

@property (weak, nonatomic) IBOutlet UITextField *secondSecurityQ;

@property (weak, nonatomic) IBOutlet UITextField *secondSecurityA;

@property (weak, nonatomic) IBOutlet UITextField *thirdSecurityQ;

@property (weak, nonatomic) IBOutlet UITextField *thirdSecurityA;

@property (weak, nonatomic) IBOutlet UIView *m_titleView;

@property (nonatomic, strong) NSString *m_FirstId;

@property (nonatomic, strong) NSString *m_SecondId;

@property (nonatomic, strong) NSString *m_ThirdId;

@property (weak, nonatomic) IBOutlet UIScrollView *m_scrollerView;


@property (weak, nonatomic) IBOutlet UITextField *txtSmsCode;
// 选择框
@property (weak, nonatomic) IBOutlet UIButton *m_ckeckBtn;

-(IBAction)selectQuestion:(id)sender;

- (IBAction)submit:(id)sender;

- (IBAction)sendSMS:(id)sender;
// 是否同意注册协议
- (IBAction)btnClicked:(id)sender;
// 点击注册协议进入注册协议的页面
- (IBAction)agreementClicked:(id)sender;
// 跳过该页面的填写
- (IBAction)jumpStep:(id)sender;
// 下一步-填写信息请求数据
- (IBAction)nextStep:(id)sender;


@end

@implementation SecuritySettingViewController

@synthesize isChecked;

@synthesize m_array;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        isChecked = YES;
        
        m_array = [[NSMutableArray alloc]initWithCapacity:0];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
        
    [self setTitle:@"支付设置"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    
    [self.m_scrollerView setContentSize:CGSizeMake(WindowSizeWidth, 580)];

    
    if ( [self.m_typeString isEqualToString:@"1"] ) {
        
        // 赋值
        self.payPassword.text = [CommonUtil getValueByKey:R_PAYPASSW];
        self.payConfrimPassword.text = [CommonUtil getValueByKey:R_AGAINPAYPASSW];
        self.firstSecurityQ.text = [CommonUtil getValueByKey:R_QUESTION_FIRST];
        self.secondSecurityQ.text = [CommonUtil getValueByKey:R_QUESTION_SECOND];
        self.thirdSecurityQ.text = [CommonUtil getValueByKey:R_QUESTION_THIRD];
        self.firstSecurityA.text = [CommonUtil getValueByKey:R_ANSWER_FIRST];
        self.secondSecurityA.text = [CommonUtil getValueByKey:R_ANSWER_SECOND];
        self.thirdSecurityA.text = [CommonUtil getValueByKey:R_ANSWER_THIRD];
        self.m_FirstId = [CommonUtil getValueByKey:R_QUESTION_FIRST_ID];
        self.m_SecondId = [CommonUtil getValueByKey:R_QUESTION_SECOND_ID];
        self.m_ThirdId = [CommonUtil getValueByKey:R_QUESTION_THIRD_ID];
        
   
    }else{
        
        // 请求问题数据
        [self questionSubmit];

    }
    
        
    self.payPassword.delegate = self;
    self.payConfrimPassword.delegate = self;
    //self.firstSecurityQ.delegate = self;
    self.firstSecurityA.delegate = self;
    //self.secondSecurityQ.delegate = self;
    self.secondSecurityA.delegate = self;
    //self.thirdSecurityQ.delegate = self;
    self.thirdSecurityA.delegate = self;
    self.txtSmsCode.delegate = self;
    
    
        
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self hideTabBar:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [self hideTabBar:NO];
}

- (void)leftClicked{
    
    [self goBack];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 请求数据
- (void)questionSubmit{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    
    //    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    //    NSString *key = [CommonUtil getServerKey];
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    //    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
    //                           memberId,     @"memberId",
    //                           status,     @"status",
    //                           key,   @"key",
    //                           nil];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"MemberSecurityQuestion.ashx" parameters:nil success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            [SVProgressHUD dismiss];
//            NSString *msg = [json valueForKey:@"msg"];
            
            self.m_array = [json valueForKey:@"Questions"];
            
            
        } else {
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
    } failure:^(NSError *error) {
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];
    
    
}


-(IBAction)selectQuestion:(id)sender {
    
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
    
    // 判断来自于哪个页面
    if ( [self.m_typeString isEqualToString:@"1"] ) {
        
        viewController.questions = [self.registInfo objectForKey:@"questioninfo"];

    }else{
        
        viewController.questions = self.m_array;

    }
        
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
    
    if ( [self.m_typeString isEqualToString:@"1"] ) {
       
        [CommonUtil addValue:self.firstSecurityQ.text andKey:R_QUESTION_FIRST];
        [CommonUtil addValue:self.secondSecurityQ.text andKey:R_QUESTION_SECOND];
        [CommonUtil addValue:self.thirdSecurityQ.text andKey:R_QUESTION_THIRD];
        [CommonUtil addValue:self.m_FirstId andKey:R_QUESTION_FIRST_ID];
        [CommonUtil addValue:self.m_SecondId andKey:R_QUESTION_SECOND_ID];
        [CommonUtil addValue:self.m_ThirdId andKey:R_QUESTION_THIRD_ID];
   
    }else{
        
        
    }
   
}

- (IBAction)sendSMS:(id)sender {
    
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
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           [self.registInfo objectForKey:@"Phone"], @"Phone",
                           [self.registInfo objectForKey:@"MemberInviteId"],@"MemberInviteId",
                           nil];
    [SVProgressHUD showWithStatus:@"验证码发送中"];
    [httpClient request:@"RegInviteVldSMS.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            self.clickDateTime = [[NSDate alloc] init];
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showSuccessWithStatus:msg];
            
        } else {
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
    } failure:^(NSError *error) {
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];
}

// 进入注册协议
- (IBAction)btnClicked:(id)sender {
    
    [self.view endEditing:YES];
    
    AgreementViewController *VC = [[AgreementViewController alloc]initWithNibName:@"AgreementViewController" bundle:nil];
    
    [self.navigationController pushViewController:VC animated:YES];
}


- (IBAction)submit:(id)sender {
    
    [self.view endEditing:YES];
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    
    if ( !self.isChecked ) {
        
        [SVProgressHUD showErrorWithStatus:@"请先同意注册协议"];
        
        return;
    }
    
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
    
    NSString *txtSmsCode = self.txtSmsCode.text;
    
    if (txtSmsCode.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入短信验证码"];
        return;
    }
    
    [self.registInfo setObject:txtSmsCode forKey:@"smsCode"];
    
    NSString *questionAnswer = [NSString stringWithFormat:@"%@,%@|%@,%@|%@,%@",
                                self.m_FirstId, txtfirstSecurityA,
                                self.m_SecondId, txtsecondSecurityA,
                                self.m_ThirdId, txtthirdSecurityA];
    
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           [self.registInfo objectForKey:@"InviteName"],     @"RealName",
                           [self.registInfo objectForKey:@"NickName"],       @"NickName",
                           [self.registInfo objectForKey:@"Email"],          @"Email",
                           [self.registInfo objectForKey:@"PassWord"],       @"PassWord",
                           [self.registInfo objectForKey:@"smsCode"],        @"smsCode",
                           [self.registInfo objectForKey:@"InviteCode"],     @"InviteCode",
                           [self.registInfo objectForKey:@"Phone"],          @"Phone",
                           txtpayPassword,                                   @"PaymentPwd",
                           txtpayConfrimPassword,                            @"ConfirmPaymentPwd",
                           questionAnswer,                                   @"questionAnswer",
                           nil];
    
    [SVProgressHUD showWithStatus:@"信息提交中"];
    
    [httpClient multiRequest:@"RegInviteSubmit.ashx" parameters:param files:self.m_imgVDic success:^(NSJSONSerialization* json){
        //    [httpClient request:@"RegInviteSubmit.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showSuccessWithStatus:msg];
            NSArray *views = self.navigationController.viewControllers;
            [self.navigationController popToViewController:[views objectAtIndex:1] animated:YES];
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
    [self.payPassword resignFirstResponder];
    [self.payConfrimPassword resignFirstResponder];
    [self.firstSecurityA resignFirstResponder];
    [self.secondSecurityA resignFirstResponder];
    [self.thirdSecurityA resignFirstResponder];
    [self.txtSmsCode resignFirstResponder];
    
    
    if ( isIOS7 ) {
        
        if ( iPhone5 ) {
          
            [self.m_scrollerView setContentSize:CGSizeMake(WindowSizeWidth, 680)];
            
        }else{
            
            [self.m_scrollerView setContentSize:CGSizeMake(WindowSizeWidth, 680)];
            
        }
    }else{
        
        [self.m_scrollerView setContentSize:CGSizeMake(WindowSizeWidth, 640)];

    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    if ( [self.m_typeString isEqualToString:@"1"] ) {
        
        // 保存数据
        
        [CommonUtil addValue:self.payPassword.text andKey:R_PAYPASSW];
        [CommonUtil addValue:self.payConfrimPassword.text andKey:R_AGAINPAYPASSW];
        
        [CommonUtil addValue:self.firstSecurityA.text andKey:R_ANSWER_FIRST];
        [CommonUtil addValue:self.secondSecurityA.text andKey:R_ANSWER_SECOND];
        [CommonUtil addValue:self.thirdSecurityA.text andKey:R_ANSWER_THIRD];

    }else{
        
        
    }
   
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)sender {
    [self hidenKeyboard];
    return YES;
}

//UITextField的协议方法，当开始编辑时监听
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    if (textField == self.payPassword
        || textField == self.payConfrimPassword
        || textField == self.firstSecurityA
        || textField == self.secondSecurityA
        || textField == self.thirdSecurityA) {
        self.needHiddenDone = YES;
        [self hiddenNumPadDone:nil];
    }
    
    if (textField == self.txtSmsCode) {
        self.needHiddenDone = NO;
        [self showNumPadDone:nil];
    }
   
    self.activeField = textField;
    
    
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

- (void)viewDidUnload {
    [self setTxtSmsCode:nil];
    [self setM_scrollerView:nil];
    [super viewDidUnload];
}

- (IBAction)agreementClicked:(id)sender {

    self.isChecked = !self.isChecked;
    
    if ( self.isChecked ) {
        
        [self.m_ckeckBtn setImage:[UIImage imageNamed:@"comm_check_box_selected.png"] forState:UIControlStateNormal];
  
    }else{

        [self.m_ckeckBtn setImage:[UIImage imageNamed:@"comm_check_box_def.png"] forState:UIControlStateNormal];
    }
  
}

- (IBAction)jumpStep:(id)sender {
    
    [self.view endEditing:YES];
    
    // 直接跳过该页面时支付密码填写的一些信息为空
    [self.registInfo setObject:@"" forKey:@"PaymentPwd"];
    [self.registInfo setObject:@"" forKey:@"ConfirmPaymentPwd"];
    [self.registInfo setObject:@"" forKey:@"questionAnswer"];
    
    // 进入头像上传的页面
    PictureViewController *viewController = [[PictureViewController alloc]initWithNibName:@"PictureViewController" bundle:nil];
    viewController.registInfo = self.registInfo;
    viewController.m_typeSteing = self.m_typeString;
    [self.navigationController pushViewController:viewController animated:YES];
}

- (IBAction)nextStep:(id)sender {
    
    [self.view endEditing:YES];

    // 判断是否填写值
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
    
    NSString *questionAnswer = [NSString stringWithFormat:@"%@,%@|%@,%@|%@,%@",
                                self.m_FirstId, txtfirstSecurityA,
                                self.m_SecondId, txtsecondSecurityA,
                                self.m_ThirdId, txtthirdSecurityA];
       
    
    // 将信息保存起来传入下一个页面
    [self.registInfo setObject:txtpayPassword forKey:@"PaymentPwd"];
    [self.registInfo setObject:txtpayConfrimPassword forKey:@"ConfirmPaymentPwd"];
    [self.registInfo setObject:questionAnswer forKey:@"questionAnswer"];
    
    
    // 进入头像上传的页面
    PictureViewController *viewController = [[PictureViewController alloc]initWithNibName:@"PictureViewController" bundle:nil];
    viewController.registInfo = self.registInfo;
    viewController.m_typeSteing = self.m_typeString;
    [self.navigationController pushViewController:viewController animated:YES];

    
}

@end
