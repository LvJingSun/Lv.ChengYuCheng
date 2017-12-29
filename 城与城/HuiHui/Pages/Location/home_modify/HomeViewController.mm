//
//  HomeViewController.m
//  HuiHui
//
//  Created by mac on 14-7-25.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "HomeViewController.h"

#import "all_merchantViewController.h"

#import "CategoryViewController.h"

#import "Ca_productListViewController.h"

#import "CommonUtil.h"

#import "SVProgressHUD.h"

#import "AppHttpClient.h"

#import "SaleProductDetailViewController.h"

#import "SaleProductListViewController.h"

#import "LocationCell.h"

#import "UIImageView+AFNetworking.h"

#import "WebViewController.h"

#import "ProductDetailViewController.h"

#import "StartViewController.h"

#import "HH_SearchViewController.h"

#import "CtriphotelViewController.h"

#import "FlightsViewController.h"

#import "hh_tianchengViewController.h"

#import "DScale_productListViewController.h"

#import "QuanquanListViewController.h"

#import "Sec_webViewController.h"

#import "HotelChooseViewController.h"

#import "TrainwebViewController.h"

#import "MyCardViewController.h"

#import "HH_MactMenuViewController.h"

#import "HH_CardPayCell.h"

#import "HH_TakeOrderViewController.h"
#import "CPSHH_TakeOrderViewController.h"

#import "BillRechargeViewController.h"

#import "RH_NavViewController.h"
#import "RH_HomeViewController.h"
#import "RH_NoMemberShipViewController.h"

#import "RedHorseHeader.h"
#import "FSB_NewHomeViewController.h"

#import "Home_MemberShipModel.h"
#import "Home_MemberShipFrame.h"
#import "Home_MemberShipCell.h"

#import "GameWebViewController.h"

//#import "FSB_GameNAVController.h"
//#import "FSB_GameViewController.h"
#import "GameCenterHomeNewViewController.h"

#import "AboutmeViewController.h"

#import "HomePushModel.h"
#import "HomePushFrame.h"
#import "HomePushCell.h"
#import "HomeMenuModel.h"
#import "HomeMenuFrame.h"
#import "HomeMenuCell.h"

#import "HomeTableFooterView.h"
#import "Home_FenLeiViewController.h"
#import "Home_ScrollView.h"
#import "Home_ScrollModel.h"

#import "MenuBtnModel.h"
#import "GreenLifeViewController.h"

#import "MR_HomeViewController.h"

static const CGFloat kDefaultPlayLocationInterval = 600.0;

@interface HomeViewController () <FFScrollViewDelegate>{

    NSString *isTongYi;
    
    NSString *isYCBMemberShip;
    
}

@property (weak, nonatomic) IBOutlet PullTableView  *m_tableView;
@property (strong, nonatomic) IBOutlet UIView       *m_headerView;
//@property (strong, nonatomic) IBOutlet UIView       *m_footerView;
//@property (weak, nonatomic) IBOutlet UIButton       *m_moreBtn;
@property (weak, nonatomic) IBOutlet UIScrollView   *m_scollerView;

@property (strong, nonatomic) NSMutableArray    *m_city;

@property (weak, nonatomic) IBOutlet UIButton *m_diandanBtn;

@property (weak, nonatomic) IBOutlet UIButton *m_vipBtn;
// 显示地址的label
@property (weak, nonatomic) IBOutlet UILabel *m_address;

@property (weak, nonatomic) IBOutlet UILabel *m_address1;

//轮播广告数组
@property (nonatomic, strong) NSArray *home_scrollArr;

//会员卡、点单数据数组
@property (nonatomic, strong) NSArray *member_dataArr;

//城与城首页推广数据数组
@property (nonatomic, strong) NSArray *homePushArray;

//城与城首页菜单数据数组
@property (nonatomic, strong) NSArray *homeMenuArray;

// 按钮的点击事件
- (void)btn1Clicked:(id)sender;
- (void)btn5Clicked:(id)sender;

//// 查看更多商品触发的事件
//- (IBAction)morebtnClicked:(id)sender;

// 各个分类点击触发的事件
- (IBAction)category_Clicked:(id)sender;
// 点单按钮触发的事件
- (IBAction)m_menuClicked:(id)sender;
// 会员卡按钮触发的事件
- (IBAction)m_vipCardClicked:(id)sender;

@end

@implementation HomeViewController

@synthesize m_BMK_mapView;

@synthesize m_search;

@synthesize m_infoList;

@synthesize isClick;

@synthesize m_AdUpAdList;

@synthesize m_dic;

@synthesize m_timer;

@synthesize m_productList;

@synthesize m_categoryList;

@synthesize m_xiaImagV;
@synthesize m_city;

@synthesize m_dazhongList;

@synthesize m_showTypeString;

@synthesize m_menuList;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        dbhelp = [[DBHelper alloc]init];
        
        m_infoList = [[NSMutableArray alloc]initWithCapacity:0];

        m_AdUpAdList = [[NSMutableArray alloc]initWithCapacity:0];
        
        m_productList = [[NSMutableArray alloc]initWithCapacity:0];
        
        m_dic = [[NSDictionary alloc]init];
        
        m_categoryList = [[NSMutableArray alloc]initWithCapacity:0];
        
        isClick = NO;

        searchHelper = [[SearchRecordsHelper alloc]init];
        
        m_city = [[NSMutableArray alloc]initWithCapacity:0];
        
        m_dazhongList = [[NSMutableArray alloc]initWithCapacity:0];
        
        m_menuList = [[NSMutableArray alloc]initWithCapacity:0];
        
    }
    
    return self;
    
}

