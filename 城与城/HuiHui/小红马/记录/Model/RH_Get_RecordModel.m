//
//  RH_Get_RecordModel.m
//  HuiHui
//
//  Created by mac on 2017/8/4.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "RH_Get_RecordModel.h"

@implementation RH_Get_RecordModel

- (instancetype)initWithDict:(NSDictionary *)dic {

    if (self = [super init]) {
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"Amount"]] forKey:@"Amount"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"MemberID"]] forKey:@"MemberID"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"TransactionDate"]] forKey:@"TransactionDate"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"TransactionType"]] forKey:@"TransactionType"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"TradingOperations"]] forKey:@"TradingOperations"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"Description"]] forKey:@"Description"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"Status"]] forKey:@"Status"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"type"]] forKey:@"type"];
        
    }
    
    return self;
    
}

+ (instancetype)RH_Get_RecordModelWithDict:(NSDictionary *)dic {

    return [[self alloc] initWithDict:dic];
    
}

@end
