//
//  InviteWelcomViewController.m
//  baozhifu
//
//  Created by mac on 13-8-14.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "InviteWelcomViewController.h"
#import "RTLabel.h"
#import "CommonUtil.h"
//#import "AppHttpClient.h"
#import "SVProgressHUD.h"
#import "SecuritySettingViewController.h"


@interface InviteWelcomViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *photo;

@property (weak, nonatomic) IBOutlet RTLabel *txtWelcome;

@property (weak, nonatomic) IBOutlet UILabel *txtMemberInviteId;

@property (weak, nonatomic) IBOutlet UITextField *txtRealName;

@property (weak, nonatomic) IBOutlet UITextField *txtNickName;

@property (weak, nonatomic) IBOutlet UITextField *txtEmail;

@property (weak, nonatomic) IBOutlet UITextField *txtPassWord;

@property (weak, nonatomic) IBOutlet UITextField *txtConfirmPassWord;

@property (weak, nonatomic) IBOutlet UITextField *txtSmsCode;

@property (weak, nonatomic) IBOutlet UIView *m_titleView;

@property (weak, nonatomic) IBOutlet UIScrollView *m_scollerView;



- (IBAction)sendSMS:(id)sender;

- (IBAction)submit:(id)sender;

@end

@implementation InviteWelcomViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setTitle:@"邀请注册"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    // 赋值
    self.txtNickName.text = [CommonUtil getValueByKey:R_USERNAME];
    self.txtEmail.text = [CommonUtil getValueByKey:R_EMAIL];
    self.txtPassWord.text = [CommonUtil getValueByKey:R_LOGINPASSW];
    self.txtConfirmPassWord.text = [CommonUtil getValueByKey:R_AGAINPASSW];
    self.txtSmsCode.text = [CommonUtil getValueByKey:R_VALIDATECODE];
    
    // 设置scrolelrView的滚动范围
    [self.m_scollerView setContentSize:CGSizeMake(WindowSizeWidth, 580)];

    self.txtNickName.delegate = self;
    self.txtEmail.delegate = self;
    self.txtPassWord.delegate = self;
    self.txtConfirmPassWord.delegate = self;
    self.txtSmsCode.delegate = self;
   
    // 图片赋值
    NSString *url = [self.registInfo objectForKey:@"PhotoMidUrl"];
    if (url) {
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]];
        self.photo.image = [CommonUtil scaleImage:image toSize:CGSizeMake(60, 60)];
    }
    self.txtWelcome.text = [self.registInfo objectForKey:@"Content"];
    self.txtRealName.text = [self.registInfo objectForKey:@"InviteName"];
//    NSInteger number = [[self.registInfo objectForKey:@"MemberInviteId"] intValue];
//    self.txtMemberInviteId.text = [NSString stringWithFormat:@"完善一下您的基础信息，让新老朋友都来认识你！在此之前已有 %d 位朋友受邀注册", number];
    
     self.txtMemberInviteId.text = [NSString stringWithFormat:@"完善一下您的基础信息，让新老朋友都来认识你！"];
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

- (IBAction)submit:(id)sender {
    
    [self.view endEditing:YES];
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    NSString *txtNickName = self.txtNickName.text;
    if (txtNickName.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入昵称"];
        return;
    }
    NSString *txtEmail = self.txtEmail.text;
    if (txtEmail.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入邮箱"];
        return;
    }
    if ( ![self isValidateEmail:self.txtEmail.text] ) {
        
        [SVProgressHUD showErrorWithStatus:@"您输入的邮箱有误，请重新输入"];
        return;
    }
    
    NSString *txtPassWord = self.txtPassWord.text;
    if (txtPassWord.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入密码"];
        return;
    }
    NSString *txtConfirmPassWord = self.txtConfirmPassWord.text;
    if (txtConfirmPassWord.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入确认密码"];
        return;
    }
    if (![txtPassWord isEqualToString:txtConfirmPassWord]) {
        [SVProgressHUD showErrorWithStatus:@"输入密码和确认密码不一致，请重新输入密码"];
        return;
    }
    
    NSString *txtSmsCode = self.txtSmsCode.text;
        
    if (self.txtSmsCode.text.length == 0 ) {
        [SVProgressHUD showErrorWithStatus:@"请输入验证码"];
        return;
    }
    
    [self.registInfo setObject:txtNickName forKey:@"NickName"];
    [self.registInfo setObject:txtEmail forKey:@"Email"];
    [self.registInfo setObject:txtPassWord forKey:@"PassWord"];
    [self.registInfo setObject:txtSmsCode forKey:@"smsCode"];
    [self.registInfo setObject:txtConfirmPassWord forKey:@"ConfirmPaymentPwd"];
    
    
    
    // 请求接口验证昵称和邮箱 验证码 是否正确=============
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           self.txtEmail.text,@"email",
                           self.txtNickName.text,@"nickName",
                           self.txtSmsCode.text,@"smsCode",
                           nil];
    [SVProgressHUD showWithStatus:@"信息提交中"];
    [httpClient request:@"RegInviteChecked_1_3_1.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            
            [SVProgressHUD dismiss];
            
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];

            
            // 提交注册
            [self submitRegister];
            
            // 进入安全支付密码填写的页面
            
