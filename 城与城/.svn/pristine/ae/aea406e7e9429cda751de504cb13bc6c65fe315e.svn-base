//
//  SceneryDetailViewController.m
//  HuiHui
//
//  Created by mac on 15-1-13.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "SceneryDetailViewController.h"

#import "SceneryDetailCell.h"

#import "SceneryDetailInfoViewController.h"

#import "SceneryPictureViewController.h"

#import "SceneryNearViewController.h"

#import "MJPhoto.h"

#import "MJPhotoBrowser.h"

#import "CommonUtil.h"

#import "UIImageView+AFNetworking.h"

#import "SceneryMapViewController.h"

#import "SceneryNearListCell.h"

#import "SceneryOrderformViewController.h"

@interface SceneryDetailViewController ()

@property (strong, nonatomic) SceneryStarView *m_starView;

@property (weak, nonatomic) IBOutlet UITableView *m_tableView;

@property (weak, nonatomic) IBOutlet UIView *m_headerView;

@property (weak, nonatomic) IBOutlet UILabel *m_name;

@property (weak, nonatomic) IBOutlet UIImageView *m_imageView;

@property (weak, nonatomic) IBOutlet UILabel *m_subName;

@property (weak, nonatomic) IBOutlet UILabel *m_themId;

@property (weak, nonatomic) IBOutlet UIImageView *m_backImgV;

@property (strong, nonatomic) IBOutlet UIView *m_showView;

@property (weak, nonatomic) IBOutlet UIView *m_showDetailView;

@property (weak, nonatomic) IBOutlet UILabel *m_price;

@property (weak, nonatomic) IBOutlet UITextView *m_textView;

@property (weak, nonatomic) IBOutlet UIControl *m_control;

@property (weak, nonatomic) IBOutlet UIButton *m_btn;

// 简介
- (IBAction)introductedClicked:(id)sender;
// 周边
- (IBAction)nearClicked:(id)sender;
// 图片
- (IBAction)pictureClicked:(id)sender;
// 点评
- (IBAction)commentClicked:(id)sender;
// 点击上面的图片进入图片展示的页面
- (IBAction)imageShowClicked:(id)sender;
// 点击票面说明显示的view所触发的事件
- (IBAction)tapDown:(id)sender;
// 票面说明上面预订按钮触发的事件
- (IBAction)ResertShowClicked:(id)sender;

@end

@implementation SceneryDetailViewController

@synthesize m_dic;

@synthesize m_sizeDic;

@synthesize m_PathDic;

@synthesize m_imagePath;

@synthesize m_priceList;

@synthesize m_noticeList;

@synthesize m_aheadDic;

@synthesize m_noticeString;

@synthesize m_noticeWebView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        m_dic = [[NSMutableDictionary alloc]initWithCapacity:0];

        m_sizeDic = [[NSMutableDictionary alloc]initWithCapacity:0];

        m_PathDic = [[NSMutableDictionary alloc]initWithCapacity:0];
        
        m_priceList = [[NSMutableArray alloc]initWithCapacity:0];
      
        m_noticeList = [[NSMutableArray alloc]initWithCapacity:0];
        
        m_aheadDic = [[NSMutableDictionary alloc]initWithCapacity:0];
        
        m_index = 0;
        
        m_firstIn = NO;


    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"景点信息"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    // 设置imageView的背景颜色及透明度
    self.m_backImgV.backgroundColor = [UIColor blackColor];
    
    self.m_backImgV.alpha = 0.6;
    
    // 设置预订按钮的圆角
    self.m_btn.layer.cornerRadius = 5.0f;
    
    // 设置textView不可编辑
    self.m_textView.editable = NO;
    
    // 点击票型说明显示的view
    self.m_showView.hidden = YES;
    self.m_showDetailView.layer.masksToBounds = YES;//设置圈角
    self.m_showDetailView.layer.cornerRadius = 5.0;
//    self.m_showView.alpha = 0;
//    self.m_control.alpha = 0;
    [self.navigationController.view.window addSubview:self.m_showView];
    

    self.m_noticeString = @"";
    
    // 初始化webView
    UIWebView *webview = [[UIWebView alloc]initWithFrame:CGRectMake(20, 45, 280, 100)];
    webview.delegate = self;
    webview.tag = 1022;
    webview.scalesPageToFit = YES;

    self.m_noticeWebView = webview;
    
    // 测试
