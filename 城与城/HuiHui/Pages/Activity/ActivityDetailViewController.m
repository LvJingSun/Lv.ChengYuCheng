//
//  ActivityDetailViewController.m
//  baozhifu
//
//  Created by mac on 14-2-27.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "ActivityDetailViewController.h"

#import "ActivityDetailCell.h"

#import "ProductDetailCell.h"

#import "MapViewController.h"

#import "CommonUtil.h"

#import "UIImageView+AFNetworking.h"

#import "WXApi.h"

#import "CommentViewController.h"

#import "JoinedViewController.h"

#import "AppHttpClient.h"

#import "SVProgressHUD.h"

#import "ProductBigViewController.h"

#import "PayStyleViewController.h"

#import "PaymentQueViewController.h"

@interface ActivityDetailViewController ()

@property (weak, nonatomic) IBOutlet UIView *m_titleView;

@property (weak, nonatomic) IBOutlet UIView *m_tempView;

@property (weak, nonatomic) IBOutlet UILabel *m_titleLabel;

@property (weak, nonatomic) IBOutlet UITableView *m_tableView;

// tableView的headerView
@property (strong, nonatomic) IBOutlet UIView *m_headerView;
// 滚动图片的scrollerView
@property (weak, nonatomic) IBOutlet UIScrollView *m_scrollerView;
// 活动名称
@property (weak, nonatomic) IBOutlet UILabel *m_productName;
// 活动时间
@property (weak, nonatomic) IBOutlet UILabel *m_timeLabel;
// 地址
@property (weak, nonatomic) IBOutlet UILabel *m_addressLabel;
// 类型
@property (weak, nonatomic) IBOutlet UILabel *m_typeLabel;
// 商户名称
@property (weak, nonatomic) IBOutlet UILabel *m_merchantLabel;
// 地址按钮
@property (weak, nonatomic) IBOutlet UIButton *m_addressBtn;

@property (weak, nonatomic) IBOutlet UILabel *m_totalPriceLabel;

@property (strong, nonatomic) IBOutlet UIView *m_showView;

@property (weak, nonatomic) IBOutlet UIView *m_showTempView;

@property (weak, nonatomic) IBOutlet UILabel *m_merchantKey;

@property (weak, nonatomic) IBOutlet UIView *m_priceView;


// 地址按钮触发的事件
- (IBAction)addressClicked:(id)sender;

// 参加按钮触发的事件
- (IBAction)joinBtnClicked:(id)sender;

// 右上角分享的按钮触发的事件
- (IBAction)shareBtnClicked:(id)sender;

// 分享
- (IBAction)shareClicked:(id)sender;

// 取消
- (IBAction)cancelShare:(id)sender;

@end

@implementation ActivityDetailViewController

@synthesize m_productList;

@synthesize m_imagArray;

@synthesize m_items;

@synthesize m_values;

@synthesize m_Funtions;

@synthesize m_keyTimes;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        m_productList = [[NSMutableArray alloc]initWithCapacity:0];
        
        m_imagArray = [[NSMutableArray alloc]initWithCapacity:0];
        
        m_items = [[NSMutableDictionary alloc]initWithCapacity:0];
        
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
    
    [self setTitle:@"详情"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    [self setRightButtonWithTitle:@"分享" action:@selector(rightClicked)];
    
    // 设置tableView的headerView
    self.m_tableView.tableHeaderView = self.m_headerView;
    
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WindowSizeWidth, 10)];
    footerView.backgroundColor = [UIColor clearColor];
    
    self.m_tableView.tableFooterView = footerView;
    
    // 设置view的圆角和边框
    self.m_showTempView.backgroundColor = [UIColor blackColor];
//    self.m_showTempView.layer.borderWidth = 1.0;
//    self.m_showTempView.layer.cornerRadius = 5.0f;
//    self.m_showTempView.layer.borderColor = [UIColor redColor].CGColor;//[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0].CGColor;
    
    // 初始化三个用于动画的数组
    NSArray *array = [[NSArray alloc]initWithObjects:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f, 0.01f, 1.0f)],[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.0f)],[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9f, 0.9f, 1.0f)],[NSValue valueWithCATransform3D:CATransform3DIdentity], nil];
    
    NSArray *keyTimes = [[NSArray alloc]initWithObjects:@"0.2f",@"0.5f", @"0.75f", @"1.0f", nil];
    
    NSArray *funtions = [[NSArray alloc]initWithObjects:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                         [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                         [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut], nil];
    
    self.m_values = array;
    
    self.m_keyTimes = keyTimes;
    
    self.m_Funtions = funtions;

    // 隐藏tableView
    self.m_tableView.hidden = YES;
    self.m_priceView.hidden = YES;
    
    self.m_showView.center = self.view.center;
    
    // 请求数据
    [self detailRequestSubmit];
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self hideTabBar:YES];

}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [self hideTabBar:NO];

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