-(NSArray *)member_dataArr {

    if (_member_dataArr == nil) {
        
        NSMutableArray *mut = [NSMutableArray array];
        
        Home_MemberShipModel *model = [[Home_MemberShipModel alloc] init];
        
        model.membershipImg = @"home_vip_.png";
        
        model.diandanImg = @"home_diandan_.png";
        
        Home_MemberShipFrame *frame = [[Home_MemberShipFrame alloc] init];
        
        frame.cellModel = model;
        
        [mut addObject:frame];
        
        _member_dataArr = mut;
        
    }
    
    return _member_dataArr;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    m_city = [dbhelp queryCity];
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(105, 6, 150, 30)];
    titleLabel.font = [UIFont systemFontOfSize:16.0f];//[UIFont fontWithName:@"Helvetica-Bold" size:20.0f];//fontWithName:@"Helvetica-Bold" size:22.0f];
    titleLabel.textColor = [UIColor whiteColor];

    [titleLabel setShadowOffset:CGSizeMake(0, 0)];
    [titleLabel setShadowColor:[UIColor colorWithRed:0x41/255.0f green:0x41/255.0f blue:0x41/255.0f alpha:1.0f]]; //[UIColor whiteColor]];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    
    if ([[NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:kSelectAddress]] isEqualToString:@"(null)"]||[[NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:kSelectAddress]] isEqualToString:@""]) {
        titleLabel.text = @"本地";
    }else{
        titleLabel.text = [CommonUtil getValueByKey:kSelectAddress];
    }
    
    [titleLabel sizeToFit];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 30)];
    view.backgroundColor = [UIColor colorWithRed:26/255.f green:140/255.f blue:254/255.f alpha:1.0];
    
    view.layer.cornerRadius = 15.0f;
    
    
    
    // 图片显示
    UIImageView *imagV = [[UIImageView alloc]initWithFrame:CGRectMake(12, 8, 12, 14)];
    imagV.image = [UIImage imageNamed:@"hh_search_home.png"];
    
    [view addSubview:imagV];
    
    // label显示
    UILabel *l_label = [[UILabel alloc]initWithFrame:CGRectMake(32, 0, 120, 30)];
    l_label.text = @"请输入商品名称";
    l_label.font = [UIFont systemFontOfSize:12.0f];
    l_label.textColor = [UIColor whiteColor];
    l_label.backgroundColor = [UIColor clearColor];
    [view addSubview:l_label];
    
    // 按钮
    UIButton *l_btn = [UIButton buttonWithType:UIButtonTypeCustom];
    l_btn.frame = CGRectMake(0, 0, 160, 30);
    l_btn.backgroundColor = [UIColor clearColor];
    [l_btn addTarget:self action:@selector(searchClicked) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:l_btn];
    
    
    
    self.navigationItem.titleView = view;

    [self setRightButtonWithTitle:@"商户" action:@selector(rightClicked)];
    
    self.m_address.alpha = 0.5f;

    // 初始化pageControl
    CGRect pageControlFrame = CGRectMake(0, 90, WindowSizeWidth, 10);
    self.m_pageControl = [[GrayPageControl alloc]initWithFrame:pageControlFrame];
    self.m_pageControl.backgroundColor = [UIColor clearColor];//背景
    self.m_pageControl.inactiveImage = [UIImage imageNamed:@"white.png"];
    self.m_pageControl.activeImage = [UIImage imageNamed:@"blue.png"];
    self.m_pageControl.userInteractionEnabled = NO;
    self.m_pageControl.currentPage = 0;
    
    
    self.m_tableView.hidden = YES;
    
    HomeTableFooterView *footerview = [[HomeTableFooterView alloc] init];
    
    footerview.frame = CGRectMake(0, 0, ScreenWidth, footerview.height);
    
    self.m_tableView.tableFooterView = footerview;
    
    // 设置导航栏的左按钮 =========
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 60, 44)];
    view1.backgroundColor = [UIColor clearColor];
    
    UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(45, 15, 16, 16)];
    imgV.image = [UIImage imageNamed:@"baiXia.png"];
    
    self.m_xiaImagV = imgV;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(3, 12, 50, 20)];
    //    label.text = @"苏州";
    label.font = [UIFont systemFontOfSize:14.0f];
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    self.m_cityNameLabel = label;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 80, 44);
    btn.backgroundColor = [UIColor clearColor];
    [btn addTarget:self action:@selector(chooseCity) forControlEvents:UIControlEventTouchUpInside];
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(20, 12, 20, 20)];
    indicator.backgroundColor = [UIColor clearColor];
    
    [indicator startAnimating];
    self.m_activity = indicator;
    
    [view1 addSubview:imgV];
    
    [view1 addSubview:self.m_cityNameLabel];
    
    [view1 addSubview:btn];
        
    // 赋值，用于定位成功后按钮可点击
    self.m_leftBtn = btn;
    
    UIBarButtonItem *_barButton = [[UIBarButtonItem alloc] initWithCustomView:view1];
    [self.navigationItem setLeftBarButtonItem:_barButton];
    
    if ([[NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:kSelectCityName]] isEqualToString:@"(null)"]) {
        [CommonUtil addValue:@"苏州" andKey:kSelectCityName];
        [CommonUtil addValue:@"" andKey:kHomeDistrict];
        [CommonUtil addValue:@"1" andKey:kSelectCityId];

        // 保存起来用于景区列表显示
        [CommonUtil addValue:@"苏州" andKey:kSceneryCityName];
        [CommonUtil addValue:@"31.354779" andKey:kSceneryLatitude];
        [CommonUtil addValue:@"120.561860" andKey:kSceneryLongitude];
        
        
    }

    NSString *district = [NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:kHomeDistrict]];
    
    // 赋值-左上角的城市名称显示
    if ( [district isEqualToString:@"(null)"] ) {
        
        self.m_cityNameLabel.text = [NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:kSelectCityName]];

    }else if ( [district isEqualToString:@""] ) {
        
        self.m_cityNameLabel.text = [NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:kSelectCityName]];
        
    }else{
        
        self.m_cityNameLabel.text = [NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:kHomeDistrict]];

    }
    

    
    [self.m_tableView setDelegate:self];
    [self.m_tableView setDataSource:self];
    [self.m_tableView setPullDelegate:self];
    self.m_tableView.pullBackgroundColor = [UIColor whiteColor];
    self.m_tableView.useRefreshView = YES;
    self.m_tableView.useLoadingMoreView = NO;
    
    
    // 请求数据
    [self homeRequestSubmit];
    
    // 判断文件路径里面是否包含这个文件
    NSFileManager *fm = [NSFileManager defaultManager];

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);

    NSString *documentDirectory = [paths objectAtIndex:0];
    
    NSString *finalPath = [documentDirectory stringByAppendingPathComponent:@"categoryList.plist"];
    
    if ( [fm fileExistsAtPath:finalPath] ) {
        self.m_categoryList = [[NSArray arrayWithContentsOfFile:finalPath] mutableCopy];
    }
    
    
    // 初始化地图
    BMKMapView *mapView = [[BMKMapView alloc]init];
    self.m_BMK_mapView = mapView;
    _locService = [[BMKLocationService alloc]init];
    m_search = [[BMKGeoCodeSearch alloc]init];
    
    // 大众点评的城市列表数据-用于匹配定位成功后的城市数据的判断-用于请求大众点评的数据
    NSString *finalPath1 = [documentDirectory stringByAppendingPathComponent:@"DzdpCityList.plist"];
    
    if ( [fm fileExistsAtPath:finalPath1] ) {
        
        self.m_dazhongList  = [[NSArray arrayWithContentsOfFile:finalPath1] mutableCopy];
        
    }
    
    [self requestForFSBExtension];
    
    [self requestForMRExtension];
    
    [self requestForGameExtension];
    
    [self requestForCarExtension];
    
    [self requestForGameAlert];
    
}

//请求游戏弹框
- (void)requestForGameAlert {
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    //4==游戏协议
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    
    AppHttpClient* httpClient = [AppHttpClient sharedGame];
    
    [httpClient gamerequest:@"GameIsUp.ashx" parameters:param success:^(NSJSONSerialization *json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            
            NSString *game = [NSString stringWithFormat:@"%@",[json valueForKey:@"gamelink"]];
            
            NSString *gameUrl = [NSString stringWithFormat:@"%@",[json valueForKey:@"gamename"]];
            
            [CommonUtil addValue:game andKey:GameAlert];
            
            [CommonUtil addValue:gameUrl andKey:GameLink];
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showErrorWithStatus:msg];
            
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}

//请求养车宝协议
- (void)requestForCarExtension {
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    //4==游戏协议
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  @"5",@"type",
                                  nil];
    
    AppHttpClient* httpClient = [AppHttpClient sharedExtension];
    
    [httpClient ExtensionRequest:@"Agreement.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            
            NSString *car_extension = [json valueForKey:@"Content"];
            
            NSString *car_title = [json valueForKey:@"Title"];
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            
            [defaults setObject:car_extension forKey:@"car_extension"];
            
            [defaults setObject:car_title forKey:@"car_title"];
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showErrorWithStatus:msg];
            
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}

