//
//  Game_MyCommisionViewController.m
//  HuiHui
//
//  Created by mac on 2017/12/22.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "Game_MyCommisionViewController.h"
#import "H_MyMoneyModel.h"
#import "H_MyMoneyFrame.h"
#import "H_MyMoneyCell.h"
#import "H_MyMoneyHeadCell.h"
#import "LJConst.h"
#import "HL_NoDataCell.h"

@interface Game_MyCommisionViewController ()<UITableViewDelegate,UITableViewDataSource> {
    
    NSString *money_type; //1-今日提成 2-近三月提成
    
}

@property (nonatomic, weak) UITableView *tableivew;

@property (nonatomic, strong) NSArray *mymoneyArray;

@end

@implementation Game_MyCommisionViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    [self setTitle:@"我的佣金"];
    
    money_type = @"1";
    
    [self requestForMoney];
    
    [self allocWithTableview];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
}

- (void)allocWithTableview {
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, _WindowViewWidth, _WindowViewHeight - 64)];
    
    self.tableivew = tableview;
    
    tableview.delegate = self;
    
    tableview.dataSource = self;
    
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    tableview.backgroundColor = FSB_ViewBGCOLOR;
    
    [self.view addSubview:tableview];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    //我的佣金
    if (self.mymoneyArray.count == 0) {
        
        return 2;
        
    }else {
        
        return self.mymoneyArray.count + 1;
        
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        
        H_MyMoneyHeadCell *cell = [[H_MyMoneyHeadCell alloc] init];
        
        cell.selectIndex = money_type;
        
        cell.changeBlock = ^(NSInteger i) {
            
            switch (i) {
                case 0:
                {
                    
                    money_type = @"1";
                    
                    [self requestForMoney];
                    
                }
                    break;
                    
                case 1:
                {
                    
                    money_type = @"2";
                    
                    [self requestForMoney];
                    
                }
                    break;
                    
                default:
                    break;
            }
            
        };
        
        return cell;
        
    }else {
        
        if (self.mymoneyArray.count == 0) {
            
            HL_NoDataCell *cell = [[HL_NoDataCell alloc] init];
            
            return cell;
            
        }else {
            
            H_MyMoneyCell *cell = [[H_MyMoneyCell alloc] init];
            
            H_MyMoneyFrame *frame = self.mymoneyArray[indexPath.row - 1];
            
            cell.frameModel = frame;
            
            return cell;
            
        }
        
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        
        H_MyMoneyHeadCell *cell = [[H_MyMoneyHeadCell alloc] init];
        
        return cell.height;
        
    }else {
        
        if (self.mymoneyArray.count == 0) {
            
            HL_NoDataCell *cell = [[HL_NoDataCell alloc] init];
            
            return cell.height;
            
        }else {
            
            H_MyMoneyFrame *frame = self.mymoneyArray[indexPath.row - 1];
            
            return frame.height;
            
        }
        
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

//获取我的佣金数据
- (void)requestForMoney {
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         [CommonUtil getValueByKey:MEMBER_ID],@"memberid",
                         money_type,@"typeid",
                         nil];
    
    AppHttpClient *httpclient = [AppHttpClient sharedHuLa];
    
    [httpclient HuLarequest:@"GetMyCommission.ashx" parameters:dic success:^(NSJSONSerialization *json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            NSMutableArray *mut = [NSMutableArray array];
            
            NSArray *arr = [json valueForKey:@"lm"];
            
            for (NSDictionary *dd in arr) {
                
                H_MyMoneyModel *model = [[H_MyMoneyModel alloc] init];
                
                model.name = [NSString stringWithFormat:@"%@",dd[@"NickName"]];
                
                model.ID = [NSString stringWithFormat:@"%@",dd[@"GameID"]];
                
                model.count = [NSString stringWithFormat:@"%@",dd[@"Price"]];
                
                model.status = [NSString stringWithFormat:@"%@",dd[@"StyleName"]];
                
                model.source = [NSString stringWithFormat:@"%@",dd[@"RechargeType"]];
                
                H_MyMoneyFrame *frame = [[H_MyMoneyFrame alloc] init];
                
                frame.model = model;
                
                [mut addObject:frame];
                
            }
            
            self.mymoneyArray = mut;
            
            [self.tableivew reloadData];
            
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
