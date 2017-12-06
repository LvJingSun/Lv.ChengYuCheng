//
//  CodeViewController.m
//  HuiHui
//
//  Created by mac on 13-11-20.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import "CodeViewController.h"

#import "QRCodeGenerator.h"

#import <QuartzCore/QuartzCore.h>

#import "CommonUtil.h"

#import "UIImageView+AFNetworking.h"

#import "AppHttpClient.h"

#import "SVProgressHUD.h"

#import "ExplanationViewController.h"

#import "ModifyCodeViewController.h"

@interface CodeViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *m_imageV;

@property (weak, nonatomic) IBOutlet UILabel *m_nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_addresslabel;

@property (weak, nonatomic) IBOutlet UIImageView *m_sexImgV;

@property (weak, nonatomic) IBOutlet UIImageView *m_codeImgV;

// 背景view
@property (weak, nonatomic) IBOutlet UIView *m_tempView;
// 用于描述该用户的公众邀请码是什么状态
@property (weak, nonatomic) IBOutlet UILabel *m_statusTipLabel;

@property (weak, nonatomic) IBOutlet UIButton *m_statusBtn;

@property (weak, nonatomic) IBOutlet UILabel *m_myCodeLabel;

@property (strong, nonatomic) IBOutlet UIView *m_showView;

@property (weak, nonatomic) IBOutlet UIButton *m_shareBtn;

@property (weak, nonatomic) IBOutlet UIButton *m_copyBtn;

// 根据用户公众邀请码不同的状态点击进入不同的操作
- (IBAction)statusBtnClicked:(id)sender;

// 分享
- (IBAction)shareBtnClicked:(id)sender;
// 取消分享
- (IBAction)cancelShare:(id)sender;
// 复制按钮触发的事件
- (IBAction)copyBtnClicked:(id)sender;


@end

@implementation CodeViewController

@synthesize m_CodeDic;

@synthesize m_values;
@synthesize m_Funtions;
@synthesize m_keyTimes;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        m_CodeDic = [[NSMutableDictionary alloc]initWithCapacity:0];
        
        m_values = [[NSArray alloc]init];
        
        m_Funtions = [[NSArray alloc]init];
        
        m_keyTimes = [[NSArray alloc]init];


    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setTitle:@"我的二维码"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    // 设置view的圆角
    self.m_tempView.layer.cornerRadius = 10.0f;
    self.m_tempView.layer.borderWidth = 1.0f;
    
    self.m_tempView.layer.borderColor = [UIColor colorWithRed:215/255.0 green:215/255.0 blue:215/255.0 alpha:1.0].CGColor;
    
    // 计算名称与性别图标的坐标位置
    self.m_nameLabel.text = [NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:NICK]];
    
    CGSize size = [self.m_nameLabel.text sizeWithFont:[UIFont systemFontOfSize:15.0f] constrainedToSize:CGSizeMake(MAXFLOAT, 21) lineBreakMode:NSLineBreakByWordWrapping];
    
    self.m_nameLabel.frame = CGRectMake(self.m_nameLabel.frame.origin.x, self.m_nameLabel.frame.origin.y, size.width, 21);
    
    self.m_sexImgV.frame = CGRectMake(self.m_nameLabel.frame.origin.x + size.width + 10, self.m_sexImgV.frame.origin.y, self.m_sexImgV.frame.size.width, self.m_sexImgV.frame.size.height);
    
    self.m_accountString = [NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:ACCOUNT]];
    
    self.m_addresslabel.text = [NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:USER_AREA]];
        
    // 判断性别
    if ( [[CommonUtil getValueByKey:USER_SEX] isEqualToString:@"男"] ) {
        
        self.m_sexImgV.image = [UIImage imageNamed:@"gr_xingbie2.png"];
        
    }else if ( [[CommonUtil getValueByKey:USER_SEX] isEqualToString:@"女"] ){
        
        self.m_sexImgV.image = [UIImage imageNamed:@"gr_xingbie.png"];
        
    }else{
        
        self.m_sexImgV.image = [UIImage imageNamed:@""];
    }

    
    // 获取图片
    NSString *path = [NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:USER_PHOTO]];
    
    [self.m_imageV setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:path]]
                            placeholderImage:[UIImage imageNamed:@"moren.png"]
                                     success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                                         self.m_imageV.image = [CommonUtil scaleImage:image toSize:CGSizeMake(60, 60)];
                                         
                                     }
                                     failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                                         
                                     }];
    self.m_imageV.layer.masksToBounds = YES;
