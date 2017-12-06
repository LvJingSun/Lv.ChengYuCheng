//
//  SceneryMapViewController.h
//  HuiHui
//
//  Created by mac on 15-1-14.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "BaseViewController.h"

#import "BMapKit.h"


@interface SceneryMapViewController : BaseViewController<BMKMapViewDelegate>{
    
    // 重新请求数组需清除之前的大头针
    NSMutableArray          *m_tempAnnotions;

    // 第一次进入页面，处于大头针位置
    BOOL                    firstEnterPage;

}

// 百度地图
@property (nonatomic, strong) BMKMapView    *m_mapView;

// 自定义百度地图上面显示的view
@property (nonatomic, strong) UIView        *m_tempView;

// 存放数据的数组
@property (nonatomic, strong) NSMutableArray  *m_aninationList;


// 添加地图上面的标志
- (void)addAnination;




@end
