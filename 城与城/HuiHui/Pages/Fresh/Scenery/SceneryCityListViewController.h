//
//  SceneryCityListViewController.h
//  HuiHui
//
//  Created by mac on 15-1-20.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "BaseViewController.h"

//#import "BMKMapView.h"

//#import "BMapKit.h"


@protocol SceneryCityListDelegate <NSObject>


- (void)getSceneryCityName:(NSMutableDictionary *)aCityname;

@end

@interface SceneryCityListViewController : BaseViewController<BMKLocationServiceDelegate,BMKMapViewDelegate,BMKGeoCodeSearchDelegate,UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>{
    
    // 地图定位
    BMKLocationService              *_locService;
    
    BMKPointAnnotation              *pointAnnotation;
    
    //    NSString                        *selectCity;
    
    CGFloat                         m_latitude;
    
    CGFloat                         m_longtitude;
    
    UIActivityIndicatorView         *activityView;//活动指示
    
    //    UIAlertView *HHalertView;
    
    
    
    double proValue;//进度值
    int blockcount;
    
    
}
@property (nonatomic, weak) IBOutlet UIView * waitview;//等待视图；
@property (nonatomic, weak) IBOutlet UILabel* paitlabel;//百分label;

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

@property (nonatomic, assign) id<SceneryCityListDelegate>   delegate;



// 存放排序字母的数组
@property (nonatomic, strong) NSMutableArray            *m_allKeys;
// 存放排序后数据的字典
@property (nonatomic, strong) NSMutableDictionary       *m_cityListDic;

// 存放GPS定位及热门城市的关键字
@property (nonatomic, strong) NSMutableArray            *m_allKeys1;

// 存放历史搜索的城市
@property (nonatomic, strong) NSMutableArray            *m_hotList;

@end

