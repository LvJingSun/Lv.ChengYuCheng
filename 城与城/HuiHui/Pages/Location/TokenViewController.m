//
//  TokenViewController.m
//  HuiHui
//
//  Created by mac on 14-2-13.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "TokenViewController.h"

#import "InviteViewController.h"

#import <QuartzCore/QuartzCore.h>

#import "CommonUtil.h"

#import "SVProgressHUD.h"

#import "AppHttpClient.h"

@interface TokenViewController ()

@property (weak, nonatomic) IBOutlet UIView *m_backView;

@property (weak, nonatomic) IBOutlet UIScrollView *m_scrollerView;

@property (weak, nonatomic) IBOutlet UILabel *m_tokenLanbel;

@property (weak, nonatomic) IBOutlet UILabel *m_usedTokenLabel;


// 邀请好友触发的事件
- (IBAction)inviteFriends:(id)sender;

@end

@implementation TokenViewController

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
    
    if ( [self.m_stringType isEqualToString:@"1"] ) {
        
        [self setTitle:@"获取令牌"];

    }else{
        
        [self setTitle:@"我的令牌"];

    }
    
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    // 设置cell的背景边框
    self.m_backView.layer.borderColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0].CGColor;
    self.m_backView.layer.borderWidth = 1.0;
    
  
    if ( !iPhone5 ) {
        
        // 设置scroller的滚动范围
        [self.m_scrollerView setContentSize:CGSizeMake(WindowSizeWidth, 580)];
    }
    
    // 请求令牌的数据
    [self toekenRequestSubmit];
    
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

// 令牌请求数据
- (void)toekenRequestSubmit{
    
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

    [httpClient request:@"MemberToken.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            
            [SVProgressHUD dismiss];
            
            // 令牌
            [CommonUtil addValue:[json valueForKey:@"TokenNoUsedTotal"] andKey:TOKENNOUSEDTOTAL];
            
            [CommonUtil addValue:[json valueForKey:@"TokenUsedTotal"] andKey:TOKENUSEDTOTAL];
            
            // 赋值
            self.m_tokenLanbel.text = [NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:TOKENNOUSEDTOTAL]];
            
            self.m_usedTokenLabel.text = [NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:TOKENUSEDTOTAL]];
            
            
        } else {
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
    } failure:^(NSError *error) {
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];
    
}


- (IBAction)inviteFriends:(id)sender {
    
    // 邀请好友
    InviteViewController *VC = [[InviteViewController alloc]initWithNibName:@"InviteViewController" bundle:nil];
//    VC.m_dic = dic;
//    VC.stringType = @"2";
    [self.navigationController pushViewController:VC animated:YES];
}

@end
