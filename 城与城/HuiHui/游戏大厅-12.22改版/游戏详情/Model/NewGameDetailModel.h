//
//  NewGameDetailModel.h
//  HuiHui
//
//  Created by mac on 2017/12/25.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewGameDetailModel : NSObject

@property (nonatomic, copy) NSString *iconUrl;

@property (nonatomic, copy) NSString *gameName;

@property (nonatomic, copy) NSString *userID;

@property (nonatomic, copy) NSString *gameID;//代表游戏类型

@property (nonatomic, copy) NSString *total;

@property (nonatomic, copy) NSString *type;//货币名称

@property (nonatomic, copy) NSString *gameLink;

@property (nonatomic, copy) NSString *desc;

@property (nonatomic, assign) BOOL isBind;

@end
