//
//  T_FriendTasksViewController.m
//  HuiHui
//
//  Created by mac on 2017/3/22.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "T_FriendTasksViewController.h"
//#import "T_Task.h"
//#import "T_TaskFrame.h"
//#import "T_TaskListCell.h"
//#import "T_TaskMember.h"
#import "T_TaskDetailViewController.h"
#import "L_NoRecordCell.h"

#import "TH_TaskModel.h"
#import "TH_TaskCellFrameModel.h"
#import "TH_TaskCell.h"
#import "CommonUtil.h"
#import "AppHttpClient.h"
#import "SVProgressHUD.h"
#import <MJRefresh.h>

#define NAVBGCOLOR [UIColor colorWithRed:72/255.f green:162/255.f blue:245/255.f alpha:1.0]
#define TabBGCOLOR [UIColor colorWithRed:244/255. green:244/255. blue:244/255. alpha:1.]
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface T_FriendTasksViewController () <UITableViewDelegate,UITableViewDataSource> {
    
    NSInteger pageIndex;
    
}

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation T_FriendTasksViewController

//-(NSArray *)dataArray {
//    
//    if (_dataArray == nil) {
//        
//        NSString *path = [[NSBundle mainBundle] pathForResource:@"FriendTasks.plist" ofType:nil];
//        
//        NSArray *array = [NSArray arrayWithContentsOfFile:path];
//        
//        NSMutableArray *mut = [NSMutableArray array];
//        
//        for (NSDictionary *dd in array) {
//            
//            T_Task *task = [[T_Task alloc] initWithDict:dd];
//            
//            T_TaskFrame *frame = [[T_TaskFrame alloc] init];
//            
//            frame.taskmodel = task;
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
    
    pageIndex = 1;

    self.title = @"好友任务";
    
    [self initWithTableview];
    
    [self requestFriendsData];
    
}

- (void)initWithTableview {
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64)];
    
    self.tableview = tableview;
    
    tableview.delegate = self;
    
    tableview.dataSource = self;
    
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    tableview.backgroundColor = TabBGCOLOR;
    
    tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        pageIndex = 1;
        
        [self requestFriendsData];
        
    }];
    
    tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        pageIndex ++;
        
        [self requestFriendsData];
        
    }];
    
    [self.view addSubview:tableview];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.dataArray.count != 0) {
        
        return self.dataArray.count;
        
    }else {
        
        return 1;
        
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.dataArray.count != 0) {
        
//        T_TaskFrame *frame = self.dataArray[indexPath.row];
//        
//        T_TaskListCell *cell = [[T_TaskListCell alloc] init];
//        
//        cell.frameModel = frame;
//        
//        return cell;
        
        TH_TaskCellFrameModel *frame = self.dataArray[indexPath.row];
        
        TH_TaskCell *cell = [[TH_TaskCell alloc] init];
        
        cell.frameModel = frame;
        
        return cell;
        
    }else {
        
        L_NoRecordCell *cell = [[L_NoRecordCell alloc] init];
        
        return cell;
        
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.dataArray.count != 0) {
        
//        T_TaskFrame *frame = self.dataArray[indexPath.row];
//        
//        return frame.height;
        
        TH_TaskCellFrameModel *frame = self.dataArray[indexPath.row];
        
        return frame.height;
        
    }else {
        
        L_NoRecordCell *cell = [[L_NoRecordCell alloc] init];
        
        return cell.height;
        
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.dataArray.count != 0) {
        
//        T_TaskFrame *frame = self.dataArray[indexPath.row];
//        
//        T_TaskDetailViewController *vc = [[T_TaskDetailViewController alloc] init];
//        
//        vc.task = frame.taskmodel;
//        
//        [self.navigationController pushViewController:vc animated:YES];
        
        TH_TaskCellFrameModel *frame = self.dataArray[indexPath.row];
        
        T_TaskDetailViewController *vc = [[T_TaskDetailViewController alloc] init];
        
        vc.th_taskmodel = frame.taskmodel;
        
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
}

