//
//  RH_CarBrandViewController.h
//  HuiHui
//
//  Created by mac on 2017/6/14.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "RH_BasicViewController.h"
@class RH_CarBrandModel;

typedef void(^popCarBlock)(RH_CarBrandModel *mainBrand,RH_CarBrandModel *childCar);

@interface RH_CarBrandViewController : RH_BasicViewController

@property (nonatomic, copy) popCarBlock popCar;

- (void)popWithCar:(popCarBlock)block;

@end
