//
//  YCB_TranFrame.h
//  HuiHui
//
//  Created by mac on 2017/9/12.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YCB_TranModel;

@interface YCB_TranFrame : NSObject

@property (nonatomic, assign) CGRect typeF;

@property (nonatomic, assign) CGRect countF;

@property (nonatomic, assign) CGRect dateF;

@property (nonatomic, assign) CGRect statusF;

@property (nonatomic, assign) CGRect lineF;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) YCB_TranModel *tranmodel;

@end
