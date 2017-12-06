//
//  SaleProductListViewController.m
//  HuiHui
//
//  Created by mac on 14-2-11.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "SaleProductListViewController.h"

#import "SaleProductListCell.h"

#import "CommonUtil.h"

#import "SVProgressHUD.h"

#import "AppHttpClient.h"

#import "SaleProductDetailViewController.h"

#import "SubmitOrderViewController.h"

#import "TokenViewController.h"

#import "PanicBuyingViewController.h"

#import "PaymentQueViewController.h"

#import "PayStyleViewController.h"


@interface SaleProductListViewController ()

@property (weak, nonatomic) IBOutlet UITableView *m_tableView;

@property (weak, nonatomic) IBOutlet UILabel *m_emptyLabel;


@end

@implementation SaleProductListViewController

@synthesize m_productList;

@synthesize m_Second;

@synthesize mEndTimer;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        m_productList = [[NSMutableArray alloc]initWithCapacity:0];
        
        pageIndex = 1;
        
        self.m_index = 0;
        
        m_Second = 0;
        
        mEndTimer = [[NSTimer alloc]init];
    
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setTitle:@"抢购商品"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    
    [self setRightButtonWithTitle:@"得令牌" action:@selector(rightClicked)];
    
    // 设置tableView的代理
    [self.m_tableView setDelegate:self];
    [self.m_tableView setDataSource:self];
//    [self.m_tableView setPullDelegate:self];
//    self.m_tableView.pullBackgroundColor = [UIColor whiteColor];
//    self.m_tableView.useRefreshView = YES;
//    self.m_tableView.useLoadingMoreView= YES;
    
    self.m_emptyLabel.hidden = YES;
    
    self.m_timeSecond = 0;
    
    // 添加时钟
    if ( ![self.mEndTimer isValid] && self.mEndTimer == nil ) {
        self.mEndTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    }
    
    // 解决刷新tableView的时候时钟秒数不动得问题
    [[NSRunLoop currentRunLoop]addTimer:self.mEndTimer forMode:NSRunLoopCommonModes];

    
    // 请求数据
    [self loadProductList];
    
    
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
    
    if ( [self.mEndTimer isValid] ) {
        
        [self.mEndTimer invalidate];
        
        self.mEndTimer = nil;
        
    }

}

- (void)rightClicked{
    // 进入获取令牌的页面
    TokenViewController *VC = [[TokenViewController alloc]initWithNibName:@"TokenViewController" bundle:nil];
    VC.m_stringType = @"1";
    [self.navigationController pushViewController:VC animated:YES];
    
}



