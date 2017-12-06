//
//  TrainwebViewController.m
//  HuiHui
//
//  Created by 冯海强 on 15-1-22.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "TrainwebViewController.h"

#import "Sharetofriend.h"

#import "SharetoHuiHuiViewController.h"

@interface TrainwebViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *Train_webView;

@end

@implementation TrainwebViewController

@synthesize Train_webView;

@synthesize m_urlString;

@synthesize m_titleString;

@synthesize m_values;

@synthesize m_Funtions;

@synthesize m_keyTimes;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        
        m_values = [[NSArray alloc]init];
        
        m_Funtions = [[NSArray alloc]init];
        
        m_keyTimes = [[NSArray alloc]init];
        
    }
    return self;
}

- (void)requestForZuiJinClick {
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         [CommonUtil getValueByKey:MEMBER_ID],@"MemberID",
                         @"6",@"Type",
                         nil];
    
    AppHttpClient *http = [AppHttpClient sharedClient];
    
    [http request:@"ClickIconRecord.ashx" parameters:dic success:^(NSJSONSerialization *json) {
        
    } failure:^(NSError *error) {
        
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self requestForZuiJinClick];
    // Do any additional setup after loading the view from its nib.
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    self.title = @"火车票/汽车票";
    
    [self setRightButtonWithTitle:@"分享" action:@selector(shareClicked)];


    //弹出输入法通知
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center  addObserver:self selector:@selector(keyboardDidShow)  name:UIKeyboardDidShowNotification  object:nil];
        
    // 设置文字显示在整个webView里面，自动适应
    [self.Train_webView setScalesPageToFit:YES];
    self.Train_webView.detectsPhoneNumbers = YES;//自动检测网页上的电话号码，单击可以拨打
    self.Train_webView.scrollView.showsHorizontalScrollIndicator = NO;

    self.Trainstring = @"http://m.tieyou.com/jy/index.php?param=/default/home.html&utm_source=cityandcity";
    
    [self loadWebPageWithString:[NSString stringWithFormat:@"%@",self.Trainstring]];
    
    
    // 初始化分享所在的view
    self.m_sharingView = [[CommonShareView alloc]initWithFrame:self.view.frame];
    
    self.m_sharingView.backgroundColor = [UIColor clearColor];
    
    
    
    // 初始化三个用于动画的数组
    NSArray *array = [[NSArray alloc]initWithObjects:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f, 0.01f, 1.0f)],[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.0f)],[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9f, 0.9f, 1.0f)],[NSValue valueWithCATransform3D:CATransform3DIdentity], nil];
    
    NSArray *keyTimes = [[NSArray alloc]initWithObjects:@"0.2f",@"0.5f", @"0.75f", @"1.0f", nil];
    
    NSArray *funtions = [[NSArray alloc]initWithObjects:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                         [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                         [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut], nil];
    
    self.m_values = array;
    
    self.m_keyTimes = keyTimes;
    
    self.m_Funtions = funtions;


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadWebPageWithString:(NSString*)urlString
{
    NSURL *url =[NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.Train_webView loadRequest:request];
    
}

- (void)keyboardDidShow
{
    [self hiddenNumPadDone:nil];
}

-(void)rightClicked
{
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies])
    {
        [storage deleteCookie:cookie];
    }
    self.navigationItem.rightBarButtonItem = nil;
    [self loadWebPageWithString:[NSString stringWithFormat:@"%@",self.Trainstring]];
    
}

- (void)leftClicked{
    
        UIActionSheet *sheet  = [[UIActionSheet alloc] initWithTitle:@"您正在查看车票信息"
                                                            delegate:self
                                                   cancelButtonTitle:@"取消"
                                              destructiveButtonTitle:nil
                                                   otherButtonTitles:@"确认返回", nil];
        sheet.tag = 100001;
        [sheet showInView:self.view];
        return;
    
    [self goBack];
    
}

- (void)shareClicked{
    
    // 显示分享的页面
    [self.m_sharingView getSharingUrl:self.m_urlString withTitle:self.title withSubTitle:self.m_titleString];
    self.m_sharingView.delegate = self;
    
    
    [self.view addSubview:self.m_sharingView];
    
    // 动画
    CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    popAnimation.duration = 0.4;
    popAnimation.values = self.m_values;
    popAnimation.keyTimes = self.m_keyTimes;
    popAnimation.timingFunctions = self.m_Funtions;
    
    [self.m_sharingView.layer addAnimation:popAnimation forKey:nil];
    
    
}

#pragma mark - ShareDelegate
- (void)getShare:(NSString *)aType{
    
    if ( [aType isEqualToString:@"1"] ) {
        
        // 分享到城与城好友
        Sharetofriend *VC = [[Sharetofriend alloc]init];
        VC.MessageType = @"WEB";
        [VC.TextDIC setObject:@"http://www.cityandcity.com/Resource/Attached/common/lianjie.png" forKey:@"imageURL"];
        [VC.TextDIC setObject:self.m_urlString forKey:@"shareString"];
        //        if ([self.title isEqualToString:@""]){
        //            [VC.TextDIC setObject:@"分享一条链接" forKey:@"title"];
        //        }else
        //        {
        [VC.TextDIC setObject:self.m_titleString forKey:@"title"];
        //        }
        [self.navigationController pushViewController:VC animated:YES];
        
    }else{
        
        // 分享到城与城朋友圈
        //诲诲朋友圈
        SharetoHuiHuiViewController * VC = [[SharetoHuiHuiViewController alloc]initWithNibName:@"SharetoHuiHuiViewController" bundle:nil];
        
        VC.dealId = @"0";
        VC.serviceID = @"0";
        VC.m_merchantShopId = @"0";
        VC.dynamicType = @"WebViewShare";
        //        if ([self.title isEqualToString:@""]||[self.m_titleString isEqualToString:self.title]){
        VC.STitle = [NSString stringWithFormat:@"%@",self.title];
        VC.subTitle =  [NSString stringWithFormat:@"%@",self.m_titleString];
        //        }else{
        //            VC.STitle = [NSString stringWithFormat:@"%@",self.title];
        //            VC.subTitle =  [NSString stringWithFormat:@"%@",self.m_titleString];
        //        }
        VC.webUrl = self.m_urlString;
        VC.activityID = @"0";
        
        //        VC.ImageArray = _downloadImages;
        
        [self.navigationController pushViewController:VC animated:YES];
        
    }
    
}

#pragma mark - UIActionSheetDelegate
-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 100001)
    {
        if (buttonIndex==0)
        {
            
            [self goBack];
            
        }
        
    }
}

#pragma mark - UIwebViewDelegate
-(BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*) reuqest navigationType:(UIWebViewNavigationType)navigationType;{

    NSString *string = [[reuqest URL] absoluteString];

    // 赋值分享的地址链接
    self.m_urlString = [NSString stringWithFormat:@"%@",string];
    
    return YES;
    
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    
    [SVProgressHUD showWithStatus:@"正在加载中…"];
    //导航栏表示网络正在进行
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    self.navigationItem.rightBarButtonItem.enabled = YES;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [SVProgressHUD dismiss];
//    [self setRightButtonWithNormalImage:@"xxqd.png" withTitle:@"清除" action:@selector(rightClicked)];
    
    
    // 设置导航栏的标题为扫描网址的标题
    NSString *title = [self.Train_webView stringByEvaluatingJavaScriptFromString:@"self.document.title"];
    //    self.title = [NSString stringWithFormat:@"%@",title];
    // 赋值-用于分享使用
    self.m_titleString = [NSString stringWithFormat:@"%@",title];

    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    [SVProgressHUD dismiss];
    
}


@end
