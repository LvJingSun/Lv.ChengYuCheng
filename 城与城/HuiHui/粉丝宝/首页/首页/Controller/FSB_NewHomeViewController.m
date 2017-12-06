//
//  FSB_NewHomeViewController.m
//  HuiHui
//
//  Created by mac on 2017/6/26.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "FSB_NewHomeViewController.h"
#import "LJConst.h"
#import "FSB_NavTitleView.h"
#import "FSB_DetailedViewController.h"

#import "F_H_CellModel.h"
#import "F_H_CellFrame.h"
#import "F_H_Cell.h"

#import "MerchantHomeViewController.h"
#import "FSB_GameBottomView.h"
#import "FSB_HomeImgScroll.h"

#import "FSB_CumulativeProfitViewController.h"
#import "XieYiViewController.h"
#import "TiXingView.h"
#import "GameGifAlertView.h"

#import "F_H_ScrollImgModel.h"
#import "GameWebViewController.h"

#import "ProductDetailViewController.h"
#import "WebViewController.h"
#import "CPSHH_TakeOrderViewController.h"

@interface FSB_NewHomeViewController () <UITableViewDelegate,UITableViewDataSource,HomeScrollViewDelegate,GifViewDelegate> {

    NSString *isTongYi;
    
    int CountDown;
    
    NSString *PingUrl;
    
    NSString *QiEUrl;
    
}

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, strong) NSArray *array;

@property (nonatomic, strong) GameGifAlertView *gameAlertView;

@property (nonatomic, strong) NSArray *scrollArr;

@property (nonatomic, strong) UIView *gameBGView;

@end

@implementation FSB_NewHomeViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self allocWithFSB_NavTitleView];
    
    [self allocWithRightBtn];
    
    [self allocWithTableview];
    
    [self checkAccount];
    
    // app从后台进入前台都会调用这个方法
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationBecomeActive) name:UIApplicationWillEnterForegroundNotification object:nil];

    [self reuqestForZuiJinClick];
    
}

- (void)reuqestForZuiJinClick {
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         [CommonUtil getValueByKey:MEMBER_ID],@"MemberID",
                         @"12",@"Type",
                         nil];
    
    AppHttpClient *http = [AppHttpClient sharedClient];
    
    [http request:@"ClickIconRecord.ashx" parameters:dic success:^(NSJSONSerialization *json) {
        
    } failure:^(NSError *error) {
        
    }];
    
}

//如果游戏悬浮框未消失，执行动画
- (void)applicationBecomeActive {
    
    if (self.gameAlertView) {
        
        [self.gameAlertView startGif];
        
    }
    
}

//显示游戏悬浮框
- (void)ShowGameIcon {
    
    UIView *bgview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _WindowViewWidth, _WindowViewHeight)];
    
    self.gameBGView = bgview;
    
    bgview.backgroundColor = [UIColor colorWithRed:0/255. green:0/255. blue:0/255. alpha:0.6];
    
    [[[UIApplication sharedApplication] keyWindow] addSubview:bgview];
    
    NSString *game = [CommonUtil getValueByKey:GameAlert];
    
    NSURL *url;
    
    if ([game isEqualToString:@"拼手气"]) {
        
        url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"regpage(1).gif" ofType:nil]];
        
    }else if ([game isEqualToString:@"打企鹅"]) {
        
        url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"bear.gif" ofType:nil]];
        
    }
    
    self.gameAlertView = [[GameGifAlertView alloc] initWithCenter:CGPointMake(_WindowViewWidth * 0.5, _WindowViewHeight * 0.5) fileURL:url];
    
    self.gameAlertView.frame = CGRectMake(_WindowViewWidth * 0.3, 200, _WindowViewWidth * 0.4, _WindowViewWidth * 0.4 * 1.5);
    
    self.gameAlertView.delegate = self;
    
    [self.gameAlertView startGif];
    
    [[[UIApplication sharedApplication] keyWindow] addSubview:self.gameAlertView];
    
}

