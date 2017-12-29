//
//  GameRechargeModel.h
//  HuiHui
//
//  Created by mac on 2017/10/27.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameRechargeModel : NSObject

@property (nonatomic, copy) NSString *rechargeType; //4-元宝 5-房卡

@property (nonatomic, copy) NSString *qipaiID;

@property (nonatomic, copy) NSString *qipaiNick;

@property (nonatomic, copy) NSString *qipaiNotice;

@property (nonatomic, copy) NSString *xiane;

@property (nonatomic, copy) NSString *count;

@property (nonatomic, copy) NSString *notice;

@property (nonatomic, copy) NSString *viewType; //1-给自己充值 2-给他人充值 3-赠送

- (instancetype)initWithDict:(NSDictionary *)dic;

+ (instancetype)GameRechargeModelWithDict:(NSDictionary *)dic;

@end
