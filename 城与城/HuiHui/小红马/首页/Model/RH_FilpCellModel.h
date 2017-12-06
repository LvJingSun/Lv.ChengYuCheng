//
//  RH_FilpCellModel.h
//  HuiHui
//
//  Created by mac on 2017/6/6.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RH_FilpCellModel : NSObject

@property (nonatomic, copy) NSString *Title;

@property (nonatomic, strong) NSArray *ADs;

- (instancetype)initWithDict:(NSDictionary *)dic;

+ (instancetype)RH_FilpCellModelWithDict:(NSDictionary *)dic;

@end
