//
//  GoldRecordViewController.m
//  HuiHui
//
//  Created by mac on 2017/9/11.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "GoldRecordViewController.h"
#import "LJConst.h"
#import "GoldTranModel.h"
#import "GoldTranFrame.h"
#import "GoldTranCell.h"
#import "GoldTranHeadView.h"

@interface GoldRecordViewController () <UITableViewDelegate,UITableViewDataSource> {
    
    NSString *segmType; // 1-全部 2-收入 3-支出
    
    NSInteger pageindex;
    
}

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, weak) UITableView *tableview;

@end

@implementation GoldRecordViewController

//-(NSArray *)dataArray {
//
//    if (_dataArray == nil) {
//        
//        NSString *path = [[NSBundle mainBundle] pathForResource:@"GoldTran.plist" ofType:nil];
//        
//        NSArray *array = [NSArray arrayWithContentsOfFile:path];
//        
//        NSMutableArray *mut = [NSMutableArray array];
//        
//        for (NSDictionary *dic in array) {
//            
//            GoldTranModel *model = [[GoldTranModel alloc] initWithDict:dic];
//            
//            GoldTranFrame *frame = [[GoldTranFrame alloc] init];
//            
//            frame.tranmodel = model;
//            
//            [mut addObject:frame];
//            
//        }
//        
//        _dataArray = mut;
//        
//    }
//    
//    return _dataArray;
//    
//}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"交易记录";
    
    self.navigationItem.leftBarButtonItem = [self SetNavigationBarImage:@"IMG_4582.PNG" andaction:@selector(viewDismiss)];
    
    [self allocWithTableview];
    
    segmType = @"0";
    
    pageindex = 1;
    
    [self requestForData];

}

- (void)requestForData {

    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         [CommonUtil getValueByKey:MEMBER_ID],@"memberid",
                         segmType,@"typeid",
                         [NSString stringWithFormat:@"%ld",(long)pageindex],@"pageIndex",
                         nil];
    
    AppHttpClient *http = [AppHttpClient sharedBonus];
    
    [SVProgressHUD showWithStatus:@"加载中..."];
    
    [http Bonusrequest:@"RecordList.ashx" parameters:dic success:^(NSJSONSerialization *json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            NSArray *array = [json valueForKey:@"gdList"];
            
            if (pageindex == 1) {
                
                if (array.count != 0) {
                    
                    NSMutableArray *mut = [NSMutableArray array];
                    
                    for (NSDictionary *dd in array) {
                        
                        GoldTranModel *model = [[GoldTranModel alloc] init];
                        
                        model.tranType = [NSString stringWithFormat:@"%@",dd[@"typename"]];
                        
                        model.count = [NSString stringWithFormat:@"%@",dd[@"goldnums"]];
                        
                        model.date = [NSString stringWithFormat:@"%@",dd[@"recordtime"]];
                        
                        model.status = [NSString stringWithFormat:@"%@",dd[@"recordstate"]];
            
                        GoldTranFrame *frame = [[GoldTranFrame alloc] init];
            
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
                    
                    for (NSDictionary *dd in array) {
                        
                        GoldTranModel *model = [[GoldTranModel alloc] init];
                        
                        model.tranType = [NSString stringWithFormat:@"%@",dd[@"typename"]];
                        
                        model.count = [NSString stringWithFormat:@"%@",dd[@"goldnums"]];
                        
                        model.date = [NSString stringWithFormat:@"%@",dd[@"recordtime"]];
                        
                        model.status = [NSString stringWithFormat:@"%@",dd[@"recordstate"]];
                        
                        GoldTranFrame *frame = [[GoldTranFrame alloc] init];
                        
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
    
    GoldTranHeadView *headview = [[GoldTranHeadView alloc] init];
    
    headview.changeblock = ^(NSInteger i) {
        
        switch (i) {
            case 0:
            {
                
                segmType = @"0";
                
                pageindex = 1;
                
                [self requestForData];
                
            }
                break;
                
            case 1:
            {
                
                segmType = @"1";
                
                pageindex = 1;
                
                [self requestForData];
                
            }
                break;
                
            case 2:
            {
                
                segmType = @"2";
                
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
    
    tableview.backgroundColor = FSB_ViewBGCOLOR;
    
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

    GoldTranCell *cell = [[GoldTranCell alloc] init];
    
    GoldTranFrame *frame = self.dataArray[indexPath.row];
    
    cell.frameModel = frame;
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    GoldTranFrame *frame = self.dataArray[indexPath.row];
    
    return frame.height;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (void)viewDismiss {

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
