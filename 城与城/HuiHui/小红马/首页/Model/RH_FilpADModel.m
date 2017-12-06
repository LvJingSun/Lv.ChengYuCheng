//
//  RH_FilpADModel.m
//  HuiHui
//
//  Created by mac on 2017/6/6.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "RH_FilpADModel.h"

@implementation RH_FilpADModel

- (instancetype)initWithDict:(NSDictionary *)dic {

    if (self = [super init]) {
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"LocationID"]] forKey:@"LocationID"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"Title"]] forKey:@"Title"];

        [self setValue:[NSString stringWithFormat:@"%@",dic[@"FrontPhoto"]] forKey:@"FrontPhoto"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"LinkUrl"]] forKey:@"LinkUrl"];

        [self setValue:[NSString stringWithFormat:@"%@",dic[@"ReversePhoto"]] forKey:@"ReversePhoto"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"FlipPhoto"]] forKey:@"FlipPhoto"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"IsSignIn"]] forKey:@"IsSignIn"];
        
    }
    
    return self;
    
}

+ (instancetype)RH_FilpADModelWithDict:(NSDictionary *)dic {

    return [[self alloc] initWithDict:dic];
    
}

@end
