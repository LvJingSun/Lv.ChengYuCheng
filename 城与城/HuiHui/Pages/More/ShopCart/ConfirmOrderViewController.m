//
//  ConfirmOrderViewController.m
//  HuiHui
//
//  Created by mac on 13-11-25.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import "ConfirmOrderViewController.h"

#import "ConfirmOrderCell.h"

#import "RechargeViewController.h"

#import <QuartzCore/QuartzCore.h>

#import "CommonUtil.h"

#import "SVProgressHUD.h"

#import "AppHttpClient.h"

#import "PayStyleViewController.h"

#import "PaymentQueViewController.h"

#import "ForgetPswdViewController.h"

#import "AlipayViewController.h"

@interface ConfirmOrderViewController ()

@property (weak, nonatomic) IBOutlet UITableView *m_tableView;

@property (strong, nonatomic) IBOutlet UIView *m_footerView;

@property (weak, nonatomic) IBOutlet UILabel *m_intergationLabel;

@property (weak, nonatomic) IBOutlet UIView *m_totalView;

@property (weak, nonatomic) IBOutlet UILabel *m_totalPrice;

@property (weak, nonatomic) IBOutlet UIView *m_baozhifuView;

@property (weak, nonatomic) IBOutlet UILabel *m_baozhifuPrice;

@property (weak, nonatomic) IBOutlet UIButton *m_chooseBtn;

@property (weak, nonatomic) IBOutlet UIButton *m_chongzhiBtn;

@property (weak, nonatomic) IBOutlet UILabel *m_needPayLabel;

@property (weak, nonatomic) IBOutlet UIView *m_intergationView;

@property (weak, nonatomic) IBOutlet UILabel *m_ActualPay;

@property (weak, nonatomic) IBOutlet UIView *m_paymentView;

@property (weak, nonatomic) IBOutlet UITextField *m_passWordTextField;

@property (weak, nonatomic) IBOutlet UIButton *m_makeSure;

@property (weak, nonatomic) IBOutlet UIButton *m_yinlianBtn;

@property (weak, nonatomic) IBOutlet UIButton *m_huihuiBtn;

@property (weak, nonatomic) IBOutlet UIView *m_zhifubaoView;

@property (weak, nonatomic) IBOutlet UILabel *m_yueLabel;

@property (weak, nonatomic) IBOutlet UIButton *m_zhifubaoBtn;

@property (weak, nonatomic) IBOutlet UIButton *m_zYinlianBtn;

@property (weak, nonatomic) IBOutlet UIButton *m_zHuihuiBtn;

@property (weak, nonatomic) IBOutlet UIButton *m_zWeixinBtn;

@property (weak, nonatomic) IBOutlet UIButton *m_weixinBtn;

@property (weak, nonatomic) IBOutlet UIButton *m_zHuahuaBtn;

@property (weak, nonatomic) IBOutlet UIButton *m_HuahuaBtn;

// 选择保智付的余额
- (IBAction)btnChoose:(id)sender;
// 充值按钮触发的事件
- (IBAction)RechargeClicked:(id)sender;

// 确认购买按钮触发的事件
- (IBAction)makeBuy:(id)sender;
// 选择支付方式
- (IBAction)choosePayType:(id)sender;
// 忘记支付密码
- (IBAction)forgetPassword:(id)sender;

@end

@implementation ConfirmOrderViewController

@synthesize m_productList;

@synthesize isSelectedBalance;

@synthesize m_countDictionary;

@synthesize m_items;

@synthesize m_payTypeString;

@synthesize isCharge;

@synthesize m_zhifubao;

