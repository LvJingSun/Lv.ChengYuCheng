//
//  ApplySubsidyModel.h
//  HuiHui
//
//  Created by mac on 2017/6/10.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ApplySubsidyModel : NSObject

//补助类型 4-油费 1-保险 2-保养 5-轮胎 3-修理
@property (nonatomic, copy) NSString *applyType;

//补助金额
@property (nonatomic, copy) NSString *count;

//发票图片地址
@property (nonatomic, copy) NSString *InvoiceImgUrl;

//发票图片数据
@property (nonatomic, strong) UIImage *InvoiceImg;

- (instancetype)initWithDict:(NSDictionary *)dic;

+ (instancetype)ApplySubsidyModelWithDict:(NSDictionary *)dic;

@end
