//
//  SEditTravellerViewController.m
//  HuiHui
//
//  Created by mac on 15-1-30.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "SEditTravellerViewController.h"

@interface SEditTravellerViewController ()

@property (weak, nonatomic) IBOutlet UITextField *m_name;

@property (weak, nonatomic) IBOutlet UITextField *m_cardId;

@property (weak, nonatomic) IBOutlet UITextField *m_phone;

@property (weak, nonatomic) IBOutlet UIScrollView *m_scrollerView;

// 删除按钮触发的事件
- (IBAction)delegateClicked:(id)sender;

@end

@implementation SEditTravellerViewController

@synthesize m_dic;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        m_dic = [[NSMutableDictionary alloc]initWithCapacity:0];
        
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"编辑信息"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    [self setRightButtonWithTitle:@"保存" action:@selector(saveTravellerClicked:)];
    
    
    // 赋值
    self.m_name.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"Name"]];
    
    self.m_cardId.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"CardNum"]];

    self.m_phone.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"MobilePhone"]];

    
    // 设置scrollerView的滚动范围
    [self.m_scrollerView setContentSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, self.m_scrollerView.frame.size.height)];
    
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

// 保存旅客信息
- (void)saveTravellerClicked:(id)sender{
    
    [self.view endEditing:YES];
    
    // 判断字符是否为空
    if ( self.m_name.text.length == 0 || [self.m_name.text isEqualToString:@"(null)"] ) {
        
        [SVProgressHUD showErrorWithStatus:@"请填写旅客姓名"];
        
        return;
        
    }
    
//    if ( self.m_cardId.text.length == 0 || [self.m_cardId.text isEqualToString:@"(null)"] ) {
//        
//        [SVProgressHUD showErrorWithStatus:@"请填写身份证号"];
//        
//        return;
//        
//    }
    
    if ( self.m_phone.text.length == 0 || [self.m_phone.text isEqualToString:@"(null)"] ) {
        
        [SVProgressHUD showErrorWithStatus:@"请填写手机号码"];
        
        return;
        
    }
    
    if ( self.m_phone.text.length != 11 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请填写正确格式的手机号码"];
        
        return;
        
    }
    
    
    // 请求编辑的jiekou
    [self EditTravellerRequest];
    
}

// 删除旅客信息
- (IBAction)delegateClicked:(id)sender {

    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@""
                                                       message:@"您确定删除该旅客的信息?"
                                                      delegate:self
                                             cancelButtonTitle:@"取消"
                                             otherButtonTitles:@"确定", nil];
    
    alertView.tag = 19230;
    [alertView show];

}

#pragma mark - NetWork
- (void)EditTravellerRequest{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    // 获取memberId
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    AppHttpClient* httpClient = [AppHttpClient scenerySharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"memberId",
                           [NSString stringWithFormat:@"%@",self.m_cardId.text],@"CardNum",
                           [NSString stringWithFormat:@"%@",self.m_phone.text],@"mobilePhone",
                           [NSString stringWithFormat:@"%@",self.m_name.text],@"name",
                           [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"Id"]],@"id",
                           nil];
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    [httpClient requestScenery:@"Scenery/ModifyTraveller.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        // status 0表示有数据 其他表示错误
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if ( success ) {
            
//            [SVProgressHUD dismiss];
            
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
            
            [self goBack];
            
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
        
        
    } failure:^(NSError *error) {
        
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}


- (void)DeleteTravellerRequest{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    // 获取memberId
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    AppHttpClient* httpClient = [AppHttpClient scenerySharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"memberId",
                           [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"Id"]],@"id",
                           nil];
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    [httpClient requestScenery:@"Scenery/DeleteTraveller.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        // status 0表示有数据 其他表示错误
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if ( success ) {
            
//            [SVProgressHUD dismiss];
            
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
            
            [self goBack];
            
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
        
        
    } failure:^(NSError *error) {
        
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}


#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{

    if ( textField == self.m_name || textField == self.m_cardId ) {
        
        [self hiddenNumPadDone:nil];
        
    }else if ( textField == self.m_phone ){
        
        [self showNumPadDone:nil];
    
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    [textField resignFirstResponder];

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    return YES;
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if ( alertView.tag == 19230 ) {
       
        if ( buttonIndex == 1 ) {
            // 删除
            [self DeleteTravellerRequest];
            
        }else{
            
        }
    }
    
}

@end
