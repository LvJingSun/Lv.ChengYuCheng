//
//  RH_AllRedViewController.m
//  HuiHui
//
//  Created by mac on 2017/8/22.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "RH_AllRedViewController.h"
#import "RedHorseHeader.h"
#import "RH_Send_RecordModel.h"
#import "RH_Send_RecordFrame.h"
#import "RH_Send_RecordCell.h"
#import "RH_GetHeadView.h"

@interface RH_AllRedViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, strong) NSArray *array;

@property (nonatomic, weak) RH_GetHeadView *headview;

@end

@implementation RH_AllRedViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"总红包";
    
    self.navigationItem.leftBarButtonItem = [self SetNavigationBarImage:@"RH_HomeBack.png" andaction:@selector(dismissRH_Homeview)];
    
    [self initWithTableview];
    
    [self requestForData];
    
}

- (void)dismissRH_Homeview {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)initWithTableview {
    
    RH_GetHeadView *headview = [[RH_GetHeadView alloc] init];
    
    headview.frame = CGRectMake(0, 0, ScreenWidth, headview.height);
    
    headview.titleLab.text = @"累计红包(元)";
    
    self.headview = headview;
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64)];
    
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
    
    RH_Send_RecordCell *cell = [[RH_Send_RecordCell alloc] init];
    
    RH_Send_RecordFrame *frame = self.array[indexPath.row];
    
    cell.frameModel = frame;
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RH_Send_RecordFrame *frame = self.array[indexPath.row];
    
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
    
    [httpClient horserequest:@"RedMemTran.ashx" parameters:dic success:^(NSJSONSerialization *json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            self.headview.countLab.text = [NSString stringWithFormat:@"%@",[json valueForKey:@"SumMoney"]];
            
            NSArray *arr = [json valueForKey:@"ybtrList"];
            
            NSMutableArray *mut = [NSMutableArray array];
            
            for (NSDictionary *dd in arr) {
                
                RH_Send_RecordModel *model = [[RH_Send_RecordModel alloc] initWithDict:dd];
                
                RH_Send_RecordFrame *frame = [[RH_Send_RecordFrame alloc] init];
                
                frame.listModel = model;
                
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
