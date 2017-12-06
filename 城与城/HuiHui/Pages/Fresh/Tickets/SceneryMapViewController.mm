//
//  SceneryMapViewController.m
//  HuiHui
//
//  Created by mac on 15-1-14.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "SceneryMapViewController.h"

#import "CustomAnnotation.h"


@interface SceneryMapViewController ()

@end

@implementation SceneryMapViewController

@synthesize m_tempView;

@synthesize m_aninationList;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        m_aninationList = [[NSMutableArray alloc]initWithCapacity:0];
        
        m_tempAnnotions = [[NSMutableArray alloc] initWithCapacity:0];

        firstEnterPage = YES;

        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"地图"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    // 初始化地图
    BMKMapView *mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height - 44 - 20)];
    
    self.m_mapView = mapView;
    
    self.m_mapView.delegate = self;
    self.m_mapView.userInteractionEnabled = YES;
    
    //    [self.m_mapView setShowsUserLocation:YES];
    
    [self.m_mapView setZoomLevel:15];
    
    [self.view addSubview:self.m_mapView];
    

    // 测试  数组赋值
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"121.9213",@"latitude",@"30.0921",@"longitude",nil];
    NSMutableDictionary *dic2 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"124.9213",@"latitude",@"29.0921",@"longitude",nil];
    NSMutableDictionary *dic3 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"122.9213",@"latitude",@"31.0921",@"longitude",nil];
    NSMutableDictionary *dic4 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"123.9213",@"latitude",@"23.0921",@"longitude",nil];
    NSMutableDictionary *dic5 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"124.9213",@"latitude",@"33.0921",@"longitude",nil];
    
    [self.m_aninationList addObject:dic1];
    [self.m_aninationList addObject:dic2];
    [self.m_aninationList addObject:dic3];
    [self.m_aninationList addObject:dic4];
    [self.m_aninationList addObject:dic5];
   
    
    // 设置具体经纬度的位置
    [self addAnination];
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self hideTabBar:YES];
    
    [self.m_mapView viewWillAppear];
    
    
    // 判断是否开启定位服务，如果未开启，则默认为上海的坐标;否则进行定位获取经纬度
    if ( ![CLLocationManager locationServicesEnabled] || ([CLLocationManager authorizationStatus]==kCLAuthorizationStatusDenied)) {
        [self.m_mapView viewWillAppear];
        
        
        [self alertWithMessage: @"请在系统设置中开启定位服务。"];
        
        
    }else{
        
        //        self.m_mapView.showsUserLocation = YES;
        
    }
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [self hideTabBar:NO];
    
    [self.m_mapView viewWillDisappear];
    
    
    //    self.m_mapView.showsUserLocation = NO;
    
    self.m_mapView.delegate = nil;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)leftClicked{
    
    [self goBack];
}

//设置具体位置
- (void)addAnination{
    
    if (m_tempAnnotions.count != 0) {
        
        [self.m_mapView removeAnnotations:m_tempAnnotions];
        [m_tempAnnotions removeAllObjects];
    }
    
    for (int i = 0; i < m_aninationList.count; i++) {
        
       NSDictionary *dic = [self.m_aninationList objectAtIndex:i];

        if ( dic ) {
            
            CLLocationCoordinate2D coord;
            coord.latitude = [[dic objectForKey:@"latitude"] doubleValue];
            coord.longitude = [[dic objectForKey:@"longitude"] doubleValue];
            
            CustomAnnotation *yAnnoation = [[CustomAnnotation alloc]initWithLocation:coord];
            yAnnoation.pTag = i;
            [m_tempAnnotions addObject:yAnnoation];
            [self.m_mapView addAnnotation:yAnnoation];
            
            if ( i == 0 && firstEnterPage ) {
                
                [self.m_mapView setCenterCoordinate:coord animated:YES];

                firstEnterPage = NO;

            }
        }
    }
    
}