@synthesize m_type;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        m_productList = [[NSMutableArray alloc]initWithCapacity:0];
        
        isSelectedBalance = YES;
        
        m_countDictionary = [[NSMutableDictionary alloc]initWithCapacity:0];
        
        m_items =  [[NSMutableDictionary alloc]initWithCapacity:0];
        
        m_payTypeString = @"";
        
        isCharge = NO;
        
        m_type = @"";
        
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
        
    if ( [self.m_typeString isEqualToString:@"1"] ) {
        
        [self.m_makeSure setTitle:@"确认购买" forState:UIControlStateNormal];
        
        [self setTitle:@"订单确认"];

        
    }else{
        
        [self.m_makeSure setTitle:@"确认付款" forState:UIControlStateNormal];
        
        [self setTitle:@"付款"];

    }
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];

    // 设置tableView的footerView
    self.m_tableView.tableFooterView = self.m_footerView;
    
    // 设置view的边框颜色和圆角
    self.m_totalView.layer.borderWidth = 1.0;
    self.m_totalView.layer.borderColor = [UIColor colorWithRed:215/255.0 green:215/255.0 blue:215/255.0 alpha:1.0].CGColor;
    self.m_totalView.layer.cornerRadius = 5.0;

   
    self.m_intergationView.layer.borderWidth = 1.0;
    self.m_intergationView.layer.borderColor = [UIColor colorWithRed:215/255.0 green:215/255.0 blue:215/255.0 alpha:1.0].CGColor;
    self.m_intergationView.layer.cornerRadius = 5.0;
    
    self.m_paymentView.layer.borderWidth = 1.0;
    self.m_paymentView.layer.borderColor = [UIColor colorWithRed:215/255.0 green:215/255.0 blue:215/255.0 alpha:1.0].CGColor;
    self.m_paymentView.layer.cornerRadius = 5.0;
    
    // 隐藏tableView
    self.m_tableView.hidden = YES;
    
    self.m_zhifubao = @"0";
    
    // 判断是否支持支付宝支付
    if ( [self.m_zhifubao isEqualToString:@"1"] ) {
        
        self.m_baozhifuView.hidden = YES;
        
        self.m_zhifubaoView.hidden = NO;
        
        // 支付宝
        self.m_zhifubaoView.layer.borderWidth = 1.0;
        self.m_zhifubaoView.layer.borderColor = [UIColor colorWithRed:215/255.0 green:215/255.0 blue:215/255.0 alpha:1.0].CGColor;
        self.m_zhifubaoView.layer.cornerRadius = 5.0;
        
        // 设置坐标
        self.m_intergationView.frame = CGRectMake(self.m_intergationView.frame.origin.x,self.m_zhifubaoView.frame.origin.y + self.m_zhifubaoView.frame.size.height + 10, self.m_intergationView.frame.size.width, self.m_intergationView.frame.size.height);
        
         self.m_paymentView.frame = CGRectMake(self.m_paymentView.frame.origin.x,self.m_intergationView.frame.origin.y + self.m_intergationView.frame.size.height + 10, self.m_paymentView.frame.size.width, self.m_paymentView.frame.size.height);
        
        
    }else{
        
        self.m_baozhifuView.hidden = NO;
        
        self.m_zhifubaoView.hidden = YES;
        
        self.m_baozhifuView.layer.borderWidth = 1.0;
        self.m_baozhifuView.layer.borderColor = [UIColor colorWithRed:215/255.0 green:215/255.0 blue:215/255.0 alpha:1.0].CGColor;
        self.m_baozhifuView.layer.cornerRadius = 5.0;
        
        
        // 设置坐标
        self.m_intergationView.frame = CGRectMake(self.m_intergationView.frame.origin.x,self.m_baozhifuView.frame.origin.y + self.m_baozhifuView.frame.size.height + 10, self.m_intergationView.frame.size.width, self.m_intergationView.frame.size.height);
        
        self.m_paymentView.frame = CGRectMake(self.m_paymentView.frame.origin.x,self.m_intergationView.frame.origin.y + self.m_intergationView.frame.size.height + 10, self.m_paymentView.frame.size.width, self.m_paymentView.frame.size.height);
        
    }
    
   
    // 默认没选中任何支付方式
    self.m_zhifubaoBtn.selected = NO;
    [self setLeftClicked:NO withRight:NO withWeixinPay:NO withHuahuaPay:NO];
    
    // 请求数据
    [self requestPriceSubmit];
   
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
      
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.isCharge = NO;

    
    [self hideTabBar:YES];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    if ( !self.isCharge ) {
        
        [self hideTabBar:NO];
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)leftClicked{
    
    [self.view endEditing:YES];

    
    [self goBack];
}

