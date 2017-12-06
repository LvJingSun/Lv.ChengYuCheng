//
//  FlightCityListViewController.m
//  HuiHui
//
//  Created by mac on 14-12-5.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "FlightCityListViewController.h"

#import "RootViewController.h"

#import "CommonUtil.h"

#import "AreaCell.h"

#import "FlightCityHelper.h"

#import "JPinYinUtil.h"

@interface FlightCityListViewController ()
{
    FlightCityHelper *dbhelp;
    
}


@property (weak, nonatomic) IBOutlet UISearchBar *m_searchBar;

@property (weak, nonatomic) IBOutlet UITableView *m_tableView;

@property (weak, nonatomic) IBOutlet UIView *m_zhezhaoView;

@property (weak, nonatomic) IBOutlet UIButton *m_dingweiBtn;

// 定位按钮触发的事件
- (IBAction)dingweiBtnClicked:(id)sender;

@end

@implementation FlightCityListViewController

@synthesize m_BMK_mapView;

@synthesize m_search;

@synthesize m_cityList;

@synthesize m_searchArray;

@synthesize m_typeString;

@synthesize delegate;

@synthesize m_hotList;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        m_cityList = [[NSMutableArray alloc]initWithCapacity:0];
        
        self.m_cityListDic = [[NSMutableDictionary alloc]initWithCapacity:0];
        
        self.m_allKeys = [[NSMutableArray alloc]initWithCapacity:0];
        
        m_searchArray = [[NSMutableArray alloc]initWithCapacity:0];
        
        self.m_isSearching = NO;
        
        dbhelp = [[FlightCityHelper alloc] init];
        
        self.m_allKeys1 = [[NSMutableArray alloc]initWithCapacity:0];
        
        m_hotList = [[NSMutableArray alloc]initWithCapacity:0];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setTitle:@"城市"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
