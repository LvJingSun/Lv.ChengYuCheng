//
//  BBMapViewController.m
//  HuiHui
//
//  Created by mac on 14-7-15.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "BBMapViewController.h"
#import "DDAnnotation.h"
#import "DDAnnotationView.h"
#import "SVProgressHUD.h"

@interface BBMapViewController ()
{
    int dele;
}
@property (nonatomic,weak) IBOutlet UIButton *searchBtn;

-(IBAction)chosecity:(id)sender;

-(IBAction)onClickGeocode:(id)sender;

@end

@implementation BBMapViewController

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
   
    [self setRightButtonWithTitle:@"保存" action:@selector(BMapSaveBtn)];

   
    _locService = [[BMKLocationService alloc]init];

    // 用于反编译
    _geocodesearch = [[BMKGeoCodeSearch alloc]init];
    
    
    if ([self.item objectForKey:@"MapX"]==nil||[self.item objectForKey:@"MapY"]==nil||[self.item objectForKey:@"HC"]==nil)
    {
        // 定位
        NSLog(@"进入普通定位态");
        _addrText.text = @"正在定位……";
        [_mapView setZoomLevel:18];
        _mapzoomlevel = 18;
        [_locService startUserLocationService];
        _mapView.showsUserLocation = NO;//先关闭显示的定位图层
        _mapView.userTrackingMode = BMKUserTrackingModeFollow;//设置定位的状态
        _mapView.showsUserLocation = YES;//显示定位图层
        
    }else{
        
        CLLocationCoordinate2D pt = (CLLocationCoordinate2D){0, 0};
        
        pt = (CLLocationCoordinate2D){[[self.item objectForKey:@"MapY"] floatValue], [[self.item objectForKey:@"MapX"] floatValue]};
        
        BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
        reverseGeocodeSearchOption.reverseGeoPoint = pt;
        
        BOOL flag = [_geocodesearch reverseGeoCode:reverseGeocodeSearchOption];
        
        [_mapView setZoomLevel:18];

        _mapzoomlevel = 18;

        if(flag)
        {
            NSLog(@"反geo检索发送成功");
        }
        else
        {
            NSLog(@"反geo检索发送失败");
            
        }
        
    }
    
}

-(void)viewWillAppear:(BOOL)animated {
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _locService.delegate = self;
    _geocodesearch.delegate = self;
    
    
    [self hideTabBar:YES];
}

-(void)viewWillDisappear:(BOOL)animated {
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _locService.delegate = nil;
    _geocodesearch.delegate = nil;
    
    [self hideTabBar:NO];

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)leftClicked{
    
    [self goBack];
}

/**
 *在地图View将要启动定位时，会调用此函数
 *@param mapView 地图View
 */
- (void)mapViewWillStartLocatingUser:(BMKMapView *)mapView
{
	NSLog(@"start locate");
}

/**
 *用户方向更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    [_mapView updateLocationData:userLocation];
    NSLog(@"heading is %@",userLocation.heading);
    
    if ( userLocation.location.coordinate.latitude != 0.000000 && userLocation.location.coordinate.longitude != 0.000000 ) {
        
        [_locService stopUserLocationService];
        
        _locService.delegate = nil;

    }
}

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
//- (void)didUpdateUserLocation:(BMKUserLocation *)userLocation
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    
//    
    [_mapView updateLocationData:userLocation];
    
    _mapy = userLocation.location.coordinate.latitude;
    _mapx = userLocation.location.coordinate.longitude;
    
    CLLocationCoordinate2D pt = (CLLocationCoordinate2D){0, 0};
    
    pt = (CLLocationCoordinate2D){userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude};
    
    
    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    reverseGeocodeSearchOption.reverseGeoPoint = pt;
    
    BOOL flag = [_geocodesearch reverseGeoCode:reverseGeocodeSearchOption];
    
    if(flag)
    {
        NSLog(@"反geo检索发送成功");
    }
    else
    {
        NSLog(@"反geo检索发送失败");
        
    }
    
}


/**
 *在地图View停止定位后，会调用此函数
 *@param mapView 地图View
 */
