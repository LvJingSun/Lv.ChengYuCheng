//
//  FSB_DetailedFrame.h
//  HuiHui
//
//  Created by mac on 2017/5/16.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FSB_DetailedModel;

@interface FSB_DetailedFrame : NSObject

//返利来源
@property (nonatomic, assign) CGRect SourceF;

//返利状态
@property (nonatomic, assign) CGRect StatusF;

//进度条背景
@property (nonatomic, assign) CGRect bgviewF;

//进度条
@property (nonatomic, assign) CGRect progressF;

//已返利金额
@property (nonatomic, assign) CGRect TotalF;

//总返利金额
@property (nonatomic, assign) CGRect totaleduF;

//百分比
@property (nonatomic, assign) CGRect progressCountF;

//返利号
@property (nonatomic, assign) CGRect FanliIDF;

//已返利天数
@property (nonatomic, assign) CGRect DaysF;

//返利周期
@property (nonatomic, assign) CGRect dateF;

//商品名
@property (nonatomic, assign) CGRect goodF;

//分隔线
@property (nonatomic, assign) CGRect lineF;

@property (nonatomic, assign) CGRect topF;

@property (nonatomic, assign) CGRect bottomF;

@property (nonatomic, assign) CGFloat height;

//暂停理由
@property (nonatomic, assign) CGRect liyouF;

//申诉电话
@property (nonatomic, assign) CGRect phoneF;

@property (nonatomic, strong) FSB_DetailedModel *detailedModel;

@end
