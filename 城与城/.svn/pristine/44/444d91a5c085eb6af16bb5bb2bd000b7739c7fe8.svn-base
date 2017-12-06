//
//  ForgetPswdViewController.h
//  baozhifu
//
//  Created by mac on 13-10-9.
//  Copyright (c) 2013年 mac. All rights reserved.
//  忘记支付宝密码

#import "BaseViewController.h"

@interface ForgetPswdViewController : BaseViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIView *m_titleView;

@property (weak, nonatomic) IBOutlet UIView *m_tempView;

@property (weak, nonatomic) IBOutlet UILabel *m_question;

@property (weak, nonatomic) IBOutlet UITextField *m_answer;

@property (weak, nonatomic) IBOutlet UITextField *m_newpassword;

@property (weak, nonatomic) IBOutlet UITextField *m_againPassWord;

@property (weak, nonatomic) IBOutlet UITextField *m_validate;

@property (strong, nonatomic) NSDate *clickDateTime;

@property (strong, nonatomic) NSMutableDictionary *item;

@property (nonatomic, strong) NSString  *m_secreId;


// 提交按钮触发的事件
- (IBAction)submit:(id)sender;

// 换一题
- (IBAction)changeQuestion:(id)sender;
// 获取验证码
- (IBAction)takeValidate:(id)sender;

- (IBAction)goBackLastView:(id)sender;

// 换一题请求数据
- (void)changQuestionSubmit;

// 提交请求数据
- (void)requestSubmit;

@end
