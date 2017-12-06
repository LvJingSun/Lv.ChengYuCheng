//
//  ZZ_FunctionModel.h
//  HuiHui
//
//  Created by mac on 2017/6/30.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZZ_FunctionModel : NSObject

@property (nonatomic, copy) NSString *iconImg;

@property (nonatomic, copy) NSString *functionName;

//判断是否是数组最后一个元素 0-不是 1-是 （是最后一个元素时cell底部的分割线不显示）
@property (nonatomic, copy) NSString *isLast;

- (instancetype)initWithDict:(NSDictionary *)dic;

+ (instancetype)ZZ_FunctionModelWithDict:(NSDictionary *)dic;

@end
