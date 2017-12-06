//
//  FSB_QuotaFrame.h
//  HuiHui
//
//  Created by mac on 2017/5/16.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FSB_QuotaModel;

@interface FSB_QuotaFrame : NSObject

//交易状态
@property (nonatomic, assign) CGRect typeF;

//赠送额度
@property (nonatomic, assign) CGRect countF;

//交易日期
@property (nonatomic, assign) CGRect dateF;

//赠送商家
@property (nonatomic, assign) CGRect shopF;

@property (nonatomic, assign) CGRect lineF;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) FSB_QuotaModel *quotaModel;

@end
