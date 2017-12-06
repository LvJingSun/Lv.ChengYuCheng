//
//  MoreViewController.m
//  HuiHui
//
//  Created by mac on 13-11-19.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import "MoreViewController.h"
#import "MoreCell.h"
#import "PersonalViewController.h"
#import "MyKeyListViewController.h"
#import "MyPaymentListViewController.h"
#import "ShopCartViewController.h"
#import "SettingViewController.h"
#import "MyOrderListViewController.h"
#import "RechargeViewController.h"
#import "RealAccountViewController.h"
#import "RealAccountResultViewController.h"
#import "PayMentViewController.h"
#import "IntegrationViewController.h"
#import "CommonUtil.h"
#import "SVProgressHUD.h"
#import "AppHttpClient.h"
#import "PaymentQueViewController.h"
#import "UIImageView+AFNetworking.h"
#import "AppDelegate.h"
#import "TokenViewController.h"
#import "PayStyleViewController.h"
#import "ShareViewController.h"
#import "MyAccountViewController.h"
#import "MyFavoriteViewController.h"
#import "AboutmeViewController.h"
//#import "AHlistViewController.h"

#import "orderChooseViewController.h"
#import "CommonUtil.h"

#import "MactQuanquanViewController.h"
#import "MyCardViewController.h"

//任务中心
#import "TaskHomeViewController.h"

#import "FSB_GameNAVController.h"
#import "FSB_GameViewController.h"

#import "New_MyWalletViewController.h"
#import "HuLa_HomeViewController.h"

@interface MoreViewController ()

@property (weak, nonatomic) IBOutlet UITableView *m_tableView;

@property (weak, nonatomic) IBOutlet UIImageView *m_imageView;

@property (weak, nonatomic) IBOutlet UIImageView *m_sexImgV;

@property (weak, nonatomic) IBOutlet UILabel *m_account;

@property (weak, nonatomic) IBOutlet UIImageView *m_whiteImagV;

@property (weak, nonatomic) IBOutlet UIScrollView *m_scrollerView;

@property (weak, nonatomic) IBOutlet UIButton *m_headerBtn;

@property (weak, nonatomic) IBOutlet UIView *m_shareView;

@property (weak, nonatomic) IBOutlet UIImageView *m_keyImgV;

@property (weak, nonatomic) IBOutlet UIImageView *m_lingImgV;

@property (weak, nonatomic) IBOutlet UIImageView *m_orderImgV;

@property (weak, nonatomic) IBOutlet UIImageView *m_zhuanImgV;

@property (weak, nonatomic) IBOutlet UIImageView *m_fenImgV;

@property (weak, nonatomic) IBOutlet UIImageView *m_shareImgV;


@property (weak, nonatomic) IBOutlet UIImageView *m_imageV1;

@property (weak, nonatomic) IBOutlet UIImageView *m_imageV2;

@property (weak, nonatomic) IBOutlet UIImageView *m_imageV3;

@property (weak, nonatomic) IBOutlet UIImageView *m_imageV4;

@property (weak, nonatomic) IBOutlet UIImageView *m_imageV5;


@property (weak, nonatomic) IBOutlet UIImageView *m_imageV6;


@property (weak, nonatomic) IBOutlet UIImageView *m_imageV7;

//游戏图标
@property (weak, nonatomic) IBOutlet UIImageView *m_imageV8;
//游戏标题
@property (weak, nonatomic) IBOutlet UILabel *m_GameLab;

@property (weak, nonatomic) IBOutlet UIImageView *m_imageV9;

@property (weak, nonatomic) IBOutlet UIImageView *m_imageV10;




// 临时label
@property (nonatomic, strong) UILabel           *m_nameLabel;

// 充值
- (void)rechargeClicked:(id)sender;
// 付款
- (void)payClicked:(id)sender;
// 按钮触发的事件
- (IBAction)btnClicked:(id)sender;

@end

@implementation MoreViewController

@synthesize appMore;

@synthesize RedTipCnt;

@synthesize m_redDotArray;

@synthesize m_keyString;
@synthesize m_orderString;
@synthesize m_recordsString;
@synthesize m_integralString;
@synthesize m_tokenString;
@synthesize m_userString;

