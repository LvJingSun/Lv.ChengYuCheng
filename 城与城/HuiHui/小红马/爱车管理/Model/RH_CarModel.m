//
//  RH_CarModel.m
//  HuiHui
//
//  Created by mac on 2017/6/8.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "RH_CarModel.h"

@implementation RH_CarModel

- (instancetype)initWithDict:(NSDictionary *)dic {

    if (self = [super init]) {
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"CheID"]] forKey:@"CheID"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"isDefault"]] forKey:@"isDefault"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"carImg"]] forKey:@"carImg"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"carBrandID"]] forKey:@"carBrandID"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"carModelID"]] forKey:@"carModelID"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"carModel"]] forKey:@"carModel"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"carPlate"]] forKey:@"carPlate"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"buyTime"]] forKey:@"buyTime"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"Mileage"]] forKey:@"Mileage"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"EngineNumber"]] forKey:@"EngineNumber"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"buyMoney"]] forKey:@"buyMoney"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"CarStatus"]] forKey:@"CarStatus"];
        
        [self setValue:dic[@"InvoiceImg"] forKey:@"InvoiceImg"];
        
    }
    
    return self;
    
}

+ (instancetype)RH_CarModelWithDict:(NSDictionary *)dic {

    return [[self alloc] initWithDict:dic];
    
}

@end
