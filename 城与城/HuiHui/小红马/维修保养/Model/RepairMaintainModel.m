//
//  RepairMaintainModel.m
//  HuiHui
//
//  Created by mac on 2017/6/7.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "RepairMaintainModel.h"

@implementation RepairMaintainModel

- (instancetype)initWithDict:(NSDictionary *)dic {

    if (self = [super init]) {
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"ID"]] forKey:@"ID"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"type"]] forKey:@"type"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"count"]] forKey:@"count"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"status"]] forKey:@"status"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"content"]] forKey:@"content"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"time"]] forKey:@"time"];
        
    }
    
    return self;
    
}

+ (instancetype)RepairMaintainModelWithDict:(NSDictionary *)dic {

    return [[self alloc] initWithDict:dic];
    
}

@end
