//
//  OilSubsidyModel.h
//  HuiHui
//
//  Created by mac on 2017/6/7.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OilSubsidyModel : NSObject

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *count;

@property (nonatomic, copy) NSString *status;

@property (nonatomic, copy) NSString *time;

- (instancetype)initWithDict:(NSDictionary *)dic;

+ (instancetype)OilSubsidyModelWithDict:(NSDictionary *)dic;

@end
