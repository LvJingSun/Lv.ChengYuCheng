//
//  SaleProductDetailViewController.m
//  HuiHui
//
//  Created by mac on 14-2-12.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "SaleProductDetailViewController.h"

#import "SubmitOrderViewController.h"

#import "ProductDetailCell.h"

#import "MapViewController.h"

#import "ShopListViewController.h"

#import "SaleProductListCell.h"

#import "ProductDetailViewController.h"

#import "TokenViewController.h"

#import "PanicBuyingViewController.h"

#import "UIImageView+AFNetworking.h"

#import "CommonUtil.h"

#import "SVProgressHUD.h"

#import "AppHttpClient.h"

#import "PanicShopListViewController.h"

#import "PaymentQueViewController.h"

#import "PayStyleViewController.h"

#import "SharetoHuiHuiViewController.h"


@interface SaleProductDetailViewController ()

@property (weak, nonatomic) IBOutlet UITableView *m_tableView;

@property (strong, nonatomic) IBOutlet UIView *m_headerView;

@property (weak, nonatomic) IBOutlet UIScrollView *m_scrollerView;

@property (weak, nonatomic) IBOutlet UILabel *m_nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_priceLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_orignPrice;

@property (weak, nonatomic) IBOutlet UILabel *m_endTimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_buyCountLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_line;

@property (weak, nonatomic) IBOutlet UIButton *m_qianggouBtn;

@property (weak, nonatomic) IBOutlet UIView *m_footerView;

@property (strong, nonatomic) IBOutlet UIView *m_showView;

@property (weak, nonatomic) IBOutlet UIButton *HuiHuiDyn;
@property (weak, nonatomic) IBOutlet UIButton *HuiHuiFri;

// 立即抢购按钮触发的事件
- (IBAction)qianggouBtnClicked:(id)sender;
// 分享按钮触发的事件
- (IBAction)shareBtnClicked:(id)sender;

// 每个分享按钮触发的事件
- (IBAction)shareClicked:(id)sender;

// 取消
- (IBAction)cancelShare:(id)sender;

@end

@implementation SaleProductDetailViewController

@synthesize m_array;

@synthesize m_productList;

@synthesize m_dic;

@synthesize m_shopList;

@synthesize m_webViewArray;

@synthesize m_Second;

@synthesize m_timeSecond;

@synthesize mEndTimer;

@synthesize m_values;

@synthesize m_Funtions;

@synthesize m_keyTimes;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        m_array = [[NSMutableArray alloc]initWithCapacity:0];
        
        m_productList = [[NSMutableArray alloc]initWithCapacity:0];
        
        m_dic = [[NSMutableDictionary alloc]initWithCapacity:0];
        
        m_shopList = [[NSMutableArray alloc]initWithCapacity:0];
        
        m_webViewArray = [[NSMutableArray alloc]initWithCapacity:0];

        m_current = 0;
        
        m_timeSecond = 0;
        
        m_Second = 0;
        
        mEndTimer = [[NSTimer alloc]init];
        
        m_values = [[NSArray alloc]init];
        
        m_Funtions = [[NSArray alloc]init];
        
        m_keyTimes = [[NSArray alloc]init];
   
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setTitle:@"抢购商品详情"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    [self setRightButtonWithTitle:@"得令牌" action:@selector(rightClicked)];
    
    self.m_tableView.hidden = YES;
    
    self.m_footerView.hidden = YES;
    
    //圆角
    [self.HuiHuiDyn.layer setMasksToBounds:YES];
    [self.HuiHuiDyn.layer setCornerRadius:10];
    
    //圆角
    [self.HuiHuiFri.layer setMasksToBounds:YES];
    [self.HuiHuiFri.layer setCornerRadius:10];
    
    // 添加时钟
    if ( ![self.mEndTimer isValid] && self.mEndTimer == nil ) {
        self.mEndTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    }
    
    // 解决刷新tableView的时候时钟秒数不动得问题
    [[NSRunLoop currentRunLoop]addTimer:self.mEndTimer forMode:NSRunLoopCommonModes];

    
    // 初始化三个用于动画的数组
    NSArray *array = [[NSArray alloc]initWithObjects:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f, 0.01f, 1.0f)],[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.0f)],[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9f, 0.9f, 1.0f)],[NSValue valueWithCATransform3D:CATransform3DIdentity], nil];
    
    NSArray *keyTimes = [[NSArray alloc]initWithObjects:@"0.2f",@"0.5f", @"0.75f", @"1.0f", nil];
    
    NSArray *funtions = [[NSArray alloc]initWithObjects:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                         [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                         [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut], nil];
    
    self.m_values = array;
    
    self.m_keyTimes = keyTimes;
    
    self.m_Funtions = funtions;
    
    // 商品详情请求数据
    [self productDetailSubmit];
    
    
    self.m_showView.center = self.view.center;
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear: animated];
    
    [self hideTabBar:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [self hideTabBar:NO];
    
    if ( [self.mEndTimer isValid] ) {
        
        [self.mEndTimer invalidate];
        
        self.mEndTimer = nil;
        
    }
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
    // 进入获取令牌的页面
    TokenViewController *VC = [[TokenViewController alloc]initWithNibName:@"TokenViewController" bundle:nil];
    VC.m_stringType = @"1";
    [self.navigationController pushViewController:VC animated:YES];
    
}

