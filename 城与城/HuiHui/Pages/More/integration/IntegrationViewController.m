//
//  IntegrationViewController.m
//  baozhifu
//
//  Created by mac on 13-10-25.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "IntegrationViewController.h"
#import "CommonUtil.h"
//#import "AppHttpClient.h"
#import "SVProgressHUD.h"
#import "PaymentCell.h"
#import "IntegrationDetailViewController.h"
#import "IntegrationCell.h"
#import "ExchangeIntegrationViewController.h"



@interface IntegrationViewController ()
    
@property (weak, nonatomic) IBOutlet PullTableView *tableView;

@property (weak, nonatomic) IBOutlet UIButton *btnInCome;

@property (weak, nonatomic) IBOutlet UIButton *btnExpt;

@property (weak, nonatomic) IBOutlet UIView *m_titleVIew;

@property (weak, nonatomic) IBOutlet UIView *m_tempView;

// 无数据时的记录
@property (weak, nonatomic) IBOutlet UILabel *m_emptylabel;

@property (weak, nonatomic) IBOutlet UILabel *m_tipLabel;

- (IBAction)changeType:(id)sender;

- (IBAction)ExchangeClicked:(id)sender;

@end

@implementation IntegrationViewController

@synthesize m_emptylabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        pageIndex = 1;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setTitle:@"我的积分"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    [self setRightButtonWithTitle:@"兑换" action:@selector(ExchangeClicked:)];
    
    self.m_emptylabel.hidden = YES;

    self.m_tipLabel.hidden = YES;

    self.tableView.hidden = YES;
        
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    [self.tableView setPullDelegate:self];
    self.tableView.pullBackgroundColor = [UIColor whiteColor];
    self.tableView.useRefreshView = YES;
    self.tableView.useLoadingMoreView= YES;
    
    // 设置默认选中第一个
    self.btnInCome.userInteractionEnabled = NO;
    
    self.btnExpt.userInteractionEnabled = YES;
    
    [self.btnInCome setBackgroundImage:[UIImage imageNamed:@"comm_tabar_selected.png"] forState:UIControlStateNormal];
    [self.btnInCome setTitleColor:[UIColor colorWithRed:46/255.0 green:133/255.0 blue:179/255.0 alpha:1.0] forState:UIControlStateNormal];
    
    self.itemType = INTEGRATION_INCOME;
    
    
    [self.view addSubview:self.tableView];
    
    pageIndex = 1;
    // 请求数据
    [self loadData];
    
}

- (void)refreshViewControlEventValueChanged {
    //self.refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"下拉刷新"];
    [self loadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated {
    [self.tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self hideTabBar:YES];
  
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [self hideTabBar:NO];
}

- (void)dealloc{
    
    [self.tableView setDelegate:nil];
    [self.tableView setDataSource:nil];
    [self.tableView setPullDelegate:nil];
    
}

- (void)leftClicked{
    
    [self goBack];
    
}

- (void)loadData {
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,     @"memberid",
                           key,   @"key",
                           self.itemType,   @"tradingOperations",
                           [NSString stringWithFormat:@"%d", pageIndex],   @"pageIndex",
                           nil];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"IntegralRecordList.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            [SVProgressHUD dismiss];
             NSMutableArray *resultList = [json valueForKey:@"integralRecord"];
            
            self.m_BalanceString = [json valueForKey:@"Balance"];
            
            self.m_ConvertibleString = [json valueForKey:@"Convertible"];
            
            if (pageIndex == 1) {
                if (resultList == nil || resultList.count == 0) {
                    [self.paymentItems removeAllObjects];
                    
                    self.tableView.hidden = YES;
                    
                    self.m_emptylabel.hidden = NO;
                    
                    self.m_tipLabel.hidden = NO;
                    
                    if ( self.itemType == INTEGRATION_INCOME ) {
                        
                        self.m_emptylabel.text = @"暂时没有积分收入的记录！";
                        
                        
                    }else{
                        
                        self.m_emptylabel.text = @"暂时没有积分支出的记录！";
                        
                    }
                    return;
                } else {
                    
                    self.paymentItems = resultList;
                    
                    self.m_emptylabel.hidden = YES;

                    self.m_tipLabel.hidden = YES;

                    self.tableView.hidden = NO;
                    
                }
            } else {
                
                self.tableView.hidden = NO;
                
                if (resultList == nil || resultList.count == 0) {
                    pageIndex--;
                } else {
                    [self.paymentItems addObjectsFromArray:resultList];
                }
            }
            [self.tableView reloadData];
        } else {
            if (pageIndex > 1) {
                pageIndex--;
            }
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
        self.tableView.pullTableIsRefreshing = NO;
        self.tableView.pullTableIsLoadingMore = NO;
    } failure:^(NSError *error) {
        if (pageIndex > 1) {
            pageIndex--;
        }
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        self.tableView.pullTableIsRefreshing = NO;
        self.tableView.pullTableIsLoadingMore = NO;
    }];
}

