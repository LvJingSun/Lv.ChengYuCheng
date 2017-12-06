//
//  HHQuanDetailViewController.m
//  HuiHui
//
//  Created by mac on 15-2-11.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "HHQuanDetailViewController.h"

#import "UIImageView+AFNetworking.h"

#import "QRCodeGenerator.h"

#import "Chat_MerViewController.h"

#import "QuanShopListViewController.h"

#import "Sharetofriend.h"

#import "SharetoHuiHuiViewController.h"


@interface HHQuanDetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *m_imageView;

@property (weak, nonatomic) IBOutlet UILabel *m_title;

@property (weak, nonatomic) IBOutlet UILabel *m_desprition;

@property (weak, nonatomic) IBOutlet UIImageView *m_codeImgV;

@property (weak, nonatomic) IBOutlet UILabel *m_allName;

@property (weak, nonatomic) IBOutlet UILabel *m_time;

@property (weak, nonatomic) IBOutlet UILabel *m_code;

@property (weak, nonatomic) IBOutlet UILabel *m_shopName;

//@property (weak, nonatomic) IBOutlet UIScrollView *m_scrollerView;

@property (weak, nonatomic) IBOutlet UITableView *m_tableView;

@property (weak, nonatomic) IBOutlet UIView *m_tempView;

@property (strong, nonatomic) IBOutlet UIView *m_footerView;

// 领取券券按钮触发的事件
- (IBAction)receiveBtnClicked:(id)sender;


@end

@implementation HHQuanDetailViewController

@synthesize m_counponId;

@synthesize imagechage;

@synthesize m_shopList;

@synthesize m_typeString;

@synthesize m_urlString;

@synthesize m_titleString;

@synthesize m_values;

@synthesize m_Funtions;

@synthesize m_keyTimes;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        imagechage = [[ImageCache alloc]init];
        
        m_shopList = [[NSMutableArray alloc]initWithCapacity:0];

    }
    
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"券券详情"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
      self.m_imageView.layer.cornerRadius = 30.0f;
    self.m_imageView.layer.masksToBounds = YES;
    
//    [self.m_scrollerView setContentSize:CGSizeMake(WindowSizeWidth, 600)];
    
    // 默认隐藏
//    self.m_scrollerView.hidden = YES;
    
    // 设置坐标
    self.m_codeImgV.frame = CGRectMake(WindowSizeWidth / 2 - 80,self.m_codeImgV.frame.origin.y, self.m_codeImgV.frame.size.width, self.m_codeImgV.frame.size.height);
    
    // 去掉多余的分割线
    [self setExtraCellLineHidden:self.m_tableView];
    
    // 判断是否领取过券券
//    if ( [self.m_typeString isEqualToString:@"1"] ) {
//        
//        self.m_tableView.tableFooterView = self.m_footerView;
//
//    }else if ( [self.m_typeString isEqualToString:@"2"] ){
//        
//        self.m_tableView.tableFooterView = nil;
//
//    }
    
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
    
   
    
    
    NSLog(@"url = %@",self.m_urlString);
    
    
    // 请求数据
    [self quanquandetailRequest];
    
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