//请求游戏协议
- (void)requestForGameExtension {
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    //4==游戏协议
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  @"4",@"type",
                                  nil];
    
    AppHttpClient* httpClient = [AppHttpClient sharedExtension];
    
    [httpClient ExtensionRequest:@"Agreement.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            
            NSString *game_extension = [json valueForKey:@"Content"];
            
            NSString *game_title = [json valueForKey:@"Title"];
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            
            [defaults setObject:game_extension forKey:@"game_extension"];
            
            [defaults setObject:game_title forKey:@"game_title"];
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showErrorWithStatus:msg];
            
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}

//请求商户红包协议
- (void)requestForMRExtension {
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    //7==商户红包协议
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  @"7",@"type",
                                  nil];
    
    AppHttpClient* httpClient = [AppHttpClient sharedExtension];
    
    [httpClient ExtensionRequest:@"Agreement.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            
            NSString *fensibao_extension = [json valueForKey:@"Content"];
            
            NSString *fensibao_title = [json valueForKey:@"Title"];
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            
            [defaults setObject:fensibao_extension forKey:@"merchantred_extension"];
            
            [defaults setObject:fensibao_title forKey:@"merchantred_title"];
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showErrorWithStatus:msg];
            
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}


//请求粉丝宝协议
- (void)requestForFSBExtension {

    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    //3==粉丝宝协议
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  @"3",@"type",
                                  nil];
    
    AppHttpClient* httpClient = [AppHttpClient sharedExtension];
    
    [httpClient ExtensionRequest:@"Agreement.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            
            NSString *fensibao_extension = [json valueForKey:@"Content"];
            
            NSString *fensibao_title = [json valueForKey:@"Title"];
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            
            [defaults setObject:fensibao_extension forKey:@"fensibao_extension"];
            
            [defaults setObject:fensibao_title forKey:@"fensibao_title"];
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showErrorWithStatus:msg];
            
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}

//首页推送请求
- (void)requestForHomeData {

    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }

    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  [CommonUtil getValueByKey:MEMBER_ID],@"MemberId",
                                  nil];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    
    [httpClient request:@"APPIndexDynamicData_1.ashx" parameters:param success:^(NSJSONSerialization *json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            
            NSArray *array = [json valueForKey:@"listData"];
            
            NSMutableArray *mut = [NSMutableArray array];
    
            for (NSDictionary *dic in array) {
    
                HomePushModel *model = [[HomePushModel alloc] init];
                
                model.Type = dic[@"Type"];
                
                model.Icon = dic[@"Icon"];
                
                model.Title = dic[@"Title"];
                
                model.Time = dic[@"Time"];
                
                model.ContentImg = dic[@"ContentImg"];
                
                model.Result = dic[@"Result"];
                
                model.Desc = dic[@"Desc"];
                
                model.ClassifyType = dic[@"ClassifyType"];
                
                model.ClassifyDesc = dic[@"ClassifyDesc"];
                
                model.IsImg = dic[@"IsImg"];
    
                HomePushFrame *frame = [[HomePushFrame alloc] init];
    
                frame.pushmodel = model;
    
                [mut addObject:frame];
                
            }
            
            self.homePushArray = mut;
            
            [self.m_tableView reloadData];
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showErrorWithStatus:msg];
            
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    // 在状态栏位置添加label，使其背景色为黑色
        if ( isIOS7 ) {
    
            UILabel *l_label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 20)];
            l_label.backgroundColor = RGBACKTAB;
            l_label.tag = 10392;
            [self.tabBarController.navigationController.view addSubview:l_label];
    
        }
    
    [self requestForHomeData];
    
    [self yanzhengFSBExtension];
    
    [self yanzhengGameExtension];
    
    [self yanzhengCARExtension];
    
    if ( !isClick ) {
        if ( isIOS7 ) {
            self.navigationController.view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        } else{
            self.navigationController.view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 49);
        }
        
    }else{
        if ( isIOS7 ) {
            self.navigationController.view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        }
    }
    
    isClick = NO;
    
    if (self.m_tableView.hidden == YES ) {
        self.m_tableView.hidden = NO;
        [self.m_tableView reloadData];
    }

    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(HomeStartLocation)
                                                 name:UIApplicationDidBecomeActiveNotification object:nil];
    
    NSTimeInterval timeInterval = [[NSDate date]
                                   timeIntervalSinceDate:[CommonUtil getValueByKey:@"kDefaultPlayLocationInterval"]];
    if (timeInterval > kDefaultPlayLocationInterval&&[[NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:HomeIslocation]] isEqualToString:@"YES"]) {
        [self.m_BMK_mapView viewWillAppear];
        [self HomeStartLocation];
    }

    [CommonUtil addValue:@"YES" andKey:HomeIslocation];

}

-(void)HomeStartLocation
{
    if (m_BMK_mapView.showsUserLocation) {
        return;
    }
    [_locService startUserLocationService];
    m_BMK_mapView.showsUserLocation = NO;//先关闭显示的定位图层
    m_BMK_mapView.userTrackingMode = BMKUserTrackingModeFollow;//设置定位的状态
    m_BMK_mapView.showsUserLocation = YES;//显示定位图层
    self.m_BMK_mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _locService.delegate = self;
    self.m_search.delegate = self;
}

- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation {

    CLLocationCoordinate2D pt = (CLLocationCoordinate2D){0, 0};
    pt = (CLLocationCoordinate2D){userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude};
    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    reverseGeocodeSearchOption.reverseGeoPoint = pt;
    [self.m_search reverseGeoCode:reverseGeocodeSearchOption];

}


- (void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    
    if (error == 0) {
        
        NSString *cityName = [NSString stringWithFormat:@"%@",result.addressDetail.city];
        if (![cityName isEqualToString:@""]) {
            
            NSString *OldCity = [NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:kSelectCityName]];
            NSString *OldAdd = [NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:kSelectAddress]];
            
            NSString *NowCity = [cityName substringWithRange:NSMakeRange(0, cityName.length - 1)];
            NSString *NowAdd = [NSString stringWithFormat:@"%@%@",result.addressDetail.streetName,result.addressDetail.streetNumber];
            
            
            if (!([OldCity isEqualToString:NowCity]&&[OldAdd isEqualToString:NowAdd])) {
                
                [CommonUtil addValue:[NSString stringWithFormat:@"%f",result.location.latitude] andKey:kLatitudeKey];
                [CommonUtil addValue:[NSString stringWithFormat:@"%f",result.location.longitude] andKey:kLongitudeKey];
                [CommonUtil addValue:NowCity andKey:kSelectCityName];
                
                
                // 用于首页城市名称的显示-左上角(包含市或者县的话则显示出来)
                if ( [result.addressDetail.district  rangeOfString:@"市"].location != NSNotFound || [result.addressDetail.district  rangeOfString:@"县"].location != NSNotFound ) {
                    
                    [CommonUtil addValue:[NSString stringWithFormat:@"%@",result.addressDetail.district] andKey:kHomeDistrict];
                    
                    // 赋值
                    self.m_cityNameLabel.text = [NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:kHomeDistrict]];

                    
                    
                }else{
                    
                    [CommonUtil addValue:@"" andKey:kHomeDistrict];
                    
                    // 赋值
                    self.m_cityNameLabel.text = NowCity;
                    
                }
                
                
                [CommonUtil addValue:NowAdd andKey:kSelectAddress];
                [CommonUtil addValue:[NSString stringWithFormat:@"%@",result.address] andKey:kALLSelectAddress];
                
                // 用于首页当前位置所显示
                [CommonUtil addValue:[NSString stringWithFormat:@"%@",result.address] andKey:kHomeCityAddress];
                
                // 保存起来用于景区列表显示
                [CommonUtil addValue:NowCity andKey:kSceneryCityName];
                [CommonUtil addValue:[NSString stringWithFormat:@"%f",result.location.latitude] andKey:kSceneryLatitude];
                [CommonUtil addValue:[NSString stringWithFormat:@"%f",result.location.longitude] andKey:kSceneryLongitude];
            }

            [self ChangeAddress:NowCity andAdd:NowAdd];

        }

    }

    [_locService stopUserLocationService];
    _locService.delegate = nil;
    self.m_search.delegate = nil;
    m_BMK_mapView.showsUserLocation = NO;
    self.m_BMK_mapView.delegate = nil; // 不用时，置nil

}