-(IBAction)changeType:(id)sender {
    pageIndex = 1;
    [self.btnInCome setBackgroundImage:[UIImage imageNamed:@"comm_tabar_def.png"] forState:UIControlStateNormal];
    [self.btnInCome setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.btnExpt setBackgroundImage:[UIImage imageNamed:@"comm_tabar_def.png"] forState:UIControlStateNormal];
    [self.btnExpt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    if (sender == self.btnInCome) {
        
        self.btnInCome.userInteractionEnabled = NO;
        
        self.btnExpt.userInteractionEnabled = YES;
        
        [self.btnInCome setBackgroundImage:[UIImage imageNamed:@"comm_tabar_selected.png"] forState:UIControlStateNormal];
        [self.btnInCome setTitleColor:[UIColor colorWithRed:46/255.0 green:133/255.0 blue:179/255.0 alpha:1.0] forState:UIControlStateNormal];
        self.itemType = INTEGRATION_INCOME;
        [self loadData];
    }
    if (sender == self.btnExpt) {
        
        self.btnInCome.userInteractionEnabled = YES;
        
        self.btnExpt.userInteractionEnabled = NO;
        
        
        [self.btnExpt setBackgroundImage:[UIImage imageNamed:@"comm_tabar_selected.png"] forState:UIControlStateNormal];
        [self.btnExpt setTitleColor:[UIColor colorWithRed:46/255.0 green:133/255.0 blue:179/255.0 alpha:1.0] forState:UIControlStateNormal];
        self.itemType = INTEGRATION_EXPENDITURE;
        [self loadData];
    }
}

- (IBAction)ExchangeClicked:(id)sender {
    
    // 进入积分兑换的页面
    
    ExchangeIntegrationViewController *VC = [[ExchangeIntegrationViewController alloc]initWithNibName:@"ExchangeIntegrationViewController" bundle:nil];
    VC.m_Balance = self.m_BalanceString;
    VC.m_Convertible = self.m_ConvertibleString;
    [self.navigationController pushViewController:VC animated:YES];

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 75;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.paymentItems count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"integrationCellIdentifier";
    
    //初始化cell并指定其类型，也可自定义cell
    IntegrationCell *cell = (IntegrationCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"IntegrationCell" owner:self options:nil];
        cell = [array objectAtIndex:0];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        cell.selectionStyle = UITableViewCellSelectionStyleGray;

        // 添加分割线
        UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 74, WindowSizeWidth, 1)];
        
        imgV.backgroundColor = [UIColor colorWithRed:221/255.0 green:221/255.0 blue:221/255.0 alpha:0.5];
        
        [cell addSubview:imgV];
        
    }
    
    if ( self.paymentItems.count != 0 ) {
        

        NSUInteger row = [indexPath row];
        NSDictionary *item = [self.paymentItems objectAtIndex:row];
        
        cell.m_integrationLabel.text = [NSString stringWithFormat:@"%@积分", [item objectForKey:@"IntegralVal"]];
        
        NSString *operation = [item objectForKey:@"TradingOperations"];
        
        if ([INTEGRATION_INCOME isEqualToString:operation]) {

            cell.m_typeLabel.text = [NSString stringWithFormat:@"来自:%@",[item objectForKey:@"Source"]];
            
        } else if ([INTEGRATION_EXPENDITURE isEqualToString:operation]) {
            
            cell.m_typeLabel.text = [NSString stringWithFormat:@"类型:%@",[item objectForKey:@"Source"]];
        }
        
        cell.m_timeLabel.text = [item objectForKey:@"TransactionDate"];
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    NSUInteger row = [indexPath row];
    NSDictionary *item = [self.paymentItems objectAtIndex:row];
    // 进入积分详情
    IntegrationDetailViewController *viewController = [[IntegrationDetailViewController alloc] initWithNibName:@"IntegrationDetailViewController" bundle:nil];
    viewController.item = item;
    
    [self.navigationController pushViewController:viewController animated:YES];
    

}

#pragma mark - PullTableViewDelegate

- (void)pullTableViewDidTriggerRefresh:(PullTableView*)pullTableView {
    pageIndex = 1;
    [self loadData];
}

- (void)pullTableViewDidTriggerLoadMore:(PullTableView*)pullTableView {
    pageIndex++;
    [self performSelector:@selector(loadData) withObject:nil];
}


@end
