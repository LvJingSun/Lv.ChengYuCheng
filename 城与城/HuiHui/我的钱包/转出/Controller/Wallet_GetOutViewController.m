//
//  Wallet_GetOutViewController.m
//  HuiHui
//
//  Created by mac on 2017/9/12.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "Wallet_GetOutViewController.h"
#import "RedHorseHeader.h"
#import "GetOut_TranModel.h"
#import "GetOut_TranFrame.h"
#import "GetOut_TranCell.h"
#import "GetOutSuccessViewController.h"
#import "LJConst.h"

@interface Wallet_GetOutViewController () <UITableViewDelegate,UITableViewDataSource,GetOutFieldDelegate>

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, weak) UIButton *sureBtn;

@end

@implementation Wallet_GetOutViewController

-(NSArray *)dataArray {

    if (_dataArray == nil) {
        
        GetOut_TranModel *model = [[GetOut_TranModel alloc] init];
        
        if ([self.viewType isEqualToString:@"Game"]) {
            
            model.notice = @"联城游戏资金转出至钱包不再收取费用。";
            
        }else {
        
            model.notice = @"资金转出至钱包将收取服务费，钱包内资金提现不收取费用，请对资金进行合理安排。";
            
        }
        
        model.xiane = [NSString stringWithFormat:@"%.2f",[self.getoutCount floatValue]];
        
        GetOut_TranFrame *frame = [[GetOut_TranFrame alloc] init];
        
        frame.tranmodel = model;
        
        NSMutableArray *mut = [NSMutableArray array];
        
        [mut addObject:frame];
        
        _dataArray = mut;
        
    }
    
    return _dataArray;
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.barTintColor = FSB_StyleCOLOR;
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:FSB_NAVFont,NSForegroundColorAttributeName:FSB_NAVTextColor}];
    
    self.title = @"转出到钱包";
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    self.view.backgroundColor = RH_ViewBGColor;
    
    [self allocWithTableview];
    
}

- (void)setLeftButtonWithNormalImage:(NSString *)aImageName action:(SEL)action{
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    [backButton setImage:[UIImage imageNamed:aImageName] forState:UIControlStateNormal];
    [backButton addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    [self.navigationItem setLeftBarButtonItem:backItem];
    
}

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

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    GetOut_TranCell *cell = [[GetOut_TranCell alloc] init];
    
    GetOut_TranFrame *frame = self.dataArray[indexPath.row];
    
    cell.frameModel = frame;
    
    cell.delegate = self;
    
    self.sureBtn = cell.sureBtn;
    
    cell.sureBlock = ^{
        
        if ([frame.tranmodel.count isEqualToString:@""] || [frame.tranmodel.count floatValue] == 0) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"请输入转出金额!"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            
            [alert show];
            
        }else if ([frame.tranmodel.count floatValue] > [frame.tranmodel.xiane floatValue]) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"你最多可转出%@元!",frame.tranmodel.xiane] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            
            [alert show];
            
        }else {
            
            self.sureBtn.userInteractionEnabled = NO;
        
            //转出
            
            if ([self.viewType isEqualToString:@"YCB"]) {
                
                //养车宝转出
                [self YCBMoneyGetOut];
                
            }else if ([self.viewType isEqualToString:@"FSB"]) {
            
                //粉丝宝转出
                [self FSBMoneyGetOut];
                
            }else if ([self.viewType isEqualToString:@"Game"]) {
                
                //游戏转出
                [self GAMEMoneyGetOut];
                
            }
            
        }
        
    };
    
    return cell;
    
}

