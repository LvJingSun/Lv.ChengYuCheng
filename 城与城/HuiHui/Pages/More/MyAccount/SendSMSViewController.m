//
//  SendSMSViewController.m
//  baozhifu
//
//  Created by mac on 14-3-31.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "SendSMSViewController.h"

#import "SVProgressHUD.h"

#import "CommonUtil.h"

#import "AppHttpClient.h"

@interface SendSMSViewController ()

@property (weak, nonatomic) IBOutlet UIView *m_titleView;

@property (weak, nonatomic) IBOutlet UIView *m_tempView;

@property (weak, nonatomic) IBOutlet UITextView *m_textView;

@property (weak, nonatomic) IBOutlet UILabel *m_emptyLabel;

@property (weak, nonatomic) IBOutlet UIView *m_SMSView;

@property (weak, nonatomic) IBOutlet UIView *m_emailView;

@property (weak, nonatomic) IBOutlet UITextField *m_titleTextField;

@property (weak, nonatomic) IBOutlet UILabel *m_emailLabel;

@property (weak, nonatomic) IBOutlet UITextView *m_emailTextView;

// 发送邮件
- (IBAction)sendEmail:(id)sender;

// 发送短信
- (IBAction)sendSMS:(id)sender;

@end

@implementation SendSMSViewController

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
    
    
    if ( [self.m_typeString isEqualToString:@"1"] ) {
        // 表示是短信
        self.m_SMSView.hidden = NO;
        self.m_emailView.hidden = YES;
        
        [self setTitle:@"群发短信"];

        
    }else{
        // 表示邮件
        self.m_SMSView.hidden = YES;
        self.m_emailView.hidden = NO;
        
        [self setTitle:@"群发邮件"];

    }
    
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
   

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

#pragma mark - UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView{
    
    if ( textView == self.m_textView ) {
        
        self.m_emptyLabel.hidden = YES;

    }else{
        
        self.m_emailLabel.hidden = YES;
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    
    if ( textView == self.m_textView ) {
        
        if ( self.m_textView.text.length == 0 ) {
            
            self.m_emptyLabel.hidden = NO;
            
        }else{
            
            
            
        }
    }else{
        
        if ( self.m_emailTextView.text.length == 0 ) {
            
            self.m_emailLabel.hidden = NO;
            
        }else{
            
            
            
        }
    }
}

- (void)textViewDidChange:(UITextView *)textView{
    
    if ( textView == self.m_textView ) {
        
        int num = (int)([self textLength:textView.text] / 2);
        //    m_textCount = (int)([self textLength:textView.text] / 2);
        
        if ( num > 70 ) {
            
            [SVProgressHUD showErrorWithStatus:@"字符个数不能大于70"];
            
            self.m_textView.text = [self.m_textView.text substringToIndex:70];
            
        }else{
            
            
        }

    }else{
        
        
    }
}

- (IBAction)sendSMS:(id)sender {
    
    [self.view endEditing:YES];
    
    if ( self.m_textView.text.length == 0 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请输入短信内容"];
        
        return;
    }
    
    // 请求接口
    
    [self sendSMSRequest];
}

- (void)sendSMSRequest{
    
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
                           [NSString stringWithFormat:@"%@",self.m_phone],@"toMemberIds",
                           [NSString stringWithFormat:@"%@",self.m_textView.text],@"smsContent",
                           nil];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"SendSms.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {

            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
         
            [NSTimer scheduledTimerWithTimeInterval:2.0f
                                             target:self
                                           selector:@selector(lastView)
                                           userInfo:nil
                                            repeats:YES];
            
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
          
            
        }
    } failure:^(NSError *error) {
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];
    
}

- (void)emailRequest{
        
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
                           [NSString stringWithFormat:@"%@",self.m_email],@"toMemberIds",
                           [NSString stringWithFormat:@"%@",self.m_emailTextView.text],@"emailContent",
                           [NSString stringWithFormat:@"%@",self.m_titleTextField.text],@"title",
                           nil];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"SendEmails.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
            
            [NSTimer scheduledTimerWithTimeInterval:2.0f
                                             target:self
                                           selector:@selector(lastView)
                                           userInfo:nil
                                            repeats:YES];
            
            
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
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)sendEmail:(id)sender {
    
    [self.view endEditing:YES];
    
    if ( self.m_titleTextField.text.length == 0 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请输入邮件标题"];
        
        return;
    }
    
    if ( self.m_emailTextView.text.length == 0 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请输入邮件内容"];
        
        return;
    }
    
    // 请求接口
    [self emailRequest];
    
}
@end
