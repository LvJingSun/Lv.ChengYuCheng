//
//  MyPaymentListViewController.m
//  HuiHui
//
//  Created by mac on 13-11-20.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import "MyPaymentListViewController.h"

#import "PayMentCell.h"

#import "PaymentDetailViewController.h"

#import "CommonUtil.h"

#import "SVProgressHUD.h"

#import "AppHttpClient.h"

#import "CashWithdrawalsViewController.h"

#import "ExplainViewController.h"

@interface MyPaymentListViewController ()


@property (weak, nonatomic) IBOutlet UIButton *m_leftBtn;

@property (weak, nonatomic) IBOutlet UIButton *m_rightBtn;

@property (weak, nonatomic) IBOutlet PullTableView *m_tableView;

@property (weak, nonatomic) IBOutlet UILabel *m_emptyLabel;


- (IBAction)typeClicked:(id)sender;

- (void)setLeft:(BOOL)isLeft withRight:(BOOL)isRight;

@end

@implementation MyPaymentListViewController

@synthesize paymentItems;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        pageIndex = 1;
        
        paymentItems = [[NSMutableArray alloc]initWithCapacity:0];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setTitle:@"我的收益"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];

    [self setRightButtonWithTitle:@"提现" action:@selector(takeMoney)];

    self.m_tableView.hidden = YES;

    self.m_emptyLabel.hidden = YES;
    
    self.How.hidden = YES;
    
    [self.How addTarget:self action:@selector(GotoExplain) forControlEvents:UIControlEventTouchUpInside];
    
    [self.m_tableView setDelegate:self];
    [self.m_tableView setDataSource:self];
    [self.m_tableView setPullDelegate:self];
    self.m_tableView.pullBackgroundColor = [UIColor whiteColor];
    self.m_tableView.useRefreshView = YES;
    self.m_tableView.useLoadingMoreView = YES;
    
    // 隐藏多余的分割线
    [self setExtraCellLineHidden:self.m_tableView];
    
    // 默认选中左边的
    [self setLeft:YES withRight:NO];
    
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
    
    [self.m_tableView setDelegate:nil];
    [self.m_tableView setDataSource:nil];
    [self.m_tableView setPullDelegate:nil];
    
}

- (void)didReceiveMemoryWarning{
    
    [super didReceiveMemoryWarning];
    
}

-(void)GotoExplain
{
    ExplainViewController * VC = [[ExplainViewController alloc]initWithNibName:@"ExplainViewController" bundle:nil];
    VC.m_HiddenBVC = @"1";
    VC.m_pop = @"1";
    [self.navigationController pushViewController:VC animated:YES];
}

- (void)leftClicked{
    
    [self goBack];
}

- (void)takeMoney{
    // 进入提现的页面
    CashWithdrawalsViewController *VC = [[CashWithdrawalsViewController alloc]initWithNibName:@"CashWithdrawalsViewController" bundle:nil];
    
    [self.navigationController pushViewController:VC animated:YES];
    
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
                           self.itemType,   @"tradOpt",
                           [NSString stringWithFormat:@"%ld", (long)pageIndex],@"pageIndex",
                           nil];
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"TransactionRecords_1.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            [SVProgressHUD dismiss];
            NSMutableArray *resultList = [json valueForKey:@"transactionRecords"];
            
            if (pageIndex == 1) {
                if (resultList == nil || resultList.count == 0) {
                    [self.paymentItems removeAllObjects];
                    self.m_tableView.hidden = YES;
                    
                    self.m_emptyLabel.hidden = NO;
                    
                    if ( self.itemType == OPERATION_INCOME ) {
                        
                        self.m_emptyLabel.text = @"暂时没有收入的数据！";
                        
                        self.How.hidden = NO;
                        
                    }else{
                        
                        self.m_emptyLabel.text = @"暂时没有支出的数据！";
                        
                        self.How.hidden = YES;

                    }
                    return;
                } else {
                    self.paymentItems = resultList;
                    
                    self.m_emptyLabel.hidden = YES;
                    
                    self.How.hidden = YES;
                    
                    self.m_tableView.hidden = NO;
                    
                }
            } else {
                
                self.m_tableView.hidden = NO;
                
                if (resultList == nil || resultList.count == 0) {
                    pageIndex--;
                } else {
                    [self.paymentItems addObjectsFromArray:resultList];
                }
            }
            [self.m_tableView reloadData];
            
        } else {
            if (pageIndex > 1) {
                pageIndex--;
            }
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
        self.m_tableView.pullTableIsRefreshing = NO;
        self.m_tableView.pullTableIsLoadingMore = NO;
    } failure:^(NSError *error) {
        if (pageIndex > 1) {
            pageIndex--;
        }
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        self.m_tableView.pullTableIsRefreshing = NO;
        self.m_tableView.pullTableIsLoadingMore = NO;
    }];
}

- (IBAction)typeClicked:(id)sender{
    
    UIButton *btn = (UIButton *)sender;
    
    pageIndex = 1;

    
    if ( btn.tag == 100 ) {
        
        [self setLeft:YES withRight:NO];
        
    }else{
        
        [self setLeft:NO withRight:YES];
        
    }
    
}

- (void)setLeft:(BOOL)isLeft withRight:(BOOL)isRight{
    
    self.m_leftBtn.selected = isLeft;
    
    self.m_rightBtn.selected = isRight;
    
    if ( isLeft ) {
        
        self.m_leftBtn.userInteractionEnabled = NO;
        self.m_rightBtn.userInteractionEnabled = YES;
        
        self.itemType = OPERATION_INCOME;
        [self loadData];
        
    }else{
        
        self.m_leftBtn.userInteractionEnabled = YES;
        self.m_rightBtn.userInteractionEnabled = NO;
        
        self.itemType = OPERATION_EXPENDITURE;
        [self loadData];
    }
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.paymentItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"PayMentCellIdentifier";
    
    PayMentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"PayMentCell" owner:self options:nil];
        
        cell = (PayMentCell *)[nib objectAtIndex:0];
        
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    
    if ( self.paymentItems.count != 0 ) {
        
        NSUInteger row = [indexPath row];
        NSDictionary *item = [self.paymentItems objectAtIndex:row];
        [cell setValue:item];
    }
    
    return cell;
    
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 75.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    NSDictionary *item = self.paymentItems[indexPath.row];
    
    PaymentDetailViewController *viewController = [[PaymentDetailViewController alloc] initWithNibName:@"PaymentDetailViewController" bundle:nil];
    
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
