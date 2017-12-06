//
//  RH_Get_RecordModel.h
//  HuiHui
//
//  Created by mac on 2017/8/4.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RH_Get_RecordModel : NSObject

@property (nonatomic, copy) NSString *Amount;

@property (nonatomic, copy) NSString *MemberID;

@property (nonatomic, copy) NSString *TransactionDate;

@property (nonatomic, copy) NSString *TransactionType;

@property (nonatomic, copy) NSString *TradingOperations;

@property (nonatomic, copy) NSString *Description;

@property (nonatomic, copy) NSString *Status;

@property (nonatomic, copy) NSString *type;

- (instancetype)initWithDict:(NSDictionary *)dic;

+ (instancetype)RH_Get_RecordModelWithDict:(NSDictionary *)dic;

@end
