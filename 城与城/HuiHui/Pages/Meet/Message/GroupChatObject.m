//
//  GroupChatObject.m
//  HuiHui
//
//  Created by mac on 14-9-23.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "GroupChatObject.h"

#import "Configuration.h"

#import "GroupObject.h"

#import "MessageAndUserObject.h"

@implementation GroupChatObject

@synthesize messageContent;
@synthesize messageDate;
@synthesize messageFrom;
@synthesize messageTo;
@synthesize messageType;
@synthesize messageId;
@synthesize isRead;
@synthesize messageImageV;

+(GroupChatObject *)messageWithType:(int)aType{
    GroupChatObject *msg=[[GroupChatObject alloc]init];
    [msg setMessageType:[NSNumber numberWithInt:aType]];
    return  msg;
}
+(GroupChatObject*)messageFromDictionary:(NSDictionary*)aDic
{
    GroupChatObject *msg=[[GroupChatObject alloc]init];
    [msg setMessageFrom:[aDic objectForKey:kMESSAGE_FROM]];
    [msg setMessageTo:[aDic objectForKey:kMESSAGE_TO]];
    [msg setMessageContent:[aDic objectForKey:kMESSAGE_CONTENT]];
    [msg setMessageDate:[aDic objectForKey:kMESSAGE_DATE]];
    [msg setMessageType:[aDic objectForKey:kMESSAGE_TYPE]];
    [msg setIsRead:[aDic objectForKey:kMESSAGE_ISREAD]];
    [msg setMessageImageV:[aDic objectForKey:kMESSAGE_IMAGE]];
    return  msg;
}


//将对象转换为字典
-(NSDictionary*)toDictionary
{
    NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:messageId,kMESSAGE_ID,messageFrom,kMESSAGE_FROM,messageTo,kMESSAGE_TO,messageContent,kMESSAGE_CONTENT,messageDate,kMESSAGE_DATE,messageType,kMESSAGE_TYPE,isRead,kMESSAGE_ISREAD,messageImageV,kMESSAGE_IMAGE, nil];
    return dic;
    
}

//增删改查

+(BOOL)save:(GroupChatObject*)aMessage
{
    
    NSString *path = [self dataBasePathString];
    
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    if (![db open]) {
        NSLog(@"数据库打开失败");
        return NO;
    };
    
    NSString *createStr = @"CREATE  TABLE  IF NOT EXISTS 'huihuiGroupMessage' ('messageId' INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL  UNIQUE , 'messageFrom' VARCHAR, 'messageTo' VARCHAR, 'messageContent' VARCHAR, 'messageDate' DATETIME,'messageType' INTEGER ,'isRead' VARCHAR,'messageImageV' VARCHAR)";
    
    BOOL worked = [db executeUpdate:createStr];
    FMDBQuickCheck(worked);
    
    NSString *insertStr = @"INSERT INTO 'huihuiGroupMessage' ('messageFrom','messageTo','messageContent','messageDate','messageType','isRead','messageImageV') VALUES (?,?,?,?,?,?,?)";
    worked = [db executeUpdate:insertStr,aMessage.messageFrom,aMessage.messageTo,aMessage.messageContent,aMessage.messageDate,aMessage.messageType,aMessage.isRead,aMessage.messageImageV];
    FMDBQuickCheck(worked);
    
    [db close];
    
    //发送全局通知
    //    [[NSNotificationCenter defaultCenter]postNotificationName:kXMPPNewMsgNotifaction object:aMessage];
    
    return worked;
}

