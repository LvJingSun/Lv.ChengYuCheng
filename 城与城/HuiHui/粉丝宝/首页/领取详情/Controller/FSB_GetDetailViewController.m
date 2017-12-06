//
//  FSB_GetDetailViewController.m
//  HuiHui
//
//  Created by mac on 2017/7/25.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "FSB_GetDetailViewController.h"
#import "LJConst.h"
#import "GetDetailModel.h"
#import "GetDetailFrame.h"
#import "GetDetailCell.h"
#import "FSB_GetDetailHeadView.h"

@interface FSB_GetDetailViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, weak) FSB_GetDetailHeadView *headview;

@end

@implementation FSB_GetDetailViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
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
    
    [self.view addSubview:tableview];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    GetDetailCell *cell = [[GetDetailCell alloc] init];
    
    GetDetailFrame *frame = self.dataArray[indexPath.row];
    
    cell.frameModel = frame;
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    GetDetailFrame *frame = self.dataArray[indexPath.row];
    
    return frame.height;
    
}

- (void)requestForData {
    
    if ([self.redtype isEqualToString:@"2"]) {
        
        NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
        
        AppHttpClient *httpClient = [AppHttpClient sharedClient];
        
        NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                               memberId,@"Memberid",
                               self.getDate,@"TransactionDate",
                               nil];
        
        [SVProgressHUD showWithStatus:@"加载中..."];
        
        [httpClient request:@"MctRPMemMerchantPacket.ashx" parameters:param success:^(NSJSONSerialization* json) {
            
            BOOL success = [[json valueForKey:@"status"] boolValue];
            
            if (success) {
                
                [self.headview.iconImg setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[json valueForKey:@"MemLogo"]]] placeholderImage:[UIImage imageNamed:@""]];
                
                self.headview.nameLab.text = [NSString stringWithFormat:@"%@共领取",[NSString stringWithFormat:@"%@",[json valueForKey:@"Name"]]];
                
                self.headview.countLab.text = [NSString stringWithFormat:@"%@元",self.count];
                
                NSArray *array = [json valueForKey:@"ybtrList"];
                
                if (array.count != 0) {
                    
                    NSMutableArray *mutArr = [NSMutableArray array];
                    
                    for (NSDictionary *dd in array) {
                        
                        GetDetailModel *model = [[GetDetailModel alloc] init];
                        
                        model.Logo = [NSString stringWithFormat:@"%@",dd[@"Logo"]];
                        
                        model.MerchantName = [NSString stringWithFormat:@"%@",dd[@"MerchantName"]];
                        
                        model.TransactionDate = [NSString stringWithFormat:@"%@",dd[@"TransactionDate"]];
                        
                        model.MerchantID = [NSString stringWithFormat:@"%@",dd[@"MerchantID"]];
                        
                        model.Status = [NSString stringWithFormat:@"%@",dd[@"Status"]];
                        
                        model.Description = [NSString stringWithFormat:@"%@",dd[@"Description"]];
                        
                        model.TradingOperations = [NSString stringWithFormat:@"%@",dd[@"TradingOperations"]];
                        
                        model.TransactionType = [NSString stringWithFormat:@"%@",dd[@"TransactionType"]];
                        
                        model.Account = [NSString stringWithFormat:@"%@",dd[@"Account"]];
                        
                        model.MemberID = [NSString stringWithFormat:@"%@",dd[@"MemberID"]];
                        
                        GetDetailFrame *frame = [[GetDetailFrame alloc] init];
                        
                        frame.detailModel = model;
                        
                        [mutArr addObject:frame];
                        
                    }
                    
                    self.dataArray = mutArr;
                    
                }
                
                [SVProgressHUD dismiss];
                
                [self.tableview reloadData];
                
            } else {
                
                NSString *msg = [json valueForKey:@"msg"];
                
                [SVProgressHUD showErrorWithStatus:msg];
                
            }
            
        } failure:^(NSError *error) {
            
            [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
            
        }];
        
    }else {
        
        NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
        
        AppHttpClient *httpClient = [AppHttpClient sharedClient];
        
        NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                               memberId,@"Memberid",
                               self.getDate,@"TransactionDate",
                               nil];
        
        [SVProgressHUD showWithStatus:@"加载中..."];
        
        [httpClient request:@"FansMemMerchantPacket.ashx" parameters:param success:^(NSJSONSerialization* json) {
            
            BOOL success = [[json valueForKey:@"status"] boolValue];
            
            if (success) {
                
                [self.headview.iconImg setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[json valueForKey:@"MemLogo"]]] placeholderImage:[UIImage imageNamed:@""]];
                
                self.headview.nameLab.text = [NSString stringWithFormat:@"%@共领取",[NSString stringWithFormat:@"%@",[json valueForKey:@"Name"]]];
                
                self.headview.countLab.text = [NSString stringWithFormat:@"%@元",self.count];
                
                NSArray *array = [json valueForKey:@"ybtrList"];
                
                if (array.count != 0) {
                    
                    NSMutableArray *mutArr = [NSMutableArray array];
                    
                    for (NSDictionary *dd in array) {
                        
                        GetDetailModel *model = [[GetDetailModel alloc] init];
                        
                        model.Logo = [NSString stringWithFormat:@"%@",dd[@"Logo"]];
                        
                        model.MerchantName = [NSString stringWithFormat:@"%@",dd[@"MerchantName"]];
                        
                        model.TransactionDate = [NSString stringWithFormat:@"%@",dd[@"TransactionDate"]];
                        
                        model.MerchantID = [NSString stringWithFormat:@"%@",dd[@"MerchantID"]];
                        
                        model.Status = [NSString stringWithFormat:@"%@",dd[@"Status"]];
                        
                        model.Description = [NSString stringWithFormat:@"%@",dd[@"Description"]];
                        
                        model.TradingOperations = [NSString stringWithFormat:@"%@",dd[@"TradingOperations"]];
                        
                        model.TransactionType = [NSString stringWithFormat:@"%@",dd[@"TransactionType"]];
                        
                        model.Account = [NSString stringWithFormat:@"%@",dd[@"Account"]];
                        
                        model.MemberID = [NSString stringWithFormat:@"%@",dd[@"MemberID"]];
                        
                        GetDetailFrame *frame = [[GetDetailFrame alloc] init];
                        
                        frame.detailModel = model;
                        
                        [mutArr addObject:frame];
                        
                    }
                    
                    self.dataArray = mutArr;
                    
                }
                
                [SVProgressHUD dismiss];
                
                [self.tableview reloadData];
                
            } else {
                
                NSString *msg = [json valueForKey:@"msg"];
                
                [SVProgressHUD showErrorWithStatus:msg];
                
            }
            
        } failure:^(NSError *error) {
            
            [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
            
        }];
        
    }
    
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
