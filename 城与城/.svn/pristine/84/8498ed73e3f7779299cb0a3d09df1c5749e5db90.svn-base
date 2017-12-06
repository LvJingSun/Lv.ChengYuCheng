//
//  ScanRegisterViewController.m
//  baozhifu
//
//  Created by mac on 13-11-28.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "ScanRegisterViewController.h"
#import "RTLabel.h"
#import "CommonUtil.h"
//#import "AppHttpClient.h"
#import "SVProgressHUD.h"
#import "SecuritySettingViewController.h"
#import "HH_PhoneViewController.h"

@interface ScanRegisterViewController ()


@property (weak, nonatomic) IBOutlet UITextField *txtRealName;

@property (weak, nonatomic) IBOutlet UITextField *txtNickName;

@property (weak, nonatomic) IBOutlet UITextField *txtEmail;

@property (weak, nonatomic) IBOutlet UITextField *txtPassWord;

@property (weak, nonatomic) IBOutlet UITextField *txtConfirmPassWord;

@property (weak, nonatomic) IBOutlet UITextField *txtSmsCode;

@property (weak, nonatomic) IBOutlet UIView *m_titleView;

@property (weak, nonatomic) IBOutlet UIScrollView *m_scollerView;

@property (weak, nonatomic) IBOutlet UITextField *m_sexTextField;

@property (weak, nonatomic) IBOutlet UITextField *m_phoneTextField;


- (IBAction)sendSMS:(id)sender;

- (IBAction)submit:(id)sender;

- (IBAction)selectedSex:(id)sender;
// qq登录获取用户信息
- (IBAction)qqLoginClicked:(id)sender;

@end

@implementation ScanRegisterViewController

@synthesize registInfo;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        registInfo = [[NSMutableDictionary alloc]initWithCapacity:0];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
 
    
    [self setTitle:@"邀请注册"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
        
    // 设置scrolelrView的滚动范围
    
    [self.m_scollerView setContentSize:CGSizeMake(WindowSizeWidth, 700)];
    
    self.txtNickName.delegate = self;
    self.txtEmail.delegate = self;
    self.txtPassWord.delegate = self;
    self.txtConfirmPassWord.delegate = self;
    self.txtSmsCode.delegate = self;
    self.txtRealName.delegate = self;
    self.m_phoneTextField.delegate = self;
    self.m_sexTextField.delegate = self;
    
    self.m_sexTextField.userInteractionEnabled = NO;
    
    // 图片赋值
//    NSString *url = [self.registInfo objectForKey:@"PhotoMidUrl"];
//    if (url) {
//        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]];
//        self.photo.image = [CommonUtil scaleImage:image toSize:CGSizeMake(60, 60)];
//    }
//    self.txtWelcome.text = [self.registInfo objectForKey:@"Content"];
//    self.txtRealName.text = [self.registInfo objectForKey:@"InviteName"];
    //    NSInteger number = [[self.registInfo objectForKey:@"MemberInviteId"] intValue];
    //    self.txtMemberInviteId.text = [NSString stringWithFormat:@"完善一下您的基础信息，让新老朋友都来认识你！在此之前已有 %d 位朋友受邀注册", number];
    
    
    // 初始化qq登录
    _permissions = [NSMutableArray arrayWithObjects:
                    kOPEN_PERMISSION_GET_USER_INFO,
                    kOPEN_PERMISSION_GET_SIMPLE_USER_INFO,
                    kOPEN_PERMISSION_GET_INFO,
                    nil];
    _tencentOAuth = [[TencentOAuth alloc] initWithAppId:TencentQzoneAppId andDelegate:self];
    
    _tencentOAuth.redirectURI = @"www.qq.com";
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self hideTabBar:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [self hideTabBar:NO];
}


- (void)viewDidUnload {
    [self setM_sexTextField:nil];
    [self setM_phoneTextField:nil];
    [super viewDidUnload];
}

