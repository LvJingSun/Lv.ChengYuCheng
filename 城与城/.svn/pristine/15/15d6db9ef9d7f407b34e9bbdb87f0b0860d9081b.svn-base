//
//  QuanquanListViewController.m
//  HuiHui
//
//  Created by mac on 15-3-18.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "QuanquanListViewController.h"
#import "LocationCell.h"
#import "CommonUtil.h"
#import "SVProgressHUD.h"
#import "AppHttpClient.h"
#import "UIImageView+AFNetworking.h"
#import "HHQuanDetailViewController.h"
#import "HHCouponCell.h"
#import "MyquanquanViewController.h"
#import "YKAddShopCartAnimationView.h"
#import "CouponWebViewController.h"

#define degreesToRadian(x) (M_PI * (x) / 180.0)

@interface QuanquanListViewController ()

@property (weak, nonatomic) IBOutlet PullTableView *m_tableView;

@property (weak, nonatomic) IBOutlet UILabel *m_emptyLabel;

//产品
@property (weak, nonatomic) IBOutlet UIButton   *m_fenleiBtn;//分类
@property (weak, nonatomic) IBOutlet UIButton   *m_diquBtn;//地区
@property (weak, nonatomic) IBOutlet UIButton   *m_paixuBtn;//排序
@property (weak, nonatomic) IBOutlet UIView     *m_alphaView;//透明层

// 标记显示标题的label
@property (nonatomic, strong) UILabel           *m_titleLabel;

@property (nonatomic, strong) UIImageView       *m_imageView;

@property (weak, nonatomic) IBOutlet UIImageView *m_imageV1;

@property (weak, nonatomic) IBOutlet UIImageView *m_imageV2;

@property (weak, nonatomic) IBOutlet UIImageView *m_imageV3;

@property (weak, nonatomic) IBOutlet UIImageView *m_imageV4;

// 点击背景触发的事件
//- (IBAction)controlTap:(id)sender;

- (IBAction)alphaviewtap:(id)sender;

// 按钮点击触发的事件
- (IBAction)btnClicked:(id)sender;

@end

@implementation QuanquanListViewController

@synthesize m_array;

@synthesize m_productList;

@synthesize keyItems;

@synthesize m_list;

@synthesize TwoID;

@synthesize m_titleLabel;

@synthesize m_keyDic;

@synthesize m_imgV;

@synthesize m_couponList;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        m_array = [[NSMutableArray alloc]initWithCapacity:0];
        m_pageIndex = 1;
        m_productList = [[NSMutableArray alloc]initWithCapacity:0];
        keyItems = [[NSMutableArray alloc]initWithCapacity:0];
        imageCache = [[ImageCache alloc] init];
        //产品
        self.LeftArray = [[NSMutableArray alloc]initWithCapacity:0];
        self.MiddleArray = [[NSMutableArray alloc]initWithCapacity:0];
        self.LeftArray2 = [[NSMutableArray alloc]initWithCapacity:0];
        self.MiddleArray2 = [[NSMutableArray alloc]initWithCapacity:0];
        self.RightArray = [[NSMutableArray alloc]initWithCapacity:0];
        self.LeftArrayID = [[NSMutableArray alloc]initWithCapacity:0];
        self.MiddleArrayID = [[NSMutableArray alloc]initWithCapacity:0];
        self.LeftArrayID2 = [[NSMutableArray alloc]initWithCapacity:0];
        self.MiddleArrayID2 = [[NSMutableArray alloc]initWithCapacity:0];
        
        m_keyDic = [[NSMutableDictionary alloc]initWithCapacity:0];
        
        m_couponList = [[NSMutableArray alloc]initWithCapacity:0];

        
        [self.RightArray addObject:@"默认排序"];
//        [self.RightArray addObject:@"销量最多"];
//        [self.RightArray addObject:@"价格最高"];
//        [self.RightArray addObject:@"价格最低"];
        [self.RightArray addObject:@"离我最近"];
        
//        m_keyDic = [[NSMutableDictionary alloc]initWithCapacity:0];
        
        
        m_list = [[NSMutableArray alloc]initWithCapacity:0];
        
        dbhelp = [[DBHelper alloc] init];
        
        
        m_indexSection = 0;
        
        m_indexRow = 0;
        
        
        isFirstRequest = YES;
        
        
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSString *titleString = [CommonUtil getValueByKey:kSelectCityName];
    
    // 如果值为空的话默认为“苏州”
    if ( [titleString isEqualToString:@"(null)"] ) {
        
        titleString = @"苏州";
    }
    
    [self setTitle:[NSString stringWithFormat:@"%@券券",titleString]];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    [self setRightButtonWithTitle:@"我的券券" action:@selector(myCouponClicked)];
    
    
    // 默认为默认排序
    self.m_latiString = @"";
    self.m_longtiString = @"";
    
    
    // 请求网络的两参数
    self.m_order = @"desc";
    self.m_sort = @"";
    
    // 判断经纬度
    self.m_string = @"1";
    
    //    self.m_backView.backgroundColor = [UIColor clearColor];
    
    // 设置导航栏的右按钮
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 250, 40)];
    view.backgroundColor = [UIColor clearColor];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(35, 0, 170, 40)];
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:18.0f];
    label.textAlignment = NSTextAlignmentCenter;
    
    label.text = [NSString stringWithFormat:@"%@券券",titleString];
    
    self.m_titleLabel = label;
    
    
    UIImageView *imgV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"baiXia.png"]];
    
    // 根据标题的内容来设置箭头的坐标位置
    NSString *string = [NSString stringWithFormat:@"%@",label.text];
    
    if ( string.length <= 5 ) {
    
        imgV.frame = CGRectMake(165, 13, 16, 16);

    }else{
        
        imgV.frame = CGRectMake(185, 13, 16, 16);

    }
    
    imgV.backgroundColor = [UIColor clearColor];
    
    
    self.m_imageView = imgV;
    
    [view  addSubview:imgV];
    
    
    [view addSubview:label];
    
    // 点击按钮
    UIButton *seachBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    seachBtn.frame = CGRectMake(35, 0, 170, 40);
    seachBtn.backgroundColor = [UIColor clearColor];
    [seachBtn addTarget:self action:@selector(citylistClicked) forControlEvents:UIControlEventTouchUpInside];
    
    [view addSubview:seachBtn];
    
    self.navigationItem.titleView = view;
    
    
    [self.m_tableView setDelegate:self];
    [self.m_tableView setDataSource:self];
    [self.m_tableView setPullDelegate:self];
    self.m_tableView.pullBackgroundColor = [UIColor whiteColor];
    self.m_tableView.useRefreshView = YES;
    self.m_tableView.useLoadingMoreView = YES;
    self.m_tableView.hidden = YES;
    
    self.m_emptyLabel.hidden = YES;
    
    //默认不下拉
    leftOpened = middleOpened = leftOpened2 = middleOpened2 = rightOpened = NO;
    self.m_alphaView.alpha = 0;
    
    
    // 经纬度 ======