//游戏资金转出
- (void)GAMEMoneyGetOut {
    
    NSString *count;
    
    for (GetOut_TranFrame *frame in self.dataArray) {
        
        count = frame.tranmodel.count;
        
    }
    
    if ([count floatValue] > [self.getoutCount floatValue]) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"你本次最多可转出%.2f元!",[self.getoutCount floatValue]] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        [alert show];
        
    }else {
        
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                             [CommonUtil getValueByKey:MEMBER_ID],@"MemberID",
                             count,@"Amount",
                             nil];
        
        AppHttpClient *httpclient = [AppHttpClient sharedClient];
        
        [SVProgressHUD show];
        
        [httpclient request:@"GameYueToMemAccount.ashx" parameters:dic success:^(NSJSONSerialization *json) {
            
            BOOL success = [[json valueForKey:@"status"] boolValue];
            
            if (success) {
                
                [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"%@",[json valueForKey:@"msg"]]];
                
                [self.navigationController popViewControllerAnimated:YES];
                
            }else {
                
                NSString *msg = [json valueForKey:@"msg"];
                
                [SVProgressHUD showErrorWithStatus:msg];
                
            }
            
            self.sureBtn.userInteractionEnabled = YES;
            
        } failure:^(NSError *error) {
            
            [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
            
            self.sureBtn.userInteractionEnabled = YES;
            
        }];
        
    }
    
}

//粉丝宝资金转出
- (void)FSBMoneyGetOut {
    
    NSString *count;
    
    for (GetOut_TranFrame *frame in self.dataArray) {
        
        count = frame.tranmodel.count;
        
    }
    
    if ([count floatValue] > [self.getoutCount floatValue]) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"你本次最多可转出%.2f元!",[self.getoutCount floatValue]] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        [alert show];
        
    }else {
        
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                             [CommonUtil getValueByKey:MEMBER_ID],@"MemberID",
                             count,@"Amount",
                             nil];
        
        AppHttpClient *httpclient = [AppHttpClient sharedClient];
        
        [SVProgressHUD show];
        
        [httpclient request:@"FansYueToMemAccount.ashx" parameters:dic success:^(NSJSONSerialization *json) {
            
            BOOL success = [[json valueForKey:@"status"] boolValue];
            
            if (success) {
                
                [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"%@",[json valueForKey:@"msg"]]];
                
                [self.navigationController popViewControllerAnimated:YES];
                
            }else {
                
                NSString *msg = [json valueForKey:@"msg"];
                
                [SVProgressHUD showErrorWithStatus:msg];
                
            }
            
            self.sureBtn.userInteractionEnabled = YES;
            
        } failure:^(NSError *error) {
            
            [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
            
            self.sureBtn.userInteractionEnabled = YES;
            
        }];
        
    }
    
}

//养车宝资金转出
- (void)YCBMoneyGetOut {
    
    NSString *count;
    
    for (GetOut_TranFrame *frame in self.dataArray) {
        
        count = frame.tranmodel.count;
        
    }
    
    if ([count floatValue] > [self.getoutCount floatValue]) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"你本次最多可转出%.2f元!",[self.getoutCount floatValue]] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        [alert show];
        
    }else {
    
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                             [CommonUtil getValueByKey:MEMBER_ID],@"MemberID",
                             count,@"Amount",
                             nil];
        
        AppHttpClient *httpclient = [AppHttpClient sharedRedHorse];
        
        [SVProgressHUD show];
        
        [httpclient horserequest:@"RHToMemAccount.ashx" parameters:dic success:^(NSJSONSerialization *json) {
            
            BOOL success = [[json valueForKey:@"status"] boolValue];
            
            if (success) {
                
                [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"%@",[json valueForKey:@"msg"]]];
                
                [self.navigationController popViewControllerAnimated:YES];
                
            }else {
            
                NSString *msg = [json valueForKey:@"msg"];
                
                [SVProgressHUD showErrorWithStatus:msg];
                
            }
            
            self.sureBtn.userInteractionEnabled = YES;
            
        } failure:^(NSError *error) {
            
            [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
            
            self.sureBtn.userInteractionEnabled = YES;
            
        }];
        
    }
    
}

- (void)CountFieldChange:(UITextField *)field {

    for (GetOut_TranFrame *frame in self.dataArray) {
        
        frame.tranmodel.count = [NSString stringWithFormat:@"%@",field.text];
        
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    GetOut_TranFrame *frame = self.dataArray[indexPath.row];
    
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
