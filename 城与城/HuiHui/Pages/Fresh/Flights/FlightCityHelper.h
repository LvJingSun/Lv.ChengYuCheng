//
//  SearchRecordsHelper.h
//  HuiHui
//
//  Created by mac on 14-11-11.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FlightCityHelper : NSObject

// 刷新机票里的城市列表
- (void)updateDataFlight:(NSArray *)cityList andType:(NSString *)type andVersion:(NSString *)ver;
// 读取搜索记录的数组
- (NSMutableArray *)flightCityList;


// 刷新搜索记录
//- (void)upDateVersion:(NSArray *)versions;
// 获取版本信息
- (NSDictionary *)version;

// 存储历史搜索的城市
- (void)UPdateHotData:(NSMutableArray *)hotList;

- (NSMutableArray *)hotList;

@end
