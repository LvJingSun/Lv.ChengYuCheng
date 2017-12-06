//
//  SceneryDetailInfoViewController.m
//  HuiHui
//
//  Created by mac on 15-1-26.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "SceneryDetailInfoViewController.h"

#import "CommonUtil.h"

#import "SceneryDetaiInfoCell.h"

#import "SceneryIntroViewController.h"

@interface SceneryDetailInfoViewController ()

@property (weak, nonatomic) IBOutlet UITableView *m_tableView;

@end

@implementation SceneryDetailInfoViewController

@synthesize m_dic;

@synthesize m_info;

@synthesize m_noticeString;

@synthesize m_routeString;

@synthesize m_noticeWebView;

@synthesize m_routeWebView;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        m_dic = [[NSMutableDictionary alloc]initWithCapacity:0];
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"景点简介"];
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    self.m_tableView.hidden = YES;
    
    // 初始化webView
    UIWebView *webview = [[UIWebView alloc]initWithFrame:CGRectMake(20, 45, 280, 100)];
    webview.delegate = self;
    webview.tag = 100;
    self.m_noticeWebView = webview;
    
    // 初始化webView
    UIWebView *webview1 = [[UIWebView alloc]initWithFrame:CGRectMake(20, 45, 280, 100)];
    webview1.delegate = self;
    webview1.tag = 101;
    self.m_routeWebView = webview1;
    
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    // 根据值来判断是否要请求数据-用于区别从更多图文详情页面返回
    if ( self.self.m_info.length == 0 ) {
        
        // 请求数据
        [self sceneryRouteRequest];
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

#pragma mark - NetWork
- (void)sceneryDetailRequest{
    
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
                           @"2",@"mapbar",
                           
                           nil];
//    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    
    NSLog(@"parma = %@",param);
    
    [httpClient requestScenery:@"Scenery/GetSceneryDetail.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        // status 0表示有数据 其他表示错误
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        NSLog(@"json =%@",json);
        
        if ( success ) {
            
            [SVProgressHUD dismiss];
            
            self.m_tableView.hidden = NO;
            
            // 赋值
            self.m_info = [NSString stringWithFormat:@"%@",[json valueForKey:@"intro"]];
            self.m_noticeString = [NSString stringWithFormat:@"%@",[json valueForKey:@"buyNotice"]];
            
            NSString *string = [self htmlString:self.m_noticeString];
            
            // webView赋值
            [self.m_noticeWebView loadHTMLString:string baseURL:nil];
            
           
            
            
        } else {
            
            
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
        
        
    } failure:^(NSError *error) {
        
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}

#pragma mark - 公交了路线请求数据
- (void)sceneryRouteRequest{
    
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
                           nil];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    
    NSLog(@"parma = %@",param);
    
    [httpClient requestScenery:@"Scenery/GetSceneryTrafficInfo.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        // status 0表示有数据 其他表示错误
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        NSLog(@"json =%@",json);
        
        if ( success ) {
            
//            [SVProgressHUD dismiss];
           
            self.m_routeString = [NSString stringWithFormat:@"%@",[json valueForKey:@"traffic"]];
            
            NSLog(@"self.m_routeString  = %@",self.m_routeString);
            
            NSString *string1 = [self htmlString:self.m_routeString];
            
            // webView赋值
            [self.m_routeWebView loadHTMLString:string1 baseURL:nil];
            
            // 公交路线接口请求成功后调用详情的接口
            [self sceneryDetailRequest];
            
        } else {
            
            
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
        
        
    } failure:^(NSError *error) {
        
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  
    if ( section == 0 ) {
        
        return 2;
        
    }else{
        
        return 1;
    
    }
    
   
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = nil;
    
    if ( indexPath.section == 0 ) {
        
        if ( indexPath.row == 0 ) {
            
            cell = [self InfoTableView:tableView cellForRowAtIndexPath:indexPath];
            
            
        }else{
           
            cell = [self moreTableView:tableView cellForRowAtIndexPath:indexPath];
        }
   
    }else{
        
        cell = [self NoticeTableView:tableView cellForRowAtIndexPath:indexPath];
    
    }
    
    return cell;
    
}
#pragma mark - 详细简介的cell
- (UITableViewCell *)InfoTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"SceneryDetaiInfoCellIdentifier";
    
    SceneryDetaiInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"SceneryDetaiInfoCell" owner:self options:nil];
        
        cell = (SceneryDetaiInfoCell *)[nib objectAtIndex:0];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    // 赋值
    cell.m_name.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"sceneryName"]];
    cell.m_address.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"sceneryAddress"]];
    
    
    cell.m_info.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"scenerySummary"]];
    
    // 判断字符为空的情况
    if ( [cell.m_info.text isEqualToString:@"(null)"] ) {
        
        cell.m_info.text = @"暂无介绍";

    }
    
    cell.m_info.numberOfLines = 0;
    
    // 根据内容计算高度
    CGSize size = [cell.m_info.text sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(265, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    
    cell.m_info.frame = CGRectMake(cell.m_info.frame.origin.x, 68, 265, size.height);
    
    cell.m_lineImgV.frame = CGRectMake(cell.m_lineImgV.frame.origin.x, cell.m_info.frame.origin.y + cell.m_info.frame.size.height + 5, cell.m_lineImgV.frame.size.width, 1);
    
    cell.frame = CGRectMake(cell.frame.origin.x, cell.frame.origin.y, cell.frame.size.width, cell.m_lineImgV.frame.origin.y + cell.m_lineImgV.frame.size.height + 1);
    
    
    return cell;
    
}

#pragma mark - 更多图文详情的cell
- (UITableViewCell *)moreTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"CellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        cell = (UITableViewCell*)[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        // 添加分割线
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(0, 43, WindowSizeWidth, 1)];
        img.image = [UIImage imageNamed:@"line.png"];
        [cell addSubview:img];
        
        
    }
    
    // 赋值设置
    cell.textLabel.text = @"更多图文详情";
    
    cell.textLabel.font = [UIFont systemFontOfSize:16.0f];
    
    
    return cell;
    
}

