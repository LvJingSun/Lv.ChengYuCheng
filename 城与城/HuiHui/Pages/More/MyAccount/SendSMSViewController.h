//
//  SendSMSViewController.h
//  baozhifu
//
//  Created by mac on 14-3-31.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "BaseViewController.h"

@interface SendSMSViewController : BaseViewController<UITextViewDelegate>

// 存储手机号的字符
@property (nonatomic, strong) NSString *m_phone;

// 存储邮箱的字符
@property (nonatomic, strong) NSString *m_email;
// 判断来自于发送短信还是发送邮件的页面  1表示短信  2表示邮件
@property (nonatomic, strong) NSString *m_typeString;


// 请求发送短信的接口
- (void)sendSMSRequest;

// 请求发送邮件的接口
- (void)emailRequest;

@end
