//
//  TaskHomeViewController.m
//  HuiHui
//
//  Created by mac on 2017/3/21.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "TaskHomeViewController.h"
#import "T_HomeTableHeadView.h"
#import "T_BtnView.h"
//#import "T_Task.h"
//#import "T_TaskFrame.h"
//#import "T_TaskListCell.h"
//#import "T_TaskMember.h"
#import "T_TaskDetailViewController.h"
#import "T_MyTasksViewController.h"
#import "T_FriendTasksViewController.h"
#import "T_ReleaseViewController.h"

#import "T_NewTask.h"
#import "T_InvitationViewController.h"

#import "TH_TaskModel.h"
#import "TH_TaskCellFrameModel.h"
#import "TH_TaskCell.h"
#import "CommonUtil.h"
#import "AppHttpClient.h"
#import "SVProgressHUD.h"
#import <MJRefresh.h>
#import "UIImageView+AFNetworking.h"

#define NAVBGCOLOR [UIColor colorWithRed:72/255.f green:162/255.f blue:245/255.f alpha:1.0]
#define TabBGCOLOR [UIColor colorWithRed:244/255. green:244/255. blue:244/255. alpha:1.]
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface TaskHomeViewController () <UITableViewDelegate,UITableViewDataSource,TaskCellDelegate> {
    
    NSInteger pageIndex;
    
}

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, weak) UIImageView *iconImageview;

@property (nonatomic, weak) UILabel *nameLab;

@property (nonatomic, weak) UILabel *countLab;

@property (nonatomic, strong) T_BtnView *DFB_Btn;

@property (nonatomic, strong) T_BtnView *MY_Btn;

@property (nonatomic, strong) T_BtnView *FRIEND_Btn;

@end

@implementation TaskHomeViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    pageIndex = 1;

    self.title = @"任务中心";
    
    [self initWithTableview];
    
}

-(void)viewWillAppear:(BOOL)animated {

    [self requestFriendsData];
    
    [self requestForAllData];
    
}

- (void)initWithTableview {
    
    UIView *header = [[UIView alloc] init];
    
    header.backgroundColor = NAVBGCOLOR;
    
    header.frame = CGRectMake(0, -SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64)];
    
    self.tableview = tableview;
    
    [tableview addSubview:header];
    
    tableview.delegate = self;
    
    tableview.dataSource = self;
    
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    T_HomeTableHeadView *view = [[T_HomeTableHeadView alloc] init];
    
    view.frame = CGRectMake(0, 0, SCREEN_WIDTH, view.height);
    
    self.iconImageview = view.iconImageview;
    
    self.nameLab = view.nameLab;
    
    self.countLab = view.countLab;
    
    self.DFB_Btn = view.DFB_Btn;
    
    self.MY_Btn = view.MY_Btn;
    
    self.FRIEND_Btn = view.FRIEND_Btn;
    
    [view.MY_Btn.clickBtn addTarget:self action:@selector(MyTaskClick) forControlEvents:UIControlEventTouchUpInside];
    
    [view.FRIEND_Btn.clickBtn addTarget:self action:@selector(FriendTaskClick) forControlEvents:UIControlEventTouchUpInside];
    
    [view.DFB_Btn.clickBtn addTarget:self action:@selector(ReleaseClick) forControlEvents:UIControlEventTouchUpInside];
    
    tableview.tableHeaderView = view;
    
    tableview.backgroundColor = TabBGCOLOR;
    
    tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        pageIndex = 1;
        
        [self requestFriendsData];
        
    }];
    
    tableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        pageIndex ++;
        
        [self requestFriendsData];
        
    }];
    
    [self.view addSubview:tableview];
    
}

