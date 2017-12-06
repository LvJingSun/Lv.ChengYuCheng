//
//  AboutUsViewController.m
//  HuiHui
//
//  Created by mac on 14-8-5.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "AboutUsViewController.h"

#import "UIImageView+AFNetworking.h"

#import "CommonUtil.h"

#import "SVProgressHUD.h"

#import "AppHttpClient.h"


@interface AboutUsViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *m_imageV;

@property (weak, nonatomic) IBOutlet UILabel *m_titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_subTitleLabel;

@end

@implementation AboutUsViewController

@synthesize m_dic;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        m_dic = [[NSMutableDictionary alloc]initWithCapacity:0];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    
    [self setTitle:@"关于我们"];
    // arrow_WL.png
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    NSString *isAttention = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"IsAttion"]];
    
    // 是否关注过此商户：1是 0否
    if ( [isAttention isEqualToString:@"1"] ) {
        
        UIButton *_button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button setFrame:CGRectMake(0, 0, 50, 29)];
        _button.backgroundColor = [UIColor clearColor];
        [_button.titleLabel setFont:[UIFont systemFontOfSize:12.0f]];
//        [_button setImage:[UIImage imageNamed:@"like.png"] forState:UIControlStateNormal];
        [_button setTitle:@"取消关注" forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(cancelAttention) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *_barButton = [[UIBarButtonItem alloc] initWithCustomView:_button];
        [self.navigationItem setRightBarButtonItem:_barButton];
        
        self.m_titleBtn = _button;

        
    }else{
        
        UIButton *_button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button setFrame:CGRectMake(0, 0, 50, 29)];
        _button.backgroundColor = [UIColor clearColor];
        [_button.titleLabel setFont:[UIFont systemFontOfSize:12.0f]];
        //        [_button setImage:[UIImage imageNamed:@"like.png"] forState:UIControlStateNormal];
        [_button setTitle:@"关注" forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(rightClicked) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *_barButton = [[UIBarButtonItem alloc] initWithCustomView:_button];
        [self.navigationItem setRightBarButtonItem:_barButton];
        
        self.m_titleBtn = _button;
        
    }
    
    
    
    /*
    // 根据来自于哪个页面来判断右上角的按钮触发的事件 1表示来自于商户列表 - 进行关注 2表示来自于我的底盘 - 取消关注
    if ( [self.m_typeString isEqualToString:@"1"] ) {
        
        [self setRightButtonWithNormalImage:@"like.png" action:@selector(rightClicked)];
        
    }else if ( [self.m_typeString isEqualToString:@"2"] ) {
        
        UIButton *_button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button setFrame:CGRectMake(0, 0, 50, 29)];
        _button.backgroundColor = [UIColor clearColor];
        [_button.titleLabel setFont:[UIFont systemFontOfSize:12.0f]];
        [_button setImage:[UIImage imageNamed:@"like.png"] forState:UIControlStateNormal];
        
        [_button addTarget:self action:@selector(cancelAttention) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *_barButton = [[UIBarButtonItem alloc] initWithCustomView:_button];
        [self.navigationItem setRightBarButtonItem:_barButton];
        
        self.m_titleBtn = _button;
        
        
    }else{
        
        
    }
     */
    
    self.m_titleLabel.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"Allname"]];
    self.m_subTitleLabel.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"Briefintro"]];
    
    CGSize size = [self.m_subTitleLabel.text sizeWithFont:[UIFont systemFontOfSize:12.0f] constrainedToSize:CGSizeMake(224, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    
    self.m_subTitleLabel.frame = CGRectMake(self.m_subTitleLabel.frame.origin.x, self.m_subTitleLabel.frame.origin.y, 224, size.height);
    
    // 获取图片
    NSString *path = [self.m_dic objectForKey:@"LogoSmlUrl"];
    
    [self.m_imageV setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:path]]
                            placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"]
                                     success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                                         self.m_imageV.image = [CommonUtil scaleImage:image toSize:CGSizeMake(68, 68)];
                                         
                                     }
                                     failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                                         
                                     }];

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
}

- (void)rightClicked{
    
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
                           [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"Merchantid"]], @"merchantId",
                           nil];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"MerchantAttentionAdd.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            // [SVProgressHUD dismiss];
            
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showSuccessWithStatus:msg];
            
            // 可进行取消关注和关注的功能
            if ( [self.m_typeString isEqualToString:@"2"] ) {
                
                // 关注成功后按钮响应取消关注的事件
                [self.m_titleBtn removeTarget:self action:@selector(rightClicked) forControlEvents:UIControlEventTouchUpInside];
                
                [self.m_titleBtn addTarget:self action:@selector(cancelAttention) forControlEvents:UIControlEventTouchUpInside];
                
                
                [self.m_titleBtn setTitle:@"取消关注" forState:UIControlStateNormal];

                
                // 保存数据来判断返回上一级时是否要重新请求商户列表的数据
                
                [CommonUtil addValue:@"0" andKey:kMerchantKey];
                
                
            }else{
                
                // 关注成功后按钮响应取消关注的事件
                [self.m_titleBtn removeTarget:self action:@selector(rightClicked) forControlEvents:UIControlEventTouchUpInside];
                
                [self.m_titleBtn addTarget:self action:@selector(cancelAttention) forControlEvents:UIControlEventTouchUpInside];
                
                [self.m_titleBtn setTitle:@"取消关注" forState:UIControlStateNormal];

                
                // 保存数据来判断返回上一级时是否要重新请求商户列表的数据
                
                [CommonUtil addValue:@"1" andKey:kMerchantKey];
                
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

// 取消对商户的关注请求数据
- (void)cancelAttentionRequest{
    
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
                           [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"Merchantid"]], @"merchantId",
                           nil];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"MerchantAttentionCancel.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            // [SVProgressHUD dismiss];
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showSuccessWithStatus:msg];
            
            // 取消成功后按钮响应关注商户的事件
            [self.m_titleBtn removeTarget:self action:@selector(cancelAttention) forControlEvents:UIControlEventTouchUpInside];
            
            [self.m_titleBtn addTarget:self action:@selector(rightClicked) forControlEvents:UIControlEventTouchUpInside];
            
            [self.m_titleBtn setTitle:@"关注" forState:UIControlStateNormal];

            
            // 保存数据来判断返回上一级时是否要重新请求商户列表的数据
            [CommonUtil addValue:@"1" andKey:kMerchantKey];
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
    } failure:^(NSError *error) {
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];
    
}

// 取消关注
- (void)cancelAttention{
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示"
                                                       message:@"您确定取消对该商户的关注？"
                                                      delegate:self
                                             cancelButtonTitle:@"取消"
                                             otherButtonTitles:@"确定", nil];
    alertView.tag = 14203;
    [alertView show];
    
    
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if ( alertView.tag == 14203 ) {
        
        if ( buttonIndex == 1 ) {
            // 取消关注请求数据
            [self cancelAttentionRequest];
            
        }
    }
    
}


@end
