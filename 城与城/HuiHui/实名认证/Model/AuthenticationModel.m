//
//  AuthenticationModel.m
//  HuiHui
//
//  Created by mac on 2017/7/21.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "AuthenticationModel.h"

@implementation AuthenticationModel

- (instancetype)initWithDict:(NSDictionary *)dic {

    if (self = [super init]) {
        
        [self setValue:dic[@"faceImg"] forKey:@"faceImg"];
        
        [self setValue:dic[@"backImg"] forKey:@"backImg"];
        
    }
    
    return self;
    
}

+ (instancetype)AuthenticationModelWithDict:(NSDictionary *)dic {

    return [[self alloc] initWithDict:dic];
    
}

@end
