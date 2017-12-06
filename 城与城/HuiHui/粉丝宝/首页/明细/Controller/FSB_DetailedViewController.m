//
//  FSB_DetailedViewController.m
//  HuiHui
//
//  Created by mac on 2017/5/16.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "FSB_DetailedViewController.h"
#import "LJConst.h"
#import "FSB_DetailedModel.h"
#import "FSB_DetailedFrame.h"
#import "FSB_DetailedCell.h"

@interface FSB_DetailedViewController () <UITableViewDelegate,UITableViewDataSource> {
    
    NSInteger pageIndex;
    
}

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation FSB_DetailedViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    pageIndex = 1;
    
    self.title = @"明细";
    
    [self allocWithTableView];
    
    [self requestForDetailedData];

}

//初始化tableview
- (void)allocWithTableView {
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, _WindowViewWidth, _WindowViewHeight - 64)];
    
    self.tableview = tableview;
    
    tableview.delegate = self;
    
    tableview.dataSource = self;
    
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    tableview.backgroundColor = FSB_ViewBGCOLOR;
    
    tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        pageIndex = 1;
        
        [self requestForDetailedData];
        
    }];
    
    tableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        pageIndex ++;
        
        [self requestForDetailedData];
        
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
    
    FSB_DetailedCell *cell = [[FSB_DetailedCell alloc] init];
    
    FSB_DetailedFrame *frame = self.dataArray[indexPath.row];
    
    cell.frameModel = frame;
    
    cell.phoneBlock = ^{
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",@"0512-89181985"]]];
        
    };
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FSB_DetailedFrame *frame = self.dataArray[indexPath.row];
    
    return frame.height;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

