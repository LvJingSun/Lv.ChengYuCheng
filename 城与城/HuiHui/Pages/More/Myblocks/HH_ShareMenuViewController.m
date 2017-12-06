//
//  HH_ShareMenuViewController.m
//  HuiHui
//
//  Created by mac on 15-8-24.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "HH_ShareMenuViewController.h"

#import "Sharetofriend.h"

#import "SharetoHuiHuiViewController.h"

@interface HH_ShareMenuViewController ()

@property (weak, nonatomic) IBOutlet UILabel *m_shopName;

@property (weak, nonatomic) IBOutlet UILabel *m_reserTime;

@property (weak, nonatomic) IBOutlet UILabel *m_linkName;

@property (weak, nonatomic) IBOutlet UILabel *m_address;

@property (weak, nonatomic) IBOutlet UILabel *m_titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_title1;

@property (weak, nonatomic) IBOutlet UILabel *m_title2;

@property (weak, nonatomic) IBOutlet UILabel *m_title3;

@property (weak, nonatomic) IBOutlet UILabel *m_title4;


// 分享按钮触发的事件
- (IBAction)shareBtnClicked:(id)sender;
// 我知道了按钮触发的事件
- (IBAction)knowBtnClicked:(id)sender;


@end

@implementation HH_ShareMenuViewController

@synthesize m_urlString;

@synthesize m_titleString;

@synthesize m_values;

@synthesize m_Funtions;

@synthesize m_keyTimes;

@synthesize m_orderId;

@synthesize m_dic;

