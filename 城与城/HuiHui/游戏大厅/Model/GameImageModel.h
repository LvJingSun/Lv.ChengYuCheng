//
//  GameImageModel.h
//  HuiHui
//
//  Created by mac on 2017/5/17.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameImageModel : NSObject

@property (nonatomic, copy) NSString *GameLinkPhtoto;

@property (nonatomic, copy) NSString *GaneIcon;

@property (nonatomic, copy) NSString *Link;

@property (nonatomic, copy) NSString *GameName;

@property (nonatomic, copy) NSString *type;

- (instancetype)initWithDict:(NSDictionary *)dic;

+ (instancetype)GameImageModelWithDict:(NSDictionary *)dic;

@end
