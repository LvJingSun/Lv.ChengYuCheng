//
//  ProductDetailViewController.m
//  HuiHui
//
//  Created by mac on 13-11-22.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import "ProductDetailViewController.h"

#import "ProductDetailCell.h"

#import "CommentViewController.h"

#import "ProductBigViewController.h"

#import "MapViewController.h"

#import "ShopListViewController.h"

#import "SubmitOrderViewController.h"

#import "CommonUtil.h"

#import "SVProgressHUD.h"

#import "AppDelegate.h"

#import "PaymentQueViewController.h"

#import "UIImageView+AFNetworking.h"

#import "PayStyleViewController.h"

#import "ContactMerchantViewController.h"

#import "InsurecountViewController.h"

#import "DPbuyViewController.h"

#import "ExplainViewController.h"

#import "InviteViewController.h"

#import "SharetoHuiHuiViewController.h"

#import "Sharetofriend.h"

#import "ShopCartViewController.h"

@interface ProductDetailViewController ()

@property (weak, nonatomic) IBOutlet UITableView *m_tableView;

@property (strong, nonatomic) IBOutlet UIView *m_sectionView;

@property (weak, nonatomic) IBOutlet UILabel *m_priceLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_totalPrice;

@property (strong, nonatomic) IBOutlet UIView *m_showView;

@property (weak, nonatomic) IBOutlet UIButton *m_buynowButton;

@property (weak, nonatomic) IBOutlet UIButton *m_joinShopcarBtn;

@property (weak, nonatomic) IBOutlet UIButton *HuiHuiFri;

@property (weak, nonatomic) IBOutlet UIButton *HuiHuiDyn;

@property (weak, nonatomic) IBOutlet UIButton *m_cartShopBtn;

// 联系卖家按钮触发的事件
- (IBAction)contactMerchant:(id)sender;

// 立即购买
- (IBAction)buyNow:(id)sender;
// 加入购物车
- (IBAction)addShopCart:(id)sender;
// 分享
- (IBAction)shareBtnClicked:(id)sender;
// 取消
- (IBAction)cancelShare:(id)sender;
// 进入购物车的按钮触发的事件
- (IBAction)gotoShopCart:(id)sender;

@end

@implementation ProductDetailViewController

@synthesize m_CommonBanner;

@synthesize m_productList;

@synthesize m_itemsDic;

@synthesize m_values;

@synthesize m_Funtions;

@synthesize m_keyTimes;

@synthesize m_titleBtn;

@synthesize m_typeString;

//@synthesize m_webDic;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        m_productList = [[NSMutableArray alloc]initWithCapacity:0];
        
        m_itemsDic = [[NSMutableDictionary alloc]initWithCapacity:0];
        
        m_values = [[NSArray alloc]init];

        m_Funtions = [[NSArray alloc]init];
        
        m_keyTimes = [[NSArray alloc]init];
        
//        m_webDic = [[NSMutableDictionary alloc]initWithCapacity:0];
        
        current = 0;
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (![self.ruKou isEqualToString:@"normal"]) {
        
//        self.m_addcarBtn.hidden = YES;
        
    }

    [self setTitle:@"商品详情"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    // 初始化控件
    YKCommonBanner *commonBanner = [[YKCommonBanner alloc]initWithFrame:CGRectMake(5, 5, WindowSizeWidth - 10, 250) withArray:nil withType:@"1"];
    
    commonBanner.delegate = self;
    commonBanner.backgroundColor = [UIColor clearColor];
    self.m_CommonBanner = commonBanner;

    self.m_tableView.tableHeaderView = self.m_CommonBanner;
    
    // 评价为0
    self.m_countString = @"1";
    
    // 设置tableView的footerView
    UIView *l_view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WindowSizeWidth, 10)];
    l_view.backgroundColor = [UIColor clearColor];
    
    self.m_tableView.tableFooterView = l_view;

    self.m_tableView.hidden = YES;
    
    self.m_sectionView.hidden = YES;
    
    self.m_cartShopBtn.hidden = YES;
    
    
    // 初始化三个用于动画的数组
    NSArray *array = [[NSArray alloc]initWithObjects:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f, 0.01f, 1.0f)],[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.0f)],[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9f, 0.9f, 1.0f)],[NSValue valueWithCATransform3D:CATransform3DIdentity], nil];
    
    NSArray *keyTimes = [[NSArray alloc]initWithObjects:@"0.2f",@"0.5f", @"0.75f", @"1.0f", nil];
    
    NSArray *funtions = [[NSArray alloc]initWithObjects:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                         [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                         [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut], nil];
    
    self.m_values = array;
    
    self.m_keyTimes = keyTimes;
    
    self.m_Funtions = funtions;

    
    //是否来自点评
    // 请求网络
    if ([self.m_FromDPId isEqualToString:@"1"]){
        
        dpapinum = 0;
        
        [self getDatadetailFromDP];
      
        // 来自大众点评的不能进行收藏,只能进行分享
         [self setRightButtonWithTitle:@"分享" action:@selector(rightClicked)];
        
        
    }else{
        
        [self requestProductDetail];
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 90, 44)];

        view.backgroundColor = [UIColor clearColor];
        
        // 收藏
        UIButton *l_button = [UIButton buttonWithType:UIButtonTypeCustom];
        [l_button setFrame:CGRectMake(0, 7, 30, 30)];
        l_button.backgroundColor = [UIColor clearColor];
        [l_button addTarget:self action:@selector(favoriteClicked) forControlEvents:UIControlEventTouchUpInside];
        
        self.m_titleBtn = l_button;
        
        // 分享
        UIButton *_button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button setFrame:CGRectMake(30, 8, 30, 30)];
        _button.backgroundColor = [UIColor clearColor];
        [_button setBackgroundImage:[UIImage imageNamed:@"huihui_share.png"] forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(rightClicked) forControlEvents:UIControlEventTouchUpInside];
        
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake(60, 8, 30, 30)];
        btn.backgroundColor = [UIColor clearColor];
        [btn setBackgroundImage:[UIImage imageNamed:@"Product_shopCart.png"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(gotoShopCart:) forControlEvents:UIControlEventTouchUpInside];

        [view addSubview:btn];
        
        // 来自城与城的商品数据可分享可收藏
        [view addSubview:l_button];
        
        [view addSubview:_button];
        
        
        UIBarButtonItem *_barButton = [[UIBarButtonItem alloc] initWithCustomView:view];
        [self.navigationItem setRightBarButtonItem:_barButton];

    }

    //圆角
    [self.HuiHuiDyn.layer setMasksToBounds:YES];
    [self.HuiHuiDyn.layer setCornerRadius:10];
    
    //圆角
    [self.HuiHuiFri.layer setMasksToBounds:YES];
    [self.HuiHuiFri.layer setCornerRadius:10];

    // 初始化webView
    UIWebView *webview = [[UIWebView alloc]initWithFrame:CGRectMake(20, 45, WindowSizeWidth - 40, 100)];
    webview.delegate = self;
    webview.tag = 100;
    self.m_detailsWebView = webview;
 
    UIWebView *webview1 = [[UIWebView alloc]initWithFrame:CGRectMake(20, 45, WindowSizeWidth - 40, 100)];
    webview1.delegate = self;
    webview1.tag = 101;
    self.m_specialWebView = webview1;
    
    // 设置分享view的中心位置
    self.m_showView.center = self.view.center;
    
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];

}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];

    [self getIsMemDarenORIsResDaren];
    
    [SVProgressHUD dismiss];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    //终断点评请求，防止闪退；
    if (self.m_tableView.hidden) {
        [[[AppDelegate instance] dpapi] cancleAPI];
    }
    [SVProgressHUD dismiss];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)leftClicked{
    
    [self goBack];
    
}

- (void)rightClicked{
    
    [self.view addSubview:self.m_showView];
    
    // 动画
    CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    popAnimation.duration = 0.4;
    popAnimation.values = self.m_values;
    popAnimation.keyTimes = self.m_keyTimes;
    popAnimation.timingFunctions = self.m_Funtions;
    
    [self.m_showView.layer addAnimation:popAnimation forKey:nil];
    
}

- (void)favoriteClicked{
    
    // 请求数据
    [self favoriteRequest];

}

