//
//  ConsumptionlistViewController.m
//  HuiHui
//
//  Created by 冯海强 on 15-4-14.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "ConsumptionlistViewController.h"
#import "ConsumptionTableViewCell.h"
#import "LJConst.h"

@interface ConsumptionlistViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)NSMutableArray *ConsumptionlArray;

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, weak) UISegmentedControl *segmview;

@end

@implementation ConsumptionlistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    m_pageindex= 1;
    self.ConsumptionlArray = [[NSMutableArray alloc]initWithCapacity:0];
    [self setTitle:@"交易记录"];
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
//    M_Consumptiontable.delegate = self;
//    M_Consumptiontable.dataSource = self;
//    [M_Consumptiontable setPullDelegate:self];
//    M_Consumptiontable.pullBackgroundColor = [UIColor whiteColor];
//    M_Consumptiontable.useRefreshView = YES;
//    M_Consumptiontable.useLoadingMoreView= YES;
//    semplabel.hidden = YES;
//    M_Consumptiontable.hidden = YES;
//    [self Servicers_loadData];
    
//    [self allocWithTableview];
    
}

- (void)allocWithTableview {
    
    UISegmentedControl *segmview = [[UISegmentedControl alloc] initWithItems:@[@"全部",@"收入",@"支出"]];
    
    segmview.frame = CGRectMake(_WindowViewWidth * 0.25, 10, _WindowViewWidth * 0.5, 35);
    
    self.segmview = segmview;
    
    segmview.selectedSegmentIndex = 0;
    
    segmview.tintColor = FSB_StyleCOLOR;
    
    [segmview addTarget:self action:@selector(segmchange:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:segmview];
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(segmview.frame) + 10, _WindowViewWidth, _WindowViewHeight - 64 - 10 - CGRectGetMaxY(segmview.frame))];
    
    self.tableview = tableview;
    
    tableview.delegate = self;
    
    tableview.dataSource = self;
    
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:tableview];
    
}

- (void)segmchange:(UISegmentedControl *)segm {
    
//    switch (segm.selectedSegmentIndex) {
//        case 0:
//        {
//
//            recordType = @"1";
//
//            [self.tableview reloadData];
//
//        }
//            break;
//
//        case 1:
//        {
//
//            recordType = @"2";
//
//            [self.tableview reloadData];
//
//        }
//            break;
//
//        default:
//            break;
//    }
    
}

- (void)leftClicked{
    
    [self goBack];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return nil;
    
}
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//
//    return 88;
//}
//
//#pragma mark - UITableViewDelegate
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *CellIdentifier = @"Cell";
//    ConsumptionTableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (cell == nil) {
//        NSArray*cellarray=[[NSBundle mainBundle]
//                           loadNibNamed:@"ConsumptionTableViewCell" owner:self options:nil];
//        cell =[cellarray objectAtIndex:0];
//
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    }
//
//    if ( self.ConsumptionlArray.count != 0 ) {
//
//        NSDictionary *dic = [self.ConsumptionlArray objectAtIndex:indexPath.row];
//
//        cell.shoplabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"shopName"]];
//        cell.timelabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"transDate"]];
//        cell.typelabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"transTypeName"]];
//        cell.moneylabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"amount"]];
//
//        if ([[NSString stringWithFormat:@"%@",[dic objectForKey:@"transType"]] isEqualToString:@"3"]) {
//
//            cell.moneylabel.textColor = RGBACKTAB;
//
//        }else{
//
//            cell.moneylabel.textColor = RGBACOLOR(200, 0, 0, 1);
//
//        }
//
//
//    }
//
//
//    return cell;
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];//取消选中状态。。
//
//}
//
//- (void)Servicers_loadData {
//    // 判断网络是否存在
//    if ( ![self isConnectionAvailable] ) {
//        return;
//    }
//    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
//    AppHttpClient* httpClient = [AppHttpClient sharedClient];
//    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
//                           memberId,     @"memberId",
//                           [NSString stringWithFormat:@"%ld",(long)m_pageindex],@"pageIndex",
//                           @"20",@"pageSize",
//                           self.vipCardRecordId,@"vipCardRecordId",
//                           nil];
//    if (self.ConsumptionlArray.count ==0) {
//        [SVProgressHUD showWithStatus:@"数据加载中..."];
//    }
//    [httpClient request:@"GetVIPCardTransactionRecords.ashx" parameters:param success:^(NSJSONSerialization* json) {
//        BOOL success = [[json valueForKey:@"status"] boolValue];
//        if (success) {
//            [SVProgressHUD dismiss];
//
//            NSMutableArray *metchantShop = [json valueForKey:@"recordList"];
//
//            if (m_pageindex == 1) {
//                if (metchantShop == nil || metchantShop.count == 0) {
//                    [SVProgressHUD showErrorWithStatus:@"暂无服务历史"];
//                    semplabel.hidden = NO;
//                    M_Consumptiontable.hidden = YES;
//                } else {
//                    self.ConsumptionlArray = metchantShop;
//                    M_Consumptiontable.hidden = NO;
//                    semplabel.hidden = YES;
//                }
//            } else {
//                if (metchantShop == nil || metchantShop.count == 0) {
//                    m_pageindex--;
//                } else {
//                    [self.ConsumptionlArray addObjectsFromArray:metchantShop];
//                }
//            }
//
//            [M_Consumptiontable reloadData];
//
//        } else {
//            NSString *msg = [json valueForKey:@"msg"];
//            [SVProgressHUD showErrorWithStatus:msg];
//        }
//        M_Consumptiontable.pullLastRefreshDate = [NSDate date];
//        M_Consumptiontable.pullTableIsRefreshing = NO;
//        M_Consumptiontable.pullTableIsLoadingMore = NO;
//    } failure:^(NSError *error) {
//        [SVProgressHUD showErrorWithStatus:@"请求失败"];
//        M_Consumptiontable.pullTableIsRefreshing = NO;
//        M_Consumptiontable.pullTableIsLoadingMore = NO;
//    }];
//}
//
//#pragma mark - PullTableViewDelegate
//- (void)pullTableViewDidTriggerRefresh:(PullTableView*)pullTableView {
//    m_pageindex = 1;
//    [self Servicers_loadData];
//}
//
//- (void)pullTableViewDidTriggerLoadMore:(PullTableView*)pullTableView {
//    m_pageindex ++;
//    [self Servicers_loadData];
//}

@end