- (void)initScrollerView{
    
//    [self.m_scrollerView setContentSize:CGSizeMake(310 * self.m_array.count,100)];
    
    self.m_scrollerView.pagingEnabled = YES;
    
    self.m_scrollerView.showsHorizontalScrollIndicator = NO;
    
    self.m_scrollerView.showsVerticalScrollIndicator = NO;
    
//    for (int i = 0; i < self.m_array.count; i ++) {
//        
//        
//    }
    
    self.m_scrollerView.backgroundColor = [UIColor clearColor];
    
    UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(0 * WindowSizeWidth - 10, 0, WindowSizeWidth - 10, 100)];
    imgV.backgroundColor = [UIColor blueColor];
//    imgV.image = [UIImage imageNamed:@"back.png"];
    
    NSString *imagePath = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"FrontCover"]];
    [imgV setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:imagePath]]
                placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"]
                         success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                             imgV.image = [CommonUtil scaleImage:image toSize:CGSizeMake(WindowSizeWidth - 10, 100)];
                //                                      self.m_imagV.contentMode = UIViewContentModeCenter;
//                             [self.imageCache addImage:self.m_imageView.image andUrl:imagePath];
                         }
                         failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                             
                         }];
    
    
    [self.m_scrollerView addSubview:imgV];
    
    
    // 初始化pageControl
    CGRect pageControlFrame = CGRectMake(0, 132, WindowSizeWidth, 10);
    self.m_pageControl = [[GrayPageControl alloc]initWithFrame:pageControlFrame];
    self.m_pageControl.backgroundColor = [UIColor clearColor];//背景
    self.m_pageControl.inactiveImage = [UIImage imageNamed:@"white.png"];
    self.m_pageControl.activeImage = [UIImage imageNamed:@"blue.png"];
    
    self.m_pageControl.userInteractionEnabled = NO;
    self.m_pageControl.numberOfPages = 1;//self.m_array.count;
    self.m_pageControl.currentPage = 0;
    
    [self.m_headerView addSubview:self.m_pageControl];
    
}

- (void)timerAction{
    
    self.m_timeSecond ++;
    
    // 判断是否抢购开始
    if ( [self.m_startTime compare:self.m_systemTime] == NSOrderedDescending ) {
        // 抢购未开始
        
        NSTimeInterval interval = [self.m_startTime timeIntervalSinceDate:self.m_systemTime] - self.m_timeSecond;
        
        if ( interval < 0.000000 ) {
            
            // 进行中
            NSTimeInterval interval1 = [self.m_EndLimitTime timeIntervalSinceDate:self.m_startTime] - self.m_timeSecond + self.m_Second + 1;
            
            if ( interval1 < 0.000000 ) {
                
                self.m_endTimeLabel.text = @"抢购已结束";
                
            }else{
                
                self.m_endTimeLabel.text = [NSString stringWithFormat:@"还有%d小时%d分%d秒结束",(int)interval1 / 3600,(int)interval1 / 60 % 60,(int)interval1 % 60];
            }
            
            
            // 判断令牌数
            NSString *string = [NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:TOKENNOUSEDTOTAL]];
            
            NSString *useToken = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"InviteTokenUse"]];
            
            if ( [string intValue] < [useToken intValue] ) {
                
                // 令牌不足
                self.m_qianggouBtn.userInteractionEnabled = NO;
                
                self.m_qianggouBtn.enabled = NO;
                
                [self.m_qianggouBtn setTitle:@"令牌不足" forState:UIControlStateNormal];
                
            }else{
                
                if ( interval1 < 0.000000 ) {
                    
                    self.m_qianggouBtn.userInteractionEnabled = NO;
                    
                    self.m_qianggouBtn.enabled = NO;
                    
                    [self.m_qianggouBtn setTitle:@"已结束" forState:UIControlStateNormal];
                    
                }else{
                    
                    self.m_qianggouBtn.userInteractionEnabled = YES;
                    
                    self.m_qianggouBtn.enabled = YES;
                    
                    [self.m_qianggouBtn setTitle:@"立即抢购" forState:UIControlStateNormal];
                }
                
            }
            
        }else{
            
            self.m_Second = self.m_timeSecond;

            // 未开始
            self.m_endTimeLabel.text = @"抢购未开始";
            
            self.m_endTimeLabel.text = [NSString stringWithFormat:@"%d:%d:%d 后开始",(int)interval / 3600,(int)interval / 60 % 60,(int)interval % 60];
            
            // 判断令牌数
            NSString *string = [NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:TOKENNOUSEDTOTAL]];
            
            NSString *useToken = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"InviteTokenUse"]];
            
            if ( [string intValue] < [useToken intValue] ) {
                
                // 令牌不足
                self.m_qianggouBtn.userInteractionEnabled = NO;
                
                self.m_qianggouBtn.enabled = NO;
                
                [self.m_qianggouBtn setTitle:@"令牌不足" forState:UIControlStateNormal];
                
            }else{
                
                self.m_qianggouBtn.userInteractionEnabled = NO;
                
                self.m_qianggouBtn.enabled = NO;
                
                [self.m_qianggouBtn setTitle:@"未开始" forState:UIControlStateNormal];
                
                
            }
            
            
        }
        
    }else{
        
        // 计算当前时间与结束时间之间的时间差(秒) - 进行中的抢购
        NSTimeInterval interval = [self.m_EndLimitTime timeIntervalSinceDate:self.m_systemTime] - self.m_timeSecond;
        
        if ( interval < 0.000000 ) {
            
            self.m_endTimeLabel.text = @"抢购已结束";
            
        }else{
            
            self.m_endTimeLabel.text = [NSString stringWithFormat:@"还有%d小时%d分%d秒结束",(int)interval / 3600,(int)interval / 60 % 60,(int)interval % 60];
        }
        
        // 判断令牌数
        NSString *string = [NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:TOKENNOUSEDTOTAL]];
        
        NSString *useToken = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"InviteTokenUse"]];
        
        if ( [string intValue] < [useToken intValue] ) {
            
            // 令牌不足
            self.m_qianggouBtn.userInteractionEnabled = NO;
            
            self.m_qianggouBtn.enabled = NO;
            
            [self.m_qianggouBtn setTitle:@"令牌不足" forState:UIControlStateNormal];
            
        }else{
            
            if ( interval < 0.000000 ) {
                
                self.m_qianggouBtn.userInteractionEnabled = NO;
                
                self.m_qianggouBtn.enabled = NO;
                
                [self.m_qianggouBtn setTitle:@"已结束" forState:UIControlStateNormal];
                
            }else{
                
                self.m_qianggouBtn.userInteractionEnabled = YES;
                
                self.m_qianggouBtn.enabled = YES;
                
                [self.m_qianggouBtn setTitle:@"立即抢购" forState:UIControlStateNormal];
                
            }
            
            
        }
        
    }

}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 5 + self.m_productList.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"cellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        cell = [(UITableViewCell *)[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
        
    }
    
    
    if ( indexPath.row == 0 ) {
        
        cell = [self tableViewOne:tableView cellForRowAtIndexPath:indexPath];
        
    }else if ( indexPath.row < 5){
        
        cell = [self tableViewTwo:tableView cellForRowAtIndexPath:indexPath];
   
    }else{
        
        cell = [self tableViewOther:tableView cellForRowAtIndexPath:indexPath];

    }
    
    
    
    return cell;
    
    
}