- (void)favoriteRequest{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    //  optionType	0：取消；1：收藏； 商户ID默认：0
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,     @"memberId",
                           key,   @"key",
                           [NSString stringWithFormat:@"%@",self.m_productId],@"serviceId",
                           @"0",@"merchantId",
                           @"0",@"merchantShopId",
                           [NSString stringWithFormat:@"%@",self.m_typeString],@"optionType",
                           nil];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"Favorites.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showSuccessWithStatus:msg];
            
            // 判断是取消收藏还是收藏的操作
            if ( [self.m_typeString isEqualToString:@"0"] ) {
                
                self.m_typeString = @"1";
                
                // 收藏商品
                [self.m_titleBtn setImage:[UIImage imageNamed:@"favorite_no.png"] forState:UIControlStateNormal];
                
                
            }else if ( [self.m_typeString isEqualToString:@"1"] ) {
                
                self.m_typeString = @"0";
                
                // 收藏商品
                [self.m_titleBtn setImage:[UIImage imageNamed:@"favorite.png"] forState:UIControlStateNormal];
                
            }else{
                
                
                
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

// 请求网络
- (void)requestProductDetail{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        return;
    }
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  memberId,     @"memberId",
                                  [NSString stringWithFormat:@"%@",self.m_productId],   @"serviceId",
                                  [NSString stringWithFormat:@"%@",self.m_merchantShopId],@"merchantShopId",
                                  nil];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"ServiceDetail_1_0.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            [SVProgressHUD dismiss];
                        
            self.m_itemsDic = [json valueForKey:@"Svc"];

            // 将商品的图片保存起来用于立即购买页面的显示
            [CommonUtil addValue:[NSString stringWithFormat:@"%@",[self.m_itemsDic objectForKey:@"SmlPoster"]] andKey:@"productImage"];
            [self.m_productList addObjectsFromArray:[self.m_itemsDic objectForKey:@"Other"]];
            [self.m_CommonBanner initScollerView:self.m_itemsDic From:@"CC"];
            self.m_tableView.tableHeaderView = self.m_CommonBanner;
            self.m_totalPrice.text = [NSString stringWithFormat:@"%@元",[self.m_itemsDic objectForKey:@"Price"]];
            // 商品介绍
            self.m_productIntro = [NSString stringWithFormat:@"%@",[self.m_itemsDic objectForKey:@"Introduction"]];
            
            if ( self.m_productIntro.length == 0 ) {
                self.m_productIntro = @"无";
            }
            
            // 特别提示
            self.m_PromptmString = [NSString stringWithFormat:@"%@",[self.m_itemsDic objectForKey:@"Explain"]];
            if ( self.m_PromptmString.length == 0 ) {
                self.m_PromptmString = @"无";
            }
            
            self.m_tableView.hidden = NO;
            self.m_sectionView.hidden = NO;
            
            self.m_buynowButton.hidden = NO;
//            self.m_addcarBtn.hidden = NO;

            // 是否收藏的字段 0否；1是
            NSString *string = [NSString stringWithFormat:@"%@",[self.m_itemsDic objectForKey:@"IsFavorites"]];
            
            if ( [string isEqualToString:@"0"] ) {
                // 未收藏的话则进行的是收藏的操作
                self.m_typeString = @"1";
                // 表示未收藏
                [self.m_titleBtn setImage:[UIImage imageNamed:@"favorite_no.png"] forState:UIControlStateNormal];
                
            }else if ( [string isEqualToString:@"1"] ){
                // 已收藏的话则进行的是取消的操作
                self.m_typeString = @"0";
                // 表示已经收藏
                [self.m_titleBtn setImage:[UIImage imageNamed:@"favorite.png"] forState:UIControlStateNormal];

            }
        
            // 刷新tableView
            [self.m_tableView reloadData];

            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
            
            [self setRightButtonWithNormalImage:@"" action:nil];
            
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}

// 加载前设置html的字体大小
- (NSString *)htmlString:(NSString *)aString{
  
    NSString *BookStr = [NSString stringWithFormat:@"<html> \n"
                         "<head> \n"
                         "<style type=\"text/css\"> \n"
                         "body {margin:0;font-size: %f;}\n"
                         "</style> \n"
                         "</head> \n"
                         "<body>%@</body> \n"
                         "</html>",12.0,aString];

    return BookStr;
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 5 + self.m_productList.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = nil;
    
    if ( indexPath.row == 0 ) {
        
        cell = [self tableViewOne:tableView cellForRowAtIndexPath:indexPath];

    }else if ( indexPath.row == 1 ){
        
        cell = [self tableViewTwo:tableView cellForRowAtIndexPath:indexPath];
   
    }else if ( indexPath.row == 2 ){
        
        cell = [self tableViewThree:tableView cellForRowAtIndexPath:indexPath];
   
    }else if ( indexPath.row == 3 ){
        
        cell = [self tableViewFour:tableView cellForRowAtIndexPath:indexPath];
   
    }else if ( indexPath.row == 4 ){
        
        cell = [self tableViewFive:tableView cellForRowAtIndexPath:indexPath];
    
    }else {
        
        cell = [self tableViewLast:tableView cellForRowAtIndexPath:indexPath];
    
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

// 第一行显示的数据
- (UITableViewCell *)tableViewOne:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"ProductDetailCellIdentifier";
    
    ProductDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"ProductDetailCell" owner:self options:nil];
        
        cell = (ProductDetailCell *)[nib objectAtIndex:0];
        
        cell.backgroundColor = [UIColor clearColor];

    }

    //大众点评第一行
    if ([self.m_FromDPId isEqualToString:@"1"]) {
        
        
        // 赋值 图标的显示 随时退
        if (  [[NSString stringWithFormat:@"%@",[[self.m_itemsDic objectForKey:@"restrictions"] objectForKey:@"is_refundable"]] isEqualToString:@"1"] ) {
            
            cell.m_randomImgV.image = [UIImage imageNamed:@"xq_gou.png"];
            
            cell.m_anyTimeLabel.text = @"支持随时退";
            
        }else{
            
            cell.m_randomImgV.image = [UIImage imageNamed:@"red_wrong.png"];
            
            cell.m_anyTimeLabel.text = @"不支持随时退";
        }
        
        
        // 过期
        if (  [[NSString stringWithFormat:@"%@",[[self.m_itemsDic objectForKey:@"restrictions"] objectForKey:@"is_refundable"]] isEqualToString:@"1"] ) {
    
            cell.m_ExpiredImagV.image = [UIImage imageNamed:@"xq_gou.png"];
        
            cell.m_expiredLabek.text = @"支持过期退";
        
        }else{
        
        cell.m_ExpiredImagV.image = [UIImage imageNamed:@"red_wrong.png"];
        
        cell.m_expiredLabek.text = @"不支持过期退";
        
        }
        
        // 预约
        if ( [[NSString stringWithFormat:@"%@",[[self.m_itemsDic objectForKey:@"restrictions"] objectForKey:@"is_reservation_required"]] isEqualToString:@"1"]  ) {
            
            cell.m_ReservationImgV.image = [UIImage imageNamed:@"xq_time.png"];
            
            cell.m_reserLabel.text = @"需预约";
            
        }else{
            
            cell.m_ReservationImgV.image = [UIImage imageNamed:@"xq_time_grey.png"];
            
            cell.m_reserLabel.text = @"不需预约";
            
        }
        
        cell.m_saled.text = [NSString stringWithFormat:@"已售%@份",[self.m_itemsDic objectForKey:@"purchase_count"]];
        cell.m_saled.text = [cell.m_saled.text stringByReplacingOccurrencesOfString:@"(null)" withString:@""];

        
        
//        cell.m_saled.frame = CGRectMake(cell.m_saled.frame.origin.x, 76, cell.m_saled.frame.size.width, cell.m_saled.frame.size.height);
        
        cell.m_remain.hidden = YES;
        
        cell.m_time.text = [NSString stringWithFormat:@"截止%@结束",[self.m_itemsDic objectForKey:@"purchase_deadline"]];
        cell.m_time.text = [cell.m_time.text stringByReplacingOccurrencesOfString:@"(null)" withString:@""];


//        cell.m_time.frame = CGRectMake(cell.m_time.frame.origin.x, 105, cell.m_time.frame.size.width, cell.m_time.frame.size.height);

        
        
        // 设置cell的背景边框
        cell.m_backImgV.layer.borderColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0].CGColor;
        cell.m_backImgV.layer.borderWidth = 1.0;
        
        cell.textLabel.font = [UIFont systemFontOfSize:16.0f];
        
        
    }else{
    
    
    // 赋值 图标的显示 随时退
    if ( [[self.m_itemsDic objectForKey:@"IsAnyTimeReturn"] isEqualToString:@"Yes"] ) {
        
        cell.m_randomImgV.image = [UIImage imageNamed:@"xq_gou.png"];
        
        cell.m_anyTimeLabel.text = @"支持随时退";
        
    }else{
        
        cell.m_randomImgV.image = [UIImage imageNamed:@"red_wrong.png"];
        
        cell.m_anyTimeLabel.text = @"不支持随时退";
    }
    // 过期
    if ( [[self.m_itemsDic objectForKey:@"IsExpiredReturn"] isEqualToString:@"Yes"] ) {
        
        cell.m_ExpiredImagV.image = [UIImage imageNamed:@"xq_gou.png"];
        
        cell.m_expiredLabek.text = @"支持过期退";
        
    }else{
        
        cell.m_ExpiredImagV.image = [UIImage imageNamed:@"red_wrong.png"];
        
        cell.m_expiredLabek.text = @"不支持过期退";
        
    }
    // 预约
    if ( [[self.m_itemsDic objectForKey:@"IsReservation"] isEqualToString:@"Yes"] ) {
        
        cell.m_ReservationImgV.image = [UIImage imageNamed:@"xq_time.png"];
        
        cell.m_reserLabel.text = @"需预约";
        
    }else{
        
        cell.m_ReservationImgV.image = [UIImage imageNamed:@"xq_time_grey.png"];
        
        cell.m_reserLabel.text = @"不需预约";
        
    }
    
    cell.m_saled.text = [NSString stringWithFormat:@"已售%@份",[self.m_itemsDic objectForKey:@"Sold"]];
    cell.m_saled.text = [cell.m_saled.text stringByReplacingOccurrencesOfString:@"(null)" withString:@""];

    
    cell.m_remain.text = [NSString stringWithFormat:@"还余%@份",[self.m_itemsDic objectForKey:@"Surplus"]];
    cell.m_remain.text = [cell.m_remain.text stringByReplacingOccurrencesOfString:@"(null)" withString:@""];

    // 判断时间是否大于0
    if ( [[self.m_itemsDic objectForKey:@"LastDays"] intValue] > 0 ) {
        
        cell.m_time.text = [NSString stringWithFormat:@"剩余时间%@天以上",[self.m_itemsDic objectForKey:@"LastDays"]];
        cell.m_time.text = [cell.m_time.text stringByReplacingOccurrencesOfString:@"(null)" withString:@""];

    }else{
        
        cell.m_time.text = @"已结束";
    }
    
    
        // 设置cell的背景边框
        cell.m_backImgV.layer.borderColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0].CGColor;
        cell.m_backImgV.layer.borderWidth = 1.0;
        
        cell.textLabel.font = [UIFont systemFontOfSize:16.0f];
    
    }
    
    
    return cell;
}

