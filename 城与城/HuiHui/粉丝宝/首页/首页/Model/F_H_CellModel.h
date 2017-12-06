//
//  F_H_CellModel.h
//  HuiHui
//
//  Created by mac on 2017/6/26.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface F_H_CellModel : NSObject

//商户名  MerchantName
@property (nonatomic, copy) NSString *ShopName;

//商户ID  MerchantID
@property (nonatomic, copy) NSString *ShopID;

//商户店ID  MerchantShopID
@property (nonatomic, copy) NSString *MerchantShopID;

//商户店名  MerchantShopName
@property (nonatomic, copy) NSString *MerchantShopName;

//标题  Title
@property (nonatomic, copy) NSString *Title;

//商户LOGO  Logo
@property (nonatomic, copy) NSString *ShopImg;

//今日红包金额  AccountTotal
@property (nonatomic, copy) NSString *Count;

//商户描述  Remark
@property (nonatomic, copy) NSString *Desc;

//链接类型  AdAdress
@property (nonatomic, copy) NSString *UrlType;

//今日红包领取状态 0-未领取 1-已领取 2-明日可领 Canget
@property (nonatomic, copy) NSString *Type;

//商户宣传图  Adpublic
@property (nonatomic, copy) NSString *ShopADImg;

//暂停描述
@property (nonatomic, copy) NSString *ztinfo;

- (instancetype)initWithDict:(NSDictionary *)dic;

+ (instancetype)F_H_CellModelWithDict:(NSDictionary *)dic;

@end
