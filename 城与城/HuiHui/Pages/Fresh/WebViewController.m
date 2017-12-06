//
//  WebViewController.m
//  HuiHui
//
//  Created by mac on 14-6-11.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "WebViewController.h"

#import "SVProgressHUD.h"

#import "CommonUtil.h"

#import "UIImageView+AFNetworking.h"

#import "SharetoHuiHuiViewController.h"

#import "TFHpple.h"

#import "SaleProductDetailViewController.h"

#import "ProductDetailViewController.h"
#import "Sharetofriend.h"
#import "HH_MactMenuViewController.h"
#import "HH_TakeOrderViewController.h"
#import "Ca_productListViewController.h"
#import "ProductListViewController.h"
#import "CPSHH_TakeOrderViewController.h"
@interface WebViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *m_webView;

@property (weak, nonatomic) IBOutlet UIButton *m_gobackBtn;

@property (weak, nonatomic) IBOutlet UIButton *m_gofowardBtn;

@property (strong, nonatomic) IBOutlet UIView *m_showView;

@property (weak, nonatomic) IBOutlet UIButton *HuiHuiFri;

@property (weak, nonatomic) IBOutlet UIButton *HuiHuiDyn;

// 返回上一级
- (IBAction)goBackWebView:(id)sender;
// 前进下一级
- (IBAction)goForwardWebView:(id)sender;
// 刷新
- (IBAction)refreshWebView:(id)sender;

// 分享
- (IBAction)shareBtnClicked:(id)sender;
// 取消
- (IBAction)cancelShare:(id)sender;

@end

@implementation WebViewController

@synthesize m_shareString;

@synthesize m_titleString;

@synthesize m_values;

@synthesize m_Funtions;

@synthesize m_keyTimes;

@synthesize m_typeString;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        m_values = [[NSArray alloc]init];
        
        m_Funtions = [[NSArray alloc]init];
        
        m_keyTimes = [[NSArray alloc]init];
        
        self.m_TakeOrderdic = [[NSMutableDictionary alloc]init];
        
        self.m_PushNextdic =[[NSMutableDictionary alloc]init];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    [self setLeftButtonWithNormalImage:@"back.png" action:@selector(leftClicked)];
    
    // 弹出输入法通知
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(keyboardDidShow)  name:UIKeyboardDidShowNotification  object:nil];
   
    // 导航栏上的左按钮
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
        
    [self setRightButtonWithTitle:@"分享" action:@selector(rightClicked)];

    NSArray *array = [[NSArray alloc]initWithObjects:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f, 0.01f, 1.0f)],[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.0f)],[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9f, 0.9f, 1.0f)],[NSValue valueWithCATransform3D:CATransform3DIdentity], nil];
    
    NSArray *keyTimes = [[NSArray alloc]initWithObjects:@"0.2f",@"0.5f", @"0.75f", @"1.0f", nil];
    
    NSArray *funtions = [[NSArray alloc]initWithObjects:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                         [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                         [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut], nil];
    
    self.m_values = array;
    
    self.m_keyTimes = keyTimes;
    
    self.m_Funtions = funtions;
    
    
    self.m_shareString = self.m_scanString;
    _shareimageURL = @"";
    //圆角
    [self.HuiHuiDyn.layer setMasksToBounds:YES];
    [self.HuiHuiDyn.layer setCornerRadius:10];
    
    //圆角
    [self.HuiHuiFri.layer setMasksToBounds:YES];
    [self.HuiHuiFri.layer setCornerRadius:10];
    
    
    self.m_showView.center = self.view.center;
    
    // 加载地址
    [self.m_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.m_scanString]]];
    
    NSLog(@"地址====%@",self.m_scanString);

}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self hideTabBar:YES];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)keyboardDidShow
{
    [self hiddenNumPadDone:nil];
}

- (void)leftClicked{
    
    
    [self hideTabBar:NO];
    
    // 1表示扫一扫页面的  2表示聊天页面跳转
    if ( [self.m_typeString isEqualToString:@"1"] ) {
        
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:0] animated:YES];

    }else{
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    
}

