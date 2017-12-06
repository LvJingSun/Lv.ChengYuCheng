//
//  Add_ContactModel.m
//  HuiHui
//
//  Created by mac on 2017/3/31.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "Add_ContactModel.h"

@implementation Add_ContactModel

- (instancetype)initWithDict:(NSDictionary *)dic {

    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dic];
        
    }
    
    return self;
    
}

+ (instancetype)Add_ContactModelWithDict:(NSDictionary *)dic {

    return [[self alloc] initWithDict:dic];
    
}

@end
