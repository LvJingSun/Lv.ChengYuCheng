//
//  HH_CardPayViewController.m
//  HuiHui
//
//  Created by mac on 15-6-30.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "HH_CardPayViewController.h"

#import "HH_CardPayCell.h"

#import "UIImageView+AFNetworking.h"

#import "HH_ShareMenuViewController.h"

@interface HH_CardPayViewController ()

@property (weak, nonatomic) IBOutlet UITableView *m_tableView;

@property (strong, nonatomic) IBOutlet UIView *m_footerView;

// 支付按钮触发的事件
- (IBAction)payClicked:(id)sender;

@end

@implementation HH_CardPayViewController

@synthesize m_orderId;
@synthesize m_shopId;
@synthesize m_price;
@synthesize m_balance;

@synthesize m_dic;
@synthesize m_cardId;
@synthesize m_typeString;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        
        isSelectedIndex = -1;
        
        m_dic = [[NSMutableDictionary alloc]initWithCapacity:0];
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"支付"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];

    
    // 隐藏多余的分割线
    [self setExtraCellLineHidden:self.m_tableView];
    // 默认隐藏
    self.m_tableView.hidden = YES;
    
    NSLog(@"shopId = %@",self.m_shopId);
    
    // 请求数据
    [self orderCheckRequest];
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    
    // 添加微信支付成功的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(weixinpaySuccess) name:@"MenuPaySuccessKey" object:nil];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"MenuPaySuccessKey" object:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)leftClicked{
    
    [self goBack];
    
}

- (void)orderCheckRequest{
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        return;
    }
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"memberId",
                           key,@"key",
                           self.m_shopId,@"merchantShopId",
                           self.m_orderId,@"cloudMenuOrderId",nil];
    
    NSLog(@"params = %@",param);
    
    [httpClient request:@"CloudMenuOrderPayCheck_2.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            NSLog(@"json = %@",json);
            
            [SVProgressHUD dismiss];
            
            // 赋值
            self.m_price = [NSString stringWithFormat:@"%@",[json valueForKey:@"PrizeAmount"]];
            self.m_balance = [NSString stringWithFormat:@"%@",[json valueForKey:@"Balance"]];
            
            // 刷新列表
            self.m_tableView.hidden = NO;
            
            [self.m_tableView reloadData];
            
            // 设置tableView的footerView
            self.m_tableView.tableFooterView = self.m_footerView;
            
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showErrorWithStatus:msg];
       
        }
        
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];

}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if ( section == 0 ) {
        
        return 1;
        
    }else{
        
        return 3;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ( indexPath.section == 0 ) {
        
        static NSString *cellIdentifier = @"HH_CardPayCellIdentifier";
        
        HH_CardPayCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if ( cell == nil ) {
            
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"HH_CardPayCell" owner:self options:nil];
            
            cell = (HH_CardPayCell *)[nib objectAtIndex:0];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        
        // 赋值
        cell.m_price.text = [NSString stringWithFormat:@"%@元",self.m_price];
        
        return cell;
        
    }else{
                
        static NSString *cellIdentifier = @"HH_CardNoPayCellIdentifier";
        
        HH_CardNoPayCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if ( cell == nil ) {
            
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"HH_CardPayCell" owner:self options:nil];
            
            cell = (HH_CardNoPayCell *)[nib objectAtIndex:1];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        
        // 赋值
        if ( indexPath.row == 0 ) {
            
            cell.m_payType.text = @"会员卡支付";
            cell.m_balance.hidden = NO;
            
            // 如果余额为空的话则默认显示为0
            if ( [self.m_balance isEqualToString:@""] ) {
                
                cell.m_balance.text = @"(余额：0元)";

                
            }else{
                
                cell.m_balance.text = [NSString stringWithFormat:@"(余额：%@元)",self.m_balance];

            }
            
            
            // 赋值图片
            NSString *imageString = [NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:@"MarchantImageKey"]];
            
            [cell.m_imageView setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:imageString]]
                                    placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"]
                                             success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                                                 
                                                 cell.m_imageView.image = image;//[CommonUtil scaleImage:image toSize:CGSizeMake(68, 68)];
                                                 cell.m_imageView.contentMode = UIViewContentModeScaleToFill;
                                                 
                                             }
                                             failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                                                 
                                             }];
            
        }else if ( indexPath.row == 1 ){
            
            cell.m_payType.text = @"微信支付";

            cell.m_balance.hidden = YES;
            
            cell.m_imageView.image = [UIImage imageNamed:@"weixin.png"];

        }else {
        
            cell.m_payType.text = @"余额支付";
            
            cell.m_balance.hidden = YES;
            
            cell.m_imageView.image = [UIImage imageNamed:@"icon_120.png"];
            
        }
        
        if ( isSelectedIndex == indexPath.row ) {
        
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            
        }else{
            
            cell.accessoryType = UITableViewCellAccessoryNone;
            
        }
        
        return cell;

    }
    
    
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ( indexPath.section == 1 ) {
        
        if ( indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 2) {
            
            isSelectedIndex = indexPath.row;
            
        }
        
        [self.m_tableView reloadData];
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 3.0f;
}

