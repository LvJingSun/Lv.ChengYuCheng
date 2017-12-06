//
//  GoldPriceModel.m
//  HuiHui
//
//  Created by mac on 2017/9/1.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "GoldPriceModel.h"

@implementation GoldPriceModel

- (instancetype)initWithDict:(NSDictionary *)dic {

    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dic];
        
    }
    
    return self;
    
}

+ (instancetype)GoldPriceModelWithDict:(NSDictionary *)dic {

    return [[self alloc] initWithDict:dic];
    
}

@end
