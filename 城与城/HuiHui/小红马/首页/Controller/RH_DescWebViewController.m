//
//  RH_DescWebViewController.m
//  HuiHui
//
//  Created by mac on 2017/8/4.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "RH_DescWebViewController.h"
#import "RedHorseHeader.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface RH_DescWebViewController () <UIWebViewDelegate>

@property (nonatomic, weak) UIWebView *webview;

@end

@implementation RH_DescWebViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    self.title = @"养车宝";
    
    self.navigationItem.leftBarButtonItem = [self SetNavigationBarImage:@"RH_HomeBack.png" andaction:@selector(dismissRH_Homeview)];
    
    UIWebView *webview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64)];
    
    webview.delegate = self;
    
    self.webview = webview;
    
    //加载请求的时候忽略缓存
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:5.0];
    
    [self.view addSubview:webview];
    
    [webview loadRequest:request];
    
    [webview setMediaPlaybackRequiresUserAction:NO];
    
}

//-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
//
//    NSLog(@"%ld",(long)navigationType);
//    
//    
//    
//}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    
    __weak typeof(self) weakself = self;

    JSContext *contect = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    contect[@"backappactivity"] = ^() {
    
        [weakself.navigationController popViewControllerAnimated:YES];
        
    };
    
    contect[@"telappactivity"] = ^() {
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",self.photoNum]]];
        
    };
    
}

- (void)dismissRH_Homeview {

    [self.navigationController popViewControllerAnimated:YES];
    
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
