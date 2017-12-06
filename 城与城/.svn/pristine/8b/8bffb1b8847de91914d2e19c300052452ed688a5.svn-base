//
//  ExplanationViewController.m
//  baozhifu
//
//  Created by mac on 13-12-24.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "ExplanationViewController.h"

#import "ApplicationCodeViewController.h"

#import "AppHttpClient.h"

#import "CommonUtil.h"

#import "SVProgressHUD.h"

#import "ApplicationPayViewController.h"

@interface ExplanationViewController ()

@property (weak, nonatomic) IBOutlet UIView *m_titleView;

@property (weak, nonatomic) IBOutlet UIView *m_tempView;

@property (weak, nonatomic) IBOutlet UIWebView *m_webView;

@property (weak, nonatomic) IBOutlet UIButton *m_applicationBtn;

// 立即申请按钮触发的事件
- (IBAction)applicationClicked:(id)sender;

@end

@implementation ExplanationViewController

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
    
   
    [self setTitle:@"申请公众邀请码"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    
    [self hideGradientBackground:self.m_webView];
   
    [self.m_webView sizeToFit];
    
    self.m_applicationBtn.hidden = YES;
    
    self.m_webView.hidden = YES;
    
    
    // 请求数据
    [self requestSubmit];


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

- (void)viewDidUnload {
    [self setM_titleView:nil];
    [self setM_tempView:nil];
    [self setM_webView:nil];
    [self setM_applicationBtn:nil];
    [super viewDidUnload];
}

- (void)leftClicked{
    
    [self goBack];
}

- (void)requestSubmit{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,     @"memberId",
                           key,   @"key",
                           nil];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"MemberInvitePanel.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            
            self.m_applicationBtn.hidden = NO;
            
            self.m_webView.hidden = NO;

            [SVProgressHUD dismiss];
            
            NSString *msg = [json valueForKey:@"msg"];
            
            [self.m_webView loadHTMLString:msg baseURL:nil];
            
        } else {
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
    } failure:^(NSError *error) {
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];

}

- (IBAction)applicationClicked:(id)sender {
  
    // 进入公众邀请码申请的页面
//    ApplicationCodeViewController *VC = [[ApplicationCodeViewController alloc]initWithNibName:@"ApplicationCodeViewController" bundle:nil];
//    [self.navigationController pushViewController:VC animated:YES];

    
    ApplicationPayViewController *VC = [[ApplicationPayViewController alloc]initWithNibName:@"ApplicationPayViewController" bundle:nil];
    [self.navigationController pushViewController:VC animated:YES];
    
}

@end
