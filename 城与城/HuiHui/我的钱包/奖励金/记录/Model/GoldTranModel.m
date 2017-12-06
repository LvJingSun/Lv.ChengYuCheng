//
//  GoldTranModel.m
//  HuiHui
//
//  Created by mac on 2017/9/11.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "GoldTranModel.h"

@implementation GoldTranModel

- (instancetype)initWithDict:(NSDictionary *)dic {

    if (self = [super init]) {
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"tranType"]] forKey:@"tranType"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"count"]] forKey:@"count"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"date"]] forKey:@"date"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"status"]] forKey:@"status"];
        
    }
    
    return self;
    
}

+ (instancetype)GoldTranModelWithDict:(NSDictionary *)dic {

    return [[self alloc] initWithDict:dic];
    
}

@end
