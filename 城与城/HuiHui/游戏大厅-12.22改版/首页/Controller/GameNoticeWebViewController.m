//
//  GameNoticeWebViewController.m
//  HuiHui
//
//  Created by mac on 2017/12/28.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "GameNoticeWebViewController.h"
#import "LJConst.h"
#import <WebKit/WebKit.h>
//#import <JavaScriptCore/JavaScriptCore.h>

@interface GameNoticeWebViewController () <WKNavigationDelegate,WKUIDelegate>

@property (nonatomic, weak) WKWebView *wkwebview;

@end

@implementation GameNoticeWebViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

//    [self setTitle:@"虎啦棋牌"];
    
    self.view.backgroundColor = FSB_ViewBGCOLOR;
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    WKWebViewConfiguration *conf = [[WKWebViewConfiguration alloc] init];
    
    conf.preferences = [[WKPreferences alloc] init];
    
    conf.preferences.javaScriptEnabled = YES;
    
    conf.preferences.javaScriptCanOpenWindowsAutomatically = NO;
    
    conf.userContentController = [[WKUserContentController alloc] init];
    
    WKWebView *wkweb = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, _WindowViewWidth, _WindowViewHeight - 64) configuration:conf];
    
    self.wkwebview = wkweb;
    
    wkweb.navigationDelegate = self;
    
    wkweb.UIDelegate = self;
    
    //加载请求的时候忽略缓存
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.loadStr] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:5.0];
    
    [wkweb loadRequest:request];
    
    [self.view addSubview:wkweb];
    
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
    [self setTitle:self.wkwebview.title];
    
}

- (void)leftClicked {
    
    if (self.wkwebview.canGoBack == YES) {
        
        [self.wkwebview goBack];
        
    }else {
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