- (void)timerAction{
    
    self.m_timeSecond ++;
    
    // 刷新列表
    [self.m_tableView reloadData];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.m_productList.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *cellIdentifier = @"SaleProductListCellIdentifier";
    
    SaleProductListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"SaleProductListCell" owner:self options:nil];
        
        cell = (SaleProductListCell *)[nib objectAtIndex:0];
        
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
    }
    
    if ( self.m_productList.count != 0 ) {
        
        NSMutableDictionary *dic = [self.m_productList objectAtIndex:indexPath.row];
        
        // 赋值
        cell.m_nameLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"GoodName"]];
        
        cell.m_priceLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Price"]];
        
        cell.m_orignPriceLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"OriginalPrice"]];
        
        cell.m_tokenLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"InviteTokenUse"]];
        
        cell.m_countLabel.text = [NSString stringWithFormat:@"%@/%@",[dic objectForKey:@"BuyedQuantity"],[dic objectForKey:@"Quantity"]];
        
        // 赋值图片
        [cell setImageView:[NSString stringWithFormat:@"%@",[dic objectForKey:@"FrontCover"]]];
        
        
        // 计算label的大小坐标
        CGSize size = [cell.m_priceLabel.text sizeWithFont:[UIFont systemFontOfSize:16.0f] constrainedToSize:CGSizeMake(MAXFLOAT, 21) lineBreakMode:NSLineBreakByWordWrapping];
        
        CGSize size1 = [cell.m_orignPriceLabel.text sizeWithFont:[UIFont systemFontOfSize:12.0f] constrainedToSize:CGSizeMake(MAXFLOAT, 21) lineBreakMode:NSLineBreakByWordWrapping];
        
        
        cell.m_priceLabel.frame = CGRectMake(cell.m_priceLabel.frame.origin.x, cell.m_priceLabel.frame.origin.y, size.width, 21);
        
        cell.m_label.frame = CGRectMake(cell.m_priceLabel.frame.origin.x + size.width + 1, cell.m_label.frame.origin.y, cell.m_label.frame.size.width, 21);
        
        cell.m_orignPriceLabel.frame = CGRectMake(cell.m_label.frame.origin.x + cell.m_label.frame.size.width + 3, cell.m_orignPriceLabel.frame.origin.y, size1.width + 2, 21);
        
        cell.m_Priceline.frame = CGRectMake(cell.m_label.frame.origin.x + cell.m_label.frame.size.width + 1, cell.m_Priceline.frame.origin.y, size1.width + 5, 1);
        
        cell.m_qianggouBtn.tag = indexPath.row;
        
        [cell.m_qianggouBtn addTarget:self action:@selector(saleBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        // 先计算抢购是否开始或者是进行中：1、未开始则显示开始时间的倒计时  2、进行中则显示抢购结束的倒计时
        self.m_startTime = [self dateFromString:[dic objectForKey:@"PanicBuyDateTimeS"]];
        self.m_systemDate = [self dateFromString:[dic objectForKey:@"NowDateTime"]];
        self.m_EndLimitTime = [self dateFromString:[dic objectForKey:@"PanicBuyDateTimeE"]];
        
        
        // 抢购开始时间和系统时间进行比较判断是未开始还是抢购进行中
        if ( [self.m_startTime compare:self.m_systemDate] == NSOrderedDescending ) {
 
            // 未开始
            // 计算即将开始的倒计时
             NSTimeInterval interval = [self.m_startTime timeIntervalSinceDate:self.m_systemDate] - self.m_timeSecond;
            
            // 判断商品的抢购时间已经开始
            if ( interval < 0.000000 ) {

                // 计算当前时间与结束时间之间的时间差(秒)
                NSTimeInterval interval1 = [self.m_EndLimitTime timeIntervalSinceDate:self.m_startTime] - self.m_timeSecond + self.m_Second + 1;
                
                // 判断商品的抢购时间是否已经结束
                if ( interval1 < 0.000000 ) {
                    
                    cell.m_timeView.hidden = YES;
                    
                    cell.m_endLabel.hidden = NO;
                    
                    cell.m_endLabel.text = @"已结束";
                    
                    
                    
                    
                    
                }else{
                    
                    cell.m_timeView.hidden = NO;
                    
                    cell.m_endLabel.hidden = YES;
                    
                    cell.m_hourLabel.text = [NSString stringWithFormat:@"%d",(int)interval1 / 3600];
                    
                    cell.m_minusLabel.text = [NSString stringWithFormat:@"%d",(int)interval1 / 60 % 60];
                    
                    cell.m_secondLabel.text = [NSString stringWithFormat:@"%d",(int)interval1 % 60];
                    
                }
                
                
                // 判断令牌数
                NSString *string = [NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:TOKENNOUSEDTOTAL]];
                
                NSString *useToken = [NSString stringWithFormat:@"%@",[dic objectForKey:@"InviteTokenUse"]];
                
                if ( [string intValue] < [useToken intValue] ) {
                    // 令牌不足的情况
                    cell.m_statusImagV.hidden = NO;
                    
                    cell.m_infoLabel.hidden = NO;
                    
                    cell.m_qianggouBtn.enabled  = NO;
                    
                    cell.m_qianggouBtn.userInteractionEnabled = NO;
                    
                }else{
                    
                    cell.m_statusImagV.hidden = YES;
                    
                    cell.m_infoLabel.hidden = YES;
                    
                    // 判断抢购时间是否已经结束
                    if ( interval1 < 0.000000 ) {
                        
                        cell.m_qianggouBtn.enabled  = NO;
                        
                        cell.m_qianggouBtn.userInteractionEnabled = NO;
                        
                    }else{
                        
                        cell.m_qianggouBtn.enabled  = YES;
                        
                        cell.m_qianggouBtn.userInteractionEnabled = YES;
                        
                        
                    }
                }
                
            }else{
                
                self.m_Second = self.m_timeSecond;
                
                // 表示抢购未开始
                
                cell.m_timeView.hidden = YES;
                
                cell.m_endLabel.hidden = NO;
                
//                cell.m_endLabel.text = @"即将开始";
                cell.m_endLabel.text = [NSString stringWithFormat:@"%d:%d:%d 后开始",(int)interval / 3600,(int)interval / 60 % 60,(int)interval % 60];
                
                
                // 判断令牌数
                NSString *string = [NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:TOKENNOUSEDTOTAL]];
                
                NSString *useToken = [NSString stringWithFormat:@"%@",[dic objectForKey:@"InviteTokenUse"]];
                
                if ( [string intValue] < [useToken intValue] ) {
                    // 令牌不足的情况
                    cell.m_statusImagV.hidden = NO;
                    
                    cell.m_infoLabel.hidden = NO;
                    
                }else{
                    
                    cell.m_statusImagV.hidden = YES;
                    
                    cell.m_infoLabel.hidden = YES;
                    
                }
                
                cell.m_qianggouBtn.enabled  = NO;
                
                cell.m_qianggouBtn.userInteractionEnabled = NO;

            }
            
            
            
        }else{
        
            // 进行中
            // 计算当前时间与结束时间之间的时间差(秒)
            NSTimeInterval interval = [self.m_EndLimitTime timeIntervalSinceDate:self.m_systemDate] - self.m_timeSecond;
            
            // 判断商品的抢购时间是否已经结束
            if ( interval < 0.000000 ) {
                
                cell.m_timeView.hidden = YES;
                
                cell.m_endLabel.hidden = NO;
                
                cell.m_endLabel.text = @"已结束";

                
                
            }else{
                
                cell.m_timeView.hidden = NO;
                
                cell.m_endLabel.hidden = YES;
                
                cell.m_hourLabel.text = [NSString stringWithFormat:@"%d",(int)interval / 3600];
                
                cell.m_minusLabel.text = [NSString stringWithFormat:@"%d",(int)interval / 60 % 60];
                
                cell.m_secondLabel.text = [NSString stringWithFormat:@"%d",(int)interval % 60];
                
            }
            
            
            // 判断令牌数
            NSString *string = [NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:TOKENNOUSEDTOTAL]];
            
            NSString *useToken = [NSString stringWithFormat:@"%@",[dic objectForKey:@"InviteTokenUse"]];
            
            if ( [string intValue] < [useToken intValue] ) {
                // 令牌不足的情况
                cell.m_statusImagV.hidden = NO;
                
                cell.m_infoLabel.hidden = NO;
                
                cell.m_qianggouBtn.enabled  = NO;
                
                cell.m_qianggouBtn.userInteractionEnabled = NO;
                
            }else{
                
                cell.m_statusImagV.hidden = YES;
                
                cell.m_infoLabel.hidden = YES;
                
                // 判断抢购时间是否已经结束
                if ( interval < 0.000000 ) {
                    
                    cell.m_qianggouBtn.enabled  = NO;
                    
                    cell.m_qianggouBtn.userInteractionEnabled = NO;
                    
                }else{
                    
                    cell.m_qianggouBtn.enabled  = YES;
                    
                    cell.m_qianggouBtn.userInteractionEnabled = YES;
                    
                    
                }
            }

        }
        
    }
    
    
    return cell;

}

