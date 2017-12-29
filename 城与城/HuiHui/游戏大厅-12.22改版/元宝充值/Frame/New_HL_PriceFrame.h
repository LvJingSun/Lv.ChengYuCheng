//
//  New_HL_PriceFrame.h
//  HuiHui
//
//  Created by mac on 2017/12/26.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>
@class New_HL_PriceModel;

@interface New_HL_PriceFrame : NSObject

@property (nonatomic, assign) CGRect lineF;

@property (nonatomic, assign) CGRect titleF;

@property (nonatomic, assign) CGRect priceF;

@property (nonatomic, assign) CGRect danweiF;

@property (nonatomic, assign) CGRect rechargeF;

@property (nonatomic, assign) CGSize size;

@property (nonatomic, strong) New_HL_PriceModel *model;

- (CGSize)getCellSize;

@end
