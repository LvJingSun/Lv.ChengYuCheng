//
//  TransferTransactionModel.h
//  HuiHui
//
//  Created by mac on 2017/6/30.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TransferTransactionModel : NSObject

@property (nonatomic, copy) NSString *toFriendID;

@property (nonatomic, copy) NSString *toFriendName;

@property (nonatomic, copy) NSString *toFriendImg;

@property (nonatomic, copy) NSString *count;

- (instancetype)initWithDict:(NSDictionary *)dic;

+ (instancetype)TransferTransactionModelWithDict:(NSDictionary *)dic;

@end
