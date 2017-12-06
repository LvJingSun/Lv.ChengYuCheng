//
//  RH_FilpCellModel.m
//  HuiHui
//
//  Created by mac on 2017/6/6.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "RH_FilpCellModel.h"
#import "RH_FilpADModel.h"

@implementation RH_FilpCellModel

- (instancetype)initWithDict:(NSDictionary *)dic {

    if (self = [super init]) {
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"Title"]] forKey:@"Title"];
        
        NSArray *array = dic[@"ADs"];
        
        NSMutableArray *mut = [NSMutableArray array];
        
        for (NSDictionary *dd in array) {
            
            RH_FilpADModel *admodel = [[RH_FilpADModel alloc] initWithDict:dd];
            
            [mut addObject:admodel];
            
        }
        
        [self setValue:mut forKey:@"ADs"];
        
    }
    
    return self;
    
}

+ (instancetype)RH_FilpCellModelWithDict:(NSDictionary *)dic {

    return [[self alloc] initWithDict:dic];
    
}

@end
