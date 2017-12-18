//
//  HL_DelegateOrderModel.h
//  HuiHui
//
//  Created by mac on 2017/12/14.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HL_DelegateOrderModel : NSObject

@property (nonatomic, copy) NSString *OrderID; //订单编号

@property (nonatomic, copy) NSString *OrderTitle; //订单类型

@property (nonatomic, copy) NSString *OriginalPrice; //原价

@property (nonatomic, copy) NSString *PresentPrice; //现价

@property (nonatomic, copy) NSString *Count; //数量

@property (nonatomic, copy) NSString *Discount; //折扣

@property (nonatomic, copy) NSString *Total; //总价

@property (nonatomic, copy) NSString *payType; //支付类型 1-支付宝 2-微信 3-城与城

@end
