//
//  Wallet_GAMERechargeViewController.m
//  HuiHui
//
//  Created by mac on 2017/9/14.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "Wallet_GAMERechargeViewController.h"
#import "RedHorseHeader.h"
#import "GetOut_TranModel.h"
#import "GAME_RechargeFrame.h"
#import "GAME_RechargeCell.h"
#import "GetOutSuccessViewController.h"
#import "LJConst.h"
#import "HL_Recharge_Sure_OrderViewController.h"
#import "HL_Recharge_Sure_OrderModel.h"

@interface Wallet_GAMERechargeViewController ()<UITableViewDelegate,UITableViewDataSource,RechargeFieldDelegate>

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, weak) UITableView *tableview;

@end

@implementation Wallet_GAMERechargeViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.barTintColor = FSB_StyleCOLOR;
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:FSB_NAVFont,NSForegroundColorAttributeName:FSB_NAVTextColor}];
    
    self.title = @"充值";
    
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

-(void)viewWillAppear:(BOOL)animated {

    [self requestForBalance];
    
}

- (void)requestForBalance {

    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         [CommonUtil getValueByKey:MEMBER_ID],@"MemberID",
                         nil];
    
    AppHttpClient *httpclient = [AppHttpClient sharedClient];
    
    [httpclient request:@"MyGaneYueInfo.ashx" parameters:dic success:^(NSJSONSerialization *json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            GetOut_TranModel *model = [[GetOut_TranModel alloc] init];
            
            model.xiane = self.balance;
            
            model.notice = [NSString stringWithFormat:@"%@",[json valueForKey:@"Desc"]];
            
            GAME_RechargeFrame *frame = [[GAME_RechargeFrame alloc] init];
            
            frame.tranmodel = model;
            
            NSMutableArray *mut = [NSMutableArray array];
            
            [mut addObject:frame];
            
            self.dataArray = mut;
            
            [self.tableview reloadData];
            
        }else {
        
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showErrorWithStatus:msg];
            
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}

//下单
- (void)creatOrder {
    
    GAME_RechargeFrame *frame = self.dataArray[0];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         [CommonUtil getValueByKey:MEMBER_ID],@"memberId",
                         frame.tranmodel.count,@"count",
                         nil];
    
    AppHttpClient *httpclient = [AppHttpClient sharedHuLa];
    
    [SVProgressHUD show];
    
    [httpclient HuLarequest:@"GameAccount/AddOrder.ashx" parameters:dic success:^(NSJSONSerialization *json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            [SVProgressHUD dismiss];
            
            HL_Recharge_Sure_OrderModel *model = [[HL_Recharge_Sure_OrderModel alloc] init];
            
            model.OrderID = [NSString stringWithFormat:@"%@",[json valueForKey:@"orderNumber"]];
            
            model.OrderTitle = [NSString stringWithFormat:@"%@",[json valueForKey:@"orderSubject"]];
            
            model.OriginalPrice = [NSString stringWithFormat:@"%@",[json valueForKey:@"originalUnitPrice"]];
            
            model.PresentPrice = [NSString stringWithFormat:@"%@",[json valueForKey:@"unitPrice"]];
            
            model.Count = [NSString stringWithFormat:@"%@",[json valueForKey:@"count"]];
            
            model.Discount = [NSString stringWithFormat:@"%@",[json valueForKey:@"dkPrice"]];
            
            model.Total = [NSString stringWithFormat:@"%@",[json valueForKey:@"orderPrice"]];
            
            HL_Recharge_Sure_OrderViewController *vc = [[HL_Recharge_Sure_OrderViewController alloc] init];
            
            vc.model = model;
            
            [self.navigationController pushViewController:vc animated:YES];
            
        }else {
            
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showErrorWithStatus:msg];
            
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
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
    
    GAME_RechargeCell *cell = [[GAME_RechargeCell alloc] init];
    
    GAME_RechargeFrame *frame = self.dataArray[indexPath.row];
    
    cell.frameModel = frame;
    
    cell.delegate = self;
    
    cell.sureBlock = ^{
        
        if ([frame.tranmodel.count floatValue] <= 0) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"请输入正确的充值金额"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            
            [alert show];
            
        }else {
            
            //充值
            [self creatOrder];
            
        }
        
    };
    
    return cell;
    
}

- (void)CountFieldChange:(UITextField *)field {
    
    for (GAME_RechargeFrame *frame in self.dataArray) {
        
        frame.tranmodel.count = [NSString stringWithFormat:@"%@",field.text];
        
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GAME_RechargeFrame *frame = self.dataArray[indexPath.row];
    
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
