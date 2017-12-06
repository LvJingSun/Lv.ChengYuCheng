//
//  FSB_QuotaModel.h
//  HuiHui
//
//  Created by mac on 2017/5/16.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FSB_QuotaModel : NSObject

//交易ID
@property (nonatomic, copy) NSString *TranRcdsid;

//交易类型  
@property (nonatomic, copy) NSString *TransactionType;

////订单状态  消费-撤销交易
//@property (nonatomic, copy) NSString *OrderStatus;

//交易内容
@property (nonatomic, copy) NSString *Desc;

//商户信息
@property (nonatomic, copy) NSString *ShopName;

//交易金额
@property (nonatomic, copy) NSString *Num;

//交易日期
@property (nonatomic, copy) NSString *Date;

//状态
@property (nonatomic, copy) NSString *status;

//赠送粉丝宝额度
@property (nonatomic, copy) NSString *allaccount;

//符号
@property (nonatomic, copy) NSString *Ispositive;

//交易描述
@property (nonatomic, copy) NSString *Descdetail;

- (instancetype)initWithDict:(NSDictionary *)dic;

+ (instancetype)FSB_QuotaModelWithDict:(NSDictionary *)dic;

@end