//    [SVProgressHUD showWithStatus:@"正在加载城市信息"];
    
    if ( isIOS7 ) {
        
        // section索引的背景色-右边排序的ABCD所在的视图
        self.m_tableView.sectionIndexBackgroundColor = [UIColor clearColor];
        // 设置索引的字体颜色
        self.m_tableView.sectionIndexColor = RGBACKTAB;
        
    }
    
    activityView = [[UIActivityIndicatorView alloc]
                    initWithFrame:CGRectMake(30,12,20.0,20.0)];
    
    activityView.activityIndicatorViewStyle= UIActivityIndicatorViewStyleWhite;
    
    activityView.hidesWhenStopped = YES;
    
    
    // 初始化地图
    BMKMapView *mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, WindowSizeWidth, [[UIScreen mainScreen] bounds].size.height - 44 - 20)];
    self.m_BMK_mapView = mapView;
    _locService = [[BMKLocationService alloc]init];
    [m_BMK_mapView setZoomLevel:19];
    
    // 用于反编译
    m_search = [[BMKGeoCodeSearch alloc]init];
    // =======
    self.m_cityName = @"正在定位中...";
    
    [self.m_dingweiBtn setTitle:self.m_cityName forState:UIControlStateNormal];
    
    
    self.m_tableView.hidden = YES;
    
    // 设置遮罩view的透明度
    self.m_zhezhaoView.alpha = 0.8f;
    self.m_zhezhaoView.hidden = YES;
    
    self.m_searchBar.showsCancelButton = NO;
    
    // 设置searchBar上的取消按钮的背景
    for(id cc in [self.m_searchBar subviews]){
        if([cc isKindOfClass:[UIButton class]]){
            UIButton *btn = (UIButton *)cc;
            [btn setTitle:@"取消" forState:UIControlStateNormal];
        }
    }
    
    
    // 设置btn的边框颜色和宽度
    self.m_dingweiBtn.layer.borderWidth = 1.0f;
    self.m_dingweiBtn.layer.borderColor = [UIColor grayColor].CGColor;
    
    
    proValue = 0;
    self.paitlabel.text = @"0.0%";
    
    
    // 从数据库中读取历史搜索城市的数据
    self.m_hotList = [dbhelp hotList];
    
    
    NSData *saveMenulistDaate1 = [CommonUtil getValueByKey:[NSString stringWithFormat:@"HHotAndAllKeys"]];
    
    if (nil == saveMenulistDaate1) {
        
        // 定位中的时候不可以滑动返回
        [self showHudInView:self.navigationController.view.window hint:@"加载城市列表"];
        
    }else{
        
        // 定位中的时候不可以滑动返回
        [self showHudInView:self.navigationController.view.window hint:@"正在定位中..."];
    }

    
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self loadCityandClass];//更新数据库城市数据；

    // 地图
    [self.m_BMK_mapView viewWillAppear];
    
    // 判断是否开启定位服务，如果未开启，则默认为苏州的坐标;否则进行定位获取经纬度
    if ( ![CLLocationManager locationServicesEnabled] || ([CLLocationManager authorizationStatus]==kCLAuthorizationStatusDenied)) {
        
        //        if ( [[[UIDevice currentDevice] systemVersion] floatValue] > 5.0 ) {
        //
        //        }
        
        [self alertWithMessage:@"请在系统设置中开启定位服务,默认的为'苏州'"];
        
        self.m_cityName = @"苏州";
        
//        selectCity = @"1";
        
        // 存储城市的id和经纬度
//        [CommonUtil addValue:@"31.354779" andKey:kLatitudeKey];
//        [CommonUtil addValue:@"120.561860" andKey:kLongitudeKey];
//        [CommonUtil addValue:self.m_cityName andKey:kSelectCityName];
////        [CommonUtil addValue:selectCity andKey:kSelectCityId];
//        [CommonUtil addValue:@"苏州市" andKey:kSelectAddress];
//        [CommonUtil addValue:@"江苏省苏州市金储街288号" andKey:kALLSelectAddress];
        
        
        [self.m_dingweiBtn setTitle:self.m_cityName forState:UIControlStateNormal];
        
        
        // 定位成功后刷新列表 刷新第一行
        NSArray *arr = [NSArray arrayWithObjects:[NSIndexPath indexPathForRow:0 inSection:0], nil];
        
        [self.m_tableView reloadRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationNone];
        
        // 请求数据
        
        
        
    }else{
        
//        NSData *saveMenulistDaate = [CommonUtil getValueByKey:[NSString stringWithFormat:@"HHcity"]];
//        if (saveMenulistDaate ==nil) {
//            
////            [self changeProgress];
//            
//            
//            NSLog(@"citysssdsfddffdf");
//            
//            
//            [_locService startUserLocationService];
//            m_BMK_mapView.showsUserLocation = NO;//先关闭显示的定位图层
//            m_BMK_mapView.userTrackingMode = BMKUserTrackingModeFollow;//设置定位的状态
//            m_BMK_mapView.showsUserLocation = YES;//显示定位图层
//            self.m_BMK_mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
//            _locService.delegate = self;
//            self.m_search.delegate = self;
//            
//        }
//        else{
//            NSLog(@"进入普通定位态");
//            [_locService startUserLocationService];
//            m_BMK_mapView.showsUserLocation = NO;//先关闭显示的定位图层
//            m_BMK_mapView.userTrackingMode = BMKUserTrackingModeFollow;//设置定位的状态
//            m_BMK_mapView.showsUserLocation = YES;//显示定位图层
//            self.m_BMK_mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
//            _locService.delegate = self;
//            self.m_search.delegate = self;
//        }

        
        NSLog(@"进入普通定位态");
        [_locService startUserLocationService];
        m_BMK_mapView.showsUserLocation = NO;//先关闭显示的定位图层
        m_BMK_mapView.userTrackingMode = BMKUserTrackingModeFollow;//设置定位的状态
        m_BMK_mapView.showsUserLocation = YES;//显示定位图层
        self.m_BMK_mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
        _locService.delegate = self;
        self.m_search.delegate = self;
        
    }
    
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [self.m_BMK_mapView viewWillDisappear];
    
    self.m_BMK_mapView.delegate = nil; // 不用时，置nil
    
    _locService.delegate = nil;
    
    self.m_search.delegate = nil;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)leftClicked{
    
    [self goBack];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
   
    return self.m_allKeys1.count;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (self.m_allKeys1.count==0) {
        return 0;
    }

    if ( section == 0 ) {
        
        return 1;
        
    }else if ( section == 1 ){
        
        return self.m_hotList.count;
        
    }else{
        
        if ( self.m_allKeys.count != 0 ) {
            
            NSString *str = [self.m_allKeys objectAtIndex:section-2];
            
            NSArray *friendsArr = [self.m_cityListDic objectForKey:str];
            
            return friendsArr.count;
            
        }else{
            
            return 0;
        }
      
    }
}


