//
//  WwebpreviewViewController.m
//  HuiHui
//
//  Created by 冯海强 on 14-7-3.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "WwebpreviewViewController.h"

#import "SVProgressHUD.h"

#import "CommonUtil.h"

#import "UIImageView+AFNetworking.h"

#import "WXApi.h"

#import "SharetoHuiHuiViewController.h"

@interface WwebpreviewViewController ()

@property (weak, nonatomic) IBOutlet UIWebView      *m_WwebView;

@property (nonatomic, strong) NSArray           *m_values;

@property (nonatomic, strong) NSArray           *m_keyTimes;

@property (nonatomic, strong) NSArray           *m_Funtions;

@property (strong, nonatomic) IBOutlet UIView *m_showView;



@end

@implementation WwebpreviewViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.m_values = [[NSArray alloc]init];
        
        self.m_Funtions = [[NSArray alloc]init];
        
        self.m_keyTimes = [[NSArray alloc]init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    //弹出输入法通知
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center  addObserver:self selector:@selector(keyboardDidShow)  name:UIKeyboardDidShowNotification  object:nil];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    [self setRightButtonWithTitle:@"分享" action:@selector(rightClicked)];

    [self hideGradientBackground:self.m_WwebView];

    // 设置文字显示在整个webView里面
    [self.m_WwebView setScalesPageToFit:YES];
    
    self.m_WwebView.scrollView.showsHorizontalScrollIndicator = NO;
    
    [self loadWebPageWithString:[NSString stringWithFormat:@"http://wx.cityandcity.com/%@",self.WXURL]];
    
    NSLog(@"url = %@",[NSString stringWithFormat:@"http://wx.cityandcity.com/%@",self.WXURL]);
    
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    NSArray *array = [[NSArray alloc]initWithObjects:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f, 0.01f, 1.0f)],[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.0f)],[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9f, 0.9f, 1.0f)],[NSValue valueWithCATransform3D:CATransform3DIdentity], nil];
    
    NSArray *keyTimes = [[NSArray alloc]initWithObjects:@"0.2f",@"0.5f", @"0.75f", @"1.0f", nil];
    
    NSArray *funtions = [[NSArray alloc]initWithObjects:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                         [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                         [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut], nil];
    
    self.m_values = array;
    
    self.m_keyTimes = keyTimes;
    
    self.m_Funtions = funtions;
    
    //圆角
    [self.HuiHui.layer setMasksToBounds:YES];
    [self.HuiHui.layer setCornerRadius:10];
    
    self.m_showView.center = self.view.center;
    
}


- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self hideTabBar:YES];
}

-(void)viewDidDisappear:(BOOL)animated
{
    
    [super viewDidDisappear:animated];

    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
}


- (void)keyboardDidShow
{
    [self hiddenNumPadDone:nil];
}



- (void)leftClicked{
    
    [self goBack];
}

- (void)rightClicked
{
    
    [self shareBtnClicked];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)loadWebPageWithString:(NSString*)urlString
{
    NSURL *url =[NSURL URLWithString:urlString];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [self.m_WwebView loadRequest:request];

}

#pragma mark - UIwebViewDelegate


- (void)webViewDidStartLoad:(UIWebView *)webView{
    
    [SVProgressHUD showWithStatus:@"正在加载……"];

    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    NSString *theTitle=[self.m_WwebView stringByEvaluatingJavaScriptFromString:@"document.title"];

    [self setTitle:theTitle];
    
    self.navigationItem.rightBarButtonItem.enabled = YES;

    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    [SVProgressHUD dismiss];
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
	// report the error inside the webview
	NSString* errorString = [NSString stringWithFormat:
							 @"<html><center><font size=+5 color='red'>An error occurred:<br>%@</font></center></html>",
							 error.localizedDescription];
	[self.m_WwebView loadHTMLString:errorString baseURL:nil];
}



//右上角分享触发事件
- (void)shareBtnClicked {
    
    [self.view addSubview:self.m_showView];
    
    // 动画
    CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    popAnimation.duration = 0.4;
    popAnimation.values = self.m_values;
    popAnimation.keyTimes = self.m_keyTimes;
    popAnimation.timingFunctions = self.m_Funtions;
    
    [self.m_showView.layer addAnimation:popAnimation forKey:nil];
}