@synthesize m_dic;
@synthesize m_modify;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        appMore = [[NSMutableDictionary alloc]initWithCapacity:0];
        
        RedTipCnt = [[NSMutableDictionary alloc]initWithCapacity:0];
        
        friendHelp = [[FriendHelper alloc]init];
        
        m_redDotArray = [[NSMutableArray alloc]initWithCapacity:0];
        
        m_dic = [[NSMutableDictionary alloc]initWithCapacity:0];
        
        
        // 添加通知
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(pushJump:) name:kPushNotifaction object:nil];
        
        m_modify = NO;

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    [self setTitle:@"我的"];
    
    
    // 赋值-导航栏标题
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 6, 150, 30)];
    titleLabel.font = [UIFont systemFontOfSize:18.0f];
    titleLabel.textColor = [UIColor whiteColor];

    [titleLabel setShadowOffset:CGSizeMake(0, 0)];
    [titleLabel setShadowColor:[UIColor colorWithRed:0x41/255.0f green:0x41/255.0f blue:0x41/255.0f alpha:1.0f]]; //[UIColor whiteColor]];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = [NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:NICK]];
    
    self.m_nameLabel = titleLabel;
    self.navigationItem.titleView = titleLabel;
    
    
    [self.m_headerBtn.layer setMasksToBounds:YES];
    
    [self.m_headerBtn.layer setCornerRadius:30.0f];
    
    [self.m_imageView.layer setMasksToBounds:YES];
    
    [self.m_imageView.layer setCornerRadius:30.0f];
    
    [self.m_headerBtn addTarget:self action:@selector(personalClicked) forControlEvents:UIControlEventTouchUpInside];
    
    //    // 设置为白色的背景
    [self.m_whiteImagV.layer setMasksToBounds:YES];
    [self.m_whiteImagV.layer setCornerRadius:30.0f];
    
    
    // 赋值
    self.m_account.text = [NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:ACCOUNT]];
    
    // 判断性别
    if ( [[CommonUtil getValueByKey:USER_SEX] isEqualToString:@"男"] ) {
        
        self.m_sexImgV.image = [UIImage imageNamed:@"gr_xingbie2.png"];
        
    }else if ( [[CommonUtil getValueByKey:USER_SEX] isEqualToString:@"女"] ) {
        
        self.m_sexImgV.image = [UIImage imageNamed:@"gr_xingbie.png"];
        
    }else{
        
        self.m_sexImgV.image = [UIImage imageNamed:@""];
        
    }
    
    // 获取图片
    NSString *path = [NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:USER_PHOTO]];
    
    [self.m_imageView setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:path]]
                            placeholderImage:[UIImage imageNamed:@"moren.png"]
                                     success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                                         
                                         self.m_imageView.image = image;
                                         
                                         self.m_imageView.contentMode = UIViewContentModeScaleAspectFit;
                                     }
     
                                     failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                                         
                                     }];
    
    
    // 获取会员卡logo
    NSString *cardpath = [NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:@"CardLoginBigUrl"]];
    
    [self.m_imageV4 setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:cardpath]]
                            placeholderImage:[UIImage imageNamed:@"moren.png"]
                                     success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                                         
                                         self.m_imageV4.image = image;
                                         
                                     }
     
                                     failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                                         self.m_imageV4.image = [UIImage imageNamed:@"moren.png"];

                                     }];


    // 设置右边的按钮
    UIButton *_button = [UIButton buttonWithType:UIButtonTypeCustom];
    [_button setFrame:CGRectMake(0, 0, 50, 29)];
    _button.backgroundColor = [UIColor clearColor];
    [_button setTitle:@"" forState:UIControlStateNormal];
    [_button.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [_button setImage:[UIImage imageNamed:@"set_fuhao.png"] forState:UIControlStateNormal];
    [_button addTarget:self action:@selector(setClicked) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *_barButton = [[UIBarButtonItem alloc] initWithCustomView:_button];
    [self.navigationItem setRightBarButtonItem:_barButton];
    
    // 设置scrollerView的滚动范围
    [self.m_scrollerView setContentSize:CGSizeMake(WindowSizeWidth, 550)];
    
    // 根据值来判断是否显示我的分享
    if ([[NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:IsDaiLiAndMct]] isEqualToString:@"1"]) {
        
        self.m_shareView.hidden = NO;
        
    }else{
        
        self.m_shareView.hidden = YES;
    }

    // 红点默认隐藏
    self.m_keyImgV.hidden = YES;
    self.m_lingImgV.hidden = YES;
    self.m_orderImgV.hidden = YES;
    self.m_zhuanImgV.hidden = YES;
    self.m_fenImgV.hidden = YES;
    self.m_shareImgV.hidden = YES;
    
    // 计算图标的大小坐标
    self.m_imageV1.frame = CGRectMake(WindowSizeWidth/6-(25/2), self.m_imageV1.frame.origin.y, self.m_imageV1.frame.size.width, self.m_imageV1.frame.size.height);

    self.m_imageV2.frame = CGRectMake(WindowSizeWidth/6*3-(25/2), self.m_imageV2.frame.origin.y, self.m_imageV2.frame.size.width, self.m_imageV2.frame.size.height);

    self.m_imageV3.frame = CGRectMake(WindowSizeWidth/6*5-(25/2), self.m_imageV3.frame.origin.y, self.m_imageV3.frame.size.width, self.m_imageV3.frame.size.height);

    self.m_imageV4.frame = CGRectMake(WindowSizeWidth/6*3-(self.m_imageV4.frame.size.width/2), self.m_imageV4.frame.origin.y, self.m_imageV4.frame.size.width, self.m_imageV4.frame.size.height);
    
    self.m_imageV5.frame = CGRectMake(WindowSizeWidth/6*5-(25/2), self.m_imageV5.frame.origin.y, self.m_imageV5.frame.size.width, self.m_imageV5.frame.size.height);
    
    self.m_imageV6.frame = CGRectMake(WindowSizeWidth/6-(25/2), self.m_imageV6.frame.origin.y, self.m_imageV6.frame.size.width, self.m_imageV6.frame.size.height);

    self.m_imageV7.frame = CGRectMake(WindowSizeWidth/6-(25/2), self.m_imageV7.frame.origin.y, self.m_imageV7.frame.size.width, self.m_imageV7.frame.size.height);

    self.m_imageV8.frame = CGRectMake(WindowSizeWidth/6*3-(25/2), self.m_imageV8.frame.origin.y, self.m_imageV8.frame.size.width, self.m_imageV8.frame.size.height);
    
    self.m_imageV9.frame = CGRectMake(WindowSizeWidth/6*5-(25/2), self.m_imageV9.frame.origin.y, self.m_imageV9.frame.size.width, self.m_imageV9.frame.size.height);

    self.m_imageV10.frame = CGRectMake(WindowSizeWidth/6-(25/2), self.m_imageV10.frame.origin.y, self.m_imageV10.frame.size.width, self.m_imageV10.frame.size.height);
    
    self.m_keyImgV.frame = CGRectMake(WindowSizeWidth/3*2-20, self.m_keyImgV.frame.origin.y, self.m_keyImgV.frame.size.width, self.m_keyImgV.frame.size.height);
    
     self.m_lingImgV.frame = CGRectMake(WindowSizeWidth/3*3-20, self.m_lingImgV.frame.origin.y, self.m_lingImgV.frame.size.width, self.m_lingImgV.frame.size.height);

    self.m_orderImgV.frame = CGRectMake(WindowSizeWidth/3-20, self.m_orderImgV.frame.origin.y, self.m_orderImgV.frame.size.width, self.m_orderImgV.frame.size.height);
    
    self.m_zhuanImgV.frame = CGRectMake(WindowSizeWidth/3*3-20, self.m_zhuanImgV.frame.origin.y, self.m_zhuanImgV.frame.size.width, self.m_zhuanImgV.frame.size.height);

    self.m_shareImgV.frame = CGRectMake(WindowSizeWidth/3-20, self.m_shareImgV.frame.origin.y, self.m_shareImgV.frame.size.width, self.m_shareImgV.frame.size.height);

    if ([[CommonUtil getValueByKey:MEMBER_ID] isEqualToString:@"19404"]) {
        
        self.m_GameLab.hidden = YES;
        
        self.m_imageV8.image = [UIImage imageNamed:@"icon.png"];
        
    }
    
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    // 如果m_modify为YES的话则重新赋值
    if ( m_modify ) {
        
        m_modify = NO;
        
        self.m_nameLabel.text = [NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:NICK]];
        
        // 赋值
        self.m_account.text = [NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:ACCOUNT]];
        
        // 判断性别
        if ( [[CommonUtil getValueByKey:USER_SEX] isEqualToString:@"男"] ) {
            
            self.m_sexImgV.image = [UIImage imageNamed:@"gr_xingbie2.png"];
            
        }else if ( [[CommonUtil getValueByKey:USER_SEX] isEqualToString:@"女"] ) {
            
            self.m_sexImgV.image = [UIImage imageNamed:@"gr_xingbie.png"];
            
        }else{
            
            self.m_sexImgV.image = [UIImage imageNamed:@""];
            
        }
        
        // 获取图片
        NSString *path = [NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:USER_PHOTO]];
        
        [self.m_imageView setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:path]]
                                placeholderImage:[UIImage imageNamed:@"moren.png"]
                                         success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                                             
                                             self.m_imageView.image = image;
                                             
                                             self.m_imageView.contentMode = UIViewContentModeScaleAspectFit;
                                         }
         
                                         failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                                             
                                         }];

    }
    
}