- (void)initScrollerView{
    
    [self.m_scrollerView setContentSize:CGSizeMake(70 * self.m_imagArray.count,105)];
    
    self.m_scrollerView.backgroundColor = [UIColor clearColor];
    
    self.m_scrollerView.pagingEnabled = YES;
    
    self.m_scrollerView.showsHorizontalScrollIndicator = NO;
    
    self.m_scrollerView.showsVerticalScrollIndicator = NO;
    
    for (int i = 0; i < self.m_imagArray.count; i ++) {
        
        NSDictionary *dic = [self.m_imagArray objectAtIndex:i];
        
        UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(i * 70, 0, 70, 105)];
        imgV.backgroundColor = [UIColor clearColor];
        
        NSString *imagePath = [NSString stringWithFormat:@"%@",[dic objectForKey:@"SmlPoster"]];
        [imgV setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:imagePath]]
                    placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"]
                             success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                                 imgV.image = image; //[CommonUtil scaleImage:image toSize:CGSizeMake(70, 105)];
                                 imgV.contentMode = UIViewContentModeScaleAspectFit;

                                 
                             }
                             failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                                 
                             }];
       
        
        [self.m_scrollerView addSubview:imgV];
        
    }
    
    // 初始化pageControl
    CGRect pageControlFrame = CGRectMake(10, 110, 70, 10);
    self.m_pageControl = [[GrayPageControl alloc]initWithFrame:pageControlFrame];
    self.m_pageControl.backgroundColor = [UIColor clearColor];//背景
    self.m_pageControl.inactiveImage = [UIImage imageNamed:@"white.png"];
    self.m_pageControl.activeImage = [UIImage imageNamed:@"blue.png"];
    
    self.m_pageControl.userInteractionEnabled = NO;
    self.m_pageControl.numberOfPages = self.m_imagArray.count;
    self.m_pageControl.currentPage = 0;
    
    [self.m_headerView addSubview:self.m_pageControl];
    
    
    self.m_timer = [NSTimer scheduledTimerWithTimeInterval:3.0f
                                               target:self
                                             selector:@selector(scrollToNextPage:)
                                             userInfo:nil
                                              repeats:YES];
    //default--> run at once
	//timewithinterval addrun ->then run
	//tablview->trackingmode
	//Mode->event lines
    
    [[NSRunLoop currentRunLoop]addTimer:self.m_timer forMode:NSRunLoopCommonModes];

    
    
}

- (IBAction)addressClicked:(id)sender {
    
    // 进入地图显示的页面
    MapViewController *VC = [[MapViewController alloc]initWithNibName:@"MapViewController" bundle:nil];

    VC.item = self.m_items;
    VC.m_shopString = @"3";

    [self.navigationController pushViewController:VC animated:YES];
    
}

- (IBAction)joinBtnClicked:(id)sender {
    
    if ( self.m_typeString == MERCHANTACTIVITY ) {
        
        // 参加活动请求数据验证接口
        [self joinedActivityRequest];
        
    
    }else{
        
        
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"参加后您的手机号将会提供给活动发起人，以方便与您联系"
                                                           message:@"您确定参加?"
                                                          delegate:self
                                                 cancelButtonTitle:@"取消"
                                                 otherButtonTitles:@"确定", nil];
        alertView.tag = 19456;
        [alertView show];
        
    }

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

- (IBAction)shareClicked:(id)sender {
    
    [self.m_showView removeFromSuperview];
    
    UIButton *btn = (UIButton *)sender;
    
    
    if ( btn.tag == 1000 ) {
        //检测是否安装QQ
        if (![self checkIsVaildQQType]) {
            return;
        }
        // qq好友
        tencentOAuth = [[TencentOAuth alloc]initWithAppId:TencentQzoneAppId andDelegate:self];
        
        //http://wx.cityandcity.com/activity/activity_detail.aspx?mctid=110&actid=171
        
        NSString *utf8String = [NSString stringWithFormat:@"http://wx.cityandcity.com/activity/activity_detail.aspx?mctid=%@&actid=%@",[self.m_items objectForKey:@"MerchantId"],[self.m_items objectForKey:@"ActivityID"]];
        
        NSString *title = [NSString stringWithFormat:@"%@",[self.m_items objectForKey:@"ActivityName"]];
        NSString *description = @"";//[NSString stringWithFormat:@"%@",[self.m_itemsDic objectForKey:@"SvcName"]];
        
        
        QQApiNewsObject *newsObj = [QQApiNewsObject objectWithURL:[NSURL URLWithString:utf8String] title:title description:description previewImageURL:[NSURL URLWithString:[CommonUtil getValueByKey:@"productImage"]]];
        
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
        
        NSString *utf8String = [NSString stringWithFormat:@"http://wx.cityandcity.com/activity/activity_detail.aspx?mctid=%@&actid=%@",[self.m_items objectForKey:@"MerchantId"],[self.m_items objectForKey:@"ActivityID"]];
        
        NSString *title = [NSString stringWithFormat:@"%@",[self.m_items objectForKey:@"ActivityName"]];
        NSString *description = @"";//[NSString stringWithFormat:@"%@",[self.m_itemsDic objectForKey:@"SvcName"]];
        
        QQApiNewsObject *newsObj = [QQApiNewsObject objectWithURL:[NSURL URLWithString:utf8String] title:title description:description previewImageURL:[NSURL URLWithString:[CommonUtil getValueByKey:@"productImage"]]];
        
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
        
    }else{
        
        
    }
}

- (IBAction)cancelShare:(id)sender {
    
       [self.m_showView removeFromSuperview];
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
    message.title = [NSString stringWithFormat:@"%@",[self.m_items objectForKey:@"ActivityName"]];
    
    message.description = @"";//[NSString stringWithFormat:@"%@",[self.m_itemsDic objectForKey:@"SvcName"]];
    
    NSString *imagePath = [NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:@"productImage"]];
    
    UIImageView *imgV = [[UIImageView alloc]init];
    
    [imgV setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:imagePath]]
                placeholderImage:[UIImage imageNamed:@""]
                         success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                             imgV.image = [CommonUtil scaleImage:image toSize:CGSizeMake(60, 60)];
                             
                             // 微信进行赋值
                             [message setThumbImage:imgV.image];
                             
                             WXWebpageObject *ext = [WXWebpageObject object];
                             ext.webpageUrl =[NSString stringWithFormat:@"http://wx.cityandcity.com/activity/activity_detail.aspx?mctid=%@&actid=%@",[self.m_items objectForKey:@"MerchantId"],[self.m_items objectForKey:@"ActivityID"]];
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
    message.description = @"";// [NSString stringWithFormat:@"%@",[self.m_itemsDic objectForKey:@"SvcName"]];
    message.title = [NSString stringWithFormat:@"%@",[self.m_items objectForKey:@"ActivityName"]];

    
    
    NSString *imagePath = [NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:@"productImage"]];
    
    UIImageView *imgV = [[UIImageView alloc]init];
    
    [imgV setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:imagePath]]
                placeholderImage:[UIImage imageNamed:@""]
                         success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                             imgV.image = [CommonUtil scaleImage:image toSize:CGSizeMake(60, 60)];
                             
                             // 微信进行赋值
                             [message setThumbImage:imgV.image];
                             
                             WXWebpageObject *ext = [WXWebpageObject object];
                             ext.webpageUrl = [NSString stringWithFormat:@"http://wx.cityandcity.com/activity/activity_detail.aspx?mctid=%@&actid=%@",[self.m_items objectForKey:@"MerchantId"],[self.m_items objectForKey:@"ActivityID"]];
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

