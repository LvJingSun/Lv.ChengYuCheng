//
//  LocationViewController.m
//  HuiHui
//
//  Created by mac on 13-11-19.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import "Ca_productListViewController.h"
#import "ProductDetailViewController.h"
#import "LocationCell.h"
#import "BusinessCell.h"
#import "MapViewController.h"
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
#import "HH_SearchViewController.h"

#define degreesToRadian(x) (M_PI * (x) / 180.0)

@interface Ca_productListViewController ()

@property (weak, nonatomic) IBOutlet PullTableView *m_tableView;

//@property (weak, nonatomic) IBOutlet UIView *m_seachView;

//@property (weak, nonatomic) IBOutlet UISearchBar *m_searchBar;

@property (weak, nonatomic) IBOutlet UIButton *m_defaultBtn;

@property (weak, nonatomic) IBOutlet UIButton *m_saleBtn;

@property (weak, nonatomic) IBOutlet UIButton *m_priceBtn;

@property (weak, nonatomic) IBOutlet UIButton *m_distanceBtn;

@property (weak, nonatomic) IBOutlet UIImageView *m_imgV;
// 选择价钱的按钮
@property (weak, nonatomic) IBOutlet UIButton *m_selectedPriceBtn;

@property (weak, nonatomic) IBOutlet UIView *m_backView;

@property (weak, nonatomic) IBOutlet UIView *m_productView;

@property (weak, nonatomic) IBOutlet UIView *m_merchantView;
// 显示商户的tableView
@property (weak, nonatomic) IBOutlet PullTableView *m_merchantTableView;

@property (weak, nonatomic) IBOutlet UIView *m_tempView;

@property (weak, nonatomic) IBOutlet UILabel *m_emptyLabel;

@property (weak, nonatomic) IBOutlet UIButton *registButton;

//产品
@property (weak, nonatomic) IBOutlet UIButton *m_fenleiBtn;//分类
@property (weak, nonatomic) IBOutlet UIButton *m_diquBtn;//地区
@property (weak, nonatomic) IBOutlet UIButton *m_paixuBtn;//排序
@property (weak, nonatomic) IBOutlet UIView *m_alphaView;//透明层


// 点击背景触发的事件
- (IBAction)controlTap:(id)sender;


@end

@implementation Ca_productListViewController

@synthesize m_array;

@synthesize m_productList;

@synthesize keyItems;

@synthesize m_keyDic;

@synthesize isNearestForMe;

@synthesize m_list;

@synthesize TwoID;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        m_array = [[NSMutableArray alloc]initWithCapacity:0];
        pageIndex = 1;
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

        [self.RightArray addObject:@"默认排序"];
        [self.RightArray addObject:@"销量最多"];
        [self.RightArray addObject:@"价格最高"];
        [self.RightArray addObject:@"价格最低"];
        [self.RightArray addObject:@"离我最近"];
        
        m_keyDic = [[NSMutableDictionary alloc]initWithCapacity:0];

        
        m_list = [[NSMutableArray alloc]initWithCapacity:0];
    
        dbhelp = [[DBHelper alloc] init];
        
        
        //大众点评
        DP_pageIndex = 1;
        self.DPdealsarray = [[NSMutableArray alloc]initWithCapacity:0];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setTitle:@"商品"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    // 请求网络的两参数
    self.m_order = @"desc";
    self.m_sort = @"";
    
