//
//  orderChooseViewController.m
//  HuiHui
//
//  Created by mac on 15-1-4.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "orderChooseViewController.h"

#import "MyOrderListViewController.h"
#import "Ctrip_hotelorderlistViewController.h"
#import "DingpingOrderViewController.h"

#import "Fl_orderListViewController.h"
#import "SceneryOrderListViewController.h"
#import "TongchenghotelorderViewController.h"
#import "FlightOrderListViewController.h"

#import "MenuOrderListViewController.h"

@interface orderChooseViewController ()
// 联盟商户订单点击触发的事件
- (IBAction)merchantOrderClicked:(id)sender;

- (IBAction)ctripClicked:(id)sender;

- (IBAction)flightsClicked:(id)sender;

// 景区订单
- (IBAction)sceneryClicked:(id)sender;

@end

@implementation orderChooseViewController

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
    [self setTitle:@"我的订单"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];

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

- (IBAction)merchantOrderClicked:(id)sender {
    
    // 我的订单
    MyOrderListViewController *VC = [[MyOrderListViewController alloc]initWithNibName:@"MyOrderListViewController" bundle:nil];
    [self.navigationController pushViewController:VC animated:YES];
}

- (IBAction)menuOrderClicked:(id)sender {
    // 点单订单
    MenuOrderListViewController *VC = [[MenuOrderListViewController alloc]initWithNibName:@"MenuOrderListViewController" bundle:nil];
    [self.navigationController pushViewController:VC animated:YES];
//    MenuEvaluationViewController *VC = [[MenuEvaluationViewController alloc]initWithNibName:@"MenuEvaluationViewController" bundle:nil];
//    [self.navigationController pushViewController:VC animated:YES];


}

- (IBAction)DingpingClicked:(id)sender {
    
    // 点评网订单（暂时获取不到 只提供电话客服）
    DingpingOrderViewController *VC = [[DingpingOrderViewController alloc]initWithNibName:@"DingpingOrderViewController" bundle:nil];
    [self.navigationController pushViewController:VC animated:YES];
    
}

- (IBAction)ctripClicked:(id)sender {
    
    // 酒店订单
//    Ctrip_hotelorderlistViewController *VC = [[Ctrip_hotelorderlistViewController alloc]initWithNibName:@"Ctrip_hotelorderlistViewController" bundle:nil];
//    [self.navigationController pushViewController:VC animated:YES];
    //同程酒店订单
    TongchenghotelorderViewController *VC = [[TongchenghotelorderViewController alloc]initWithNibName:@"TongchenghotelorderViewController" bundle:nil];
    [self.navigationController pushViewController:VC animated:YES];

}

- (IBAction)flightsClicked:(id)sender {
    
    // 进入机票订单的页面
//    Fl_orderListViewController *VC = [[Fl_orderListViewController alloc]initWithNibName:@"Fl_orderListViewController" bundle:nil];
//    VC.m_typeString = @"1";
//    [self.navigationController pushViewController:VC animated:YES];
    
    FlightOrderListViewController *VC = [[FlightOrderListViewController alloc]initWithNibName:@"FlightOrderListViewController" bundle:nil];
    [self.navigationController pushViewController:VC animated:YES];


}

- (IBAction)sceneryClicked:(id)sender {
    
    // 进入景区预定的订单页面
    SceneryOrderListViewController *VC = [[SceneryOrderListViewController alloc]initWithNibName:@"SceneryOrderListViewController" bundle:nil];
    VC.m_stringType = @"1";
    [self.navigationController pushViewController:VC animated:YES];
    
}

@end
