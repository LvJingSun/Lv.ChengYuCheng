//
//  RH_ChooseCarModelView.h
//  HuiHui
//
//  Created by mac on 2017/6/14.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RH_CarBrandModel;

typedef void(^ChooseChildCar)(RH_CarBrandModel *mainBrand,RH_CarBrandModel *childCar);

@interface RH_ChooseCarModelView : UIView

- (void)showInView:(UIView *)view;

- (void)disMissView;

@property (nonatomic, strong) RH_CarBrandModel *brandModel;

@property (nonatomic, copy) ChooseChildCar brandcar;

- (void)returnChildCar:(ChooseChildCar)block;

@end
