//
//  BillRechargeViewController.m
//  HuiHui
//
//  Created by mac on 2017/5/18.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "BillRechargeViewController.h"
#import "BillRechargeHeadView.h"
#import "LJConst.h"
#import "BillOrderModel.h"
#import "BillAlertView.h"

#import "PaymentPasswordView.h"
#import "PaymentQueViewController.h"
#import "ForgetPswdViewController.h"

@interface BillRechargeViewController () <UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,PasswordAlertViewDelegate,BillAlertViewDelegate,UIAlertViewDelegate> {

    NSString *rechargePhone;
    
    NSString *rechargeLocation;
    
    BillOrderModel *billOrderModel;
    
    BOOL isTrue;
    
}

@property (nonatomic, weak) BillRechargeHeadView *headview;

@property (nonatomic, weak) UITextField *phoneField;

@property (nonatomic, weak) UILabel *locationLab;

@property (nonatomic, weak) UIButton *btn50;

@property (nonatomic, weak) UIButton *btn100;

@property (nonatomic, weak) UIButton *btn300;

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, retain) BillAlertView *billAlertView;

//@property (nonatomic,strong) PaymentPasswordView *alertView1;
@property (nonatomic,strong) PaymentPasswordView *alertView2;

@end

@implementation BillRechargeViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    isTrue = NO;
    
    self.title = @"充值中心";
    
    [self allocWithTableView];
    
    self.billAlertView = [[BillAlertView alloc] init];
    
    self.billAlertView.delegate = self;
    
    _alertView2 =[[PaymentPasswordView alloc]initWithType:PasswordAlertViewType_sheet];
    
    _alertView2.delegate = self;
    
    _alertView2.titleLable.text = @"请输入支付密码";
    
    _alertView2.tipsLalbe.text = @"您输入的密码不正确！";
    
}

- (void)BillSureBtnClick {
    
    [self requestForPayPWD];
    
}

//判断是否设置支付密码
- (void)requestForPayPWD {
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];

    AppHttpClient *httpClient = [AppHttpClient sharedHuiHuiRecharge];
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"MemberID",
                           nil];
    
    [httpClient HuiHuiRechargeRequest:@"ISMemPayPass.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        if ([[json valueForKey:@"IsPayPass"] isEqualToString:@"1"]) {
            
            if (self.billAlertView) {
                
                [self.billAlertView disMissView];
                
            }
            
            [_alertView2 show];
            
        }else if ([[json valueForKey:@"IsPayPass"] isEqualToString:@"0"]) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您的城与城账号未设置支付密码，是否前往设置？" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
    
            [alert show];
            
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {

    switch (buttonIndex) {
        case 1:
        {
        
            PaymentQueViewController *viewController = [[PaymentQueViewController alloc]initWithNibName:@"PaymentQueViewController" bundle:nil];
            
            [self.navigationController pushViewController:viewController animated:YES];
            
        }
            break;
            
        default:
            break;
    }
    
}

//输入支付密码请求
-(void)PasswordAlertViewCompleteInputWith:(NSString*)password{
    
    AppHttpClient *httpClient = [AppHttpClient sharedHuiHuiRecharge];
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           billOrderModel.orderNo,@"OrderID",
                           password,@"PassWord",
                           nil];
    
    [SVProgressHUD show];
    
    [httpClient HuiHuiRechargeRequest:@"MembersPay.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        if ([[json valueForKey:@"status"] boolValue]) {
            
            [self requestForJuHeRecharge];
            
        }else {
            
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",[json valueForKey:@"msg"]]];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [_alertView2 passwordError];
            });
            
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}

