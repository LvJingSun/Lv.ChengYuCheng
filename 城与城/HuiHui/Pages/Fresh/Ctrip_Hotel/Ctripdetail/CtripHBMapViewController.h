//
//  CtripHBMapViewController.h
//  HuiHui
//
//  Created by 冯海强 on 14-9-18.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "BaseViewController.h"

//#import "BMapKit.h"


@interface CtripHBMapViewController : BaseViewController<BMKMapViewDelegate,BMKLocationServiceDelegate>
{
    
    BMKMapView             *CH_mapView;
    BMKLocationService* CH_locService;
    

}

@property (nonatomic,strong) NSString *Longitude;
@property (nonatomic,strong) NSString *Latitude;

@property (nonatomic,strong) NSString *AdressTitle;


@end
