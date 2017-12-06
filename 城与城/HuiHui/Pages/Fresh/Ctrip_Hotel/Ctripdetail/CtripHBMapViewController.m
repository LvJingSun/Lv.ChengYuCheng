//
//  CtripHBMapViewController.m
//  HuiHui
//
//  Created by 冯海强 on 14-9-18.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "CtripHBMapViewController.h"

#import "CustomAnnotation.h"

#import "DDAnnotation.h"


@interface CtripHBMapViewController ()

@end

@implementation CtripHBMapViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.title = self.AdressTitle;
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];    
    [self InitBMap];
}

-(void)InitBMap
{
    // 初始化地图
    CH_mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, WindowSize.size.width,WindowSize.size.height - 44 - 20 )];
    [CH_mapView setZoomLevel:16];
    [self.view addSubview:CH_mapView];
    //初始化BMKLocationService
    CH_locService = [[BMKLocationService alloc]init];
    //添加地理位置图标
    [self addAnination];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)leftClicked{
    [self goBack];
}


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(didStopLocatingUser) userInfo:nil repeats:NO];
}

-(void)viewWillAppear:(BOOL)animated {
    [CH_mapView viewWillAppear];
    CH_mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    CH_locService.delegate = self;
    [self hideTabBar:YES];

}

-(void)viewWillDisappear:(BOOL)animated {
    [CH_mapView viewWillDisappear];
    CH_mapView.delegate = nil; // 不用时，置nil
    CH_locService.delegate = nil;
    CH_mapView.showsUserLocation = NO;

    [self hideTabBar:NO];

}


//普通态
-(void)startLocation
{
    [CH_locService startUserLocationService];
    NSLog(@"进入普通定位态");
    CH_mapView.showsUserLocation = NO;//先关闭显示的定位图层
    CH_mapView.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态
    CH_mapView.showsUserLocation = YES;//显示定位图层
}



-(void)didStopLocatingUser;
{
    
    CLLocationCoordinate2D coordinate;
    
    coordinate.latitude = [self.Latitude doubleValue];
    coordinate.longitude = [self.Longitude doubleValue];
    
    BMKCoordinateRegion viewRegion = BMKCoordinateRegionMake(coordinate,BMKCoordinateSpanMake(1000000.0, 10000000.0));
    BMKCoordinateRegion adjustedRegion = [CH_mapView regionThatFits:viewRegion];
    [CH_mapView setRegion:adjustedRegion animated:YES];
    
}

//设置具体位置

- (void)addAnination{
    
    CLLocationCoordinate2D coordinate;
    
    coordinate.latitude = [self.Latitude doubleValue];
    coordinate.longitude = [self.Longitude doubleValue];
    
    CustomAnnotation *aAnnotion = [[CustomAnnotation alloc] initWithLocation:coordinate];
    aAnnotion.pTag = 111;
    [CH_mapView addAnnotation:aAnnotion];
    [CH_mapView setCenterCoordinate:coordinate animated:YES];
    
//    [self startLocation];
    
}


#pragma mark - BMKMapViewDelegate
///**
// *用户位置更新后，会调用此函数
// *@param userLocation 新的用户位置
// */
//- (void)didUpdateUserLocation:(BMKUserLocation *)userLocation
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    
    [CH_mapView updateLocationData:userLocation];
    
}

//定位失败
- (void)mapView:(BMKMapView *)mapView didFailToLocateUserWithError:(NSError *)error{
    
    [self alertWithMessage:@"定位失败"];
    
    CH_mapView.showsUserLocation = NO;
    
    CH_mapView.delegate = nil;
    
    CH_locService.delegate = nil;

}

//显示地图
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation{
    
    if ([annotation isKindOfClass:[CustomAnnotation class]]) {
        
        CustomAnnotation *temp_annotation = (CustomAnnotation *)annotation;
        
        NSUInteger tag = temp_annotation.pTag;
        NSString *AnnotationViewID = [NSString stringWithFormat:@"AnnotationView-%i", tag];
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:temp_annotation reuseIdentifier:AnnotationViewID];
        //红色打头针
        newAnnotationView.pinColor = BMKPinAnnotationColorRed;
        
        // 设置该标注点动画显示
        newAnnotationView.canShowCallout = YES;
        
        return newAnnotationView;
    }
    return nil;
    
}



//取消选中
- (void)mapView:(BMKMapView *)mapView didDeselectAnnotationView:(BMKAnnotationView *)view{
    
}

//选中地标
-(void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view{
    
}

//区域变化了，图层大小
- (void)mapView:(BMKMapView *)mapView regionWillChangeAnimated:(BOOL)animated{
    
    
}








@end
