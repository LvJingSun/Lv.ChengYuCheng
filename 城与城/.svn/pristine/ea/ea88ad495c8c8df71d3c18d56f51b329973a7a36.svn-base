//
//  SceneryOrderDetailViewController.m
//  HuiHui
//
//  Created by mac on 15-1-30.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "SceneryOrderDetailViewController.h"

#import "SceneryOrderListCell.h"

@interface SceneryOrderDetailViewController ()

@property (weak, nonatomic) IBOutlet UIView *m_showView;

@property (weak, nonatomic) IBOutlet UIControl *m_control;

@property (weak, nonatomic) IBOutlet UIView *m_cancelView;

@property (weak, nonatomic) IBOutlet UITableView *m_tableView;


// 点击view隐藏取消原因所在的view
- (IBAction)tapDown:(id)sender;
// 选择取消的原因
- (IBAction)chooseCancelReson:(id)sender;
// 选择了原因后确定取消订单
- (IBAction)sureCancelClikcked:(id)sender;

@end

@implementation SceneryOrderDetailViewController

@synthesize m_dic;

@synthesize m_cancelReson;

@synthesize m_orderDic;

@synthesize m_type;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        m_dic = [[NSMutableDictionary alloc]initWithCapacity:0];
        
        m_orderDic = [[NSMutableDictionary alloc]initWithCapacity:0];
        
        m_index = 0;
        
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setTitle:@"订单详情"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    
    // 隐藏tableView多余的分割线
    [self setExtraCellLineHidden:self.m_tableView];
    
    self.m_tableView.hidden = YES;
    self.m_showView.hidden = YES;
    
    self.m_control.backgroundColor = [UIColor blackColor];
    self.m_control.alpha = 0.5;
    self.m_cancelView.layer.cornerRadius = 5.0f;
    
    [self.navigationController.view.window addSubview:self.m_showView];
    
    
    // 请求数据
    [self SceneryDetailRequest];
    
    NSLog(@"enableCancel = %@",[self.m_dic objectForKey:@"orderStatus"]);
    
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

- (void)SceneryDetailRequest{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    // 获取memberId
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];

    AppHttpClient* httpClient = [AppHttpClient scenerySharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"memberId",
                           [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"serialId"]],@"serialIds",
                           @"",@"writeDB",
                           
                           nil];
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    [httpClient requestScenery:@"Scenery/GetSceneryOrderDetail.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        NSLog(@"json = %@",json);
        
        // status 0表示有数据 其他表示错误
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if ( success ) {
            
            [SVProgressHUD dismiss];
            
            // 赋值
            self.m_orderDic = [json valueForKey:@"orderDetail"];
            
            self.m_tableView.hidden = NO;
            // 刷新列表
            [self.m_tableView reloadData];
            
            // 根据是否可取消的状态来判断是否显示右上角的取消按钮
            // enableCancel	order	1	是否可取消	int	1:可取消 0：不可取消
            NSString *cancelString = [self.m_orderDic objectForKey:@"enableCancel"];
            
            NSString *orderStatus = [NSString stringWithFormat:@"%@",[self.m_orderDic objectForKey:@"orderStatus"]];
            
            
            NSLog(@"%@",orderStatus);
            
            // orderStatus  0所有订单  1新建（待游玩订单）  2取消订单  3游玩过的订单 4预订未游玩的订单
            if ( [orderStatus isEqualToString:@"1"] ) {
                
                // 根据状态来判断是否可以取消
                if ( [cancelString isEqualToString:@"1"] ) {
                    
                    [self setRightButtonWithTitle:@"取消订单" action:@selector(cancelOrderClicked)];
                    
                }else{
                    
                    self.navigationItem.rightBarButtonItem = nil;
                }
            }else{
                
                self.navigationItem.rightBarButtonItem = nil;

            }
            
        
        }else{
            
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
            
        }
       
        
    } failure:^(NSError *error) {
      
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}

- (void)cancelOrderClicked{
    
//    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@""
//                                                       message:@"您确定要取消该订单吗?"
//                                                      delegate:self
//                                             cancelButtonTitle:@"取消"
//                                             otherButtonTitles:@"确定", nil];
//    
//    alertView.tag = 19232;
//    [alertView show];

    
    self.m_showView.hidden = NO;
    
    
    
}

