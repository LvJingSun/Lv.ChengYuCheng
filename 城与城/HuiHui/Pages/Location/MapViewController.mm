//
//  MapShowViewController.m
//  HuiHui
//
//  Created by mac on 13-12-3.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import "MapViewController.h"

#import "CustomAnnotation.h"

@interface MapViewController ()

@end

@implementation MapViewController

@synthesize m_tempView;

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
    CLLocationCoordinate2D coordinate;
    if ([self.m_FromDPId isEqualToString:@"1"]) {
        coordinate.latitude = [[self.item objectForKey:@"latitude"] floatValue];
        coordinate.longitude = [[self.item objectForKey:@"longitude"] floatValue];
    }else{
        coordinate.latitude = [[self.item objectForKey:@"MapY"] floatValue];
        coordinate.longitude = [[self.item objectForKey:@"MapX"] floatValue];
    }
    
    CustomAnnotation *aAnnotion = [[CustomAnnotation alloc] initWithLocation:coordinate];
    aAnnotion.pTag = 111;
    [self.m_mapView addAnnotation:aAnnotion];
    [self.m_mapView setCenterCoordinate:coordinate animated:YES];

    
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
    
    // 判断是来自于3 活动还是其他的
    if ( [self.m_shopString isEqualToString:@"3"] ) {
        
        //获取当前的经纬度
        NSString *lati = [NSString stringWithFormat:@"%@",[self.item objectForKey:@"MapY"]];
        
        NSString *lonti = [NSString stringWithFormat:@"%@",[self.item objectForKey:@"MapX"]];
        
        if ( lati.length != 0 || lonti.length != 0 ) {
            
            coordinate.latitude = [[self.item objectForKey:@"MapY"] floatValue];
            coordinate.longitude = [[self.item objectForKey:@"MapX"] floatValue];
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
        l_ProductName.text = [NSString stringWithFormat:@"%@",[self.item objectForKey:@"ActivityName"]];
        
        l_ProductName.font = [UIFont systemFontOfSize:14.0f];
        l_ProductName.textColor = [UIColor whiteColor];
        l_ProductName.numberOfLines = 2;
        [self.m_tempView addSubview:l_ProductName];
        
        // 显示地址位置
        UILabel *l_name = [[UILabel alloc]initWithFrame:CGRectMake(15, 35, 246, 33)];
        l_name.backgroundColor = [UIColor clearColor];
        l_name.textColor = [UIColor whiteColor];
        l_name.text = [NSString stringWithFormat:@"%@%@",[self.item objectForKey:@"AddressDetail"],[self.item objectForKey:@"Address"]];
        
        l_name.font = [UIFont systemFontOfSize:12.0f];
        l_name.numberOfLines = 2;
        [self.m_tempView addSubview:l_name];
        
        [self.m_mapView addSubview:self.m_tempView];
        
    }else{
        
        //来自大众点评
        if ([self.m_FromDPId isEqualToString:@"1"]) {
            
            NSString *lati = [NSString stringWithFormat:@"%@",[self.item objectForKey:@"latitude"]];
            
            NSString *lonti = [NSString stringWithFormat:@"%@",[self.item objectForKey:@"longitude"]];
            
            if ( lati.length != 0 || lonti.length != 0 ) {
                
                coordinate.latitude = [[NSString stringWithFormat:@"%@",[self.item objectForKey:@"latitude"]] floatValue];
                coordinate.longitude = [[NSString stringWithFormat:@"%@",[self.item objectForKey:@"longitude"]] floatValue];
            }
            
        }else{
        
        

        NSString *lati = [NSString stringWithFormat:@"%@",[self.item objectForKey:@"MapY"]];
        
        NSString *lonti = [NSString stringWithFormat:@"%@",[self.item objectForKey:@"MapX"]];
        
        if ( lati.length != 0 || lonti.length != 0 ) {
            
            coordinate.latitude = [[self.item objectForKey:@"MapY"] floatValue];
            coordinate.longitude = [[self.item objectForKey:@"MapX"] floatValue];
        }
            }
        
        
        CGPoint ptp = [self.m_mapView convertCoordinate:coordinate toPointToView:self.view];
        
        UIImageView* imageview = [[UIImageView alloc] init];
        
        imageview.frame = CGRectMake(0, 0, 271, 157);
        
        self.m_tempView = [[UIView alloc] initWithFrame:CGRectMake(ptp.x -137, ptp.y-180, imageview.frame.size.width, imageview.frame.size.height)];
        
        self.m_tempView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"common_bg_map.png"]];
        
        // 显示商品名称
        UILabel *l_ProductName = [[UILabel alloc]initWithFrame:CGRectMake(15, 8, 246, 42)];
        l_ProductName.backgroundColor = [UIColor clearColor];
        // 店铺显示店铺的名称 商户显示商户的名称
        if ( [self.m_shopString isEqualToString:@"1"] ) {
            
            //来自大众点评
            if ([self.m_FromDPId isEqualToString:@"1"]) {
                
                l_ProductName.text = [NSString stringWithFormat:@"%@",[self.item objectForKey:@"name" ] ];
            }else{
                
                l_ProductName.text = [NSString stringWithFormat:@"%@",[self.item objectForKey:@"ShopName"]];
            }
            
        }else if ( [self.m_shopString isEqualToString:@"2"] ){
            
            l_ProductName.text = [NSString stringWithFormat:@"%@",[self.item objectForKey:@"MctName"]];
            
        }
        
        l_ProductName.font = [UIFont systemFontOfSize:18.0f];
        l_ProductName.textColor = [UIColor whiteColor];
        l_ProductName.numberOfLines = 2;
        [self.m_tempView addSubview:l_ProductName];
        
        // 显示地址位置
        //        UILabel *l_name = [[UILabel alloc]initWithFrame:CGRectMake(15, 55, 246, 21)];
        //        l_name.backgroundColor = [UIColor clearColor];
        //        l_name.textColor = [UIColor whiteColor];
        //        l_name.text = [NSString stringWithFormat:@"%@",[self.item  objectForKey:@"ShopName"]];
        //        l_name.font = [UIFont systemFontOfSize:12.0f];
        //
        //        [self.m_tempView addSubview:l_name];
        
        UILabel *l_address = [[UILabel alloc]initWithFrame:CGRectMake(15, 50, 246, 36)];
        l_address.backgroundColor = [UIColor clearColor];
        l_address.textColor = [UIColor whiteColor];
        l_address.numberOfLines = 2;
        if ([self.m_FromDPId isEqualToString:@"1"]) {
            
            l_address.text = [NSString stringWithFormat:@"地址：%@",[self.item objectForKey:@"address"]];
            
        }else{
            
            l_address.text = [NSString stringWithFormat:@"地址：%@",[self.item  objectForKey:@"Address"]];
            
        }
        l_address.font = [UIFont systemFontOfSize:12.0f];
        
        [self.m_tempView addSubview:l_address];
        
        UILabel *l_time = [[UILabel alloc]initWithFrame:CGRectMake(15, 82, 246, 21)];
        l_time.backgroundColor = [UIColor clearColor];
        l_time.textColor = [UIColor whiteColor];
        if ([self.m_FromDPId isEqualToString:@"1"]) {
            
            l_time.text = [NSString stringWithFormat:@"营业时间：-=-=-==-=-=-"];
            l_time.text = [NSString stringWithFormat:@"营业时间："];
            
        }else{
            
            l_time.text = [NSString stringWithFormat:@"营业时间：%@",[self.item  objectForKey:@"OpeningHours"]];
            
        }
        l_time.font = [UIFont systemFontOfSize:12.0f];
        [self.m_tempView addSubview:l_time];
        
        
        UILabel *l_phone = [[UILabel alloc]initWithFrame:CGRectMake(15, 105, 246, 21)];
        l_phone.backgroundColor = [UIColor clearColor];
        l_phone.textColor = [UIColor whiteColor];
        if ([self.m_FromDPId isEqualToString:@"1"]) {
            
            l_phone.text = [NSString stringWithFormat:@"咨询电话：%@",[self.item  objectForKey:@"telephone"]];
            
        }else{
            
            l_phone.text = [NSString stringWithFormat:@"咨询电话：%@",[self.item  objectForKey:@"Phone"]];
            
        }
        l_phone.font = [UIFont systemFontOfSize:12.0f];
        [self.m_tempView addSubview:l_phone];
        
        [self.m_mapView addSubview:self.m_tempView];
        
    }
    
}

//区域变化了，图层大小 
- (void)mapView:(BMKMapView *)mapView regionWillChangeAnimated:(BOOL)animated{
    
    self.m_tempView.hidden = YES;
    
}

@end