//            SecuritySettingViewController *viewController = [[SecuritySettingViewController alloc]initWithNibName:@"SecuritySettingViewController" bundle:nil];
//            viewController.registInfo = self.registInfo;
//            viewController.m_typeString = @"1";
//            [self.navigationController pushViewController:viewController animated:YES];
            
            
        } else {
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
    } failure:^(NSError *error) {
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];

}

- (void)submitRegister{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           [self.registInfo objectForKey:@"InviteName"],     @"realName",
                           [self.registInfo objectForKey:@"NickName"],       @"nickName",
                           [self.registInfo objectForKey:@"Email"],          @"email",
                           [self.registInfo objectForKey:@"PassWord"],       @"password",
                           [self.registInfo objectForKey:@"smsCode"],        @"smsCode",
                           [self.registInfo objectForKey:@"InviteCode"],     @"inviteCode",
                           [self.registInfo objectForKey:@"ConfirmPaymentPwd"],@"confirmPassword",
                           nil];
    
    [SVProgressHUD showWithStatus:@"信息提交中"];
    
    [httpClient request:@"RegInviteSubmit_1.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showSuccessWithStatus:msg];
            
            // 返回登录的页面
            [NSTimer scheduledTimerWithTimeInterval:2.0
                                             target:self
                                           selector:@selector(lastView)
                                           userInfo:nil
                                            repeats:NO];
            
        } else {
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
    } failure:^(NSError *error) {
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];
}

- (void)lastView{
    
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:[self.navigationController.viewControllers count] - 3] animated:YES];
}


//隐藏键盘的方法
-(void)hidenKeyboard {
    [self.txtNickName resignFirstResponder];
    [self.txtEmail resignFirstResponder];
    [self.txtPassWord resignFirstResponder];
    [self.txtConfirmPassWord resignFirstResponder];
    [self.txtSmsCode resignFirstResponder];
    
    if ( isIOS7 ) {
        
        if ( iPhone5 ) {
            
            [self.m_scollerView setContentSize:CGSizeMake(WindowSizeWidth, 680)];
            
        }else{
            
            [self.m_scollerView setContentSize:CGSizeMake(WindowSizeWidth, 680)];
            
        }
    }else{
        
        [self.m_scollerView setContentSize:CGSizeMake(WindowSizeWidth, 580)];
        
    }
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)sender {
    [self hidenKeyboard];
    return YES;
}

//UITextField的协议方法，当开始编辑时监听
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField == self.txtNickName
        || textField == self.txtEmail
        || textField == self.txtPassWord
        || textField == self.txtConfirmPassWord) {
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
            
            [self.m_scollerView setContentSize:CGSizeMake(WindowSizeWidth, 800)];
            
        }else{
            
            [self.m_scollerView setContentSize:CGSizeMake(WindowSizeWidth, 800)];
            
        }
    }else{
        
        [self.m_scollerView setContentSize:CGSizeMake(WindowSizeWidth, 800)];
        
    }

    
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    [textField resignFirstResponder];
        
    // 如果值有变化，则重新进行赋值
    [CommonUtil addValue:self.txtNickName.text andKey:R_USERNAME];
    
    [CommonUtil addValue:self.txtEmail.text andKey:R_EMAIL];
    
    [CommonUtil addValue:self.txtPassWord.text andKey:R_LOGINPASSW];
    
    [CommonUtil addValue:self.txtConfirmPassWord.text andKey:R_AGAINPASSW];
    
    [CommonUtil addValue:self.txtSmsCode.text andKey:R_VALIDATECODE];
        
}



@end
