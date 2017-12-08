//
//  GameTranViewController.m
//  HuiHui
//
//  Created by mac on 2017/12/7.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "GameTranViewController.h"
#import "LJConst.h"
#import "GameTranModel.h"
#import "GameTranFrame.h"
#import "GameTranCell.h"

@interface GameTranViewController () <UITableViewDelegate,UITableViewDataSource> {
    
    NSInteger pageIndex;
    
}

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, weak) UITableView *tableview;

@end

@implementation GameTranViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    pageIndex = 1;

    [self setTitle:@"记录"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    self.view.backgroundColor = FSB_ViewBGCOLOR;
    
    [self allocWithTableview];
    
    [self requestForData];
    
}

- (void)requestForData {
    
    AppHttpClient *http = [AppHttpClient sharedHuLa];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         [CommonUtil getValueByKey:MEMBER_ID],@"memberId",
                         [NSString stringWithFormat:@"%ld",(long)pageIndex],@"pageIndex",
                         nil];
    
    [SVProgressHUD showWithStatus:@"加载中..."];
    
    [http HuLarequest:@"GetRechargeRecord.ashx" parameters:dic success:^(NSJSONSerialization *json) {
        
        if ([[json valueForKey:@"status"] boolValue]) {
            
            NSArray *array = [json valueForKey:@"rechargeRecordList"];
            
            if (pageIndex == 1) {
                
                if (array.count != 0) {
                    
                    NSMutableArray *mut = [NSMutableArray array];
                    
                    for (NSDictionary *dic in array) {
                        
                        GameTranModel *model = [[GameTranModel alloc] init];
                        
                        model.type = [NSString stringWithFormat:@"%@",dic[@"rechargeType"]];
                        
                        model.count = [NSString stringWithFormat:@"%@",dic[@"rechargeAmount"]];
                        
                        model.date = [NSString stringWithFormat:@"%@",dic[@"createDate"]];
                        
                        model.recordID = [NSString stringWithFormat:@"%@",dic[@"rechargeRecordId"]];
                        
                        model.remark = [NSString stringWithFormat:@"%@",dic[@"remark"]];
                        
                        GameTranFrame *frame = [[GameTranFrame alloc] init];
                        
                        frame.tranModel = model;
                        
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
                        
                        GameTranModel *model = [[GameTranModel alloc] init];
                        
                        model.type = [NSString stringWithFormat:@"%@",dic[@"rechargeType"]];
                        
                        model.count = [NSString stringWithFormat:@"%@",dic[@"rechargeAmount"]];
                        
                        model.date = [NSString stringWithFormat:@"%@",dic[@"createDate"]];
                        
                        model.recordID = [NSString stringWithFormat:@"%@",dic[@"rechargeRecordId"]];
                        
                        model.remark = [NSString stringWithFormat:@"%@",dic[@"remark"]];
                        
                        GameTranFrame *frame = [[GameTranFrame alloc] init];
                        
                        frame.tranModel = model;
                        
                        [temp addObject:frame];
                        
                    }
                    
                    self.dataArray = temp;
                    
                }
                
            }
            
            [SVProgressHUD dismiss];
            
            [self headAndFootEndRefreshing];
            
            [self.tableview reloadData];
            
        }else {
            
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

- (void)allocWithTableview {
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, _WindowViewWidth, _WindowViewHeight - 64)];
    
    self.tableview = tableview;
    
    tableview.delegate = self;
    
    tableview.dataSource = self;
    
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    tableview.backgroundColor = FSB_ViewBGCOLOR;
    
    tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        pageIndex = 1;
        
        [self requestForData];
        
    }];
    
    tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
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
    
    GameTranFrame *frame = self.dataArray[indexPath.row];
    
    GameTranCell *cell = [[GameTranCell alloc] init];
    
    cell.frameModel = frame;
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GameTranFrame *frame = self.dataArray[indexPath.row];
    
    return frame.height;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
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