//    self.m_searchBar.text = @"";
    
    self.m_tempView.alpha = 0.8;
    
    self.registButton.tag = 1001;
    
    // 判断经纬度
    self.m_string = @"1";
  
    self.m_backView.backgroundColor = [UIColor clearColor];
    
    // 设置导航栏的右按钮
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 40)];
    view.backgroundColor = [UIColor clearColor];
    
    //搜索
    UIButton *seachBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    seachBtn.frame = CGRectMake(10, 4, 20, 35);
    [seachBtn setImage:[UIImage imageNamed:@"bd_02.png"] forState:UIControlStateNormal];
    seachBtn.backgroundColor = [UIColor clearColor];
    [seachBtn addTarget:self action:@selector(seachBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    [view addSubview:seachBtn];
    
    UIBarButtonItem *l_barButton = [[UIBarButtonItem alloc] initWithCustomView:view];
    [self.navigationItem setRightBarButtonItem:l_barButton];
    
    
    // =====
    //    UIScrollView *scroller = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 280, 40)];
    //
    //    scroller.backgroundColor = [UIColor redColor];
    //
    //    scroller.contentSize = CGSizeMake(600, 40);
    //
    //    [view addSubview:scroller];
    //
    //
    //    self.navigationItem.titleView = view;
    
    
    
    //=========
   
    [self.m_tableView setDelegate:self];
    [self.m_tableView setDataSource:self];
    [self.m_tableView setPullDelegate:self];
    self.m_tableView.pullBackgroundColor = [UIColor whiteColor];
    self.m_tableView.useRefreshView = YES;
    self.m_tableView.useLoadingMoreView = YES;
    self.m_tableView.hidden = YES;
    
    self.m_emptyLabel.hidden = YES;
    
    // 隐藏搜索时出现的view
//    self.m_seachView.hidden = YES;
    
    self.m_selectedPriceBtn.hidden = YES;
    
    //默认不下拉
    leftOpened = middleOpened = leftOpened2 = middleOpened2 = rightOpened = NO;
    self.m_alphaView.alpha = 0;
    
    
    // 经纬度 ======
    NSString *latitudeString = [CommonUtil getValueByKey:kLatitudeKey];
    NSString *lontiduteString = [CommonUtil getValueByKey:kLongitudeKey];
    
    NSString *cityId = [CommonUtil getValueByKey:kSelectCityId];
    
    self.m_latiString = [NSString stringWithFormat:@"%f",[latitudeString floatValue]];
    self.m_longtiString = [NSString stringWithFormat:@"%f",[lontiduteString floatValue]];
    
    selectCity = cityId;
    
    // 赋值
    [self.m_fenleiBtn setTitle:self.m_titleString forState:UIControlStateNormal];
    
    //分类
    [self loadCategoryView];//加载一级类别
    [self FenleiDataTotableview1];//一级赋值

    //排序
    [self PaixuDataTotableview];//排序赋值
    
    [self.m_fenleiBtn addTarget:self action:@selector(LeftOpenBtn) forControlEvents:UIControlEventTouchUpInside];
    
    [self.m_diquBtn addTarget:self action:@selector(LeftOpenBtn2) forControlEvents:UIControlEventTouchUpInside];
    
    [self.m_paixuBtn addTarget:self action:@selector(RightOpenBtn) forControlEvents:UIControlEventTouchUpInside];
    
    //地区
    [self citySelectarea];//加载一级类别
    [self DiquDataTotableview1];//一级赋值
    [self.MiddleTableview2 reloadData];
    
    // 判断是分类的还是全部分类-来区分请求哪个数据
    if ( TwoID.length == 0 ) {
        
        self.isNearestForMe = YES;
        
        // 请求分区显示商品的数据
        [self merchantAndProductRequest];
        
    }else{
        
        self.isNearestForMe = NO;

        // 请求商品列表的接口
        [self requestProductList1];
    }
 
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
//    frame.size.height = 0.0f;
    frame = CGRectMake(0, 40, WindowSizeWidth/2, 0);
    [self.LeftTableview setFrame:frame];

    CGRect frame1 = self.MiddleTableview.frame;
//    frame1.size.height = 0.0f;
    frame1 = CGRectMake( WindowSizeWidth/2, 40,  WindowSizeWidth/2, 0);

    [self.MiddleTableview setFrame:frame1];

    CGRect frame2 = self.LeftTableview2.frame;
//    frame2.size.height = 0.0f;
    frame2 = CGRectMake(0, 40,  WindowSizeWidth/2, 0);

    [self.LeftTableview2 setFrame:frame2];

    CGRect frame3 = self.MiddleTableview2.frame;
//    frame3.size.height = 0.0f;
    frame3 = CGRectMake( WindowSizeWidth/2, 40,  WindowSizeWidth/2, 0);

    [self.MiddleTableview2 setFrame:frame3];
    
    CGRect frame4 = self.RightTableview.frame;
//    frame4.size.height = 0.0f;
    frame4 = CGRectMake(0, 40,  WindowSizeWidth, 0);

    [self.RightTableview setFrame:frame4];
    
    self.m_alphaView.alpha = 0;
    
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

- (void)seachBtnClicked{
    
//    self.m_seachView.hidden = NO;
//    
//    [self.m_searchBar becomeFirstResponder];
    
    // test 进入搜索的页面
    HH_SearchViewController *VC = [[HH_SearchViewController alloc]initWithNibName:@"HH_SearchViewController" bundle:nil];
    [self.navigationController pushViewController:VC animated:YES];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ( self.isNearestForMe ) {
        
        if ([self.dp_isfenqu isEqualToString:@"fenqu"]) {
            
            return self.m_list.count+1;
            
        }
        
        return self.m_list.count;
        
    }else{
        
        return 1;
        
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
        
    if ( self.isNearestForMe ) {
        
        if ([self.dp_isfenqu isEqualToString:@"fenqu"]&&section == self.m_list.count) {
            
                
                return self.DPdealsarray.count;
            
        }
        
        NSDictionary *dic = [self.m_list objectAtIndex:section];
        
        NSMutableArray *svcList = [dic objectForKey:@"SvcList"];
        
        NSString *moreString = [NSString stringWithFormat:@"%@",[self.m_keyDic objectForKey:[NSString stringWithFormat:@"%i",section]]];
        
        if ( [moreString isEqualToString:@"0"] ) {
            
            if ( svcList.count > 3 ) {
                
                return 4;
                
            }else{
                
                return svcList.count;
                
            }
        }else{
            
            return svcList.count;
            
        }
        
    }else{
        
//        return self.m_productList.count;
        //加上点评数据
        return self.m_productList.count+self.DPdealsarray.count;
    }
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    

        
    if ( self.isNearestForMe ) {
        
        UITableViewCell *cell = nil;
        
        if ([self.dp_isfenqu isEqualToString:@"fenqu"]&&indexPath.section == self.m_list.count) {
            
            cell = [self ProductTableView:tableView cellForRowAtIndexPath:indexPath];
            
            return cell;
            
        }else{
        
        if ( self.m_list.count != 0 ) {
  
            NSMutableDictionary *l_dic = [self.m_list objectAtIndex:indexPath.section];
            
            NSMutableArray *svcList = [l_dic objectForKey:@"SvcList"];
            
            if ( svcList.count != 0 ) {
                
                NSString *moreString = [NSString stringWithFormat:@"%@",[self.m_keyDic objectForKey:[NSString stringWithFormat:@"%li",(long)indexPath.section]]];
                
                if ( [moreString isEqualToString:@"0"] ) {
                    
                    
                    if ( svcList.count > 3 ) {
                        
                        if ( indexPath.row <= 2 ) {
                            
                            cell = [self ProductTableView:tableView cellForRowAtIndexPath:indexPath];
                            
                            return cell;
                            
                        }else{
                            
                            cell = [self MoreTableView:tableView cellForRowAtIndexPath:indexPath];
                            
                            return cell;
                            
                        }
                        
                        
                    }else{
                        
                        cell = [self ProductTableView:tableView cellForRowAtIndexPath:indexPath];
                        
                        return cell;
                        
                    }
                    
                    
                }else{
                    
                    cell = [self ProductTableView:tableView cellForRowAtIndexPath:indexPath];
                    
                    return cell;
                    
                }
                
                
                
                
            }else{
                
                return nil;
            }
        }else{
            
            return nil;
            
            }
            
        }
    }else{
        static NSString *cellIdentifier = @"LocationCellIdentifier";
        
        LocationCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if ( cell == nil ) {
            
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"LocationCell" owner:self options:nil];
            
            cell = (LocationCell *)[nib objectAtIndex:0];
            
//            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            cell.selectionStyle = UITableViewCellSelectionStyleGray;
            
        }
        
        //大众点评列表也从此添加字段
        if ( self.m_productList.count != 0 ||self.DPdealsarray.count!=0) {
            
            //大众点评列表也从此添加字段
            NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithCapacity:0];
            
            if (indexPath.row >= self.m_productList.count) {
                
                //大众点评列表数据
                dic = [self.DPdealsarray objectAtIndex:indexPath.row-self.m_productList.count];
                
                // 设置图片
                [cell setImageView:[NSString stringWithFormat:@"%@",[dic objectForKey:@"s_image_url"]]];
                // 设置cell上面的评分
                [cell setValue:[NSString stringWithFormat:@"%@",[dic objectForKey:@"0"]]];
                
                // 赋值
                cell.m_productName.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"title"]];
                cell.m_infoLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"description"]];
                cell.m_priceLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"current_price"]];
                cell.m_orignLabel.text = [NSString stringWithFormat:@"￥%@",[dic objectForKey:@"list_price"]];;
                
                // 计算label的大小坐标
                CGSize size = [cell.m_priceLabel.text sizeWithFont:[UIFont systemFontOfSize:18.0f] constrainedToSize:CGSizeMake(MAXFLOAT, 21) lineBreakMode:NSLineBreakByWordWrapping];
                
                CGSize size1 = [cell.m_orignLabel.text sizeWithFont:[UIFont systemFontOfSize:12.0f] constrainedToSize:CGSizeMake(MAXFLOAT, 21) lineBreakMode:NSLineBreakByWordWrapping];
                
                
                cell.m_priceLabel.frame = CGRectMake(cell.m_priceLabel.frame.origin.x, cell.m_priceLabel.frame.origin.y, size.width, 21);
                
                cell.m_orignLabel.frame = CGRectMake(cell.m_priceLabel.frame.origin.x + size.width + 5, cell.m_orignLabel.frame.origin.y, size1.width + 2, 21);
                
                cell.m_lineLabel.frame = CGRectMake(cell.m_priceLabel.frame.origin.x + size.width + 7, cell.m_lineLabel.frame.origin.y, size1.width + 3, 1);
                
                cell.m_distanceLabel.hidden = NO;
                if ([[dic objectForKey:@"distance"] intValue]>=1000) {
                    cell.m_distanceLabel.text = [NSString stringWithFormat:@"%@km",[NSString stringWithFormat:@"%.1f",[[dic objectForKey:@"distance"] floatValue]/1000]];
                }else{
                    //返回 m
                    cell.m_distanceLabel.text = [NSString stringWithFormat:@"%@米",[dic objectForKey:@"distance"]];
                }
                
            }else{
                
                dic = [self.m_productList objectAtIndex:indexPath.row];
                
                // 设置图片
                [cell setImageView:[NSString stringWithFormat:@"%@",[dic objectForKey:@"ApplePoster315"]]];
                // 设置cell上面的评分
                [cell setValue:[NSString stringWithFormat:@"%@",[dic objectForKey:@"Rank"]]];
                
                // 赋值
                cell.m_productName.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"ServiceName"]];
                cell.m_infoLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Detail"]];
                cell.m_priceLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Price"]];
                cell.m_orignLabel.text = [NSString stringWithFormat:@"￥%@",[dic objectForKey:@"OriginalPrice"]];;
                
                // 计算label的大小坐标
                CGSize size = [cell.m_priceLabel.text sizeWithFont:[UIFont systemFontOfSize:18.0f] constrainedToSize:CGSizeMake(MAXFLOAT, 21) lineBreakMode:NSLineBreakByWordWrapping];
                
                CGSize size1 = [cell.m_orignLabel.text sizeWithFont:[UIFont systemFontOfSize:12.0f] constrainedToSize:CGSizeMake(MAXFLOAT, 21) lineBreakMode:NSLineBreakByWordWrapping];
                
                
                cell.m_priceLabel.frame = CGRectMake(cell.m_priceLabel.frame.origin.x, cell.m_priceLabel.frame.origin.y, size.width, 21);
                
                cell.m_orignLabel.frame = CGRectMake(cell.m_priceLabel.frame.origin.x + size.width + 5, cell.m_orignLabel.frame.origin.y, size1.width + 2, 21);
                
                cell.m_lineLabel.frame = CGRectMake(cell.m_priceLabel.frame.origin.x + size.width + 7, cell.m_lineLabel.frame.origin.y, size1.width + 3, 1);
                
                cell.m_distanceLabel.hidden = YES;
                
            }
            
        }

        
        return cell;
        
    }
  
}