- (IBAction)forgetPassword:(id)sender {
    
    [self.view endEditing:YES];
    
    self.m_type = @"2";

    [self paymentSafeRequest];
    
}

// 请求数据返回余额和总价钱
- (void)requestPriceSubmit{
    
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
                           [NSString stringWithFormat:@"%@",self.m_orderId],@"ordIds",
                           nil];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"MemberBalance.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            
            self.m_tableView.hidden = NO;
            
//            NSString *msg = [json valueForKey:@"msg"];
            
//            [SVProgressHUD showSuccessWithStatus:msg];
            
            [SVProgressHUD dismiss];
            
            self.m_items = [json valueForKey:@"memberBalanceInfo"];
            
            self.m_totalPrice.text = [NSString stringWithFormat:@"￥%@",[self.m_items objectForKey:@"Total"]];
            
            self.m_baozhifuPrice.text = [NSString stringWithFormat:@"城与城余额:%.2f",floor([[self.m_items objectForKey:@"Balance"] doubleValue]*100)/100];
            
            self.m_yueLabel.text = [NSString stringWithFormat:@"城与城余额:%.2f",floor([[self.m_items objectForKey:@"Balance"] doubleValue]*100)/100];
            

            self.m_ActualPay.text = [NSString stringWithFormat:@"%@",[self.m_items objectForKey:@"Total"]];

            self.m_intergationLabel.text = [NSString stringWithFormat:@"%i分",[[self.m_items objectForKey:@"Total"] intValue]];
            
            
        } else {
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
    } failure:^(NSError *error) {
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];
    
}

// 验证用户是否填写了支付问题的网络请求
- (void)paymentSafeRequest{
    
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
                           nil];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"PaymentSafetyTesting.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
//            NSString *msg = [json valueForKey:@"msg"];
//              [SVProgressHUD showSuccessWithStatus:msg];
            [SVProgressHUD dismiss];
            
            if ( [self.m_type isEqualToString:@"1"] ) {
                
                // 请求成功后进入支付方式选择的页面
                PayStyleViewController *VC = [[PayStyleViewController alloc]initWithNibName:@"PayStyleViewController" bundle:nil];
                VC.m_typeString = @"1";
                [self.navigationController pushViewController:VC animated:YES];
                
            }else if ( [self.m_type isEqualToString:@"2"] ){
                
                // 进入忘记支付密码页面
                ForgetPswdViewController *viewController = [[ForgetPswdViewController alloc]initWithNibName:@"ForgetPswdViewController" bundle:nil];
                [self.navigationController pushViewController:viewController animated:YES];
                
                
            }else{
                
                
            }
            
        } else {
            
//            NSString *msg = [json valueForKey:@"msg"];
            //                [SVProgressHUD showErrorWithStatus:msg];
            [SVProgressHUD dismiss];
            
            // 进入设置安全问题及支付密码的页面
            PaymentQueViewController *viewController = [[PaymentQueViewController alloc]initWithNibName:@"PaymentQueViewController" bundle:nil];
            [self.navigationController pushViewController:viewController animated:YES];
            
            
        }
        
    } failure:^(NSError *error) {
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];
    
}

