//
//  RH_SwitchCarViewController.h
//  HuiHui
//
//  Created by mac on 2017/6/21.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "RH_BasicViewController.h"
@class RH_CarModel;

typedef void(^popSwitchCarBlock)(RH_CarModel *carModel);

@interface RH_SwitchCarViewController : RH_BasicViewController

@property (nonatomic, copy) popSwitchCarBlock popCar;

- (void)popCarClick:(popSwitchCarBlock)block;

@end
