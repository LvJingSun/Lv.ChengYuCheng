//
//  Game_MyTeamViewController.m
//  HuiHui
//
//  Created by mac on 2017/12/22.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "Game_MyTeamViewController.h"
#import "LJConst.h"
#import "H_MyTeamModel.h"
#import "H_MyTeamFrame.h"
#import "H_MyTeamCell.h"
#import "H_MyTeamHeadCell.h"
#import "H_MyTeamHeadModel.h"
#import "H_MyTeamHeadFrame.h"
#import "H_MyTeamCountView.h"
#import "HL_NoDataCell.h"
#import "H_MyTeamHeadView.h"

@interface Game_MyTeamViewController ()<UITableViewDelegate,UITableViewDataSource> {
    
    NSString *level;//0-全部 1-一级 2-二级 3-三级
    
}

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, strong) NSArray *myteamHeadArray;

@property (nonatomic, strong) NSArray *myteamArray;

@property (nonatomic, weak) H_MyTeamHeadView *headView;

//@property (nonatomic, weak) H_MyTeamCountView *oneView;
//
//@property (nonatomic, weak) H_MyTeamCountView *twoView;
//
//@property (nonatomic, weak) H_MyTeamCountView *threeView;
//
//@property (nonatomic, weak) H_MyTeamCountView *fourView;

@end

@implementation Game_MyTeamViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    [self setTitle:@"我的团队"];
    
    level = @"0";
    
    self.view.backgroundColor = FSB_ViewBGCOLOR;
    
    [self allocWithTableview];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    [self myTeamRequest];
    
}

- (void)allocWithTableview {
    
    H_MyTeamHeadView *headview = [[H_MyTeamHeadView alloc] init];
    
    headview.frame = CGRectMake(0, 0, _WindowViewWidth, headview.height);
    
    self.headView = headview;
    
    headview.oneBlock = ^{
        
        level = @"0";
        
        [self myTeamRequest];
        
    };
    
    headview.twoBlock = ^{
        
        level = @"1";
        
        [self myTeamRequest];
        
    };
    
    headview.threeBlock = ^{
        
        level = @"2";
        
        [self myTeamRequest];
        
    };
    
    headview.fourBlock = ^{
        
        level = @"3";
        
        [self myTeamRequest];
        
    };
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, _WindowViewWidth, _WindowViewHeight - 64)];
    
    self.tableview = tableview;
    
    tableview.tableHeaderView = headview;
    
    tableview.delegate = self;
    
    tableview.dataSource = self;
    
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    tableview.backgroundColor = FSB_ViewBGCOLOR;
    
    [self.view addSubview:tableview];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    //我的团队
    if (self.myteamArray.count == 0) {

        return 1;

    }else {

        return self.myteamArray.count;

    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    if (indexPath.row == 0) {
//
//        H_MyTeamHeadCell *cell = [[H_MyTeamHeadCell alloc] init];
//
//        H_MyTeamHeadFrame *frame = self.myteamHeadArray[indexPath.row];
//
//        cell.frameModel = frame;
//
//        cell.oneBlock = ^{
//
//            level = @"0";
//
//            [self myTeamRequest];
//
//        };
//
//        cell.twoBlock = ^{
//
//            level = @"1";
//
//            [self myTeamRequest];
//
//        };
//
//        cell.threeBlock = ^{
//
//            level = @"2";
//
//            [self myTeamRequest];
//
//        };
//
//        cell.fourBlock = ^{
//
//            level = @"3";
//
//            [self myTeamRequest];
//
//        };
//
//        return cell;
//
//    }else {
    
        if (self.myteamArray.count == 0) {
            
            HL_NoDataCell *cell = [[HL_NoDataCell alloc] init];
            
            return cell;
            
        }else {
            
            H_MyTeamCell *cell = [[H_MyTeamCell alloc] init];
            
            H_MyTeamFrame *frame = self.myteamArray[indexPath.row];
            
            cell.frameModel = frame;
            
            return cell;
            
        }
        
//    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//
//    if (indexPath.row == 0) {
//
//        H_MyTeamHeadFrame *frame = self.myteamHeadArray[indexPath.row];
//
//        return frame.height;
//
//    }else {
    
        if (self.myteamArray.count == 0) {
            
            HL_NoDataCell *cell = [[HL_NoDataCell alloc] init];
            
            return cell.height;
            
        }else {
            
            H_MyTeamFrame *frame = self.myteamArray[indexPath.row];
            
            return frame.height;
            
        }
        
//    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

//请求我的团队
- (void)myTeamRequest {
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         [CommonUtil getValueByKey:MEMBER_ID],@"memberId",
                         level,@"type",
                         nil];
    
    AppHttpClient *http = [AppHttpClient sharedHuLa];
    
    [http HuLarequest:@"Mine/Team.ashx" parameters:dic success:^(NSJSONSerialization *json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            self.headView.oneView.contentLab.text = [NSString stringWithFormat:@"%@",[json valueForKey:@"quanbu"]];
            
            self.headView.twoView.contentLab.text = [NSString stringWithFormat:@"%@",[json valueForKey:@"zhijie"]];
            
            self.headView.threeView.contentLab.text = [NSString stringWithFormat:@"%@",[json valueForKey:@"jianjie"]];
            
            self.headView.fourView.contentLab.text = [NSString stringWithFormat:@"%@",[json valueForKey:@"sanji"]];
            
            NSMutableArray *mut = [NSMutableArray array];
            
            NSArray *arr = [json valueForKey:@"ailist"];
            
            for (NSDictionary *dd in arr) {
                
                H_MyTeamModel *model = [[H_MyTeamModel alloc] init];
                
                model.name = [NSString stringWithFormat:@"%@",dd[@"name"]];
                
                model.level = [NSString stringWithFormat:@"%@",dd[@"daili"]];
                
                model.delegateCount = [NSString stringWithFormat:@"%@",dd[@"daili_num"]];
                
                model.memberCount = [NSString stringWithFormat:@"%@",dd[@"total_shouyi"]];
                
                H_MyTeamFrame *frame = [[H_MyTeamFrame alloc] init];
                
                frame.model = model;
                
                [mut addObject:frame];
                
            }
            
            self.myteamArray = mut;
            
            [self.tableview reloadData];
            
        }else {
            
            [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"%@",[json valueForKey:@"msg"]]];
            
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}

- (void)leftClicked {
    
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
