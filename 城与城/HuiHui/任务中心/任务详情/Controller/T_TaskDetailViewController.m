//
//  T_TaskDetailViewController.m
//  HuiHui
//
//  Created by mac on 2017/3/22.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "T_TaskDetailViewController.h"
//#import "T_Task.h"
//#import "T_TaskMember.h"
#import "T_Detail1Frame.h"
#import "T_Detail1Cell.h"
#import "T_Detail2Frame.h"
#import "T_Detail2Cell.h"

#import "TH_TaskModel.h"
#import "TH_TaskMemberModel.h"
#import "CommonUtil.h"
#import "AppHttpClient.h"
#import "SVProgressHUD.h"
#import "T_InvitationViewController.h"
#import "T_NewTask.h"

// 屏幕宽度
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)

// 屏幕高度
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define TabBGCOLOR [UIColor colorWithRed:244/255. green:244/255. blue:244/255. alpha:1.]
#define JinXingZhongColor [UIColor colorWithRed:69/255. green:191/255. blue:89/255. alpha:1.]
#define JuJueColor [UIColor colorWithRed:254/255. green:73/255. blue:63/255. alpha:1.]

@interface T_TaskDetailViewController () <UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, strong) NSArray *memberArray;

@end

@implementation T_TaskDetailViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"详情";
    
    [self initWithTableview];

}

- (void)initWithTableview {
    
    if ([self.th_taskmodel.IsFriendsTaskOrMyTask isEqualToString:@"0"]) {
        
        UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 124)];
        
        self.tableview = tableview;
        
        tableview.delegate = self;
        
        tableview.dataSource = self;
        
        tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        tableview.backgroundColor = TabBGCOLOR;
        
        [self.view addSubview:tableview];
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(tableview.frame), SCREEN_WIDTH, 60)];
        
        [btn setTitle:@"邀请好友" forState:0];
        
        [btn setTitleColor:JinXingZhongColor forState:0];
        
        btn.titleLabel.font = [UIFont systemFontOfSize:19];
        
        [btn addTarget:self action:@selector(YaoqingFriends) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:btn];
        
        [self requestMyTaskData];

    }else if ([self.th_taskmodel.IsFriendsTaskOrMyTask isEqualToString:@"1"]) {

        UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 124)];
        
        self.tableview = tableview;
        
        tableview.delegate = self;
        
        tableview.dataSource = self;
        
        tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        tableview.backgroundColor = TabBGCOLOR;
        
        [self.view addSubview:tableview];
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(tableview.frame), SCREEN_WIDTH, 60)];
        
        [btn setTitle:@"拒绝任务" forState:0];
        
        [btn setTitleColor:JuJueColor forState:0];
        
        btn.titleLabel.font = [UIFont systemFontOfSize:19];
        
        [btn addTarget:self action:@selector(JujueTaskClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:btn];
        
        [self requestFriendTaskData];
        
    }else {
    
        UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
        
        self.tableview = tableview;
        
        tableview.delegate = self;
        
        tableview.dataSource = self;
        
        tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        tableview.backgroundColor = TabBGCOLOR;
        
        [self.view addSubview:tableview];
        
    }

}

