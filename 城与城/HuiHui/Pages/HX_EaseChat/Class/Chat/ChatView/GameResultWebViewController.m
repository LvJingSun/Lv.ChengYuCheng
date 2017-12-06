//
//  GameResultWebViewController.m
//  HuiHui
//
//  Created by mac on 2017/8/10.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "GameResultWebViewController.h"
#import "LJConst.h"

@interface GameResultWebViewController ()

@property (nonatomic, weak) UIWebView *webview;

@end

@implementation GameResultWebViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"游戏结果";
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:FSB_NAVFont,NSForegroundColorAttributeName:FSB_NAVTextColor}];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = [self SetNavigationBarImage:@"WebView_Back.png" andaction:@selector(dissClick)];
    
    UIWebView *webview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, _WindowViewWidth, _WindowViewHeight - 64)];
    
    self.webview = webview;
    
    //加载请求的时候忽略缓存
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.loadStr] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:5.0];
    
    [self.view addSubview:webview];
    
    [webview loadRequest:request];
    
    [webview setMediaPlaybackRequiresUserAction:NO];
    
    NSLog(@"%@",request);

}

- (UIBarButtonItem *)SetNavigationBarImage:(NSString *)aImageName andaction:(SEL)Saction{
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addButton setFrame:CGRectMake(-5, 0, 30, 30)];
    addButton.backgroundColor = [UIColor clearColor];
    [addButton setImage:[UIImage imageNamed:aImageName] forState:UIControlStateNormal];
    [addButton addTarget:self action:Saction forControlEvents:UIControlEventTouchUpInside];
    
    addButton.layer.masksToBounds = YES;
    
    addButton.layer.cornerRadius = addButton.frame.size.width * 0.5;
    UIBarButtonItem *_addFriendItem = [[UIBarButtonItem alloc] initWithCustomView:addButton];
    return _addFriendItem;
}

- (void)dissClick {
    
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
