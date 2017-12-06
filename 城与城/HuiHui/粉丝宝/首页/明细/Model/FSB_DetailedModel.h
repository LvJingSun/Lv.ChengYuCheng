//
//  FSB_DetailedModel.h
//  HuiHui
//
//  Created by mac on 2017/5/16.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FSB_DetailedModel : NSObject

//返利额度
@property (nonatomic, copy) NSString *totaledu;

//是否展开
@property (nonatomic, assign) BOOL isZhanKai;

//返利id
@property (nonatomic, copy) NSString *FanliID;

//商品名
@property (nonatomic, copy) NSString *goodname;

//已返利天数
@property (nonatomic, copy) NSString *Days;

//剩余天数
@property (nonatomic, copy) NSString *LeftDays;

//已返利金额
@property (nonatomic, copy) NSString *Total;

//未返利金额
@property (nonatomic, copy) NSString *Leftnum;

//开始日期
@property (nonatomic, copy) NSString *StartDate;

//结束日期
@property (nonatomic, copy) NSString *EndDate;

//返利来源
@property (nonatomic, copy) NSString *Source;

//返利进度
@property (nonatomic, copy) NSString *progress;

//返利状态
@property (nonatomic, copy) NSString *Status;

//返利周期
@property (nonatomic, copy) NSString *Rite;

//暂停理由
@property (nonatomic, copy) NSString *liyou;

- (instancetype)initWithDict:(NSDictionary *)dic;

+ (instancetype)FSB_DetailedModelWithDict:(NSDictionary *)dic;

@end
