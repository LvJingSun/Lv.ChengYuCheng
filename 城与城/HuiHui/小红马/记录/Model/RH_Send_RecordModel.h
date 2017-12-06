//
//  RH_Send_RecordModel.h
//  HuiHui
//
//  Created by mac on 2017/8/4.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RH_Send_RecordModel : NSObject

@property (nonatomic, copy) NSString *TranID;

@property (nonatomic, copy) NSString *CarNo;

@property (nonatomic, copy) NSString *Brandname;

@property (nonatomic, copy) NSString *Memberid;

@property (nonatomic, copy) NSString *MerchantID;

@property (nonatomic, copy) NSString *TotalPart;

@property (nonatomic, copy) NSString *Goodsname;

@property (nonatomic, copy) NSString *CashierAccountID;

@property (nonatomic, copy) NSString *Num;

@property (nonatomic, copy) NSString *Allaccount;

@property (nonatomic, copy) NSString *CreateDate;

@property (nonatomic, copy) NSString *MemDesc;

@property (nonatomic, copy) NSString *CarInvoiceImg;

@property (nonatomic, copy) NSString *TranStatus;

- (instancetype)initWithDict:(NSDictionary *)dic;

+ (instancetype)RH_Send_RecordModelWithDict:(NSDictionary *)dic;

@end
