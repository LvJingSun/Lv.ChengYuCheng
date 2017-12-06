//
//  GoldPriceFrame.h
//  HuiHui
//
//  Created by mac on 2017/9/1.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GoldPriceModel;

@interface GoldPriceFrame : NSObject

@property (nonatomic, assign) CGRect titleF;

@property (nonatomic, assign) CGRect priceF;

@property (nonatomic, assign) CGRect dateF;

@property (nonatomic, assign) CGRect lineF;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) GoldPriceModel *pricemodel;

@end
