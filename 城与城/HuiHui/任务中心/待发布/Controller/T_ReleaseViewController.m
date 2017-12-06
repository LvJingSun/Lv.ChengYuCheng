//
//  T_ReleaseViewController.m
//  HuiHui
//
//  Created by mac on 2017/3/22.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "T_ReleaseViewController.h"
#import "T_ReleaseHeadView.h"
#import "T_NewTaskFrame.h"
#import "T_NewTask.h"
#import "T_NewTaskCell.h"
#import "T_InvitationViewController.h"
//#import "T_CommissionViewController.h"

#import "CommonUtil.h"
#import "AppHttpClient.h"
#import "SVProgressHUD.h"

#define TabBGCOLOR [UIColor colorWithRed:244/255. green:244/255. blue:244/255. alpha:1.]
#define SureColor [UIColor colorWithRed:255/255. green:100/255. blue:0/255. alpha:1.]
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface T_ReleaseViewController () <UITableViewDelegate,UITableViewDataSource> {

    T_NewTask *theNewTask;
    
}

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, weak) UILabel *countLab;

@end

@implementation T_ReleaseViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"任务列表";
    
    [self initWithTableview];
    
    [self requestTaskData];
    
}

- (void)initWithTableview {
    
    T_ReleaseHeadView *headview = [[T_ReleaseHeadView alloc] init];
    
    headview.frame = CGRectMake(0, 0, SCREEN_WIDTH, headview.height);
    
    self.countLab = headview.countLab;
    
    headview.countLab.text = [NSString stringWithFormat:@"%@",self.count];
    
    [self.view addSubview:headview];
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(headview.frame), SCREEN_WIDTH, SCREEN_HEIGHT - 124 - headview.frame.size.height)];
    
    self.tableview = tableview;
    
    tableview.delegate = self;
    
    tableview.dataSource = self;
    
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    tableview.backgroundColor = TabBGCOLOR;
    
    [self.view addSubview:tableview];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(tableview.frame), SCREEN_WIDTH, 60)];
    
    [btn setTitle:@"发布任务" forState:0];
    
    [btn setTitleColor:SureColor forState:0];
    
    btn.titleLabel.font = [UIFont systemFontOfSize:19];
    
    [btn addTarget:self action:@selector(ReleaseClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    T_NewTaskFrame *frame = self.dataArray[indexPath.row];
    
    T_NewTaskCell *cell = [[T_NewTaskCell alloc] init];
    
    cell.frameModel = frame;
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    T_NewTaskFrame *frame = self.dataArray[indexPath.row];
    
    return frame.height;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    T_NewTaskFrame *T_frame = self.dataArray[indexPath.row];
    
    for (T_NewTaskFrame *frame in self.dataArray) {
        
        T_NewTask *task = frame.taskModel;
        
        if ([frame isEqual:T_frame]) {
            
            if (!task.isChoose) {
                
                task.isChoose = YES;
                
            }
            
        }else {
        
            task.isChoose = NO;
            
        }
        
    }
    
    [tableView reloadData];
    
}

//发布任务按钮点击
- (void)ReleaseClick {
    
    BOOL isTask = NO;

    for (T_NewTaskFrame *frame in self.dataArray) {
    
        if (frame.taskModel.isChoose) {
            
            isTask = frame.taskModel.isChoose;
            
            theNewTask = frame.taskModel;
            
        }
        
    }
    
    if (isTask) {
        
//        T_CommissionViewController *vc = [[T_CommissionViewController alloc] init];
        
        T_InvitationViewController *vc = [[T_InvitationViewController alloc] init];
        
        vc.taskModel = theNewTask;
        
        vc.ReTaskID = @"0";
        
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
}

- (void)requestTaskData {
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];

    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"memberId",
                           nil];
    
    [httpClient request:@"TaskInfoList.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            NSArray *arr = [json valueForKey:@"ListTask"];
            
            NSMutableArray *mut = [NSMutableArray array];
            
            for (NSDictionary *dd in arr) {
                
                T_NewTask *task = [[T_NewTask alloc] initWithDict:dd];
                
                task.isChoose = NO;
                
                T_NewTaskFrame *frame = [[T_NewTaskFrame alloc] init];
                
                frame.taskModel = task;
                
                [mut addObject:frame];
                
            }
            
            self.dataArray = mut;
            
            [self.tableview reloadData];
            
        } else {
            
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