// 第二行显示的数据
- (UITableViewCell *)tableViewTwo:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *cellIdentifier = @"StartCellIdentifier";
    
    StartCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
    
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"ProductDetailCell" owner:self options:nil];
        
        cell = (StartCell *)[nib objectAtIndex:1];
        
        cell.backgroundColor = [UIColor clearColor];

    }
    
    
    // 设置cell的背景边框
    cell.m_backImgV.layer.borderColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0].CGColor;
    cell.m_backImgV.layer.borderWidth = 1.0;
    
    //大众点评第二行数据
    if ([self.m_FromDPId isEqualToString:@"1"]) {
        

        NSDictionary * dic = [self.dp_merchantList objectAtIndex:FrommeNearly];
 
        NSString *string = [[NSString stringWithFormat:@"%@",[dic objectForKey:@"avg_rating"]] substringToIndex:1];

        NSString *count = [NSString stringWithFormat:@"%@",[dic objectForKey:@"review_count"]];
        
        // 判断cell是否可以点击
        if ( [string isEqualToString:@"0"]||[count isEqualToString:@"0"] ) {
            
            cell.userInteractionEnabled = NO;
            count = @"0";
            string = @"0";
            
        }else{
            
            cell.userInteractionEnabled = YES;
            
        }
        
        // 对星星进行赋值
        [cell setValue:string withCount:count];
        
    }
    else{
    
    if ( [self.m_countString isEqualToString:@"0"] ) {
        
        cell.userInteractionEnabled = NO;
        
    }else{
        
        cell.userInteractionEnabled = YES;
    }
    
    // 赋值
    if ( self.m_itemsDic.count != 0  ) {
        
        NSString *string = [NSString stringWithFormat:@"%@",[self.m_itemsDic objectForKey:@"Rank"]];
        
        NSString *count = [NSString stringWithFormat:@"%@",[self.m_itemsDic objectForKey:@"RankCount"]];
        
        // 对星星进行赋值
        [cell setValue:string withCount:count];
        
        
        // 判断cell是否可以点击
        if ( [string isEqualToString:@"0"] ) {
            
            cell.userInteractionEnabled = NO;
            
        }else{
            
            cell.userInteractionEnabled = YES;
        }
        
    }
        
    }
    return cell;

}



// 第三行显示的数据
- (UITableViewCell *)tableViewThree:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"ShopInforCellIdentifier";
    
    ShopInforCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"ProductDetailCell" owner:self options:nil];
        
        cell = (ShopInforCell *)[nib objectAtIndex:2];
        
        cell.backgroundColor = [UIColor clearColor];

    }
    
    //大众点评数据
    if ([self.m_FromDPId isEqualToString:@"1"]) {
        
        // 店铺信息的数组
        //        NSArray *array = [self.m_itemsDic objectForKey:@"businesses"];
        if (self.dp_merchantList.count == 0) {
            return cell;
        }
        
        [self ADDdp_merchantDIC];//排序离我最近的；
        
        NSDictionary * dic = [self.dp_merchantList objectAtIndex:FrommeNearly];
        
        cell.m_shopName.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];
        cell.m_address.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"address"]];
        cell.m_time.text = [NSString stringWithFormat:@"营业时间："];
        cell.m_phone.text = [NSString stringWithFormat:@"咨询电话：%@",[dic objectForKey:@"telephone"]];
        
        // 添加按钮触发的事件
        [cell.m_phoneBtn addTarget:self action:@selector(callPhone) forControlEvents:UIControlEventTouchUpInside];
        [cell.m_mapBtn addTarget:self action:@selector(mapClicked) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.m_moreBtn addTarget:self action:@selector(moreShop) forControlEvents:UIControlEventTouchUpInside];
        
        // 设置cell的背景边框
        cell.m_backImgV.layer.borderColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0].CGColor;
        cell.m_backImgV.layer.borderWidth = 1.0;
        
        
    }else{
    
        // 店铺信息的数组
        NSMutableDictionary *dic = [self.m_itemsDic objectForKey:@"MerchantShop"];
        
        cell.m_shopName.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"ShopName"]];
        cell.m_address.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Address"]];
        cell.m_time.text = [NSString stringWithFormat:@"营业时间：%@",[dic objectForKey:@"OpeningHours"]];
        cell.m_phone.text = [NSString stringWithFormat:@"咨询电话：%@",[dic objectForKey:@"Phone"]];
        
        // 添加按钮触发的事件
        [cell.m_phoneBtn addTarget:self action:@selector(callPhone) forControlEvents:UIControlEventTouchUpInside];
        [cell.m_mapBtn addTarget:self action:@selector(mapClicked) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.m_moreBtn addTarget:self action:@selector(moreShop) forControlEvents:UIControlEventTouchUpInside];
        
        // 设置cell的背景边框
        cell.m_backImgV.layer.borderColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0].CGColor;
        cell.m_backImgV.layer.borderWidth = 1.0;
        
    }
    
    
    return cell;
    
}