- (UITableViewCell *)tableViewOne:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"ShopInforCellIdentifier";
    
    ShopInforCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"ProductDetailCell" owner:self options:nil];
        
        cell = (ShopInforCell *)[nib objectAtIndex:2];
        
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

    }
    
    if ( self.m_shopList.count != 0 ) {
        
        NSMutableDictionary *dic = [self.m_shopList objectAtIndex:0];
        
        cell.m_shopName.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"ShopName"]];
        cell.m_address.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Address"]];
        cell.m_time.text = [NSString stringWithFormat:@"营业时间：%@",[dic objectForKey:@"OpeningHours"]];
        cell.m_phone.text = [NSString stringWithFormat:@"咨询电话：%@",[dic objectForKey:@"Phone"]];
        
        
        if ( self.m_shopList.count == 1 ) {
            
            cell.m_moreLabel.hidden = YES;
            cell.m_moreBtn.hidden = YES;
            
            cell.m_arrowImgV.hidden = YES;
            
        }else{
            
            cell.m_moreLabel.hidden = NO;
            cell.m_moreBtn.hidden = NO;
            
            cell.m_arrowImgV.hidden = NO;

            
        }
        
        // 添加按钮触发的事件
        [cell.m_phoneBtn addTarget:self action:@selector(callPhone) forControlEvents:UIControlEventTouchUpInside];
        [cell.m_mapBtn addTarget:self action:@selector(mapClicked) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.m_moreBtn addTarget:self action:@selector(moreShop) forControlEvents:UIControlEventTouchUpInside];
        
        // 设置cell的背景边框
        cell.m_backImgV.layer.borderColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0].CGColor;
        cell.m_backImgV.layer.borderWidth = 1.0;
        
    
        
        
        // 设置cell的背景颜色
        //    UIImageView *imageV = [[UIImageView alloc]initWithFrame:cell.frame];
        //    imageV.backgroundColor = [UIColor clearColor];
        //
        //    cell.backgroundView = imageV;
        
        cell.backgroundColor = [UIColor clearColor];
        
    }

    
    return cell;
    
}


- (UITableViewCell *)tableViewTwo:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *cellIdentifier = @"SaleDetailCellIdentifier";
    
    SaleDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"SaleProductListCell" owner:self options:nil];
        
        cell = (SaleDetailCell *)[nib objectAtIndex:1];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

    }
    
