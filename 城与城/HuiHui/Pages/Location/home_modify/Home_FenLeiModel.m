//
//  Home_FenLeiModel.m
//  HuiHui
//
//  Created by mac on 2017/9/8.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "Home_FenLeiModel.h"

@implementation Home_FenLeiModel

- (instancetype)initWithDict:(NSDictionary *)dic {

    if (self = [super init]) {
        
//        [self setValue:[NSString stringWithFormat:@"%@",dic[@"iconUrl"]] forKey:@"iconUrl"];
//        
//        [self setValue:[NSString stringWithFormat:@"%@",dic[@"iconTitle"]] forKey:@"iconTitle"];
//        
//        [self setValue:[NSString stringWithFormat:@"%@",dic[@"clickType"]] forKey:@"clickType"];
        
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"Type"]] forKey:@"Type"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"Title"]] forKey:@"Title"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"Contents"]] forKey:@"Contents"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"PhotoUrl"]] forKey:@"PhotoUrl"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"LinkUrl"]] forKey:@"LinkUrl"];
        
    }
    
    return self;
    
}

+ (instancetype)Home_FenLeiModelWithDict:(NSDictionary *)dic {

    return [[self alloc] initWithDict:dic];
    
}

@end
