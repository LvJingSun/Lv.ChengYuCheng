//
//  RechargeViewController.m
//  baozhifu
//
//  Created by mac on 13-7-23.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "RechargeViewController.h"
#import "CommonUtil.h"
#import "AppHttpClient.h"
#import "SVProgressHUD.h"
#import "CardInfoView.h"
#import "AddBankCardViewController.h"
#import "ForgetPswdViewController.h"

@interface RechargeViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *bankListView;

@property (weak, nonatomic) IBOutlet UITextField *amount;

@property (weak, nonatomic) IBOutlet UITextField *password;

@property (weak, nonatomic) IBOutlet UITextField *smsCode;

@property (weak, nonatomic) IBOutlet UIView *m_titleVIew;

@property (weak, nonatomic) IBOutlet UIView *m_tempView;

- (IBAction)addBankCard:(id)sender;

- (IBAction)submit:(id)sender;

- (IBAction)sendSMS:(id)sender;

- (IBAction)forgetPsw:(id)sender;

@end

@implementation RechargeViewController

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
    
    
    [self setTitle:@"充值"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
       
    self.bankListView.showsHorizontalScrollIndicator = NO;
    self.bankListView.showsVerticalScrollIndicator=NO;
    self.bankListView.pagingEnabled=YES;
    self.bankListView.delegate = self;
    self.amount.delegate = self;
    self.password.delegate = self;
    self.smsCode.delegate = self;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self loadData];
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

- (void)loadData {
    
    [self setDataView:nil];
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,     @"memberid",
                           key,   @"key",
                           @"VerificationSucc",   @"bnkListType",
                           nil];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"BankCarList.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            [SVProgressHUD dismiss];
            NSArray *bankCarList = [json valueForKey:@"memberBankCard"];
            self.bankItems = bankCarList;
            [self setDataView:bankCarList];
        } else {
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
    } failure:^(NSError *error) {
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];
}

- (void)setDataView:(NSArray *)bankCarList {
    CGFloat width = 235;
    CGFloat height = 88;
    if (bankCarList == nil || [bankCarList count] == 0) {
        CGRect frame = CGRectMake(0, 0, width, height);
        UILabel *label = [[UILabel alloc] initWithFrame:frame];
        label.text = @"您还未没有添加银行卡!";
        label.textAlignment = NSTextAlignmentCenter;
        [self.bankListView addSubview:label];
        self.bankListView.contentSize = CGSizeMake(width, height);
        return;
    }
    for (UIView *view in [self.bankListView subviews]) {
        [view removeFromSuperview];
    }
    int count = [bankCarList count];
    for (NSInteger index = 0; index < count; index++) {
        NSDictionary *bankInfo = [bankCarList objectAtIndex:index];
        NSString *isDefault = [bankInfo objectForKey:@"IsDefault"];
        if (isDefault.intValue == 1) self.currentPage = index;
        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"CardInfoView" owner:self options:nil];
        CardInfoView *view = [array objectAtIndex:0];
        [view setData:bankInfo];
        view.frame = CGRectMake(width * index, 0, width, height);
        //[view setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.bankListView addSubview:view];
    }
    self.bankListView.contentSize = CGSizeMake(width * count, height);
    [self.bankListView setContentOffset:CGPointMake(width * self.currentPage, 0) animated:YES];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    int index = fabs(self.bankListView.contentOffset.x) / self.bankListView.frame.size.width;

    self.currentPage = index;
}

- (IBAction)addBankCard:(id)sender {
    AddBankCardViewController *viewController = [[AddBankCardViewController alloc] initWithNibName:@"AddBankCardViewController" bundle:nil];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (IBAction)sendSMS:(id)sender {
    
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

    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,     @"memberId",
                           key,   @"key",
                           nil];
    [SVProgressHUD showWithStatus:@"验证码发送中"];
    [httpClient request:@"MobileSMSCode.ashx" parameters:param success:^(NSJSONSerialization* json) {
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

// 忘记密码
- (IBAction)forgetPsw:(id)sender {
    
    // 进入忘记密码页面
    ForgetPswdViewController *viewController = [[ForgetPswdViewController alloc]initWithNibName:@"ForgetPswdViewController" bundle:nil];
    [self.navigationController pushViewController:viewController animated:YES];
    
}

- (IBAction)submit:(id)sender {
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    NSString *amountStr = self.amount.text;
    if (amountStr.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入充值金额"];
        return;
    }
    CGFloat amount = [amountStr floatValue];
    if (amount < 200) {
        [SVProgressHUD showErrorWithStatus:@"充值金额不能小于200"];
        return;
    }
    
    NSString *password = self.password.text;
    if (password.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入支付密码"];
        return;
    }
    
    NSString *smsCode = self.smsCode.text;
    if (smsCode.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入短信验证码"];
        return;
    }
   
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,     @"memberId",
                           key,   @"key",
                           [[self.bankItems objectAtIndex:self.currentPage] objectForKey:@"MemberBankCardId"],   @"memberBankCardId",
                           password, @"password",
                           amountStr, @"rechargeAmount",
                           smsCode, @"smsCode",
                           nil];
    [SVProgressHUD showWithStatus:@"正在连接银行服务器..."];
    [httpClient request:@"Recharge.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD dismiss];
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alertView show];
            
        } else {
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
    } failure:^(NSError *error) {
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 隐藏键盘的方法
-(void)hidenKeyboard {
    [self.amount resignFirstResponder];
    [self.password resignFirstResponder];
    [self.smsCode resignFirstResponder];
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
    CGRect rect=CGRectMake(0.0f,-140.0f,width,height);
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