//获取某联系人聊天记录
+(NSMutableArray*)fetchMessageListWithUser:(NSString *)userId byPage:(int)pageInde
{
    
    NSMutableArray *messageList=[[NSMutableArray alloc]init];
    
    NSString *path = [self dataBasePathString];
    
    FMDatabase *db=[FMDatabase databaseWithPath:path];
    if (![db open]) {
        NSLog(@"数据打开失败");
        return messageList;
    }
    
    
    NSString *queryString = @"select * from huihuiGroupMessage where (messageFrom=? and messageTo=?) or ( messageFrom = ? and messageTo = ?) order by messageDate";
    
    FMResultSet *rs=[db executeQuery:queryString,userId,[[NSUserDefaults standardUserDefaults]objectForKey:kMY_USER_ID],[[NSUserDefaults standardUserDefaults]objectForKey:kMY_USER_ID],userId];
    
    while ([rs next]) {
        GroupChatObject *message=[[GroupChatObject alloc]init];
        [message setMessageId:[rs objectForColumnName:kMESSAGE_ID]];
        [message setMessageContent:[rs stringForColumn:kMESSAGE_CONTENT]];
        [message setMessageDate:[rs dateForColumn:kMESSAGE_DATE]];
        [message setMessageFrom:[rs stringForColumn:kMESSAGE_FROM]];
        [message setMessageTo:[rs stringForColumn:kMESSAGE_TO]];
        [message setMessageType:[rs objectForColumnName:kMESSAGE_TYPE]];
        [message setIsRead:[rs objectForColumnName:kMESSAGE_ISREAD]];
        [message setMessageImageV:[rs objectForColumnName:kMESSAGE_IMAGE]];
        
        [messageList addObject:message];
        
    }
    
    return  messageList;
    
}

//获取最近联系人
+(NSMutableArray *)fetchRecentChatByPage:(int)pageIndex
{
    NSMutableArray *messageList=[[NSMutableArray alloc]init];
    
    
    NSString *path = [self dataBasePathString];
    
    FMDatabase *db=[FMDatabase databaseWithPath:path];
    if (![db open]) {
        NSLog(@"数据打开失败");
        return messageList;
    }
    
    
    NSString *queryString = @"select * from huihuiGroupMessage as m ,huihuiGroupUser as u where u.friendId = ? and ( u.userId=m.messageFrom or u.userId=m.messageTo ) and (u.friendId=m.messageFrom or u.friendId=m.messageTo) group by u.userId order by m.messageDate desc limit ?,10";
    
    FMResultSet *rs = [db executeQuery:queryString,[[NSUserDefaults standardUserDefaults]objectForKey:kMY_USER_ID],[NSNumber numberWithInt:pageIndex-1]];
    
    
    
    while ([rs next]) {
        
        GroupChatObject *message=[[GroupChatObject alloc]init];
        [message setMessageId:[rs objectForColumnName:kMESSAGE_ID]];
        [message setMessageContent:[rs stringForColumn:kMESSAGE_CONTENT]];
        [message setMessageDate:[rs dateForColumn:kMESSAGE_DATE]];
        [message setMessageFrom:[rs stringForColumn:kMESSAGE_FROM]];
        [message setMessageTo:[rs stringForColumn:kMESSAGE_TO]];
        [message setMessageType:[rs objectForColumnName:kMESSAGE_TYPE]];
        [message setIsRead:[rs objectForColumnName:kMESSAGE_ISREAD]];
        [message setMessageImageV:[rs objectForColumnName:kMESSAGE_IMAGE]];

        GroupObject *user=[[GroupObject alloc]init];
        [user setUserId:[rs stringForColumn:kUSER_ID]];
        [user setFriendId:[rs stringForColumn:kUSER_FRIENDID]];
        [user setUserNickName:[rs stringForColumn:kUSER_NICKNAME]];
        [user setUserHead:[rs stringForColumn:kUSER_USERHEAD]];
        [user setUserDescription:[rs stringForColumn:kUSER_DESCRIPTION]];
        [user setFriendFlag:[rs objectForColumnName:kUSER_FRIEND_FLAG]];
        [user setMesgId:[rs objectForColumnName:kUSER_MESGID]];
        
        
        MessageAndUserObject *unionObject = [MessageAndUserObject unionWithGroup:message andObject:user];
        
        [messageList addObject:unionObject];
        
    }
    return  messageList;
    
}

