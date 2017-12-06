//
//  CalendarSceneryHomeViewController.h
//  CandalDemo
//
//  Created by mac on 15-2-3.
//  Copyright (c) 2015年 WJL. All rights reserved.
//  景区日期选择的页面

#import "CalendarSceneryViewController.h"

@interface CalendarSceneryHomeViewController : CalendarSceneryViewController{
    
    int m_index;
}

//设置导航栏标题
@property (nonatomic, strong) NSString          *calendartitle;
// 价格数组
@property (nonatomic, strong) NSMutableArray    *m_priceList;
// 政策id
@property (nonatomic, strong) NSString          *m_policyId;

// 记录是第几个月
@property (nonatomic, assign) NSInteger         m_month;


// 景区初始化方法
- (void)setSceneryToDay:(int)day ToDateforString:(NSString *)todate;



- (void)datePriceRequest:(int)day ToDateforString:(NSString *)todate;

@end
