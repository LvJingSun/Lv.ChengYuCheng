//
//  TicketsViewController.m
//  HuiHui
//
//  Created by mac on 15-1-13.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "TicketsViewController.h"

#import "SceneryListViewController.h"

#import "SceneryListCell.h"

#import "SceneryDetailViewController.h"

#import "CommonUtil.h"

#import "SceneryCityHelper.h"

#import "JPinYinUtil.h"

#import "HH_searchCell.h"

@interface TicketsViewController (){

    SceneryCityHelper *dbhelp;

}

@property (weak, nonatomic) IBOutlet UITextField *m_textField;

@property (weak, nonatomic) UIButton *m_cityBtn;

@property (weak, nonatomic) IBOutlet PullTableView *m_tableView;

@property (weak, nonatomic) IBOutlet UIControl *m_control;

@property (weak, nonatomic) IBOutlet UILabel *m_emptyLabel;

@property (weak, nonatomic) IBOutlet UIView *m_tempView;

@property (weak, nonatomic) IBOutlet UILabel *m_diquLabel;

@property (weak, nonatomic) IBOutlet UITableView *m_recordTableView;

@property (strong, nonatomic) IBOutlet UIView *m_footerView;

@property (weak, nonatomic) IBOutlet UILabel *m_tip;

// 清空历史记录
- (IBAction)cleanSearchRecords:(id)sender;

// 附近景点按钮触发的事件
- (IBAction)nearBtnClicked:(id)sender;
// 某个景区按钮触发的事件
- (IBAction)sceneryBtnClicked:(id)sender;

// 搜索时点view隐藏键盘
- (IBAction)tapDown:(id)sender;
// 搜索按钮触发的事件
- (IBAction)searchBtnClicked:(id)sender;

@end

@implementation TicketsViewController

//@synthesize m_BMK_mapView;
//
//@synthesize m_search;

@synthesize m_sceneryList;

@synthesize m_imageUrl;

@synthesize m_cityId;

@synthesize m_cityList;

@synthesize m_allKeys;

@synthesize m_cityListDic;

@synthesize m_allKeys1;

@synthesize m_searchList;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        m_pageIndex = 1;
        
        m_sceneryList = [[NSMutableArray alloc]initWithCapacity:0];
        
        m_cityId = @"";
        
        m_cityList = [[NSMutableArray alloc]initWithCapacity:0];
        
        dbhelp = [[SceneryCityHelper alloc]init];
        
        self.m_cityListDic = [[NSMutableDictionary alloc]initWithCapacity:0];
        
        self.m_allKeys = [[NSMutableArray alloc]initWithCapacity:0];
        
        self.m_allKeys1 = [[NSMutableArray alloc]initWithCapacity:0];
        
        m_searchList = [[NSMutableArray alloc]initWithCapacity:0];

    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setTitle:@"景点门票"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    // 设置tableView的代理
//    [self.m_tableView setDelegate:self];
//    [self.m_tableView setDataSource:self];
//    [self.m_tableView setPullDelegate:self];
//    self.m_tableView.pullBackgroundColor = [UIColor whiteColor];
//    self.m_tableView.useRefreshView = YES;
//    self.m_tableView.useLoadingMoreView= YES;

    // 隐藏view
    self.m_control.backgroundColor = [UIColor clearColor];
    //    self.m_control.alpha = 0.5;
    self.m_control.hidden = YES;
    
    self.m_emptyLabel.hidden = YES;
    
    // 设置导航栏上的搜索框
//    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 290, 40)];
//    view.backgroundColor = [UIColor clearColor];
    