//    cell.m_webView.userInteractionEnabled = NO;
    
    cell.m_webView.scrollView.scrollEnabled = NO;
    
    if ( indexPath.row == 1 ) {
        
        cell.m_titleLabel.text = @"商品详情";
        
//        CGSize size = [self.m_productIntro sizeWithFont:[UIFont systemFontOfSize:17.0f] constrainedToSize:CGSizeMake(280, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
        
        
        if ( self.m_webViewArray.count != 0 ) {
            
            
            UIWebView *webView = (UIWebView *)[self.m_webViewArray objectAtIndex:0];
            
            [cell.m_webView loadHTMLString:self.m_productIntro baseURL:nil];
            
            cell.m_webView.frame = CGRectMake(20, 45, WindowSizeWidth - 40, webView.frame.size.height);
            
            cell.m_backImgV.frame = CGRectMake(10, 10, cell.m_backImgV.frame.size.width, 68 - 21 + webView.frame.size.height);
            
            cell.frame = CGRectMake(0, 0, WindowSizeWidth, cell.m_backImgV.frame.size.height + 10);
            

        }
        
  
        
    }else if ( indexPath.row == 2){
        
        cell.m_titleLabel.text = @"诲抢规则";
        
        if ( self.m_webViewArray.count != 0 ) {
            
            UIWebView *webView = (UIWebView *)[self.m_webViewArray objectAtIndex:1];
            
            [cell.m_webView loadHTMLString:self.m_ruleString baseURL:nil];
            
            cell.m_webView.frame = CGRectMake(20, 45, WindowSizeWidth - 40, webView.frame.size.height);
            
            cell.m_backImgV.frame = CGRectMake(10, 10, cell.m_backImgV.frame.size.width, 68 - 21 + webView.frame.size.height);
            
            cell.frame = CGRectMake(0, 0, WindowSizeWidth, cell.m_backImgV.frame.size.height + 10);
            
        }

        
        
    } else if ( indexPath.row == 3 ){
        
        cell.m_titleLabel.text = @"如何使用";
        
        if ( self.m_webViewArray.count != 0 ) {
            
            
            UIWebView *webView = (UIWebView *)[self.m_webViewArray objectAtIndex:2];
            
            [cell.m_webView loadHTMLString:self.m_userString baseURL:nil];
            
            cell.m_webView.frame = CGRectMake(20, 45, WindowSizeWidth - 40, webView.frame.size.height);
            
            cell.m_backImgV.frame = CGRectMake(10, 10, cell.m_backImgV.frame.size.width, 68 - 21 + webView.frame.size.height);
            
            cell.frame = CGRectMake(0, 0, WindowSizeWidth, cell.m_backImgV.frame.size.height + 10);
            
        }
        
        
    }else if ( indexPath.row == 4 ){
        
        cell.m_titleLabel.text = @"商户介绍";
        
        if ( self.m_webViewArray.count != 0 ) {
            
            UIWebView *webView = (UIWebView *)[self.m_webViewArray objectAtIndex:3];
            
            [cell.m_webView loadHTMLString:self.m_merchantInfo baseURL:nil];
            
            cell.m_webView.frame = CGRectMake(20, 45, WindowSizeWidth - 40, webView.frame.size.height);
            
            cell.m_backImgV.frame = CGRectMake(10, 10, cell.m_backImgV.frame.size.width, 68 - 21 + webView.frame.size.height);
            
            cell.frame = CGRectMake(0, 0, WindowSizeWidth, cell.m_backImgV.frame.size.height + 10);
            
        }

        
    }

    // 设置cell的背景边框
    cell.m_backImgV.layer.borderColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0].CGColor;
    cell.m_backImgV.layer.borderWidth = 1.0;

    
    cell.backgroundColor = [UIColor clearColor];

    
    return cell;
}

- (UITableViewCell *)tableViewOther:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    
    if ( indexPath.row == 5 ) {
        
        static NSString *cellIdentifier = @"OtherCellIdentifier";
        
        OtherCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if ( cell == nil ) {
            
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"ProductDetailCell" owner:self options:nil];
            
            cell = (OtherCell *)[nib objectAtIndex:4];
            
            cell.backgroundColor = [UIColor clearColor];
            
        }
        
        
        if ( self.m_productList.count != 0 ) {
            
            cell.m_otherName.text = @"该商户相关商品";

            
            // 赋值
           NSMutableDictionary *dic = [self.m_productList objectAtIndex:indexPath.row - 5];
            
            cell.m_nameLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"ServiceName"]];
            
//            cell.m_nameLabel.text = [NSString stringWithFormat:@"%@",[self.m_productList objectAtIndex:indexPath.row - 5]];

            
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
            
            cell.selectionStyle = UITableViewCellSelectionStyleGray;
            
            cell.backgroundColor = [UIColor clearColor];

        }
        
        // 赋值
        if ( self.m_productList.count != 0 ) {
            
           NSMutableDictionary *dic = [self.m_productList objectAtIndex:indexPath.row - 5];
           
          cell.m_productName.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"ServiceName"]];
            