#pragma mark - 购买须知和交通路线的cell
- (UITableViewCell *)NoticeTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"SceneryBuyNoticeCellIdentifier";
    
    SceneryBuyNoticeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"SceneryDetaiInfoCell" owner:self options:nil];
        
        cell = (SceneryBuyNoticeCell *)[nib objectAtIndex:1];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if ( indexPath.section == 1 ) {
        
        cell.m_tipLabel.text = @"交通路线";
        
        cell.m_webView.scrollView.scrollEnabled = NO;
        
        cell.m_notice.hidden = YES;
        
        cell.m_webView.hidden = NO;
        
        cell.m_lineImgV.hidden = YES;
        
        
//        cell.m_notice.hidden = NO;
//        
//        cell.m_webView.hidden = YES;
//        
//        cell.m_lineImgV.hidden = NO;
//        
//        cell.m_notice.numberOfLines = 0;
//        
//        cell.m_notice.backgroundColor = [UIColor clearColor];
//        
//        if ( self.m_routeString.length == 0 || [self.m_routeString isEqualToString:@"(null)"] ) {
//            
//            cell.m_notice.text = @"无";
//
//        }else{
//            
//            cell.m_notice.text = [NSString stringWithFormat:@"%@",self.m_routeString];
//
//        }
        
        
        // 根据内容计算高度
//        CGSize size = [cell.m_notice.text sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(300, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
//        
//        cell.m_notice.frame = CGRectMake(cell.m_notice.frame.origin.x, 25, 300, size.height);
//        
//        cell.m_lineImgV.frame = CGRectMake(cell.m_lineImgV.frame.origin.x, cell.m_notice.frame.origin.y + cell.m_notice.frame.size.height + 5 + 2, cell.m_lineImgV.frame.size.width, 1);
//        
//        cell.frame = CGRectMake(cell.frame.origin.x, cell.frame.origin.y, cell.frame.size.width, cell.m_lineImgV.frame.origin.y + cell.m_lineImgV.frame.size.height + 1);

        
        // 加载webView
        NSString *BookStr = [self htmlString:self.m_routeString];
        // webView赋值
        [cell.m_webView loadHTMLString:BookStr baseURL:nil];
        
        // 计算webView的高度
        cell.m_webView.frame = CGRectMake(cell.m_webView.frame.origin.x, cell.m_webView.frame.origin.y, cell.m_webView.frame.size.width, self.m_routeWebView.frame.size.height);
        
        cell.m_lineImgV.frame = CGRectMake(cell.m_lineImgV.frame.origin.x, cell.m_webView.frame.origin.y + cell.m_webView.frame.size.height + 5, cell.m_lineImgV.frame.size.width, 1);
        
        cell.frame = CGRectMake(cell.frame.origin.x, cell.frame.origin.y, cell.frame.size.width, cell.m_lineImgV.frame.origin.y + cell.m_lineImgV.frame.size.height + 1);
        
        
    }else{
        
        cell.m_tipLabel.text = @"购买须知";
        
//        cell.m_webView.userInteractionEnabled = NO;
        
        cell.m_webView.scrollView.scrollEnabled = NO;
        
        cell.m_notice.hidden = YES;
        
        cell.m_webView.hidden = NO;
        
        cell.m_lineImgV.hidden = YES;
        
        // 加载webView
        NSString *BookStr = [self htmlString:self.m_noticeString];
        // webView赋值
        [cell.m_webView loadHTMLString:BookStr baseURL:nil];
        
        // 计算webView的高度
        cell.m_webView.frame = CGRectMake(cell.m_webView.frame.origin.x, cell.m_webView.frame.origin.y, cell.m_webView.frame.size.width, self.m_noticeWebView.frame.size.height);
        
        cell.m_lineImgV.frame = CGRectMake(cell.m_lineImgV.frame.origin.x, cell.m_webView.frame.origin.y + cell.m_webView.frame.size.height + 5, cell.m_lineImgV.frame.size.width, 1);
        
        cell.frame = CGRectMake(cell.frame.origin.x, cell.frame.origin.y, cell.frame.size.width, cell.m_lineImgV.frame.origin.y + cell.m_lineImgV.frame.size.height + 1);
        
        
    }
    
    return cell;

}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ( indexPath.section == 0 ) {
        
        if ( indexPath.row == 0 ) {
            
            NSString *string = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"scenerySummary"]];
            
            if ( [string isEqualToString:@"(null)"] ) {
                
                string = @"暂无介绍";
                
            }
            
            // 根据内容计算高度
            CGSize size = [string sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(265, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
            
            return 70 + size.height + 6;
            
        }else{
            
            return 44.0f;
        }
    }else if ( indexPath.section == 1 ){
        
        // 根据内容计算高度-交通路线
        return 25 + self.m_routeWebView.frame.size.height + 6;

    }else{
        
        // 根据内容计算高度-购买须知
        return 25 + self.m_noticeWebView.frame.size.height + 6;

    }
    
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ( indexPath.section == 0 ) {
        
        if ( indexPath.row == 1 ) {
           // 进入更多图文详情的页面
            SceneryIntroViewController *VC = [[SceneryIntroViewController alloc]initWithNibName:@"SceneryIntroViewController" bundle:nil];
            VC.m_infoString = [NSString stringWithFormat:@"%@",self.m_info];
            [self.navigationController pushViewController:VC animated:YES];
            
            
        }
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if ( isIOS7 ) {
        
        return 0.001;
    }
    
    return 0;
    
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
                         "</html>",14.0,aString];
    
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

    if ( webView == self.m_noticeWebView || webView == self.m_routeWebView) {
        
        CGFloat high = 0.0;
        //UIWebView字体大小设为190
        //        NSString *jsString = [[NSString alloc] initWithFormat:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '%f%%'",190.0f];
        
        
        NSString *jsString = [[NSString alloc] initWithFormat:@"document.body.style.fontSize=%f;document.body.style.color=%@",16.0f,[UIColor blackColor]];
        
        [webView stringByEvaluatingJavaScriptFromString:jsString];
        
        
        //获取webView的自适应高度
        high = [webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight;"].floatValue;
        
        
        
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