- (void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:animated];
    // 添加通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(pushJump:) name:kPushNotifaction object:nil];
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    if ( isIOS7 ) {
        
        self.navigationController.view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    }

    // 判断如果是从购物车点击了去逛逛的按钮过来后直接跳转到本地
    if ( Appdelegate.isSelectgoShopping ) {
        
        [self.tabBarController setSelectedIndex:2];
        
        Appdelegate.isSelectgoShopping = NO;
   
    }else{
        
        // 如果用户登录则直接请求数据
        [self loadData];
        
        // 从我的用户页面返回过来，如果是1则表示点击进入过我的用户的页面，则刷新数据保存到数据库里面，否则的话则不做任何操作
        if ( [[CommonUtil getValueByKey:@"RedDotKey"]isEqualToString:@"1"] ) {
            
            if ( self.m_dic.count != 0 ) {
                
                // 点击后更新数据存储到数据库里面
                [self.m_dic setValue:[NSString stringWithFormat:@"%@",[self.RedTipCnt objectForKey:@"MemberPublicInviteList"]] forKey:@"MemberPublicInviteList"];
                
                NSArray *arr = [NSArray arrayWithObject:self.m_dic];
                
                [friendHelp updateRedDot:arr];
                
            }
            // 默认为0
            [CommonUtil addValue:@"0" andKey:@"RedDotKey"];
            
        }else{
            
            
        }
        
        if ( self.m_redDotArray.count != 0 ) {
            
            [self.m_redDotArray removeAllObjects];
        }
        
        // 从数据库中读取数据
        self.m_redDotArray = (NSMutableArray *)[friendHelp redDotArray];
        
        // 赋值
        if ( self.m_redDotArray.count != 0 ) {
            
            self.m_dic = [self.m_redDotArray objectAtIndex:0];
            
            self.m_keyString = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"KeyList"]];

            self.m_orderString = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"MemberOrder"]];

            self.m_recordsString = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"TransactionRecords"]];

            self.m_integralString = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"IntegralRecordList"]];

            self.m_tokenString = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"MemberToken"]];

            self.m_userString = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"MemberPublicInviteList"]];
            
        }else{
            
            self.m_keyString = @"";
            self.m_orderString = @"";
            self.m_recordsString = @"";
            self.m_integralString = @"";
            self.m_tokenString = @"";
            self.m_userString = @"";
            
            // 默认第一次赋值都为0
            self.m_dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"0",@"IntegralRecordList",@"0",@"KeyList",@"0",@"MemberOrder",@"0",@"MemberPublicInviteList",@"0",@"MemberToken",@"0",@"TransactionRecords", nil];
            
        }
        
        
        // 请求红点的接口
        [self requestSubmitRedDian];

    }

}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setClicked{
    // 进入设置的页面
    SettingViewController *VC = [[SettingViewController alloc]initWithNibName:@"SettingViewController" bundle:nil];
    [self.navigationController pushViewController:VC animated:YES];
    
}

