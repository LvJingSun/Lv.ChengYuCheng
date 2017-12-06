//
//  RegistViewController.m
//  baozhifu
//
//  Created by mac on 13-8-14.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "RegistViewController.h"
#import "InviteWelcomViewController.h"
#import "CommonUtil.h"
#import "SVProgressHUD.h"
#import "QRCodeGenerator.h"
#import <QRCodeReader.h>
#import "ScanRegisterViewController.h"
//#import "AppHttpClient.h"

@interface RegistViewController ()

@property (weak, nonatomic) IBOutlet UITextField *registCode;

@property (weak, nonatomic) IBOutlet UIView *m_titleView;

@property (weak, nonatomic) IBOutlet UIView *m_tempView;


- (IBAction)openRegist:(id)sender;

- (IBAction)scanInviteCode:(id)sender;

@end

@implementation RegistViewController

@synthesize m_dic;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        m_dic = [[NSMutableDictionary alloc]initWithCapacity:0];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.registCode.delegate = self;
    
    [self setTitle:@"注册"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
  
    // Do any additional setup after loading the view from its nib.
    
    // 在状态栏位置添加label，使其背景色为黑色
    if ( isIOS7 ) {
        
        UILabel *l_label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 20)];
//        l_label.backgroundColor = [UIColor blackColor];
//        l_label.alpha = 0.5;

        
        l_label.backgroundColor = RGBACKTAB;
        l_label.tag = 1001;
        [self.navigationController.view addSubview:l_label];
        
    }
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self hideTabBar: YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)openRegist:(id)sender {
        
    [self.view endEditing:YES];
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    NSString *registCode = self.registCode.text;
    if (registCode.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入邀请码"];
        return;
    }
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           registCode,     @"inviteCode",
                           nil];
    [SVProgressHUD showWithStatus:@"信息提交中"];
    [httpClient request:@"RegInviteVldCode.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            NSMutableDictionary *registInfo = [json valueForKey:@"inviteInfo"];
            [registInfo setObject:self.registCode.text forKey:@"InviteCode"];
            [registInfo setObject:[json valueForKey:@"questioninfo"] forKey:@"questioninfo"];
            [SVProgressHUD dismiss];
           
            InviteWelcomViewController *viewController = [[InviteWelcomViewController alloc] initWithNibName:@"InviteWelcomViewController" bundle:nil];
            viewController.registInfo = registInfo;
            [self.navigationController pushViewController:viewController animated:YES];
 
        } else {
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
    } failure:^(NSError *error) {
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];
}

- (IBAction)scanInviteCode:(id)sender {
    
    [self hideTabBar:YES];

    // 进入二维码扫描的界面
    ZXingWidgetController *widController = [[ZXingWidgetController alloc] initWithDelegate:self showCancel:NO OneDMode:NO];
    widController.view.backgroundColor = [UIColor whiteColor];

    NSMutableSet *readers = [[NSMutableSet alloc] init];
    QRCodeReader *qrcodeReader = [[QRCodeReader alloc] init];
    [readers addObject:qrcodeReader];
    widController.readers = readers;
    
    UIButton *_button = [UIButton buttonWithType:UIButtonTypeCustom];
    [_button setFrame:CGRectMake(0, 0, 44, 40)];
    _button.backgroundColor = [UIColor clearColor];
    [_button setImage:[UIImage imageNamed:@"arrow_WL.png"] forState:UIControlStateNormal];
    [_button addTarget:self action:@selector(scangoback) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *_barButton = [[UIBarButtonItem alloc] initWithCustomView:_button];
    [widController.navigationItem setLeftBarButtonItem:_barButton];
   
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 44)];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont fontWithName:@"Helvetica-Bold" size:18.0f];;
    label.text = @"账号扫描";
    widController.navigationItem.titleView = label;

    self.mWidgetController = widController;
    
//    // 扫描成功后的声音
    NSBundle *mainBundle = [NSBundle mainBundle];
    widController.soundToPlay = [NSURL fileURLWithPath:[mainBundle pathForResource:@"beep-beep" ofType:@"caf"] isDirectory:YES];
    
    [self.navigationController pushViewController:self.mWidgetController animated:YES];
    
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

// 扫描页面的左按钮执行的方法
- (void)scangoback{
    
    [self goBack];
}

