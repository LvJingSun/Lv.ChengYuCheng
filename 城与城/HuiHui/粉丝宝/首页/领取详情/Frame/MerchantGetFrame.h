//
//  MerchantGetFrame.h
//  HuiHui
//
//  Created by mac on 2017/7/25.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MerchantGetModel;

@interface MerchantGetFrame : NSObject

@property (nonatomic, assign) CGRect goodF;

@property (nonatomic, assign) CGRect dateF;

@property (nonatomic, assign) CGRect countF;

@property (nonatomic, assign) CGRect lineF;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) MerchantGetModel *detailModel;

@end
