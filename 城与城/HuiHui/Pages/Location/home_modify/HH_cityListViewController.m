//
//  HH_cityListViewController.m
//  HuiHui
//
//  Created by mac on 14-8-1.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "HH_cityListViewController.h"

#import "RootViewController.h"

#import "CommonUtil.h"

#import "AreaCell.h"

#import "DBHelper.h"

#import "JPinYinUtil.h"

@interface HH_cityListViewController ()
{
    DBHelper *dbhelp;
    
}


@property (weak, nonatomic) IBOutlet UISearchBar *m_searchBar;

@property (weak, nonatomic) IBOutlet UITableView *m_tableView;

@property (weak, nonatomic) IBOutlet UIView *m_zhezhaoView;

@property (weak, nonatomic) IBOutlet UIButton *m_dingweiBtn;

//@property (nonatomic, weak) UILabel *progressLab;

// 定位按钮触发的事件
- (IBAction)dingweiBtnClicked:(id)sender;

@end

@implementation HH_cityListViewController

@synthesize m_BMK_mapView;

@synthesize m_search;

@synthesize m_cityList;

@synthesize m_searchArray;

@synthesize m_typeString;

@synthesize delegate;

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
        
        dbhelp = [[DBHelper alloc] init];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setTitle:@"城市"];

    if ( isIOS7 ) {
        
        // section索引的背景色-右边排序的ABCD所在的视图
        self.m_tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    }
    
    activityView = [ [ UIActivityIndicatorView alloc ]
                    initWithFrame:CGRectMake(30,12,20.0,20.0)];
    
    activityView.activityIndicatorViewStyle= UIActivityIndicatorViewStyleWhite;
    
    activityView.hidesWhenStopped = YES;
    
    if ( [self.m_typeString isEqualToString:@"2"] ) {
        
//        // 定位中的时候不可以滑动返回
//        [self showHudInView:self.navigationController.view.window hint:@"正在定位中…"];
//        
//        
        UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
        [backButton setImage:[UIImage imageNamed:@"arrow_WL.png"] forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(leftClicked) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        [self.navigationItem setLeftBarButtonItem:backItem];
        
    }else{
        
        // 定位中的时候不可以滑动返回
        //        [self showHudInView:self.navigationController.view.window hint:@"正在加载城市信息…"];
        
        
        // 第一次进入城市列表的时候在状态栏添加一个黑色的label
        // 在状态栏位置添加label，使其背景色为黑色
        if ( isIOS7 ) {
            
            UILabel *l_label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 20)];

            l_label.backgroundColor = RGBACKTAB;
            
            l_label.tag = 100;
            
            [self.navigationController.view addSubview:l_label];
            
        }
        
        UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 60, 44)];
        view1.backgroundColor = [UIColor clearColor];
        
        [view1 addSubview:activityView ];
        
        UIBarButtonItem *_barButton = [[UIBarButtonItem alloc] initWithCustomView:view1];
        [self.navigationItem setLeftBarButtonItem:_barButton];
        
        //        [self setLeftButtonWithNormalImage:@"" action:nil];
        
    }
    
    
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

//    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(WindowSizeWidth * 0.05, 100, WindowSizeWidth * 0.9, 30)];
//    
//    self.progressLab = lab;
//    
//    lab.textAlignment = NSTextAlignmentCenter;
//    
//    lab.textColor = [UIColor darkGrayColor];
//    
//    [self.view addSubview:lab];
    
