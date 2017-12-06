//
//  RH_InsuranceModel.m
//  HuiHui
//
//  Created by mac on 2017/6/9.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "RH_InsuranceModel.h"

@implementation RH_InsuranceModel

- (instancetype)initWithDict:(NSDictionary *)dic {

    if (self = [super init]) {
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"CarID"]] forKey:@"CarID"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"carPrice"]] forKey:@"carPrice"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"insurancePerson"]] forKey:@"insurancePerson"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"insuranceTypeID"]] forKey:@"insuranceTypeID"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"insuranceType"]] forKey:@"insuranceType"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"drivingArea"]] forKey:@"drivingArea"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"drivingYears"]] forKey:@"drivingYears"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"carYears"]] forKey:@"carYears"];
        
    }
    
    return self;
    
}

+ (instancetype)RH_InsuranceModelWithDict:(NSDictionary *)dic {

    return [[self alloc] initWithDict:dic];
    
}

@end
