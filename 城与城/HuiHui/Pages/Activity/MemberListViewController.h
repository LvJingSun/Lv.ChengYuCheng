//
//  MemberListViewController.h
//  baozhifu
//
//  Created by mac on 14-3-13.
//  Copyright (c) 2014年 mac. All rights reserved.
//  会员列表

#import "BaseViewController.h"
#import <MessageUI/MessageUI.h>


@interface MemberListViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,MFMessageComposeViewControllerDelegate>


@property (nonatomic, strong) NSMutableArray *m_friendsArray;

// 记录来自于活动还是聚会 0:商户活动；1:聚会
@property (nonatomic, strong) NSString       *m_typeString;
// 用于传值的actId
@property (nonatomic, strong) NSString       *m_activiceId;
// 记录于拨打电话的webView
@property (nonatomic, strong) UIWebView      *m_webView;

@property (nonatomic, assign) NSInteger      m_index;

// 请求数据
- (void)memberRequestSubmit;

@end