//    self.progressLab.hidden = YES;
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [CommonUtil addValue:@"NO" andKey:HomeIslocation];//手动选择城市 进入首页不定位
    
    [self loadCityandClass];//更新数据库城市数据；
    
    // 从本地过来隐藏tabBar
    if ( [self.m_typeString isEqualToString:@"2"] ) {
        
        [self hideTabBar:YES];
    }
    
    // 地图
    [self.m_BMK_mapView viewWillAppear];
    
    // 判断是否开启定位服务，如果未开启，则默认为苏州的坐标;否则进行定位获取经纬度
    if ( ![CLLocationManager locationServicesEnabled] || ([CLLocationManager authorizationStatus]==kCLAuthorizationStatusDenied)) {
        
        [self alertWithMessage:@"请在系统设置中开启定位服务,默认的为'苏州'"];
        
        self.m_cityName = @"苏州";
        
        selectCity = @"1";
        
        // 存储城市的id和经纬度
        [CommonUtil addValue:@"31.354779" andKey:kLatitudeKey];
        [CommonUtil addValue:@"120.561860" andKey:kLongitudeKey];
        [CommonUtil addValue:self.m_cityName andKey:kSelectCityName];
        [CommonUtil addValue:@"" andKey:kHomeDistrict];
        [CommonUtil addValue:selectCity andKey:kSelectCityId];
        [CommonUtil addValue:@"苏州市" andKey:kSelectAddress];
        [CommonUtil addValue:@"江苏省苏州市金储街288号" andKey:kALLSelectAddress];
        
        [self.m_dingweiBtn setTitle:self.m_cityName forState:UIControlStateNormal];
        
    }else{
        
        NSData *saveMenulistDaate = [CommonUtil getValueByKey:[NSString stringWithFormat:@"HHcitya"]];
        
        if (saveMenulistDaate ==nil) {
            
            [self changeProgress];
            
            NSLog(@"112233");
        }
        else{
            NSLog(@"111进入普通定位态");
            [_locService startUserLocationService];
            m_BMK_mapView.showsUserLocation = NO;//先关闭显示的定位图层
            m_BMK_mapView.userTrackingMode = BMKUserTrackingModeFollow;//设置定位的状态
            m_BMK_mapView.showsUserLocation = YES;//显示定位图层
            self.m_BMK_mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
            _locService.delegate = self;
            self.m_search.delegate = self;

        }
        
        
    }
    
}

- (void)willStartLocatingUser
{
    NSLog(@"将要开始定位了");
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    // 从本地过来就显示tabBar
    if ( [self.m_typeString isEqualToString:@"2"] ) {
        
        [self hideTabBar:NO];
    }
    
    [self.m_BMK_mapView viewWillDisappear];
    
    self.m_BMK_mapView.delegate = nil; // 不用时，置nil
    
    _locService.delegate = nil;
    
    self.m_search.delegate = nil;
    
    HHalertView.delegate = nil;
    [HHalertView dismissWithClickedButtonIndex:0 animated:YES];
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
    
    return self.m_allKeys.count;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    if (self.m_allKeys.count==0) {
        return 0;
    }
    
    NSString *str = [self.m_allKeys objectAtIndex:section];
    
    NSArray *friendsArr = [self.m_cityListDic objectForKey:str];
    
    return friendsArr.count;
}


#pragma mark - UITableViewDelegate
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    
    return self.m_allKeys;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    
    UIView* l_View = [[UIView alloc] init];
    l_View.backgroundColor = [UIColor clearColor];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, WindowSizeWidth, 22)];
    titleLabel.textColor=[UIColor grayColor];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.font = [UIFont systemFontOfSize:15.0];
    titleLabel.backgroundColor = [UIColor clearColor];
    
    NSString *str = [self.m_allKeys objectAtIndex:section];
    titleLabel.text = str;
    
    
    [l_View addSubview:titleLabel];
    
    return l_View;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    
    return 30.0f;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"AreaCellIdentifier";
    
    AreaCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"AreaCell" owner:self options:nil];
        
        cell = (AreaCell *)[nib objectAtIndex:0];
        
    }
    
    if ( !self.m_isSearching ) {
        // 赋值
        if ( self.m_cityList.count != 0 ) {
            
            // 赋值
            NSString *key = [self.m_allKeys objectAtIndex:indexPath.section];
            
            NSArray *array = [self.m_cityListDic objectForKey:key];
            
            NSDictionary *dic = [array objectAtIndex:indexPath.row];
            
            cell.m_cityName.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];
            
            
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
        
    }else{
        
        if ( self.m_searchArray.count != 0 ) {
            
            // 赋值
            cell.m_cityName.text = [NSString stringWithFormat:@"%@",[self.m_searchArray objectAtIndex:indexPath.row]];
            
            cell.selectionStyle = UITableViewCellSelectionStyleGray;
            
        }else{
            
            // 赋值
            cell.m_cityName.text = @"无结果";
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
    }
    
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 55.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // 赋值清空
    [CommonUtil addValue:@"" andKey:kHomeDistrict];
    
    NSString *key = [self.m_allKeys objectAtIndex:indexPath.section];
    
    NSArray *array = [self.m_cityListDic objectForKey:key];
    
    NSDictionary *dic = [array objectAtIndex:indexPath.row];
    
    
    
    if (activityView.isAnimating) {
        
        return;
    }
    
    [activityView startAnimating];//启动
    
    [self getcitylocalong:dic];
    
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

}

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */

- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation {
    
    [self.m_BMK_mapView updateLocationData:userLocation];
    
    m_latitude = userLocation.location.coordinate.latitude;
    
    m_longtitude = userLocation.location.coordinate.longitude;
    
    // 存储下定位到的经纬度
    [CommonUtil addValue:[NSString stringWithFormat:@"%f",m_latitude] andKey:kLatitudeKey];
    
    [CommonUtil addValue:[NSString stringWithFormat:@"%f",m_longtitude] andKey:kLongitudeKey];
    
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
        
        selectCity = @"1";
        
        [CommonUtil addValue:self.m_cityName andKey:kSelectCityName];
        [CommonUtil addValue:selectCity andKey:kSelectCityId];
        [CommonUtil addValue:@"" andKey:kHomeDistrict];
        
    }
    
}

- (void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    
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
            
            NSString *district = [NSString stringWithFormat:@"%@",result.addressDetail.district];
            
            // 用于首页城市名称的显示-左上角(包含市或者县的话则显示出来)
            if ( [district rangeOfString:@"市"].location != NSNotFound || [district rangeOfString:@"县"].location != NSNotFound ) {
                
                [self.m_dingweiBtn setTitle:district forState:UIControlStateNormal];
                
            }else{
                
                [self.m_dingweiBtn setTitle:self.m_cityName forState:UIControlStateNormal];
                
            }
            
            // 根据城市获取到对应的城市Id
            for (NSDictionary *dic in self.m_cityList) {
                
                NSString *string = [dic objectForKey:@"name"];
                
                if ( [string isEqualToString:self.m_cityName] ) {
                    
                    selectCity = [NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
                    
                }
                
            }
            
            
        }else{
            // 默认没值的情况为苏州
            self.m_cityName = @"苏州";
            
            selectCity = @"1";
            
            [self.m_dingweiBtn setTitle:self.m_cityName forState:UIControlStateNormal];
            
        }
        
    }
    
    [CommonUtil addValue:self.m_cityName andKey:kSelectCityName];
    [CommonUtil addValue:selectCity andKey:kSelectCityId];
    [CommonUtil addValue:[NSString stringWithFormat:@"%@%@",result.addressDetail.streetName,result.addressDetail.streetNumber] andKey:kSelectAddress];
    [CommonUtil addValue:[NSString stringWithFormat:@"%@",result.address] andKey:kALLSelectAddress];
    [CommonUtil addValue:[NSString stringWithFormat:@"%f",result.location.latitude] andKey:kLatitudeKey];
    [CommonUtil addValue:[NSString stringWithFormat:@"%f",result.location.longitude] andKey:kLongitudeKey];
    // 用于首页城市名称的显示-左上角(包含市或者县的话则显示出来)
    NSString *district = [NSString stringWithFormat:@"%@",result.addressDetail.district];
    
    if ( [district rangeOfString:@"市"].location != NSNotFound || [district rangeOfString:@"县"].location != NSNotFound ) {
        
        [CommonUtil addValue:[NSString stringWithFormat:@"%@",result.addressDetail.district] andKey:kHomeDistrict];
        
    }else{
        
        [CommonUtil addValue:@"" andKey:kHomeDistrict];
        
    }
    
    
    // 用于首页当前位置所显示
    [CommonUtil addValue:[NSString stringWithFormat:@"%@",result.address] andKey:kHomeCityAddress];
    
    // 保存起来用于景区列表显示
    [CommonUtil addValue:self.m_cityName andKey:kSceneryCityName];
    [CommonUtil addValue:[NSString stringWithFormat:@"%f",result.location.latitude] andKey:kSceneryLatitude];
    [CommonUtil addValue:[NSString stringWithFormat:@"%f",result.location.longitude] andKey:kSceneryLongitude];
    
    
    // 反编码成功后进行一些操作
    // 定位取消
    [_locService stopUserLocationService];
    _locService.delegate = nil;
    
    self.m_search.delegate = nil;
    
    // 从首页进来的时候进行提示
    if ( ![self.m_typeString isEqualToString:@"2"] ) {
        
        HHalertView= [[UIAlertView alloc]initWithTitle:nil message:[NSString stringWithFormat:@"已为您成功定位,是否切换到【%@】\n%@",self.m_cityName,[CommonUtil  getValueByKey:kSelectAddress]] delegate:self
                                     cancelButtonTitle:@"取消"
                                     otherButtonTitles:@"切换", nil];
        HHalertView.tag = 101;
        [HHalertView show];
        
    }else{
        
        
    }
    
    
}