- (void)personalClicked{
    
    m_modify = YES;
    
    // 进入个人信息
    PersonalViewController *VC = [[PersonalViewController alloc]initWithNibName:@"PersonalViewController" bundle:nil];
    
    [self.navigationController pushViewController:VC animated:YES];
}

- (IBAction)btnClicked:(id)sender {

    UIButton *btn = (UIButton *)sender;
    
    switch (btn.tag) {
        case 11:
        {
            // 进入我的钱包的页面
//            MywalletViewController *VC = [[MywalletViewController alloc]initWithNibName:@"MywalletViewController" bundle:nil];
//            
//            [self.navigationController pushViewController:VC animated:YES];
            
            New_MyWalletViewController *vc = [[New_MyWalletViewController alloc] init];
            
            [self.navigationController pushViewController:vc animated:YES];
            
        }
            break;
        case 22:
        {
            // 进入我的key值的页面
            // 点击后更新数据存储到数据库里面
            if ( self.m_dic.count != 0 ) {
                
                [self.m_dic setValue:[NSString stringWithFormat:@"%@",[self.RedTipCnt objectForKey:@"KeyList"]] forKey:@"KeyList"];
                
                NSArray *arr = [NSArray arrayWithObject:self.m_dic];
                
                [friendHelp updateRedDot:arr];
            }
            
            // 进入我的KEY值列表
            MyKeyListViewController *VC = [[MyKeyListViewController alloc]initWithNibName:@"MyKeyListViewController" bundle:nil];
            VC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:VC animated:YES];
            

        }
            break;
        case 33:
        {
            // 进入我的令牌的页面
            if ( self.m_dic.count != 0 ) {
                
                // 点击后更新数据存储到数据库里面
                [self.m_dic setValue:[NSString stringWithFormat:@"%@",[self.RedTipCnt objectForKey:@"MemberToken"]] forKey:@"MemberToken"];
                
                NSArray *arr = [NSArray arrayWithObject:self.m_dic];
                
                [friendHelp updateRedDot:arr];
            }
            
            
            // 我的令牌
            TokenViewController *VC = [[TokenViewController alloc]initWithNibName:@"TokenViewController" bundle:nil];
            VC.m_stringType = @"2";
            [self.navigationController pushViewController:VC animated:YES];
            
        }
            break;
        case 44:
        {
            // 点击后更新数据存储到数据库里面 - 订单列表的页面
            if ( self.m_dic.count != 0 ) {
                
                [self.m_dic setValue:[NSString stringWithFormat:@"%@",[self.RedTipCnt objectForKey:@"MemberOrder"]] forKey:@"MemberOrder"];
                
                NSArray *arr = [NSArray arrayWithObject:self.m_dic];
                
                [friendHelp updateRedDot:arr];
                
            }
            
            orderChooseViewController *VC = [[orderChooseViewController alloc]initWithNibName:@"orderChooseViewController" bundle:nil];
            [self.navigationController pushViewController:VC animated:YES];

            
        }
            break;
        case 55:
        {
            // 进入我的收益的页面
            // 点击后更新数据存储到数据库里面
            if ( self.m_dic.count != 0 ) {

                [self.m_dic setValue:[NSString stringWithFormat:@"%@",[self.RedTipCnt objectForKey:@"TransactionRecords"]] forKey:@"TransactionRecords"];

                NSArray *arr = [NSArray arrayWithObject:self.m_dic];

                [friendHelp updateRedDot:arr];
            }

            // 我的收益
            MyPaymentListViewController *VC = [[MyPaymentListViewController alloc]initWithNibName:@"MyPaymentListViewController" bundle:nil];
            [self.navigationController pushViewController:VC animated:YES];
            
//            //虎啦游戏
//            HuLa_HomeViewController *vc = [[HuLa_HomeViewController alloc] init];
//
//            [self.navigationController pushViewController:vc animated:YES];

            
        }
            break;
        case 66:
        {
            // 进入我的积分的页面
            if ( self.m_dic.count != 0 ) {
                
                // 点击后更新数据存储到数据库里面
                [self.m_dic setValue:[NSString stringWithFormat:@"%@",[self.RedTipCnt objectForKey:@"IntegralRecordList"]] forKey:@"IntegralRecordList"];
                
                NSArray *arr = [NSArray arrayWithObject:self.m_dic];
                
                [friendHelp updateRedDot:arr];
            }
            
            
            // 我的积分
            IntegrationViewController *VC = [[IntegrationViewController alloc]initWithNibName:@"IntegrationViewController" bundle:nil];
            [self.navigationController pushViewController:VC animated:YES];
            
        }
            break;
        case 77:
        {
            
            // 进入购物车的页面
            ShopCartViewController *VC = [[ShopCartViewController alloc]initWithNibName:@"ShopCartViewController" bundle:nil];
            [self.navigationController pushViewController:VC animated:YES];
            
        }
            break;
        case 88:
        {
            
            if ([[CommonUtil getValueByKey:MEMBER_ID] isEqualToString:@"19404"]) {
            
            }else {
            
                FSB_GameViewController *vc = [[FSB_GameViewController alloc] init];
                
                FSB_GameNAVController *gameNav = [[FSB_GameNAVController alloc] initWithRootViewController:vc];
                
                [self presentViewController:gameNav animated:YES completion:nil];
                
            }
 
        }
            break;
        case 99:
        {
            // 进入我的收藏的页面
            MyFavoriteViewController *VC = [[MyFavoriteViewController alloc]initWithNibName:@"MyFavoriteViewController" bundle:nil];
            [self.navigationController pushViewController:VC animated:YES];
            
            
        }
            break;
        case 100:
        {
            // 进入我的分享的页面
            ShareViewController *VC = [[ShareViewController alloc]initWithNibName:@"ShareViewController" bundle:nil];
            [self.navigationController pushViewController:VC animated:YES];

            
        }
            break;
            
        case 111:
        {
            // 进入我的会员卡的页面
           
            // 我的卡
            MyCardViewController * VC = [[MyCardViewController alloc]initWithNibName:@"MyCardViewController" bundle:nil];
            
            [self.navigationController pushViewController:VC animated:YES];
            
            
            
        }
            break;
            
            
        default:
            break;
    }

    

}