- (void)leftClicked{
    
//    [self goBack];
    
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:2] animated:YES];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sendSMS:(id)sender {
    
    [self.view endEditing:YES];
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    if ( self.m_phoneTextField.text.length == 0 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请输入手机号码"];
        
        return;
    }
    
    if ( self.m_phoneTextField.text.length != 11 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请输入11位手机号码"];
        
        return;
    }
    
//    if ( ![self isMobileNumber:self.m_phoneTextField.text] ) {
//       
//        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号码格式"];
//        
//        return;
//        
//    }
    
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
                           self.m_phoneTextField.text, @"phone",
                           nil];
    [SVProgressHUD showWithStatus:@"验证码发送中"];
    [httpClient request:@"PublicInviteSMSVld.ashx" parameters:param success:^(NSJSONSerialization* json) {
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


- (IBAction)submit:(id)sender {
    
    [self.view endEditing:YES];
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    NSString *txtRealName = self.txtRealName.text;
    if (txtRealName.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入真实姓名"];
        return;
    }
    
    NSString *txtNickName = self.txtNickName.text;
    if (txtNickName.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入昵称"];
        return;
    }
    
    NSString *txtSex = self.m_sexTextField.text;
    if (txtSex.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入性别"];
        return;
    }else{
        
        if ([@"男" isEqualToString:txtSex]) {
            txtSex = @"Male";
        } else if ([@"女" isEqualToString:txtSex]) {
            txtSex = @"Female";
        }
    }

    NSString *txtPhone = self.m_phoneTextField.text;
    if (txtPhone.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入手机号码"];
        return;
    }
    
    if ( txtPhone.length != 11 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请输入11位手机号码"];
        
        return;
    }
    
//    if ( ![self isMobileNumber:txtPhone] ) {
//        
//        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号码格式"];
//        
//        return;
//        
//    }

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
    
    [self.registInfo setObject:txtRealName forKey:@"RealName"];
    [self.registInfo setObject:txtNickName forKey:@"NickName"];
    [self.registInfo setObject:txtEmail forKey:@"Email"];
    [self.registInfo setObject:txtPassWord forKey:@"PassWord"];
    [self.registInfo setObject:txtSmsCode forKey:@"smsCode"];
    [self.registInfo setObject:txtConfirmPassWord forKey:@"confirmPassword"];
    
    [self.registInfo setObject:txtSex forKey:@"userSex"];
    [self.registInfo setObject:txtPhone forKey:@"Phone"];
        
    // 请求接口验证昵称和邮箱 验证码 是否正确=============
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           [self.registInfo objectForKey:@"RealName"],@"realName",
                           [self.registInfo objectForKey:@"NickName"],@"nickName",
                           [self.registInfo objectForKey:@"Phone"],@"phoneNumber",
                           [self.registInfo objectForKey:@"Email"],@"email",
                           [self.registInfo objectForKey:@"PassWord"],@"password",
                           [self.registInfo objectForKey:@"confirmPassword"],@"confirmPassword",
                           [self.registInfo objectForKey:@"smsCode"],@"smsCode",
                           nil];
    [SVProgressHUD showWithStatus:@"信息提交中"];
    [httpClient request:@"PublicInviteInfoVld.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            
            [SVProgressHUD dismiss];
            
            // 提交注册
            [self submitPublicRegister];

            
            // 进入安全支付密码填写的页面
//            SecuritySettingViewController *viewController = [[SecuritySettingViewController alloc]initWithNibName:@"SecuritySettingViewController" bundle:nil];
//            viewController.registInfo = self.registInfo;
//            viewController.m_typeString = @"2";
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

- (void)submitPublicRegister{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           [self.registInfo objectForKey:@"RealName"],       @"realName",
                           [self.registInfo objectForKey:@"NickName"],       @"nickName",
                           [self.registInfo objectForKey:@"userSex"],        @"sex",
                           [self.registInfo objectForKey:@"Email"],          @"email",
                           [self.registInfo objectForKey:@"PassWord"],       @"password",
                           [self.registInfo objectForKey:@"smsCode"],        @"smsCode",
                           [self.registInfo objectForKey:@"InviteCode"],     @"pubInvCode",
                           [self.registInfo objectForKey:@"Phone"],          @"phoneNumber",
                           [self.registInfo objectForKey:@"confirmPassword"],@"confirmPassword",
                           nil];
    
    [SVProgressHUD showWithStatus:@"信息提交中"];
    
    [httpClient request:@"PublicInviteInfoVld_1.ashx" parameters:param success:^(NSJSONSerialization* json) {
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
    
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:[self.navigationController.viewControllers count] - 4] animated:YES];
}



- (IBAction)selectedSex:(id)sender {
    
    [self.view endEditing:YES];
    
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:@"" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"男",@"女", nil];
   
    [sheet showInView:self.view];
    
}

- (IBAction)qqLoginClicked:(id)sender {
    // qq登录
//    [self qqLogin];
    
    // 调用qq登录的方法，登录成功后则会执行 tencentDidLogin 的代理方法
    [_tencentOAuth authorize:_permissions inSafari:NO];


}

// qq登录成功后执行的方法
- (void)qqLoginSuccess{
    
    // 进入手机绑定的页面
    HH_PhoneViewController *VC = [[HH_PhoneViewController alloc]initWithNibName:@"HH_PhoneViewController" bundle:nil];
    
    [self.navigationController pushViewController:VC animated:YES];
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if ( buttonIndex == 0 ) {
        
        self.m_sexTextField.text = @"男";
        
    }else if ( buttonIndex == 1 ){
        
        self.m_sexTextField.text = @"女";
        
    }else{
        
        
    }
    
    if ( isIOS7 ) {
        
        if ( iPhone5 ) {
            
            [self.m_scollerView setContentSize:CGSizeMake(WindowSizeWidth, 800)];
            
        }else{
            
            [self.m_scollerView setContentSize:CGSizeMake(WindowSizeWidth, 800)];
            
        }
    }else{
        
        [self.m_scollerView setContentSize:CGSizeMake(WindowSizeWidth, 700)];
        
    }

}

//隐藏键盘的方法
- (void)hidenKeyboard {
    [self.txtRealName resignFirstResponder];
    [self.txtNickName resignFirstResponder];
    [self.txtEmail resignFirstResponder];
    [self.txtPassWord resignFirstResponder];
    [self.txtConfirmPassWord resignFirstResponder];
    [self.txtSmsCode resignFirstResponder];
    [self.m_sexTextField resignFirstResponder];
    [self.m_phoneTextField resignFirstResponder];
    
    if ( isIOS7 ) {
        
        if ( iPhone5 ) {
            
            [self.m_scollerView setContentSize:CGSizeMake(WindowSizeWidth, 800)];
            
        }else{
            
            [self.m_scollerView setContentSize:CGSizeMake(WindowSizeWidth, 800)];
            
        }
    }else{
        
        [self.m_scollerView setContentSize:CGSizeMake(WindowSizeWidth, 700)];
        
    }
    
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)sender {
    [self hidenKeyboard];
    return YES;
}

//UITextField的协议方法，当开始编辑时监听
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField == self.txtNickName
        || textField == self.txtRealName
        || textField == self.txtEmail
        || textField == self.txtPassWord
        || textField == self.txtConfirmPassWord) {
        self.needHiddenDone = YES;
        [self hiddenNumPadDone:nil];
    }
    if (textField == self.txtSmsCode || textField == self.m_phoneTextField) {
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
    
}


