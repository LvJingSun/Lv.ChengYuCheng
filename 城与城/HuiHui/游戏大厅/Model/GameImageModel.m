//
//  GameImageModel.m
//  HuiHui
//
//  Created by mac on 2017/5/17.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "GameImageModel.h"

@implementation GameImageModel

- (instancetype)initWithDict:(NSDictionary *)dic {

    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dic];
        
    }
    
    return self;
    
}

+ (instancetype)GameImageModelWithDict:(NSDictionary *)dic {

    return [[self alloc] initWithDict:dic];
    
}

@end