#pragma mark - btn Clicked
- (IBAction)payClicked:(id)sender {
    
    if ( isSelectedIndex == 0 ) {
        
        // 会员卡支付
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil
                                                           message:@"确定会员卡支付?"
                                                          delegate:self
                                                 cancelButtonTitle:@"取消"
                                                 otherButtonTitles:@"确定", nil];
        alertView.tag = 13241;
        [alertView show];
        
    }else if ( isSelectedIndex == 1 ){
        
        // 判断是否安装了微信
        if ( [WXApi isWXAppInstalled] ) {
            // 微信支付 =======
            
            NSString *shopName = [NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:@"MctShopNameKey"]];
            
            if ( [shopName isEqualToString:@"(null)"] ) {
                
                shopName = @"";
                
            }
            
            // 点击去支付后将数据保存起来用于微信支付的赋值
            [CommonUtil addValue:[NSString stringWithFormat:@"%@点单的商品",shopName] andKey:WEIXIN_NAME];
            [CommonUtil addValue:[NSString stringWithFormat:@"%@",self.m_price] andKey:WEIXIN_PRICE];
            [CommonUtil addValue:[NSString stringWithFormat:@"%@",self.m_orderId] andKey:WEIXIN_OREDENO];
            
            // 表示是点单购买
            [CommonUtil addValue:@"3" andKey:WEIXIN_PAYTYPE];

            
            //创建支付签名对象
            payRequsestHandler *req = [payRequsestHandler alloc];
            //初始化支付签名对象
            [req init:APP_ID mch_id:MCH_ID];
            //设置密钥
            [req setKey:PARTNER_ID];
            
            //}}}
            
            //获取到实际调起微信支付的参数后，在app端调起支付
            NSMutableDictionary *dict = [req sendPay_demo];
            
            if(dict == nil){
                //错误提示
                NSString *debug = [req getDebugifo];
                
                [SVProgressHUD showErrorWithStatus:debug];
                
            }else{

                NSMutableString *stamp  = [dict objectForKey:@"timestamp"];
                
                //调起微信支付
                PayReq* req             = [[PayReq alloc] init];
                req.openID              = [dict objectForKey:@"appid"];
                req.partnerId           = [dict objectForKey:@"partnerid"];
                req.prepayId            = [dict objectForKey:@"prepayid"];
                req.nonceStr            = [dict objectForKey:@"noncestr"];
                req.timeStamp           = stamp.intValue;
                req.package             = [dict objectForKey:@"package"];
                req.sign                = [dict objectForKey:@"sign"];
                
                [WXApi sendReq:req];
            }
            
        }else{
            // 微信没有安装
            [SVProgressHUD showErrorWithStatus:@"您没有安装微信"];
            
        }
      
    }else if ( isSelectedIndex == 2 ) {
    
        [self yueRequestData];
        
    }else {
        
        // 没有选择任何支付方式
        [SVProgressHUD showErrorWithStatus:@"请选择一种支付方式"];
    
    }
    
}

//余额支付
- (void)yueRequestData {
    
    [SVProgressHUD showWithStatus:@"支付中..."];

    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        return;
    }
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"memberId",
                           key,@"Key",
                           self.m_orderId,@"cloudMenuOrderId",nil];
    
    [httpClient request:@"NewCloudMenuOrderPay_2.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        NSString *msg = [json valueForKey:@"msg"];
        
        if (success) {
            
            // 赋值
            self.m_dic = (NSMutableDictionary *)json;
            
            [SVProgressHUD showSuccessWithStatus:msg];
            
            // 过1s后返回上一个页面
            [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(lastView) userInfo:nil repeats:NO];
            
        } else {
            
                [SVProgressHUD showErrorWithStatus:msg];
            
        }
        
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];

    
}

