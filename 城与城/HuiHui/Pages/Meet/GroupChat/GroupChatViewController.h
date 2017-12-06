//
//  GroupChatViewController.h
//  HuiHui
//
//  Created by mac on 14-8-21.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "BaseViewController.h"

#import "FriendHelper.h"

@protocol XMPPRoomDelegate;


@interface GroupChatViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,XMPPRoomDelegate>{
    
    FriendHelper  *friendHelp;
    
}


@property (nonatomic, strong) NSMutableArray        *m_friendsList;

@property (nonatomic, strong) NSArray               *m_allKeys;

@property (nonatomic, strong) NSMutableDictionary   *m_FriendsListDic;

// 记录选中的是哪个好友进行转发的
@property (nonatomic, assign) NSInteger             m_section;

@property (nonatomic, assign) NSInteger             m_index;
// 记录转发那边聊天的userId
@property (nonatomic, strong) NSString              *m_userId;

// 存储选择的人物的数组
@property (nonatomic, strong) NSMutableArray        *m_userArray;

// 存储选中的某个用户
@property (nonatomic, strong) NSMutableDictionary   *m_selectedDic;


@end
