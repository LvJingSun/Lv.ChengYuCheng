//
//  HL_RechargeOrderFrame.h
//  HuiHui
//
//  Created by mac on 2017/12/20.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HL_RechargeOrderModel;

@interface HL_RechargeOrderFrame : NSObject

@property (nonatomic, assign) CGRect OrderBgF;

@property (nonatomic, assign) CGRect OrderIDTitleF;

@property (nonatomic, assign) CGRect OrderIDF;

@property (nonatomic, assign) CGRect lineF;

@property (nonatomic, assign) CGRect GameIDTitleF;

@property (nonatomic, assign) CGRect GameIDF;

@property (nonatomic, assign) CGRect GameNickTitleF;

@property (nonatomic, assign) CGRect GameNickF;

@property (nonatomic, assign) CGRect bgF;

@property (nonatomic, assign) CGRect OrderTitleF;

@property (nonatomic, assign) CGRect OriginalPriceTitleF;

@property (nonatomic, assign) CGRect OriginalPriceF;

@property (nonatomic, assign) CGRect OriginalPriceLineF;

@property (nonatomic, assign) CGRect DelegatePriceTitleF;

@property (nonatomic, assign) CGRect DelegatePriceF;

@property (nonatomic, assign) CGRect CountTitleF;

@property (nonatomic, assign) CGRect CountF;

@property (nonatomic, assign) CGRect TotalTitleF;

@property (nonatomic, assign) CGRect TotalF;

@property (nonatomic, assign) CGRect PayTitleF;

@property (nonatomic, assign) CGRect ZFB_TypeF;

@property (nonatomic, assign) CGRect WX_TypeF;

@property (nonatomic, assign) CGRect CYC_TypeF;

@property (nonatomic, assign) CGRect FSB_TypeF;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) HL_RechargeOrderModel *model;

@end
