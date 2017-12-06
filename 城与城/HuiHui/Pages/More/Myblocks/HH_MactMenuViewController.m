//
//  HH_MactMenuViewController.m
//  HuiHui
//
//  Created by mac on 15-7-2.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "HH_MactMenuViewController.h"

#import "ProductDetailViewController.h"

#import "LocationCell.h"

#import "MapViewController.h"

#import "MerchantDetailViewController.h"

#import "CommonUtil.h"

#import "SVProgressHUD.h"

#import "AppHttpClient.h"

#import "SaleProductListViewController.h"

#import "UIImageView+AFNetworking.h"

#import "SaleProductDetailViewController.h"

#import "EnterViewController.h"

#import "MyActivityViewController.h"

#import "MyPartyViewController.h"

#import "ActivityDetailViewController.h"

#import "BusinesserlistViewController.h"

#import "HomeViewController.h"

#import "Chat_MerViewController.h"

#import "HH_CardPayCell.h"

#import "HH_TakeOrderViewController.h"

#import "CPSHH_TakeOrderViewController.h"

#define degreesToRadian(x) (M_PI * (x) / 180.0)

@interface HH_MactMenuViewController ()

@property (weak, nonatomic) IBOutlet UIView *m_seachView;

@property (weak, nonatomic) IBOutlet UISearchBar *m_searchBar;

@property (weak, nonatomic) IBOutlet UIImageView *m_imgV;

@property (weak, nonatomic) IBOutlet UIView *m_backView;

@property (weak, nonatomic) IBOutlet UIView *m_merchantView;
// 显示商户的tableView
@property (weak, nonatomic) IBOutlet PullTableView *m_merchantTableView;

@property (weak, nonatomic) IBOutlet UIView *m_tempView;

@property (weak, nonatomic) IBOutlet UILabel *m_emptyLabel;

@property (weak, nonatomic) IBOutlet UIButton *registButton;


//商户
@property (weak, nonatomic) IBOutlet UIButton *B_m_fenleiBtn;//分类
@property (weak, nonatomic) IBOutlet UIButton *B_m_diquBtn;//地区
@property (weak, nonatomic) IBOutlet UIButton *B_m_paixuBtn;//排序
@property (weak, nonatomic) IBOutlet UIView   *B_m_alphaView;//透明层



// 点击背景触发的事件
- (IBAction)controlTap:(id)sender;


@end

@implementation HH_MactMenuViewController

@synthesize m_array;

@synthesize keyItems;

@synthesize m_keyDic;

@synthesize isNearestForMe;

@synthesize m_list;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        m_array = [[NSMutableArray alloc]initWithCapacity:0];
        
        pageIndex = 1;
        m_pageIndex = 1;
        
        keyItems = [[NSMutableArray alloc]initWithCapacity:0];
        
        imageCache = [[ImageCache alloc] init];
        
        //商户
        self.B_RightArray = [[NSMutableArray alloc]initWithCapacity:0];
        self.B_MiddleArray = [[NSMutableArray alloc]initWithCapacity:0];
        self.B_MiddleArrayID = [[NSMutableArray alloc]initWithCapacity:0];
        self.B_MiddleArray2 = [[NSMutableArray alloc]initWithCapacity:0];
        self.B_MiddleArrayID2 = [[NSMutableArray alloc]initWithCapacity:0];
        self.B_LeftArray = [[NSMutableArray alloc]initWithCapacity:0];
        self.B_LeftArrayID = [[NSMutableArray alloc]initWithCapacity:0];
        self.B_LeftArray2 = [[NSMutableArray alloc]initWithCapacity:0];
        self.B_LeftArrayID2 = [[NSMutableArray alloc]initWithCapacity:0];
        
        [self.B_RightArray addObject:@"默认排序"];
        [self.B_RightArray addObject:@"离我最近"];
        
        
        m_keyDic = [[NSMutableDictionary alloc]initWithCapacity:0];
        
        isNearestForMe = YES;
        
        m_list = [[NSMutableArray alloc]initWithCapacity:0];
        
        dbhelp = [[DBHelper alloc] init];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setTitle:@"在线点单"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    self.m_searchBar.text = @"";
    
    self.m_tempView.alpha = 0.8;
    
    self.registButton.tag = 1001;
    
    // 判断经纬度
    self.m_string = @"1";
    
    self.m_backView.backgroundColor = [UIColor clearColor];
    
    // 设置导航栏的右按钮
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 40)];
    view.backgroundColor = [UIColor clearColor];
    
    //搜索
