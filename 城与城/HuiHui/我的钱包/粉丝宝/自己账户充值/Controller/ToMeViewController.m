//
//  ToMeViewController.m
//  HuiHui
//
//  Created by mac on 2017/10/16.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "ToMeViewController.h"
#import "RedHorseHeader.h"
#import "GameRechargeModel.h"
#import "GameRechargeFrame.h"
#import "GameRechargeCell.h"
#import "GetOutSuccessViewController.h"
#import "GameRechargeAlertView.h"
#import "NoticeAlertView.h"
#import "GameTranViewController.h"
#import "HL_RechargeSureOrderViewController.h"
#import "HL_RechargeOrderModel.h"

@interface ToMeViewController ()<UITableViewDelegate,UITableViewDataSource,GameRechargeDelegate,UITextFieldDelegate> {
    
    NSString *fsb_balance;
    
    NSString *cac_balance;
    
    NSString *zhekou;
    
    NSString *type; //1-粉丝宝余额 2-城与城余额
    
    NSString *needcount;
    
    NSString *requestType; //1-城与城元宝 2-粉丝宝元宝 3-城与城房卡 4-粉丝宝房卡
    
}

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, weak) GameRechargeAlertView *alert;

@property (nonatomic, weak) UILabel *noticeLab;

@end

@implementation ToMeViewController

-(NSArray *)dataArray {
    
    if (_dataArray == nil) {
        
        GameRechargeModel *model = [[GameRechargeModel alloc] init];
        
        model.rechargeType = self.rechargeType;
        
        model.notice = [NSString stringWithFormat:@"赠送%@给对方需消耗等额游戏币",self.rechargeType];
        
        model.viewType = self.viewType;
        
        GameRechargeFrame *frame = [[GameRechargeFrame alloc] init];
        
        frame.tranmodel = model;
        
        NSMutableArray *mut = [NSMutableArray array];
        
        [mut addObject:frame];
        
        _dataArray = mut;
        
    }
    
    return _dataArray;
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    if ([self.viewType isEqualToString:@"1"]) {
        
        [self setTitle:@"棋牌游戏充值"];
        
    }else if ([self.viewType isEqualToString:@"2"]) {
        
        [self setTitle:@"给他人充值"];
        
    }else if ([self.viewType isEqualToString:@"3"]) {
        
        [self setTitle:@"赠送"];
        
    }
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
//    [self setRightButtonWithTitle:@"记录" action:@selector(rightClicked)];
    
    self.view.backgroundColor = RH_ViewBGColor;
    
    [self allocWithTableview];
    
}

//- (void)rightClicked {
//
//    //记录按钮点击
//    GameTranViewController *vc = [[GameTranViewController alloc] init];
//
//    [self.navigationController pushViewController:vc animated:YES];
//
//}

- (BOOL)isNULLString:(NSString *)string {
    
    if (string == nil || string == NULL) {
        
        return YES;
        
    }
    
    if ([string isKindOfClass:[NSNull class]]) {
        
        return YES;
        
    }
    
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        
        return YES;
        
    }
    
    return NO;
    
}

////请求余额
//- (void)requestForBalance {
//
//    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
//                         [CommonUtil getValueByKey:MEMBER_ID],@"MemberID",
//                         nil];
//
//    AppHttpClient *httpclient = [AppHttpClient sharedClient];
//
//    [httpclient request:@"FansAccountInfo.ashx" parameters:dic success:^(NSJSONSerialization *json) {
//
//        BOOL success = [[json valueForKey:@"status"] boolValue];
//
//        if (success) {
//
//            fsb_balance = [NSString stringWithFormat:@"%@",[json valueForKey:@"FansBalance"]];
//
//            cac_balance = [NSString stringWithFormat:@"%@",[json valueForKey:@"AccountBalance"]];
//
//            zhekou = [NSString stringWithFormat:@"%@",[json valueForKey:@"dlzk"]];
//
//        }else {
//
//        }
//
//    } failure:^(NSError *error) {
//
//    }];
//
//}

- (void)allocWithTableview {
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64)];
    
    self.tableview = tableview;
    
    tableview.delegate = self;
    
    tableview.dataSource = self;
    
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    tableview.backgroundColor = RH_ViewBGColor;
    
    [self.view addSubview:tableview];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
    
}