@synthesize m_typeString;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        
        m_values = [[NSArray alloc]init];
        
        m_Funtions = [[NSArray alloc]init];
        
        m_keyTimes = [[NSArray alloc]init];
        
        m_dic = [[NSMutableDictionary alloc]initWithCapacity:0];
        
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setTitle:@"下单成功"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    self.m_titleLabel.text = [NSString stringWithFormat:@"%@",self.m_titleString];
    
    self.m_urlString = [NSString stringWithFormat:@"http://m.cityandcity.com/diandan/OrderDetail.aspx?orderid=%@",self.m_orderId];
    
    // 初始化分享所在的view
    self.m_sharingView = [[CommonShareView alloc]initWithFrame:self.view.frame];
    
    self.m_sharingView.backgroundColor = [UIColor clearColor];
    
    // 初始化三个用于动画的数组
    NSArray *array = [[NSArray alloc]initWithObjects:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f, 0.01f, 1.0f)],[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.0f)],[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9f, 0.9f, 1.0f)],[NSValue valueWithCATransform3D:CATransform3DIdentity], nil];
    
    NSArray *keyTimes = [[NSArray alloc]initWithObjects:@"0.2f",@"0.5f", @"0.75f", @"1.0f", nil];
    
    NSArray *funtions = [[NSArray alloc]initWithObjects:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                         [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                         [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut], nil];
    
    self.m_values = array;
    
    self.m_keyTimes = keyTimes;
    
    self.m_Funtions = funtions;
    
    if ( self.m_dic.count != 0 ) {
        
        NSString *isWaimai = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"IsWaiMai"]];
        
        if ( [self.m_typeString isEqualToString:@"3"] ) {
            
            if ( [isWaimai isEqualToString:@"1"] ) {
                
                // 是外卖的情况下显示的值
                self.m_title1.text = @"联系人";
                
                self.m_title2.text = @"手机号";
                
                self.m_title3.text = @"配送时间";
                
                self.m_title4.text = @"配送地址";
                
                self.m_shopName.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"LinkName"]];
                
                self.m_reserTime.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"LinkPhone"]];
                
                self.m_linkName.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"PeiSongTime"]];
                
                self.m_address.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"Address"]];
                
                
            }else{
                
                // 预约的模式下显示的值
                self.m_title1.text = @"门店";
                
                self.m_title2.text = @"预订时间";
                
                self.m_title3.text = @"预订人数";
                
                self.m_title4.text = @"门店地址";
                
                self.m_shopName.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"ShopName"]];
                
                self.m_reserTime.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"BookDateTime"]];
                
                self.m_linkName.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"CloudMenuPerson"]];
                
                self.m_address.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"ShopAddress"]];
                
                
            }

            
        }else if ( [self.m_typeString isEqualToString:@"4"] ) {
        
            // 美容模式成功的显示操作
            self.m_title1.text = @"预订人";
            
            self.m_title2.text = @"下单时间";
            
            self.m_title3.text = @"门店";
            
            self.m_title4.text = @"门店地址";
            
            self.m_shopName.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"LinkName"]];
            
            self.m_reserTime.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"BookDateTime"]];
            
            self.m_linkName.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"ShopName"]];
            
            self.m_address.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"ShopAddress"]];
            
        }
        
    }else{
        
        if ( [self.m_typeString isEqualToString:@"1"] ) {
            
            // 现场支付请求数据进行赋值
            [self infoRequestSubmit];

        }else if ( [self.m_typeString isEqualToString:@"2"] || [self.m_typeString isEqualToString:@"5"] ) {
            
            // 微信支付成功后进行的处理
            [self weixinSuccessPaySubmit];
            
            
        }else{
            
            
        }
        
        
    }
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
  
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 微信支付成功后进入该页面时进行的请求数据进行赋值
- (void)weixinSuccessPaySubmit{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    // 获取memberId
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    //    NSString *merchantId = [CommonUtil getValueByKey:MERCHANTID];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"MemberID",
                           key,@"Key",
                           self.m_orderId,@"CloudMenuOrderID",
                           
                           nil];
    
    
    [SVProgressHUD showWithStatus:@"获取订单数据"];

    [httpClient request:@"SuccessOrderMsg.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        // status 0表示有数据 其他表示错误
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if ( success ) {
            
            [SVProgressHUD dismiss];
        
            // 赋值
            self.m_dic = (NSMutableDictionary *)json;
            
            if ( [self.m_typeString isEqualToString:@"2"] ) {
                
                NSString *isWaimai = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"IsWaiMai"]];
                
                if ( [isWaimai isEqualToString:@"1"] ) {
                    
                    // 是外卖的情况下显示的值
                    self.m_title1.text = @"联系人";
                    
                    self.m_title2.text = @"手机号";
                    
                    self.m_title3.text = @"配送时间";
                    
                    self.m_title4.text = @"配送地址";
                    
                    self.m_shopName.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"LinkName"]];
                    
                    self.m_reserTime.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"LinkPhone"]];
                    
                    self.m_linkName.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"PeiSongTime"]];
                    
                    self.m_address.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"Address"]];
                    
                    
                }else{
                    
                    // 预约的模式下显示的值
                    self.m_title1.text = @"门店";
                    
                    self.m_title2.text = @"预订时间";
                    
                    self.m_title3.text = @"预订人数";
                    
                    self.m_title4.text = @"门店地址";
                    
                    self.m_shopName.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"ShopName"]];
                    
                    self.m_reserTime.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"BookDateTime"]];
                    
                    self.m_linkName.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"CloudMenuPerson"]];
                    
                    self.m_address.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"ShopAddress"]];
                    
                    
                }

                
            }else if ( [self.m_typeString isEqualToString:@"5"] ){
                
                // 美容模式成功的显示操作
                self.m_title1.text = @"预订人";
                
                self.m_title2.text = @"下单时间";
                
                self.m_title3.text = @"门店";
                
                self.m_title4.text = @"门店地址";
                
                self.m_shopName.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"LinkName"]];
                
                self.m_reserTime.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"BookDateTime"]];
                
                self.m_linkName.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"ShopName"]];
                
                self.m_address.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"ShopAddress"]];
                
                
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

