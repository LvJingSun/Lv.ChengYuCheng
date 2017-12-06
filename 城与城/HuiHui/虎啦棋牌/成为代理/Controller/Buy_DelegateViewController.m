//
//  Buy_DelegateViewController.m
//  HuiHui
//
//  Created by mac on 2017/11/15.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "Buy_DelegateViewController.h"
#import "LJConst.h"
#import "BuyDelegateModel.h"
#import "BuyDelegateFrame.h"
#import "BuyDelegateCell.h"
#import "WXApi.h"
#import "payRequsestHandler.h"

@interface Buy_DelegateViewController () <UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate> {
    
    NSString *orderID;
    
}

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation Buy_DelegateViewController

-(NSArray *)dataArray {
    
    if (_dataArray == nil) {
        
        BuyDelegateModel *model = [[BuyDelegateModel alloc] init];
        
        model.price = self.price;
        
        model.categoryId = self.categoryId;
        
        model.timeStatus = @"1";
        
        model.payStatus = @"1";
        
        if ([self.type isEqualToString:@"3"]) {
            
            model.allCount = [NSString stringWithFormat:@"%.2f",[model.price floatValue] * ([model.timeStatus floatValue] - 1) + [self.difference floatValue]];
            
        }else {
            
            model.allCount = [NSString stringWithFormat:@"%.2f",[model.price floatValue] * [model.timeStatus floatValue]];
            
        }
        
        BuyDelegateFrame *frame = [[BuyDelegateFrame alloc] init];
        
        frame.buyModel = model;
        
        NSMutableArray *mut = [NSMutableArray array];
        
        [mut addObject:frame];
        
        _dataArray = mut;
        
    }
    
    return _dataArray;
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];

    self.title = @"购买代理";
    
    [self allocWithTableview];
    
}

-(void)viewWillAppear:(BOOL)animated {
    
    // 添加微信支付成功的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(weixinpaySuccess) name:@"MenuPaySuccessKey" object:nil];
    
}

-(void)viewWillDisappear:(BOOL)animated {
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"MenuPaySuccessKey" object:nil];
    
}

- (void)allocWithTableview {
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, _WindowViewWidth, _WindowViewHeight - 64)];
    
    self.tableview = tableview;
    
    tableview.delegate = self;
    
    tableview.dataSource = self;
    
    tableview.backgroundColor = FSB_ViewBGCOLOR;
    
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:tableview];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BuyDelegateCell *cell = [[BuyDelegateCell alloc] init];
    
    BuyDelegateFrame *frame = self.dataArray[indexPath.row];
    
    cell.frameModel = frame;
    
    cell.oneBlock = ^{
        
        frame.buyModel.timeStatus = @"1";
        
        if ([self.type isEqualToString:@"3"]) {
            
            frame.buyModel.allCount = [NSString stringWithFormat:@"%.2f",[frame.buyModel.price floatValue] * ([frame.buyModel.timeStatus floatValue] - 1) + [self.difference floatValue]];
            
        }else {
            
            frame.buyModel.allCount = [NSString stringWithFormat:@"%.2f",[frame.buyModel.price floatValue] * [frame.buyModel.timeStatus floatValue]];
            
        }
        
        [tableView reloadData];
        
    };
    
    cell.twoBlock = ^{
        
        frame.buyModel.timeStatus = @"2";
        
        if ([self.type isEqualToString:@"3"]) {
            
            frame.buyModel.allCount = [NSString stringWithFormat:@"%.2f",[frame.buyModel.price floatValue] * ([frame.buyModel.timeStatus floatValue] - 1) + [self.difference floatValue]];
            
        }else {
            
            frame.buyModel.allCount = [NSString stringWithFormat:@"%.2f",[frame.buyModel.price floatValue] * [frame.buyModel.timeStatus floatValue]];
            
        }
        
        [tableView reloadData];
        
    };
    
    cell.threeBlock = ^{
        
        frame.buyModel.timeStatus = @"3";
        
        if ([self.type isEqualToString:@"3"]) {
            
            frame.buyModel.allCount = [NSString stringWithFormat:@"%.2f",[frame.buyModel.price floatValue] * ([frame.buyModel.timeStatus floatValue] - 1) + [self.difference floatValue]];
            
        }else {
            
            frame.buyModel.allCount = [NSString stringWithFormat:@"%.2f",[frame.buyModel.price floatValue] * [frame.buyModel.timeStatus floatValue]];
            
        }
        
        [tableView reloadData];
        
    };
    
    cell.cycBlock = ^{
        
        frame.buyModel.payStatus = @"1";
        
        [tableView reloadData];
        
    };
    
    cell.wxBlock = ^{
        
        frame.buyModel.payStatus = @"2";
        
        [tableView reloadData];
        
    };
    
    cell.zfbBlock = ^{
        
        frame.buyModel.payStatus = @"3";
        
        [tableView reloadData];
        
    };
    
    cell.sureBlock = ^{
        
        if ([frame.buyModel.payStatus isEqualToString:@"1"]) {
            
            //城与城支付
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"购买%@年代理资格，共计%@元，是否支付？",frame.buyModel.timeStatus,frame.buyModel.allCount] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"支付", nil];
            
            [alert show];
            
        }else if ([frame.buyModel.payStatus isEqualToString:@"2"]) {
            
            //微信支付生成订单
            [self creatOrder];
            
        }else if ([frame.buyModel.payStatus isEqualToString:@"3"]) {
            
            //支付宝支付
            
        }
        
    };
    
    return cell;
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    switch (buttonIndex) {
        case 1:
        {
            
            //城与城支付
            [self cyc_pay];
            
        }
            break;
            
        default:
            break;
    }
    
}

