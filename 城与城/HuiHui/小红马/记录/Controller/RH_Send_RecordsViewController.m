//
//  RH_Send_RecordsViewController.m
//  HuiHui
//
//  Created by mac on 2017/8/4.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "RH_Send_RecordsViewController.h"
#import "RedHorseHeader.h"
#import "RH_Get_RecordModel.h"
#import "RH_Get_RecordFrame.h"
#import "RH_Get_RecordCell.h"
#import "RH_GetHeadView.h"

@interface RH_Send_RecordsViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, strong) NSArray *array;

@property (nonatomic, weak) RH_GetHeadView *headview;

@end

@implementation RH_Send_RecordsViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self initWithTableview];

}

-(void)viewWillAppear:(BOOL)animated {

    [self requestForData];
    
}

- (void)initWithTableview {
    
    RH_GetHeadView *headview = [[RH_GetHeadView alloc] init];
    
    headview.frame = CGRectMake(0, 0, ScreenWidth, headview.height);
    
    headview.titleLab.text = @"累计补贴(元)";
    
    self.headview = headview;
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64 - 40)];
    
    self.tableview = tableview;
    
    tableview.tableHeaderView = headview;
    
    tableview.delegate = self;
    
    tableview.dataSource = self;
    
    tableview.backgroundColor = RH_ViewBGColor;
    
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:tableview];

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.array.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    RH_Get_RecordCell *cell = [[RH_Get_RecordCell alloc] init];
    
    RH_Get_RecordFrame *frame = self.array[indexPath.row];
    
    cell.frameModel = frame;
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    RH_Get_RecordFrame *frame = self.array[indexPath.row];
    
    return frame.height;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (void)requestForData {

    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         [CommonUtil getValueByKey:MEMBER_ID],@"MemberID",
                         nil];
    
    AppHttpClient* httpClient = [AppHttpClient sharedRedHorse];
    
    [httpClient horserequest:@"RedGetMoneyBT.ashx" parameters:dic success:^(NSJSONSerialization *json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            self.headview.countLab.text = [NSString stringWithFormat:@"%@",[json valueForKey:@"SumMoney"]];
            
            NSArray *arr = [json valueForKey:@"ybtrList"];
            
            NSMutableArray *mut = [NSMutableArray array];
            
            for (NSDictionary *dd in arr) {
                
                RH_Get_RecordModel *model = [[RH_Get_RecordModel alloc] initWithDict:dd];
                
                RH_Get_RecordFrame *frame = [[RH_Get_RecordFrame alloc] init];
                
                frame.getModel = model;
                
                [mut addObject:frame];
                
            }
            
            self.array = mut;
            
            [self.tableview reloadData];
            
        }else {
            
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showErrorWithStatus:msg];
            
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];

}

@end