- (void)rightClicked{
    // 分享按钮触发的事件
    
    [self.view addSubview:self.m_showView];
    
    // 动画
    CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    popAnimation.duration = 0.4;
    popAnimation.values = self.m_values;
    popAnimation.keyTimes = self.m_keyTimes;
    popAnimation.timingFunctions = self.m_Funtions;
    
    [self.m_showView.layer addAnimation:popAnimation forKey:nil];
    
}

#pragma mark - UIWebViewDelegate
//此方法可以获取网页上的数据
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {

    self.m_shareString = [NSString stringWithFormat:@"%@",[[request URL] absoluteString]];

    self.m_PushNextdic = [[self dictionaryFromQuery:[NSString stringWithFormat:@"%@",[[request URL] query]] usingEncoding:NSUTF8StringEncoding] copy];

    //不为空并且!=4进行筛选类别（＝4的情况是网页 return YES）
    if (![[NSString stringWithFormat:@"%@",[self.m_PushNextdic objectForKey:@"cityandcitytype"]] isEqualToString:@"(null)"]) {
        
        [self setPushNextViewController];
    }
    
    
    return YES;
    
}


-(void)setPushNextViewController{
    
    if ([[self.m_PushNextdic objectForKey:@"cityandcitytype"]isEqualToString:@"1"]) {
        [self.m_webView stopLoading];
        SaleProductDetailViewController *VC = [[SaleProductDetailViewController alloc]initWithNibName:@"SaleProductDetailViewController" bundle:nil];
        VC.m_panicBuyGoodID = [NSString stringWithFormat:@"%@",[self.m_PushNextdic objectForKey:@"PanicBuyGoodID"]];
        [self.navigationController pushViewController:VC animated:YES];
        
    }else if([[self.m_PushNextdic objectForKey:@"cityandcitytype"]isEqualToString:@"2"]){
        [self.m_webView stopLoading];
        
        ProductDetailViewController *VC = [[ProductDetailViewController alloc]initWithNibName:@"ProductDetailViewController" bundle:nil];
        VC.m_FromDPId = @"0";
        VC.m_productId = [NSString stringWithFormat:@"%@",[self.m_PushNextdic objectForKey:@"serviceId"]];
        VC.m_merchantShopId = [NSString stringWithFormat:@"%@",[self.m_PushNextdic objectForKey:@"merchantShopId"]];
        [self.navigationController pushViewController:VC animated:YES];
        
    }
    
    //    跳转地址包含cityandcitytype=5跳转到点单列表页面
    else if([[self.m_PushNextdic objectForKey:@"cityandcitytype"]isEqualToString:@"5"]&&[[NSString stringWithFormat:@"%@",[self.m_PushNextdic objectForKey:@"merchantid"]] isEqualToString:@"(null)"]){
        [self.m_webView stopLoading];
        
        // 进入到点单的页面
        HH_MactMenuViewController *VC  = [[HH_MactMenuViewController alloc]initWithNibName:@"HH_MactMenuViewController" bundle:nil];
        [self.navigationController pushViewController:VC animated:YES];
        
    }
    //    跳转地址包含cityandcitytype=5&merchanid跳转到此商户点单页面
    else if([[self.m_PushNextdic objectForKey:@"cityandcitytype"]isEqualToString:@"5"]&&(![[NSString stringWithFormat:@"%@",[self.m_PushNextdic objectForKey:@"merchantid"]] isEqualToString:@"(null)"])){
        [self.m_webView stopLoading];
        
        
        // 获取店铺列表的信息
        NSMutableArray *arr = [self.m_TakeOrderdic objectForKey:@"ShopList"];
        
        [CommonUtil addValue:[self.m_TakeOrderdic objectForKey:@"Logo"] andKey:@"MarchantImageKey"];
        [CommonUtil addValue:[self.m_TakeOrderdic objectForKey:@"YHDescription"] andKey:YHDESCRIPTION];
        [CommonUtil addValue:[self.m_TakeOrderdic objectForKey:@"Man"] andKey:MANKEY];
        [CommonUtil addValue:[self.m_TakeOrderdic objectForKey:@"Jian"] andKey:JIANKEY];
        
        
        // 进入点菜的页面
//        HH_TakeOrderViewController *VC = [[HH_TakeOrderViewController alloc]initWithNibName:@"HH_TakeOrderViewController" bundle:nil];
//        VC.m_shopList = arr;
//        VC.m_seat = [NSString stringWithFormat:@"%@",[self.m_TakeOrderdic objectForKey:@"IsSelectSeat"]];
//        VC.m_merchantId = [NSString stringWithFormat:@"%@",[self.m_TakeOrderdic objectForKey:@"MerchantID"]];
//        VC.m_ModelType = [NSString stringWithFormat:@"%@",[self.m_TakeOrderdic objectForKey:@"ModelType"]];
//        
//        VC.IsZCWaiMai = [NSString stringWithFormat:@"%@",[self.m_TakeOrderdic objectForKey:@"IsZCWaiMai"]];
//        
//        [self.navigationController pushViewController:VC animated:YES];
        
        
        CPSHH_TakeOrderViewController *VCC = [[CPSHH_TakeOrderViewController alloc]init];
        [VCC.m_dic setObject:arr forKey:@"m_shopList"];
        [VCC.m_dic setObject:[NSString stringWithFormat:@"%@",[self.m_TakeOrderdic objectForKey:@"IsSelectSeat"]] forKey:@"m_seat"];
        [VCC.m_dic setObject:[NSString stringWithFormat:@"%@",[self.m_TakeOrderdic objectForKey:@"ModelType"]] forKey:@"m_ModelType"];
        [VCC.m_dic setObject:[NSString stringWithFormat:@"%@",[self.m_TakeOrderdic objectForKey:@"MerchantID"]] forKey:@"m_merchantId"];
        [VCC.m_dic setObject:[NSString stringWithFormat:@"%@",[self.m_TakeOrderdic objectForKey:@"IsZCWaiMai"]] forKey:@"IsZCWaiMai"];
        [self.navigationController pushViewController:VCC animated:YES];
        
        
        
    }
    //    跳转地址包含cityandcitytype=6跳转到团购页面（类别全部，城市全城，离我最近）
    else if([[self.m_PushNextdic objectForKey:@"cityandcitytype"]isEqualToString:@"6"]&&([[NSString stringWithFormat:@"%@",[self.m_PushNextdic objectForKey:@"merchantid"]] isEqualToString:@"(null)"])){
        [self.m_webView stopLoading];
        
        // 进入商品列表的页面
        Ca_productListViewController *VC = [[Ca_productListViewController alloc]initWithNibName:@"Ca_productListViewController" bundle:nil];
        VC.TwoID = @"";
        VC.m_titleString = @"全部分类";
        [self.navigationController pushViewController:VC animated:YES];
        
    }
    //    跳转地址包含cityandcitytype=6&merchanid跳转到此商户的商品列表页面
    else if([[self.m_PushNextdic objectForKey:@"cityandcitytype"]isEqualToString:@"6"]&&(![[NSString stringWithFormat:@"%@",[self.m_PushNextdic objectForKey:@"merchantid"]] isEqualToString:@"(null)"])){
        [self.m_webView stopLoading];
        
        // 进入商品列表
        ProductListViewController *VC = [[ProductListViewController alloc]initWithNibName:@"ProductListViewController" bundle:nil];
        VC.m_merchantId = [NSString stringWithFormat:@"%@",[self.m_PushNextdic objectForKey:@"merchantid"]];
        VC.m_merchantShopId = @"";
        
        [self.navigationController pushViewController:VC animated:YES];
        
    }
    //    跳转地址包含cityandcitytype=10跳转到团购页面（类别全部，城市全城，离我最近）
    else if([[self.m_PushNextdic objectForKey:@"cityandcitytype"]isEqualToString:@"10"]&&([[NSString stringWithFormat:@"%@",[self.m_PushNextdic objectForKey:@"mctid"]] isEqualToString:@"(null)"])){
        [self.m_webView stopLoading];
        
        // 进入商品列表的页面
        Ca_productListViewController *VC = [[Ca_productListViewController alloc]initWithNibName:@"Ca_productListViewController" bundle:nil];
        VC.TwoID = @"";
        VC.m_titleString = @"全部分类";
        [self.navigationController pushViewController:VC animated:YES];
        
    }    //    跳转地址包含cityandcitytype=11&merchanid跳转到此商户的商品列表页面
    else if([[self.m_PushNextdic objectForKey:@"cityandcitytype"]isEqualToString:@"11"]&&(![[NSString stringWithFormat:@"%@",[self.m_PushNextdic objectForKey:@"mctid"]] isEqualToString:@"(null)"])){
        [self.m_webView stopLoading];
        
        // 进入商品列表
        ProductListViewController *VC = [[ProductListViewController alloc]initWithNibName:@"ProductListViewController" bundle:nil];
        VC.m_merchantId = [NSString stringWithFormat:@"%@",[self.m_PushNextdic objectForKey:@"mctid"]];
        VC.m_merchantShopId = @"";
        
        [self.navigationController pushViewController:VC animated:YES];
        
    }    //    跳转地址包含cityandcitytype=12跳转到点单列表页面
    else if([[self.m_PushNextdic objectForKey:@"cityandcitytype"]isEqualToString:@"12"]&&[[NSString stringWithFormat:@"%@",[self.m_PushNextdic objectForKey:@"mctid"]] isEqualToString:@"(null)"]){
        [self.m_webView stopLoading];
        
        // 进入到点单的页面
        HH_MactMenuViewController *VC  = [[HH_MactMenuViewController alloc]initWithNibName:@"HH_MactMenuViewController" bundle:nil];
        [self.navigationController pushViewController:VC animated:YES];
        
    }    //    跳转地址包含cityandcitytype=5&merchanid跳转到此商户点单页面
    else if([[self.m_PushNextdic objectForKey:@"cityandcitytype"]isEqualToString:@"13"]&&(![[NSString stringWithFormat:@"%@",[self.m_PushNextdic objectForKey:@"mctid"]] isEqualToString:@"(null)"])){
        [self.m_webView stopLoading];
        
        [self GetMemberchantTakelist:[NSString stringWithFormat:@"%@",[self.m_PushNextdic objectForKey:@"mctid"]]];
        
    }//跳转到商品详情
    else if([[self.m_PushNextdic objectForKey:@"cityandcitytype"]isEqualToString:@"14"]&&(![[NSString stringWithFormat:@"%@",[self.m_PushNextdic objectForKey:@"shopid"]] isEqualToString:@"(null)"])&&(![[NSString stringWithFormat:@"%@",[self.m_PushNextdic objectForKey:@"svid"]] isEqualToString:@"(null)"])){
        [self.m_webView stopLoading];
        
        ProductDetailViewController *VC = [[ProductDetailViewController alloc]initWithNibName:@"ProductDetailViewController" bundle:nil];
        VC.m_FromDPId = @"0";
        VC.m_productId = [NSString stringWithFormat:@"%@",[self.m_PushNextdic objectForKey:@"svid"]];
        VC.m_merchantShopId = [NSString stringWithFormat:@"%@",[self.m_PushNextdic objectForKey:@"shopid"]];
        [self.navigationController pushViewController:VC animated:YES];
        
    }//跳转到拼手气网址
    else if([[self.m_PushNextdic objectForKey:@"cityandcitytype"]isEqualToString:@"15"]){
        
        if (([[NSString stringWithFormat:@"%@",[self.m_PushNextdic objectForKey:@"memid"]] isEqualToString:@"(null)"])) {
            
            NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
            NSString *key = [CommonUtil getServerKey];
            NSLog(@"%@",[NSString stringWithFormat:@"%@&key=%@&memid=%@",self.m_shareString,key,memberId]);

            [self.m_webView stopLoading];
            [self.m_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@&key=%@&memid=%@",self.m_shareString,key,memberId]]]];

        }
        
    }
    
}

//获取某个商户点单列表
- (void)GetMemberchantTakelist:(NSString *)merchantId
{
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        return;
    }

    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  merchantId, @"merchantId",
                                  nil];
    
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"CityAndCityType13.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            
            [SVProgressHUD dismiss];
            
            NSDictionary *CACT13SesionModel = [json valueForKey:@"CACT13SesionModel"];
            
            [CommonUtil addValue:[CACT13SesionModel objectForKey:@"Logo"] andKey:@"MarchantImageKey"];
            [CommonUtil addValue:[CACT13SesionModel objectForKey:@"YHDescription"] andKey:YHDESCRIPTION];
            [CommonUtil addValue:[CACT13SesionModel objectForKey:@"Man"] andKey:MANKEY];
            [CommonUtil addValue:[CACT13SesionModel objectForKey:@"Jian"] andKey:JIANKEY];
            
            
            // 进入点菜的页面
