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
//#import <QRCodeReader.h>
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
@synthesize mWidgetController;
@synthesize readline;

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
    
    [CommonUtil addValue:@"0" andKey:ApplicationStatusKey];
    
    [self hideTabBar: YES];
    
    ISscaning = NO;
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    // 如果此值为0的话，则表示返回上一级不是进入下一级
    NSString *status = [CommonUtil getValueByKey:ApplicationStatusKey];
    
    if ( [status isEqualToString:@"0"] ) {
        
        // 移除导航栏上面的view
        for (UILabel *label in self.navigationController.view.subviews) {
            
            if ( label.tag == 1001 ) {
                
                [label removeFromSuperview];
                
            }
        }

    }
 
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
            
            [CommonUtil addValue:@"1" andKey:ApplicationStatusKey];
           
            InviteWelcomViewController *viewController = [[InviteWelcomViewController alloc] initWithNibName:@"InviteWelcomViewController" bundle:nil];
            viewController.registInfo = registInfo;
            [self.navigationController pushViewController:viewController animated:YES];
 
        } else {
            
            [CommonUtil addValue:@"0" andKey:ApplicationStatusKey];

            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
    } failure:^(NSError *error) {
        
        [CommonUtil addValue:@"0" andKey:ApplicationStatusKey];

        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];
}

- (IBAction)scanInviteCode:(id)sender {
    
    [self hideTabBar:YES];
    
    [CommonUtil addValue:@"1" andKey:ApplicationStatusKey];

    // 进入二维码扫描的界面
//    self.mWidgetController = [[ZBarReaderViewController alloc]init];
    ZBarReaderViewController *reader = [ZBarReaderViewController new];
    reader.readerDelegate = self;
    reader.supportedOrientationsMask = ZBarOrientationMaskAll;
    reader.showsZBarControls = NO;
    reader.wantsFullScreenLayout = NO;
    ZBarImageScanner *scanner = reader.scanner;
    
    [scanner setSymbology: ZBAR_I25
                   config: ZBAR_CFG_ENABLE
                       to: 0];
    
    UIButton *_button = [UIButton buttonWithType:UIButtonTypeCustom];
    [_button setFrame:CGRectMake(0, 0, 25, 25)];
    _button.backgroundColor = [UIColor clearColor];
    [_button setImage:[UIImage imageNamed:@"arrow_WL.png"] forState:UIControlStateNormal];
    [_button addTarget:self action:@selector(scangoback) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *_barButton = [[UIBarButtonItem alloc] initWithCustomView:_button];
    [reader.navigationItem setLeftBarButtonItem:_barButton];
   
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 44)];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont fontWithName:@"Helvetica-Bold" size:18.0f];;
    label.text = @"账号扫描";
    reader.navigationItem.titleView = label;
    
    [self ZbarViewdid:reader];


    [self.navigationController pushViewController:reader animated:YES];
    
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
    
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark uiimagepicker delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    if (ISscaning) {
        return;
    }
    ISscaning = YES;
    [self playSound];
    id<NSFastEnumeration> results =
    [info objectForKey: ZBarReaderControllerResults];
    ZBarSymbol *symbol = nil;
    for(symbol in results)
        break;
    
    // 扫描成功后进行接口确认邀请码是否有效
    // http://wx.cityandcity.com/reg.aspx?inviteCode=3-1-M2013042411
    // 字符串是否以http://开头,如果不是则就表示是手机号；如果是，则是公众邀请码的一个链接，需截取其中的一个手机号
    if ( [symbol.data hasPrefix:@"http://"] ) {
        NSArray *array = [symbol.data componentsSeparatedByString:@"inviteCode="];
        
        NSString *string = [NSString stringWithFormat:@"%@",[array objectAtIndex:1]];
        
        if ( [string rangeOfString:@"&"].location != NSNotFound ) {
            
            NSArray *arr = [string componentsSeparatedByString:@"&"];
            
            NSLog(@"arr 0 = %@,arr = %@",[arr objectAtIndex:0],arr);
            
            [self requestRegister:[arr objectAtIndex:0]];
            
        }else{
            
            [self requestRegister:[array objectAtIndex:1]];
            
        }
        
    }else{
        
        [self requestRegister:symbol.data];
        
    }

    
    
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
            
            [CommonUtil addValue:@"1" andKey:ApplicationStatusKey];

            // 进入扫描公众邀请码的注册页面
            ScanRegisterViewController *VC = [[ScanRegisterViewController alloc]initWithNibName:@"ScanRegisterViewController" bundle:nil];
            VC.registInfo = self.m_dic;
            [self.navigationController pushViewController:VC animated:YES];
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
//            [SVProgressHUD showErrorWithStatus:msg];
            
            [CommonUtil addValue:@"0" andKey:ApplicationStatusKey];

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
        
        [CommonUtil addValue:@"0" andKey:ApplicationStatusKey];

        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];

    }];

}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [picker dismissModalViewControllerAnimated:YES];
    
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

-(void)ZbarViewdid:(ZBarReaderViewController *)View;
{
    
    self.mWidgetController =View;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getNotificationRunFromBack) name:@"RunFromBackground"  object:nil];
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    UIImageView *backImg = [[UIImageView alloc]init];
    if (iPhone5) {
        backImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"saomiaokuang@2x.png"]];
        [backImg setFrame:CGRectMake((WindowSizeWidth-191)/2, 82+40, 191, 259)];
    }else{
        backImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"saomiaokuang.png"]];
        [backImg setFrame:CGRectMake((WindowSizeWidth-191)/2, 38+40, 191, 259)];
    }
    [self.mWidgetController.view addSubview:backImg];
    
    [self performSelector:@selector(addAnimations) withObject:nil afterDelay:1.0];
    
}

-(void)playSound
{
    //注册声音到系统
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"beep-beep" ofType:@"caf"]],&shake_sound_male_id);
    AudioServicesPlaySystemSound(shake_sound_male_id);   //播放注册的声音，（此句代码，可以在本类中的任意位置调用，不限于本方法中）
}

-(void)addAnimations
{
    //stop loading
    [activity stopAnimating];
    //显示视图
    activityLabel.hidden = YES;
    //    overlayView.hidden=NO;
    
    readline =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"line_saomiao"]];
    readline.contentMode = UIViewContentModeScaleAspectFit;
    readline.frame=CGRectMake(0, 0, 157,7);
    [self.mWidgetController.view addSubview:readline];
    
    //添加图片的layer动画
    [self addLineImageAnimation];
}
// lineImage动画
-(void)addLineImageAnimation
{
    //添加图片的layer动画
    CABasicAnimation *translation = [CABasicAnimation animationWithKeyPath:@"position"];
    if (iPhone5) {
        translation.fromValue = [NSValue valueWithCGPoint:CGPointMake(WindowSizeWidth/2, 85+40)];
        translation.toValue = [NSValue valueWithCGPoint:CGPointMake(WindowSizeWidth/2, 240+40)];
    }else{
        
        translation.fromValue = [NSValue valueWithCGPoint:CGPointMake(WindowSizeWidth/2, 40+40)];
        translation.toValue = [NSValue valueWithCGPoint:CGPointMake(WindowSizeWidth/2, 210+40)];
    }
    translation.duration = 2;
    translation.repeatCount = HUGE_VALF;
    translation.autoreverses = YES;
    
    [readline.layer addAnimation:translation forKey:@"translation"];
}
// 后台进入前台通知动画继续
- (void)getNotificationRunFromBack
{
    //添加图片的layer动画
    [self addLineImageAnimation];
    
}

@end