#pragma mark UIAlertViewDelegate Method
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if ( alertView.tag == 100100 ) {
        if ( buttonIndex == 1 ) {
            // 跳转到下载微信的地址
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[WXApi getWXAppInstallUrl]]];
        }else{
            
        }
    }else  if ( alertView.tag == 12489 ){
        // 余额不足
        if ( buttonIndex == 1 ) {
            
            // 余额不足跳转到充值的页面
            
            PayStyleViewController *VC = [[PayStyleViewController alloc]initWithNibName:@"PayStyleViewController" bundle:nil];
            VC.m_typeString = @"1";
            [self.navigationController pushViewController:VC animated:YES];
            
        }
    }else if ( alertView.tag == 123804 ){
        if ( buttonIndex == 1 ) {
            
            // 未设置支付密码，进入支付密码设置的页面
            PaymentQueViewController *viewController = [[PaymentQueViewController alloc]initWithNibName:@"PaymentQueViewController" bundle:nil];
            [self.navigationController pushViewController:viewController animated:YES];
            
        }else{
            
            
        }
    }else if ( alertView.tag == 19456 ){
        if ( buttonIndex == 1 ) {
            // 聚会参加请求数据
            [self joinedPartyRequest];
            
        }else{
            
            
        }
        
    }else{
        
        
    }

    
}

- (void)detailRequestSubmit{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  memberId,     @"memberId",
                                  key,   @"key",
                                  self.m_serviceId,   @"activityId",
                                  nil];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"ActivityDetail.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            [SVProgressHUD dismiss];
            
            self.m_items = [json valueForKey:@"Activity"];
            
            // 赋值
            self.m_productList = [self.m_items objectForKey:@"SimilarActList"];
            
            self.m_imagArray = [self.m_items objectForKey:@"PosterList"];
            
            // 初始化scrollerView
            [self initScrollerView];
            
            self.m_productName.text = [NSString stringWithFormat:@"%@",[self.m_items objectForKey:@"ActivityName"]];
            
            // 会员聚会不显示商户的名称
            if ( self.m_typeString == MERCHANTACTIVITY ) {
                
                self.m_merchantKey.hidden = NO;
                self.m_merchantLabel.hidden = NO;
                self.m_merchantLabel.text = [NSString stringWithFormat:@"%@",[self.m_items objectForKey:@"MerchantAllName"]];
                
                self.m_totalPriceLabel.text = [NSString stringWithFormat:@"%@",[self.m_items objectForKey:@"Price"]];

                
            }else{
                
                self.m_merchantKey.hidden = YES;
                self.m_merchantLabel.hidden = YES;
                
                self.m_totalPriceLabel.text = [NSString stringWithFormat:@"%@",[self.m_items objectForKey:@"Fee"]];

            }

            self.m_typeLabel.text = [NSString stringWithFormat:@"%@",[self.m_items objectForKey:@"ActCatgNames"]];
            
            self.m_timeLabel.text = [NSString stringWithFormat:@"%@~%@ %@至%@",[self.m_items objectForKey:@"ActStartDate"],[self.m_items objectForKey:@"ActEndDate"],[self.m_items objectForKey:@"ActStartTime"],[self.m_items objectForKey:@"ActEndtTime"]];
            
            self.m_addressLabel.text = [NSString stringWithFormat:@"%@\n%@",[self.m_items objectForKey:@"AddressDetail"],[self.m_items objectForKey:@"Address"]];
            
            NSString *string = [NSString stringWithFormat:@"%@",[self.m_items objectForKey:@"Summary"]];
           
             NSString *string1 = [NSString stringWithFormat:@"%@",[self.m_items objectForKey:@"Content"]];
            
             NSString *string2 = [NSString stringWithFormat:@"%@",[self.m_items objectForKey:@"Explain"]];
            
            if ( string.length == 0 ) {
                
                self.m_infoString = @"- 发布人未填写 -";

            }else{
                
                self.m_infoString = [NSString stringWithFormat:@"%@",[self.m_items objectForKey:@"Summary"]];

            }
           
            
            if ( string1.length == 0 ) {
                
                self.m_contentString = @"- 发布人未填写 -";
                
            }else{
                
                self.m_contentString = [NSString stringWithFormat:@"%@",[self.m_items objectForKey:@"Content"]];
                
            }
            
            
            if ( string2.length == 0 ) {
                
                self.m_PromptString = @"- 发布人未填写 -";
                
            }else{
                
                self.m_PromptString = [NSString stringWithFormat:@"%@",[self.m_items objectForKey:@"Explain"]];
                
            }
            
            // 显示tableView和显示价格所在的view
            self.m_priceView.hidden = NO;
            self.m_tableView.hidden = NO;
            [self.m_tableView reloadData];
            
            // 判断是否从个人聚会和活动过来
            if ( [self.m_partyString isEqualToString:@"1"] ) {
                
                self.m_joinedBtn.enabled = NO;
                
                self.m_joinedBtn.userInteractionEnabled = NO;
          
            }else{
                
                self.m_joinedBtn.enabled = YES;
                
                self.m_joinedBtn.userInteractionEnabled = YES;
                
            }
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
        
        
    } failure:^(NSError *error) {
        
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        //self.tableView.pullLastRefreshDate = [NSDate date];
        
    }];
}

