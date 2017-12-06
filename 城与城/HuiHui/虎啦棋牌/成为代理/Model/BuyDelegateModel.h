//
//  BuyDelegateModel.h
//  HuiHui
//
//  Created by mac on 2017/11/15.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BuyDelegateModel : NSObject

@property (nonatomic, copy) NSString *categoryId;

@property (nonatomic, copy) NSString *price;

@property (nonatomic, copy) NSString *zhekou;

@property (nonatomic, copy) NSString *timeStatus; //1-一年 2-两年 3-三年

@property (nonatomic, copy) NSString *payStatus; //1-城与城支付 2-微信支付 3-支付宝支付

@property (nonatomic, copy) NSString *allCount;

@end
