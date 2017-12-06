//
//  M_Record_Model.h
//  HuiHui
//
//  Created by mac on 2017/10/12.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface M_Record_Model : NSObject

@property (nonatomic, copy) NSString *TransactionType;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *date;

@property (nonatomic, copy) NSString *count;

- (instancetype)initWithDict:(NSDictionary *)dic;

+ (instancetype)M_Record_ModelWithDict:(NSDictionary *)dic;

@end
