//
//  FriendHelper.m
//  HuiHui
//
//  Created by mac on 14-7-18.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "FriendHelper.h"

#import "FMDatabase.h"

#import "Configuration.h"


static FMDatabase *db;

@implementation FriendHelper

- (id)init {
    if (self = [super init]) {
        if (db == nil) {
//            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);

            NSString *documentDirectory = [paths objectAtIndex:0];
            
            NSString *userId = [[NSUserDefaults standardUserDefaults]objectForKey:kMY_USER_ID];
            
            //dbPath： 数据库路径，在Document中。
            NSString *dbPath = [documentDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_FriendsList.db",userId]];
            
            db = [FMDatabase databaseWithPath:dbPath];
            if (![db open]) {
                NSLog(@"Could not open db.");
                return self;
            }
            //保存环信聊天列表
            [db executeUpdate:@"CREATE TABLE IF NOT EXISTS EXChatList (RealName text, PhotoMidUrl text, NickName text, MemberId text)"];

            [db executeUpdate:@"CREATE TABLE IF NOT EXISTS friendsList (RealName text, PhotoUrl text, NickName text, MemberID text)"];
           
            [db executeUpdate:@"CREATE TABLE IF NOT EXISTS merchantList (MctName text, MerchantID text, MerchantPic text, MerchantShopId text)"];

            [db executeUpdate:@"CREATE TABLE IF NOT EXISTS inviteFriendList (InviteName text, InviteStatus text, InviteCodeView text, InvitePhone text)"];
            
            [db executeUpdate:@"CREATE TABLE IF NOT EXISTS newContactList (NickName text, OtmemId text, Phone text, Name text)"];

            [db executeUpdate:@"CREATE TABLE IF NOT EXISTS newFriendsCount (newFriendCount text,memFanCount text, contactCount text, isRead text)"];
            
            [db executeUpdate:@"CREATE TABLE IF NOT EXISTS memberInvite (MemberID text,NickName text, PhoneNumber text, PhotoUrl text, RealName text)"];

            [db executeUpdate:@"CREATE TABLE IF NOT EXISTS redDot (IntegralRecordList text,KeyList text, MemberOrder text, MemberPublicInviteList text, MemberToken text,TransactionRecords text)"];

            [db executeUpdate:@"CREATE TABLE IF NOT EXISTS DynamicCount (DynamicCount text,DynamicComments text)"];
            
            [db close];
        }
    }
    return self;
}

// 读取新朋友的个数
- (void)upDateNewFriendCont:(NSArray *)friendCount{
    
    
    if (![db open]) {
        NSLog(@"Could not open db.");
        return;
    }
    [db beginTransaction];
    //    [db executeUpdate:@"DELETE FROM version WHERE type=?", type];
    //    [db executeUpdate:@"INSERT INTO version (type, ver) VALUES (?,?)", type, ver];
    
    [db executeUpdate:@"DELETE FROM newFriendsCount"];
    
    NSString *sql = @"INSERT INTO newFriendsCount (newFriendCount,memFanCount,contactCount,isRead) VALUES (?,?,?,?)";
    
    if ( friendCount.count != 0 ) {
        
        for (NSDictionary *data in friendCount) {
            
            [db executeUpdate:sql, [data objectForKey:@"newFriendCount"],[data objectForKey:@"memFanCount"],[data objectForKey:@"contactCount"],[data objectForKey:@"isRead"]];
            
        }
    }
    
    [db commit];
    [db close];
    
}

- (void)upEXChatData:(NSArray *)friends {
    
    if (![db open]) {
        return;
    }
    [db beginTransaction];
    
    [db executeUpdate:@"DELETE FROM EXChatList"];
    
    NSString *sql = @"INSERT INTO EXChatList (RealName, PhotoMidUrl, NickName, MemberId) VALUES (?,?,?,?)";
    
    if ( friends.count != 0 ) {
        
        for (NSDictionary *data in friends) {
            
            [db executeUpdate:sql, [data objectForKey:@"RealName"], [data objectForKey:@"PhotoMidUrl"], [data objectForKey:@"NickName"],[data objectForKey:@"MemberId"]];
            
        }
    }
    
    [db commit];
    [db close];
}

- (void)updateData:(NSArray *)friends {
    
    if (![db open]) {
        NSLog(@"Could not open db.");
        return;
    }
    [db beginTransaction];
    
    [db executeUpdate:@"DELETE FROM friendsList"];
    
    NSString *sql = @"INSERT INTO friendsList (RealName, PhotoUrl, NickName, MemberID) VALUES (?,?,?,?)";
    
    if ( friends.count != 0 ) {
        
        for (NSDictionary *data in friends) {
            
            [db executeUpdate:sql, [data objectForKey:@"RealName"], [data objectForKey:@"PhotoUrl"], [data objectForKey:@"NickName"],[data objectForKey:@"MemberID"]];
            
        }
    }
   
    [db commit];
    [db close];
}



- (void)updateMerchantData:(NSArray *)merchant {
    
    if (![db open]) {
        NSLog(@"Could not open db.");
        return;
    }
    [db beginTransaction];
    
    [db executeUpdate:@"DELETE FROM merchantList"];
    
    NSString *sql = @"INSERT INTO merchantList (MctName, MerchantID, MerchantPic, MerchantShopId) VALUES (?,?,?,?)";
    
    if ( merchant.count != 0 ) {
        
        for (NSDictionary *data in merchant) {
            
            [db executeUpdate:sql, [data objectForKey:@"MctName"], [data objectForKey:@"MerchantID"], [data objectForKey:@"MerchantPic"],[data objectForKey:@"MerchantShopId"]];
            
        }
    }
    
    [db commit];
    [db close];
}

- (void)updateInviteFriends:(NSArray *)inviteFriends{
    
    if (![db open]) {
        NSLog(@"Could not open db.");
        return;
    }
    [db beginTransaction];
    
    [db executeUpdate:@"DELETE FROM inviteFriendList"];
    
    NSString *sql = @"INSERT INTO inviteFriendList (InviteName, InviteStatus, InviteCodeView, InvitePhone) VALUES (?,?,?,?)";
    
    if ( inviteFriends.count != 0 ) {
        
        
        for (NSDictionary *data in inviteFriends) {
            
            [db executeUpdate:sql, [data objectForKey:@"InviteName"], [data objectForKey:@"InviteStatus"], [data objectForKey:@"InviteCodeView"],[data objectForKey:@"InvitePhone"]];
            
        }
    }
    
    [db commit];
    [db close];
}

- (void)updateTongxunluList:(NSArray *)contactList{
    if (![db open]) {
        NSLog(@"Could not open db.");
        return;
    }
    [db beginTransaction];
    
    [db executeUpdate:@"DELETE FROM newContactList"];
    
    NSString *sql = @"INSERT INTO newContactList (NickName, OtmemId, Phone, Name) VALUES (?,?,?,?)";
  
    for (NSDictionary *data in contactList) {
        
        [db executeUpdate:sql, [data objectForKey:@"NickName"], [data objectForKey:@"OtmemId"], [data objectForKey:@"Phone"],[data objectForKey:@"Name"]];
        
    }
    [db commit];
    [db close];

}

- (NSMutableArray *)EX_ChatList {
    
    NSMutableArray *list = [[NSMutableArray alloc] init];
    if (![db open]) {
        return list;
    }
    
    NSString *sql = @" SELECT * FROM EXChatList";
    FMResultSet *rs = [db executeQuery:sql];
    while ([rs next]) {
        NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithCapacity:5];
        
        NSString *RealName = [rs stringForColumn:@"RealName"];
        [data setObject:RealName forKey:@"RealName"];
        
        NSString *PhotoUrl = [rs stringForColumn:@"PhotoMidUrl"];
        [data setObject:PhotoUrl forKey:@"PhotoMidUrl"];
        
        NSString *NickName = [rs stringForColumn:@"NickName"];
        [data setObject:NickName forKey:@"NickName"];
        
        NSString *MemberID = [rs stringForColumn:@"MemberId"];
        [data setObject:MemberID forKey:@"MemberId"];
        
        [list addObject:data];
    }
    
    [rs close];
    [db close];
    return list;
}


