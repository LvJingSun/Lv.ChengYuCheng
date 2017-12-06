//
//  HomeMenuModel.h
//  HuiHui
//
//  Created by mac on 2017/9/5.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeMenuModel : NSObject

@property (nonatomic, strong) NSArray *btnArray;

- (instancetype)initWithDict:(NSDictionary *)dic;

+ (instancetype)HomeMenuModelWithDict:(NSDictionary *)dic;

@end
