//
//  CtriphotellistViewController.m
//  HuiHui
//
//  Created by 冯海强 on 14-9-16.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "CtriphotellistViewController.h"

#import "CtriphotellistCell.h"

#import "CtriphoteldetailViewController.h"

#import "CommonUtil.h"

#import "Ctrip_config.h"

#import "XMLDictionary.h"
#import "Hotel_CitylistDB.h"



@interface CtriphotellistViewController ()
{
    UIButton *_button;
    Hotel_CitylistDB *dbhelp;

}

@property (nonatomic,strong)NSMutableArray * Ctrip_hotelarray;

@property (nonatomic,strong)NSDictionary * Ctrip_regiondic;//行政区
@property (strong, nonatomic) NSMutableArray *CitysSource;


@end

@implementation CtriphotellistViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.Ctrip_hotelarray = [[NSMutableArray alloc] initWithCapacity:0];
        self.Ctrip_hotelInfomation = [[NSMutableDictionary alloc]initWithCapacity:0];
        dbhelp = [[Hotel_CitylistDB alloc] init];
        _CitysSource = [NSMutableArray array];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"酒店"];
    
    indexpage = 1;
    
    self.Ctrip_hoteltableview.hidden = YES;
    [self.Ctrip_hoteltableview setPullDelegate:self];
    self.Ctrip_hoteltableview.pullBackgroundColor = [UIColor whiteColor];
    self.Ctrip_hoteltableview.useRefreshView = YES;
    self.Ctrip_hoteltableview.useLoadingMoreView= YES;
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    self.Ctrip_hotelmyaddress.text = [NSString stringWithFormat:@"您的位置：%@",[CommonUtil getValueByKey:kALLSelectAddress]];
    
    _button= [UIButton buttonWithType:UIButtonTypeCustom];
    [_button setFrame:CGRectMake(0, 0, 50, 29)];
    _button.backgroundColor = [UIColor clearColor];
    [_button setImage:[UIImage imageNamed:@"icon_hotel_refresh.png"] forState:UIControlStateNormal];
    [_button addTarget:self action:@selector(startAnimation) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *_barButton = [[UIBarButtonItem alloc] initWithCustomView:_button];
    [self.navigationItem setRightBarButtonItem:_barButton];


    [self Ctrip_hotelRequest];

    [self setExtraCellLineHidden:self.Ctrip_hoteltableview];
    
    [self InitBMap];
    
    self.CitysSource = [NSMutableArray arrayWithArray: [dbhelp queryCity]];

}

-(void)Gethotel_cityid
{
    for (NSDictionary *dic in self.CitysSource) {
        
        NSString *string = [dic objectForKey:@"CityName"];
        
        if ( [string isEqualToString:[NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:kSelectCityName]]] ) {
            
            [CommonUtil addValue:[NSString stringWithFormat:@"%@",[dic objectForKey:@"CityId"]] andKey:hotelCityCode];
            return;
        }
        
    }
    
}

-(void)InitBMap
{
    // 初始化地图
    CH_mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, WindowSize.size.width,WindowSize.size.height - 44 - 20 )];
    //初始化BMKLocationService
    CH_locService = [[BMKLocationService alloc]init];
    m_search = [[BMKGeoCodeSearch alloc]init];
    
}