//邀请朋友
- (void)YaoqingFriends {
    
    T_NewTask *newtask = [[T_NewTask alloc] init];

    T_InvitationViewController *vc = [[T_InvitationViewController alloc] init];
    
    newtask.TaskID = [NSString stringWithFormat:@"%@",self.th_taskmodel.TaskType];
    
    vc.taskModel = newtask;
    
    vc.ReTaskID = self.th_taskmodel.ReTaskID;
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

//拒绝任务点击
- (void)JujueTaskClick {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"确定拒绝该任务？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    [alert show];
    
}

//拒绝任务请求
- (void)RefusedTask {
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];

    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           self.th_taskmodel.PsID,@"PsID",
                           memberId,@"Memberid",
                           nil];
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    [httpClient request:@"RefusedFriendTask.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showErrorWithStatus:msg];
            
            [self requestFriendTaskData];
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showErrorWithStatus:msg];
            
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {

    switch (buttonIndex) {
        case 1:
        {
        
            [self RefusedTask];
            
        }
            break;
            
        default:
            break;
    }
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section == 0) {
        
        return self.dataArray.count;
        
    }else {
    
        return self.memberArray.count;
        
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {
        
        T_Detail1Cell *cell = [[T_Detail1Cell alloc] init];
        
        T_Detail1Frame *frame = self.dataArray[indexPath.row];
        
        cell.frameModel = frame;
        
        return cell;
        
    }else {
    
        T_Detail2Cell *cell = [[T_Detail2Cell alloc] init];
        
        T_Detail2Frame *frame = self.memberArray[indexPath.row];
        
        cell.frameModel = frame;
        
        return cell;
        
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {
        
        T_Detail1Frame *frame = self.dataArray[indexPath.row];
        
        return frame.height;
        
    }else {
        
        T_Detail2Frame *frame = self.memberArray[indexPath.row];
        
        return frame.height;
        
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (void)requestFriendTaskData {
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           self.th_taskmodel.PsID,@"PsID",
                           nil];
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    [httpClient request:@"FriendsTaskDetails.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            NSMutableArray *mut = [NSMutableArray array];

            TH_TaskModel *task = [[TH_TaskModel alloc] init];
            
            task.IsFriendsTaskOrMyTask = @"1";
        
            task.PsID = [NSString stringWithFormat:@"%@",[json valueForKey:@"PsID"]];
            
            task.TaskName = [NSString stringWithFormat:@"%@",[json valueForKey:@"TaskName"]];
            
            task.RName = [NSString stringWithFormat:@"%@",[json valueForKey:@"RName"]];
            
            task.WhetherComplete = [NSString stringWithFormat:@"%@",[json valueForKey:@"WhetherComplete"]];
            
            task.WTime = [NSString stringWithFormat:@"%@",[json valueForKey:@"WTime"]];
            
            task.TaskBonuses = [NSString stringWithFormat:@"%@",[json valueForKey:@"TaskBonuses"]];
            
            T_Detail1Frame *frame = [[T_Detail1Frame alloc] init];
            
            frame.th_taskmodel = task;
            
            [mut addObject:frame];
            
            self.dataArray = mut;
            
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

- (void)requestMyTaskData {
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           self.th_taskmodel.ReTaskID,@"ReTaskID",
                           @"1",@"pageIndex",
                           nil];
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    [httpClient request:@"MyTaskFriendsList.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            NSMutableArray *mut = [NSMutableArray array];
            
            TH_TaskModel *task = [[TH_TaskModel alloc] init];
            
            task.IsFriendsTaskOrMyTask = @"0";
            
            task.ReTaskID = [NSString stringWithFormat:@"%@",[json valueForKey:@"ReTaskID"]];
            
            task.ReMemName = [NSString stringWithFormat:@"%@",[json valueForKey:@"ReMemName"]];
            
            task.ReleaseName = [NSString stringWithFormat:@"%@",[json valueForKey:@"ReleaseName"]];
            
            task.StatusIs = [NSString stringWithFormat:@"%@",[json valueForKey:@"StatusIs"]];
            
            task.ReTime = [NSString stringWithFormat:@"%@",[json valueForKey:@"ReTime"]];
            
            task.ReTaskAmount = [NSString stringWithFormat:@"%@",[json valueForKey:@"ReTaskAmount"]];
            
            T_Detail1Frame *frame = [[T_Detail1Frame alloc] init];
            
            frame.th_taskmodel = task;
            
            [mut addObject:frame];
            
            self.dataArray = mut;
            
            NSArray *array = [json valueForKey:@"ListFriend"];
            
            NSMutableArray *temp = [NSMutableArray array];
            
            for (NSDictionary *tt in array) {
                
                TH_TaskMemberModel *member = [[TH_TaskMemberModel alloc] initWithDict:tt];
                
                T_Detail2Frame *frame = [[T_Detail2Frame alloc] init];
                
                frame.th_memberModel = member;
                
                [temp addObject:frame];
                
            }
            
            self.memberArray = temp;
            
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
