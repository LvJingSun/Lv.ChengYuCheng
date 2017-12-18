//
//  MoneyListViewController.m
//  HuiHui
//
//  Created by mac on 2016/12/5.
//  Copyright © 2016年 MaxLinksTec. All rights reserved.
//

#import "MoneyListViewController.h"
#import <MJRefresh.h>
#import "CommonUtil.h"
#import "AppHttpClient.h"
#import "SVProgressHUD.h"
#import "YuEDetailCell.h"
#import "XiangQingViewController.h"
#import "LJConst.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface MoneyListViewController ()<UITableViewDelegate,UITableViewDataSource> {

    int m_pageIndex;
    
    NSString *recordType;
    
}

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, weak) UILabel *noLabel;

@property (nonatomic, weak) UISegmentedControl *segmview;

@end

@implementation MoneyListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"余额明细";
    
    self.dataArray = [NSMutableArray array];
    
    [self initWithTableview];
    
    m_pageIndex = 1;
    
    recordType = @"All";
    
    [self loadAllDataWithPageIndex:m_pageIndex];

}

- (void)initWithTableview {
    
    UISegmentedControl *segmview = [[UISegmentedControl alloc] initWithItems:@[@"全部",@"收入",@"支出"]];
    
    segmview.frame = CGRectMake(_WindowViewWidth * 0.15, 10, _WindowViewWidth * 0.7, 35);
    
    self.segmview = segmview;
    
    segmview.selectedSegmentIndex = 0;
    
    segmview.tintColor = FSB_StyleCOLOR;
    
    segmview.layer.masksToBounds = YES;
    
    segmview.layer.borderWidth = 1;
    
    segmview.layer.borderColor = FSB_StyleCOLOR.CGColor;
    
    segmview.layer.cornerRadius = 17.5;
    
    [segmview addTarget:self action:@selector(segmchange:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:segmview];
    
    UILabel *lab= [[UILabel alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT * 0.5 - 30, SCREEN_WIDTH, 30)];
    
    self.noLabel = lab;
    
    lab.text = @"暂无数据";
    
    lab.textColor = [UIColor lightGrayColor];
    
    lab.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:lab];
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(segmview.frame) + 10, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 10 - CGRectGetMaxY(segmview.frame))];
    
    self.tableview = tableview;
    
    tableview.delegate = self;
    
    tableview.dataSource = self;
    
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        m_pageIndex = 1;

        [self loadAllDataWithPageIndex:m_pageIndex];
        
    }];
    
    tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        m_pageIndex ++;

        [self loadAllDataWithPageIndex:m_pageIndex];
        
    }];
    
    [self.view addSubview:tableview];
    
}

- (void)segmchange:(UISegmentedControl *)segm {
    
        switch (segm.selectedSegmentIndex) {
            case 0:
            {
    
                recordType = @"All";
                
                m_pageIndex = 1;
    
                [self loadAllDataWithPageIndex:m_pageIndex];
    
            }
                break;
    
            case 1:
            {
    
                recordType = @"Income";
                
                m_pageIndex = 1;
    
                [self loadAllDataWithPageIndex:m_pageIndex];
    
            }
                break;
                
            case 2:
            {
                
                recordType = @"Expenditure";
                
                m_pageIndex = 1;
                
                [self loadAllDataWithPageIndex:m_pageIndex];
                
            }
                break;
    
            default:
                break;
        }
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    NSDictionary *dic = self.dataArray[indexPath.row];
    
    YuEDetailCell *cell = [[YuEDetailCell alloc] init];
    
    cell.typeLab.text = dic[@"transactionType"];
    
    if ([dic[@"tradingOperations"] isEqualToString:@"Income"]) {
        
        cell.countLab.text = [NSString stringWithFormat:@"+%.2f",[dic[@"amount"] floatValue]];
        
        cell.countLab.textColor = [UIColor colorWithRed:72/255.f green:162/255.f blue:245/255.f alpha:1.0];
        
    }else {
        
        cell.countLab.text = [NSString stringWithFormat:@"-%.2f",[dic[@"amount"] floatValue]];
        
        cell.countLab.textColor = [UIColor redColor];
        
    }
    
    cell.timeLab.text = dic[@"transactionDate"];
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    YuEDetailCell *cell = [[YuEDetailCell alloc] init];
    
    return cell.height;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *dd = self.dataArray[indexPath.row];
    
    XiangQingViewController *vc = [[XiangQingViewController alloc] init];
    
    vc.no = dd[@"transactionNumber"];
    
    vc.time = dd[@"transactionDate"];
    
    vc.money = dd[@"tradingOperations"];
    
    vc.type = dd[@"transactionType"];
    
    vc.status = dd[@"status"];
    
    vc.count = [NSString stringWithFormat:@"%@",dd[@"amount"]];

    vc.desc = dd[@"description"];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)loadAllDataWithPageIndex:(int)pageindex {
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    
    NSString *page = [NSString stringWithFormat:@"%d",pageindex];
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"memberId",
                           recordType,@"tradOpt",
                           page,@"pageIndex",
                           nil];
    
    [SVProgressHUD showWithStatus:@"请求中..."];
    
    [httpClient request:@"TransactionRecords_2.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            
            NSArray *array = [json valueForKey:@"transactionRecords"];
            
            if (pageindex == 1) {
                
                if (array.count != 0) {
                    
                    self.tableview.hidden = NO;
                    
                    self.noLabel.hidden = YES;
                    
                    self.dataArray = [NSMutableArray arrayWithArray:array];
                    
                }else {
                
                    self.tableview.hidden = YES;
                    
                    self.noLabel.hidden = NO;
                    
                }
                
            }else {
                
                if (array.count != 0) {
                    
                    [self.dataArray addObjectsFromArray:array];
                    
                }
                
            }
            
            [self headAndFootEndRefreshing];
            
            [SVProgressHUD dismiss];
            
            [self.tableview reloadData];
            
        } else {
            
            if (m_pageIndex != 1) {
                
                m_pageIndex --;
                
            }
            
            [SVProgressHUD dismiss];
            
            [self headAndFootEndRefreshing];
            
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showErrorWithStatus:msg];
            
        }
        
    } failure:^(NSError *error) {
        
        if (m_pageIndex != 1) {
            
            m_pageIndex --;
            
        }
        
        [SVProgressHUD dismiss];
        
        [self headAndFootEndRefreshing];
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}

- (void)headAndFootEndRefreshing {
    
    [self.tableview.mj_header endRefreshing];
    
    [self.tableview.mj_footer endRefreshing];
    
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