// 第四行显示的数据
- (UITableViewCell *)tableViewFour:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"IntroductionCellIndentifier";
    
    IntroductionCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"ProductDetailCell" owner:self options:nil];
        
        cell = (IntroductionCell *)[nib objectAtIndex:3];
        
        cell.backgroundColor = [UIColor clearColor];

    }
    
    // 赋值
    cell.m_titleLabel.text = @"商品介绍";
    
    // 判断是大众点评的数据还是本地的数据：大众点评的数据用webView显示，本地的用label显示
    if ([self.m_FromDPId isEqualToString:@"1"]) {
        
        // 如果没有值的话则直接用label显示
        if ( self.m_productIntro.length == 0 ) {
            
            cell.m_detailLabel.text = @"无";
            
            cell.m_webView.hidden = YES;
            cell.m_detailLabel.hidden = NO;
            
            
            // 计算label的高度
            CGSize size = [cell.m_detailLabel.text sizeWithFont:[UIFont systemFontOfSize:12.0f] constrainedToSize:CGSizeMake(WindowSizeWidth - 40, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
            
            cell.m_detailLabel.frame = CGRectMake(20, 45, WindowSizeWidth - 40, size.height + 10);
            
            cell.m_backImgV.frame = CGRectMake(10, 10, cell.m_backImgV.frame.size.width, 68 - 21 + size.height);
            
            cell.frame = CGRectMake(0, 0, cell.frame.size.width, cell.m_backImgV.frame.size.height + 10);
            
            cell.m_detailLabel.text = self.m_productIntro;
            
        }else{
            
            cell.m_webView.hidden = NO;
            cell.m_detailLabel.hidden = YES;
            
//            cell.m_webView.userInteractionEnabled = NO;
            
            cell.m_webView.scrollView.scrollEnabled = NO;

            NSString *BookStr = [self htmlString:self.m_productIntro];
            
            // webView赋值
            [cell.m_webView loadHTMLString:BookStr baseURL:nil];
            
            
            // 计算webView的高度
            cell.m_webView.frame = CGRectMake(cell.m_webView.frame.origin.x, cell.m_webView.frame.origin.y, cell.m_webView.frame.size.width, self.m_detailsWebView.frame.size.height);
            
            cell.m_backImgV.frame = CGRectMake(10, 10, cell.m_backImgV.frame.size.width, 68 - 21 + self.m_detailsWebView.frame.size.height);
            
            cell.frame = CGRectMake(0, 0, cell.frame.size.width, cell.m_backImgV.frame.size.height + 10);
            
        }
        
    }else{
        
        cell.m_webView.hidden = YES;
        cell.m_detailLabel.hidden = NO;
        
        // 计算label的高度
        CGSize size = [self.m_productIntro sizeWithFont:[UIFont systemFontOfSize:12.0f] constrainedToSize:CGSizeMake(WindowSizeWidth - 40, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
        
        cell.m_detailLabel.frame = CGRectMake(20, 45, WindowSizeWidth - 40, size.height + 10);
        
        cell.m_backImgV.frame = CGRectMake(10, 10, cell.m_backImgV.frame.size.width, 68 - 21 + size.height);
        
        cell.frame = CGRectMake(0, 0, cell.frame.size.width, cell.m_backImgV.frame.size.height + 10);
        
        cell.m_detailLabel.text = self.m_productIntro;
        
    }

    cell.m_infoImgV.image = [UIImage imageNamed:@"xq_jieshao.png"];
    
    
    
    // 设置cell的背景边框
    cell.m_backImgV.layer.borderColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0].CGColor;
    cell.m_backImgV.layer.borderWidth = 1.0;
    
    return cell;
}

// 第五行显示的数据
- (UITableViewCell *)tableViewFive:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"IntroductionCellIndentifier";
    
    IntroductionCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"ProductDetailCell" owner:self options:nil];
        
        cell = (IntroductionCell *)[nib objectAtIndex:3];
        
        cell.backgroundColor = [UIColor clearColor];

    }
    
    // 赋值
    cell.m_titleLabel.text = @"特别提示";
    
    cell.m_infoImgV.image = [UIImage imageNamed:@"xq_tip.png"];
    
    // 判断是大众点评的数据还是本地的数据：大众点评的数据用webView显示，本地的用label显示
    if ([self.m_FromDPId isEqualToString:@"1"]) {
       
        // 如果没有值的话则直接用label显示
        if ( self.m_PromptmString.length == 0 ) {
            
            cell.m_detailLabel.text = @"无";
            
            cell.m_webView.hidden = YES;
            cell.m_detailLabel.hidden = NO;
            
            
            // 计算label的高度
            CGSize size = [cell.m_detailLabel.text sizeWithFont:[UIFont systemFontOfSize:12.0f] constrainedToSize:CGSizeMake(WindowSizeWidth - 40, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
            
            cell.m_detailLabel.frame = CGRectMake(20, 45, WindowSizeWidth - 40, size.height + 10);
            
            cell.m_backImgV.frame = CGRectMake(10, 10, cell.m_backImgV.frame.size.width, 68 - 21 + size.height);
            
            cell.frame = CGRectMake(0, 0, cell.frame.size.width, cell.m_backImgV.frame.size.height + 10);
            
            cell.m_detailLabel.text = self.m_PromptmString;
            
            
        
        }else{
            
            cell.m_webView.hidden = NO;
            cell.m_detailLabel.hidden = YES;

//            cell.m_webView.userInteractionEnabled = NO;

            cell.m_webView.scrollView.scrollEnabled = NO;
            
            NSString *BookStr = [self htmlString:self.m_PromptmString];
            // webView赋值
            [cell.m_webView loadHTMLString:BookStr baseURL:nil];
         
            // 计算webView的高度
            cell.m_webView.frame = CGRectMake(cell.m_webView.frame.origin.x, cell.m_webView.frame.origin.y, cell.m_webView.frame.size.width, self.m_specialWebView.frame.size.height);
            
            cell.m_backImgV.frame = CGRectMake(10, 10, cell.m_backImgV.frame.size.width, 68 - 21 + cell.m_webView.frame.size.height);
            cell.frame = CGRectMake(0, 0, cell.frame.size.width, cell.m_backImgV.frame.size.height + 10);
        
        }
    
        
    }else{
    
        cell.m_webView.hidden = YES;
        cell.m_detailLabel.hidden = NO;
        
        
        CGSize size = [self.m_PromptmString sizeWithFont:[UIFont systemFontOfSize:12.0f] constrainedToSize:CGSizeMake(WindowSizeWidth - 40, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
        
        cell.m_detailLabel.frame = CGRectMake(20, 45, WindowSizeWidth - 40, size.height + 10);
        
        cell.m_backImgV.frame = CGRectMake(10, 10, cell.m_backImgV.frame.size.width, 68 - 21 + size.height);
        
        cell.frame = CGRectMake(0, 0, cell.frame.size.width, cell.m_backImgV.frame.size.height + 10);
        
        cell.m_detailLabel.text = self.m_PromptmString;
        
        

    }
    
 

    // 设置cell的背景边框
    cell.m_backImgV.layer.borderColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0].CGColor;
    cell.m_backImgV.layer.borderWidth = 1.0;
    
    return cell;
}

// 第六行显示的数据
- (UITableViewCell *)tableViewLast:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ( indexPath.row == 5 ) {
        
        static NSString *cellIdentifier = @"OtherCellIdentifier";
        
        OtherCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if ( cell == nil ) {
            
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"ProductDetailCell" owner:self options:nil];
            
            cell = (OtherCell *)[nib objectAtIndex:4];
           
            cell.backgroundColor = [UIColor clearColor];

        }
        
        
        if ( self.m_productList.count != 0 ) {
            
            cell.m_otherName.text = @"其他商品";
            
            // 赋值
            NSMutableDictionary *dic = [self.m_productList objectAtIndex:indexPath.row - 5];
            
            cell.m_nameLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"SvcSimpleName"]];
            cell.m_clickedBtn.tag = indexPath.row - 5;
            [cell.m_clickedBtn addTarget:self action:@selector(clickedBtn:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        
        return cell;
        
    }else{
        
        static NSString *cellIdentifier = @"OtherOneCellIdentifier";
        
        OtherOneCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if ( cell == nil ) {
            
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"ProductDetailCell" owner:self options:nil];
            
            cell = (OtherOneCell *)[nib objectAtIndex:5];
            
            cell.backgroundColor = [UIColor clearColor];

        }
        
        // 赋值
        if ( self.m_productList.count != 0 ) {
            
            NSMutableDictionary *dic = [self.m_productList objectAtIndex:indexPath.row - 5];
            
            cell.m_productName.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"SvcSimpleName"]];
            
            
            // 设置cell的背景边框
            cell.m_backImgV.layer.borderColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0].CGColor;
            cell.m_backImgV.layer.borderWidth = 1.0;
            
        }

        return cell;
    }
    
}


#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ( indexPath.row == 0 ) {
        
        return 89.0f;
        
    }else if ( indexPath.row == 1 ){
        
        return 36.0f;
    
    }else if ( indexPath.row == 2 ){
        
        return 145.0f;
        
    }else if ( indexPath.row == 3 ){
        
        
       if ([self.m_FromDPId isEqualToString:@"1"]) {
           
           if ( self.m_productIntro.length == 0 ) {
               
               self.m_productIntro = @"无";
              
               CGSize size = [self.m_productIntro sizeWithFont:[UIFont systemFontOfSize:12.0f] constrainedToSize:CGSizeMake(WindowSizeWidth - 40, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
               
               return 68 - 21 + size.height + 10 + 10;
               
           }else{
               
               
               return 68 - 21 + self.m_detailsWebView.frame.size.height + 10 + 10;
               
           }
           
           
       }else{
           
           
           
           CGSize size = [self.m_productIntro sizeWithFont:[UIFont systemFontOfSize:12.0f] constrainedToSize:CGSizeMake(WindowSizeWidth - 40, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
           
           return 68 - 21 + size.height + 10 + 10;
           
       }
        
        
        
    }else if ( indexPath.row == 4 ){
        
        
        if ([self.m_FromDPId isEqualToString:@"1"]) {
            
            if ( self.m_PromptmString.length == 0 ) {
                
                self.m_PromptmString = @"无";
                
                CGSize size = [self.m_PromptmString sizeWithFont:[UIFont systemFontOfSize:12.0f] constrainedToSize:CGSizeMake(WindowSizeWidth - 40, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                
                return 68 - 21 + size.height + 10 + 10;
                
            }else{
               
                return 68 - 21 + self.m_specialWebView.frame.size.height + 10 + 10;
                
            }
            
        }else{
            
            CGSize size = [self.m_PromptmString sizeWithFont:[UIFont systemFontOfSize:12.0f] constrainedToSize:CGSizeMake(WindowSizeWidth - 40, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
            
            return 68 - 21 + size.height + 10 + 10;
            
            
        }
    
    }else  if( indexPath.row == 5 ){
        
        return 78.0f;
        
    }else{
        
        return 40.0f;
    }
} 

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
//    if ( indexPath.row == 1 ) {
//        // 进入评价的页面
//        CommentViewController *VC = [[CommentViewController alloc]initWithNibName:@"CommentViewController" bundle:nil];
//        [self.navigationController pushViewController:VC animated:YES];
//        
//    }
    
    switch (indexPath.row) {
        case 0:
            
            break;
        case 1:
        {
            //大众点评第二行数据
            if ([self.m_FromDPId isEqualToString:@"1"]) {
                
                DPbuyViewController * VC = [[DPbuyViewController alloc]initWithNibName:@"DPbuyViewController" bundle:nil];
                NSDictionary * dic = [self.dp_merchantList objectAtIndex:FrommeNearly];
                VC.dp_buystring = [NSString stringWithFormat:@"%@?hasheader=0",[dic objectForKey:@"review_list_url"]];
                VC.dp_Type = @"1";//表示评价
                [self.navigationController pushViewController:VC animated:YES];
                
            }else{
                // 进入评价的页面
                CommentViewController *VC = [[CommentViewController alloc]initWithNibName:@"CommentViewController" bundle:nil];
                VC.m_typeString = @"1";
                VC.m_serviceId = [NSString stringWithFormat:@"%@",[self.m_itemsDic objectForKey:@"ServiceID"]];
                
                [self.navigationController pushViewController:VC animated:YES];
            }

        }
            
            break;
        case 2:
            
            break;
        case 3:
            
            break;
        case 4:
            
            break;
        case 5:
    
            break;
                    
        default:
        {
            
            // 进入商品详情
            NSMutableDictionary *dic = [self.m_productList objectAtIndex:indexPath.row - 5];
            
            ProductDetailViewController *VC = [[ProductDetailViewController alloc]initWithNibName:@"ProductDetailViewController" bundle:nil];
            VC.m_productId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"ServiceID"]];
            VC.m_merchantShopId = [NSString stringWithFormat:@"%@",self.m_merchantShopId];
            [self.navigationController pushViewController:VC animated:YES];

            
        }
            break;
    }
}

- (void)clickedBtn:(id)sender{
    
    UIButton *btn = (UIButton *)sender;
    
    NSMutableDictionary *dic = [self.m_productList objectAtIndex:btn.tag];
    
    // 进入商品详情
    ProductDetailViewController *VC = [[ProductDetailViewController alloc]initWithNibName:@"ProductDetailViewController" bundle:nil];
    VC.m_productId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"ServiceID"]];
    VC.m_merchantShopId = [NSString stringWithFormat:@"%@",self.m_merchantShopId];
    [self.navigationController pushViewController:VC animated:YES];
    
}

#pragma mark - YKCommonBannerDelegate
- (void)clickBannerAction:(NSString *)aIndex{
    
    // 点击进入大图
//    ProductBigViewController *VC = [[ProductBigViewController alloc]initWithNibName:@"ProductBigViewController" bundle:nil imageArray:[self.m_itemsDic objectForKey:@"Poster"]];
//    [self presentViewController:VC animated:NO completion:nil];
    
}


//请求会员的身份信息；
 -(void)getIsMemDarenORIsResDaren
{
    
    if ([[CommonUtil getValueByKey:IsMemDaren] isEqualToString:@"1"]){
        
        return;
    }

    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return ;
    }
        
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,     @"memberId",
                           key,   @"key",
                           nil];
    [httpClient request:@"JudgeIdentity.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            
            NSDictionary * dic = [json valueForKey:@"JudgeIty"];
            
            if ( [[CommonUtil getValueByKey:IsMemDaren] isEqualToString:@"0"]&&[[NSString stringWithFormat:@"%@", [dic objectForKey:@"IsMemDaren"]]isEqualToString:@"1"]) {
                
                [self.m_tableView reloadData];

            }
            
            //存储会员身份，是否是生活达人或资源达人；
            [CommonUtil addValue:[NSString stringWithFormat:@"%@", [dic objectForKey:@"IsMemDaren"]] andKey:IsMemDaren];
            [CommonUtil addValue:[NSString stringWithFormat:@"%@", [dic objectForKey:@"IsResDaren"]] andKey:IsResDaren];
            
        } else {

            
        }
    } failure:^(NSError *error) {
        
    
    }];
 
}