//    self.m_imageV.layer.borderWidth = 1.0;
    self.m_imageV.layer.cornerRadius = 5.0;
    self.m_imageV.layer.borderColor = [UIColor colorWithRed:215/255.0 green:215/255.0 blue:215/255.0 alpha:1.0].CGColor;
    
    
    // 初始化三个用于动画的数组
    NSArray *array = [[NSArray alloc]initWithObjects:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f, 0.01f, 1.0f)],[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.0f)],[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9f, 0.9f, 1.0f)],[NSValue valueWithCATransform3D:CATransform3DIdentity], nil];
    
    NSArray *keyTimes = [[NSArray alloc]initWithObjects:@"0.2f",@"0.5f", @"0.75f", @"1.0f", nil];
    
    NSArray *funtions = [[NSArray alloc]initWithObjects:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                         [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                         [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut], nil];
    
    self.m_values = array;
    
    self.m_keyTimes = keyTimes;
    
    self.m_Funtions = funtions;
    
    
    self.m_showView.center = self.view.center;
  
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self hideTabBar:YES];
    // 请求数据，根据用户是否申请过公众邀请码来判断
    [self requestValidateCode];

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

// 判断登录的用户是否生成过公众邀请码的请求
- (void)requestValidateCode{
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,     @"memberid",
                           key,   @"key",
                           nil];
