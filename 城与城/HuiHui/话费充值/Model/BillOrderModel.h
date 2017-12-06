//
//  BillOrderModel.h
//  HuiHui
//
//  Created by mac on 2017/5/19.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BillOrderModel : NSObject

//充值数额
@property (nonatomic, copy) NSString *count;

//充值订单号
@property (nonatomic, copy) NSString *orderNo;

//充值手机号
@property (nonatomic, copy) NSString *phone;

//充值手机号归属地
@property (nonatomic, copy) NSString *location;

//付款方式
@property (nonatomic, copy) NSString *style;

//MD5加密字符
@property (nonatomic, copy) NSString *MdStr;

//余额是否足够 0-余额不足 1-余额足够
@property (nonatomic, copy) NSString *IFEnough;

////是否设置支付密码 0-未设置 1-已设置
//@property (nonatomic, copy) NSString *isSetting;

@end
