//
//  M_Record_Model.m
//  HuiHui
//
//  Created by mac on 2017/10/12.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "M_Record_Model.h"

@implementation M_Record_Model

- (instancetype)initWithDict:(NSDictionary *)dic {
    
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dic];
        
    }
    
    return self;
    
}

+ (instancetype)M_Record_ModelWithDict:(NSDictionary *)dic {
    
    return [[self alloc] initWithDict:dic];
    
}

@end
