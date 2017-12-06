//
//  Add_MoreFriends.m
//  HuiHui
//
//  Created by mac on 2017/3/30.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "Add_MoreFriends.h"

@implementation Add_MoreFriends

- (instancetype)initWithDict:(NSDictionary *)dic {

    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dic];
        
    }
    
    return self;
    
}

+ (instancetype)Add_MoreFriendsWithDict:(NSDictionary *)dic {

    return [[self alloc] initWithDict:dic];
    
}

@end
