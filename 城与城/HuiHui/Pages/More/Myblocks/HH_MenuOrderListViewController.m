//
//  HH_MenuOrderListViewController.m
//  HuiHui
//
//  Created by mac on 15-6-19.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "HH_MenuOrderListViewController.h"

#import "HH_OrderMenuCell.h"

#import "HH_CardPayViewController.h"

#import "CardMenuOrderCell.h"

@interface HH_MenuOrderListViewController ()

@property (weak, nonatomic) IBOutlet UITableView *m_tableView;

@property (weak, nonatomic) IBOutlet UIButton *m_notPayBtn;

@property (weak, nonatomic) IBOutlet UIButton *m_payedBtn;

@property (weak, nonatomic) IBOutlet UIButton *m_cancelBtn;

@property (weak, nonatomic) IBOutlet UILabel *m_emptyLabel;

@property (weak, nonatomic) IBOutlet UIControl *m_control;

@property (weak, nonatomic) IBOutlet UITableView *m_menuTableView;

@property (weak, nonatomic) IBOutlet UIImageView *m_imageV;

@property (strong, nonatomic) IBOutlet UIView *m_footerView;


- (IBAction)btnClicked:(id)sender;

// 点击背景触发的事件
- (IBAction)backTap:(id)sender;
// 取消订单
- (IBAction)cancelOrderClicked:(id)sender;
// 立即支付
- (IBAction)payNowClicked:(id)sender;

@end

@implementation HH_MenuOrderListViewController

@synthesize m_orderList;

@synthesize m_shopId;

@synthesize m_status;

@synthesize m_menuOrderList;

@synthesize m_isWaiMai;

@synthesize m_merchantId;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        
        m_orderList = [[NSMutableArray alloc]initWithCapacity:0];
        
        m_menuOrderList = [[NSMutableArray alloc]initWithCapacity:0];
        
        m_index = 0;
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setTitle:@"菜单订单列表"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    self.m_tableView.hidden = YES;
    self.m_emptyLabel.hidden = YES;
    
    // 隐藏多余的分割线
    [self setExtraCellLineHidden:self.m_tableView];
   
    [self setNotPay:NO withPayed:YES withCancel:NO];
    
    self.m_imageV.alpha = 0.6;
    
    [self.m_control setFrame:CGRectMake(0, self.view.frame.size.height, WindowSizeWidth, 0)];
    
    // 隐藏多余的分割线
    [self setExtraCellLineHidden:self.m_menuTableView];
    