- (void)startAnimation
{
    if ( (![CLLocationManager locationServicesEnabled]) || ([CLLocationManager authorizationStatus]==kCLAuthorizationStatusDenied)) {
        [self alertWithMessage:@"为了不影响您的正常使用\n请在系统设置中开启定位服务！"];
        return;
    }
    
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = 1;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = MAXFLOAT;
    
    [_button.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    
    [self startLocation];
    self.Ctrip_hotelmyaddress.text = @"您的位置：正在定位…";
    _button.userInteractionEnabled = NO;
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

- (void)stopAnimation
{
    [_button.layer removeAllAnimations];

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)didUpdateUserLocation:(BMKUserLocation *)userLocation;
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    
    CLLocationCoordinate2D pt = (CLLocationCoordinate2D){0, 0};
    pt = (CLLocationCoordinate2D){userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude};
    
    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    reverseGeocodeSearchOption.reverseGeoPoint = pt;
    
     [m_search reverseGeoCode:reverseGeocodeSearchOption];

}

-(void)BtnuserInteraction{
    _button.userInteractionEnabled = YES;
}


- (void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    if (error == 0) {
        BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
        item.coordinate = result.location;
        item.title = result.address;
        
        [CH_locService stopUserLocationService];
        CH_mapView.showsUserLocation = NO;

        [self Gethotel_cityid];
        [self stopAnimation];
        [NSTimer scheduledTimerWithTimeInterval:15 target:self selector:@selector(BtnuserInteraction) userInfo:nil repeats:NO];

        NSString *cityName = [NSString stringWithFormat:@"%@",result.addressDetail.city];
        
        [CommonUtil addValue:[NSString stringWithFormat:@"%f",result.location.latitude] andKey:kLatitudeKey];
        [CommonUtil addValue:[NSString stringWithFormat:@"%f",result.location.longitude] andKey:kLongitudeKey];
        [CommonUtil addValue:[cityName substringWithRange:NSMakeRange(0, cityName.length - 1)] andKey:kSelectCityName];
        [CommonUtil addValue:[NSString stringWithFormat:@"%@%@",result.addressDetail.streetName,result.addressDetail.streetNumber] andKey:kSelectAddress];

        self.Ctrip_hotelmyaddress.text = [NSString stringWithFormat:@"您的位置：%@",result.address];
        
        if ((![cityName isEqualToString:@""]) && (![result.address isEqualToString:[CommonUtil getValueByKey:kALLSelectAddress]])) {

            [CommonUtil addValue:result.address andKey:kALLSelectAddress];

            indexpage =1;
            [self Ctrip_hotelRequest];
            
            
        }

    }

}

//定位失败
- (void)mapView:(BMKMapView *)mapView didFailToLocateUserWithError:(NSError *)error{
    
    [SVProgressHUD showErrorWithStatus:@"定位失败，请重新刷新…"];
    [self stopAnimation];

}

- (void)leftClicked{
    
    [self goBack];
}


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"行政区" ofType:@"xml"];
//    NSString *xmlString = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
//    NSLog(@"string: %@", xmlString);
//    
//    self.Ctrip_regiondic = [NSMutableDictionary dictionaryWithXMLString:xmlString];
    
}


- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self hideTabBar:YES];
    
    CH_mapView.delegate = self;
    CH_locService.delegate = self;
    m_search.delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [self hideTabBar:NO];
    
    [SVProgressHUD dismiss];
    
    CH_mapView.delegate = nil;
    CH_locService.delegate = nil;
    m_search.delegate = nil;
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint translation = [scrollView.panGestureRecognizer translationInView:scrollView.superview];
    
    if (translation.y>0) {
        
        
        
    }
}



#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.Ctrip_hotelarray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"CtriphotelCellIdentifier";
    
    CtriphotellistCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"CtriphotellistCell" owner:self options:nil];
        
        cell = (CtriphotellistCell *)[nib objectAtIndex:0];
        
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
    }
        
    NSDictionary * Ctriphoteldic = [self.Ctrip_hotelarray objectAtIndex:indexPath.row];
    
    [cell setCtrip_hotelImage:[Ctriphoteldic objectForKey:@"ImgText"]];
    
    cell.hotel_name.text = [NSString stringWithFormat:@"%@",[Ctriphoteldic objectForKey:@"HotelName"]];
    cell.hotel_score.text = [NSString stringWithFormat:@"%.1f",[[Ctriphoteldic objectForKey:@"CtripCommRate"] floatValue]];
    
    cell.hotel_pice.text = [NSString stringWithFormat:@"￥%@",[Ctriphoteldic objectForKey:@"MinRate"]];
    
    cell.hotel_type.text = [NSString stringWithFormat:@"%@",[Ctriphoteldic objectForKey:@"SegmentCategoryName"]];
    
    cell.hotel_area.text = [NSString stringWithFormat:@"%@",[Ctriphoteldic objectForKey:@"Address"]];
    
    float a =[[CommonUtil getValueByKey:kLatitudeKey] floatValue];
    float b = [[Ctriphoteldic  objectForKey:@"Latitude"] floatValue];
    float c =[[CommonUtil getValueByKey:kLongitudeKey] floatValue];
    float d =[[Ctriphoteldic objectForKey:@"Longitude"] floatValue];
    cell.hotel_distance.text = [Ctrip_Config distanceBetweenOrderBy:a :b :c :d];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80.0f;
    
}


