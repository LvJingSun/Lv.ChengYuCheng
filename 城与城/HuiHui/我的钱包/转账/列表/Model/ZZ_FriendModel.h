//
//  ZZ_FriendModel.h
//  HuiHui
//
//  Created by mac on 2017/6/30.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZZ_FriendModel : NSObject

@property (nonatomic, copy) NSString *iconImg;

@property (nonatomic, copy) NSString *friendName;

@property (nonatomic, copy) NSString *friendPhone;

- (instancetype)initWithDict:(NSDictionary *)dic;

+ (instancetype)ZZ_FriendModelWithDict:(NSDictionary *)dic;

@end