//执行聚合的充值
- (void)requestForJuHeRecharge {

    AppHttpClient *httpClient = [AppHttpClient sharedBillRecharge];
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           billOrderModel.phone,@"phoneno",
                           billOrderModel.count,@"cardnum",
                           RechargeKey,@"key",
                           billOrderModel.orderNo,@"orderid",
                           billOrderModel.MdStr,@"sign",
                           nil];
    
    [httpClient billRechargeRequest:@"onlineorder" parameters:param success:^(NSJSONSerialization* json) {
        
        int code = [[json valueForKey:@"error_code"] intValue];
        
        if (code == 0) {
            
            [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"%@",[json valueForKey:@"reason"]]];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [_alertView2 passwordCorrect];
            });
            
        }else {
            
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",[json valueForKey:@"reason"]]];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [_alertView2 passwordError];
            });
            
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
        [self setGrayBtn];
        
    }];
    
}


-(void)PasswordAlertViewDidClickCancleButton{
    
    [self.billAlertView showInView:self.view];

}


-(void)PasswordAlertViewDidClickForgetButton{
    
    // 进入忘记支付密码页面
    ForgetPswdViewController *viewController = [[ForgetPswdViewController alloc]initWithNibName:@"ForgetPswdViewController" bundle:nil];
    [self.navigationController pushViewController:viewController animated:YES];
    
}

//初始化tableview
- (void)allocWithTableView {
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, _WindowViewWidth, _WindowViewHeight - 64)];
    
    BillRechargeHeadView *headview = [[BillRechargeHeadView alloc] init];
    
    headview.frame = CGRectMake(0, 0, _WindowViewWidth, headview.height);
    
    self.phoneField = headview.phoneFiled;
    
    headview.phoneFiled.delegate = self;
    
    self.locationLab = headview.locationLab;
    
    self.btn50 = headview.btn50;
    
    [headview.btn50 addTarget:self action:@selector(Btn50Click) forControlEvents:UIControlEventTouchUpInside];
    
    self.btn100 = headview.btn100;
    
    [headview.btn100 addTarget:self action:@selector(Btn100Click) forControlEvents:UIControlEventTouchUpInside];
    
    self.btn300 = headview.btn300;
    
    [headview.btn300 addTarget:self action:@selector(Btn300Click) forControlEvents:UIControlEventTouchUpInside];
    
    self.tableview = tableview;
    
    tableview.tableHeaderView = headview;
    
    tableview.delegate = self;
    
    tableview.dataSource = self;
    
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    tableview.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:tableview];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tableviewClick:)];
    
    [tableview addGestureRecognizer:tap];
    
}

- (void)Btn50Click {
    
    [self hideKeyBoard];
    
    [self requestForOrderInfoWithCount:@"50"];
    
}

//获取订单信息
- (void)requestForOrderInfoWithCount:(NSString *)count {
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    
    AppHttpClient *httpClient = [AppHttpClient sharedHuiHuiRecharge];
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           rechargePhone,@"PhoneNo",
                           count,@"CardNum",
                           memberId,@"MemberID",
                           nil];
    
    [SVProgressHUD show];
    
    [httpClient HuiHuiRechargeRequest:@"SavePhoneTopUp.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        if ([[json valueForKey:@"status"] boolValue]) {
            
            billOrderModel = [[BillOrderModel alloc] init];
            
            billOrderModel.count = [NSString stringWithFormat:@"%.2f",[[json valueForKey:@"CardNum"] floatValue]];
            
            billOrderModel.orderNo = [NSString stringWithFormat:@"%@",[json valueForKey:@"OrderID"]];
            
            billOrderModel.phone = [NSString stringWithFormat:@"%@",[json valueForKey:@"PhotoNo"]];
            
            billOrderModel.location = rechargeLocation;
            
            billOrderModel.style = @"余额";
            
            billOrderModel.MdStr = [NSString stringWithFormat:@"%@",[json valueForKey:@"MdStr"]];
            
            billOrderModel.IFEnough = [NSString stringWithFormat:@"%@",[json valueForKey:@"IFEnough"]];
            
            self.billAlertView.orderModel = billOrderModel;
            
            [self.billAlertView showInView:self.view];
            
            [SVProgressHUD dismiss];
            
        }else {
        
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",[json valueForKey:@"msg"]]];
            
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}

