//
//  Fl_orderListViewController.m
//  HuiHui
//
//  Created by mac on 15-1-7.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "Fl_orderListViewController.h"

#import "flightsOrderListCell.h"

#import "CommonUtil.h"

#import "Fl_orderDetailViewController.h"

@interface Fl_orderListViewController ()

@property (weak, nonatomic) IBOutlet UITableView *m_tableView;

@property (weak, nonatomic) IBOutlet UIButton *m_notpaidBtn;
@property (weak, nonatomic) IBOutlet UIButton *m_paidBtn;
@property (weak, nonatomic) IBOutlet UIButton *m_dealBtn;
@property (weak, nonatomic) IBOutlet UIButton *m_refundBtn;

@property (weak, nonatomic) IBOutlet UILabel *m_emptyLabel;

// 类型切换选择
- (IBAction)typeChange:(id)sender;


@end

@implementation Fl_orderListViewController

@synthesize m_type;

@synthesize m_orderList;

@synthesize m_typeString;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        m_orderList = [[NSMutableArray alloc]initWithCapacity:0];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setTitle:@"机票订单"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    // 默认隐藏空间
    self.m_emptyLabel.hidden = YES;
    
    self.m_tableView.hidden = YES;
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    // 默认选中第一个
    [self setUnPaid:YES withPaid:NO withDeal:NO withRefund:NO];
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
    
    // 判断来自于哪个页面 1表示订单支付方式选择的页面 2表示订单支付成功的页面
    if ( [self.m_typeString isEqualToString:@"2"] ) {
        
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
   
    }else{
        
         [self goBack];
    }
    
   
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.m_orderList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"flightsOrderListCellIdentifier";
    
    flightsOrderListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"flightsOrderListCell" owner:self options:nil];
        
        cell = (flightsOrderListCell *)[nib objectAtIndex:0];
        
    }
    
    // 赋值
    if ( self.m_orderList.count != 0 ) {
        
        NSDictionary *dic = [self.m_orderList objectAtIndex:indexPath.row];
        
        cell.m_cityName.text = [NSString stringWithFormat:@"%@-%@",[dic objectForKey:@"departureCity"],[dic objectForKey:@"arrivalCity"]];
        
        cell.m_dptTime.text = [NSString stringWithFormat:@"%@ %@",[dic objectForKey:@"departureDate"],[dic objectForKey:@"departureTime"]];
        
        cell.m_airPort.text = [NSString stringWithFormat:@"%@-%@",[dic objectForKey:@"departureAirportName"],[dic objectForKey:@"arrivalAirportName"]];
        
        cell.m_flightsNum.text = [NSString stringWithFormat:@"%@%@",[dic objectForKey:@"shortCompanyName"],[dic objectForKey:@"flightNum"]];
        
        cell.m_price.text = [NSString stringWithFormat:@"￥%@",[dic objectForKey:@"hhPurchasePrice"]];
        
       
        // 判断在未支付的状态下显示去支付的label
        if ( self.m_type == NotPaidOrder ) {
        
            // 显示状态的label
            cell.m_status.hidden = NO;

        }else{
            
            // 显示状态的label
            cell.m_status.hidden = YES;

        }
    }
    
    
    return cell;
    
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 83.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // 进入订单详情的页面
    NSMutableDictionary *dic = [self.m_orderList objectAtIndex:indexPath.row];
    
    Fl_orderDetailViewController *VC = [[Fl_orderDetailViewController alloc]initWithNibName:@"Fl_orderDetailViewController" bundle:nil];
    VC.m_dic = dic;
    VC.m_typeString = [NSString stringWithFormat:@"%i",self.m_type];
    [self.navigationController pushViewController:VC animated:YES];
    
    
}

- (IBAction)typeChange:(id)sender {
    
    UIButton *btn = (UIButton *)sender;
    
    if ( btn.tag == 11 ) {
        // 未付款
        [self setUnPaid:YES withPaid:NO withDeal:NO withRefund:NO];
        
    }else if ( btn.tag == 22 ){
        // 已付款
        [self setUnPaid:NO withPaid:YES withDeal:NO withRefund:NO];
        
    }else if ( btn.tag == 33 ){
        // 处理中
        [self setUnPaid:NO withPaid:NO withDeal:YES withRefund:NO];
        
    }else{
        // 已退款
        [self setUnPaid:NO withPaid:NO withDeal:NO withRefund:YES];
        
    }
    
    
}

- (void)setUnPaid:(BOOL)aUnpaid withPaid:(BOOL)aPaid withDeal:(BOOL)aDeal withRefund:(BOOL)aRefund{
    
    self.m_notpaidBtn.selected = aUnpaid;
    self.m_paidBtn.selected = aPaid;
    self.m_dealBtn.selected = aDeal;
    self.m_refundBtn.selected = aRefund;
    
    
    if ( aUnpaid ) {
        
        self.m_notpaidBtn.userInteractionEnabled = NO;
        self.m_paidBtn.userInteractionEnabled = YES;
        self.m_dealBtn.userInteractionEnabled = YES;
        self.m_refundBtn.userInteractionEnabled = YES;
        
        self.m_type = NotPaidOrder;
        
    }
    
    if ( aPaid ) {
        
        self.m_notpaidBtn.userInteractionEnabled = YES;
        self.m_paidBtn.userInteractionEnabled = NO;
        self.m_dealBtn.userInteractionEnabled = YES;
        self.m_refundBtn.userInteractionEnabled = YES;
        
        self.m_type = PaidOrder;

    }
    
    if ( aDeal ) {
        
        self.m_notpaidBtn.userInteractionEnabled = YES;
        self.m_paidBtn.userInteractionEnabled = YES;
        self.m_dealBtn.userInteractionEnabled = NO;
        self.m_refundBtn.userInteractionEnabled = YES;
        
        self.m_type = DealOrder;

    }
    
    if ( aRefund ) {
        
        self.m_notpaidBtn.userInteractionEnabled = YES;
        self.m_paidBtn.userInteractionEnabled = YES;
        self.m_dealBtn.userInteractionEnabled = YES;
        self.m_refundBtn.userInteractionEnabled = NO;
        
        self.m_type = RefundOrder;

    }
    
    // 请求数据
    [self requestOrderSubmit];
    
}

#pragma mark - Network 订单请求接口
- (void)requestOrderSubmit{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    // 获取memberId
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient1];
    
    // 支付方式payStyle bzf(诲诲余额支付)
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"memberId",
                           [NSString stringWithFormat:@"%i",self.m_type],@"status",
                           
                           nil];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    [httpClient requestFlights:@"QunarOrderInfo.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        // status 0表示有数据 其他表示错误
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if ( success ) {
            
            [SVProgressHUD dismiss];
            
//            NSString *msg = [json valueForKey:@"msg"];
//            
//            [SVProgressHUD showSuccessWithStatus:msg];
            
            // 如果数组有数据则清空数组
            if ( self.m_orderList.count != 0 ) {
            
                [self.m_orderList removeAllObjects];
                
            }
            
            self.m_orderList = [json valueForKey:@"orderList"];
            
            if ( self.m_orderList.count == 0 ) {
                
                self.m_emptyLabel.hidden = NO;
                
                self.m_tableView.hidden = YES;
                
                self.m_emptyLabel.text = @"您暂时没有该类型的订单";
                
            }else{
                
                self.m_emptyLabel.hidden = YES;
                
                self.m_tableView.hidden = NO;
                
                // 刷新列表
                [self.m_tableView reloadData];
            }
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
            
            
        }
    } failure:^(NSError *error) {
        NSLog(@"failed:%@", error);
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];

    
    
}

@end
