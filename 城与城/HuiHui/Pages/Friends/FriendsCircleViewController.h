//
//  FriendsCircleViewController.h
//  HuiHui
//
//  Created by mac on 14-5-4.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//  圈子-修改后的

#import "BaseViewController.h"

#import "FriendHelper.h"

@interface FriendsCircleViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>{
    
    FriendHelper  *friendHelp;
    
}


// 存放好友的数组
@property (strong, nonatomic) NSMutableArray            *m_friendsArray;
// 存放排序字母的数组
@property (nonatomic, strong) NSMutableArray            *m_allKeys;
// 存放排序后数据的字典
@property (nonatomic, strong) NSMutableDictionary       *m_FriendsListDic;

// 用于解决页面tableView大小的问题
@property (nonatomic, assign) BOOL                      isEnterSecondPage;

// 存储我的好友的数量的字符用于和数据库中的数据的个数进行比较
@property (nonatomic, strong) NSString                  *m_friendsCount;

@property (nonatomic, strong) NSString                  *m_memberInviteCount;

@property (nonatomic, strong) NSString                  *m_phoneString;

// 数组用于存储新朋友个数的方便存储数据库
@property (nonatomic,strong) NSMutableArray             *m_friendCount;

@property (nonatomic, strong) NSString                  *m_totalCount;

@property (nonatomic, strong) NSString                  *m_newFriendsCount;

@property (nonatomic, strong) NSString                  *m_showCount;


@end