- (void)refreshRedRodShow{
    
    // 判断值是否相等-key值
    if ( [self.m_keyString isEqualToString:[NSString stringWithFormat:@"%@",[self.RedTipCnt objectForKey:@"KeyList"]]] ) {
        
        self.m_keyImgV.hidden = YES;
        
    }else{
        
        // 判断：如果值为0的话则不显示红点
        NSString *string = [NSString stringWithFormat:@"%@",[self.RedTipCnt objectForKey:@"KeyList"]];
        
        if ( [string isEqualToString:@"0"] ) {
            
            self.m_keyImgV.hidden = YES;
            
        }else{
            
            self.m_keyImgV.hidden = NO;
            
        }
        
        
    }
    // 判断值是否相等-订单
    if ( [self.m_orderString isEqualToString:[NSString stringWithFormat:@"%@",[self.RedTipCnt objectForKey:@"MemberOrder"]]] ) {
        
        self.m_orderImgV.hidden = YES;
        
    }else{
        
        // 判断：如果值为0的话则不显示红点
        NSString *string = [NSString stringWithFormat:@"%@",[self.RedTipCnt objectForKey:@"MemberOrder"]];
        
        if ( [string isEqualToString:@"0"] ) {
            
            self.m_orderImgV.hidden = YES;
            
        }else{
            
            self.m_orderImgV.hidden = NO;
            
        }
        
    }
    
    // 判断值是否相等-我的收益
    if ( [self.m_recordsString isEqualToString:[NSString stringWithFormat:@"%@",[self.RedTipCnt objectForKey:@"TransactionRecords"]]] ) {
        
        self.m_zhuanImgV.hidden = YES;
        
    }else{
        
        // 判断：如果值为0的话则不显示红点
        NSString *string = [NSString stringWithFormat:@"%@",[self.RedTipCnt objectForKey:@"TransactionRecords"]];
        
        if ( [string isEqualToString:@"0"] ) {
            
            self.m_zhuanImgV.hidden = YES;
            
        }else{
            
            self.m_zhuanImgV.hidden = NO;
            
        }
    }
    
    // 判断值是否相等-我的令牌
    if ( [self.m_tokenString isEqualToString:[NSString stringWithFormat:@"%@",[self.RedTipCnt objectForKey:@"MemberToken"]]] ) {
        
        self.m_lingImgV.hidden = YES;
        
    }else{
        
        // 判断：如果值为0的话则不显示红点
        NSString *string = [NSString stringWithFormat:@"%@",[self.RedTipCnt objectForKey:@"MemberToken"]];
        
        if ( [string isEqualToString:@"0"] ) {
            
            self.m_lingImgV.hidden = YES;
            
        }else{
            
            self.m_lingImgV.hidden = NO;
            
        }
    }
    
    // 判断值是否相等-我的分享
    if ( [self.m_userString isEqualToString:[NSString stringWithFormat:@"%@",[self.RedTipCnt objectForKey:@"MemberPublicInviteList"]]] ) {
        
        self.m_shareImgV.hidden = YES;
        
        // 如果我的用户数据有变化的话则保存起来用于在进入我的分享里进行判断-没变化
        [CommonUtil addValue:@"0" andKey:@"MyAccountKey"];
        
    }else{
        
        // 判断：如果值为0的话则不显示红点
        NSString *string = [NSString stringWithFormat:@"%@",[self.RedTipCnt objectForKey:@"MemberPublicInviteList"]];
        
        if ( [string isEqualToString:@"0"] ) {
            
            self.m_shareImgV.hidden = YES;
            
            // 如果我的用户数据有变化的话则保存起来用于在进入我的分享里进行判断-有变化
            [CommonUtil addValue:@"0" andKey:@"MyAccountKey"];
            
        }else{
            
            self.m_shareImgV.hidden = NO;
            
            // 如果我的用户数据有变化的话则保存起来用于在进入我的分享里进行判断-有变化
            [CommonUtil addValue:@"1" andKey:@"MyAccountKey"];
            
        }
        
    }
    

}