//定位失败
- (void)mapView:(BMKMapView *)mapView didFailToLocateUserWithError:(NSError *)error{
    
    self.m_search.delegate = nil;
    self.m_BMK_mapView.delegate = nil;
    m_BMK_mapView.showsUserLocation = NO;
    _locService.delegate = nil;
    
}

-(void)ChangeAddress:(NSString *)City andAdd:(NSString *)Add {
    self.m_cityNameLabel.text = City;
    // 根据城市获取到对应的城市Id
    for (NSDictionary *dic in m_city) {
        NSString *string = [dic objectForKey:@"name"];
        if ( [string isEqualToString:City] ) {
            [CommonUtil addValue:[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]] andKey:kSelectCityId];
            break;
        }
    }
    [CommonUtil addValue:[NSDate date] andKey:@"kDefaultPlayLocationInterval"];
    [self homeRequestSubmit];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (void)rightClicked{
   
    isClick = YES;
    
    // 进入全部商户的页面
    all_merchantViewController *VC = [[all_merchantViewController alloc]initWithNibName:@"all_merchantViewController" bundle:nil];
    [self.navigationController pushViewController:VC animated:YES];
}

- (void)searchClicked{
    
    // 进入搜索的页面
    HH_SearchViewController *VC = [[HH_SearchViewController alloc]initWithNibName:@"HH_SearchViewController" bundle:nil];
    [self.navigationController pushViewController:VC animated:YES];
    
}

- (void)chooseCity{
    
    isClick = YES;
    
//    // 进入城市列表
    HH_cityListViewController *VC = [[HH_cityListViewController alloc]initWithNibName:@"HH_cityListViewController" bundle:nil];
    VC.m_typeString = @"2";
    VC.delegate = self;
    [self.navigationController pushViewController:VC animated:YES];

}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0){
        
        return self.member_dataArr.count;
        
    }else if (section == 1) {
        
        return self.homeMenuArray.count;
        
    }else if (section == 2){
    
        return self.homePushArray.count;
        
    }else {
    
        return 0;
        
    }

}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if ( section == 0 ) {
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 2, WindowSizeWidth, 15)];
        view.backgroundColor = [UIColor clearColor];
        
        UIImageView *imagV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WindowSizeWidth, 15)];
        imagV.backgroundColor = [UIColor blackColor];
        imagV.alpha = 0.6;
        [view addSubview:imagV];
        
        NSString *current = [NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:kHomeCityAddress]];
        
        // 定位到的具体地理位置
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, 300, 15)];
        
        // 如果定位的地址为空时默认为苏州市的地址
        if ( current.length == 0 || [current isEqualToString:@"(null)"] ) {
            
            label.text = @"定位未成功 默认为:苏州";

        }else{
            
            label.text = [NSString stringWithFormat:@"您当前位置:%@",current];

        }
        
        label.font = [UIFont systemFontOfSize:10.0f];
        label.textColor = [UIColor whiteColor];
        
        [view addSubview:label];
        
        return view;

    }else {
    
        return nil;
        
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    if (section == 0) {
        
        return 15;
        
    }else {
    
        return 0;
        
    }
    
}

//验证粉丝宝协议是否签订
- (void)yanzhengFSBExtension {
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    
    AppHttpClient* httpClient = [AppHttpClient sharedExtension];
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"Memberid",
                           @"3",@"type",
                           @"0",@"IsAgree",
                           nil];

    [httpClient ExtensionRequest:@"FistAgreement.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            
            [defaults setObject:@"1" forKey:@"FSB_YanZheng"];
            
        } else {
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            
            [defaults setObject:@"0" forKey:@"FSB_YanZheng"];
            
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
}

//验证养车宝协议是否签订
- (void)yanzhengCARExtension {
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    
    AppHttpClient* httpClient = [AppHttpClient sharedExtension];
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"Memberid",
                           @"5",@"type",
                           @"0",@"IsAgree",
                           nil];
    
    [httpClient ExtensionRequest:@"FistAgreement.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            
            [defaults setObject:@"1" forKey:@"CAR_YanZheng"];
            
        } else {
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            
            [defaults setObject:@"0" forKey:@"CAR_YanZheng"];
            
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
}

//验证游戏协议是否签订
- (void)yanzhengGameExtension {
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    
    AppHttpClient* httpClient = [AppHttpClient sharedExtension];
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"Memberid",
                           @"4",@"type",
                           @"0",@"IsAgree",
                           nil];
    
    [httpClient ExtensionRequest:@"FistAgreement.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            
            [defaults setObject:@"1" forKey:@"Game_YanZheng"];
            
        } else {
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            
            [defaults setObject:@"0" forKey:@"Game_YanZheng"];
            
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
}

