//
//  GoldBrokenLineModel.m
//  HuiHui
//
//  Created by mac on 2017/9/11.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "GoldBrokenLineModel.h"

@implementation GoldBrokenLineModel

- (instancetype)initWithDict:(NSDictionary *)dic {

    if (self = [super init]) {
        
        NSArray *valuearr = dic[@"valueArr"];
        
        [self setValue:valuearr forKey:@"valueArr"];
        
        NSArray *keyarr = dic[@"keyArr"];
        
        [self setValue:keyarr forKey:@"keyArr"];
        
    }
    
    return self;
    
}

+ (instancetype)GoldBrokenLineModelWithDict:(NSDictionary *)dic {

    return [[self alloc] initWithDict:dic];
    
}

@end