//    [SVProgressHUD showWithStatus:@"数据加载中"]; PublicInviteIsExist.ashx
    [httpClient request:@"PublicInviteIsExist_1.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
//            [SVProgressHUD dismiss];
            
            // 审核中(PublicInviteCodePending)、已通过(PublicInviteCodePassed)、已禁用（PublicInviteCodeStopped）和已退回(PublicInviteCodeReturened)
            
            self.m_CodeDic = [json valueForKey:@"inviteCode"];
            
            NSLog(@"个人信息：：%@",self.m_CodeDic);
            
            
            // IsDaiLi 根据该值来判断是代理还是不是代理，如果是代理的话则再判断二维码的状态，如果不是代理的话则直接进行公众邀请码的申请 1是代理  0不是代理
            
            NSString *daili = [NSString stringWithFormat:@"%@",[self.m_CodeDic objectForKey:@"IsDaiLi"]];
            
            if ( [daili isEqualToString:@"1"] ) {
                
                // 根据状态判断按钮是否可点击
                if ( [[self.m_CodeDic objectForKey:@"InviteCodeStatus"] isEqualToString:@"PublicInviteCodePending"] ) {
                    
                    self.m_statusBtn.hidden = NO;
                    self.m_shareBtn.hidden = YES;
                    self.m_copyBtn.hidden = YES;
                    
                    self.m_myCodeLabel.text = @"我的二维码,也是我的公众邀请码";
                    self.m_statusTipLabel.text = @"朋友扫描即可进城";
                    
                    [self.m_statusBtn setTitle:@"审核中,暂不可邀请" forState:UIControlStateNormal];
                    
                    self.m_statusBtn.userInteractionEnabled = NO;
                    
                    self.m_codeStatus = PublicInviteCodePending;
                    
                    // 审核中的状态-显示用户的账号
//                    UIImage *codeImage = [QRCodeGenerator qrImageForString:self.m_accountString imageSize:self.m_codeImgV.frame.size.width];
//                    [self.m_codeImgV setImage:codeImage];

                    
                    UIImage *codeImage = [QRCodeGenerator qrImageForString:[self.m_CodeDic objectForKey:@"MemberInviteCode"] imageSize:self.m_codeImgV.frame.size.width];
                    [self.m_codeImgV setImage:codeImage];
                    
                    
                    self.navigationItem.rightBarButtonItem = nil;
                    
                }else if ( [[self.m_CodeDic objectForKey:@"InviteCodeStatus"] isEqualToString:@"PublicInviteCodePassed"] ){
                    
                    self.m_statusBtn.hidden = YES;
                    self.m_shareBtn.hidden = NO;
                    self.m_copyBtn.hidden = NO;
                    
                    
                    self.m_statusTipLabel.text = @"朋友扫描即可进城";
                    
                    self.m_myCodeLabel.text = @"我的二维码,也是我的公众邀请码";
                    
                    [self.m_statusBtn setTitle:@"分享给好友" forState:UIControlStateNormal];
                    
                    self.m_statusBtn.userInteractionEnabled = YES;
                    
                    self.m_codeStatus = PublicInviteCodePassed;
                    
                    // 申请通过 生成二维码图片
                    UIImage *codeImage = [QRCodeGenerator qrImageForString:[self.m_CodeDic objectForKey:@"MemberInviteCode"] imageSize:self.m_codeImgV.frame.size.width];
                    [self.m_codeImgV setImage:codeImage];
                    
                    
                    // 申请扩容或延期
                    [self setRightButtonWithTitle:@"申请扩容" action:@selector(ExpansionClicked)];
                    
                    
                }else if ( [[self.m_CodeDic objectForKey:@"InviteCodeStatus"] isEqualToString:@"PublicInviteCodeStopped"] ){
                    
                    self.m_statusBtn.hidden = NO;
                    self.m_shareBtn.hidden = YES;
                    self.m_copyBtn.hidden = YES;
                    
                    self.m_myCodeLabel.text = @"我的二维码,也是我的公众邀请码";
                    
                    self.m_statusTipLabel.text = @"朋友扫描即可进城";
                    
                    [self.m_statusBtn setTitle:@"已禁用" forState:UIControlStateNormal];
                    
                    self.m_statusBtn.userInteractionEnabled = YES;
                    
                    self.m_codeStatus = PublicInviteCodeStopped;
                    
                    // 已禁用的状态-显示用户的账号
//                    UIImage *codeImage = [QRCodeGenerator qrImageForString:self.m_accountString imageSize:self.m_codeImgV.frame.size.width];
//                    [self.m_codeImgV setImage:codeImage];

                    
                    UIImage *codeImage = [QRCodeGenerator qrImageForString:[self.m_CodeDic objectForKey:@"MemberInviteCode"] imageSize:self.m_codeImgV.frame.size.width];
                    [self.m_codeImgV setImage:codeImage];
                    
                    
                    self.navigationItem.rightBarButtonItem = nil;
                    
                }else if ( [[self.m_CodeDic objectForKey:@"InviteCodeStatus"] isEqualToString:@"PublicInviteCodeReturened"] ){
                    
                    self.m_statusBtn.hidden = NO;
                    self.m_shareBtn.hidden = YES;
                    self.m_copyBtn.hidden = YES;
                    
                    self.m_myCodeLabel.text = @"我的二维码,也是我的公众邀请码";
                    
                    self.m_statusTipLabel.text = @"朋友扫描即可进城";
                    
                    [self.m_statusBtn setTitle:@"已退回" forState:UIControlStateNormal];
                    
                    self.m_statusBtn.userInteractionEnabled = YES;
                    
                    self.m_codeStatus = PublicInviteCodeReturened;
                    
                    // 已退回的状态-显示用户的账号
//                    UIImage *codeImage = [QRCodeGenerator qrImageForString:self.m_accountString imageSize:self.m_codeImgV.frame.size.width];
//                    [self.m_codeImgV setImage:codeImage];
                    
                    UIImage *codeImage = [QRCodeGenerator qrImageForString:[self.m_CodeDic objectForKey:@"MemberInviteCode"] imageSize:self.m_codeImgV.frame.size.width];
                    [self.m_codeImgV setImage:codeImage];
                    
                    self.navigationItem.rightBarButtonItem = nil;
                    
                }else{
                    
                    
                    
                }

            }else if ( [daili isEqualToString:@"0"] ){
                
                // 显示用户的账号
                UIImage *codeImage = [QRCodeGenerator qrImageForString:[self.m_CodeDic objectForKey:@"MemberInviteCode"] imageSize:self.m_codeImgV.frame.size.width];
                [self.m_codeImgV setImage:codeImage];
                
                // 不是代理的情况下直接去申请公众邀请码
                self.m_statusBtn.hidden = NO;
                self.m_shareBtn.hidden = YES;
                self.m_copyBtn.hidden = YES;
                
                self.m_codeStatus = NOPublicCode;
                
                self.m_myCodeLabel.text = @"我的二维码";
                
                self.m_statusTipLabel.text = @"朋友扫描即可进城";
                
                [self.m_statusBtn setTitle:@"申请成为代理商" forState:UIControlStateNormal];
                
                self.m_statusBtn.userInteractionEnabled = YES;

                
            }else{
                
                
                
            }
           
        } else {
            
            // 显示用户的账号
//            UIImage *codeImage = [QRCodeGenerator qrImageForString:self.m_accountString imageSize:self.m_codeImgV.frame.size.width];
//            [self.m_codeImgV setImage:codeImage];
            
            UIImage *codeImage = [QRCodeGenerator qrImageForString:[self.m_CodeDic objectForKey:@"MemberInviteCode"] imageSize:self.m_codeImgV.frame.size.width];
            [self.m_codeImgV setImage:codeImage];
            
            
            
            NSString *msg = [json valueForKey:@"msg"];
            
            // 1表示用户信息丢失，请重新登录 2表示没有申请公众邀请码
            if ( [msg isEqualToString:@"1"] ) {
                
                [SVProgressHUD showErrorWithStatus:@"用户信息丢失，请重新登录"];
                
            }else if ( [msg isEqualToString:@"2"] ) {
                // 2表示没有申请过公众邀请码
               
                self.m_statusBtn.hidden = NO;
                self.m_shareBtn.hidden = YES;
                self.m_copyBtn.hidden = YES;
                
                self.m_codeStatus = NOPublicCode;
                
                self.m_myCodeLabel.text = @"我的二维码";
                
                self.m_statusTipLabel.text = @"朋友扫描即可进城";
                
                [self.m_statusBtn setTitle:@"申请成为代理商" forState:UIControlStateNormal];
                
                self.m_statusBtn.userInteractionEnabled = YES;
        
            }
            
        }
    } failure:^(NSError *error) {
        //NSLog(@"failed:%@", error);
        self.m_statusBtn.hidden = NO;
        self.m_shareBtn.hidden = YES;
        self.m_copyBtn.hidden = YES;
        
        self.m_codeStatus = NOPublicCode;
        
        self.m_myCodeLabel.text = @"我的二维码";
        
        self.m_statusTipLabel.text = @"朋友扫描即可进城";
        
        [self.m_statusBtn setTitle:@"申请成为代理商" forState:UIControlStateNormal];
        
        self.m_statusBtn.userInteractionEnabled = YES;
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];
    
}

