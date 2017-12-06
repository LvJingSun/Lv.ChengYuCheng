//
//  CouponWebViewController.m
//  HuiHui
//
//  Created by mac on 15-4-30.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "CouponWebViewController.h"

@interface CouponWebViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *m_webView;

@end

@implementation CouponWebViewController

@synthesize m_dic;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        
        m_dic = [[NSMutableDictionary alloc]initWithCapacity:0];
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   
    [self setTitle:[NSString stringWithFormat:@"%@优惠券",[self.m_dic objectForKey:@"Title"]]];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    NSLog(@"m_dic = %@",self.m_dic);
    
    // web加载数据
    NSString *urlString = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"Url"]];
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.m_webView loadRequest:request];
    

}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)leftClicked{
    
    [self goBack];
    
}

#pragma mark - UIWebViewDelegate
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


@end
