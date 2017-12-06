//
//  TH_TaskModel.m
//  HuiHui
//
//  Created by mac on 2017/4/27.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "TH_TaskModel.h"

@implementation TH_TaskModel

- (instancetype)initWithDict:(NSDictionary *)dic {

    if (self = [super init]) {
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"IsFriendsTaskOrMyTask"]] forKey:@"IsFriendsTaskOrMyTask"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"PsID"]] forKey:@"PsID"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"TaskName"]] forKey:@"TaskName"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"RName"]] forKey:@"RName"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"WhetherComplete"]] forKey:@"WhetherComplete"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"WTime"]] forKey:@"WTime"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"TaskBonuses"]] forKey:@"TaskBonuses"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"ReTaskID"]] forKey:@"ReTaskID"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"ReMemName"]] forKey:@"ReMemName"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"ReTime"]] forKey:@"ReTime"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"ReTaskAmount"]] forKey:@"ReTaskAmount"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"ReTaskBonuses"]] forKey:@"ReTaskBonuses"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"StatusIs"]] forKey:@"StatusIs"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"ReleaseName"]] forKey:@"ReleaseName"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"TaskType"]] forKey:@"TaskType"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"CompletedNum"]] forKey:@"CompletedNum"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"NeedNum"]] forKey:@"NeedNum"];
        
    }
    
    return self;
    
}

+ (instancetype)TH_TaskModelWithDict:(NSDictionary *)dic {

    return [[self alloc] initWithDict:dic];
    
}

@end