- (void)ExpansionClicked{
    
    [self.m_showView removeFromSuperview];

    // 已通过跳转到修改公众邀请码的页面
    ModifyCodeViewController *VC = [[ModifyCodeViewController alloc]initWithNibName:@"ModifyCodeViewController" bundle:nil];
    VC.m_dic = self.m_CodeDic;
    [self.navigationController pushViewController:VC animated:YES];
    
}

- (IBAction)statusBtnClicked:(id)sender {
        
    if ( self.m_codeStatus == NOPublicCode ) {
        
        // 进入申请公众邀请码的说明页面
        ExplanationViewController *VC = [[ExplanationViewController alloc]initWithNibName:@"ExplanationViewController" bundle:nil];
        [self.navigationController pushViewController:VC animated:YES];
        
    }else if ( self.m_codeStatus == PublicInviteCodePassed ){
        
        // 已通过跳转到修改公众邀请码的页面
//        ModifyCodeViewController *VC = [[ModifyCodeViewController alloc]initWithNibName:@"ModifyCodeViewController" bundle:nil];
//        VC.m_dic = self.m_CodeDic;
//        [self.navigationController pushViewController:VC animated:YES];
        
        [self.view addSubview:self.m_showView];
        
        // 动画
        CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        popAnimation.duration = 0.4;
        popAnimation.values = self.m_values;
        popAnimation.keyTimes = self.m_keyTimes;
        popAnimation.timingFunctions = self.m_Funtions;
        
        [self.m_showView.layer addAnimation:popAnimation forKey:nil];
        
        
        
    }else if ( self.m_codeStatus == PublicInviteCodeStopped ){
        
        // 已禁用 跳出提示禁用的原因-可重新申请公众邀请码
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示"
                                                           message:[self.m_CodeDic objectForKey:@"ReturnDescript"]
                                                          delegate:self
                                                 cancelButtonTitle:@"取消"
                                                 otherButtonTitles:@"重新申请", nil];
        alertView.tag = 10902;
        [alertView show];
        
    }else if ( self.m_codeStatus == PublicInviteCodeReturened ){
        
        // 已退出 跳出提示退回的原因-可重新申请公众邀请码
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示"
                                                           message:[self.m_CodeDic objectForKey:@"ReturnDescript"]
                                                          delegate:self
                                                 cancelButtonTitle:@"取消"
                                                 otherButtonTitles:@"重新申请", nil];
        alertView.tag = 10902;
        [alertView show];
        
    }else{
        
        
        
    }
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    if ( alertView.tag == 10902 ){
        
        if ( buttonIndex == 1 ) {
            // 进入重新申请的页面
            ModifyCodeViewController *VC = [[ModifyCodeViewController alloc]initWithNibName:@"ModifyCodeViewController" bundle:nil];
            VC.m_dic = self.m_CodeDic;
            [self.navigationController pushViewController:VC animated:YES];
            
            
        }else{
            
            
        }
        
    }else if ( alertView.tag == 100100 ) {
        if ( buttonIndex == 1 ) {
            // 跳转到下载微信的地址
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[WXApi getWXAppInstallUrl]]];
        }else{
            
        }
    }else{
        
        
    }
}