//    UIButton *seachBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    seachBtn.frame = CGRectMake(10, 4, 20, 35);
//    [seachBtn setImage:[UIImage imageNamed:@"bd_02.png"] forState:UIControlStateNormal];
//    seachBtn.backgroundColor = [UIColor clearColor];
//    [seachBtn addTarget:self action:@selector(seachBtnClicked) forControlEvents:UIControlEventTouchUpInside];
//    [view addSubview:seachBtn];
//    
//    UIBarButtonItem *l_barButton = [[UIBarButtonItem alloc] initWithCustomView:view];
//    [self.navigationItem setRightBarButtonItem:l_barButton];
    
    [self.m_merchantTableView setDelegate:self];
    [self.m_merchantTableView setDataSource:self];
    [self.m_merchantTableView setPullDelegate:self];
    self.m_merchantTableView.pullBackgroundColor = [UIColor whiteColor];
    self.m_merchantTableView.useRefreshView = YES;
    self.m_merchantTableView.useLoadingMoreView = YES;
    
    // 经纬度 ======
    NSString *latitudeString = [CommonUtil getValueByKey:kLatitudeKey];
    NSString *lontiduteString = [CommonUtil getValueByKey:kLongitudeKey];
    NSString *cityId = [CommonUtil getValueByKey:kSelectCityId];
    
    self.B_m_latiString = [NSString stringWithFormat:@"%f",[latitudeString floatValue]];
    self.B_m_longtiString = [NSString stringWithFormat:@"%f",[lontiduteString floatValue]];
    
    selectCity = cityId;
    
    self.m_emptyLabel.hidden = YES;
    
    // 隐藏搜索时出现的view
    self.m_seachView.hidden = YES;
    
    self.B_m_alphaView.alpha = 0;
    
    //    [self loadCityandClass];
    
    [self B_citySelectarea];
    [self B_DiquDataTotableview1];
    [self.B_MiddleTableview2 reloadData];
    
    [self B_loadCategoryView];
    [self B_FenleiDataTotableview1];
    [self.B_LeftTableview reloadData];
    
    
    ///商户
    [self B_loadCategoryView];//加载一级类别
    [self B_FenleiDataTotableview1];//一级赋值
    
    [self.B_m_fenleiBtn addTarget:self action:@selector(B_LeftOpenBtn) forControlEvents:UIControlEventTouchUpInside];
    
    [self.B_m_diquBtn addTarget:self action:@selector(B_LeftOpenBtn2) forControlEvents:UIControlEventTouchUpInside];
    
    [self.B_m_paixuBtn addTarget:self action:@selector(B_RightOpenBtn) forControlEvents:UIControlEventTouchUpInside];
    
    [self B_PaixuDataTotableview];//排序赋值
    
    // 请求商户的接口
    [self loadData];
    
    self.m_merchantTableView.hidden = NO;
    
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear: animated];
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self hideTabBar:YES];
    
    B_leftOpened = NO;
    B_middleOpened = NO;
    B_leftOpened2 = NO;
    B_middleOpened2 = NO;
    B_rightOpened = NO;
    
    self.B_LeftTableview.hidden = YES;
    self.B_MiddleTableview.hidden = YES;
    self.B_LeftTableview2.hidden = YES;
    self.B_MiddleTableview2.hidden = YES;
    self.B_RightTableview.hidden = YES;
    
    CGRect frame = self.B_LeftTableview.frame;
    //    frame.size.height = 0.0f;
    
    frame = CGRectMake(0, 44, WindowSizeWidth/2, 0);
    
    [self.B_LeftTableview setFrame:frame];
    
    
    CGRect frame1 = self.B_MiddleTableview.frame;
    //    frame1.size.height = 0.0f;
    frame1 = CGRectMake(WindowSizeWidth/2, 44, WindowSizeWidth/2, 0);
    
    [self.B_MiddleTableview setFrame:frame1];
    
    
    CGRect frame2 = self.B_LeftTableview2.frame;
    //    frame2.size.height = 0.0f;
    frame2 = CGRectMake(0, 44, WindowSizeWidth/2, 0);
    
    [self.B_LeftTableview2 setFrame:frame2];
    
    
    CGRect frame3 = self.B_MiddleTableview2.frame;
    //    frame3.size.height = 0.0f;
    frame3 = CGRectMake(WindowSizeWidth/2, 44, WindowSizeWidth/2, 0);
    
    [self.B_MiddleTableview2 setFrame:frame3];
    
    
    CGRect frame4 = self.B_RightTableview.frame;
    //    frame4.size.height = 0.0f;
    frame4 = CGRectMake(WindowSizeWidth/2, 44, WindowSizeWidth/2, 0);
    
    [self.B_RightTableview setFrame:frame4];
    
    self.B_m_alphaView.alpha = 0;
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [self hideTabBar:NO];
    
    self.B_LeftTableview.hidden = YES;
    self.B_MiddleTableview.hidden = YES;
    self.B_LeftTableview2.hidden = YES;
    self.B_MiddleTableview2.hidden = YES;
    self.B_RightTableview.hidden = YES;
    
    CGRect frame = self.B_LeftTableview.frame;
    frame.size.height = 0.0f;
    [self.B_LeftTableview setFrame:frame];
    
    
    CGRect frame1 = self.B_MiddleTableview.frame;
    frame1.size.height = 0.0f;
    [self.B_MiddleTableview setFrame:frame1];
    
    
    CGRect frame2 = self.B_LeftTableview2.frame;
    frame2.size.height = 0.0f;
    
    [self.B_LeftTableview2 setFrame:frame2];
    
    
    CGRect frame3 = self.B_MiddleTableview2.frame;
    frame3.size.height = 0.0f;
    [self.B_MiddleTableview2 setFrame:frame3];
    
    
    CGRect frame4 = self.B_RightTableview.frame;
    frame4.size.height = 0.0f;
    [self.B_RightTableview setFrame:frame4];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)leftClicked{
    
    [self goBack];
    
}

- (void)seachBtnClicked{
    
    self.m_seachView.hidden = NO;
    
    [self.m_searchBar becomeFirstResponder];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.keyItems.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *cellIdentifier = @"HH_MactMenuCellIdentifier1";
    
    HH_MactMenuCell1 *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"HH_CardPayCell" owner:self options:nil];
        
        cell = (HH_MactMenuCell1 *)[nib objectAtIndex:3];
        
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    }
    
    NSMutableDictionary *item = [self.keyItems objectAtIndex:indexPath.row];
    [cell setMactLogImagePath:[NSString stringWithFormat:@"%@",[item objectForKey:@"Logo"]]];
    [cell setSeroes:[NSString stringWithFormat:@"%@",[item objectForKey:@"Score"]]];
    cell.MerchantShopName.text = [NSString stringWithFormat:@"%@",[item objectForKey:@"MerchantShopName"]];
    cell.QsPrice.text = [NSString stringWithFormat:@"￥%@",[item objectForKey:@"QsPrice"]];
    cell.LastMonthSales.text = [NSString stringWithFormat:@"月售%@单",[item objectForKey:@"LastMonthSales"]];