+ (BOOL)delereUserId:(NSString *)aUserId{
    
    
    NSString *path = [self dataBasePathString];
    
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    if (![db open]) {
        NSLog(@"数据打开失败");
        
    }
    
    NSString *deleteString = @"delete from huihuiGroupUser where userId=?";
    
    BOOL worked = [db executeUpdate:deleteString,aUserId];
    
    [db close];
    
    return worked;
    
    
}

+(NSInteger)fetchCountWithUser:(NSString *)userId byPage:(int)pageIndex
{
    NSMutableArray *messageList=[[NSMutableArray alloc]init];
    
    NSInteger unReadCount = 0;
    
    
    NSString *path = [self dataBasePathString];
    
    
    FMDatabase *db=[FMDatabase databaseWithPath:path];
    if (![db open]) {
        NSLog(@"数据打开失败");
        return unReadCount;
    }
    
    NSString *queryString = @"select * from huihuiGroupMessage where messageTo=? order by messageDate";
    
    FMResultSet *rs = [db executeQuery:queryString,userId];
    
    while ([rs next]) {
        GroupChatObject *message = [[GroupChatObject alloc]init];
        [message setMessageId:[rs objectForColumnName:kMESSAGE_ID]];
        [message setMessageContent:[rs stringForColumn:kMESSAGE_CONTENT]];
        [message setMessageDate:[rs dateForColumn:kMESSAGE_DATE]];
        [message setMessageFrom:[rs stringForColumn:kMESSAGE_FROM]];
        [message setMessageTo:[rs stringForColumn:kMESSAGE_TO]];
        [message setMessageType:[rs objectForColumnName:kMESSAGE_TYPE]];
        [message setIsRead:[rs objectForColumnName:kMESSAGE_ISREAD]];
        [message setMessageImageV:[rs objectForColumnName:kMESSAGE_IMAGE]];

        [messageList addObject:message];
        
    }
    
    for (int i = 0; i < messageList.count; i++) {
        
        GroupChatObject *message = [messageList objectAtIndex:i];
        
        unReadCount = unReadCount + [message.isRead integerValue];
        
    }
    
    return  unReadCount;
    
}