- (void)paymentRequest{
    
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
                           [NSString stringWithFormat:@"%@",self.m_orderId],@"ordIds",
                           [NSString stringWithFormat:@"%@",self.m_passWordTextField.text],@"password",
                           nil];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"ConfirmPayment.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
                        
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showSuccessWithStatus:msg];
            
            [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(lastView) userInfo:nil repeats:NO];
            
        } else {
            NSString *msg = [json valueForKey:@"msg"];
            
            NSString *errorCode = [json valueForKey:@"ErrorCode"];
            
            if ( [errorCode isEqualToString:@"1"] ) {
                
                [SVProgressHUD dismiss];
                
                // 支付密码未设置，请先设置
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示"
                                                                   message:msg
                                                                  delegate:self
                                                         cancelButtonTitle:@"取消"
                                                         otherButtonTitles:@"立即设置",nil];
                alertView.tag = 1112223;
                
                [alertView show];

            
            }else{
                
                  [SVProgressHUD showErrorWithStatus:msg];
            }
          
        }
    } failure:^(NSError *error) {
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];
}

- (void)lastView{
    
    if ( [self.m_typeString isEqualToString:@"1"] ) {
        
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count - 2] animated:YES];
        
    }else{
        
          [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if ( alertView.tag == 1112223 ){
        if ( buttonIndex == 1 ) {
            
            // 未设置支付密码，进入支付密码设置的页面
            PaymentQueViewController *viewController = [[PaymentQueViewController alloc]initWithNibName:@"PaymentQueViewController" bundle:nil];
            [self.navigationController pushViewController:viewController animated:YES];
            
        }else{
            
            
        }
        
        
    }else if (alertView.tag == 1234321) {
    
        if (buttonIndex == 1) {
            
            [self requestHuahuaSubmit];
            
        }
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return [self.m_productList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *cellIdentifier = @"ConfirmOrderCellIdentifier";
    
    ConfirmOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"ConfirmOrderCell" owner:self options:nil];
        
        cell = (ConfirmOrderCell *)[nib objectAtIndex:0];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    // 1表示来自于购物车  2表示来自于我的订单中的去付款
    if ( [self.m_typeString isEqualToString:@"1"] ) {
        
        if ( self.m_productList.count != 0 ) {
            
            
            NSMutableDictionary *dic = [self.m_productList objectAtIndex:indexPath.row];
            
            // 赋值
            cell.m_productName.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"ServiceName"]];
            cell.m_priceLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Price"]];
            cell.m_orignLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"OldPric"]];
            
            NSString *serviceId = [dic objectForKey:@"ServiceId"];
            
            NSString *count = [self.m_countDictionary objectForKey:[NSString stringWithFormat:@"%@",serviceId]];
            
            cell.m_countLabel.text = [NSString stringWithFormat:@"%@",count];
            
            // 图片赋值
            [cell setImageView:[dic objectForKey:@"ServiceLog"]];
            
            cell.m_orignLabel.hidden = NO;
            
            cell.m_lineLabel.hidden = NO;
            
            CGSize size = [cell.m_priceLabel.text sizeWithFont:[UIFont systemFontOfSize:18.0f] constrainedToSize:CGSizeMake(MAXFLOAT, 21) lineBreakMode:NSLineBreakByWordWrapping];
            
            CGSize size1 = [cell.m_orignLabel.text sizeWithFont:[UIFont systemFontOfSize:13.0f] constrainedToSize:CGSizeMake(MAXFLOAT, 21) lineBreakMode:NSLineBreakByWordWrapping];
            
            cell.m_priceLabel.frame = CGRectMake(cell.m_priceLabel.frame.origin.x, cell.m_priceLabel.frame.origin.y, size.width, 21);
            
            cell.m_orignLabel.frame = CGRectMake(cell.m_priceLabel.frame.origin.x + size.width + 3, cell.m_orignLabel.frame.origin.y, size1.width, 21);
            
            cell.m_lineLabel.frame = CGRectMake(cell.m_priceLabel.frame.origin.x + size.width, cell.m_lineLabel.frame.origin.y, size1.width + 4, 1);
            
            
        }

    }else{
        
        if ( self.m_productList.count != 0 ) {
            
            NSMutableDictionary *dic = [self.m_productList objectAtIndex:indexPath.row];
            
            // 赋值
            cell.m_productName.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"ServiceName"]];
            cell.m_priceLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Price"]];
            cell.m_orignLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"OldPric"]];
            
                        
            cell.m_countLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Amount"]];

            // 图片赋值
            [cell setImageView:[dic objectForKey:@"ServiceLog"]];
            
            cell.m_orignLabel.hidden = YES;
            
            cell.m_lineLabel.hidden = YES;
 
        }

    }
    
    return cell;

}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 106.0f;
    
}