//            HH_TakeOrderViewController *VC = [[HH_TakeOrderViewController alloc]initWithNibName:@"HH_TakeOrderViewController" bundle:nil];
//            VC.m_shopList = [CACT13SesionModel objectForKey:@"ShopList"];
//            VC.m_seat = [NSString stringWithFormat:@"%@",[CACT13SesionModel objectForKey:@"IsSelectSeat"]];
//            VC.m_merchantId = [NSString stringWithFormat:@"%@",[CACT13SesionModel objectForKey:@"MerchantID"]];
//            VC.m_ModelType = [NSString stringWithFormat:@"%@",[CACT13SesionModel objectForKey:@"ModelType"]];
//            
//            VC.IsZCWaiMai = [NSString stringWithFormat:@"%@",[CACT13SesionModel objectForKey:@"IsZCWaiMai"]];
//            [self.navigationController pushViewController:VC animated:YES];
            
            
            CPSHH_TakeOrderViewController *VCC = [[CPSHH_TakeOrderViewController alloc]init];
            [VCC.m_dic setObject:[CACT13SesionModel objectForKey:@"ShopList"] forKey:@"m_shopList"];
            [VCC.m_dic setObject:[NSString stringWithFormat:@"%@",[CACT13SesionModel objectForKey:@"IsSelectSeat"]] forKey:@"m_seat"];
            [VCC.m_dic setObject:[NSString stringWithFormat:@"%@",[CACT13SesionModel objectForKey:@"ModelType"]] forKey:@"m_ModelType"];
            [VCC.m_dic setObject:[NSString stringWithFormat:@"%@",[CACT13SesionModel objectForKey:@"MerchantID"]] forKey:@"m_merchantId"];
            [VCC.m_dic setObject:[NSString stringWithFormat:@"%@",[CACT13SesionModel objectForKey:@"IsZCWaiMai"]] forKey:@"IsZCWaiMai"];
            [self.navigationController pushViewController:VCC animated:YES];
            
            
            }else{
                
                NSString *msg = [json valueForKey:@"msg"];
                [SVProgressHUD showErrorWithStatus:msg];
              
            }

        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    

}



