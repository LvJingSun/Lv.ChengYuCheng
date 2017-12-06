//
//  HotelChooseViewController.m
//  HuiHui
//
//  Created by mac on 15-4-27.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
// 

#import "HotelChooseViewController.h"

#import "Ca_productListViewController.h"

#import "Hotel_webViewController.h"

@interface HotelChooseViewController ()

// 酒店团购按钮触发的事件
- (IBAction)hotelClicked:(id)sender;
// 同程酒店预订按钮触发的事件
- (IBAction)TCHotelBook:(id)sender;

@end

@implementation HotelChooseViewController

@synthesize m_titleString;

@synthesize m_code;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"酒店类别选择"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    NSLog(@"title = %@,code = %@",self.m_titleString,self.m_code);
    
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

- (IBAction)hotelClicked:(id)sender {
    
    // 进入商品列表的页面
    Ca_productListViewController *VC = [[Ca_productListViewController alloc]initWithNibName:@"Ca_productListViewController" bundle:nil];
    VC.TwoID = [NSString stringWithFormat:@"%@",self.m_code];
    VC.m_titleString = [NSString stringWithFormat:@"%@",self.m_titleString];
    [self.navigationController pushViewController:VC animated:YES];

}

- (IBAction)TCHotelBook:(id)sender {
    
    Hotel_webViewController *VC = [[Hotel_webViewController alloc]initWithNibName:@"Hotel_webViewController" bundle:nil];
    [self.navigationController  pushViewController:VC animated:YES];

}

@end
