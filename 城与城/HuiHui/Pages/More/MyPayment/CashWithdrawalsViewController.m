//
//  CashWithdrawalsViewController.m
//  baozhifu
//
//  Created by mac on 13-11-5.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "CashWithdrawalsViewController.h"

#import "CashDrawalsCell.h"

#import "AppHttpClient.h"

#import "SVProgressHUD.h"

#import "CommonUtil.h"

#import "TakeMoneyViewController.h"

#import "CashDetailViewController.h"

#import "RealAccountResultViewController.h"

#import "RealAccountViewController.h"

#import "ADView.h"

#import "ProductDetailViewController.h"
#import "WebViewController.h"
#import "CPSHH_TakeOrderViewController.h"
#import "OfficeLJViewController.h"
#import "NewYearADView.h"
#import "TiXianTotalView.h"

// 屏幕宽度
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)

// 屏幕高度
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface CashWithdrawalsViewController () <UIAlertViewDelegate> {
    
    NSString *IsExit;
    
    NSString *officeAd;
    
    NSDictionary *officeADdic;
    
    NSString *xianshiAD;
    
    NSString *isNewYear;
    
    NSString *newYearAD;
    
    NSString *notice;
    
    //限额状态
    NSString *xianeStatus;
    
    //限额描述
    NSString *xianeDesc;
    
}

@property (weak, nonatomic) IBOutlet UIView *m_titleView;

@property (weak, nonatomic) IBOutlet PullTableView *m_tableView;

@property (weak, nonatomic) IBOutlet UILabel *m_emptyLabel;

@property (nonatomic, strong) ADView *OfficeADView;

@property (nonatomic, weak) UIImageView *OfficeADImageview;

@property (nonatomic, weak) UILabel *allCountLab;

// 提现按钮触发的事件
- (IBAction)crashWithDrawal:(id)sender;

@end

@implementation CashWithdrawalsViewController

@synthesize m_recordsArr;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        pageIndex = 1;
        
        m_recordsArr = [[NSMutableArray alloc]initWithCapacity:0];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"提现记录"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    [self setRightButtonWithTitle:@"提现" action:@selector(tixianBtnClicked)];
    
    TiXianTotalView *headview = [[TiXianTotalView alloc] init];
    
    headview.frame = CGRectMake(0, 0, WindowSizeWidth, headview.height);
    
    self.allCountLab = headview.countLab;
    
    self.m_tableView.tableHeaderView = headview;
    
    [self.m_tableView setDelegate:self];
    [self.m_tableView setDataSource:self];
    [self.m_tableView setPullDelegate:self];
    self.m_tableView.pullBackgroundColor = [UIColor whiteColor];
    self.m_tableView.useRefreshView = YES;
    self.m_tableView.useLoadingMoreView= YES;
    
    // 隐藏
    self.m_emptyLabel.hidden = YES;
    
    self.m_tableView.hidden = YES;
    
    [self requestOffice];
    
    [self requestNewYearAD];
    
    [self requestForTiXian];
    
}

//判断是否限额提现
- (void)requestForTiXian {
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         [CommonUtil getValueByKey:MEMBER_ID],@"MemberID", nil];
    
    [httpClient request:@"CashWithdrawalState.ashx" parameters:dic success:^(NSJSONSerialization* json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            xianeStatus = [NSString stringWithFormat:@"%@",[json valueForKey:@"StateID"]];
            
            xianeDesc = [NSString stringWithFormat:@"%@",[json valueForKey:@"Descs"]];
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showErrorWithStatus:msg];
            
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
    
}

//获取新年广告
- (void)requestNewYearAD {

    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    
    [httpClient request:@"NewYearAD.ashx" parameters:[NSDictionary dictionary] success:^(NSJSONSerialization* json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            NSArray *arr = [json valueForKey:@"NewYearADList"];
            
            NSDictionary *dic = arr[0];
            
            newYearAD = dic[@"PhotoUrl"];
            
            isNewYear = dic[@"IsPublic"];
            
            notice = dic[@"desc"];
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showErrorWithStatus:msg];
            
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];

    
}

- (void)requestOffice {
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           [CommonUtil getValueByKey:CITYID],@"cityId",
                           nil];
    
    [httpClient request:@"AdOffList.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            IsExit = [json valueForKey:@"IsExit"];
            
            NSDictionary *dic = [json valueForKey:@"MctIndex"];
            
            officeADdic = dic;
            
            NSArray *array = dic[@"AdgldAdList"];
            
            NSDictionary *dd = array[0];
            
            officeAd = dd[@"AdImg"];
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showErrorWithStatus:msg];
            
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}