#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if ( alertView.tag == 101 ) {
        if ( buttonIndex == 1 ) {
            
            [self dingweiBtnClicked:nil];
            
        }
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

- (void)mapView:(BMKMapView *)mapView didFailToLocateUserWithError:(NSError *)error{
    
    self.m_cityName = @"苏州";
    
    [self.m_dingweiBtn setTitle:self.m_cityName forState:UIControlStateNormal];
    
    
    [self alertWithMessage:@"定位失败,默认的为'苏州'"];
    
    self.m_search.delegate = nil;
    self.m_BMK_mapView.delegate = nil;
    self.m_BMK_mapView.showsUserLocation = NO;
    // 反编码成功后进行一些操作
    [_locService stopUserLocationService];
    _locService.delegate = nil;
    self.m_search.delegate = nil;
    
    
    
    // 请求数据
    selectCity = @"1";
    
    // 定位失败后进行一些操作
    // 存储城市的id和经纬度
    
    [CommonUtil addValue:@"31.354779" andKey:kLatitudeKey];
    [CommonUtil addValue:@"120.561860" andKey:kLongitudeKey];
    [CommonUtil addValue:self.m_cityName andKey:kSelectCityName];
    [CommonUtil addValue:selectCity andKey:kSelectCityId];
    [CommonUtil addValue:@"苏州市" andKey:kSelectAddress];
    [CommonUtil addValue:@"江苏省苏州市金储街288号" andKey:kALLSelectAddress];
    
    
}

- (IBAction)dingweiBtnClicked:(id)sender {
    
    
    if ( [self.m_typeString isEqualToString:@"2"] ) {
        
        if ([self.m_cityName isEqualToString:@"正在定位中..."]) {
            
        }else{
            
            if ( delegate && [delegate respondsToSelector:@selector(getHHCityName:)] ) {
                
                NSArray *array = [self.m_cityListDic objectForKey:[self firstLetterForCompositeNames:self.m_cityName]];
                
                for (int iii=0; iii<array.count; iii++) {
                    
                    NSDictionary *dic = [array objectAtIndex:iii];
                    
                    if ([[dic objectForKey:@"name"] isEqualToString:self.m_cityName] ) {
                        
                        [delegate performSelector:@selector(getHHCityName:) withObject:dic];
                        
                        [self goBack];
                        
                        return;
                    }
                    
                }
                
            }
            
        }
        
        
    }else{
        
        if ([self.m_cityName isEqualToString:@"正在定位中..."]) {
            [SVProgressHUD showErrorWithStatus:@"未能定位，请稍后…"];
            return;
        }
        
        // 进入首页
        [self goRootView];
        
    }
}

- (void)goRootView{
    
    // 移除上面的view
    for (UILabel *label in self.navigationController.view.subviews) {
        
        if ( label.tag == 100 ) {
            
            [label removeFromSuperview];
            
        }
    }
    // 跳转到首页
    RootViewController * rootViewController = [[RootViewController alloc]initWithNibName:@"RootViewController" bundle:nil];
    [self.navigationController pushViewController:rootViewController animated:NO];
    
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
    
    NSArray *citys = [dbhelp queryCity];
    
    [self loadcelldata:citys];
    
}

