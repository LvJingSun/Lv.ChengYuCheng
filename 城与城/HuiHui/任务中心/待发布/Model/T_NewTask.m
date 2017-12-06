//
//  T_NewTask.m
//  HuiHui
//
//  Created by mac on 2017/3/23.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "T_NewTask.h"

@implementation T_NewTask

- (instancetype)initWithDict:(NSDictionary *)dic {

    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dic];
        
    }
    
    return self;
    
}

+ (instancetype)T_NewTaskWithDict:(NSDictionary *)dic {

    return [[self alloc] initWithDict:dic];
    
}

@end
