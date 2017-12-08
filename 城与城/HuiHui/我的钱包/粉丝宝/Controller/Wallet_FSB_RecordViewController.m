//
//  Wallet_FSB_RecordViewController.m
//  HuiHui
//
//  Created by mac on 2017/9/12.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "Wallet_FSB_RecordViewController.h"
#import "RedHorseHeader.h"
#import "LJConst.h"
#import "FSB_TranModel.h"
#import "FSB_TranFrame.h"
#import "FSB_TranCell.h"
#import "FSB_RecordHeadView.h"
#import "Wallet_FSB_DetailViewController.h"

@interface Wallet_FSB_RecordViewController ()<UITableViewDelegate,UITableViewDataSource> {
    
    NSString *segmType; // 1-全部 2-领取 3-支出
    
    NSInteger pageindex;
    
}

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, weak) UITableView *tableview;

@end

@implementation Wallet_FSB_RecordViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    [self setTitle:@"明细"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    self.view.backgroundColor = RH_ViewBGColor;
    
    [self allocWithTableview];
    
    segmType = @"1";
    
    pageindex = 1;
    
    [self requestForData];
    
}

- (void)requestForData {
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         [CommonUtil getValueByKey:MEMBER_ID],@"MemberID",
                         segmType,@"Type",
                         [NSString stringWithFormat:@"%ld",(long)pageindex],@"pageIndex",
                         nil];
    
    AppHttpClient *httpclient = [AppHttpClient sharedClient];
    
    [SVProgressHUD showWithStatus:@"加载中..."];
    
    [httpclient request:@"MyFansTranList.ashx" parameters:dic success:^(NSJSONSerialization *json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            NSArray *array = [json valueForKey:@"transactionRecords"];
            
            if (pageindex == 1) {
                
                if (array.count != 0) {
                    
                    NSMutableArray *mut = [NSMutableArray array];
                    
                    for (NSDictionary *dic in array) {
                        
                        FSB_TranModel *model = [[FSB_TranModel alloc] init];
                        
                        model.OrderNo = [NSString stringWithFormat:@"%@",dic[@"OrderNo"]];
                        
                        model.TradingOperations = [NSString stringWithFormat:@"%@",dic[@"TradingOperations"]];
                        
                        model.icon = [NSString stringWithFormat:@"%@",dic[@"icon"]];
                        
                        model.name = [NSString stringWithFormat:@"%@",dic[@"name"]];
                        
                        model.count = [NSString stringWithFormat:@"%@",dic[@"count"]];
                        
                        model.status = [NSString stringWithFormat:@"%@",dic[@"status"]];
                        
                        model.CostDesc = [NSString stringWithFormat:@"%@",dic[@"CostDesc"]];
                        
                        model.TranType = [NSString stringWithFormat:@"%@",dic[@"TranType"]];
                        
                        model.GoodsDesc = [NSString stringWithFormat:@"%@",dic[@"GoodsDesc"]];
                        
                        model.CreateTime = [NSString stringWithFormat:@"%@",dic[@"CreateTime"]];
                        
                        FSB_TranFrame *frame = [[FSB_TranFrame alloc] init];
                        
                        frame.tranmodel = model;
                        
                        [mut addObject:frame];
                        
                    }
                    
                    self.dataArray = mut;
                    
                }else {
                    
                    self.dataArray = array;
                    
                }
                
            }else {
                
                if (array.count != 0) {
                    
                    NSMutableArray *temp = [NSMutableArray arrayWithArray:self.dataArray];
                    
                    for (NSDictionary *dic in array) {
                        
                        FSB_TranModel *model = [[FSB_TranModel alloc] init];
                        
                        model.OrderNo = [NSString stringWithFormat:@"%@",dic[@"OrderNo"]];
                        
                        model.TradingOperations = [NSString stringWithFormat:@"%@",dic[@"TradingOperations"]];
                        
                        model.icon = [NSString stringWithFormat:@"%@",dic[@"icon"]];
                        
                        model.name = [NSString stringWithFormat:@"%@",dic[@"name"]];
                        
                        model.count = [NSString stringWithFormat:@"%@",dic[@"count"]];
                        
                        model.status = [NSString stringWithFormat:@"%@",dic[@"status"]];
                        
                        model.CostDesc = [NSString stringWithFormat:@"%@",dic[@"CostDesc"]];
                        
                        model.TranType = [NSString stringWithFormat:@"%@",dic[@"TranType"]];
                        
                        model.GoodsDesc = [NSString stringWithFormat:@"%@",dic[@"GoodsDesc"]];
                        
                        model.CreateTime = [NSString stringWithFormat:@"%@",dic[@"CreateTime"]];
                        
                        FSB_TranFrame *frame = [[FSB_TranFrame alloc] init];
                        
                        frame.tranmodel = model;
                        
                        [temp addObject:frame];
                        
                    }
                    
                    self.dataArray = temp;
                    
                }
                
            }
            
            [SVProgressHUD dismiss];
            
            [self headAndFootEndRefreshing];
            
            [self.tableview reloadData];
            
        }else {
            
            if (pageindex > 1) {
                
                pageindex --;
                
            }
            
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showErrorWithStatus:msg];
            
            [self headAndFootEndRefreshing];
            
        }
        
    } failure:^(NSError *error) {
        
        if (pageindex > 1) {
            
            pageindex --;
            
        }
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
        [self headAndFootEndRefreshing];
        
    }];
    
}

- (void)allocWithTableview {
    
    FSB_RecordHeadView *headview = [[FSB_RecordHeadView alloc] init];
    
    headview.changeblock = ^(NSInteger i) {
        
        switch (i) {
            case 0:
            {
                
                segmType = @"1";
                
                pageindex = 1;
                
                [self requestForData];
                
            }
                break;
                
            case 1:
            {
                
                segmType = @"2";
                
                pageindex = 1;
                
                [self requestForData];
                
            }
                break;
                
            case 2:
            {
                
                segmType = @"3";
                
                pageindex = 1;
                
                [self requestForData];
                
            }
                break;
                
            default:
                break;
        }
        
    };
    
    headview.frame = CGRectMake(0, 0, _WindowViewWidth, headview.height);
    
    [self.view addSubview:headview];
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(headview.frame), _WindowViewWidth, _WindowViewHeight - 64 - headview.height)];
    
    self.tableview = tableview;
    
    tableview.backgroundColor = RH_ViewBGColor;
    
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    tableview.delegate = self;
    
    tableview.dataSource = self;
    
    tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        pageindex = 1;
        
        [self requestForData];
        
    }];
    
    tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        pageindex ++;
        
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
    
    FSB_TranCell *cell = [[FSB_TranCell alloc] init];
    
    FSB_TranFrame *frame = self.dataArray[indexPath.row];
    
    cell.frameModel = frame;
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FSB_TranFrame *frame = self.dataArray[indexPath.row];
    
    return frame.height;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    FSB_TranFrame *frame = self.dataArray[indexPath.row];
    
    Wallet_FSB_DetailViewController *vc = [[Wallet_FSB_DetailViewController alloc] init];
    
    vc.tranModel = frame.tranmodel;
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)leftClicked {

    [self.navigationController popViewControllerAnimated:YES];
    
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
