//
//  F_H_CellModel.m
//  HuiHui
//
//  Created by mac on 2017/6/26.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "F_H_CellModel.h"

@implementation F_H_CellModel

- (instancetype)initWithDict:(NSDictionary *)dic {

    if (self = [super init]) {
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"ShopName"]] forKey:@"ShopName"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"ShopImg"]] forKey:@"ShopImg"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"Count"]] forKey:@"Count"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"Desc"]] forKey:@"Desc"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"Type"]] forKey:@"Type"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"ShopADImg"]] forKey:@"ShopADImg"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"ShopID"]] forKey:@"ShopID"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"UrlType"]] forKey:@"UrlType"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"ztinfo"]] forKey:@"ztinfo"];
        
    }
    
    return self;
    
}

+ (instancetype)F_H_CellModelWithDict:(NSDictionary *)dic {

    return [[self alloc] initWithDict:dic];
    
}

@end
