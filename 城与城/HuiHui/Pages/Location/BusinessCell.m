//
//  BusinessCell.m
//  baozhifu
//
//  Created by mac on 13-8-14.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "BusinessCell.h"
#import "CommonUtil.h"
#import "AppHttpClient.h"
#import "SVProgressHUD.h"
#import "UIImageView+AFNetworking.h"
#import "Reachability.h"

@interface BusinessCell ()

@property (weak, nonatomic) IBOutlet UIImageView *logoView;

@property (weak, nonatomic) IBOutlet UILabel *txtMctName;

@property (weak, nonatomic) IBOutlet UILabel *txtAddress;

@property (weak, nonatomic) IBOutlet UILabel *txtOpeningHours;

@property (weak, nonatomic) IBOutlet UILabel *txtMessage;

@property (weak, nonatomic) IBOutlet UIButton *m_favoriteBtn;

// 打开地图按钮触发的事件
- (IBAction)openMap:(id)sender;
// 拨打电话按钮触发的事件
- (IBAction)openCall:(id)sender;
// 赞按钮触发的事件
- (IBAction)interested:(id)sender;
// 收藏按钮触发的事件
- (IBAction)addFavorite:(id)sender;


@end

@implementation BusinessCell

@synthesize delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
//        imageCache = [[ImageCache alloc] init];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setValue {
    
    if (self.item == nil) {
        return;
    }
    
    // 收藏按钮的值显示
    NSString *string = [NSString stringWithFormat:@"%@",[self.item objectForKey:@"IsFavorites"]];
    
    // 判断该商户是否进行收藏
    if ( [string isEqualToString:@"0"] ) {
        
        // 未收藏的话则进行的是收藏的操作
        self.m_typeString = @"1";
        
        // 表示未收藏
        [self.m_favoriteBtn setTitle:@"收藏" forState:UIControlStateNormal];
        
        
    }else if ( [string isEqualToString:@"1"] ){
        
        // 已收藏的话则进行的是取消的操作
        self.m_typeString = @"0";
        
        // 表示已经收藏
        [self.m_favoriteBtn setTitle:@"已收藏" forState:UIControlStateNormal];
        
    }
    
//    self.logoView.image = [self scaleImage: toSize:CGSizeMake(60, 60)];
    self.txtMctName.text= [self.item objectForKey:@"ShopName"];
    self.txtAddress.text= [self.item objectForKey:@"Address"];
    self.txtOpeningHours.text= [self.item objectForKey:@"OpeningHours"];
    self.txtMessage.text= [NSString stringWithFormat:@"%@ 人去过\n%@ 觉得不错", [self.item objectForKey:@"BeenCount"], [self.item objectForKey:@"InterestedCount"]];
   
    NSString *path = [self.item objectForKey:@"LogoSmlUrl"];
   
    
    UIImage *reSizeImage = [self.imageCache getImage:path];
    if (reSizeImage != nil) {
        self.logoView.image = reSizeImage;
        return;
    }
    //NSLog(@"AFImage load path: %@", path);
    __weak BusinessCell *weakCell = self;
    [self.logoView setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:path]]
                         placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"]
                                  success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                                    
                                      self.logoView.image = [CommonUtil scaleImage:image toSize:CGSizeMake(68, 68)];
                                      self.logoView.contentMode = UIViewContentModeScaleToFill;
                                      [weakCell setNeedsLayout];
                                      [self.imageCache addImage:self.logoView.image andUrl:path];
                                     
                                  }
                                  failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                                      
                                  }];
        
    
}