- (void)Btn100Click {
    
    [self hideKeyBoard];
    
    [self requestForOrderInfoWithCount:@"100"];
    
}

- (void)Btn300Click {
    
    [self hideKeyBoard];
    
    [self requestForOrderInfoWithCount:@"300"];
    
}

- (void)tableviewClick:(UITapGestureRecognizer *)recognizer {
    
    [self hideKeyBoard];
    
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        
        return NO;
        
    }
    
    return YES;
    
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
        
    NSInteger existedLength = textField.text.length;
    
    NSInteger selectedLength = range.length;
    
    NSInteger replaceLength = string.length;
    
    if (replaceLength == 0) {
        
        rechargePhone = @"";
        
        [self requestForPhoneInfo];
        
        return YES;
        
    }
    
    if (existedLength - selectedLength + replaceLength > 11) {
        
        [self hideKeyBoard];
        
        return NO;
        
    }else {
    
        rechargePhone = [textField.text stringByAppendingString:string];

        [self requestForPhoneInfo];
        
    }
    
    return YES;
    
}

//检测手机号码是否正确及归属地
- (void)requestForPhoneInfo {
    
    if (rechargePhone.length == 11) {
        
        AppHttpClient *httpClient = [AppHttpClient sharedBillRecharge];
        
        NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                               rechargePhone,@"phoneno",
                               @"50",@"cardnum",
                               RechargeKey,@"key",
                               nil];
        
        [httpClient billRechargeRequest:@"telquery" parameters:param success:^(NSJSONSerialization* json) {
            
            int code = [[json valueForKey:@"error_code"] intValue];
            
            if (code == 0) {
                
                NSDictionary *dic = [json valueForKey:@"result"];
                
                self.locationLab.text = [NSString stringWithFormat:@"%@",dic[@"game_area"]];
                
                rechargeLocation = [NSString stringWithFormat:@"%@",dic[@"game_area"]];
                
                [self setStyleBtn];
                
            }else {
                
                self.locationLab.text = [NSString stringWithFormat:@"%@",[json valueForKey:@"reason"]];
                
                [self setGrayBtn];
                
            }
            
        } failure:^(NSError *error) {
            
            [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
            
            [self setGrayBtn];
            
        }];
        
    }else {
    
        self.locationLab.text = @"";
        
        [self setGrayBtn];
        
    }

}

//设置按钮蓝色
- (void)setStyleBtn {

    [self.btn50 setTitleColor:FSB_StyleCOLOR forState:0];
    
    self.btn50.layer.borderColor = FSB_StyleCOLOR.CGColor;
    
    self.btn50.userInteractionEnabled = YES;
    
    [self.btn100 setTitleColor:FSB_StyleCOLOR forState:0];
    
    self.btn100.layer.borderColor = FSB_StyleCOLOR.CGColor;
    
    self.btn100.userInteractionEnabled = YES;
    
    [self.btn300 setTitleColor:FSB_StyleCOLOR forState:0];
    
    self.btn300.layer.borderColor = FSB_StyleCOLOR.CGColor;
    
    self.btn300.userInteractionEnabled = YES;
    
}

//设置按钮灰色
- (void)setGrayBtn {

    [self.btn50 setTitleColor:[UIColor darkGrayColor] forState:0];
    
    self.btn50.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    self.btn50.userInteractionEnabled = NO;
    
    [self.btn100 setTitleColor:[UIColor darkGrayColor] forState:0];
    
    self.btn100.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    self.btn100.userInteractionEnabled = NO;
    
    [self.btn300 setTitleColor:[UIColor darkGrayColor] forState:0];
    
    self.btn300.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    self.btn300.userInteractionEnabled = NO;
    
}

- (void)hideKeyBoard {

    if ([self.phoneField isFirstResponder]) {
        
        [self.phoneField resignFirstResponder];
        
    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 0;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    return nil;
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];

}

@end