//    IsZCFirstBuy，FirstBuyDesc，首次，IsZCHowMuchLess，Man，Jian，满立减，IsZCMLZ，MLZDesc，满立赠
    NSString *IsZCFirstBuy=[NSString stringWithFormat:@"%@",[item objectForKey:@"IsZCFirstBuy"]];
    NSString *IsZCHowMuchLess=[NSString stringWithFormat:@"%@",[item objectForKey:@"IsZCHowMuchLess"]];
    NSString *IsZCMLZ=[NSString stringWithFormat:@"%@",[item objectForKey:@"IsZCMLZ"]];
    NSString *IsZCWaiMai=[NSString stringWithFormat:@"%@",[item objectForKey:@"IsZCWaiMai"]];
    NSString *ModelType=[NSString stringWithFormat:@"%@",[item objectForKey:@"ModelType"]];
    if ([IsZCFirstBuy isEqualToString:@"1"]) {
        cell.FirstBuyDesc.text=[NSString stringWithFormat:@"%@",[item objectForKey:@"FirstBuyDesc"]];
        cell.IsZCFirstBuy.hidden=NO;
        cell.IsZCFirstBuy.frame=CGRectMake(cell.IsZCFirstBuy.frame.origin.x, 77, cell.IsZCFirstBuy.frame.size.width, cell.IsZCFirstBuy.frame.size.height);

        
        if ([IsZCHowMuchLess isEqualToString:@"1"]) {
            cell.Jian.text=[NSString stringWithFormat:@"满%@减%@",[item objectForKey:@"Man"],[item objectForKey:@"Jian"]];
            cell.IsZCHowMuchLess.hidden=NO;
            cell.IsZCHowMuchLess.frame=CGRectMake(cell.IsZCHowMuchLess.frame.origin.x, 98, cell.IsZCHowMuchLess.frame.size.width, cell.IsZCHowMuchLess.frame.size.height);

            if ([IsZCMLZ isEqualToString:@"1"]) {
                cell.MLZDesc.text=[NSString stringWithFormat:@"%@",[item objectForKey:@"MLZDesc"]];
                cell.IsZCMLZ.hidden=NO;
                cell.IsZCMLZ.frame=CGRectMake(cell.IsZCMLZ.frame.origin.x, 119, cell.IsZCMLZ.frame.size.width, cell.IsZCMLZ.frame.size.height);
                cell.lingeView.frame = CGRectMake(0, 141, WindowSize.size.width, 1);

            }else
            {
                cell.MLZDesc.text=@"不支持满立赠活动";
                cell.IsZCMLZ.hidden=YES;
                cell.lingeView.frame = CGRectMake(0, 119, WindowSize.size.width, 1);
            }
            
        }else
        {
            cell.Jian.text=@"不支持满立减优惠";
            cell.IsZCHowMuchLess.hidden=YES;
            
            if ([IsZCMLZ isEqualToString:@"1"]) {
                cell.MLZDesc.text=[NSString stringWithFormat:@"%@",[item objectForKey:@"MLZDesc"]];
                cell.IsZCMLZ.hidden=NO;
                cell.IsZCMLZ.frame=CGRectMake(cell.IsZCMLZ.frame.origin.x, 98, cell.IsZCMLZ.frame.size.width, cell.IsZCMLZ.frame.size.height);
                cell.lingeView.frame = CGRectMake(0, 119, WindowSize.size.width, 1);

            }else
            {
                cell.MLZDesc.text=@"不支持满立赠活动";
                cell.IsZCMLZ.hidden=YES;
                cell.lingeView.frame = CGRectMake(0, 97, WindowSize.size.width, 1);
                
            }
        }
        
    }else
    {
        cell.FirstBuyDesc.text=@"不支持首次购买优惠";
        cell.IsZCFirstBuy.hidden = YES;

        if ([IsZCHowMuchLess isEqualToString:@"1"]) {
            cell.Jian.text=[NSString stringWithFormat:@"满%@减%@",[item objectForKey:@"Man"],[item objectForKey:@"Jian"]];
            cell.IsZCHowMuchLess.hidden=NO;
            cell.IsZCHowMuchLess.frame=CGRectMake(cell.IsZCHowMuchLess.frame.origin.x, 77, cell.IsZCHowMuchLess.frame.size.width, cell.IsZCHowMuchLess.frame.size.height);
            
            if ([IsZCMLZ isEqualToString:@"1"]) {
                cell.MLZDesc.text=[NSString stringWithFormat:@"%@",[item objectForKey:@"MLZDesc"]];
                cell.IsZCMLZ.hidden=NO;
                cell.IsZCMLZ.frame=CGRectMake(cell.IsZCMLZ.frame.origin.x, 98, cell.IsZCMLZ.frame.size.width, cell.IsZCMLZ.frame.size.height);
                cell.lingeView.frame = CGRectMake(0, 119, WindowSize.size.width, 1);


            }else
            {
                cell.MLZDesc.text=@"不支持满立赠活动";
                cell.IsZCMLZ.hidden=YES;
                cell.lingeView.frame = CGRectMake(0, 97, WindowSize.size.width, 1);
                
            }
            
        }else
        {
            cell.Jian.text=@"不支持满立减优惠";
            cell.IsZCHowMuchLess.hidden=YES;
            
            if ([IsZCMLZ isEqualToString:@"1"]) {
                cell.MLZDesc.text=[NSString stringWithFormat:@"%@",[item objectForKey:@"MLZDesc"]];
                cell.IsZCMLZ.hidden=NO;
                cell.IsZCMLZ.frame=CGRectMake(cell.IsZCMLZ.frame.origin.x, 77, cell.IsZCMLZ.frame.size.width, cell.IsZCMLZ.frame.size.height);
                cell.lingeView.frame = CGRectMake(0, 97, WindowSize.size.width, 1);

            }else
            {
                cell.MLZDesc.text=@"不支持满立赠活动";
                cell.IsZCMLZ.hidden=YES;
                cell.lingeView.frame = CGRectMake(0, 75, WindowSize.size.width, 1);
                
            }
        }
        
        
    }



    
    if ([IsZCWaiMai isEqualToString:@"1"]) {
        cell.QsPrice.hidden = NO;
        cell.QsPriceLabel.hidden =NO;
        //餐饮支持外卖的模式
        if ([ModelType isEqualToString:@"0"]) {
            CGFloat Distance =[[NSString stringWithFormat:@"%@",[item objectForKey:@"Distance"]] floatValue];
            if (Distance>1) {
                cell.PsMinutesDistancePsPrice.text = [NSString stringWithFormat:@"%@分钟送达|%.1fkm|配送费%@元",[item objectForKey:@"PsMinutes"],Distance,[item objectForKey:@"PsPrice"]];
            }else{
                Distance = Distance*1000;
                cell.PsMinutesDistancePsPrice.text = [NSString stringWithFormat:@"%@分钟送达|%.0f米|配送费%@元",[item objectForKey:@"PsMinutes"],Distance,[item objectForKey:@"PsPrice"]];
            }
            
        }else if ([ModelType isEqualToString:@"1"]){
        
        }else if ([ModelType isEqualToString:@"2"]){
            cell.QsPrice.hidden = YES;
            cell.QsPriceLabel.hidden = YES;
            CGFloat Distance =[[NSString stringWithFormat:@"%@",[item objectForKey:@"Distance"]] floatValue];
            if (Distance>1) {
                cell.PsMinutesDistancePsPrice.text = [NSString stringWithFormat:@"%.1fkm|配送费%@元",Distance,[item objectForKey:@"PsPrice"]];
            }else{
                Distance = Distance*1000;
                cell.PsMinutesDistancePsPrice.text = [NSString stringWithFormat:@"%.0f米|配送费%@元",Distance,[item objectForKey:@"PsPrice"]];
            }
        }
        
    }else{
    
        cell.QsPrice.hidden = YES;
        cell.QsPriceLabel.hidden = YES;
        CGFloat Distance =[[NSString stringWithFormat:@"%@",[item objectForKey:@"Distance"]] floatValue];
        if (Distance>1) {
            cell.PsMinutesDistancePsPrice.text = [NSString stringWithFormat:@"%.1fkm",Distance];
        }else{
            Distance = Distance*1000;
            cell.PsMinutesDistancePsPrice.text = [NSString stringWithFormat:@"%.0f米",Distance];
        }
    
    }
    
    
    return cell;

}