#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    CtriphoteldetailViewController * VC = [[CtriphoteldetailViewController alloc]initWithNibName:@"CtriphoteldetailViewController" bundle:nil];
    
    VC.Ctriphotel_detailheadD = [self.Ctrip_hotelarray objectAtIndex:indexPath.row];
    VC.Ctrip_hotelInfomation = self.Ctrip_hotelInfomation;
    
    [self.navigationController pushViewController:VC animated:YES];

    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}

#pragma mark - 酒店请求
-(void)Ctrip_hotelRequest
{
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        return;
    }

    AppHttpClient* httpClient = [AppHttpClient sharedCtrip];

    if (self.Ctrip_hotelarray.count ==0) {
        [SVProgressHUD showWithStatus:@"数据加载中…"];
    }
    
    NSString *HotelNameKey =[[NSString stringWithFormat:@"%@",[self.Ctrip_hotelInfomation objectForKey:@"Ctriphotel_KeyWord"]] stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           [NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:hotelCityCode]],@"hotelCityCode",
                           HotelNameKey,@"hotelName",
                           [NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:kLatitudeKey]],@"latitude",
                           [NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:kLongitudeKey]],@"longitude",
                           [NSString stringWithFormat:@"%d",indexpage], @"pageIndex",
                           nil];
    
    NSLog(@"%@",param);
    
    [httpClient requestCtrip:@"HotelList.ashx" parameters:param success:^(NSJSONSerialization* json) {
        [SVProgressHUD dismiss];
        BOOL success = [[json valueForKey:@"status"] boolValue];
        NSLog(@"%@",[json valueForKey:@"msg"]);
        if (success) {
            NSMutableArray *resultList = [json valueForKey:@"HotelListSession"];
            if (indexpage == 1) {
                if (resultList == nil || resultList.count == 0) {
                    [self.Ctrip_hotelarray removeAllObjects];
                    self.Ctrip_hoteltableview.hidden = YES;
                    return;
                } else {
                    self.Ctrip_hotelarray = [json valueForKey:@"HotelListSession"];
                    self.Ctrip_hoteltableview.hidden = NO;
                }
            } else {
                self.Ctrip_hoteltableview.hidden = NO;
                if (resultList == nil || resultList.count == 0) {
                    indexpage--;
                } else {
                    [self.Ctrip_hotelarray addObjectsFromArray:resultList];
                }
            }
            [self.Ctrip_hoteltableview reloadData];
            
            //缓行之计 线程
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                if (![HotelNameKey isEqualToString:@""]) {
                    NSMutableArray *arr = [CommonUtil getValueByKey:@"HotelNameKeyArray"];
                    for (int i=0; i<arr.count; i++) {
                        if ([[arr objectAtIndex:i] isEqualToString:HotelNameKey]) {
                            return;
                        }
                    }
                    [arr insertObject:HotelNameKey atIndex:0];
                    [CommonUtil addValue:arr andKey:@"HotelNameKeyArray"];
                }
            });


        } else {
            if (indexpage > 1) {
                indexpage--;
            }
            [SVProgressHUD showErrorWithStatus:[json valueForKey:@"msg"]];
        }
        self.Ctrip_hoteltableview.pullLastRefreshDate = [NSDate date];
        self.Ctrip_hoteltableview.pullTableIsRefreshing = NO;
        self.Ctrip_hoteltableview.pullTableIsLoadingMore = NO;
    } failure:^(NSError *error) {
        self.Ctrip_hoteltableview.hidden = YES;
        [SVProgressHUD showErrorWithStatus:@"获取酒店失败"];
        self.Ctrip_hoteltableview.pullTableIsRefreshing = NO;
        self.Ctrip_hoteltableview.pullTableIsLoadingMore = NO;
    }];

}

#pragma mark - PullTableViewDelegate
- (void)pullTableViewDidTriggerRefresh:(PullTableView*)pullTableView {
    [self.Ctrip_hotelInfomation setObject:@"" forKey:@"Ctriphotel_KeyWord"];
    indexpage = 1;
    [self Ctrip_hotelRequest];
}


- (void)pullTableViewDidTriggerLoadMore:(PullTableView*)pullTableView {
    indexpage ++;
    [self Ctrip_hotelRequest];
}






@end