- (IBAction)buyNow:(id)sender {
    
    [self GoBuyReally];

    
//    if ([[CommonUtil getValueByKey:[NSString stringWithFormat:@"%@%@",MEMBER_ID,MemResNo]] isEqualToString:@"1"]) {
//        
//        [self GoBuyReally];
//
//    }else
//    {
//        
//        if ([[CommonUtil getValueByKey:IsMemDaren] isEqualToString:@"1"]) {
//            
//            [self GoBuyReally];
//            
//        }else{
// 
//                 UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"邀请一位好友成功注册\n好友每次购买，终身获得商品返利的50%作为奖励。" delegate:self cancelButtonTitle:@"立即邀请" otherButtonTitles:@"不在提醒",@"下次再说",nil];
//                 
//                 msgbox.tag = 123895;
//                 
//                 [msgbox show];
//            
//        }
//        
//    }
    
}

//直接去购买
-(void)GoBuyReally
{
    
    if ([self.m_FromDPId isEqualToString:@"1"]) {
        
        DPbuyViewController * VC = [[DPbuyViewController alloc]initWithNibName:@"DPbuyViewController" bundle:nil];
        VC.dp_buystring = [NSString stringWithFormat:@"%@?hasheader=0&direct=true&uid=%@",[self.m_itemsDic objectForKey:@"deal_h5_url"],[CommonUtil getValueByKey:MEMBER_ID]];
        VC.dp_dic = self.m_itemsDic;
        VC.dp_Type = @"0";//表示购买；
        [CommonUtil addValue:self.m_productId andKey:@"DP_BuyID"];
        [self.navigationController pushViewController:VC animated:YES];
        
    }else{
        
        // 验证用户是否设置了安全支付问题
        [self paymentSafeRequest];
        
    }
    
}



- (IBAction)addShopCart:(id)sender {
 
    // 加入购物车
    [self addShopCartSubmit];
    
}

- (IBAction)shareBtnClicked:(id)sender {
    
    [self.m_showView removeFromSuperview];
    
    UIButton *btn = (UIButton *)sender;
    
    if ( btn.tag == 1000 ) {
        //检测是否安装QQ
        if (![self checkIsVaildQQType]) {
            return;
        }
        // qq好友
        tencentOAuth = [[TencentOAuth alloc]initWithAppId:TencentQzoneAppId andDelegate:self];
        
        
        //        http://wx.cityandcity.com/commodity_detail.aspx?svcid=101&mctid=63
        

        QQApiNewsObject *newsObj;
        
        if ([self.m_FromDPId isEqualToString:@"1"]) {
            
            
            NSString *utf8String = [NSString stringWithFormat:@"%@?hasheader=0",[self.m_itemsDic objectForKey:@"deal_h5_url"]];
            NSString *title = [NSString stringWithFormat:@"%@",[self.m_itemsDic objectForKey:@"title"]];
            NSString *description =  [NSString stringWithFormat:@"%@",[self.m_itemsDic objectForKey:@"description"]];
            newsObj = [QQApiNewsObject objectWithURL:[NSURL URLWithString:utf8String] title:title description:description previewImageURL:[NSURL URLWithString:[CommonUtil getValueByKey:@"productImage"]]];
            
        }else{

            NSString *utf8String = [NSString stringWithFormat:@"http://m.cityandcity.com/ProCCPDetail.aspx?svcid=%@",[self.m_itemsDic objectForKey:@"ServiceID"]];
            
            
            NSString *title = [NSString stringWithFormat:@"%@",[self.m_itemsDic objectForKey:@"SvcSimpleName"]];
            NSString *description =  [NSString stringWithFormat:@"%@",[self.m_itemsDic objectForKey:@"SvcName"]];
            newsObj = [QQApiNewsObject objectWithURL:[NSURL URLWithString:utf8String] title:title description:description previewImageURL:[NSURL URLWithString:[CommonUtil getValueByKey:@"productImage"]]];
        }

        SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:newsObj];
        //将内容分享到qq
        QQApiSendResultCode sent = 0;
        sent = [QQApiInterface sendReq:req];
        // 判断QQ的情况
        [self handleSendResult:sent];
        
    }else if ( btn.tag == 1001 ) {
        //检测是否安装QQ
        if (![self checkIsVaildQQType]) {
            return;
        }
        QQApiNewsObject *newsObj;
        
        if ([self.m_FromDPId isEqualToString:@"1"]) {
            
            // QQ空间分享
            tencentOAuth = [[TencentOAuth alloc]initWithAppId:TencentQzoneAppId andDelegate:self];
            

            NSString *utf8String = [NSString stringWithFormat:@"%@?hasheader=0",[self.m_itemsDic objectForKey:@"deal_h5_url"]];
            NSString *title = [NSString stringWithFormat:@"%@",[self.m_itemsDic objectForKey:@"title"]];
            NSString *description =  [NSString stringWithFormat:@"%@",[self.m_itemsDic objectForKey:@"description"]];
            newsObj= [QQApiNewsObject objectWithURL:[NSURL URLWithString:utf8String] title:title description:description previewImageURL:[NSURL URLWithString:[CommonUtil getValueByKey:@"productImage"]]];
            
        }else{
            
            // QQ空间分享
            tencentOAuth = [[TencentOAuth alloc]initWithAppId:TencentQzoneAppId andDelegate:self];

            NSString *utf8String = [NSString stringWithFormat:@"http://m.cityandcity.com/ProCCPDetail.aspx?svcid=%@",[self.m_itemsDic objectForKey:@"ServiceID"]];
            
            NSString *title = [NSString stringWithFormat:@"%@",[self.m_itemsDic objectForKey:@"SvcSimpleName"]];
            NSString *description =  [NSString stringWithFormat:@"%@",[self.m_itemsDic objectForKey:@"SvcName"]];
            newsObj= [QQApiNewsObject objectWithURL:[NSURL URLWithString:utf8String] title:title description:description previewImageURL:[NSURL URLWithString:[CommonUtil getValueByKey:@"productImage"]]];
        }

        SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:newsObj];
        //将内容分享到qq
        QQApiSendResultCode sent = 0;
        
        //将内容分享到qzone
        sent = [QQApiInterface SendReqToQZone:req];
        
        // 判断QQ的情况
        [self handleSendResult:sent];
        
    }else if ( btn.tag == 1002 ) {
        
        // 微信分享
        [self checkIsVaildweixinType:1002];
        
    }else if ( btn.tag == 1003 ) {
        
        // 朋友圈分享
        [self checkIsVaildweixinType:1003];
        
    }else if ( btn.tag == 1004 ){
        //诲诲好友
        Sharetofriend *VC = [[Sharetofriend alloc]init];
        VC.MessageType = @"PRO";
        VC.m_FromDPId = self.m_FromDPId;
        VC.m_productId = self.m_productId;
        VC.m_merchantShopId = self.m_merchantShopId;
        VC.TextDIC = self.m_itemsDic;
        [self.navigationController pushViewController:VC animated:YES];
        
    }else if ( btn.tag == 1005 ){
        //诲诲朋友圈
        SharetoHuiHuiViewController * VC = [[SharetoHuiHuiViewController alloc]initWithNibName:@"SharetoHuiHuiViewController" bundle:nil];
        
        if ([self.m_FromDPId isEqualToString:@"1"]){
            
            VC.dealId = self.m_productId;
            VC.serviceID = @"0";
            VC.m_merchantShopId = @"0";
            VC.dynamicType = @"DianPingShare";
            VC.STitle = [NSString stringWithFormat:@"%@",[self.m_itemsDic objectForKey:@"title"]];
            VC.subTitle =  [NSString stringWithFormat:@"%@",[self.m_itemsDic objectForKey:@"description"]];

            
        }else{
            VC.dealId = @"0";
            VC.serviceID = self.m_productId;
            VC.m_merchantShopId = self.m_merchantShopId;
            VC.dynamicType = @"SvcShare";
            VC.STitle = [NSString stringWithFormat:@"%@",[self.m_itemsDic objectForKey:@"SvcSimpleName"]];
            VC.subTitle =  [NSString stringWithFormat:@"%@",[self.m_itemsDic objectForKey:@"SvcName"]];

        }
        
        VC.webUrl = @"";
        VC.activityID = @"0";
        
        [self.navigationController pushViewController:VC animated:YES];
    }
    
}