- (UITableViewCell *)ProductTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"LocationCellIdentifier";
    
    LocationCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"LocationCell" owner:self options:nil];
        
        cell = (LocationCell *)[nib objectAtIndex:0];
        
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
    }
    
    
    if ([self.dp_isfenqu isEqualToString:@"fenqu"]&&(self.DPdealsarray.count!=0)&&indexPath.section == self.m_list.count) {
        
        //大众点评列表也从此添加字段
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithCapacity:0];
        
        //大众点评列表数据
        dic = [self.DPdealsarray objectAtIndex:indexPath.row];
        
        // 设置图片
        [cell setImageView:[NSString stringWithFormat:@"%@",[dic objectForKey:@"s_image_url"]]];
        // 设置cell上面的评分
        [cell setValue:[NSString stringWithFormat:@"%@",[dic objectForKey:@"0"]]];
        
        // 赋值
        cell.m_productName.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"title"]];
        cell.m_infoLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"description"]];
        cell.m_priceLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"current_price"]];
        cell.m_orignLabel.text = [NSString stringWithFormat:@"￥%@",[dic objectForKey:@"list_price"]];;
        
        // 计算label的大小坐标
        CGSize size = [cell.m_priceLabel.text sizeWithFont:[UIFont systemFontOfSize:18.0f] constrainedToSize:CGSizeMake(MAXFLOAT, 21) lineBreakMode:NSLineBreakByWordWrapping];
        
        CGSize size1 = [cell.m_orignLabel.text sizeWithFont:[UIFont systemFontOfSize:12.0f] constrainedToSize:CGSizeMake(MAXFLOAT, 21) lineBreakMode:NSLineBreakByWordWrapping];
        
        
        cell.m_priceLabel.frame = CGRectMake(cell.m_priceLabel.frame.origin.x, cell.m_priceLabel.frame.origin.y, size.width, 21);
        
        cell.m_orignLabel.frame = CGRectMake(cell.m_priceLabel.frame.origin.x + size.width + 5, cell.m_orignLabel.frame.origin.y, size1.width + 2, 21);
        
        cell.m_lineLabel.frame = CGRectMake(cell.m_priceLabel.frame.origin.x + size.width + 7, cell.m_lineLabel.frame.origin.y, size1.width + 3, 1);
        
        cell.m_distanceLabel.hidden = NO;
        
        if ([[dic objectForKey:@"distance"] intValue]>=1000) {
        cell.m_distanceLabel.text = [NSString stringWithFormat:@"%@km",[NSString stringWithFormat:@"%.1f",[[dic objectForKey:@"distance"] floatValue]/1000]];
        }else{
        //返回 m
        cell.m_distanceLabel.text = [NSString stringWithFormat:@"%@米",[dic objectForKey:@"distance"]];
        }
        
        
        
    }else{
    
    if ( self.m_list.count != 0 ) {
        
        NSMutableDictionary *l_dic = [self.m_list objectAtIndex:indexPath.section];
        
        NSMutableArray *svcList = [l_dic objectForKey:@"SvcList"];
        
        NSDictionary *dic = [svcList objectAtIndex:indexPath.row];
        
        // 设置图片
        [cell setImageView:[NSString stringWithFormat:@"%@",[dic objectForKey:@"ApplePoster315"]]];
        // 设置cell上面的评分
        [cell setValue:[NSString stringWithFormat:@"%@",[dic objectForKey:@"Rank"]]];
        
        // 赋值
        cell.m_productName.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"ServiceName"]];
        cell.m_infoLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Detail"]];
        cell.m_priceLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Price"]];
        cell.m_orignLabel.text = [NSString stringWithFormat:@"￥%@",[dic objectForKey:@"OriginalPrice"]];;
        
        // 计算label的大小坐标
        CGSize size = [cell.m_priceLabel.text sizeWithFont:[UIFont systemFontOfSize:18.0f] constrainedToSize:CGSizeMake(MAXFLOAT, 21) lineBreakMode:NSLineBreakByWordWrapping];
        
        CGSize size1 = [cell.m_orignLabel.text sizeWithFont:[UIFont systemFontOfSize:12.0f] constrainedToSize:CGSizeMake(MAXFLOAT, 21) lineBreakMode:NSLineBreakByWordWrapping];
        
        cell.m_priceLabel.frame = CGRectMake(cell.m_priceLabel.frame.origin.x, cell.m_priceLabel.frame.origin.y, size.width, 21);
        
        cell.m_orignLabel.frame = CGRectMake(cell.m_priceLabel.frame.origin.x + size.width + 5, cell.m_orignLabel.frame.origin.y, size1.width + 2, 21);
        
        cell.m_lineLabel.frame = CGRectMake(cell.m_priceLabel.frame.origin.x + size.width + 7, cell.m_lineLabel.frame.origin.y, size1.width + 3, 1);
        
        cell.m_distanceLabel.hidden = YES;
        
    }
            
        
    }
    
    return cell;
    
}

- (UITableViewCell *)MoreTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"MoreProductCellIdentifier";
    
    MoreProductCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"LocationCell" owner:self options:nil];
        
        cell = (MoreProductCell *)[nib objectAtIndex:1];
        
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
    }
    
    return cell;

}