- (void)favoriteRequest{
        
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    //  optionType	0：取消；1：收藏； 商户ID默认：0
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,     @"memberId",
                           key,   @"key",
                           @"0",@"serviceId",
                           @"0",@"merchantId",
                           [self.item objectForKey:@"MerchantShopId"],@"merchantShopId",
                           [NSString stringWithFormat:@"%@",self.m_typeString],@"optionType",
                           nil];
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"Favorites.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showSuccessWithStatus:msg];
            
            // 判断是取消收藏还是收藏的操作
            if ( [self.m_typeString isEqualToString:@"0"] ) {
                
                self.m_typeString = @"1";
                
                // 重新设置网络返回的数据以便刷新数据的时候错误
                [self.item setObject:@"0" forKey:@"IsFavorites"];
                
                // 收藏
                [self.m_favoriteBtn setTitle:@"收藏" forState:UIControlStateNormal];

                
            }else if ( [self.m_typeString isEqualToString:@"1"] ) {
                
                self.m_typeString = @"0";
                
                // 重新设置网络返回的数据以便刷新数据的时候错误
                [self.item setObject:@"1" forKey:@"IsFavorites"];

                // 已收藏
                [self.m_favoriteBtn setTitle:@"已收藏" forState:UIControlStateNormal];
                
            }else{
                
                
                
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

- (IBAction)addFavorite:(id)sender {
    
    // 请求数据
     [self favoriteRequest];
    
}

- (IBAction)openMap:(id)sender {
//     [self.merchantView openMap:self.item];
    
    if ( delegate && [delegate respondsToSelector:@selector(openBaiduMap:)]  ) {
        
        [delegate performSelector:@selector(openBaiduMap:) withObject:self.item];
        
    }
}

// 拨打电话号码
- (IBAction)openCall:(id)sender {
    
    NSString *phone = [self.item objectForKey:@"Phone"];
    
    // 调用此方法，进入通讯录后不返回程序  下面的方法将会返回程序当中
//    NSURL *phoneNumberURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", phone]];//telprompt
//    [[UIApplication sharedApplication] openURL:phoneNumberURL];
    
    // 判断设备是否支持
    if([[[UIDevice currentDevice] model] rangeOfString:@"iPhone Simulator"].location != NSNotFound) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示"
                                                        message:@"该设备暂不支持电话功能"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles: nil];
        [alert show];
        
    }else{
                
        self.m_webView = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
        [self.m_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", phone]]]];
    
    }
  
}

// 判断网络不好
- (BOOL)isConnectionAvailable{
    
    BOOL  isExistenceNetWork = YES;
    
    Reachability *reach = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    
    switch ( [reach currentReachabilityStatus] ) {
        case NotReachable:
            isExistenceNetWork = NO;
            break;
        case ReachableViaWiFi:
            isExistenceNetWork = YES;
            break;
        case ReachableViaWWAN:
            isExistenceNetWork = YES;
            break;
            
        default:
            break;
    }
    
    if ( !isExistenceNetWork ) {
        
        [SVProgressHUD showErrorWithStatus:@"网络不给力，请稍后再试！"];
        
    }
    
    
    return isExistenceNetWork;
    
}

- (IBAction)interested:(id)sender {

    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,     @"memberid",
                           key,   @"key",
                           [self.item objectForKey:@"MerchantShopId"], @"merchantShopId",
                           nil];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"MerchantShopInterested.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            [SVProgressHUD dismiss];
            
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showSuccessWithStatus:msg];
            
            NSInteger interestedCount = [[self.item objectForKey:@"InterestedCount"] intValue] + 1;
            [self.item setObject:[NSString stringWithFormat:@"%d", interestedCount] forKey:@"InterestedCount"];
            self.txtMessage.text= [NSString stringWithFormat:@"%@ 人去过\n%@ 觉得不错", [self.item objectForKey:@"BeenCount"], [self.item objectForKey:@"InterestedCount"]];
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


@implementation PartyCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        //imageCache = [[ImageCache alloc] init];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)setImageView:(NSString *)imagePath{
    
    UIImage *reSizeImage = [self.imageCache getImage:imagePath];
    if (reSizeImage != nil) {
        self.m_imagV.image = reSizeImage;
        return;
    }
    //NSLog(@"AFImage load path: %@", path);
    self.m_imagV.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.m_imagV.layer.borderWidth = 1.0;
    
    __weak PartyCell *weakCell = self;
    [self.m_imagV setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:imagePath]]
                        placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"]
                                 success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                                     self.m_imagV.image = image;// [CommonUtil scaleImage:image toSize:CGSizeMake(70, 105)];
                                     self.m_imagV.contentMode = UIViewContentModeScaleAspectFit;
                                     [weakCell setNeedsLayout];
                                     [self.imageCache addImage:self.m_imagV.image andUrl:imagePath];
                                 }
                                 failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                                     
                                 }];
    
}

@end