//
//  SceneryListViewController.m
//  HuiHui
//
//  Created by mac on 15-1-13.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "SceneryListViewController.h"

#import "CommonUtil.h"

#import "SceneryListCell.h"

#import "SceneryDetailViewController.h"

#import "SceneryMapViewController.h"


@interface SceneryListViewController ()

@property (weak, nonatomic) IBOutlet UIButton *m_morenBtn;

@property (weak, nonatomic) IBOutlet UIButton *m_saleBtn;

@property (weak, nonatomic) IBOutlet UIButton *m_goodBtn;

@property (weak, nonatomic) IBOutlet UIButton *m_filterBtn;

@property (weak, nonatomic) IBOutlet UIButton *m_nearbtn;

@property (weak, nonatomic) IBOutlet PullTableView *m_tableView;

@property (weak, nonatomic) UITextField *m_textField;

@property (weak, nonatomic) IBOutlet UIControl *m_control;

@property (weak, nonatomic) IBOutlet UILabel *m_emptyLabel;

@property (weak, nonatomic) IBOutlet UIImageView *m_saleImgV;

@property (weak, nonatomic) IBOutlet UIImageView *m_goodImgV;

@property (weak, nonatomic) IBOutlet UIImageView *m_filterImgV;

// 按钮的选择类别
- (IBAction)btnClicked:(id)sender;

// 点击显示的view后触发的事件-隐藏键盘
- (IBAction)tapDown:(id)sender;

@end

@implementation SceneryListViewController

@synthesize m_sceneryList;

@synthesize m_type;

@synthesize m_imageUrl;

@synthesize m_keyWord;

@synthesize m_levelString;

@synthesize m_priceString;

@synthesize m_countryId;

@synthesize m_cityId;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        m_sceneryList = [[NSMutableArray alloc]initWithCapacity:0];
        
        m_pageIndex = 1;
        
        self.m_cityId = @"";
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    [self setTitle:@"景点列表"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    // 默认为空
    self.m_levelString = @"";
    self.m_priceString = @"";
    self.m_countryId = @"";
    
    
    // 设置导航栏上的搜索框
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 290, 40)];
    view.backgroundColor = [UIColor clearColor];
    
    // 背景图片
    UIImageView *backImgV = [[UIImageView alloc]initWithFrame: CGRectMake(0, 3, 220, 34)];
    backImgV.backgroundColor = [UIColor whiteColor];
    backImgV.layer.borderColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0].CGColor;
    backImgV.layer.borderWidth = 1.0f;
    backImgV.layer.cornerRadius = 10.0f;
    
    [view addSubview:backImgV];
    
    // 搜索的图片
    UIImageView *imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"skin_searchbar_icon.png"]];
    imgView.frame = CGRectMake(5, 13, 12, 14);
    [view addSubview:imgView];
    
    // 搜索框
    UITextField *field = [[UITextField alloc]initWithFrame:CGRectMake(22, 6, 200, 30)];
    field.backgroundColor = [UIColor clearColor];
    field.returnKeyType = UIReturnKeyDone;
    field.font = [UIFont systemFontOfSize:14.0f];
    field.clearButtonMode = UITextFieldViewModeWhileEditing;
    field.placeholder = @"请输入景点名称/城市名";
    field.delegate = self;
    self.m_textField = field;
    
    [view addSubview:field];
    
    // 设置显示地图的按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(222, 0, 60, 40);
    [btn setTitle:@"地图" forState:UIControlStateNormal];
    [btn.titleLabel setTextColor:[UIColor whiteColor]];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
    btn.backgroundColor = [UIColor clearColor];
    [btn addTarget:self action:@selector(mapClicked) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];
    
    self.navigationItem.titleView = view;
    // 设置输入框的返回键
    self.m_textField.returnKeyType = UIReturnKeySearch;
    
    
    // 对输入框内容进行赋值
    self.m_textField.text = [NSString stringWithFormat:@"%@",self.m_keyWord];
    
    // 隐藏view
    self.m_control.backgroundColor = [UIColor clearColor];
//    self.m_control.alpha = 0.5;
    self.m_control.hidden = YES;
    
    // 设置代理
    [self.m_tableView setDelegate:self];
    [self.m_tableView setDataSource:self];
    [self.m_tableView setPullDelegate:self];
    self.m_tableView.pullBackgroundColor = [UIColor whiteColor];
    self.m_tableView.useRefreshView = YES;
    self.m_tableView.useLoadingMoreView = YES;
    
    self.m_emptyLabel.hidden = YES;
    
    // 设置选中的为默认的类型
    [self setmore:YES withSale:NO withGood:NO withNear:NO];
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [self.view endEditing:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)leftClicked{
    
    [self goBack];
}