// 参加聚会请求数据
- (void)joinedPartyRequest{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  memberId,     @"memberId",
                                  key,   @"key",
                                  self.m_serviceId,   @"actId",
                                  nil];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"ActivityLifeJoin.ashx" parameters:param success:^(NSJSONSerialization* json) {
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
        //self.tableView.pullLastRefreshDate = [NSDate date];
        
    }];
}

// 参加活动请求数据 确认支付验证接口
- (void)joinedActivityRequest{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  memberId,     @"memberId",
                                  key,   @"key",
                                  self.m_serviceId,   @"actId",
                                  nil];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"ActivityJoinCheck.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            
//            NSString *msg = [json valueForKey:@"msg"];
//            [SVProgressHUD showSuccessWithStatus:msg];
            
            [SVProgressHUD dismiss];
            
            // 进入我要参加的页面
            JoinedViewController *VC = [[JoinedViewController alloc]initWithNibName:@"JoinedViewController" bundle:nil];
            VC.m_dic = self.m_items;
            [self.navigationController pushViewController:VC animated:YES];
            
        } else {
            
            [SVProgressHUD dismiss];

//        False:1(Msg=用户信息丢失，请重新登录!)
//        False:2(Msg=活动不存在!)
//        False:3(Msg=活动不在进行中!)
//        False:4(Msg=您已报过名了!)
//        False:5(Msg=您的基本资料不完整，请先至个人中心维护基本资料!)
//        False:6(Msg=年龄条件不符!)
//        False:7(Msg=年龄条件不符!)
//        False:8(Msg=性别条件不符!)
//        False:9(Msg=活动报名已截止!)
//        False:10(Msg=报名人数已达到上限，您可以看看其它相关活动!)
//        False:11(Msg=余额不足!)
//        False:13(Msg=未设置安全支付密码!)
//        True:12(Msg=验证成功!)
            
            NSString *msg = [json valueForKey:@"msg"];
            
            NSString *errorCode = [json valueForKey:@"ErrorCode"];
            
            if ( [errorCode isEqualToString:@"11"] ) {
                
                
                NSString *vldStatus = [json valueForKey:@"RealNameAuStatus"];
                
                // 保存状态用于充值那边判断进入哪个页面
                [CommonUtil addValue:vldStatus andKey:REALAUSTATUS];
                
                // 余额不足
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示"
                                                                   message:msg
                                                                  delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"立即充值", nil];
                alertView.tag = 12489;
                [alertView show];
                
            }else if ( [errorCode isEqualToString:@"13"] ){
                
                // 支付密码未设置，请先设置
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示"
                                                                   message:msg
                                                                  delegate:self
                                                         cancelButtonTitle:@"取消"
                                                         otherButtonTitles:@"立即设置",nil];
                alertView.tag = 123804;
                
                [alertView show];
                
                
            }else{
                
                [SVProgressHUD showErrorWithStatus:msg];

            }
            
        }
        
        
    } failure:^(NSError *error) {
        
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        //self.tableView.pullLastRefreshDate = [NSDate date];
        
    }];

}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    if ( self.m_typeString == MERCHANTACTIVITY ) {
        
        return 5 + self.m_productList.count;

    }else{
        
        return 4 + self.m_productList.count;

    }
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = nil;
    
     if ( self.m_typeString == MERCHANTACTIVITY ) {
         
         if ( indexPath.row == 0 ) {
             
             cell = [self tableViewOne:tableView cellForRowAtIndexPath:indexPath];
             
         }else if ( indexPath.row == 1 ){
             
             cell = [self tableViewTwo:tableView cellForRowAtIndexPath:indexPath];
             
         }else if ( indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 4 ){
             
             cell = [self tableViewThree:tableView cellForRowAtIndexPath:indexPath];
             
         }else{
             
             cell = [self tableViewFour:tableView cellForRowAtIndexPath:indexPath];
         }

     }else{
        
         if ( indexPath.row == 0 ) {
             
             cell = [self tableViewOne:tableView cellForRowAtIndexPath:indexPath];
             
         }else if ( indexPath.row == 1 ){
             
             cell = [self tableViewTwo:tableView cellForRowAtIndexPath:indexPath];
             
         }else if ( indexPath.row == 2 || indexPath.row == 3 ){
             
             cell = [self tableViewThree:tableView cellForRowAtIndexPath:indexPath];
             
         }else{
             
             cell = [self tableViewFour:tableView cellForRowAtIndexPath:indexPath];
         }
         
     }
    
    
    
    return cell;
   
}