//             cell.m_productName.text = [NSString stringWithFormat:@"%@",[self.m_productList objectAtIndex:indexPath.row - 5]];
            
            
            // 设置cell的背景边框
            cell.m_backImgV.layer.borderColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0].CGColor;
            cell.m_backImgV.layer.borderWidth = 1.0;
            
        }
        
        return cell;
    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if ( indexPath.row > 5 ) {
       
        // 进入商品详情
        NSMutableDictionary *dic = [self.m_productList objectAtIndex:indexPath.row - 5];
        
        ProductDetailViewController *VC = [[ProductDetailViewController alloc]initWithNibName:@"ProductDetailViewController" bundle:nil];
        VC.m_productId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"ServiceId"]];
        VC.m_merchantShopId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"MerchantShopId"]];
        [self.navigationController pushViewController:VC animated:YES];

    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ( indexPath.row == 0 ) {
        
        return 145.0f;
        
    }else if ( indexPath.row == 1 ){
  
        if ( self.m_webViewArray.count != 0 ) {
            
            UIWebView *webView = (UIWebView *)[self.m_webViewArray objectAtIndex:0];
            
            return 68 - 21 + webView.frame.size.height + 10;

        }else{
            
            return 0.0f;
        }
        
    }else if ( indexPath.row == 2 ){
       
        if ( self.m_webViewArray.count != 0 ) {
           
            UIWebView *webView = (UIWebView *)[self.m_webViewArray objectAtIndex:1];
            
            return 68 - 21 + webView.frame.size.height + 10;
       
        }else{
            
            return 0.0f;
        }
   
    } else if ( indexPath.row == 3 ){
        
        if ( self.m_webViewArray.count != 0 ) {
           
            UIWebView *webView = (UIWebView *)[self.m_webViewArray objectAtIndex:2];
            
            return 68 - 21 + webView.frame.size.height + 10;
       
        }else{
            
            return 0.0f;
        }
        
    }else if ( indexPath.row == 4 ){
    
        if ( self.m_webViewArray.count != 0 ) {
         
            UIWebView *webView = (UIWebView *)[self.m_webViewArray objectAtIndex:3];
            
            return 68 - 21 + webView.frame.size.height + 10;
        
        }else{
            
            return 0.0f;
        }
        
    }else  if( indexPath.row == 5 ){
        
        return 78.0f;
        
    }else{
        
        return 40.0f;
    }
}

#pragma mark - BtnClicked
- (void)clickedBtn:(id)sender{
    
    UIButton *btn = (UIButton *)sender;
    
    // 进入商品详情
    NSMutableDictionary *dic = [self.m_productList objectAtIndex:btn.tag];
    
    ProductDetailViewController *VC = [[ProductDetailViewController alloc]initWithNibName:@"ProductDetailViewController" bundle:nil];
    VC.m_productId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"ServiceId"]];
    VC.m_merchantShopId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"MerchantShopId"]];
    [self.navigationController pushViewController:VC animated:YES];
    
}

- (void)callPhone{
    
//    NSMutableDictionary *dic = [self.m_itemsDic objectForKey:@"MerchantShop"];
    
    NSString *phone = [NSString stringWithFormat:@"0512-88603119"];
    
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
    
    NSMutableDictionary *dic = [self.m_shopList objectAtIndex:0];
    
    // 进入地图展示的页面
    MapViewController *VC = [[MapViewController alloc]initWithNibName:@"MapViewController" bundle:nil];
    VC.m_shopString = @"1";
    VC.item = dic;
    
    [self.navigationController pushViewController:VC animated:YES];
    
}

- (void)moreShop{
    // 商家地址列表
//    ShopListViewController *VC = [[ShopListViewController alloc]initWithNibName:@"ShopListViewController" bundle:nil];
//    VC.m_typeString = @"1";
////    VC.m_merchantId = [self.m_itemsDic objectForKey:@"MerchantID"];
//    
//    [self.navigationController pushViewController:VC animated:YES];
    
    PanicShopListViewController *VC = [[PanicShopListViewController alloc]initWithNibName:@"PanicShopListViewController" bundle:nil];
    VC.m_shopList = self.m_shopList;
    [self.navigationController pushViewController:VC animated:YES];
}


#pragma mark - UIScrollerDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.m_scrollerView) {
        CGFloat pageWidth = WindowSizeWidth - 10;
        int page = floor((self.m_scrollerView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
        self.m_pageControl.currentPage = page;
        
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == self.m_scrollerView) {
        CGFloat pageWidth = scrollView.frame.size.width;
		int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
		if (page != self.m_pageControl.currentPage)
		{
            if (page <= self.m_pageControl.numberOfPages) {
                self.m_pageControl.currentPage = page;
                
            }
		}
    }
}

- (IBAction)qianggouBtnClicked:(id)sender {
    
    NSString *imagePath = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"FrontCover"]];
    // 添加立即抢购里面的显示图片
    [CommonUtil addValue:imagePath andKey:@"productImage"];
    
    
   // 验证用户是否设置了安全问题
    [self paymentSafeRequest];
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
                           [NSString stringWithFormat:@"%@",self.m_panicBuyGoodID],@"panicBuyGoodID",
                           nil];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"WisdomPaymentCheck_1.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