- (void)sharingClicked{
    
    // 显示分享的页面
    [self.m_sharingView getSharingUrl:self.m_urlString withTitle:@"券券分享" withSubTitle:self.m_titleString];
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

// 请求券券详情数据
- (void)quanquandetailRequest{
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    // 获取memberId
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"memberId",
                           key,@"key",
                           [NSString stringWithFormat:@"%@",self.m_counponId],@"voucherId",
                          
                           nil];
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    NSLog(@"params = %@",param);
    
    [httpClient request:@"VoucherDetail.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        NSLog(@"json = %@",json);
        
        // status 0表示有数据 其他表示错误
        BOOL success = [[json valueForKey:@"status"] boolValue];
      
        // 请求数据后显示scrollerView
//        self.m_scrollerView.hidden = NO;
        
        if ( success ) {
            
            [SVProgressHUD dismiss];
            
            NSDictionary *dic = [json valueForKey:@"VoucherModel"];
        
            // 赋值
            self.m_title.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Title"]];
            
            self.m_desprition.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Description"]];
            
            self.m_allName.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"AllName"]];

            self.m_time.text = [NSString stringWithFormat:@"有效期：%@-%@",[dic objectForKey:@"MinDateTime"],[dic objectForKey:@"MaxDateTime"]];
            
            self.m_shopList = [dic objectForKey:@"VouMctShopList"];
            
            
            // 请求成功后进行赋值
            [self setRightButtonWithTitle:@"分享" action:@selector(sharingClicked)];
            
            // 赋值
            self.m_urlString = [NSString stringWithFormat:@"http://m.cityandcity.com/QuanDetail.aspx?id=%@",self.m_counponId];
            
            self.m_titleString = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Title"]];
            
            
//            NSMutableArray *shopList = (NSMutableArray *)[dic objectForKey:@"VouMctShopList"];
            
            // 可使用的店铺
//            if ( shopList.count != 0 ) {
//                
//                NSString *nameString = @"";
//                
//                for (int i = 0; i < shopList.count; i++) {
//                    
//                    NSDictionary *dic = [shopList objectAtIndex:i];
//                    
//                    NSString *name = [NSString stringWithFormat:@"%@",[dic objectForKey:@"MctShopName"]];
//                    
//                    // 赋值
//                    if ( i != shopList.count - 1 ) {
//                        
//                        nameString = [nameString stringByAppendingString:[NSString stringWithFormat:@"%@,",name]];
//                        
//                    }else{
//                        
//                        nameString = [nameString stringByAppendingString:[NSString stringWithFormat:@"%@",name]];
//                        
//                    }
//                    
//                    self.m_shopName.text = [NSString stringWithFormat:@"可使用店铺:%@",nameString];
//                    
//                }
//                
//            }else{
//                
//                self.m_shopName.text = @"";
//            
//            }
            
            // 对券券码进行赋值
            NSString *KeyValue = [NSString stringWithFormat:@"%@",[dic objectForKey:@"KeyValue"]];
            
           
//            NSArray *array = [KeyValue componentsSeparatedByString:@"|"];
//            
//            if ( array.count != 0 ) {
//                
//                NSString *code = [array objectAtIndex:0];
//                
//                self.m_code.text = [NSString stringWithFormat:@"%@",code];
//
//            }

            
            self.m_code.text = [NSString stringWithFormat:@"%@",KeyValue];

            // 对券券码进行生成二维码，用于收银台页面的扫描
            UIImage *codeImage = [QRCodeGenerator qrImageForString:[dic objectForKey:@"KeyValue"] imageSize:self.m_codeImgV.frame.size.width];
            [self.m_codeImgV setImage:codeImage];

            // 图片进行赋值
            NSString *headImage = [dic objectForKey:@"LogoMidUrl"];
            UIImage *reSizeImage = [imagechage getImage:headImage];
            if (reSizeImage != nil)
            {
                self.m_imageView.image = [CommonUtil scaleImage:reSizeImage toSize:CGSizeMake(60, 60)];
            }
            else{
                
                [self.m_imageView setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:headImage]]
                                        placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"]
                                                 success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                                                     
                                                     self.m_imageView.image = [CommonUtil scaleImage:image toSize:CGSizeMake(60, 60)];
                                                     
                                                 }
                                                 failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                                                     
                                                 }];
            }
            
            
        } else {
          
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
            
            self.navigationItem.rightBarButtonItem = nil;
            
        }
        
    } failure:^(NSError *error) {
        
        self.navigationItem.rightBarButtonItem = nil;

        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
       
    }];

    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"quanquanCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        cell = [(UITableViewCell *)[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        
        if ( indexPath.section == 0 ) {
            
            UIButton *btn = [UIButton buttonWithType: UIButtonTypeCustom];
            btn.frame = cell.frame;
            
            btn.backgroundColor = [UIColor clearColor];
            
            [btn addTarget:self action:@selector(merchantClicked) forControlEvents:UIControlEventTouchUpInside];
            
            [cell addSubview:btn];
            
        }else{
            
            UIButton *btn1 = [UIButton buttonWithType: UIButtonTypeCustom];
            btn1.frame = cell.frame;
            
            btn1.backgroundColor = [UIColor clearColor];
            
            [btn1 addTarget:self action:@selector(shopBtnClicked) forControlEvents:UIControlEventTouchUpInside];
            
            [cell addSubview:btn1];
        }
        
       
    }
    
    if ( indexPath.section == 0 ) {
        
        cell.textLabel.text = @"查看商户信息";
        
    }else{
        
        cell.textLabel.text = @"查看支持的店铺";

    }
    
    return cell;

}

- (void)merchantClicked{
    
    // 进入商户聊天的页面
    NSMutableDictionary *item = [[NSMutableDictionary alloc]initWithCapacity:0];
    
    if ( self.m_shopList.count != 0 ) {
        
        NSDictionary *dic = [self.m_shopList objectAtIndex:0];
        
        NSString *shopId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"MctShopID"]];
        
        [item setObject:shopId forKey:@"MerchantShopId"];
        
    }
    
    Chat_MerViewController *chatVC = [[Chat_MerViewController alloc]initWithChatter:nil isGroup:NO];
    chatVC.m_items = item;
    [self.navigationController pushViewController:chatVC animated:YES];
    
}

- (void)shopBtnClicked{
    
    // 进入支持的店铺
    QuanShopListViewController *VC = [[QuanShopListViewController alloc]initWithNibName:@"QuanShopListViewController" bundle:nil];
    VC.m_shopList = self.m_shopList;
    [self.navigationController pushViewController:VC animated:YES];
    
}

#pragma mark - UITableViewDelegate
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    NSLog(@"2221221321");
//
//    if ( indexPath.section == 0 ) {
//        
//        // 进入商户聊天的页面
//        NSMutableDictionary *item = [[NSMutableDictionary alloc]initWithCapacity:0];
//        
//        if ( self.m_shopList.count != 0 ) {
//            
//            NSDictionary *dic = [self.m_shopList objectAtIndex:0];
//            
//            NSString *shopId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"MctShopID"]];
//            
//            [item setObject:shopId forKey:@"MerchantShopId"];
//            
//        }
//        
//        Chat_MerViewController *chatVC = [[Chat_MerViewController alloc]initWithChatter:nil isGroup:NO];
//        chatVC.m_items = item;
//        [self.navigationController pushViewController:chatVC animated:YES];
//    
//    }else{
//        
//        
//        
//    }
//    
//    
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//
//    
//}
//
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return 20.0f;
        
    }
    
    return 10.0f;
    
}


- (IBAction)receiveBtnClicked:(id)sender {
    
    // 领取券券
    
    
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
        VC.STitle = [NSString stringWithFormat:@"%@",@"券券分享"];
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
