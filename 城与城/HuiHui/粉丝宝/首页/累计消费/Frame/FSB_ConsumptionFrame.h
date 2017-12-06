//
//  FSB_ConsumptionFrame.h
//  HuiHui
//
//  Created by mac on 2017/5/16.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FSB_ConsumptionModel;

@interface FSB_ConsumptionFrame : NSObject

//交易状态
@property (nonatomic, assign) CGRect typeF;

//提交凭证状态
@property (nonatomic, assign) CGRect voucherF;

//消费金额
@property (nonatomic, assign) CGRect countF;

//消费日期
@property (nonatomic, assign) CGRect dateF;

//消费商家
@property (nonatomic, assign) CGRect shopF;

@property (nonatomic, assign) CGRect lineF;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) FSB_ConsumptionModel *consumptionModel;

@end
