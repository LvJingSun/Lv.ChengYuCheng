//
//  UserInformationViewController.h
//  HuiHui
//
//  Created by mac on 13-12-3.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//  个人资料

#import "BaseViewController.h"

#import <MessageUI/MessageUI.h>
#import "ModifyNoteViewController.h"

@interface UserInformationViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,MFMessageComposeViewControllerDelegate,UIGestureRecognizerDelegate,UIScrollViewDelegate,ModifyNoteDelegate>

// 记录来自于哪个页面 1表示好友列表 2表示按号码搜索的页面（判断要不要显示“取消关注”按钮，后期已经去除这个功能）
@property (nonatomic, strong) NSString *m_typeString;

@property (strong, nonatomic) NSString  *m_RName;

// 用于请求数据的好友id
@property (nonatomic, strong) NSString  *m_friendId;

// 请求数据返回的字典
@property (nonatomic, strong) NSMutableDictionary  *m_items;

// 记录导航栏上面的按钮
@property (nonatomic, strong) UIButton     *m_titleBtn;

@property (nonatomic, strong) UIWebView    *m_webView;

// 记录是否离开了该页面
@property (nonatomic, assign) BOOL         isLeavePage;

// 记录是从聊天的头像点击进入还是其他的 1表示从聊天的头像
@property (nonatomic, strong) NSString     *m_chatString;

@property (nonatomic, strong) NSString *m_BackorPop;//还是pop（群聊的情况）

// 好友详细信息请求数据
- (void)requestSubmit;


// 取消关注请求数据
- (void)requestCancelFriends;

@end