- (void)mapViewDidStopLocatingUser:(BMKMapView *)mapView
{
    NSLog(@"stop locate");
}

/**
 *定位失败后，会调用此函数
 *@param mapView 地图View
 *@param error 错误号，参考CLError.h中定义的错误号
 */


- (void)mapView:(BMKMapView *)mapView didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"location error");
    
    if (remind == 0 ) {
        
        [SVProgressHUD dismiss];
        address = @"";
        _mapx=0.000000;
        _mapy=0.000000;
        _addrText.text=@"";
        remind ++;
        UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"提醒" message:@"未能完成定位" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        
    }

}

//根据anntation生成对应的View
- (BMKAnnotationView *)mapView:(BMKMapView *)view viewForAnnotation:(id <BMKAnnotation>)annotation
{
    NSString *AnnotationViewID = @"annotationViewID";
	//根据指定标识查找一个可被复用的标注View，一般在delegate中使用，用此函数来代替新申请一个View
    BMKAnnotationView *annotationView = [view dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
    if (annotationView == nil) {
        annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
		((BMKPinAnnotationView*)annotationView).pinColor = BMKPinAnnotationColorRed;
		((BMKPinAnnotationView*)annotationView).animatesDrop = YES;
    }
	
	annotationView.centerOffset = CGPointMake(0, -(annotationView.frame.size.height * 0.5));
    annotationView.annotation = annotation;
	annotationView.canShowCallout = YES;
    
    [annotationView setDraggable:YES];//设置可Dragg
    
    DDAnnotation *annotation1 = (DDAnnotation *)annotation;
    annotation1.subtitle = [NSString stringWithFormat:@"%f,%f", annotation.coordinate.latitude, annotation.coordinate.longitude];
    
    _mapy=annotation.coordinate.latitude;
    _mapx=annotation.coordinate.longitude;
    
    NSLog(@"%f,%f",_mapx,_mapy);
    
    [SVProgressHUD dismiss];
    
    return annotationView;
}

-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    
    [MyTimer invalidate];
    
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
	[_mapView removeAnnotations:array];
	array = [NSArray arrayWithArray:_mapView.overlays];
	[_mapView removeOverlays:array];
	if (error == 0) {
		BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
        
		item.coordinate = result.location;
		item.title = result.address;
        
        address = item.title;
        _addrText.text = address;
        
        if ([locationself isEqualToString:@"Notlocationself"]){
        }else{
            if (![address isEqualToString:@""]) {
                _cityText.text = [address substringWithRange:NSMakeRange(3, 2)];//城市
            }
            
        }
        
	    [_mapView addAnnotation:item];
        
        _mapView.centerCoordinate = result.location;
        
        
	}
    
    [_locService stopUserLocationService];

}

/**
 *返回地址信息搜索结果
 *@param searcher 搜索对象
 *@param result 搜索结BMKGeoCodeSearch果
 *@param error 错误号，@see BMKSearchErrorCode
 */
- (void)onGetGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error;
{
  
    [MyTimer invalidate];
    
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
	[_mapView removeAnnotations:array];
	array = [NSArray arrayWithArray:_mapView.overlays];
	[_mapView removeOverlays:array];
	if (error == 0) {
		BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
        
		item.coordinate = result.location;
		item.title = result.address;
        
        address = item.title;
        _addrText.text = address;
        
        if ([locationself isEqualToString:@"Notlocationself"]){
        }else{
            if (![address isEqualToString:@""]) {
                _cityText.text = [address substringWithRange:NSMakeRange(3, 2)];//城市
            }
            
        }
        
	    [_mapView addAnnotation:item];
        
        _mapView.centerCoordinate = result.location;
        
        
	}
    
}