- (void)loadCityandClass {
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        NSLog(@"没网络");
        
        self.m_cityList = [NSMutableArray arrayWithArray: [dbhelp queryCity]];
        
        NSData *saveMenulistDaate = [CommonUtil getValueByKey:[NSString stringWithFormat:@"HHcitya"]];
        if (nil == saveMenulistDaate) {
            
            self.m_allKeys = nil;
        }
        else
        {
            self.m_allKeys = (NSMutableArray *)[NSKeyedUnarchiver unarchiveObjectWithData:saveMenulistDaate];
        }
        
        
        NSData *saveMenulist = [CommonUtil getValueByKey:[NSString stringWithFormat:@"HHcityd"]];
        
        if (nil == saveMenulist) {
            
            self.m_cityListDic = nil;
        }
        else
        {
            self.m_cityListDic = (NSMutableDictionary *)[NSKeyedUnarchiver unarchiveObjectWithData:saveMenulist];
        }
        
        [self.m_tableView reloadData];
        
        
        return;
    }
    
    NSDictionary *versions = [dbhelp queryVersion];
    
    NSString *cityVer = [versions objectForKey:TYPE_CITY];
    if (cityVer == nil) {
        cityVer = @"-1";
        
    }
    NSString *categoryVer = [versions objectForKey:TYPE_CATEGORY];
    if (categoryVer == nil) {
        categoryVer = @"-1";
    }
    
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           cityVer, @"cityVer",
                           categoryVer, @"categoryVer",
                           nil];

    [httpClient request:@"MerchantCityandClass.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            
            NSArray *versionList = [json valueForKey:@"version"];
            
            if (versionList == nil || [versionList count] == 0) {
                
                NSLog(@"有缓存");
                
                self.m_cityList = [NSMutableArray arrayWithArray: [dbhelp queryCity]];
                
                NSData *saveMenulistDaate = [CommonUtil getValueByKey:[NSString stringWithFormat:@"HHcitya"]];
                
                if (nil == saveMenulistDaate) {
                    self.m_allKeys = nil;
                }
                else
                {
                    self.m_allKeys = (NSMutableArray *)[NSKeyedUnarchiver unarchiveObjectWithData:saveMenulistDaate];
                }
                
                NSData *saveMenulist = [CommonUtil getValueByKey:[NSString stringWithFormat:@"HHcityd"]];
                
                if (nil == saveMenulist) {
                    
                    self.m_cityListDic = nil;
                }
                else
                {
                    self.m_cityListDic = (NSMutableDictionary *)[NSKeyedUnarchiver unarchiveObjectWithData:saveMenulist];
                }
                
                [SVProgressHUD dismiss];
                
                [self.m_tableView reloadData];
                
                return;
                
            }else {
            
                NSInteger cityVersion = 0;
                NSInteger categoryVersion = 0;
                for (NSDictionary *version in versionList) {
                    NSString *type = [version objectForKey:@"VersionType"];
                    if ([@"VersionCity" isEqualToString:type]) {
                        cityVersion = [[version objectForKey:@"VersionNum"] intValue];
                    }
                    if ([@"VersionClass" isEqualToString:type]) {
                        categoryVersion = [[version objectForKey:@"VersionNum"] intValue];
                    }
                }
                if (cityVersion > 0) {
                    
                    NSArray *cityList = [json valueForKey:@"city"];
                    
                    [dbhelp updateData:cityList andType:TYPE_CITY andVersion:[NSString stringWithFormat:@"%ld", (long)cityVersion]];
                    
                }
                
                if (categoryVersion > 0) {
                    NSArray *categoryList = [json valueForKey:@"category"];
                    [dbhelp updateData:categoryList andType:TYPE_CATEGORY andVersion:[NSString stringWithFormat:@"%ld", (long)categoryVersion]];
                    
                }
                
                NSLog(@"没缓存");
                
                [self loadCityView];

                
            }
            
        } else {
            
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",[json valueForKey:@"msg"]]];
            
        }
    } failure:^(NSError *error) {
        NSLog(@"failed:%@", error);
    }];
}



