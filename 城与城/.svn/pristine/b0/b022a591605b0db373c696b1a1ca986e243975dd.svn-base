//
//  HH_LoginPhoneViewController.m
//  HuiHui
//
//  Created by mac on 14-11-6.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "HH_LoginPhoneViewController.h"

#import "CommonUtil.h"

#import <QRCodeReader.h>

#import "TwoDDecoderResult.h"

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
    
    [self hideTabBar:YES];
    
     self.isChooseScanImage = NO;
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
                                                       message:@"您QQ和手机号都没注册过诲诲,点击去注册,扫描商户的二维码即可完成注册"
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
            [_button addTarget:self action:@selector(codeLeftClicked) forControlEvents:UIControlEventTouchUpInside];
            
            UIBarButtonItem *_barButton = [[UIBarButtonItem alloc] initWithCustomView:_button];
            [widController.navigationItem setLeftBarButtonItem:_barButton];
            
            
            UIButton *r_button = [UIButton buttonWithType:UIButtonTypeCustom];
            [r_button setFrame:CGRectMake(0, 0, 50, 29)];
            r_button.backgroundColor = [UIColor clearColor];
            [r_button.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
            [r_button setTitle:@"相册" forState:UIControlStateNormal];
            [r_button setBackgroundImage:[UIImage imageNamed:@"xxqd.png"] forState:UIControlStateNormal];
            [r_button addTarget:self action:@selector(rightClicked) forControlEvents:UIControlEventTouchUpInside];
            
            UIBarButtonItem *r_barButton = [[UIBarButtonItem alloc] initWithCustomView:r_button];
            [widController.navigationItem setRightBarButtonItem:r_barButton];
            
            
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
    }
}

#pragma mark ZxingDelegate
- (void)zxingController:(ZXingWidgetController*)controller didScanResult:(NSString *)result {
    
//    if ( isIOS7 ) {
    
//        for(UIView *view in self.tabBarController.view.subviews)
//        {
//            
//            if([view isKindOfClass:[UITabBar class]])
//            {
//                
//                if (self.tabBarController.tabBar.hidden) {
//                    [view setFrame:CGRectMake(view.frame.origin.x, [UIScreen mainScreen].bounds.size.height, view.frame.size.width, 49)];
//                    
//                }
//            }
//            
//        }
//    }

    
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
    
    [self.mWidgetController.navigationController popViewControllerAnimated:YES];

}

- (void)rightClicked{
    
    // 如果已经选择过相册则先还原下view的大小
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
	
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    // 当选择类型是图片
    if ([type isEqualToString:@"public.image"]) {
        UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        
        QRCodeReader* qrcodeReader = [[QRCodeReader alloc] init];
        NSSet *readers = [[NSSet alloc] initWithObjects:qrcodeReader, nil];
        
        Decoder *d = [[Decoder alloc] init];
        d.delegate = self;
        d.readers = readers;
        
        int res = [d decodeImage:image];
		
		[picker dismissModalViewControllerAnimated:YES];
        
        // 0 没有二维码图片 1 扫描成功
		
        if (res == 0) {
            
            [SVProgressHUD showErrorWithStatus:@"未发现二维码"];
            
            // 判断view的大小，解决相册选择失败后view大小的问题
//            if ( isIOS7 ) {
            
//                for(UIView *view in self.tabBarController.view.subviews)
//                {
//                    
//                    if([view isKindOfClass:[UITabBar class]])
//                    {
//                        
//                        if (self.tabBarController.tabBar.hidden) {
//                            [view setFrame:CGRectMake(view.frame.origin.x, [UIScreen mainScreen].bounds.size.height, view.frame.size.width, 0)];
//                        }
//                    }
//                }
//            }
            
            
        }else{
            
            NSBundle *mainBundle = [NSBundle mainBundle];
            
            self.mWidgetController.soundToPlay = [NSURL fileURLWithPath:[mainBundle pathForResource:@"beep-beep" ofType:@"caf"] isDirectory:NO];
        }
		
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
	[picker dismissModalViewControllerAnimated:YES];
	
//    if ( isIOS7 ) {
    
//        for(UIView *view in self.tabBarController.view.subviews)
//        {
//            
//            if([view isKindOfClass:[UITabBar class]])
//            {
//                
//                if (self.tabBarController.tabBar.hidden) {
//                    [view setFrame:CGRectMake(view.frame.origin.x, [UIScreen mainScreen].bounds.size.height, view.frame.size.width, 0)];
//                }
//            }
//        }
//    }
}


#pragma mark decoder delegate
- (void)decoder:(Decoder *)decoder didDecodeImage:(UIImage *)image usingSubset:(UIImage *)subset withResult:(TwoDDecoderResult *)result{
    
    
//    if ( isIOS7 ) {
//        
//        for(UIView *view in self.tabBarController.view.subviews)
//        {
//            
//            if([view isKindOfClass:[UITabBar class]])
//            {
//                
//                if (self.tabBarController.tabBar.hidden) {
//                    [view setFrame:CGRectMake(view.frame.origin.x, [UIScreen mainScreen].bounds.size.height, view.frame.size.width, 49)];
//                    
//                }
//            }
//            
//        }
//    }
    
    
    NSLog(@"result = %@,text = %@",result,[result text]);
    
    // 扫描成功后进行接口确认邀请码是否有效
    // http://wx.cityandcity.com/reg.aspx?inviteCode=3-1-M2013042411
    // 字符串是否以http://开头,如果不是则就表示是手机号；如果是，则是公众邀请码的一个链接，需截取其中的一个手机号
    if ( [[result text] hasPrefix:@"http://"] ) {
        
        NSArray *array = [[result text] componentsSeparatedByString:@"inviteCode="];
        
        NSString *string = [NSString stringWithFormat:@"%@",[array objectAtIndex:1]];
        
        if ( [string rangeOfString:@"&"].location != NSNotFound ) {
            
            NSArray *arr = [string componentsSeparatedByString:@"&"];
            
            NSLog(@"arr 0 = %@,arr = %@",[arr objectAtIndex:0],arr);
            
            [self requestRegister:[arr objectAtIndex:0]];
            
        }else{
            
            [self requestRegister:[array objectAtIndex:1]];
            
        }
        
    }else{
        
        [self requestRegister:[result text]];
        
    }

}


@end
