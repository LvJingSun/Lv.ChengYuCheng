//
//  OilSubsidyModel.m
//  HuiHui
//
//  Created by mac on 2017/6/7.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "OilSubsidyModel.h"

@implementation OilSubsidyModel

- (instancetype)initWithDict:(NSDictionary *)dic {

    if (self = [super init]) {
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"ID"]] forKey:@"ID"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"count"]] forKey:@"count"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"status"]] forKey:@"status"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"time"]] forKey:@"time"];
        
    }
    
    return self;
    
}

+ (instancetype)OilSubsidyModelWithDict:(NSDictionary *)dic {

    return [[self alloc] initWithDict:dic];

}

@end
