//
//  RH_FilpADModel.h
//  HuiHui
//
//  Created by mac on 2017/6/6.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RH_FilpADModel : NSObject

@property (nonatomic, copy) NSString *LocationID;

@property (nonatomic, copy) NSString *Title;

@property (nonatomic, copy) NSString *FrontPhoto;

@property (nonatomic, copy) NSString *LinkUrl;

@property (nonatomic, copy) NSString *ReversePhoto;

@property (nonatomic, copy) NSString *FlipPhoto;

@property (nonatomic, copy) NSString *IsSignIn;

- (instancetype)initWithDict:(NSDictionary *)dic;

+ (instancetype)RH_FilpADModelWithDict:(NSDictionary *)dic;

@end
