//
//  PanicBuyingViewController.m
//  HuiHui
//
//  Created by mac on 14-2-13.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "PanicBuyingViewController.h"

#import "ConfirmOrderViewController.h"

#import "SVProgressHUD.h"

#import "CommonUtil.h"

#import "AppHttpClient.h"

#import "UIImageView+AFNetworking.h"

#import "PaymentQueViewController.h"

#import "RechargeViewController.h"

#import "PayStyleViewController.h"

@interface PanicBuyingViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *m_imgV;

@property (weak, nonatomic) IBOutlet UILabel *m_productName;

@property (weak, nonatomic) IBOutlet UILabel *m_totalPrice;

@property (weak, nonatomic) IBOutlet UITextField *m_passwordTextField;

@property (weak, nonatomic) IBOutlet UILabel *m_countLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_tokenLabel;

@property (weak, nonatomic) IBOutlet UIView *m_passwordView;

@property (weak, nonatomic) IBOutlet UIButton *m_yinlianBtn;

@property (weak, nonatomic) IBOutlet UIButton *m_huihuiBtn;

@property (weak, nonatomic) IBOutlet UILabel *m_balanceLabel;

@property (weak, nonatomic) IBOutlet UIView *m_payView;

@property (weak, nonatomic) IBOutlet UIView *m_payBtnView;

@property (weak, nonatomic) IBOutlet UIView *m_paypassView;

@property (weak, nonatomic) IBOutlet UIScrollView *m_scrollerView;

// 提交订单
- (IBAction)submitOrder:(id)sender;

// 选择支付方式
- (IBAction)choosePayType:(id)sender;

// 诲诲余额支付
- (IBAction)submitPayOrder:(id)sender;

@end

@implementation PanicBuyingViewController

@synthesize m_items;

@synthesize m_payTypeString;

@synthesize isCharge;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        m_items = [[NSMutableDictionary alloc]initWithCapacity:0];
        
        isCharge = NO;

    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"立即抢购"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    
    // 赋值
    self.m_productName.text = [NSString stringWithFormat:@"%@",[self.m_items objectForKey:@"GoodName"]];
    
    self.m_totalPrice.text = [NSString stringWithFormat:@"￥%@",[self.m_items objectForKey:@"Price"]];
    
    self.m_tokenLabel.text = [NSString stringWithFormat:@"%@",[self.m_items objectForKey:@"InviteTokenUse"]];
    
    self.m_countLabel.text = @"1";
    
    // 对图片进行赋值
    [self.m_imgV setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:[CommonUtil getValueByKey:@"productImage"]]]
                       placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"]
                                success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                                    
                                    self.m_imgV.image = [CommonUtil scaleImage:image toSize:CGSizeMake(105, 65)];
                                    
                                }
                                failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                                    
                                }];
    
    // 设置选择支付方式view的属性
    self.m_payView.layer.borderWidth = 1.0;
    self.m_payView.layer.borderColor = [UIColor colorWithRed:215/255.0 green:215/255.0 blue:215/255.0 alpha:1.0].CGColor;
    self.m_payView.layer.cornerRadius = 5.0;
    
    
    // 隐藏
    [self setLeftClicked:NO withRight:NO];
    
    // 获取余额请求数据
    [self balanceRequestSubmit];
    
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
    
    [self goBack];
}

- (void)balanceRequestSubmit{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,     @"memberid",
                           key,   @"key",
                           nil];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"More.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
           
            [SVProgressHUD dismiss];
            
            NSDictionary *dic = [json valueForKey:@"appMore"];
          
            self.m_balanceLabel.text = [NSString stringWithFormat:@"余额:%.2f",floor([[dic objectForKey:@"myBalance"] doubleValue]*100)/100];
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showErrorWithStatus:msg];
            
        }
    } failure:^(NSError *error) {
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];

    
}

- (IBAction)choosePayType:(id)sender {
    
    UIButton *btn = (UIButton *)sender;
    
    if ( btn.tag == 11 ) {
        // 银联支付
        [self setLeftClicked:YES withRight:NO];
        
    }else{
        // 诲诲余额支付
        [self setLeftClicked:NO withRight:YES];
      
    }
    
}

// 设置是诲诲支付还是银联支付
- (void)setLeftClicked:(BOOL)aLeft withRight:(BOOL)aRight{
    
    self.m_yinlianBtn.selected = aLeft;
    
    self.m_huihuiBtn.selected = aRight;
    
    
    // 隐藏输入支付密码的页面
    self.m_paypassView.hidden = YES;
    
    self.m_payBtnView.hidden = NO;

    
    if ( aLeft ) {
        // 银联支付
        self.m_payTypeString = @"1";
        
        
    }else if ( aRight ){
        // 诲诲支付
        self.m_payTypeString = @"2";
        
    }else{
        
        self.m_payTypeString = @"";

        
    }
    
}

