//
//  GameRechargeModel.m
//  HuiHui
//
//  Created by mac on 2017/10/27.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "GameRechargeModel.h"

@implementation GameRechargeModel

- (instancetype)initWithDict:(NSDictionary *)dic {
    
    if (self = [super init]) {
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"xiane"]] forKey:@"xiane"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"count"]] forKey:@"count"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"notice"]] forKey:@"notice"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"qipaiID"]] forKey:@"qipaiID"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"qipaiNotice"]] forKey:@"qipaiNotice"];
        
    }
    
    return self;
    
}

+ (instancetype)GameRechargeModelWithDict:(NSDictionary *)dic {
    
    return [[self alloc] initWithDict:dic];
    
}

@end
