//
//  MyOrderListViewController.m
//  HuiHui
//
//  Created by mac on 13-11-21.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import "MyOrderListViewController.h"

#import "OrderCell.h"

#import "ProductDetailViewController.h"

#import "CommonUtil.h"

#import "SVProgressHUD.h"

#import "AppHttpClient.h"

#import "ConfirmOrderViewController.h"

#import "DPbuyViewController.h"


@interface MyOrderListViewController ()

@property (weak, nonatomic) IBOutlet UIButton *m_waitpayBtn;

@property (weak, nonatomic) IBOutlet UIButton *m_buyedBtn;

@property (weak, nonatomic) IBOutlet UILabel *m_emptyLabel;

@property (weak, nonatomic) IBOutlet UITableView *m_tableView;

@property (weak, nonatomic) IBOutlet UIImageView *m_moveImgV;


// 按钮点击事件
- (IBAction)typeChange:(id)sender;

- (void)setLeft:(BOOL)isLeft withRight:(BOOL)isRight;

// 滑块移动位置
- (void)moveImageMoveTo:(CGFloat)rectPoint;

@end

@implementation MyOrderListViewController

@synthesize m_productList;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        m_productList = [[NSMutableArray alloc]initWithCapacity:0];
        self.dp_productList = [[NSMutableArray alloc]initWithCapacity:0];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"我的订单"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    self.m_tableView.hidden = YES;
    
    self.m_emptyLabel.hidden = YES;
    
    
    self.m_typeString = KEY_TYPE_WAITPAY;
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
//    [self hideTabBar:YES];
    
    if ( self.m_typeString == KEY_TYPE_WAITPAY ) {
        
        // 默认选中待付款
        [self setLeft:YES withRight:NO];
        
    }else{
        
        [self setLeft:NO withRight:YES];
        
    }

    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
//    [self hideTabBar:NO];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 滑块移动位置
- (void)moveImageMoveTo:(CGFloat)rectPoint
{
    [UIView beginAnimations:@"Flips1" context:(__bridge void *)(self)];
    [UIView setAnimationDuration:0.3];
    self.m_moveImgV.frame = CGRectMake(rectPoint, 40, WindowSizeWidth / 2 - 1, 4);
    [UIView commitAnimations];
}

- (void)leftClicked{
    
    [self goBack];
}

#pragma mark - 请求数据
// 订单请求数据
- (void)requestOrderSubmit{
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
   // ordStatus	状态(HasBeenPaid:已支付、ToBePaid待付款)
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,     @"memberId",
                           key,   @"key",
                           [NSString stringWithFormat:@"%@",self.m_typeString],@"ordStatus",
                           nil];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    [httpClient request:@"MemberOrderList.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            [SVProgressHUD dismiss];
            
            if ( self.m_productList.count != 0 ) {
                
                [self.m_productList removeAllObjects];

            }
            
            NSLog(@"json = %@",json);
            
            self.m_productList = [json valueForKey:@"orderInfo"];
            
            
            //点评订单已经去除
//            [self ServicesFromDP_jl];
            

            if ( self.m_productList.count != 0 ) {
                
                self.m_emptyLabel.hidden = YES;
                
                self.m_tableView.hidden = NO;
                
                
                // 刷新列表
                [self.m_tableView reloadData];
                
            }else{
                
                self.m_emptyLabel.hidden = NO;
                
                self.m_tableView.hidden = YES;
                
                if ( self.m_typeString == KEY_TYPE_WAITPAY ) {
                    
                    self.m_emptyLabel.text = @"暂无待付款的订单！";
                    
                }else{
                    
                    self.m_emptyLabel.text = @"暂无已付款的订单！";

                }
                
            }
  
           
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showErrorWithStatus:msg];
            
            
        }
    } failure:^(NSError *error) {
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];
    
}

- (IBAction)typeChange:(id)sender{
    
    UIButton *btn = (UIButton *)sender;
    
    if ( btn.tag == 100 ) {
        
        [self setLeft:YES withRight:NO];
        
        // 设置滑块滚动的坐标
        [self moveImageMoveTo:0];
        
    }else{
        
        [self setLeft:NO withRight:YES];
        
        // 设置滑块滚动的坐标
        [self moveImageMoveTo:WindowSizeWidth / 2 + 1];
 
    }
    
}

