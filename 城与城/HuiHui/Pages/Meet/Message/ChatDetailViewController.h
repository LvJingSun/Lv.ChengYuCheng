//
//  ChatDetailViewController.h
//  HuiHui
//
//  Created by mac on 14-10-9.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//  群的详细信息类

#import "BaseViewController.h"

#import "ChatGroup.h"

@interface ChatDetailViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>



// 用于记录群聊
@property (nonatomic, strong) ChatGroup         *group;

// 记录来自于哪个页面
@property (nonatomic, strong) NSString          *m_typeString;

// 记录群的名称
@property (nonatomic, strong) NSString          *m_groupName;

// 记录群主的名称
@property (nonatomic, strong) NSString          *m_userName;

// 记录群主的memberId
@property (nonatomic, strong) NSString          *m_groupMemberId;


// 获取群主的名字的方法
- (void)getGroupName;


@end
