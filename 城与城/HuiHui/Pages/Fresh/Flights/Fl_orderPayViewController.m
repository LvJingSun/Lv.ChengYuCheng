//
//  Fl_orderPayViewController.m
//  HuiHui
//
//  Created by mac on 15-1-8.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "Fl_orderPayViewController.h"

#import "CommonUtil.h"
#import "PayStyleViewController.h"
#import "PaymentQueViewController.h"

@interface Fl_orderPayViewController ()

@property (weak, nonatomic) IBOutlet UILabel *m_price;

@property (weak, nonatomic) IBOutlet UILabel *m_huihuibalance;

@property (weak, nonatomic) IBOutlet UITextField *m_passWord;

// 充值按钮触发的事件
- (IBAction)rechageClicked:(id)sender;
// 支付按钮触发的事件
- (IBAction)payClicked:(id)sender;

@end

@implementation Fl_orderPayViewController

@synthesize appMore;

@synthesize m_priceString;

@synthesize m_orderId;

@synthesize m_securityString;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        appMore = [[NSMutableDictionary alloc]initWithCapacity:0];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setTitle:@"去支付"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    self.m_securityString = @"";
    
    // 赋值
    self.m_price.text = [NSString stringWithFormat:@"支付金额:￥%@",self.m_priceString];

}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
 
    // 请求网络数据
    [self loadData];
    
    // 判断用户是否设置了安全支付问题
    [self paymentSafeRequest];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)leftClicked{
    
    [self goBack];
    
}

// 获取网络数据得到用户的余额
- (void)loadData {
    
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
    //    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"More.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            
            //            [SVProgressHUD dismiss];
            self.appMore = [json valueForKey:@"appMore"];
            [CommonUtil addValue:[self.appMore objectForKey:@"realAuName"] andKey:REAL_ACCOUNT_NAME];
            [CommonUtil addValue:[self.appMore objectForKey:@"realAuIdCard"] andKey:REAL_ACCOUNT_IDCARD];
            [CommonUtil addValue:[self.appMore objectForKey:@"realAuStatus"] andKey:USER_REALAUSTATUS];
            
            // 余额进行赋值
            self.m_huihuibalance.text = [NSString stringWithFormat:@"城与城余额:￥%.2f",floor([[self.appMore objectForKey:@"myBalance"] doubleValue]*100)/100];

          
            // 保存用户的状态
            NSString *vldStatus = [self.appMore objectForKey:@"realAuStatus"];
            
            // 保存用户的状态
            [CommonUtil addValue:vldStatus andKey:REALAUSTATUS];
            
            
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
    //    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"PaymentSafetyTesting.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
//            [SVProgressHUD dismiss];
            // 设置了安全问题
            self.m_securityString = @"2";
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            
            if ( [msg isEqualToString:@"用户信息丢失，请重新登录"] ) {
                
                [SVProgressHUD showErrorWithStatus:msg];
                
            }else{
                
                self.m_securityString = @"1";
                
            }
            
        }
        
    } failure:^(NSError *error) {
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];
    
}


#pragma mark - BtnClicked
- (IBAction)rechageClicked:(id)sender {
    
    // 根据个人的不同状态来进入不同的页面
    NSString *vldStatus = [CommonUtil getValueByKey:REALAUSTATUS];
    
    NSLog(@"vldStatus = %@",vldStatus);
    
    // 根据是否设置了安全支付问题进行页面跳转 2表示设置了 直接跳转到充值的页面  1表示未设置 跳转到设置安全支付问题的页面
    if ( [self.m_securityString isEqualToString:@"2"] ) {
        
        // 进入充值选择的页面
        PayStyleViewController *VC = [[PayStyleViewController alloc]initWithNibName:@"PayStyleViewController" bundle:nil];
        VC.m_typeString = @"1";
        [self.navigationController pushViewController:VC animated:YES];
        
    }else{
        
        // 进入设置安全问题及支付密码的页面
        PaymentQueViewController *viewController = [[PaymentQueViewController alloc]initWithNibName:@"PaymentQueViewController" bundle:nil];
        [self.navigationController pushViewController:viewController animated:YES];
        
    }
    
}

- (IBAction)payClicked:(id)sender {
    
    float balance = floor([[self.appMore objectForKey:@"myBalance"] doubleValue]*100)/100;
    
    float price = [self.m_priceString floatValue];
    
    NSLog(@"m_securityString = %@",self.m_securityString);
    
    NSLog(@"balance = %.2f,price = %f",balance,price);
    // 先判断是否设置了安全支付问题，2表示设置了   1表示未设置 跳转到设置安全支付问题的页面
    if ( [self.m_securityString isEqualToString:@"2"] ) {
        
        // 判断如果余额小于订单的价钱则提示用户先充值
        if ( balance < price ) {
            
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"您的余额不足请先充值"
                                                               message:@""
                                                              delegate:nil
                                                     cancelButtonTitle:@"确定"
                                                     otherButtonTitles: nil];
            [alertView show];
            
            return;
        }
        
        if ( self.m_passWord.text.length == 0 ) {
            
            [SVProgressHUD showErrorWithStatus:@"请输入支付密码"];
            
            return;
        }
        
        // 支付订单请求接口
        [self requestSubmit];
        
    }else{
        
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"您还未设置支付密码"
                                                           message:@""
                                                          delegate:self
                                                 cancelButtonTitle:@"确定"
                                                 otherButtonTitles:@"去设置", nil];
        alertView.tag = 13409;
        [alertView show];
        
    }
    
    
    
}

#pragma mark - NetRequest
- (void)requestSubmit{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    // 获取memberId
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient1];
    
    // 支付方式payStyle bzf(诲诲余额支付)
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"memberId",
                           @"bzf",@"payStyle",
                           [NSString stringWithFormat:@"%@",self.m_orderId],@"orderId",
                           [NSString stringWithFormat:@"%@",self.m_passWord.text],@"paymentPass",
                           
                           nil];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    [httpClient requestFlights:@"QunarQbPay.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        // status 0表示有数据 其他表示错误
        BOOL success = [[json valueForKey:@"status"] boolValue];
                
        if ( success ) {
            
            [SVProgressHUD dismiss];
            
            NSString *msg = [json valueForKey:@"msg"];
            
            //            [SVProgressHUD showSuccessWithStatus:msg];
            
            
            // 支付成功后跳出提示-返回还是查看订单
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示"
                                                               message:msg
                                                              delegate:self
                                                     cancelButtonTitle:@"返回"
                                                     otherButtonTitles:@"查看订单", nil];
            alertView.tag = 109203;
            [alertView show];
            
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
            
            
        }
    } failure:^(NSError *error) {
        NSLog(@"failed:%@", error);
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
    
}

// 返回到机票搜索的页面
- (void)LastView{
    
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:2] animated:YES];
    
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if ( alertView.tag == 109203 ) {
        
        if ( buttonIndex == 0 ) {
            
            // 返回上一级
            [self LastView];
            
            
        }else if ( buttonIndex == 1 ){
            // 查看订单 进入机票订单的页面
            // 返回上一级
            [self LastView];

            
            
        }
    }else if ( alertView.tag == 13409 ){
        
        if ( buttonIndex == 0 ) {
            
            
        }else{
            
            // 进入设置安全问题及支付密码的页面
            PaymentQueViewController *viewController = [[PaymentQueViewController alloc]initWithNibName:@"PaymentQueViewController" bundle:nil];
            [self.navigationController pushViewController:viewController animated:YES];
            
        }
        
    }else{
        
        
    }
    
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    [self showNumPadDone:nil];
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    return YES;
}



@end