- (IBAction)makeBuy:(id)sender {
    
    [self.view endEditing:YES];

    
    if ( self.m_payTypeString.length == 0 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请选择一种支付方式"];
        
        return;
        
    }
        
    if ( [self.m_payTypeString isEqualToString:@"1"] ) {
        // 银联支付
        [self requestRechargeSubmit];
        
    }else if ( [self.m_payTypeString isEqualToString:@"2"] ){
       
        // 诲诲余额支付
        if ( self.m_passWordTextField.text.length == 0 ) {
            
            [SVProgressHUD showErrorWithStatus:@"请输入支付密码"];
            
            return;
        }
        
        // 结算请求数据
        [self paymentRequest];
        
    }else if ( [self.m_payTypeString isEqualToString:@"3"] ){
        // 表示是支付宝支付
        
        
    }else if ( [self.m_payTypeString isEqualToString:@"4"] ){
        // 微信支付
        
        //调起微信支付
        //        PayReq* req             = [[PayReq alloc] init];
        //        req.openID              = @"";
        //        req.partnerId           = @"";
        //        req.prepayId            = @"";
        //        req.nonceStr            = @"";
        //        req.timeStamp           = 0;
        //        req.package             = @"";
        //        req.sign                = @"";
        //        [WXApi sendReq:req];
        
        NSLog(@"totalPrice = %@",[self.m_items objectForKey:@"Total"]);
        
        
        // 判断是否安装了微信
        if ( [WXApi isWXAppInstalled] ) {
            
            
            // 点击去支付后将数据保存起来用于微信支付的赋值
            NSMutableDictionary *dic = [self.m_productList objectAtIndex:0];
            
            NSLog(@"dic = %@",dic);

            [CommonUtil addValue:[NSString stringWithFormat:@"%@",[dic objectForKey:@"ServiceName"]] andKey:WEIXIN_NAME];
            
            [CommonUtil addValue:[NSString stringWithFormat:@"%@",[self.m_items objectForKey:@"Total"]] andKey:WEIXIN_PRICE];
            
            [CommonUtil addValue:[NSString stringWithFormat:@"%@",self.m_orderId] andKey:WEIXIN_OREDENO];
          
            // 表示商品购买
            [CommonUtil addValue:@"1" andKey:WEIXIN_PAYTYPE];
            
            
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
                
                //            [self alert:@"提示信息" msg:debug];
                
                NSLog(@"%@\n\n",debug);
                
            }else{
                
                //            NSLog(@"%@\n\n",[req getDebugifo]);
                //[self alert:@"确认" msg:@"下单成功，点击OK后调起支付！"];
                
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
                
                NSLog(@"dict = %@",dict);
                
                [WXApi sendReq:req];
                
            }

            
            
        }else{
            
            
            // 微信没有安装
            [SVProgressHUD showErrorWithStatus:@"您没有安装微信"];
            
        }
        
    }else if ( [self.m_payTypeString isEqualToString:@"5"] ){
        
        UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确定使用花花支付吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        
        alerta.tag = 1234321;
        
        [alerta show];
        

        
        
    }else {
    
        
    }
   
}



