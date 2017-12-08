//
//  RechargeAmountViewController.m
//  baozhifu
//
//  Created by mac on 14-1-15.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "RechargeAmountViewController.h"

#import "SVProgressHUD.h"

#import "CommonUtil.h"

#import "AppHttpClient.h"

#import <AlipaySDK/AlipaySDK.h>

#import "RSADataSigner.h"

@interface RechargeAmountViewController () {
    
    //充值金额
    NSString *rechargeCount;
    
    //充值订单
    NSString *rechargeOrder;
    
}

@property (weak, nonatomic) IBOutlet UIView *m_titleView;

@property (weak, nonatomic) IBOutlet UIView *m_tempView;

@property (weak, nonatomic) IBOutlet UITextField *m_amountTextField;


// 充值按钮触发的事件
- (IBAction)rechargeClicked:(id)sender;


@end

@implementation RechargeAmountViewController

@synthesize keyShow;

@synthesize isCharge;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        isCharge = NO;
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    
    self.needDone = YES;
    
    keyShow = NO;
    
    [self setTitle:@"充值"];
    
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear: animated];
    
    self.isCharge = NO;

    [self hideTabBar:YES];
    
    // 添加微信支付成功的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(weixinpaySuccess) name:@"MenuPaySuccessKey" object:nil];

}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    if ( !self.isCharge ) {
        
        [self hideTabBar:NO];

    }
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"MenuPaySuccessKey" object:nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)leftClicked{
    
    [self goBack];
}

- (IBAction)rechargeClicked:(id)sender {
    
    [self.m_amountTextField resignFirstResponder];
    
    NSString *amountStr = self.m_amountTextField.text;
    
    if ( amountStr.length == 0 ) {
       
        [SVProgressHUD showErrorWithStatus:@"请输入充值金额"];
        return;
    }
    
    // 判断输入多个小数点的情况
    NSArray *array = [self.m_amountTextField.text componentsSeparatedByString:@"."];
    
    if ( array.count > 2 ) {
        
        [SVProgressHUD showErrorWithStatus:@"您输入的金额格式不对,请重新输入"];
        
        return;
    }
    
    
    CGFloat amount = [amountStr floatValue];
    
    if (amount < 1) {

        [SVProgressHUD showErrorWithStatus:@"充值金额不能小于1"];
        return;
    }
    
    [self recharge];
    
}

- (void)recharge {
    
    if ([self.payType isEqualToString:@"1"]) {
        
        // 连接银联
        [self requestRechargeSubmit];
        
    }else if ([self.payType isEqualToString:@"2"]) {
        
        //生成微信充值订单
        [self setUpWeChatOrder];
        
    }else if ([self.payType isEqualToString:@"3"]) {
        
        //支付宝充值
        [self CreatAliPayOrder];
        
    }
    
}

- (void)CreatAliPayOrder {
    
    AppHttpClient *http = [AppHttpClient sharedClient];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         [CommonUtil getValueByKey:MEMBER_ID],@"memberid",
                         [NSString stringWithFormat:@"%@",self.m_amountTextField.text],@"price",
                         nil];
    
    [SVProgressHUD show];
    
    [http request:@"AddMXOrder_ALiPay.ashx" parameters:dic success:^(NSJSONSerialization *json) {
        
        if ([[json valueForKey:@"status"] boolValue]) {
            
            [SVProgressHUD dismiss];
            
            [self AliPayWithString:[NSString stringWithFormat:@"%@",[json valueForKey:@"msg"]]];
            
        }else {
            
            [SVProgressHUD showErrorWithStatus:[json valueForKey:@"msg"]];
            
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

- (void)weixinpaySuccess {
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         [NSString stringWithFormat:@"'%@'",rechargeOrder],@"ordernumber",
                         nil];
    
    AppHttpClient *http = [AppHttpClient sharedClient];
    
    [http request:@"AddMX_Order_OK.ashx" parameters:dic success:^(NSJSONSerialization *json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }else {
            
        }
        
    } failure:^(NSError *error) {
        
    }];
    
}

//生成微信充值订单
- (void)setUpWeChatOrder {
    
    rechargeCount = [NSString stringWithFormat:@"%@",self.m_amountTextField.text];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         [CommonUtil getValueByKey:MEMBER_ID],@"memberid",
                         rechargeCount,@"Price", nil];
    
    AppHttpClient *http = [AppHttpClient sharedClient];
    
    [SVProgressHUD showWithStatus:@"订单生成中..."];
    
    [http request:@"AddMX_Order.ashx" parameters:dic success:^(NSJSONSerialization *json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            
            rechargeOrder = [NSString stringWithFormat:@"%@",[json valueForKey:@"ordenumber"]];
            
            [self WeChatRechargeRequest];
            
            [SVProgressHUD dismiss];
            
        } else {
            
            [SVProgressHUD showErrorWithStatus:@"订单生成失败，请稍后再试！"];
            
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:@"订单生成失败，请稍后再试！"];
        
    }];
    
}