- (void)requestForAllData {

    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"Memberid",
                           nil];
    
    [httpClient request:@"TaskPageHomeInfo.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            [self.iconImageview setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[json valueForKey:@"MemPhoto"]]] placeholderImage:[UIImage imageNamed:@""]];
            
            self.nameLab.text = [NSString stringWithFormat:@"%@",[json valueForKey:@"MemName"]];
            
            self.countLab.text = [NSString stringWithFormat:@"  今日收益%@",[json valueForKey:@"TodayRebate"]];
            
            self.DFB_Btn.countLab.text = [NSString stringWithFormat:@"%@",[json valueForKey:@"ReTaskMoney"]];
            
            self.MY_Btn.countLab.text = [NSString stringWithFormat:@"%@",[json valueForKey:@"MyTaskNumP"]];
            
            self.FRIEND_Btn.countLab.text = [NSString stringWithFormat:@"%@",[json valueForKey:@"FriendsTaskNum"]];
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showErrorWithStatus:msg];
            
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}

//我的任务按钮点击
- (void)MyTaskClick {

    T_MyTasksViewController *vc = [[T_MyTasksViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

//好友任务按钮点击
- (void)FriendTaskClick {

    T_FriendTasksViewController *vc = [[T_FriendTasksViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

//待发布按钮点击
- (void)ReleaseClick {

    T_ReleaseViewController *vc = [[T_ReleaseViewController alloc] init];
    
    vc.count = [NSString stringWithFormat:@"%@",self.DFB_Btn.countLab.text];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TH_TaskCellFrameModel *frame = self.dataArray[indexPath.row];

    TH_TaskCell *cell = [[TH_TaskCell alloc] init];
    
    cell.delegate = self;
    
    cell.frameModel = frame;
    
    return cell;
    
}

- (void)addBtnClick:(UIButton *)sender {

    NSIndexPath *indexPath;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        
        indexPath = [self.tableview indexPathForCell:(TH_TaskCell *)[sender superview]];
        
    }else {
        
        indexPath = [self.tableview indexPathForCell:(TH_TaskCell *)[[sender superview] superview]];
    }
    
    TH_TaskCellFrameModel *frame = self.dataArray[indexPath.row];
    
    TH_TaskModel *model = frame.taskmodel;
    
    T_NewTask *newtask = [[T_NewTask alloc] init];
    
    T_InvitationViewController *vc = [[T_InvitationViewController alloc] init];
    
    newtask.TaskID = [NSString stringWithFormat:@"%@",model.TaskType];
    
    vc.taskModel = newtask;
    
    vc.ReTaskID = model.ReTaskID;
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    TH_TaskCellFrameModel *frame = self.dataArray[indexPath.row];
    
    return frame.height;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    TH_TaskCellFrameModel *frame = self.dataArray[indexPath.row];
    
    T_TaskDetailViewController *vc = [[T_TaskDetailViewController alloc] init];
    
    vc.th_taskmodel = frame.taskmodel;
    
    [self.navigationController pushViewController:vc animated:YES];
    
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
    
    [httpClient request:@"MyTaskInfoAndFriendsTask_New.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            if (pageIndex == 1) {
                
                NSArray *arr = [json valueForKey:@"MyReTaskInfoListTwo"];
                
                NSMutableArray *mut = [NSMutableArray array];
                
                for (NSDictionary *dd in arr) {
                    
                    TH_TaskModel *task = [[TH_TaskModel alloc] initWithDict:dd];
                    
                    TH_TaskCellFrameModel *frame = [[TH_TaskCellFrameModel alloc] init];
                    
                    frame.taskmodel = task;
                    
                    [mut addObject:frame];
                    
                }
                
                self.dataArray = mut;
                
            }else {
            
                NSArray *arr = [json valueForKey:@"MyReTaskInfoListTwo"];
                
                NSMutableArray *temp = [NSMutableArray arrayWithArray:self.dataArray];
                
                NSMutableArray *mut = [NSMutableArray array];
                
                for (NSDictionary *dd in arr) {
                    
                    TH_TaskModel *task = [[TH_TaskModel alloc] initWithDict:dd];
                    
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