//请求明细数据
- (void)requestForDetailedData {
    
    if ([self.redType isEqualToString:@"2"]) {
        
        NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
        
        AppHttpClient *httpClient = [AppHttpClient sharedClient];
        
        NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                               memberId,@"Memberid",
                               self.merchantID,@"MerchantID",
                               [NSString stringWithFormat:@"%ld",(long)pageIndex],@"pageIndex",
                               nil];
        
        [SVProgressHUD showWithStatus:@"加载中..."];
        
        [httpClient request:@"MctRPMemMerTranList.ashx" parameters:param success:^(NSJSONSerialization* json) {
            
            BOOL success = [[json valueForKey:@"status"] boolValue];
            
            if (success) {
                
                NSArray *array = [json valueForKey:@"ybtrList"];
                
                if (array.count != 0) {
                    
                    if (pageIndex == 1) {
                        
                        NSMutableArray *mutArr = [NSMutableArray array];
                        
                        for (NSDictionary *dd in array) {
                            
                            FSB_DetailedModel *model = [[FSB_DetailedModel alloc] init];
                            
                            model.totaledu = [NSString stringWithFormat:@"%@",dd[@"Allaccount"]];
                            
                            model.FanliID = [NSString stringWithFormat:@"%@",dd[@"TranNum"]];
                            
                            model.StartDate = [NSString stringWithFormat:@"%@",dd[@"CreateDate"]];
                            
                            model.progress = [NSString stringWithFormat:@"%@",dd[@"progress"]];
                            
                            model.Status = [NSString stringWithFormat:@"%@",dd[@"TranStatus"]];
                            
                            model.Days = [NSString stringWithFormat:@"%@",dd[@"Part"]];
                            
                            model.Source = [NSString stringWithFormat:@"%@",dd[@"Souce"]];
                            
                            model.Total = [NSString stringWithFormat:@"%@",dd[@"GetAccount"]];
                            
                            model.goodname = [NSString stringWithFormat:@"%@",dd[@"Goodsname"]];
                            
                            model.liyou = [NSString stringWithFormat:@"%@",dd[@"liyou"]];
                            
                            FSB_DetailedFrame *frame = [[FSB_DetailedFrame alloc] init];
                            
                            frame.detailedModel = model;
                            
                            [mutArr addObject:frame];
                            
                        }
                        
                        self.dataArray = mutArr;
                        
                    }else {
                        
                        NSMutableArray *mutArr = [NSMutableArray arrayWithArray:self.dataArray];
                        
                        for (NSDictionary *dd in array) {
                            
                            FSB_DetailedModel *model = [[FSB_DetailedModel alloc] init];
                            
                            model.totaledu = [NSString stringWithFormat:@"%@",dd[@"Allaccount"]];
                            
                            model.FanliID = [NSString stringWithFormat:@"%@",dd[@"TranNum"]];
                            
                            model.StartDate = [NSString stringWithFormat:@"%@",dd[@"CreateDate"]];
                            
                            model.progress = [NSString stringWithFormat:@"%@",dd[@"progress"]];
                            
                            model.Status = [NSString stringWithFormat:@"%@",dd[@"TranStatus"]];
                            
                            model.Days = [NSString stringWithFormat:@"%@",dd[@"Part"]];
                            
                            model.Source = [NSString stringWithFormat:@"%@",dd[@"Souce"]];
                            
                            model.Total = [NSString stringWithFormat:@"%@",dd[@"GetAccount"]];
                            
                            FSB_DetailedFrame *frame = [[FSB_DetailedFrame alloc] init];
                            
                            frame.detailedModel = model;
                            
                            [mutArr addObject:frame];
                            
                        }
                        
                        self.dataArray = mutArr;
                        
                    }
                    
                }
                
                [self headAndFootEndRefreshing];
                
                [SVProgressHUD dismiss];
                
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
        
    }else {
        
        NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
        
        AppHttpClient *httpClient = [AppHttpClient sharedClient];
        
        NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                               memberId,@"Memberid",
                               self.merchantID,@"MerchantID",
                               [NSString stringWithFormat:@"%ld",(long)pageIndex],@"pageIndex",
                               nil];
        
        [SVProgressHUD showWithStatus:@"加载中..."];
        
        [httpClient request:@"FansMemMerTranList_1.ashx" parameters:param success:^(NSJSONSerialization* json) {
            
            BOOL success = [[json valueForKey:@"status"] boolValue];
            
            if (success) {
                
                NSArray *array = [json valueForKey:@"ybtrList"];
                
                if (array.count != 0) {
                    
                    if (pageIndex == 1) {
                        
                        NSMutableArray *mutArr = [NSMutableArray array];
                        
                        for (NSDictionary *dd in array) {
                            
                            FSB_DetailedModel *model = [[FSB_DetailedModel alloc] init];
                            
                            model.totaledu = [NSString stringWithFormat:@"%@",dd[@"Allaccount"]];
                            
                            model.FanliID = [NSString stringWithFormat:@"%@",dd[@"TranNum"]];
                            
                            model.StartDate = [NSString stringWithFormat:@"%@",dd[@"CreateDate"]];
                            
                            model.progress = [NSString stringWithFormat:@"%@",dd[@"progress"]];
                            
                            model.Status = [NSString stringWithFormat:@"%@",dd[@"TranStatus"]];
                            
                            model.Days = [NSString stringWithFormat:@"%@",dd[@"Part"]];
                            
                            model.Source = [NSString stringWithFormat:@"%@",dd[@"Souce"]];
                            
                            model.Total = [NSString stringWithFormat:@"%@",dd[@"GetAccount"]];
                            
                            model.goodname = [NSString stringWithFormat:@"%@",dd[@"Goodsname"]];
                            
                            model.liyou = [NSString stringWithFormat:@"%@",dd[@"liyou"]];
                            
                            FSB_DetailedFrame *frame = [[FSB_DetailedFrame alloc] init];
                            
                            frame.detailedModel = model;
                            
                            [mutArr addObject:frame];
                            
                        }
                        
                        self.dataArray = mutArr;
                        
                    }else {
                        
                        NSMutableArray *mutArr = [NSMutableArray arrayWithArray:self.dataArray];
                        
                        for (NSDictionary *dd in array) {
                            
                            FSB_DetailedModel *model = [[FSB_DetailedModel alloc] init];
                            
                            model.totaledu = [NSString stringWithFormat:@"%@",dd[@"Allaccount"]];
                            
                            model.FanliID = [NSString stringWithFormat:@"%@",dd[@"TranNum"]];
                            
                            model.StartDate = [NSString stringWithFormat:@"%@",dd[@"CreateDate"]];
                            
                            model.progress = [NSString stringWithFormat:@"%@",dd[@"progress"]];
                            
                            model.Status = [NSString stringWithFormat:@"%@",dd[@"TranStatus"]];
                            
                            model.Days = [NSString stringWithFormat:@"%@",dd[@"Part"]];
                            
                            model.Source = [NSString stringWithFormat:@"%@",dd[@"Souce"]];
                            
                            model.Total = [NSString stringWithFormat:@"%@",dd[@"GetAccount"]];
                            
                            FSB_DetailedFrame *frame = [[FSB_DetailedFrame alloc] init];
                            
                            frame.detailedModel = model;
                            
                            [mutArr addObject:frame];
                            
                        }
                        
                        self.dataArray = mutArr;
                        
                    }
                    
                }
                
                [self headAndFootEndRefreshing];
                
                [SVProgressHUD dismiss];
                
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
    
}


- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];

}

@end