- (void)menuClickWithType:(NSString *)type withViewType:(NSString *)viewID WithName:(NSString *)titleName {
    
    if ([type isEqualToString:@"4"]) {
        
        //养车宝
        for (HomePushFrame *frame in self.homePushArray) {
            
            if ([frame.pushmodel.Type isEqualToString:@"2"]) {
                
                if ([frame.pushmodel.ClassifyType isEqualToString:@"2"]) {
                    
                    //是会员
                    RH_HomeViewController *vc = [[RH_HomeViewController alloc] init];
                    
                    RH_NavViewController *nav = [[RH_NavViewController alloc] initWithRootViewController:vc];
                    
                    [self presentViewController:nav animated:YES completion:nil];
                    
                }else {
                    
                    //不是会员
                    RH_NoMemberShipViewController *vc = [[RH_NoMemberShipViewController alloc] init];
                    
                    RH_NavViewController *nav = [[RH_NavViewController alloc] initWithRootViewController:vc];

                    [self presentViewController:nav animated:YES completion:nil];
                    
                }
                
            }
            
        }
        
    }else if ([type isEqualToString:@"5"]) {
        
        //游戏大厅
        //游戏
//        FSB_GameViewController *vc = [[FSB_GameViewController alloc] init];
//
//        FSB_GameNAVController *gameNav = [[FSB_GameNAVController alloc] initWithRootViewController:vc];
//
//        [self presentViewController:gameNav animated:YES completion:nil];
        
        GameCenterHomeNewViewController *vc = [[GameCenterHomeNewViewController alloc] init];
        
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if ([type isEqualToString:@"6"]) {
        
        //车票
        // 火车、汽车
        TrainwebViewController *VC = [[TrainwebViewController alloc]initWithNibName:@"TrainwebViewController" bundle:nil];
        [self.navigationController pushViewController:VC animated:YES];
        
    }else if ([type isEqualToString:@"7"]) {
        
        //机票
        Fl_webViewController *VC = [[Fl_webViewController alloc]initWithNibName:@"Fl_webViewController" bundle:nil];
        [self.navigationController pushViewController:VC animated:NO];
        
    }else if ([type isEqualToString:@"8"]) {
        
        //酒店
        Hotel_webViewController *VC = [[Hotel_webViewController alloc]initWithNibName:@"Hotel_webViewController" bundle:nil];
        [self.navigationController  pushViewController:VC animated:YES];
        
    }else if ([type isEqualToString:@"9"]) {
        
        //景点
        Sec_webViewController *VC = [[Sec_webViewController alloc]initWithNibName:@"Sec_webViewController" bundle:nil];
        [self.navigationController pushViewController:VC animated:YES];
        
    }else if ([type isEqualToString:@"10"]) {
        
        //绿生网
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                              [CommonUtil getValueByKey:MEMBER_ID],@"Memberid", nil];
        
        AppHttpClient *http = [AppHttpClient sharedGreen];
        
        [http Greenrequest:@"LoginByMemberID.ashx" parameters:dict success:^(NSJSONSerialization *json) {
            
            GreenLifeViewController *vc = [[GreenLifeViewController alloc] init];
            
            vc.loadStr = [NSString stringWithFormat:@"%@?memberId=%@&cityId=%@",viewID,[CommonUtil getValueByKey:MEMBER_ID],[CommonUtil getValueByKey:CITYID]];
            
            [self presentViewController:vc animated:YES completion:nil];
            
        } failure:^(NSError *error) {
            
        }];
        
    }else if ([type isEqualToString:@"11"]) {
        
        //更多
        Home_FenLeiViewController *vc = [[Home_FenLeiViewController alloc] init];
        
        //养车宝
        for (HomePushFrame *frame in self.homePushArray) {
            
            if ([frame.pushmodel.Type isEqualToString:@"2"]) {
                
                vc.YCBType = frame.pushmodel.Type;
                
            }
            
        }
        
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if ([type isEqualToString:@"12"]) {
        
        //粉丝宝
        FSB_NewHomeViewController *vc = [[FSB_NewHomeViewController alloc] init];
        
        [self.navigationController pushViewController:vc animated:YES];
        
    }else {
        
        [self pushWithMenuID:type WithViewID:viewID WithTitle:titleName];
        
    }
    
}

- (void)pushWithMenuID:(NSString *)menu WithViewID:(NSString *)view WithTitle:(NSString *)title {
    
    Ca_productListViewController *VC = [[Ca_productListViewController alloc]initWithNibName:@"Ca_productListViewController" bundle:nil];
    VC.TwoID = [NSString stringWithFormat:@"%@",view];
    VC.m_titleString = [NSString stringWithFormat:@"%@",title];
    [self.navigationController pushViewController:VC animated:YES];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         [CommonUtil getValueByKey:MEMBER_ID],@"MemberID",
                         menu,@"Type",
                         nil];
    
    AppHttpClient *http = [AppHttpClient sharedClient];
    
    [http request:@"ClickIconRecord.ashx" parameters:dic success:^(NSJSONSerialization *json) {
        
    } failure:^(NSError *error) {
        
    }];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        Home_MemberShipCell *cell = [[Home_MemberShipCell alloc] init];
        
        Home_MemberShipFrame *frame = self.member_dataArr[indexPath.row];
        
        cell.memberShipBlock = ^{
            
            // 进入会员卡的页面
            MyCardViewController * VC = [[MyCardViewController alloc]initWithNibName:@"MyCardViewController" bundle:nil];
            
            [self.navigationController pushViewController:VC animated:YES];
            
        };
        
        cell.dianDanBlock = ^{
            
            // 进入到点单的页面
            HH_MactMenuViewController *VC  = [[HH_MactMenuViewController alloc]initWithNibName:@"HH_MactMenuViewController" bundle:nil];
            [self.navigationController pushViewController:VC animated:YES];
            
        };
        
        cell.frameModel = frame;
        
        return cell;
        
    }else if (indexPath.section == 1) {
        
        HomeMenuCell *cell = [[HomeMenuCell alloc] init];
        
        HomeMenuFrame *frame = self.homeMenuArray[indexPath.row];
        
        cell.frameModel = frame;
        
        cell.meishiBlock = ^{
            
            MenuBtnModel *model = frame.menumodel.btnArray[0];
            
            [self menuClickWithType:model.Type withViewType:model.LinkUrl WithName:model.Title];

        };
        
        cell.lirenBlock = ^{
            
            MenuBtnModel *model = frame.menumodel.btnArray[1];
            
            [self menuClickWithType:model.Type withViewType:model.LinkUrl WithName:model.Title];
            
        };
        
        cell.KTVBlock = ^{
            
            MenuBtnModel *model = frame.menumodel.btnArray[2];
            
            [self menuClickWithType:model.Type withViewType:model.LinkUrl WithName:model.Title];
            
        };
        
        cell.yangchebaoBlock = ^{
            
            MenuBtnModel *model = frame.menumodel.btnArray[3];
            
            [self menuClickWithType:model.Type withViewType:model.LinkUrl WithName:model.Title];
            
        };
        
        cell.youxiBlock = ^{
            
            MenuBtnModel *model = frame.menumodel.btnArray[4];
            
            [self menuClickWithType:model.Type withViewType:model.LinkUrl WithName:model.Title];
            
        };
        
        cell.chepiaoBlock = ^{
            
            MenuBtnModel *model = frame.menumodel.btnArray[5];
            
            [self menuClickWithType:model.Type withViewType:model.LinkUrl WithName:model.Title];
            
        };
        
        cell.jipiaoBlock = ^{
            
            MenuBtnModel *model = frame.menumodel.btnArray[6];
            
            [self menuClickWithType:model.Type withViewType:model.LinkUrl WithName:model.Title];
            
        };
        
        cell.jiudianBlock = ^{
            
            MenuBtnModel *model = frame.menumodel.btnArray[7];
            
            [self menuClickWithType:model.Type withViewType:model.LinkUrl WithName:model.Title];
            
        };
        
        cell.jingdianBlock = ^{
            
            MenuBtnModel *model = frame.menumodel.btnArray[8];
            
            [self menuClickWithType:model.Type withViewType:model.LinkUrl WithName:model.Title];
            
        };
        
        cell.gengduoBlock = ^{
            
            //更多
            MenuBtnModel *model = frame.menumodel.btnArray[9];
            
            [self menuClickWithType:model.Type withViewType:model.LinkUrl WithName:model.Title];
            
        };
        
        return cell;
        
    }else if (indexPath.section == 2) {
    
        HomePushCell *cell = [[HomePushCell alloc] init];
        
        HomePushFrame *frame = self.homePushArray[indexPath.row];
        
        cell.frameModel = frame;
        
        cell.clickBlock = ^{
            
            if ([frame.pushmodel.Type isEqualToString:@"1"]) {
                
                //粉丝宝
                FSB_NewHomeViewController *vc = [[FSB_NewHomeViewController alloc] init];
                
                [self.navigationController pushViewController:vc animated:YES];
                
            }else if ([frame.pushmodel.Type isEqualToString:@"2"]) {
                
                //养车宝
                if ([frame.pushmodel.ClassifyType isEqualToString:@"2"]) {
                    
                    //养车宝会员
                    
                    RH_HomeViewController *vc = [[RH_HomeViewController alloc] init];
                    
                    RH_NavViewController *nav = [[RH_NavViewController alloc] initWithRootViewController:vc];
                    
                    [self presentViewController:nav animated:YES completion:nil];
                    
                }else {
                    
                    //不是养车宝会员
                
                    RH_NoMemberShipViewController *vc = [[RH_NoMemberShipViewController alloc] init];
                    
                    RH_NavViewController *nav = [[RH_NavViewController alloc] initWithRootViewController:vc];
                    
                    //                    vc.cellModel = frame.rh_model;
                    
                    [self presentViewController:nav animated:YES completion:nil];
                    
                }

            }else if ([frame.pushmodel.Type isEqualToString:@"3"]) {
                
                //游戏结果
                if ([frame.pushmodel.ClassifyType isEqualToString:@"1"]) {
                    
                    //进入拼手气
                    GameWebViewController *vc = [[GameWebViewController alloc] init];
                    
                    vc.loadStr = [NSString stringWithFormat:@"%@?memberId=%@",frame.pushmodel.ClassifyDesc,[CommonUtil getValueByKey:MEMBER_ID]];
                    
                    [self.navigationController pushViewController:vc animated:YES];
                    
                }else if ([frame.pushmodel.ClassifyType isEqualToString:@"2"]) {
                    
                    //进入打企鹅
                    GameWebViewController *vc = [[GameWebViewController alloc] init];
                    
                    vc.loadStr = [NSString stringWithFormat:@"%@?memberId=%@",frame.pushmodel.ClassifyDesc,[CommonUtil getValueByKey:MEMBER_ID]];
                    
                    [self.navigationController pushViewController:vc animated:YES];
                    
                }else if ([frame.pushmodel.ClassifyType isEqualToString:@"3"]) {
                    
                    //进入抽黄金
                    GameWebViewController *vc = [[GameWebViewController alloc] init];
                    
                    vc.loadStr = [NSString stringWithFormat:@"%@?memberId=%@&app=ios",frame.pushmodel.ClassifyDesc,[CommonUtil getValueByKey:MEMBER_ID]];
                    
                    [self.navigationController pushViewController:vc animated:YES];
                    
                }else if ([frame.pushmodel.ClassifyType isEqualToString:@"0"]) {
                    
                    //进入游戏大厅
//                    FSB_GameViewController *vc = [[FSB_GameViewController alloc] init];
//
//                    FSB_GameNAVController *gameNav = [[FSB_GameNAVController alloc] initWithRootViewController:vc];
//
//                    [self presentViewController:gameNav animated:YES completion:nil];
                    
                    GameCenterHomeNewViewController *vc = [[GameCenterHomeNewViewController alloc] init];
                    
                    [self.navigationController pushViewController:vc animated:YES];
                    
                }
                
            }else if ([frame.pushmodel.Type isEqualToString:@"4"]) {
                
                //推广
                if ([frame.pushmodel.ClassifyType isEqualToString:@"0"]) {
                    
                    //跳h5推广
                    
                    GameWebViewController *vc = [[GameWebViewController alloc] init];
                    
                    vc.loadStr = [NSString stringWithFormat:@"%@",frame.pushmodel.ClassifyDesc];
                    
                    [self.navigationController pushViewController:vc animated:YES];
                    
                }else if ([frame.pushmodel.ClassifyType isEqualToString:@"1"]) {
                    
                    //跳游戏
                    GameWebViewController *vc = [[GameWebViewController alloc] init];
                    
                    vc.loadStr = [NSString stringWithFormat:@"%@?memberId=%@&app=ios",frame.pushmodel.ClassifyDesc,[CommonUtil getValueByKey:MEMBER_ID]];
                    
                    [self.navigationController pushViewController:vc animated:YES];
                    
                }else if ([frame.pushmodel.ClassifyType isEqualToString:@"2"]) {
                    
                    //进入游戏大厅
//                    FSB_GameViewController *vc = [[FSB_GameViewController alloc] init];
//
//                    FSB_GameNAVController *gameNav = [[FSB_GameNAVController alloc] initWithRootViewController:vc];
//
//                    [self presentViewController:gameNav animated:YES completion:nil];
                    
                    GameCenterHomeNewViewController *vc = [[GameCenterHomeNewViewController alloc] init];
                    
                    [self.navigationController pushViewController:vc animated:YES];
                    
                }
                
            }else if ([frame.pushmodel.Type isEqualToString:@"5"]) {
                
                //天城
                isClick = YES;
                
                // 点击进入链接
                WebViewController *VC = [[WebViewController alloc]initWithNibName:@"WebViewController" bundle:nil];
                VC.m_scanString = [NSString stringWithFormat:@"%@",frame.pushmodel.ClassifyDesc];
                VC.m_typeString = @"2";
                
                [self.navigationController pushViewController:VC animated:YES];
                
            }else if ([frame.pushmodel.Type isEqualToString:@"6"]) {
                
                MR_HomeViewController *vc = [[MR_HomeViewController alloc] init];
                
                [self.navigationController pushViewController:vc animated:YES];
                
            }
            
        };
        
        return cell;
        
    }else {
    
        return nil;
        
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0){
        
        Home_MemberShipFrame *frame = self.member_dataArr[indexPath.row];
        
        return frame.height;
        
    }else if (indexPath.section == 1) {
        
        HomeMenuFrame *frame = self.homeMenuArray[indexPath.row];
        
        return frame.height;
        
    }else if (indexPath.section == 2){
    
        HomePushFrame *frame = self.homePushArray[indexPath.row];
        
        return frame.height;
        
    }else {
    
        return 0;
        
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}

