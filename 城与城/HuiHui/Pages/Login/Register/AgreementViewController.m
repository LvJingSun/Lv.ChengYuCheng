//
//  AgreementViewController.m
//  baozhifu
//
//  Created by mac on 13-11-1.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "AgreementViewController.h"

#import "CommonUtil.h"

#import "SVProgressHUD.h"

#import "AppHttpClient.h"

@interface AgreementViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *m_webView;

@property (weak, nonatomic) IBOutlet UIView *m_titleView;


@end

@implementation AgreementViewController

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
    
    [self setTitle:@"协议"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    // 请求接口
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
- (void)leftClicked{
    
    [self goBack];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setM_webView:nil];
    [self setM_titleView:nil];
    [super viewDidUnload];
}

- (void)requestSubmit{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
   
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"Agreement.ashx" parameters:nil success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            
            [SVProgressHUD dismiss];

//            NSString *msg = [json valueForKey:@"msg"];
            
            NSDictionary *data = [json valueForKey:@"infoAbout"];
            [self reflashView:data];
            
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
    } failure:^(NSError *error) {
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];

}

- (void)reflashView:(NSDictionary *)data {
    
    [self.m_webView loadHTMLString:[data objectForKey:@"Content"] baseURL:nil];

}


@end