- (void)mapClicked{
   
    // 进入地图显示的页面
    SceneryMapViewController *VC = [[SceneryMapViewController alloc]initWithNibName:@"SceneryMapViewController" bundle:nil];
    VC.m_aninationList = self.m_sceneryList;
    VC.m_imageUrl = self.m_imageUrl;
    [self.navigationController pushViewController:VC animated:YES];
    
}

- (IBAction)btnClicked:(id)sender {
    
    UIButton *btn = (UIButton *)sender;
    
    if ( btn.tag == 10) {
        
        // 默认的类型
        [self setmore:YES withSale:NO withGood:NO withNear:NO];
        
    }else if ( btn.tag == 11 ){
        
        // 销量的类型
        [self setmore:NO withSale:YES withGood:NO withNear:NO];
        
    }else if ( btn.tag == 12 ){
        
        // 好评的类型
        [self setmore:NO withSale:NO withGood:YES withNear:NO];
        
    }else if ( btn.tag == 13 ){
        
        // 周边的类型
        [self setmore:NO withSale:NO withGood:NO withNear:YES];
        
    }else{
        
        // 筛选的类型 - 进入筛选的页面进行选择
        SceneryFilterViewController *VC = [SceneryFilterViewController shareobject];
        VC.delegate = self;
        [self.navigationController pushViewController:VC animated:YES];

    }

}

- (IBAction)tapDown:(id)sender {
    
    [self.m_textField resignFirstResponder];
    
    // 点击输入框的时候隐藏view
    self.m_control.hidden = YES;
    
}

- (void)setmore:(BOOL)aMoren withSale:(BOOL)aSale withGood:(BOOL)aGood withNear:(BOOL)aNear{
    
    m_pageIndex = 1;
 
    self.m_morenBtn.selected = aMoren;
    self.m_saleBtn.selected = aSale;
    self.m_goodBtn.selected = aGood;
    self.m_nearbtn.selected = aNear;
    
    if ( aMoren ) {
        
        self.m_morenBtn.userInteractionEnabled = NO;
        self.m_saleBtn.userInteractionEnabled = YES;
        self.m_goodBtn.userInteractionEnabled = YES;
        self.m_nearbtn.userInteractionEnabled = YES;

        self.m_filterBtn.userInteractionEnabled = YES;
        
        self.m_type = SceneryMorenType;
        
        // 设置图片
        self.m_saleImgV.image = [UIImage imageNamed:@"icon_hh_down_common.png"];
        self.m_goodImgV.image = [UIImage imageNamed:@"icon_hh_down_common.png"];
                
    }
    
    if ( aSale ) {
        
        self.m_morenBtn.userInteractionEnabled = YES;
        self.m_saleBtn.userInteractionEnabled = NO;
        self.m_goodBtn.userInteractionEnabled = YES;
        self.m_nearbtn.userInteractionEnabled = YES;

        self.m_filterBtn.userInteractionEnabled = YES;
        
        self.m_type = ScenerySaleType;
        
        // 设置图片
        self.m_saleImgV.image = [UIImage imageNamed:@"icon_hh_down_selected.png"];
        self.m_goodImgV.image = [UIImage imageNamed:@"icon_hh_down_common.png"];
        
        
    }
    
    if ( aGood ) {
        
        self.m_morenBtn.userInteractionEnabled = YES;
        self.m_saleBtn.userInteractionEnabled = YES;
        self.m_goodBtn.userInteractionEnabled = NO;
        self.m_nearbtn.userInteractionEnabled = YES;

        self.m_filterBtn.userInteractionEnabled = YES;
        
        self.m_type = SceneryGoodType;
        
        // 设置图片
        self.m_saleImgV.image = [UIImage imageNamed:@"icon_hh_down_common.png"];
        self.m_goodImgV.image = [UIImage imageNamed:@"icon_hh_down_selected.png"];
        
    }
    
    if ( aNear ) {
        
        self.m_morenBtn.userInteractionEnabled = YES;
        self.m_saleBtn.userInteractionEnabled = YES;
        self.m_goodBtn.userInteractionEnabled = YES;
        self.m_nearbtn.userInteractionEnabled = NO;
        
        self.m_filterBtn.userInteractionEnabled = YES;
        
        self.m_type = SceneryJuliType;
        
    }
    
    
    NSLog(@"self.m_type = %i",self.m_type);
    
    // 请求数据
    [self requestSubmit];
    
    
}