- (IBAction)shareClicked:(id)sender {
    
    [self.m_showView removeFromSuperview];
    
    UIButton *btn = (UIButton *)sender;
    
    
    //诲诲圈子分享
    if (btn.tag == 999) {
        
        SharetoHuiHuiViewController * VC = [[SharetoHuiHuiViewController alloc]initWithNibName:@"SharetoHuiHuiViewController" bundle:nil];
        
        [self.navigationController pushViewController:VC animated:YES];
        
        
    }else if ( btn.tag == 1000 ) {
        //检测是否安装QQ
        if (![self checkIsVaildQQType]) {
            return;
        }
        // qq好友
        tencentOAuth = [[TencentOAuth alloc]initWithAppId:TencentQzoneAppId andDelegate:self];
        
        //http://wx.cityandcity.com/activity/activity_detail.aspx?mctid=110&actid=171
        
        NSString *utf8String = [NSString stringWithFormat:@"http://wx.cityandcity.com/%@",self.WXURL];
        
        NSString *title = [NSString stringWithFormat:@"%@",self.title];
        NSString *description = @"";//[NSString stringWithFormat:@"%@",[self.m_itemsDic objectForKey:@"SvcName"]];
        
        
        QQApiNewsObject *newsObj = [QQApiNewsObject objectWithURL:[NSURL URLWithString:utf8String] title:title description:description previewImageURL:[NSURL URLWithString:self.WXimagepath]];
        
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
        
        NSString *utf8String = [NSString stringWithFormat:@"http://wx.cityandcity.com/%@",self.WXURL];
        
        NSString *title = [NSString stringWithFormat:@"%@",self.title];
        NSString *description = @"期待你的加入";//[NSString stringWithFormat:@"%@",[self.m_itemsDic objectForKey:@"SvcName"]];
        
        QQApiNewsObject *newsObj = [QQApiNewsObject objectWithURL:[NSURL URLWithString:utf8String] title:title description:description previewImageURL:[NSURL URLWithString:self.WXimagepath]];
        
        
        NSLog(@"%@",self.WXimagepath);
        
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

- (IBAction)cancelShare:(id)sender {
    
    [self.m_showView removeFromSuperview];
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
    message.title = [NSString stringWithFormat:@"%@",self.title];
    
    message.description = @"";//[NSString stringWithFormat:@"%@",[self.m_itemsDic objectForKey:@"SvcName"]];
    
    NSString *imagePath = [NSString stringWithFormat:@"%@",self.WXimagepath];
    
    UIImageView *imgV = [[UIImageView alloc]init];
    
    [imgV setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:imagePath]]
                placeholderImage:[UIImage imageNamed:@""]
                         success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                             imgV.image = [CommonUtil scaleImage:image toSize:CGSizeMake(60, 60)];
                             
                             // 微信进行赋值
                             [message setThumbImage:imgV.image];
                             
                             WXWebpageObject *ext = [WXWebpageObject object];
                             ext.webpageUrl = [NSString stringWithFormat:@"http://wx.cityandcity.com/%@",self.WXURL];
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
    message.description = @"期待你的加入";// [NSString stringWithFormat:@"%@",[self.m_itemsDic objectForKey:@"SvcName"]];
    message.title = [NSString stringWithFormat:@"%@",self.title];
    
    
    
    NSString *imagePath = [NSString stringWithFormat:@"%@",self.WXimagepath];
    
    UIImageView *imgV = [[UIImageView alloc]init];
    
    [imgV setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:imagePath]]
                placeholderImage:[UIImage imageNamed:@""]
                         success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                             imgV.image = [CommonUtil scaleImage:image toSize:CGSizeMake(60, 60)];
                             
                             // 微信进行赋值
                             [message setThumbImage:imgV.image];
                             
                             WXWebpageObject *ext = [WXWebpageObject object];
                             ext.webpageUrl = [NSString stringWithFormat:@"http://wx.cityandcity.com/%@",self.WXURL];
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

#pragma mark UIAlertViewDelegate Method
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if ( alertView.tag == 100100 ) {
        if ( buttonIndex == 1 ) {
            // 跳转到下载微信的地址
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[WXApi getWXAppInstallUrl]]];
        }else{
            
        }
    }
    
    
    
}


@end