//    NSString *latitudeString = [CommonUtil getValueByKey:kLatitudeKey];
//    NSString *lontiduteString = [CommonUtil getValueByKey:kLongitudeKey];
    
    NSString *cityId = [CommonUtil getValueByKey:kSelectCityId];
    
//    self.m_latiString = [NSString stringWithFormat:@"%f",[latitudeString floatValue]];
//    self.m_longtiString = [NSString stringWithFormat:@"%f",[lontiduteString floatValue]];
    
    selectCity = cityId;
    
    
    
    //分类
    [self loadCategoryView];//加载一级类别
    [self FenleiDataTotableview1];//一级赋值
    
    //排序
    [self PaixuDataTotableview];//排序赋值
    
    // 赋值
    [self.m_fenleiBtn setTitle:@"全部分类" forState:UIControlStateNormal];
    
    [self.m_paixuBtn setTitle:@"默认排序" forState:UIControlStateNormal];
    
    [self.m_diquBtn setTitle:@"全城" forState:UIControlStateNormal];

    
    [self.m_fenleiBtn addTarget:self action:@selector(LeftOpenBtn) forControlEvents:UIControlEventTouchUpInside];
    
    [self.m_diquBtn addTarget:self action:@selector(LeftOpenBtn2) forControlEvents:UIControlEventTouchUpInside];
    
    [self.m_paixuBtn addTarget:self action:@selector(RightOpenBtn) forControlEvents:UIControlEventTouchUpInside];
    
    //地区
    [self citySelectarea];//加载一级类别
    [self DiquDataTotableview1];//一级赋值
    [self.MiddleTableview2 reloadData];
    
    // 请求商品列表的接口
    [self vourcherRequestSubmit];
    
    
    // 设置图片
    self.m_imageV1.layer.cornerRadius = 30.0;
    self.m_imageV2.layer.cornerRadius = 30.0;
    self.m_imageV3.layer.cornerRadius = 30.0;
    self.m_imageV4.layer.cornerRadius = 30.0;
    
    self.m_imageV1.layer.masksToBounds = YES;
    self.m_imageV2.layer.masksToBounds = YES;
    self.m_imageV3.layer.masksToBounds = YES;
    self.m_imageV4.layer.masksToBounds = YES;


    // 请求数据
    [self couponRequestSubmit];
    
}

- (void)couponRequestSubmit{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    // 获取memberId
//    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
//    NSString *key = [CommonUtil getServerKey];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];

//    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
//                           memberId,@"memberId",
//                           key,@"key",
//                           
//                           nil];
    
//    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    [httpClient request:@"AppHashData.ashx" parameters:nil success:^(NSJSONSerialization* json) {
        
        // status 0表示有数据 其他表示错误
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if ( success ) {
            
            [SVProgressHUD dismiss];
            
            // 收藏成功后提示
//            NSString *msg = [json valueForKey:@"msg"];
//            [SVProgressHUD showSuccessWithStatus:msg];
            
            if ( self.m_couponList.count != 0 ) {
                
                [self.m_couponList removeAllObjects];
                
                
            }
            
            
            self.m_couponList = [json valueForKey:@"HashDataConfgList"];
            
            // 赋值
            if ( self.m_couponList.count != 0 ) {
                
                NSDictionary *dic1 = [self.m_couponList objectAtIndex:0];
                NSDictionary *dic2 = [self.m_couponList objectAtIndex:1];
                NSDictionary *dic3 = [self.m_couponList objectAtIndex:2];
                NSDictionary *dic4 = [self.m_couponList objectAtIndex:3];
                
                NSString *path1 = [NSString stringWithFormat:@"%@",[dic1 objectForKey:@"IconUrl180"]];
                NSString *path2 = [NSString stringWithFormat:@"%@",[dic2 objectForKey:@"IconUrl180"]];
                NSString *path3 = [NSString stringWithFormat:@"%@",[dic3 objectForKey:@"IconUrl180"]];
                NSString *path4 = [NSString stringWithFormat:@"%@",[dic4 objectForKey:@"IconUrl180"]];
                
                // 赋值
                [self.m_imageV1 setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:path1]]
                                      placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"]
                                               success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                                                   
                                                   self.m_imageV1.image = image;//[CommonUtil scaleImage:image toSize:CGSizeMake(60, 60)];
                                                   
                                               }
                                               failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                                                   
                                               }];
                
                [self.m_imageV2 setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:path2]]
                                      placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"]
                                               success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                                                   
                                                   self.m_imageV2.image = image;//[CommonUtil scaleImage:image toSize:CGSizeMake(60, 60)];
                                                   
                                               }
                                               failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                                                   
                                               }];
                
                
                [self.m_imageV3 setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:path3]]
                                      placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"]
                                               success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                                                   
                                                   self.m_imageV3.image = image;//[CommonUtil scaleImage:image toSize:CGSizeMake(60, 60)];
                                                   
                                               }
                                               failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                                                   
                                               }];
                
                
                [self.m_imageV4 setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:path4]]
                                      placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"]
                                               success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                                                   
                                                   self.m_imageV4.image = image;//[CommonUtil scaleImage:image toSize:CGSizeMake(60, 60)];
                                                   
                                               }
                                               failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                                                   
                                               }];

                
            }
          
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
        
    } failure:^(NSError *error) {
        
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];

}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self hideTabBar:YES];
    
    
    leftOpened = NO;
    middleOpened = NO;
    leftOpened2 = NO;
    middleOpened2 = NO;
    rightOpened = NO;
    
    self.LeftTableview.hidden = YES;
    self.MiddleTableview.hidden = YES;
    self.LeftTableview2.hidden = YES;
    self.MiddleTableview2.hidden = YES;
    self.RightTableview.hidden = YES;
    
    CGRect frame = self.LeftTableview.frame;
    frame = CGRectMake(0, 110, WindowSizeWidth/2, 0);
    [self.LeftTableview setFrame:frame];
    
    CGRect frame1 = self.MiddleTableview.frame;
    frame1 = CGRectMake(WindowSizeWidth/2, 110, WindowSizeWidth/2, 0);
    
    [self.MiddleTableview setFrame:frame1];
    
    CGRect frame2 = self.LeftTableview2.frame;
    frame2 = CGRectMake(0, 110, WindowSizeWidth/2, 0);
    
    [self.LeftTableview2 setFrame:frame2];
    
    CGRect frame3 = self.MiddleTableview2.frame;
    frame3 = CGRectMake(WindowSizeWidth/2, 110, WindowSizeWidth/2, 0);
    
    [self.MiddleTableview2 setFrame:frame3];
    
    CGRect frame4 = self.RightTableview.frame;
    frame4 = CGRectMake(0, 110, WindowSizeWidth, 0);
    
    [self.RightTableview setFrame:frame4];
    
    self.m_alphaView.alpha = 0;
    
    // 根据值来判断是否要重新请求数据来刷新列表
    NSString *favorite = [NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:@"IsFavorite"]];
    
    // favorite等于1，则表示在我的券券-我收藏的列表里面进行取消收藏成功的操作
    if ( [favorite isEqualToString:@"1"] ) {
        
        // 重新赋值
        [CommonUtil addValue:@"0" andKey:@"IsFavorite"];
        
        // 请求数据
        [self vourcherRequestSubmit];
        
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [self hideTabBar:NO];
    
    self.LeftTableview.hidden = YES;
    self.MiddleTableview.hidden = YES;
    self.LeftTableview2.hidden = YES;
    self.MiddleTableview2.hidden = YES;
    self.RightTableview.hidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)leftClicked{
    
    [self goBack];
    
}

