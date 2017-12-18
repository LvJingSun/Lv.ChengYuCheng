//
//  HL_PromoterFrame.h
//  HuiHui
//
//  Created by mac on 2017/12/18.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HL_PromoterModel;

@interface HL_PromoterFrame : NSObject

@property (nonatomic, assign) CGRect iconF;

@property (nonatomic, assign) CGRect nameF;

@property (nonatomic, assign) CGRect delegateF;

@property (nonatomic, assign) CGRect countF;

@property (nonatomic, assign) CGRect lineF;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) HL_PromoterModel *promoterModel;

@end