- (IBAction)submitOrder:(id)sender {
    
    if ( self.m_payTypeString.length == 0 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请选择一种支付方式"];
        
        return;
        
    }
    
    if ( [self.m_payTypeString isEqualToString:@"1"] ) {
        // 银联支付 - 先去判断抢购的条件是否还成立
        [self paymentSafeRequest];
        
    }else if ( [self.m_payTypeString isEqualToString:@"2"] ){
        // 诲诲余额支付 - 先进行判断余额不足和支付问题未设置的情况
        
        [self safeRequestSubmit];
        
    }else{
        
        
        
    }
   
    
}

// 抢购进行条件的判断
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
                           [NSString stringWithFormat:@"%@",[self.m_items objectForKey:@"PanicBuyGoodID"]],@"panicBuyGoodID",
                           nil];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"WisdomPaymentCheck_1.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        //        NSString *ErrorCode = [NSString stringWithFormat:@"%@",[json valueForKey:@"ErrorCode"]];
        
        //    ErrorCode:0(Msg=用户信息丢失，请重新登录!)<br />
        //    ErrorCode:1(Msg=账号已被锁定!)<br />
        //    ErrorCode:2(Msg=您抢购的商品不存在!)<br />
        //    ErrorCode:3(Msg=请在活动进行时间内抢购!)<br />
        //    ErrorCode:4(Msg=商品已被抢光，请等待下次抢购活动!)<br />
        //    ErrorCode:11(Msg=您的邀请令牌不足，可邀请好友获得令牌!)<br />
        //    ErrorCode:12(Msg=您已经成功抢购，每人每商品只能抢购一次，不要贪心哦!)<br />
        
        
        if (success) {
            
//            [SVProgressHUD dismiss];
            
            // 条件成立后进行调起银联的插件
            [self requestRechargeSubmit];
            
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD dismiss];
            
            // 其他提示情况
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示"
                                                               message:msg
                                                              delegate:nil
                                                     cancelButtonTitle:@"确定"
                                                     otherButtonTitles:nil];
            
            [alertView show];
           
        }
        
    } failure:^(NSError *error) {
        //NSLog(@"failed:%@", error);
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
                           [NSString stringWithFormat:@"%@",[self.m_items objectForKey:@"Price"]], @"amount",
                        [NSString stringWithFormat:@"%@",[self.m_items objectForKey:@"PanicBuyGoodID"]],@"panicBuyGoodID",
                           nil];

    [httpClient request:@"WisdomBuyUniPay.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            
            self.isCharge = YES;
            
            //            NSString *msg = [json valueForKey:@"msg"];
            
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
            
            // 充值成功后提示抢购成功，请求token的接口刷新令牌数
            [SVProgressHUD showSuccessWithStatus:@"抢购成功"];
            
            // 购买成功后请求数据刷新下令牌数
            [self toekenRequestSubmit];
            
        }else{
            
            [SVProgressHUD showErrorWithStatus:@"交易失败"];
            
        }
    }
}