- (NSMutableArray *)friendsList {
    
    NSMutableArray *list = [[NSMutableArray alloc] init];
    if (![db open]) {
        NSLog(@"Could not open db.");
        return list;
    }
    
    NSString *sql = @" SELECT * FROM friendsList";
    FMResultSet *rs = [db executeQuery:sql];
    while ([rs next]) {
        NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithCapacity:5];
        
        NSString *RealName = [rs stringForColumn:@"RealName"];
        [data setObject:RealName forKey:@"RealName"];
        
        NSString *PhotoUrl = [rs stringForColumn:@"PhotoUrl"];
        [data setObject:PhotoUrl forKey:@"PhotoUrl"];
        
        NSString *NickName = [rs stringForColumn:@"NickName"];
        [data setObject:NickName forKey:@"NickName"];
        
        NSString *MemberID = [rs stringForColumn:@"MemberID"];
        [data setObject:MemberID forKey:@"MemberID"];
        
        [list addObject:data];
    }
    
    [rs close];
    [db close];
    return list;
}


- (NSMutableArray *)merchantList {
    
    NSMutableArray *list = [[NSMutableArray alloc] init];
    if (![db open]) {
        NSLog(@"Could not open db.");
        return list;
    }
    
    NSString *sql = @" SELECT * FROM merchantList";
    FMResultSet *rs = [db executeQuery:sql];
    while ([rs next]) {
        NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithCapacity:5];
        
        NSString *MctName = [rs stringForColumn:@"MctName"];
        [data setObject:MctName forKey:@"MctName"];
        
        NSString *MerchantID = [rs stringForColumn:@"MerchantID"];
        [data setObject:MerchantID forKey:@"MerchantID"];
        
        NSString *MerchantPic = [rs stringForColumn:@"MerchantPic"];
        [data setObject:MerchantPic forKey:@"MerchantPic"];
        
        NSString *MerchantShopId = [rs stringForColumn:@"MerchantShopId"];
        [data setObject:MerchantShopId forKey:@"MerchantShopId"];
        
        [list addObject:data];
    }
    
    [rs close];
    [db close];
    return list;
}

