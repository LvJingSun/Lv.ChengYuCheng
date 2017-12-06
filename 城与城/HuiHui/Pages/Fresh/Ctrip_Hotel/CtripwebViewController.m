//
//  CtripwebViewController.m
//  HuiHui
//
//  Created by 冯海强 on 14-10-17.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "CtripwebViewController.h"

@interface CtripwebViewController ()

@end

@implementation CtripwebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setTitle:@"酒店评价"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    self.Ctrip_webview.delegate = self;
    // 设置文字显示在整个webView里面，自动适应
    [self.Ctrip_webview setScalesPageToFit:YES];
    
    self.Ctrip_webview.detectsPhoneNumbers = YES;//自动检测网页上的电话号码，单击可以拨打
    self.Ctrip_webview.scrollView.showsHorizontalScrollIndicator = NO;
    
    [self loadWebPageWithString:[NSString stringWithFormat:@"%@",self.Ctrip_webstring]];
//    
//    self.navigationController.navigationBarHidden = YES;
    if (WindowSize.size.height==480.f) {
        [self.Ctrip_webview setFrame:CGRectMake(0, -48, WindowSize.size.width, WindowSize.size.height+(68*2))];}else{
            [self.Ctrip_webview setFrame:CGRectMake(0, -48, WindowSize.size.width, WindowSize.size.height +48)];
        }    
    [self.Ctrip_webview setBackgroundColor:[UIColor clearColor]];
    [self.Ctrip_webview setOpaque:NO];//设置透明
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(keyboardDidShow)  name:UIKeyboardDidShowNotification  object:nil];

}

- (void)keyboardDidShow
{
    [self hiddenNumPadDone:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)leftClicked{
    
    [self goBack];
    
}


- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self hideTabBar:YES];

}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [self hideTabBar:NO];
  
}



- (void)loadWebPageWithString:(NSString*)urlString
{
    NSURL *url =[NSURL URLWithString:urlString];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [self.Ctrip_webview loadRequest:request];
    
}
#pragma mark - UIwebViewDelegate
-(BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*) reuqest navigationType:(UIWebViewNavigationType)navigationType;{
    
    NSRange range1 = [[[reuqest URL] absoluteString] rangeOfString:@"ctrip://wireless/?GUID="];
    NSRange range2 = [[[reuqest URL] absoluteString] rangeOfString:@"itms-apps://itunes.apple.com/cn/app"];
    if ((range2.location == !NSNotFound)||(range1.location == !NSNotFound))
    {
        return NO;
    }

//    
//    if ([[NSString stringWithFormat:@"%@",[[reuqest URL] absoluteString]] isEqualToString:@"http://m.ctrip.com/html5/"]) {
//        
//        [self.Ctrip_webview stopLoading];
//        
//        [self leftClicked];
//    }
 
    return YES;
    
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    
    //导航栏表示网络正在进行
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{

    self.navigationItem.rightBarButtonItem.enabled = YES;
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    [SVProgressHUD dismiss];
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    [SVProgressHUD dismiss];
    
}

#pragma mark - UIScrollerDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat yOffset = scrollView.contentOffset.y;
    UIScrollView * scrollV = [[self.Ctrip_webview subviews] objectAtIndex:0];

    if (yOffset<=0) {
        [scrollV setContentOffset:CGPointMake(-48, 0) animated:NO];
    }
}

@end