- (void)getOfficeAdImageview {
    
    ADView *adview = [[ADView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    
    self.OfficeADView = adview;
    
    self.OfficeADImageview = adview.adimageview;
    
    [self.OfficeADImageview setImageWithURL:[NSURL URLWithString:officeAd]];
    
        [adview.noButton addTarget:self action:@selector(adviewdismiss) forControlEvents:UIControlEventTouchUpInside];
    
    if ([IsExit isEqualToString:@"1"]) {
        
        [adview.clickBtn addTarget:self action:@selector(officeAdClick) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    [[[UIApplication sharedApplication].windows firstObject] addSubview:adview];
    
}

- (void)adviewdismiss {

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:@"buxianshi" forKey:@"ljxianshiAD"];
    
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

- (void)officeAdClick {
    
    [self.OfficeADView removeFromSuperview];
    
    NSArray *array = officeADdic[@"AdgldAdList"];
    
    NSDictionary *dic = array[0];
    
    NSDictionary * Prodic = [self dictionaryFromQuery:[[NSURL URLWithString:[dic objectForKey:@"AdUrl"]] query] usingEncoding:NSUTF8StringEncoding];
    
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
        
        VC.m_scanString = [NSString stringWithFormat:@"%@",[dic objectForKey:@"AdUrl"]];
        VC.m_typeString = @"2";
        
        [self.navigationController pushViewController:VC animated:YES];
        
    }else if ([[NSString stringWithFormat:@"%@",[Prodic objectForKey:@"cityandcitytype"]] isEqualToString:@"5"])
    {
        
        // 跳转到菜单列表的页面
        
        [CommonUtil addValue:[dic objectForKey:@"Logo"] andKey:@"MarchantImageKey"];
        [CommonUtil addValue:[dic objectForKey:@"YHDescription"] andKey:YHDESCRIPTION];
        [CommonUtil addValue:[dic objectForKey:@"Man"] andKey:MANKEY];
        [CommonUtil addValue:[dic objectForKey:@"Jian"] andKey:JIANKEY];
        
        CPSHH_TakeOrderViewController *VCC = [[CPSHH_TakeOrderViewController alloc]init];
        [VCC.m_dic setObject:[dic objectForKey:@"ShopList"] forKey:@"m_shopList"];
        [VCC.m_dic setObject:[NSString stringWithFormat:@"%@",[dic objectForKey:@"IsSelectSeat"]] forKey:@"m_seat"];
        [VCC.m_dic setObject:[NSString stringWithFormat:@"%@",[dic objectForKey:@"ModelType"]] forKey:@"m_ModelType"];
        [VCC.m_dic setObject:[NSString stringWithFormat:@"%@",[dic objectForKey:@"MerchantID"]] forKey:@"m_merchantId"];
        [VCC.m_dic setObject:[NSString stringWithFormat:@"%@",[dic objectForKey:@"IsZCWaiMai"]] forKey:@"IsZCWaiMai"];
        [self.navigationController pushViewController:VCC animated:YES];
        
        
        
    }else if ([[NSString stringWithFormat:@"%@",[Prodic objectForKey:@"cityandcitytype"]] isEqualToString:@"6"])
    {
        
        
        [self pushOfficeViewWithTitle:[dic objectForKey:@"AdTitle"] withContent:[dic objectForKey:@"AdRemark"]];
        
        
    }
    
}

//进入官方简介
- (void)pushOfficeViewWithTitle:(NSString *)title withContent:(NSString *)content {
    
    OfficeLJViewController *vc = [[OfficeLJViewController alloc] init];
    
    vc.titletext = title;
    
    vc.contenttext = content;
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self request];
    
    [self hideTabBar:YES];

    pageIndex = 1;
    
    // 请求数据 ========
    [self loadData];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    xianshiAD = [defaults objectForKey:@"ljxianshiAD"];
    
    if ([xianshiAD isEqualToString:@"xianshi"]) {
        
        [self getOfficeAdImageview];
        
    }
    
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

- (void)viewDidUnload {
    [self setM_titleView:nil];
    [self setM_tableView:nil];
    [self setM_emptyLabel:nil];
    [super viewDidUnload];
}

- (void)request {

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
                           nil];
    
    [httpClient request:@"More.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            NSDictionary *appMore = [json valueForKey:@"appMore"];
            
            //充值
            NSString *vldStatus = [appMore objectForKey:@"realAuStatus"];
            
            // 保存用户的状态
            [CommonUtil addValue:vldStatus andKey:REALAUSTATUS];
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showErrorWithStatus:msg];
            
        }
    } failure:^(NSError *error) {
        
    }];

    
}

