//
//  FlightsPayViewController.m
//  HuiHui
//
//  Created by mac on 14-12-31.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "FlightsPayViewController.h"

#import "CommonUtil.h"

#import "Fl_orderListViewController.h"
#import "PayStyleViewController.h"
#import "PaymentQueViewController.h"

@interface FlightsPayViewController ()

@property (weak, nonatomic) IBOutlet UILabel *m_huihuibalance;

@property (weak, nonatomic) IBOutlet UITextField *m_passWord;

@property (weak, nonatomic) IBOutlet UIView *m_passView;

@property (weak, nonatomic) IBOutlet UIScrollView *m_scrollerView;

@property (weak, nonatomic) IBOutlet UILabel *m_dateLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_flightsNum;

@property (weak, nonatomic) IBOutlet UILabel *m_dptTime;

@property (weak, nonatomic) IBOutlet UILabel *m_arrTime;

@property (weak, nonatomic) IBOutlet UILabel *m_distance;

@property (weak, nonatomic) IBOutlet UILabel *m_orderNo;

@property (weak, nonatomic) IBOutlet UILabel *m_supplier;

@property (weak, nonatomic) IBOutlet UILabel *m_name;

@property (weak, nonatomic) IBOutlet UILabel *m_cardId;

@property (weak, nonatomic) IBOutlet UILabel *m_price;

@property (weak, nonatomic) IBOutlet UILabel *m_contactName;

@property (weak, nonatomic) IBOutlet UILabel *m_phone;

@property (weak, nonatomic) IBOutlet UILabel *m_totalPrice;

@property (weak, nonatomic) IBOutlet UILabel *m_tiplabel;

@property (weak, nonatomic) IBOutlet UIImageView *m_imagV;



// 充值按钮触发的事件
- (IBAction)rechageClicked:(id)sender;
// 支付按钮触发的事件
- (IBAction)payClicked:(id)sender;
// 点击展开或者收起
- (IBAction)closeOrOpenClicked:(id)sender;

@end

@implementation FlightsPayViewController

@synthesize appMore;

@synthesize isClose;

@synthesize m_dic;

@synthesize m_contactDic;

@synthesize m_orderdic;

@synthesize m_phoneString;

