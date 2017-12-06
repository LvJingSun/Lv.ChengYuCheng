//
//  HH_FanliViewController.m
//  HuiHui
//
//  Created by mac on 15-3-31.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "HH_FanliViewController.h"

@interface HH_FanliViewController ()

@property (weak, nonatomic) IBOutlet UITextField *m_orderField;

// 申请返利触发的事件
- (IBAction)shenqingFanliClicked:(id)sender;

@end

@implementation HH_FanliViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"申请返利"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
   
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
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

- (IBAction)shenqingFanliClicked:(id)sender {
    
    [self.view endEditing:YES];
    
    if ( self.m_orderField.text.length == 0 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请填写您申请返利的订单号"];
        
        return;
        
    }
    
    // 请求数据
    [self fanliRequestSubmit];
    
}

// 申请返利请求数据
- (void)fanliRequestSubmit{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
  
    // 获取memberId
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    AppHttpClient* httpClient = [AppHttpClient scenerySharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"memberId",
                           [NSString stringWithFormat:@"%@",self.m_orderField.text],@"orderId",
                           
                           nil];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    [httpClient requestScenery:@"Flight/ApplyFlightRebate.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        // status 0表示有数据 其他表示错误
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        NSLog(@"json = %@",json);
        
        if ( success ) {
            
            [SVProgressHUD dismiss];
            NSString *msg = [json valueForKey:@"msg"];
//            [SVProgressHUD showSuccessWithStatus:msg];
            
            // 记录值返回返利列表页面后进行刷新数据
            [CommonUtil addValue:@"1" andKey:@"RebateKey"];
            
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示"
                                                               message:msg
                                                              delegate:self
                                                     cancelButtonTitle:@"确定"
                                                     otherButtonTitles: nil];
           
            alertView.tag = 13234;
            [alertView show];
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
        
        
    } failure:^(NSError *error) {
        
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
    
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if ( alertView.tag == 13234 ) {
        
        if ( buttonIndex == 0 ) {
            // 返回上一级
            [self goBack];
        }
    }
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{

    [self  hiddenNumPadDone:nil];
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField{

    [textField resignFirstResponder];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    return YES;
}

@end
