//
//  ApplySubsidyModel.m
//  HuiHui
//
//  Created by mac on 2017/6/10.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "ApplySubsidyModel.h"

@implementation ApplySubsidyModel

- (instancetype)initWithDict:(NSDictionary *)dic {

    if (self = [super init]) {
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"applyType"]] forKey:@"applyType"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"count"]] forKey:@"count"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"InvoiceImgUrl"]] forKey:@"InvoiceImgUrl"];
        
        [self setValue:dic[@"InvoiceImg"] forKey:@"InvoiceImg"];
        
    }
    
    return self;
    
}

+ (instancetype)ApplySubsidyModelWithDict:(NSDictionary *)dic {

    return [[self alloc] initWithDict:dic];
    
}

@end