@synthesize m_securityString;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        appMore = [[NSMutableDictionary alloc]initWithCapacity:0];
        
        isClose = NO;
        
        m_dic = [[NSMutableDictionary alloc]initWithCapacity:0];
        
        m_contactDic = [[NSMutableDictionary alloc]initWithCapacity:0];
        
        m_orderdic = [[NSMutableDictionary alloc]initWithCapacity:0];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setTitle:@"机票支付"];
    
    self.view.backgroundColor = RGBACKTAB;
    
    self.m_securityString = @"";

    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    // 将scrollerView滚动时出现的滚动条去掉
    [self.m_scrollerView setShowsVerticalScrollIndicator:NO];
    
    
    // 赋值
    // 根据日期计算出星期几
    NSString *dateString = [self getDate:[NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"dptDate"]]];
    
    self.m_dateLabel.text = [NSString stringWithFormat:@"%@ %@-%@",dateString,[self.m_dic objectForKey:@"dptCity"],[self.m_dic objectForKey:@"arrCity"]];
    
    
    self.m_flightsNum.text = [NSString stringWithFormat:@"%@%@",[self.m_dic objectForKey:@"airlineCompany"],[self.m_dic objectForKey:@"flightNum"]];
    
    self.m_dptTime.text = [NSString stringWithFormat:@"%@   %@",[self.m_dic objectForKey:@"dptTime"],[self.m_dic objectForKey:@"dptCodeName"]];
   
    self.m_arrTime.text = [NSString stringWithFormat:@"%@   %@",[self.m_dic objectForKey:@"arrTime"],[self.m_dic objectForKey:@"arrCodeName"]];
    
    
    // 判断折扣的，大于10表示原价，小于10表示是经济舱打几折
    NSString *discount = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"discount"]];
    
    if ( [discount floatValue] < 10.00 ) {
        
        self.m_distance.text = [NSString stringWithFormat:@"经济舱|飞行%@个小时|里程%@公里",[self.m_dic objectForKey:@"flightTime"],[self.m_dic objectForKey:@"distance"]];
        
    }else{
        
        self.m_distance.text = [NSString stringWithFormat:@"飞行%@个小时|里程%@公里",[self.m_dic objectForKey:@"flightTime"],[self.m_dic objectForKey:@"distance"]];
    
    }

    
    
   
    
    // 订单号
    self.m_orderNo.text = [NSString stringWithFormat:@"%@",[self.m_orderdic objectForKey:@"orderNo"]];
   
    self.m_supplier.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"supplierName"]];

    // 乘机人信息
    self.m_name.text = [NSString stringWithFormat:@"%@",[self.m_contactDic objectForKey:@"name"]];
    
    self.m_cardId.text = [NSString stringWithFormat:@"%@",[self.m_contactDic objectForKey:@"cardNum"]];
    
    self.m_price.text = [NSString stringWithFormat:@"票价￥%@|机建￥%@|燃油￥%@",[self.m_dic objectForKey:@"hhDiscountPrice"],[self.m_dic objectForKey:@"constructionFee"],[self.m_dic objectForKey:@"fuelTax"]];

    // 联系人
    self.m_contactName.text = [NSString stringWithFormat:@"%@",[self.m_contactDic objectForKey:@"name"]];
    
    // 联系人手机号
    self.m_phone.text = [NSString stringWithFormat:@"%@",self.m_phoneString];
    
    // 支付总价
   self.m_totalPrice.text = [NSString stringWithFormat:@"支付金额:￥%@",[self.m_dic objectForKey:@"hhPurchasePrice"]];
    
    
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
    
    [self.view endEditing:YES];
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
            
            [SVProgressHUD dismiss];
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
    
    NSLog(@"self.m_securityString = %@",self.m_securityString);

    
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
    
    
    NSLog(@"self.m_securityString = %@",self.m_securityString);
    
    
    float balance = floor([[self.appMore objectForKey:@"myBalance"] doubleValue]*100)/100;
    
    float price = [[self.m_dic objectForKey:@"hhPurchasePrice"] floatValue];
    
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

- (IBAction)closeOrOpenClicked:(id)sender {
    
    self.isClose = !self.isClose;
    // 如果是展开则设置view的坐标
    if ( self.isClose ) {
        
        [UIView animateWithDuration:0.3 animations:^{
            // 设置view的坐标及scrollerView的滚动范围
            [self.m_passView setFrame:CGRectMake(0, 343, [UIScreen mainScreen].bounds.size.width, 400)];
            
            [self.m_scrollerView setContentSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 20, 350)];

        } completion:^(BOOL finished){
            // 设置提示语及箭头的方向
            self.m_tiplabel.text = @"点击收起";
            
            self.m_imagV.image = [UIImage imageNamed:@"arrow_up.png"];

        }];
        
    }else{
        
        [UIView animateWithDuration:0.3 animations:^{
            
            // 设置view的坐标及scrollerView的滚动范围
            [self.m_passView setFrame:CGRectMake(0, 121, [UIScreen mainScreen].bounds.size.width, 400)];
            
            [self.m_scrollerView setContentSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 20, 300)];
            
        } completion:^(BOOL finished){
            
            // 设置提示语及箭头的方向
            self.m_tiplabel.text = @"点击展开";
            
             self.m_imagV.image = [UIImage imageNamed:@"arrow_down.png"];
            
        }];
    
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
                           [NSString stringWithFormat:@"%@",[self.m_orderdic objectForKey:@"oID"]],@"orderId",
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
    
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
    
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if ( alertView.tag == 109203 ) {
        
        if ( buttonIndex == 0 ) {
            
            // 返回上一级
            [self LastView];

            
        }else if ( buttonIndex == 1 ){
            // 查看订单 进入机票订单的页面
            Fl_orderListViewController *VC = [[Fl_orderListViewController alloc]initWithNibName:@"Fl_orderListViewController" bundle:nil];
            VC.m_typeString = @"2";
            [self.navigationController pushViewController:VC animated:YES];
            
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
    
    // 点击输入密码时将view的坐标重新设置
    [self.m_passView setFrame:CGRectMake(0, 80, [UIScreen mainScreen].bounds.size.width, 500)];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    return YES;
}

@end