//游戏悬浮框点击代理
- (void)GifViewClick {
    
    GameWebViewController *vc = [[GameWebViewController alloc] init];
    
    vc.loadStr = [NSString stringWithFormat:@"%@?memberId=%@",[CommonUtil getValueByKey:GameLink],[CommonUtil getValueByKey:MEMBER_ID]];
    
    [self.navigationController pushViewController:vc animated:YES];
   
    [self.gameAlertView stopGif];

    [self.gameAlertView removeFromSuperview];
    
    [self.gameBGView removeFromSuperview];
    
}

- (void)checkAccount {

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    isTongYi = [defaults objectForKey:@"FSB_YanZheng"];
    
    NSString *fensibaoExtension = [defaults objectForKey:@"fensibao_extension"];
    
    if ([isTongYi isEqualToString:@"0"]) {
        
        TiXingView *tixingview = [[TiXingView alloc] initWithFrame:CGRectMake(0, 0, _WindowViewWidth, _WindowViewHeight)];
        
        tixingview.iconImg.image = [UIImage imageNamed:@"QFFImage.png"];
        
        [tixingview.sureBtn addTarget:self action:@selector(tongyiRequest) forControlEvents:UIControlEventTouchUpInside];
        
        [tixingview.backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        fensibaoExtension = [fensibaoExtension stringByReplacingOccurrencesOfString:@"/n" withString:@"\n"];
        
        tixingview.textview.text = [NSString stringWithFormat:@"%@",fensibaoExtension];
        
        [[[UIApplication sharedApplication].windows firstObject] addSubview:tixingview];
        
    }else {
        
        [self MoveData];
        
        [self requestForScrollData];
        
    }
    
}

- (void)requestForScrollData {

    AppHttpClient *httpClient = [AppHttpClient sharedClient];
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           @"1",@"Type",
                           [CommonUtil getValueByKey:CITYID],@"CityID",
                           [CommonUtil getValueByKey:MEMBER_ID],@"Memberid",
                           nil];
    
    [httpClient request:@"ShufflingAdvertiseList.ashx" parameters:param success:^(NSJSONSerialization *json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            NSArray *arr = [json valueForKey:@"listShuffAdver"];
            
            CountDown = [[json valueForKey:@"ShuffTime"] intValue];
            
            NSMutableArray *tempArray = [NSMutableArray array];
            
            for (NSDictionary *dd in arr) {
                
                F_H_ScrollImgModel *model = [[F_H_ScrollImgModel alloc] init];
                
                model.ID = [NSString stringWithFormat:@"%@",dd[@"ID"]];
                
                model.Title = [NSString stringWithFormat:@"%@",dd[@"Title"]];
                
                model.PhotoUrl = [NSString stringWithFormat:@"%@",dd[@"PhotoUrl"]];
                
                model.LinkUrl = [NSString stringWithFormat:@"%@",dd[@"LinkUrl"]];
                
                model.ShufflingTime = [NSString stringWithFormat:@"%@",dd[@"ShufflingTime"]];
                
                [tempArray addObject:model];
                
            }
            
            self.scrollArr = tempArray;
            
            if (arr.count != 0) {
                
                [self allocWithImgScroll];
                
            }
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showErrorWithStatus:msg];
            
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}

//数据迁移
- (void)MoveData {

    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    
    AppHttpClient* httpClient = [AppHttpClient sharedExtension];
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"Memberid",
                           nil];
    
    [SVProgressHUD showWithStatus:@"数据检测中,请稍后。。"];
    
    [httpClient ExtensionRequest:@"DataDigration.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            
            [SVProgressHUD dismiss];
            
            [self requestForListData];
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showErrorWithStatus:msg];
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }];
    
}

- (void)backBtnClick {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

//签订粉丝宝协议
- (void)tongyiRequest {
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    
    AppHttpClient* httpClient = [AppHttpClient sharedExtension];
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"Memberid",
                           @"3",@"type",
                           @"1",@"IsAgree",
                           nil];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient ExtensionRequest:@"FistAgreement.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            
            [SVProgressHUD showSuccessWithStatus:@"欢迎加入全返付"];
            
            [self yyanZheng];
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showErrorWithStatus:msg];
            
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}

