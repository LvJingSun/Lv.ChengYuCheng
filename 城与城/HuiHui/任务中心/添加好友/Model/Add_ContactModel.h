//
//  Add_ContactModel.h
//  HuiHui
//
//  Created by mac on 2017/3/31.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Add_ContactModel : NSObject

@property (nonatomic, copy) NSString *iconUrl;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *nick;

@property (nonatomic, copy) NSString *phone;

@property (nonatomic, assign) BOOL isFriend;

- (instancetype)initWithDict:(NSDictionary *)dic;

+ (instancetype)Add_ContactModelWithDict:(NSDictionary *)dic;

@end