#pragma mark - UITableViewDelegate
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    
    return self.m_allKeys1;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView* l_View = [[UIView alloc] init];
    l_View.backgroundColor = [UIColor colorWithRed:243/255.0 green:248/255.0 blue:252/255.0 alpha:1.0];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, WindowSizeWidth, 22)];
    titleLabel.textColor =[UIColor blackColor];
    titleLabel.textAlignment = UITextAlignmentLeft;
    titleLabel.font = [UIFont systemFontOfSize:15.0];
    titleLabel.backgroundColor = [UIColor clearColor];
    
    // 区上面进行赋值
    if ( section == 0 ) {
        
        titleLabel.text = @"GPS定位当前城市";
        
    }else if ( section == 1 ){
        
        titleLabel.text = @"历史城市";

        
    }else{
        
        if ( self.m_allKeys.count != 0 ) {
            
            NSString *str = [self.m_allKeys objectAtIndex:section - 2];
            titleLabel.text = str;
        }
        
      
    }
    
        
    [l_View addSubview:titleLabel];
    
    return l_View;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 30.0f;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *cellIdentifier = @"FlightsCityCellIdentifier";
    
    FlightsCityCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"AreaCell" owner:self options:nil];
        
        cell = (FlightsCityCell *)[nib objectAtIndex:1];
        
    }
    
    if ( !self.m_isSearching ) {
        // 赋值
        if ( self.m_cityList.count != 0 ) {
            
            if ( indexPath.section == 0 ) {
                
                // 显示定位的城市名称
                cell.m_flightsName.text = [NSString stringWithFormat:@"%@",self.m_cityName];
                
                

            }else if ( indexPath.section == 1 ){
                
                if ( self.m_hotList.count != 0 ) {
                    
                    NSDictionary *dic = [self.m_hotList objectAtIndex:indexPath.row];

                    // 历史搜索城市
                    cell.m_flightsName.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Name"]];
                    
                }
               

            }else{
                
                if ( self.m_allKeys.count != 0 ) {
                    
                    // 赋值
                    NSString *key = [self.m_allKeys objectAtIndex:indexPath.section-2];
                    
                    NSArray *array = [self.m_cityListDic objectForKey:key];
                    
                    NSDictionary *dic = [array objectAtIndex:indexPath.row];
                    
                    cell.m_flightsName.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Name"]];
                    
                }
                
            }
            
            
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
        
    }else{
        
        if ( self.m_searchArray.count != 0 ) {
            
            // 赋值
            cell.m_flightsName.text = [NSString stringWithFormat:@"%@",[self.m_searchArray objectAtIndex:indexPath.row]];
            
            cell.selectionStyle = UITableViewCellSelectionStyleGray;
            
        }else{
            
            // 赋值
            cell.m_flightsName.text = @"无结果";
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
    }
    
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 44.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if ( indexPath.section == 0 ) {
        
        // GPS定位点击
        [self dingweiBtnClicked:nil];
        
    }else if ( indexPath.section == 1 ){
        
        // 历史搜索点击触发的事件
        NSDictionary *dic = [self.m_hotList objectAtIndex:indexPath.row];
        
        [self getcitylocalong:dic];
        
    }else{
        
        NSString *key = [self.m_allKeys objectAtIndex:indexPath.section-2];
        
        NSArray *array = [self.m_cityListDic objectForKey:key];
        
        NSDictionary *dic = [array objectAtIndex:indexPath.row];
        
        // 点击了后将数据存储到数据库中
        if ( ![self.m_hotList containsObject:dic] ) {
            
            // 数组里保存三个数字
            if ( self.m_hotList.count == 3 ) {
                
                [self.m_hotList replaceObjectAtIndex:0 withObject:dic];
                
            }else{
                
                [self.m_hotList addObject:dic];

            }
            
           
            [dbhelp UPdateHotData:self.m_hotList];

        }
        
        
        [self getcitylocalong:dic];
    }
    
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}


#pragma mark - UISearchBarDelegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    if ( searchBar.text.length != 0 ) {
        
        self.m_isSearching = YES;
        
    }else{
        
        self.m_isSearching = NO;
    }
    
    // textField进行改变的时候 搜索:将数组里的数据与m_searchBar.text进行比较,若存在,则存入搜索数组中
    // 先将数组里的数据remove,以存放新的数据
    [self.m_searchArray removeAllObjects];
    // 遍历整个数组
    for (NSString * obj in self.m_cityList) {
        // 开头字 [cellTitle rangeOfString:searchBar.text options:NSCaseInsensitiveSearch].location != NSNotFound这个表示带有这个字得所有结果
        NSComparisonResult result = [obj compare:searchBar.text options:NSCaseInsensitiveSearch range:NSMakeRange(0, [searchBar.text length])];
        if ( result == NSOrderedSame || [obj rangeOfString:searchBar.text options:NSCaseInsensitiveSearch].location != NSNotFound ) {
            
            [self.m_searchArray addObject:obj];
        }
        
    }
    
    [self.m_tableView reloadData];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    
    [self hiddenNumPadDone:nil];
    
    if ( searchBar.text.length != 0 ) {
        
        self.m_isSearching = YES;
        
    }else{
        
        self.m_isSearching = NO;
    }
    
    self.m_searchBar.showsCancelButton = YES;
    
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    
    if ( searchBar.text.length != 0 ) {
        
        self.m_isSearching = YES;
        
    }else{
        
        self.m_isSearching = NO;
    }
    
    [self.m_searchBar resignFirstResponder];
    
    self.m_zhezhaoView.hidden = YES;
    
    self.m_searchBar.showsCancelButton = NO;
    
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    [self.m_searchBar resignFirstResponder];
    
    self.m_zhezhaoView.hidden = YES;
    
    self.m_searchBar.showsCancelButton = NO;
    
}



