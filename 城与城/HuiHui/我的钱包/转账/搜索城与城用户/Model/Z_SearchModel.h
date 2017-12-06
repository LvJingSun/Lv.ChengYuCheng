//
//  Z_SearchModel.h
//  HuiHui
//
//  Created by mac on 2017/7/3.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Z_SearchModel : NSObject

@property (nonatomic, copy) NSString *searchPhone;

@property (nonatomic, copy) NSString *isPhoneNumber;

- (instancetype)initWithDict:(NSDictionary *)dic;

+ (instancetype)Z_SearchModelWithDict:(NSDictionary *)dic;

@end
