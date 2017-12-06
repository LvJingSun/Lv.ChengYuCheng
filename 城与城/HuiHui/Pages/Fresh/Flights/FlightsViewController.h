//
//  FlightsViewController.h
//  HuiHui
//
//  Created by mac on 14-12-2.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//  机票的页面

#import "BaseViewController.h"

#import "FlightCityListViewController.h"


typedef enum
{
    SingleType = 0,
    BackType

} FlightsType;

typedef enum
{
    CurrentCityType = 0,
    ArrivalCityType
    
} CityType;




@interface FlightsViewController : BaseViewController<FlightCityListDelegate>

// 判断是否切换出发城市和到达城市
@property (nonatomic, assign) BOOL  isChangeCity;

// 记录是单程还是往返类型
@property (nonatomic, assign) FlightsType  m_type;

// 记录是出发城市还是到达城市
@property (nonatomic, assign) CityType     m_cityType;

// 记录请求数据的值
@property (nonatomic, strong) NSMutableDictionary *m_dic;


@end
