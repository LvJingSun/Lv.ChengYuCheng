//
//  HL_RechargeSureOrderViewController.m
//  HuiHui
//
//  Created by mac on 2017/12/20.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "HL_RechargeSureOrderViewController.h"
#import "LJConst.h"
#import "HL_RechargeOrderModel.h"
#import "HL_RechargeOrderFrame.h"
#import "HL_RechargeOrderCell.h"
#import "HL_PayMoneyView.h"
#import <AlipaySDK/AlipaySDK.h>

@interface HL_RechargeSureOrderViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, weak) HL_PayMoneyView *payMoneyView;

@end

@implementation HL_RechargeSureOrderViewController

-(NSArray *)dataArray {
    
    if (_dataArray == nil) {
        
        self.model.payType = @"1";
        
        HL_RechargeOrderFrame *frame = [[HL_RechargeOrderFrame alloc] init];
        
        frame.model = self.model;
        
        NSMutableArray *mut = [NSMutableArray array];
        
        [mut addObject:frame];
        
        _dataArray = mut;
        
    }
    
    return _dataArray;
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];

    [self setTitle:@"确认订单"];
    
    self.view.backgroundColor = FSB_ViewBGCOLOR;
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    [self allocWithTableview];
    
    // 添加微信支付成功的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(weixinpaySuccess) name:@"MenuPaySuccessKey" object:nil];
    
}

- (void)sureBuy {
    
    HL_RechargeOrderFrame *frame = self.dataArray[0];
    
    if ([frame.model.payType isEqualToString:@"1"]) {
        
        //支付宝支付
        [self creatZFB_Order];
        
    }else if ([frame.model.payType isEqualToString:@"2"]) {
        
        //微信支付
        [self creatWX_Order];
        
    }else if ([frame.model.payType isEqualToString:@"3"]) {
        
        //城与城余额支付
        [self CYC_BalanceBuy];
        
    }else if ([frame.model.payType isEqualToString:@"4"]) {
        
        //粉丝宝红包支付
        [self FSB_BalanceBuy];
        
    }
    
}

//请求微信拼接字符串
- (void)creatWX_Order {
    
    HL_RechargeOrderFrame *frame = self.dataArray[0];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         [CommonUtil getValueByKey:MEMBER_ID],@"memberId",
                         frame.model.OrderID,@"orderNumber",
                         nil];
    
    [SVProgressHUD show];
    
    AppHttpClient *http = [AppHttpClient sharedHuLa];
    
    [http HuLarequest:@"Recharge/Pay_WeChatPay.ashx" parameters:dic success:^(NSJSONSerialization *json) {
        
        if ([[NSString stringWithFormat:@"%@",[json valueForKey:@"status"]] boolValue]) {
            
            [SVProgressHUD dismiss];
            
            NSDictionary *dd = [json valueForKey:@"strJson"];
            
            PayReq *req = [[PayReq alloc] init];
            
            req.openID = [NSString stringWithFormat:@"%@",dd[@"appId"]];
            
            req.partnerId = [NSString stringWithFormat:@"%@",dd[@"paternerId"]];
            
            req.prepayId = [NSString stringWithFormat:@"%@",dd[@"prepayId"]];
            
            req.nonceStr = [NSString stringWithFormat:@"%@",dd[@"nonceStr"]];
            
            req.timeStamp = [[NSString stringWithFormat:@"%@",dd[@"timeStamp"]] intValue];
            
            req.package = [NSString stringWithFormat:@"%@",dd[@"package"]];
            
            req.sign = [NSString stringWithFormat:@"%@",dd[@"sign"]];
            
            [WXApi sendReq:req];
            
        }else {
            
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",[json valueForKey:@"msg"]]];
            
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:@"生成微信订单失败，请稍后再试！"];
        
    }];
    
}

//微信支付成功回调
- (void)weixinpaySuccess {
    
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
    
}

//请求支付宝拼接字符串
- (void)creatZFB_Order {
    
    HL_RechargeOrderFrame *frame = self.dataArray[0];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         [CommonUtil getValueByKey:MEMBER_ID],@"memberId",
                         frame.model.OrderID,@"orderNumber",
                         nil];
    
    [SVProgressHUD show];
    
    AppHttpClient *http = [AppHttpClient sharedHuLa];
    
    [http HuLarequest:@"Recharge/Pay_ALiPay.ashx" parameters:dic success:^(NSJSONSerialization *json) {
        
        if ([[NSString stringWithFormat:@"%@",[json valueForKey:@"status"]] boolValue]) {
            
            [SVProgressHUD dismiss];
            
            NSString *key = [NSString stringWithFormat:@"%@",[json valueForKey:@"msg"]];
            
            [self AliPayWithString:key];
            
        }else {
            
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",[json valueForKey:@"msg"]]];
            
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:@"生成支付宝订单失败，请稍后再试！"];
        
    }];
    
}