/**
 *在地图View将要启动定位时，会调用此函数
 *@param mapView 地图View
 */
#pragma mark - BMKMapViewDelegate
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
    [self.m_BMK_mapView updateLocationData:userLocation];
    NSLog(@"heading is %@",userLocation.heading);
    
}

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
//- (void)didUpdateUserLocation:(BMKUserLocation *)userLocation
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    
    
    [self.m_BMK_mapView updateLocationData:userLocation];
    
    
    m_latitude = userLocation.location.coordinate.latitude;
    
    m_longtitude = userLocation.location.coordinate.longitude;
    
    
    // 存储下定位到的经纬度
    [CommonUtil addValue:[NSString stringWithFormat:@"%f",m_latitude] andKey:kLatitudeKey];
    [CommonUtil addValue:[NSString stringWithFormat:@"%f",m_longtitude] andKey:kLongitudeKey];
    
    NSLog(@"用户更新位置");
    //    self.m_coord = userLocation.location.coordinate;
    
    // 根据经纬度去请求接口来转换成具体的地理位置
    
    CLLocationCoordinate2D pt = (CLLocationCoordinate2D){0, 0};
    pt = (CLLocationCoordinate2D){userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude};
    
    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    reverseGeocodeSearchOption.reverseGeoPoint = pt;
    
    BOOL flag = [self.m_search reverseGeoCode:reverseGeocodeSearchOption];
    
    if(flag)
    {
        NSLog(@"反geo检索发送成功");
    }
    else
    {
        NSLog(@"反geo检索发送失败");
        
        self.m_cityName = @"苏州";
        
        [self.m_dingweiBtn setTitle:self.m_cityName forState:UIControlStateNormal];
        
        
        // 定位成功后刷新列表 刷新第一行
        NSArray *arr = [NSArray arrayWithObjects:[NSIndexPath indexPathForRow:0 inSection:0], nil];
        
        [self.m_tableView reloadRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationNone];
        
        
//        selectCity = @"1";
        
//        [CommonUtil addValue:self.m_cityName andKey:kSelectCityName];
//        [CommonUtil addValue:selectCity andKey:kSelectCityId];
        
    }
    
}

