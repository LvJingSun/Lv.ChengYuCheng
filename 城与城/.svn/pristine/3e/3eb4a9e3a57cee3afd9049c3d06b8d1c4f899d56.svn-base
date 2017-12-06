//
//  FriendHelper.h
//  HuiHui
//
//  Created by mac on 14-7-18.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FriendHelper : NSObject

//获取消息列表（用了环信之后）
- (NSMutableArray *)EX_ChatList;
//更新消息列表（用了环信之后）
- (void)upEXChatData:(NSArray *)friends;

// 更新数据库中的我的好友的数据
- (void)updateData:(NSArray *)friends;

// 更新数据库中的商户数据
- (void)updateMerchantData:(NSArray *)merchant;

// 更新邀请中的好友数据
- (void)updateInviteFriends:(NSArray *)inviteFriends;

// 更新数据库中通讯录好友的数据
- (void)updateTongxunluList:(NSArray *)contactList;

// 将别人加我的数组更新到数据库中
- (void)updateOtherConternedMe:(NSArray *)memberInviteList;
// 获取别人加我的数组
- (NSMutableArray *)memberInviteList;

// 获取数据库中的数组
- (NSMutableArray *)friendsList;
// 获取商户的数组
- (NSMutableArray *)merchantList;
// 获取邀请中的好友数组
- (NSMutableArray *)inviteFriendsList;

// 获取新朋友里面通讯录里面增加的人
- (NSMutableArray *)contactList;

// 读取新朋友的个数
- (void)upDateNewFriendCont:(NSArray *)friendCount;

- (NSMutableArray *)newFriendsCount;

// 未读状态改为已读的状态
+ (BOOL)updateIsreadNewFriendsCount;

// 改变值
+ (BOOL)updateMemFan:(NSString *)memFancount withMemInvitingAcount:(NSString *)aCount withNewFriendCount:(NSString *)aNewFriendsCount;
// 红点数据
- (void)updateRedDot:(NSArray *)redDotArray;

- (NSArray *)redDotArray;


// 红点保存数据-朋友圈动态的红点数
//- (void)updateDynamictCount:(NSString *)DynamicCount;
- (void)updateDynamictCount:(NSString *)DynamicCount withDynamicComments:(NSString *)DynamicComments;
- (NSString *)DynamicCount;
- (NSString *)DynamicComments;

@end