- (void)leftClicked{
    
    [self goBack];
}

- (void)tixianBtnClicked{
    
    if ([isNewYear boolValue]) {
        
        NewYearADView *adview = [[NewYearADView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        
        [adview.adimageview setImageWithURL:[NSURL URLWithString:newYearAD]];
        
        adview.noticeLab.text = notice;
        
        [[[UIApplication sharedApplication].windows firstObject] addSubview:adview];
        
    }else {
        
            // 根据用户的身份验证的状态来判断进入哪个页面
            
            // 进入我的银行卡的页面
            NSString *string = [CommonUtil getValueByKey:REALAUSTATUS];
            
            if ([string isEqualToString:@"Valid"]) {
                
                if ([xianeStatus isEqualToString:@"1"]) {
                    
                    //暂停提现
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:xianeDesc delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    
                    [alert show];
                    
                }else if ([xianeStatus isEqualToString:@"2"]) {
                    
                    //提现限额
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"经过系统评估，您的账号每日提现额度仅限%.2f元，未提现余额可以用于城与城即将推出的官方商城、游戏业务等消费。如有疑问，请详询城与城当地合作商",[xianeDesc floatValue]] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                    
                    alert.tag = 10001;
                    
                    [alert show];
                    
                }else {

                    //正常用户
                    // 进入提现的界面
                    TakeMoneyViewController *VC = [[TakeMoneyViewController alloc]initWithNibName:@"TakeMoneyViewController" bundle:nil];
                    VC.m_inString = self.m_IncomeString;
                    [self.navigationController pushViewController:VC animated:YES];
                    
                }
                
            } else if ([string isEqualToString:@"NotCertified"]) {
                
                // 未认证 进入实名认证页面
                RealAccountViewController *viewController = [[RealAccountViewController alloc] initWithNibName:@"RealAccountViewController" bundle:nil];
                [self.navigationController pushViewController:viewController animated:YES];
                
            } else {
                
                // 其他的进入认证结果页面
                RealAccountResultViewController *viewController = [[RealAccountResultViewController alloc] initWithNibName:@"RealAccountResultViewController" bundle:nil];
                //viewController.message = [self.appMore objectForKey:@"realAuReason"];
                //viewController.status = vldStatus;
                [self.navigationController pushViewController:viewController animated:YES];
                
            }

    }

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {

    if (alertView.tag == 10001) {
        
        switch (buttonIndex) {
            case 1:
            {
            
                // 进入提现的界面
                TakeMoneyViewController *VC = [[TakeMoneyViewController alloc]initWithNibName:@"TakeMoneyViewController" bundle:nil];
                VC.m_inString = self.m_IncomeString;
                
                VC.xianeStatus = xianeStatus;
                
                VC.xianeCount = xianeDesc;
                
                [self.navigationController pushViewController:VC animated:YES];
                
            }
                break;
                
            default:
                break;
        }
        
    }
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.m_recordsArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"CashDrawalsCellIdentifier";
    
    CashDrawalsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"CashDrawalsCell" owner:self options:nil];
        
        cell = (CashDrawalsCell *)[nib objectAtIndex:0];
        
        // 设置cell的点击选择状态
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
        // 添加分割线
        UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 69, WindowSizeWidth, 1)];
        
        imgV.backgroundColor = [UIColor colorWithRed:221/255.0 green:221/255.0 blue:221/255.0 alpha:0.5];
        
        [cell addSubview:imgV];
    }
    
    // 赋值
    if ( self.m_recordsArr.count != 0 ) {
        
        NSDictionary *item = [self.m_recordsArr objectAtIndex:indexPath.row];
        
        cell.m_priceLabel.text = [NSString stringWithFormat:@"-%.2f",[[item objectForKey:@"Amount"] floatValue]];
        
        NSString *str = [NSString stringWithFormat:@"%@",[item objectForKey:@"Balance"]];
        
        if ([str isEqualToString:@""] || [str isEqualToString:@"(null)"]) {

        }else {
        
            cell.m_timeLabel.text = [NSString stringWithFormat:@"余额：%@",str];
            
        }
        
//        cell.m_timeLabel.text = [NSString stringWithFormat:@"余额：%@",[item objectForKey:@"Balance"]];
        
        cell.m_bankLabel.text = [NSString stringWithFormat:@"%@",[item objectForKey:@"BankName"]];
        
        cell.m_accountLabel.text = [NSString stringWithFormat:@"%@",[item objectForKey:@"CreateDate"]];
        
        // 根据状态来判断如何显示
        if ( [[item objectForKey:@"Status"] isEqualToString:@"HasCompleted"] ) {
            
            cell.m_statusLabel.text = [NSString stringWithFormat:@"（已完成）"];
            
            cell.m_statusLabel.textColor = [UIColor colorWithRed:51/255.0 green:152/255.0 blue:24/255.0 alpha:1.0];
       
        }else if ( [[item objectForKey:@"Status"] isEqualToString:@"Pending"] ){
            
            cell.m_statusLabel.text = [NSString stringWithFormat:@"（处理中）"];
          
            cell.m_statusLabel.textColor = [UIColor colorWithRed:252/255.0 green:14/255.0 blue:44/255.0 alpha:1.0];
        
        }else if ( [[item objectForKey:@"Status"] isEqualToString:@"HasRefused"] ){
            
            cell.m_statusLabel.text = [NSString stringWithFormat:@"（失败）"];
            
            cell.m_statusLabel.textColor = [UIColor colorWithRed:252/255.0 green:14/255.0 blue:44/255.0 alpha:1.0];
            
        }else{
            
            cell.m_statusLabel.text = [NSString stringWithFormat:@"（处理中）"];
            
            cell.m_statusLabel.textColor = [UIColor colorWithRed:252/255.0 green:14/255.0 blue:44/255.0 alpha:1.0];
        }
        
        // 计算label的坐标
        CGSize size = [cell.m_priceLabel.text sizeWithFont:[UIFont systemFontOfSize:20.0f] constrainedToSize:CGSizeMake(MAXFLOAT, 29) lineBreakMode:NSLineBreakByWordWrapping];
        
        cell.m_priceLabel.frame = CGRectMake(15, 11, size.width, 29);
        
        cell.m_statusLabel.frame = CGRectMake(cell.m_priceLabel.frame.origin.x + size.width, 15, 79, 21);
                
    }

    return cell;
    
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 70.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
        
    NSMutableDictionary *item = [self.m_recordsArr objectAtIndex:indexPath.row];

    // 进入提现详情
    CashDetailViewController *VC = [[CashDetailViewController alloc]initWithNibName:@"CashDetailViewController" bundle:nil];
    VC.m_items = item;
    [self.navigationController pushViewController:VC animated:YES];
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}