//    SceneryStarView *starRatingView = [[SceneryStarView alloc] initWithFrame:CGRectMake(10, 118, 90, 17) numberOfStar:5];
//    starRatingView.backgroundColor = [UIColor clearColor];
//    
//    self.m_starView = starRatingView;
//    
//    [self.m_headerView addSubview:self.m_starView];
    
    // 设置星级显示
//    [self.m_starView changeViewFrame:7.3f];
    
    
    self.m_tableView.hidden = YES;

}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    // 只有第一次进入页面的时候来请求数据
    if ( !m_firstIn ) {
        
        m_firstIn = YES;
     
        // 请求图片列表数据
        [self sceneryPictureListRequest];
        
        // 请求价格的接口
        [self sceneryPriceRequest];
    }
 
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)leftClicked{
    
    [self goBack];
}

#pragma mark - BtnClicked
- (IBAction)introductedClicked:(id)sender {
    // 进入景区简介的页面
    SceneryDetailInfoViewController *VC = [[SceneryDetailInfoViewController alloc]initWithNibName:@"SceneryDetailInfoViewController" bundle:nil];
    VC.m_dic = self.m_dic;
    [self.navigationController pushViewController:VC animated:YES];
}

- (IBAction)nearClicked:(id)sender {
   // 进入周边景区的页面
    SceneryNearViewController *VC = [[SceneryNearViewController alloc]initWithNibName:@"SceneryNearViewController" bundle:nil];
    VC.m_sceneryId = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"sceneryId"]];
    [self.navigationController pushViewController:VC animated:YES];
    
}

- (IBAction)pictureClicked:(id)sender {
    
    // 进入景区图片列表的页面
    SceneryPictureViewController *VC = [[SceneryPictureViewController alloc]initWithNibName:@"SceneryPictureViewController" bundle:nil];
    VC.m_imageUrl = [NSString stringWithFormat:@"%@",self.m_imagePath];
    VC.m_sceneryId = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"sceneryId"]];
    VC.m_imageList = [self.m_PathDic objectForKey:@"image"];
    [self.navigationController pushViewController:VC animated:YES];

}

- (IBAction)commentClicked:(id)sender {
    
    
}

- (IBAction)imageShowClicked:(id)sender {

    
}

- (IBAction)tapDown:(id)sender {
    
    // 点击时隐藏
    self.m_showView.hidden = YES;
}

// 预订按钮触发的事件
- (IBAction)ResertShowClicked:(id)sender {
    
    NSMutableDictionary *dic = [self.m_priceList objectAtIndex:m_index];

    self.m_showView.hidden = YES;
    // 点击进入预订门票的页面
    SceneryOrderformViewController *VC = [[SceneryOrderformViewController alloc]initWithNibName:@"SceneryOrderformViewController" bundle:nil];
    VC.m_dic = dic;
    VC.m_sceneryId = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"sceneryId"]];
    [self.navigationController pushViewController:VC animated:YES];
    
}

- (void)ResertClicked:(id)sender{
    
    UIButton *btn = (UIButton *)sender;
    
    m_index = btn.tag;
    
    // 预订按钮触发的事件-cell上面的预订 - 按钮点击进入预订门票的页面
    NSMutableDictionary *dic = [self.m_priceList objectAtIndex:m_index];
    
    self.m_showView.hidden = YES;
    // 点击进入预订门票的页面
    SceneryOrderformViewController *VC = [[SceneryOrderformViewController alloc]initWithNibName:@"SceneryOrderformViewController" bundle:nil];
    VC.m_dic = dic;
    VC.m_sceneryId = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"sceneryId"]];
    [self.navigationController pushViewController:VC animated:YES];
    
}

- (void)ExplanationClicked:(id)sender{
    
    UIButton *btn = (UIButton *)sender;
    
    m_index = btn.tag;
    
    [UIView animateWithDuration:0.5
                     animations:^{
                         
                         // 详细说明
                         self.m_showView.hidden = NO;
                         
                     }
                     completion:^(BOOL finished){
                         
                         
                     }
     ];
    
    // 刷新数据
    [self reshData:btn.tag];
    
    
}


