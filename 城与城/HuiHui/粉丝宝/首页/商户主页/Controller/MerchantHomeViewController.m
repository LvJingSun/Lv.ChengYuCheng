//
//  MerchantHomeViewController.m
//  HuiHui
//
//  Created by mac on 2017/6/27.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "MerchantHomeViewController.h"
#import "FSB_AllWealthHeadView.h"
#import "LJConst.h"
#import "FSB_CumulativeProfitViewController.h"
#import "FSB_CumulativeConsumptionViewController.h"
#import "FSB_AllQuotaViewController.h"
#import "FSB_DetailedViewController.h"

@interface MerchantHomeViewController () <UITableViewDelegate,UITableViewDataSource,FSB_AllWealthHeadViewDelegate>

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, weak) FSB_AllWealthHeadView *headview;

@end

@implementation MerchantHomeViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = [NSString stringWithFormat:@"%@",self.merchantName];
    
    [self allocWithTableView];
    
    [self allocWithRightBtn];
    
    [self requestForData];
    
}

//初始化tableview
- (void)allocWithTableView {
    
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, -_WindowViewHeight, _WindowViewWidth, _WindowViewHeight)];
    
    header.backgroundColor = FSB_StyleCOLOR;
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, _WindowViewWidth, _WindowViewHeight - 64)];
    
    FSB_AllWealthHeadView *headview = [[FSB_AllWealthHeadView alloc] init];
    
    headview.frame = CGRectMake(0, 0, _WindowViewWidth, headview.height);
    
    self.headview = headview;
    
    headview.YesterdayProfitLabel.text = @"0.00";
    
    headview.AllQuotaLabel.text = @"总红包：0元";
    
    headview.CumulativeProfitLabel.text = @"0";
    
    headview.CumulativeConsumptionLabel.text = @"0";
    
    headview.delegate = self;
    
    self.tableview = tableview;
    
    tableview.tableHeaderView = headview;
    
    [tableview addSubview:header];
    
    tableview.delegate = self;
    
    tableview.dataSource = self;
    
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    tableview.backgroundColor = FSB_ViewBGCOLOR;
    
    [self.view addSubview:tableview];
    
}

- (void)requestForData {

    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    
    AppHttpClient *httpClient = [AppHttpClient sharedClient];
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"Memberid",
                           self.merchantID,@"MerchantID",
                           nil];
    
    [SVProgressHUD showWithStatus:@"加载中..."];
    
    [httpClient request:@"FansMemIndex_1.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            self.headview.YesterdayProfitLabel.text = [NSString stringWithFormat:@"%@",[json valueForKey:@"TodayNum"]];
            
            self.headview.AllQuotaLabel.text = [NSString stringWithFormat:@"总红包:%@元",[json valueForKey:@"TotalNum"]];
            
            self.headview.CumulativeProfitLabel.text = [NSString stringWithFormat:@"%@",[json valueForKey:@"TotalPacketNum"]];
            
            self.headview.CumulativeConsumptionLabel.text = [NSString stringWithFormat:@"%@",[json valueForKey:@"ActivityNum"]];
            
            [SVProgressHUD dismiss];
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showErrorWithStatus:msg];
            
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}

//今日红包点击
- (void)YesterdayProfitButtonClicked {
    
    FSB_CumulativeProfitViewController *vc = [[FSB_CumulativeProfitViewController alloc] init];
    
    vc.type = @"merchant";
    
    vc.merchantID = self.merchantID;
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

//总红包点击
- (void)AllQuotaButtonClicked {
    
    FSB_AllQuotaViewController *vc = [[FSB_AllQuotaViewController alloc] init];
    
    vc.merchantID = self.merchantID;
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

//累计收益点击
- (void)CumulativeProfitButtonClicked {
    
    FSB_CumulativeProfitViewController *vc = [[FSB_CumulativeProfitViewController alloc] init];
    
    vc.type = @"merchant";
    
    vc.merchantID = self.merchantID;
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

//商家优惠点击
- (void)CumulativeConsumptionButtonClicked {
    
//    FSB_CumulativeConsumptionViewController *vc = [[FSB_CumulativeConsumptionViewController alloc] init];
//    
//    [self.navigationController pushViewController:vc animated:YES];
    
}


//初始化右上角的按钮
- (void)allocWithRightBtn {
    
    self.navigationItem.rightBarButtonItem = [self SetNavigationBarRightTitle:@"明细" andaction:@selector(MingXiClicked)];
    
}

//右上角按钮点击事件
- (void)MingXiClicked {
    
    FSB_DetailedViewController *vc = [[FSB_DetailedViewController alloc] init];
    
    vc.merchantID = self.merchantID;
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 0;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    return nil;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