- (void)setLeft:(BOOL)isLeft withRight:(BOOL)isRight{
    
    self.m_waitpayBtn.selected = isLeft;
    
    self.m_buyedBtn.selected = isRight;
    
    if ( isLeft ) {
        
        self.m_waitpayBtn.userInteractionEnabled = NO;
        self.m_buyedBtn.userInteractionEnabled = YES;
        
        self.m_typeString = KEY_TYPE_WAITPAY;

        
    }else{
        
        self.m_waitpayBtn.userInteractionEnabled = YES;
        self.m_buyedBtn.userInteractionEnabled = NO;
        
        self.m_typeString = KEY_TYPE_BUYED;
    }
    
    // 请求数据
    [self requestOrderSubmit];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.m_productList.count+self.dp_productList.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if ( self.m_typeString == KEY_TYPE_WAITPAY ) {
        
        
        
        if (indexPath.row<self.m_productList.count) {
        
        static NSString *cellIdentifier = @"OrderCellIdentifier";
        
        OrderCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if ( cell == nil ) {
            
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"OrderCell" owner:self options:nil];
            
            cell = (OrderCell *)[nib objectAtIndex:0];
            
            cell.selectionStyle = UITableViewCellSelectionStyleGray;
            
        }
        
        // 赋值
        if ( self.m_productList.count != 0 ) {
            
            NSMutableDictionary *dic = [self.m_productList objectAtIndex:indexPath.row];
            
            cell.m_productName.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"ServiceName"]];
            cell.m_count.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Amount"]];
            cell.m_unitPrice.text = [NSString stringWithFormat:@"￥%@",[dic objectForKey:@"Price"]];
            cell.m_keyTime.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"KeyVaildDate"]];
           
            // 设置图片
            [cell setImageView:[NSString stringWithFormat:@"%@",[dic objectForKey:@"ServiceLog"]]];
            
            
            cell.m_cancelBtn.tag = indexPath.row;
            
            cell.m_payBtn.tag = indexPath.row;
            
            [cell.m_cancelBtn addTarget:self action:@selector(cancelOrder:) forControlEvents:UIControlEventTouchUpInside];
            
            [cell.m_payBtn addTarget:self action:@selector(payOrder:) forControlEvents:UIControlEventTouchUpInside];
            
            
        }

        return cell;
            
        }else{
            
            //点评
            static NSString *cellIdentifier = @"dp_OrderCellIdentifier";
            
            dp_OrderPayedCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            
            if ( cell == nil ) {
                
                NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"OrderCell" owner:self options:nil];
                
                cell = (dp_OrderPayedCell *)[nib objectAtIndex:2];
                
                cell.selectionStyle = UITableViewCellSelectionStyleGray;
                
            }
            
            // 赋值
            if ( self.dp_productList.count != 0 ) {
                
                NSMutableDictionary *dic = [self.dp_productList objectAtIndex:indexPath.row-self.m_productList.count];
                cell.dp_numLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"transaction_count"]];
                cell.dp_order_id.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"order_id"]];
                cell.dp_priceLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"transaction_count"]];
                cell.dp_timeLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"update_time"]];
                
                
            }
            
            return cell;
            
            
        }
        
    }else{
        
        if (indexPath.row<self.m_productList.count) {
            
            
            static NSString *cellIdentifier = @"OrderPayedCellIdentifier";
            
            OrderPayedCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            
            if ( cell == nil ) {
                
                NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"OrderCell" owner:self options:nil];
                
                cell = (OrderPayedCell *)[nib objectAtIndex:1];
                
                
                cell.selectionStyle = UITableViewCellSelectionStyleGray;
                
            }
            
            
            // 赋值
            if ( self.m_productList.count != 0 ) {
                
                
                NSMutableDictionary *dic = [self.m_productList objectAtIndex:indexPath.row];
                
                cell.m_productName.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"ServiceName"]];
                cell.m_countLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Amount"]];
                cell.m_priceLabel.text = [NSString stringWithFormat:@"￥%@",[dic objectForKey:@"Price"]];
                cell.m_keyTime.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"KeyVaildDate"]];
                
                // 设置图片
                [cell setImageString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"ServiceLog"]]];
                
                // OrderStatus   1：未使用、2：已使用
                if ( [[dic objectForKey:@"OrderStatus"]isEqualToString:@"1"] ) {
                    
                    cell.m_statusImgV.image = [UIImage imageNamed:@"weishiyong.png"];
                    cell.m_statusLabel.text = @"未使用";
                    
                    cell.m_timeInfo.hidden = YES;
                    
                    cell.m_timeLabel.hidden = YES;
                    
                }else if ( [[dic objectForKey:@"OrderStatus"]isEqualToString:@"2"] ) {
                    
                    cell.m_statusImgV.image = [UIImage imageNamed:@"yishiyong.png"];
                    cell.m_statusLabel.text = @"已使用";
                    
                    cell.m_timeInfo.hidden = NO;
                    
                    cell.m_timeLabel.hidden = NO;
                    
                    cell.m_timeLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"UseDate"]];
                }
                
                
            }
            
            
            return cell;
            

            
        }else{
            
            //点评
            static NSString *cellIdentifier = @"dp_OrderCellIdentifier";
            
            dp_OrderPayedCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            
            if ( cell == nil ) {
                
                NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"OrderCell" owner:self options:nil];
                
                cell = (dp_OrderPayedCell *)[nib objectAtIndex:2];
                
                cell.selectionStyle = UITableViewCellSelectionStyleGray;
                
            }
            
            // 赋值
            if ( self.dp_productList.count != 0 ) {
                
                NSMutableDictionary *dic = [self.dp_productList objectAtIndex:indexPath.row-self.m_productList.count];
                
                cell.dp_numLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"transaction_count"]];
                cell.dp_order_id.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"order_id"]];
                cell.dp_priceLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"transaction_count"]];
                cell.dp_timeLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"update_time"]];
                
                
                
                
            }
            
            return cell;
            
            
        }
    
    }
    
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.row <self.m_productList.count) {
        
        NSMutableDictionary *dic = [self.m_productList objectAtIndex:indexPath.row];
        
        // 进入商品详情
        ProductDetailViewController *VC = [[ProductDetailViewController alloc]initWithNibName:@"ProductDetailViewController" bundle:nil];
        VC.m_productId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"ServiceId"]];
        VC.m_merchantShopId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"MerchantShopID"]];
        VC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:VC animated:YES];
        
    }else{
        
//        DPbuyViewController * VC = [[DPbuyViewController alloc]initWithNibName:@"DPbuyViewController" bundle:nil];
//        VC.dp_buystring = @"http://lite.m.dianping.com/my/bindphone?redir=/my/group/receiptlist?st=1&hasheader=0&direct=true";
//        VC.dp_Type = @"2";
//        [self.navigationController pushViewController:VC animated:YES];
        
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];


}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ( self.m_typeString == KEY_TYPE_WAITPAY ) {
        
        if (indexPath.row>=self.m_productList.count) {
            
            return 118.0f;

        }
        return 148.0f;
        
    }else{
        if (indexPath.row>=self.m_productList.count) {
            
            return 118.0f;
            
        }
        
        return 116.0f;
    }
}