- (void)myCouponClicked{
    // 进入我的券券
    MyquanquanViewController *VC = [[MyquanquanViewController alloc]initWithNibName:@"MyquanquanViewController" bundle:nil];
    [self.navigationController pushViewController:VC animated:YES];
        
}

- (void)citylistClicked{
    // 进入城市列表
    HH_cityListViewController *VC = [[HH_cityListViewController alloc]initWithNibName:@"HH_cityListViewController" bundle:nil];
    VC.m_typeString = @"2";
    VC.delegate = self;
    [self.navigationController pushViewController:VC animated:YES];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return self.m_productList.count;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSDictionary *dic = [self.m_productList objectAtIndex:section];
    
    NSMutableArray *vouList = [dic objectForKey:@"MctVouList"];
    
    NSString *moreString = [NSString stringWithFormat:@"%@",[self.m_keyDic objectForKey:[NSString stringWithFormat:@"%i",section]]];
    
    
    if ( [moreString isEqualToString:@"0"] ) {
        
        if ( vouList.count > 2 ) {
            
            return 3;
            
        }else{
        
            return vouList.count;
            
        }
    }else{
        
        return vouList.count;

    }
 
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = nil;
    
    NSString *moreString = [NSString stringWithFormat:@"%@",[self.m_keyDic objectForKey:[NSString stringWithFormat:@"%i",indexPath.section]]];
    
    NSDictionary *dic = [self.m_productList objectAtIndex:indexPath.section];
    
    NSMutableArray *arr = [dic objectForKey:@"MctVouList"];
    
    if ( [moreString isEqualToString:@"0"] ) {
        
        if ( arr.count > 2 ) {
            
            if ( indexPath.row <= 1 ) {
                
                cell = [self quanqunaTableView:tableView cellForRowAtIndexPath:indexPath];
                
                return cell;
                
            }else{
                
                cell = [self moreTableView:tableView cellForRowAtIndexPath:indexPath];
                
                return cell;
                
            }
            
        }else{
            
            cell = [self quanqunaTableView:tableView cellForRowAtIndexPath:indexPath];
            
            return cell;
            
        }
        
    }else{
        
        cell = [self quanqunaTableView:tableView cellForRowAtIndexPath:indexPath];
        
        return cell;
        
    }
    
}


- (UITableViewCell *)quanqunaTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"HHQuanquanListCellIdentifier";
    
    HHQuanquanListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"HHCouponCell" owner:self options:nil];
        
        cell = (HHQuanquanListCell *)[nib objectAtIndex:2];
        
        //        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.m_view.layer.cornerRadius = 5.0f;
        cell.m_view.layer.masksToBounds = YES;
        
        cell.m_view.layer.borderWidth = 0.5f;
        cell.m_view.layer.borderColor = [UIColor lightGrayColor].CGColor;
        
        cell.m_imagV.layer.cornerRadius = 30.0f;
        cell.m_imagV.layer.masksToBounds = YES;
        
//        cell.m_btn.layer.cornerRadius = 25.0f;
//        cell.m_btn.layer.masksToBounds = YES;
//        cell.m_btn.backgroundColor = [UIColor blackColor];
//        cell.m_btn.alpha = 0.6;
        
        
        cell.m_view.frame = CGRectMake(cell.m_view.frame.origin.x, cell.m_view.frame.origin.y, WindowSizeWidth - 10, cell.m_view.frame.size.height);
        
    }
    
    // 赋值
    if ( self.m_productList.count != 0 ) {
        
        NSDictionary *l_dic = [self.m_productList objectAtIndex:indexPath.section];
        
        NSMutableArray *arr = [l_dic objectForKey:@"MctVouList"];
        
        NSDictionary *dic = [arr objectAtIndex:indexPath.row];
        
        cell.m_title.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Title"]];
        cell.m_time.text = [NSString stringWithFormat:@"截止日期:%@",[dic objectForKey:@"MaxDateTime"]];
        cell.m_mctName.text = [NSString stringWithFormat:@"可用份数:%@",[dic objectForKey:@"AllowGetAmount"]];
        
        [cell setImagePath:[NSString stringWithFormat:@"%@",[l_dic objectForKey:@"LogoMidUrl"]]];
        
        
        // 添加收藏按钮的触发事件
        cell.m_btn.hidden = NO;
        cell.m_btn.tag = indexPath.row;
        
        // 设置记录值
        m_indexSection = indexPath.section;
        
        // 判断是否收藏  IsFav  0 表示未收藏 1表示已收藏
        NSString *isFav = [NSString stringWithFormat:@"%@",[dic objectForKey:@"IsFav"]];
        
        
        
        if ( [isFav isEqualToString:@"1"] ) {
            
            // 已收藏
            [cell.m_btn setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
            
//            [cell.m_btn setTitle:@"已领取" forState:UIControlStateNormal];
            
            [cell.m_btn removeTarget:self action:@selector(favoriteClicked:) forControlEvents:UIControlEventTouchUpInside];
            
            [cell.m_btn addTarget:self action:@selector(cancelFavClicked:) forControlEvents:UIControlEventTouchUpInside];

            
        }else{
            
            // 未收藏
            [cell.m_btn setImage:[UIImage imageNamed:@"favorite_no.png"] forState:UIControlStateNormal];

//            [cell.m_btn setTitle:@"领取" forState:UIControlStateNormal];

            [cell.m_btn removeTarget:self action:@selector(cancelFavClicked:) forControlEvents:UIControlEventTouchUpInside];
            
            [cell.m_btn addTarget:self action:@selector(favoriteClicked:) forControlEvents:UIControlEventTouchUpInside];

            
        }
        
    }
    
    return cell;
    
    
}