#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSMutableDictionary *item = [self.keyItems objectAtIndex:indexPath.row];
    NSString *IsZCFirstBuy=[NSString stringWithFormat:@"%@",[item objectForKey:@"IsZCFirstBuy"]];
    NSString *IsZCHowMuchLess=[NSString stringWithFormat:@"%@",[item objectForKey:@"IsZCHowMuchLess"]];
    NSString *IsZCMLZ=[NSString stringWithFormat:@"%@",[item objectForKey:@"IsZCMLZ"]];

    if ([IsZCFirstBuy isEqualToString:@"1"]) {
        if ([IsZCHowMuchLess isEqualToString:@"1"]) {
            if ([IsZCMLZ isEqualToString:@"1"]) {
                return 142.0f;
            }else
            {
                return 120.f;
            }
            
        }else
        {
            if ([IsZCMLZ isEqualToString:@"1"]) {
                return 120.0f;
            }else
            {
                return 98.0f;
            }
        }
        
    }else
    {
        if ([IsZCHowMuchLess isEqualToString:@"1"]) {
            if ([IsZCMLZ isEqualToString:@"1"]) {
                return 120.f;

            }else
            {
                return 98.0f;
            }
            
        }else
        {
            if ([IsZCMLZ isEqualToString:@"1"]) {
                return 98.0f;
            }else
            {
                return 76.0f;
            }
        }
        
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    NSMutableDictionary *item = [self.keyItems objectAtIndex:indexPath.row];
    // 获取店铺列表的信息
//    NSMutableArray *arr = [item objectForKey:@"ShopList"];

    [CommonUtil addValue:[item objectForKey:@"Logo"] andKey:@"MarchantImageKey"];
    [CommonUtil addValue:[item objectForKey:@"YHDescription"] andKey:YHDESCRIPTION];
    [CommonUtil addValue:[item objectForKey:@"Man"] andKey:MANKEY];
    [CommonUtil addValue:[item objectForKey:@"Jian"] andKey:JIANKEY];
    

    // 进入点菜的页面
//    HH_TakeOrderViewController *VC = [[HH_TakeOrderViewController alloc]initWithNibName:@"HH_TakeOrderViewController" bundle:nil];
//    VC.m_shopList = arr;
//    VC.m_seat = [NSString stringWithFormat:@"%@",[item objectForKey:@"IsSelectSeat"]];
//    VC.m_merchantId = [NSString stringWithFormat:@"%@",[item objectForKey:@"MerchantID"]];
//   VC.m_ModelType = [NSString stringWithFormat:@"%@",[item objectForKey:@"ModelType"]];
//    VC.IsZCWaiMai = [NSString stringWithFormat:@"%@",[item objectForKey:@"IsZCWaiMai"]];
//    [self.navigationController pushViewController:VC animated:YES];

    
    CPSHH_TakeOrderViewController *VCC = [[CPSHH_TakeOrderViewController alloc] init];
    [VCC.m_dic setObject:@[@{@"MctShopID":[NSString stringWithFormat:@"%@",[item objectForKey:@"MerchantShopID"]],@"MctShopName":[NSString stringWithFormat:@"%@",[item objectForKey:@"MerchantShopName"]]}] forKey:@"m_shopList"];
    [VCC.m_dic setObject:[NSString stringWithFormat:@"%@",[item objectForKey:@"IsSelectSeat"]] forKey:@"m_seat"];
    [VCC.m_dic setObject:[NSString stringWithFormat:@"%@",[item objectForKey:@"ModelType"]] forKey:@"m_ModelType"];
    [VCC.m_dic setObject:[NSString stringWithFormat:@"%@",[item objectForKey:@"MerchantID"]] forKey:@"m_merchantId"];
    [VCC.m_dic setObject:[NSString stringWithFormat:@"%@",[item objectForKey:@"IsZCWaiMai"]] forKey:@"IsZCWaiMai"];
    [self.navigationController pushViewController:VCC animated:YES];
    
}

- (IBAction)controlTap:(id)sender {
    
    [self.m_searchBar resignFirstResponder];
    
    self.m_seachView.hidden = YES;
}