#pragma mark - 取消按钮触发的事件
- (void)cancelOrder:(id)sender{
    
    UIButton *btn = (UIButton *)sender;
    
    self.m_cancelIndex = btn.tag;
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示"
                                                       message:@"您确定取消订单？"
                                                      delegate:self
                                             cancelButtonTitle:@"取消"
                                             otherButtonTitles:@"确定", nil];
    alertView.tag = 10293;
    [alertView show];
    
      
}

- (void)payOrder:(id)sender{
    
    UIButton *btn = (UIButton *)sender;
    
    self.m_payIndex = btn.tag;
    
    NSMutableDictionary *dic = [self.m_productList objectAtIndex:btn.tag];
    
    NSMutableArray *array = [NSMutableArray arrayWithObject:dic];
    
    // 进入确认订单的界面
    ConfirmOrderViewController *VC = [[ConfirmOrderViewController alloc]initWithNibName:@"ConfirmOrderViewController" bundle:nil];
    VC.m_productList = array;
//    VC.m_countDictionary = self.m_countDic;
    VC.m_orderId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"OrderId"]];
    VC.m_typeString = @"2";
    [self.navigationController pushViewController:VC animated:YES];

   
}

- (void)cancelOrderRequest:(NSString *)orderId{
        
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,     @"memberId",
                           key,   @"key",
                           [NSString stringWithFormat:@"%@",orderId],@"orderId",
                           nil];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    [httpClient request:@"MemberCancelOrder.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            
            NSString *msg = [json valueForKey:@"msg"];

            [SVProgressHUD showSuccessWithStatus:msg];
                
            [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(requestOrderSubmit) userInfo:nil repeats:NO];
         
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showErrorWithStatus:msg];
            
        }
    } failure:^(NSError *error) {
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];

}