- (UITableViewCell *)moreTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"QuanquanMoreCellIdentifier";
    
    QuanquanMoreCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"HHCouponCell" owner:self options:nil];
        
        cell = (QuanquanMoreCell *)[nib objectAtIndex:3];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    
    return cell;

}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
  
    NSDictionary *dic = [self.m_productList objectAtIndex:indexPath.section];
    
    NSMutableArray *vouList = [dic objectForKey:@"MctVouList"];
    
    NSString *moreString = [NSString stringWithFormat:@"%@",[self.m_keyDic objectForKey:[NSString stringWithFormat:@"%i",indexPath.section]]];
    
    if ( [moreString isEqualToString:@"0"] ) {
        
        if ( vouList.count > 2 ) {
            
            if ( indexPath.row <= 1 ) {
                
                return 110.0f;

            }else{
                
                return 44.0f;

            }
            
        }else{
            
            return 110.0f;

        }
        
    }else{
        
        return 110.0f;
        
    }
    
}

//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 0.000001;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 30.0f;
    
}

#pragma mark - UITableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView* l_View = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WindowSizeWidth, 30)];
    l_View.backgroundColor = [UIColor colorWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:1.0];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, WindowSizeWidth, 22)];
    titleLabel.textColor = RGBACKTAB; //[UIColor blackColor];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.font = [UIFont systemFontOfSize:12.0];
    titleLabel.backgroundColor = [UIColor clearColor];
    
    // 赋值-标题
    NSDictionary *dic = [self.m_productList objectAtIndex:section];
    
    titleLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"MctShopName"]];
    
    // 分割线
    UIImageView *lineImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 29, WindowSizeWidth, 1)];
    lineImg.backgroundColor = [UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1.0];
    [l_View addSubview:lineImg];
    [l_View addSubview:titleLabel];
    
    return l_View;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *moreString = [NSString stringWithFormat:@"%@",[self.m_keyDic objectForKey:[NSString stringWithFormat:@"%i",indexPath.section]]];
    
    NSDictionary *dic = [self.m_productList objectAtIndex:indexPath.section];
    
    NSMutableArray *arr = [dic objectForKey:@"MctVouList"];
    
    NSDictionary *l_dic = [arr objectAtIndex:indexPath.row];
    
    if ( [moreString isEqualToString:@"0"] ) {
        
        if ( arr.count > 2 ) {
            
            if ( indexPath.row <= 1 ) {
                
                // 进入券券详情的页面
                HHQuanDetailViewController *VC = [[HHQuanDetailViewController alloc]initWithNibName:@"HHQuanDetailViewController" bundle:nil];
                VC.m_counponId = [NSString stringWithFormat:@"%@",[l_dic objectForKey:@"VouchersID"]];
                VC.m_typeString = @"1";
                [self.navigationController pushViewController:VC animated:YES];
                
            }else{
                
                // 点击后将数据重新赋值
                [self.m_keyDic setObject:@"1" forKey:[NSString stringWithFormat:@"%i",indexPath.section]];
                
                [self.m_tableView reloadData];
                
            }
            
        }else{
            
            // 进入券券详情的页面
            HHQuanDetailViewController *VC = [[HHQuanDetailViewController alloc]initWithNibName:@"HHQuanDetailViewController" bundle:nil];
            VC.m_counponId = [NSString stringWithFormat:@"%@",[l_dic objectForKey:@"VouchersID"]];
            VC.m_typeString = @"1";
            [self.navigationController pushViewController:VC animated:YES];
            
        }
        
    }else{
        
        // 进入券券详情的页面
        HHQuanDetailViewController *VC = [[HHQuanDetailViewController alloc]initWithNibName:@"HHQuanDetailViewController" bundle:nil];
        VC.m_counponId = [NSString stringWithFormat:@"%@",[l_dic objectForKey:@"VouchersID"]];
        VC.m_typeString = @"1";
        [self.navigationController pushViewController:VC animated:YES];
        
    }
   
}

- (void)favoriteClicked:(id)sender{
    
    UIButton *btn = (UIButton *)sender;
    
    m_indexRow = btn.tag;
    
    // 计算tableview的某个区
    NSInteger index = 0;
    index = [self.m_tableView indexPathForCell:((HHQuanquanListCell*)[[[sender superview]superview]superview])].section; //这个方便一点点，不用设置tag。
    
    // 获取voucherId
    NSDictionary *l_dic = [self.m_productList objectAtIndex:index];
    
    NSMutableArray *arr = [l_dic objectForKey:@"MctVouList"];
    
    NSDictionary *dic = [arr objectAtIndex:btn.tag];
    
    NSString *voucherId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"VouchersID"]];
    
    // 商户logo赋值
    NSString *imagString = [NSString stringWithFormat:@"%@",[l_dic objectForKey:@"LogoMidUrl"]];
    
    [self.m_imgV setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:imagString]]
                     placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"]
                              success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                                  
                                  self.m_imgV.image = [CommonUtil scaleImage:image toSize:CGSizeMake(60, 60)];
                                  self.m_imgV.contentMode = UIViewContentModeScaleAspectFit;
                                 
                              }
                              failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                                  
                              }];
    
    // 请求添加收藏的接口
    [self favoriteRequest:voucherId];
    
//    [self ReceiveRequest:voucherId];
    
}

- (void)cancelFavClicked:(id)sender{
    
    UIButton *btn = (UIButton *)sender;
    
    m_indexRow = btn.tag;
    
    // 计算tableview的某个区
    m_indexSection = [self.m_tableView indexPathForCell:((HHQuanquanListCell*)[[[sender superview]superview]superview])].section; //这个方便一点点，不用设置tag。
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示"
                                                       message:@"您确定取消收藏？"
                                                      delegate:self
                                             cancelButtonTitle:@"取消"
                                             otherButtonTitles:@"确定", nil];
    alertView.tag = 10236;
    
    [alertView show];

}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if ( alertView.tag == 10236 ) {
        
        if ( buttonIndex == 1 ) {
            
            // 获取voucherId
            NSDictionary *l_dic = [self.m_productList objectAtIndex:m_indexSection];
            
            NSMutableArray *arr = [l_dic objectForKey:@"MctVouList"];
            
            NSDictionary *dic = [arr objectAtIndex:m_indexRow];
            
            NSString *voucherId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"VouchersID"]];
            
            // 确定取消收藏请求网络
            [self CancelFavoriteRequest:voucherId];
            
        }
    }
    
}

- (void)ReceiveRequest:(NSString *)aVoucherId{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    // 获取memberId
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    // type 1表示添加收藏  2表示取消收藏
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"memberId",
                           key,@"key",
                           aVoucherId,@"voucherId",
                           nil];
    
    NSLog(@"params = %@",param);
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    [httpClient request:@"GetVoucher.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        // status 0表示有数据 其他表示错误
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if ( success ) {
            
            NSLog(@"json= %@",json);
            
            // 收藏成功后提示
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showSuccessWithStatus:msg];
            
            // 请求数据重新刷新
            [self vourcherRequestSubmit];
            
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
        
    } failure:^(NSError *error) {
        
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}