// 现场支付的情况下进入该页面时进行的请求数据
- (void)infoRequestSubmit{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    // 获取memberId
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    //    NSString *merchantId = [CommonUtil getValueByKey:MERCHANTID];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"MemberID",
                           key,@"Key",
                          self.m_orderId,@"cloudMenuOrderId",
                           
                           nil];
    
    [SVProgressHUD showWithStatus:@"获取订单数据"];
    
    [httpClient request:@"NoOnlinePay.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        // status 0表示有数据 其他表示错误
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if ( success ) {
            
//            NSString *msg = [json valueForKey:@"msg"];
//            [SVProgressHUD showSuccessWithStatus:msg];

            [SVProgressHUD dismiss];

            NSLog(@"json = %@",json);
            
            
            // 预约的模式下显示的值
            self.m_title1.text = @"门店";
            
            self.m_title2.text = @"预订时间";
            
            self.m_title3.text = @"预订人数";
            
            self.m_title4.text = @"门店地址";
            
            self.m_shopName.text = [NSString stringWithFormat:@"%@",[json valueForKey:@"ShopName"]];
            
            self.m_reserTime.text = [NSString stringWithFormat:@"%@",[json valueForKey:@"BookDateTime"]];
            
            self.m_linkName.text = [NSString stringWithFormat:@"%@",[json valueForKey:@"CloudMenuPerson"]];
            
            self.m_address.text = [NSString stringWithFormat:@"%@",[json valueForKey:@"ShopAddress"]];
            
            
            
            
        } else {
            
            
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
        
    } failure:^(NSError *error) {
        
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];

}

- (void)leftClicked{
    
//    [self goBack];
    
    // 返回商户菜单列表的页面
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
    
}

- (IBAction)shareBtnClicked:(id)sender {
    
    // 显示分享的页面
    [self.m_sharingView getSharingUrl:self.m_urlString withTitle:self.title withSubTitle:self.m_titleString];
    self.m_sharingView.delegate = self;
    
    
    [self.view addSubview:self.m_sharingView];
    
    // 动画
    CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    popAnimation.duration = 0.4;
    popAnimation.values = self.m_values;
    popAnimation.keyTimes = self.m_keyTimes;
    popAnimation.timingFunctions = self.m_Funtions;
    
    [self.m_sharingView.layer addAnimation:popAnimation forKey:nil];

}

- (IBAction)knowBtnClicked:(id)sender {
    
    // 返回商户菜单列表的页面
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
    
}

#pragma mark - ShareDelegate
- (void)getShare:(NSString *)aType{
    
    if ( [aType isEqualToString:@"1"] ) {
        
        // 分享到城与城好友
        Sharetofriend *VC = [[Sharetofriend alloc]init];
        VC.MessageType = @"WEB";
        [VC.TextDIC setObject:@"http://www.cityandcity.com/Resource/Attached/common/lianjie.png" forKey:@"imageURL"];
        [VC.TextDIC setObject:self.m_urlString forKey:@"shareString"];
        //        if ([self.title isEqualToString:@""]){
        //            [VC.TextDIC setObject:@"分享一条链接" forKey:@"title"];
        //        }else
        //        {
        [VC.TextDIC setObject:self.m_titleString forKey:@"title"];
        //        }
        [self.navigationController pushViewController:VC animated:YES];
        
    }else{
        
        // 分享到城与城朋友圈
        //诲诲朋友圈
        SharetoHuiHuiViewController * VC = [[SharetoHuiHuiViewController alloc]initWithNibName:@"SharetoHuiHuiViewController" bundle:nil];
        
        VC.dealId = @"0";
        VC.serviceID = @"0";
        VC.m_merchantShopId = @"0";
        VC.dynamicType = @"WebViewShare";
        //        if ([self.title isEqualToString:@""]||[self.m_titleString isEqualToString:self.title]){
        VC.STitle = [NSString stringWithFormat:@"%@",self.title];
        VC.subTitle =  [NSString stringWithFormat:@"%@",self.m_titleString];
        //        }else{
        //            VC.STitle = [NSString stringWithFormat:@"%@",self.title];
        //            VC.subTitle =  [NSString stringWithFormat:@"%@",self.m_titleString];
        //        }
        VC.webUrl = self.m_urlString;
        VC.activityID = @"0";
        
        //        VC.ImageArray = _downloadImages;
        
        [self.navigationController pushViewController:VC animated:YES];
        
    }
    
}


@end
