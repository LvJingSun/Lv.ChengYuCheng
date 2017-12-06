//
//  MapShowViewController.h
//  HuiHui
//
//  Created by mac on 13-12-3.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import "BaseViewController.h"

//#import "BMapKit.h"

@interface MapViewController : BaseViewController<BMKMapViewDelegate>

// 百度地图
@property (nonatomic, strong) BMKMapView    *m_mapView;

// 自定义百度地图上面显示的view
@property (nonatomic, strong) UIView        *m_tempView;

// 判断来自于哪个页面  1表示来自于商品详情 2表示来自于商户列表或商户详情
@property (nonatomic, strong) NSString      *m_typeString;

// 判断来自于商户列表还是店铺列表 1 表示店铺 2 表示商户
@property (nonatomic, strong) NSString      *m_shopString;

@property(strong, nonatomic) NSDictionary *item;


// 添加地图上面的标志
- (void)addAnination;


@property (nonatomic, strong) NSString         *m_FromDPId;//是否来自点评的信息（0表示城与城数据，1表示大众点评数据）


@end
