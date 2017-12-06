//
//  GAME_TranModel.h
//  HuiHui
//
//  Created by mac on 2017/9/12.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GAME_TranModel : NSObject

//交易类型 Income-领取 Expenditure-转出
@property (nonatomic, copy) NSString *TradingOperations;

//交易对象logo
@property (nonatomic, copy) NSString *icon;

//交易对象名字
@property (nonatomic, copy) NSString *name;

//交易金额
@property (nonatomic, copy) NSString *count;

//交易状态 1-确认中 2-交易成功 3-交易失败
@property (nonatomic, copy) NSString *status;

//费用说明
@property (nonatomic, copy) NSString *CostDesc;

//交易方式
@property (nonatomic, copy) NSString *TranType;

//商品说明
@property (nonatomic, copy) NSString *GoodsDesc;

//交易时间
@property (nonatomic, copy) NSString *CreateTime;

//交易单号
@property (nonatomic, copy) NSString *OrderNo;

@end
