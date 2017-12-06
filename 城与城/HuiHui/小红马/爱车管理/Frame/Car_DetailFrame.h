//
//  Car_DetailFrame.h
//  HuiHui
//
//  Created by mac on 2017/6/15.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RH_CarModel;

@interface Car_DetailFrame : NSObject

@property (nonatomic, assign) CGRect carImgF;

@property (nonatomic, assign) CGRect carModelF;

@property (nonatomic, assign) CGRect carStatusF;

@property (nonatomic, assign) CGRect Line1F;

@property (nonatomic, assign) CGRect carPlateTitleF;

@property (nonatomic, assign) CGRect carPlateF;

@property (nonatomic, assign) CGRect carPlateLineF;

@property (nonatomic, assign) CGRect timeTitleF;

@property (nonatomic, assign) CGRect timeF;

@property (nonatomic, assign) CGRect timeLineF;

@property (nonatomic, assign) CGRect moneyTitleF;

@property (nonatomic, assign) CGRect moneyF;

@property (nonatomic, assign) CGRect moneyLineF;

@property (nonatomic, assign) CGRect EngineNumberTitleF;

@property (nonatomic, assign) CGRect EngineNumberF;

@property (nonatomic, assign) CGRect EngineNumberLineF;

@property (nonatomic, assign) CGRect MileageTitleF;

@property (nonatomic, assign) CGRect MileageF;

@property (nonatomic, assign) CGRect MileageLineF;

@property (nonatomic, assign) CGRect InvoiceTitleF;

@property (nonatomic, assign) CGRect InvoiceImgF;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) RH_CarModel *carModel;

@end