- (void)handleSendResult:(QQApiSendResultCode)sendResult
{
    switch (sendResult)
    {
        case EQQAPIAPPNOTREGISTED:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"App未注册" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            break;
        }
        case EQQAPIMESSAGECONTENTINVALID:
        case EQQAPIMESSAGECONTENTNULL:
        case EQQAPIMESSAGETYPEINVALID:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"发送参数错误" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            break;
        }
        case EQQAPIQQNOTINSTALLED:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"未安装手Q" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            break;
        }
        case EQQAPIQQNOTSUPPORTAPI:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"API接口不支持" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            break;
        }
        case EQQAPISENDFAILD:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"发送失败" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            break;
        }
        default:
        {
            break;
        }
    }
}
// 检查是否安装了微信的客户端
-(void)checkIsVaildweixinType
{
    if( [WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi] ){ //判断是否安装且支持微信
        //安装了微信
        [self shareTogoodFriend];
        
    }else{
        
        //未安装
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示"
                                                        message:@"您尚未安装微信,确认进行安装吗？"
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                              otherButtonTitles:@"确定",nil];
        alert.tag = 100100;
        [alert show];
        
        
    }
    
}

// 检查是否安装了QQ的客户端
-(BOOL)checkIsVaildQQType
{
    if ([QQApi isQQInstalled] &&[QQApi isQQSupportApi]) {
        return YES;
    }else
    {
        //未安装
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示"
                                                        message:@"您尚未安装QQ或是当前版本太低"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        return NO;
    }
    
}

// 检查是否安装了微信的客户端
-(void)checkIsVaildweixinType:(NSInteger)aType
{
    if( [WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi] ){ //判断是否安装且支持微信
        if ( aType == 1002 ) {
            
            if ([self.m_FromDPId isEqualToString:@"1"]) {
                
                [self dp_shareTogoodFriend];
            }else{
                // 好友
                [self shareTogoodFriend];
            }

            
        }else if ( aType == 1003 ) {
            
            
            if ([self.m_FromDPId isEqualToString:@"1"]) {
                
                [self dp_shareTogoodFriendShipsWithMessage];
            }else{
                // 朋友圈
                [self shareTogoodFriendShipsWithMessage];
            }

            
        }else{
            
            
        }
        
    }else{
        
        //未安装
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示"
                                                        message:@"您尚未安装微信,确认进行安装吗？"
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                              otherButtonTitles:@"确定",nil];
        alert.tag = 100100;
        [alert show];
        
        
    }
    
}

//发送给好友
-(void)shareTogoodFriend
{
    
    WXMediaMessage *message = [WXMediaMessage message];//发送消息的多媒体内容
    message.title = [NSString stringWithFormat:@"%@", [self.m_itemsDic objectForKey:@"SvcSimpleName"]];
    message.description = [NSString stringWithFormat:@"%@",[self.m_itemsDic objectForKey:@"SvcName"]];
    
    NSString *imagePath = [NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:@"productImage"]];
    
    UIImageView *imgV = [[UIImageView alloc]init];
    
    [imgV setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:imagePath]]
                placeholderImage:[UIImage imageNamed:@""]
                         success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                             imgV.image = [CommonUtil scaleImage:image toSize:CGSizeMake(60, 60)];
                             
                             // 微信进行赋值
                             [message setThumbImage:imgV.image];
                             
                             WXWebpageObject *ext = [WXWebpageObject object];
                            
//                             ext.webpageUrl = [NSString stringWithFormat:@"http://wx.cityandcity.com/commodity_detail.aspx?svcid=%@&mctid=%@&memberId=%@",[self.m_itemsDic objectForKey:@"ServiceID"],[self.m_itemsDic objectForKey:@"MerchantID"],[CommonUtil getValueByKey:MEMBER_ID]];

                             
                            ext.webpageUrl = [NSString stringWithFormat:@"http://m.cityandcity.com/ProCCPDetail.aspx?svcid=%@",[self.m_itemsDic objectForKey:@"ServiceID"]];
                             
                             
                             message.mediaObject = ext;
                             SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
                             req.bText = NO;//发送消息的类型，包括文本消息和多媒体消息两种，两者只能选择其一，不能同时发送文本和多媒体消息
                             req.message = message;
                             req.scene = WXSceneSession;//选择发送好友
                             [WXApi sendReq:req];
                             
                             
                         }
                         failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                             
                         }];
    
}

// 朋友圈
-(void)shareTogoodFriendShipsWithMessage {
    
    WXMediaMessage *message = [WXMediaMessage message];//发送消息的多媒体内容
    message.title =@"分享";
    message.description = [NSString stringWithFormat:@"%@",[self.m_itemsDic objectForKey:@"SvcName"]];
    message.title = [NSString stringWithFormat:@"%@", [self.m_itemsDic objectForKey:@"SvcSimpleName"]];
    
    
    NSString *imagePath = [NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:@"productImage"]];
    
    UIImageView *imgV = [[UIImageView alloc]init];
    
    [imgV setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:imagePath]]
                placeholderImage:[UIImage imageNamed:@""]
                         success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                             imgV.image = [CommonUtil scaleImage:image toSize:CGSizeMake(60, 60)];
                             
                             // 微信进行赋值
                             [message setThumbImage:imgV.image];
                             
                             WXWebpageObject *ext = [WXWebpageObject object];
                             
//                             ext.webpageUrl = [NSString stringWithFormat:@"http://wx.cityandcity.com/commodity_detail.aspx?svcid=%@&mctid=%@&memberId=%@",[self.m_itemsDic objectForKey:@"ServiceID"],[self.m_itemsDic objectForKey:@"MerchantID"],[CommonUtil getValueByKey:MEMBER_ID]];

                             ext.webpageUrl = [NSString stringWithFormat:@"http://m.cityandcity.com/ProCCPDetail.aspx?svcid=%@",[self.m_itemsDic objectForKey:@"ServiceID"]];
                             
                             message.mediaObject = ext;
                             
                             SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
                             req.bText = NO;//发送消息的类型，包括文本消息和多媒体消息两种，两者只能选择其一，不能同时发送文本和多媒体消息
                             req.message = message;
                             req.scene = WXSceneTimeline;//发送到朋友圈
                             
                             [WXApi sendReq:req];
                             
                             
                         }
                         failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                             
                         }];
    
}




//发送给好友
-(void)dp_shareTogoodFriend
{
    
    WXMediaMessage *message = [WXMediaMessage message];//发送消息的多媒体内容
    message.title = [NSString stringWithFormat:@"%@", [self.m_itemsDic objectForKey:@"title"]];
    message.description = [NSString stringWithFormat:@"%@",[self.m_itemsDic objectForKey:@"description"]];
    
    NSString *imagePath = [NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:@"productImage"]];
    
    UIImageView *imgV = [[UIImageView alloc]init];
    
    [imgV setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:imagePath]]
                placeholderImage:[UIImage imageNamed:@""]
                         success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                             imgV.image = [CommonUtil scaleImage:image toSize:CGSizeMake(60, 60)];
                             
                             // 微信进行赋值
                             [message setThumbImage:imgV.image];
                             
                             WXWebpageObject *ext = [WXWebpageObject object];
                             ext.webpageUrl = [NSString stringWithFormat:@"%@?hasheader=0",[self.m_itemsDic objectForKey:@"deal_h5_url"]];
                             message.mediaObject = ext;
                             SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
                             req.bText = NO;//发送消息的类型，包括文本消息和多媒体消息两种，两者只能选择其一，不能同时发送文本和多媒体消息
                             req.message = message;
                             req.scene = WXSceneSession;//选择发送好友
                             [WXApi sendReq:req];
                             
                             
                         }
                         failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                             
                         }];
    
}