//确认同意后再次验证
- (void)yyanZheng {
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    
    AppHttpClient* httpClient = [AppHttpClient sharedExtension];
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"Memberid",
                           @"3",@"type",
                           @"0",@"IsAgree",
                           nil];
    
    [httpClient ExtensionRequest:@"FistAgreement.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            
            [defaults setObject:@"1" forKey:@"FSB_YanZheng"];
            
            [self requestForScrollData];
            
        } else {
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            
            [defaults setObject:@"0" forKey:@"FSB_YanZheng"];
            
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}

//显示图片轮播广告
- (void)allocWithImgScroll {

    FSB_HomeImgScroll *scroll = [[FSB_HomeImgScroll alloc] init];
    
    scroll.delegate = self;
    
    scroll.sourceArray = self.scrollArr;
    
    scroll.countDown = CountDown;
    
//    scroll.dismissBlock = ^{
//        
//        [self ShowGameIcon];
//        
//    };
    
    [scroll showInView:[UIApplication sharedApplication].keyWindow];
    
}

//首页轮播代理
- (void)HomeScrollDidSelected:(NSInteger)index {

    NSLog(@"点击了第%ld张图",(long)index);
    
}

- (void)allocWithTableview {
    
    FSB_GameBottomView *bottomview = [[FSB_GameBottomView alloc] init];
    
    bottomview.frame = CGRectMake(0, _WindowViewHeight - bottomview.height - 64, _WindowViewWidth, bottomview.height);
    
    [bottomview.game1Btn setImage:[UIImage imageNamed:@"拼手气.png"] forState:0];
    
    [bottomview.game2Btn setImage:[UIImage imageNamed:@"企鹅.png"] forState:0];
    
    bottomview.game1NameLab.text = @"拼手气";
    
    bottomview.game2NameLab.text = @"打企鹅";
    
    bottomview.game1Block = ^{
        
        //进入拼手气游戏
        GameWebViewController *vc = [[GameWebViewController alloc] init];
        
        vc.loadStr = PingUrl;
        
        [self.navigationController pushViewController:vc animated:YES];
        
    };
    
    bottomview.game2Block = ^{
        
        //进入打企鹅游戏
        GameWebViewController *vc = [[GameWebViewController alloc] init];
        
        vc.loadStr = QiEUrl;
        
        [self.navigationController pushViewController:vc animated:YES];
        
    };
    
    [self.view addSubview:bottomview];

    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, _WindowViewWidth, _WindowViewHeight - 64 - bottomview.height)];
    
    self.tableview = tableview;
    
    tableview.delegate = self;
    
    tableview.dataSource = self;
    
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    tableview.backgroundColor = FSB_ViewBGCOLOR;
    
    [self.view addSubview:tableview];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.array.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    F_H_Cell *cell = [[F_H_Cell alloc] init];
    
    F_H_CellFrame *frame = self.array[indexPath.row];
    
    cell.frameModel = frame;
    
    cell.getMoneyBlock = ^{
        
        [self requestForGetMoneyWithMemberID:[CommonUtil getValueByKey:MEMBER_ID] ShopID:frame.cellModel.ShopID Count:frame.cellModel.Count];
        
    };
    
    cell.adImgBlock = ^{
        
        [self readForUrl:frame.cellModel];
        
    };
    
    cell.shopIconBlock = ^{
        
        //点击头像进入商户详情页
        MerchantHomeViewController *vc = [[MerchantHomeViewController alloc] init];
        
        vc.merchantID = frame.cellModel.ShopID;
        
        vc.merchantName = frame.cellModel.ShopName;
        
        [self.navigationController pushViewController:vc animated:YES];
        
    };
    
    return cell;
    
}