- (void)saleBtnClicked:(id)sender{
    
    UIButton *btn = (UIButton *)sender;
    
    self.m_index = btn.tag;
    
    NSMutableDictionary *dic = [self.m_productList objectAtIndex:self.m_index];
    
    // 将商品的图片保存起来用于立即购买页面的显示
    [CommonUtil addValue:[NSString stringWithFormat:@"%@",[dic objectForKey:@"FrontCover"]] andKey:@"productImage"];
    
    // 验证用户是否设置了安全支付问题
    [self paymentSafeRequest];

}


// 验证用户是否填写了支付问题的网络请求
- (void)paymentSafeRequest{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    NSMutableDictionary *dic = [self.m_productList objectAtIndex:self.m_index];
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,     @"memberId",
                           key,   @"key",
                           [NSString stringWithFormat:@"%@",[dic objectForKey:@"PanicBuyGoodID"]],@"panicBuyGoodID",
                           nil];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"WisdomPaymentCheck_1.ashx" parameters:param success:^(NSJSONSerialization* json) {
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
            NSMutableDictionary *dic = [self.m_productList objectAtIndex:self.m_index];
            
            PanicBuyingViewController *VC = [[PanicBuyingViewController alloc]initWithNibName:@"PanicBuyingViewController" bundle:nil];
            VC.m_items = dic;
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
    
    NSMutableDictionary *dic = [self.m_productList objectAtIndex:self.m_index];
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,     @"memberId",
                           key,   @"key",
                           [NSString stringWithFormat:@"%@",[dic objectForKey:@"PanicBuyGoodID"]],@"panicBuyGoodID",
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
            NSMutableDictionary *dic = [self.m_productList objectAtIndex:self.m_index];
            
            PanicBuyingViewController *VC = [[PanicBuyingViewController alloc]initWithNibName:@"PanicBuyingViewController" bundle:nil];
            VC.m_items = dic;
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
        
    }else{
        
        
    }

}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSMutableDictionary *dic = [self.m_productList objectAtIndex:indexPath.row];
    
    // 将商品的图片保存起来用于立即购买页面的显示
   [CommonUtil addValue:[NSString stringWithFormat:@"%@",[dic objectForKey:@"FrontCover"]] andKey:@"productImage"];
    
    // 点击进入商品详情