// 收到通知进行页面的跳转
- (void)pushJump:(NSNotification *)notification{
    
    NSString *typeString = [NSString stringWithFormat:@"%@",[notification.userInfo objectForKey:@"messageTypeKey"]];
    
    // 记录存储的最后一个类是哪个
    NSString *className = [NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:@"ClassName"]];
    
    // 判断如果tabBar选中的不是“我的”模块的话，则设置选中为第四个
    if ( self.tabBarController.selectedIndex != 4 ) {
        
        [self.tabBarController setSelectedIndex:4];

    }
    
    // 根据类型进行不同的跳转 如果是1表示的是我的收益，2表示的是我的用户
    if ( [typeString isEqualToString:@"1"] ) {
        
        // 判断如果不在本类的话则进行跳转，如果在的话则不进行操作
        if ( ![className isEqualToString:@"MyPaymentListViewController"] ) {
            
            // 进入我的收益的页面
            MyPaymentListViewController *VC = [[MyPaymentListViewController alloc]initWithNibName:@"MyPaymentListViewController" bundle:nil];
            [self.navigationController pushViewController:VC animated:YES];
        }
        
    }else if ( [typeString isEqualToString:@"2"] ){
        
        // 进入我的用户
        // 用于判断是否点击了用户，点击了用户后则返回更多页面的时候进行刷新，去掉小红点
        [CommonUtil addValue:@"1" andKey:@"RedDotKey"];
        
        [CommonUtil addValue:@"0" andKey:@"MyAccountKey"];
        
        // 判断如果不在本类的话则进行跳转，如果在的话则不进行操作
        if ( ![className isEqualToString:@"MyAccountViewController"] ) {
            
            // 我的用户
            MyAccountViewController *VC = [[MyAccountViewController alloc]initWithNibName:@"MyAccountViewController" bundle:nil];
            [self.navigationController pushViewController:VC animated:YES];
        }
        
    }
  
}