//        NSString *ErrorCode = [NSString stringWithFormat:@"%@",[json valueForKey:@"ErrorCode"]];
        
        //    ErrorCode:0(Msg=用户信息丢失，请重新登录!)<br />
        //    ErrorCode:1(Msg=账号已被锁定!)<br />
        //    ErrorCode:2(Msg=您抢购的商品不存在!)<br />
        //    ErrorCode:3(Msg=请在活动进行时间内抢购!)<br />
        //    ErrorCode:4(Msg=商品已被抢光，请等待下次抢购活动!)<br />
        //    ErrorCode:11(Msg=您的邀请令牌不足，可邀请好友获得令牌!)<br />
        //    ErrorCode:12(Msg=您已经成功抢购，每人每商品只能抢购一次，不要贪心哦!)<br />
        
        
        if (success) {
            
            [SVProgressHUD dismiss];
            
            // 立即抢购
            PanicBuyingViewController *VC = [[PanicBuyingViewController alloc]initWithNibName:@"PanicBuyingViewController" bundle:nil];
            VC.m_items = self.m_dic;
            [self.navigationController pushViewController:VC animated:YES];
            
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD dismiss];
            
//            if ( [ErrorCode isEqualToString:@"5"] ){
//                // 未设置支付密码
//                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示"
//                                                                   message:@"您还未设置支付密码"
//                                                                  delegate:self
//                                                         cancelButtonTitle:@"取消"
//                                                         otherButtonTitles:@"立即设置",nil];
//                alertView.tag = 12940;
//                
//                [alertView show];
//                
//            }else if ( [ErrorCode isEqualToString:@"6"] ){
//                
//                NSString *vldStatus = [json valueForKey:@"RealNameAuStatus"];
//                
//                // 保存状态用于充值那边判断进入哪个页面
//                [CommonUtil addValue:vldStatus andKey:REALAUSTATUS];
//                
//                // 您和账户余额不足，请充值
//                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示"
//                                                                   message:@"余额不足"
//                                                                  delegate:self
//                                                         cancelButtonTitle:@"取消"
//                                                         otherButtonTitles:@"立即充值",nil];
//                alertView.tag = 123893;
//                
//                [alertView show];
//                
//                
//                
//            }else {
            
                // 其他提示情况
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示"
                                                                   message:msg
                                                                  delegate:nil
                                                         cancelButtonTitle:@"确定"
                                                         otherButtonTitles:nil];
                
                [alertView show];
                
//            }
            
            
            
        }
        
    } failure:^(NSError *error) {
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];
}

/*
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
                           [NSString stringWithFormat:@"%@",self.m_panicBuyGoodID],@"panicBuyGoodID",
                           nil];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"WisdomPaymentCheck.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        NSString *ErrorCode = [NSString stringWithFormat:@"%@",[json valueForKey:@"ErrorCode"]];
        
        
        //    ErrorCode:0(Msg=用户信息丢失，请重新登录!)<br />
        //    ErrorCode:1(Msg=账号已被锁定!)<br />
        //    ErrorCode:2(Msg=您抢购的商品不存在!)<br />
        //    ErrorCode:3(Msg=请在活动进行时间内抢购!)<br />
        //    ErrorCode:4(Msg=商品已被抢光，请等待下次抢购活动!)<br />
        //    ErrorCode:5(Msg=支付密码未设置!)<br />
        //    ErrorCode:11(Msg=您的邀请令牌不足，可邀请好友获得令牌!)<br />
        //    ErrorCode:12(Msg=您已经成功抢购，每人每商品只能抢购一次，不要贪心哦!)<br />
        
        
        if (success) {

            [SVProgressHUD dismiss];
            
            // 立即抢购
            PanicBuyingViewController *VC = [[PanicBuyingViewController alloc]initWithNibName:@"PanicBuyingViewController" bundle:nil];
            VC.m_items = self.m_dic;
            [self.navigationController pushViewController:VC animated:YES];
            
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];

            [SVProgressHUD dismiss];
            
            if ( [ErrorCode isEqualToString:@"5"] ){
                // 未设置支付密码
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示"
                                                                   message:@"您还未设置支付密码"
                                                                  delegate:self
                                                         cancelButtonTitle:@"取消"
                                                         otherButtonTitles:@"立即设置",nil];
                alertView.tag = 12940;
                
                [alertView show];
                
            }else if ( [ErrorCode isEqualToString:@"6"] ){
                
                NSString *vldStatus = [json valueForKey:@"RealNameAuStatus"];
                
                // 保存状态用于充值那边判断进入哪个页面
                [CommonUtil addValue:vldStatus andKey:REALAUSTATUS];
                
                // 您和账户余额不足，请充值
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示"
                                                                   message:@"余额不足"
                                                                  delegate:self
                                                         cancelButtonTitle:@"取消"
                                                         otherButtonTitles:@"立即充值",nil];
                alertView.tag = 123893;
                
                [alertView show];
                
                
                
            }else {
                
                // 其他提示情况
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

*/

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ( alertView.tag == 12940 ) {
        
        if ( buttonIndex == 1 ) {
            
            // 进入设置安全问题及支付密码的页面
            PaymentQueViewController *viewController = [[PaymentQueViewController alloc]initWithNibName:@"PaymentQueViewController" bundle:nil];
            [self.navigationController pushViewController:viewController animated:YES];
            
        }else{
            
            
        }
    }else if ( alertView.tag == 123893 ){
        if ( buttonIndex == 1 ) {
            // 余额不足跳转到充值的页面
            PayStyleViewController *VC = [[PayStyleViewController alloc]initWithNibName:@"PayStyleViewController" bundle:nil];
            VC.m_typeString = @"1";
            [self.navigationController pushViewController:VC animated:YES];
            
            
        }else{
            
            
        }
        
    }else if ( alertView.tag == 100100 ) {
        if ( buttonIndex == 1 ) {
            // 跳转到下载微信的地址
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[WXApi getWXAppInstallUrl]]];
        }else{
            
        }
    }else{
        
        
    }
    
}