// 点击票型说明后刷新页面上显示的内容
- (void)reshData:(NSInteger)index{
    
    NSDictionary *dic = [self.m_priceList objectAtIndex:index];
    
    // 拼接字符串-预订时间
    NSString *string = @"";
    NSString *dTime = @"";
    
    // 预订截止时间
    NSString *day = [NSString stringWithFormat:@"%@",[dic objectForKey:@"advanceDay"]];
    
    NSString *time = [NSString stringWithFormat:@"%@",[dic objectForKey:@"timeLimit"]];
    
    NSString *timeString = @"";
    // 根据day来进行判断，要提前day天time点前预订
    
    if ( [day isEqualToString:@"(null)"] || day.length == 0 ) {
        
        // 赋值
        dTime = @"请尽早提前预订";
        
    }else{
        
        if ( [day isEqualToString:@"0"] ) {
            
            timeString = [NSString stringWithFormat:@"当天%@前",time];
            
        }else{
            
            timeString = [NSString stringWithFormat:@"前%@天%@前",day,time];
            
        }
        
        // 赋值
        dTime = [NSString stringWithFormat:@"请最晚要在出行%@预订。",timeString];
    }
    
    string = [NSString stringWithFormat:@"预订时间\n%@，%@",[dic objectForKey:@"policyName"],dTime];
    
    
    // 包含项目
    NSString *xiangmuString = @"";
    NSString *containItems = [NSString stringWithFormat:@"%@",[dic objectForKey:@"containItems"]];
    //根据值来判断是否显示
    if ( containItems.length == 0 || [containItems isEqualToString:@"(null)"] ) {
        
        xiangmuString = @"";

    }else{
        
        xiangmuString = [NSString stringWithFormat:@"包含项目\n%@",containItems];

    }
        
    // 取票方式
    NSString *gMode = @"";
    
    NSString *mode = [NSString stringWithFormat:@"%@",[dic objectForKey:@"gMode"]];
    
    //根据值来判断是否显示
    if ( mode.length == 0 || [mode isEqualToString:@"(null)"] ) {
        
        gMode = @"";
        
    }else{
        
        gMode = [NSString stringWithFormat:@"取票方式\n%@",mode];
    }
    
    
    // 使用日期
    NSString *useDate = @"";
    
    NSString *closeDate = @"";
    
//    bDate    门票类型可预订的开始时间
//    eDate    门票类型可预订的结束时间
//    <openDateType> --价格策略有效期类型3-特殊日,2-按周,1-按月,0-普通
//    <openDateValue> --价格策略具体有效期，只针对按周或月有效(已去除前后逗号)。
//    <closeDate> --价格策略里面的屏蔽节假日 例如： 2-10,4-15,5-20
//    openDateType=3时 还是取 bDate-eDate
//    openDateType=2时  1,2 就是星期一 ，星期二
//    openDateType=1 时  10,20 就是10号，20 号
    
    // 可预订的类型
    NSString *dateTypeString = [NSString stringWithFormat:@"%@",[dic objectForKey:@"openDateType"]];
    
    NSString *dateString = @"";
    
    if ( [dateTypeString isEqualToString:@"0"] || [dateTypeString isEqualToString:@"3"] ) {
        
        dateString = [NSString stringWithFormat:@"%@到%@可预订",[dic objectForKey:@"bDate"],[dic objectForKey:@"eDate"]];
        
    }else if ( [dateTypeString isEqualToString:@"1"] ){
        
        dateString = @"每个月的10、20号可预订";
        
    }else if ( [dateTypeString isEqualToString:@"2"] ){
        
        dateString = @"星期一 ，星期二可预订";
        
    }else{
        
        dateString = @"";
    }
    
    // 预订票的屏蔽节假日
    closeDate = [NSString stringWithFormat:@"%@",[dic objectForKey:@"closeDate"]];
    
    if ( [closeDate isEqualToString:@"(null)"] || closeDate.length == 0 ) {
        // 根据值是否有值来判断是否显示
        if ( dateString.length != 0 ) {
            
            useDate = [NSString stringWithFormat:@"可预订日期\n%@",dateString];

        }else{
            
            useDate = @"";

        }

        
    }else{
        // 根据值是否有值来判断是否显示
        if ( dateString.length != 0 ) {
            
            useDate = [NSString stringWithFormat:@"可预订日期\n%@，%@除外",dateString,closeDate];

        }else{
            
            useDate = [NSString stringWithFormat:@"%@不可预订",closeDate];

        }
        

    }
    
    // 购买限制
    NSString *countString = @"";
    
    NSString *minT = [NSString stringWithFormat:@"%@",[dic objectForKey:@"minT"]];

    NSString *maxT = [NSString stringWithFormat:@"%@",[dic objectForKey:@"maxT"]];
    
    if ( [maxT isEqualToString:@"0"] && [minT isEqualToString:@"0"] ) {
        
        countString = @"预订限制\n预订没有票数限制。";
        
    }else{
        
        if ( maxT.length == 0 || [maxT isEqualToString:@"(null)"] ) {
            
            countString = @"";

        }else{
            
            countString = [NSString stringWithFormat:@"预订限制\n一次最多可预订%@张。",maxT];
        }
    
    }

    
    // 预订说明
//    NSString *shuoming = @"";
//    shuoming = [NSString stringWithFormat:@"取票方式\n%@",[dic objectForKey:@"gMode"]];
    

    // 赋值
    self.m_textView.text = [NSString stringWithFormat:@"%@\n\n%@\n\n%@\n\n%@\n\n%@",string,xiangmuString,gMode,useDate,countString];
    

    
    self.m_price.text = [NSString stringWithFormat:@"￥%@",[dic objectForKey:@"tcPrice"]];
    

    
    
    
    
}


