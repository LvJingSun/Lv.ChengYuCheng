//
//  GroupChatObject.h
//  HuiHui
//
//  Created by mac on 14-9-23.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FMDatabase.h"
#import "FMResultSet.h"

#define kMESSAGE_TYPE       @"messageType"
#define kMESSAGE_FROM       @"messageFrom"
#define kMESSAGE_TO         @"messageTo"
#define kMESSAGE_CONTENT    @"messageContent"
#define kMESSAGE_DATE       @"messageDate"
#define kMESSAGE_ID         @"messageId"
#define kMESSAGE_ISREAD     @"isRead"

#define kMESSAGE_IMAGE      @"messageImageV"

//enum kWCMessageType {
//    
//    kWCMessageTypePlain = 0,
//    kWCMessageTypeImage = 1,
//    kWCMessageTypeVoice = 2,
//    kWCMessageTypeLocation = 3
//    
//};
//
//enum kWCMessageCellStyle {
//    
//    kWCMessageCellStyleMe = 0,
//    kWCMessageCellStyleOther = 1,
//    kWCMessageCellStyleMeWithImage = 2,
//    kWCMessageCellStyleOtherWithImage = 3,
//    kWCMessageCellStyleMeWithVoice = 4,
//    kWCMessageCellStyleOtherWithVoice = 5
//    
//};

@interface GroupChatObject : NSObject

@property (nonatomic,strong) NSString   *messageFrom;
@property (nonatomic,strong) NSString   *messageTo;
@property (nonatomic,strong) NSString   *messageContent;
@property (nonatomic,strong) NSDate     *messageDate;
@property (nonatomic,strong) NSNumber   *messageType;
@property (nonatomic,strong) NSNumber   *messageId;
@property (nonatomic,strong) NSString   *isRead; // 1表示未读 0表示已读的标记
// 添加个群聊天的个人头像
@property (nonatomic,strong) NSString   *messageImageV;

+ (GroupChatObject *)messageWithType:(int)aType;

// 将对象转换为字典
- (NSDictionary*)toDictionary;
+ (GroupChatObject*)messageFromDictionary:(NSDictionary*)aDic;

// 数据库增删改查
+ (BOOL)save:(GroupChatObject*)aMessage;
//+ (BOOL)deleteMessageById:(NSNumber*)aMessageId;
//+ (BOOL)merge:(MessageObject*)aMessage;

// 获取某联系人聊天记录
+ (NSMutableArray *)fetchMessageListWithUser:(NSString *)userId byPage:(int)pageIndex;

// 获取最近联系人
+ (NSMutableArray *)fetchRecentChatByPage:(int)pageIndex;

// 删除消息列表里某个联系人的数据
+ (BOOL)delereUserId:(NSString *)aUserId;
// 获取未读消息的条数
+(NSInteger)fetchCountWithUser:(NSString *)userId byPage:(int)pageIndex;

// 将未读消息的状态转化为已读的状态
+ (BOOL)updateMessage:(NSString *)aUserId;

// 获取数据库存储的路径
+ (NSString *)dataBasePathString;

// 删除某个用户的详细的聊天记录
+ (BOOL)deleteMessageFromUserId:(NSString *)aUserId;

// 删除某一条具体的聊天记录
+ (BOOL)deleteMessageFromUserId:(NSString *)aUserId toUserId:(NSString *)bUserId withDate:(NSDate *)aDate;

// 读取群聊里的聊天信息
+(NSMutableArray*)fetchGroupList:(NSString *)groupId byPage:(int)pageIndex;

// 获取群聊的联系人数组
+ (NSMutableArray *)fetchGroupByPage:(int)pageIndex;
// 清空所有的群聊的数据
+ (BOOL)deleteGroupMessage;
// 删除数据库里面的所有数据
+ (BOOL)deleteFromAllMessage;

// 获取最近群聊的所有联系人
+ (NSMutableArray *)fetchAllGroup;

@end
