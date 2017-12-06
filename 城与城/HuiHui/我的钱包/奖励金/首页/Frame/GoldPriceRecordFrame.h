//
//  GoldPriceRecordFrame.h
//  HuiHui
//
//  Created by mac on 2017/9/15.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GoldPriceModel;

@interface GoldPriceRecordFrame : NSObject

@property (nonatomic, assign) CGRect dateF;

@property (nonatomic, assign) CGRect priceF;

@property (nonatomic, assign) CGRect lineF;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) GoldPriceModel *priceModel;

@end