- (void)openBaiduMap:(NSDictionary *)item{
    
    MapViewController *viewController = [[MapViewController alloc] initWithNibName:@"MapViewController" bundle:nil];
    viewController.item = item;
    viewController.m_shopString = @"2";
    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark - 请求网络数据
//商户接口
//- (void)loadData {
//    
//    // 判断网络是否存在
//    if ( ![self isConnectionAvailable] ) {
//        
//        return;
//    }
//    if (B_TwoID==nil||[B_TwoID isEqualToString:@""]) {
//        B_TwoID =@"";
//    }
//    if (B_OneID2==nil||[B_OneID2 isEqualToString:@""]) {
//        B_OneID2 =@"";
//    }
//    if (B_TwoID2==nil||[B_TwoID2 isEqualToString:@""]) {
//        B_TwoID2 =@"";
//    }
//    
//    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
//    NSString *key = [CommonUtil getServerKey];
//    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:
//                                  memberId,     @"memberId",
//                                  key,   @"key",
//                                  [NSString stringWithFormat:@"%ld", (long)pageIndex], @"pageIndex",
//                                  @"10",@"pageSize",
//                                  selectCity, @"CityID",
//                                  B_OneID2, @"AreaID",
//                                  B_TwoID2, @"DistrictID",
////                                  B_TwoID, @"categoryId",
//                                  B_TwoID, @"ClassID",
//                                  [NSString stringWithFormat:@"%@",self.B_m_longtiString],@"MapX",
//                                  [NSString stringWithFormat:@"%@",self.B_m_latiString],@"MapY",
//                                  @"",@"keyword",
//                                  
//                                  
//                                  nil];
//    
//    
//    NSLog(@"params = %@",param);
//    
//    AppHttpClient* httpClient = [AppHttpClient sharedClient];
//    [SVProgressHUD showWithStatus:@"数据加载中"];
//    [httpClient request:@"GetMerchantCloudMenuList.ashx" parameters:param success:^(NSJSONSerialization* json) {
//        BOOL success = [[json valueForKey:@"status"] boolValue];
//        if (success) {
//            [SVProgressHUD dismiss];
//            
//            NSLog(@"json = %@",json);
//
//            NSMutableArray *metchantShop = [json valueForKey:@"MerchantList"];
//            
//            if (pageIndex == 1) {
//                if (metchantShop == nil || metchantShop.count == 0) {
//                    
//                    [self.keyItems removeAllObjects];
//                    self.m_merchantTableView.hidden = YES;
//                    
//                    self.m_emptyLabel.hidden = NO;
//                    
//                    self.m_emptyLabel.text = @"暂无支持点单的商户信息！";
//                    
//                } else {
//                    
//                    self.keyItems = metchantShop;
//                    
//                    self.m_emptyLabel.hidden = YES;
//                    
//                    self.m_merchantTableView.hidden = NO;
//                    
//                    [self.m_merchantTableView reloadData];
//                    
//                }
//            } else {
//                
//                if (metchantShop == nil || metchantShop.count == 0) {
//                    pageIndex--;
//                    
//                } else {
//                    
//                    [self.keyItems addObjectsFromArray:metchantShop];
//                }
//                
//                self.m_merchantTableView.hidden = NO;
//                
//                [self.m_merchantTableView reloadData];
//            }
//            
//  
//        } else {
//            if (pageIndex > 1) {
//                pageIndex--;
//            }
//            NSString *msg = [json valueForKey:@"msg"];
//            [SVProgressHUD showErrorWithStatus:msg];
//        }
//        self.m_merchantTableView.pullLastRefreshDate = [NSDate date];
//        self.m_merchantTableView.pullTableIsRefreshing = NO;
//        self.m_merchantTableView.pullTableIsLoadingMore = NO;
//        
//    } failure:^(NSError *error) {
//        if (pageIndex > 1) {
//            pageIndex--;
//        }
//        //NSLog(@"failed:%@", error);
//        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
//        //self.tableView.pullLastRefreshDate = [NSDate date];
//        self.m_merchantTableView.pullTableIsRefreshing = NO;
//        self.m_merchantTableView.pullTableIsLoadingMore = NO;
//    }];
//}

//获取开通云菜单功能的店铺
- (void)loadData {
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    if (B_TwoID==nil||[B_TwoID isEqualToString:@""]) {
        B_TwoID =@"";
    }
    if (B_OneID2==nil||[B_OneID2 isEqualToString:@""]) {
        B_OneID2 =@"";
    }
    if (B_TwoID2==nil||[B_TwoID2 isEqualToString:@""]) {
        B_TwoID2 =@"";
    }
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  memberId,     @"memberId",
                                  key,   @"key",
                                  [NSString stringWithFormat:@"%ld", (long)pageIndex], @"pageIndex",
                                  @"10",@"pageSize",
                                  selectCity, @"CityID",
                                  B_OneID2, @"AreaID",
                                  B_TwoID2, @"DistrictID",
                                  B_TwoID, @"ClassID",
                                  [NSString stringWithFormat:@"%@",self.B_m_longtiString],@"MapX",
                                  [NSString stringWithFormat:@"%@",self.B_m_latiString],@"MapY",
                                  @"",@"keyword",
                                  nil];
    
    NSLog(@"params = %@",param);
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"GetMerchantShopCloudMenuList.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            [SVProgressHUD dismiss];
            NSLog(@"json = %@",json);
            
            NSMutableArray *metchantShop = [json valueForKey:@"MsList"];
            
            if (pageIndex == 1) {
                if (metchantShop == nil || metchantShop.count == 0) {
                    
                    [self.keyItems removeAllObjects];
                    self.m_merchantTableView.hidden = YES;
                    self.m_emptyLabel.hidden = NO;
                    self.m_emptyLabel.text = @"暂无支持点单的商户信息！";
                    
                } else {
                    
                    self.keyItems = metchantShop;
                    
                    self.m_emptyLabel.hidden = YES;
                    
                    self.m_merchantTableView.hidden = NO;
                    
                    [self.m_merchantTableView reloadData];
                    
                }
            } else {
                
                if (metchantShop == nil || metchantShop.count == 0) {
                    pageIndex--;
                    
                } else {
                    
                    [self.keyItems addObjectsFromArray:metchantShop];
                }
                
                self.m_merchantTableView.hidden = NO;
                
                [self.m_merchantTableView reloadData];
            }
            
            
        } else {
            if (pageIndex > 1) {
                pageIndex--;
            }
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
        self.m_merchantTableView.pullLastRefreshDate = [NSDate date];
        self.m_merchantTableView.pullTableIsRefreshing = NO;
        self.m_merchantTableView.pullTableIsLoadingMore = NO;
        
    } failure:^(NSError *error) {
        if (pageIndex > 1) {
            pageIndex--;
        }
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        //self.tableView.pullLastRefreshDate = [NSDate date];
        self.m_merchantTableView.pullTableIsRefreshing = NO;
        self.m_merchantTableView.pullTableIsLoadingMore = NO;
    }];
}


#pragma mark - PullTableViewDelegate
- (void)pullTableViewDidTriggerRefresh:(PullTableView*)pullTableView {
    
    pageIndex = 1;
    m_pageIndex = 1;
    self.m_searchBar.text = @"";
    
    [self performSelector:@selector(loadData) withObject:nil];
    
    
}