//    // 背景图片
//    UIImageView *backImgV = [[UIImageView alloc]initWithFrame: CGRectMake(0, 3, 220, 34)];
//    backImgV.backgroundColor = [UIColor whiteColor];
//    backImgV.layer.borderColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0].CGColor;
//    backImgV.layer.borderWidth = 1.0f;
//    backImgV.layer.cornerRadius = 10.0f;
//    
//    [view addSubview:backImgV];
//    
//    // 搜索的图片
//    UIImageView *imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"skin_searchbar_icon.png"]];
//    imgView.frame = CGRectMake(5, 13, 12, 14);
//    [view addSubview:imgView];
//    
//    // 搜索框
//    UITextField *field = [[UITextField alloc]initWithFrame:CGRectMake(22, 6, 200, 30)];
//    field.backgroundColor = [UIColor clearColor];
//    field.returnKeyType = UIReturnKeyDone;
//    field.font = [UIFont systemFontOfSize:14.0f];
//    field.clearButtonMode = UITextFieldViewModeWhileEditing;
//    field.placeholder = @"请输入景点名称/城市名";
//    field.delegate = self;
//    self.m_textField = field;
//    
//    [view addSubview:field];
    
    //    // 设置输入框的返回键
    //    self.m_textField.returnKeyType = UIReturnKeySearch;

    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 76, 44)];
    view.backgroundColor = [UIColor clearColor];
    
    UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(68, 17, 8, 8)];
    imgV.image = [UIImage imageNamed:@"baiXia.png"];
    
    // 地区按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 68, 44);
    [btn setTitle:@"" forState:UIControlStateNormal];
    btn.titleLabel.textAlignment = NSTextAlignmentRight;
    [btn.titleLabel setTextColor:[UIColor whiteColor]];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:12.0f]];
    btn.backgroundColor = [UIColor clearColor];
//    [btn addTarget:self action:@selector(cityClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.m_cityBtn = btn;
    
    // 地区点击按钮
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(0, 0, 76, 44);
    [btn1 setTitle:@"" forState:UIControlStateNormal];
    [btn1.titleLabel setTextColor:[UIColor whiteColor]];
    [btn1.titleLabel setFont:[UIFont systemFontOfSize:12.0f]];
    btn1.backgroundColor = [UIColor clearColor];
    [btn1 addTarget:self action:@selector(cityClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [view addSubview:imgV];
    [view addSubview:btn];
    [view addSubview:btn1];
    
    UIBarButtonItem *_barButton = [[UIBarButtonItem alloc] initWithCustomView:view];
    [self.navigationItem setRightBarButtonItem:_barButton];

    
    // =====
    self.m_tempView.backgroundColor = [UIColor whiteColor];
    self.m_tempView.layer.borderColor = [UIColor colorWithRed:209/255.0 green:209/255.0 blue:208/255.0 alpha:1.0].CGColor;
    self.m_tempView.layer.borderWidth = 0.4f;
    
    
    // 根据首页定位的地点来赋值
    self.m_cityName = [NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:kSceneryCityName]];

    // 如果这个字符为空的话则默认显示为苏州
    if ( self.m_cityName.length == 0 || [self.m_cityName isEqualToString:@"(null)"] ) {
        
        self.m_cityName = @"苏州";
        
    }
    
    // 如果经纬度为空的话则默认显示为苏州的经纬度
    NSString *longtitude = [NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:kSceneryLongitude]];
    
    if ( longtitude.length == 0 || [longtitude isEqualToString:@"(null)"]) {
        
        [CommonUtil addValue:@"31.354779" andKey:kSceneryLatitude];
        [CommonUtil addValue:@"120.561860" andKey:kSceneryLongitude];
    }
    
    
    [self.m_cityBtn setTitle:self.m_cityName forState:UIControlStateNormal];
    
    // 请求城市列表的数据
    [self cityRequest];
    
    
    // 从数据库中读取数据
    NSData *saveMenulistData = [CommonUtil getValueByKey:[NSString stringWithFormat:@"ScenerySearchListKey"]];
    
    if (nil == saveMenulistData) {
        
        self.m_searchList = [[NSMutableArray alloc]initWithCapacity:0];
       
    }
    else
    {
         NSMutableArray *arr = (NSMutableArray *)[NSKeyedUnarchiver unarchiveObjectWithData:saveMenulistData];
        
        self.m_searchList = arr;
       
    }
    
    
    // 设置tableView的footerView
    if ( self.m_searchList.count != 0 ) {
        
        self.m_tip.hidden = NO;
        self.m_recordTableView.hidden = NO;
        // 设置tableView的footerView
        self.m_recordTableView.tableFooterView = self.m_footerView;
   
    }else{
        
        self.m_tip.hidden = YES;
        self.m_recordTableView.hidden = YES;

        // 设置tableView的footerView
        self.m_recordTableView.tableFooterView = nil;
        
    }
    
    // 刷新列表
    [self.m_recordTableView reloadData];
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    // 地图
//    [self.m_BMK_mapView viewWillAppear];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [self.m_textField resignFirstResponder];
    
