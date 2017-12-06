//
//  I_Friend.h
//  HuiHui
//
//  Created by mac on 2017/3/23.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface I_Friend : NSObject

@property (nonatomic, copy) NSString *PhotoMidUrl;

@property (nonatomic, copy) NSString *MemberInviteId;

@property (nonatomic, copy) NSString *MemberID;

@property (nonatomic, copy) NSString *InvitePhone;

@property (nonatomic, copy) NSString *NickName;

@property (nonatomic, copy) NSString *RealName;

@property (nonatomic, copy) NSString *PhotoUrl;

@property (nonatomic, copy) NSString *MemberStatus;

@property (nonatomic, copy) NSString *CreateDate;

@property (nonatomic, assign) BOOL isChoose;

- (instancetype)initWithDict:(NSDictionary *)dic;

+ (instancetype)I_FriendWithDict:(NSDictionary *)dic;

@end
