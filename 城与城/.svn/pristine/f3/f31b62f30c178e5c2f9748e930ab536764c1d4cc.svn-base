//
//  ModifyNoteViewController.m
//  HuiHui
//
//  Created by 冯海强 on 15-2-4.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "ModifyNoteViewController.h"

@interface ModifyNoteViewController ()

@end

@implementation ModifyNoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"修改备注"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];

    UIButton *addButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 44)];
    [addButton setTitle:@"保存" forState:UIControlStateNormal];
    [addButton.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
    [addButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [addButton addTarget:self action:@selector(rightClicked) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *_addFriendItem = [[UIBarButtonItem alloc] initWithCustomView:addButton];
    self.navigationItem.rightBarButtonItem = _addFriendItem;
    
    Notetextfield.text = self.oldNotetext;
    Notetextfield.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)leftClicked{
    
    [self goBack];
}

-(void)rightClicked{
    
    [self goBack];
    
    [self.delegate GetSaveRemarkName:Notetextfield.text];
    
    [self SaveremarkName];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [Notetextfield becomeFirstResponder];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [Notetextfield resignFirstResponder];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField;
{
    [self hiddenNumPadDone:nil];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField;
{

    [self rightClicked];
    
    return YES;
}

-(void)SaveremarkName
{
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
                           self.toMemberId,@"toMemberId",
                           Notetextfield.text,@"remarkName",
                           nil];
    
    [httpClient request:@"MemberReNameUpdate.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            
        }else
        {
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"备注名修改失败，稍后再试"];
        
    }];
}


@end
