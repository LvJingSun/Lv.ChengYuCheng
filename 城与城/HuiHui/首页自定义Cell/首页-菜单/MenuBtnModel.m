//
//  MenuBtnModel.m
//  HuiHui
//
//  Created by mac on 2017/9/5.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "MenuBtnModel.h"

@implementation MenuBtnModel

+ (instancetype)homeBtnModelWithDict:(NSDictionary *)dic {
    
    return [[self alloc] initWithDict:dic];
    
}

- (instancetype)initWithDict:(NSDictionary *)dic {
    
    if (self = [super init]) {
        
//        [self setValue:dic[@"imageName"] forKey:@"imageName"];
//        
//        [self setValue:dic[@"title"] forKey:@"title"];
//        
//        [self setValue:dic[@"homeBtnType"] forKey:@"homeBtnType"];
//        
//        [self setValue:dic[@"homeBtnUrl"] forKey:@"homeBtnUrl"];
        
        
        
        [self setValue:dic[@"Type"] forKey:@"Type"];
        
        [self setValue:dic[@"Title"] forKey:@"Title"];
        
        [self setValue:dic[@"Contents"] forKey:@"Contents"];
        
        [self setValue:dic[@"PhotoUrl"] forKey:@"PhotoUrl"];
        
        [self setValue:dic[@"LinkUrl"] forKey:@"LinkUrl"];
        
    }
    
    return self;
    
}

@end