- (void)requestSubmitRedDian{
    
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

    [httpClient request:@"RedTip.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {

            self.RedTipCnt = [json valueForKey:@"RedTipCnt"];
            
            int RedDot = [self sumOfSixValueWithDic:self.RedTipCnt];
            
            if ( [friendHelp redDotArray].count != 0 ) {
                
                int RedDot1 = [self sumOfSixValueWithDic:[[friendHelp redDotArray] objectAtIndex:0]];
                
                // 如果这两值相等的话则表示没有新消息，不显示红点
                if ( RedDot != RedDot1 ) {
                    
                    self.navigationController.tabBarItem.badgeValue = @"";
                    
                }else{
                    
                    self.navigationController.tabBarItem.badgeValue = nil;
                }
                
                
            }else{
                
                // 第一次进入时数据库中没有数据，如果这个值为0则表示没消息不显示红点,否则显示红点
                if ( RedDot != 0 ) {
                    
                    self.navigationController.tabBarItem.badgeValue = @"";
                    
                }else{
                    
                    self.navigationController.tabBarItem.badgeValue = nil;
                    
                }
                
            }
            // 刷新红点的显示与隐藏
            [self refreshRedRodShow];
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showErrorWithStatus:msg];
            
        }
    } failure:^(NSError *error) {

    }];
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
                           nil];
    
    [httpClient request:@"More.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            [SVProgressHUD dismiss];
            self.appMore = [json valueForKey:@"appMore"];
            [CommonUtil addValue:[self.appMore objectForKey:@"realAuName"] andKey:REAL_ACCOUNT_NAME];
            [CommonUtil addValue:[self.appMore objectForKey:@"realAuIdCard"] andKey:REAL_ACCOUNT_IDCARD];
            [CommonUtil addValue:[self.appMore objectForKey:@"realAuStatus"] andKey:USER_REALAUSTATUS];
            
            //充值
            NSString *vldStatus = [self.appMore objectForKey:@"realAuStatus"];
            
            // 保存用户的状态
            [CommonUtil addValue:vldStatus andKey:REALAUSTATUS];
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showErrorWithStatus:msg];
            
        }
    } failure:^(NSError *error) {

    }];
}