- (NSMutableArray *)inviteFriendsList {
    
    NSMutableArray *list = [[NSMutableArray alloc] init];
    if (![db open]) {
        NSLog(@"Could not open db.");
        return list;
    }
    
    NSString *sql = @" SELECT * FROM inviteFriendList";
    FMResultSet *rs = [db executeQuery:sql];
    while ([rs next]) {

        
        NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithCapacity:5];
        
        NSString *InviteName = [rs stringForColumn:@"InviteName"];
        [data setObject:InviteName forKey:@"InviteName"];
        
        NSString *InviteStatus = [rs stringForColumn:@"InviteStatus"];
        [data setObject:InviteStatus forKey:@"InviteStatus"];
        
        NSString *InviteCodeView = [rs stringForColumn:@"InviteCodeView"];
        [data setObject:InviteCodeView forKey:@"InviteCodeView"];
        
        NSString *InvitePhone = [rs stringForColumn:@"InvitePhone"];
        [data setObject:InvitePhone forKey:@"InvitePhone"];
        
        [list addObject:data];
    }
    
    [rs close];
    [db close];
    return list;
}

- (NSMutableArray *)contactList{
    
    NSMutableArray *list = [[NSMutableArray alloc] init];
    if (![db open]) {
        NSLog(@"Could not open db.");
        return list;
    }
    
    NSString *sql = @" SELECT * FROM newContactList";
    FMResultSet *rs = [db executeQuery:sql];
    while ([rs next]) {
        NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithCapacity:5];
        
        NSString *NickName = [rs stringForColumn:@"NickName"];
        [data setObject:NickName forKey:@"NickName"];
        
        NSString *OtmemId = [rs stringForColumn:@"OtmemId"];
        [data setObject:OtmemId forKey:@"OtmemId"];
        
        NSString *Phone = [rs stringForColumn:@"Phone"];
        [data setObject:Phone forKey:@"Phone"];
        
        NSString *Name = [rs stringForColumn:@"Name"];
        [data setObject:Name forKey:@"Name"];
        
        
        [list addObject:data];
    }
    
    [rs close];
    [db close];
    return list;

}

