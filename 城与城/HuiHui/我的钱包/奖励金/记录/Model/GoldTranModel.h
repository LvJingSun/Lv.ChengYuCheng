//
//  GoldTranModel.h
//  HuiHui
//
//  Created by mac on 2017/9/11.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoldTranModel : NSObject

//交易类型 1-获取 2-卖出
@property (nonatomic, copy) NSString *tranType;

@property (nonatomic, copy) NSString *count;

@property (nonatomic, copy) NSString *date;

//交易状态 1-确认中 2-交易成功 3-交易失败
@property (nonatomic, copy) NSString *status;

- (instancetype)initWithDict:(NSDictionary *)dic;

+ (instancetype)GoldTranModelWithDict:(NSDictionary *)dic;

@end