// 输入支付密码进行购买-诲诲余额购买
- (IBAction)submitPayOrder:(id)sender {
    
    [self.view endEditing:YES];

    if ( self.m_passwordTextField.text.length == 0 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请输入密码！"];
        
        return;
    }
    
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
                           [NSString stringWithFormat:@"%@",self.m_passwordTextField.text],@"password",
                           [NSString stringWithFormat:@"%@",[self.m_items objectForKey:@"PanicBuyGoodID"]],@"panicBuyGoodID",
                           nil];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"WisdomBuy.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        //    ErrorCode:0(Msg=用户信息丢失，请重新登录!)
        //    ErrorCode:1(Msg=账号已被锁定!)
        //    ErrorCode:2(Msg=请输入支付密码!)
        //    ErrorCode:3(Msg=您抢购的商品不存在!)
        //    ErrorCode:4(Msg=请在活动进行时间内抢购!)
        //    ErrorCode:5(Msg=商品已被抢光，请等待下次抢购活动!)
        //    ErrorCode:6(Msg=支付密码未设置，请先设置!)
        //    ErrorCode:7(Msg=支付密码不正确，请重新再试!)
        //    ErrorCode:8(Msg=您的支付锁定，3小时后再试!)
        //    ErrorCode:9(Msg=您和账户余额不足，请充值!)
        //    ErrorCode:10(Msg=您的邀请令牌不足，可邀请好友获得令牌!)
        //    ErrorCode:11(Msg=您已经成功抢购，每人每商品只能抢购一次，不要贪心哦!)
        //    ErrorCode:12(Msg=抢购成功!)
        
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        NSString *ErrorCode = [NSString stringWithFormat:@"%@",[json valueForKey:@"ErrorCode"]];
        
        
        if (success) {
            
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showSuccessWithStatus:msg];
            
            // 购买成功后请求数据刷新下令牌数
            [self toekenRequestSubmit];
            
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD dismiss];
            
            if ( [ErrorCode isEqualToString:@"0"] ) {
                
                // 用户信息丢失
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示"
                                                                   message:msg
                                                                  delegate:nil
                                                         cancelButtonTitle:@"确定"
                                                         otherButtonTitles:nil];
                
                [alertView show];
                
            }else if ( [ErrorCode isEqualToString:@"1"] ){
                
                // 账号已被锁定
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示"
                                                                   message:msg
                                                                  delegate:nil
                                                         cancelButtonTitle:@"确定"
                                                         otherButtonTitles:nil];
                
                [alertView show];
                
            }else if ( [ErrorCode isEqualToString:@"2"] ){
                
                // 请输入支付密码
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示"
                                                                   message:msg
                                                                  delegate:nil
                                                         cancelButtonTitle:@"确定"
                                                         otherButtonTitles:nil];
                
                [alertView show];
                
            }else if ( [ErrorCode isEqualToString:@"3"] ){
                
                // 您抢购的商品不存在
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示"
                                                                   message:msg
                                                                  delegate:nil
                                                         cancelButtonTitle:@"确定"
                                                         otherButtonTitles:nil];
                
                [alertView show];
                
            }else if ( [ErrorCode isEqualToString:@"4"] ){
                
                // 请在活动进行时间内抢购
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示"
                                                                   message:msg
                                                                  delegate:nil
                                                         cancelButtonTitle:@"确定"
                                                         otherButtonTitles:nil];
                
                [alertView show];
                
            }else if ( [ErrorCode isEqualToString:@"5"] ){
                
                // 商品已被抢光，请等待下次抢购活动
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示"
                                                                   message:msg
                                                                  delegate:nil
                                                         cancelButtonTitle:@"确定"
                                                         otherButtonTitles:nil];
                
                [alertView show];
                
            }else if ( [ErrorCode isEqualToString:@"6"] ){
                
                // 支付密码未设置，请先设置
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示"
                                                                   message:msg
                                                                  delegate:self
                                                         cancelButtonTitle:@"取消"
                                                         otherButtonTitles:@"立即设置",nil];
                alertView.tag = 123894;
                
                [alertView show];
                
                
            }else if ( [ErrorCode isEqualToString:@"7"] ){
                
                // 支付密码不正确，请重新再试
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示"
                                                                   message:msg
                                                                  delegate:nil
                                                         cancelButtonTitle:@"确定"
                                                         otherButtonTitles:nil];
                
                [alertView show];
                
            }else if ( [ErrorCode isEqualToString:@"8"] ){
                
                // 您的支付锁定，3小时后再试
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示"
                                                                   message:msg
                                                                  delegate:nil
                                                         cancelButtonTitle:@"确定"
                                                         otherButtonTitles:nil];
                
                [alertView show];
                
            }else if ( [ErrorCode isEqualToString:@"9"] ){
                
                // 您和账户余额不足，请充值
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示"
                                                                   message:msg
                                                                  delegate:self
                                                         cancelButtonTitle:@"取消"
                                                         otherButtonTitles:@"立即充值",nil];
                alertView.tag = 123893;
                
                [alertView show];
                
                
            }else if ( [ErrorCode isEqualToString:@"10"] ){
                
                // 您的邀请令牌不足，可邀请好友获得令牌
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示"
                                                                   message:msg
                                                                  delegate:nil
                                                         cancelButtonTitle:@"确定"
                                                         otherButtonTitles:nil];
                
                [alertView show];
                
            }else if ( [ErrorCode isEqualToString:@"11"] ){
                
                // 您已经成功抢购，每人每商品只能抢购一次，不要贪心哦
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示"
                                                                   message:msg
                                                                  delegate:nil
                                                         cancelButtonTitle:@"确定"
                                                         otherButtonTitles:nil];
                
                [alertView show];
                
            }
            
        }
    } failure:^(NSError *error) {
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];
    
}
// 判断余额不足和支付密码未设置的情况
- (void)safeRequestSubmit{
    
    
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
                          [NSString stringWithFormat:@"%@",[self.m_items objectForKey:@"PanicBuyGoodID"]],@"panicBuyGoodID",
                           nil];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"WisdomPaymentCheck_2.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        NSString *ErrorCode = [NSString stringWithFormat:@"%@",[json valueForKey:@"ErrorCode"]];
        
        if (success) {
            
            [SVProgressHUD dismiss];
            
            // 显示输入密码的页面
            self.m_paypassView.hidden = NO;
            
            self.m_payBtnView.hidden = YES;
            
            
        } else {
            
            self.m_paypassView.hidden = YES;
            
            self.m_payBtnView.hidden = NO;
            
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD dismiss];
            
            //        0：用户信息丢失，请重新登录!
            //        1：支付密码未设置！
            //        2：账户余额不足的情况
            //        3:您的邀请令牌不足，可邀请好友获得令牌！

            
            if ( [ErrorCode isEqualToString:@"0"] ) {
                
                // 用户信息丢失
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示"
                                                                   message:@"用户信息丢失，请重新登录!"
                                                                  delegate:nil
                                                         cancelButtonTitle:@"确定"
                                                         otherButtonTitles:nil];
                
                [alertView show];
                
            }
            else if ( [ErrorCode isEqualToString:@"1"] ){
                
                // 支付密码未设置，请先设置
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示"
                                                                   message:@"支付密码未设置！"
                                                                  delegate:self
                                                         cancelButtonTitle:@"取消"
                                                         otherButtonTitles:@"立即设置",nil];
                alertView.tag = 123894;
                
                [alertView show];
                
                
            }
            else if ( [ErrorCode isEqualToString:@"2"] ){
                
                
                NSString *vldStatus = [json valueForKey:@"RealNameAuStatus"];
                
                // 保存状态用于充值那边判断进入哪个页面
                [CommonUtil addValue:vldStatus andKey:REALAUSTATUS];
                
                // 您和账户余额不足，请充值
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示"
                                                                   message:@"账户余额不足的情况"
                                                                  delegate:self
                                                         cancelButtonTitle:@"取消"
                                                         otherButtonTitles:@"立即充值",nil];
                alertView.tag = 123893;
                
                [alertView show];
                
                
            }else if ( [ErrorCode isEqualToString:@"3"] ){
                
                // 令牌不足
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示"
                                                                   message:@"您的邀请令牌不足，可邀请好友获得令牌！"
                                                                  delegate:nil
                                                         cancelButtonTitle:@"确定"
                                                         otherButtonTitles:nil];
                
                [alertView show];
                
            }else{
                
                // 其他提示情况
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示"
                                                                   message:msg
                                                                  delegate:nil
                                                         cancelButtonTitle:@"确定"
                                                         otherButtonTitles:nil];
                
                [alertView show];
            }
          
        }
        
    } failure:^(NSError *error) {
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];
}