// 会员卡支付请求数据
- (void)cardPayRequest{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        return;
    }
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"memberId",
                           key,@"key",
                           self.m_shopId,@"merchantShopId",
                           self.m_orderId,@"cloudMenuOrderId",nil];

    [httpClient request:@"CloudMenuOrderPay_2.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
       
        NSString *msg = [json valueForKey:@"msg"];

        if (success) {
            
            // 赋值
            self.m_dic = (NSMutableDictionary *)json;
            
            [SVProgressHUD showSuccessWithStatus:msg];
            
            // 过1s后返回上一个页面
            [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(lastView) userInfo:nil repeats:NO];
            
        } else {
            
            NSArray *arr = [msg componentsSeparatedByString:@"|"];
            
            if ( arr.count == 2 ) {
                
                // 赋值会员卡id
                self.m_cardId = [NSString stringWithFormat:@"%@",[arr objectAtIndex:1]];
                
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil
                                                                   message:[NSString stringWithFormat:@"%@",[arr objectAtIndex:0]]
                                                                  delegate:self
                                                         cancelButtonTitle:@"下次再说"
                                                         otherButtonTitles:@"领取会员卡", nil];
                alertView.tag = 15638;
                
                [alertView show];
                
            }else{
                
                [SVProgressHUD showErrorWithStatus:msg];

            }
            
        }
        
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}

- (void)lastView{

    // 点击进入到订单详情显示的页面进行分享
    HH_ShareMenuViewController *VC = [[HH_ShareMenuViewController alloc]initWithNibName:@"HH_ShareMenuViewController" bundle:nil];
    VC.m_orderId = [NSString stringWithFormat:@"%@",self.m_orderId];
    VC.m_titleString = @"恭喜您下单支付成功";
    VC.m_dic = self.m_dic;
    
    if ( [self.m_typeString isEqualToString:@"1"] ) {
        // 美容模式下
        VC.m_typeString = @"4";
        
    }else{
        // 饮食模式下会员卡支付
        VC.m_typeString = @"3";

    }
    

    [self.navigationController pushViewController:VC animated:YES];
    
    
}

- (void)weixinpaySuccess{
    
    // 点击进入到订单详情显示的页面进行分享
    HH_ShareMenuViewController *VC = [[HH_ShareMenuViewController alloc]initWithNibName:@"HH_ShareMenuViewController" bundle:nil];
    VC.m_orderId = [NSString stringWithFormat:@"%@",self.m_orderId];
    VC.m_titleString = @"恭喜您下单支付成功";
//    VC.m_dic = self.m_dic;
    
    if ( [self.m_typeString isEqualToString:@"1"] ) {
        // 美容模式下的微信操作
        VC.m_typeString = @"5";

    }else{
        
        VC.m_typeString = @"2";

    }
    
    [self.navigationController pushViewController:VC animated:YES];
    
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if ( alertView.tag == 13241 ) {
        
        if ( buttonIndex == 1 ) {
            // 请求数据
            [self cardPayRequest];
            
        }
    }else if ( alertView.tag == 15638 ){
                
        if ( buttonIndex == 1 ) {
            
            // 领取会员卡
            [self SubmitAddCard];
            
        }
        
    }
    
}

// 领取会员卡请求数据
- (void)SubmitAddCard{
    
    if ( ![self isConnectionAvailable] ) {
        
        return;
        
    }
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  
                                  memberId,@"memberId",
                                  self.m_cardId,@"vipCardId",
                                  
                                  nil];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    
    [self showHudInView:self.view hint:@"数据加载中"];
    
    [httpClient request:@"GetCards.ashx" parameters:param success:^(NSJSONSerialization* json) {
      
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        [self hideHud];
      
        NSString *msg = [json valueForKey:@"msg"];
       
        if (success) {
           
            [SVProgressHUD showSuccessWithStatus:msg];
            
          
            
        } else {
            
            [SVProgressHUD showErrorWithStatus:msg];
        }
        
    } failure:^(NSError *error) {
        [self hideHud];
        [SVProgressHUD showErrorWithStatus:@"添加失败，请稍后再试"];
    }];
    
}


@end