// 取消订单请求数据
- (void)cancelOrderRequest{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    // 获取memberId
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    
   // 1行程变更 2通过其他更优惠的渠道预订了景区  3对服务不满意  4其他原因  5信息错误重新预订  12景区不承认合作  17	天气原因 18重复订单
    
    AppHttpClient* httpClient = [AppHttpClient scenerySharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"memberId",
                           [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"serialId"]],@"serialId",
                           [NSString stringWithFormat:@"%ld",(long)m_index],@"cancelReason",
                           
                           nil];
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    NSLog(@"parma = %@",param);
    
    [httpClient requestScenery:@"Scenery/CancelSceneryOrder.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        // status 0表示有数据 其他表示错误
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        NSLog(@"json =%@",json);
        
        if ( success ) {
            
            [SVProgressHUD dismiss];
            
            // 返回上一级
//            [self goBack];
            
            // 请求数据
            [self SceneryDetailRequest];
            
        }else{
            
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
    
    if ( alertView.tag == 19232 ) {
        
        if ( buttonIndex == 1 ) {
            // 删除
            [self cancelOrderRequest];
            
        }else{
            
        }
    }
    
}

- (IBAction)tapDown:(id)sender {
    
    self.m_showView.hidden = YES;
}

- (IBAction)chooseCancelReson:(id)sender {
    
    UIButton *btn = (UIButton *)sender;
    
    NSLog(@"btn.tag = %li",(long)btn.tag);
    
    m_index = btn.tag;
    
    for (id button in self.m_cancelView.subviews) {
        
        if ( [button isKindOfClass:[UIButton class]] ) {
            
            UIButton *l_btn = (UIButton *)button;
            
            if ( l_btn.tag == btn.tag ) {
                
                l_btn.selected = YES;
                
            }else{
                
                l_btn.selected = NO;
            }
        }
        
    }
    
    
}

- (IBAction)sureCancelClikcked:(id)sender {
    
    if ( m_index == 0 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请选择取消订单的原因"];
        
        return;
    }
    
    self.m_showView.hidden = YES;
    
    // 删除
    [self cancelOrderRequest];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = nil;
    
    if ( indexPath.section == 0 ) {
        
        cell = [self SureOrdeTableView:tableView cellForRowAtIndexPath:indexPath];
        
    }else if ( indexPath.section == 1 ) {

        cell = [self travellerTableView:tableView cellForRowAtIndexPath:indexPath];
        
    }
    
    
    return cell;
    
}

- (UITableViewCell *)SureOrdeTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"ScenerySureOrderCellIdentifier";
    
    ScenerySureOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SceneryOrderListCell" owner:self options:nil];
        
        cell = (ScenerySureOrderCell *)[nib objectAtIndex:1];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    // 赋值
    cell.m_sceneryName.text = [NSString stringWithFormat:@"%@",[self.m_orderDic objectForKey:@"ticketName"]];
    
    cell.m_price.text = [NSString stringWithFormat:@"￥%@",[self.m_orderDic objectForKey:@"ticketAmount"]];
    
    cell.m_date.text = [NSString stringWithFormat:@"%@",[self.m_orderDic objectForKey:@"travelDate"]];

    cell.m_count.text = [NSString stringWithFormat:@"%@张",[self.m_orderDic objectForKey:@"ticketQuantity"]];

    cell.m_fanliPrice.text = [NSString stringWithFormat:@"￥%@",[self.m_orderDic objectForKey:@"rebate"]];

    
    cell.m_orderNum.text = [NSString stringWithFormat:@"%@",[self.m_orderDic objectForKey:@"serialId"]];

    
    return cell;
    
}

- (UITableViewCell *)travellerTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"ScenerySureTravellerCellIdentifier";
    
    ScenerySureTravellerCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SceneryOrderListCell" owner:self options:nil];
        
        cell = (ScenerySureTravellerCell *)[nib objectAtIndex:2];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    // 赋值
    cell.m_travellerName.text = [NSString stringWithFormat:@"%@",[self.m_orderDic objectForKey:@"guestName"]];

    cell.m_phone.text = [NSString stringWithFormat:@"%@",[self.m_orderDic objectForKey:@"guestMobile"]];

    
    return cell;
    
}

#pragma mark - UITableviewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ( indexPath.section == 0 ) {
        
        return 145.0f;
        
    }else{
        
        return 50.0f;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if ( isIOS7 ) {
        
        return 5.0f;
    }
    
    return 0;
    
}

@end
