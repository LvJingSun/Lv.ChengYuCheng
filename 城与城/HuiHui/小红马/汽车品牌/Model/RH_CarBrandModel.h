//
//  RH_CarBrandModel.h
//  HuiHui
//
//  Created by mac on 2017/6/14.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RH_CarBrandModel : NSObject

@property (nonatomic, copy) NSString *PinYin;

@property (nonatomic, copy) NSString *ImageSrc;

@property (nonatomic, copy) NSString *Name;

@property (nonatomic, copy) NSString *ParentID;

@property (nonatomic, copy) NSString *Levels;

@property (nonatomic, copy) NSString *CheID;

- (instancetype)initWithDict:(NSDictionary *)dic;

+ (instancetype)RH_CarBrandModelWithDict:(NSDictionary *)dic;

@end
