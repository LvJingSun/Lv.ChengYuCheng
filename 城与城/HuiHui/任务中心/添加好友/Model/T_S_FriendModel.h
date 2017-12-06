//
//  T_S_FriendModel.h
//  HuiHui
//
//  Created by mac on 2017/5/10.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface T_S_FriendModel : NSObject

//ID
@property (nonatomic, copy) NSString *MemberId;

//昵称
@property (nonatomic, copy) NSString *NickName;

//真实姓名
@property (nonatomic, copy) NSString *RealName;

//头像
@property (nonatomic, copy) NSString *MemPhoto;

//城与城账号
@property (nonatomic, copy) NSString *Account;

//好友状态 0：自己，1：已添加过的好友，2：未添加的好友
@property (nonatomic, copy) NSString *StateStr;

- (instancetype)initWithDict:(NSDictionary *)dic;

+ (instancetype)T_S_FriendModelWithDict:(NSDictionary *)dic;

@end