- (NSMutableArray *)newFriendsCount{
    
    
    NSMutableArray *list = [[NSMutableArray alloc] init];
    if (![db open]) {
        NSLog(@"Could not open db.");
        return list;
    }
    
    NSString *sql = @" SELECT * FROM newFriendsCount";
    FMResultSet *rs = [db executeQuery:sql];
    while ([rs next]) {
        NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithCapacity:5];
        
        NSString *newFriendCount = [rs stringForColumn:@"newFriendCount"];
        [data setObject:newFriendCount forKey:@"newFriendCount"];
        
        NSString *memFanCount = [rs stringForColumn:@"memFanCount"];
        [data setObject:memFanCount forKey:@"memFanCount"];
        
        NSString *contactCount = [rs stringForColumn:@"contactCount"];
        [data setObject:contactCount forKey:@"contactCount"];
        
        NSString *isRead = [rs stringForColumn:@"isRead"];
        [data setObject:isRead forKey:@"isRead"];
        
        [list addObject:data];
    }
    
    [rs close];
    [db close];
    return list;
}

// 未读状态改为已读的状态
+ (BOOL)updateIsreadNewFriendsCount{
    
    if (![db open]) {
        NSLog(@"Could not open db.");
        return NO;
    }
    
    NSString *deleteString = @"update newFriendsCount set isRead = ?";
    
    BOOL worked = [db executeUpdate:deleteString,@"0"];
    
    [db close];
    
    return worked;
    
}

// 改变值
+ (BOOL)updateMemFan:(NSString *)memFancount withMemInvitingAcount:(NSString *)aCount withNewFriendCount:(NSString *)aNewFriendsCount{
    
    if (![db open]) {
        NSLog(@"Could not open db.");
        return NO;
    }
    
    NSString *deleteString = @"update newFriendsCount set memFanCount = ? , contactCount = ? , newFriendCount = ? ";
    
    BOOL worked = [db executeUpdate:deleteString,memFancount,aCount,aNewFriendsCount];
    
    [db close];
    
    return worked;
    
}

// 将别人加我的数组更新到数据库中
- (void)updateOtherConternedMe:(NSArray *)memberInviteList{
    
    if (![db open]) {
        NSLog(@"Could not open db.");
        return;
    }
    [db beginTransaction];
    //    [db executeUpdate:@"DELETE FROM version WHERE type=?", type];
    //    [db executeUpdate:@"INSERT INTO version (type, ver) VALUES (?,?)", type, ver];
    
    [db executeUpdate:@"DELETE FROM memberInvite"];
    
    NSString *sql = @"INSERT INTO memberInvite (MemberID ,NickName, PhoneNumber, PhotoUrl, RealName) VALUES (?,?,?,?,?)";
    
    for (NSDictionary *data in memberInviteList) {
        
        [db executeUpdate:sql, [data objectForKey:@"MemberID"], [data objectForKey:@"NickName"], [data objectForKey:@"PhoneNumber"],[data objectForKey:@"PhotoUrl"],[data objectForKey:@"RealName"]];
        
    }
    [db commit];
    [db close];

}


// 获取别人加我的数组
- (NSMutableArray *)memberInviteList{
    
    NSMutableArray *list = [[NSMutableArray alloc] init];
    if (![db open]) {
        NSLog(@"Could not open db.");
        return list;
    }
    
    NSString *sql = @" SELECT * FROM memberInvite";
    FMResultSet *rs = [db executeQuery:sql];
 
    while ([rs next]) {
        
        NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithCapacity:5];
        
        NSString *MemberID = [rs stringForColumn:@"MemberID"];
        [data setObject:MemberID forKey:@"MemberID"];
        
        NSString *NickName = [rs stringForColumn:@"NickName"];
        [data setObject:NickName forKey:@"NickName"];
        
        NSString *PhoneNumber = [rs stringForColumn:@"PhoneNumber"];
        [data setObject:PhoneNumber forKey:@"PhoneNumber"];
        
        NSString *PhotoUrl = [rs stringForColumn:@"PhotoUrl"];
        [data setObject:PhotoUrl forKey:@"PhotoUrl"];
        
        NSString *RealName = [rs stringForColumn:@"RealName"];
        [data setObject:RealName forKey:@"RealName"];
        
        [list addObject:data];
    }
    
    [rs close];
    [db close];
    return list;
    
}

