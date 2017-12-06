//
//  GroupObject.m
//  HuiHui
//
//  Created by mac on 14-9-23.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "GroupObject.h"



#import "Configuration.h"

@implementation GroupObject

@synthesize userNickName;
@synthesize userDescription;
@synthesize friendFlag;
@synthesize userHead;
@synthesize userId;
@synthesize friendId;
@synthesize mesgId;

+(BOOL)saveNewUser:(GroupObject*)aUser
{
    
    NSString *path = [self dataBasePathString];
    
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    if (![db open]) {
        NSLog(@"数据库打开失败");
        return NO;
    };
    
    [GroupObject checkTableCreatedInDb:db];
    
    
    
    NSString *insertStr=@"INSERT INTO 'huihuiGroupUser' ('userId','friendId','nickName','description','userHead','friendFlag') VALUES (?,?,?,?,?,?)";
    BOOL worked = [db executeUpdate:insertStr,aUser.userId,aUser.friendId,aUser.userNickName,aUser.userDescription,aUser.userHead,aUser.friendFlag];
    // FMDBQuickCheck(worked);
    
    [db close];
    
    return worked;
}

+(BOOL)haveSaveUserById:(NSString*)userId withFriendId:(NSString *)aFriendId
{
    NSString *path = [self dataBasePathString];
    
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    if (![db open]) {
        NSLog(@"数据库打开失败");
        return YES;
    };
    
    [GroupObject checkTableCreatedInDb:db];
    
    FMResultSet *rs=[db executeQuery:@"select count(*) from huihuiGroupUser where userId=? and friendId =?",userId,aFriendId];
    
    while ([rs next]) {
        int count= [rs intForColumnIndex:0];
        
        if (count!=0){
            [rs close];
            return YES;
        }else
        {
            [rs close];
            return NO;
        }
        
    };
    [rs close];
    return NO;
    
}

+(BOOL)deleteUserById:(NSNumber*)userId
{
    return NO;
    
}
+(BOOL)updateUser:(GroupObject*)newUser
{
    NSString *path = [self dataBasePathString];
    
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    if (![db open]) {
        NSLog(@"数据库打开失败");
        return NO;
    };
    [GroupObject checkTableCreatedInDb:db];
    BOOL worked=[db executeUpdate:@"update huihuiGroupUser set friendFlag=?, userHead=? ,nickName=? ,description=? ,friendId=? where userId=?",newUser.friendFlag,newUser.userHead,newUser.userNickName,newUser.userDescription,newUser.friendId,newUser.userId];
    [db close];
    return worked;
    
}

+(NSMutableArray*)fetchAllFriendsFromLocal
{
    NSMutableArray *resultArr=[[NSMutableArray alloc]init];
    
    NSString *path = [self dataBasePathString];
    
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    if (![db open]) {
        NSLog(@"数据库打开失败");
        return resultArr;
    };
    [GroupObject checkTableCreatedInDb:db];
    
    FMResultSet *rs=[db executeQuery:@"select * from huihuiGroupUser where friendFlag=?",[NSNumber numberWithInt:1]];
    while ([rs next]) {
        GroupObject *user=[[GroupObject alloc]init];
        user.userId=[rs stringForColumn:kUSER_ID];
        user.friendId = [rs stringForColumn:kUSER_FRIENDID];
        user.userNickName=[rs stringForColumn:kUSER_NICKNAME];
        user.userHead=[rs stringForColumn:kUSER_USERHEAD];
        user.userDescription=[rs stringForColumn:kUSER_DESCRIPTION];
        [user setMesgId:[rs objectForColumnName:kUSER_MESGID]];
        
        user.friendFlag=[NSNumber numberWithInt:1];
        [resultArr addObject:user];
    }
    [rs close];
    [db close];
    return resultArr;
    
}

+(GroupObject*)userFromDictionary:(NSDictionary*)aDic
{
    GroupObject *user=[[GroupObject alloc]init];
    [user setUserId:[aDic objectForKey:kUSER_ID]];
    [user setFriendId:[aDic objectForKey:kUSER_FRIENDID]];
    [user setUserHead:[aDic objectForKey:kUSER_USERHEAD]];
    [user setUserDescription:[aDic objectForKey:kUSER_DESCRIPTION]];
    [user setUserNickName:[aDic objectForKey:kUSER_NICKNAME]];
    [user setMesgId:[aDic objectForKey:kUSER_MESGID]];
    [user setFriendFlag:[aDic objectForKey:kUSER_FRIEND_FLAG]];
    
    return user;
}

-(NSDictionary*)toDictionary
{
    NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:userId,kUSER_ID,friendId,kUSER_FRIENDID,userNickName,kUSER_NICKNAME,userDescription,kUSER_DESCRIPTION,userHead,kUSER_USERHEAD,friendFlag,kUSER_FRIEND_FLAG,mesgId,kUSER_MESGID, nil];
    return dic;
}


+(BOOL)checkTableCreatedInDb:(FMDatabase *)db
{
    NSString *createStr=@"CREATE  TABLE  IF NOT EXISTS 'huihuiGroupUser' ('mesgId' INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL  UNIQUE,'userId' VARCHAR, 'friendId' VARCHAR,'nickName' VARCHAR, 'description' VARCHAR, 'userHead' VARCHAR,'friendFlag' INT)";
    
    
    BOOL worked = [db executeUpdate:createStr];
    FMDBQuickCheck(worked);
    return worked;
    
}

+ (NSString *)dataBasePathString{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentDir = [paths objectAtIndex:0];
	
	NSString *dbPath = [[NSString alloc] initWithFormat:@"%@/HuihuiAPP_%@.db",documentDir,[[NSUserDefaults standardUserDefaults] objectForKey:kMY_USER_ID]];
    
    
    //	BOOL exist = [[NSFileManager defaultManager] fileExistsAtPath:dbPath];
    //
    //    if (NO == exist) {
    //
    //		NSString *filePath = [[NSString alloc] initWithFormat:@"%@/HuihuiAPP_%@.db",documentDir,[[NSUserDefaults standardUserDefaults] objectForKey:kMY_USER_ID]];
    //
    //		NSData *data = [[NSData alloc] initWithContentsOfFile:filePath];
    //		[data writeToFile:dbPath atomically:NO];
    //
    //        
    //	}
    
    
    return dbPath;
}


// 修改群聊收到的最后一条消息
+ (BOOL)updateGroupMessage:(NSString *)aDescription withUserId:(NSString *)aUserId{
    
    NSString *path = [self dataBasePathString];
    
    FMDatabase *db=[FMDatabase databaseWithPath:path];
    if ( ![db open] ) {
        NSLog(@"数据打开失败");
        
    }
    
    NSString *deleteString = @"update huihuiGroupUser set description = ? where userId = ?";
    
    BOOL worked = [db executeUpdate:deleteString,aDescription,aUserId];
    
    [db close];
    
    return worked;
    
}

@end
