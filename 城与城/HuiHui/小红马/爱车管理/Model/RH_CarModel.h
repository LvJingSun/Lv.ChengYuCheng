//
//  RH_CarModel.h
//  HuiHui
//
//  Created by mac on 2017/6/8.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RH_CarModel : NSObject

//车辆ID
@property (nonatomic, copy) NSString *CheID;

//默认车辆 1-默认 0-非默认
@property (nonatomic, copy) NSString *isDefault;

//汽车品牌图标
@property (nonatomic, copy) NSString *carImg;

//汽车审核状态
@property (nonatomic, copy) NSString *CarStatus;

//汽车品牌ID
@property (nonatomic, copy) NSString *carBrandID;

//汽车型号
@property (nonatomic, copy) NSString *carModel;

//汽车型号ID
@property (nonatomic, copy) NSString *carModelID;

//汽车牌照
@property (nonatomic, copy) NSString *carPlate;

//购车时间
@property (nonatomic, copy) NSString *buyTime;

//行驶里程
@property (nonatomic, copy) NSString *Mileage;

//发动机号
@property (nonatomic, copy) NSString *EngineNumber;

//购车款
@property (nonatomic, copy) NSString *buyMoney;

//购车发票图片
@property (nonatomic, copy) UIImage *InvoiceImg;

//购车发票图片链接
@property (nonatomic, copy) NSString *InvoiceImgUrl;

- (instancetype)initWithDict:(NSDictionary *)dic;

+ (instancetype)RH_CarModelWithDict:(NSDictionary *)dic;

@end
