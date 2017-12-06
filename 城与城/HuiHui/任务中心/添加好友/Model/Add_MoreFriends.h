//
//  Add_MoreFriends.h
//  HuiHui
//
//  Created by mac on 2017/3/30.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Add_MoreFriends : NSObject

@property (nonatomic, copy) NSString *iconUrl;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *MemberID;

@property (nonatomic, copy) NSString *NickName;

@property (nonatomic, copy) NSString *RealName;

@property (nonatomic, copy) NSString *PhotoMidUrl;

@property (nonatomic, copy) NSString *InviteAccount;

- (instancetype)initWithDict:(NSDictionary *)dic;

+ (instancetype)Add_MoreFriendsWithDict:(NSDictionary *)dic;

@end