#pragma mark - UITableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    if ( self.isNearestForMe ) {
        
        UIView* l_View = [[UIView alloc] init];
        l_View.backgroundColor = [UIColor colorWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:1.0];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5,  WindowSizeWidth, 22)];
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.font = [UIFont systemFontOfSize:15.0];
        titleLabel.backgroundColor = [UIColor clearColor];
        
        // 分割线
        UIImageView *lineImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 29, WindowSizeWidth, 1)];
        lineImg.backgroundColor = [UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1.0];
        
        [l_View addSubview:lineImg];
        
        
        
        if ([self.dp_isfenqu isEqualToString:@"fenqu"]&&section ==self.m_list.count) {
            
            titleLabel.text = @"点评网合作商品";
            
            [l_View addSubview:titleLabel];
            
        }else{
            
        if ( self.m_list.count != 0 ) {

                NSDictionary *dic = [self.m_list objectAtIndex:section];
                
                NSString *str = [NSString stringWithFormat:@"%@",[dic objectForKey:@"ShopName"]];
                titleLabel.text = str;
                
            }
            
            [l_View addSubview:titleLabel];
            
        }
        return l_View;
    }else{
        
        return nil;
        
    }
    
    

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ( self.isNearestForMe ) {
        
        if ([self.dp_isfenqu isEqualToString:@"fenqu"]&&indexPath.section == self.m_list.count) {
            
                return 100.0f;

        }
        
        NSDictionary *dic = [self.m_list objectAtIndex:indexPath.section];
        
        NSMutableArray *svcList = [dic objectForKey:@"SvcList"];
        
        if ( svcList.count > 3 ) {
            
            NSString *moreString = [NSString stringWithFormat:@"%@",[self.m_keyDic objectForKey:[NSString stringWithFormat:@"%i",indexPath.section]]];
            
            if ( [moreString isEqualToString:@"0"] ) {
                
                if ( indexPath.row != 3 ) {
                    
                    return 100.0f;
                    
                }else{
                    
                    return 44.0f;
                    
                }
                
            }else{
                
                return 100.0f;
                
            }
        }else{
            
            return 100.0f;
            
        }
        
    }else{
        
        return 100.0f;
        
    }
    

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if ( self.isNearestForMe ) {
        
        return 30.0f;
        
    }else{
        
        return 0.0f;
        
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ( self.isNearestForMe ) {
        
        if ([self.dp_isfenqu isEqualToString:@"fenqu"]&&indexPath.section == self.m_list.count) {
            
                NSMutableDictionary *dic = [self.DPdealsarray objectAtIndex:indexPath.row];
                
                // 将商品的图片保存起来用于立即购买页面的显示
                [CommonUtil addValue:[NSString stringWithFormat:@"%@",[dic objectForKey:@"s_image_url"]] andKey:@"productImage"];
                
                // 点击进入商品详情
                ProductDetailViewController *VC = [[ProductDetailViewController alloc]initWithNibName:@"ProductDetailViewController" bundle:nil];
                
                VC.m_productId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"deal_id"]];
                VC.m_FromDPId  =@"1";
                
                [self.navigationController pushViewController:VC animated:YES];
            
                [tableView deselectRowAtIndexPath:indexPath animated:YES];
            
                return;
            
        }
        
        
        NSMutableDictionary *l_dic = [self.m_list objectAtIndex:indexPath.section];
        
        NSMutableArray *svcList = [l_dic objectForKey:@"SvcList"];
        
        NSDictionary *dic = [svcList objectAtIndex:indexPath.row];
        
        NSString *moreString = [NSString stringWithFormat:@"%@",[self.m_keyDic objectForKey:[NSString stringWithFormat:@"%i",indexPath.section]]];
        
        if ( [moreString isEqualToString:@"0"] ) {
            
            if ( svcList.count > 3 ) {
                
                if ( indexPath.row <= 2 ) {
                    
                    // 将商品的图片保存起来用于立即购买页面的显示
                    [CommonUtil addValue:[NSString stringWithFormat:@"%@",[dic objectForKey:@"ApplePoster315"]] andKey:@"productImage"];
                    
                    // 点击进入商品详情
                    ProductDetailViewController *VC = [[ProductDetailViewController alloc]initWithNibName:@"ProductDetailViewController" bundle:nil];
                    
                    VC.m_productId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"ServiceId"]];
                    VC.m_merchantShopId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"MerchantShopId"]];
                    
                    [self.navigationController pushViewController:VC animated:YES];
                    
                    
                }else{
                    
                    // 点击后将数据重新赋值
                    [self.m_keyDic setObject:@"1" forKey:[NSString stringWithFormat:@"%i",indexPath.section]];
                    
                    [self.m_tableView reloadData];
                    
                }
                
            }else{
                
                // 将商品的图片保存起来用于立即购买页面的显示
                [CommonUtil addValue:[NSString stringWithFormat:@"%@",[dic objectForKey:@"ApplePoster315"]] andKey:@"productImage"];
                
                // 点击进入商品详情
                ProductDetailViewController *VC = [[ProductDetailViewController alloc]initWithNibName:@"ProductDetailViewController" bundle:nil];
                
                VC.m_productId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"ServiceId"]];
                VC.m_merchantShopId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"MerchantShopId"]];
                
                [self.navigationController pushViewController:VC animated:YES];
                
            }
            
        }else{
            
            // 将商品的图片保存起来用于立即购买页面的显示
            [CommonUtil addValue:[NSString stringWithFormat:@"%@",[dic objectForKey:@"ApplePoster315"]] andKey:@"productImage"];
            
            // 点击进入商品详情
            ProductDetailViewController *VC = [[ProductDetailViewController alloc]initWithNibName:@"ProductDetailViewController" bundle:nil];
            
            VC.m_productId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"ServiceId"]];
            VC.m_merchantShopId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"MerchantShopId"]];
            
            [self.navigationController pushViewController:VC animated:YES];
            
        }
        
        
    }else{
        
        //大众点评数据
        if (indexPath.row >= self.m_productList.count) {
            
            NSMutableDictionary *dic = [self.DPdealsarray objectAtIndex:indexPath.row-self.m_productList.count];
            
            // 将商品的图片保存起来用于立即购买页面的显示
            [CommonUtil addValue:[NSString stringWithFormat:@"%@",[dic objectForKey:@"s_image_url"]] andKey:@"productImage"];
            
            // 点击进入商品详情
            ProductDetailViewController *VC = [[ProductDetailViewController alloc]initWithNibName:@"ProductDetailViewController" bundle:nil];
            
            VC.m_productId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"deal_id"]];
            VC.m_FromDPId  =@"1";
            
            [self.navigationController pushViewController:VC animated:YES];
            
        }else{
            
            NSMutableDictionary *dic = [self.m_productList objectAtIndex:indexPath.row];
            
            // 将商品的图片保存起来用于立即购买页面的显示
            [CommonUtil addValue:[NSString stringWithFormat:@"%@",[dic objectForKey:@"ApplePoster315"]] andKey:@"productImage"];
            
            // 点击进入商品详情
            ProductDetailViewController *VC = [[ProductDetailViewController alloc]initWithNibName:@"ProductDetailViewController" bundle:nil];
            
            VC.m_productId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"ServiceId"]];
            VC.m_merchantShopId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"MerchantShopId"]];
            
            [self.navigationController pushViewController:VC animated:YES];
            
        }
        
    }
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}

/*
- (IBAction)controlTap:(id)sender {
    
    [self.m_searchBar resignFirstResponder];
    
    self.m_seachView.hidden = YES;
}

#pragma mark - UISearchBarDelegate
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    
    [self hiddenNumPadDone:nil];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    [self.m_searchBar resignFirstResponder];
    
    self.m_seachView.hidden = YES;
    
    pageIndex = 1;
    
    m_pageIndex = 1;

    
    // 请求数据
    if ( self.isNearestForMe ) {
        
        [self merchantAndProductRequest];
        
    }else{
        
        [self requestProductList1];
    }
    
}

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar{
    
    [self.m_searchBar resignFirstResponder];
    
    self.m_seachView.hidden = YES;
}


*/

