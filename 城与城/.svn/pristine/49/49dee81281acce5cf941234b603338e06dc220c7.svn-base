//
//  AlipayViewController.m
//  HuiHui
//
//  Created by mac on 14-8-13.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "AlipayViewController.h"

#import "CommonUtil.h"

@interface AlipayViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *m_webView;

@end

@implementation AlipayViewController

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
    // Do any additional setup after loading the view from its nib.
    
    [self setTitle:@"支付宝支付"];
    
    
    //弹出输入法通知
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(keyboardDidShow)  name:UIKeyboardDidShowNotification  object:nil];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    NSLog(@"payUrl = %@",[CommonUtil getValueByKey:kAlipayUrl]);
    
    // 加载地址
    [self.m_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[CommonUtil getValueByKey:kAlipayUrl]]]];
    
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

- (void)keyboardDidShow
{
    [self hiddenNumPadDone:nil];
}

#pragma mark - UIwebViewDelegate
-(BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*) reuqest navigationType:(UIWebViewNavigationType)navigationType;{
    
    NSString *string = [[reuqest URL] absoluteString];
    
    NSLog(@"string = %@",string);
    
    return YES;
    
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    
    [SVProgressHUD showWithStatus:@"正在加载中"];
    
    //导航栏表示网络正在进行
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [SVProgressHUD dismiss];
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    [SVProgressHUD dismiss];
    
}


@end
