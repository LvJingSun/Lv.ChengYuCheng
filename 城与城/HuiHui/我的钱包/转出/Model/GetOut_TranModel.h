//
//  GetOut_TranModel.h
//  HuiHui
//
//  Created by mac on 2017/9/12.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetOut_TranModel : NSObject

@property (nonatomic, copy) NSString *xiane;

@property (nonatomic, copy) NSString *count;

@property (nonatomic, copy) NSString *notice;

- (instancetype)initWithDict:(NSDictionary *)dic;

+ (instancetype)GetOut_TranModelWithDict:(NSDictionary *)dic;

@end
