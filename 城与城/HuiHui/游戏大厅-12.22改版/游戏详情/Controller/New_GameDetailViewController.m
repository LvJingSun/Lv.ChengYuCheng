//
//  New_GameDetailViewController.m
//  HuiHui
//
//  Created by mac on 2017/12/25.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "New_GameDetailViewController.h"
#import "LJConst.h"
#import "NewGameDetailModel.h"
#import "NewGameDetailFrame.h"
#import "NewGameDetailCell.h"
#import "New_HLRechargeViewController.h"
#import "ToMeViewController.h"
#import "HuLaHomeBindAlertView.h"

@interface New_GameDetailViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,GameIDFieldDelegate> {
    
    NSString *chooseID;
    
}

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, weak) HuLaHomeBindAlertView *alertView;

@end

@implementation New_GameDetailViewController

- (void)requestForData {
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         [CommonUtil getValueByKey:MEMBER_ID],@"memberId",
                         self.gameID,@"gameId",
                         nil];
    
    AppHttpClient *http = [AppHttpClient sharedHuLa];
    
    [SVProgressHUD show];
    
    [http HuLarequest:@"Game/Detail.ashx" parameters:dic success:^(NSJSONSerialization *json) {
        
        if ([[NSString stringWithFormat:@"%@",[json valueForKey:@"status"]] boolValue]) {
            
            NewGameDetailModel *model = [[NewGameDetailModel alloc] init];
            
            model.gameName = [NSString stringWithFormat:@"%@",[json valueForKey:@"gameName"]];
            
            model.iconUrl = [NSString stringWithFormat:@"%@",[json valueForKey:@"gameIcon"]];
            
            model.gameLink = [NSString stringWithFormat:@"%@",[json valueForKey:@"gameLink"]];
            
            model.type = [NSString stringWithFormat:@"%@",[json valueForKey:@"currencyName"]];
            
            model.userID = [NSString stringWithFormat:@"%@",[json valueForKey:@"gameId"]];
            
            model.total = [NSString stringWithFormat:@"%@",[json valueForKey:@"balance"]];
            
            model.desc = [NSString stringWithFormat:@"%@",[json valueForKey:@"walkthrough"]];
            
            model.gameID = [NSString stringWithFormat:@"%@",[json valueForKey:@"gameCategoryId"]];
            
            model.isBind = [[json valueForKey:@"IsBindGameId"] boolValue];
            
            NewGameDetailFrame *frame = [[NewGameDetailFrame alloc] init];
            
            frame.model = model;
            
            NSMutableArray *mut = [NSMutableArray array];
            
            [mut addObject:frame];
            
            self.dataArray = mut;
            
            [self.tableview reloadData];
            
            [SVProgressHUD dismiss];
            
        }else {
            
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",[json valueForKey:@"msg"]]];
            
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setTitle:@"虎啦棋牌"];
    
    self.view.backgroundColor = FSB_ViewBGCOLOR;
    
    [self allocWithTableview];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];

}

-(void)viewWillAppear:(BOOL)animated {
    
    [self requestForData];
    
}