#pragma mark - UITableViewDatasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if ( section == 0 ) {
        
        return 2;
        
    }else if ( section == 1 ){
        
        return self.m_priceList.count;
        
    }else{
        
         return 1;
    }
}
#pragma mark - address tableviewcell
- (UITableViewCell *)AddressTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
        
    static NSString *cellIdentifier = @"SceneryMapCellIdentifier";
    
    SceneryMapCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"SceneryDetailCell" owner:self options:nil];
        
        cell = (SceneryMapCell *)[nib objectAtIndex:2];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if ( indexPath.row == 0 ) {
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
        }
    }
    
    if ( indexPath.row == 0 ) {
        
        // 地址  赋值
        cell.m_address.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"sceneryAddress"]];
        cell.m_address.numberOfLines = 2;
        
        cell.m_imagV.image = [UIImage imageNamed:@"xq_map.png"];
        
    }else{
        
        // 入园提醒
        cell.m_address.numberOfLines = 2;
        
        cell.m_imagV.image = [UIImage imageNamed:@"xq_time.png"];
        
        NSString *day = [NSString stringWithFormat:@"%@",[self.m_aheadDic objectForKey:@"day"]];
        
        NSString *time = [NSString stringWithFormat:@"%@",[self.m_aheadDic objectForKey:@"time"]];
        
        NSString *timeString = @"";
        // 根据day来进行判断，要提前day天time点前预订
        
        if ( [day isEqualToString:@"(null)"] || day.length == 0 ) {
           
            // 赋值
            cell.m_address.text = @"请尽早提前预订";
            
        }else{
            
            if ( [day isEqualToString:@"0"] ) {
                
                timeString = [NSString stringWithFormat:@"当天%@前",time];
                
            }else{
                
                timeString = [NSString stringWithFormat:@"前%@天%@前",day,time];
                
            }

            // 赋值
            cell.m_address.text = [NSString stringWithFormat:@"如需预订，您最晚要在出行%@下单，请尽早预订",timeString];
        }
        
    }
    
    
    return cell;
    
}

