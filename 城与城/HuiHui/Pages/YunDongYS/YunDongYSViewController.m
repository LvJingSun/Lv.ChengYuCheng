//
//  YunDongYSViewController.m
//  HuiHui
//
//  Created by mac on 15-10-25.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "YunDongYSViewController.h"

@interface YunDongYSViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *YunDong_webview;
@property (strong, nonatomic) NSString *webstring;

@end

@implementation YunDongYSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(LeftClicked)];
    
    //弹出输入法通知
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center  addObserver:self selector:@selector(keyboardDidShow)  name:UIKeyboardDidShowNotification  object:nil];
    
    // 设置文字显示在整个webView里面，自动适应
    [self.YunDong_webview setScalesPageToFit:YES];
    self.YunDong_webview.detectsPhoneNumbers = YES;//自动检测网页上的电话号码，单击可以拨打
    self.YunDong_webview.scrollView.showsHorizontalScrollIndicator = NO;
    self.YunDong_webview.delegate=self;
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    
    [self loadWebPageWithString:[NSString stringWithFormat:@"%@?key=%@&memid=%@",[CommonUtil getValueByKey:YunDongYSUrl],key,memberId]];
}


- (void)LeftClicked{
    
    [self goBack];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadWebPageWithString:(NSString*)urlString
{
    NSURL *url =[NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.YunDong_webview loadRequest:request];
    
}
- (void)keyboardDidShow
{
    [self hiddenNumPadDone:nil];
}
#pragma mark - UIwebViewDelegate
-(BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*) reuqest navigationType:(UIWebViewNavigationType)navigationType;{
    
    return YES;
    
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    
//    [SVProgressHUD showWithStatus:@"正在加载中…"];
    //导航栏表示网络正在进行
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    self.navigationItem.rightBarButtonItem.enabled = YES;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [SVProgressHUD dismiss];
    
    // 设置导航栏的标题为扫描网址的标题
    NSString *title = [self.YunDong_webview stringByEvaluatingJavaScriptFromString:@"self.document.title"];
    if (title.length==0) {
        [self setTitle:@"运动养生"];
    }else{
    [self setTitle:[NSString stringWithFormat:@"%@",title]];
    }
    
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [SVProgressHUD dismiss];
    
}

@end