- (void)allocWithTableview {
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, _WindowViewWidth, _WindowViewHeight - 64)];
    
    self.tableview = tableview;
    
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
    
    NewGameDetailFrame *frame = self.dataArray[indexPath.row];
    
    NewGameDetailCell *cell = [[NewGameDetailCell alloc] init];
    
    cell.frameModel = frame;
    
    cell.reloadBlock = ^{
        
        [tableView reloadData];
        
    };
    
    cell.rechargeBlock = ^{
        
        if (frame.model.isBind) {
            
            //充值点击
            New_HLRechargeViewController *vc = [[New_HLRechargeViewController alloc] init];
            
            vc.gameID = frame.model.gameID;
            
            vc.userID = frame.model.userID;
            
            vc.type = frame.model.type;
            
            [self.navigationController pushViewController:vc animated:YES];
            
        }else {
            
            [SVProgressHUD showErrorWithStatus:@"请先绑定游戏ID"];
            
        }
        
    };
    
    cell.sendBlock = ^{
        
        if (frame.model.isBind) {
        
            ToMeViewController *vc = [[ToMeViewController alloc] init];
            
            vc.gameTypeID = frame.model.gameID;
            
            vc.viewType = @"3";
            
            vc.rechargeType = frame.model.type;
            
            [self.navigationController pushViewController:vc animated:YES];
            
        }else {
            
            [SVProgressHUD showErrorWithStatus:@"请先绑定游戏ID"];
            
        }
        
    };
    
    cell.bindBlock = ^{
        
        //点击绑定ID
        HuLaHomeBindAlertView *alert = [[HuLaHomeBindAlertView alloc] init];
        
        self.alertView = alert;
        
        alert.delegate = self;
        
//        alert.IDfield.delegate = self;
        
        alert.bindClickBlock = ^{
            
            if (chooseID.length != 0) {
                
                [self BindGameID];
                
            }else {
                
                [SVProgressHUD showErrorWithStatus:@"请输入正确的游戏ID"];
                
            }
            
        };
        
        [alert showInView:[UIApplication sharedApplication].keyWindow];
        
    };
    
    cell.tiyanBlock = ^{
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:frame.model.gameLink]];
        
    };
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NewGameDetailFrame *frame = self.dataArray[indexPath.row];
    
    return frame.height;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

-(void)GameIDFieldChange:(UITextField *)field {
    
    [self checkForGameID:field.text];
    
}

////游戏ID输入9位自动检测
//#define myDotNumbers     @"0123456789"
//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
//
//    //输入字符限制
//    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:myDotNumbers]invertedSet];
//
//    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
//
//    if (filtered.length == 0 ) {
//        //支持删除键
//        if (textField.text.length ==7) {
//
//        }
//
//        return [string isEqualToString:@""];
//
//    }else if (textField.text.length ==6){
//
//        textField.text = [NSString stringWithFormat:@"%@%@",textField.text,string];
//
//        [self checkForGameID:[NSString stringWithFormat:@"%@",textField.text]];
//
//    }else if (string.length ==7)
//    {
//        textField.text = [NSString stringWithFormat:@"%@%@",textField.text,string];
//
//        [self checkForGameID:[NSString stringWithFormat:@"%@",textField.text]];
//
//    }
//
//    return YES;
//
//}

//检测游戏账号
- (void)checkForGameID:(NSString *)gameID {
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         [CommonUtil getValueByKey:MEMBER_ID],@"memberId",
                         gameID,@"gameid",
                         self.gameID,@"gameCategoryId",
                         nil];
    
    AppHttpClient *httpclient = [AppHttpClient sharedHuLa];
    
    [SVProgressHUD show];
    
    [httpclient HuLarequest:@"Game/CheckGameId.ashx" parameters:dic success:^(NSJSONSerialization *json) {
        
        [SVProgressHUD dismiss];
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            if ([self.alertView.IDfield isFirstResponder]) {
        
                [self.alertView.IDfield resignFirstResponder];
        
            }
            
            self.alertView.noticeLab.textColor = FSB_StyleCOLOR;
            
            self.alertView.noticeLab.text = [NSString stringWithFormat:@"%@",[json valueForKey:@"nickName"]];
            
            chooseID = gameID;
            
        }else {
            
            self.alertView.noticeLab.textColor = [UIColor redColor];
            
            self.alertView.noticeLab.text = [NSString stringWithFormat:@"%@",[json valueForKey:@"msg"]];
            
            chooseID = @"";
            
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD dismiss];
        
        self.alertView.noticeLab.textColor = [UIColor redColor];
        
        self.alertView.noticeLab.text = @"查询失败，请稍后再试！";
        
    }];
    
}

//绑定游戏账号
- (void)BindGameID {
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         [CommonUtil getValueByKey:MEMBER_ID],@"Memberid",
                         self.gameID,@"gameCategoryId",
                         chooseID,@"gameId",
                         nil];
    
    AppHttpClient *httpclient = [AppHttpClient sharedHuLa];
    
    [SVProgressHUD show];
    
    [httpclient HuLarequest:@"Game/BindGame.ashx" parameters:dic success:^(NSJSONSerialization *json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"%@",[json valueForKey:@"msg"]]];
            
            [self.alertView dismiss];
            
            [self requestForData];
            
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

}

@end
