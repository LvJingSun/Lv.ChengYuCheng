//
//  I_Friend.m
//  HuiHui
//
//  Created by mac on 2017/3/23.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "I_Friend.h"

@implementation I_Friend

- (instancetype)initWithDict:(NSDictionary *)dic {

    if (self = [super init]) {
        
        [self setValue:dic[@"PhotoMidUrl"] forKey:@"PhotoMidUrl"];
        
        [self setValue:dic[@"MemberInviteId"] forKey:@"MemberInviteId"];
        
        [self setValue:dic[@"MemberID"] forKey:@"MemberID"];
        
        [self setValue:dic[@"InvitePhone"] forKey:@"InvitePhone"];
        
        [self setValue:dic[@"NickName"] forKey:@"NickName"];
        
        [self setValue:dic[@"RealName"] forKey:@"RealName"];
        
        [self setValue:dic[@"PhotoUrl"] forKey:@"PhotoUrl"];
        
        [self setValue:dic[@"MemberStatus"] forKey:@"MemberStatus"];
        
        [self setValue:dic[@"CreateDate"] forKey:@"CreateDate"];
        
    }
    
    return self;
    
}

+ (instancetype)I_FriendWithDict:(NSDictionary *)dic {

    return [[self alloc] initWithDict:dic];
    
}

@end