- (IBAction)cancelShare:(id)sender {
    
    [self.m_showView removeFromSuperview];
    
}

- (IBAction)copyBtnClicked:(id)sender {
    
    // 复制到粘贴板
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = [NSString stringWithFormat:@"%@",[self.m_CodeDic objectForKey:@"MemberInviteCode"]];
   [SVProgressHUD showSuccessWithStatus:@"内容已经复制到粘贴板"];
}

- (IBAction)shareBtnClicked:(id)sender {
    
    [self.m_showView removeFromSuperview];
    
    UIButton *btn = (UIButton *)sender;
    
    if ( btn.tag == 1000 ) {
        //检测是否安装QQ
        if (![self checkIsVaildQQType]) {
            return;
        }
        // qq好友
        tencentOAuth = [[TencentOAuth alloc]initWithAppId:TencentQzoneAppId andDelegate:self];
        NSString *title = @"邀请好友";
        NSString *description =  @"诚邀您加入本地实名邀请制品质人脉社交分享平台。点击此公众邀请码即可在“城与城”或“城与城App”进城注册";
        
        NSString *utf8String = [self.m_CodeDic objectForKey:@"MemberInviteCode"];
        
        QQApiNewsObject *newsObj = [QQApiNewsObject objectWithURL:[NSURL URLWithString:utf8String] title:title description:description previewImageURL:[NSURL URLWithString:[self.m_CodeDic objectForKey:@"QrCodeUrl"]]];
        
        
        SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:newsObj];
        //将内容分享到qq
        QQApiSendResultCode sent = 0;
        sent = [QQApiInterface sendReq:req];
        // 判断QQ的情况
        [self handleSendResult:sent];
        
        
    }else if ( btn.tag == 1001 ) {
        //检测是否安装QQ
        if (![self checkIsVaildQQType]) {
            return;
        }
        // QQ空间分享
        tencentOAuth = [[TencentOAuth alloc]initWithAppId:TencentQzoneAppId andDelegate:self];
        
        NSString *title = @"邀请好友";
        NSString *description = @"诚邀您加入本地实名邀请制品质人脉社交分享平台。点击此公众邀请码即可在“城与城”或“城与城App”进城注册";
        
        NSString *utf8String = [self.m_CodeDic objectForKey:@"MemberInviteCode"];
        
        QQApiNewsObject *newsObj = [QQApiNewsObject objectWithURL:[NSURL URLWithString:utf8String] title:title description:description previewImageURL:[NSURL URLWithString:[self.m_CodeDic objectForKey:@"QrCodeUrl"]]];
        
        SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:newsObj];
        //将内容分享到qq
        QQApiSendResultCode sent = 0;
        
        //将内容分享到qzone
        sent = [QQApiInterface SendReqToQZone:req];
        
        // 判断QQ的情况
        [self handleSendResult:sent];
        
        
    }else if ( btn.tag == 1002 ) {
        
        // 微信分享
        [self checkIsVaildweixinType:1002];
        
    }else if ( btn.tag == 1003 ) {
        
        // 朋友圈分享
        [self checkIsVaildweixinType:1003];
        
    }else{
        
        
    }
    
}