- (void)cyc_pay {
    
    BuyDelegateFrame *frame = self.dataArray[0];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         [CommonUtil getValueByKey:MEMBER_ID],@"MemberID",
                         frame.buyModel.price,@"Amount",
                         frame.buyModel.timeStatus,@"Count",
                         frame.buyModel.categoryId,@"categoryId",
                         self.type,@"type",
                         nil];
    
    AppHttpClient *httpclient = [AppHttpClient sharedHuLa];
    
    [SVProgressHUD show];
    
    [httpclient HuLarequest:@"Recharge_cyc_1.ashx" parameters:dic success:^(NSJSONSerialization *json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"%@",[json valueForKey:@"msg"]]];
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }else {
            
            [SVProgressHUD showSuccessWithStatus:[json valueForKey:@"msg"]];
            
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showSuccessWithStatus:@"购买失败，请稍后重试"];
        
    }];
    
}

- (void)creatOrder {
    
    BuyDelegateFrame *frame = self.dataArray[0];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         [CommonUtil getValueByKey:MEMBER_ID],@"MemberID",
                         frame.buyModel.price,@"Amount",
                         frame.buyModel.timeStatus,@"Count",
                         frame.buyModel.categoryId,@"categoryId",
                         self.type,@"type",
                         nil];
    
    AppHttpClient *httpclient = [AppHttpClient sharedHuLa];
    
    [SVProgressHUD show];
    
    [httpclient HuLarequest:@"Recharge_weixin_Order_1.ashx" parameters:dic success:^(NSJSONSerialization *json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            //生成订单成功，跳转微信支付
            orderID = [NSString stringWithFormat:@"%@",[json valueForKey:@"ordenumber"]];
            
            [self WeChatRechargeRequest];
            
            [SVProgressHUD dismiss];
            
        }else {
            
            [SVProgressHUD showSuccessWithStatus:[json valueForKey:@"msg"]];
            
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:@"生成订单失败，请稍后重试"];
        
    }];
    
}

//微信充值
- (void)WeChatRechargeRequest {
    
    BuyDelegateFrame *frame = self.dataArray[0];
    
    // 判断是否安装了微信
    if ( [WXApi isWXAppInstalled] ) {
        
        // 点击去支付后将数据保存起来用于微信支付的赋值
        [CommonUtil addValue:[NSString stringWithFormat:@"%@",@"购买代理"] andKey:WEIXIN_NAME];
        [CommonUtil addValue:frame.buyModel.allCount andKey:WEIXIN_PRICE];
        [CommonUtil addValue:orderID andKey:WEIXIN_OREDENO];
        
        // 表示是点单购买
        [CommonUtil addValue:@"3" andKey:WEIXIN_PAYTYPE];
        
        
        //创建支付签名对象
        payRequsestHandler *req = [payRequsestHandler alloc];
        //初始化支付签名对象
        [req init:APP_ID mch_id:MCH_ID];
        //设置密钥
        [req setKey:PARTNER_ID];
        
        //}}}
        
        //获取到实际调起微信支付的参数后，在app端调起支付
        NSMutableDictionary *dict = [req sendPay_demo];
        
        if(dict == nil){
            //错误提示
            NSString *debug = [req getDebugifo];
            
            [SVProgressHUD showErrorWithStatus:debug];
            
        }else{
            
            NSMutableString *stamp  = [dict objectForKey:@"timestamp"];
            
            //调起微信支付
            PayReq* req             = [[PayReq alloc] init];
            req.openID              = [dict objectForKey:@"appid"];
            req.partnerId           = [dict objectForKey:@"partnerid"];
            req.prepayId            = [dict objectForKey:@"prepayid"];
            req.nonceStr            = [dict objectForKey:@"noncestr"];
            req.timeStamp           = stamp.intValue;
            req.package             = [dict objectForKey:@"package"];
            req.sign                = [dict objectForKey:@"sign"];
            
            [WXApi sendReq:req];
        }
        
    }else{
        
        // 微信没有安装
        [SVProgressHUD showErrorWithStatus:@"您没有安装微信"];
        
    }
    
}

//充值成功确认订单
- (void)weixinpaySuccess {
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         [NSString stringWithFormat:@"%@",orderID],@"ordernumber",
                         nil];
    
    AppHttpClient *http = [AppHttpClient sharedHuLa];
    
    [http HuLarequest:@"Recharge_weixin_Order_OK_1.ashx" parameters:dic success:^(NSJSONSerialization *json) {
        
        if ([[json valueForKey:@"status"] boolValue]) {
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }
        
    } failure:^(NSError *error) {
        
    }];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BuyDelegateFrame *frame = self.dataArray[indexPath.row];
    
    return frame.height;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
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
