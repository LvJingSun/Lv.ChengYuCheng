//
//  RH_InsuranceModel.h
//  HuiHui
//
//  Created by mac on 2017/6/9.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RH_InsuranceModel : NSObject

//车ID
@property (nonatomic, copy) NSString *CarID;

//车价
@property (nonatomic, copy) NSString *carPrice;

//被保险人
@property (nonatomic, copy) NSString *insurancePerson;

//保险种类ID
@property (nonatomic, copy) NSString *insuranceTypeID;

//保险种类
@property (nonatomic, copy) NSString *insuranceType;

//行驶里程
@property (nonatomic, copy) NSString *drivingArea;

//驾龄 1-一年以下 2-1~3年 3-3年以上
@property (nonatomic, copy) NSString *drivingYears;

//车龄 1-一年以下 2-1~2年 3-3~6年 4-6年以上
@property (nonatomic, copy) NSString *carYears;

- (instancetype)initWithDict:(NSDictionary *)dic;

+ (instancetype)RH_InsuranceModelWithDict:(NSDictionary *)dic;

@end
