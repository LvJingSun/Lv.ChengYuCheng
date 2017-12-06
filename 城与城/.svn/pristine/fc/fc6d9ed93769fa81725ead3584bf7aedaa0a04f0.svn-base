//
//  UserMessage.h
//  HuiHui
//
//  Created by mac on 14-1-24.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>

//----------发送信息类-------------
@interface UserMessage : NSObject

@property(nonatomic, strong) NSString     *fromUserID;        // 发出者的userId
@property(nonatomic, strong) NSString     *toUserID;          // 接受者的userId
@property(nonatomic, strong) NSString     *msgType;           // 信息类型 TEXT
@property(nonatomic, strong) NSString     *audioOrimageFile;  // 语音信息、或图片；
@property(nonatomic, strong) NSString     *textMsg;           // 文本信息
@property(nonatomic, strong) NSString     *msgTime;           // 信息时间
@property(nonatomic, assign) BOOL         isRead;             // 信息标志 已读，未读


@end


//----------用户信息类-------------
@interface Userinfo : NSObject<NSCoding>

@property(nonatomic, strong) NSString       *userID;        //登录ID
@property(nonatomic, strong) NSString       *userName;
@property(nonatomic, strong) NSString       *userPassword;
@property(nonatomic, strong) NSString       *userAge;
@property(nonatomic, strong) NSString       *userSex;
@property(nonatomic, strong) NSString       *userImageURL;
@property(nonatomic, strong) UIImage        *userImage;
@property(nonatomic, strong) NSString       *userType;      //类型
@property(nonatomic, strong) NSString       *userSign;      //签名
@property(nonatomic, strong) NSString       *usertime;      //注册时间
@property(nonatomic, strong) NSString       *ftime;


@end