- (void)pullTableViewDidTriggerLoadMore:(PullTableView*)pullTableView {
    
//    if ( [self.m_isLastPage isEqualToString:@"1"] ) {
//        
//        m_pageIndex++;
//        [self performSelector:@selector(loadData1) withObject:nil];
//        
//    }else{
    
        pageIndex++;
        [self performSelector:@selector(loadData) withObject:nil];
        
//    }
}

- (IBAction)regeistMerchant:(id)sender {
    
    BusinesserlistViewController *viewController = [[BusinesserlistViewController alloc] initWithNibName:@"BusinesserlistViewController" bundle:nil];
    viewController.PorB=@"2";//商户
    [self.navigationController pushViewController:viewController animated:YES];
    
}
//商户
//加载类别一
-(void)B_loadCategoryView
{
    NSMutableArray *categorys = [dbhelp queryCategory];
    
    [self B_loadcelldata:categorys];
}
//二
- (void)B_categorySelect {
    
    NSMutableArray *areas = [dbhelp queryProject:[NSString stringWithFormat:@"%@",B_OneID]];
    
    [self B_loadcelldatatwo:areas];
}

-(void)B_loadcelldata:(NSArray*)datalist
{
    [self.B_LeftArray removeAllObjects];
    [self.B_LeftArrayID removeAllObjects];
    
    if (datalist == nil) {
        return;
    }
    [self.B_LeftArray addObject:@"全部分类"];
    [self.B_LeftArrayID addObject:@""];
    for (NSDictionary *data in datalist)
    {
        [self.B_LeftArray addObject:[data objectForKey:@"name"]];
        
        [self.B_LeftArrayID addObject:[data objectForKey:@"code"]];
    }
    
}

-(void)B_loadcelldatatwo:(NSArray*)datalist
{
    [self.B_MiddleArray removeAllObjects];
    [self.B_MiddleArrayID removeAllObjects];
    if (datalist == nil) {
        return;
    }
    [self.B_MiddleArray addObject:@"全部"];
    [self.B_MiddleArrayID addObject:@""];
    for (NSDictionary *data in datalist)
    {
        [self.B_MiddleArray addObject:[data objectForKey:@"name"]];
        
        [self.B_MiddleArrayID addObject:[data objectForKey:@"code"]];
    }
}


-(void)B_citySelectarea
{
    NSMutableArray *areas = [dbhelp queryArea:selectCity];
    
    [self B_loadcelldata2:areas];
    
}
-(void)B_areaSelectmerchant
{
    NSMutableArray *areas = [dbhelp queryMerchant:B_OneID2];
    
    [self B_loadcelldatatwo2:areas];
}

-(void)B_loadcelldata2:(NSArray*)datalist
{
    [self.B_LeftArray2 removeAllObjects];
    [self.B_LeftArrayID2 removeAllObjects];
    
    if (datalist == nil) {
        return;
    }
    [self.B_LeftArray2 addObject:@"全城"];
    [self.B_LeftArrayID2 addObject:@""];
    
    for (NSDictionary *data in datalist)
    {
        [self.B_LeftArray2 addObject:[data objectForKey:@"name"]];
        
        [self.B_LeftArrayID2 addObject:[data objectForKey:@"code"]];
    }
    
}

-(void)B_loadcelldatatwo2:(NSArray*)datalist
{
    [self.B_MiddleArray2 removeAllObjects];
    [self.B_MiddleArrayID2 removeAllObjects];
    if (datalist == nil) {
        return;
    }
    [self.B_MiddleArray2 addObject:@"全部"];
    [self.B_MiddleArrayID2 addObject:@""];
    for (NSDictionary *data in datalist)
    {
        [self.B_MiddleArray2 addObject:[data objectForKey:@"name"]];
        
        [self.B_MiddleArrayID2 addObject:[data objectForKey:@"code"]];
    }
}

#pragma mark - 商户
-(void) B_FenleiDataTotableview1
{
    
    [self.B_LeftTableview initTableViewDataSourceAndDelegate:^(UITableView *tableView,NSInteger section)
     {
         NSInteger count=self.B_LeftArray.count;
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
                 cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
             }
         }
         [cell.MctName setText:[NSString stringWithFormat:@"%@",[self.B_LeftArray objectAtIndex:indexPath.row]]];
         
         return cell;
     } setDidSelectRowBlock:^(UITableView *tableView,NSIndexPath *indexPath)
     {
         
         if (indexPath.row ==0) {
             
             B_NeedOpenTwo = @"";
             [self.B_m_fenleiBtn setTitle:@"全部分类" forState:UIControlStateNormal];
             
             B_OneID = B_TwoID = @"";
             
             pageIndex=1;
             //请求商户列表
             self.m_searchBar.text = @"";
             
             [self loadData];
             
             [self alphaviewtap:nil];
             
         }else{
             
             B_NeedOpenTwo = @"NeedOpenTwo";
             
             B_OneID =[NSString stringWithFormat:@"%@",[self.B_LeftArrayID objectAtIndex:indexPath.row]];
             
             [self B_categorySelect];
             
             [self B_FenleiDataTotableview2];
             
             [self.B_MiddleTableview reloadData];
             
             B_middleOpened=NO;
             
             [self B_MiddleOpenBtn];
         }
         
         
         
     }];
    
    [self.B_LeftTableview.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.B_LeftTableview.layer setBorderWidth:0];
    
    
}

