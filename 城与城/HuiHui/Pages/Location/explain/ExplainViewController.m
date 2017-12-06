//
//  ExplainViewController.m
//  HuiHui
//
//  Created by 冯海强 on 14-8-12.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "ExplainViewController.h"

#import "ProductDetailCell.h"

#import "SubmitOrderViewController.h"

#import "DPbuyViewController.h"

#import "CommonUtil.h"

#import "MyPaymentListViewController.h"

#import "InviteViewController.h"

@interface ExplainViewController ()

@property (nonatomic, strong) NSMutableDictionary  *AppConfigInfo_itemsDic;

@end

@implementation ExplainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.m_itemsDic = [[NSMutableDictionary alloc]initWithCapacity:0];
        self.AppConfigInfo_itemsDic = [[NSMutableDictionary alloc]initWithCapacity:0];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.m_tableview.hidden = YES;
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
        
    [self setRightButtonWithTitle:@"查收益" action:@selector(rightClicked)];

    [self setTitle:@"返利说明"];
    
    self.m_totalPrice.text = self.m_totalPricestring;


    [self AppConfigInfoRequest];
    
    
    if ([self.m_HiddenBVC isEqualToString:@"1"]) {
        
        self.m_Buyview.hidden = YES;
        
        self.m_tableview.frame = CGRectMake(0, 0, WindowSize.size.width, WindowSize.size.height);
    }

}

- (void)leftClicked{
    
    [self goBack];
}

-(void)rightClicked
{
    if ([self.m_pop isEqualToString:@"1"]) {
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    // 我的收益
    MyPaymentListViewController *VC = [[MyPaymentListViewController alloc]initWithNibName:@"MyPaymentListViewController" bundle:nil];
    [self.navigationController pushViewController:VC animated:YES];
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


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    if ([self.m_FromDPId isEqualToString:@"1"]&&[[CommonUtil getValueByKey:IsMemDaren] isEqualToString:@"1"]) {
        
        return 4;
        
    }
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = nil;
    
    if ([self.m_FromDPId isEqualToString:@"1"]&&[[CommonUtil getValueByKey:IsMemDaren] isEqualToString:@"1"]) {
        
        if ( indexPath.row == 0 ) {
            
            cell = [self tableViewo:tableView cellForRowAtIndexPath:indexPath];
            
        }else if ( indexPath.row == 1 ) {
            
            cell = [self tableViewFour:tableView cellForRowAtIndexPath:indexPath];
            
        }else if ( indexPath.row == 2 ){
            
            cell = [self tableViewFive:tableView cellForRowAtIndexPath:indexPath];
            
        }else if ( indexPath.row == 3 ){
            
            cell = [self tableViewSix:tableView cellForRowAtIndexPath:indexPath];
            
        }
        
    }else{
        
        if ( indexPath.row == 0 ) {
            
            cell = [self tableViewFour:tableView cellForRowAtIndexPath:indexPath];
            
        }else if ( indexPath.row == 1 ){
            
            cell = [self tableViewFive:tableView cellForRowAtIndexPath:indexPath];
            
        }else if ( indexPath.row == 2 ){
            
            cell = [self tableViewSix:tableView cellForRowAtIndexPath:indexPath];
            
        }
        
    }

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}




// 第0行显示的数据
- (UITableViewCell *)tableViewo:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *cellIdentifier = @"OtherOneCellIdentifier";
    
    OtherOneCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"ProductDetailCell" owner:self options:nil];
        
        cell = (OtherOneCell *)[nib objectAtIndex:5];
        
        cell.backgroundColor = [UIColor clearColor];
        
    }
    
//    cell.m_productName.text = [NSString stringWithFormat:@"本商品，生活达人返利为%@。",[NSString stringWithFormat:@"￥%.2f",[[self.m_itemsDic objectForKey:@"current_price"] floatValue] * [[self.m_itemsDic objectForKey:@"commission_ratio"] floatValue] * [[CommonUtil getValueByKey:LifFanLiBiLi] floatValue]]];
    
    cell.m_productName.text = [NSString stringWithFormat:@"本商品，生活达人返利为%@。",[NSString stringWithFormat:@"￥%.2f",[[self.m_itemsDic objectForKey:@"current_price"] floatValue] * [[CommonUtil getValueByKey:DZDP_FANLI] floatValue] / 2]];
    
    
    cell.m_productName.textAlignment = UITextAlignmentCenter;
    // 设置cell的背景边框
    cell.m_backImgV.layer.borderColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0].CGColor;
    cell.m_backImgV.layer.borderWidth = 1.0;
    
    return cell;
}