- (void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    
    // 将提示消失
    [self hideHud];
    
    //    self.m_leftBtn.userInteractionEnabled = YES;
    
    NSArray* array = [NSArray arrayWithArray:self.m_BMK_mapView.annotations];
    [self.m_BMK_mapView removeAnnotations:array];
    array = [NSArray arrayWithArray:self.m_BMK_mapView.overlays];
    [self.m_BMK_mapView removeOverlays:array];
    if (error == 0) {
        BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
        item.coordinate = result.location;
        item.title = result.address;
        [self.m_BMK_mapView addAnnotation:item];
        self.m_BMK_mapView.centerCoordinate = result.location;
        
        NSString* titleStr;
        NSString* showmeg;
        
        titleStr = @"反向地理编码";
        showmeg = [NSString stringWithFormat:@"%@",item.title];
        
        NSString *cityName = [NSString stringWithFormat:@"%@",result.addressDetail.city];
        
        // 获取到城市-将“市”去掉
        if ( cityName.length != 0 ) {
            
            self.m_cityName = [cityName substringWithRange:NSMakeRange(0, cityName.length - 1)];
            
            [self.m_dingweiBtn setTitle:self.m_cityName forState:UIControlStateNormal];
            
            // 根据城市获取到对应的城市Id
//            for (NSDictionary *dic in self.m_cityList) {
//                
//                NSString *string = [dic objectForKey:@"name"];
            
//                if ( [string isEqualToString:self.m_cityName] ) {
//                    
//                    selectCity = [NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
//                    
//                }
                
//            }
        }else{
            // 默认没值的情况为苏州
            self.m_cityName = @"苏州";
            
            [self.m_dingweiBtn setTitle:self.m_cityName forState:UIControlStateNormal];
            
        }
        
        // 定位成功后刷新列表 刷新第一行
//        NSArray *arr = [NSArray arrayWithObjects:[NSIndexPath indexPathForRow:0 inSection:0], nil];
//        
//        [self.m_tableView reloadRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationNone];

        // 刷新列表
        [self.m_tableView reloadData];
    }
    
//    [CommonUtil addValue:[NSString stringWithFormat:@"%f",result.location.latitude] andKey:kLatitudeKey];
//    [CommonUtil addValue:[NSString stringWithFormat:@"%f",result.location.longitude] andKey:kLongitudeKey];
//    [CommonUtil addValue:self.m_cityName andKey:kSelectCityName];
////    [CommonUtil addValue:selectCity andKey:kSelectCityId];
//    [CommonUtil addValue:[NSString stringWithFormat:@"%@%@",result.addressDetail.streetName,result.addressDetail.streetNumber] andKey:kSelectAddress];
//    [CommonUtil addValue:[NSString stringWithFormat:@"%@",result.address] andKey:kALLSelectAddress];
    
    
    // 反编码成功后进行一些操作
    // 定位取消
    [_locService stopUserLocationService];
    _locService.delegate = nil;
    
    self.m_search.delegate = nil;
    
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

- (void)mapView:(BMKMapView *)mapView didFailToLocateUserWithError:(NSError *)error{
    
    //    self.m_leftBtn.userInteractionEnabled = YES;
    
    //    self.m_cityNameLabel.hidden = NO;
    
    self.m_cityName = @"苏州";
    
    [self.m_dingweiBtn setTitle:self.m_cityName forState:UIControlStateNormal];
    
    
    // 定位成功后刷新列表 刷新第一行
    NSArray *arr = [NSArray arrayWithObjects:[NSIndexPath indexPathForRow:0 inSection:0], nil];
    
    [self.m_tableView reloadRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationNone];
    
    
    
    [self alertWithMessage:@"定位失败,默认的为'苏州'"];
    
    self.m_search.delegate = nil;
    self.m_BMK_mapView.delegate = nil;
    self.m_BMK_mapView.showsUserLocation = NO;
    // 反编码成功后进行一些操作
    [_locService stopUserLocationService];
    _locService.delegate = nil;
    self.m_search.delegate = nil;
    
    
    
    // 请求数据
//    selectCity = @"1";
    
    // 定位失败后进行一些操作
    // 存储城市的id和经纬度
    
//    [CommonUtil addValue:@"31.354779" andKey:kLatitudeKey];
//    [CommonUtil addValue:@"120.561860" andKey:kLongitudeKey];
//    
//    [CommonUtil addValue:self.m_cityName andKey:kSelectCityName];
////    [CommonUtil addValue:selectCity andKey:kSelectCityId];
//    [CommonUtil addValue:@"苏州市" andKey:kSelectAddress];
//    [CommonUtil addValue:@"江苏省苏州市金储街288号" andKey:kALLSelectAddress];
    
    
}

- (IBAction)dingweiBtnClicked:(id)sender {
    
    if ([self.m_cityName isEqualToString:@"正在定位中..."]) {
        
        [SVProgressHUD showErrorWithStatus:@"正在定位"];
        
    }else{
        
        if ( delegate && [delegate respondsToSelector:@selector(getFlightCityName:)] ) {
            
            NSArray *array = [self.m_cityListDic objectForKey:[self firstLetterForCompositeNames:self.m_cityName]];
            
            NSMutableArray *arr = [[NSMutableArray alloc]initWithCapacity:0];
            
            for (int iii=0; iii<array.count; iii++) {
                
                NSDictionary *dic = [array objectAtIndex:iii];
                
                [arr addObject:[NSString stringWithFormat:@"%@",[dic objectForKey:@"Name"]]];
                
                
            }
            
            
            if ( [arr containsObject:self.m_cityName] ) {
                
                NSInteger index = [arr indexOfObject:self.m_cityName];
                
                NSDictionary *dic = [array objectAtIndex:index];
                
                [delegate performSelector:@selector(getFlightCityName:) withObject:dic];
                
                [self goBack];
                
            }else{
                
                // 如果不包含的话在则直接默认一个值来进行搜索
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@""
                                                                   message:@"您选择的城市没有机场,默认为'上海'"
                                                                  delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alertView show];

                NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"SHA",@"Code",@"上海",@"Name", nil];
                
                [delegate performSelector:@selector(getFlightCityName:) withObject:dic];
                
                [self goBack];
                
            }

        }
     
    }
    
}

