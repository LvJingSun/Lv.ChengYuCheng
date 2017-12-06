//
//  UserNameViewController.m
//  HuiHui
//
//  Created by mac on 13-11-20.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import "UserNameViewController.h"

#import "CommonUtil.h"

#import "SVProgressHUD.h"

#import "AppHttpClient.h"


@interface UserNameViewController ()


@end

@implementation UserNameViewController

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
    
    [self setTitle:@"修改用户名"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
   
    [self setRightButtonWithTitle:@"保存" action:@selector(rightClicked)];
    
    
    // 赋值
    self.m_nameTextField.text = [NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:NICK]];

}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self hideTabBar:YES];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    // 取消第一响应
    if ( [self.m_nameTextField isFirstResponder] ) {
        
        [self.m_nameTextField resignFirstResponder];

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

- (void)rightClicked{
        
    if ( self.m_nameTextField.text.length == 0 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请输入昵称"];
        
        return;
    }
    
    if ( self.delegate && [self.delegate respondsToSelector:@selector(getUserName:)] ) {
        
        [self.delegate performSelector:@selector(getUserName:) withObject:self.m_nameTextField.text];
    }
    
    [self goBack];
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{

    [self hiddenNumPadDone:nil];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{

    [textField resignFirstResponder];
    
    return YES;
}

@end
