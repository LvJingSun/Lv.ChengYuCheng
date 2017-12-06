//
//  New_MyWalletViewController.m
//  HuiHui
//
//  Created by mac on 2017/6/26.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "New_MyWalletViewController.h"
#import "RedHorseHeader.h"
#import "MyWallet_HeadView.h"
#import "MyWallet_Cell.h"

#import "PayStyleViewController.h"

#import "PaymentQueViewController.h"

#import "LJHuahuaViewController.h"

#import "IntegrationViewController.h"

#import "MyCardViewController.h"

#import "CashWithdrawalsViewController.h"

#import "MoneyListViewController.h"

#import "Wallet_FSBViewController.h"

#import "TransferAccountsViewController.h"

#import "New_WalletModel.h"
#import "New_WalletFrame.h"
#import "MyWallet_Cell.h"

#import "GameGoldNavViewController.h"
#import "GG_HomeViewController.h"

#import "Wallet_YCBViewController.h"
#import "Wallet_GAMEViewController.h"

@interface New_MyWalletViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, weak) MyWallet_HeadView *headview;

@property (nonatomic, strong) NSArray *firstMenus;

@end

@implementation New_MyWalletViewController

-(NSArray *)firstMenus {

    if (_firstMenus == nil) {
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"WalletFirstMenus.plist" ofType:nil];
        
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        
        NSMutableArray *mut = [NSMutableArray array];
        
        for (NSDictionary *dic in array) {
            
            New_WalletModel *model = [[New_WalletModel alloc] initWithDict:dic];
            
            New_WalletFrame *frame = [[New_WalletFrame alloc] init];
            
            frame.walletmodel = model;
            
            [mut addObject:frame];
            
        }
        
        _firstMenus = mut;
        
    }
    
    return _firstMenus;
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setTitle:@"我的钱包"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    self.view.backgroundColor = RH_ViewBGColor;
    
    [self allocWithTableview];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:nil action:nil];
    
    self.navigationItem.backBarButtonItem = backItem;

}

-(void)viewWillAppear:(BOOL)animated {

    [self loadData];
    
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
                           nil];
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    [httpClient request:@"More.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            
            [SVProgressHUD dismiss];
            
            self.appMore = [json valueForKey:@"appMore"];
            
            [CommonUtil addValue:[self.appMore objectForKey:@"realAuName"] andKey:REAL_ACCOUNT_NAME];
            [CommonUtil addValue:[self.appMore objectForKey:@"realAuIdCard"] andKey:REAL_ACCOUNT_IDCARD];
            [CommonUtil addValue:[self.appMore objectForKey:@"realAuStatus"] andKey:USER_REALAUSTATUS];
            
            //充值
            NSString *vldStatus = [self.appMore objectForKey:@"realAuStatus"];
            
            // 保存用户的状态
            [CommonUtil addValue:vldStatus andKey:REALAUSTATUS];
            
            self.headview.balanceLab.text = [NSString stringWithFormat:@"%.2f",floor([[self.appMore objectForKey:@"myBalance"] doubleValue]*100)/100];
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showErrorWithStatus:msg];
            
            
        }
    } failure:^(NSError *error) {

        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}

- (void)allocWithTableview {
    
    MyWallet_HeadView *headview = [[MyWallet_HeadView alloc] init];
    
    headview.frame = CGRectMake(0, 0, ScreenWidth, headview.height);
    
    self.headview = headview;
    
    headview.countBlock = ^{
        
        MoneyListViewController *VC = [[MoneyListViewController alloc] init];

        [self.navigationController pushViewController:VC animated:YES];
        
    };

    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64)];
    
    self.tableview = tableview;
    
    UIView *header = [[UIView alloc] init];
    
    header.backgroundColor = [UIColor colorWithRed:72/255.f green:162/255.f blue:245/255.f alpha:1.0];
    
    header.frame = CGRectMake(0, -ScreenHeight, ScreenWidth, ScreenHeight);
    
    [tableview addSubview:header];
    
    tableview.tableHeaderView = headview;
    
    tableview.delegate = self;
    
    tableview.dataSource = self;
    
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    tableview.backgroundColor = RH_ViewBGColor;
    
    [self.view addSubview:tableview];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        
    return self.firstMenus.count;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
        
    return 20;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
        
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 20)];
    
    view.backgroundColor = RH_ViewBGColor;
    
    return view;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MyWallet_Cell *cell = [[MyWallet_Cell alloc] init];
        
    New_WalletFrame *frame = self.firstMenus[indexPath.row];
    
    cell.frameModel = frame;
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
        
    New_WalletFrame *frame = self.firstMenus[indexPath.row];
    
    return frame.height;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
    if (indexPath.row == 0) {
        
        //充值点击  验证安全问题
        [self paymentSafeRequest];
        
    }else if (indexPath.row == 1) {
    
        //提现
        CashWithdrawalsViewController *VC = [[CashWithdrawalsViewController alloc]initWithNibName:@"CashWithdrawalsViewController" bundle:nil];
        
        [self.navigationController pushViewController:VC animated:YES];
        
    }
    
}

// 验证用户是否填写了支付问题的网络请求
- (void)paymentSafeRequest{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    // 根据类型字符aType 来判断  2表示点击修改支付密码 1表示充值按钮来请求
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,     @"memberId",
                           key,   @"key",
                           nil];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"PaymentSafetyTesting.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {

            [SVProgressHUD dismiss];
            
            //充值
            NSString *vldStatus = [self.appMore objectForKey:@"realAuStatus"];
            
            // 保存用户的状态
            [CommonUtil addValue:vldStatus andKey:REALAUSTATUS];
            
            // 请求成功后进入支付方式选择的页面
            PayStyleViewController *VC = [[PayStyleViewController alloc]initWithNibName:@"PayStyleViewController" bundle:nil];
            
            VC.m_typeString = @"1";
            
            [self.navigationController pushViewController:VC animated:YES];
            
        } else {

            [SVProgressHUD dismiss];
            
            // 进入设置安全问题及支付密码的页面
            PaymentQueViewController *viewController = [[PaymentQueViewController alloc]initWithNibName:@"PaymentQueViewController" bundle:nil];
            
            [self.navigationController pushViewController:viewController animated:YES];
            
        }
        
    } failure:^(NSError *error) {

        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}

- (void)leftClicked{
    
    [self goBack];
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];

}

@end