// 令牌请求数据
- (void)toekenRequestSubmit{
    
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

    [httpClient request:@"MemberToken.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            
            // 令牌
            [CommonUtil addValue:[json valueForKey:@"TokenNoUsedTotal"] andKey:TOKENNOUSEDTOTAL];
            
            [CommonUtil addValue:[json valueForKey:@"TokenUsedTotal"] andKey:TOKENUSEDTOTAL];
            
            
            [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(goLastView) userInfo:nil repeats:NO];

            
        } else {
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
    } failure:^(NSError *error) {
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];

}

- (void)goLastView{
    
    [self goBack];
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    if ( textField == self.m_passwordTextField ) {
        
        [self hiddenNumPadDone:nil];

    }
    
    [self.m_scrollerView setContentOffset:CGPointMake(0, 100)];

}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    [self.m_scrollerView setContentOffset:CGPointMake(0, 0)];

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    
    [textField resignFirstResponder];
    
    return YES;
}


#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if ( alertView.tag == 123894 ){
        if ( buttonIndex == 1 ) {
            
            // 未设置支付密码，进入支付密码设置的页面
            PaymentQueViewController *viewController = [[PaymentQueViewController alloc]initWithNibName:@"PaymentQueViewController" bundle:nil];
            [self.navigationController pushViewController:viewController animated:YES];
            
        }else{
            
            
        }
        
        
    }else if ( alertView.tag == 123893 ){
        if ( buttonIndex == 1 ) {
            // 余额不足跳转到充值的页面
//            RechargeViewController *viewController = [[RechargeViewController alloc] initWithNibName:@"RechargeViewController" bundle:nil];
//            [self.navigationController pushViewController:viewController animated:YES];
            
            PayStyleViewController *VC = [[PayStyleViewController alloc]initWithNibName:@"PayStyleViewController" bundle:nil];
            VC.m_typeString = @"1";
            [self.navigationController pushViewController:VC animated:YES];

        }else{
            
            
        }
        
    }else{
        
        
    }
}



@end
