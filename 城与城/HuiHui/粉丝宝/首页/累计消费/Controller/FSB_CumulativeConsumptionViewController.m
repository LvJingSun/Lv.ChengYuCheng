//
//  FSB_CumulativeConsumptionViewController.m
//  HuiHui
//
//  Created by mac on 2017/5/16.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "FSB_CumulativeConsumptionViewController.h"
#import "LJConst.h"
//累计消费model
#import "FSB_ConsumptionModel.h"
//消费frame
#import "FSB_ConsumptionFrame.h"
//消费cell
#import "FSB_ConsumptionCell.h"

@interface FSB_CumulativeConsumptionViewController () <UITableViewDelegate,UITableViewDataSource> {
    
    NSInteger pageIndex;
    
}

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation FSB_CumulativeConsumptionViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    pageIndex = 1;
    
    self.title = @"累计消费";
    
    [self allocWithTableView];
    
    [self requestForCumulativeConsumptionData];

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
        
        [self requestForCumulativeConsumptionData];
        
    }];
    
    tableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        pageIndex ++;
        
        [self requestForCumulativeConsumptionData];
        
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
    
    FSB_ConsumptionCell *cell = [[FSB_ConsumptionCell alloc] init];
    
    FSB_ConsumptionFrame *frame = self.dataArray[indexPath.row];
    
    cell.frameModel = frame;
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FSB_ConsumptionFrame *frame = self.dataArray[indexPath.row];
    
    return frame.height;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

//请求累计消费数据
- (void)requestForCumulativeConsumptionData {
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    
    AppHttpClient *httpClient = [AppHttpClient sharedClient];
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"memberid",
                           [NSString stringWithFormat:@"%ld",(long)pageIndex],@"pageIndex",
                           nil];
    
    [SVProgressHUD showWithStatus:@"加载中..."];
    
    [httpClient request:@"CumulativeConsumption.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            NSArray *array = [json valueForKey:@"ybtrList"];
            
            if (array.count != 0) {
                
                if (pageIndex == 1) {
                    
                    NSMutableArray *mutArr = [NSMutableArray array];
                    
                    for (NSDictionary *dd in array) {
                        
                        FSB_ConsumptionModel *model = [[FSB_ConsumptionModel alloc] initWithDict:dd];
                        
                        FSB_ConsumptionFrame *frame = [[FSB_ConsumptionFrame alloc] init];
                        
                        frame.consumptionModel = model;
                        
                        [mutArr addObject:frame];
                        
                    }
                    
                    self.dataArray = mutArr;
                    
                }else {
                    
                    NSMutableArray *temp = [NSMutableArray arrayWithArray:self.dataArray];
                    
                    for (NSDictionary *dd in array) {
                        
                        FSB_ConsumptionModel *model = [[FSB_ConsumptionModel alloc] initWithDict:dd];
                        
                        FSB_ConsumptionFrame *frame = [[FSB_ConsumptionFrame alloc] init];
                        
                        frame.consumptionModel = model;
                        
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
