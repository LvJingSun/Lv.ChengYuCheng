//
//  BBMapViewController.h
//  HuiHui
//
//  Created by mac on 14-7-15.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "BaseViewController.h"
//#import "BMapKit.h"
#import "DowncellViewController.h"


/**
 定义协议，用来实现传值代理
 */
@protocol ChosesMapDelegate <NSObject>
/**
 此方为必须实现的协议方法，用来传值
 */
@optional

- (void)ChosesMapValue:(NSString *)address mapx:(NSString *)mapx mapy:(NSString *)mapy level:(NSString *)level;//经纬度

@end

@interface BBMapViewController : BaseViewController<BMKMapViewDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate,ChosesMapDelegate,ChosesDelegate>{
    
    IBOutlet BMKMapView             *_mapView;
    
    BMKLocationService              *_locService;
    
    
    BMKGeoCodeSearch                *_geocodesearch;
    
    IBOutlet UITextField* _cityText;
    
    IBOutlet UITextField* _addrText;
    
    NSString * address;
    int _mapzoomlevel;//图层；
    float _mapx;
    float _mapy;
    
    NSString * locationself;//自动定位标记
    int remind;//提醒过了就不用提醒了；
    
    
    NSTimer *MyTimer;
    

    
    
}


@property(strong, nonatomic) NSDictionary *item;

/**
 此处利用协议来定义代理
 */
@property (nonatomic, unsafe_unretained) id<ChosesMapDelegate> Chosemapdelegate;



@end