- (void)CancelFavoriteRequest:(NSString *)aVoucherId{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    // 获取memberId
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    // type 1表示添加收藏  2表示取消收藏
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"memberId",
                           key,@"key",
                           aVoucherId,@"voucherId",
                           @"2",@"option",
                           
                           nil];
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    [httpClient request:@"VoucherFav.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        // status 0表示有数据 其他表示错误
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if ( success ) {
            
            // 收藏成功后提示
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showSuccessWithStatus:msg];
            
            // 请求数据重新刷新
            [self vourcherRequestSubmit];
            
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
        
    } failure:^(NSError *error) {
        
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}


- (void)favoriteRequest:(NSString *)aVoucherId{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    // 获取memberId
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    // type 1表示添加收藏  2表示取消收藏
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"memberId",
                           key,@"key",
                           aVoucherId,@"voucherId",
                           @"1",@"option",
                           
                           nil];
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    [httpClient request:@"VoucherFav.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        // status 0表示有数据 其他表示错误
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if ( success ) {
            
            // 设置添加收藏后的动画
            CGRect rectInTableView = [self.m_tableView rectForRowAtIndexPath:[NSIndexPath indexPathForRow:m_indexRow inSection:m_indexSection]];
            
            CGRect rect = [self.m_tableView convertRect:rectInTableView toView:[self.m_tableView superview]];
            
            YKAddShopCartAnimationView* animationView = [YKAddShopCartAnimationView animationViewWithStartPoint:CGPointMake(120, rect.origin.y) WithEndPoint:CGPointMake(155, 15) withAnimationImage:[UIImage imageNamed:@"hh_icon_love.png"]];

            
//            YKAddShopCartAnimationView* animationView = [YKAddShopCartAnimationView animationViewWithStartPoint:CGPointMake(120, rect.origin.y) WithEndPoint:CGPointMake(155, 15) withAnimationImage:self.m_imgV.image];
            
            [animationView showAnimation];
            
            // 收藏成功后提示
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showSuccessWithStatus:msg];
            
            // 请求数据重新刷新
            [self vourcherRequestSubmit];
            
           
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
        
    } failure:^(NSError *error) {
        
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}

#pragma mark - 请求网络数据
// 商品列表请求数据
- (void)vourcherRequestSubmit{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
//    NSString *maxPrice = @"";
//    
//    NSString *minPrice = @"";
//    
//    maxPrice = @"";
//    
//    minPrice = @"";
    
    if (TwoID==nil||[TwoID isEqualToString:@""]) {
        TwoID =@"";
    }
    if (OneID2==nil||[OneID2 isEqualToString:@""]) {
        OneID2 =@"";
    }
    if (TwoID2==nil||[TwoID2 isEqualToString:@""]) {
        TwoID2 =@"";
    }
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  memberId,     @"memberId",
                                  key,   @"key",
                                  [NSString stringWithFormat:@"%d", m_pageIndex], @"pageIndex",
                                  selectCity, @"cityId",
                                  OneID2, @"areaId",
                                  TwoID2, @"districtId",
                                  TwoID,@"categoryId",
                                  [NSString stringWithFormat:@"%@",self.m_longtiString],@"mapX",
                                  [NSString stringWithFormat:@"%@",self.m_latiString],@"mapY",
                                 
                                  nil];
    
    NSLog(@"parm = %@",param);
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"VoucherMerchantList.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            
            [SVProgressHUD dismiss];
            
            
            NSLog(@"json = %@",json);
            
            NSMutableArray *metchantShop = [json valueForKey:@"VouMctList"];
            
            if (m_pageIndex == 1) {
                
                if ( self.m_productList.count != 0 ) {
                    
                    [self.m_productList removeAllObjects];
                    
                }
                
                if (metchantShop == nil || metchantShop.count == 0) {
                    
                    self.m_tableView.hidden = YES;
                    
                    self.m_emptyLabel.hidden = NO;
                    
                    self.m_emptyLabel.text = @"暂无数据";
                    
                } else {
                    
                    self.m_emptyLabel.hidden = YES;
                    
                    self.m_tableView.hidden = NO;
                    
                    [self.m_productList addObjectsFromArray: metchantShop];
                    
                    // 如果是第一次请求数据并且是第一页数据的话，则先创建m_keyDic
                    if ( isFirstRequest ) {
                        
                        // 有值的时候删除数据
                        if ( self.m_keyDic.count != 0 ) {
                            
                            [self.m_keyDic removeAllObjects];
                            
                        }
                        
                        // 用于判断点击某一行上面的查看更多券券时用到
                        for (int i = 0; i < self.m_productList.count; i ++) {
                            
                            [self.m_keyDic setValue:@"0" forKey:[NSString stringWithFormat:@"%i",i]];
                            
                        }
                        
                        isFirstRequest = NO;
                    }
                    
                    
                    self.m_tableView.hidden = NO;
                    
                    [self.m_tableView reloadData];
                    
                    
                }
            } else {
                
                if (metchantShop == nil || metchantShop.count == 0) {
                   
                    m_pageIndex--;
                    
                } else {
                    
                    [self.m_productList addObjectsFromArray:metchantShop];
                    
                    
                    // 判断如果第二页有数据的话，则先清空m_keyDic的数据，再重新创建
                    if ( self.m_keyDic.count != 0 ) {
                        
                        [self.m_keyDic removeAllObjects];
                        
                    }
                    
                    // 用于判断点击某一行上面的查看更多券券时用到
                    for (int i = 0; i < self.m_productList.count; i ++) {
                        
                        [self.m_keyDic setValue:@"0" forKey:[NSString stringWithFormat:@"%i",i]];
                        
                    }
                    
                }
                
                
                self.m_tableView.hidden = NO;
                
                [self.m_tableView reloadData];
            }
            
            
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

#pragma mark - PullTableViewDelegate
- (void)pullTableViewDidTriggerRefresh:(PullTableView*)pullTableView {
    
    m_pageIndex = 1;
    
    [self performSelector:@selector(vourcherRequestSubmit) withObject:nil];
    
    
}

- (void)pullTableViewDidTriggerLoadMore:(PullTableView*)pullTableView {
    
    m_pageIndex++;
    [self performSelector:@selector(vourcherRequestSubmit) withObject:nil];
    
}

#pragma mark - 类别和区域
//加载类别一
-(void)loadCategoryView
{
    NSMutableArray *categorys = [dbhelp queryCategory];
    
    [self loadcelldata:categorys];
}
//二
- (void)categorySelect {
    
    NSMutableArray *areas = [dbhelp queryProject:[NSString stringWithFormat:@"%@",OneID]];
    
    [self loadcelldatatwo:areas];
}

-(void)loadcelldata:(NSArray*)datalist
{
    [self.LeftArray removeAllObjects];
    [self.LeftArrayID removeAllObjects];
    
    if (datalist == nil) {
        return;
    }
    [self.LeftArray addObject:@"全部分类"];
    [self.LeftArrayID addObject:@""];
    for (NSDictionary *data in datalist)
    {
        [self.LeftArray addObject:[data objectForKey:@"name"]];
        
        [self.LeftArrayID addObject:[data objectForKey:@"code"]];
    }
    
}

