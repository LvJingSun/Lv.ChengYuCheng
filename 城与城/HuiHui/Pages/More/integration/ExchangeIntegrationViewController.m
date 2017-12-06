//
//  ExchangeIntegrationViewController.m
//  baozhifu
//
//  Created by mac on 13-11-15.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "ExchangeIntegrationViewController.h"

#import "CommonUtil.h"

//#import "AppHttpClient.h"

#import "SVProgressHUD.h"

@interface ExchangeIntegrationViewController ()

@property (weak, nonatomic) IBOutlet UIView *m_tempView;

@property (weak, nonatomic) IBOutlet UIView *m_titleView;


@property (weak, nonatomic) IBOutlet UILabel *m_myIntergaLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_exchangeIntergaLabel;

@property (weak, nonatomic) IBOutlet UITextField *m_exchangeTextField;


// 确定兑换
- (IBAction)exchangeIntergation:(id)sender;

@end

@implementation ExchangeIntegrationViewController

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
    
    [self setTitle:@"积分兑换"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    self.m_exchangeTextField.delegate = self;
    
    self.m_myIntergaLabel.text = [NSString stringWithFormat:@"%.2f",[self.m_Balance floatValue]];
    
    self.m_exchangeIntergaLabel.text = [NSString stringWithFormat:@"%.2f",[self.m_Convertible floatValue]];
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self hideTabBar:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [super hideTabBar:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setM_tempView:nil];
    [self setM_titleView:nil];
    [self setM_myIntergaLabel:nil];
    [self setM_exchangeIntergaLabel:nil];
    [self setM_exchangeTextField:nil];
    [super viewDidUnload];
}

- (void)leftClicked{
    
    [self goBack];
}

- (IBAction)exchangeIntergation:(id)sender {
    
    if ( self.m_exchangeTextField.isFirstResponder ) {
        
         [self hidenKeyboard];
        
    }
    
    if ( self.m_exchangeTextField.text.length == 0 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请输入要兑换的积分"];
        
        return;
        
    }
    
    if ( [self.m_exchangeTextField.text isEqualToString:@"0"] ) {
        
        [SVProgressHUD showErrorWithStatus:@"兑换的积分不能为0,请重新输入"];
        
        return;
    }
    
    if ( [self.m_exchangeTextField.text floatValue] > [self.m_exchangeIntergaLabel.text floatValue] ) {
        
        [SVProgressHUD showErrorWithStatus:@"输入的兑换积分不能大于可兑换的积分"];
        
        return;
    }
    
    // 兑换积分请求网络
    
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
                           self.m_exchangeTextField.text, @"integralValue",
                           nil];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"CreditsTransaction.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showSuccessWithStatus:msg];
            
            [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(BackLast) userInfo:self repeats:NO];
            
        } else {
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
    } failure:^(NSError *error) {
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];

}

- (void)BackLast{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

//隐藏键盘的方法
-(void)hidenKeyboard {
    [self.m_exchangeTextField resignFirstResponder];
    
    [self resumeView];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)sender {
    
    [self hidenKeyboard];
    
    return YES;
    
}

//UITextField的协议方法，当开始编辑时监听
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    if ( textField == self.m_exchangeTextField ) {
        
        NSTimeInterval animationDuration=0.30f;
        [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
        [UIView setAnimationDuration:animationDuration];
        float width = self.view.frame.size.width;
        float height = self.view.frame.size.height;

        CGRect rect;
        
        if ( isIOS7 ) {
            
            rect=CGRectMake(0.0f,0.0f,width,height);
            
        }else{
            
            rect=CGRectMake(0.0f,-80.0f,width,height);
        }
        
        self.view.frame=rect;
        [UIView commitAnimations];
        
        [self showNumPadDone:nil];

    }
    
    return YES;
    
}

//恢复原始视图位置
-(void)resumeView {
    NSTimeInterval animationDuration=0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    float width = self.view.frame.size.width;
    float height = self.view.frame.size.height;
    float Y = 0.0f;
    
    CGRect rect;
    
    if ( isIOS7 ) {
        
        rect=CGRectMake(0.0f,64.0f,width,height);
        
    }else{
        
        rect=CGRectMake(0.0f,Y,width,height);
        
    }
    self.view.frame=rect;
    [UIView commitAnimations];
}

@end