#pragma mark - BtnClciked 分类
- (void)btn1Clicked:(id)sender {

    isClick = YES;

}

- (void)btn5Clicked:(id)sender {
    
    isClick = YES;

    // 进入分类的页面
    CategoryViewController *VC = [[CategoryViewController alloc]initWithNibName:@"CategoryViewController" bundle:nil];
    
    [self.navigationController pushViewController:VC animated:YES];
}

- (void)scrollViewDidClickedAtPage:(NSInteger)pageNumber {
    
    if ([[CommonUtil getValueByKey:MEMBER_ID] isEqualToString:@"19404"]) {
        
        
        
    }else {
        
        Home_ScrollModel *model = self.home_scrollArr[pageNumber];
        
        NSDictionary * Prodic = [self dictionaryFromQuery:[[NSURL URLWithString:model.AdUrl] query] usingEncoding:NSUTF8StringEncoding];
        
        if ([[NSString stringWithFormat:@"%@",[Prodic objectForKey:@"cityandcitytype"]] isEqualToString:@"3"]) {
            // 点击进入商品详情
            ProductDetailViewController *VC = [[ProductDetailViewController alloc]initWithNibName:@"ProductDetailViewController" bundle:nil];
            
            VC.m_productId = [NSString stringWithFormat:@"%@",[Prodic objectForKey:@"serviceId"]];
            VC.m_merchantShopId = [NSString stringWithFormat:@"%@",[Prodic objectForKey:@"merchantShopId"]];
            
            [self.navigationController pushViewController:VC animated:YES];
            
        }else if ([[NSString stringWithFormat:@"%@",[Prodic objectForKey:@"cityandcitytype"]] isEqualToString:@"4"])
        {
            
            // 进入webView页面
            WebViewController *VC = [[WebViewController alloc]initWithNibName:@"WebViewController" bundle:nil];
            
            NSArray *array = [[NSString stringWithFormat:@"%@",model.AdUrl] componentsSeparatedByString:@"?"];
            
            NSString *urlstr = [NSString stringWithFormat:@"%@",array[0]];
            
            if ([[urlstr substringToIndex:3] isEqualToString:@"www"] || [[urlstr substringToIndex:3] isEqualToString:@"WWW"]) {
                
                urlstr = [NSString stringWithFormat:@"http://%@",urlstr];
                
            }
            
            VC.m_scanString = urlstr;
            VC.m_typeString = @"2";
            
            [self.navigationController pushViewController:VC animated:YES];
            
        }else if ([[NSString stringWithFormat:@"%@",[Prodic objectForKey:@"cityandcitytype"]] isEqualToString:@"5"])
        {
            
            // 跳转到菜单列表的页面
            
            [CommonUtil addValue:model.Logo andKey:@"MarchantImageKey"];
            [CommonUtil addValue:model.YHDescription andKey:YHDESCRIPTION];
            [CommonUtil addValue:model.Man andKey:MANKEY];
            [CommonUtil addValue:model.Jian andKey:JIANKEY];
            
            CPSHH_TakeOrderViewController *VCC = [[CPSHH_TakeOrderViewController alloc]init];
            [VCC.m_dic setObject:model.ShopLists forKey:@"m_shopList"];
            [VCC.m_dic setObject:[NSString stringWithFormat:@"%@",model.IsSelectSeat] forKey:@"m_seat"];
            [VCC.m_dic setObject:[NSString stringWithFormat:@"%@",model.ModelType] forKey:@"m_ModelType"];
            [VCC.m_dic setObject:[NSString stringWithFormat:@"%@",model.MerchantID] forKey:@"m_merchantId"];
            [VCC.m_dic setObject:[NSString stringWithFormat:@"%@",model.IsZCWaiMai] forKey:@"IsZCWaiMai"];
            [self.navigationController pushViewController:VCC animated:YES];
            
        }else if ([[NSString stringWithFormat:@"%@",[Prodic objectForKey:@"cityandcitytype"]] isEqualToString:@"7"])
        {
            
            //跳粉丝宝
            FSB_NewHomeViewController *vc = [[FSB_NewHomeViewController alloc] init];
            
            [self.navigationController pushViewController:vc animated:YES];
            
        }else if ([[NSString stringWithFormat:@"%@",[Prodic objectForKey:@"cityandcitytype"]] isEqualToString:@"8"])
        {
            
            //跳养车宝
            RH_HomeViewController *vc = [[RH_HomeViewController alloc] init];
            
            RH_NavViewController *nav = [[RH_NavViewController alloc] initWithRootViewController:vc];
            
            [self presentViewController:nav animated:YES completion:nil];
            
        }else if ([[NSString stringWithFormat:@"%@",[Prodic objectForKey:@"cityandcitytype"]] isEqualToString:@"9"])
        {
            
            //跳游戏
            //进入游戏大厅
//            FSB_GameViewController *vc = [[FSB_GameViewController alloc] init];
//
//            FSB_GameNAVController *gameNav = [[FSB_GameNAVController alloc] initWithRootViewController:vc];
//
//            [self presentViewController:gameNav animated:YES completion:nil];
            
            GameCenterHomeNewViewController *vc = [[GameCenterHomeNewViewController alloc] init];
            
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        
    }
    
}

- (void)initScrollerViewWithArray:(NSArray *)array;{
    
    Home_ScrollView *scroll = [[Home_ScrollView alloc] initPageViewWithFrame:CGRectMake(0, 0, WindowSizeWidth, WindowSizeWidth * 0.3125) views:array];
    
    scroll.pageControl.pageIndicatorTintColor = [UIColor grayColor];
    
    scroll.pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:255/255. green:47/255. blue:46/255. alpha:1.];
    
    scroll.pageViewDelegate = self;
    
    self.m_tableView.tableHeaderView = scroll;
    
}

