//
//  GoldBrokenLineModel.h
//  HuiHui
//
//  Created by mac on 2017/9/11.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoldBrokenLineModel : NSObject

@property (nonatomic, strong) NSArray *valueArr;

@property (nonatomic, strong) NSArray *keyArr;

- (instancetype)initWithDict:(NSDictionary *)dic;

+ (instancetype)GoldBrokenLineModelWithDict:(NSDictionary *)dic;

@end