#pragma mark - 登录成功后执行的代理方法
- (void)tencentDidLogin {
	// 登录成功
    //	_labelTitle.text = @"登录完成";
    
    
    if (_tencentOAuth.accessToken
        && 0 != [_tencentOAuth.accessToken length])
    {
        
        NSLog(@"token = %@",_tencentOAuth.accessToken);
        
        NSLog(@"openId = %@",_tencentOAuth.openId);
        
        NSLog(@"expirationDate = %@",_tencentOAuth.expirationDate);
    
        // 获取用户的信息，成功的话则会执行 getUserInfoResponse 的代理方法
        if( ![_tencentOAuth getUserInfo] ){
            
            [self showInvalidTokenOrOpenIDMessage];
        }
        
        
    }
    else
    {
        //        _labelAccessToken.text = @"登录不成功 没有获取accesstoken";
    }
    
}

- (void)tencentDidNotLogin:(BOOL)cancelled
{
    
    if ( cancelled ){
        
		[SVProgressHUD showErrorWithStatus:@"用户取消登录"];
        
	}
	else {
        
		[SVProgressHUD showErrorWithStatus:@"登录失败"];
	}
	
}


- (void)tencentDidNotNetWork
{
    
    [SVProgressHUD showErrorWithStatus:@"无网络连接，请设置网络"];
    
}

