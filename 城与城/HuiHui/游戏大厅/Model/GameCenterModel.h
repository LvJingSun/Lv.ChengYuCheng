//
//  GameCenterModel.h
//  HuiHui
//
//  Created by mac on 2017/5/18.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameCenterModel : NSObject

@property (nonatomic, copy) NSString *MemberID;

@property (nonatomic, copy) NSString *MemPhoto;

@property (nonatomic, copy) NSString *NickName;

@property (nonatomic, copy) NSString *AccountBalance;

@property (nonatomic, copy) NSArray *listCategory;

@property (nonatomic, copy) NSString *status;

@property (nonatomic, copy) NSString *msg;

- (instancetype)initWithDict:(NSDictionary *)dic;

+ (instancetype)GameCenterModelWithDict:(NSDictionary *)dic;

@end