//解析html数据
- (NSArray*)parseData:(NSData*) data
{
    TFHpple *doc = [[TFHpple alloc] initWithHTMLData:data];
    
    //在页面中查找img标签
    NSArray *images = [doc searchWithXPathQuery:@"//jpeg"];
    
    return images;
}

//下载图片的方法
- (void)downLoadPicture:(NSArray *)images
{
    //创建存放UIImage的数组
    _downloadImages = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < [images count]; i++){
        NSString *prefix = [[[images objectAtIndex:i] objectForKey:@"src"] substringToIndex:4];
        NSString *url = [[images objectAtIndex:i] objectForKey:@"src"];
        
        //判断图片的下载地址是相对路径还是绝对路径，如果是以http开头，则是绝对地址，否则是相对地址
        if ([prefix isEqualToString:@"http"] == NO){
            url = [self.m_shareString stringByAppendingPathComponent:url];
        }
        
        NSURL *downImageURL = [NSURL URLWithString:url];
        
        UIImage *image = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:downImageURL]];
        
        if(image != nil){
            [_downloadImages addObject:image];
        }
        NSLog(@"下载图片的URL:%@", url);
        _shareimageURL = url;
    }
}

- (void)webViewDidStartLoad:(UIWebView *)webView{

    self.navigationItem.rightBarButtonItem.enabled = NO;

	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;

}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
//    [SVProgressHUD dismiss];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    // 设置导航栏的标题为扫描网址的标题
    NSString *title = [self.m_webView stringByEvaluatingJavaScriptFromString:@"self.document.title"];
    self.title = [NSString stringWithFormat:@"%@",title];
    // 赋值-用于分享使用
    self.m_titleString = [NSString stringWithFormat:@"%@",title];
    
    // 设置前进后退按钮图标
    if ( [self.m_webView canGoBack] ) {
        [self.m_gobackBtn setImage:[UIImage imageNamed:@"arrow_WL.png"] forState:UIControlStateNormal];
    }else{
        [self.m_gobackBtn setImage:[UIImage imageNamed:@"arrow_L.png"] forState:UIControlStateNormal];
    }
    
    if ( [self.m_webView canGoForward] ) {
        [self.m_gofowardBtn setImage:[UIImage imageNamed:@"arrow_WR.png"] forState:UIControlStateNormal];
    }else{
        [self.m_gofowardBtn setImage:[UIImage imageNamed:@"arrow_R.png"] forState:UIControlStateNormal];
    }
    

    if([webView.request.URL.absoluteString rangeOfString:@"http://mp.weixin.qq.com"].location !=NSNotFound)
    {
        NSString *jsToGetHTMLSource = @"document.getElementsByTagName('html')[0].innerHTML";
        NSString *HTMLSource = [webView stringByEvaluatingJavaScriptFromString:jsToGetHTMLSource];
        
        if ([HTMLSource rangeOfString:@"<h2 class=\"rich_media_title\" id=\"activity-name\">"].location!=NSNotFound) {
            NSRange range = [HTMLSource rangeOfString:@"<h2 class=\"rich_media_title\" id=\"activity-name\">"];//匹配得到的下标
            NSString * string = [HTMLSource substringWithRange:NSMakeRange (range.location +range.length, 0)];
            for (int iii =0; iii<MAXFLOAT; iii++) {
                if ([string rangeOfString:@"</h2>"].location !=NSNotFound) {
                    string = [HTMLSource substringWithRange:NSMakeRange (range.location +range.length, string.length -5)];
                    break;
                }else{
                    string = [HTMLSource substringWithRange:NSMakeRange (range.location +range.length, iii)];
                }
            }
            self.m_titleString = [NSString stringWithFormat:@"%@",string];
        }
        
        
        if ([HTMLSource rangeOfString:@"var msg_cdn_url"].location !=NSNotFound) {
            NSRange range = [HTMLSource rangeOfString:@"var msg_cdn_url = \""];//匹配得到的下标
            NSString * string = [HTMLSource substringWithRange:NSMakeRange (range.location +range.length, 100)];
            for (int iii =0; iii<MAXFLOAT; iii++) {
                if ([string rangeOfString:@"\""].location !=NSNotFound) {
                    string = [HTMLSource substringWithRange:NSMakeRange (range.location +range.length, string.length -1)];
                    break;
                }else
                {   string = [HTMLSource substringWithRange:NSMakeRange (range.location +range.length, 100+iii)];
                }
            }

            _shareimageURL =string;
            _downloadImages = [[NSMutableArray alloc] init];
            
            UIImageView *M_img = [[UIImageView alloc]init];
            [M_img setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:string]]
                                    placeholderImage:[UIImage imageNamed:@"moren.png"]
                                             success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                                                 if(image != nil){
                                                     [_downloadImages addObject:image];
                                                 }
                                             }
                                             failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){

                                             }];

        }

    }
    else
    {
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.m_shareString]];
        NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        NSArray *imagesData =  [self parseData:response];
        [self downLoadPicture:imagesData];
    }
    
    self.navigationItem.rightBarButtonItem.enabled = YES;

    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
