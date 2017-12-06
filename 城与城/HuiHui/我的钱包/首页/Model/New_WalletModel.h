//
//  New_WalletModel.h
//  HuiHui
//
//  Created by mac on 2017/8/30.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface New_WalletModel : NSObject

@property (nonatomic, copy) NSString *icon;

@property (nonatomic, copy) NSString *title;

- (instancetype)initWithDict:(NSDictionary *)dic;

+ (instancetype)New_WalletModelWithDict:(NSDictionary *)dic;

@end
