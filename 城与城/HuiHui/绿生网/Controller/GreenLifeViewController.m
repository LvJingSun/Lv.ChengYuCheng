//
//  GreenLifeViewController.m
//  HuiHui
//
//  Created by mac on 2017/9/21.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "GreenLifeViewController.h"
#import "LJConst.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface GreenLifeViewController () <UIWebViewDelegate>

@property (nonatomic, weak) UIWebView *webview;

@end

@implementation GreenLifeViewController

//设置状态栏颜色
- (void)setStatusBarBackgroundColor:(UIColor *)color {
    
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
//    self.view.backgroundColor = [UIColor colorWithRed:49/255. green:189/255. blue:128/255. alpha:1.];
    
    UIWebView *webview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, _WindowViewWidth, _WindowViewHeight)];

    webview.delegate = self;

    self.webview = webview;
    
    webview.backgroundColor = [UIColor clearColor];

    //加载请求的时候忽略缓存
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.loadStr] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:5.0];

    [self.view addSubview:webview];

    [webview loadRequest:request];

    [webview setMediaPlaybackRequiresUserAction:NO];
    
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    
    __weak typeof(self) weakself = self;
    
    JSContext *contect = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    contect[@"backapp"] = ^() {
        
        [weakself dismissViewControllerAnimated:YES completion:nil];
        
    };
    
}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];

    [self setStatusBarBackgroundColor:[UIColor colorWithRed:48/255. green:214/255. blue:159/255. alpha:1.]];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    [self setStatusBarBackgroundColor:[UIColor clearColor]];
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
