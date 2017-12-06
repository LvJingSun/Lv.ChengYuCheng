//
//  ForgetPasswordViewController.m
//  baozhifu
//
//  Created by mac on 14-3-24.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "ForgetPasswordViewController.h"

#import "SVProgressHUD.h"

#import "CommonUtil.h"

#import "AppHttpClient.h"

@interface ForgetPasswordViewController ()

@property (weak, nonatomic) IBOutlet UIView *m_titleView;

@property (weak, nonatomic) IBOutlet UIView *m_tempView;

@property (weak, nonatomic) IBOutlet UITextField *m_passwordTextField;

@property (weak, nonatomic) IBOutlet UITextField *m_codetextField;

@property (weak, nonatomic) IBOutlet UITextField *m_newPsdTextField;

@property (weak, nonatomic) IBOutlet UITextField *m_againTextField;

// 获取验证码
- (IBAction)SMSClicked:(id)sender;
// 下一步
- (IBAction)nextStepClicked:(id)sender;


@end

@implementation ForgetPasswordViewController

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
    // Do any additional setup after loading the view from its nib.
    
    [self setTitle:@"忘记密码"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    self.m_phoneString = @"";
    
    
    // 在状态栏位置添加label，使其背景色为黑色
    if ( isIOS7 ) {
        
        UILabel *l_label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 20)];
//        l_label.backgroundColor = [UIColor blackColor];
//        l_label.alpha = 0.5;

        l_label.backgroundColor = RGBACKTAB;
        l_label.tag = 1001;
        [self.navigationController.view addSubview:l_label];
        
    }
    

}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    // 移除导航栏上面的view
    for (UILabel *label in self.navigationController.view.subviews) {
        
        if ( label.tag == 1001 ) {
            
            [label removeFromSuperview];
            
        }
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)leftClicked{
    
    // 移除导航栏上面的view
    for (UILabel *label in self.navigationController.view.subviews) {
        
        if ( label.tag == 1001 ) {
            
            [label removeFromSuperview];
            
        }
    }

    
    [self goBack];
}

- (IBAction)SMSClicked:(id)sender {
    // 获取验证码
    [self.view endEditing:YES];
    
    if ( self.m_passwordTextField.text.length == 0 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请输入账号"];
        
        return;
        
    }
    
    if ( self.m_passwordTextField.text.length != 11 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请输入11位手机号码"];
        
        return;
    }
    
//    if ( ![self isMobileNumber:self.m_passwordTextField.text] ) {
//        
//        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号码格式"];
//        
//        return;
//        
//    }

    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    if (self.clickDateTime != nil) {
        NSTimeInterval timeDiff = [self.clickDateTime timeIntervalSinceNow];
        //NSLog(@"%.0f", ABS(timeDiff));
        
        if ( [self.m_passwordTextField.text isEqualToString:self.m_phoneString] ) {
            
            if (ABS(timeDiff) < 120) {
                [SVProgressHUD showErrorWithStatus:@"短信已发送，请过2分钟后再发送。"];
                return;
            }
        }else{
            
            
        }
        
    }
    
    ///*
//    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
//    NSString *key = [CommonUtil getServerKey];
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           @"33",@"type",
                           self.m_passwordTextField.text,@"phoneNumber",
                           nil];
    [SVProgressHUD showWithStatus:@"验证码发送中"];
    [httpClient request:@"FindBackSMSCode.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            self.clickDateTime = [[NSDate alloc] init];
            
            // 验证码获取成功后进行赋值 - 用于判断更换手机号获取验证码的可能
            self.m_phoneString = [NSString stringWithFormat:@"%@",self.m_passwordTextField.text];
            
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

- (IBAction)nextStepClicked:(id)sender {
    
    [self.view endEditing:YES];
    
    if ( self.m_passwordTextField.text.length == 0 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请输入账号"];
        
        return;
    }
    
    if ( self.m_passwordTextField.text.length != 11 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请输入11位手机号码"];
        
        return;
    }
    
//    if ( ![self isMobileNumber:self.m_passwordTextField.text] ) {
//        
//        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号码格式"];
//        
//        return;
//        
//    }
    
    if ( self.m_newPsdTextField.text.length == 0 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请输入新密码"];
        
        return;
    }
    
    if ( self.m_againTextField.text.length == 0 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请输入确认密码"];
        
        return;
    }
    
    if ( ![self.m_newPsdTextField.text isEqualToString:self.m_againTextField.text] ) {
        
        [SVProgressHUD showErrorWithStatus:@"两次输入的密码不一样，请重新输入"];
        
        return;
    }
    
    
    if ( self.m_codetextField.text.length == 0 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请输入验证码"];
        
        return;
    }

    // 提交请求
    [self submitPasswordRequest];
}

- (void)submitPasswordRequest{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
//    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
//    NSString *key = [CommonUtil getServerKey];
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
//                           memberId,     @"memberId",
//                           key,   @"key",
                           [NSString stringWithFormat:@"%@",self.m_passwordTextField.text],@"phoneNumber",
                           [NSString stringWithFormat:@"%@",self.m_codetextField.text],@"smsCode",
                           [NSString stringWithFormat:@"%@",self.m_newPsdTextField.text],@"newPwd",
                           [NSString stringWithFormat:@"%@",self.m_againTextField.text],@"confirmPwd",
                           
                           nil];
    
    NSLog(@"param = %@",param);
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"FindBackPassword.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showSuccessWithStatus:msg];
            
            [NSTimer scheduledTimerWithTimeInterval:2.0
                                             target:self
                                           selector:@selector(BackLast)
                                           userInfo:self
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

- (void)BackLast {

    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{


}

- (void)textFieldDidEndEditing:(UITextField *)textField{

    [textField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{

    [textField resignFirstResponder];
    
    return YES;
}

@end