///////////////////////////////////////////////////////////////////////////////
-(void)loadcelldata:(NSArray*)datalist
{
    
    if (datalist == nil) {
        return;
    }
    
    self.m_cityList = [NSMutableArray arrayWithArray:datalist];
    
    [self sortCitys];
    
}

//城市
-(void)loadCityView
{
//    self.waitview.hidden = NO;
    
    NSArray *citys = [dbhelp flightCityList];
    
    [self loadcelldata:citys];
    
}


- (void)loadCityandClass {
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        self.m_cityList = [NSMutableArray arrayWithArray: [dbhelp flightCityList]];
        
        NSData *saveMenulistDaate1 = [CommonUtil getValueByKey:[NSString stringWithFormat:@"HHotAndAllKeys"]];
        
        if (nil == saveMenulistDaate1) {
            self.m_allKeys1 = nil;
        }
        else
        {
            self.m_allKeys1 = (NSMutableArray *)[NSKeyedUnarchiver unarchiveObjectWithData:saveMenulistDaate1];
        }
        
        NSData *saveMenulistDaate = [CommonUtil getValueByKey:[NSString stringWithFormat:@"HHAllKeys"]];
        if (nil == saveMenulistDaate) {
            
            self.m_allKeys = nil;
        }
        else
        {
            self.m_allKeys = (NSMutableArray *)[NSKeyedUnarchiver unarchiveObjectWithData:saveMenulistDaate];
        }
        
        
        NSData *saveMenulist = [CommonUtil getValueByKey:[NSString stringWithFormat:@"HHcity"]];
        
        if (nil == saveMenulist) {
            
            self.m_cityListDic = nil;
        }
        else
        {
            self.m_cityListDic = (NSMutableDictionary *)[NSKeyedUnarchiver unarchiveObjectWithData:saveMenulist];
        }
        
        self.m_tableView.hidden = NO;
        [self.m_tableView reloadData];
        
        
        return;
    }
    
    NSDictionary *versions = [dbhelp version];
    
    NSString *cityVer = [versions objectForKey:TYPE_FLIGHTSCITY];
    if (cityVer == nil) {
        cityVer = @"-1";
        
    }
    
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient1];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           cityVer, @"qunarCityVer",
                           nil];
