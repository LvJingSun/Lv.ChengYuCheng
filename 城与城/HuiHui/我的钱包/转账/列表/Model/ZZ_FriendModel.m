//
//  ZZ_FriendModel.m
//  HuiHui
//
//  Created by mac on 2017/6/30.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "ZZ_FriendModel.h"

@implementation ZZ_FriendModel

- (instancetype)initWithDict:(NSDictionary *)dic {

    if (self = [super init]) {
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"iconImg"]] forKey:@"iconImg"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"friendName"]] forKey:@"friendName"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"friendPhone"]] forKey:@"friendPhone"];
        
    }
    
    return self;
    
}

+ (instancetype)ZZ_FriendModelWithDict:(NSDictionary *)dic {

    return [[self alloc] initWithDict:dic];
    
}

@end
