//
//  SceneryMapViewController.m
//  HuiHui
//
//  Created by mac on 15-1-14.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "SceneryMapViewController.h"

#import "CustomAnnotation.h"

#import "UIImageView+AFNetworking.h"

#import "CommonUtil.h"

@interface SceneryMapViewController ()

@end

@implementation SceneryMapViewController

@synthesize m_tempView;

@synthesize m_aninationList;

@synthesize m_imageUrl;

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
    
    [self.m_mapView setShowsUserLocation:YES];
    
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
        
//                self.m_mapView.showsUserLocation = YES;
        
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
            coord.latitude = [[dic objectForKey:@"lat"] doubleValue];
            coord.longitude = [[dic objectForKey:@"lon"] doubleValue];
            
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
//        newAnnotationView.pinColor = BMKPinAnnotationColorRed;
        
        // 设置显示的图标
        newAnnotationView.image = [UIImage imageNamed:@"icon_hh_scenery_map.png"];
        
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
    NSString *lati = [NSString stringWithFormat:@"%@",[view_data objectForKey:@"lat"]];
    
    NSString *lonti = [NSString stringWithFormat:@"%@",[view_data objectForKey:@"lon"]];
    
    if ( lati.length != 0 || lonti.length != 0 ) {
        
        coordinate.latitude = [[view_data objectForKey:@"lat"] floatValue];
        coordinate.longitude = [[view_data objectForKey:@"lon"] floatValue];
    }
    
    CGPoint ptp = [self.m_mapView convertCoordinate:coordinate toPointToView:self.view];
    
    UIImageView* imageview = [[UIImageView alloc] init];
    
    imageview.frame = CGRectMake(0, 0, 270, 90);
    
    self.m_tempView = [[UIView alloc] initWithFrame:CGRectMake(ptp.x -137, ptp.y-110, imageview.frame.size.width, imageview.frame.size.height)];
    
    self.m_tempView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"common_map_short.png"]];
    
    // 添加图片
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 67, 50)];
    
    NSString *path = [NSString stringWithFormat:@"%@%@",self.m_imageUrl,[view_data objectForKey:@"imgPath"]];
    
    [imageV setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:path]]
                            placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"]
                                     success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                                         
                                         imageV.image = [CommonUtil scaleImage:image toSize:CGSizeMake(67 , 50)];
                                         imageV.contentMode = UIViewContentModeScaleToFill;
                                         
//                                         [self.imageCache addImage:self.m_showImagV.image andUrl:path];
                                     }
                                     failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                                         
                                     }];
    

    [self.m_tempView addSubview:imageV];

    
    // 显示景区名称
    UILabel *l_ProductName = [[UILabel alloc]initWithFrame:CGRectMake(80, 3, 180, 21)];
    l_ProductName.backgroundColor = [UIColor clearColor];

    l_ProductName.text = [NSString stringWithFormat:@"%@",[view_data objectForKey:@"sceneryName"]];
    l_ProductName.font = [UIFont systemFontOfSize:14.0f];
    l_ProductName.textColor = [UIColor whiteColor];
    l_ProductName.numberOfLines = 1;
    [self.m_tempView addSubview:l_ProductName];
    
    // 显示副标题
    UILabel *l_subTitle = [[UILabel alloc]initWithFrame:CGRectMake(80, 22, 180, 28)];
    l_subTitle.backgroundColor = [UIColor clearColor];
    
    // 判断副标题是否有值
    NSString *string = [NSString stringWithFormat:@"%@",[view_data objectForKey:@"scenerySummary"]];

    if ( [string isEqualToString:@"(null)"] || string.length == 0 ) {
        
        string = @"";
        
    }
    
    l_subTitle.text = [NSString stringWithFormat:@"%@",string];
    l_subTitle.font = [UIFont systemFontOfSize:10.0f];
    l_subTitle.textColor = [UIColor whiteColor];
    l_subTitle.numberOfLines = 2;
    [self.m_tempView addSubview:l_subTitle];
    
    
    
    // 显示地址位置
    UILabel *l_name = [[UILabel alloc]initWithFrame:CGRectMake(80, 46, 180, 21)];
    l_name.backgroundColor = [UIColor clearColor];
    l_name.textColor = [UIColor whiteColor];
    l_name.text = [NSString stringWithFormat:@"地址:%@",[view_data objectForKey:@"sceneryAddress"]];
    
    l_name.font = [UIFont systemFontOfSize:10.0f];
    l_name.numberOfLines = 2;
    [self.m_tempView addSubview:l_name];
    
    [self.m_mapView addSubview:self.m_tempView];
    
}

//区域变化了，图层大小
- (void)mapView:(BMKMapView *)mapView regionWillChangeAnimated:(BOOL)animated{
    
    self.m_tempView.hidden = YES;
    
}

@end
