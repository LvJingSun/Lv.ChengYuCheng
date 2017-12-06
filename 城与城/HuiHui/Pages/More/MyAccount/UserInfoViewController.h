//
//  UserInfoViewController.h
//  baozhifu
//
//  Created by mac on 14-3-10.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "BaseViewController.h"

#import <MessageUI/MessageUI.h>

#import "ModifyNoteViewController.h"


@interface UserInfoViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,MFMessageComposeViewControllerDelegate,ModifyNoteDelegate>

@property (nonatomic, strong) NSMutableDictionary  *m_dic;

@property (nonatomic, strong) UIWebView            *m_webView;

// 记录是否选择发送短信
@property (nonatomic, assign) BOOL                  isSendMessage;

@end