- (UITableViewCell *)tableViewOne:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ( self.m_typeString == MERCHANTACTIVITY ) {
        
        static NSString *cellIdentifier = @"ActivityDetailCellIdentifier";
        
        ActivityDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if ( cell == nil ) {
            
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ActivityDetailCell" owner:self options:nil];
            
            cell = (ActivityDetailCell *)[nib objectAtIndex:0];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.backgroundColor = [UIColor clearColor];
            
        }
        
        // 赋值 图标的显示 随时退
        if ( [[self.m_items objectForKey:@"IsAnyTimeReturn"] isEqualToString:@"Yes"] ) {
            
            cell.m_randomImgV.image = [UIImage imageNamed:@"xq_gou.png"];
            
            cell.m_anyTimeLabel.text = @"支持随时退";
            
        }else{
            
            cell.m_randomImgV.image = [UIImage imageNamed:@"red_wrong.png"];
            
            cell.m_anyTimeLabel.text = @"不支持随时退";
        }
        // 过期
        if ( [[self.m_items objectForKey:@"IsExpiredReturn"] isEqualToString:@"Yes"] ) {
            
            cell.m_ExpiredImagV.image = [UIImage imageNamed:@"xq_gou.png"];
            
            cell.m_expiredLabel.text = @"支持过期退";
            
        }else{
            
            cell.m_ExpiredImagV.image = [UIImage imageNamed:@"red_wrong.png"];
            
            cell.m_expiredLabel.text = @"不支持过期退";
            
        }
        // 预约
        if ( [[self.m_items objectForKey:@"IsReservation"] isEqualToString:@"Yes"] ) {
            
            cell.m_ReservationImgV.image = [UIImage imageNamed:@"xq_time.png"];
            
            cell.m_reserLabel.text = @"需预约";
            
        }else{
            
            cell.m_ReservationImgV.image = [UIImage imageNamed:@"xq_time_grey.png"];
            
            cell.m_reserLabel.text = @"不需预约";
            
        }

        cell.m_personCount.text = [NSString stringWithFormat:@"最少:%@人,最多:%@人",[self.m_items objectForKey:@"PeoperNumMin"],[self.m_items objectForKey:@"PeoperNumMax"]];
        
        NSString *sexString = [NSString stringWithFormat:@"%@",[self.m_items objectForKey:@"Sex"]];
        
        if ( [sexString isEqualToString:@"Female"] ) {
            
            sexString = @"女";
            
        }else if ( [sexString isEqualToString:@"Male"]  ){
            
            sexString = @"男";
            
        }else{
            
            sexString = @"不限男女";
            
        }
        cell.m_ageSex.text = [NSString stringWithFormat:@"年龄:%@-%@岁/性别:%@",[self.m_items objectForKey:@"AgeMin"],[self.m_items objectForKey:@"AgeMax"],sexString];

        cell.m_Endtime.text = [NSString stringWithFormat:@"报名截止:%@",[self.m_items objectForKey:@"RegStopTime"]];
        
        // 生活达人和资源达人的返利情况
        if ( ![[self.m_items objectForKey:@"ResDarenRbt"] floatValue] == 0.000000 ) {
            
            cell.m_lifeView.hidden = NO;
            cell.m_secondLifeView.hidden = YES;
            
            cell.m_lifeRebates.text = [NSString stringWithFormat:@"￥%@",[self.m_items objectForKey:@"LifDarenRbt"]];
            
            cell.m_resourceRebates.text = [NSString stringWithFormat:@"￥%@",[self.m_items objectForKey:@"ResDarenRbt"]];
            
        }else{
            
            cell.m_lifeView.hidden = YES;
            cell.m_secondLifeView.hidden = NO;
            
            cell.m_secondLifeRebates.text = [NSString stringWithFormat:@"￥%@",[self.m_items objectForKey:@"LifDarenRbt"]];
            
        }

        // 设置cell的背景边框
        cell.m_backImgV.layer.borderColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0].CGColor;
        cell.m_backImgV.layer.borderWidth = 1.0;
        
        
        return cell;
        
    }else{
        
        static NSString *cellIdentifier = @"ActivityInfoCellIdentifier";
        
        ActivityInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if ( cell == nil ) {
            
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ActivityDetailCell" owner:self options:nil];
            
            cell = (ActivityInfoCell *)[nib objectAtIndex:1];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.backgroundColor = [UIColor clearColor];
            
        }
        
        cell.m_personCount.text = [NSString stringWithFormat:@"最少:%@人,最多:%@人",[self.m_items objectForKey:@"PeoperNumMin"],[self.m_items objectForKey:@"PeoperNumMax"]];
        
        NSString *sexString = [NSString stringWithFormat:@"%@",[self.m_items objectForKey:@"Sex"]];
        
        if ( [sexString isEqualToString:@"Female"] ) {
            
            sexString = @"女";
            
        }else if ( [sexString isEqualToString:@"Male"]  ){
            
            sexString = @"男";
            
        }else{
            
            sexString = @"不限男女";
            
        }
        cell.m_ageSex.text = [NSString stringWithFormat:@"年龄:%@-%@岁/性别:%@",[self.m_items objectForKey:@"AgeMin"],[self.m_items objectForKey:@"AgeMax"],sexString];
        
        cell.m_Endtime.text = [NSString stringWithFormat:@"报名截止:%@",[self.m_items objectForKey:@"RegStopTime"]];
        
        
        // 设置cell的背景边框
        cell.m_backImgV.layer.borderColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0].CGColor;
        cell.m_backImgV.layer.borderWidth = 1.0;
        
        
        return cell;

    }
    
}

// 第二行显示的数据
- (UITableViewCell *)tableViewTwo:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"StartCellIdentifier";
    
    StartCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"ProductDetailCell" owner:self options:nil];
        
        cell = (StartCell *)[nib objectAtIndex:1];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.backgroundColor = [UIColor clearColor];

    }
    
    // 设置cell的背景边框
    cell.m_backImgV.layer.borderColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0].CGColor;
    cell.m_backImgV.layer.borderWidth = 1.0;
    
    
    // 赋值
    NSString *string = [NSString stringWithFormat:@"%@",[self.m_items objectForKey:@"Rank"]];
    
    NSString *count = [NSString stringWithFormat:@"%@",[self.m_items objectForKey:@"ActCommentsNumber"]];
    
    // 对星星进行赋值
    [cell setValue:string withCount:count];
    
    
    // 判断cell是否可以点击
    if ( [string isEqualToString:@"0"] ) {
        
        cell.userInteractionEnabled = NO;
        
    }else{
        
        cell.userInteractionEnabled = YES;
    }

    return cell;
    
}