#pragma mark - UINetWorking 请求数据
- (void)requestSubmit{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    

    // 根据星级来判断 sortType 的类型 如果星级没有，则sortType为1
    int  sortType = 0;
    
    if ( self.m_levelString.length == 0 ) {
        
        sortType = self.m_type;

    }else{
        
        sortType = SceneryLevelType;

    }
    
    NSLog(@"sortType = %i,%@", sortType,self.m_countryId);
    
    

    NSString *latitude = @"";
    NSString *longtitude = @"";
    NSString *radius = @"";
    NSString *maptype = @"";
    
    // 默认半径为5000以内的数据   cs 1.mapbar、2.百度；不传默认为1
//    if ( sortType == SceneryJuliType ) {
//        
//        // 如果按距离进行搜索的话，则传递经纬度和半径，否则为空
//        latitude = [NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:kSceneryLatitude]];
//        longtitude = [NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:kSceneryLongitude]];
//        radius = @"5000";
//        maptype = @"2";
//        
//    }else{
//        
//        latitude = @"";
//        longtitude = @"";
//        radius = @"";
//        maptype = @"";
//    }
    
    // 当搜索内容为空的时候，判断是来自于什么类型的
    if ( self.m_textField.text.length == 0 ) {
        
        // 1的时候表示是由我的附近点击过来
        if ( [self.m_stringType isEqualToString:@"1"] ) {
            
            // 如果按距离进行搜索的话，则传递经纬度和半径，否则为空
            latitude = [NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:kSceneryLatitude]];
            longtitude = [NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:kSceneryLongitude]];
            radius = @"5000";
            maptype = @"2";
            
        }else{
            
            latitude = @"";
            longtitude = @"";
            radius = @"";
            maptype = @"";
        }

    }else{
        
        // 当搜索结果不为空的时候，将经纬度清空,城市id也清空
        latitude = @"";
        longtitude = @"";
        radius = @"";
        maptype = @"";
        
        self.m_cityId = @"";
    }

    
    // 获取memberId
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    // sortType 1表示景区级别 2 同程推荐  3人气指数 4按距离升序 默认按同程推荐
    AppHttpClient* httpClient = [AppHttpClient scenerySharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"memberId",
                           @"",@"provinceId",
                           [NSString stringWithFormat:@"%@",self.m_cityId],@"cityId",
                           [NSString stringWithFormat:@"%@",self.m_countryId],@"countryId",
                           [NSString stringWithFormat:@"%d",m_pageIndex],@"page",
                           @"20",@"pageSize",
                           [NSString stringWithFormat:@"%i",sortType],@"sortType",
                           [NSString stringWithFormat:@"%@",self.m_textField.text],@"keyword",
                           @"",@"searchFields",
                           [NSString stringWithFormat:@"%@",self.m_levelString],@"gradeId",
                           @"",@"themId",
                           [NSString stringWithFormat:@"%@",self.m_priceString],@"priceRange",
                           maptype,@"cs",
                           longtitude,@"longitude",
                           latitude,@"latitude",
                           radius,@"radius",
                           @"",@"payType",
                           
                           nil];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    NSLog(@"self.m_type = %i",self.m_type);
    
    NSLog(@"parma = %@",param);
    
    [httpClient requestScenery:@"Scenery/GetSceneryList.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        // status 0表示有数据 其他表示错误
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        NSLog(@"json =%@",json);
        
        if ( success ) {
            
            [SVProgressHUD dismiss];
            
            NSMutableArray *sceneryList = [json valueForKey:@"sceneryList"];
            
            if (m_pageIndex == 1) {
                
                if (sceneryList == nil || sceneryList.count == 0) {
                    
                    [self.m_sceneryList removeAllObjects];
                    
                    [self.m_tableView reloadData];

                    self.m_tableView.hidden = YES;
                    
                    self.m_emptyLabel.hidden = NO;
                    
                    // 数组为空的时候显示错误的提示信息
                    NSString *msg = [json valueForKey:@"msg"];

                    self.m_emptyLabel.text = [NSString stringWithFormat:@"%@",msg];
                    
                    return;
                    
                } else {
                    
                    // 对图片进行赋值
                    self.m_imageUrl = [NSString stringWithFormat:@"%@",[json valueForKey:@"imgbaseURL"]];
                    
                    self.m_sceneryList = sceneryList;
                    
                    self.m_emptyLabel.hidden = YES;
                    
                    self.m_tableView.hidden = NO;

                }
            } else {
                
                self.m_emptyLabel.hidden = YES;
                self.m_tableView.hidden = NO;
                
                if (sceneryList == nil || sceneryList.count == 0) {
                   
                    m_pageIndex--;
                
                } else {
                    
                    // 对图片进行赋值
                    self.m_imageUrl = [NSString stringWithFormat:@"%@",[json valueForKey:@"imgbaseURL"]];
                    
                    [self.m_sceneryList addObjectsFromArray:sceneryList];
                }
            }
            
            [self.m_tableView reloadData];
            
        } else {
            
            if (m_pageIndex > 1) {
                m_pageIndex--;
            }
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
        
        self.m_tableView.pullLastRefreshDate = [NSDate date];
        self.m_tableView.pullTableIsRefreshing = NO;
        self.m_tableView.pullTableIsLoadingMore = NO;
        
    } failure:^(NSError *error) {
        if (m_pageIndex > 1) {
            m_pageIndex--;
        }
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        //self.tableView.pullLastRefreshDate = [NSDate date];
        self.m_tableView.pullTableIsRefreshing = NO;
        self.m_tableView.pullTableIsLoadingMore = NO;
    }];
    
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    if ( textField == self.m_textField ) {
        
        [self hiddenNumPadDone:nil];
    }
    
    // 点击输入框的时候显示view
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
    
    m_pageIndex = 1;
    
    // 重新请求数据
    [self requestSubmit];
    
    //    [self searchClicked:nil];
    
    // 进入搜索后的景点列表