- (void)handleSendResult:(QQApiSendResultCode)sendResult
{
    switch (sendResult)
    {
        case EQQAPIAPPNOTREGISTED:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"App未注册" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            break;
        }
        case EQQAPIMESSAGECONTENTINVALID:
        case EQQAPIMESSAGECONTENTNULL:
        case EQQAPIMESSAGETYPEINVALID:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"发送参数错误" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            break;
        }
        case EQQAPIQQNOTINSTALLED:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"未安装手Q" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            break;
        }
        case EQQAPIQQNOTSUPPORTAPI:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"API接口不支持" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            break;
        }
        case EQQAPISENDFAILD:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"发送失败" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            break;
        }
        default:
        {
            break;
        }
    }
}

// 检查是否安装了QQ的客户端
-(BOOL)checkIsVaildQQType
{
    if ([QQApi isQQInstalled] &&[QQApi isQQSupportApi]) {
        return YES;
    }else
    {
        //未安装
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示"
                                                        message:@"您尚未安装QQ或是当前版本太低"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        return NO;
    }
    
}

// 检查是否安装了微信的客户端
-(void)checkIsVaildweixinType:(NSInteger)aType
{
    if( [WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi] ){ //判断是否安装且支持微信
        if ( aType == 1002 ) {
            
            // 好友
            [self shareTogoodFriend];
            
        }else if ( aType == 1003 ) {
            
            // 朋友圈
            [self shareTogoodFriendShipsWithMessage];
            
        }else{
            
            
        }
        
    }else{
        
        //未安装
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示"
                                                        message:@"您尚未安装微信,确认进行安装吗？"
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                              otherButtonTitles:@"确定",nil];
        alert.tag = 100100;
        [alert show];
        
        
    }
    
}

//发送给好友
-(void)shareTogoodFriend
{
    
    WXMediaMessage *message = [WXMediaMessage message];//发送消息的多媒体内容
    message.title = @"邀请好友";
    message.description = @"诚邀您加入本地实名邀请制品质人脉社交分享平台。点击此公众邀请码即可在“城与城”或“城与城App”进城注册";
    
    NSString *imagePath = [NSString stringWithFormat:@"%@",[self.m_CodeDic objectForKey:@"QrCodeUrl"]];
    
    UIImageView *imgV = [[UIImageView alloc]init];
    
    [imgV setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:imagePath]]
                placeholderImage:[UIImage imageNamed:@""]
                         success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                             imgV.image = [CommonUtil scaleImage:image toSize:CGSizeMake(60, 60)];
                             
                             // 微信进行赋值
                             [message setThumbImage:imgV.image];
                             
                             WXWebpageObject *ext = [WXWebpageObject object];
                             ext.webpageUrl = [NSString stringWithFormat:@"%@",[self.m_CodeDic objectForKey:@"MemberInviteCode"]];
                             message.mediaObject = ext;
                             SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
                             req.bText = NO;//发送消息的类型，包括文本消息和多媒体消息两种，两者只能选择其一，不能同时发送文本和多媒体消息
                             req.message = message;
                             req.scene = WXSceneSession;//选择发送好友
                             [WXApi sendReq:req];
                             
                         }
                         failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                             
                         }];
    
}

// 朋友圈
-(void)shareTogoodFriendShipsWithMessage {
    
    WXMediaMessage *message = [WXMediaMessage message];//发送消息的多媒体内容
    message.title = @"邀请好友";
    message.description = @"诚邀您加入本地实名邀请制品质人脉社交分享平台。点击此公众邀请码即可在“城与城”或“城与城App”进城注册";
    
    
    NSString *imagePath = [NSString stringWithFormat:@"%@",[self.m_CodeDic objectForKey:@"QrCodeUrl"]];
    
    UIImageView *imgV = [[UIImageView alloc]init];
    
    [imgV setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:imagePath]]
                placeholderImage:[UIImage imageNamed:@""]
                         success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                             imgV.image = [CommonUtil scaleImage:image toSize:CGSizeMake(60, 60)];
                             
                             // 微信进行赋值
                             [message setThumbImage:imgV.image];
                             
                             WXWebpageObject *ext = [WXWebpageObject object];
                             
                             ext.webpageUrl = [NSString stringWithFormat:@"%@",[self.m_CodeDic objectForKey:@"MemberInviteCode"]];
                             message.mediaObject = ext;
                             
                             SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
                             req.bText = NO;//发送消息的类型，包括文本消息和多媒体消息两种，两者只能选择其一，不能同时发送文本和多媒体消息
                             req.message = message;
                             req.scene = WXSceneTimeline;//发送到朋友圈
                             
                             [WXApi sendReq:req];
                         }
                         failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                             
                         }];
    
}


@end