// 红点保存数据
- (void)updateRedDot:(NSArray *)redDotArray{
    if (![db open]) {
        NSLog(@"Could not open db.");
        return;
    }
    [db beginTransaction];
    //    [db executeUpdate:@"DELETE FROM version WHERE type=?", type];
    //    [db executeUpdate:@"INSERT INTO version (type, ver) VALUES (?,?)", type, ver];
    
    [db executeUpdate:@"DELETE FROM redDot"];
    
    NSString *sql = @"INSERT INTO redDot (IntegralRecordList, KeyList, MemberOrder, MemberPublicInviteList, MemberToken, TransactionRecords) VALUES (?,?,?,?,?,?)";
    
    for (NSDictionary *data in redDotArray) {
        
        [db executeUpdate:sql, [data objectForKey:@"IntegralRecordList"], [data objectForKey:@"KeyList"], [data objectForKey:@"MemberOrder"],[data objectForKey:@"MemberPublicInviteList"],[data objectForKey:@"MemberToken"],[data objectForKey:@"TransactionRecords"]];
        
    }
    [db commit];
    [db close];
    
}

// 红点的数组
- (NSMutableArray *)redDotArray{
    
    NSMutableArray *list = [[NSMutableArray alloc] init];
    if (![db open]) {
        NSLog(@"Could not open db.");
        return list;
    }
    
    NSString *sql = @"SELECT * FROM redDot";
    FMResultSet *rs = [db executeQuery:sql];
    
    while ([rs next]) {
        
        NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithCapacity:5];
        
        NSString *IntegralRecordList = [rs stringForColumn:@"IntegralRecordList"];
        [data setObject:IntegralRecordList forKey:@"IntegralRecordList"];
        
        NSString *KeyList = [rs stringForColumn:@"KeyList"];
        [data setObject:KeyList forKey:@"KeyList"];
        
        NSString *MemberOrder = [rs stringForColumn:@"MemberOrder"];
        [data setObject:MemberOrder forKey:@"MemberOrder"];
        
        NSString *MemberPublicInviteList = [rs stringForColumn:@"MemberPublicInviteList"];
        [data setObject:MemberPublicInviteList forKey:@"MemberPublicInviteList"];
        
        NSString *MemberToken = [rs stringForColumn:@"MemberToken"];
        [data setObject:MemberToken forKey:@"MemberToken"];
        
        NSString *TransactionRecords = [rs stringForColumn:@"TransactionRecords"];
        [data setObject:TransactionRecords forKey:@"TransactionRecords"];
        
        [list addObject:data];
    }
    
    [rs close];
    [db close];
    return list;
    
    
}



// 红点保存数据-朋友圈动态的红点数
- (void)updateDynamictCount:(NSString *)DynamicCount withDynamicComments:(NSString *)DynamicComments{
    
    if (![db open]) {
        NSLog(@"Could not open db.");
        return;
    }
    [db beginTransaction];
    //    [db executeUpdate:@"DELETE FROM version WHERE type=?", type];
    //    [db executeUpdate:@"INSERT INTO version (type, ver) VALUES (?,?)", type, ver];
    
    [db executeUpdate:@"DELETE FROM DynamicCount"];
    
    NSString *sql = @"INSERT INTO DynamicCount (DynamicCount,DynamicComments) VALUES (?,?)";
    
   [db executeUpdate:sql, DynamicCount,DynamicComments];
    
    
    [db commit];
    [db close];
    
}

- (NSString *)DynamicCount{
    
//    NSMutableArray *list = [[NSMutableArray alloc] init];
    
    NSString *string = @"";
    
    if (![db open]) {
        NSLog(@"Could not open db.");
        return string;
    }
    
    NSString *sql = @" SELECT * FROM DynamicCount";
    FMResultSet *rs = [db executeQuery:sql];
    
    while ([rs next]) {
        
        string = [rs stringForColumn:@"DynamicCount"];
    }
    
    [rs close];
    [db close];
    
    return string;
    
}

- (NSString *)DynamicComments{
    
    NSString *string = @"";
    
    if (![db open]) {
        NSLog(@"Could not open db.");
        return string;
    }
    
    NSString *sql = @" SELECT * FROM DynamicCount";
    FMResultSet *rs = [db executeQuery:sql];
    
    while ([rs next]) {
        
        string = [rs stringForColumn:@"DynamicComments"];
    }
    
    [rs close];
    [db close];
    
    return string;
    
}




@end