//    [SVProgressHUD dismiss];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    self.navigationItem.rightBarButtonItem.enabled = NO;

    if ( [self.m_typeString isEqualToString:@"1"] ) {
        self.navigationItem.rightBarButtonItem = nil;
    }
    
    
	// 在webView视图中报告错误信息
//	NSString* errorString = [NSString stringWithFormat:
//							 @"<html><center><font size=+5 color='red'>An error occurred:<br>%@</font></center></html>",
//							 error.localizedDescription];
//    
//	[self.m_webView loadHTMLString:errorString baseURL:nil];
    
}


- (IBAction)goBackWebView:(id)sender {
    
    if ( [self.m_webView canGoBack] ) {
        
        [self.m_webView goBack];
        
        [self.m_gobackBtn setImage:[UIImage imageNamed:@"arrow_WL.png"] forState:UIControlStateNormal];
        
    }else{
        
        [self.m_gobackBtn setImage:[UIImage imageNamed:@"arrow_L.png"] forState:UIControlStateNormal];

    }
}

- (IBAction)goForwardWebView:(id)sender {
    
    if ( [self.m_webView canGoForward] ) {
        
        [self.m_webView goForward];
        
        [self.m_gofowardBtn setImage:[UIImage imageNamed:@"arrow_WR.png"] forState:UIControlStateNormal];

        
    }else{
        
        
        [self.m_gofowardBtn setImage:[UIImage imageNamed:@"arrow_R.png"] forState:UIControlStateNormal];

    }
    
}

