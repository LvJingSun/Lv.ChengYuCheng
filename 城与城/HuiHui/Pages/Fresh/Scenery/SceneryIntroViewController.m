//
//  SceneryIntroViewController.m
//  HuiHui
//
//  Created by mac on 15-1-19.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "SceneryIntroViewController.h"

#import "CommonUtil.h"

@interface SceneryIntroViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *m_webView;

@end

@implementation SceneryIntroViewController

@synthesize m_infoString;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"图文介绍"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    
    self.m_webView.backgroundColor = [UIColor whiteColor];
    self.m_webView.scalesPageToFit = YES;
    self.m_webView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    
    NSString *BookStr = [self htmlString:self.m_infoString];
    // webView赋值
    [self.m_webView loadHTMLString:BookStr baseURL:nil];

    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
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

// 加载前设置html的字体大小
- (NSString *)htmlString:(NSString *)aString{
    
    NSString *BookStr = [NSString stringWithFormat:@"<html> \n"
                         "<head> \n"
                         "<style type=\"text/css\"> \n"
                         "body {margin:0;font-size: %f;}\n"
                         "</style> \n"
                         "</head> \n"
                         "<body>%@</body> \n"
                         "</html>",35.0,aString];
    
    return BookStr;
    
}

#pragma UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView{
    
    [SVProgressHUD showWithStatus:@"正在加载中"];
    //导航栏表示网络正在进行
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [SVProgressHUD dismiss];
    
    NSString *jsString = [[NSString alloc] initWithFormat:@"document.body.style.fontSize=%f;document.body.style.color=%@",30.0f,[UIColor blackColor]];
    
    [webView stringByEvaluatingJavaScriptFromString:jsString];
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    [SVProgressHUD dismiss];
    
}

@end
