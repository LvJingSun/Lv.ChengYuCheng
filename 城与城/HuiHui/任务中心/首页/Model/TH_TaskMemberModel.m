//
//  TH_TaskMemberModel.m
//  HuiHui
//
//  Created by mac on 2017/4/27.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "TH_TaskMemberModel.h"

@implementation TH_TaskMemberModel

- (instancetype)initWithDict:(NSDictionary *)dic {

    if (self = [super init]) {
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"Memberid"]] forKey:@"Memberid"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"MemName"]] forKey:@"MemName"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"TaskBonuses"]] forKey:@"TaskBonuses"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"WhetherComplete"]] forKey:@"WhetherComplete"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"WhetherToAccept"]] forKey:@"WhetherToAccept"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"MemPhoto"]] forKey:@"MemPhoto"];
        
    }
    
    return self;
    
}

+ (instancetype)TH_TaskMemberModelWithDict:(NSDictionary *)dic {

    return [[self alloc] initWithDict:dic];
    
}

@end