- (void)readForUrl:(F_H_CellModel *)model {

    NSDictionary *Prodic = [self dictionaryFromQuery:[[NSURL URLWithString:model.UrlType] query] usingEncoding:NSUTF8StringEncoding];
    
    if ([[NSString stringWithFormat:@"%@",[Prodic objectForKey:@"cityandcitytype"]] isEqualToString:@"3"]) {
        // 点击进入商品详情
        ProductDetailViewController *VC = [[ProductDetailViewController alloc]initWithNibName:@"ProductDetailViewController" bundle:nil];

        VC.m_productId = [NSString stringWithFormat:@"%@",[Prodic objectForKey:@"serviceId"]];
        VC.m_merchantShopId = [NSString stringWithFormat:@"%@",[Prodic objectForKey:@"merchantShopId"]];

        [self.navigationController pushViewController:VC animated:YES];

    }else if ([[NSString stringWithFormat:@"%@",[Prodic objectForKey:@"cityandcitytype"]] isEqualToString:@"4"])
    {

        // 进入webView页面
        WebViewController *VC = [[WebViewController alloc]initWithNibName:@"WebViewController" bundle:nil];

        NSArray *array = [[NSString stringWithFormat:@"%@",model.UrlType] componentsSeparatedByString:@"?"];

        NSString *urlstr = [NSString stringWithFormat:@"%@",array[0]];

        if ([[urlstr substringToIndex:3] isEqualToString:@"www"] || [[urlstr substringToIndex:3] isEqualToString:@"WWW"]) {

            urlstr = [NSString stringWithFormat:@"http://%@",urlstr];

        }

        VC.m_scanString = urlstr;
        VC.m_typeString = @"2";

        [self.navigationController pushViewController:VC animated:YES];

    }else if ([[NSString stringWithFormat:@"%@",[Prodic objectForKey:@"cityandcitytype"]] isEqualToString:@"5"])
    {

        // 跳转到菜单列表的页面

//        [CommonUtil addValue:[dic objectForKey:@"Logo"] andKey:@"MarchantImageKey"];
//        [CommonUtil addValue:[dic objectForKey:@"YHDescription"] andKey:YHDESCRIPTION];
//        [CommonUtil addValue:[dic objectForKey:@"Man"] andKey:MANKEY];
//        [CommonUtil addValue:[dic objectForKey:@"Jian"] andKey:JIANKEY];
//
        CPSHH_TakeOrderViewController *VCC = [[CPSHH_TakeOrderViewController alloc]init];
//        [VCC.m_dic setObject:[dic objectForKey:@"ShopList"] forKey:@"m_shopList"];
//        [VCC.m_dic setObject:[NSString stringWithFormat:@"%@",[dic objectForKey:@"IsSelectSeat"]] forKey:@"m_seat"];
//        [VCC.m_dic setObject:[NSString stringWithFormat:@"%@",[dic objectForKey:@"ModelType"]] forKey:@"m_ModelType"];
        [VCC.m_dic setObject:[NSString stringWithFormat:@"%@",model.ShopID] forKey:@"m_merchantId"];
        
//        [VCC.m_dic setObject:[NSString stringWithFormat:@"%@",[dic objectForKey:@"IsZCWaiMai"]] forKey:@"IsZCWaiMai"];
        [self.navigationController pushViewController:VCC animated:YES];
        
    }
    
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

- (void)requestForGetMoneyWithMemberID:(NSString *)memberid ShopID:(NSString *)shopid Count:(NSString *)count {

    AppHttpClient *httpClient = [AppHttpClient sharedClient];
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberid,@"Memberid",
                           shopid,@"MerchantID",
                           count,@"AccountTotal",
                           nil];
    
    [SVProgressHUD show];
    
    [httpClient request:@"FansGetMoney_2.ashx" parameters:param success:^(NSJSONSerialization *json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            [SVProgressHUD dismiss];
            
            NSString *type = [NSString stringWithFormat:@"%@",[json valueForKey:@"cantogame"]];
            
            if ([type isEqualToString:@"1"]) {
                
                //已领完全部红包，弹出游戏图标
                [self ShowGameIcon];
                
            }
            
            [self requestForListData];
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showErrorWithStatus:msg];
            
        }

        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    F_H_CellFrame *frame = self.array[indexPath.row];
    
    return frame.height;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (void)requestForListData {

    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    
    AppHttpClient *httpClient = [AppHttpClient sharedClient];
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"Memberid",
                           nil];
    
    [httpClient request:@"FansGetMerchantList_3.ashx" parameters:param success:^(NSJSONSerialization *json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            NSArray *arr = [json valueForKey:@"ybtrList"];
            
            PingUrl = [NSString stringWithFormat:@"%@?memberId=%@",[json valueForKey:@"dazhuanpan"],memberId];
            
            QiEUrl = [NSString stringWithFormat:@"%@?memberId=%@",[json valueForKey:@"daqie"],memberId];
            
            NSMutableArray *tempArray = [NSMutableArray array];
            
            for (NSDictionary *dd in arr) {
                
                F_H_CellModel *model = [[F_H_CellModel alloc] init];
                
                model.ShopName = [NSString stringWithFormat:@"%@",dd[@"MerchantName"]];
                
                model.ShopID = [NSString stringWithFormat:@"%@",dd[@"MerchantID"]];
                
                model.ShopImg = [NSString stringWithFormat:@"%@",dd[@"Logo"]];
                
                model.Count = [NSString stringWithFormat:@"%@",dd[@"AccountTotal"]];
                
                model.UrlType = [NSString stringWithFormat:@"%@",dd[@"AdAdress"]];
                
                model.Type = [NSString stringWithFormat:@"%@",dd[@"Canget"]];
                
                model.ShopADImg = [NSString stringWithFormat:@"%@",dd[@"Adpublic"]];
                
                model.Desc = [NSString stringWithFormat:@"%@",dd[@"Remark"]];
                
                model.MerchantShopID = [NSString stringWithFormat:@"%@",dd[@"MerchantShopID"]];
                
                model.MerchantShopName = [NSString stringWithFormat:@"%@",dd[@"MerchantShopName"]];
                
                model.Title = [NSString stringWithFormat:@"%@",dd[@"Title"]];
                
                model.ztinfo = [NSString stringWithFormat:@"%@",dd[@"ztinfo"]];
                
                F_H_CellFrame *frame = [[F_H_CellFrame alloc] init];
                
                frame.cellModel = model;
                
                [tempArray addObject:frame];
                
            }

            self.array = tempArray;
            
            [self.tableview reloadData];
        
        } else {
            
            PingUrl = [NSString stringWithFormat:@"%@?memberId=%@",[json valueForKey:@"dazhuanpan"],memberId];
            
            QiEUrl = [NSString stringWithFormat:@"%@?memberId=%@",[json valueForKey:@"daqie"],memberId];
            
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showErrorWithStatus:msg];
        
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}

//初始化titleview
- (void)allocWithFSB_NavTitleView {
    
    FSB_NavTitleView *titleview = [[FSB_NavTitleView alloc] initWithFrame:CGRectMake(0, 0, _WindowViewWidth * 0.6, 30)];
    
    titleview.titleBlock = ^{
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        NSString *fensibaoExtension = [defaults objectForKey:@"fensibao_extension"];
        
        fensibaoExtension = [fensibaoExtension stringByReplacingOccurrencesOfString:@"/n" withString:@"\n"];
        
        XieYiViewController *vc = [[XieYiViewController alloc] init];
        
        vc.xieyiString = fensibaoExtension;
        
        [self.navigationController pushViewController:vc animated:YES];
        
    };
        
    self.navigationItem.titleView = titleview;
    
}

//初始化右上角的按钮
- (void)allocWithRightBtn {
    
    self.navigationItem.rightBarButtonItem = [self SetNavigationBarRightTitle:@"记录" andaction:@selector(MingXiClicked)];
    
}

//右上角按钮点击事件
- (void)MingXiClicked {
    
//    FSB_DetailedViewController *vc = [[FSB_DetailedViewController alloc] init];
    
    FSB_CumulativeProfitViewController *vc = [[FSB_CumulativeProfitViewController alloc] init];
    
    vc.type = @"home";
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];

}

@end