//获取地址址中参数
- (NSDictionary*)dictionaryFromQuery:(NSString*)query usingEncoding:(NSStringEncoding)encoding {
    NSCharacterSet* delimiterSet = [NSCharacterSet characterSetWithCharactersInString:@"&;"];
    NSMutableDictionary* pairs = [NSMutableDictionary dictionary];
    NSScanner* scanner = [[NSScanner alloc] initWithString:query];
    while (![scanner isAtEnd]) {
        NSString* pairString = nil;
        [scanner scanUpToCharactersFromSet:delimiterSet intoString:&pairString];
        [scanner scanCharactersFromSet:delimiterSet intoString:NULL];
        NSArray* kvPair = [pairString componentsSeparatedByString:@"="];
        if (kvPair.count == 2) {
            NSString* key = [[kvPair objectAtIndex:0]
                             stringByReplacingPercentEscapesUsingEncoding:encoding];
            NSString* value = [[kvPair objectAtIndex:1]
                               stringByReplacingPercentEscapesUsingEncoding:encoding];
            [pairs setObject:value forKey:key];
        }
    }
    
    return [NSDictionary dictionaryWithDictionary:pairs];
}

#pragma mark - 请求首页的数据
- (void)homeRequestSubmit{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        return;
    }
    
    NSString *merchantId = [CommonUtil getValueByKey:MERCHANTID];
    NSString *cityId = [CommonUtil getValueByKey:kSelectCityId];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           [CommonUtil getValueByKey:MEMBER_ID],@"MemberID",
                           merchantId, @"merchantId",
                           cityId, @"cityId",
                           nil];
    [httpClient request:@"IndexIconAndAdvertList.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            
            NSArray *adArr = [json valueForKey:@"listmctadvert"];
            
            NSMutableArray *mut = [NSMutableArray array];
            
            for (NSDictionary *dd in adArr) {
                
                Home_ScrollModel *model = [[Home_ScrollModel alloc] init];
                
                model.AdImg = [NSString stringWithFormat:@"%@",dd[@"AdImg"]];
                
                model.AdRemark = [NSString stringWithFormat:@"%@",dd[@"AdRemark"]];
                
                model.AdUrl = [NSString stringWithFormat:@"%@",dd[@"AdUrl"]];
                
                model.AdTitle = [NSString stringWithFormat:@"%@",dd[@"AdTitle"]];
                
                model.YHDescription = [NSString stringWithFormat:@"%@",dd[@"YHDescription"]];
                
                model.Man = [NSString stringWithFormat:@"%@",dd[@"Man"]];
                
                model.Jian = [NSString stringWithFormat:@"%@",dd[@"Jian"]];
                
                model.IsZCWaiMai = [NSString stringWithFormat:@"%@",dd[@"IsZCWaiMai"]];
                
                model.IsSelectSeat = [NSString stringWithFormat:@"%@",dd[@"IsSelectSeat"]];
                
                model.ModelType = [NSString stringWithFormat:@"%@",dd[@"ModelType"]];
                
                model.MerchantID = [NSString stringWithFormat:@"%@",dd[@"MerchantID"]];
                
                model.Logo = [NSString stringWithFormat:@"%@",dd[@"Logo"]];
                
                NSArray *temp = dd[@"ShopLists"];
                
                model.ShopLists = temp;
                
                [mut addObject:model];
                
            }
            
            self.home_scrollArr = mut;
            
            if (self.home_scrollArr.count != 0) {
                
                [self initScrollerViewWithArray:self.home_scrollArr];
                
            }
            
            NSArray *menuArr = [json valueForKey:@"listIcon"];
            
            NSMutableArray *menuMut = [NSMutableArray array];
            
            NSMutableArray *menuFrameMut = [NSMutableArray array];
            
            for (NSDictionary *menu in menuArr) {
                
                MenuBtnModel *model = [[MenuBtnModel alloc] init];
                
                model.Type = [NSString stringWithFormat:@"%@",menu[@"Type"]];
                
                model.Title = [NSString stringWithFormat:@"%@",menu[@"Title"]];
                
                model.Contents = [NSString stringWithFormat:@"%@",menu[@"Contents"]];
                
                model.PhotoUrl = [NSString stringWithFormat:@"%@",menu[@"PhotoUrl"]];
                
                model.LinkUrl = [NSString stringWithFormat:@"%@",menu[@"LinkUrl"]];
                
                [menuMut addObject:model];
                
            }
            
            HomeMenuModel *model = [[HomeMenuModel alloc] init];
            
            model.btnArray = menuMut;
            
            HomeMenuFrame *frame = [[HomeMenuFrame alloc] init];
            
            frame.menumodel = model;
            
            [menuFrameMut addObject:frame];
            
            self.homeMenuArray = menuFrameMut;
            
            // 设置定位到的地址位置
            NSString *current = [NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:kHomeCityAddress]];
            // 如果定位的地址为空时默认为苏州市的地址
            if ( current.length == 0 || [current isEqualToString:@"(null)"] ) {

                self.m_address1.text = @"定位未成功 默认为:苏州";

            }else{

                self.m_address1.text = [NSString stringWithFormat:@"您当前位置:%@",current];

            }
            
            [self.m_tableView reloadData];
            
            // 将分类的数据存储起来用于分类滚动的页面显示