#pragma mark - price tableviewcell
- (UITableViewCell *)PriceTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"SceneryPriceCellIdentifier";
    
    SceneryPriceCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"SceneryNearListCell" owner:self options:nil];
        
        cell = (SceneryPriceCell *)[nib objectAtIndex:1];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
       
    }
    // 价钱  赋值
    if ( self.m_priceList.count != 0 ) {
        
        NSDictionary *dic = [self.m_priceList objectAtIndex:indexPath.row];
        
        cell.m_policyName.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"policyName"]];
        
        cell.m_orignPrice.text = [NSString stringWithFormat:@"￥%@",[dic objectForKey:@"price"]];
        
        cell.m_price.text = [NSString stringWithFormat:@"￥%@",[dic objectForKey:@"tcPrice"]];
        
        // 返利赋值
        cell.m_fanli.text = [NSString stringWithFormat:@"返￥%@",[dic objectForKey:@"rebate"]];

        // 添加按钮事件
        cell.m_shuomingBtn.tag = indexPath.row;
        cell.m_yudingBtn.tag = indexPath.row;
        
        cell.m_yudingBtn.layer.cornerRadius = 5.0f;
        
        [cell.m_shuomingBtn addTarget:self action:@selector(ExplanationClicked:) forControlEvents:UIControlEventTouchUpInside];
        [cell.m_yudingBtn addTarget:self action:@selector(ResertClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
    }
   
    
    return cell;
    
}


#pragma mark - notice tableviewcell
- (UITableViewCell *)NoticeTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"SceneryNoticeCellIdentifier";
    
    SceneryNoticeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"SceneryDetailCell" owner:self options:nil];
        
        cell = (SceneryNoticeCell *)[nib objectAtIndex:3];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    // 购买须知  赋值
    cell.m_notice.hidden = YES;
    
    // 加载webView
    NSString *BookStr = [self htmlString:self.m_noticeString];
    // webView赋值
    [cell.m_webView loadHTMLString:BookStr baseURL:nil];
   
    cell.m_webView.scrollView.scrollEnabled = NO;
    
    cell.m_webView.scalesPageToFit = YES;
    

    // 计算webView的高度
    cell.m_webView.frame = CGRectMake(cell.m_webView.frame.origin.x, cell.m_webView.frame.origin.y, cell.m_webView.frame.size.width, self.m_noticeWebView.frame.size.height);

    cell.frame = CGRectMake(cell.frame.origin.x, cell.frame.origin.y, cell.frame.size.width, cell.m_webView.frame.origin.y + cell.m_webView.frame.size.height + 5);
    
    

    
    return cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = nil;
    
    if ( indexPath.section == 0 ) {
        
        cell = [self AddressTableView:tableView cellForRowAtIndexPath:indexPath];
        
    }else if ( indexPath.section == 1 ){
    
        cell = [self PriceTableView:tableView cellForRowAtIndexPath:indexPath];
    
    }else{
        
        cell = [self NoticeTableView:tableView cellForRowAtIndexPath:indexPath];
    }
    
    return cell;
 
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ( indexPath.section == 0 ) {
        
        return 44.0f;
        
    }else if ( indexPath.section == 1 ){
        
        return 70.0f;

    }else{
        
        // 根据内容计算高度-购买须知
        return 40 + self.m_noticeWebView.frame.size.height + 6;

    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if ( section == 1 ){
        
        if ( self.m_priceList.count != 0 ) {
            
            return 10.0f;
            
        }else{
            
            if ( isIOS7 ) {
                
                return 0.001;
            }
            
            return 0.0f;
        }
    }else{
        
        return 10.0f;
    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ( indexPath.section == 0 ) {
        
        if ( indexPath.row == 0 ) {
            
            // 进入地图显示的页面
            NSMutableArray *arr = [[NSMutableArray alloc]initWithCapacity:0];
            [arr addObject:self.m_dic];
            
            NSString *string = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"lat"]];
            // 判断经纬度是否有值，有值的话则进入地图显示的页面
            if ( ![string isEqualToString:@"(null)"] ) {
                
                SceneryMapViewController *VC = [[SceneryMapViewController alloc]initWithNibName:@"SceneryMapViewController" bundle:nil];
                VC.m_aninationList = arr;
                VC.m_imageUrl = [NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:SceneryImageUrl]];
                [self.navigationController pushViewController:VC animated:YES];
            }
        
        }
    }
    
}

