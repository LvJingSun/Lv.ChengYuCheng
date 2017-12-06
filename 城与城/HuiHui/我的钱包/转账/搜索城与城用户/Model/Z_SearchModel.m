//
//  Z_SearchModel.m
//  HuiHui
//
//  Created by mac on 2017/7/3.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "Z_SearchModel.h"

@implementation Z_SearchModel

- (instancetype)initWithDict:(NSDictionary *)dic {

    if (self = [super init]) {
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"searchPhone"]] forKey:@"searchPhone"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"isPhoneNumber"]] forKey:@"isPhoneNumber"];
        
    }
    
    return self;
    
}

+ (instancetype)Z_SearchModelWithDict:(NSDictionary *)dic {

    return [[self alloc] initWithDict:dic];
    
}

@end
