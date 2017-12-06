//
//  ContactHelper.m
//  HuiHui
//
//  Created by mac on 14-7-16.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//  用于存储通讯录里面的数据

#import "ContactHelper.h"

#import "FMDatabase.h"

#import "Configuration.h"


static FMDatabase *db;

@implementation ContactHelper

-(id)init {
    if (self = [super init]) {
        if (db == nil) {
//            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);

            NSString *documentDirectory = [paths objectAtIndex:0];
          
            NSString *userId = [[NSUserDefaults standardUserDefaults]objectForKey:kMY_USER_ID];
            
            //dbPath： 数据库路径，在Document中。
            NSString *dbPath = [documentDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_ContactList.db",userId]];
            
            db= [FMDatabase databaseWithPath:dbPath];
            if (![db open]) {
                NSLog(@"Could not open db.");
                return self;
            }
            [db executeUpdate:@"CREATE TABLE IF NOT EXISTS contactList (NickName text, OtmemId text, Phone text, Type text)"];
            
            
            [db close];
        }
    }
    return self;
}

- (void)updateData:(NSArray *)list {
    
    if (![db open]) {
        NSLog(@"Could not open db.");
        return;
    }
    [db beginTransaction];
//    [db executeUpdate:@"DELETE FROM version WHERE type=?", type];
//    [db executeUpdate:@"INSERT INTO version (type, ver) VALUES (?,?)", type, ver];
    
    [db executeUpdate:@"DELETE FROM contactList"];
    
    NSString *sql = @"INSERT INTO contactList (NickName, OtmemId, Phone, Type) VALUES (?,?,?,?)";
    for (NSDictionary *data in list) {
       
        [db executeUpdate:sql, [data objectForKey:@"NickName"], [data objectForKey:@"OtmemId"], [data objectForKey:@"Phone"],[data objectForKey:@"Type"]];
        
    }
    [db commit];
    [db close];
}


- (NSMutableArray *)contactList {
    
    NSMutableArray *list = [[NSMutableArray alloc] init];
    if (![db open]) {
        NSLog(@"Could not open db.");
        return list;
    }
    
    NSString *sql = @" SELECT * FROM contactList";
    FMResultSet *rs = [db executeQuery:sql];
    while ([rs next]) {
        NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithCapacity:5];
       
        NSString *NickName = [rs stringForColumn:@"NickName"];
        [data setObject:NickName forKey:@"NickName"];
      
        NSString *OtmemId = [rs stringForColumn:@"OtmemId"];
        [data setObject:OtmemId forKey:@"OtmemId"];
      
        NSString *Phone = [rs stringForColumn:@"Phone"];
        [data setObject:Phone forKey:@"Phone"];
        
        NSString *Type = [rs stringForColumn:@"Type"];
        [data setObject:Type forKey:@"Type"];

        
        [list addObject:data];
    }
    
    [rs close];
    [db close];
    return list;
}

// 关注过此人后将状态改变
+ (BOOL)updateMessage:(NSString *)OtmemId{
    
    if (![db open]) {
        NSLog(@"Could not open db.");
        return NO;
    }
    
    NSString *deleteString = @"update contactList set Type = ? where (OtmemId=?)";
    
    BOOL worked = [db executeUpdate:deleteString,@"2",OtmemId];
    
    [db close];
    
    return worked;
    
}

@end