#pragma mark - NetWork
- (void)sceneryPriceRequest{
    
    self.m_tableView.hidden = NO;

    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }

    //  payType 0：所有，1到付，2在线支付，默认0
    //  isAutoShowPrice 否，0:显示，1：不现实，默认0
    //  useCache 0不使用，1使用，默认0
    //  payType 否，0：所有，1到付，2在线支付，默认0
    // 获取memberId
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    AppHttpClient* httpClient = [AppHttpClient scenerySharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"memberId",
                           [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"sceneryId"]],@"sceneryIds",
                           @"",@"isAutoShowPrice",
                           @"",@"useCache",
                           @"",@"payType",
                           
                           nil];
//    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    [httpClient requestScenery:@"Scenery/GetSceneryPrice.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        // status 0表示有数据 其他表示错误
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        NSLog(@"json = %@",json);
        
        if ( success ) {
            
            [SVProgressHUD dismiss];
            
            NSMutableArray *list = [json valueForKey:@"sceneryList"];
            
            if ( list.count != 0 ) {
                
                NSDictionary *dic = [list objectAtIndex:0];
                
                self.m_priceList = [dic objectForKey:@"policy"];

                self.m_noticeList = [dic objectForKey:@"notice"];
                
                self.m_aheadDic = [dic objectForKey:@"ahead"];
                
                
                if ( self.m_noticeList.count != 0 ) {
                   

                    // 根据数
                    for (int i = 0; i < self.m_noticeList.count; i++) {
                        
                        NSDictionary *dic = [self.m_noticeList objectAtIndex:i];
                        
                        NSMutableArray *nInfo = [dic objectForKey:@"nInfo"];
                        
                        if ( nInfo.count != 0 ) {
                            
                            NSString *string1 = @"";

                            for (int ii = 0; ii < nInfo.count; ii++) {
                                
                                NSString *string = @"";
                     
                                NSDictionary *dic = [nInfo objectAtIndex:ii];

                                NSString *name = [NSString stringWithFormat:@"%@",[dic objectForKey:@"nName"]];

                              
                                // 判断名称是否为空，为空的话则不显示名称，不为空的话则显示
                                if ( [name isEqualToString:@"(null)"] || name.length == 0 ) {

                                    string = [NSString stringWithFormat:@"%@\n",[dic objectForKey:@"nContent"]];

                                }else{

                                    string = [NSString stringWithFormat:@"%@%@\n",name,[dic objectForKey:@"nContent"]];

                                }
                                
                                
                                string1 = [string1 stringByAppendingString:string];
                                
                                
                            }
                            
                            self.m_noticeString = [self.m_noticeString stringByAppendingString:string1];
                            
                        }
                    
                    }
                    
                    NSString *string = [self htmlString:self.m_noticeString];
                    
                    // webView赋值
                    [self.m_noticeWebView loadHTMLString:string baseURL:nil];
                }
                
              

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

#pragma mark - NetWork
- (void)sceneryPictureListRequest{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    // 获取memberId
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    // 1.mapbar2.百度；不传默认为1
    AppHttpClient* httpClient = [AppHttpClient scenerySharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"memberId",
                           [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"sceneryId"]],@"sceneryId",
                           @"1",@"page",
                           @"20",@"pageSize",
                           
                           nil];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    [httpClient requestScenery:@"Scenery/GetSceneryImageList.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        // status 0表示有数据 其他表示错误
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if ( success ) {
            
            [SVProgressHUD dismiss];
            
            // 赋值
            self.m_name.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"sceneryName"]];
            
            self.m_subName.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"scenerySummary"]];
            
            // 根据值来判断是否显示
            if ( [self.m_subName.text isEqualToString:@"(null)"] ) {
                
                self.m_subName.text = @"";
                
            }
            
            // 主题进行赋值
            NSArray *themList = [self.m_dic objectForKey:@"themeList"];
            
            NSString *themName = @"";
            
            if ( themList.count != 0 ) {
                
                // 取数组里的第一个值
                NSMutableDictionary *dic = [themList objectAtIndex:0];
                
                themName = [NSString stringWithFormat:@"%@",[dic objectForKey:@"themeName"]];
                
            }
            
            // 判断字符是否为空的情况
            if ( [themName isEqualToString:@"(null)"] || [themName isEqualToString:@""] ) {
                themName = @"";
            }
            
            NSString *gradeId = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"gradeId"]];
            
            if ( [gradeId isEqualToString:@"(null)"] ||  [gradeId isEqualToString:@""] ) {
                
                // 赋值
                gradeId = @"";
                
            }
            
            // 赋值
            self.m_themId.text = [NSString stringWithFormat:@"%@  %@",themName,gradeId];
            
            
            // 图片赋值
            self.m_PathDic = [json valueForKey:@"imagelist"];
            
            self.m_sizeDic = [json valueForKey:@"extInfoOfImageList"];
            
            NSString *imageUrl = [NSString stringWithFormat:@"%@",[self.m_sizeDic objectForKey:@"imageBaseUrl"]];
           
            // 取出图片size的大小