#pragma mark ZxingDelegate
- (void)zxingController:(ZXingWidgetController*)controller didScanResult:(NSString *)result {
    
    NSLog(@"result = %@",result);
    
    // 扫描成功后进行接口确认邀请码是否有效
    // http://wx.cityandcity.com/reg.aspx?inviteCode=3-1-M2013042411
    // 字符串是否以http://开头,如果不是则就表示是手机号；如果是，则是公众邀请码的一个链接，需截取其中的一个手机号
    if ( [result hasPrefix:@"http://"] ) {
        
        NSArray *array = [result componentsSeparatedByString:@"inviteCode="];
        
        NSString *string = [NSString stringWithFormat:@"%@",[array objectAtIndex:1]];
        
        if ( [string rangeOfString:@"&"].location != NSNotFound ) {
            
            NSArray *arr = [string componentsSeparatedByString:@"&"];
            
            NSLog(@"arr 0 = %@,arr = %@",[arr objectAtIndex:0],arr);
            
            [self requestRegister:[arr objectAtIndex:0]];

        }else{
            
            [self requestRegister:[array objectAtIndex:1]];

        }
        
    }else{
        
        [self requestRegister:result];
        
    }
 
}

- (void)zxingControllerDidCancel:(ZXingWidgetController*)controller {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)requestRegister:(NSString *)aCode{
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           aCode,     @"pubInvCode",
                           nil];
    [SVProgressHUD showWithStatus:@"邀请码验证中"];
    [httpClient request:@"PublicInviteCodeVld.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            
            [SVProgressHUD dismiss];
            
           // 验证成功进入
            
            [self.m_dic setObject:aCode forKey:@"InviteCode"];
            
            // 进入扫描公众邀请码的注册页面
            ScanRegisterViewController *VC = [[ScanRegisterViewController alloc]initWithNibName:@"ScanRegisterViewController" bundle:nil];
            VC.registInfo = self.m_dic;
            [self.navigationController pushViewController:VC animated:YES];
            
        } else {
            NSString *msg = [json valueForKey:@"msg"];
//            [SVProgressHUD showErrorWithStatus:msg];
            
            [SVProgressHUD dismiss];
         
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示"
                                                               message:msg
                                                              delegate:self
                                                     cancelButtonTitle:@"确定"
                                                     otherButtonTitles: nil];
            
            alertView.tag = 112243;
            [alertView show];

        
        
        }
    } failure:^(NSError *error) {
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];

}


//隐藏键盘的方法
-(void)hidenKeyboard {
    [self.registCode resignFirstResponder];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)sender {
    [self hidenKeyboard];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    [textField resignFirstResponder];
        
    NSString *string = [CommonUtil getValueByKey:R_INVIDATECODE];
    
    if ( string.length == 0 ) {
        
        [CommonUtil addValue:self.registCode.text andKey:R_INVIDATECODE];
        
    }else{
        
        if ( [self.registCode.text isEqualToString:[CommonUtil getValueByKey:R_INVIDATECODE]] ) {
            // 如果邀请码未修改，则保存的内容不清空，否则清空所有保存的数据
            
             [CommonUtil addValue:self.registCode.text andKey:R_INVIDATECODE];
            
        }else{
            
            [CommonUtil addValue:self.registCode.text andKey:R_INVIDATECODE];
            
            [CommonUtil addValue:@"" andKey:R_USERNAME];
            [CommonUtil addValue:@"" andKey:R_EMAIL];
            [CommonUtil addValue:@"" andKey:R_LOGINPASSW];
            [CommonUtil addValue:@"" andKey:R_AGAINPASSW];
            [CommonUtil addValue:@"" andKey:R_VALIDATECODE];
            
            [CommonUtil addValue:@"" andKey:R_PAYPASSW];
            [CommonUtil addValue:@"" andKey:R_AGAINPAYPASSW];
            [CommonUtil addValue:@"" andKey:R_QUESTION_FIRST];
            [CommonUtil addValue:@"" andKey:R_QUESTION_SECOND];
            [CommonUtil addValue:@"" andKey:R_QUESTION_THIRD];
            [CommonUtil addValue:@"" andKey:R_ANSWER_FIRST];
            [CommonUtil addValue:@"" andKey:R_ANSWER_SECOND];
            [CommonUtil addValue:@"" andKey:R_ANSWER_THIRD];
            [CommonUtil addValue:@"" andKey:R_QUESTION_FIRST_ID];
            [CommonUtil addValue:@"" andKey:R_QUESTION_SECOND_ID];
            [CommonUtil addValue:@"" andKey:R_QUESTION_THIRD_ID];
            
        }
        
    }

}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if ( alertView.tag == 112243 ) {
        if ( buttonIndex == 0 ) {
            // 验证公众邀请码错误时返回上一级
            [self.navigationController popViewControllerAnimated:YES];
            
        }
    }
    
}

@end
