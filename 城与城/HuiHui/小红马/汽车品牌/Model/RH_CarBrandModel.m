//
//  RH_CarBrandModel.m
//  HuiHui
//
//  Created by mac on 2017/6/14.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "RH_CarBrandModel.h"

@implementation RH_CarBrandModel

- (instancetype)initWithDict:(NSDictionary *)dic {

    if (self = [super init]) {
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"PinYin"]] forKey:@"PinYin"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"ImageSrc"]] forKey:@"ImageSrc"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"Name"]] forKey:@"Name"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"ParentID"]] forKey:@"ParentID"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"Levels"]] forKey:@"Levels"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"CheID"]] forKey:@"CheID"];
        
    }
    
    return self;
    
}

+ (instancetype)RH_CarBrandModelWithDict:(NSDictionary *)dic {

    return [[self alloc] initWithDict:dic];
    
}

@end