// 第1行显示的数据
- (UITableViewCell *)tableViewFour:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"IntroductionCellIndentifier";
    
    IntroductionCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"ProductDetailCell" owner:self options:nil];
        
        cell = (IntroductionCell *)[nib objectAtIndex:3];
        
        cell.backgroundColor = [UIColor clearColor];
        
    }
    
    cell.m_webView.hidden = YES;
    cell.m_detailLabel.hidden = NO;
    
    // 赋值
    cell.m_titleLabel.text = [NSString stringWithFormat:@"%@",[self.AppConfigInfo_itemsDic objectForKey:@"Title1"]];
    
    cell.m_titleLabel.frame = CGRectMake(44, 15, 200, 21);
    
    cell.m_infoImgV.image = [UIImage imageNamed:nil];
    
    CGSize size = [self.m_productIntro sizeWithFont:[UIFont systemFontOfSize:15.0f] constrainedToSize:CGSizeMake(WindowSizeWidth - 40, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    
    cell.m_detailLabel.frame = CGRectMake(20, 45, WindowSizeWidth - 40, size.height + 10);
    
    [cell.m_detailLabel setFont:[UIFont systemFontOfSize:15.0f]];

    
    cell.m_backImgV.frame = CGRectMake(10, 10, cell.m_backImgV.frame.size.width, 68 - 21 + size.height);
    
    cell.frame = CGRectMake(0, 0, WindowSizeWidth, cell.m_backImgV.frame.size.height + 10);
    
    
    cell.m_detailLabel.text = self.m_productIntro;
    
    
    // 设置cell的背景边框
    cell.m_backImgV.layer.borderColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0].CGColor;
    cell.m_backImgV.layer.borderWidth = 1.0;
    
    return cell;
}

// 第2行显示的数据
- (UITableViewCell *)tableViewFive:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"IntroductionCellIndentifier";
    
    IntroductionCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"ProductDetailCell" owner:self options:nil];
        
        cell = (IntroductionCell *)[nib objectAtIndex:3];
        
        cell.backgroundColor = [UIColor clearColor];
        
    }
    
    cell.m_webView.hidden = YES;
    cell.m_detailLabel.hidden = NO;
    
    // 赋值
    cell.m_titleLabel.text = [NSString stringWithFormat:@"%@",[self.AppConfigInfo_itemsDic objectForKey:@"Title2"]];

    
    cell.m_titleLabel.frame = CGRectMake(44, 15, 200, 21);
    
    cell.m_infoImgV.image = [UIImage imageNamed:nil];
    
    
    CGSize size = [self.m_PromptmString sizeWithFont:[UIFont systemFontOfSize:15.0f] constrainedToSize:CGSizeMake(WindowSizeWidth - 40, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    
    [cell.m_detailLabel setFont:[UIFont systemFontOfSize:15.0f]];

    cell.m_detailLabel.frame = CGRectMake(20, 45, WindowSizeWidth - 40, size.height + 10);
    
    cell.m_backImgV.frame = CGRectMake(10, 10, cell.m_backImgV.frame.size.width, 68 - 21 + size.height);
    
    cell.frame = CGRectMake(0, 0, WindowSizeWidth, cell.m_backImgV.frame.size.height + 10);
    
    cell.m_detailLabel.text = self.m_PromptmString;
    
    // 设置cell的背景边框
    cell.m_backImgV.layer.borderColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0].CGColor;
    cell.m_backImgV.layer.borderWidth = 1.0;
    
    return cell;
}

//显示的数据
- (UITableViewCell *)tableViewSix:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"IntroductionCellIndentifier";
    
    IntroductionCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"ProductDetailCell" owner:self options:nil];
        
        cell = (IntroductionCell *)[nib objectAtIndex:3];
        
        cell.backgroundColor = [UIColor clearColor];
        
    }

    cell.m_titleLabel.hidden = YES;
    cell.m_detailLabel.hidden = YES;
    cell.m_backImgV.hidden = YES;
    
    cell.m_webView.hidden = YES;
    cell.m_detailLabel.hidden = NO;

    UIButton * Btn =[UIButton buttonWithType:UIButtonTypeCustom];
    [Btn setFrame:CGRectMake(10, 0, WindowSizeWidth - 20, 40)];
    [Btn setBackgroundImage:[UIImage imageNamed:@"blue_btn.png"] forState:UIControlStateNormal];
    [Btn setTitle: @"立即邀请好友" forState: UIControlStateNormal];
    [Btn.titleLabel setFont:[UIFont systemFontOfSize:18.0f]];
    [Btn addTarget:self action:@selector(Invite) forControlEvents:UIControlEventTouchUpInside];
    
    [cell addSubview:Btn];
    
    cell.m_infoImgV.image = [UIImage imageNamed:nil];

    
    return cell;
}


