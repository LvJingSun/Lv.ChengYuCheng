//
//  BindingEmailViewController.m
//  HuiHui
//
//  Created by mac on 14-6-26.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "BindingEmailViewController.h"

#import <QuartzCore/QuartzCore.h>

#import "CommonUtil.h"

#import "SVProgressHUD.h"

#import "AppHttpClient.h"

@interface BindingEmailViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *m_scrollerView;

@property (weak, nonatomic) IBOutlet UITextField *m_email;

@property (weak, nonatomic) IBOutlet UITextField *m_validateCode;

@property (weak, nonatomic) IBOutlet UIView *m_emailView;

- (IBAction)sendSMS:(id)sender;

- (IBAction)saveSubmit:(id)sender;

@end

@implementation BindingEmailViewController

@synthesize m_secreId;

@synthesize item;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        item = [[NSMutableDictionary alloc]initWithCapacity:0];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setTitle:@"绑定邮箱"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    [self setRightButtonWithTitle:@"保存" action:@selector(rightClicked)];
    
    self.m_emailView.layer.cornerRadius = 10.0f;
    self.m_emailView.layer.borderWidth = 1.0f;
    
    self.m_emailView.layer.borderColor = [UIColor colorWithRed:215/255.0 green:215/255.0 blue:215/255.0 alpha:1.0].CGColor;
    
    
    // 设置请求的参数默认为0
    self.m_secreId = @"0";
    
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self hideTabBar:YES];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)leftClicked{
    
    [self goBack];
}

- (void)rightClicked{
    
    // 请求数据
    [self saveSubmit:nil];
}


- (IBAction)sendSMS:(id)sender {
    
    [self.view endEditing:YES];
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    if ( self.m_email.text.length == 0 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请输入邮箱地址！"];
        
        return;
    }
    
    if ( ![self isValidateEmail:self.m_email.text] ) {
        
        [SVProgressHUD showErrorWithStatus:@"您输入的邮箱有误，请重新输入"];
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
                           @"24",@"type",
                           self.m_email.text,@"email",
                           nil];
    [SVProgressHUD showWithStatus:@"验证码发送中"];
    [httpClient request:@"EmailSMSCode.ashx" parameters:param success:^(NSJSONSerialization* json) {
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

- (IBAction)saveSubmit:(id)sender {
    
    
    if ( self.m_email.text.length == 0 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请输入邮箱地址！"];
        
        return;
    }
    
    if ( ![self isValidateEmail:self.m_email.text] ) {
        
        [SVProgressHUD showErrorWithStatus:@"您输入的邮箱有误，请重新输入"];
        return;
    }
    
    if ( self.m_validateCode.text.length == 0 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请输入验证码"];
        
        return;
    }
    
    
    // 请求数据
    [self requestSubmit];
    
}


// 提交请求数据
- (void)requestSubmit{
    
    [self.view endEditing:YES];
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,     @"memberId",
                           key,   @"key",
                           self.m_email.text,@"email",
                           self.m_validateCode.text,@"vaildCode",
                           @"24",@"vaildType",
                           nil];
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    [httpClient request:@"BindEmail.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showSuccessWithStatus:msg];
            
            // 修改成功后保存邮箱地址
            [CommonUtil addValue:self.m_email.text andKey:USER_EMAIL];
            
            [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(goBackLastView:) userInfo:nil repeats:NO];
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
        
    } failure:^(NSError *error) {
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];
 
}

- (void)goBackLastView:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    if ( textField == self.m_email ) {
        
        [self hiddenNumPadDone:nil];
        
    }else{
        
        [self showNumPadDone:nil];
    }
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    [textField resignFirstResponder];

    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    return YES;
    
}

@end
