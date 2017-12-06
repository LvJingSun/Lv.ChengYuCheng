//
//  HomeMenuModel.m
//  HuiHui
//
//  Created by mac on 2017/9/5.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "HomeMenuModel.h"
#import "MenuBtnModel.h"

@implementation HomeMenuModel

- (instancetype)initWithDict:(NSDictionary *)dic {

    if (self = [super init]) {
        
        NSArray *arr = dic[@"btnArray"];
        
        NSMutableArray *mut = [NSMutableArray array];
        
        for (NSDictionary *dd in arr) {
            
            MenuBtnModel *model = [[MenuBtnModel alloc] initWithDict:dd];
            
            [mut addObject:model];
            
        }
        
        [self setValue:mut forKey:@"btnArray"];
        
    }
    
    return self;
    
}

+ (instancetype)HomeMenuModelWithDict:(NSDictionary *)dic {

    return [[self alloc] initWithDict:dic];
    
}

@end
