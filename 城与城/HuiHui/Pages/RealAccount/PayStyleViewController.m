//
//  PayStyleViewController.m
//  baozhifu
//
//  Created by mac on 14-1-15.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "PayStyleViewController.h"

#import "RechargeViewController.h"

#import "CommonUtil.h"

#import "RechargeViewController.h"

#include "RealAccountViewController.h"

#import "RealAccountResultViewController.h"

#import "RechargeAmountViewController.h"


@interface PayStyleViewController ()

@property (weak, nonatomic) IBOutlet UIView *m_titleView;

@property (weak, nonatomic) IBOutlet UIView *m_tempView;

// 快捷支付按钮触发的事件
- (IBAction)quickPayClicked:(id)sender;
// 银联支付按钮触发的事件
- (IBAction)UnionPayClicked:(id)sender;
// 微信充值按钮触发的事件
- (IBAction)WeChatRechargeClicked:(id)sender;
// 支付宝充值按钮点击
- (IBAction)ZhiFuBaoRechargeClicked:(id)sender;

@end

@implementation PayStyleViewController

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
    
    [self setTitle:@"充值方式"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
   
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear: animated];
    
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

- (IBAction)quickPayClicked:(id)sender {
    
    if ( [self.m_typeString isEqualToString:@"1"] ) {
        
        // 快捷支付根据个人的不同状态来进入不同的页面
       NSString *vldStatus = [CommonUtil getValueByKey:REALAUSTATUS];
        
        if ([VLD_STATUS_VALID isEqualToString:vldStatus]) {
            RechargeViewController *viewController = [[RechargeViewController alloc] initWithNibName:@"RechargeViewController" bundle:nil];
            [self.navigationController pushViewController:viewController animated:YES];
            
        } else if ([VLD_STATUS_NOT_CERTIFIED isEqualToString:vldStatus]) {
            
            RealAccountViewController *viewController = [[RealAccountViewController alloc] initWithNibName:@"RealAccountViewController" bundle:nil];
            [self.navigationController pushViewController:viewController animated:YES];
            
        } else {
            
            RealAccountResultViewController *viewController = [[RealAccountResultViewController alloc] initWithNibName:@"RealAccountResultViewController" bundle:nil];
            //viewController.message = [self.appMore objectForKey:@"realAuReason"];
            //viewController.status = vldStatus;
            [self.navigationController pushViewController:viewController animated:YES];
            
        }

    }else{
        
        // 进入充值页面
        RechargeViewController *viewController = [[RechargeViewController alloc] initWithNibName:@"RechargeViewController" bundle:nil];
        [self.navigationController pushViewController:viewController animated:YES];

        
    }
}

- (IBAction)UnionPayClicked:(id)sender {
    
    // 快捷支付进入填写充值金额的页面
    RechargeAmountViewController *VC = [[RechargeAmountViewController alloc]initWithNibName:@"RechargeAmountViewController" bundle:nil];
    
    VC.payType = @"1";
    [self.navigationController pushViewController:VC animated:YES];
    
    
}

- (IBAction)WeChatRechargeClicked:(id)sender {
    
    RechargeAmountViewController *VC = [[RechargeAmountViewController alloc]initWithNibName:@"RechargeAmountViewController" bundle:nil];
    VC.payType = @"2";
    [self.navigationController pushViewController:VC animated:YES];
    
}

- (IBAction)ZhiFuBaoRechargeClicked:(id)sender {
    
    RechargeAmountViewController *VC = [[RechargeAmountViewController alloc]initWithNibName:@"RechargeAmountViewController" bundle:nil];
    VC.payType = @"3";
    [self.navigationController pushViewController:VC animated:YES];
    
}

@end
