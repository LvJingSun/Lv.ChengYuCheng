//
//  EditorCustomerservicerViewController.m
//  HuiHui
//
//  Created by fenghq on 15/9/17.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "EditorCustomerservicerViewController.h"

@interface EditorCustomerservicerViewController ()<UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet UITextField *CustomerPhone;

@property (weak, nonatomic) IBOutlet UIButton *CustomerSave;
@property (weak, nonatomic) IBOutlet UIButton *CustomerDel;
//启用；禁用
@property (weak, nonatomic) IBOutlet UIButton *CustomerTypeBtn;

@end

@implementation EditorCustomerservicerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.CustomerDIC = [[NSMutableDictionary alloc]initWithCapacity:0];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];

    
    //编辑或是新增
    if ([self.CustomerType isEqualToString:@"1"]) {
        self.CustomerSave.hidden = NO;
        self.CustomerDel.hidden = YES;
        self.CustomerTypeBtn.hidden = YES;
        [self setTitle:@"新增客服"];

    }else
    {
        self.CustomerSave.hidden = YES;
        self.CustomerDel.hidden = NO;
        self.CustomerTypeBtn.hidden = NO;
        self.CustomerPhone.text = [NSString stringWithFormat:@"%@",[self.CustomerDIC objectForKey:@"Account"]];
        self.CustomerPhone.enabled = NO;
        [self setTitle:@"设置客服"];
    }
    
    NSString *status = [NSString stringWithFormat:@"%@",[self.CustomerDIC objectForKey:@"Status"]];
    if ([status isEqualToString:@"1"]) {
        [self.CustomerTypeBtn setTitle:@"禁用" forState:UIControlStateNormal];
    }else
    {
        [self.CustomerTypeBtn setTitle:@"启用" forState:UIControlStateNormal];
    }
    
    self.CustomerSave.tag = 101;
    self.CustomerDel.tag = 102;
    self.CustomerTypeBtn.tag = 103;
    [self.CustomerSave addTarget:self action:@selector(ActionsBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.CustomerDel addTarget:self action:@selector(ActionsBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.CustomerTypeBtn addTarget:self action:@selector(ActionsBtn:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)leftClicked{
    
    [self goBack];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)ActionsBtn:(UIButton *)Send
{
    [self.view endEditing:YES];
    UIButton *btn = (UIButton *)Send;
    if (btn.tag == 101) {
        if (self.CustomerPhone.text.length ==0) {
            [SVProgressHUD showErrorWithStatus:@"请输入会员手机号"];
            return;
        }
    }
    NSString *status = [NSString stringWithFormat:@"%@",[self.CustomerDIC objectForKey:@"Status"]];
    NSString *Title = @"";
    switch (btn.tag) {
        case 101:
            Title = @"确定新增客服";
            break;
        case 102:
            Title = @"确定删除客服";
            break;
        case 103:
            if ([status isEqualToString:@"1"]) {
                Title = @"确定禁用客服";
            }else
            {
                Title = @"确定启用客服";
            }
            break;
        default:
            break;
    }
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:Title
                                                            delegate:self
                                                   cancelButtonTitle:@"取消"
                                              destructiveButtonTitle:nil
                                                   otherButtonTitles:@"确认", nil];
    
    actionSheet.tag = 1009;
    [actionSheet showInView:self.view];


}

#pragma mark - ActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if ( actionSheet.tag == 1009 ) {
        
        if ( buttonIndex != [actionSheet cancelButtonIndex]) {
            //新增客服
            if ([self.CustomerType isEqualToString:@"1"]) {
                
                [self requestddCustomer];
                
            }else
            {
                if ([actionSheet.title isEqualToString:@"确定删除客服"]) {
                    //删除客服
                    [self requestdelCustomer];
                }else
                {
                NSString *status = [NSString stringWithFormat:@"%@",[self.CustomerDIC objectForKey:@"Status"]];
                //禁用客服
                if ([status isEqualToString:@"1"]) {
                    
                    [self requestCustomerStatus:@"0"];
                }else
                {//启用客服
                    [self requestCustomerStatus:@"1"];

                }
                }
                
            }
            
        }
    }
}

//添加客服
- (void)requestddCustomer{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        return;
    }
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  memberId,     @"memberId",
                                  key,   @"key",
                                  self.CustomerPhone.text,@"Account",
                                  nil];
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"AddCustomerService.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            [SVProgressHUD dismiss];
 
            [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(actionPushup) userInfo:nil repeats:NO];
            
        } else {
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
        
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];
    
}

//删除客服
- (void)requestdelCustomer{

    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        return;
    }
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  memberId,     @"memberId",
                                  key,   @"key",
                                  [NSString stringWithFormat:@"%@",[self.CustomerDIC objectForKey:@"CustomerServiceID"]],@"CustomerServiceID",
                                  nil];
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"DeleteCustomerService.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            [SVProgressHUD dismiss];
            
            [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(actionPushup) userInfo:nil repeats:NO];
            
        } else {
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
        
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];
    
}

//设置客服状态
- (void)requestCustomerStatus:(NSString *)status{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        return;
    }
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  memberId,     @"memberId",
                                  key,   @"key",
                                  [NSString stringWithFormat:@"%@",[self.CustomerDIC objectForKey:@"CustomerServiceID"]],@"CustomerServiceID",
                                  status,@"Status",
                                  nil];
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"ChangeCustomerServiceStatus.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            [SVProgressHUD dismiss];
            
            [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(actionPushup) userInfo:nil repeats:NO];
            
        } else {
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
        
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];
    
}

//返回
- (void)actionPushup
{
    [self leftClicked];
    if ( self.delegate && [self.delegate respondsToSelector:@selector(EditorCustomeraction)] ) {
        [self.delegate EditorCustomeraction];
        
    }
    
}




@end