//    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient requestFlights:@"QunarCityInfo.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        NSLog(@"json = %@",json);

        if (success) {
            
            [SVProgressHUD dismiss];

            NSArray *versionList = [json valueForKey:@"Version"];
            
            if (versionList == nil || [versionList count] == 0) {
                
                self.m_cityList = [NSMutableArray arrayWithArray: [dbhelp flightCityList]];
                
                
                NSData *saveMenulistDaate1 = [CommonUtil getValueByKey:[NSString stringWithFormat:@"HHotAndAllKeys"]];
                
                if (nil == saveMenulistDaate1) {
                    self.m_allKeys1 = nil;
                }
                else
                {
                    self.m_allKeys1 = (NSMutableArray *)[NSKeyedUnarchiver unarchiveObjectWithData:saveMenulistDaate1];
                }
                
                
                NSData *saveMenulistDaate = [CommonUtil getValueByKey:[NSString stringWithFormat:@"HHAllKeys"]];
                
                if (nil == saveMenulistDaate) {
                    self.m_allKeys = nil;
                }
                else
                {
                    self.m_allKeys = (NSMutableArray *)[NSKeyedUnarchiver unarchiveObjectWithData:saveMenulistDaate];
                }
                
                
                NSData *saveMenulist = [CommonUtil getValueByKey:[NSString stringWithFormat:@"HHcity"]];
                
                if (nil == saveMenulist) {
                    
                    self.m_cityListDic = nil;
                }
                else
                {
                    self.m_cityListDic = (NSMutableDictionary *)[NSKeyedUnarchiver unarchiveObjectWithData:saveMenulist];
                }
                
                
                self.m_tableView.hidden = NO;
                
                [self.m_tableView reloadData];
                
                return;
            }
            NSInteger cityVersion = 0;
            for (NSDictionary *version in versionList) {
                NSString *type = [version objectForKey:@"VersionType"];
                if ([@"VersionQunarCity" isEqualToString:type]) {
                    cityVersion = [[version objectForKey:@"VersionNum"] intValue];
                }

            }
            if (cityVersion > 0) {
                
                NSArray *cityList = [json valueForKey:@"CityList"];
                
                [dbhelp updateDataFlight:cityList andType:TYPE_FLIGHTSCITY andVersion:[NSString stringWithFormat:@"%d", cityVersion]];
                
            }
            
            [self loadCityView];
            
        } else {
        }
    } failure:^(NSError *error) {
        NSLog(@"failed:%@", error);
    }];
}