#pragma mark - BMKMapViewDelegate
- (void)mapView:(BMKMapView *)mapView didUpdateUserLocation:(BMKUserLocation *)userLocation{
    
    //    self.m_mapView.showsUserLocation = NO;
    //
    //    self.m_mapView.delegate = nil;
    
}

//定位失败
- (void)mapView:(BMKMapView *)mapView didFailToLocateUserWithError:(NSError *)error{
    
    [self alertWithMessage:@"定位失败"];
    
    //    self.m_mapView.showsUserLocation = NO;
    //
    //    self.m_mapView.delegate = nil;
    
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
        //        newAnnotationView.image = [UIImage imageNamed:@"blue.png"];
        
        // 设置该标注点动画显示
        newAnnotationView.animatesDrop = YES;
        
        newAnnotationView.canShowCallout = NO;
        
        return newAnnotationView;
    }
    return nil;
    
}

//取消选中
- (void)mapView:(BMKMapView *)mapView didDeselectAnnotationView:(BMKAnnotationView *)view{
    
    self.m_tempView.hidden = YES;
}

//取中地标
-(void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view{
    
    if ( self.m_tempView ) {
        
        [self.m_tempView removeFromSuperview];
    }
    
    //    CustomAnnotation *temp_annotation = (CustomAnnotation *)view.annotation;
    
    
    //获取当前的经纬度
    CLLocationCoordinate2D coordinate;
    
    CustomAnnotation *temp_annotation = (CustomAnnotation *)view.annotation;
    
    NSDictionary *view_data = [self.m_aninationList objectAtIndex:temp_annotation.pTag];
    //获取当前的经纬度
    NSString *lati = [NSString stringWithFormat:@"%@",[view_data objectForKey:@"latitude"]];
    
    NSString *lonti = [NSString stringWithFormat:@"%@",[view_data objectForKey:@"longitude"]];
    
    if ( lati.length != 0 || lonti.length != 0 ) {
        
        coordinate.latitude = [[view_data objectForKey:@"latitude"] floatValue];
        coordinate.longitude = [[view_data objectForKey:@"longitude"] floatValue];
    }
    
    CGPoint ptp = [self.m_mapView convertCoordinate:coordinate toPointToView:self.view];
    
    UIImageView* imageview = [[UIImageView alloc] init];
    
    imageview.frame = CGRectMake(0, 0, 270, 90);
    
    self.m_tempView = [[UIView alloc] initWithFrame:CGRectMake(ptp.x -137, ptp.y-110, imageview.frame.size.width, imageview.frame.size.height)];
    
    self.m_tempView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"common_map_short.png"]];
    
    // 显示商品名称
    UILabel *l_ProductName = [[UILabel alloc]initWithFrame:CGRectMake(15, 3, 246, 35)];
    l_ProductName.backgroundColor = [UIColor clearColor];
    
    // 来自于活动
//    l_ProductName.text = [NSString stringWithFormat:@"%@",[view_data objectForKey:@"ActivityName"]];
//    
//    l_ProductName.font = [UIFont systemFontOfSize:14.0f];
//    l_ProductName.textColor = [UIColor whiteColor];
//    l_ProductName.numberOfLines = 2;
//    [self.m_tempView addSubview:l_ProductName];
//    
//    // 显示地址位置
//    UILabel *l_name = [[UILabel alloc]initWithFrame:CGRectMake(15, 35, 246, 33)];
//    l_name.backgroundColor = [UIColor clearColor];
//    l_name.textColor = [UIColor whiteColor];
//    l_name.text = [NSString stringWithFormat:@"%@%@",[view_data objectForKey:@"AddressDetail"],[view_data objectForKey:@"Address"]];
//    
//    l_name.font = [UIFont systemFontOfSize:12.0f];
//    l_name.numberOfLines = 2;
//    [self.m_tempView addSubview:l_name];
    
    [self.m_mapView addSubview:self.m_tempView];
    
}

//区域变化了，图层大小
- (void)mapView:(BMKMapView *)mapView regionWillChangeAnimated:(BOOL)animated{
    
    self.m_tempView.hidden = YES;
    
}

@end
