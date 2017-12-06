//
//  YCB_TranDetailFrame.h
//  HuiHui
//
//  Created by mac on 2017/9/14.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YCB_TranModel;

@interface YCB_TranDetailFrame : NSObject

@property (nonatomic, assign) CGRect iconF;

@property (nonatomic, assign) CGRect nameF;

@property (nonatomic, assign) CGRect countF;

@property (nonatomic, assign) CGRect statusF;

@property (nonatomic, assign) CGRect feiyongTitleF;

@property (nonatomic, assign) CGRect feiyongF;

@property (nonatomic, assign) CGRect typeTitleF;

@property (nonatomic, assign) CGRect typeF;

@property (nonatomic, assign) CGRect descTitleF;

@property (nonatomic, assign) CGRect descF;

@property (nonatomic, assign) CGRect lineF;

@property (nonatomic, assign) CGRect dateTitleF;

@property (nonatomic, assign) CGRect dateF;

@property (nonatomic, assign) CGRect NoTitleF;

@property (nonatomic, assign) CGRect NoF;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) YCB_TranModel *tranmodel;


@end
