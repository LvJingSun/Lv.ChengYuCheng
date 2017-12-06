//
//  HH_cityListViewController.h
//  HuiHui
//
//  Created by mac on 14-8-1.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "BaseViewController.h"

//#import "BMKMapView.h"

//#import "BMapKit.h"

@protocol HHCityListDelegate <NSObject>


- (void)getHHCityName:(NSMutableDictionary *)aCityame;

@end

@interface HH_cityListViewController : BaseViewController<BMKLocationServiceDelegate,BMKMapViewDelegate,BMKGeoCodeSearchDelegate,UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>{
    
    // 地图定位
    BMKLocationService              *_locService;
    
    BMKPointAnnotation              *pointAnnotation;
    
    NSString                        *selectCity;
    
    CGFloat                         m_latitude;
    
    CGFloat                         m_longtitude;
    
    UIActivityIndicatorView         *activityView;//活动指示
    
    UIAlertView *HHalertView;
    
    
    
    double proValue;//进度值
    int blockcount;
    

}


// 百度地图
@property (nonatomic, strong) BMKMapView                *m_BMK_mapView;
// 反编码
@property (nonatomic, strong) BMKGeoCodeSearch          *m_search;

@property (nonatomic, strong) NSString                  *m_cityName;

// 存储城市列表的数据
@property (nonatomic, strong) NSMutableArray            *m_cityList;

// 存放搜索的数据数组
@property (nonatomic, strong) NSMutableArray            *m_searchArray;

@property (nonatomic, assign) BOOL                      m_isSearching;
// 用于判断来自于哪个页面  1表示刚打开app进入的页面 2表示本地里面去选择城市的页面
@property (nonatomic, strong) NSString                  *m_typeString;

@property (nonatomic, assign) id<HHCityListDelegate>   delegate;



// 存放排序字母的数组
@property (nonatomic, strong) NSMutableArray            *m_allKeys;
// 存放排序后数据的字典
@property (nonatomic, strong) NSMutableDictionary       *m_cityListDic;

@end