#pragma mark - 请求网络数据
// 商户下的商品请求数据（置顶）
- (void)merchantAndProductRequest
{
    
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
                                  [NSString stringWithFormat:@"%ld", (long)pageIndex], @"pageIndex",
                                  selectCity, @"cityId",
                                  OneID2, @"areaId",
                                  TwoID2, @"districtId",
                                  //                                  OneID, @"categoryId",
                                  TwoID,@"classId",
                                  [NSString stringWithFormat:@"%@",self.m_longtiString],@"mapX",
                                  [NSString stringWithFormat:@"%@",self.m_latiString],@"mapY",
                                  @"",@"shopName",
                                  nil];

    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"MerchantCommodityListTop.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            [SVProgressHUD dismiss];
            
            NSMutableArray *metchantShop = [json valueForKey:@"merchantShop"];
            
            if (pageIndex == 1) {
                if (metchantShop == nil || metchantShop.count == 0) {
                    [self.m_list removeAllObjects];
                    
                    self.m_tableView.hidden = YES;
                    
                    self.m_emptyLabel.hidden = NO;
                    
//                    self.m_emptyLabel.text = @"暂无商品数据！";
                    
                    
                } else {
                    
                    self.m_list = metchantShop;
                    
                    self.m_emptyLabel.hidden = YES;
                    
                }
            } else {
                if (metchantShop == nil || metchantShop.count == 0) {
                    pageIndex--;
                } else {
                    [self.m_list addObjectsFromArray:metchantShop];
                }
            }
            
            
            self.m_isLastPage = [NSString stringWithFormat:@"%@",[json valueForKey:@"IsLastPage"]];
            
            if ( [self.m_isLastPage isEqualToString:@"1"] ) {
                
                m_pageIndex = 1;
                //如果是1则表示是最后一页，请求数据

               [self merchantAndProductRequest1];
                
            }else{
                
                // 用于判断点击某一行上面的查看更多商品时用到
                [self.m_keyDic removeAllObjects];
                
                // 用于判断点击某一行上面的查看更多商品时用到
                for (int i = 0; i < self.m_list.count; i ++) {
                    
                    [self.m_keyDic setValue:@"0" forKey:[NSString stringWithFormat:@"%i",i]];
                    
                }
                
            }
         
            self.m_tableView.hidden = NO;
            
            [self.m_tableView reloadData];
            
        } else {
            if (pageIndex > 1) {
                pageIndex--;
            }
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
        
        self.m_tableView.pullLastRefreshDate = [NSDate date];
        self.m_tableView.pullTableIsRefreshing = NO;
        self.m_tableView.pullTableIsLoadingMore = NO;
        
        
    } failure:^(NSError *error) {
        if (pageIndex > 1) {
            pageIndex--;
        }
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        self.m_tableView.pullTableIsRefreshing = NO;
        self.m_tableView.pullTableIsLoadingMore = NO;
    }];
    
}

//全部数据
- (void)merchantAndProductRequest1
{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
      
        return;
    }
    
    NSString *maxPrice = @"";
    
    NSString *minPrice = @"";
    
    maxPrice = @"";
    
    minPrice = @"";
    
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
                                  [NSString stringWithFormat:@"%ld", (long)m_pageIndex], @"pageIndex",
                                  selectCity, @"cityId",
                                  OneID2, @"areaId",
                                  TwoID2, @"districtId",
                                  //                                  OneID, @"categoryId",
                                  TwoID,@"classId",
                                  [NSString stringWithFormat:@"%@",self.m_longtiString],@"mapX",
                                  [NSString stringWithFormat:@"%@",self.m_latiString],@"mapY",
                                  @"",@"shopName",
                                  nil];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"MerchantCommodityList.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            [SVProgressHUD dismiss];
            
            //对大众点评参数作处理
            [self.DPdealsarray removeAllObjects];
            
            DP_pageIndex = 1;
            
            NSMutableArray *metchantShop = [json valueForKey:@"merchantShop"];
            
            if (m_pageIndex == 1) {
                if (metchantShop == nil || metchantShop.count == 0) {
                    //                    [self.keyItems removeAllObjects];
                    if ( self.m_list.count != 0 ) {
                        
                        
                    }else{
                        
                        self.dp_isfenqu = @"fenqu";

                        [self ServicesFromDP];
                        
                        return;
                    }
                    
                } else {
                    
                    [self.m_list addObjectsFromArray: metchantShop];
                    
                    self.m_emptyLabel.hidden = YES;
                    
                    self.m_tableView.hidden = NO;
                    
                }
            } else {
                if (metchantShop == nil || metchantShop.count == 0) {
                    m_pageIndex--;
                    //添加一个分区
                    
                    self.dp_isfenqu = @"fenqu";
                    
                    [self ServicesFromDP];
                    
                    return;
                    
                    
                } else {
                    [self.m_list addObjectsFromArray:metchantShop];
                }
            }
            
            // 用于判断点击某一行上面的查看更多商品时用到
            [self.m_keyDic removeAllObjects];
            
            // 用于判断点击某一行上面的查看更多商品时用到
            for (int i = 0; i < self.m_list.count; i ++) {
                
                [self.m_keyDic setValue:@"0" forKey:[NSString stringWithFormat:@"%i",i]];
                
            }
            
            self.m_tableView.hidden = NO;
            
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