// 朋友圈
-(void)dp_shareTogoodFriendShipsWithMessage {
    
    WXMediaMessage *message = [WXMediaMessage message];//发送消息的多媒体内容
    message.title =@"分享";
    message.description = [NSString stringWithFormat:@"%@",[self.m_itemsDic objectForKey:@"title"]];
    message.title = [NSString stringWithFormat:@"%@", [self.m_itemsDic objectForKey:@"description"]];
    
    
    NSString *imagePath = [NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:@"productImage"]];
    
    UIImageView *imgV = [[UIImageView alloc]init];
    
    [imgV setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:imagePath]]
                placeholderImage:[UIImage imageNamed:@""]
                         success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                             imgV.image = [CommonUtil scaleImage:image toSize:CGSizeMake(60, 60)];
                             
                             // 微信进行赋值
                             [message setThumbImage:imgV.image];
                             
                             WXWebpageObject *ext = [WXWebpageObject object];
                             ext.webpageUrl = [NSString stringWithFormat:@"%@?hasheader=0",[self.m_itemsDic objectForKey:@"deal_h5_url"]];
                             message.mediaObject = ext;
                             
                             SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
                             req.bText = NO;//发送消息的类型，包括文本消息和多媒体消息两种，两者只能选择其一，不能同时发送文本和多媒体消息
                             req.message = message;
                             req.scene = WXSceneTimeline;//发送到朋友圈
                             
                             [WXApi sendReq:req];
                             
                             
                         }
                         failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                             
                         }];
    
}

- (IBAction)cancelShare:(id)sender {
    
    [self.m_showView removeFromSuperview];

}

- (IBAction)gotoShopCart:(id)sender {
    
    // 进入购物车页面
    ShopCartViewController *VC = [[ShopCartViewController alloc]initWithNibName:@"ShopCartViewController" bundle:nil];
    [self.navigationController pushViewController:VC animated:YES];
    
}

// 加入购物车请求数据
- (void)addShopCartSubmit{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    //  type	标示字段1：加入购物车，2:增加或减少数量
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,     @"memberId",
                           key,   @"key",
                           @"1",@"amount",
                           @"1",@"type",
                           [NSString stringWithFormat:@"%@",self.m_productId],@"serviceId",
                           nil];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"BuyCarAdd.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showSuccessWithStatus:msg];
            
        } else {
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
    } failure:^(NSError *error) {
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];
    
}

#pragma mark - BtnClicked
- (void)callPhone{
    
    NSString *phone;
    
    if ([self.m_FromDPId isEqualToString:@"1"]) {
        
        
        NSDictionary * dic = [self.dp_merchantList objectAtIndex:FrommeNearly];
        
        phone = [NSString stringWithFormat:@"%@",[dic objectForKey:@"telephone"]];


    }else{
        
        NSMutableDictionary *dic = [self.m_itemsDic objectForKey:@"MerchantShop"];
        
        phone = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Phone"]];

    }
    
    // 判断设备是否支持
    if([[[UIDevice currentDevice] model] rangeOfString:@"iPhone Simulator"].location != NSNotFound) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示"
                                                        message:@"该设备暂不支持电话功能"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles: nil];
        [alert show];
        
    }else{
        
        self.m_webView = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
        [self.m_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", phone]]]];
        
    }
    
}



- (void)mapClicked{
    
    
    // 进入地图展示的页面
    MapViewController *VC = [[MapViewController alloc]initWithNibName:@"MapViewController" bundle:nil];
    VC.m_shopString = @"1";
    
    if ([self.m_FromDPId isEqualToString:@"1"]) {
        
        VC.m_FromDPId = @"1";
        VC.item = [self.dp_merchantList objectAtIndex:FrommeNearly];
        
    }else{
        
        VC.m_FromDPId = @"0";
        VC.item = [self.m_itemsDic objectForKey:@"MerchantShop"];
    }
    [self.navigationController pushViewController:VC animated:YES];
    
}

- (void)moreShop{
    
   // 商家地址列表
    ShopListViewController *VC = [[ShopListViewController alloc]initWithNibName:@"ShopListViewController" bundle:nil];
    VC.m_typeString = @"1";
    if ([self.m_FromDPId isEqualToString:@"1"]) {
        
        VC.m_FromDPId = @"1";
        VC.m_shopList = self.dp_merchantList;
        
    }else{
        
        VC.m_merchantId = [self.m_itemsDic objectForKey:@"MerchantID"];
        
    }
    [self.navigationController pushViewController:VC animated:YES];
}

// 验证用户是否填写了支付问题的网络请求
- (void)paymentSafeRequest{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,     @"memberId",
                           key,   @"key",
                           [NSString stringWithFormat:@"%@",[self.m_itemsDic objectForKey:@"ServiceID"]],@"svcId",
                           nil];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"PaymentCheck_1.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            [SVProgressHUD dismiss];
            
            // 立即购买
            SubmitOrderViewController *VC = [[SubmitOrderViewController alloc]initWithNibName:@"SubmitOrderViewController" bundle:nil];
            VC.m_items = self.m_itemsDic;
            VC.ruKou = self.ruKou;
            [self.navigationController pushViewController:VC animated:YES];
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD dismiss];
            
            //            false(1：用户信息丢失，请重新登录;2：商品不存在;3：服务资源不在销售中；4：服务资源已下架；5：服务资源已售完 true(验证成功)
            if ( [msg isEqualToString:@"1"] ) {
                // 1: 用户信息丢失，请重新登录
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示"
                                                                   message:@"用户信息丢失，请重新登录"
                                                                  delegate:nil
                                                         cancelButtonTitle:@"确定"
                                                         otherButtonTitles:nil];
                
                [alertView show];
                
            }else if ( [msg isEqualToString:@"2"] ){
                
                // 2：商品不存在
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示"
                                                                   message:@"商品不存在"
                                                                  delegate:nil
                                                         cancelButtonTitle:@"确定"
                                                         otherButtonTitles:nil];
                
                [alertView show];
                
                
            }else if ( [msg isEqualToString:@"3"] ){
                
                // 3：服务资源不在销售中
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示"
                                                                   message:@"服务资源不在销售中"
                                                                  delegate:nil
                                                         cancelButtonTitle:@"确定"
                                                         otherButtonTitles:nil];
                
                [alertView show];
                
            }else if ( [msg isEqualToString:@"4"] ){
                
                // 4：服务资源已下架
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示"
                                                                   message:@"服务资源已下架"
                                                                  delegate:nil
                                                         cancelButtonTitle:@"确定"
                                                         otherButtonTitles:nil];
                
                [alertView show];
                
                
            }else if ( [msg isEqualToString:@"5"] ){
                
                // 5：服务资源已售完
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示"
                                                                   message:@"服务资源已售完"
                                                                  delegate:nil
                                                         cancelButtonTitle:@"确定"
                                                         otherButtonTitles:nil];
                
                [alertView show];
                
            }
//            else if ( [msg isEqualToString:@"6"] ){
            
//                NSString *vldStatus = [json valueForKey:@"RealNameAuStatus"];
//                
//                // 保存用户的状态
//                [CommonUtil addValue:vldStatus andKey:REALAUSTATUS];
//                
//                // 6：您的账户余额不足
//                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示"
//                                                                   message:@"您的账户余额不足"
//                                                                  delegate:self
//                                                         cancelButtonTitle:@"取消"
//                                                         otherButtonTitles:@"立即充值",nil];
//                alertView.tag = 123893;
//                
//                [alertView show];
//                
//            }else if ( [msg isEqualToString:@"7"] ){
//                
//                // 7：支付密码未设置
//                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示"
//                                                                   message:@"支付密码未设置"
//                                                                  delegate:self
//                                                         cancelButtonTitle:@"取消"
//                                                         otherButtonTitles:@"立即设置",nil];
//                alertView.tag = 123894;
//                
//                [alertView show];
                
                
//            }
        else {
                
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示"
                                                                   message:msg
                                                                  delegate:nil
                                                         cancelButtonTitle:@"确定"
                                                         otherButtonTitles:nil];
                
                [alertView show];
                
            }
            
        }
        
    } failure:^(NSError *error) {
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ( alertView.tag == 123894 ){
        if ( buttonIndex == 1 ) {
            
            // 未设置支付密码，进入支付密码设置的页面
            PaymentQueViewController *viewController = [[PaymentQueViewController alloc]initWithNibName:@"PaymentQueViewController" bundle:nil];
            [self.navigationController pushViewController:viewController animated:YES];
            
        }else{
            
            
        }
        
        
    }
    else if ( alertView.tag == 123893 ){
        if ( buttonIndex == 1 ) {
            // 余额不足跳转到充值的页面
            
            PayStyleViewController *VC = [[PayStyleViewController alloc]initWithNibName:@"PayStyleViewController" bundle:nil];
            VC.m_typeString = @"1";
            [self.navigationController pushViewController:VC animated:YES];
            
            
        }else{
          
        
        }
    }
    else if ( alertView.tag == 123895 ){
        
        if (buttonIndex == 0) {
            
            //立即邀请
            
            InviteViewController * VC = [[InviteViewController alloc]initWithNibName:@"InviteViewController" bundle:nil];
            
            [self.navigationController pushViewController:VC animated:YES];
            
        }
        
        //购物提醒是否是生活达人
        if (buttonIndex == 1){

            [CommonUtil addValue:@"1" andKey:[NSString stringWithFormat:@"%@%@",MEMBER_ID,MemResNo]];
            
            [self GoBuyReally];

            
        }else if (buttonIndex == 2){
            
            [self GoBuyReally];
            
        }
        
        
        
    }else  if ( alertView.tag == 100100 ) {
        if ( buttonIndex == 1 ) {
            // 跳转到下载微信的地址
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[WXApi getWXAppInstallUrl]]];
        }else{
            
        }
    }else{
        
        
    }


}

