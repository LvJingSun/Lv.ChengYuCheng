//
//  Gold_OutModel.h
//  HuiHui
//
//  Created by mac on 2017/9/19.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Gold_OutModel : NSObject

//账户余额
@property (nonatomic, copy) NSString *allQuality;

//当前金价
@property (nonatomic, copy) NSString *goldPrice;

//转出质量
@property (nonatomic, copy) NSString *outQuality;

//价值
@property (nonatomic, copy) NSString *money;

@end