//调起支付宝进行支付
- (void)AliPayWithString:(NSString *)string {
    
    NSString *appScheme = @"huihuiAliPay";
    
    [[AlipaySDK defaultService] payOrder:string fromScheme:appScheme callback:^(NSDictionary *resultDic) {
        
        NSString *code = resultDic[@"resultStatus"];
        
        if ([code isEqualToString:@"9000"]) {
            
            //支付成功
            [SVProgressHUD showSuccessWithStatus:@"充值成功"];
            
            [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
            
        }else if ([code isEqualToString:@"4000"]) {
            
            //支付失败
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"支付失败，请稍后再试!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            
            [alert show];
            
        }else if ([code isEqualToString:@"6001"]) {
            
            //取消支付
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"你已取消支付!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            
            [alert show];
            
        }else if ([code isEqualToString:@"6002"]) {
            
            //网络连接失败
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"网络连接失败，请稍后再试!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            
            [alert show];
            
        }else if ([code isEqualToString:@"8000"]) {
            
            //订单处理中
            [SVProgressHUD showSuccessWithStatus:@"订单处理中"];
            
            [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
            
        }else {
            
            //其他情况
            [SVProgressHUD showErrorWithStatus:@"充值失败，请稍后再试！"];
            
        }
        
    }];
    
}


//粉丝宝红包支付
- (void)FSB_BalanceBuy {
    
    HL_RechargeOrderFrame *frame = self.dataArray[0];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         [CommonUtil getValueByKey:MEMBER_ID],@"memberId",
                         frame.model.OrderID,@"orderNumber",
                         nil];
    
    [SVProgressHUD showWithStatus:@"支付中.."];
    
    AppHttpClient *http = [AppHttpClient sharedHuLa];
    
    [http HuLarequest:@"Recharge/Pay_Fans.ashx" parameters:dic success:^(NSJSONSerialization *json) {
        
        if ([[NSString stringWithFormat:@"%@",[json valueForKey:@"status"]] boolValue]) {
            
            [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"%@",[json valueForKey:@"msg"]]];
            
            [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
            
        }else {
            
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",[json valueForKey:@"msg"]]];
            
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:@"支付失败，请稍后再试！"];
        
    }];
    
}

//城与城余额支付
- (void)CYC_BalanceBuy {
    
    HL_RechargeOrderFrame *frame = self.dataArray[0];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         [CommonUtil getValueByKey:MEMBER_ID],@"memberId",
                         frame.model.OrderID,@"orderNumber",
                         nil];
    
    [SVProgressHUD showWithStatus:@"支付中.."];
    
    AppHttpClient *http = [AppHttpClient sharedHuLa];
    
    [http HuLarequest:@"Recharge/Pay_CYC.ashx" parameters:dic success:^(NSJSONSerialization *json) {
        
        if ([[NSString stringWithFormat:@"%@",[json valueForKey:@"status"]] boolValue]) {
            
            [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"%@",[json valueForKey:@"msg"]]];
            
            [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
            
        }else {
            
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",[json valueForKey:@"msg"]]];
            
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:@"支付失败，请稍后再试！"];
        
    }];
    
}

- (void)allocWithTableview {
    
    HL_PayMoneyView *moneyView = [[HL_PayMoneyView alloc] initWithFrame:CGRectMake(0, _WindowViewHeight - 64 - 50, _WindowViewWidth, 50)];
    
    self.payMoneyView = moneyView;
    
    moneyView.moneyLab.text = [NSString stringWithFormat:@"实付:¥%@",self.model.Total];
    
    moneyView.sureBlock = ^{
        
        [self sureBuy];
        
    };
    
    [self.view addSubview:moneyView];
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, _WindowViewWidth, _WindowViewHeight - 64 - 50)];
    
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
    
    HL_RechargeOrderFrame *frame = self.dataArray[indexPath.row];
    
    HL_RechargeOrderCell *cell = [[HL_RechargeOrderCell alloc] init];
    
    cell.frameModel = frame;
    
    cell.zfbBlock = ^{
        
        frame.model.payType = @"1";
        
        [tableView reloadData];
        
    };
    
    cell.wxBlock = ^{
        
        frame.model.payType = @"2";
        
        [tableView reloadData];
        
    };
    
    cell.cycBlock = ^{
        
        frame.model.payType = @"3";
        
        [tableView reloadData];
        
    };
    
    cell.fsbBlock = ^{
        
        frame.model.payType = @"4";
        
        [tableView reloadData];
        
    };
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HL_RechargeOrderFrame *frame = self.dataArray[indexPath.row];
    
    return frame.height;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
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