// 列表进行字母分类
- (void)sortCitys{
    
    if ( self.m_cityList.count != 0 ) {
        
        // 进行排序循环
        for (int i = 0; i< self.m_cityList.count; i++) {
           
            NSDictionary *dic = [self.m_cityList objectAtIndex:i];
            NSString *pinyin = [self firstLetterForCompositeNames:[dic objectForKey:@"Name"]];
            NSArray *array = [self sortBypinyin:pinyin];
            
            
            [self.m_cityListDic setObject:array forKey:pinyin];
            self.m_allKeys = [[[self.m_cityListDic allKeys] sortedArrayUsingSelector:@selector(compare:)] mutableCopy];
            
        }
        
        // 添加到数值里// 添加GPS定位及热门城市
        [self.m_allKeys1 addObject:@"GPS"];
        [self.m_allKeys1 addObject:@"历史"];
        [self.m_allKeys1 addObjectsFromArray:self.m_allKeys];
        
        
        // 对数据进行存储
        NSData *encodemenulist1 = [NSKeyedArchiver archivedDataWithRootObject:self.m_allKeys1];
        [CommonUtil addValue:encodemenulist1 andKey:[NSString stringWithFormat:@"HHotAndAllKeys"]];
        NSData *encodemenulist = [NSKeyedArchiver archivedDataWithRootObject:self.m_allKeys];
        [CommonUtil addValue:encodemenulist andKey:[NSString stringWithFormat:@"HHAllKeys"]];
        NSData *encodemenudic = [NSKeyedArchiver archivedDataWithRootObject:self.m_cityListDic];
        [CommonUtil addValue:encodemenudic andKey:[NSString stringWithFormat:@"HHcity"]];
        
        // 刷新列表
        self.m_tableView.hidden = NO;
        [self.m_tableView reloadData];
        
        
    }else{
        
        //        self.MClist_tableview.tableFooterView = nil;
    }
    
}

-(NSString *)firstLetterForCompositeNames:(NSString *)cityString {
    if (![cityString length]) {
        return @"";
    }
    unichar charString = [cityString characterAtIndex:0];
    NSArray *array = pinYinWithoutToneOnlyLetter(charString);
    if ([array count]) {
        
        return [[[array objectAtIndex:0] substringToIndex:1] uppercaseString];
        
        
    }
    return @"";
}

- (NSMutableArray *)sortBypinyin:(NSString *)pinyin{
    
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (int i = 0; i< self.m_cityList.count; i++) {
        
        NSDictionary *dic = [self.m_cityList objectAtIndex:i];
        NSString *data_pinyin = [self firstLetterForCompositeNames:[dic objectForKey:@"Name"]];
        
        if ([data_pinyin isEqualToString:pinyin]) {
            
            [array addObject:dic];
        }
    }
    
    return array;
}

// 根据城市名获取经纬度
- (void)getcitylocalong:(NSDictionary *)cityNamedic;
{
    // 选择城市进行执行代理方法
    if ( self.m_cityList.count != 0 ) {
        
        if ( delegate && [delegate respondsToSelector:@selector(getFlightCityName:)] ) {
            
            [delegate performSelector:@selector(getFlightCityName:) withObject:cityNamedic];
            
        }
    }
    
    [self goBack];
    
}


@end
