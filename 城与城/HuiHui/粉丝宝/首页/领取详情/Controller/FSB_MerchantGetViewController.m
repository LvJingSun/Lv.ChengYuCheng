//
//  FSB_MerchantGetViewController.m
//  HuiHui
//
//  Created by mac on 2017/7/25.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "FSB_MerchantGetViewController.h"
#import "LJConst.h"
#import "MerchantGetModel.h"
#import "MerchantGetFrame.h"
#import "MerchantGetCell.h"
#import "FSB_GetDetailHeadView.h"

@interface FSB_MerchantGetViewController () <UITableViewDelegate,UITableViewDataSource> {
    
    NSInteger pageIndex;
    
}

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, weak) FSB_GetDetailHeadView *headview;

@end

@implementation FSB_MerchantGetViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    pageIndex = 1;

    self.title = @"红包详情";
    
    [self allocWithTableView];
    
    [self requestForData];
    
}

//初始化tableview
- (void)allocWithTableView {
    
    FSB_GetDetailHeadView *head = [[FSB_GetDetailHeadView alloc] init];
    
    head.frame = CGRectMake(0, 0, _WindowViewWidth, head.height);
    
    self.headview = head;
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, _WindowViewWidth, _WindowViewHeight - 64)];
    
    self.tableview = tableview;
    
    tableview.tableHeaderView = head;
    
    tableview.delegate = self;
    
    tableview.dataSource = self;
    
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    tableview.backgroundColor = FSB_ViewBGCOLOR;
    
    tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        pageIndex = 1;
        
        [self requestForData];
        
    }];
    
    tableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        pageIndex ++;
        
        [self requestForData];
        
    }];
    
    [self.view addSubview:tableview];
    
}

- (void)headAndFootEndRefreshing {
    
    [self.tableview.mj_header endRefreshing];
    
    [self.tableview.mj_footer endRefreshing];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MerchantGetCell *cell = [[MerchantGetCell alloc] init];
    
    MerchantGetFrame *frame = self.dataArray[indexPath.row];
    
    cell.frameModel = frame;
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MerchantGetFrame *frame = self.dataArray[indexPath.row];
    
    return frame.height;
    
}

- (void)requestForData {
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    
    AppHttpClient *httpClient = [AppHttpClient sharedClient];
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"Memberid",
                           self.getDate,@"TransactionDate",
                           self.merchantID,@"MerchantID",
                           [NSString stringWithFormat:@"%ld",(long)pageIndex],@"pageIndex",
                           nil];
    
    [httpClient request:@"FansMerchantPacketList.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            [self.headview.iconImg setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[json valueForKey:@"Logo"]]] placeholderImage:[UIImage imageNamed:@""]];
            
            self.headview.nameLab.text = @"红包总计";
            
            self.headview.countLab.text = [NSString stringWithFormat:@"%@元",self.count];
            
            NSArray *array = [json valueForKey:@"ybtrList"];
            
            if (array.count != 0) {
                
                if (pageIndex == 1) {
                
                    NSMutableArray *mutArr = [NSMutableArray array];
                    
                    for (NSDictionary *dd in array) {
                        
                        MerchantGetModel *model = [[MerchantGetModel alloc] init];
                        
                        model.Number = [NSString stringWithFormat:@"%@",dd[@"Number"]];
                        
                        model.GoodsName = [NSString stringWithFormat:@"%@",dd[@"GoodsName"]];
                        
                        model.MerchantName = [NSString stringWithFormat:@"%@",dd[@"MerchantName"]];
                        
                        model.TransactionDate = [NSString stringWithFormat:@"%@",dd[@"TransactionDate"]];
                        
                        model.MerchantID = [NSString stringWithFormat:@"%@",dd[@"MerchantID"]];
                        
                        model.Status = [NSString stringWithFormat:@"%@",dd[@"Status"]];
                        
                        model.Description = [NSString stringWithFormat:@"%@",dd[@"Description"]];
                        
                        model.TradingOperations = [NSString stringWithFormat:@"%@",dd[@"TradingOperations"]];
                        
                        model.TransactionType = [NSString stringWithFormat:@"%@",dd[@"TransactionType"]];
                        
                        model.Account = [NSString stringWithFormat:@"%@",dd[@"Account"]];
                        
                        model.MemberID = [NSString stringWithFormat:@"%@",dd[@"MemberID"]];
                        
                        MerchantGetFrame *frame = [[MerchantGetFrame alloc] init];
                        
                        frame.detailModel = model;
                        
                        [mutArr addObject:frame];
                        
                    }
                    
                    self.dataArray = mutArr;
                    
                }else {
                
                    NSMutableArray *mutArr = [NSMutableArray arrayWithArray:self.dataArray];
                    
                    for (NSDictionary *dd in array) {
                        
                        MerchantGetModel *model = [[MerchantGetModel alloc] init];
                        
                        model.Number = [NSString stringWithFormat:@"%@",dd[@"Number"]];
                        
                        model.GoodsName = [NSString stringWithFormat:@"%@",dd[@"GoodsName"]];
                        
                        model.MerchantName = [NSString stringWithFormat:@"%@",dd[@"MerchantName"]];
                        
                        model.TransactionDate = [NSString stringWithFormat:@"%@",dd[@"TransactionDate"]];
                        
                        model.MerchantID = [NSString stringWithFormat:@"%@",dd[@"MerchantID"]];
                        
                        model.Status = [NSString stringWithFormat:@"%@",dd[@"Status"]];
                        
                        model.Description = [NSString stringWithFormat:@"%@",dd[@"Description"]];
                        
                        model.TradingOperations = [NSString stringWithFormat:@"%@",dd[@"TradingOperations"]];
                        
                        model.TransactionType = [NSString stringWithFormat:@"%@",dd[@"TransactionType"]];
                        
                        model.Account = [NSString stringWithFormat:@"%@",dd[@"Account"]];
                        
                        model.MemberID = [NSString stringWithFormat:@"%@",dd[@"MemberID"]];
                        
                        MerchantGetFrame *frame = [[MerchantGetFrame alloc] init];
                        
                        frame.detailModel = model;
                        
                        [mutArr addObject:frame];
                        
                    }
                    
                    self.dataArray = mutArr;
                    
                }
                
            }
            
            [self headAndFootEndRefreshing];
            
            [self.tableview reloadData];
            
        } else {
            
            [self headAndFootEndRefreshing];
            
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showErrorWithStatus:msg];
            
        }
        
    } failure:^(NSError *error) {
        
        [self headAndFootEndRefreshing];
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
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
