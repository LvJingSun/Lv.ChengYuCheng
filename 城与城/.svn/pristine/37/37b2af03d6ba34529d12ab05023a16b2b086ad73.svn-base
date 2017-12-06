//
//  ChangePwdViewController.m
//  baozhifu
//
//  Created by mac on 13-7-2.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "ChangePwdViewController.h"

#import "SVProgressHUD.h"

#import "CommonUtil.h"

#import "AppHttpClient.h"

 
@interface ChangePwdViewController ()

@property (weak, nonatomic) IBOutlet UITextField *oldPwd;

@property (weak, nonatomic) IBOutlet UITextField *nnewPwd;

@property (weak, nonatomic) IBOutlet UITextField *confirmPwd;

@property (weak, nonatomic) IBOutlet UIView *m_tempView;

-(IBAction)changePwd:(id)sender;

@end

@implementation ChangePwdViewController

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
    
        
    [self.oldPwd setDelegate:self];
    [self.nnewPwd setDelegate:self];
    [self.confirmPwd setDelegate:self];
    //[self.navigationController setNavigationBarHidden:NO];
    
    
    [self setTitle:@"修改登录密码"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    
    // 设置view的圆角
    self.m_tempView.layer.cornerRadius = 10.0f;
    self.m_tempView.layer.borderWidth = 1.0f;
    
    self.m_tempView.layer.borderColor = [UIColor colorWithRed:215/255.0 green:215/255.0 blue:215/255.0 alpha:1.0].CGColor;
   
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

-(IBAction)changePwd:(id)sender {
    
    [self.view endEditing:YES];
        
    NSString *txtoldPwd = self.oldPwd.text;
    NSString *txtnewPwd = self.nnewPwd.text;
    NSString *txtconfirmPwd = self.confirmPwd.text;
   
    if (txtoldPwd.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入原始密码"];
        return;
    }
    if (txtnewPwd.length < 6) {
        [SVProgressHUD showErrorWithStatus:@"新密码至少6位"];
        return;
    }
    if (txtconfirmPwd.length < 6) {
        [SVProgressHUD showErrorWithStatus:@"确认密码至少6位"];
        return;
    }

    if (![txtnewPwd isEqualToString:txtconfirmPwd]) {
        [SVProgressHUD showErrorWithStatus:@"两次输入新密码不相同"];
        //self.nnewPwd.text = @"";
        //self.confirmPwd.text = @"";
        return;
    }
    
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,      @"memberId",
                           txtoldPwd,     @"oriPwd",
                           txtnewPwd,     @"newPwd",
                           key,           @"key",
                           nil];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"ChangePassword.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showSuccessWithStatus:msg];
            
            //清除密码
            [CommonUtil addValue:@"0" andKey:LOGINSELF];
            
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

- (void)BackLast{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

//隐藏键盘的方法
-(void)hidenKeyboard {
    
    [self.oldPwd resignFirstResponder];
    [self.nnewPwd resignFirstResponder];
    [self.confirmPwd resignFirstResponder];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)sender {
    /*if (sender == self.oldPwd) {
        [self.nnewPwd becomeFirstResponder];
    } else if (sender == self.nnewPwd){
        [self.confirmPwd becomeFirstResponder];
    } else if (sender == self.confirmPwd){
        [self hidenKeyboard];
    }*/
    [self hidenKeyboard];
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    [textField resignFirstResponder];
}

@end