#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if ( alertView.tag == 10293 ) {
        if ( buttonIndex == 1 ) {
            
            NSMutableDictionary *dic = [self.m_productList objectAtIndex:self.m_cancelIndex];
            
            // 取消订单请求数据
            [self cancelOrderRequest:[dic objectForKey:@"OrderId"]];

        }else{
            
            
        }
    }
}


//一个月之前
-(NSString *)getPriousorLaterDateFromDate:(NSDate *)date withMonth:(int)month

{
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    [comps setMonth:month];
    
    NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDate *mDate = [calender dateByAddingComponents:comps toDate:date options:0];
    
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *  time=[dateformatter stringFromDate:mDate];
    
    return time;
    
}



//大众点评开发数据
-(void)ServicesFromDP_jl

{
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    

    NSDate * date = [NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *  time=[dateformatter stringFromDate:date];
    
    
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    NSString *url = @"v1/stats/get_deal_transaction_history";

    
    int transaction_status;
    
    if ([self.m_typeString isEqualToString:KEY_TYPE_WAITPAY]) {
        
        transaction_status = 1;
        
    }else {
        
        transaction_status = 2;

    }
    
         //地区
    NSString * params= [NSString stringWithFormat:@"begin_time=%@&end_time=%@&transaction_status=%d&uid=%@",[self getPriousorLaterDateFromDate:[NSDate date] withMonth:-1],time,transaction_status,[CommonUtil getValueByKey:MEMBER_ID]];
    
    NSLog(@"%@",params);

    
    [[[AppDelegate instance] dpapi] requestWithURL:url paramsString:params delegate:self];
    
    
}



- (void)request:(DPRequest *)request didFailWithError:(NSError *)error {
    
    [SVProgressHUD dismiss];
    
//    if (DP_pageIndex > 1) {
//        DP_pageIndex--;
//    }
//    //    [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
//    
//    self.m_tableView.pullTableIsRefreshing = NO;
//    self.m_tableView.pullTableIsLoadingMore = NO;
    
}

- (void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result {
    
    NSString * success = [result valueForKey:@"status"];
    
    if ([success isEqualToString:@"OK"]) {
        
        [SVProgressHUD dismiss];
        
        self.dp_productList = [result valueForKey:@"transactions"];
        
//        if (DP_pageIndex == 1) {
//            
//            if (metchantShop == nil || metchantShop.count == 0) {
//                
//                //暂无大众点评数据；
//                
//                //                    self.m_tableView.hidden = YES;
//                //
//                //                    self.m_emptyLabel.hidden = NO;
//                //
//                //                    self.m_emptyLabel.text = @"暂无商品数据！";
//                //
//                //                    return;
//                self.m_tableView.pullLastRefreshDate = [NSDate date];
//                self.m_tableView.pullTableIsRefreshing = NO;
//                self.m_tableView.pullTableIsLoadingMore = NO;
//                
//                
//            } else {
//                
//                self.DPdealsarray = metchantShop;
//                
//                self.m_emptyLabel.hidden = YES;
//                
//                self.m_tableView.hidden = NO;
//                
//            }
//        } else {
//            if (metchantShop == nil || metchantShop.count == 0) {
//                
//                DP_pageIndex--;
//                
//            } else {
//                [self.DPdealsarray addObjectsFromArray:metchantShop];
//            }
//        }
//        
//
        
            if (self.dp_productList.count!=0) {
                
                self.m_emptyLabel.hidden = YES;
                
                self.m_tableView.hidden = NO;
                
                [self.m_tableView reloadData];
                
            }else{
                
                if (self.m_productList.count!=0) {
                    
                    self.m_emptyLabel.hidden = YES;
                    
                    self.m_tableView.hidden = NO;
                    
                    [self.m_tableView reloadData];
                    
                }else{
                    
                    
                    self.m_tableView.hidden = YES;
                    self.m_emptyLabel.hidden = NO;

                    if ( self.m_typeString == KEY_TYPE_WAITPAY ) {
                    
                    self.m_emptyLabel.text = @"暂无待付款的订单！";
                    
                    }else{
                        
                    self.m_emptyLabel.text = @"暂无已付款的订单！";
                    
                    }

                }
            }

        
    } else {
//        if (DP_pageIndex > 1) {
//            DP_pageIndex--;
//        }
//        NSString *msg = [request valueForKey:@"msg"];
//        [SVProgressHUD showErrorWithStatus:msg];
    }
//    self.m_tableView.pullLastRefreshDate = [NSDate date];
//    self.m_tableView.pullTableIsRefreshing = NO;
//    self.m_tableView.pullTableIsLoadingMore = NO;
//    
    
}





@end