#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if ([self.m_FromDPId isEqualToString:@"1"]&&[[CommonUtil getValueByKey:IsMemDaren] isEqualToString:@"1"]) {
        
        if ( indexPath.row == 0 ){
            
            return 45;
            
        }if ( indexPath.row == 1 ){
            
            CGSize size = [self.m_productIntro sizeWithFont:[UIFont systemFontOfSize:15.0f] constrainedToSize:CGSizeMake(WindowSizeWidth - 40, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
            
            return 68 - 21 + size.height + 10 + 10;
            
        }else if ( indexPath.row == 2 ){
            
            CGSize size = [self.m_PromptmString sizeWithFont:[UIFont systemFontOfSize:15.0f] constrainedToSize:CGSizeMake(WindowSizeWidth - 40, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
            
            return 68 - 21 + size.height + 10 + 10;
            
        }else if ( indexPath.row == 3 ){
            
            return 68;
        }
    }else{
        
        if ( indexPath.row == 0 ){
            
            CGSize size = [self.m_productIntro sizeWithFont:[UIFont systemFontOfSize:15.0f] constrainedToSize:CGSizeMake(WindowSizeWidth - 40, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
            
            return 68 - 21 + size.height + 10 + 10;
            
        }else if ( indexPath.row == 1 ){
            
            CGSize size = [self.m_PromptmString sizeWithFont:[UIFont systemFontOfSize:15.0f] constrainedToSize:CGSizeMake(WindowSizeWidth - 40, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
            
            return 68 - 21 + size.height + 10 + 10;
            
        }else if ( indexPath.row == 2 ){
            
            
            return 68;
            
        }
        
    }

    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}



-(IBAction)GOtoBuy:(UIButton *)sender
{
    if ([self.m_FromDPId isEqualToString:@"1"]) {
        
        DPbuyViewController * VC = [[DPbuyViewController alloc]initWithNibName:@"DPbuyViewController" bundle:nil];
        VC.dp_buystring = [NSString stringWithFormat:@"%@?hasheader=0&direct=true&uid=%@",[self.m_itemsDic objectForKey:@"deal_h5_url"],[CommonUtil getValueByKey:MEMBER_ID]];
        VC.dp_dic = self.m_itemsDic;
        VC.dp_Type = @"0";//表示购买；
        [CommonUtil addValue:[NSString stringWithFormat:@"%@",[self.m_itemsDic objectForKey:@"deal_id"]] andKey:@"DP_BuyID"];
                
        [self.navigationController pushViewController:VC animated:YES];
        
    }else{
        // 验证用户是否设置了安全支付问题
        [self paymentSafeRequest];
        
    }
    
}


//邀请好友
-(void)Invite
{
    InviteViewController * VC = [[InviteViewController alloc]initWithNibName:@"InviteViewController" bundle:nil];
    
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



- (void)AppConfigInfoRequest{
    
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
    
//    [SVProgressHUD showWithStatus:@"数据请求中"];
    
    [httpClient request:@"AppConfigInfo.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
                        
            self.AppConfigInfo_itemsDic = [json valueForKey:@"AppConfigSession"];
            
            self.m_productIntro = [NSString stringWithFormat:@"%@",[self.AppConfigInfo_itemsDic objectForKey:@"Content1"]];
            self.m_PromptmString = [NSString stringWithFormat:@"%@",[self.AppConfigInfo_itemsDic objectForKey:@"Content2"]];
            
            self.m_productIntro = [self.m_productIntro stringByReplacingOccurrencesOfString:@"\\t" withString:@"\t"];
            self.m_productIntro = [self.m_productIntro stringByReplacingOccurrencesOfString:@"\\n" withString:@"\n"];
            
            self.m_PromptmString = [self.m_PromptmString stringByReplacingOccurrencesOfString:@"\\t" withString:@"\t"];
            self.m_PromptmString = [self.m_PromptmString stringByReplacingOccurrencesOfString:@"\\n" withString:@"\n"];

            self.m_tableview.hidden = NO;
            [self.m_tableview reloadData];

            
        } else {
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
            self.m_tableview.hidden = YES;
        }
    } failure:^(NSError *error) {

        [SVProgressHUD showErrorWithStatus:@"请求失败，稍后再试"];
        self.m_tableview.hidden = YES;

    }];
}


@end