//    [self.m_BMK_mapView viewWillDisappear];
//    
//    self.m_BMK_mapView.delegate = nil; // 不用时，置nil
//    
//    _locService.delegate = nil;
//    
//    self.m_search.delegate = nil;

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)leftClicked{
    
    [self goBack];
}

- (void)cityClicked:(id)sender {
   
    // 点击城市进入城市列表的页面
    SceneryCityListViewController *VC = [[SceneryCityListViewController alloc]initWithNibName:@"SceneryCityListViewController" bundle:nil];
    VC.delegate = self;
    [self.navigationController pushViewController:VC animated:YES];
    
}

- (void)cityRequest{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        self.m_cityList = [NSMutableArray arrayWithArray: [dbhelp sceneryCityList]];
        
        return;
    }
    
    NSDictionary *versions = [dbhelp version];
    
    NSString *cityVer = [versions objectForKey:TYPE_SCENERYCITY];
    if (cityVer == nil) {
        cityVer = @"-1";
        
    }
    
    AppHttpClient* httpClient = [AppHttpClient scenerySharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           cityVer, @"tcCityVersion",
                           nil];
//    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient requestScenery:@"Scenery/GetCityList.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            [SVProgressHUD dismiss];
            
            
            NSArray *versionList = [json valueForKey:@"version"];
            
            if (versionList == nil || [versionList count] == 0) {
                
                self.m_cityList = [NSMutableArray arrayWithArray: [dbhelp sceneryCityList]];
                
                // 根据定位来的城市名称来获取城市的Id
                [self scenerycityId];

                
                return;
            }
            
            int cityVersion = 0;
            
            for (NSDictionary *version in versionList) {
                NSString *type = [version objectForKey:@"VersionType"];
                if ([@"VersionTongChengCity" isEqualToString:type]) {
                    cityVersion = [[version objectForKey:@"VersionNum"] intValue];
                }
                
            }
            if (cityVersion > 0) {
                
                NSArray *cityList = [json valueForKey:@"cityList"];
                
                // 赋值
                [self.m_cityList addObjectsFromArray:cityList];
                
                [dbhelp updateDataFlight:cityList andType:TYPE_SCENERYCITY andVersion:[NSString stringWithFormat:@"%d", cityVersion]];
                
            }
            
            // 根据定位来的城市名称来获取城市的Id
            [self scenerycityId];
      
        } else {
            
            [SVProgressHUD dismiss];

            
        }
    } failure:^(NSError *error) {
        NSLog(@"failed:%@", error);
    }];
    
}

///////////////////////////////////////////////////////////////////////////////
-(void)loadcelldata:(NSArray*)datalist
{
    
    if (datalist == nil) {
        return;
    }
    
    // 先清空数据
    if ( self.m_cityList.count != 0 ) {
        
        [self.m_cityList removeAllObjects];
        
    }
    
    self.m_cityList = [NSMutableArray arrayWithArray:datalist];
    
    [self sortCitys];
    
}