// 
//    self.m_footerView.frame = CGRectMake(self.m_footerView.frame.origin.x, self.m_footerView.frame.origin.y, self.m_footerView.frame.size.width, 60);
    
    NSLog(@"m_merchantId = %@",self.m_merchantId);
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)leftClicked{
    
    [self goBack];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if ( tableView == self.m_tableView ) {

        return self.m_orderList.count;

    }else{
        
        return self.m_menuOrderList.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if ( tableView == self.m_tableView ) {
        
        static NSString *cellIdentifier = @"HH_MenuOrderListCellIdentifier";
        
        HH_MenuOrderListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if ( cell == nil ) {
            
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"HH_OrderMenuCell" owner:self options:nil];
            
            cell = (HH_MenuOrderListCell *)[nib objectAtIndex:2];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            // 设置下坐标-时间和价钱的显示位置
            cell.m_orderTime.frame = CGRectMake(WindowSizeWidth - cell.m_orderTime.frame.size.width - 15, cell.m_orderTime.frame.origin.y, cell.m_orderTime.frame.size.width, cell.m_orderTime.frame.size.height);
            
            cell.m_price.frame = CGRectMake(WindowSizeWidth - cell.m_price.frame.size.width - 15, cell.m_price.frame.origin.y, cell.m_price.frame.size.width, cell.m_price.frame.size.height);
            
        }
        
        // 赋值
        if ( self.m_orderList.count != 0 ) {
            
            NSDictionary *dic = [self.m_orderList objectAtIndex:indexPath.row];
            
            cell.m_account.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Account"]];
            
            NSString *time =  [NSString stringWithFormat:@"%@",[dic objectForKey:@"BookDateTime"]];
            
            if ( time.length != 0 ) {
                
                cell.m_time.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"BookDateTime"]];
                
            }else{
                
                cell.m_time.text = @"暂无信息";
            }
            
            
            NSString *count = [NSString stringWithFormat:@"%@",[dic objectForKey:@"CloudMenuPerson"]];
            
            if ( count.length != 0 ) {
                
                cell.m_personCount.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"CloudMenuPerson"]];
                
                
            }else{
                
                cell.m_personCount.text = @"暂无信息";
                
            }
            
            
            
            cell.m_orderNo.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"OrderNumber"]];
            
            cell.m_price.text = [NSString stringWithFormat:@"%@元",[dic objectForKey:@"PriceAmount"]];
            
            cell.m_orderTime.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"CreateDate"]];
            
            
            
        }
        
        
        return cell;

    }else if ( tableView == self.m_menuTableView ){
        
        // 预定菜单的tableView页面
        static NSString *cellIdentifier = @"CardMenuOrderCellIdentifier";
        
        CardMenuOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if ( cell == nil ) {
            
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"CardMenuOrderCell" owner:self options:nil];
            
            cell = (CardMenuOrderCell *)[nib objectAtIndex:0];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        
        // 赋值
        if ( self.m_menuOrderList.count != 0 ) {
            
            NSDictionary *dic = [self.m_menuOrderList objectAtIndex:indexPath.row];
            
            cell.m_menuName.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"MenuName"]];
            cell.m_menuPrice.text = [NSString stringWithFormat:@"%@元",[dic objectForKey:@"MenuPrice"]];
            cell.m_menuCount.text = [NSString stringWithFormat:@"%@份",[dic objectForKey:@"MenuAmount"]];
            
        }
        
        
        return cell;
        
    }else{
        
        return nil;
    }
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ( tableView == self.m_tableView ) {
        
        return 97.0f;

    }else{
        
        return 60.0f;
    }
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ( tableView == self.m_tableView ) {
        
        NSDictionary *dic = [self.m_orderList objectAtIndex:indexPath.row];
        
        // 赋值
        self.m_menuOrderList = (NSMutableArray *)[dic objectForKey:@"DetailList"];
        
        
        // 设置view的坐标大小
        CGRect frame = self.view.frame;
        frame.size.height = self.view.frame.size.height;
        
        [self.m_control setFrame:CGRectMake(0, 0, WindowSizeWidth, frame.size.height)];
        
        [self.m_menuTableView reloadData];
        
        // 判断如果是未支付的情况下可以删除订单
        if ( [self.m_status isEqualToString:@"0"] ) {
            
            m_index = indexPath.row;
            
        }
        
    }
  
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    if ( tableView == self.m_menuTableView ) {
        
        if ( [self.m_status isEqualToString:@"0"] ) {
          
            UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WindowSizeWidth, 60)];
            
            view.backgroundColor = [UIColor clearColor];
            
            UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];

            btn1.frame = CGRectMake(10, 10, (WindowSizeWidth - 40)/2, 40);

            [btn1 setBackgroundImage:[UIImage imageNamed:@"blue_btn.png"] forState:UIControlStateNormal];
            [btn1 setTitle:@"取消订单" forState:UIControlStateNormal];
            [btn1 addTarget:self action:@selector(cancelOrderClicked:) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:btn1];
            
            
            UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
            btn2.frame = CGRectMake((WindowSizeWidth - 40)/2 + 30, 10, (WindowSizeWidth - 40)/2, 40);
            [btn2 setBackgroundImage:[UIImage imageNamed:@"blue_btn.png"] forState:UIControlStateNormal];
            [btn2 setTitle:@"立即支付" forState:UIControlStateNormal];
            [btn2 addTarget:self action:@selector(payNowClicked:) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:btn2];
            
            
            return view;
            
        }else{
            
            return nil;
        }
        
    }else{
        
        return nil;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    if ( tableView == self.m_menuTableView ) {
        
        if ( [self.m_status isEqualToString:@"0"] ) {
            
            return 60.0f;
            
        }else{
            
            return 0.0f;
        }

    }else{
        
        return 0.0f;

    }
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if ( alertView.tag == 19093 ) {
        
        if ( buttonIndex == 1 ) {
            
            // 取消订单
            [self cancelOrderRequest];
        }
    }
    
    
}

#pragma mark - UIActionDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if ( actionSheet.tag == 10302 ) {
        
        if ( buttonIndex == 0 ) {
            
            // 立即支付
            NSDictionary *dic = [self.m_orderList objectAtIndex:m_index];
            
            HH_CardPayViewController *VC = [[HH_CardPayViewController alloc]initWithNibName:@"HH_CardPayViewController" bundle:nil];
            VC.m_orderId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"CloudMenuOrderID"]];
            VC.m_shopId = [NSString stringWithFormat:@"%@",self.m_shopId];
            [self.navigationController pushViewController:VC animated:YES];
            
        }else if (buttonIndex == 1 ){
            
            // 删除某个订单
            [self cancelOrderRequest];
            
        }
    }
    
}

#pragma mark - NetWork
- (void)cancelOrderRequest{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        return;
    }
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    
    NSDictionary *dic = [self.m_orderList objectAtIndex:m_index];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"memberId",
                           key,@"key",
                           [NSString stringWithFormat:@"%@",[dic objectForKey:@"CloudMenuOrderID"]],@"cloudMenuOrderId",nil];
    
    [SVProgressHUD showWithStatus:@"取消订单中"];
    [httpClient request:@"DeleteCloudMenuOrder.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        NSString *msg = [json valueForKey:@"msg"];
        
        if (success) {
            
            [SVProgressHUD dismiss];
            
            // 取消成功后刷新下数据
            [self menuOrderList];
            
            
        } else {
            
            [SVProgressHUD showErrorWithStatus:msg];
        }
        
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];

    
}