//微信充值
- (void)WeChatRechargeRequest {
    
    // 判断是否安装了微信
    if ( [WXApi isWXAppInstalled] ) {
        
        // 点击去支付后将数据保存起来用于微信支付的赋值
        [CommonUtil addValue:[NSString stringWithFormat:@"%@",@"城与城余额充值"] andKey:WEIXIN_NAME];
        [CommonUtil addValue:rechargeCount andKey:WEIXIN_PRICE];
        [CommonUtil addValue:rechargeOrder andKey:WEIXIN_OREDENO];
        
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

// 请求充值的接口，请求服务器返回报文提交启动银联支付的插件
- (void)requestRechargeSubmit{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }

    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,     @"memberId",
                           key,   @"key",
                           self.m_amountTextField.text, @"amount",
                           nil];
    [SVProgressHUD showWithStatus:@"信息提交中"];
    [httpClient request:@"UnionMobileRecharge.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {

            self.isCharge = YES;
            
            NSString *respXml = [json valueForKey:@"respXml"];
            
            [SVProgressHUD dismiss];
            
            NSInteger type = [[json valueForKey:@"tranEnvironment"] integerValue];
            
            // 请求服务器成功后将报文提交银联插件 生产测试  0 生产 1 测试
            UIViewController *viewCtrl = nil;
            viewCtrl = [LTInterface getHomeViewControllerWithType:type strOrder:respXml andDelegate:self];
            
            if ( isIOS7 ) {
                
                [self.navigationController pushViewController:viewCtrl animated:NO];
                
            }else{
                
                [self.navigationController pushViewController:viewCtrl animated:YES];
                
            }
        
        } else {
            
            self.isCharge = NO;

            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showErrorWithStatus:msg];
            
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];
}

- (void)returnWithResult:(NSString *)strResult{
        
    // 有值则表示交易结果，若为空则用户未进行交易。
    if ( strResult == nil ) {
        
        [SVProgressHUD showErrorWithStatus:@"您取消了交易操作"];
        
    }else{
        
        // 0000 表示成功，其他表示失败
        NSRange range;
        
        range = [strResult rangeOfString:@"<respCode>0000</respCode>"];
        
        if ( range.location != NSNotFound ) {
            
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示"
                                                               message:@"您已成功充值，正常情况下即时到账，由于网络原因可能会有延时。"
                                                              delegate:self
                                                     cancelButtonTitle:@"确定"
                                                     otherButtonTitles: nil];
            
            alertView.tag = 11983;
            [alertView show];
            
        }else{
            
            
            [SVProgressHUD showErrorWithStatus:@"交易失败"];
            
        }

    }
    
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if ( alertView.tag == 11983 ) {
        if ( buttonIndex == 0 ) {
            
            [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:2] animated:YES];
        }
    }
    
}

// 完成按钮改为小数点
- (void)handleKeyboardWillHide:(NSNotification *)notification
{
    if (self.doneButton.superview)
    {
        [self.doneButton removeFromSuperview];
    }
    if (!keyShow) {
        return;
    }

    keyShow = NO;
}
- (void)handleKeyboardDidShow:(NSNotification *)notification
{
    // create custom button
    if (self.doneButton == nil)
    {
        self.doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;

        if ( screenHeight == 736.0f ) {
            
            self.doneButton.frame = CGRectMake(self.view.frame.origin.x, screenHeight - 57, WindowSizeWidth/3 - 2, 57);
            
        }else{
            
            self.doneButton.frame = CGRectMake(self.view.frame.origin.x, screenHeight - 53, WindowSizeWidth/3 - 2, 53);
            
        }
        
        self.doneButton.adjustsImageWhenHighlighted = NO;
        self.doneButton.hidden=self.needDone;
        [self.doneButton setBackgroundImage:[UIImage imageNamed:@"btn_done_normal.png"] forState:UIControlStateNormal];
        [self.doneButton setBackgroundImage:[UIImage imageNamed:@"btn_done_selected.png"] forState:UIControlStateHighlighted];
        [self.doneButton addTarget:self action:@selector(finishAction) forControlEvents:UIControlEventTouchUpInside];
    }
    
    // locate keyboard view
    UIWindow* tempWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:1];
    if (self.doneButton.superview == nil)
    {
        [tempWindow addSubview:self.doneButton];    // 注意这里直接加到window上
    }
    self.doneButton.hidden=self.needDone;
    if (keyShow) {
        return;
    }

    keyShow = YES;

}

- (void)finishAction
{
    self.m_amountTextField.text = [self.m_amountTextField.text stringByAppendingString:@"."];

}

- (IBAction)showKeyboard:(id)sender
{
    self.needDone = NO;
    self.doneButton.hidden = self.needDone;
}

- (IBAction)hideKeyboard:(id)sender
{
    self.needDone = YES;
    self.doneButton.hidden = self.needDone;
}

//UITextField的协议方法，当开始编辑时监听
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    self.doneButton.userInteractionEnabled = YES;
    
    [self showKeyboard:nil];
    
    return YES;
    
}


@end