// 验证用户是否填写了支付问题的网络请求
- (void)paymentSafeRequest{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    // 根据类型字符aType 来判断  2表示点击修改支付密码 1表示充值按钮来请求
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,     @"memberId",
                           key,   @"key",
                           nil];
    [httpClient request:@"PaymentSafetyTesting.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
                
        if (success) {
//            NSString *msg = [json valueForKey:@"msg"];
            //                [SVProgressHUD showSuccessWithStatus:msg];
            [SVProgressHUD dismiss];
            
            //充值
            NSString *vldStatus = [self.appMore objectForKey:@"realAuStatus"];
            
            // 保存用户的状态
            [CommonUtil addValue:vldStatus andKey:REALAUSTATUS];
            
            // 请求成功后进入支付方式选择的页面
            PayStyleViewController *VC = [[PayStyleViewController alloc]initWithNibName:@"PayStyleViewController" bundle:nil];
            VC.m_typeString = @"1";
            [self.navigationController pushViewController:VC animated:YES];
            
            
        } else {
            
//            NSString *msg = [json valueForKey:@"msg"];
            //                [SVProgressHUD showErrorWithStatus:msg];
            [SVProgressHUD dismiss];

            
            // 进入设置安全问题及支付密码的页面
            PaymentQueViewController *viewController = [[PaymentQueViewController alloc]initWithNibName:@"PaymentQueViewController" bundle:nil];
            [self.navigationController pushViewController:viewController animated:YES];
            
            
        }
       
    } failure:^(NSError *error) {
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];

}


#pragma mafrk - Btn clicked
- (void)rechargeClicked:(id)sender{

    // 验证安全问题 ==================
    [self paymentSafeRequest];
    
    
}

- (void)payClicked:(id)sender{
    
    // 进入付款的页面
    PayMentViewController *VC = [[PayMentViewController alloc]initWithNibName:@"PayMentViewController" bundle:nil];
    
    [self.navigationController pushViewController:VC animated:YES];
}


@end
