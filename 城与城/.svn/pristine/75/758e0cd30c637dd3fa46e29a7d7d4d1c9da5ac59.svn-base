//
//  SearchNumberViewController.m
//  HuiHui
//
//  Created by mac on 13-12-3.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import "SearchNumberViewController.h"

#import "CommonUtil.h"

#import "SVProgressHUD.h"

#import "AppHttpClient.h"

#import "ResultViewController.h"

#import "InviteViewController.h"

@interface SearchNumberViewController ()

@property (weak, nonatomic) IBOutlet UITextField *m_phoneTextField;

@end

@implementation SearchNumberViewController

@synthesize m_friendsArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        m_friendsArray = [[NSMutableArray alloc]initWithCapacity:0];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setTitle:@"搜号码"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    [self setRightButtonWithTitle:@"搜索" action:@selector(rightClicked)];
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self hideTabBar:YES];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [self hideTabBar:NO];
    
    [self.m_phoneTextField resignFirstResponder];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)leftClicked{
    
    [SVProgressHUD dismiss];

    [self goBack];
}

- (void)rightClicked{
    
    if ( self.m_phoneTextField.text.length == 0 ) {
        [SVProgressHUD showErrorWithStatus:@"请输入要搜索的内容"];
        return;
    }else if ([self.m_phoneTextField.text isEqualToString:[CommonUtil getValueByKey:ACCOUNT]])
    {
        [SVProgressHUD showErrorWithStatus:@"不能添加自己为好友"];
        return;
    }
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        return;
    }
    
    self.navigationController.navigationItem.rightBarButtonItem.enabled = NO;
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,     @"memberId",
                           key,   @"key",
                           self.m_phoneTextField.text,@"content",
                           nil];
    [SVProgressHUD showWithStatus:@"正在搜索…"];
    [httpClient request:@"PhoneSearch.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            
           [SVProgressHUD dismiss];
            
           self.m_friendsArray = [json valueForKey:@"attentionInfo"];
            
            // 进入搜索结果的页面
            ResultViewController *VC = [[ResultViewController alloc]initWithNibName:@"ResultViewController" bundle:nil];
            VC.m_typeString = @"1";
            VC.m_searchString = [NSString stringWithFormat:@"%@",self.m_phoneTextField.text];
            [self.navigationController pushViewController:VC animated:YES];
//            [self.SearchNumberNav pushViewController:VC animated:YES];
            
        } else {

            self.navigationController.navigationItem.rightBarButtonItem.enabled = YES;


            [SVProgressHUD dismiss];
            
            [self.view endEditing:YES];
            
            // 如果不存在就去邀请
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示"
                                                               message:@"您搜索的号码不是城与城的会员"
                                                              delegate:self
                                                     cancelButtonTitle:@"取消"
                                                     otherButtonTitles:@"去邀请", nil];
            
            alertView.tag = 11093;
            [alertView show];
            
            
            
            
        }
    } failure:^(NSError *error) {
        //NSLog(@"failed:%@", error);
//        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        self.navigationController.navigationItem.rightBarButtonItem.enabled = YES;

    }];

}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if ( alertView.tag == 11093 ) {
        
        if ( buttonIndex == 1 ) {
            
            // 进入邀请好友的页面
            InviteViewController *VC = [[InviteViewController alloc]initWithNibName:@"InviteViewController" bundle:nil];
            VC.stringType = @"3";
            
            // 判断如果搜索的是手机号码，则直接传值到邀请页面进行赋值
            if ( [self isMobileNumber:self.m_phoneTextField.text] ) {
                
                VC.m_phoneString = self.m_phoneTextField.text;
                
            }else{
                
                VC.m_phoneString = @"";
            }
            
            [self.navigationController pushViewController:VC animated:YES];
//            [self.SearchNumberNav pushViewController:VC animated:YES];

        }
    }
    
    
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    [self hiddenNumPadDone:nil];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    // 搜索结果
    [self rightClicked];
    
    return YES;
}

@end