//城市
- (void)loadCityView
{
    //    self.waitview.hidden = NO;
    
    NSArray *citys = [dbhelp sceneryCityList];
    
    [self loadcelldata:citys];
    
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
        [CommonUtil addValue:encodemenulist1 andKey:[NSString stringWithFormat:@"tcHotAndAllKeys"]];
        NSData *encodemenulist = [NSKeyedArchiver archivedDataWithRootObject:self.m_allKeys];
        [CommonUtil addValue:encodemenulist andKey:[NSString stringWithFormat:@"tcHAllKeys"]];
        NSData *encodemenudic = [NSKeyedArchiver archivedDataWithRootObject:self.m_cityListDic];
        [CommonUtil addValue:encodemenudic andKey:[NSString stringWithFormat:@"tcHcity"]];
        
        
    }else{
        
        //        self.MClist_tableview.tableFooterView = nil;
    }
    
}

- (NSString *)firstLetterForCompositeNames:(NSString *)cityString {
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

// 根据城市名称转换成城市的Id
- (void)scenerycityId
{
    for (NSDictionary *dic in self.m_cityList) {
        
        NSString *string = [dic objectForKey:@"Name"];
        
        if ( [string isEqualToString:[NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:kSceneryCityName]]] ) {
            
            // 将城市id存储起来
            [CommonUtil addValue:[NSString stringWithFormat:@"%@",[dic objectForKey:@"cId"]] andKey:SceneryCityId];

            // 临时存放值，用于点击附近时所用与请求参数
            [CommonUtil addValue:[NSString stringWithFormat:@"%@",[dic objectForKey:@"cId"]] andKey:@"sCityId"];

            // 赋值
            self.m_cityId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"cId"]];
            
        }
        
    }
    

}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{

    if ( textField == self.m_textField ) {
        
        [self hiddenNumPadDone:nil];
    }
    
    // 显示view
    self.m_control.hidden = NO;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    // 隐藏view
    self.m_control.hidden = YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
   
    [textField resignFirstResponder];
    
    // 点击输入框的时候隐藏view
    self.m_control.hidden = YES;
    
    // 进入搜索景区的页面
    [self searchBtnClicked:nil];
    
 
    return YES;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if ( self.m_searchList.count != 0 ) {
        
        return self.m_searchList.count;
        
    }else{
        
        return 0;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ( self.m_searchList.count != 0 ) {
        
        static NSString *cellIdentifier = @"HH_searchListCellIdentifier";
        
        HH_searchListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if ( cell == nil ) {
            
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"HH_searchCell" owner:self options:nil];
            
            cell = (HH_searchListCell *)[nib objectAtIndex:1];
            
            cell.selectionStyle = UITableViewCellSelectionStyleGray;
            
        }
        
        if ( self.m_searchList.count != 0 ) {
            
            // 赋值
            cell.m_searchName.text = [NSString stringWithFormat:@"%@",[self.m_searchList objectAtIndex:indexPath.row]];
        }
        
        return cell;

    }else{
        
        return nil;
    }
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ( self.m_searchList.count != 0 ) {
        
        return 44.0f;
        
    }else{
        
        return 0.0f;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    // 进入搜索后的景点列表
    SceneryListViewController *VC = [[SceneryListViewController alloc]initWithNibName:@"SceneryListViewController" bundle:nil];
    VC.m_keyWord = [NSString stringWithFormat:@"%@",[self.m_searchList objectAtIndex:indexPath.row]];
    VC.m_stringType = @"";
    VC.m_cityId = @"";
    [self.navigationController pushViewController:VC animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma mark - SceneryCityDelegate
- (void)getSceneryCityName:(NSMutableDictionary *)aCityname{
    
    m_pageIndex = 1;
    
    self.m_cityName = [NSString stringWithFormat:@"%@",[aCityname objectForKey:@"Name"]];
    
    [self.m_cityBtn setTitle:self.m_cityName forState:UIControlStateNormal];
    
    self.m_cityId = [NSString stringWithFormat:@"%@",[aCityname objectForKey:@"cId"]];
    
    // label赋值
    self.m_diquLabel.text = [NSString stringWithFormat:@"%@景区",self.m_cityName];
    
    // 将城市的cityId保存起来用于景区列表行政区列表请求数据
    [CommonUtil addValue:self.m_cityId andKey:SceneryCityId];
    
}

- (IBAction)tapDown:(id)sender {
    
    [self.m_textField resignFirstResponder];
    
    // 点击输入框的时候隐藏view
    self.m_control.hidden = YES;
}


#pragma mark - BtnClicked
- (IBAction)searchBtnClicked:(id)sender {
    
    [self.m_textField resignFirstResponder];
    
    if ( self.m_textField.text.length != 0 ) {
        // 将搜索的数据进行保存
        
        [self getSearching:self.m_textField.text];
        
    }
    
    // 进入搜索后的景点列表
    SceneryListViewController *VC = [[SceneryListViewController alloc]initWithNibName:@"SceneryListViewController" bundle:nil];
    VC.m_keyWord = [NSString stringWithFormat:@"%@",self.m_textField.text];
    VC.m_stringType = @"";
    VC.m_cityId = @"";
    [self.navigationController pushViewController:VC animated:YES];
    
}

// 将数据保存到数组里面，然后进入下一级搜索的商品列表页面
- (void)getSearching:(NSString *)aString{
    
    // 将搜索的内容添加到数组里-先判断数组里是否已经存在这个搜索的关键字,如果不存在的话则直接添加进来，否则不添加
    if ( ![self.m_searchList containsObject:aString] ) {
        
        // 判断数组是否有值
        if ( self.m_searchList.count == 0 ) {
            
            [self.m_searchList addObject:aString];
            
        }else{
            
            [self.m_searchList insertObject:aString atIndex:0];
            
        }
        
        // 对数据进行存储
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.m_searchList];
        [CommonUtil addValue:data andKey:[NSString stringWithFormat:@"ScenerySearchListKey"]];
        
        
        // 刷新列表
        [self.m_recordTableView reloadData];
        
    }
    
    if ( self.m_searchList.count != 0 ) {
        
        self.m_recordTableView.hidden = NO;
        self.m_tip.hidden = NO;
        // 设置tableView的footerView
        self.m_recordTableView.tableFooterView = self.m_footerView;
        
    }else{
        
        self.m_recordTableView.hidden = YES;
        self.m_tip.hidden = YES;
        
        // 设置tableView的footerView
        self.m_recordTableView.tableFooterView = nil;
        
    }
  
}


- (IBAction)nearBtnClicked:(id)sender {
    
    // 根据当前的经纬度去请求数据
    SceneryListViewController *VC = [[SceneryListViewController alloc]initWithNibName:@"SceneryListViewController" bundle:nil];
    VC.m_keyWord = @"";
    VC.m_stringType = @"1";
    VC.m_cityId = [NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:@"sCityId"]];
    [self.navigationController pushViewController:VC animated:YES];

}

- (IBAction)sceneryBtnClicked:(id)sender {
    
    // 当前城市的景区页面进行搜索
    SceneryListViewController *VC = [[SceneryListViewController alloc]initWithNibName:@"SceneryListViewController" bundle:nil];
    VC.m_keyWord = @"";
    VC.m_cityId = [NSString stringWithFormat:@"%@",self.m_cityId];
    VC.m_stringType = @"";
    [self.navigationController pushViewController:VC animated:YES];
    
}

- (IBAction)cleanSearchRecords:(id)sender {
    
    [self.m_textField resignFirstResponder];
    
    // 从数据库中读取数据
//    NSData *saveMenulistData = [CommonUtil getValueByKey:[NSString stringWithFormat:@"ScenerySearchListKey"]];
    
    
    if ( self.m_searchList.count != 0 ) {
        
        [self.m_searchList removeAllObjects];
        
        // 对数据进行存储
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.m_searchList];
        [CommonUtil addValue:data andKey:[NSString stringWithFormat:@"ScenerySearchListKey"]];
        
        // 刷新列表
        [self.m_recordTableView reloadData];
        
        self.m_recordTableView.hidden = YES;
        self.m_tip.hidden = YES;
        
        // 设置tableView的footerView
        self.m_recordTableView.tableFooterView = nil;
        // 清空搜索框里的内容
        self.m_textField.text = @"";
        
    }
    
}

@end
