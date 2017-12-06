//
//  CtriphotelViewController.h
//  HuiHui
//
//  Created by 冯海强 on 14-9-11.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "BaseViewController.h"

#import "HotelCitylistViewController.h"

//#import "BMapKit.h"
#import "ZHPickView.h"

@interface CtriphotelViewController : BaseViewController<GetCtriphotelcity,BMKMapViewDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate,ZHPickViewDelegate>
{
    BMKMapView             *CH_mapView;
    BMKLocationService* CH_locService;
    BMKGeoCodeSearch          *m_search;

}

@property (weak, nonatomic) IBOutlet UITableView *Ctriptableview;

@property (weak, nonatomic) NSString *Ctriphotel_start;//星级；

@property (weak, nonatomic) IBOutlet UIView *C_alphaView;//透明层

@property (strong, nonatomic) IBOutlet UIView *C_ActhionSheet;//星级视图

@property (strong, nonatomic) IBOutlet UIView *C_DateActhionSheet;//入住时间视图

@property (strong, nonatomic)  NSMutableDictionary *Ctrip_hotelInfomation;////入住信息的存储；

@property(nonatomic,strong)ZHPickView *HotelNameKeypickview;

@end