// 将未读消息的状态转化为已读的状态
+ (BOOL)updateMessage:(NSString *)aUserId{
    
    
    NSString *path = [self dataBasePathString];
    
    FMDatabase *db=[FMDatabase databaseWithPath:path];
    if ( ![db open] ) {
        NSLog(@"数据打开失败");
        
    }
    
    NSString *deleteString = @"update huihuiGroupMessage set isRead = ? where messageTo=?";
    
    BOOL worked = [db executeUpdate:deleteString,@"0",aUserId];
    
    [db close];
    
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

+ (BOOL)deleteMessageFromUserId:(NSString *)aUserId{
    
    NSString *path = [self dataBasePathString];
    
    FMDatabase *db=[FMDatabase databaseWithPath:path];
    if (![db open]) {
        NSLog(@"数据打开失败");
        
    }
    
    NSString *queryString = @"delete from huihuiGroupMessage where (messageTo=?)";
    
    BOOL worked = [db executeUpdate:queryString,aUserId];
    
    [db close];
    
    return worked;
    
    
}

+ (BOOL)deleteMessageFromUserId:(NSString *)aUserId toUserId:(NSString *)bUserId withDate:(NSDate *)aDate{
    
    NSString *path = [self dataBasePathString];
    
    FMDatabase *db=[FMDatabase databaseWithPath:path];
    if (![db open]) {
        NSLog(@"数据打开失败");
        
    }
    
    NSString *queryString = @"delete from huihuiGroupMessage where (messageFrom=? and messageTo=? and messageDate = ?)";
    
    BOOL worked = [db executeUpdate:queryString,aUserId,bUserId,aDate];
    
    [db close];
    
    return worked;
    
}

+(NSMutableArray*)fetchGroupList:(NSString *)groupId byPage:(int)pageIndex{
    
    NSMutableArray *messageList=[[NSMutableArray alloc]init];
    
    NSString *path = [self dataBasePathString];
    
    FMDatabase *db=[FMDatabase databaseWithPath:path];
    if (![db open]) {
        NSLog(@"数据打开失败");
        return messageList;
    }
    
    
    NSString *queryString = @"select * from huihuiGroupMessage where (messageTo=?) order by messageDate";
    
    FMResultSet *rs = [db executeQuery:queryString,groupId];
    
    while ([rs next]) {
        GroupChatObject *message = [[GroupChatObject alloc]init];
        [message setMessageId:[rs objectForColumnName:kMESSAGE_ID]];
        [message setMessageContent:[rs stringForColumn:kMESSAGE_CONTENT]];
        [message setMessageDate:[rs dateForColumn:kMESSAGE_DATE]];
        [message setMessageFrom:[rs stringForColumn:kMESSAGE_FROM]];
        //        [message setMessageTo:[rs stringForColumn:kMESSAGE_TO]];
        
        [message setMessageTo:[[NSUserDefaults standardUserDefaults]objectForKey:kMY_USER_ID]];
        [message setMessageType:[rs objectForColumnName:kMESSAGE_TYPE]];
        [message setIsRead:[rs objectForColumnName:kMESSAGE_ISREAD]];
        [message setMessageImageV:[rs objectForColumnName:kMESSAGE_IMAGE]];

        [messageList addObject:message];
        
    }
    
    return  messageList;
    
}


//获取最近联系人
+(NSMutableArray *)fetchGroupByPage:(int)pageIndex
{
    NSMutableArray *messageList=[[NSMutableArray alloc]init];
    
    
    NSString *path = [self dataBasePathString];
    
    FMDatabase *db=[FMDatabase databaseWithPath:path];
    if (![db open]) {
        NSLog(@"数据打开失败");
        return messageList;
    }
    
    
    //    NSString *queryString = @"select * from huihuiGroupMessage as m ,huihuiGroupUser as u where u.friendId = ? and ( u.userId=m.messageTo ) group by u.friendId order by m.messageDate desc limit ?,10";
    
  
    NSString *queryString = @"select * from huihuiGroupMessage as m ,huihuiGroupUser as u where u.friendId = ? group by u.friendId order by m.messageDate desc limit ?,10";

    
    FMResultSet *rs = [db executeQuery:queryString,[[NSUserDefaults standardUserDefaults]objectForKey:kMY_USER_ID],[NSNumber numberWithInt:pageIndex-1]];

    
    
    while ([rs next]) {
        
        GroupChatObject *message = [[GroupChatObject alloc]init];
        [message setMessageId:[rs objectForColumnName:kMESSAGE_ID]];
        [message setMessageContent:[rs stringForColumn:kMESSAGE_CONTENT]];
        [message setMessageDate:[rs dateForColumn:kMESSAGE_DATE]];
        [message setMessageFrom:[rs stringForColumn:kMESSAGE_FROM]];
        [message setMessageTo:[rs stringForColumn:kMESSAGE_TO]];
        [message setMessageType:[rs objectForColumnName:kMESSAGE_TYPE]];
        [message setIsRead:[rs objectForColumnName:kMESSAGE_ISREAD]];
        [message setMessageImageV:[rs objectForColumnName:kMESSAGE_IMAGE]];

        GroupObject *user = [[GroupObject alloc]init];
        [user setUserId:[rs stringForColumn:kUSER_ID]];
        [user setFriendId:[rs stringForColumn:kUSER_FRIENDID]];
        [user setUserNickName:[rs stringForColumn:kUSER_NICKNAME]];
        [user setUserHead:[rs stringForColumn:kUSER_USERHEAD]];
        [user setUserDescription:[rs stringForColumn:kUSER_DESCRIPTION]];
        [user setFriendFlag:[rs objectForColumnName:kUSER_FRIEND_FLAG]];
        [user setMesgId:[rs objectForColumnName:kUSER_MESGID]];
        
        
        MessageAndUserObject *unionObject = [MessageAndUserObject unionWithGroup:message andObject:user];
        
        [messageList addObject:unionObject];
       
        
    }
    return  messageList;
    
}


+ (BOOL)deleteGroupMessage{
    
    NSString *path = [self dataBasePathString];
    
    FMDatabase *db=[FMDatabase databaseWithPath:path];
    if (![db open]) {
        NSLog(@"数据打开失败");
        
    }
    
    NSString *queryString = @"delete from huihuiGroupUser where (friendId=?)";
    
    BOOL worked = [db executeUpdate:queryString,[[NSUserDefaults standardUserDefaults]objectForKey:kMY_USER_ID]];
    
    [db close];
    
    return worked;
    
    
}


+ (BOOL)deleteFromAllMessage{
    
    NSString *path = [self dataBasePathString];
    
    FMDatabase *db=[FMDatabase databaseWithPath:path];
    if (![db open]) {
        NSLog(@"数据打开失败");
        
    }
    
    NSString *queryString = @"delete from huihuiGroupMessage";
    
    BOOL worked = [db executeUpdate:queryString];
    
    [db close];
    
    return worked;
    
    
}



// 获取最近群聊的所有联系人
+ (NSMutableArray *)fetchAllGroup
{
    NSMutableArray *messageList=[[NSMutableArray alloc]init];
    
    
    NSString *path = [self dataBasePathString];
    
    FMDatabase *db=[FMDatabase databaseWithPath:path];
    if (![db open]) {
        NSLog(@"数据打开失败");
        return messageList;
    }
    
    
    //    NSString *queryString = @"select * from huihuiGroupMessage as m ,huihuiGroupUser as u where u.friendId = ? and ( u.userId=m.messageTo ) group by u.friendId order by m.messageDate desc limit ?,10";
    
    
    NSString *queryString = @"select * from huihuiGroupUser where friendId = ?";
    
    
    FMResultSet *rs = [db executeQuery:queryString,[[NSUserDefaults standardUserDefaults]objectForKey:kMY_USER_ID]];
    
    
    
    while ([rs next]) {
        
//        GroupChatObject *message = [[GroupChatObject alloc]init];
//        [message setMessageId:[rs objectForColumnName:kMESSAGE_ID]];
//        [message setMessageContent:[rs stringForColumn:kMESSAGE_CONTENT]];
//        [message setMessageDate:[rs dateForColumn:kMESSAGE_DATE]];
//        [message setMessageFrom:[rs stringForColumn:kMESSAGE_FROM]];
//        [message setMessageTo:[rs stringForColumn:kMESSAGE_TO]];
//        [message setMessageType:[rs objectForColumnName:kMESSAGE_TYPE]];
//        [message setIsRead:[rs objectForColumnName:kMESSAGE_ISREAD]];
        
        GroupObject *user = [[GroupObject alloc]init];
        [user setUserId:[rs stringForColumn:kUSER_ID]];
        [user setFriendId:[rs stringForColumn:kUSER_FRIENDID]];
        [user setUserNickName:[rs stringForColumn:kUSER_NICKNAME]];
        [user setUserHead:[rs stringForColumn:kUSER_USERHEAD]];
        [user setUserDescription:[rs stringForColumn:kUSER_DESCRIPTION]];
        [user setFriendFlag:[rs objectForColumnName:kUSER_FRIEND_FLAG]];
        [user setMesgId:[rs objectForColumnName:kUSER_MESGID]];
        
        
//        MessageAndUserObject *unionObject = [MessageAndUserObject unionWithGroup:message andObject:user];
        
        [messageList addObject:user];
       
        
    }
    return  messageList;
    
}



@end
