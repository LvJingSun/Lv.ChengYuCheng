//
//  SceneryOrderListViewController.m
//  HuiHui
//
//  Created by mac on 15-1-29.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "SceneryOrderListViewController.h"

#import "SceneryOrderListCell.h"

#import "SceneryOrderDetailViewController.h"

@interface SceneryOrderListViewController ()

@property (weak, nonatomic) IBOutlet PullTableView *m_tableView;

@property (weak, nonatomic) IBOutlet UILabel *m_emptyLabel;

@property (weak, nonatomic) IBOutlet UIButton *m_inProBtn;

@property (weak, nonatomic) IBOutlet UIButton *m_endBtn;

// 按钮触发的事件
- (IBAction)btnClicked:(id)sender;

@end

@implementation SceneryOrderListViewController

@synthesize m_orderList;

@synthesize m_type;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        m_orderList = [[NSMutableArray alloc]initWithCapacity:0];
        
        m_pageIndex = 1;
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setTitle:@"同程网景区订单"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
  
    
    // 设置代理
    [self.m_tableView setDelegate:self];
    [self.m_tableView setDataSource:self];
    [self.m_tableView setPullDelegate:self];
    self.m_tableView.pullBackgroundColor = [UIColor whiteColor];
    self.m_tableView.useRefreshView = YES;
    self.m_tableView.useLoadingMoreView = YES;
    
    self.m_tableView.hidden = YES;
    self.m_emptyLabel.hidden = YES;
    
    // 设置默认的状态
//    self.m_type = SceneryOrderInProType;
    
    self.m_type = SceneryOrderEndType;

    // 请求数据
    [self orderListRequest];
    
    
    [self setExtraCellLineHidden:self.m_tableView];

}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    // 根据类型来请求刷新数据
    if ( self.m_type == SceneryOrderInProType ) {
        
        // 设置选中的为默认的类型
        [self setLeft:YES withRight:NO];
  
    }else {
        
        // 设置选中的为默认的类型
        [self setLeft:NO withRight:YES];
        
    }
   
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
    
    if ( [self.m_stringType isEqualToString:@"2"] ) {
        
        // 返回到景区列表的页面
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:2] animated:YES];
        
    }else{
        
        [self goBack];
    }
    
    
}

- (void)setLeft:(BOOL)aLeft withRight:(BOOL)aRight{
    
    self.m_inProBtn.selected = aLeft;
    self.m_endBtn.selected = aRight;

    if ( aLeft ) {
        
        self.m_inProBtn.userInteractionEnabled = NO;
        self.m_endBtn.userInteractionEnabled = YES;
       
        // 设置订单状态
        self.m_type = SceneryOrderInProType;
        
    }
    
    if ( aRight ) {
        
        self.m_inProBtn.userInteractionEnabled = YES;
        self.m_endBtn.userInteractionEnabled = NO;
        
        // 设置订单状态
        self.m_type = SceneryOrderEndType;
        
    }
    
    // 请求数据
    [self orderListRequest];

}

- (IBAction)btnClicked:(id)sender {

    UIButton *btn = (UIButton *)sender;
    
    if ( btn.tag == 11 ) {
    
        [self setLeft:YES withRight:NO];
        
    }else{
        
        [self setLeft:NO withRight:YES];
    }

}

