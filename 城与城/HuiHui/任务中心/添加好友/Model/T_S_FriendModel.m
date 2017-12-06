//
//  T_S_FriendModel.m
//  HuiHui
//
//  Created by mac on 2017/5/10.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "T_S_FriendModel.h"

@implementation T_S_FriendModel

- (instancetype)initWithDict:(NSDictionary *)dic {

    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dic];
        
    }
    
    return self;
    
}

+ (instancetype)T_S_FriendModelWithDict:(NSDictionary *)dic {

    return [[self alloc] initWithDict:dic];
    
}

@end
