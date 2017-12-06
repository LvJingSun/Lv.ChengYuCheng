//
//  ZZ_FunctionModel.m
//  HuiHui
//
//  Created by mac on 2017/6/30.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "ZZ_FunctionModel.h"

@implementation ZZ_FunctionModel

- (instancetype)initWithDict:(NSDictionary *)dic {

    if (self = [super init]) {
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"iconImg"]] forKey:@"iconImg"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"functionName"]] forKey:@"functionName"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"isLast"]] forKey:@"isLast"];
        
    }
    
    return self;
    
}

+ (instancetype)ZZ_FunctionModelWithDict:(NSDictionary *)dic {

    return [[self alloc] initWithDict:dic];
    
}

@end
