//
//  GameTranModel.h
//  HuiHui
//
//  Created by mac on 2017/12/7.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameTranModel : NSObject

@property (nonatomic, copy) NSString *recordID;

@property (nonatomic, copy) NSString *rechargeType; //1-代理购买 2-代理升级 3-元宝充值 4-房卡充值

@property (nonatomic, copy) NSString *typeName; //交易类型

@property (nonatomic, copy) NSString *type; //+ -

@property (nonatomic, copy) NSString *count;

@property (nonatomic, copy) NSString *date;

@property (nonatomic, copy) NSString *remark;

@end
