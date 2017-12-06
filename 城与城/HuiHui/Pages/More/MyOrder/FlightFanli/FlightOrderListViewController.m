//
//  FlightOrderListViewController.m
//  HuiHui
//
//  Created by mac on 15-3-31.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "FlightOrderListViewController.h"

#import "HH_FanliViewController.h"

#import "FanliListViewController.h"

@interface FlightOrderListViewController ()

@property (weak, nonatomic) IBOutlet UILabel *m_titleLabel;


- (IBAction)fanliClicked:(id)sender;


@end

@implementation FlightOrderListViewController

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
    [self setTitle:@"同程网机票订单"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    [self setRightButtonWithTitle:@"联系客服" action:@selector(callClicked)];
    
    self.m_titleLabel.layer.masksToBounds = YES;//设置圈角
    self.m_titleLabel.layer.cornerRadius = 5.0;
    self.m_titleLabel.text = [NSString stringWithFormat:@"\n\t1、目前，同程网的所有机票订单暂不支持显示，若您需要退款、查询等操作，可以联系同程网官方客服。\n\t2、目前您可以手动申请购买机票时所获得的返利。\n\n\t您需要提供：\n\n\t购买的机票的订单号\n"];
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)leftClicked{
    
    [self goBack];
}

- (void)callClicked{
    // 联系客服
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil
                                                        delegate:self
                                               cancelButtonTitle:@"取消"
                                          destructiveButtonTitle:nil
                                               otherButtonTitles:@"400-799-1555",nil];
    sheet.tag = 10001;
    [sheet showInView:self.view];
    
}

#pragma mark - UIActionSheetDelegate
- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 10001)
    {
        if (buttonIndex==0)
        {
            // test =======
            NSString *phone = @"4007991555";

            // 判断设备是否支持
            if([[[UIDevice currentDevice] model] rangeOfString:@"iPhone Simulator"].location != NSNotFound) {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示"
                                                                message:@"该设备暂不支持电话功能"
                                                               delegate:self
                                                      cancelButtonTitle:@"确定"
                                                      otherButtonTitles: nil];
                [alert show];
                
            }else{
                
                self.m_webView = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
                [self.m_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", phone]]]];
                
            }
            
        }
        
    }
    
}

- (IBAction)fanliClicked:(id)sender {
    // 进入申请返利的页面
//    HH_FanliViewController *VC = [[HH_FanliViewController alloc]initWithNibName:@"HH_FanliViewController" bundle:nil];
//    [self.navigationController pushViewController:VC animated:YES];
    
    FanliListViewController *VC = [[FanliListViewController alloc]initWithNibName:@"FanliListViewController" bundle:nil];
    [self.navigationController pushViewController:VC animated:YES];

    
}




@end