//            NSString *size = @"";
            NSString *l_size = @"";
            
            NSMutableArray *arr = [self.m_sizeDic objectForKey:@"sizeCodeList"];
            
            if ( arr.count != 0 ) {
                
//                NSDictionary *dic = [arr objectAtIndex:arr.count - 1];
//                
//                size = [NSString stringWithFormat:@"%@",[dic objectForKey:@"size"]];
                
                // 获取300*225 / 740_350 的尺寸用于图片列表进行显示
                NSDictionary *l_dic = [arr objectAtIndex:arr.count - 1];
                
                l_size = [NSString stringWithFormat:@"%@",[l_dic objectForKey:@"size"]];
            
            }

            // 获取出图片的路径
            NSMutableArray *path_arr = [self.m_PathDic objectForKey:@"image"];
            
            NSString *image = @"";
            
            if ( path_arr.count != 0 ) {
                
                NSDictionary *dic = [path_arr objectAtIndex:0];
                
                image = [NSString stringWithFormat:@"%@",[dic objectForKey:@"imagePath"]];
                
            }

            // 拼接图片地址
            NSString *imagePath = [NSString stringWithFormat:@"%@%@/%@",imageUrl,l_size,image];
            
            // 拼接字符用于图片列表进行显示
            self.m_imagePath = [NSString stringWithFormat:@"%@%@/",imageUrl,l_size];
            
            // 对图片进行赋值
            [self.m_imageView setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:imagePath]]
                                    placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"]
                                             success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                                                 
                                                 self.m_imageView.image = [CommonUtil scaleImage:image toSize:CGSizeMake(WindowSizeWidth , 150)];
                                                 self.m_imageView.contentMode = UIViewContentModeScaleToFill;
                                                 
                                             }
                                             failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                                                 
                                             }];
            
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
            
            // 请求错误的情况下进行赋值
            self.m_name.text = @"";
            self.m_subName.text = @"";
            self.m_themId.text = @"";
            self.m_imageView.image = [UIImage imageNamed:@"invite_reg_no_photo.png"];
        }
        
    } failure:^(NSError *error) {
        
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
        // 请求错误的情况下进行赋值
        self.m_name.text = @"";
        self.m_subName.text = @"";
        self.m_themId.text = @"";
        self.m_imageView.image = [UIImage imageNamed:@"invite_reg_no_photo.png"];
        
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
                         "</html>",40.0,aString];
    
    return BookStr;
    
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView{
    
    //导航栏表示网络正在进行
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
}

// webView加载完成后设置内容字体的大小，内容的高度
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    //导航栏表示网络停止进行
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    if ( webView == self.m_noticeWebView ) {
        
        CGFloat high = 0.0;
        
        //UIWebView字体大小设为190
        NSString *jsString = [[NSString alloc] initWithFormat:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '%f%%'",230.0f];
        
        [webView stringByEvaluatingJavaScriptFromString:jsString];
        //获取webView的自适应高度
        high = [webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight;"].floatValue/8.0f;
        
        
        CGRect frame = [webView frame];
        frame.size.height = high;
        [webView setFrame:CGRectMake(20, 45, 280, high + 10)];
        
        
        // 刷新列表
        [self.m_tableView reloadData];
        
    }
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
    //导航栏表示网络停止进行
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
}

@end