////游戏ID输入7位自动检测
//#define myDotNumbers     @"0123456789"
//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
//
//    //输入字符限制
//    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:myDotNumbers]invertedSet];
//
//    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
//
//    if (filtered.length == 0) {
//
//        return YES;
//
//    }else {
//
//        if (textField.text.length + filtered.length == 7) {
//
//            [self checkGameNickWithID:[NSString stringWithFormat:@"%@%@",textField.text,filtered]];
//
//            return YES;
//
//        }else if (textField.text.length + filtered.length > 7) {
//
//            return NO;
//
//        }else {
//
//            return YES;
//
//        }
//
//    }
//
//}

- (void)checkGameNickWithID:(NSString *)ID {
    
    GameRechargeFrame *frame = self.dataArray[0];
    
    frame.tranmodel.qipaiID = ID;
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         ID,@"gameid",
                         nil];
    
    AppHttpClient *httpclient = [AppHttpClient sharedHuLa];
    
    [SVProgressHUD show];
    
    [httpclient HuLarequest:@"Bind_TestingNickName.ashx" parameters:dic success:^(NSJSONSerialization *json) {
        
        [SVProgressHUD dismiss];
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            GameRechargeFrame *frame = self.dataArray[0];
            
            frame.tranmodel.qipaiNick = [NSString stringWithFormat:@"%@",[json valueForKey:@"NickName"]];
            
            [self.tableview reloadData];
            
        }else {
            
//            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",[json valueForKey:@"msg"]]];
//
            frame.tranmodel.qipaiNick = [NSString stringWithFormat:@"%@",[json valueForKey:@"msg"]];
            
            self.noticeLab.text = [NSString stringWithFormat:@"%@",[json valueForKey:@"msg"]];
            
//            [self.tableview reloadData];
            
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:@"查询失败，请稍后再试！"];
        
    }];
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GameRechargeCell *cell = [[GameRechargeCell alloc] init];
    
    GameRechargeFrame *frame = self.dataArray[indexPath.row];
    
    cell.frameModel = frame;
    
    cell.delegate = self;
    
    self.noticeLab = cell.nickLab;
    
    cell.noticeBlock = ^{
        
        NoticeAlertView *alert = [[NoticeAlertView alloc] initWithImg:@"hulaid.png"];
        
        [alert showInView:[UIApplication sharedApplication].keyWindow];
        
    };
    
    cell.sureBlock = ^{
        
        if ([self isNULLString:frame.tranmodel.qipaiID]) {

            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"请输入ID"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];

            [alert show];

        }else if ([self isNULLString:frame.tranmodel.count]) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"请输入充值数量"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            
            [alert show];
            
        }else{
            
            [self requestForRecharge];

        }
        
    };
    
    return cell;
    
}

- (void)requestForRecharge {
    
    GameRechargeFrame *frame = self.dataArray[0];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         [CommonUtil getValueByKey:MEMBER_ID],@"memberId",
                         self.gameTypeID,@"gameCategoryId",
                         frame.tranmodel.count,@"count",
                         self.rechargeType,@"type",
                         frame.tranmodel.qipaiID,@"targetGameId",
                         nil];
    
    AppHttpClient *http = [AppHttpClient sharedHuLa];
    
    [SVProgressHUD showWithStatus:@"充值中..."];
    
    [http HuLarequest:@"Game/Recharge.ashx" parameters:dic success:^(NSJSONSerialization *json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"%@",[json valueForKey:@"msg"]]];
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }else {
            
            [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"%@",[json valueForKey:@"msg"]]];
            
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}


- (void)CountFieldChange:(UITextField *)field {
    
    for (GameRechargeFrame *frame in self.dataArray) {
        
        frame.tranmodel.count = [NSString stringWithFormat:@"%@",field.text];
        
    }
    
}

- (void)IDFieldChange:(UITextField *)field {
    
    [self checkGameNickWithID:field.text];
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GameRechargeFrame *frame = self.dataArray[indexPath.row];
    
    return frame.height;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (void)leftClicked {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self hideKeyboard];
    
}

- (void)hideKeyboard {
    
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}

@end
