//
//  MessageViewController.m
//  HuiHui
//
//  Created by mac on 13-11-28.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//  消息点击进入的详细界面

#import "MessageViewController.h"

@interface MessageViewController ()

@property (weak, nonatomic) IBOutlet UILabel        *m_titleLabel;

@property (weak, nonatomic) IBOutlet UILabel        *m_timeLabel;

@property (weak, nonatomic) IBOutlet UIWebView      *m_webView;


@end

@implementation MessageViewController

@synthesize m_DetailDic;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        m_DetailDic = [[NSMutableDictionary alloc]initWithCapacity:0];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    [self setTitle:[NSString stringWithFormat:@"%@",[self.m_DetailDic objectForKey:@"Title"]]];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    // 赋值
    self.m_titleLabel.text = [NSString stringWithFormat:@"%@",[self.m_DetailDic objectForKey:@"Title"]];
    
    self.m_timeLabel.text = [NSString stringWithFormat:@"%@",[self.m_DetailDic objectForKey:@"ModifyDate"]];
    
    [self hideGradientBackground:self.m_webView];

    NSString *string = [NSString stringWithFormat:@"%@",[self.m_DetailDic objectForKey:@"Content"]];
                        
       // 加载webView数据
    [self.m_webView loadHTMLString:string baseURL:nil];
    
    // 设置文字显示在整个webView里面
//    [self.m_webView setScalesPageToFit:YES];
    
    self.m_webView.scrollView.showsHorizontalScrollIndicator = NO;
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self hideTabBar:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [self hideTabBar:NO];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)leftClicked{
    
    [self goBack];
}

#pragma mark - UIwebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView{
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
	// report the error inside the webview
	NSString* errorString = [NSString stringWithFormat:
							 @"<html><center><font size=+5 color='red'>An error occurred:<br>%@</font></center></html>",
							 error.localizedDescription];
	[self.m_webView loadHTMLString:errorString baseURL:nil];
}

@end
