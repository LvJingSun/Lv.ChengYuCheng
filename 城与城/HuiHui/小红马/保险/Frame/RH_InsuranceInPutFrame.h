//
//  RH_InsuranceInPutFrame.h
//  HuiHui
//
//  Created by mac on 2017/6/9.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RH_InsuranceModel;

@interface RH_InsuranceInPutFrame : NSObject

@property (nonatomic, assign) CGRect carPriceTitleF;

@property (nonatomic, assign) CGRect carPriceF;

@property (nonatomic, assign) CGRect carPriceLineF;

@property (nonatomic, assign) CGRect insurancePersonTitleF;

@property (nonatomic, assign) CGRect insurancePersonF;

@property (nonatomic, assign) CGRect insurancePersonLineF;

@property (nonatomic, assign) CGRect insurancePriceTitleF;

@property (nonatomic, assign) CGRect insurancePriceF;

@property (nonatomic, assign) CGRect insurancePriceLineF;

@property (nonatomic, assign) CGRect drivingAreaTitleF;

@property (nonatomic, assign) CGRect drivingAreaF;

@property (nonatomic, assign) CGRect drivingAreaLineF;

@property (nonatomic, assign) CGRect drivingYearsTitleF;

@property (nonatomic, assign) CGRect drivingYears_ONE_TitleF;

@property (nonatomic, assign) CGRect drivingYears_ONEtoTHREE_TitleF;

@property (nonatomic, assign) CGRect drivingYears_moreTHREE_TitleF;

@property (nonatomic, assign) CGRect carYearsTitleF;

@property (nonatomic, assign) CGRect carYears_ONE_TitleF;

@property (nonatomic, assign) CGRect carYears_ONEtoTWO_TitleF;

@property (nonatomic, assign) CGRect carYears_TWOtoSIX_TitleF;

@property (nonatomic, assign) CGRect carYears_moreSIX_TitleF;

@property (nonatomic, assign) CGRect SureBtnF;

@property (nonatomic, assign) CGRect SureBtnBGViewF;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) RH_InsuranceModel *insuranceModel;


@end
