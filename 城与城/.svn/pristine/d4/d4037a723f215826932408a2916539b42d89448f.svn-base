//
//  CardVerifyViewController.m
//  baozhifu
//
//  Created by mac on 13-9-8.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "CardVerifyViewController.h"
#import "SVProgressHUD.h"
#import "CommonUtil.h"
#import "AppHttpClient.h"

@interface CardVerifyViewController ()

@property (weak, nonatomic) IBOutlet UITextField *verifyAmount;

@property (weak, nonatomic) IBOutlet UILabel *bandCardNo;

@property (weak, nonatomic) IBOutlet UILabel *idcardNo;

@property (weak, nonatomic) IBOutlet UILabel *bankStation;

@property (weak, nonatomic) IBOutlet UILabel *cardStatus;

@property (weak, nonatomic) IBOutlet UIView *m_tempView;

@property (weak, nonatomic) IBOutlet UIView *m_titleView;

-(IBAction)submit:(id)sender;

@end

@implementation CardVerifyViewController

@synthesize keyShow;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        
        // 发送键盘通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
        
      
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [self setTitle:@"银行卡验证"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    self.needDone = YES;
    
    keyShow = NO;
    
    
    self.verifyAmount.delegate = self;
    self.bandCardNo.text = [self.bankInfo objectForKey:@"CardNumber"];
    self.idcardNo.text = [NSString stringWithFormat:@"身份证号：%@", [self.bankInfo objectForKey:@"IDCard"]];
    self.bankStation.text = [self.bankInfo objectForKey:@"BranchName"];
//    NSString *status = [[CommonUtil bankcardStatusDict] objectForKey:[self.bankInfo objectForKey:@"Status"]];
    
    NSString *status = [self.bankInfo objectForKey:@"Status"];
    
    if ( [status isEqualToString:@"PaySucc"] ) {
        
        self.cardStatus.text = [NSString stringWithFormat:@"当前状态：支付成功"];
        
    }else{
        
        self.cardStatus.text = [NSString stringWithFormat:@"当前状态：待验卡"];

    }
//    self.cardStatus.text = [NSString stringWithFormat:@"当前状态：%@", status];
    
    
    //[self setUpForDismissKeyboard];
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self hideTabBar:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    
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

#pragma mark 隐藏键盘的方法
-(void)hidenKeyboard {
    [self.verifyAmount resignFirstResponder];
    [self resumeView];
}

- (BOOL)textFieldShouldReturn:(UITextField *)sender {
    [self hidenKeyboard];
    return YES;
}

//UITextField的协议方法，当开始编辑时监听
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    self.doneButton.userInteractionEnabled = YES;

    [self showKeyboard:nil];
    
    
    NSTimeInterval animationDuration=0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    float width = self.view.frame.size.width;
    float height = self.view.frame.size.height;
    CGRect rect=CGRectMake(0.0f,-80,width,height);
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
//    float Y = 0.0f;
//    CGRect rect=CGRectMake(0.0f,Y,width,height);
    
    CGRect rect;
    
    if ( isIOS7 ) {
        
        rect=CGRectMake(0.0f,70.0f,width,height);
        
    }else{
        
        rect=CGRectMake(0.0f,0.0f,width,height);
    }
    
    self.view.frame=rect;
    [UIView commitAnimations];
}

- (IBAction)submit:(id)sender {
   
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    NSString *verifyAmount = self.verifyAmount.text;
    if (verifyAmount.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入验卡金额"];
        return;
    }
    
    
    // 判断输入多个小数点的情况
    NSArray *array = [self.verifyAmount.text componentsSeparatedByString:@"."];
    
    if ( array.count > 2 ) {
        
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示"
                                                           message:@"您输入的价钱格式不对,请重新输入"
                                                          delegate:nil
                                                 cancelButtonTitle:@"确定"
                                                 otherButtonTitles: nil];
        [alertView show];
        
        return;
        
    }

    
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,     @"memberId",
                           key,   @"key",
                           [self.bankInfo objectForKey:@"MemberBankCardId"],   @"memberBankCardId",
                           verifyAmount, @"playMoney",
                           nil];
    [SVProgressHUD showWithStatus:@"信息提交中"];
    [httpClient request:@"BankCardVerification.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showSuccessWithStatus:msg];
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            NSString *msg = [json valueForKey:@"msg"];
            
//            [SVProgressHUD showErrorWithStatus:msg];
            
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示"
                                                               message:msg
                                                              delegate:nil
                                                     cancelButtonTitle:@"确定"
                                                     otherButtonTitles: nil];
            
            [alertView show];
            
            [SVProgressHUD dismiss];
            
            self.verifyAmount.text = @"";
        }
    } failure:^(NSError *error) {
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];
}

// 完成按钮改为小数点
- (void)handleKeyboardWillHide:(NSNotification *)notification
{
    if (self.doneButton.superview)
    {
        [self.doneButton removeFromSuperview];
    }
    if (!keyShow) {
        return;
    }
   
    keyShow = NO;
}

- (void)handleKeyboardDidShow:(NSNotification *)notification
{
    // create custom button
    if (self.doneButton == nil)
    {
        self.doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;
//        if (screenHeight==568.0f) {//爱疯5
//            self.doneButton.frame = CGRectMake(0, 568 - 53, 106, 53);
//        } else {//3.5寸
//            self.doneButton.frame = CGRectMake(0, 480 - 53, 106, 53);
//        }
        
        if ( screenHeight == 736.0f ) {
            
            self.doneButton.frame = CGRectMake(self.view.frame.origin.x, screenHeight - 57, WindowSizeWidth/3 - 2, 57);
            
        }else{
            
            self.doneButton.frame = CGRectMake(self.view.frame.origin.x, screenHeight - 53, WindowSizeWidth/3 - 2, 53);
            
        }


        self.doneButton.adjustsImageWhenHighlighted = NO;
        self.doneButton.hidden=self.needDone;
        [self.doneButton setBackgroundImage:[UIImage imageNamed:@"btn_done_normal.png"] forState:UIControlStateNormal];
        [self.doneButton setBackgroundImage:[UIImage imageNamed:@"btn_done_selected.png"] forState:UIControlStateHighlighted];
        [self.doneButton addTarget:self action:@selector(finishAction) forControlEvents:UIControlEventTouchUpInside];
    }
    
    // locate keyboard view
    UIWindow* tempWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:1];
    if (self.doneButton.superview == nil)
    {
        [tempWindow addSubview:self.doneButton];    // 注意这里直接加到window上
    }
    self.doneButton.hidden=self.needDone;
    if (keyShow) {
        return;
    }

    keyShow = YES;
  
}

- (void)finishAction
{
    //    [self hidenKeyboard];
    
    self.verifyAmount.text = [self.verifyAmount.text stringByAppendingString:@"."];

}

- (IBAction)showKeyboard:(id)sender
{
    self.needDone = NO;
    self.doneButton.hidden = self.needDone;
}

- (IBAction)hideKeyboard:(id)sender
{
    self.needDone = YES;
    self.doneButton.hidden = self.needDone;
}

@end