- (void)productDetailSubmit{
   
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
                           [NSString stringWithFormat:@"%@",self.m_panicBuyGoodID],@"panicBuyGoodID",
                           nil];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"WisdomInfo.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
         
//            NSString *msg = [json valueForKey:@"msg"];
            
//            [SVProgressHUD dismiss];
            
            self.m_dic = [json valueForKey:@"PanBuyGood"];
            
            
            // 设置tableView的headerView
            self.m_tableView.tableHeaderView = self.m_headerView;
            
            self.m_productList = [self.m_dic objectForKey:@"ServiceList"];
            
            // 初始化scrollerView
            [self initScrollerView];
            
            self.m_nameLabel.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"GoodName"]];
            
            // 假数据赋值
            self.m_productIntro = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"GoodDetail"]];
            
            self.m_ruleString = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"GoodRule"]];
            
            self.m_userString = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"HowUse"]];
            
            self.m_merchantInfo = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"GoodSimpleName"]];
            
            self.m_priceLabel.text = [NSString stringWithFormat:@"￥%@",[self.m_dic objectForKey:@"Price"]];
            
            self.m_orignPrice.text = [NSString stringWithFormat:@"￥%@",[self.m_dic objectForKey:@"OriginalPrice"]];
            
            self.m_buyCountLabel.text = [NSString stringWithFormat:@"%@人已购买",[self.m_dic objectForKey:@"BuyedQuantity"]];
            
            CGSize size = [self.m_orignPrice.text sizeWithFont:[UIFont systemFontOfSize:12.0f] constrainedToSize:CGSizeMake(MAXFLOAT, 21) lineBreakMode:NSLineBreakByWordWrapping];
            self.m_line.frame = CGRectMake(self.m_orignPrice.frame.origin.x - 1, self.m_line.frame.origin.y, size.width + 3, 1);
            
            
            // 将值存入数组里来计算webView的宽度
            self.m_array = [NSMutableArray arrayWithObjects:self.m_productIntro,self.m_ruleString,self.m_userString,self.m_merchantInfo, nil];
            
            
            // 计算时间
            self.m_systemTime = [self dateFromString:[self.m_dic objectForKey:@"NowDateTime"]];
            self.m_EndLimitTime = [self dateFromString:[self.m_dic objectForKey:@"PanicBuyDateTimeE"]];

            self.m_startTime = [self dateFromString:[self.m_dic objectForKey:@"PanicBuyDateTimeS"]];
            
            // 店铺请求数据
            [self requestShopList];
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
    } failure:^(NSError *error) {
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];
    
}

// 获取店铺信息
- (void)requestShopList{
    
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
                           [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"PanicBuyGoodID"]],@"panicBuyGoodID",
                           nil];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"WisdomBuyShopList.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
//            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD dismiss];
            
            self.m_shopList = [json valueForKey:@"merchantShop"];
            
            
            // 初始化webView
            [self initData];
            
        } else {
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
    } failure:^(NSError *error) {
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];

}

- (void)initData{
    
    for (int i = 0; i < self.m_array.count; i ++) {
        
        NSString *string = [NSString stringWithFormat:@"%@",[self.m_array objectAtIndex:i]];
        
        UIWebView *l_webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 20, WindowSizeWidth - 40, 100)];
        l_webView.delegate = self;
        [l_webView loadHTMLString:string baseURL:nil];
        
        [self.m_webViewArray addObject:l_webView];
        
    }

}


#pragma mark - UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView{
	
//    [SVProgressHUD showWithStatus:@"加载中..."];
}