// 商品列表请求数据
- (void)requestProductList1{
    
    
    self.dp_isfenqu = @"";
    

    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
    
        return;
    }
    
    NSString *maxPrice = @"";
    
    NSString *minPrice = @"";
    
    maxPrice = @"";
    
    minPrice = @"";
    
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
                                  [NSString stringWithFormat:@"%ld", (long)m_pageIndex], @"pageIndex",
                                  selectCity, @"cityId",
                                  OneID2, @"areaId",
                                  TwoID2, @"districtId",
                                  //                                  OneID, @"categoryId",
                                  TwoID,@"classId",
                                  [NSString stringWithFormat:@"%@",self.m_order],@"order",
                                  [NSString stringWithFormat:@"%@",self.m_sort],@"sort",
                                  [NSString stringWithFormat:@"%@",self.m_longtiString],@"mapX",
                                  [NSString stringWithFormat:@"%@",self.m_latiString],@"mapY",
                                  maxPrice,@"maxPrice",
                                  minPrice,@"smlPrice",
                                  @"",@"svcName",
                                  nil];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    [SVProgressHUD showWithStatus:@"数据加载中"];//  CommodityList_1_0.ashx
    [httpClient request:@"CommodityList_1_0.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            [SVProgressHUD dismiss];
            NSMutableArray *metchantShop = [json valueForKey:@"serviceList"];
            
            //对大众点评参数作处理
            [self.DPdealsarray removeAllObjects];
           
            DP_pageIndex = 1;
            
            if (m_pageIndex == 1) {
                
                if ( self.m_productList.count != 0 ) {
                    
                    [self.m_productList removeAllObjects];

                }
                
                if (metchantShop == nil || metchantShop.count == 0) {
                    //                    [self.keyItems removeAllObjects];
                   
                    self.m_tableView.hidden = YES;
                    
                    self.m_emptyLabel.hidden = NO;
                    
                    self.m_emptyLabel.text = @"正在加载数据...";
                    
                    [self ServicesFromDP];
               
                } else {
                    
                    self.m_emptyLabel.hidden = YES;
                    
                    self.m_tableView.hidden = NO;
                    
                    //如果第一页数据小于6个，调大众点评数据接在后面
                    if (metchantShop.count <= 6) {
                        
                        [self.m_productList addObjectsFromArray: metchantShop];
                        
                        [self ServicesFromDP];
                        
                    }
                    else{
                        
                        [self.m_productList addObjectsFromArray: metchantShop];
                        
                    }
                 
                }
            } else {
                if (metchantShop == nil || metchantShop.count == 0) {
                    m_pageIndex--;
                    
                    [self ServicesFromDP];

                } else {
                    //如果最后一页数据小于6个，调大众点评数据接在后面
                    if (metchantShop.count<=6) {
                        
                        [self.m_productList addObjectsFromArray:metchantShop];
                        
                        [self ServicesFromDP];
                        
                        
                    }
                    else{
                        
                        [self.m_productList addObjectsFromArray:metchantShop];
                        
                    }
                }
            }
            
            
            self.m_tableView.hidden = NO;
            
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

#pragma mark - PullTableViewDelegate
- (void)pullTableViewDidTriggerRefresh:(PullTableView*)pullTableView {
    
    if ( self.isNearestForMe ) {
        pageIndex = 1;
        m_pageIndex = 1;
//        self.m_searchBar.text = @"";
        self.dp_isfenqu = @"";
        [self performSelector:@selector(merchantAndProductRequest) withObject:nil];
        
    }else{
        
        pageIndex = 1;
        m_pageIndex = 1;
//        self.m_searchBar.text = @"";
        [self performSelector:@selector(requestProductList1) withObject:nil];
    }

    
}

- (void)pullTableViewDidTriggerLoadMore:(PullTableView*)pullTableView {
 
    if ( self.isNearestForMe ) {
        
        if ([self.dp_isfenqu isEqualToString:@"fenqu"]) {
            
            DP_pageIndex++;
            
            [self performSelector:@selector(ServicesFromDP) withObject:nil];
            

        }else{
        
        m_pageIndex++;
        
        [self performSelector:@selector(merchantAndProductRequest1) withObject:nil];
            
        }
        
    }else{
        
        if (self.DPdealsarray.count == 0) {
            
            m_pageIndex++;
            [self performSelector:@selector(requestProductList1) withObject:nil];
            
        }else{
            DP_pageIndex++;
            [self performSelector:@selector(ServicesFromDP) withObject:nil];
        }
    }
    
}

- (IBAction)regeistMerchant:(id)sender {
    
    BusinesserlistViewController *viewController = [[BusinesserlistViewController alloc] initWithNibName:@"BusinesserlistViewController" bundle:nil];
    viewController.PorB=@"1";
    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark - 类别和区域

//产品
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
         NSInteger count=self.LeftArray.count;
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
         [cell.MctName setText:[NSString stringWithFormat:@"%@",[self.LeftArray objectAtIndex:indexPath.row]]];
         
         return cell;
     } setDidSelectRowBlock:^(UITableView *tableView,NSIndexPath *indexPath)
     {

         if (indexPath.row == 0) {
             
             NeedOpenTwo = @"";
             [self.m_fenleiBtn setTitle:@"全部分类" forState:UIControlStateNormal];
             
             OneID = TwoID = @"";
             
             pageIndex=1;
             m_pageIndex = 1;

             //请求产品列表
//             self.m_searchBar.text = @"";
             
             // 如果是全部、全城、离我最近，则请求商户分类的显示
             if ( OneID2.length == 0 && self.m_string.length != 0 ) {
                 
                 self.isNearestForMe = YES;
                 
             }else{
                 
                 self.isNearestForMe = NO;

             }

             if ( self.isNearestForMe ) {
                 
                 [self merchantAndProductRequest];

             }else{
                 
                 [self requestProductList1];

             }
             [self alphaviewtap:nil];

         }else{
             
             self.isNearestForMe = NO;
             
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
         NSInteger count=self.MiddleArray.count;
         return count;
         
     } setCellForIndexPathBlock:^(UITableView *tableView,NSIndexPath *indexPath)
     {
         MiddleCell *cell=[tableView dequeueReusableCellWithIdentifier:@"MiddleCell"];
         
         if (!cell)
         {
             cell=[[[NSBundle mainBundle]loadNibNamed:@"MiddleCell" owner:self options:nil]objectAtIndex:0];
             [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
         }
         
         [cell.MctName setText:[NSString stringWithFormat:@"%@",[self.MiddleArray objectAtIndex:indexPath.row]]];
         
         return cell;
     } setDidSelectRowBlock:^(UITableView *tableView,NSIndexPath *indexPath)
     {
         MiddleCell *cell=(MiddleCell*)[tableView cellForRowAtIndexPath:indexPath];
         
         if (indexPath.row ==0) {
             
             for (int i=0; i<self.LeftArrayID.count; i++) {
                 if ([OneID isEqualToString:[self.LeftArrayID objectAtIndex:i]]) {
                     
                [self.m_fenleiBtn setTitle:[self.LeftArray objectAtIndex:i] forState:UIControlStateNormal];
                    break;
                 }
                 
                 TwoID = OneID;

                 //类别就传一级ID；
             }
             
         }else{

             [self.m_fenleiBtn setTitle:cell.MctName.text forState:UIControlStateNormal];
             
             TwoID =[NSString stringWithFormat:@"%@",[self.MiddleArrayID objectAtIndex:indexPath.row]];

         }
         
         pageIndex = 1;
         
         m_pageIndex = 1;


         //请求产品列表
//         self.m_searchBar.text = @"";

         if ( self.isNearestForMe ) {
             
             [self merchantAndProductRequest];
             
         }else{
             
             [self requestProductList1];
             
         }
         
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
         NSInteger count=self.LeftArray2.count;
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
         [cell.MctName setText:[NSString stringWithFormat:@"%@",[self.LeftArray2 objectAtIndex:indexPath.row]]];
         
         return cell;
     } setDidSelectRowBlock:^(UITableView *tableView,NSIndexPath *indexPath)
     {
         //        LeftCell *cell=(LeftCell*)[tableView cellForRowAtIndexPath:indexPath];
         
         if (indexPath.row ==0) {
             
             NeedOpenTwo2 = @"";
             [self.m_diquBtn setTitle:@"全城" forState:UIControlStateNormal];
             
             OneID2 = TwoID2 = @"";
             
             pageIndex=1;
             m_pageIndex = 1;

//             self.m_searchBar.text = @"";
             
             // 如果是全部、全城、离我最近，则请求商户分类的显示
             if ( TwoID.length == 0 && self.m_string.length != 0 ) {
                 
                 self.isNearestForMe = YES;
                 
             }else{
                 
                 self.isNearestForMe = NO;
                 
             }

             //请求产品列表
             if ( self.isNearestForMe ) {
                 
                 [self merchantAndProductRequest];
                 
             }else{
                 
                 [self requestProductList1];
                 
             }
             
             [self alphaviewtap:nil];

         }else{
             
             self.isNearestForMe = NO;

             NeedOpenTwo2 = @"NeedOpenTwo2";
             
             OneID2 =[NSString stringWithFormat:@"%@",[self.LeftArrayID2 objectAtIndex:indexPath.row]];

             [self areaSelectmerchant];
         
             [self DiquDataTotableview2];
         
             [self.MiddleTableview2 reloadData];
         
             middleOpened2=NO;
         
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
         NSInteger count=self.MiddleArray2.count;
         return count;
         
     } setCellForIndexPathBlock:^(UITableView *tableView,NSIndexPath *indexPath)
     {
         MiddleCell *cell=[tableView dequeueReusableCellWithIdentifier:@"MiddleCell"];
         
         if (!cell)
         {
             cell=[[[NSBundle mainBundle]loadNibNamed:@"MiddleCell" owner:self options:nil]objectAtIndex:0];
             [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
         }
         
         [cell.MctName setText:[NSString stringWithFormat:@"%@",[self.MiddleArray2 objectAtIndex:indexPath.row]]];
         
         return cell;
     } setDidSelectRowBlock:^(UITableView *tableView,NSIndexPath *indexPath)
     {
         MiddleCell *cell=(MiddleCell*)[tableView cellForRowAtIndexPath:indexPath];
         
         
         if (indexPath.row ==0) {
             
             for (int i=0; i<self.LeftArrayID2.count; i++) {
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
         
         
         pageIndex=1;
         m_pageIndex = 1;

//         self.m_searchBar.text = @"";

         //请求产品列表
         if ( self.isNearestForMe ) {
             
             [self merchantAndProductRequest];
             
         }else{
             
             [self requestProductList1];
             
         }
         
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
         
         pageIndex=1;
         
         m_pageIndex = 1;
         
         
         if (indexPath.row == 0) {
             
             self.isNearestForMe = NO;
             
             self.m_string = @"";
             
             self.m_order = @"";
             self.m_sort = @"";
             self.m_latiString = @"";
             self.m_longtiString = @"";
             
             //请求产品列表
             [self requestProductList1];
             
         }else if (indexPath.row ==1)
         {
             
             self.isNearestForMe = NO;
             self.m_string = @"";

             self.m_order = @"desc";//降序
             self.m_sort = @"buyNum";
             self.m_latiString = @"";
             self.m_longtiString = @"";
             
             //请求产品列表
             [self requestProductList1];
             
         }else if (indexPath.row ==2)
         {
             
             self.isNearestForMe = NO;
             self.m_string = @"";

             self.m_order = @"desc";//降序
             self.m_sort = @"Price";
             self.m_latiString = @"";
             self.m_longtiString = @"";
             
             //请求产品列表
             [self requestProductList1];

         }else if (indexPath.row ==3)
         {
             
             self.isNearestForMe = NO;
             self.m_string = @"";

             self.m_order = @"asc";
             self.m_sort = @"Price";
             self.m_latiString = @"";
             self.m_longtiString = @"";
             
             //请求产品列表
             [self requestProductList1];
             
         }else if (indexPath.row ==4)
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
             
             // 判断如果分类为全部并且地区为全城、离我最近的时候按商户分类显示
             if ( OneID2.length == 0 && TwoID.length == 0 ) {
                 self.isNearestForMe = YES;
                 
                 // 离我最近时请求分区的数据
                 [self merchantAndProductRequest];
                 
             }else{
                 
                 self.isNearestForMe = NO;
                 
                 // 离我最近时请求分区的数据
                 [self requestProductList1];
             }
         }
         
         [self alphaviewtap:nil];
     }];
    
    [self.RightTableview.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.RightTableview.layer setBorderWidth:0];
    
}

- (void)LeftOpenBtn {
    
    if (leftOpened) {
        
        [UIView animateWithDuration:0.3 animations:^{
            self.m_alphaView.alpha = 0;

            CGRect frame=self.LeftTableview.frame;
            frame.size.height=0;
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
            frame.size.height=0;
            [self.MiddleTableview setFrame:frame];
            
        } completion:^(BOOL finished){
            
            middleOpened=NO;
        }];
    }else{
        
        self.MiddleTableview.hidden = NO;

        [UIView animateWithDuration:0.3 animations:^{
            

            CGRect frame=self.MiddleTableview.frame;
            
            int fr = self.MiddleArray.count*44;
            if (fr>300) {
                frame.size.height=300;
            }else
            {
                frame.size.height = fr;
            }
            [self.MiddleTableview setFrame:frame];
            
        } completion:^(BOOL finished){
            
            middleOpened=YES;
            
        }];
        
    }
    
}

- (void)LeftOpenBtn2 {
    
    
    if (leftOpened2) {
        
        [UIView animateWithDuration:0.3 animations:^{
            self.m_alphaView.alpha = 0;
            
            CGRect frame=self.LeftTableview2.frame;
            
            frame.size.height=0;
            [self.LeftTableview2 setFrame:frame];
            
        } completion:^(BOOL finished){
            
            leftOpened2=NO;
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
            
            CGRect frame=self.MiddleTableview2.frame;
            
            frame.size.height=0;
            [self.MiddleTableview2 setFrame:frame];
            
            
        } completion:^(BOOL finished){
            
            middleOpened2=NO;
        }];
    }else{
        
        self.MiddleTableview2.hidden = NO;

        [UIView animateWithDuration:0.3 animations:^{
            
            CGRect frame=self.MiddleTableview2.frame;
            
            
            int fr = self.MiddleArray2.count*44;
            if (fr>300) {
                frame.size.height=300;
            }else
            {
                frame.size.height = fr;
            }
            [self.MiddleTableview2 setFrame:frame];
            
        } completion:^(BOOL finished){
            
            middleOpened2=YES;
            
            
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







//大众点评开发数据
-(void)ServicesFromDP

{
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    NSString *url = @"v1/deal/find_deals";
    
    NSString *city =[CommonUtil getValueByKey:kSelectCityName];//城市
    
    NSString *category;

    if ([self.m_fenleiBtn.titleLabel.text isEqualToString:@"电影院"]){
    category = @"院线影院";
    }
    else{
    category = self.m_fenleiBtn.titleLabel.text;//类别
    }

    
    
    
    float latitude = [[CommonUtil getValueByKey:kLatitudeKey] floatValue];
    float longitude = [[CommonUtil getValueByKey:kLongitudeKey] floatValue];
    
    if (latitude == 0.000000&&longitude == 0.000000) {
        
        latitude = 31.3;
        longitude = 120.6;
    }
    
    int sort = 0;
    
    if ( [self.m_paixuBtn.titleLabel.text isEqualToString:@"默认排序"])//排序)
    {
        sort = 1;
        
        
    }else if ( [self.m_paixuBtn.titleLabel.text isEqualToString:@"销量最多"])
    {
        sort = 4;
        
        
    }else if ( [self.m_paixuBtn.titleLabel.text isEqualToString:@"价格最高"])
    {
        sort = 3;
        
        
    }else if ( [self.m_paixuBtn.titleLabel.text isEqualToString:@"价格最低"])
    {
        sort = 2;
        
        
    }else if ( [self.m_paixuBtn.titleLabel.text isEqualToString:@"离我最近"])
    {
        sort = 7;
        
    }
    
    NSString * params;
    
    if ([self.m_diquBtn.titleLabel.text isEqualToString:@"全城"]) {
        
        // 判断是否查找关键字
        
//        if ([self.m_searchBar.text isEqualToString:@""]) {
//            // 没要关键字
//            if ([self.m_fenleiBtn.titleLabel.text isEqualToString:@"全部分类"]) {
//                
//                params= [NSString stringWithFormat:@"city=%@&latitude=%f&longitude=%f&radius=-1&sort=%d&page=%d&limit=20",city,latitude,longitude,sort,DP_pageIndex];
//                
//            }else{
//            
//            params= [NSString stringWithFormat:@"city=%@&latitude=%f&longitude=%f&radius=-1&category=%@&sort=%d&page=%d&limit=20",city,latitude,longitude,category,sort,DP_pageIndex];
//            }
//            
//        }else{
//            
//            // 有关键字的情况
//            params= [NSString stringWithFormat:@"city=%@&latitude=%f&longitude=%f&radius=-1&category=%@&keyword=%@&sort=%d&page=%d&limit=20",city,latitude,longitude,category,self.m_searchBar.text,sort,DP_pageIndex];
//            
//        }

        
        if ([self.m_fenleiBtn.titleLabel.text isEqualToString:@"全部分类"]) {
            
            params= [NSString stringWithFormat:@"city=%@&latitude=%f&longitude=%f&radius=-1&sort=%d&page=%d&limit=20",city,latitude,longitude,sort,DP_pageIndex];
            
        }else{
            
            params= [NSString stringWithFormat:@"city=%@&latitude=%f&longitude=%f&radius=-1&category=%@&sort=%d&page=%d&limit=20",city,latitude,longitude,category,sort,DP_pageIndex];
        }
        
        
    }else{
        
//        if ([self.m_searchBar.text isEqualToString:@""]) {
//            
//            if ([self.m_fenleiBtn.titleLabel.text isEqualToString:@"全部分类"]) {
//                params= [NSString stringWithFormat:@"city=%@&latitude=%f&longitude=%f&radius=-1&region=%@&sort=%d&page=%d&limit=20",city,latitude,longitude,self.m_diquBtn.titleLabel.text,sort,DP_pageIndex];
//                
//            }else{
//                params= [NSString stringWithFormat:@"city=%@&latitude=%f&longitude=%f&radius=-1&category=%@&region=%@&sort=%d&page=%d&limit=20",city,latitude,longitude,category,self.m_diquBtn.titleLabel.text,sort,DP_pageIndex];
//            }
//            
//        }else{
//                params= [NSString stringWithFormat:@"city=%@&latitude=%f&longitude=%f&radius=-1&region=%@&category=%@&keyword=%@&sort=%d&page=%d&limit=20",city,latitude,longitude,self.m_diquBtn.titleLabel.text,self.m_searchBar.text,category,sort,DP_pageIndex];
//            
//        }
        
        if ([self.m_fenleiBtn.titleLabel.text isEqualToString:@"全部分类"]) {
            params= [NSString stringWithFormat:@"city=%@&latitude=%f&longitude=%f&radius=-1&region=%@&sort=%d&page=%d&limit=20",city,latitude,longitude,self.m_diquBtn.titleLabel.text,sort,DP_pageIndex];
            
        }else{
            params= [NSString stringWithFormat:@"city=%@&latitude=%f&longitude=%f&radius=-1&category=%@&region=%@&sort=%d&page=%d&limit=20",city,latitude,longitude,category,self.m_diquBtn.titleLabel.text,sort,DP_pageIndex];
        }

        
        
    }
    
    
    //结果排序，1:默认，2:价格低优先，3:价格高优先，4:购买人数多优先，5:最新发布优先，6:即将结束优先，7:离经纬度坐标距离近优先
    
    NSLog(@"%@",params);
    
    [[[AppDelegate instance] dpapi] requestWithURL:url paramsString:params delegate:self];
    
    
}



- (void)request:(DPRequest *)request didFailWithError:(NSError *)error {
    
    [SVProgressHUD dismiss];
    
    if (DP_pageIndex > 1) {
        DP_pageIndex--;
    }
    
    if (self.m_productList.count == 0) {
        
        self.m_tableView.hidden = YES;
        
        self.m_emptyLabel.hidden = NO;
        
        self.m_emptyLabel.text = @"暂无商品数据！";
        
    }
    
//    [SVProgressHUD showErrorWithStatus:@"请求失败"];
    
    self.m_tableView.pullTableIsRefreshing = NO;
    self.m_tableView.pullTableIsLoadingMore = NO;
    
}

- (void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result {
    
    
    NSString * success = [result valueForKey:@"status"];
    
    if ([success isEqualToString:@"OK"]) {
        
        [SVProgressHUD dismiss];
        
        NSMutableArray *metchantShop = [result valueForKey:@"deals"];
        
        if (DP_pageIndex == 1) {
            
            if (metchantShop == nil || metchantShop.count == 0) {
                
                //暂无大众点评数据；
                
                if (self.m_productList.count==0) {
                    
                    self.m_tableView.hidden = YES;
                    
                    self.m_emptyLabel.hidden = NO;
                
                    self.m_emptyLabel.text = @"暂无商品数据！";
                    
                    self.m_tableView.pullLastRefreshDate = [NSDate date];
                    self.m_tableView.pullTableIsRefreshing = NO;
                    self.m_tableView.pullTableIsLoadingMore = NO;
                    
                    return;

                }
                

            } else {
                
                
                // =========================
                // 当pageIndex = 1 时 如果数组有值则将数组清空再重新赋值
                if ( self.DPdealsarray.count != 0 ) {
                    
                    [self.DPdealsarray removeAllObjects];
                    
                }
                
                if ( metchantShop.count != 0 ) {
                    
                    for (int i = 0; i < metchantShop.count; i++) {
                        
                        NSDictionary *dic = [metchantShop objectAtIndex:i];
                        
                        NSString *price = [NSString stringWithFormat:@"%@",[dic objectForKey:@"current_price"]];
                        
                        float priceValue = [price floatValue];
                        
                        if ( priceValue != 0.000000 ) {
                            
                            [self.DPdealsarray addObject:dic];
                            
                        }
                        
                    }
                    
                }
                
                // =========================

                
                
                
                
                

//                    self.DPdealsarray = metchantShop;
                
                
                
                
                    
                    self.m_emptyLabel.hidden = YES;
                    
                    self.m_tableView.hidden = NO;
    
            }
        } else {
            if (metchantShop == nil || metchantShop.count == 0) {
                
                DP_pageIndex--;
                
            } else {
                
//                [self.DPdealsarray addObjectsFromArray:metchantShop];
                
                
                // =========================
                // 当pageIndex != 1 时 如果数组有值则直接加入数组

                if ( metchantShop.count != 0 ) {
                    
                    for (int i = 0; i < metchantShop.count; i++) {
                        
                        NSDictionary *dic = [metchantShop objectAtIndex:i];
                        
                        NSString *price = [NSString stringWithFormat:@"%@",[dic objectForKey:@"current_price"]];
                        
                        float priceValue = [price floatValue];
                        
                        if ( priceValue != 0.000000 ) {
                            
                            [self.DPdealsarray addObject:dic];
                            
                        }
                        
                    }
                    
                }
                
                // =========================

            }
        }
        
        
        self.m_tableView.hidden = NO;
        
        [self.m_tableView reloadData];
        
    } else {
        if (DP_pageIndex > 1) {
            DP_pageIndex--;
        }
//        NSString *msg = [request valueForKey:@"msg"];
//        [SVProgressHUD showErrorWithStatus:msg];
    }
    self.m_tableView.pullLastRefreshDate = [NSDate date];
    self.m_tableView.pullTableIsRefreshing = NO;
    self.m_tableView.pullTableIsLoadingMore = NO;
    
    
}


@end