- (void)showInvalidTokenOrOpenIDMessage{
    
    [SVProgressHUD showErrorWithStatus:@"可能授权已过期，请重新登录获取"];
    
    [self performSelector:@selector(qqAuthLogin) withObject:nil afterDelay:2.0];
    
}

// qq授权
-(void)qqAuthLogin
{

    // 清空token及openId的值
    [CommonUtil addValue:@"(null)" andKey:QQAccessTokenKey];
    [CommonUtil addValue:@"(null)" andKey:QQCurrentUserIdKey];
    
    // 重新调用qq登录的方法
    [_tencentOAuth authorize:_permissions inSafari:NO];
}


// Called when the get_user_info has response.
#pragma mark - 获取个人信息成功后执行的代理方法
- (void)getUserInfoResponse:(APIResponse*) response {
	
    if (response.retCode == URLREQUEST_SUCCEED)
	{
        
        // qq昵称
        NSLog(@"nickname = %@",[response.jsonResponse objectForKey:@"nickname"]);
        // 所在地区
        NSLog(@"province = %@",[response.jsonResponse objectForKey:@"province"]);
        // 性别
        NSLog(@"gender = %@",[response.jsonResponse objectForKey:@"gender"]);
        //空间头像 50*50
        NSLog(@"figureurl_1 = %@",[response.jsonResponse objectForKey:@"figureurl_1"]);
        //空间头像 100*100
        NSLog(@"figureurl_2 = %@",[response.jsonResponse objectForKey:@"figureurl_2"]);
        //qq头像 40*40
        NSLog(@"figureurl_qq_1 = %@",[response.jsonResponse objectForKey:@"figureurl_qq_1"]);
        //qq头像 100*100
        NSLog(@"figureurl_qq_2 = %@",[response.jsonResponse objectForKey:@"figureurl_qq_2"]);
        
        
        
		NSMutableString *str = [NSMutableString stringWithFormat:@""];
		for (id key in response.jsonResponse) {
			[str appendString: [NSString stringWithFormat:@"%@:%@\n",key,[response.jsonResponse objectForKey:key]]];
		}
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"操作成功" message:[NSString stringWithFormat:@"%@",str]
							  
													   delegate:self cancelButtonTitle:@"我知道啦" otherButtonTitles: nil];
        alert.tag = 1112;
//        [alert show];
        
        NSLog(@"login");
        
        // qq登录成功后执行的方法
        [self qqLoginSuccess];
        
	}
	else
    {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"操作失败"
                                                        message:[NSString stringWithFormat:@"%@", response.errorMsg]
													   delegate:self
                                              cancelButtonTitle:@"我知道啦"
                                              otherButtonTitles: nil];
        alert.tag = 1112;
		[alert show];
        
	}
    
}

#pragma mark - UIalertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    //    if ( alertView.tag == 100100 ) {
    //        if ( buttonIndex == 1 ) {
    //            // 跳转到下载微信的地址
    //            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[WXApi getWXAppInstallUrl]]];
    //        }else{
    //
    //
    //        }
    //    }else
    
    if (alertView.tag == 1112 ){
        
        NSString *Title = [alertView title];
        NSString *ButtonTitle = [alertView buttonTitleAtIndex:buttonIndex];
        UITextField *textMatch;
        UITextField *textReqnum;
        
        
        if ([Title isEqualToString:@"请输入匹配字符串"])
        {
            if([ButtonTitle isEqualToString:@"确定"])
            {
                //textMatch = [alertView textFieldAtIndex:0];
                textMatch = (UITextField*)[alertView viewWithTag:0xAA];
                _Marth = [textMatch.text copy];
            }
        }
        else if ([Title isEqualToString:@"请输入请求个数"])
        {
            if([ButtonTitle isEqualToString:@"确定"])
            {
                //textReqnum = [alertView textFieldAtIndex:0];
                textReqnum = (UITextField*)[alertView viewWithTag:0xAA];
                _Reqnum = [textReqnum.text copy];
                
            }
        }
        
        CFRunLoopStop(CFRunLoopGetCurrent());
        
    }else{
        
        
    }
    
}


@end
