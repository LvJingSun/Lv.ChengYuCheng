//
//  ModifyPhoneViewController.m
//  HuiHui
//
//  Created by mac on 13-11-20.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import "ModifyPhoneViewController.h"

#import <QuartzCore/QuartzCore.h>

#import "CommonUtil.h"

#import "SVProgressHUD.h"

#import "AppHttpClient.h"

@interface ModifyPhoneViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *m_scrollerView;

@property (weak, nonatomic) IBOutlet UILabel *m_titleLabel;

@property (weak, nonatomic) IBOutlet UITextField *m_answer;

@property (weak, nonatomic) IBOutlet UITextField *m_phone;

@property (weak, nonatomic) IBOutlet UITextField *m_validateCode;

@property (weak, nonatomic) IBOutlet UIView *m_shenfenView;

@property (weak, nonatomic) IBOutlet UIView *m_phoneView;


// 下一题
- (IBAction)nextQuestion:(id)sender;
// 获取验证码
- (IBAction)sendSMS:(id)sender;
// 保存
- (IBAction)saveSubmit:(id)sender;


@end

@implementation ModifyPhoneViewController

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
    
    
    [self setTitle:@"修改手机号码"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    [self setRightButtonWithTitle:@"保存" action:@selector(rightClicked)];
    
//    [self setRightButtonWithNormalImage:@"save.png" action:@selector(rightClicked)];
    
    // 设置view的圆角
    self.m_shenfenView.layer.cornerRadius = 10.0f;
    self.m_shenfenView.layer.borderWidth = 1.0f;
    
    self.m_shenfenView.layer.borderColor = [UIColor colorWithRed:215/255.0 green:215/255.0 blue:215/255.0 alpha:1.0].CGColor;
    
    self.m_phoneView.layer.cornerRadius = 10.0f;
    self.m_phoneView.layer.borderWidth = 1.0f;
    
    self.m_phoneView.layer.borderColor = [UIColor colorWithRed:215/255.0 green:215/255.0 blue:215/255.0 alpha:1.0].CGColor;
    
    
    // 设置请求的参数默认为0
    self.m_secreId = @"0";
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self hideTabBar:YES];
    
    // 问题的数据请求
    [self changQuestionSubmit];
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
    
//    [self alertWithMessage:@"保存"];
    
    // 请求数据
    [self saveSubmit:nil];
}

- (IBAction)nextQuestion:(id)sender {
    
    // 请求数据
    [self changQuestionSubmit];
}

- (IBAction)sendSMS:(id)sender {
    
    [self.view endEditing:YES];
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    if ( self.m_phone.text.length == 0 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请输入手机号码！"];
        
        return;
    }
    
    if ( self.m_phone.text.length != 11 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请输入11位手机号码"];
        
        return;
    }
    
//    if ( ![self isMobileNumber:self.m_phone.text] ) {
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
    
    ///*
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,     @"memberId",
                           key,   @"key",
                           @"4",@"type",
                           self.m_phone.text,@"phoneNumber",
                           nil];
    [SVProgressHUD showWithStatus:@"验证码发送中"];
    [httpClient request:@"SMSCode.ashx" parameters:param success:^(NSJSONSerialization* json) {
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
    
    [self.view endEditing:YES];
    
    if (self.m_answer.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入答案"];
        return;
    }
    
    if (self.m_phone.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入新手机号码"];
        return;
    }

    if ( self.m_phone.text.length != 11 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请输入11位手机号码"];
        
        return;
    }
    
//    if ( ![self isMobileNumber:self.m_phone.text] ) {
//        
//        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号码格式"];
//        
//        return;
//        
//    }
    
    if (self.m_validateCode.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入短信验证码"];
        return;
    }
    
    // 提交
    [self requestSubmit];

}

// 提交请求数据
- (void)requestSubmit{
    
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
                           self.m_secreId,@"secretSecurityId",
                           self.m_answer.text,@"answer",
                           self.m_phone.text,@"phoneNumber",
                           self.m_validateCode.text,@"vaildCode",
                           @"4",@"vaildType",
                           nil];
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    [httpClient request:@"ChangePhoneNumber.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showSuccessWithStatus:msg];
            
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

// 换一题请求数据
- (void)changQuestionSubmit{
    
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
                           self.m_secreId ,@"secretSecurityId",
                           nil];
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    [httpClient request:@"PaymentRandomQuestion.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        self.item = [json valueForKey:@"randomQuestion"];
        
        if (success) {
            
            self.m_titleLabel.text = [NSString stringWithFormat:@"%@",[self.item objectForKey:@"Question"]];
            
            self.m_secreId = [self.item objectForKey:@"SecretSecurityId"];
            
            [SVProgressHUD dismiss];
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
        
    } failure:^(NSError *error) {
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];
    
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    
    if ( textField == self.m_answer ) {
        
        [self.m_scrollerView setContentOffset:CGPointMake(0, 0) animated:NO];
        
        [self hiddenNumPadDone:nil];
    
    }else  {
        
        [self.m_scrollerView setContentOffset:CGPointMake(0, 200) animated:NO];
        
        [self showNumPadDone:nil];
        
    }
    
    [self.m_scrollerView setContentSize:CGSizeMake(WindowSizeWidth, 750)];

}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    [self.m_scrollerView setContentOffset:CGPointMake(0, 0) animated:NO];
    
    [self.m_scrollerView setContentSize:CGSizeMake(WindowSizeWidth, 100)];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self.m_scrollerView setContentOffset:CGPointMake(0, 0) animated:NO];

    [self.m_scrollerView setContentSize:CGSizeMake(WindowSizeWidth, 100)];

    [textField resignFirstResponder];
    
    return YES;
    
}


@end
