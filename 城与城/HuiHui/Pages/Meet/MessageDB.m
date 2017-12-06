//
//  MessageDB.m
//  HuiHui
//
//  Created by mac on 14-1-24.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "MessageDB.h"

#import "CommonUtil.h"

const NSString *DB_NAME= @"myTableName";

static sqlite3*_sqlliteLink=nil;


@implementation MessageDB


+(MessageDB *) shareObject
{
    static MessageDB *ssssMsgDBSQL = nil;
    if(! ssssMsgDBSQL)
    {
        ssssMsgDBSQL = [[MessageDB alloc] init];
    }
    return ssssMsgDBSQL;
}

- (id)init
{
    self = [super init];
//    MainViewController*mainVC=[MainViewController shareobject];
    
    if (self)
    {
        NSString*msgDBFile=[NSString stringWithFormat:@"%@/Documents/SQL.sqlite",NSHomeDirectory()];
        
        
        if (!_sqlliteLink)
        {
            if( sqlite3_open([msgDBFile UTF8String], &_sqlliteLink)!=SQLITE_OK)
            {
                NSLog(@"数据库打开失败");
                
            }
            //创建表
            NSString *filetable = [NSString stringWithFormat: @"CREATE TABLE %@ (ID integer(20)  PRIMARY KEY  DEFAULT NULL,fromUserID Varchar(64) DEFAULT NULL,toUserID Varchar(64) DEFAULT NULL,msgType Varchar(32) DEFAULT NULL,audioOrimageFile Varchar(80) DEFAULT NULL,textMsg Varchar(256) DEFAULT NULL,msgTime Varchar(32) DEFAULT NULL,isRead integer DEFAULT 0)",DB_NAME];
            [self execSQL:filetable];
            
            
        }
    }
    return self;
}

- (void)dealloc
{
    //sqlite3_close(_sqlliteLink);
//    [super dealloc];
}

//关闭数据库链接；
-(void)closesqlDB
{
    sqlite3_close(_sqlliteLink);
    _sqlliteLink=nil;
}

//用于执行没有返回 的sql语句
-(BOOL)execSQL:(NSString*)sqlstring
{
    char*error=nil;
    
    if(sqlite3_exec(_sqlliteLink, [sqlstring UTF8String], NULL, NULL, &error)!=SQLITE_OK)
    {
//        NSLog(@"表创建失败");
        return NO;
    }
    
    return YES;
    
}


-(BOOL) saveMsgToDB:(UserMessage*)msg
{
    
    /*
     fromUserID;
     
     toUserID;
     msgType;//信息类型 TEXT
     audioOrimageFile;//语音信息、或图片；
     textMsg;//文本信息
     *msgTime;//信息时间
     isRead;//信息标志 已读，未读
     */
//    MainViewController*mainVC=[MainViewController shareobject];
    
    NSString*insertstr=[NSString stringWithFormat:@"insert into %@ (fromUserID,toUserID,msgtype,audioOrimageFile,textMsg,msgTime,isRead) values('%@','%@','%@','%@','%@','%@','%@')",DB_NAME,msg.fromUserID,msg.toUserID,msg.msgType,msg.audioOrimageFile,msg.textMsg,msg.msgTime,msg.isRead? @"1":@"0"];
    return [self execSQL:insertstr];
}


//获取未读信息（某个ID未读数量）
-(int) getUnreadMsgnum:(NSString *)userID
{
//    MainViewController*mainVC=[MainViewController shareobject];
    
    NSString *selectStr;
    if(userID!=nil)
    {
        selectStr=[NSString stringWithFormat:@"select count(*) from %@ where fromUserID='%@' and isRead='0' ",DB_NAME,userID];
    }
    else
    {
        selectStr=[NSString stringWithFormat:@"select count(*) as unReadNum from %@ where isRead='0' ",DB_NAME];
    }
    sqlite3_stmt *stam;
    if(sqlite3_prepare_v2(_sqlliteLink, [selectStr UTF8String], -1, &stam,NULL)==SQLITE_OK)
    {
        sqlite3_step(stam);
        
        NSString *strCount=[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(stam, 0)];
        
        return [strCount intValue];
    }
    return 0;
}

////获取未读消息
- (NSMutableArray*)getunreadList:(NSString*)userID1
{
    NSMutableArray*unreadarray=[[NSMutableArray alloc]init] ;
    int unReadMsgNum = [self getUnreadMsgnum:userID1];//调用获取个未读个数的函数
//    MainViewController*mainVC=[MainViewController shareobject];
    
    
    for(int i=0;i < unReadMsgNum;i++)
    {
        UserMessage*msginfo= [[UserMessage alloc]init];
        
        NSString *UnReadMsgText = [NSString stringWithFormat:@"select textMsg from %@ where fromUserID = '%@' and isRead=0 ",DB_NAME,userID1];
        
        sqlite3_stmt *stam;
        
        if(sqlite3_prepare_v2(_sqlliteLink, [UnReadMsgText UTF8String], -1, &stam,NULL)==SQLITE_OK)
        {
            sqlite3_step(stam);
            
            NSString *unReadMsgStr=[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(stam, 0)];
            msginfo.textMsg=unReadMsgStr;
            
        }
        
        NSString *UnReadMsgTime = [NSString stringWithFormat:@"select msgTime from %@ where fromUserID = '%@' and isRead=0 ",DB_NAME,userID1];
        sqlite3_stmt *stam1;
        
        if(sqlite3_prepare_v2(_sqlliteLink, [UnReadMsgTime UTF8String], -1, &stam1,NULL)==SQLITE_OK)
        {
            sqlite3_step(stam1);
            
            NSString *unReadMsgStr1=[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(stam1, 0)];
            msginfo.msgTime=unReadMsgStr1;
            
        }
        
        [unreadarray addObject:msginfo];
        
        NSString *readStr = [NSString stringWithFormat:@"update %@ set isRead = '1' where textMsg='%@'",DB_NAME,msginfo.textMsg];
        [self execSQL:readStr];
    }
    
    
    return unreadarray;
}