-(void)loadcelldatatwo:(NSArray*)datalist
{
    [self.MiddleArray removeAllObjects];
    [self.MiddleArrayID removeAllObjects];
    if (datalist == nil) {
        return;
    }
    [self.MiddleArray addObject:@"全部"];
    [self.MiddleArrayID addObject:@""];
    for (NSDictionary *data in datalist)
    {
        [self.MiddleArray addObject:[data objectForKey:@"name"]];
        
        [self.MiddleArrayID addObject:[data objectForKey:@"code"]];
    }
}

- (void)citySelectarea
{
    
    NSMutableArray *areas = [dbhelp queryArea:selectCity];
    
    [self loadcelldata2:areas];
    
}

- (void)areaSelectmerchant
{
    
    NSMutableArray *areas = [dbhelp queryMerchant:OneID2];
    
    [self loadcelldatatwo2:areas];
}

- (void)loadcelldata2:(NSArray*)datalist
{
    [self.LeftArray2 removeAllObjects];
    [self.LeftArrayID2 removeAllObjects];
    
    if (datalist == nil) {
        return;
    }
    [self.LeftArray2 addObject:@"全城"];
    [self.LeftArrayID2 addObject:@""];
    
    for (NSDictionary *data in datalist)
    {
        [self.LeftArray2 addObject:[data objectForKey:@"name"]];
        
        [self.LeftArrayID2 addObject:[data objectForKey:@"code"]];
    }
    
    
}

- (void)loadcelldatatwo2:(NSArray*)datalist
{
    [self.MiddleArray2 removeAllObjects];
    [self.MiddleArrayID2 removeAllObjects];
    if (datalist == nil) {
        return;
    }
    [self.MiddleArray2 addObject:@"全部"];
    [self.MiddleArrayID2 addObject:@""];
    for (NSDictionary *data in datalist)
    {
        [self.MiddleArray2 addObject:[data objectForKey:@"name"]];
        
        [self.MiddleArrayID2 addObject:[data objectForKey:@"code"]];
    }
}