//webView加载完成后设置内容字体的大小，内容的高度
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    [SVProgressHUD dismiss];
	
	CGFloat high=0.0;
    //UIWebView字体大小设为190
	NSString *jsString = [[NSString alloc] initWithFormat:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '%f%%'",190.0f];

    //	NSString *jsString = [[NSString alloc] initWithFormat:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '%d%%'",190];
    [webView stringByEvaluatingJavaScriptFromString:jsString];
    //获取webView的自适应高度
    high = [webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight;"].floatValue/3.0f;
    
    CGRect frame = [webView frame];
    frame.size.height = high;
    [webView setFrame:CGRectMake(10, 25, 300, high)];
    
    
    // 当计算到最后一个webView的高度时刷新列表
    m_current ++;
    
    if ( m_current >= self.m_array.count ) {
        
        self.m_tableView.hidden = NO;
        
        self.m_footerView.hidden = NO;
		
		[self.m_tableView reloadData];
    }
    
	
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
	
	[SVProgressHUD dismiss];
    
}


#pragma mark - share
// 取消分享
- (IBAction)cancelShare:(id)sender{
    
    [self.m_showView removeFromSuperview];
    
}

- (IBAction)shareBtnClicked:(id)sender {
    
    [self.view addSubview:self.m_showView];
    
    // 动画
    CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    popAnimation.duration = 0.4;
    popAnimation.values = self.m_values;
    popAnimation.keyTimes = self.m_keyTimes;
    popAnimation.timingFunctions = self.m_Funtions;
    
    [self.m_showView.layer addAnimation:popAnimation forKey:nil];
}


- (IBAction)shareClicked:(id)sender{
    
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
        
        NSString *utf8String = [NSString stringWithFormat:@"http://wx.cityandcity.com/merchant_web/PanicBuying_detail.aspx?id=%@",self.m_panicBuyGoodID];
       
        NSLog(@"utf8String = %@",utf8String);
        
        NSString *title = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"GoodName"]];
        NSString *description = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"GoodDetail"]];
        newsObj = [QQApiNewsObject objectWithURL:[NSURL URLWithString:utf8String] title:title description:description previewImageURL:[NSURL URLWithString:[CommonUtil getValueByKey:@"productImage"]]];

        
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
        
        // QQ空间分享
        tencentOAuth = [[TencentOAuth alloc]initWithAppId:TencentQzoneAppId andDelegate:self];
        NSString *utf8String = [NSString stringWithFormat:@"http://wx.cityandcity.com/merchant_web/PanicBuying_detail.aspx?id=%@",self.m_panicBuyGoodID];
        
        NSLog(@"utf8String = %@",utf8String);
        
        NSString *title = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"GoodName"]];
        NSString *description = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"GoodDetail"]];
        newsObj = [QQApiNewsObject objectWithURL:[NSURL URLWithString:utf8String] title:title description:description previewImageURL:[NSURL URLWithString:[CommonUtil getValueByKey:@"productImage"]]];
        
        
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
        
        
    }else if ( btn.tag == 1005 ){
        
        // 将图片放在数组里然后进行赋值
        NSMutableArray *arr = [[NSMutableArray alloc]initWithCapacity:0];
        
        UIImage *image = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[CommonUtil getValueByKey:@"productImage"]]]];
        
        if(image != nil){
            
            [arr addObject:image];
        }
        
        //诲诲朋友圈
        SharetoHuiHuiViewController * VC = [[SharetoHuiHuiViewController alloc]initWithNibName:@"SharetoHuiHuiViewController" bundle:nil];
        
        VC.dealId = @"0";
        VC.serviceID = @"0";
        VC.m_merchantShopId = @"0";
        VC.dynamicType = @"WebViewShare";
        VC.STitle = [NSString stringWithFormat:@"%@", [self.m_dic objectForKey:@"GoodName"]];
        VC.subTitle =  [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"GoodDetail"]];
        VC.webUrl = [NSString stringWithFormat:@"http://wx.cityandcity.com/merchant_web/PanicBuying_detail.aspx?id=%@",self.m_panicBuyGoodID];
        
        VC.activityID = @"0";
        VC.ImageArray = arr;
        
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
            
            // 好友
            [self shareTogoodFriend];
            
        }else if ( aType == 1003 ) {
            // 朋友圈
            [self shareTogoodFriendShipsWithMessage];
            
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
    message.title = [NSString stringWithFormat:@"%@", [self.m_dic objectForKey:@"GoodName"]];
    message.description = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"GoodDetail"]];
    
    NSString *imagePath = [NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:@"productImage"]];
    
    UIImageView *imgV = [[UIImageView alloc]init];
    
    [imgV setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:imagePath]]
                placeholderImage:[UIImage imageNamed:@""]
                         success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                             imgV.image = [CommonUtil scaleImage:image toSize:CGSizeMake(60, 60)];
                             
                             // 微信进行赋值
                             [message setThumbImage:imgV.image];
                             
                             WXWebpageObject *ext = [WXWebpageObject object];
                             ext.webpageUrl = [NSString stringWithFormat:@"http://wx.cityandcity.com/merchant_web/PanicBuying_detail.aspx?id=%@",self.m_panicBuyGoodID];
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
    message.description = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"GoodDetail"]];
    message.title = [NSString stringWithFormat:@"%@", [self.m_dic objectForKey:@"GoodName"]];
    
    
    NSString *imagePath = [NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:@"productImage"]];
    
    UIImageView *imgV = [[UIImageView alloc]init];
    
    [imgV setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:imagePath]]
                placeholderImage:[UIImage imageNamed:@""]
                         success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                             imgV.image = [CommonUtil scaleImage:image toSize:CGSizeMake(60, 60)];
                             
                             // 微信进行赋值
                             [message setThumbImage:imgV.image];
                             
                             WXWebpageObject *ext = [WXWebpageObject object];
                             ext.webpageUrl = [NSString stringWithFormat:@"http://wx.cityandcity.com/merchant_web/PanicBuying_detail.aspx?id=%@",self.m_panicBuyGoodID];
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


@end