//获取两个人的全部对话数组
- (NSMutableArray*)getallList:(NSString*)userID1
{
//    MainViewController*mainVC=[MainViewController shareobject];
    
    if (userID1==nil)
        return nil ;
    
    NSMutableArray*unreadarray=[[NSMutableArray alloc]init];
    
    
    NSString *allReadMsgText = [NSString stringWithFormat:@"select textMsg,msgTime,fromUserID  from %@ where fromUserID ='%@' OR toUserID='%@'  ",DB_NAME ,userID1,userID1];
    
    sqlite3_stmt *stam;
    if(sqlite3_prepare_v2(_sqlliteLink, [allReadMsgText UTF8String], -1, &stam,NULL)==SQLITE_OK)
    {
        
        while (sqlite3_step(stam)==SQLITE_ROW)
        {
            UserMessage*user=[[UserMessage alloc]init];
            
            
            NSString *unReadtempstr=[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(stam, 0)];
            user.textMsg=unReadtempstr;
            
            
            unReadtempstr=[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(stam, 1)];
            user.msgTime=unReadtempstr;
            
            unReadtempstr=[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(stam, 2)];
            user.fromUserID=unReadtempstr;
            
            [unreadarray addObject:user];
        }
    }
    
    return unreadarray;
}






//获取聊天记录
-(NSMutableArray *) getAllMsgToShow:(Userinfo *)user
{
//    MainViewController *mainVC=[MainViewController shareobject];
    NSString *selsectStr;
    if(user.userID==nil) return nil;
    
    NSMutableArray *msgArray=[[NSMutableArray alloc] init];
    selsectStr=[NSString stringWithFormat:@"select fromUserID,toUserID,msgType,audioOrImageFile,textMsg,msgTime,isRead from %@ where fromUserID='%@' and toUserID='%@' or toUserID='%@' and fromUserID='%@'",DB_NAME,user.userID,[CommonUtil getValueByKey:MEMBER_ID],user.userID,[CommonUtil getValueByKey:MEMBER_ID]];
        
    sqlite3_stmt *stam;
    if(sqlite3_prepare(_sqlliteLink, [selsectStr UTF8String], -1, &stam,NULL)==SQLITE_OK)
    {
        while (sqlite3_step(stam)==SQLITE_ROW)
        {
            UserMessage *usmsg=[[UserMessage alloc] init];
            
            //from
            NSString *tempStr=[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(stam, 0)];//把返回的值转换类型char * --》NSString
            usmsg.fromUserID=tempStr;
            tempStr=nil;
            
            //to
            tempStr=[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(stam, 1)];
            usmsg.toUserID=tempStr;
            tempStr=nil;
            
            //type
            tempStr=[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(stam, 2)];
            usmsg.msgType=tempStr;
            tempStr=nil;
            
            //audio
            tempStr=[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(stam, 3)];
            usmsg.audioOrimageFile=tempStr;
            tempStr=nil;
            
            //textmsg
            tempStr=[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(stam, 4)];
            usmsg.textMsg=tempStr;
            tempStr=nil;
            
            //msgtime
            tempStr=[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(stam, 5)];
            usmsg.msgTime=tempStr;
            tempStr=nil;
            
            //isread
            tempStr=[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(stam, 6)];
            usmsg.isRead=[tempStr intValue];
            tempStr=nil;
            
            //数据库中的修改信息语句
            NSString *insertStr=[NSString stringWithFormat:@"update %@ set isRead='1' where textmsg='%@'",DB_NAME,usmsg.textMsg];
            [self execSQL:insertStr];//返回插入  成功   失败
            
            [msgArray addObject:usmsg];
        }
    }
    return msgArray;
}



//将未读变成已读
-(void)changeunreand:(NSString*)userIDA;
{
//    MainViewController*mainVC=[MainViewController shareobject];
    
    NSString *readStr = [NSString stringWithFormat:@"update %@ set isRead = 1 where fromUserID = '%@'",DB_NAME,userIDA];
    [self execSQL:readStr];
    
}

-(void)changeunreand1:(NSString*)userIDA;
{
//    MainViewController*mainVC=[MainViewController shareobject];
    NSString *readStr = [NSString stringWithFormat:@"update %@ set isRead = 1 where fromUserID = 'FROMServer'",DB_NAME];
    [self execSQL:readStr];
    
}


-(void)deleteallmessage:(NSString*)userID
{
//    MainViewController*mainVC=[MainViewController shareobject];
    
    NSString*Delestr=[NSString stringWithFormat:@"delete  from %@ where fromUserID='%@' OR toUserID='%@' ",DB_NAME,userID,userID];
    [self execSQL:Delestr];
    
    
}

@end
