//
//  MessageDB.h
//  HuiHui
//
//  Created by mac on 14-1-24.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

extern const NSString *DB_NAME;

#import <Foundation/Foundation.h>

#import <sqlite3.h>

#import "UserMessage.h"

@interface MessageDB : NSObject{
    
    
}

+ (MessageDB *) shareObject;

- (void)closesqlDB;

- (BOOL)execSQL:(NSString *)sqlstring;

- (BOOL) saveMsgToDB:(UserMessage *)msg;

// 获取未读信息，
- (int) getUnreadMsgnum:(NSString*)userID;

- (void)changeunreand:(NSString*)userIDA;

- (NSMutableArray*)getunreadList:(NSString*)userID1;

- (NSMutableArray*)getallList:(NSString*)userID1;

- (void)deleteallmessage:(NSString*)userID;

- (NSMutableArray *) getAllMsgToShow:(Userinfo *)user;

- (void)changeunreand1:(NSString*)userIDA;


@end