#pragma mark - PullTableViewDelegate
- (void)pullTableViewDidTriggerRefresh:(PullTableView*)pullTableView {
    pageIndex = 1;
    
    [self loadData];
}

- (void)pullTableViewDidTriggerLoadMore:(PullTableView*)pullTableView {
    pageIndex++;
    
    [self performSelector:@selector(loadData) withObject:nil];
}

- (void)loadData {
    
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
                           [NSString stringWithFormat:@"%ld", (long)pageIndex],@"pageIndex",
                           nil];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"MemberWithdrawalsRecord_1.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            [SVProgressHUD dismiss];
            NSMutableArray *resultList = [json valueForKey:@"WithdrawalsRecord"];
            
            self.m_IncomeString = [json valueForKey:@"Income"];
            
            self.allCountLab.text = [NSString stringWithFormat:@"%@ 元",[json valueForKey:@"Total"]];
            
            if (pageIndex == 1) {
                if (resultList == nil || resultList.count == 0) {
                    [self.m_recordsArr removeAllObjects];
                    self.m_tableView.hidden = YES;
                    
                    self.m_emptyLabel.hidden = NO;
                    
                    self.m_emptyLabel.text = @"暂时没有提现记录！";

                    return;
                    
                } else {
                    
                    [self.m_recordsArr removeAllObjects];

                    self.m_recordsArr = resultList;
                    
                    self.m_emptyLabel.hidden = YES;
                    
                    self.m_tableView.hidden = NO;
                    
                }
            } else {
                
                self.m_tableView.hidden = NO;
                
                if (resultList == nil || resultList.count == 0) {
                    
                    pageIndex--;
                    
                } else {
                    
                    [self.m_recordsArr addObjectsFromArray:resultList];
                }
            }
            [self.m_tableView reloadData];
        } else {
            if (pageIndex > 1) {
                pageIndex--;
            }
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
        self.m_tableView.pullTableIsRefreshing = NO;
        self.m_tableView.pullTableIsLoadingMore = NO;
    
    } failure:^(NSError *error) {
        if (pageIndex > 1) {
            pageIndex--;
        }
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
        self.m_tableView.pullTableIsRefreshing = NO;
        self.m_tableView.pullTableIsLoadingMore = NO;
    }];
}


@end
