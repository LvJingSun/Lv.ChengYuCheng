//
//  Userobject.h
//  HuiHui
//
//  Created by mac on 14-3-28.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "FMResultSet.h"

#define kUSER_ID @"userId"
#define kUSER_NICKNAME @"nickName"
#define kUSER_DESCRIPTION @"description"
#define kUSER_USERHEAD @"userHead"
#define kUSER_FRIEND_FLAG @"friendFlag"
#define kUSER_FRIENDID    @"friendId"
#define kUSER_MESGID    @"mesgId"

@interface Userobject : NSObject

@property (nonatomic,strong) NSString *userId;

@property (nonatomic,strong) NSString *userNickName;

@property (nonatomic,strong) NSString *userDescription;

@property (nonatomic,strong) NSString *userHead;

@property (nonatomic,strong) NSNumber *friendFlag;

@property (nonatomic,strong) NSString *friendId;

@property (nonatomic,strong) NSString *mesgId;


// 数据库增删改查
+ (BOOL) saveNewUser:(Userobject *)aUser;
+ (BOOL) deleteUserById:(NSNumber*)userId;
+ (BOOL) updateUser:(Userobject *)newUser;
+ (BOOL) haveSaveUserById:(NSString *)userId withFriendId:(NSString *)aFriendId;



// 获取本地的所有好友
+ (NSMutableArray *)fetchAllFriendsFromLocal;

// 将对象转换为字典
- (NSDictionary *)toDictionary;

+ (Userobject *)userFromDictionary:(NSDictionary *)aDic;

+(BOOL)checkTableCreatedInDb:(FMDatabase *)db;

+ (NSString *)dataBasePathString;

@end