- (void)requestHuahuaSubmit{
    
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
                           self.m_orderId,@"orderId",
                           nil];

    [SVProgressHUD showWithStatus:@"信息提交中"];
    [httpClient request:@"PaymentCheck_huahua.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showSuccessWithStatus:msg];
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showErrorWithStatus:msg];
            
        }
    } failure:^(NSError *error) {
        NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];
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
                            [NSString stringWithFormat:@"%@",[self.m_items objectForKey:@"Total"]], @"amount",
                           self.m_orderId,@"ordersId",
                           nil];
    [SVProgressHUD showWithStatus:@"信息提交中"];
    [httpClient request:@"UnionMobileRechargeBuy.ashx" parameters:param success:^(NSJSONSerialization* json) {
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
        //NSLog(@"failed:%@", error);
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
            
            // 充值成功后调用购买支付的接口
        
            [SVProgressHUD showSuccessWithStatus:@"购买成功"];
            
            // 购买成功返回页面
            [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(lastView) userInfo:nil repeats:NO];

            
            
        }else{
            
            [SVProgressHUD showErrorWithStatus:@"交易失败"];
            
        }
    }
}


- (IBAction)choosePayType:(id)sender {
    
    UIButton *btn = (UIButton *)sender;
    
    if ( btn.tag == 11 ) {
        // 银联支付
        [self setLeftClicked:YES withRight:NO withWeixinPay:NO withHuahuaPay:NO];
        
    }else if ( btn.tag == 22 ){
        // 诲诲余额支付
        [self setLeftClicked:NO withRight:YES withWeixinPay:NO withHuahuaPay:NO];

    }else if ( btn.tag == 33 ){
        // 支付宝支付
        
        self.m_payTypeString = @"3";
        
        // 隐藏输入支付密码的页面
        self.m_paymentView.hidden = YES;
        
        self.m_zhifubaoBtn.selected = YES;

        self.m_zYinlianBtn.selected = NO;
        
        self.m_zHuihuiBtn.selected = NO;
        
        self.m_zWeixinBtn.selected = NO;
        
        self.m_zHuahuaBtn.selected = NO;

        
    }else if ( btn.tag == 44 ){
        
        // 微信支付
        [self setLeftClicked:NO withRight:NO withWeixinPay:YES withHuahuaPay:NO];
        
//        [SVProgressHUD showErrorWithStatus:@"微信支付"];
        
    }else if (btn.tag == 333) {
    
        //花花支付
        [self setLeftClicked:NO withRight:NO withWeixinPay:NO withHuahuaPay:YES];
        
    }
    
}

// 设置是诲诲支付还是银联支付
- (void)setLeftClicked:(BOOL)aLeft withRight:(BOOL)aRight withWeixinPay:(BOOL)aWeixinPay withHuahuaPay:(BOOL)aHuahua{
    
    if ( [self.m_zhifubao isEqualToString:@"1"] ) {
        
        self.m_zYinlianBtn.selected = aLeft;
        
        self.m_zHuihuiBtn.selected = aRight;
        
        self.m_zhifubaoBtn.selected = NO;
        
        self.m_zWeixinBtn.selected = aWeixinPay;
        
        self.m_zHuahuaBtn.selected = aHuahua;

        
        if ( aLeft ) {
            // 银联支付
            self.m_payTypeString = @"1";
            
            // 隐藏输入支付密码的页面
            self.m_paymentView.hidden = YES;
            
            
        }else if ( aRight ){
            // 诲诲支付
            self.m_payTypeString = @"2";
            
            // 显示输入密码所在的view
            self.m_paymentView.hidden = NO;
            
        }else if ( aWeixinPay ) {
            // 微信支付
            self.m_payTypeString = @"4";
            
            // 隐藏输入支付密码的页面
            self.m_paymentView.hidden = YES;
            
            
            
            
        }else if (aHuahua) {
        
            self.m_payTypeString = @"5";
            
            self.m_paymentView.hidden = YES;
            
        }
        else{
            
            // 隐藏输入支付密码的页面
            self.m_paymentView.hidden = YES;
            
            self.m_payTypeString = @"";
            
            
        }

        
    }else{
        
        
        self.m_yinlianBtn.selected = aLeft;
        
        self.m_huihuiBtn.selected = aRight;
        
        self.m_weixinBtn.selected = aWeixinPay;
        
        self.m_HuahuaBtn.selected = aHuahua;

        
        if ( aLeft ) {
            // 银联支付
            self.m_payTypeString = @"1";
            
            // 隐藏输入支付密码的页面
            self.m_paymentView.hidden = YES;
            
            
        }else if ( aRight ){
            // 诲诲支付
            self.m_payTypeString = @"2";
            
            // 显示输入密码所在的view
            self.m_paymentView.hidden = NO;
            
        }else if ( aWeixinPay ) {
            // 微信支付
            self.m_payTypeString = @"4";
            
            // 隐藏输入支付密码的页面
            self.m_paymentView.hidden = YES;
            
            
        }else if (aHuahua) {
        
            self.m_payTypeString = @"5";
            
            self.m_paymentView.hidden = YES;
            
        }
        else{
            
            // 隐藏输入支付密码的页面
            self.m_paymentView.hidden = YES;
            
            self.m_payTypeString = @"";
            
            
        }

    }
}

