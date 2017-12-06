//
//  FSB_QuotaModel.m
//  HuiHui
//
//  Created by mac on 2017/5/16.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "FSB_QuotaModel.h"

@implementation FSB_QuotaModel

- (instancetype)initWithDict:(NSDictionary *)dic {

    if (self = [super init]) {
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"TranRcdsid"]] forKey:@"TranRcdsid"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"TransactionType"]] forKey:@"TransactionType"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"Desc"]] forKey:@"Desc"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"ShopName"]] forKey:@"ShopName"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"Num"]] forKey:@"Num"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"Date"]] forKey:@"Date"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"status"]] forKey:@"status"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"allaccount"]] forKey:@"allaccount"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"Ispositive"]] forKey:@"Ispositive"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"Descdetail"]] forKey:@"Descdetail"];
        
    }
    
    return self;
    
}

+ (instancetype)FSB_QuotaModelWithDict:(NSDictionary *)dic {

    return [[self alloc] initWithDict:dic];
    
}

@end
