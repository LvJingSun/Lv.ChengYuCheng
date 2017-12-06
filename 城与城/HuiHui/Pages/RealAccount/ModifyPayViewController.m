//
//  ModifyPayViewController.m
//  baozhifu
//
//  Created by mac on 13-10-25.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "ModifyPayViewController.h"

#import "SVProgressHUD.h"

#import "AppHttpClient.h"

#import "CommonUtil.h"

@interface ModifyPayViewController ()

@property (weak, nonatomic) IBOutlet UITextField *oldPwd;

@property (weak, nonatomic) IBOutlet UITextField *nnewPwd;

@property (weak, nonatomic) IBOutlet UITextField *confirmPwd;

@property (weak, nonatomic) IBOutlet UIView *m_tempVIew;

@property (weak, nonatomic) IBOutlet UITextField *m_validateCode;

@property (weak, nonatomic) IBOutlet UIScrollView *m_scrollerView;

-(IBAction)changePwd:(id)sender;

// 获取验证码
- (IBAction)SendSMS:(id)sender;

@end

@implementation ModifyPayViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //self.title = @"修改密码";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self  setTitle:@"修改支付密码"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    [self.m_scrollerView setContentSize:CGSizeMake(WindowSizeWidth, 500)];
    
    [self.oldPwd setDelegate:self];
    [self.nnewPwd setDelegate:self];
    [self.confirmPwd setDelegate:self];
    [self.m_validateCode setDelegate:self];

    self.m_tempVIew.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tableviewClick:)];
    
    [self.m_tempVIew addGestureRecognizer:tap];
    
}

- (void)tableviewClick:(UITapGestureRecognizer *)recognizer {
    
    [self hidenKeyboard];
    
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

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField == self.oldPwd || textField == self.nnewPwd || textField == self.confirmPwd) {
        
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

- (void)leftClicked{
    
    [self goBack];
}

-(IBAction)changePwd:(id)sender {
    
    [self.view endEditing:YES];

    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    NSString *txtoldPwd = self.oldPwd.text;
    NSString *txtnewPwd = self.nnewPwd.text;
    NSString *txtconfirmPwd = self.confirmPwd.text;
    if (txtoldPwd.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入原始密码"];
        return;
    }
    if (txtnewPwd.length != 6) {
        [SVProgressHUD showErrorWithStatus:@"请确认新密码为6位数字"];
        return;
    }
    if (txtconfirmPwd.length != 6) {
        [SVProgressHUD showErrorWithStatus:@"请确认密码为6位数字"];
        return;
    }
    
    if (![txtnewPwd isEqualToString:txtconfirmPwd]) {
        [SVProgressHUD showErrorWithStatus:@"两次输入新密码不相同"];

        return;
    }
    
    if ( self.m_validateCode.text.length == 0 ) {
       
        [SVProgressHUD showErrorWithStatus:@"请输入验证码"];
        
        return;
        
    }
    
    // 支付密码请求的接口
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,     @"memberId",
                           txtoldPwd,     @"oriPwd",
                           txtnewPwd,     @"newPwd",
                           key,   @"key",
                           self.m_validateCode.text,@"smsCode",
                           nil];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"ChangePayPassword.ashx" parameters:param success:^(NSJSONSerialization* json) {
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
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];
}

- (IBAction)SendSMS:(id)sender {
    
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
    
    ///*
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

- (void)BackLast{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

//隐藏键盘的方法
-(void)hidenKeyboard {
    [self.oldPwd resignFirstResponder];
    [self.nnewPwd resignFirstResponder];
    [self.confirmPwd resignFirstResponder];
    [self.m_validateCode resignFirstResponder];
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    if ( textField == self.m_validateCode ) {
        
        [self showNumPadDone:nil];
        
    }else{
        
        [self hiddenNumPadDone:nil];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)sender {
    [self hidenKeyboard];
    return YES;
}

//UITextField的协议方法，当开始编辑时监听
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField == self.oldPwd
        || textField == self.nnewPwd
        || textField == self.confirmPwd) {
//        self.needHiddenDone = YES;
//        [self hiddenNumPadDone:nil];
    }
    if (textField == self.m_validateCode) {
//        self.needHiddenDone = NO;
//        [self showNumPadDone:nil];
    }
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    [textField resignFirstResponder];
}


- (void)viewDidUnload {
    [self setM_validateCode:nil];
    [self setM_scrollerView:nil];
    [super viewDidUnload];
}

@end