// 第三行显示的数据
- (UITableViewCell *)tableViewThree:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if ( self.m_typeString == MERCHANTACTIVITY ) {

        static NSString *cellIdentifier = @"IntroductionCellIndentifier";
        
        IntroductionCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if ( cell == nil ) {
            
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"ProductDetailCell" owner:self options:nil];
            
            cell = (IntroductionCell *)[nib objectAtIndex:3];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        
        if ( indexPath.row == 2 ) {
            
            // 赋值
            cell.m_titleLabel.text = @"活动简介";
            
            cell.m_infoImgV.image = [UIImage imageNamed:@"xq_jieshao.png"];
            
            cell.m_detailLabel.text = self.m_infoString;
        
            
            CGSize size = [self.m_infoString sizeWithFont:[UIFont systemFontOfSize:12.0f] constrainedToSize:CGSizeMake(WindowSizeWidth - 40, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
            
            cell.m_detailLabel.frame = CGRectMake(20, 45, WindowSizeWidth - 40, size.height + 10);
            
            cell.m_backImgV.frame = CGRectMake(10, 10, cell.m_backImgV.frame.size.width
                                               , 68 - 21 + size.height);
            
            cell.frame = CGRectMake(0, 0, WindowSizeWidth, cell.m_backImgV.frame.size.height + 10);
            
            
        }else if ( indexPath.row == 3 ){
            
            
            // 赋值
            cell.m_titleLabel.text = @"活动内容";
            
            cell.m_infoImgV.image = [UIImage imageNamed:@"xq_jieshao.png"];
            
            cell.m_detailLabel.text = self.m_contentString;
        
            
            CGSize size = [self.m_contentString sizeWithFont:[UIFont systemFontOfSize:12.0f] constrainedToSize:CGSizeMake(WindowSizeWidth - 40, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
            
            cell.m_detailLabel.frame = CGRectMake(20, 45, WindowSizeWidth - 40, size.height + 10);
            
            cell.m_backImgV.frame = CGRectMake(10, 10, cell.m_backImgV.frame.size.width, 68 - 21 + size.height);
            
            cell.frame = CGRectMake(0, 0, WindowSizeWidth, cell.m_backImgV.frame.size.height + 10);
            
        }else if ( indexPath.row == 4 ){
            
            
            // 赋值
            cell.m_titleLabel.text = @"特别提示";
            
            cell.m_infoImgV.image = [UIImage imageNamed:@"xq_tip.png"];
            
            cell.m_detailLabel.text = self.m_PromptString;
         
            
            CGSize size = [self.m_PromptString sizeWithFont:[UIFont systemFontOfSize:12.0f] constrainedToSize:CGSizeMake(WindowSizeWidth - 40, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
            
            cell.m_detailLabel.frame = CGRectMake(20, 45, WindowSizeWidth - 40, size.height + 10);
            
            cell.m_backImgV.frame = CGRectMake(10, 10, cell.m_backImgV.frame.size.width, 68 - 21 + size.height);
            
            cell.frame = CGRectMake(0, 0, WindowSizeWidth, cell.m_backImgV.frame.size.height + 10);
            
        }
        
        
        cell.m_webView.hidden = YES;
        cell.m_detailLabel.hidden = NO;
        
        cell.backgroundColor = [UIColor clearColor];
        
        // 设置cell的背景边框
        cell.m_backImgV.layer.borderColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0].CGColor;
        cell.m_backImgV.layer.borderWidth = 1.0;
        
        return cell;

        
    }else{
        
        static NSString *cellIdentifier = @"IntroductionCellIndentifier";
        
        IntroductionCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if ( cell == nil ) {
            
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"ProductDetailCell" owner:self options:nil];
            
            cell = (IntroductionCell *)[nib objectAtIndex:3];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        
       /* if ( indexPath.row == 2 ) {
            
            // 赋值
            cell.m_titleLabel.text = @"活动简介";
            
            cell.m_infoImgV.image = [UIImage imageNamed:@"xq_jieshao.png"];
            
            cell.m_detailLabel.text = self.m_infoString;
            
            CGSize size = [self.m_infoString sizeWithFont:[UIFont systemFontOfSize:12.0f] constrainedToSize:CGSizeMake(280, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
            
            cell.m_detailLabel.frame = CGRectMake(20, 45, 280, size.height);
            
            cell.m_backImgV.frame = CGRectMake(10, 10, 300, 68 - 21 + size.height);
            
            cell.frame = CGRectMake(0, 0, 320, cell.m_backImgV.frame.size.height + 10);
            
            
        }else*/
        if ( indexPath.row == 2 ){
            
            
            // 赋值
            cell.m_titleLabel.text = @"活动内容";
            
            cell.m_infoImgV.image = [UIImage imageNamed:@"xq_jieshao.png"];
            
            cell.m_detailLabel.text = self.m_contentString;
            
            CGSize size = [self.m_contentString sizeWithFont:[UIFont systemFontOfSize:12.0f] constrainedToSize:CGSizeMake(WindowSizeWidth - 40, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
            
            cell.m_detailLabel.frame = CGRectMake(20, 45, WindowSizeWidth - 40, size.height + 10);
            
            cell.m_backImgV.frame = CGRectMake(10, 10, cell.m_backImgV.frame.size.width, 68 - 21 + size.height);
            
            cell.frame = CGRectMake(0, 0, WindowSizeWidth, cell.m_backImgV.frame.size.height + 10);
            
        }else if ( indexPath.row == 3 ){
            
            
            // 赋值
            cell.m_titleLabel.text = @"特别提示";
            
            cell.m_infoImgV.image = [UIImage imageNamed:@"xq_tip.png"];
            
            cell.m_detailLabel.text = self.m_PromptString;
            
            CGSize size = [self.m_PromptString sizeWithFont:[UIFont systemFontOfSize:12.0f] constrainedToSize:CGSizeMake(WindowSizeWidth - 40, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
            
            cell.m_detailLabel.frame = CGRectMake(20, 45, WindowSizeWidth - 40, size.height + 10);
            
            cell.m_backImgV.frame = CGRectMake(10, 10, cell.m_backImgV.frame.size.width, 68 - 21 + size.height);
            
            cell.frame = CGRectMake(0, 0, WindowSizeWidth, cell.m_backImgV.frame.size.height + 10);
            
        }
        
        
        cell.m_webView.hidden = YES;
        cell.m_detailLabel.hidden = NO;
        
        cell.backgroundColor = [UIColor clearColor];
        
        // 设置cell的背景边框
        cell.m_backImgV.layer.borderColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0].CGColor;
        cell.m_backImgV.layer.borderWidth = 1.0;
        
        return cell;

    }
   
}

- (UITableViewCell *)tableViewFour:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
     if ( self.m_typeString == MERCHANTACTIVITY ) {
         
         if ( indexPath.row == 5 ) {
             
             static NSString *cellIdentifier = @"OtherCellIdentifier";
             
             OtherCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
             
             if ( cell == nil ) {
                 
                 NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"ProductDetailCell" owner:self options:nil];
                 
                 cell = (OtherCell *)[nib objectAtIndex:4];
                 
                 cell.selectionStyle = UITableViewCellSelectionStyleNone;
                 
                 cell.backgroundColor = [UIColor clearColor];
                 
             }
             
             
             if ( self.m_productList.count != 0 ) {
                 
                 cell.m_otherName.text = @"类似活动";
                 
                 
                 // 赋值
                 NSMutableDictionary *dic = [self.m_productList objectAtIndex:indexPath.row - 5];
                 
                 cell.m_nameLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"ActivityName"]];
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
                 
                 cell.selectionStyle = UITableViewCellSelectionStyleNone;
                 
                 cell.backgroundColor = [UIColor clearColor];
                 
             }
             
             // 赋值
             if ( self.m_productList.count != 0 ) {
                 
                 NSMutableDictionary *dic = [self.m_productList objectAtIndex:indexPath.row - 5];
                 
                 cell.m_productName.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"ActivityName"]];
                 
                 
                 // 设置cell的背景边框
                 cell.m_backImgV.layer.borderColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0].CGColor;
                 cell.m_backImgV.layer.borderWidth = 1.0;
                 
             }
             
             return cell;
         }

         
     }else{
         
         if ( indexPath.row == 4 ) {
             
             static NSString *cellIdentifier = @"OtherCellIdentifier";
             
             OtherCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
             
             if ( cell == nil ) {
                 
                 NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"ProductDetailCell" owner:self options:nil];
                 
                 cell = (OtherCell *)[nib objectAtIndex:4];
                 
                 cell.selectionStyle = UITableViewCellSelectionStyleNone;
                 
                 cell.backgroundColor = [UIColor clearColor];
                 
             }
             
             
             if ( self.m_productList.count != 0 ) {
                 
                 cell.m_otherName.text = @"类似活动";
                 
                 
                 // 赋值
                 NSMutableDictionary *dic = [self.m_productList objectAtIndex:indexPath.row - 4];
                 
                 cell.m_nameLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"ActivityName"]];
                 cell.m_clickedBtn.tag = indexPath.row - 4;
                 [cell.m_clickedBtn addTarget:self action:@selector(clickedBtn:) forControlEvents:UIControlEventTouchUpInside];
             }
             
             
             return cell;
             
         }else{
             
             static NSString *cellIdentifier = @"OtherOneCellIdentifier";
             
             OtherOneCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
             
             if ( cell == nil ) {
                 
                 NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"ProductDetailCell" owner:self options:nil];
                 
                 cell = (OtherOneCell *)[nib objectAtIndex:5];
                 
                 cell.selectionStyle = UITableViewCellSelectionStyleNone;
                 
                 cell.backgroundColor = [UIColor clearColor];
                 
             }
             
             // 赋值
             if ( self.m_productList.count != 0 ) {
                 
                 NSMutableDictionary *dic = [self.m_productList objectAtIndex:indexPath.row - 4];
                 
                 cell.m_productName.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"ActivityName"]];
                 
                 
                 // 设置cell的背景边框
                 cell.m_backImgV.layer.borderColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0].CGColor;
                 cell.m_backImgV.layer.borderWidth = 1.0;
                 
             }
             
             return cell;
         }

         
     }
   
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ( self.m_typeString == MERCHANTACTIVITY ) {

        if ( indexPath.row == 0 ) {
            
            return 140.0f;
            
        }else if ( indexPath.row == 1 ){
            
            return 36.0f;
            
        }else if ( indexPath.row == 2 ){
            
            CGSize size = [self.m_infoString sizeWithFont:[UIFont systemFontOfSize:12.0f] constrainedToSize:CGSizeMake(WindowSizeWidth - 40, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
            
            return 68 - 21 + size.height + 10 + 10;
            
        }else if ( indexPath.row == 3 ){
            
            CGSize size = [self.m_contentString sizeWithFont:[UIFont systemFontOfSize:12.0f] constrainedToSize:CGSizeMake(WindowSizeWidth - 40, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
            
            return 68 - 21 + size.height + 10 + 10;
            
        }else if ( indexPath.row == 4 ){
            
            CGSize size = [self.m_PromptString sizeWithFont:[UIFont systemFontOfSize:12.0f] constrainedToSize:CGSizeMake(WindowSizeWidth - 40, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
            
            return 68 - 21 + size.height + 10 + 10;
            
        }else if ( indexPath.row == 5 ) {
            
            return 78.0f;
            
        }else{
            
            return 40.0f;
        }
        
    }else{
        if ( indexPath.row == 0 ) {
            
            return 89.0f;
            
        }else if ( indexPath.row == 1 ){
            
            return 36.0f;
            
        }else if ( indexPath.row == 2 ){
            
            CGSize size = [self.m_contentString sizeWithFont:[UIFont systemFontOfSize:12.0f] constrainedToSize:CGSizeMake(WindowSizeWidth - 40, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
            
            return 68 - 21 + size.height + 10 + 10;
            
        }else if ( indexPath.row == 3 ){
            
            CGSize size = [self.m_PromptString sizeWithFont:[UIFont systemFontOfSize:12.0f] constrainedToSize:CGSizeMake(WindowSizeWidth - 40, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
            
            return 68 - 21 + size.height + 10 + 10;
            
        }else if ( indexPath.row == 4 ){
            
            return 78.0f;
            
        }else{
            
            return 40.0f;
        }

    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    if ( self.m_typeString == MERCHANTACTIVITY ) {

        if ( indexPath.row == 1 ) {
            
            // 进入评价的页面
            CommentViewController *VC = [[CommentViewController alloc]initWithNibName:@"CommentViewController" bundle:nil];
            VC.m_typeString = @"3";
            VC.m_serviceId = [NSString stringWithFormat:@"%@",[self.m_items objectForKey:@"ActivityID"]];
            [self.navigationController pushViewController:VC animated:YES];
            
        }else if ( indexPath.row > 5 ){
            
            NSDictionary *dic = [self.m_productList objectAtIndex:indexPath.row - 5];
            
            // 点击进入活动详情
            ActivityDetailViewController *VC = [[ActivityDetailViewController alloc]initWithNibName:@"ActivityDetailViewController" bundle:nil];
            VC.m_typeString = self.m_typeString;
            VC.m_partyString = self.m_partyString;
            VC.m_serviceId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"ActivityID"]];
            
            [self.navigationController pushViewController:VC animated:YES];
        }
  
        
    }else{
        
        if ( indexPath.row == 1 ) {
            
            // 进入评价的页面
            CommentViewController *VC = [[CommentViewController alloc]initWithNibName:@"CommentViewController" bundle:nil];
            VC.m_typeString = @"3";
            VC.m_serviceId = [NSString stringWithFormat:@"%@",[self.m_items objectForKey:@"ActivityID"]];
            [self.navigationController pushViewController:VC animated:YES];
            
        }else if ( indexPath.row > 4 ){
            
            NSDictionary *dic = [self.m_productList objectAtIndex:indexPath.row - 4];
            
            // 点击进入活动详情
            ActivityDetailViewController *VC = [[ActivityDetailViewController alloc]initWithNibName:@"ActivityDetailViewController" bundle:nil];
            VC.m_typeString = self.m_typeString;
            VC.m_partyString = self.m_partyString;
            VC.m_serviceId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"ActivityID"]];
            
            [self.navigationController pushViewController:VC animated:YES];
        }
 
        
    }
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    
}

- (void)clickedBtn:(id)sender{
    
    UIButton *btn = (UIButton *)sender;
    
    NSLog(@"tag = %i",btn.tag);
    
    NSDictionary *dic = [self.m_productList objectAtIndex:btn.tag];

    // 点击进入活动详情
    ActivityDetailViewController *VC = [[ActivityDetailViewController alloc]initWithNibName:@"ActivityDetailViewController" bundle:nil];
    VC.m_typeString = self.m_typeString;
    VC.m_partyString = self.m_partyString;
    VC.m_serviceId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"ActivityID"]];
    [self.navigationController pushViewController:VC animated:YES];
    
}

#pragma UIScrollView delegate
-(void)scrollToNextPage:(id)sender
{
    int pageNum = self.m_pageControl.currentPage;
    
    CGSize viewSize = self.m_scrollerView.frame.size;
 
    pageNum ++;
    
    if ( pageNum == self.m_imagArray.count ) {
        
        pageNum = 0;
        
        self.m_pageControl.currentPage = pageNum;

        CGRect newRect=CGRectMake(0, 0, viewSize.width, viewSize.height);
        [self.m_scrollerView scrollRectToVisible:newRect animated:YES];
   
    }else{
        
        self.m_pageControl.currentPage = pageNum;

        
        CGRect rect = CGRectMake(pageNum * viewSize.width, 0, viewSize.width, viewSize.height);
        [self.m_scrollerView scrollRectToVisible:rect animated:YES];
    }
    

}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pageWidth = self.m_scrollerView.frame.size.width;
    int currentPage = self.m_scrollerView.contentOffset.x  / pageWidth;
    
    //floor((self.m_scrollerView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    
//    if ( currentPage == 0 ) {
//        
//        self.m_pageControl.currentPage = self.m_imagArray.count - 1;
//        
//    }else if ( currentPage == self.m_imagArray.count + 1 ){
//        
//        self.m_pageControl.currentPage = 0;
//        
//    }
//    self.m_pageControl.currentPage = currentPage - 1;
    
//    self.m_pageControl.currentPage = currentPage;
    
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.m_timer invalidate];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    self.m_timer = [NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(scrollToNextPage:) userInfo:nil repeats:YES];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pageWidth = self.m_scrollerView.frame.size.width;
    CGFloat pageHeigth = self.m_scrollerView.frame.size.height;
    int currentPage = self.m_scrollerView.contentOffset.x / pageWidth;
    
    //floor((self.m_scrollerView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    
//    if ( currentPage == 0 ) {
//        
//        [self.m_scrollerView scrollRectToVisible:CGRectMake(pageWidth*m_imagArray.count, 0, pageWidth, pageHeigth) animated:NO];
//        self.m_pageControl.currentPage = self.m_imagArray.count - 1;
//        
//        return;
//        
//    }else if( currentPage == [self.m_imagArray count] + 1 ){
//        
//        [self.m_scrollerView scrollRectToVisible:CGRectMake(pageWidth, 0, pageWidth, pageHeigth) animated:NO];
//        self.m_pageControl.currentPage = 0;
//        
//        return;
//    }
    
    
    [self.m_scrollerView scrollRectToVisible:CGRectMake(pageWidth * currentPage, 0, pageWidth, pageHeigth) animated:NO];
//    self.m_pageControl.currentPage = 0;
    
    
    self.m_pageControl.currentPage = currentPage;
}



@end
