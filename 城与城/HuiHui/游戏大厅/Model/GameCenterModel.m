//
//  GameCenterModel.m
//  HuiHui
//
//  Created by mac on 2017/5/18.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "GameCenterModel.h"
#import "GameImageModel.h"

@implementation GameCenterModel

- (instancetype)initWithDict:(NSDictionary *)dic {

    if (self = [super init]) {
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"MemberID"]] forKey:@"MemberID"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"MemPhoto"]] forKey:@"MemPhoto"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"NickName"]] forKey:@"NickName"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"AccountBalance"]] forKey:@"AccountBalance"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"status"]] forKey:@"status"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"msg"]] forKey:@"msg"];
        
        NSArray *array = dic[@"listCategory"];
        
        NSMutableArray *mut = [NSMutableArray array];
        
        for (NSDictionary *dd in array) {
            
            GameImageModel *model = [[GameImageModel alloc] initWithDict:dd];
            
            [mut addObject:model];
            
        }
        
        [self setValue:mut forKey:@"listCategory"];
        
    }
    
    return self;
    
}

+ (instancetype)GameCenterModelWithDict:(NSDictionary *)dic {

    return [[self alloc] initWithDict:dic];
    
}

@end