- (IBAction)contactMerchant:(id)sender {
    // 进入联系卖家的客服选择的页面
    
    ContactMerchantViewController *VC = [[ContactMerchantViewController alloc]initWithNibName:@"ContactMerchantViewController" bundle:nil];
    VC.m_merchantId = [NSString stringWithFormat:@"%@",[self.m_itemsDic objectForKey:@"MerchantID"]];
    [self.navigationController pushViewController:VC animated:YES];
    
}

//保险免费试算

- (void) InsureTryCount
{
    InsurecountViewController * VC =[[InsurecountViewController alloc]initWithNibName:@"InsurecountViewController" bundle:nil];
    VC.InsureTitle = [NSString stringWithFormat:@"%@",[self.m_itemsDic objectForKey:@"SvcName"]];
    VC.InsuresimpleTitle = [NSString stringWithFormat:@"%@",[self.m_itemsDic objectForKey:@"SvcSimpleName"]];
    VC.Insuremctid = [NSString stringWithFormat:@"%@",[self.m_itemsDic objectForKey:@"Seconddomain"]];
    VC.InsureMerchantID = [NSString stringWithFormat:@"%@",[self.m_itemsDic objectForKey:@"MerchantID"]];
    VC.InsureServiceID = [NSString stringWithFormat:@"%@",[self.m_itemsDic objectForKey:@"ServiceID"]];
    [self.navigationController pushViewController:VC animated:YES];
 
}

//获取大众点评商品详情
-(void) getDatadetailFromDP
{
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        return;
    }
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    NSString *url = @"v1/deal/get_single_deal";
    NSString * params = [NSString stringWithFormat:@"deal_id=%@&return_html=1",self.m_productId];
    
    NSLog(@"%@",params);

    [[[AppDelegate instance] dpapi] requestWithURL:url paramsString:params delegate:self];

}


- (void)request:(DPRequest *)request didFailWithError:(NSError *)error {

    [SVProgressHUD showErrorWithStatus:@"请求失败，稍后再试！"];

}


- (void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result {
    
    dpapinum ++;
    
    NSString * success = [result valueForKey:@"status"];
    
    if ([success isEqualToString:@"OK"]) {
        

        if (dpapinum ==1) {
            
            NSMutableArray * array =[result valueForKey:@"deals"];
            
            if (array.count == 0) {
                
                [SVProgressHUD showErrorWithStatus:@"暂不能购买"];
                return;
            }
            
        }

        //商品
        if ([[result valueForKey:@"deals"] objectAtIndex:0]!=nil) {
            
            NSArray *arr = [result valueForKey:@"deals"];
            
            if ( arr.count != 0 ) {
                
                self.m_itemsDic = [[result valueForKey:@"deals"] objectAtIndex:0];
                
            }
            
            
            NSString *burl =@"v1/business/get_batch_businesses_by_id";
            
            NSArray * array =[self.m_itemsDic objectForKey:@"businesses"];
            
            NSString * bparams = @"";
            
            if (array.count == 1) {
                
                bparams = [NSString stringWithFormat:@"business_ids=%@&platform=2",[[array objectAtIndex:0] objectForKey:@"id"]];
                
            }else{
                
                if ( array.count != 0 ) {
                
                    bparams = [NSString stringWithFormat:@"%@",[[array objectAtIndex:0] objectForKey:@"id"]];
                    
                    //显示前40条数据
                    for (int i=1; i<array.count; i++) {
                        
                        if (i==40) {
                            break;
                        }
                        
                        bparams = [NSString stringWithFormat:@"%@,%@",bparams,[[array objectAtIndex:i] objectForKey:@"id"]];
                        
                    }
                    bparams = [NSString stringWithFormat:@"business_ids=%@&platform=2",bparams];
                }
                
            }
            
            
            [[[AppDelegate instance] dpapi] requestWithURL:burl paramsString:bparams delegate:self];
            
            
            //批量获取商户详情
        }else{
            
            
            [self.m_productList removeAllObjects];//其他商品为空；
            
            [self.m_CommonBanner initScollerView:self.m_itemsDic From:@"DP"];//滚动的广告图片，以及原价，现价，折扣
            
            self.m_tableView.tableHeaderView = self.m_CommonBanner;
            
            self.m_totalPrice.text = [NSString stringWithFormat:@"%@元",[self.m_itemsDic objectForKey:@"current_price"]];//现价
            
            
            // 商品介绍
            self.m_productIntro = [NSString stringWithFormat:@"%@",[self.m_itemsDic objectForKey:@"details"]];
            
            NSString *BookStr = [self htmlString:self.m_productIntro];
            
            // webView赋值
            [self.m_detailsWebView loadHTMLString:BookStr baseURL:nil];
            
            
            // 特别提示
            self.m_PromptmString = [NSString stringWithFormat:@"%@",[[self.m_itemsDic objectForKey:@"restrictions"] objectForKey:@"special_tips"]];
            
            
            NSString *string = [self htmlString:self.m_PromptmString];
            
            // webView赋值
            [self.m_specialWebView loadHTMLString:string baseURL:nil];

            
            
            self.m_totalPrice.frame = CGRectMake(0, 8, 100, self.m_totalPrice.frame.size.height);
            self.m_buyBtn.frame = CGRectMake(WindowSizeWidth - self.m_buyBtn.frame.size.width - 10, 7, self.m_buyBtn.frame.size.width, self.m_buyBtn.frame.size.height);
            
            //处理多个商户
            self.dp_merchantList = [result valueForKey:@"businesses"];
            
            
            // 隐藏进入购物车页面的按钮
            self.m_cartShopBtn.hidden = YES;
            
            self.m_addcarBtn.hidden = YES;
            self.merchantBtn.hidden = YES;
            self.merchantimage.hidden = YES;
            self.m_totalPrice.hidden = NO;
            self.m_tableView.hidden = NO;
            self.m_sectionView.hidden = NO;
    
        }
        
    }else{
        
        [SVProgressHUD showErrorWithStatus:@"请求失败"];
        
    }
    
}

//explain返利
- (void)ExplaintoView
{
    ExplainViewController * VC = [[ExplainViewController alloc]initWithNibName:@"ExplainViewController" bundle:nil];
    VC.m_totalPricestring =self.m_totalPrice.text;
    VC.m_FromDPId = self.m_FromDPId;
    VC.m_itemsDic = self.m_itemsDic;
    [self.navigationController pushViewController:VC animated:YES];
}

- (void)Animation:(UIImageView*)imageView
{
    NSArray *Animation;
    Animation=[[NSArray alloc]initWithObjects:[UIImage imageNamed:@"zhuai.png"],[UIImage imageNamed:@"jinbie.png"],[UIImage imageNamed:@"zhuani.png"],nil];
    imageView.animationImages=Animation;
    imageView.animationDuration=1;
    imageView.animationRepeatCount = 2;
    [imageView startAnimating];
}

-(double)distanceBetweenOrderBy:(double)lat1 :(double)lat2 :(double)lng1 :(double)lng2{
    CLLocation* curLocation = [[CLLocation alloc] initWithLatitude:lat1 longitude:lng1];
    CLLocation* otherLocation = [[CLLocation alloc] initWithLatitude:lat2 longitude:lng2];
    double distance  = [curLocation distanceFromLocation:otherLocation];
    return distance;
}

//存放离我最近的店铺
-(void)ADDdp_merchantDIC{
    
    FrommeNearly = 0;
    if (self.dp_merchantList.count>1) {
        double a = [[CommonUtil getValueByKey:kLatitudeKey] doubleValue];
        double c = [[CommonUtil getValueByKey:kLongitudeKey] doubleValue];

        double longlalo = [self distanceBetweenOrderBy:a :[[[self.dp_merchantList objectAtIndex:0] objectForKey:@"latitude"] doubleValue] :c :[[[self.dp_merchantList objectAtIndex:0] objectForKey:@"longitude"] doubleValue]];
        
        for (int i=1; i<self.dp_merchantList.count; i++) {
        double newlonglalo = [self distanceBetweenOrderBy:a :[[[self.dp_merchantList objectAtIndex:i] objectForKey:@"latitude"] doubleValue] :c :[[[self.dp_merchantList objectAtIndex:i] objectForKey:@"longitude"] doubleValue]];
            
            if (longlalo > newlonglalo) {
                longlalo = newlonglalo;
                FrommeNearly = i;
            }
        }
    }
    

}

#pragma mark - UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView{
    
    //	[self startLoading];
}

//webView加载完成后设置内容字体的大小，内容的高度
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    if ( webView == self.m_detailsWebView || webView == self.m_specialWebView ) {
        
        CGFloat high = 0.0;
        //UIWebView字体大小设为190
//        NSString *jsString = [[NSString alloc] initWithFormat:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '%f%%'",190.0f];
        
        
        NSString *jsString = [[NSString alloc] initWithFormat:@"document.body.style.fontSize=%f;document.body.style.color=%@",16.0f,[UIColor blackColor]];
        
        [webView stringByEvaluatingJavaScriptFromString:jsString];
        
        
        //获取webView的自适应高度
        high = [webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight;"].floatValue;
        
        
        
        CGRect frame = [webView frame];
        frame.size.height = high;
        [webView setFrame:CGRectMake(20, 45, WindowSizeWidth - 40, high + 10 + 20)];
        
        [SVProgressHUD dismiss];

        // 刷新列表
        [self.m_tableView reloadData];
        
    }
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    

}



@end
