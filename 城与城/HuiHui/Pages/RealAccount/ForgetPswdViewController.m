//
//  ForgetPswdViewController.m
//  baozhifu
//
//  Created by mac on 13-10-9.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "ForgetPswdViewController.h"

#import "SVProgressHUD.h"

#import "CommonUtil.h"

//#import "AppHttpClient.h"

@interface ForgetPswdViewController ()

@end

@implementation ForgetPswdViewController

@synthesize item;

@synthesize m_secreId;

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

    [self setTitle:@"重置支付密码"];

    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
   
    // 设置请求的参数默认为0
    self.m_secreId = @"0";

    // 设置代理
    self.m_answer.delegate = self;
    self.m_newpassword.delegate = self;
    self.m_againPassWord.delegate = self;
    self.m_validate.delegate = self;
    
    
    // 问题的数据请求
    [self changQuestionSubmit];
    
    self.m_tempView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tableviewClick:)];
    
    [self.m_tempView addGestureRecognizer:tap];
    
}

- (void)tableviewClick:(UITapGestureRecognizer *)recognizer {
    
    [self hidenKeyboard];
    
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField == self.m_newpassword || textField == self.m_againPassWord) {
        
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
    [self setM_tempView:nil];
    [self setM_question:nil];
    [self setM_answer:nil];
    [self setM_newpassword:nil];
    [self setM_againPassWord:nil];
    [self setM_validate:nil];
    [super viewDidUnload];
}

- (IBAction)changeQuestion:(id)sender {
    
    // 请求数据
    [self changQuestionSubmit];
}

- (IBAction)takeValidate:(id)sender {
    
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

- (IBAction)submit:(id)sender {
    
    if (self.m_answer.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入答案"];
        return;
    }
   
    if (self.m_newpassword.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入新密码"];
        return;
    }
    
    if (self.m_againPassWord.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请再次输入新密码"];
        return;
    }
    
    if (![self.m_againPassWord.text isEqualToString:self.m_newpassword.text]) {
        [SVProgressHUD showErrorWithStatus:@"两次输入的密码不一致"];
        return;
    }
    
    if (self.m_validate.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入短信验证码"];
        return;
    }

    // 提交
    [self requestSubmit];
    
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
            
            self.m_question.text = [NSString stringWithFormat:@"%@",[self.item objectForKey:@"Question"]];
            
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
                           self.m_newpassword.text,@"newPwd",
                           self.m_validate.text,@"smsCode",
                           nil];
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    [httpClient request:@"ForgetPayPassword.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
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

- (void)goBackLastView:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 隐藏键盘的方法
-(void)hidenKeyboard {
    [self.m_againPassWord resignFirstResponder];
    [self.m_answer resignFirstResponder];
    [self.m_newpassword resignFirstResponder];
    [self.m_validate resignFirstResponder];
    [self resumeView];
}

- (BOOL)textFieldShouldReturn:(UITextField *)sender {
    /*if (sender == self.amount) {
     [self.password becomeFirstResponder];
     } else if (sender == self.password) {
     [self.smsCode becomeFirstResponder];
     } else if (sender == self.smsCode) {
     [self hidenKeyboard];
     }*/
    [self hidenKeyboard];
    return YES;
}

//UITextField的协议方法，当开始编辑时监听
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    NSTimeInterval animationDuration=0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    float width = self.view.frame.size.width;
    float height = self.view.frame.size.height;
    
    CGRect rect;
    
    if ( isIOS7 ) {
        
        rect=CGRectMake(0.0f,0.0f,width,height);
        
    }else{
        
        rect=CGRectMake(0.0f,-80.0f,width,height);
    }
    
    self.view.frame=rect;
    [UIView commitAnimations];
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
    CGRect rect;
    
    if ( isIOS7 ) {
        
        rect=CGRectMake(0.0f,60.0f,width,height);
    
    }else{
        
        rect=CGRectMake(0.0f,Y,width,height);
    }
    
    self.view.frame=rect;
    [UIView commitAnimations]; 
}


@end