//    SaleProductDetailViewController *VC = [[SaleProductDetailViewController alloc]initWithNibName:@"SaleProductDetailViewController" bundle:nil];
//    VC.m_dic = dic;
//    VC.m_timeSecond = self.m_timeSecond;
//    [self.navigationController pushViewController:VC animated:YES];
    
    SaleProductDetailViewController *VC = [[SaleProductDetailViewController alloc]initWithNibName:@"SaleProductDetailViewController" bundle:nil];
    //        VC.m_dic = dic;
    //        VC.m_timeSecond = self.m_timeSecond;
    
    VC.m_panicBuyGoodID = [NSString stringWithFormat:@"%@",[dic objectForKey:@"PanicBuyGoodID"]];
    [self.navigationController pushViewController:VC animated:YES];
    

    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 122.0f;

}

#pragma mark - PullTableViewDelegate

//- (void)pullTableViewDidTriggerRefresh:(PullTableView*)pullTableView {
//    pageIndex = 1;
////    [self performSelector:@selector(requestMerchantList) withObject:nil];
//}
//
//- (void)pullTableViewDidTriggerLoadMore:(PullTableView*)pullTableView {
//    pageIndex++;
////    [self performSelector:@selector(requestMerchantList) withObject:nil];
//}


// 获取抢购商品
- (void)loadProductList{
    
    
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
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"WisdomBuyList.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
//            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD dismiss];
            
            self.m_productList = [json valueForKey:@"PanicBuyGoodList"];
            
            // 判断数组是否为0
            if ( self.m_productList.count != 0 ) {
                
                self.m_emptyLabel.hidden = YES;
                
                
            }else{
             
                // 显示提示的label
                self.m_emptyLabel.hidden = NO;
            }
            
            // 刷新列表
            [self.m_tableView reloadData];
            
        } else {
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
    } failure:^(NSError *error) {
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];
    
}

@end