// 列表进行字母分类
- (void)sortCitys{
    
        // 进行排序循环
        for (int i = 0; i< self.m_cityList.count; i++) {
            
            blockcount++;
            
            NSDictionary *dic = [self.m_cityList objectAtIndex:i];
            NSString *pinyin = [self firstLetterForCompositeNames:[dic objectForKey:@"name"]];
            NSArray *array = [self sortBypinyin:pinyin];
            [self.m_cityListDic setObject:array forKey:pinyin];
            if (blockcount==self.m_cityList.count) {
                self.m_allKeys  = [[[self.m_cityListDic allKeys] sortedArrayUsingSelector:@selector(compare:)] mutableCopy];
            }
            
//            float a = i;
//            float b = self.m_cityList.count;
//            proValue = a/b;//改变进度条值
            
        }

                
        [self changeProgress];
    


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
        NSString *data_pinyin = [self firstLetterForCompositeNames:[dic objectForKey:@"name"]];
        
        if ([data_pinyin isEqualToString:pinyin]) {
            
            [array addObject:dic];
        }
    }
    
    return array;
}




// 根据城市名获取经纬度
- (void)getcitylocalong:(NSDictionary *)cityNamedic;
{
    
    CLGeocoder * geocoder = [[CLGeocoder alloc] init];
    
    [geocoder geocodeAddressString:[cityNamedic objectForKey:@"name"] completionHandler:^(NSArray *placemarks, NSError *error) {
        
        CLPlacemark * placeMark = [placemarks objectAtIndex:0];
        
        [CommonUtil addValue:[NSString stringWithFormat:@"%f",placeMark.location.coordinate.latitude] andKey:kLatitudeKey];
        [CommonUtil addValue:[NSString stringWithFormat:@"%f",placeMark.location.coordinate.longitude] andKey:kLongitudeKey];
        [CommonUtil addValue:[NSString stringWithFormat:@"%@市",[cityNamedic objectForKey:@"name"]] andKey:kSelectAddress];
        [CommonUtil addValue:[NSString stringWithFormat:@"%@市中心位置",[cityNamedic objectForKey:@"name"]]andKey:kALLSelectAddress];
        
        
        [ activityView stopAnimating ];//启动
        
        
        // 判断从哪个页面过来
        if ( [self.m_typeString isEqualToString:@"1"] ) {
            
            [CommonUtil addValue:[NSString stringWithFormat:@"%@",[cityNamedic objectForKey:@"name"]] andKey:kSelectCityName];
            [CommonUtil addValue:[NSString stringWithFormat:@"%@",[cityNamedic objectForKey:@"code"]] andKey:kSelectCityId];
            
            // 进入首页
            [self goRootView];
            
            
        }else{
            // 选择城市进行执行代理方法
            
            if ( self.m_cityList.count != 0 ) {
                
                if ( delegate && [delegate respondsToSelector:@selector(getHHCityName:)] ) {
                    
                    [delegate performSelector:@selector(getHHCityName:) withObject:cityNamedic];
                    
                }
            }
            
            
            [self goBack];
            
            
        }
        
        
    }];
    
}


//进度条开始动画
-(void)changeProgress;
{

    // 刷新列表
    [self.m_tableView reloadData];
    
    [_locService startUserLocationService];
    m_BMK_mapView.showsUserLocation = NO;//先关闭显示的定位图层
    m_BMK_mapView.userTrackingMode = BMKUserTrackingModeFollow;//设置定位的状态
    m_BMK_mapView.showsUserLocation = YES;//显示定位图层
    self.m_BMK_mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _locService.delegate = self;
    self.m_search.delegate = self;
    
    //对数据进行存储
    NSData *encodemenulist = [NSKeyedArchiver archivedDataWithRootObject:self.m_allKeys];
    [CommonUtil addValue:encodemenulist andKey:[NSString stringWithFormat:@"HHcitya"]];
    NSData *encodemenudic = [NSKeyedArchiver archivedDataWithRootObject:self.m_cityListDic];
    [CommonUtil addValue:encodemenudic andKey:[NSString stringWithFormat:@"HHcityd"]];

}

@end
