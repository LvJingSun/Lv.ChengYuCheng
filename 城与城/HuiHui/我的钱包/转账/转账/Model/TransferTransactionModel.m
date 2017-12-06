//
//  TransferTransactionModel.m
//  HuiHui
//
//  Created by mac on 2017/6/30.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "TransferTransactionModel.h"

@implementation TransferTransactionModel

- (instancetype)initWithDict:(NSDictionary *)dic {

    if (self = [super init]) {
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"toFriendID"]] forKey:@"toFriendID"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"toFriendName"]] forKey:@"toFriendName"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"toFriendImg"]] forKey:@"toFriendImg"];
        
        [self setValue:[NSString stringWithFormat:@"%@",dic[@"count"]] forKey:@"count"];
        
    }
    
    return self;
    
}

+ (instancetype)TransferTransactionModelWithDict:(NSDictionary *)dic {

    return [[self alloc] initWithDict:dic];
    
}

@end
