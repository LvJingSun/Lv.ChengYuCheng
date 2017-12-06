//
//  InviteResultViewController.h
//  baozhifu
//
//  Created by mac on 13-7-23.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "BaseViewController.h"

@interface InviteResultViewController : BaseViewController<MFMessageComposeViewControllerDelegate,UIActionSheetDelegate,QQApiInterfaceDelegate,TencentSessionDelegate,UIAlertViewDelegate>{
    
    TencentOAuth                *tencentOAuth;
    
}

@property (strong, nonatomic) NSString *message;

@property (strong, nonatomic) NSString *phone;

// 记录来自于哪个页面 1表示来自于好友列表里面的查看 2表示来自于邀请好友列表
@property (strong, nonatomic) NSString *m_type;

@end