//    SceneryListViewController *VC = [[SceneryListViewController alloc]initWithNibName:@"SceneryListViewController" bundle:nil];
//    [self.navigationController pushViewController:VC animated:YES];
    
    return YES;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.m_sceneryList.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"SceneryListCellIdentifier";
    
    SceneryListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"SceneryListCell" owner:self options:nil];
        
        cell = (SceneryListCell *)[nib objectAtIndex:0];
        
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
    }
    
    // 赋值
    if ( self.m_sceneryList.count != 0 ) {
        
        NSDictionary *dic = [self.m_sceneryList objectAtIndex:indexPath.row];
        
        cell.m_title.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"sceneryName"]];
        cell.m_subTitle.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"scenerySummary"]];
        
        // 主题进行赋值
        NSArray *themList = [dic objectForKey:@"themeList"];
        
        NSString *themName = @"";
        
        if ( themList.count != 0 ) {
            
            // 取数组里的第一个值
            NSMutableDictionary *dic = [themList objectAtIndex:0];
            
            themName = [NSString stringWithFormat:@"%@",[dic objectForKey:@"themeName"]];
            
        }
        
        // 赋值
        cell.m_themName.text = [NSString stringWithFormat:@"%@  %@",themName,[dic objectForKey:@"gradeId"]];
        
        cell.m_price.text = [NSString stringWithFormat:@"￥%@",[dic objectForKey:@"adviceAmount"]];
        
        cell.m_orignPrice.text = [NSString stringWithFormat:@"￥%@",[dic objectForKey:@"sceneryAmount"]];
        
        // 图片赋值 图片由两个字符拼接起来
        NSString *imagePath = [NSString stringWithFormat:@"%@%@",self.m_imageUrl,[dic objectForKey:@"imgPath"]];
        
        // 返利赋值
        cell.m_fanli.text = [NSString stringWithFormat:@"返￥%@",[dic objectForKey:@"rebate"]];
        
        // 赋值图片
        [cell setImageView:imagePath];
        
        // 根据搜索的内容来判断
        if ( self.m_textField.text.length == 0 ) {
            
            // 1的时候表示是由我的附近点击过来
            if ( [self.m_stringType isEqualToString:@"1"] ) {
                
                cell.m_distance.hidden = NO;
                // 根据两个经纬度来计算两者之间的距离
                cell.m_distance.text = [self getDistance:[[dic objectForKey:@"lat"] doubleValue] lng2:[[dic objectForKey:@"lon"] doubleValue]];
                
            }else{
                
                cell.m_distance.hidden = YES;
                
            }
        }else{
            
            cell.m_distance.hidden = YES;

        }
      
    }
    
    
    return cell;
    
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 90.0f;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // 保存图片的路径，用于周边景区使用
    [CommonUtil addValue:self.m_imageUrl andKey:SceneryImageUrl];
    
    NSMutableDictionary *dic = [self.m_sceneryList objectAtIndex:indexPath.row];
        
    // 进入景点详情的页面
    SceneryDetailViewController *VC = [[SceneryDetailViewController alloc]initWithNibName:@"SceneryDetailViewController" bundle:nil];
    VC.m_dic = dic;
    [self.navigationController pushViewController:VC animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma mark - PullTableViewDelegate
- (void)pullTableViewDidTriggerRefresh:(PullTableView*)pullTableView {
    m_pageIndex = 1;
    [self performSelector:@selector(requestSubmit) withObject:nil];
}

- (void)pullTableViewDidTriggerLoadMore:(PullTableView*)pullTableView {
    m_pageIndex++;
    [self performSelector:@selector(requestSubmit) withObject:nil];
}

#pragma mark - SceneryFilterDelegate
- (void)filterChoose:(NSMutableDictionary *)aDic{
    
    m_pageIndex = 1;
    
    NSString *level = [NSString stringWithFormat:@"%@",[aDic objectForKey:@"LevelKey"]];
    
    NSString *price = [NSString stringWithFormat:@"%@",[aDic objectForKey:@"PriceKey"]];

    NSString *countryId = [NSString stringWithFormat:@"%@",[aDic objectForKey:@"CountyIdKey"]];
    
    if ( [level isEqualToString:@"不限"] ) {
        if ( [price isEqualToString:@"不限"] ) {
            if ( [countryId isEqualToString:@"不限"] ) {
               
                [self.m_filterBtn.titleLabel setTextColor:[UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1.0]];
                
                self.m_filterImgV.image = [UIImage imageNamed:@"icon_hh_filter_common.png"];
            
            }else{
                
                [self.m_filterBtn.titleLabel setTextColor:RGBACKTAB];
                
                self.m_filterImgV.image = [UIImage imageNamed:@"icon_hh_filter_selected.png"];
                
            }
        }else{
            
            [self.m_filterBtn.titleLabel setTextColor:RGBACKTAB];
            
            self.m_filterImgV.image = [UIImage imageNamed:@"icon_hh_filter_selected.png"];
            
        }
    }else{
        
        
        [self.m_filterBtn.titleLabel setTextColor:RGBACKTAB];
        
        self.m_filterImgV.image = [UIImage imageNamed:@"icon_hh_filter_selected.png"];
        
        
    }
 
    // 判断 如果是A的话则换成数字1，2等 ；如果是1-50的价格则换成0，50
    if ( [level isEqualToString:@"不限"] ) {
        
        self.m_levelString = @"";
        
    }else  if ( [level isEqualToString:@"A"] ) {
        
        self.m_levelString = @"1";
        
    }else  if ( [level isEqualToString:@"AA"] ) {
        
        self.m_levelString = @"2";
        
    }else  if ( [level isEqualToString:@"AAA"] ) {
        
        self.m_levelString = @"3";
        
    }else  if ( [level isEqualToString:@"AAAA"] ) {
        
        self.m_levelString = @"4";
        
    }else  if ( [level isEqualToString:@"AAAAA"] ) {
        
        self.m_levelString = @"5";
        
    }
    

    if ( [price isEqualToString:@"不限"] ) {
        
        self.m_priceString = @"";
        
    }else  if ( [price isEqualToString:@"0-50"] ) {
        
        self.m_priceString = @"0,50";
        
    }else  if ( [price isEqualToString:@"50-100"] ) {
        
        self.m_priceString = @"50,100";
        
    }else  if ( [price isEqualToString:@"100以上"] ) {
        
        self.m_priceString = @"100,";
        
    }
    
    if ( [countryId isEqualToString:@"不限"] ) {
        
        self.m_countryId = @"";
        
    }else{
        
        self.m_countryId = [NSString stringWithFormat:@"%@",countryId];
    }
    
    // 请求数据
    [self requestSubmit];
    
}

#pragma mark - 根据两个经纬度计算两者之间相差的距离
- (NSString*)getDistance:(CGFloat)lat2 lng2:(CGFloat)lng2
{
    
    double lat1 = [[CommonUtil getValueByKey:kSceneryLatitude] doubleValue];
    
    double lng1 = [[CommonUtil getValueByKey:kSceneryLongitude] doubleValue];

    CLLocation *orig = [[CLLocation alloc] initWithLatitude:lat1 longitude:lng1];
    
    CLLocation* dist = [[CLLocation alloc] initWithLatitude:lat2 longitude:lng2];
    
    CLLocationDistance kilometers = [orig distanceFromLocation:dist]/1000;
   
//    NSLog(@"距离:%f",kilometers);
    
    // 如果公里数小于1的话则显示米 单位  否则显示 公里 单位
    if ( kilometers < 1.0 ) {
        
        return [NSString stringWithFormat:@"%.1f米",kilometers * 1000];
        
    }else{
        
        return [NSString stringWithFormat:@"%.1f公里",kilometers];

    }
   
}


@end