#pragma mark - UINetWorking 请求数据
- (void)orderListRequest{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    // 获取memberId
//    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    
    NSString *account = [CommonUtil getValueByKey:ACCOUNT];
    
    AppHttpClient* httpClient = [AppHttpClient scenerySharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           [NSString stringWithFormat:@"%i",m_pageIndex],@"page",
                           @"10",@"pageSize",
                           [NSString stringWithFormat:@"%i",self.m_type],@"orderStatus",
                           account,@"bookingMobile",
                           nil];
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    NSLog(@"params = %@",param);
    
    // GetTCSceneryOrderList.ashx  GetSceneryOrderList.ashx
    
    [httpClient requestScenery:@"Scenery/GetTCSceneryOrderList.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        // status 0表示有数据 其他表示错误
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        NSLog(@"json = %@",json);
        
        if ( success ) {
            
            [SVProgressHUD dismiss];
            
            NSMutableArray *orderList = [json valueForKey:@"tcOrderList"];
            
//            self.m_orderList = orderList;
//            
//            if ( self.m_orderList.count != 0 ) {
//                
//                self.m_tableView.hidden = NO;
//                self.m_emptyLabel.hidden = YES;
//                
//                // 刷新列表
//                [self.m_tableView reloadData];
//                
//            }else{
//                
//                self.m_tableView.hidden = YES;
//                self.m_emptyLabel.hidden = NO;
//
//                self.m_emptyLabel.text = @"暂无该类型的订单";
//                
//            }
            
            if (m_pageIndex == 1) {
                
                if (orderList == nil || orderList.count == 0) {
                    
                    [self.m_orderList removeAllObjects];
                    
                    [self.m_tableView reloadData];
                    
                    self.m_tableView.hidden = YES;
                    
                    self.m_emptyLabel.hidden = NO;
                    
                    // 数组为空的时候显示错误的提示信息
                    self.m_emptyLabel.text = @"暂无景区订单的数据";
                    
                    return;
                    
                } else {
                    
                    self.m_orderList = orderList;
                    
                    self.m_emptyLabel.hidden = YES;
                    
                    self.m_tableView.hidden = NO;
                    
                }
            } else {
                
                self.m_emptyLabel.hidden = YES;
                self.m_tableView.hidden = NO;
                
                if (orderList == nil || orderList.count == 0) {
                    
                    m_pageIndex--;
                    
                } else {
                    
                    [self.m_orderList addObjectsFromArray:orderList];
                }
            }
            
            
            [self.m_tableView reloadData];
            
        } else {
            
            if (m_pageIndex > 1) {
                m_pageIndex--;
            }
            
            
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
        
        self.m_tableView.pullLastRefreshDate = [NSDate date];
        self.m_tableView.pullTableIsRefreshing = NO;
        self.m_tableView.pullTableIsLoadingMore = NO;
        
    } failure:^(NSError *error) {
        if (m_pageIndex > 1) {
            m_pageIndex--;
        }
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
        self.m_tableView.pullLastRefreshDate = [NSDate date];
        self.m_tableView.pullTableIsRefreshing = NO;
        self.m_tableView.pullTableIsLoadingMore = NO;
    }];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.m_orderList.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"SceneryOrderListCellIdentifier";
    
    SceneryOrderListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"SceneryOrderListCell" owner:self options:nil];
        
        cell = (SceneryOrderListCell *)[nib objectAtIndex:0];
        
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
    }
    
    // 赋值
    if ( self.m_orderList.count != 0 ) {
        
        NSDictionary *dic = [self.m_orderList objectAtIndex:indexPath.row];
        
        cell.m_sceneryName.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"sceneryName"]];

        cell.m_outDate.text = [NSString stringWithFormat:@"游玩日期：%@",[dic objectForKey:@"travelDate"]];

        cell.m_orderDate.text = [NSString stringWithFormat:@"门票数量：%@张",[dic objectForKey:@"ticketQuantity"]];

        cell.m_price.text = [NSString stringWithFormat:@"￥%@",[dic objectForKey:@"ticketAmount"]];

        cell.m_orderStatus.layer.cornerRadius = 10.0f;
        
        NSString *orderStatus = [NSString stringWithFormat:@"%@",[dic objectForKey:@"orderStatus"]];
        
        // orderStatus  0所有订单  1新建（待游玩订单）  2取消订单  3游玩过的订单 4预订未游玩的订单
        
        if ( [orderStatus isEqualToString:@"1"] ) {
            
            cell.m_orderStatus.text = @"预订成功";
            cell.m_orderStatus.textColor = RGBACKTAB;
            
        }else{
            
            cell.m_orderStatus.text = @"已取消";
            cell.m_orderStatus.textColor = [UIColor lightGrayColor];
        }
        
        
        // 返利赋值
        cell.m_fanli.text = [NSString stringWithFormat:@"返利:%@元",[dic objectForKey:@"rebate"]];
        
       
        
    }
    
    return cell;
    
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 75.0f;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSMutableDictionary *dic = [self.m_orderList objectAtIndex:indexPath.row];
    
    // 进入景区订单详情的页面
    SceneryOrderDetailViewController *VC = [[SceneryOrderDetailViewController alloc]initWithNibName:@"SceneryOrderDetailViewController" bundle:nil];
    VC.m_dic = dic;
        
    VC.m_type = self.m_type;
    [self.navigationController pushViewController:VC animated:YES];
    
}


#pragma mark - PullTableViewDelegate
- (void)pullTableViewDidTriggerRefresh:(PullTableView*)pullTableView {
    m_pageIndex = 1;
    [self performSelector:@selector(orderListRequest) withObject:nil];
}

- (void)pullTableViewDidTriggerLoadMore:(PullTableView*)pullTableView {
    m_pageIndex++;
    [self performSelector:@selector(orderListRequest) withObject:nil];
}



@end