#pragma mark - 产品
//分类一赋值tableview
-(void) FenleiDataTotableview1
{
    
    [self.LeftTableview initTableViewDataSourceAndDelegate:^(UITableView *tableView,NSInteger section)
     {
         NSInteger count = self.LeftArray.count;
         return count;
         
     } setCellForIndexPathBlock:^(UITableView *tableView,NSIndexPath *indexPath)
     {
         LeftCell *cell=[tableView dequeueReusableCellWithIdentifier:@"LeftCell"];
         
         if (!cell)
             
         {
             cell = [[[NSBundle mainBundle]loadNibNamed:@"LeftCell" owner:self options:nil]objectAtIndex:0];
             [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
             
             if (indexPath.row == 0) {
             }else{
                 cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
             }
         }
         [cell.MctName setText:[NSString stringWithFormat:@"%@",[self.LeftArray objectAtIndex:indexPath.row]]];
         
         return cell;
     } setDidSelectRowBlock:^(UITableView *tableView,NSIndexPath *indexPath)
     {
         
         if (indexPath.row == 0) {
             
             NeedOpenTwo = @"";
             [self.m_fenleiBtn setTitle:@"全部分类" forState:UIControlStateNormal];
             
             OneID = TwoID = @"";
             
             m_pageIndex = 1;
             
             [self vourcherRequestSubmit];
             
             [self alphaviewtap:nil];
             
         }else{
             
             NeedOpenTwo = @"NeedOpenTwo";
             
             OneID = [NSString stringWithFormat:@"%@",[self.LeftArrayID objectAtIndex:indexPath.row]];
             
             [self categorySelect];
             
             [self FenleiDataTotableview2];
             
             [self.MiddleTableview reloadData];
             
             middleOpened = NO;
             
             [self MiddleOpenBtn];
         }
         
     }];
    
    [self.LeftTableview.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.LeftTableview.layer setBorderWidth:0];
    
}

//分类二赋值
-(void) FenleiDataTotableview2
{
    [self.MiddleTableview initTableViewDataSourceAndDelegate:^(UITableView *tableView,NSInteger section)
     {
         NSInteger count = self.MiddleArray.count;
         return count;
         
     } setCellForIndexPathBlock:^(UITableView *tableView,NSIndexPath *indexPath)
     {
         MiddleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MiddleCell"];
         
         if (!cell)
         {
             cell = [[[NSBundle mainBundle]loadNibNamed:@"MiddleCell" owner:self options:nil]objectAtIndex:0];
             [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
         }
         
         [cell.MctName setText:[NSString stringWithFormat:@"%@",[self.MiddleArray objectAtIndex:indexPath.row]]];
         
         return cell;
     } setDidSelectRowBlock:^(UITableView *tableView,NSIndexPath *indexPath)
     {
         MiddleCell *cell=(MiddleCell*)[tableView cellForRowAtIndexPath:indexPath];
         
         if (indexPath.row == 0) {
             
             for (int i = 0; i < self.LeftArrayID.count; i++) {
                 if ([OneID isEqualToString:[self.LeftArrayID objectAtIndex:i]]) {
                     
                     [self.m_fenleiBtn setTitle:[self.LeftArray objectAtIndex:i] forState:UIControlStateNormal];
                     break;
                 }
                 
                 TwoID = OneID;
                 
                 //类别就传一级ID；
             }
             
         }else{
             
             [self.m_fenleiBtn setTitle:cell.MctName.text forState:UIControlStateNormal];
             
             TwoID = [NSString stringWithFormat:@"%@",[self.MiddleArrayID objectAtIndex:indexPath.row]];
             
         }
         
         m_pageIndex = 1;
         
         //请求产品列表
         [self vourcherRequestSubmit];
         
         [self alphaviewtap:nil];
         
     }];
    
    [self.MiddleTableview .layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.MiddleTableview .layer setBorderWidth:0];
    
}

//地区一赋值
-(void) DiquDataTotableview1
{
    
    [self.LeftTableview2 initTableViewDataSourceAndDelegate:^(UITableView *tableView,NSInteger section)
     {
         NSInteger count = self.LeftArray2.count;
         return count;
         
     } setCellForIndexPathBlock:^(UITableView *tableView,NSIndexPath *indexPath)
     {
         LeftCell *cell=[tableView dequeueReusableCellWithIdentifier:@"LeftCell"];
         
         if (!cell)
             
         {
             cell=[[[NSBundle mainBundle]loadNibNamed:@"LeftCell" owner:self options:nil]objectAtIndex:0];
             [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
             
             if (indexPath.row == 0) {
             }else{
                 cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
             }
         }
         
         if ( self.LeftArray2.count != 0 ) {
             
             [cell.MctName setText:[NSString stringWithFormat:@"%@",[self.LeftArray2 objectAtIndex:indexPath.row]]];
 
         }
         
        
         return cell;
         
         
     } setDidSelectRowBlock:^(UITableView *tableView,NSIndexPath *indexPath)
     {
         //        LeftCell *cell=(LeftCell*)[tableView cellForRowAtIndexPath:indexPath];
         
         if (indexPath.row ==0) {
             
             NeedOpenTwo2 = @"";
             [self.m_diquBtn setTitle:@"全城" forState:UIControlStateNormal];
             
             OneID2 = TwoID2 = @"";
             
             m_pageIndex = 1;
             
             //请求产品列表
             [self vourcherRequestSubmit];
             
             [self alphaviewtap:nil];
             
         }else{
             
             NeedOpenTwo2 = @"NeedOpenTwo2";
             
             OneID2 = [NSString stringWithFormat:@"%@",[self.LeftArrayID2 objectAtIndex:indexPath.row]];
             
             [self areaSelectmerchant];
             
             [self DiquDataTotableview2];
             
             [self.MiddleTableview2 reloadData];
             
             middleOpened2 = NO;
             
             [self MiddleOpenBtn2];
             
         }
         
     }];
    
    [self.LeftTableview2.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.LeftTableview2.layer setBorderWidth:0];
    
}

//地区二赋值
-(void) DiquDataTotableview2
{
    
    [self.MiddleTableview2 initTableViewDataSourceAndDelegate:^(UITableView *tableView,NSInteger section)
     {
         NSInteger count = self.MiddleArray2.count;
         return count;
         
     } setCellForIndexPathBlock:^(UITableView *tableView,NSIndexPath *indexPath)
     {
         MiddleCell *cell=[tableView dequeueReusableCellWithIdentifier:@"MiddleCell"];
         
         if (!cell)
         {
             cell = [[[NSBundle mainBundle]loadNibNamed:@"MiddleCell" owner:self options:nil]objectAtIndex:0];
             [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
         }
         
         [cell.MctName setText:[NSString stringWithFormat:@"%@",[self.MiddleArray2 objectAtIndex:indexPath.row]]];
         
         return cell;
     } setDidSelectRowBlock:^(UITableView *tableView,NSIndexPath *indexPath)
     {
         MiddleCell *cell=(MiddleCell*)[tableView cellForRowAtIndexPath:indexPath];
         
         
         if (indexPath.row == 0) {
             
             for (int i = 0; i < self.LeftArrayID2.count; i++) {
                 if ([OneID2 isEqualToString:[self.LeftArrayID2 objectAtIndex:i]]) {
                     
                     [self.m_diquBtn setTitle:[self.LeftArray2 objectAtIndex:i] forState:UIControlStateNormal];
                     break;
                 }
                 
                 TwoID2 = @"";
                 
             }
             
         }else{
             
             [self.m_diquBtn setTitle:cell.MctName.text forState:UIControlStateNormal];
             TwoID2 =[NSString stringWithFormat:@"%@",[self.MiddleArrayID2 objectAtIndex:indexPath.row]];
         }
         
         m_pageIndex = 1;
         
         [self vourcherRequestSubmit];
         
         [self alphaviewtap:nil];
     }];
    
    [self.MiddleTableview2 .layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.MiddleTableview2 .layer setBorderWidth:0];
    
}

//排序赋值
-(void) PaixuDataTotableview
{
    
    [self.RightTableview initTableViewDataSourceAndDelegate:^(UITableView *tableView,NSInteger section)
     {
         NSInteger count=self.RightArray.count;
         return count;
         
     } setCellForIndexPathBlock:^(UITableView *tableView,NSIndexPath *indexPath)
     {
         RightCell *cell=[tableView dequeueReusableCellWithIdentifier:@"RightCell"];
         
         if (!cell)
         {
             cell=[[[NSBundle mainBundle]loadNibNamed:@"RightCell" owner:self options:nil]objectAtIndex:0];
             [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
         }
         
         [cell.MctName setText:[NSString stringWithFormat:@"%@",[self.RightArray objectAtIndex:indexPath.row]]];
         
         return cell;
     } setDidSelectRowBlock:^(UITableView *tableView,NSIndexPath *indexPath)
     {
         RightCell *cell=(RightCell*)[tableView cellForRowAtIndexPath:indexPath];
         
         [self.m_paixuBtn setTitle:cell.MctName.text forState:UIControlStateNormal];
         
         m_pageIndex = 1;
         
         if (indexPath.row == 0) {
             
             self.m_string = @"";
             
             self.m_order = @"";
             self.m_sort = @"";
             self.m_latiString = @"";
             self.m_longtiString = @"";
             
             //请求产品列表
             [self vourcherRequestSubmit];
             
         }else if (indexPath.row == 1)
         {
             
             self.m_string = @"1";
             
             //离我最近
             self.m_order = @"";
             self.m_sort = @"";
             
             NSString *latitudeString = [CommonUtil getValueByKey:kLatitudeKey];
             NSString *lontiduteString = [CommonUtil getValueByKey:kLongitudeKey];
             NSString *cityId = [CommonUtil getValueByKey:kSelectCityId];
             
             self.m_latiString = [NSString stringWithFormat:@"%f",[latitudeString floatValue]];
             self.m_longtiString = [NSString stringWithFormat:@"%f",[lontiduteString floatValue]];
             
             selectCity = cityId;
             
             // 离我最近时请求分区的数据
             [self vourcherRequestSubmit];
             
         }
         
//         }else if (indexPath.row ==2)
//         {
//             
//             self.m_string = @"";
//             
//             self.m_order = @"desc";//降序
//             self.m_sort = @"Price";
//             self.m_latiString = @"";
//             self.m_longtiString = @"";
//             
//             //请求产品列表
//             [self vourcherRequestSubmit];
//             
//         }else if (indexPath.row ==3)
//         {
//             
//             self.m_string = @"";
//             
//             self.m_order = @"asc";
//             self.m_sort = @"Price";
//             self.m_latiString = @"";
//             self.m_longtiString = @"";
//             
//             //请求产品列表
//             [self vourcherRequestSubmit];
//             
//         }else if (indexPath.row ==4)
//         {
//             
//             
//         }
         
         [self alphaviewtap:nil];
     }];
    
    [self.RightTableview.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.RightTableview.layer setBorderWidth:0];
    
}

- (void)LeftOpenBtn {
    
    if (leftOpened) {
        
        [UIView animateWithDuration:0.3 animations:^{
            self.m_alphaView.alpha = 0;
            
            CGRect frame = self.LeftTableview.frame;
            frame.size.height = 0;
            [self.LeftTableview setFrame:frame];
            
        } completion:^(BOOL finished){
            
            leftOpened=NO;
        }];
    }else{
        self.LeftTableview.hidden = NO;
        
        [UIView animateWithDuration:0.3 animations:^{
            
            self.m_alphaView.alpha = 0.3;
            
            CGRect frame = self.LeftTableview.frame;
            frame.size.height = 300;
            [self.LeftTableview setFrame:frame];
            
            //默认打开上次二级
            if ([NeedOpenTwo isEqualToString:@"NeedOpenTwo"]) {
                middleOpened = NO;
                [self MiddleOpenBtn];
            }
            
        } completion:^(BOOL finished){
            
            leftOpened=YES;
            
        }];
    }
}

- (void)MiddleOpenBtn {
    
    
    if (middleOpened) {
        
        [UIView animateWithDuration:0.3 animations:^{
            
            CGRect frame=self.MiddleTableview.frame;
            frame.size.height = 0;
            [self.MiddleTableview setFrame:frame];
            
        } completion:^(BOOL finished){
            
            middleOpened = NO;
        }];
    }else{
        
        self.MiddleTableview.hidden = NO;
        
        [UIView animateWithDuration:0.3 animations:^{
            
            CGRect frame = self.MiddleTableview.frame;
            
            int fr = self.MiddleArray.count * 44;
            if (fr>300) {
                frame.size.height = 300;
            }else
            {
                frame.size.height = fr;
            }
            [self.MiddleTableview setFrame:frame];
            
        } completion:^(BOOL finished){
            
            middleOpened = YES;
            
        }];
        
    }
    
}

- (void)LeftOpenBtn2 {
    
    
    if (leftOpened2) {
        
        [UIView animateWithDuration:0.3 animations:^{
            self.m_alphaView.alpha = 0;
            CGRect frame = self.LeftTableview2.frame;
            frame.size.height = 0;
            [self.LeftTableview2 setFrame:frame];
            
        } completion:^(BOOL finished){
            
            leftOpened2 = NO;
        }];
    }else{
        
        self.LeftTableview2.hidden = NO;
        
        
        [UIView animateWithDuration:0.3 animations:^{
            
            self.m_alphaView.alpha = 0.3;
            
            CGRect frame=self.LeftTableview2.frame;
            frame.size.height=300;
            [self.LeftTableview2 setFrame:frame];
            
            //默认打开上次二级
            if ([NeedOpenTwo2 isEqualToString:@"NeedOpenTwo2"]) {
                middleOpened2 = NO;
                [self MiddleOpenBtn2];
            }
            
        } completion:^(BOOL finished){
            
            leftOpened2=YES;
            
        }];
        
    }
    
}

- (void)MiddleOpenBtn2 {
    
    if (middleOpened2) {
        
        [UIView animateWithDuration:0.3 animations:^{
            
            CGRect frame = self.MiddleTableview2.frame;
            
            frame.size.height = 0;
            [self.MiddleTableview2 setFrame:frame];
            
            
        } completion:^(BOOL finished){
            
            middleOpened2 = NO;
        }];
    }else{
        
        self.MiddleTableview2.hidden = NO;
        
        [UIView animateWithDuration:0.3 animations:^{
            
            CGRect frame = self.MiddleTableview2.frame;
            
            int fr = self.MiddleArray2.count * 44;
            if (fr > 300) {
                frame.size.height = 300;
            }else
            {
                frame.size.height = fr;
            }
            [self.MiddleTableview2 setFrame:frame];
            
        } completion:^(BOOL finished){
            
            middleOpened2 = YES;
            
        }];
    }
    
}

- (void)RightOpenBtn {
    
    if (rightOpened) {
        
        [UIView animateWithDuration:0.3 animations:^{
            
            CGRect frame=self.RightTableview.frame;
            
            frame.size.height=0;
            [self.RightTableview setFrame:frame];
            self.m_alphaView.alpha = 0;
            
            
        } completion:^(BOOL finished){
            
            rightOpened=NO;
        }];
    }else{
        
        self.RightTableview.hidden = NO;
        
        [UIView animateWithDuration:0.3 animations:^{
            
            CGRect frame=self.RightTableview.frame;
            
            int fr = self.RightArray.count*44;
            if (fr>300) {
                frame.size.height=300;
            }else
            {
                frame.size.height = fr;
            }
            [self.RightTableview setFrame:frame];
            
            self.m_alphaView.alpha = 0.3;
            
        } completion:^(BOOL finished){
            
            rightOpened=YES;
            
        }];
        
    }
    
}

- (IBAction)alphaviewtap:(id)sender
{
    leftOpened = YES;
    middleOpened = YES;
    leftOpened2 = YES;
    middleOpened2 = YES;
    rightOpened = YES;
    [self LeftOpenBtn];
    [self MiddleOpenBtn];
    [self LeftOpenBtn2];
    [self MiddleOpenBtn2];
    [self RightOpenBtn];
}

- (IBAction)btnClicked:(id)sender {
    
    UIButton *btn = (UIButton *)sender;
    
    NSMutableDictionary *dic = [self.m_couponList objectAtIndex:btn.tag];
    
    // 进入优惠券的页面
    CouponWebViewController *VC = [[CouponWebViewController alloc]initWithNibName:@"CouponWebViewController" bundle:nil];
    VC.m_dic = dic;
    [self.navigationController pushViewController:VC animated:YES];
    
    
}

#pragma mark - HHCityListDelegate
- (void)getHHCityName:(NSMutableDictionary *)aCityName{
    
    // 选择城市后重新刷新数据
    if ([[aCityName objectForKey:@"name"] isEqualToString:self.m_titleLabel.text])
    {
        return;
    }
    
    self.m_titleLabel.text = [NSString stringWithFormat:@"%@券券",[aCityName objectForKey:@"name"]];
    
    // 根据
    NSString *string = [NSString stringWithFormat:@"%@",self.m_titleLabel.text];
   
    if ( string.length <= 5 ) {
        
        self.m_imageView.frame = CGRectMake(165, 13, 16, 16);
        
    }else{
        
        self.m_imageView.frame = CGRectMake(185, 13, 16, 16);
        
    }
    
    
    
    
    selectCity = [aCityName objectForKey:@"code"];
    
    [CommonUtil addValue:[aCityName objectForKey:@"name"] andKey:kSelectCityName];
    [CommonUtil addValue:selectCity andKey:kSelectCityId];
    
    // 选择城市后重新刷新数据
    isFirstRequest = YES;
    
    m_pageIndex = 1;
    
    // 默认为默认排序
    self.m_latiString = @"";
    self.m_longtiString = @"";
    
    OneID2 = TwoID2 = TwoID = @"";
    
    // 赋值
    [self.m_fenleiBtn setTitle:@"全部分类" forState:UIControlStateNormal];
    [self.m_paixuBtn setTitle:@"默认排序" forState:UIControlStateNormal];
    [self.m_diquBtn setTitle:@"全城" forState:UIControlStateNormal];
    
       
    //地区
    [self citySelectarea];//加载一级类别
    [self DiquDataTotableview1];//一级赋值
    
    [self.LeftTableview2 reloadData];
    
    [self.MiddleTableview2 reloadData];
    
    // 请求数据
    [self vourcherRequestSubmit];
    
 
}

@end
