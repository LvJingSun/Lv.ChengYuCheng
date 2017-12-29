//
//  HL_RechargeOrderFrame.h
//  HuiHui
//
//  Created by mac on 2017/12/27.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HL_Recharge_Sure_OrderModel;

@interface HL_Recharge_Sure_OrderFrame : NSObject

@property (nonatomic, assign) CGRect bgF;

@property (nonatomic, assign) CGRect OrderIDTitleF;

@property (nonatomic, assign) CGRect OrderIDF;

@property (nonatomic, assign) CGRect lineF;

@property (nonatomic, assign) CGRect OrderTitleF;

@property (nonatomic, assign) CGRect OriginalPriceTitleF;

@property (nonatomic, assign) CGRect OriginalPriceF;

@property (nonatomic, assign) CGRect OriginalPriceLineF;

@property (nonatomic, assign) CGRect PresentPriceTitleF;

@property (nonatomic, assign) CGRect PresentPriceF;

@property (nonatomic, assign) CGRect CountTitleF;

@property (nonatomic, assign) CGRect CountF;

@property (nonatomic, assign) CGRect DiscountTitleF;

@property (nonatomic, assign) CGRect DiscountF;

@property (nonatomic, assign) CGRect TotalTitleF;

@property (nonatomic, assign) CGRect TotalF;

@property (nonatomic, assign) CGRect PayTitleF;

@property (nonatomic, assign) CGRect ZFB_TypeF;

@property (nonatomic, assign) CGRect WX_TypeF;

@property (nonatomic, assign) CGRect CYC_TypeF;

@property (nonatomic, assign) CGRect FSB_TypeF;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) HL_Recharge_Sure_OrderModel *orderModel;

@end