- (IBAction)refreshWebView:(id)sender {
    
    [self.m_webView reload];
    
}

#pragma mark - shareTo
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
        
        NSString *utf8String = [NSString stringWithFormat:@"%@",self.m_shareString];
        
        NSString *title = [NSString stringWithFormat:@"%@",self.m_titleString];
        NSString *description = [NSString stringWithFormat:@"%@",self.m_shareString];
        
        QQApiNewsObject *newsObj ;
        if ([_shareimageURL isEqualToString:@""]) {
            
        newsObj= [QQApiNewsObject objectWithURL:[NSURL URLWithString:utf8String] title:title description:description previewImageURL:[NSURL URLWithString:@"http://www.cityandcity.com/Resource/Attached/common/lianjie.png"]];
            
        }else{
            
        newsObj= [QQApiNewsObject objectWithURL:[NSURL URLWithString:utf8String] title:title description:description previewImageURL:[NSURL URLWithString:_shareimageURL]];
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
        // QQ空间分享
        tencentOAuth = [[TencentOAuth alloc]initWithAppId:TencentQzoneAppId andDelegate:self];
        
        NSString *utf8String = [NSString stringWithFormat:@"%@",self.m_shareString];
        
        NSString *title = [NSString stringWithFormat:@"%@",self.m_titleString];
        NSString *description = [NSString stringWithFormat:@"%@",self.m_shareString];

        QQApiNewsObject *newsObj ;
        if ([_shareimageURL isEqualToString:@""]) {
            
        newsObj= [QQApiNewsObject objectWithURL:[NSURL URLWithString:utf8String] title:title description:description previewImageURL:[NSURL URLWithString:@"http://www.cityandcity.com/Resource/Attached/common/lianjie.png"]];
            
        }else{
            
            newsObj= [QQApiNewsObject objectWithURL:[NSURL URLWithString:utf8String] title:title description:description previewImageURL:[NSURL URLWithString:_shareimageURL]];
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
        VC.MessageType = @"WEB";
        [VC.TextDIC setObject:_shareimageURL forKey:@"imageURL"];
        [VC.TextDIC setObject:self.m_shareString forKey:@"shareString"];
        if ([self.title isEqualToString:@""]){
            [VC.TextDIC setObject:@"分享一条链接" forKey:@"title"];
        }else
        {
            [VC.TextDIC setObject:self.m_titleString forKey:@"title"];
        }
        [self.navigationController pushViewController:VC animated:YES];
        
    }else if ( btn.tag == 1005 ){
        //诲诲朋友圈
        SharetoHuiHuiViewController * VC = [[SharetoHuiHuiViewController alloc]initWithNibName:@"SharetoHuiHuiViewController" bundle:nil];
        
            VC.dealId = @"0";
            VC.serviceID = @"0";
            VC.m_merchantShopId = @"0";
            VC.dynamicType = @"WebViewShare";
            if ([self.title isEqualToString:@""]||[self.m_titleString isEqualToString:self.title]){
            VC.STitle = [NSString stringWithFormat:@"%@",@"分享一条链接"];
            VC.subTitle =  [NSString stringWithFormat:@"%@",self.title];
            }else{
            VC.STitle = [NSString stringWithFormat:@"%@",self.title];
            VC.subTitle =  [NSString stringWithFormat:@"%@",self.m_titleString];
            }
            VC.webUrl = self.m_scanString;
            VC.activityID = @"0";
        
            VC.ImageArray = _downloadImages;
        
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
    message.title = [NSString stringWithFormat:@"%@", self.m_titleString];
    message.description = [NSString stringWithFormat:@"%@",self.m_shareString];
    
    /*
    NSString *imagePath = [NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:@"productImage"]];
    
    UIImageView *imgV = [[UIImageView alloc]init];
    
    [imgV setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:imagePath]]
                placeholderImage:[UIImage imageNamed:@""]
                         success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                             imgV.image = [CommonUtil scaleImage:image toSize:CGSizeMake(60, 60)];
                             
                             // 微信进行赋值
                             [message setThumbImage:imgV.image];
                             
                             WXWebpageObject *ext = [WXWebpageObject object];
                             ext.webpageUrl = [NSString stringWithFormat:@"%@",self.m_shareString];
                             message.mediaObject = ext;
                             SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
                             req.bText = NO;//发送消息的类型，包括文本消息和多媒体消息两种，两者只能选择其一，不能同时发送文本和多媒体消息
                             req.message = message;
                             req.scene = WXSceneSession;//选择发送好友
                             [WXApi sendReq:req];
                             
                             
                         }
                         failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                             
                         }];
    
     
     */
    
    // 微信进行赋值
    
    if (_downloadImages.count==0) {
        [message setThumbImage:[UIImage imageNamed:@"lianjie.png"]];
    }else{
        [message setThumbImage:[_downloadImages objectAtIndex:0]];
    }
    
    
    WXWebpageObject *ext = [WXWebpageObject object];
    ext.webpageUrl = [NSString stringWithFormat:@"%@",self.m_shareString];
    message.mediaObject = ext;
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;//发送消息的类型，包括文本消息和多媒体消息两种，两者只能选择其一，不能同时发送文本和多媒体消息
    req.message = message;
    req.scene = WXSceneSession;//选择发送好友
    [WXApi sendReq:req];
    
}

// 朋友圈
-(void)shareTogoodFriendShipsWithMessage {
    
    WXMediaMessage *message = [WXMediaMessage message];//发送消息的多媒体内容
    message.title = @"分享";
    message.description = [NSString stringWithFormat:@"%@",self.m_titleString];
    message.title = [NSString stringWithFormat:@"%@", self.m_shareString];
    
    /*
    NSString *imagePath = [NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:@"productImage"]];
    
    UIImageView *imgV = [[UIImageView alloc]init];
    
    [imgV setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:imagePath]]
                placeholderImage:[UIImage imageNamed:@""]
                         success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                             imgV.image = [CommonUtil scaleImage:image toSize:CGSizeMake(60, 60)];
                             
                             // 微信进行赋值
                             [message setThumbImage:imgV.image];
                             
                             WXWebpageObject *ext = [WXWebpageObject object];
                             ext.webpageUrl = [NSString stringWithFormat:@"%@",self.m_shareString];
                             message.mediaObject = ext;
                             
                             SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
                             req.bText = NO;//发送消息的类型，包括文本消息和多媒体消息两种，两者只能选择其一，不能同时发送文本和多媒体消息
                             req.message = message;
                             req.scene = WXSceneTimeline;//发送到朋友圈
                             
                             [WXApi sendReq:req];
                             
                             
                         }
                         failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                             
                         }];
     
     */
    
    // 微信进行赋值
    if (_downloadImages.count==0) {
        [message setThumbImage:[UIImage imageNamed:@"lianjie.png"]];
    }else{
        [message setThumbImage:[_downloadImages objectAtIndex:0]];
    }
    WXWebpageObject *ext = [WXWebpageObject object];
    ext.webpageUrl = [NSString stringWithFormat:@"%@",self.m_shareString];
    message.mediaObject = ext;
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;//发送消息的类型，包括文本消息和多媒体消息两种，两者只能选择其一，不能同时发送文本和多媒体消息
    req.message = message;
    req.scene = WXSceneTimeline;//发送到朋友圈
    
    [WXApi sendReq:req];
    
    
}


- (IBAction)cancelShare:(id)sender {
    
    [self.m_showView removeFromSuperview];
    
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

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
{
    if ( alertView.tag == 100100 ) {
        if ( buttonIndex == 1 ) {
            // 跳转到下载微信的地址
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[WXApi getWXAppInstallUrl]]];
        }else{
            
        }
    }else{
        
        
        
    }
}


@end