//点击地图空白处
- (void)mapView:(BMKMapView *)mapView onClickedMapBlank:(CLLocationCoordinate2D)coordinate;
{
    [_addrText resignFirstResponder];
    
}



//地图改变状态
- (void)mapStatusDidChanged:(BMKMapView *)mapView;
{
    
    [_addrText resignFirstResponder];
    
    _mapzoomlevel = mapView.zoomLevel;
    
    
}

/**
 *拖动annotation view时，若view的状态发生变化，会调用此函数。ios3.2以后支持
 
 */
- (void)mapView:(BMKMapView *)mapView annotationView:(BMKAnnotationView *)view didChangeDragState:(BMKAnnotationViewDragState)newState
   fromOldState:(BMKAnnotationViewDragState)oldState;
{
    
    if (oldState == BMKAnnotationViewDragStateDragging)
    {
        
		DDAnnotation *annotation = (DDAnnotation *)view.annotation;
		annotation.subtitle = [NSString	stringWithFormat:@"%f,%f", annotation.coordinate.latitude, annotation.coordinate.longitude];
        
        _mapy=annotation.coordinate.latitude;
        _mapx=annotation.coordinate.longitude;
        
        CLLocationCoordinate2D pt = (CLLocationCoordinate2D){0, 0};
        pt = (CLLocationCoordinate2D){_mapy, _mapx};
        
        BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
        reverseGeocodeSearchOption.reverseGeoPoint = pt;
        [_geocodesearch reverseGeoCode:reverseGeocodeSearchOption];
        
        
	}
    
}

- (void)BMapSaveBtn
{
    
    [SVProgressHUD dismiss];
    
    if ([address isEqualToString:@""]||_mapx == 0.000000||_mapy == 0.000000|| _mapzoomlevel==0 ) {
        [SVProgressHUD showErrorWithStatus:@"未定位到地位"];
        return;
    }
 
    
    
    [self.Chosemapdelegate ChosesMapValue:address mapx:[NSString stringWithFormat:@"%f",_mapx] mapy:[NSString stringWithFormat:@"%f",_mapy] level:[NSString stringWithFormat:@"%d",_mapzoomlevel]];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark - BtnClicked
-(IBAction)chosecity:(id)sender
{
    DowncellViewController*downVC=[[DowncellViewController alloc]initWithNibName:@"DowncellViewController" bundle:nil];
    downVC.Itemstyle = @"B_city";
    
    downVC.Chosedelegate = self;
    
    [self.navigationController pushViewController:downVC animated:YES];
    
    
}

//查找
-(IBAction)onClickGeocode:(id)sender
{
    [_addrText resignFirstResponder];
    
    locationself = @"Notlocationself";
    
    if ([_cityText.text isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus:@"请选择城市"];
        return;
    }
    if ([_addrText.text isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus:@"请输入地址"];
        return;
    }
    
    [SVProgressHUD showWithStatus:@"正在定位……"];
    [_mapView setShowsUserLocation:NO];
    
    
    BMKGeoCodeSearchOption *geocodeSearchOption = [[BMKGeoCodeSearchOption alloc]init];
    geocodeSearchOption.city= _cityText.text;
    geocodeSearchOption.address = _addrText.text;
    

    NSLog(@"%@",geocodeSearchOption.address);
    
    
    
    BOOL flag = [_geocodesearch geoCode:geocodeSearchOption];
    
    if(flag)
    {
        NSLog(@"检索发送成功");
    }
    else
    {
        NSLog(@"检索发送失败");
        
    }
    
    
    
    
    
    

    MyTimer =  [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(SVdismiss) userInfo:nil repeats:NO];
    
}

-(void)SVdismiss
{
    
    [SVProgressHUD showErrorWithStatus:@"定位未成功"];
}


- (void)ChosescityValue:(NSString *)value code:(NSString *)citycode
{
    _cityText.text =  value;
    
}


#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField;
{
    
    if (textField == _addrText)
    {
        [self hiddenNumPadDone:nil];
    }
    
    return YES;
}



@end