//分类二赋值
-(void) B_FenleiDataTotableview2
{
    
    [self.B_MiddleTableview initTableViewDataSourceAndDelegate:^(UITableView *tableView,NSInteger section)
     {
         NSInteger count=self.B_MiddleArray.count;
         return count;
         
     } setCellForIndexPathBlock:^(UITableView *tableView,NSIndexPath *indexPath)
     {
         MiddleCell *cell=[tableView dequeueReusableCellWithIdentifier:@"MiddleCell"];
         
         if (!cell)
         {
             cell=[[[NSBundle mainBundle]loadNibNamed:@"MiddleCell" owner:self options:nil]objectAtIndex:0];
             [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
         }
         
         [cell.MctName setText:[NSString stringWithFormat:@"%@",[self.B_MiddleArray objectAtIndex:indexPath.row]]];
         
         return cell;
     } setDidSelectRowBlock:^(UITableView *tableView,NSIndexPath *indexPath)
     {
         MiddleCell *cell=(MiddleCell*)[tableView cellForRowAtIndexPath:indexPath];
         
         if (indexPath.row ==0) {
             
             for (int i=0; i<self.B_LeftArrayID.count; i++) {
                 if ([B_OneID isEqualToString:[self.B_LeftArrayID objectAtIndex:i]]) {
                     
                     [self.B_m_fenleiBtn setTitle:[self.B_LeftArray objectAtIndex:i] forState:UIControlStateNormal];
                     break;
                 }
                 
                 B_TwoID = B_OneID;
                 
             }
             
         }else{
             
             [self.B_m_fenleiBtn setTitle:cell.MctName.text forState:UIControlStateNormal];
             
             B_TwoID =[NSString stringWithFormat:@"%@",[self.B_MiddleArrayID objectAtIndex:indexPath.row]];
             
         }
         
         pageIndex=1;
         
         self.m_searchBar.text = @"";
         
         //请求产品列表
         [self loadData];
         
         [self alphaviewtap:nil];
         
     }];
    
    [self.B_MiddleTableview .layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.B_MiddleTableview .layer setBorderWidth:0];
    
    
    
}

//地区一赋值
-(void) B_DiquDataTotableview1
{
    
    [self.B_LeftTableview2 initTableViewDataSourceAndDelegate:^(UITableView *tableView,NSInteger section)
     {
         NSInteger count=self.B_LeftArray2.count;
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
                 cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
             }
         }
         [cell.MctName setText:[NSString stringWithFormat:@"%@",[self.B_LeftArray2 objectAtIndex:indexPath.row]]];
         
         return cell;
     } setDidSelectRowBlock:^(UITableView *tableView,NSIndexPath *indexPath)
     {
         //        LeftCell *cell=(LeftCell*)[tableView cellForRowAtIndexPath:indexPath];
         
         if (indexPath.row ==0) {
             
             B_NeedOpenTwo2 = @"";
             [self.B_m_diquBtn setTitle:@"全城" forState:UIControlStateNormal];
             
             B_OneID2 = B_TwoID2 = @"";
             
             pageIndex=1;
             
             self.m_searchBar.text = @"";
             
             //请求产品列表
             [self loadData];
             
             [self alphaviewtap:nil];
             
         }else{
             
             B_NeedOpenTwo2 = @"NeedOpenTwo2";
             
             B_OneID2 =[NSString stringWithFormat:@"%@",[self.B_LeftArrayID2 objectAtIndex:indexPath.row]];
             
             [self B_areaSelectmerchant];
             
             [self B_DiquDataTotableview2];
             
             [self.B_MiddleTableview2 reloadData];
             
             B_middleOpened2=NO;
             
             [self B_MiddleOpenBtn2];
             
         }
         
     }];
    
    [self.B_LeftTableview2.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.B_LeftTableview2.layer setBorderWidth:0];
    
    
}

