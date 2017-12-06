//
//  HomeViewController.h
//  HuiHui
//
//  Created by mac on 14-7-25.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "BaseViewController.h"

#import "DBHelper.h"

//#import "BMKMapView.h"

//#import "BMapKit.h"

#import "HomeCell.h"

#import "HH_cityListViewController.h"

#import "PullTableView.h"

#import "SearchRecordsHelper.h"
#import "Hotel_webViewController.h"
#import "Fl_webViewController.h"
//DPRequestDelegate
@interface HomeViewController : BaseViewController<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,BMKLocationServiceDelegate,BMKMapViewDelegate,BMKGeoCodeSearchDelegate,AdvDelegate,HHCityListDelegate,PullTableViewDelegate>{
    
    DBHelper                        *dbhelp;

    // 地图定位
    BMKLocationService              *_locService;
    
    BMKPointAnnotation              *pointAnnotation;

    CGFloat                         m_latitude;
    
    CGFloat                         m_longtitude;

    NSString                        *selectCity;
    
    
//    NSString * secondASI;//因为没有数据，二次请求
//    NSString * secondlatitude;//二次请求的临时纬度
//    NSString * secondlongitude;//二次请求临时的经度

    UILabel * titleLabel;
    
    
    SearchRecordsHelper *searchHelper;
    

}

//@property (strong, nonatomic)NSDate *lastlocatinDate;//最后定位时间

// 百度地图
@property (nonatomic, strong) BMKMapView                *m_BMK_mapView;
// 反编码
@property (nonatomic, strong) BMKGeoCodeSearch          *m_search;
// 用于临时存储导航栏左按钮，以用于赋值
@property (nonatomic, strong) UIButton                  *m_leftBtn;
// 导航栏左按钮显示的名称
@property (strong, nonatomic) UILabel                   *m_cityNameLabel;

@property (strong, nonatomic) UIImageView               *m_xiaImagV;

// 定位时在转圈圈,定位成功或失败后停止转圈圈
@property (strong, nonatomic) UIActivityIndicatorView   *m_activity;
// 存放广告的数组
@property (nonatomic, strong) NSMutableArray            *m_infoList;

// 存放商户广告的数组
@property (nonatomic, strong) NSMutableArray            *m_AdUpAdList;

// 商品列表的数据
@property (nonatomic, strong) NSMutableArray            *m_productList;

// 存储服务器请求返回的数据
@property (nonatomic, strong) NSDictionary              *m_dic;

// 用于判断来设置view的大小
@property (nonatomic,assign) BOOL                       isClick;
// 滚动的pageControl
@property (nonatomic, strong) GrayPageControl           *m_pageControl;
// 定时器
@property (nonatomic,strong)  NSTimer                   *m_timer;

// 存放类别的数组
@property (nonatomic, strong) NSMutableArray            *m_categoryList;

// 存放大众点评的城市数据
@property (nonatomic, strong) NSMutableArray            *m_dazhongList;

// 记录显示不同的页面的值
@property (nonatomic, strong) NSString                  *m_showTypeString;

// 存放菜单数据的数组
@property (nonatomic, strong) NSMutableArray            *m_menuList;


// 请求首页的数据
- (void)homeRequestSubmit;



@end
