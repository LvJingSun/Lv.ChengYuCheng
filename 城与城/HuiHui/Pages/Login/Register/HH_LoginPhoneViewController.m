//
//  HH_LoginPhoneViewController.m
//  HuiHui
//
//  Created by mac on 14-11-6.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "HH_LoginPhoneViewController.h"

#import "CommonUtil.h"

@interface HH_LoginPhoneViewController ()

@property (weak, nonatomic) IBOutlet UITextField *m_phoneTextField;

@property (weak, nonatomic) IBOutlet UITextField *m_codeTextField;

@property (weak, nonatomic) IBOutlet UIButton *m_registerBtn;

// 获取验证码
- (IBAction)SMSClicked:(id)sender;
// 注册按钮触发的事件
- (IBAction)LoginClicked:(id)sender;


@end

@implementation HH_LoginPhoneViewController

@synthesize isChooseScanImage;
@synthesize mWidgetController;
@synthesize readline;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        isChooseScanImage = NO;

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setTitle:@"绑定手机号"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];

    
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
    
    [self hideTabBar:YES];
    
     self.isChooseScanImage = NO;
    
    ISscaning = NO;

}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [self hideTabBar:NO];
    
    
    // 解决图片选择后出现的问题
    if ( self.isChooseScanImage ) {
        
//        if ( isIOS7 ) {
        
//            for(UIView *view in self.tabBarController.view.subviews)
//            {
//                
//                if([view isKindOfClass:[UITabBar class]])
//                {
//                    
//                    if (self.tabBarController.tabBar.hidden) {
//                        [view setFrame:CGRectMake(view.frame.origin.x, [UIScreen mainScreen].bounds.size.height, view.frame.size.width, 49)];
//                        
//                    }
//                }
//                
//            }
            
//        }
        self.isChooseScanImage = NO;
    }
    

    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (IBAction)SMSClicked:(id)sender {
    
    [self.view endEditing:YES];
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    if ( self.m_phoneTextField.text.length == 0 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请输入手机号码"];
        
        return;
    }
    
    if ( self.m_phoneTextField.text.length != 11 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请输入11位手机号码"];
        
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
    
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           self.m_phoneTextField.text, @"phone",
                           nil];
    [SVProgressHUD showWithStatus:@"验证码发送中"];
    [httpClient request:@"PublicInviteSMSVld.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            self.clickDateTime = [[NSDate alloc] init];
            
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showSuccessWithStatus:msg];
            
        } else {
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
    } failure:^(NSError *error) {
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];
}

- (IBAction)LoginClicked:(id)sender {
    
    // 注册请求数据
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@""
                                                       message:@"您QQ和手机号都没注册过城与城,点击去注册,扫描商户的二维码即可完成注册"
                                                      delegate:self
                                             cancelButtonTitle:@"取消"
                                             otherButtonTitles:@"去注册", nil];
    alertView.tag = 19882;
    [alertView show];
    
}

#pragma mark - uitextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)sender {
    
    return YES;
}

//UITextField的协议方法，当开始编辑时监听
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    if ( textField == self.m_phoneTextField || textField == self.m_codeTextField ) {
        
        [self showNumPadDone:nil];
        
    }
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
}

#pragma mark = UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if ( alertView.tag == 19882 ) {
        if ( buttonIndex == 1 ) {
            
            [self hideTabBar:YES];
            
            // 进入二维码扫描的界面
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
            [_button addTarget:self action:@selector(codeLeftClicked) forControlEvents:UIControlEventTouchUpInside];
            
            UIBarButtonItem *_barButton = [[UIBarButtonItem alloc] initWithCustomView:_button];
            [reader.navigationItem setLeftBarButtonItem:_barButton];
            
            
            UIButton *r_button = [UIButton buttonWithType:UIButtonTypeCustom];
            [r_button setFrame:CGRectMake(0, 0, 50, 29)];
            r_button.backgroundColor = [UIColor clearColor];
            [r_button.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
            [r_button setTitle:@"相册" forState:UIControlStateNormal];
            [r_button setBackgroundImage:[UIImage imageNamed:@"xxqd.png"] forState:UIControlStateNormal];
            [r_button addTarget:self action:@selector(rightClicked) forControlEvents:UIControlEventTouchUpInside];
            
            UIBarButtonItem *r_barButton = [[UIBarButtonItem alloc] initWithCustomView:r_button];
//            [reader.navigationItem setRightBarButtonItem:r_barButton];
            
            
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
            // 测试 ==== 扫描成功后执行的方法
            [SVProgressHUD showErrorWithStatus:@"扫描成功"];
            
            [self.navigationController popViewControllerAnimated:YES];
            
//            [self.m_dic setObject:aCode forKey:@"InviteCode"];
//            
//            // 进入扫描公众邀请码的注册页面
//            ScanRegisterViewController *VC = [[ScanRegisterViewController alloc]initWithNibName:@"ScanRegisterViewController" bundle:nil];
//            VC.registInfo = self.m_dic;
//            [self.navigationController pushViewController:VC animated:YES];
            
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
            
            // 提示错误信息后返回上一级
            
            [self.navigationController popViewControllerAnimated:YES];

            
        }
    } failure:^(NSError *error) {
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];

    }];
    
}

- (void)codeLeftClicked{
    
    // 解决图片选择后出现的问题
    if ( self.isChooseScanImage ) {

        
        self.isChooseScanImage = NO;
    }
    
    [self.mWidgetController.navigationController popViewControllerAnimated:YES];

}

- (void)rightClicked{
    
    // 如果已经选择过相册则先还原下view的大小
    if ( self.isChooseScanImage ) {

    }
 
    self.isChooseScanImage = YES;
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    picker.allowsEditing = YES;
	
    [self presentModalViewController:picker animated:YES];
    
}

#pragma mark uiimagepicker delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    if (ISscaning) {
        return;
    }
    id<NSFastEnumeration> results =
    [info objectForKey: ZBarReaderControllerResults];
    ZBarSymbol *symbol = nil;
    for(symbol in results)
        break;
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    // 当选择类型是图片
    if ([type isEqualToString:@"public.image"]) {
        [picker dismissModalViewControllerAnimated:YES];
        if (isIOS7) { // 判断是否是IOS7
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
        }
        if ([[NSString stringWithFormat:@"%@",symbol.data] isEqualToString:@"(null)"]) {
            [SVProgressHUD showErrorWithStatus:@"未获取到二维码"];
            ISscaning = NO;
            return;
        }
    }
    
    ISscaning = YES;
    [self playSound];
    
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

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
	[picker dismissModalViewControllerAnimated:YES];
    if (isIOS7) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    }
	
}

-(void)ZbarViewdid:(ZBarReaderViewController *)View;
{
    self.mWidgetController = View;
    
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
    }    translation.duration = 2;
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
