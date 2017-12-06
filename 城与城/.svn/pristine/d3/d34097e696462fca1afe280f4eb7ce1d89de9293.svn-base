//
//  Fl_orderDetailViewController.m
//  HuiHui
//
//  Created by mac on 15-1-8.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "Fl_orderDetailViewController.h"

#import "flightsOrderListCell.h"

#import "Fl_orderPayViewController.h"

@interface Fl_orderDetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *m_dateTime;
@property (weak, nonatomic) IBOutlet UILabel *m_dptTime;
@property (weak, nonatomic) IBOutlet UILabel *m_arrTime;
@property (weak, nonatomic) IBOutlet UILabel *m_distance;
@property (weak, nonatomic) IBOutlet UITableView *m_tableView;

@property (strong, nonatomic) IBOutlet UIView *m_payView;
@property (weak, nonatomic) IBOutlet UIImageView *m_backImgV;

@end

@implementation Fl_orderDetailViewController

@synthesize m_dic;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        m_dic = [[NSMutableDictionary alloc]initWithCapacity:0];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setTitle:@"订单详情"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClciked)];
    
    self.m_backImgV.backgroundColor = [UIColor blackColor];
    self.m_backImgV.alpha = 0.6;
    
    // 表示是未支付的订单则显示导航栏右按钮“去支付”的按钮
    if ( [self.m_typeString isEqualToString:@"0"] ) {
        
        [self setRightButtonWithTitle:@"去支付" action:@selector(payOrder)];
        
    }else{
        
        self.navigationItem.rightBarButtonItem = nil;
    }
    
    // 赋值

    self.m_dateTime.text = [NSString stringWithFormat:@"%@ %@",[self.m_dic objectForKey:@"departureDate"],[self.m_dic objectForKey:@"flightNum"]];
    
    self.m_dptTime.text = [NSString stringWithFormat:@"%@  %@  %@",[self.m_dic objectForKey:@"departureTime"],[self.m_dic objectForKey:@"departureCity"],[self.m_dic objectForKey:@"departureAirportName"]];
    
    self.m_arrTime.text = [NSString stringWithFormat:@"%@  %@  %@",[self.m_dic objectForKey:@"arrivalTime"],[self.m_dic objectForKey:@"arrivalCity"],[self.m_dic objectForKey:@"arrivalAirportName"]];
    
    
    NSString *jingji = [self.m_dic objectForKey:@"IsJingji"];
    // 1表示是经济舱
    if ( [jingji isEqualToString:@"1"] ) {
        
         self.m_distance.text = [NSString stringWithFormat:@"经济舱|飞行%@|里程%@公里",[self.m_dic objectForKey:@"flightTime"],[self.m_dic objectForKey:@"distance"]];
    }else{
        
         self.m_distance.text = [NSString stringWithFormat:@"飞行%@|里程%@公里",[self.m_dic objectForKey:@"flightTime"],[self.m_dic objectForKey:@"distance"]];
    }
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear: animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)leftClciked{
    
    [self goBack];
    
}
// 导航栏右按钮“去支付”按钮触发的事件
- (void)payOrder{
    
    // 进入去支付的页面
    Fl_orderPayViewController *VC = [[Fl_orderPayViewController alloc]initWithNibName:@"Fl_orderPayViewController" bundle:nil];
    VC.m_priceString = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"hhPurchasePrice"]];
    VC.m_orderId = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"oId"]];
    [self.navigationController pushViewController:VC animated:YES];
    
}
// 导航栏右按钮“取消订单”按钮触发的事件
//- (void)callClicked{
//    
//    NSString *phone = [self.m_dic objectForKey:@"Phone"];
//    // 判断设备是否支持
//    if([[[UIDevice currentDevice] model] rangeOfString:@"iPhone Simulator"].location != NSNotFound) {
//        
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示"
//                                                        message:@"该设备暂不支持电话功能"
//                                                       delegate:self
//                                              cancelButtonTitle:@"确定"
//                                              otherButtonTitles: nil];
//        [alert show];
//        
//    }else{
//        
//        self.m_webView = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
//        [self.m_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", phone]]]];
//        
//    }
//
//}

#pragma mark - UITableDateSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ( indexPath.row == 0 ) {
        
        static NSString *cellIdentifier = @"flightsOrderPriceCellIdentifier";
        
        flightsOrderPriceCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if ( cell == nil ) {
            
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"flightsOrderListCell" owner:self options:nil];
            cell = (flightsOrderPriceCell *)[nib objectAtIndex:1];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        
        // 赋值
        cell.m_price.text = [NSString stringWithFormat:@"￥%@",[self.m_dic objectForKey:@"hhPurchasePrice"]];
        
        cell.m_orderNo.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"orderNo"]];
        
        return cell;
        
    }else if ( indexPath.row == 1 ){
        
        static NSString *cellIdentifier = @"flightsOrderRideCellIdentifier";
        
        flightsOrderRideCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if ( cell == nil ) {
            
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"flightsOrderListCell" owner:self options:nil];
            cell = (flightsOrderRideCell *)[nib objectAtIndex:2];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

        }
        
         // 赋值
         cell.m_name.text = [NSString stringWithFormat:@"%@  成人票",[self.m_dic objectForKey:@"name"]];
        
        cell.m_birthDay.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"birthday"]];
        
        cell.m_cardType.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"cardTypeName"]];
        
        cell.m_cardId.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"cardNumDisplay"]];
        
        return cell;
        
    }else{
        
        static NSString *cellIdentifier = @"flightsOrderContactCellIdentifier";
        
        flightsOrderContactCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if ( cell == nil ) {
            
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"flightsOrderListCell" owner:self options:nil];
            cell = (flightsOrderContactCell *)[nib objectAtIndex:3];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

        }
        
        // 赋值
        cell.m_phone.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"contactTel"]];
        
        return cell;
    }
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ( indexPath.row == 0 ) {
        
        return 52.0f;
        
    }else  if ( indexPath.row == 1 ) {
        
        return 94.0f;
        
    }else{
        
        return 55.0f;

    }
}

@end
