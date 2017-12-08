//
//  FSB_CumulativeProfitViewController.m
//  HuiHui
//
//  Created by mac on 2017/5/15.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "FSB_CumulativeProfitViewController.h"
#import "LJConst.h"
//收益model
#import "FSB_ProfitModel.h"
//收益frame
#import "FSB_ProfitFrame.h"
//收益cell
#import "FSB_ProfitCell.h"
//收益页面headview
#import "FSB_ProfitHeadView.h"

#import "FSB_GetDetailViewController.h"
#import "FSB_MerchantGetViewController.h"

@interface FSB_CumulativeProfitViewController () <UITableViewDelegate,UITableViewDataSource> {

    NSInteger pageIndex;
    
}

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, weak) UILabel *allProfitLab;

@end

@implementation FSB_CumulativeProfitViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    pageIndex = 1;
    
    self.title = @"记录";
    
    [self allocWithTableView];
    
    [self requestForCumulativeProfitData];

}

//初始化tableview
- (void)allocWithTableView {
    
    FSB_ProfitHeadView *headview = [[FSB_ProfitHeadView alloc] init];
    
    headview.frame = CGRectMake(0, 0, _WindowViewWidth, headview.height);
    
    self.allProfitLab = headview.countLab;
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, _WindowViewWidth, _WindowViewHeight - 64)];
    
    self.tableview = tableview;
    
    tableview.tableHeaderView = headview;
    
    tableview.delegate = self;
    
    tableview.dataSource = self;
    
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    tableview.backgroundColor = FSB_ViewBGCOLOR;
    
    tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        pageIndex = 1;
        
        [self requestForCumulativeProfitData];
        
    }];
    
    tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        pageIndex ++;
        
        [self requestForCumulativeProfitData];
        
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

    FSB_ProfitCell *cell = [[FSB_ProfitCell alloc] init];
    
    FSB_ProfitFrame *frame = self.dataArray[indexPath.row];
    
    cell.frameModel = frame;
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    FSB_ProfitFrame *frame = self.dataArray[indexPath.row];
    
    return frame.height;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    FSB_ProfitFrame *frame = self.dataArray[indexPath.row];
    
    if ([self.redType isEqualToString:@"2"]) {
        
        if ([self.type isEqualToString:@"home"]) {
            
            FSB_GetDetailViewController *vc = [[FSB_GetDetailViewController alloc] init];
            
            vc.getDate = frame.profitModel.TodayDate;
            
            vc.count = frame.profitModel.TodayProfit;
            
            vc.redtype = @"2";
            
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        
    }else {
        
        if ([self.type isEqualToString:@"home"]) {
            
            FSB_GetDetailViewController *vc = [[FSB_GetDetailViewController alloc] init];
            
            vc.getDate = frame.profitModel.TodayDate;
            
            vc.count = frame.profitModel.TodayProfit;
            
            [self.navigationController pushViewController:vc animated:YES];
            
        }else if ([self.type isEqualToString:@"merchant"]) {
            
            FSB_MerchantGetViewController *vc = [[FSB_MerchantGetViewController alloc] init];
            
            vc.getDate = frame.profitModel.TodayDate;
            
            vc.merchantID = self.merchantID;
            
            vc.count = frame.profitModel.TodayProfit;
            
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        
    }
    
}

//请求累计收益数据
- (void)requestForCumulativeProfitData {
    
    if ([self.redType isEqualToString:@"2"]) {
        
        if ([self.type isEqualToString:@"home"]) {
            
            NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
            
            AppHttpClient *httpClient = [AppHttpClient sharedClient];
            
            NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                                   memberId,@"Memberid",
                                   [NSString stringWithFormat:@"%ld",(long)pageIndex],@"pageIndex",
                                   nil];
            
            [SVProgressHUD showWithStatus:@"加载中..."];
            
            [httpClient request:@"MctRPGetMoneyTranMember.ashx" parameters:param success:^(NSJSONSerialization* json) {
                
                BOOL success = [[json valueForKey:@"status"] boolValue];
                
                if (success) {
                    
                    self.allProfitLab.text = [NSString stringWithFormat:@"%@",[json valueForKey:@"totalaccount"]];
                    
                    NSArray *array = [json valueForKey:@"ybtrList"];
                    
                    if (array.count != 0) {
                        
                        if (pageIndex == 1) {
                            
                            NSMutableArray *mutArr = [NSMutableArray array];
                            
                            for (NSDictionary *dd in array) {
                                
                                FSB_ProfitModel *model = [[FSB_ProfitModel alloc] init];
                                
                                model.TodayDate = [NSString stringWithFormat:@"%@",dd[@"TransactionDate"]];
                                
                                model.TodayProfit = [NSString stringWithFormat:@"%@",dd[@"Account"]];
                                
                                model.Type = [NSString stringWithFormat:@"%@",dd[@"TransactionType"]];
                                
                                FSB_ProfitFrame *frame = [[FSB_ProfitFrame alloc] init];
                                
                                frame.profitModel = model;
                                
                                [mutArr addObject:frame];
                                
                            }
                            
                            self.dataArray = mutArr;
                            
                        }else {
                            
                            NSMutableArray *temp = [NSMutableArray arrayWithArray:self.dataArray];
                            
                            for (NSDictionary *dd in array) {
                                
                                FSB_ProfitModel *model = [[FSB_ProfitModel alloc] init];
                                
                                model.TodayDate = [NSString stringWithFormat:@"%@",dd[@"TransactionDate"]];
                                
                                model.TodayProfit = [NSString stringWithFormat:@"%@",dd[@"Account"]];
                                
                                model.Type = [NSString stringWithFormat:@"%@",dd[@"TransactionType"]];
                                
                                FSB_ProfitFrame *frame = [[FSB_ProfitFrame alloc] init];
                                
                                frame.profitModel = model;
                                
                                [temp addObject:frame];
                                
                            }
                            
                            self.dataArray = temp;
                            
                        }
                        
                    }
                    
                    [SVProgressHUD dismiss];
                    
                    [self headAndFootEndRefreshing];
                    
                    [self.tableview reloadData];
                    
                } else {
                    
                    if (pageIndex > 1) {
                        
                        pageIndex --;
                        
                    }
                    
                    NSString *msg = [json valueForKey:@"msg"];
                    
                    [SVProgressHUD showErrorWithStatus:msg];
                    
                    [self headAndFootEndRefreshing];
                    
                }
                
            } failure:^(NSError *error) {
                
                if (pageIndex > 1) {
                    
                    pageIndex --;
                    
                }
                
                [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
                
                [self headAndFootEndRefreshing];
                
            }];
            
        }else if ([self.type isEqualToString:@"merchant"]) {
            
            NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
            
            AppHttpClient *httpClient = [AppHttpClient sharedClient];
            
            NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                                   memberId,@"Memberid",
                                   [NSString stringWithFormat:@"%ld",(long)pageIndex],@"pageIndex",
                                   self.merchantID,@"MerchantID",
                                   nil];
            
            [SVProgressHUD showWithStatus:@"加载中..."];
            
            [httpClient request:@"MctRPGetMoneyMerchantTran.ashx" parameters:param success:^(NSJSONSerialization* json) {
                
                BOOL success = [[json valueForKey:@"status"] boolValue];
                
                if (success) {
                    
                    self.allProfitLab.text = [NSString stringWithFormat:@"%@",[json valueForKey:@"totalaccount"]];
                    
                    NSArray *array = [json valueForKey:@"ybtrList"];
                    
                    if (array.count != 0) {
                        
                        if (pageIndex == 1) {
                            
                            NSMutableArray *mutArr = [NSMutableArray array];
                            
                            for (NSDictionary *dd in array) {
                                
                                FSB_ProfitModel *model = [[FSB_ProfitModel alloc] init];
                                
                                model.TodayDate = [NSString stringWithFormat:@"%@",dd[@"TransactionDate"]];
                                
                                model.TodayProfit = [NSString stringWithFormat:@"%@",dd[@"Account"]];
                                
                                model.Type = [NSString stringWithFormat:@"%@",dd[@"TransactionType"]];
                                
                                FSB_ProfitFrame *frame = [[FSB_ProfitFrame alloc] init];
                                
                                frame.profitModel = model;
                                
                                [mutArr addObject:frame];
                                
                            }
                            
                            self.dataArray = mutArr;
                            
                        }else {
                            
                            NSMutableArray *temp = [NSMutableArray arrayWithArray:self.dataArray];
                            
                            for (NSDictionary *dd in array) {
                                
                                FSB_ProfitModel *model = [[FSB_ProfitModel alloc] init];
                                
                                model.TodayDate = [NSString stringWithFormat:@"%@",dd[@"TransactionDate"]];
                                
                                model.TodayProfit = [NSString stringWithFormat:@"%@",dd[@"Account"]];
                                
                                model.Type = [NSString stringWithFormat:@"%@",dd[@"TransactionType"]];
                                
                                FSB_ProfitFrame *frame = [[FSB_ProfitFrame alloc] init];
                                
                                frame.profitModel = model;
                                
                                [temp addObject:frame];
                                
                            }
                            
                            self.dataArray = temp;
                            
                        }
                        
                    }
                    
                    [SVProgressHUD dismiss];
                    
                    [self headAndFootEndRefreshing];
                    
                    [self.tableview reloadData];
                    
                } else {
                    
                    if (pageIndex > 1) {
                        
                        pageIndex --;
                        
                    }
                    
                    NSString *msg = [json valueForKey:@"msg"];
                    
                    [SVProgressHUD showErrorWithStatus:msg];
                    
                    [self headAndFootEndRefreshing];
                    
                }
                
            } failure:^(NSError *error) {
                
                if (pageIndex > 1) {
                    
                    pageIndex --;
                    
                }
                
                [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
                
                [self headAndFootEndRefreshing];
                
            }];
            
        }
        
    }else {
        
        if ([self.type isEqualToString:@"home"]) {
            
            NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
            
            AppHttpClient *httpClient = [AppHttpClient sharedClient];
            
            NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                                   memberId,@"Memberid",
                                   [NSString stringWithFormat:@"%ld",(long)pageIndex],@"pageIndex",
                                   nil];
            
            [SVProgressHUD showWithStatus:@"加载中..."];
            
            [httpClient request:@"FansGetMoneyTranMember.ashx" parameters:param success:^(NSJSONSerialization* json) {
                
                BOOL success = [[json valueForKey:@"status"] boolValue];
                
                if (success) {
                    
                    self.allProfitLab.text = [NSString stringWithFormat:@"%@",[json valueForKey:@"totalaccount"]];
                    
                    NSArray *array = [json valueForKey:@"ybtrList"];
                    
                    if (array.count != 0) {
                        
                        if (pageIndex == 1) {
                            
                            NSMutableArray *mutArr = [NSMutableArray array];
                            
                            for (NSDictionary *dd in array) {
                                
                                FSB_ProfitModel *model = [[FSB_ProfitModel alloc] init];
                                
                                model.TodayDate = [NSString stringWithFormat:@"%@",dd[@"TransactionDate"]];
                                
                                model.TodayProfit = [NSString stringWithFormat:@"%@",dd[@"Account"]];
                                
                                model.Type = [NSString stringWithFormat:@"%@",dd[@"TransactionType"]];
                                
                                FSB_ProfitFrame *frame = [[FSB_ProfitFrame alloc] init];
                                
                                frame.profitModel = model;
                                
                                [mutArr addObject:frame];
                                
                            }
                            
                            self.dataArray = mutArr;
                            
                        }else {
                            
                            NSMutableArray *temp = [NSMutableArray arrayWithArray:self.dataArray];
                            
                            for (NSDictionary *dd in array) {
                                
                                FSB_ProfitModel *model = [[FSB_ProfitModel alloc] init];
                                
                                model.TodayDate = [NSString stringWithFormat:@"%@",dd[@"TransactionDate"]];
                                
                                model.TodayProfit = [NSString stringWithFormat:@"%@",dd[@"Account"]];
                                
                                model.Type = [NSString stringWithFormat:@"%@",dd[@"TransactionType"]];
                                
                                FSB_ProfitFrame *frame = [[FSB_ProfitFrame alloc] init];
                                
                                frame.profitModel = model;
                                
                                [temp addObject:frame];
                                
                            }
                            
                            self.dataArray = temp;
                            
                        }
                        
                    }
                    
                    [SVProgressHUD dismiss];
                    
                    [self headAndFootEndRefreshing];
                    
                    [self.tableview reloadData];
                    
                } else {
                    
                    if (pageIndex > 1) {
                        
                        pageIndex --;
                        
                    }
                    
                    NSString *msg = [json valueForKey:@"msg"];
                    
                    [SVProgressHUD showErrorWithStatus:msg];
                    
                    [self headAndFootEndRefreshing];
                    
                }
                
            } failure:^(NSError *error) {
                
                if (pageIndex > 1) {
                    
                    pageIndex --;
                    
                }
                
                [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
                
                [self headAndFootEndRefreshing];
                
            }];
            
        }else if ([self.type isEqualToString:@"merchant"]) {
            
            NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
            
            AppHttpClient *httpClient = [AppHttpClient sharedClient];
            
            NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                                   memberId,@"Memberid",
                                   [NSString stringWithFormat:@"%ld",(long)pageIndex],@"pageIndex",
                                   self.merchantID,@"MerchantID",
                                   nil];
            
            [SVProgressHUD showWithStatus:@"加载中..."];
            
            [httpClient request:@"FansGetMoneyMerchantTran.ashx" parameters:param success:^(NSJSONSerialization* json) {
                
                BOOL success = [[json valueForKey:@"status"] boolValue];
                
                if (success) {
                    
                    self.allProfitLab.text = [NSString stringWithFormat:@"%@",[json valueForKey:@"totalaccount"]];
                    
                    NSArray *array = [json valueForKey:@"ybtrList"];
                    
                    if (array.count != 0) {
                        
                        if (pageIndex == 1) {
                            
                            NSMutableArray *mutArr = [NSMutableArray array];
                            
                            for (NSDictionary *dd in array) {
                                
                                FSB_ProfitModel *model = [[FSB_ProfitModel alloc] init];
                                
                                model.TodayDate = [NSString stringWithFormat:@"%@",dd[@"TransactionDate"]];
                                
                                model.TodayProfit = [NSString stringWithFormat:@"%@",dd[@"Account"]];
                                
                                model.Type = [NSString stringWithFormat:@"%@",dd[@"TransactionType"]];
                                
                                FSB_ProfitFrame *frame = [[FSB_ProfitFrame alloc] init];
                                
                                frame.profitModel = model;
                                
                                [mutArr addObject:frame];
                                
                            }
                            
                            self.dataArray = mutArr;
                            
                        }else {
                            
                            NSMutableArray *temp = [NSMutableArray arrayWithArray:self.dataArray];
                            
                            for (NSDictionary *dd in array) {
                                
                                FSB_ProfitModel *model = [[FSB_ProfitModel alloc] init];
                                
                                model.TodayDate = [NSString stringWithFormat:@"%@",dd[@"TransactionDate"]];
                                
                                model.TodayProfit = [NSString stringWithFormat:@"%@",dd[@"Account"]];
                                
                                model.Type = [NSString stringWithFormat:@"%@",dd[@"TransactionType"]];
                                
                                FSB_ProfitFrame *frame = [[FSB_ProfitFrame alloc] init];
                                
                                frame.profitModel = model;
                                
                                [temp addObject:frame];
                                
                            }
                            
                            self.dataArray = temp;
                            
                        }
                        
                    }
                    
                    [SVProgressHUD dismiss];
                    
                    [self headAndFootEndRefreshing];
                    
                    [self.tableview reloadData];
                    
                } else {
                    
                    if (pageIndex > 1) {
                        
                        pageIndex --;
                        
                    }
                    
                    NSString *msg = [json valueForKey:@"msg"];
                    
                    [SVProgressHUD showErrorWithStatus:msg];
                    
                    [self headAndFootEndRefreshing];
                    
                }
                
            } failure:^(NSError *error) {
                
                if (pageIndex > 1) {
                    
                    pageIndex --;
                    
                }
                
                [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
                
                [self headAndFootEndRefreshing];
                
            }];
            
        }
        
    }

}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];

}

@end
