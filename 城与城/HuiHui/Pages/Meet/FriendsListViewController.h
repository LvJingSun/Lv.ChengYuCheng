//
//  FriendsListViewController.h
//  HuiHui
//
//  Created by mac on 14-5-4.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "BaseViewController.h"

#import "FriendHelper.h"

@interface FriendsListViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>{
    
    FriendHelper  *friendHelp;
}


@property (nonatomic, strong) NSMutableArray        *m_friendsList;

@property (nonatomic, strong) NSArray               *m_allKeys;

@property (nonatomic, strong) NSMutableDictionary   *m_FriendsListDic;

// 记录来自于哪个页面  1表示来自于消息右上角按钮  2表示来自于转发
@property (nonatomic, strong) NSString              *m_typeString;

// 记录选中的是哪个好友进行转发的
@property (nonatomic, assign) NSInteger             m_section;

@property (nonatomic, assign) NSInteger             m_index;
// 记录转发那边聊天的userId
@property (nonatomic, strong) NSString              *m_userId;


// 我的好友请求数据
- (void)friendsRequest;

@end