- (IBAction)btnChoose:(id)sender {
    
    // 默认为选中的状态
    self.isSelectedBalance = !self.isSelectedBalance;
    
    if ( self.isSelectedBalance ) {
        
        self.m_chooseBtn.backgroundColor = [UIColor redColor];
        
        float needPay = 0.00;
        
        if ( [self.m_totalPriceString floatValue] > [self.m_balanceString floatValue] ) {
            
            needPay = [self.m_totalPriceString floatValue] - [self.m_balanceString floatValue];
            
        }else{
            
            needPay = [self.m_balanceString floatValue] - [self.m_totalPriceString floatValue];
            
        }
        
        self.m_needPayLabel.text = [NSString stringWithFormat:@"￥%.2f",needPay];
        
        self.m_ActualPay.text = [NSString stringWithFormat:@"%@",self.m_needPayLabel.text];

   
    }else{
        
        self.m_chooseBtn.backgroundColor = [UIColor greenColor];
    
        
        self.m_needPayLabel.text = [NSString stringWithFormat:@"￥%.@",self.m_totalPriceString];
        
        self.m_ActualPay.text = [NSString stringWithFormat:@"￥%@",self.m_totalPriceString];

    }
    
}

- (IBAction)RechargeClicked:(id)sender {
    
    [self.view endEditing:YES];

    self.m_type = @"1";
    
    // 根据用户账号是否设置了安全支付问题来判断进入哪个页面
    [self paymentSafeRequest];
    
}

#pragma mark - CounponDelegate
- (void)getCounponString:(NSString *)aCounpon{
    
    self.m_couponString = [NSString stringWithFormat:@"%@",aCounpon];
    
    // 刷新某一行
    NSArray *arr = [NSArray arrayWithObjects:[NSIndexPath indexPathForRow:0 inSection:1], nil];
    
    [self.m_tableView reloadRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    [self hiddenNumPadDone:nil];
    
    [self.m_tableView setContentSize:CGSizeMake(WindowSizeWidth, self.m_tableView.frame.size.height + 200)];
    
    [self.m_tableView setContentOffset:CGPointMake(0, 200)];
    
    // 设置tableView滚动到最后一行
//    [self.m_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow: inSection:0]atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    [self.m_tableView setContentOffset:CGPointMake(0, 40)];
    
    [self.m_tableView setContentSize:CGSizeMake(WindowSizeWidth, self.m_tableView.frame.size.height + 60)];

    [textField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self.m_tableView setContentOffset:CGPointMake(0, 0)];
    
    [self.m_tableView setContentSize:CGSizeMake(WindowSizeWidth, self.m_tableView.frame.size.height + 60)];
    
    [textField resignFirstResponder];
    
    return YES;
}


@end
