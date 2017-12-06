//
//  TicketsViewController.h
//  HuiHui
//
//  Created by mac on 15-1-13.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//  景点搜索页面

#import "BaseViewController.h"

//#import "BMKMapView.h"

//#import "BMapKit.h"

#import "SceneryCityListViewController.h"

@interface TicketsViewController : BaseViewController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,BMKLocationServiceDelegate,BMKMapViewDelegate,BMKGeoCodeSearchDelegate,SceneryCityListDelegate>{
    
    // 地图定位
//    BMKLocationService              *_locService;
//    
//    BMKPointAnnotation              *pointAnnotation;
    
    CGFloat                         m_latitude;
    
    CGFloat                         m_longtitude;

    // 显示分页的参数
    int                             m_pageIndex;
    
}

//// 百度地图
//@property (nonatomic, strong) BMKMapView                *m_BMK_mapView;
//// 反编码
//@property (nonatomic, strong) BMKGeoCodeSearch          *m_search;

@property (nonatomic, strong) NSString                  *m_cityName;

// 存放数据的数组
@property (nonatomic, strong) NSMutableArray            *m_sceneryList;

// 记录显示图片的url字符
@property (nonatomic, strong) NSString                  *m_imageUrl;

// 存储城市id-用于选择城市后的记录
@property (nonatomic, strong) NSString                  *m_cityId;

// 获取城市列表
@property (nonatomic, strong) NSMutableArray            *m_cityList;


// 存放排序字母的数组
@property (nonatomic, strong) NSMutableArray            *m_allKeys;
// 存放排序后数据的字典
@property (nonatomic, strong) NSMutableDictionary       *m_cityListDic;

// 存放GPS定位及热门城市的关键字
@property (nonatomic, strong) NSMutableArray            *m_allKeys1;

// 存放搜索记录的数组
@property (nonatomic, strong) NSMutableArray            *m_searchList;



@end