- (void)headAndFootEndRefreshing {
    
    [self.tableview.mj_header endRefreshing];
    
    [self.tableview.mj_footer endRefreshing];
    
}

- (void)requestFriendsData {
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"Memberid",
                           [NSString stringWithFormat:@"%ld",(long)pageIndex],@"pageIndex",
                           nil];
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    [httpClient request:@"FriendsTaskList.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            if (pageIndex == 1) {
            
                NSArray *arr = [json valueForKey:@"AcceptTaskListFr"];
                
                NSMutableArray *mut = [NSMutableArray array];
                
                for (NSDictionary *dd in arr) {
                    
                    TH_TaskModel *task = [[TH_TaskModel alloc] init];
                    
                    task.IsFriendsTaskOrMyTask = @"1";
                    
                    task.PsID = [NSString stringWithFormat:@"%@",dd[@"PsID"]];
                    
                    task.TaskName = [NSString stringWithFormat:@"%@",dd[@"TaskName"]];
                    
                    task.WTime = [NSString stringWithFormat:@"%@",dd[@"WTime"]];
                    
                    task.RName = [NSString stringWithFormat:@"%@",dd[@"RName"]];
                    
                    task.TaskBonuses = [NSString stringWithFormat:@"%@",dd[@"TaskBonuses"]];
                    
                    task.WhetherComplete = [NSString stringWithFormat:@"%@",dd[@"WhetherComplete"]];
                    
                    task.TaskType = [NSString stringWithFormat:@"%@",dd[@"TaskType"]];
                    
                    TH_TaskCellFrameModel *frame = [[TH_TaskCellFrameModel alloc] init];
                    
                    frame.taskmodel = task;
                    
                    [mut addObject:frame];
                    
                }
                
                self.dataArray = mut;
                
            }else {
            
                NSArray *arr = [json valueForKey:@"AcceptTaskListFr"];
                
                NSMutableArray *temp = [NSMutableArray arrayWithArray:self.dataArray];
                
                NSMutableArray *mut = [NSMutableArray array];
                
                for (NSDictionary *dd in arr) {
                    
                    TH_TaskModel *task = [[TH_TaskModel alloc] init];
                    
                    task.IsFriendsTaskOrMyTask = @"1";
                    
                    task.PsID = [NSString stringWithFormat:@"%@",dd[@"PsID"]];
                    
                    task.TaskName = [NSString stringWithFormat:@"%@",dd[@"TaskName"]];
                    
                    task.WTime = [NSString stringWithFormat:@"%@",dd[@"WTime"]];
                    
                    task.RName = [NSString stringWithFormat:@"%@",dd[@"RName"]];
                    
                    task.TaskBonuses = [NSString stringWithFormat:@"%@",dd[@"TaskBonuses"]];
                    
                    task.WhetherComplete = [NSString stringWithFormat:@"%@",dd[@"WhetherComplete"]];
                    
                    task.TaskType = [NSString stringWithFormat:@"%@",dd[@"TaskType"]];
                    
                    TH_TaskCellFrameModel *frame = [[TH_TaskCellFrameModel alloc] init];
                    
                    frame.taskmodel = task;
                    
                    [mut addObject:frame];
                    
                }
                
                if (mut.count != 0) {
                    
                    [temp addObjectsFromArray:mut];
                    
                }else {
                
                    if (pageIndex > 1) {
                        
                        pageIndex --;
                        
                    }
                    
                }
                
                self.dataArray = temp;
                
            }
            
            [SVProgressHUD dismiss];
            
            [self headAndFootEndRefreshing];
            
            [self.tableview reloadData];
            
        } else {
            
            if (pageIndex > 1) {
                
                pageIndex --;
                
            }
            
            [self headAndFootEndRefreshing];
            
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showErrorWithStatus:msg];
            
        }
        
    } failure:^(NSError *error) {
        
        if (pageIndex > 1) {
            
            pageIndex --;
            
        }
        
        [self headAndFootEndRefreshing];
        
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