//            if ( [searchHelper categoryList].count == 0 ) {
//
//                NSMutableArray *arr = [[NSMutableArray alloc]initWithCapacity:0];
//
//                for (int i = 0; i < self.m_categoryList.count - 1; i++) {
//
//                    NSDictionary *dic = [self.m_categoryList objectAtIndex:i];
//
//                    NSString *classId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"ClassId"]];
//
//                    NSString *className = [NSString stringWithFormat:@"%@",[dic objectForKey:@"ClassName"]];
//
//                    NSDictionary *l_dic = [NSDictionary dictionaryWithObjectsAndKeys:className,@"name",classId,@"code", nil];
//
//                    [arr addObject:l_dic];
//
//                }
//                // 将分类的数据保存到数据库中
//                [searchHelper updatecategoryList:arr];
//            }
            self.m_tableView.pullTableIsRefreshing = NO;
            
        }else {
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
            self.m_tableView.pullTableIsRefreshing = NO;

        }
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"请求失败，请稍后再试"];
        self.m_tableView.pullTableIsRefreshing = NO;
    }];

}

#pragma mark - HHCityListDelegate{
- (void)getHHCityName:(NSMutableDictionary *)aCityName{
    
    [CommonUtil addValue:@"NO" andKey:HomeIslocation];//手动选择城市 进入首页不定位

    if ([[aCityName objectForKey:@"name"] isEqualToString:self.m_cityNameLabel.text]&& [[CommonUtil getValueByKey:kSelectAddress] isEqualToString:titleLabel.text]&&(![titleLabel.text isEqualToString:@""]))
    {
        return;
    }
   
    NSString *district = [CommonUtil getValueByKey: kHomeDistrict];
    
    // 判断左上角城市显示名称
    if ( ![district isEqualToString:@""] ) {
        
        self.m_cityNameLabel.text = [NSString stringWithFormat:@"%@",district];
        
    }else{
        
        self.m_cityNameLabel.text = [aCityName objectForKey:@"name"];

    }
    

    selectCity = [aCityName objectForKey:@"code"];
    
    [CommonUtil addValue:[aCityName objectForKey:@"name"] andKey:kSelectCityName];
    [CommonUtil addValue:selectCity andKey:kSelectCityId];

    [CommonUtil addValue:[NSDate date] andKey:@"kDefaultPlayLocationInterval"];
    
    [self homeRequestSubmit];


}

#pragma mark - PullTableViewDelegate
- (void)pullTableViewDidTriggerRefresh:(PullTableView*)pullTableView {

    self.m_cityNameLabel.text = [CommonUtil getValueByKey:kSelectCityName];
    for (NSDictionary *dic in m_city) {
        NSString *string = [dic objectForKey:@"name"];
        if ( [string isEqualToString:self.m_cityNameLabel.text] ) {
            [CommonUtil addValue:[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]] andKey:kSelectCityId];
            break;
        }
    }

    // 刷新数据
    [self homeRequestSubmit];
    
}

- (void)pullTableViewDidTriggerLoadMore:(PullTableView*)pullTableView {

    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(LoadMoreOver) userInfo:nil repeats:NO];
}

- (void)LoadMoreOver
{
    self.m_tableView.pullLastRefreshDate = [NSDate date];
    self.m_tableView.pullTableIsLoadingMore = NO;
    
}

- (void)menuRequestSubmit{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    NSString *cityId = [CommonUtil getValueByKey:kSelectCityId];
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  memberId,     @"memberId",
                                  key,   @"key",
                                  @"1", @"pageIndex",
                                  @"10",@"pageSize",
                                  cityId, @"CityID",
                                  @"", @"AreaID",
                                  @"", @"DistrictID",
                                  @"", @"ClassID",
                                  [NSString stringWithFormat:@"%f",m_longtitude],@"MapX",
                                  [NSString stringWithFormat:@"%f",m_latitude],@"MapY",
                                  @"",@"keyword",
                                  nil];

    AppHttpClient* httpClient = [AppHttpClient sharedClient];

    [httpClient request:@"GetMerchantCloudMenuList.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];

        if (success) {
            
            NSMutableArray *metchantShop = [json valueForKey:@"MerchantList"];
            
            self.m_menuList = metchantShop;
            
            [self.m_tableView reloadData];

        } else {
           
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
       
    } failure:^(NSError *error) {

        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];

    }];

}

@end