//地区二赋值
-(void) B_DiquDataTotableview2
{
    
    [self.B_MiddleTableview2 initTableViewDataSourceAndDelegate:^(UITableView *tableView,NSInteger section)
     {
         NSInteger count=self.B_MiddleArray2.count;
         return count;
         
     } setCellForIndexPathBlock:^(UITableView *tableView,NSIndexPath *indexPath)
     {
         MiddleCell *cell=[tableView dequeueReusableCellWithIdentifier:@"MiddleCell"];
         
         if (!cell)
         {
             cell=[[[NSBundle mainBundle]loadNibNamed:@"MiddleCell" owner:self options:nil]objectAtIndex:0];
             [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
         }
         
         [cell.MctName setText:[NSString stringWithFormat:@"%@",[self.B_MiddleArray2 objectAtIndex:indexPath.row]]];
         
         return cell;
     } setDidSelectRowBlock:^(UITableView *tableView,NSIndexPath *indexPath)
     {
         MiddleCell *cell=(MiddleCell*)[tableView cellForRowAtIndexPath:indexPath];
         
         
         if (indexPath.row ==0) {
             
             for (int i=0; i<self.B_LeftArrayID2.count; i++) {
                 if ([B_OneID2 isEqualToString:[self.B_LeftArrayID2 objectAtIndex:i]]) {
                     
                     [self.B_m_diquBtn setTitle:[self.B_LeftArray2 objectAtIndex:i] forState:UIControlStateNormal];
                     break;
                 }
                 
                 B_TwoID2 = @"";
                 
             }
             
             
             
         }else{
             
             [self.B_m_diquBtn setTitle:cell.MctName.text forState:UIControlStateNormal];
             B_TwoID2 =[NSString stringWithFormat:@"%@",[self.B_MiddleArrayID2 objectAtIndex:indexPath.row]];
         }
         
         
         pageIndex=1;
         
         self.m_searchBar.text = @"";
         
         //请求产品列表
         [self loadData];
         
         [self alphaviewtap:nil];
     }];
    
    [self.B_MiddleTableview2 .layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.B_MiddleTableview2 .layer setBorderWidth:0];
    
    
}

//排序赋值
-(void) B_PaixuDataTotableview
{
    
    [self.B_RightTableview initTableViewDataSourceAndDelegate:^(UITableView *tableView,NSInteger section)
     {
         NSInteger count=self.B_RightArray.count;
         return count;
         
     } setCellForIndexPathBlock:^(UITableView *tableView,NSIndexPath *indexPath)
     {
         RightCell *cell=[tableView dequeueReusableCellWithIdentifier:@"RightCell"];
         
         if (!cell)
         {
             cell=[[[NSBundle mainBundle]loadNibNamed:@"RightCell" owner:self options:nil]objectAtIndex:0];
             [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
         }
         
         [cell.MctName setText:[NSString stringWithFormat:@"%@",[self.B_RightArray objectAtIndex:indexPath.row]]];
         
         return cell;
     } setDidSelectRowBlock:^(UITableView *tableView,NSIndexPath *indexPath)
     {
         RightCell *cell=(RightCell*)[tableView cellForRowAtIndexPath:indexPath];
         
         [self.B_m_paixuBtn setTitle:cell.MctName.text forState:UIControlStateNormal];
         
         pageIndex=1;
         
         
         
         if (indexPath.row == 0) {
             
             self.B_m_latiString = @"";
             self.B_m_longtiString = @"";
             
         }else if (indexPath.row ==1)
         {
             // 经纬度 ======
             NSString *latitudeString = [CommonUtil getValueByKey:kLatitudeKey];
             NSString *lontiduteString = [CommonUtil getValueByKey:kLongitudeKey];
             
             self.B_m_latiString = [NSString stringWithFormat:@"%f",[latitudeString floatValue]];
             self.B_m_longtiString = [NSString stringWithFormat:@"%f",[lontiduteString floatValue]];
             
         }
         
         //请求产品列表
         [self loadData];
         
         [self alphaviewtap:nil];
     }];
    
    [self.B_RightTableview .layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.B_RightTableview .layer setBorderWidth:0];
    
    
}

- (void)B_LeftOpenBtn {
    
    if (B_leftOpened) {
        
        [UIView animateWithDuration:0.3 animations:^{
            self.B_m_alphaView.alpha = 0;
            
            CGRect frame=self.B_LeftTableview.frame;
            
            frame.size.height=0;
            [self.B_LeftTableview setFrame:frame];
            
            
            
        } completion:^(BOOL finished){
            
            B_leftOpened=NO;
        }];
    }else{
        
        self.B_LeftTableview.hidden = NO;
        
        [UIView animateWithDuration:0.3 animations:^{
            
            self.B_m_alphaView.alpha = 0.3;
            
            CGRect frame=self.B_LeftTableview.frame;
            frame.size.height=300;
            [self.B_LeftTableview setFrame:frame];
            
            //默认打开上次二级
            if ([B_NeedOpenTwo isEqualToString:@"NeedOpenTwo"]) {
                B_middleOpened = NO;
                [self B_MiddleOpenBtn];
            }
            
        } completion:^(BOOL finished){
            
            B_leftOpened=YES;
            
            
        }];
        
    }
    
    
}

- (void)B_MiddleOpenBtn {
    
    if (B_middleOpened) {
        
        [UIView animateWithDuration:0.3 animations:^{
            
            CGRect frame=self.B_MiddleTableview.frame;
            
            frame.size.height=0;
            [self.B_MiddleTableview setFrame:frame];
            
            
        } completion:^(BOOL finished){
            
            B_middleOpened=NO;
        }];
    }else{
        
        self.B_MiddleTableview.hidden = NO;
        
        [UIView animateWithDuration:0.3 animations:^{
            
            CGRect frame=self.B_MiddleTableview.frame;
            
            
            int fr = self.B_MiddleArray.count*44;
            if (fr>300) {
                frame.size.height=300;
            }else
            {
                frame.size.height = fr;
            }
            [self.B_MiddleTableview setFrame:frame];
            
            
            
            
        } completion:^(BOOL finished){
            
            B_middleOpened=YES;
            
            
        }];
        
    }
    
    
}

- (void)B_LeftOpenBtn2 {
    
    if (B_leftOpened2) {
        
        [UIView animateWithDuration:0.3 animations:^{
            self.B_m_alphaView.alpha = 0;
            
            CGRect frame=self.B_LeftTableview2.frame;
            
            frame.size.height=0;
            [self.B_LeftTableview2 setFrame:frame];
            
            
            
        } completion:^(BOOL finished){
            
            B_leftOpened2=NO;
        }];
    }else{
        
        self.B_LeftTableview2.hidden = NO;
        
        [UIView animateWithDuration:0.3 animations:^{
            
            self.B_m_alphaView.alpha = 0.3;
            
            CGRect frame=self.B_LeftTableview2.frame;
            frame.size.height=300;
            [self.B_LeftTableview2 setFrame:frame];
            
            //默认打开上次二级
            if ([B_NeedOpenTwo2 isEqualToString:@"NeedOpenTwo2"]) {
                B_middleOpened2 = NO;
                [self B_MiddleOpenBtn2];
            }
            
        } completion:^(BOOL finished){
            
            B_leftOpened2=YES;
            
            
        }];
        
    }
    
    
}

- (void)B_MiddleOpenBtn2 {
    
    if (B_middleOpened2) {
        
        [UIView animateWithDuration:0.3 animations:^{
            
            CGRect frame=self.B_MiddleTableview2.frame;
            
            frame.size.height=0;
            [self.B_MiddleTableview2 setFrame:frame];
            
            
        } completion:^(BOOL finished){
            
            B_middleOpened2=NO;
        }];
    }else{
        
        self.B_MiddleTableview2.hidden = NO;
        
        [UIView animateWithDuration:0.3 animations:^{
            
            CGRect frame=self.B_MiddleTableview2.frame;
            
            
            int fr = self.B_MiddleArray2.count*44;
            if (fr>300) {
                frame.size.height=300;
            }else
            {
                frame.size.height = fr;
            }
            [self.B_MiddleTableview2 setFrame:frame];
            
            
            
            
        } completion:^(BOOL finished){
            
            B_middleOpened2=YES;
            
            
        }];
        
    }
    
    
}



- (void)B_RightOpenBtn {
    
    if (B_rightOpened) {
        
        [UIView animateWithDuration:0.3 animations:^{
            
            CGRect frame=self.B_RightTableview.frame;
            
            frame.size.height=0;
            [self.B_RightTableview setFrame:frame];
            self.B_m_alphaView.alpha = 0;
            
            
        } completion:^(BOOL finished){
            
            B_rightOpened=NO;
        }];
    }else{
        
        self.B_RightTableview.hidden = NO;
        
        [UIView animateWithDuration:0.3 animations:^{
            
            CGRect frame=self.B_RightTableview.frame;
            
            
            int fr = self.B_RightArray.count*44;
            if (fr>300) {
                frame.size.height=300;
            }else
            {
                frame.size.height = fr;
            }
            [self.B_RightTableview setFrame:frame];
            
            
            self.B_m_alphaView.alpha = 0.3;
            
            
        } completion:^(BOOL finished){
            
            B_rightOpened=YES;
            
            
        }];
        
    }
    
}

- (IBAction)alphaviewtap:(id)sender
{
    B_leftOpened = YES;
    B_middleOpened = YES;
    B_leftOpened2 = YES;
    B_middleOpened2 = YES;
    B_rightOpened = YES;
    [self B_LeftOpenBtn];
    [self B_MiddleOpenBtn];
    [self B_LeftOpenBtn2];
    [self B_MiddleOpenBtn2];
    [self B_RightOpenBtn];
}

@end

