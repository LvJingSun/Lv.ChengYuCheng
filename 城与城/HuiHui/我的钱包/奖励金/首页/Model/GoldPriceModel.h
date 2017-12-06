//
//  GoldPriceModel.h
//  HuiHui
//
//  Created by mac on 2017/9/1.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoldPriceModel : NSObject

@property (nonatomic, copy) NSString *price;

@property (nonatomic, copy) NSString *date;

- (instancetype)initWithDict:(NSDictionary *)dic;

+ (instancetype)GoldPriceModelWithDict:(NSDictionary *)dic;

@end