- (void)menuOrderList{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        return;
    }
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"memberId",
                           key,@"key",
                           self.m_shopId,@"merchantShopId",
                           [NSString stringWithFormat:@"%@",self.m_isWaiMai],@"isWaiMai",
                           [NSString stringWithFormat:@"%@",self.m_status],@"status",nil];
    
    NSLog(@"parmas = %@",param);
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"GetCloudMenuOrder_1.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
       
        NSString *msg = [json valueForKey:@"msg"];
        
        if (success) {
            
            NSLog(@"json = %@",json);
           
            [SVProgressHUD dismiss];
            
            if ( self.m_orderList.count != 0 ) {
                
                [self.m_orderList removeAllObjects];
                
            }
            
            // 赋值
            self.m_orderList = [json valueForKey:@"orderList"];
            
            if ( self.m_orderList.count != 0 ) {
                
                self.m_emptyLabel.hidden = YES;
                self.m_tableView.hidden = NO;
                
                [self.m_tableView reloadData];
                
            }else{
                
                self.m_emptyLabel.hidden = NO;
                self.m_emptyLabel.text = @"暂时没有该类型的订单数据";
                self.m_tableView.hidden = YES;
                
            }
                
            
        } else {
            
            [SVProgressHUD showErrorWithStatus:msg];
        }
        
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];

    
}

#pragma mark - Button Click
- (IBAction)btnClicked:(id)sender {

    UIButton *btn = (UIButton *)sender;
    
    if ( btn.tag == 11 ) {
        
        [self setNotPay:YES withPayed:NO withCancel:NO];
        
    }else if ( btn.tag == 22 ){
        
        [self setNotPay:NO withPayed:YES withCancel:NO];
        
    }else{
        
        [self setNotPay:NO withPayed:NO withCancel:YES];
        
    }
    
}

- (void)setNotPay:(BOOL)aNotPay withPayed:(BOOL)aPayed withCancel:(BOOL)aCancel{
    
    self.m_notPayBtn.selected = aNotPay;
    self.m_payedBtn.selected = aPayed;
    self.m_cancelBtn.selected = aCancel;
    
    if ( aNotPay ) {
       
        self.m_notPayBtn.userInteractionEnabled = NO;
        self.m_payedBtn.userInteractionEnabled = YES;
        self.m_cancelBtn.userInteractionEnabled = YES;

        self.m_status = @"0";
        
    }
    
    if ( aPayed ) {
        
        self.m_notPayBtn.userInteractionEnabled = YES;
        self.m_payedBtn.userInteractionEnabled = NO;
        self.m_cancelBtn.userInteractionEnabled = YES;
        
        self.m_status = @"1";
        
    }
    
    if ( aCancel ) {
        
        self.m_notPayBtn.userInteractionEnabled = YES;
        self.m_payedBtn.userInteractionEnabled = YES;
        self.m_cancelBtn.userInteractionEnabled = NO;
        
        self.m_status = @"2";

    }
    
    
    // 请求订单列表的数据
    [self menuOrderList];
    
    
}

// 点击下一步按钮触发的事件
- (IBAction)backTap:(id)sender {
 
    [UIView animateWithDuration:0.3 animations:^{
        
        [self.m_control setFrame:CGRectMake(0, self.view.frame.size.height, WindowSizeWidth, 0)];
        
    } completion:^(BOOL finished){
        
        
    }];
    
}

// 取消订单按钮的操作
- (IBAction)cancelOrderClicked:(id)sender {
    
    [UIView animateWithDuration:0.3 animations:^{
        
        [self.m_control setFrame:CGRectMake(0, self.view.frame.size.height, WindowSizeWidth, 0)];
        
    } completion:^(BOOL finished){
        
        
    }];
    
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil
                                                       message:@"您确定取消订单？"
                                                      delegate:self
                                             cancelButtonTitle:@"取消"
                                             otherButtonTitles:@"确定", nil];
    alertView.tag = 19093;
    [alertView show];
}

- (IBAction)payNowClicked:(id)sender {
    
    [UIView animateWithDuration:0.3 animations:^{
        
        [self.m_control setFrame:CGRectMake(0, self.view.frame.size.height, WindowSizeWidth, 0)];
        
    } completion:^(BOOL finished){
        
        
    }];
    
    // 立即支付
    NSDictionary *dic = [self.m_orderList objectAtIndex:m_index];
    
    HH_CardPayViewController *VC = [[HH_CardPayViewController alloc]initWithNibName:@"HH_CardPayViewController" bundle:nil];
    VC.m_orderId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"CloudMenuOrderID"]];
    VC.m_shopId = [NSString stringWithFormat:@"%@",self.m_shopId];
    [self.navigationController pushViewController:VC animated:YES];
    
    
}



@end
