//
//  DynamicViewController.m
//  HuiHui
//
//  Created by mac on 13-11-21.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import "DynamicViewController.h"

#import "DynamicCell.h"

#import "ProductDetailViewController.h"

#import "ActivityDetailViewController.h"

#import <QuartzCore/QuartzCore.h>

#import "SVProgressHUD.h"

#import "MorecommentViewController.h"

#import "ProductBigViewController.h"

#import "FriDynamicViewController.h"

#import "CXAHyperlinkLabel.h"

#import "NSString+CXAHyperlinkParser.h"

#import "WebViewController.h"

#import "MarkupParser.h"

#import "NewCommentViewController.h"

#import "UIImageView+AFNetworking.h"

#import "FriendShipCell.h"

// 展示 帖子 图片1 图片2 图片3 图片4
// 展示 图片
#import "UIImageView+MJWebCache.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"

static CGFloat ImageHeight  = 135.0;
static CGFloat ImageWidth  = 320.0;

@interface DynamicViewController ()
{
    CXAHyperlinkLabel *zan_label;
    
    EGORefreshTableHeaderView *refreshView;
    
    
}
@property (weak, nonatomic) IBOutlet PullTableView      *m_tableView;

@property (strong, nonatomic) IBOutlet UIView           *m_commentView;

@property (nonatomic, strong) UITextField               *m_textField;

@property (weak, nonatomic) IBOutlet UITextField        *m_commentTextField;

@property (weak, nonatomic) IBOutlet UIButton           *m_heardBtn;//头像

@property (weak, nonatomic) IBOutlet UIButton           *m_coverBtn;//封面

@property (weak, nonatomic) IBOutlet UILabel            *m_nameLabel;

@property (weak, nonatomic) IBOutlet UIImageView        *m_imageView;

@property (weak, nonatomic) IBOutlet UIImageView        *m_headerImageView;
// 表示上传图片转圈圈
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView    *m_activityV;

@property (nonatomic, strong) UIImageView                       *l_imageView;

@property (weak, nonatomic) IBOutlet UIImageView                *m_whiteImagV;

@property (weak, nonatomic) IBOutlet UILabel                    *m_emptyLabel;

@property (weak, nonatomic) IBOutlet UIView *m_publishView;

@property (weak, nonatomic) IBOutlet UIView *m_newCommentView;

@property (weak, nonatomic) IBOutlet UIButton *m_newCommentBtn;

@property (weak, nonatomic) IBOutlet UIImageView *m_newMessageImagV;

@property (weak, nonatomic) IBOutlet UILabel *m_newMessageCountLabel;

// 有新评论的按钮触发的事件
- (IBAction)newCommentClicked:(id)sender;

//进入发表页面
-(IBAction) Publishing:(id)sender;

// 发送按钮触发的事件
- (IBAction)sendCommentClicked:(id)sender;





@end

@implementation DynamicViewController

@synthesize m_dic;

@synthesize m_imageDic;

@synthesize l_imageView;

@synthesize isChooseFrontCover;

@synthesize m_zanDic;

@synthesize m_index;


- (void)Publishdelegate:(NSDictionary *)FOdic send:(NSString*)imageNO;
{
    if ([imageNO isEqualToString:@"0"]) {
    page = 1;//第一页
    [self DynamicList];//请求数据
    //分享信息后刷新数据库中的数据
    [self requestSubmitRedDian];
        
    }else{
    flaseover = @"NO";
    [self.m_DynamicArray replaceObjectAtIndex:0 withObject:FOdic];
    NSData *encodemenulist = [NSKeyedArchiver archivedDataWithRootObject:self.m_DynamicArray];
    [CommonUtil addValue:encodemenulist andKey:[NSString stringWithFormat:@"%@space",[CommonUtil getValueByKey:MEMBER_ID]]];
    [self.m_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    
    [self Savedatafromarray];
    
    // 分享信息后刷新数据库中的数据
    [self requestSubmitRedDian];
    }
    
}

-(void)deldelegate
{
    page = 1;//第一页
    [self DynamicList];//请求数据
    // 删除某条分享后刷新数据库中的数据
    [self requestSubmitRedDian];
    
}

- (void)forwarddelegate
{
    page = 1;//第一页
    [self DynamicList];//请求数据
    // 转发某条分享后刷新数据库中的数据
    [self requestSubmitRedDian];
}

static DynamicViewController*sssmainviewcontroller=nil;

+(DynamicViewController*)shareobject;//保证空间只有一个；
{
    if (sssmainviewcontroller==nil)
    {
        sssmainviewcontroller=[[DynamicViewController alloc]init];
    }
    return sssmainviewcontroller;
}

+(void)attemptDealloc
{
    sssmainviewcontroller = nil;

}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.m_imageArray = [[NSMutableArray alloc]initWithCapacity:0];
        
        self.m_AllMidArray = [[NSMutableArray alloc]initWithCapacity:0];
        
        self.m_CommentArray = [[NSMutableArray alloc]initWithCapacity:0];
        
        self.m_BigimageArray = [[NSMutableArray alloc]initWithCapacity:0];
        
        self.m_DynamicPraiseArray = [[NSMutableArray alloc]initWithCapacity:0];
        
        m_dic = [[NSMutableDictionary alloc]initWithCapacity:0];
        
        m_imageDic = [[NSMutableDictionary alloc]initWithCapacity:0];
        
        l_imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WindowSizeWidth, 135)];
        
        isChooseFrontCover = NO;
        
        m_zanDic = [[NSMutableDictionary alloc]initWithCapacity:0];
        
        m_index = 0;
        
        friendHelper = [[FriendHelper alloc]init];
        
        imagechage = [[ImageCache alloc] init];
        
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"好友动态"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(LeftClicked)];
    
    UIButton *_button = [UIButton buttonWithType:UIButtonTypeCustom];
    [_button setFrame:CGRectMake(0, 0, 30, 30)];
    _button.backgroundColor = [UIColor clearColor];
    [_button setImage:[UIImage imageNamed:@"icon_share.png"] forState:UIControlStateNormal];
    [_button addTarget:self action:@selector(Publishing:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *_barButton = [[UIBarButtonItem alloc] initWithCustomView:_button];
    [self.navigationItem setRightBarButtonItem:_barButton];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 30)];
    
    view.backgroundColor = [UIColor clearColor];
    
    UIButton *titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    titleBtn.backgroundColor = [UIColor clearColor];
    titleBtn.frame = CGRectMake(0, 6, 200, 30);
    titleBtn.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20.0f];//fontWithName:@"Helvetica-Bold" size:22.0f];
    titleBtn.titleLabel.textColor = [UIColor whiteColor];
    [titleBtn.titleLabel setShadowOffset:CGSizeMake(0, -1)];
    [titleBtn.titleLabel setShadowColor:[UIColor colorWithRed:0x41/255.0f green:0x41/255.0f blue:0x41/255.0f alpha:1.0f]]; //[UIColor whiteColor]];
    titleBtn.titleLabel.backgroundColor = [UIColor clearColor];
    titleBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [titleBtn setTitle:@"好友动态" forState:UIControlStateNormal];
    [titleBtn.titleLabel sizeToFit];
    self.m_titleBtn = titleBtn;
    [view addSubview:self.m_titleBtn];
    
    
    //自定义键盘输入
    UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 200, 30)];
    textField.delegate = self;
    self.m_textField = textField;
    [self.view addSubview:self.m_textField];
    self.m_textField.hidden = YES;
    self.m_textField.inputAccessoryView = self.m_commentView;
    self.m_commentTextField.delegate = self;
    
    // 设置图片的圆角
    [self setheard];
    
    [self.m_coverBtn addTarget:self action:@selector(ChangeTheCoverImage) forControlEvents:UIControlEventTouchUpInside];
    
    [self.m_tableView setPullDelegate:self];
    self.m_tableView.pullBackgroundColor = [UIColor whiteColor];
    self.m_tableView.useRefreshView = YES;
    self.m_tableView.useLoadingMoreView= YES;
    
    self.m_emptyLabel.hidden = YES;
    self.m_activityV.hidden = YES;
    // 请求用户信息
    [self memberRequestSubmit];
    
    NSString *savedTime = [CommonUtil getValueByKey:Spaceuploadtime];
    NSString *time = [NSString stringWithFormat:@"%f", (double)[[NSDate date] timeIntervalSince1970]];
    if (([time doubleValue] - [savedTime doubleValue]) * 1000<300000) {
        page = 1;//第一页
        [self DynamicList];//请求数据
    }
    
}


//关于我的头像
-(void)setheard
{
    
    [self.m_heardBtn.layer setMasksToBounds:YES];
    
    [self.m_heardBtn.layer setCornerRadius:30.0f];
    
    [self.m_headerImageView.layer setMasksToBounds:YES];
    
    [self.m_headerImageView.layer setCornerRadius:30.0f];
    
    [self.m_heardBtn addTarget:self action:@selector(AboutMe) forControlEvents:UIControlEventTouchUpInside];
    
    //    // 设置为白色的背景
    [self.m_whiteImagV.layer setMasksToBounds:YES];
    [self.m_whiteImagV.layer setCornerRadius:30.0f];
    
}

-(void)AboutMe
{
    AboutmeViewController * VC = [[AboutmeViewController alloc]initWithNibName:@"AboutmeViewController" bundle:nil];
    VC.deldele =self;
    [self.navigationController pushViewController:VC animated:YES];
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
#define CExpandContentOffset @"contentOffset"
    
    [self.m_commentTextField resignFirstResponder];
    [self.m_textField resignFirstResponder];
    
    // label上面的链接网址可以点击的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(openURLString:) name:@"OpenUrl" object:nil];
    
    NSString *string = [CommonUtil getValueByKey:DynamicComments];
    
    
    
    NSLog(@"消息条数：%d",[string intValue]);
    
    // 头像进行赋值
    NSString *path = [CommonUtil getValueByKey:CommentPhotoMid];
    
    // 判断是否有新评论的值
    //![string isEqualToString:@"0"] ||
//    if (  ![string isEqualToString:@"0"] || string.length != 0 ) {
    if ([string intValue] != 0) {
    
        // 如果新评论的个数等于0则隐藏显示数字的view,否则显示出来
        self.m_publishView.hidden = YES;
        
        self.m_newCommentView.hidden = NO;
        
        // 显示数字
        self.m_newMessageCountLabel.text = [NSString stringWithFormat:@"%@条新消息",string];
        
        // 头像进行赋值
        [self.m_newMessageImagV setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:path]]
                                      placeholderImage:[UIImage imageNamed:@"moren.png"]
                                               success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                                                   
                                                   self.m_newMessageImagV.image = [CommonUtil scaleImage:image toSize:CGSizeMake(30, 30)];
                                                   
                                               }
                                               failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                                                   
                                               }];
        
        
    }else{
        
        // 隐藏显示view
        self.m_publishView.hidden = NO;
        
        self.m_newCommentView.hidden = YES;
        
    }
    
    
    if ( !self.isChooseFrontCover ) {
        
        [self hideTabBar:YES];
        
        if ( Appdelegate.isChangeCover ) {
            
            // 请求用户信息
            [self memberRequestSubmit];
            
            Appdelegate.isChangeCover = NO;
            
        }
        
    }else{
        
        // =========
//        if ( isIOS7 ) {
//            
//            for(UIView *view in self.tabBarController.view.subviews)
//            {
//                
//                if([view isKindOfClass:[UITabBar class]])
//                {
//                    
//                    if (self.tabBarController.tabBar.hidden) {
//                        [view setFrame:CGRectMake(view.frame.origin.x, [UIScreen mainScreen].bounds.size.height, view.frame.size.width, 0)];
//                    }
//                }
//            }
//            
//        }
        //========
    }
    
    self.isChooseFrontCover = NO;

    self.m_tableView.pullTableIsRefreshing = NO;
    self.m_tableView.pullTableIsLoadingMore = NO;
    
    if ( !self.isChooseFrontCover ) {
        NSString *savedTime = [CommonUtil getValueByKey:Spaceuploadtime];
        NSString *time = [NSString stringWithFormat:@"%f", (double)[[NSDate date] timeIntervalSince1970]];
        
        if (([time doubleValue] - [savedTime doubleValue]) * 1000>=300000) {
            
            page = 1;//第一页
            
            [self DynamicList];//请求数据
            
            
        }
        else
        {
            //从数据库里捞
            if ([[CommonUtil getValueByKey:Spacedp]isEqualToString:@"1"]) {
                
                NSData *saveMenulistDaate = [CommonUtil getValueByKey:[NSString stringWithFormat:@"%@space",[CommonUtil getValueByKey:MEMBER_ID]]];
                
                if (nil == saveMenulistDaate) {
                    
                    NSMutableArray *menulistarry = [[NSMutableArray alloc]init];
                    
                    self.m_DynamicArray = menulistarry;
                }
                else
                {
                    self.m_DynamicArray = (NSMutableArray *)[NSKeyedUnarchiver unarchiveObjectWithData:saveMenulistDaate];
                }
                
                
                NSData *saveMenu = [CommonUtil getValueByKey:[NSString stringWithFormat:@"%@_zandic",[CommonUtil getValueByKey:MEMBER_ID]]];
                
                if (nil == saveMenu) {
                    
                    NSMutableDictionary *menulistarry = [[NSMutableDictionary alloc]init];
                    
                    self.m_zanDic = menulistarry;
                }
                else
                {
                    self.m_zanDic = (NSMutableDictionary *)[NSKeyedUnarchiver unarchiveObjectWithData:saveMenu];
                }
                
            }
        }
        
        
        NewPingjia = NO;
        
    }
}


- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"OpenUrl" object:nil];
    
    // 判断是否隐藏tabBar
    if ( !self.isChooseFrontCover ) {
        
        [self hideTabBar:NO];
        
    }else{
        
        
    }
   
    
}

- (void)updateImg {
    
    CGFloat yOffset = self.m_tableView.contentOffset.y;
    
    if ([flaseover isEqualToString:@"YES"]) {
        
        if (yOffset<=0) {
            
            [self.m_tableView setContentOffset:CGPointMake(0, 0) animated:NO];
            
            return;
        }
    }
    
    if (yOffset <=0.000000&&ABS(yOffset)<=50.000000) {

        CGFloat factor = ((ABS(yOffset)+ImageHeight)*WindowSizeWidth)/ImageHeight;
        
        CGRect f = CGRectMake(-(factor-WindowSizeWidth)/2, 0, factor, ImageHeight+ABS(yOffset));
        
        self.m_imageView.frame = f;
        
    }
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 聊天页面里点击网址后进行跳转的通知
- (void)openURLString:(NSNotification *)notification{
    
    NSString *string = [NSString stringWithFormat:@"%@",[notification.userInfo objectForKey:@"urlString"]];
    
    // 进入网页页面
    WebViewController *VC = [[WebViewController alloc]initWithNibName:@"WebViewController" bundle:nil];
    VC.m_scanString = string;
    VC.m_typeString = @"2";
    [self.navigationController pushViewController:VC animated:YES];
    
}


- (void)LeftClicked{
    
    [self goBack];
}


#pragma mark - NetWork
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
            
            NSDictionary *dic = [json valueForKey:@"RedTipCnt"];
            
            // 更新数据到数据库中
            [friendHelper updateDynamictCount:[NSString stringWithFormat:@"%@",[dic objectForKey:@"DynamicList"]] withDynamicComments:[NSString stringWithFormat:@"%@",[dic objectForKey:@"DynamicComments"]]];
            
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showErrorWithStatus:msg];
            
        }
    } failure:^(NSError *error) {
        
        //NSLog(@"failed:%@", error);
    }];
}


// 会员信息请求数据
- (void)memberRequestSubmit{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    AppHttpClient* httpClient = [AppHttpClient sharedSpace];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,     @"memberId",
                           key,   @"key",
                           nil];
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient requestSpace:@"DynamicConfig.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            [SVProgressHUD dismiss];

            self.m_tableView.hidden = NO;
            
            self.m_dic = [json valueForKey:@"DynConfig"];
            
            // 赋值(登录会员的昵称)
            self.m_nameLabel.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"NickName"]];
            
            NSString *headImage = [self.m_dic objectForKey:@"FrontCover"];
            
            UIImage *reSizeImage = [imagechage getImage:headImage];
            
            if (reSizeImage != nil)
            {
                self.m_imageView.image = [CommonUtil scaleImage:reSizeImage toSize:CGSizeMake(WindowSizeWidth, 135)];
            }
            else{
                [self.m_imageView setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:headImage]]
                                        placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"]
                                                 success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                                                     
                                                     self.m_imageView.image = [CommonUtil scaleImage:image toSize:CGSizeMake(WindowSizeWidth, 135)];
                                                     
                                                 }
                                                 failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                                                     
                                                 }];
            }
            
            
            // 头像
            NSString *userHeadImage = /*[self.m_dic objectForKey:@"PhotoMidUrl"];*/[CommonUtil getValueByKey:USER_PHOTO];
            UIImage *reSizeImage2 = [imagechage getImage:userHeadImage];
            
            if (reSizeImage2 != nil)
            {
                self.m_headerImageView.image = [CommonUtil scaleImage:reSizeImage2 toSize:CGSizeMake(60, 60)];
            }
            else{
                
                [self.m_headerImageView setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:userHeadImage]]
                                              placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"]
                                                       success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                                                           
                                                           self.m_headerImageView.image = [CommonUtil scaleImage:image toSize:CGSizeMake(60, 60)];
                                                           
                                                       }
                                                       failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                                                           
                                                           self.m_headerImageView.image = [CommonUtil scaleImage:[UIImage imageNamed:@"invite_reg_no_photo.png"] toSize:CGSizeMake(60, 60)];
                                                           
                                                       }];
            }
            
            
        } else {
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
    } failure:^(NSError *error) {
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:@"请求失败，请稍后再试！"];
    }];
    
}


// 修改用户的背景图片请求数据
- (void)modifyPictureRequest{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        // 没有网络的情况下，还原图片值
        [self getImage];
        
        return;
    }
    
    NSString * memberId = [CommonUtil getValueByKey:MEMBER_ID];
    
    NSString * key = [CommonUtil getServerKey];
    
    AppHttpClient* httpClient = [AppHttpClient sharedSpace];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"memberId",
                           key,@"key",
                           nil];
    
    
    [SVProgressHUD showWithStatus:@"图片上传中"];
    
    [httpClient multiRequestSpace:@"DynamicConfigAdd.ashx" parameters:param files:self.m_imageDic success:^(NSJSONSerialization* json){
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            
            NSString *msg=[json valueForKey:@"msg"];
            [SVProgressHUD showSuccessWithStatus:msg];
            
            // 停止转圈圈
            if ( [self.m_activityV isAnimating] ) {
                
                [self.m_activityV stopAnimating];
            }
            
            self.m_activityV.hidden = YES;
            
            
            [self memberRequestSubmit];//请求用户信息（封面）
            
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
            
            // 请求失败的话，还原图片值
            [self getImage];
        }
    } failure:^(NSError *error) {
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:@"上传失败，请稍后再试！"];
        // 请求失败的话，还原图片值
        [self getImage];
        
    }];
    
}

- (void)getImage{
    
    // 停止转圈圈
    if ( [self.m_activityV isAnimating] ) {
        
        [self.m_activityV stopAnimating];
    }
    
    self.m_activityV.hidden = YES;
    
    
    NSString *headImage = [self.m_dic objectForKey:@"FrontCover"];
    
    [self.m_imageView setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:headImage]]
                            placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"]
                                     success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                                         
                                         self.m_imageView.image = [CommonUtil scaleImage:image toSize:CGSizeMake(WindowSizeWidth, 135)];
                                         
                                     }
                                     failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                                         
                                     }];
    
}



#pragma mark - UITableViewDataSource
- (void)endUpdates;
{
    NSIndexPath* indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.m_tableView scrollToRowAtIndexPath:indexPath
                            atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.m_DynamicArray.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.m_DynamicPraiseArray = [[NSMutableArray alloc]initWithCapacity:0];
    self.m_CommentArray = [[NSMutableArray alloc]initWithCapacity:0];
    
    UITableViewCell *cell = nil;
    
    //如果有动态信息的时候赋值
    if ( self.m_DynamicArray.count != 0 ) {
        
        NSDictionary * Dydic = [self.m_DynamicArray objectAtIndex:indexPath.row];
        
        //来自什么类型（空表示发表或分享）原态的
        if ([[NSString stringWithFormat:@"%@",[Dydic objectForKey:@"FormDynamicType"]]isEqualToString:@""]){
            
            self.m_typeString = [NSString stringWithFormat:@"%@",[Dydic objectForKey:@"DynamicType"]];
            
            cell = [self tableViewPUL:tableView cellForRowAtIndexPath:indexPath DIC:Dydic];
            
            if ([flaseover isEqualToString:@"YES"]&&indexPath.row==0) {
                cell.userInteractionEnabled = NO;
            }else{
                cell.userInteractionEnabled = YES;
            }
            
        }//不为空表示，是转发的
        else if(![[NSString stringWithFormat:@"%@",[Dydic objectForKey:@"FormDynamicType"]]isEqualToString:@""]){
            
            self.m_typeString = [NSString stringWithFormat:@"%@",[Dydic objectForKey:@"FormDynamicType"]];
            
            cell = [self tableViewSHA:tableView cellForRowAtIndexPath:indexPath DIC:Dydic];
            
        }
        
    }else{
        //否则返回空的cell
        static NSString *cellIdentifier = @"cellIdentifier";
        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        if ( cell == nil ) {
            cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        }
        return cell;
    }
    
    return cell;
    
}



// 发表了说说、分享产品、分享链接
- (UITableViewCell *)tableViewPUL:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath DIC:(NSDictionary *)Dydic{
    
    if ( [self.m_typeString isEqualToString: KEY_DYNAMIC_FRIENDS]||[self.m_typeString isEqualToString: KEY_DYNAMIC_FromFRIENDS]) {
        
        static NSString *cellIdentifier = @"DynamicCellIdentifier";
        
        DynamicCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if ( cell == nil ) {
            
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"DynamicCell" owner:self options:nil];
            
            cell = (DynamicCell *)[nib objectAtIndex:0];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        
        cell.m_DelBtn.hidden = YES;
        //昵称
        cell.m_nameLabel.text = [NSString stringWithFormat:@"%@",[Dydic objectForKey:@"NickName"]];
        
        cell.m_timeLabel.text = [NSString stringWithFormat:@"%@",[Dydic objectForKey:@"CreateDate"]];
        
//        cell.m_fromLabel.text = [NSString stringWithFormat:@"来自:%@",[Dydic objectForKey:@"Source"]];
        
        cell.m_fromLabel.hidden = YES;
        
        CGSize namesize = [cell.m_nameLabel.text sizeWithFont:[UIFont systemFontOfSize:17.0f] constrainedToSize:CGSizeMake(90, MAXFLOAT) lineBreakMode:NSLineBreakByTruncatingTail];
        
        cell.m_nameLabel.frame = CGRectMake(cell.m_nameLabel.frame.origin.x, cell.m_nameLabel.frame.origin.y, namesize.width, 26);
        cell.m_zhuanzai.frame = CGRectMake(cell.m_nameLabel.frame.origin.x+cell.m_nameLabel.frame.size.width, cell.m_zhuanzai.frame.origin.y, cell.m_zhuanzai.frame.size.width, cell.m_zhuanzai.frame.size.height);
        
        cell.m_zhuanzai.text = @"发表了";
        //内容
        cell.m_contentLabel.text = [NSString stringWithFormat:@"%@",[Dydic objectForKey:@"Contents"]];
        
        //图片列表
        self.m_imageArray = [Dydic objectForKey:@"DynamicPicList"];
        
        CGSize size = [cell.m_contentLabel.text sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(WindowSizeWidth - 87, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
        
        cell.m_contentLabel.frame = CGRectMake(cell.m_contentLabel.frame.origin.x, cell.m_contentLabel.frame.origin.y, WindowSizeWidth - 87, size.height+3);
        
        // 设置label，可以点击链接地址
        MarkupParser* p = [[MarkupParser alloc] init];
        // 清空数组重新赋值
        [p.images removeAllObjects];
        
        [cell.m_contentLabel.imageInfoArr removeAllObjects];
        
        NSMutableAttributedString* attString = [p attrStringFromMarkup:[Dydic objectForKey:@"Contents"]];
        CTFontRef verdana = CTFontCreateWithName((CFStringRef)@"Verdana",14,NULL);
        [attString addAttribute:(NSString*)(kCTFontAttributeName) value:(__bridge id)verdana range:NSMakeRange(0, attString.length)];
        
        [cell.m_contentLabel setAttString:attString withImages:p.images];
        // 这个属性设置为YES时就表示可以对网址进行操作
        cell.m_contentLabel.underlineLinks = YES;
        cell.m_contentLabel.userInteractionEnabled = YES;
        
        CGRect labelRect = cell.m_contentLabel.frame;
        
        labelRect.size.width = [cell.m_contentLabel sizeThatFits:CGSizeMake(WindowSizeWidth - 87, CGFLOAT_MAX)].width;
        labelRect.size.height = [cell.m_contentLabel sizeThatFits:CGSizeMake(WindowSizeWidth - 87, CGFLOAT_MAX)].height;
        
        labelRect.origin = CGPointMake(80, 30);
        cell.m_contentLabel.frame = labelRect;
        [cell.m_contentLabel.layer display];
        
        cell.m_imageView.layer.masksToBounds = YES;
        cell.m_imageView.layer.cornerRadius = 8.0;
        //头像
        UIImageView*imv=[[UIImageView alloc]init];
        UIImage *reSizeImage = [imagechage getImage:[Dydic objectForKey:@"PhotoMidUrl"]];
        
        if (reSizeImage != nil)
        {
            cell.m_imageView.image = reSizeImage;
        }
        else{
            
            [imv setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[Dydic objectForKey:@"PhotoMidUrl"]]]] placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                cell.m_imageView.image = image;
                [imagechage addImage:image andUrl:[Dydic objectForKey:@"PhotoMidUrl"]];
            } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                
            }];
        }
        
        //删除
        for(id tmpView in cell.m_ImgView.subviews)
        {
            [tmpView removeFromSuperview];
        }
        for(id tmpView in cell.m_commentView.subviews)
        {
            [tmpView removeFromSuperview];
        }
        for (id tepview in cell.m_zanView.subviews) {
            [tepview removeFromSuperview];
        }
        
        
        //发表说说的点击头像
        cell.m_PhotoBtn.tag = indexPath.row;
        [cell.m_PhotoBtn addTarget:self action:@selector(PhotoBtn:) forControlEvents:UIControlEventTouchUpInside];
        // 添加按钮事件
        cell.m_zanBtn.tag = indexPath.row;
        cell.m_zhuanfaBtn.tag = indexPath.row;
        cell.m_pingjiaBtn.tag = indexPath.row;
        [cell.m_zanBtn addTarget:self action:@selector(zanClicked:) forControlEvents:UIControlEventTouchUpInside];
        [cell.m_zhuanfaBtn addTarget:self action:@selector(zhuanfaClicked:) forControlEvents:UIControlEventTouchUpInside];
        [cell.m_pingjiaBtn addTarget:self action:@selector(pingjiaClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        
        NSString *zanString = [self.m_zanDic objectForKey:[NSString stringWithFormat:@"%i",indexPath.row]];
        
        if ( [zanString isEqualToString:@"1"] ) {
            
            // 1表示赞 0表示未赞
            cell.m_cancelLabel.hidden = NO;
            
        }else if ( [zanString isEqualToString:@"0"] ) {
            
            cell.m_cancelLabel.hidden = YES;
            
        }else{
            
            
        }
        
        
        self.m_CommentArray = [Dydic objectForKey:@"DynamicComment"];
        
        self.m_DynamicPraiseArray =[Dydic objectForKey:@"DynamicPraise"];
        
        
        NSString *zanstringman =@"" ;
        CGSize zansize;
        
        if (self.m_DynamicPraiseArray.count == 0) {
            zansize.height = 0;
            cell.m_zanView.hidden = YES;
        }else{
            
            cell.m_zanView.hidden = NO;
            
            zanstringman =[[self.m_DynamicPraiseArray objectAtIndex:0]objectForKey:@"NickName"];
            
            //赞的人数组
            for (int iii=1; iii<self.m_DynamicPraiseArray.count; iii++) {
                
                
                NSDictionary * zandic = [self.m_DynamicPraiseArray objectAtIndex:iii ];
                
                zanstringman = [NSString stringWithFormat:@"%@,%@",zanstringman,[zandic objectForKey:@"NickName"]];
                
            }
            
            
            zansize = [[NSString stringWithFormat:@"空两%@",zanstringman] sizeWithFont:[UIFont systemFontOfSize:13.0f] constrainedToSize:CGSizeMake(WindowSizeWidth - 87, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
            
            
            
            if (isIOS5) {
                UILabel * zanl = [[UILabel alloc]initWithFrame:CGRectMake(0, 2, 230, zansize.height)];
                zanl.numberOfLines = 0;
                zanl.backgroundColor = [UIColor clearColor];
                zanl.font = [UIFont fontWithName:@"Baskerville" size:13];
                zanl.text = [NSString stringWithFormat:@"        %@",zanstringman];
                [cell.m_zanView addSubview:zanl];
                
            }else{
                
                NSArray *URLs;
                NSArray *URLRanges;
                NSAttributedString *as = [self attributedString:&URLs URLRanges:&URLRanges nicknamearray:self.m_DynamicPraiseArray];
                zan_label = [[CXAHyperlinkLabel alloc] initWithFrame:CGRectMake(0, 2, 230, zansize.height)];
                zan_label.numberOfLines = 0;
                zan_label.backgroundColor = [UIColor clearColor];
                [zan_label setURLs:URLs forRanges:URLRanges];
                zan_label.attributedText = as;
                
                zan_label.URLClickHandler = ^(CXAHyperlinkLabel *label, NSURL *URL, NSRange range, NSArray *textRects){
                    //点击进入空间//赞的人
                    [self ZannameBtn:[URL absoluteString]];
                };
                [cell.m_zanView addSubview:zan_label];
                
            }
            
            UIImageView * imagevc = [[UIImageView alloc]initWithFrame:CGRectMake(5,0, 18, 18)];
            imagevc.image = [UIImage imageNamed:@"zanyige.png"];
            [cell.m_zanView addSubview:imagevc];
        }
        
        
        
        if (NewPingjia&&indexPath.row == Pingjiaindex) {
            
            self.m_commentTextField.text = @"";
            
            NewPingjia = NO;
            
        }
        
        //图片为空
        if (self.m_imageArray.count == 0) {
            
            cell.m_ImgView.hidden =YES;
            
            //没有评论
            if (self.m_CommentArray.count == 0) {
                
                cell.m_commentView.hidden =YES;
                
                cell.m_tempView.frame = CGRectMake(cell.m_tempView.frame.origin.x, cell.m_contentLabel.frame.origin.y+size.height+zansize.height, cell.m_tempView.frame.size.width, cell.m_tempView.frame.size.height);
                
                cell.m_lineImgV.frame = CGRectMake(cell.m_lineImgV.frame.origin.x, cell.m_tempView.frame.origin.y + cell.m_tempView.frame.size.height, cell.m_lineImgV.frame.size.width, cell.m_lineImgV.frame.size.height);
                
                cell.m_zanView.frame = CGRectMake(80, cell.m_tempView.frame.origin.y-zansize.height, cell.m_zanView.frame.size.width, zansize.height);
                
                
                return cell;
                
            }
            //一条评论
            else if (self.m_CommentArray.count==1) {
                
                cell.m_commentView.hidden =NO;
                
                NSDictionary * dic = [self.m_CommentArray objectAtIndex:0];
                
                NSString *pinglu0 =[NSString stringWithFormat:@"%@:%@",[dic objectForKey:@"NickName"],[dic objectForKey:@"Contents"]];
                
                CGSize pinglu = [pinglu0 sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(WindowSizeWidth - 87, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                
                
                UILabel * label = [[UILabel alloc]init];
                
                [label setFrame:CGRectMake(0 , 0, WindowSizeWidth - 97, pinglu.height)];
                
                label.text = pinglu0;
                
                
                label.backgroundColor = [UIColor clearColor];
                label.textColor = [UIColor lightGrayColor];
                [label setFont:[UIFont systemFontOfSize:14.0f]];
                label.numberOfLines = 0;// 不可少Label属性
                label.lineBreakMode = UILineBreakModeCharacterWrap;// 不可少Label属性之二
                
                
                [cell.m_commentView setFrame:CGRectMake(80, cell.m_contentLabel.frame.origin.y + size.height , cell.m_commentView.frame.size.width, pinglu.height)];
                
                [cell.m_commentView addSubview:label];
                
                
            }
            //两条评论
            else if (self.m_CommentArray.count==2) {
                
                CGFloat pingluHIGHT2 = 0;
                
                cell.m_commentView.hidden =NO;
                
                for (int i=0; i<self.m_CommentArray.count; i++) {
                    
                    
                    NSDictionary * dic = [self.m_CommentArray objectAtIndex:0];
                    
                    NSString *pinglu0 =[NSString stringWithFormat:@"%@:%@",[dic objectForKey:@"NickName"],[dic objectForKey:@"Contents"]];
                    CGSize pinglu = [pinglu0 sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(WindowSizeWidth - 87, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                    
                    NSDictionary * dic2 = [self.m_CommentArray objectAtIndex:1];
                    NSString *pinglustring =[NSString stringWithFormat:@"%@:%@",[dic2 objectForKey:@"NickName"],[dic2 objectForKey:@"Contents"]];
                    CGSize size1 = [pinglustring sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(WindowSizeWidth - 87, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                    
                    
                    UILabel * label = [[UILabel alloc]init];
                    
                    if (i==0)
                    {
                        pingluHIGHT2 = pingluHIGHT2+ pinglu.height;
                        
                        [label setFrame:CGRectMake(0 , i*pinglu.height, WindowSizeWidth - 97, pinglu.height)];
                        
                        label.text = pinglu0;
                        
                        
                    }else if (i==1)
                    {
                        
                        pingluHIGHT2 = pingluHIGHT2+ size1.height;
                        
                        [label setFrame:CGRectMake(0 , i*pinglu.height, WindowSizeWidth - 97, size1.height)];
                        
                        label.text = pinglustring;
                        
                    }
                    
                    label.backgroundColor = [UIColor clearColor];
                    label.textColor = [UIColor lightGrayColor];
                    [label setFont:[UIFont systemFontOfSize:14.0f]];
                    label.numberOfLines = 0;// 不可少Label属性
                    label.lineBreakMode = UILineBreakModeCharacterWrap;// 不可少Label属性之二
                    
                    
                    [cell.m_commentView setFrame:CGRectMake(80, cell.m_contentLabel.frame.origin.y +size.height, cell.m_commentView.frame.size.width, pingluHIGHT2)];
                    
                    [cell.m_commentView addSubview:label];
                    
                    
                }
                
            }
            //两条评论
            else if (self.m_CommentArray.count>=3) {
                
                CGFloat pingluHIGHT2 = 0;
                
                cell.m_commentView.hidden =NO;
                
                for (int i=0; i<3; i++) {
                    
                    if (i==2) {
                        
                        UIButton * PINGLUMOREbtn =[UIButton buttonWithType:UIButtonTypeCustom];
                        [PINGLUMOREbtn setFrame:CGRectMake(0, cell.m_commentView.frame.size.height, WindowSizeWidth - 87, 25)];
                        
                        PINGLUMOREbtn.backgroundColor = [UIColor clearColor];
                        [PINGLUMOREbtn setTitle: @"查看更多评论" forState: UIControlStateNormal];
                        [PINGLUMOREbtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
                        [PINGLUMOREbtn.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
                        PINGLUMOREbtn.showsTouchWhenHighlighted = YES;
                        PINGLUMOREbtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
                        
                        PINGLUMOREbtn.tag = indexPath.row;
                        
                        [PINGLUMOREbtn addTarget:self action:@selector(MorepingluView:) forControlEvents:UIControlEventTouchUpInside];
                        
                        [cell.m_commentView setFrame:CGRectMake(80, cell.m_contentLabel.frame.origin.y +size.height, cell.m_commentView.frame.size.width, pingluHIGHT2+25)];
                        
                        [cell.m_commentView addSubview:PINGLUMOREbtn];
                        
                        break;
                        
                    }
                    
                    
                    NSDictionary * dic = [self.m_CommentArray objectAtIndex:0];
                    NSString *pinglu0 =[NSString stringWithFormat:@"%@:%@",[dic objectForKey:@"NickName"],[dic objectForKey:@"Contents"]];
                    CGSize pinglu = [pinglu0 sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(WindowSizeWidth - 87, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                    
                    NSDictionary * dic2 = [self.m_CommentArray objectAtIndex:1];
                    NSString *pinglustring =[NSString stringWithFormat:@"%@:%@",[dic2 objectForKey:@"NickName"],[dic2 objectForKey:@"Contents"]];
                    CGSize size1 = [pinglustring sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(WindowSizeWidth - 87, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                    
                    
                    UILabel * label = [[UILabel alloc]init];
                    
                    if (i==0)
                    {
                        pingluHIGHT2 = pingluHIGHT2+ pinglu.height;
                        
                        [label setFrame:CGRectMake(0 , i*pinglu.height, WindowSizeWidth - 97, pinglu.height)];
                        
                        label.text = pinglu0;
                        
                    }else if (i==1)
                    {
                        
                        pingluHIGHT2 = pingluHIGHT2+ size1.height;
                        
                        [label setFrame:CGRectMake(0 , i*pinglu.height, WindowSizeWidth - 97, size1.height)];
                        
                        label.text = pinglustring;
                    }
                    
                    label.backgroundColor = [UIColor clearColor];
                    label.textColor = [UIColor lightGrayColor];
                    [label setFont:[UIFont systemFontOfSize:14.0f]];
                    label.numberOfLines = 0;// 不可少Label属性
                    label.lineBreakMode = UILineBreakModeCharacterWrap;// 不可少Label属性之二
                    
                    [cell.m_commentView setFrame:CGRectMake(80, cell.m_contentLabel.frame.origin.y +size.height + 2, cell.m_commentView.frame.size.width, pingluHIGHT2)];
                    
                    [cell.m_commentView addSubview:label];
                    
                    
                }
                
            }
            
            
            cell.m_tempView.frame = CGRectMake(cell.m_tempView.frame.origin.x, cell.m_commentView.frame.origin.y+cell.m_commentView.frame.size.height+zansize.height, cell.m_tempView.frame.size.width, cell.m_tempView.frame.size.height);
            
            cell.m_lineImgV.frame = CGRectMake(cell.m_lineImgV.frame.origin.x, cell.m_tempView.frame.origin.y + cell.m_tempView.frame.size.height, cell.m_lineImgV.frame.size.width, cell.m_lineImgV.frame.size.height);
            
            
            cell.m_zanView.frame = CGRectMake(80, cell.m_tempView.frame.origin.y-zansize.height, cell.m_zanView.frame.size.width, zansize.height);
            
            
        }
        //图片是1-9之间
        else if (self.m_imageArray.count>=1&&self.m_imageArray.count<=9)
        {
            cell.m_ImgView.hidden = NO;
            
            int line =0;
            
            if (self.m_imageArray.count<=3) {
                [cell.m_ImgView setFrame:CGRectMake(80, cell.m_contentLabel.frame.origin.y + size.height+3,cell.m_ImgView.frame.size.width, 80)];
            }else if (self.m_imageArray.count<=6){
                line =1;
                [cell.m_ImgView setFrame:CGRectMake(80, cell.m_contentLabel.frame.origin.y + size.height+3,cell.m_ImgView.frame.size.width, 160)];
                
            }else if (self.m_imageArray.count<=9){
                line =2;
                [cell.m_ImgView setFrame:CGRectMake(80, cell.m_contentLabel.frame.origin.y + size.height+3,cell.m_ImgView.frame.size.width, 235)];
                
            }
            
            if ([flaseover isEqualToString:@"YES"]&&indexPath.row == 0) {
                
                for (int i=0; i<self.m_imageArray.count; i++) {
                    
                    UIButton * Btn = [[UIButton alloc]init];
                    [Btn setFrame:CGRectMake(5+(i%3*75), 5+(i/3*75), 70, 70)];
                    [Btn setImage:[CommonUtil scaleImage:[self.m_imageArray objectAtIndex:i] toSize:CGSizeMake(70, 70)] forState:UIControlStateNormal];
                    [Btn addTarget:self action:@selector(ChangeBigImage:) forControlEvents:UIControlEventTouchUpInside];
                    Btn.tag = i;
                    [cell.m_ImgView addSubview:Btn];
                    
                }
                
            }else{
                
                for (int i=0; i<self.m_imageArray.count; i++) {
                    
                    NSDictionary * imageDic = [self.m_imageArray objectAtIndex:i];
                    
                    NSString *path=[NSString stringWithFormat:@"%@",[imageDic objectForKey:@"MidImgUrl"]];
                    
                    UIImageView*imv=[[UIImageView alloc]init];
                    UIButton * Btn = [[UIButton alloc]init];
                    
                    UIImage *reSizeImage = [imagechage getImage:path];
                    
                    
                    if (reSizeImage != nil)
                    {
                        [Btn setFrame:CGRectMake(5+(i%3*75), 5+(i/3*75), 70, 70)];
                        
                        [Btn setImage:[CommonUtil scaleImage:reSizeImage toSize:CGSizeMake(70, 70)] forState:UIControlStateNormal];
                        
                        [Btn addTarget:self action:@selector(ChangeBigImage:) forControlEvents:UIControlEventTouchUpInside];
                        Btn.tag = i;
                        [cell.m_ImgView addSubview:Btn];
                        
                        continue;
                    }
                    else{
                        
                        [imv setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",path]]] placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                            
                            [Btn setFrame:CGRectMake(5+(i%3*75), 5+(i/3*75), 70, 70)];
                            
                            [Btn setImage:[CommonUtil scaleImage:image toSize:CGSizeMake(70, 70)] forState:UIControlStateNormal];
                            
                            
                            [Btn addTarget:self action:@selector(ChangeBigImage:) forControlEvents:UIControlEventTouchUpInside];
                            
                            Btn.tag =i;
                            
                            [cell.m_ImgView addSubview:Btn];
                            
                            [imagechage addImage:[CommonUtil scaleImage:image toSize:CGSizeMake(70, 70)] andUrl:path];
                            
                        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                            
                            [Btn setFrame:CGRectMake(5+(i%3*75), 5+(i/3*75), 70, 70)];
                            
                            [Btn addTarget:self action:@selector(ChangeBigImage:) forControlEvents:UIControlEventTouchUpInside];
                            [Btn setImage:[CommonUtil scaleImage:[UIImage imageNamed:@"invite_reg_no_photo.png"] toSize:CGSizeMake(70, 70)]forState:UIControlStateNormal];
                            
                            Btn.tag =i;
                            [cell.m_ImgView addSubview:Btn];
                        }];
                        
                    }
                    
                }
                
            }
            
            
            
            //没有评论
            if (self.m_CommentArray.count == 0) {
                
                cell.m_commentView.hidden =YES;
                
                cell.m_tempView.frame = CGRectMake(cell.m_tempView.frame.origin.x,cell.m_contentLabel.frame.origin.y + size.height +((line+1)*80)+8+zansize.height, cell.m_tempView.frame.size.width, cell.m_tempView.frame.size.height);
                
                cell.m_lineImgV.frame = CGRectMake(cell.m_lineImgV.frame.origin.x, cell.m_tempView.frame.origin.y + cell.m_tempView.frame.size.height, cell.m_lineImgV.frame.size.width, cell.m_lineImgV.frame.size.height);
                
                cell.m_zanView.frame = CGRectMake(80, cell.m_tempView.frame.origin.y-zansize.height - 5, cell.m_zanView.frame.size.width, zansize.height);
                
                return cell;
                
            }
            //一条评论
            else if (self.m_CommentArray.count==1) {
                
                cell.m_commentView.hidden =NO;
                
                NSDictionary * dic = [self.m_CommentArray objectAtIndex:0];
                
                NSString *pinglu0 =[NSString stringWithFormat:@"%@:%@",[dic objectForKey:@"NickName"],[dic objectForKey:@"Contents"]];
                
                CGSize pinglu = [pinglu0 sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(WindowSizeWidth - 87, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                
                UILabel * label = [[UILabel alloc]init];
                
                [label setFrame:CGRectMake(0 , 0, WindowSizeWidth - 97, pinglu.height)];
                
                label.text = pinglu0;
                
                label.backgroundColor = [UIColor clearColor];
                label.textColor = [UIColor lightGrayColor];
                [label setFont:[UIFont systemFontOfSize:14.0f]];
                label.numberOfLines = 0;// 不可少Label属性
                label.lineBreakMode = UILineBreakModeCharacterWrap;// 不可少Label属性之二
                
                [cell.m_commentView setFrame:CGRectMake(80, cell.m_contentLabel.frame.origin.y +size.height+ cell.m_ImgView.frame.size.height, cell.m_commentView.frame.size.width, pinglu.height)];
                
                [cell.m_commentView addSubview:label];
                
                
            }
            //两条评论
            else if (self.m_CommentArray.count==2) {
                
                CGFloat pingluHIGHT2 = 0;
                
                cell.m_commentView.hidden =NO;
                
                for (int i=0; i<self.m_CommentArray.count; i++) {
                    
                    NSDictionary * dic = [self.m_CommentArray objectAtIndex:0];
                    NSString *pinglu0 =[NSString stringWithFormat:@"%@:%@",[dic objectForKey:@"NickName"],[dic objectForKey:@"Contents"]];
                    CGSize pinglu = [pinglu0 sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(WindowSizeWidth - 87, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                    
                    NSDictionary * dic2 = [self.m_CommentArray objectAtIndex:1];
                    NSString *pinglustring =[NSString stringWithFormat:@"%@:%@",[dic2 objectForKey:@"NickName"],[dic2 objectForKey:@"Contents"]];
                    CGSize size1 = [pinglustring sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(WindowSizeWidth - 87, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                    
                    
                    UILabel * label = [[UILabel alloc]init];
                    
                    if (i==0)
                    {
                        pingluHIGHT2 = pingluHIGHT2+ pinglu.height;
                        
                        [label setFrame:CGRectMake(0 , i*pinglu.height, WindowSizeWidth - 97, pinglu.height)];
                        
                        label.text = pinglu0;
                        
                    }else if (i==1)
                    {
                        
                        pingluHIGHT2 = pingluHIGHT2+ size1.height;
                        
                        [label setFrame:CGRectMake(0 , i*pinglu.height, WindowSizeWidth - 97, size1.height)];
                        
                        label.text = pinglustring;
                    }
                    
                    label.backgroundColor = [UIColor clearColor];
                    label.textColor = [UIColor lightGrayColor];
                    [label setFont:[UIFont systemFontOfSize:14.0f]];
                    label.numberOfLines = 0;// 不可少Label属性
                    label.lineBreakMode = UILineBreakModeCharacterWrap;// 不可少Label属性之二
                    
                    
                    [cell.m_commentView setFrame:CGRectMake(80, cell.m_contentLabel.frame.origin.y +size.height+ cell.m_ImgView.frame.size.height, cell.m_commentView.frame.size.width, pingluHIGHT2)];
                    
                    [cell.m_commentView addSubview:label];
                    
                    
                }
                
            }
            //两条评论
            else if (self.m_CommentArray.count>=3) {
                
                cell.m_commentView.hidden =NO;
                
                CGFloat pingluHIGHT2 = 0;
                
                for (int i=0; i<3; i++) {
                    
                    if (i==2) {
                        
                        UIButton * PINGLUMOREbtn =[UIButton buttonWithType:UIButtonTypeCustom];
                        [PINGLUMOREbtn setFrame:CGRectMake(0, cell.m_commentView.frame.size.height, WindowSizeWidth - 87, 25)];
                        
                        PINGLUMOREbtn.backgroundColor = [UIColor clearColor];
                        [PINGLUMOREbtn setTitle: @"查看更多评论" forState: UIControlStateNormal];
                        [PINGLUMOREbtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
                        [PINGLUMOREbtn.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
                        PINGLUMOREbtn.showsTouchWhenHighlighted = YES;
                        PINGLUMOREbtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
                        
                        PINGLUMOREbtn.tag = indexPath.row;
                        
                        [PINGLUMOREbtn addTarget:self action:@selector(MorepingluView:) forControlEvents:UIControlEventTouchUpInside];
                        
                        [cell.m_commentView setFrame:CGRectMake(80, cell.m_contentLabel.frame.origin.y +size.height+ cell.m_ImgView.frame.size.height, cell.m_commentView.frame.size.width, pingluHIGHT2+25)];
                        
                        
                        [cell.m_commentView addSubview:PINGLUMOREbtn];
                        
                        break;
                        
                    }
                    
                    
                    NSDictionary * dic = [self.m_CommentArray objectAtIndex:0];
                    NSString *pinglu0 =[NSString stringWithFormat:@"%@:%@",[dic objectForKey:@"NickName"],[dic objectForKey:@"Contents"]];
                    CGSize pinglu = [pinglu0 sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(WindowSizeWidth - 87, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                    
                    NSDictionary * dic2 = [self.m_CommentArray objectAtIndex:1];
                    NSString *pinglustring =[NSString stringWithFormat:@"%@:%@",[dic2 objectForKey:@"NickName"],[dic2 objectForKey:@"Contents"]];
                    CGSize size1 = [pinglustring sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(WindowSizeWidth - 87, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                    
                    
                    UILabel * label = [[UILabel alloc]init];
                    
                    if (i==0)
                    {
                        pingluHIGHT2 = pingluHIGHT2+ pinglu.height;
                        
                        [label setFrame:CGRectMake(0 , i*pinglu.height, WindowSizeWidth - 97, pinglu.height)];
                        
                        label.text = pinglu0;
                        
                    }else if (i==1)
                    {
                        
                        pingluHIGHT2 = pingluHIGHT2+ size1.height;
                        
                        [label setFrame:CGRectMake(0 , i*pinglu.height, WindowSizeWidth - 97, size1.height)];
                        
                        label.text = pinglustring;
                    }
                    
                    label.backgroundColor = [UIColor clearColor];
                    label.textColor = [UIColor lightGrayColor];
                    [label setFont:[UIFont systemFontOfSize:14.0f]];
                    label.numberOfLines = 0;// 不可少Label属性
                    label.lineBreakMode = UILineBreakModeCharacterWrap;// 不可少Label属性之二
                    
                    
                    [cell.m_commentView setFrame:CGRectMake(80, cell.m_contentLabel.frame.origin.y +size.height+ cell.m_ImgView.frame.size.height, cell.m_commentView.frame.size.width, pingluHIGHT2)];
                    
                    [cell.m_commentView addSubview:label];
                    
                    
                }
                
            }
            
            
            cell.m_tempView.frame = CGRectMake(cell.m_tempView.frame.origin.x, cell.m_commentView.frame.origin.y+cell.m_commentView.frame.size.height+zansize.height, cell.m_tempView.frame.size.width, cell.m_tempView.frame.size.height);
            
            cell.m_lineImgV.frame = CGRectMake(cell.m_lineImgV.frame.origin.x, cell.m_tempView.frame.origin.y + cell.m_tempView.frame.size.height, cell.m_lineImgV.frame.size.width, cell.m_lineImgV.frame.size.height);
            
            cell.m_zanView.frame = CGRectMake(80, cell.m_tempView.frame.origin.y-zansize.height, cell.m_zanView.frame.size.width, zansize.height);
            
        }
        
        return cell;
    }
    
    
    else if ([self.m_typeString isEqualToString: KEY_DYNAMIC_SvcShare]||[self.m_typeString isEqualToString: KEY_DYNAMIC_WebViewShare]||[self.m_typeString isEqualToString: KEY_DYNAMIC_DianPingShare] ){
        
        static NSString *cellIdentifier = @"DynamicDetailCellIdentifier";
        
        DynamicDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if ( cell == nil ) {
            
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"DynamicCell" owner:self options:nil];
            
            cell = (DynamicDetailCell *)[nib objectAtIndex:1];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }

        
        cell.m_DelBtn.hidden = YES;
        
        cell.m_zhuanzai.text = @"分享了";
        
        cell.m_nameLabel.text = [NSString stringWithFormat:@"%@",[Dydic objectForKey:@"NickName"]];
        
        cell.m_timeLabel.text = [NSString stringWithFormat:@"%@",[Dydic objectForKey:@"CreateDate"]];
        
//        cell.m_fromLabel.text = [NSString stringWithFormat:@"来自:%@",[Dydic objectForKey:@"Source"]];
        cell.m_fromLabel.hidden = YES;
        
        CGSize namesize = [cell.m_nameLabel.text sizeWithFont:[UIFont systemFontOfSize:17.0f] constrainedToSize:CGSizeMake(90, MAXFLOAT) lineBreakMode:NSLineBreakByTruncatingTail];
        
        cell.m_nameLabel.frame = CGRectMake(cell.m_nameLabel.frame.origin.x, cell.m_nameLabel.frame.origin.y, namesize.width, 26);
        
        cell.m_zhuanzai.frame = CGRectMake(cell.m_nameLabel.frame.origin.x+cell.m_nameLabel.frame.size.width, cell.m_zhuanzai.frame.origin.y, cell.m_zhuanzai.frame.size.width, cell.m_zhuanzai.frame.size.height);
        
        cell.m_imageView.layer.masksToBounds = YES;
        cell.m_imageView.layer.cornerRadius = 8.0;
        //头像
        UIImageView*imv=[[UIImageView alloc]init];
        
        UIImage *reSizeImage = [imagechage getImage:[Dydic objectForKey:@"PhotoMidUrl"]];
        
        if (reSizeImage != nil)
        {
            cell.m_imageView.image = reSizeImage;
        }
        else{
            
            [imv setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[Dydic objectForKey:@"PhotoMidUrl"]]]] placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                cell.m_imageView.image = image;
                [imagechage addImage:image andUrl:[Dydic objectForKey:@"PhotoMidUrl"]];
            } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                
            }];
        }
        
        self.m_imageArray = [Dydic objectForKey:@"DynamicPicList"];
        
        if (self.m_imageArray.count==0) {
            
            if ([[NSString stringWithFormat:@"%@",[Dydic objectForKey:@"DynamicType"]] isEqualToString: KEY_DYNAMIC_SvcShare]) {
                
                [cell.self.m_imgV setImage:[UIImage imageNamed:@"invite_reg_no_photo.png"]];
                
            }else if ([[NSString stringWithFormat:@"%@",[Dydic objectForKey:@"DynamicType"]] isEqualToString: KEY_DYNAMIC_ActShare])
            {
                [cell.self.m_imgV setImage:[UIImage imageNamed:@"invite_reg_no_photo.png"]];
                
            }else if ([[NSString stringWithFormat:@"%@",[Dydic objectForKey:@"DynamicType"]] isEqualToString: KEY_DYNAMIC_WebViewShare])
            {
                [cell.self.m_imgV setImage:[UIImage imageNamed:@"lianjie.png"]];
                
            }else if ([[NSString stringWithFormat:@"%@",[Dydic objectForKey:@"DynamicType"]] isEqualToString: KEY_DYNAMIC_DianPingShare]){
                
                [cell.self.m_imgV setImage:[UIImage imageNamed:@"invite_reg_no_photo.png"]];
                
            }
            
        }else{
            
            NSDictionary * imageDic = [self.m_imageArray objectAtIndex:0];
            
            NSString *path=[NSString stringWithFormat:@"%@",[imageDic objectForKey:@"MidImgUrl"]];
            
            [cell ShareCellimage:path];
        }
        
        
        for(id tmpView in cell.m_commentView.subviews)
        {
            [tmpView removeFromSuperview];
        }
        for (id tepview in cell.m_zanView.subviews) {
            [tepview removeFromSuperview];
        }
        
        
        //发表说说的点击头像
        cell.m_PhotoBtn.tag = indexPath.row;
        [cell.m_PhotoBtn addTarget:self action:@selector(PhotoBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        // 添加按钮事件
        cell.m_zanBtn.tag = indexPath.row;
        cell.m_zhuanfaBtn.tag = indexPath.row;
        cell.m_pingjiaBtn.tag = indexPath.row;
        [cell.m_zanBtn addTarget:self action:@selector(zanClicked:) forControlEvents:UIControlEventTouchUpInside];
        [cell.m_zhuanfaBtn addTarget:self action:@selector(zhuanfaClicked:) forControlEvents:UIControlEventTouchUpInside];
        [cell.m_pingjiaBtn addTarget:self action:@selector(pingjiaClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.m_linkBtn.tag = indexPath.row;//链接按钮；
        
        [cell.m_linkBtn addTarget:self action:@selector(resourcelink:) forControlEvents:UIControlEventTouchUpInside];
        
        NSString *zanString = [self.m_zanDic objectForKey:[NSString stringWithFormat:@"%i",indexPath.row]];
        
        if ( [zanString isEqualToString:@"1"] ) {
            
            // 1表示赞 0表示未赞
            cell.m_cancelLabel.hidden = NO;
            
        }else if ( [zanString isEqualToString:@"0"] ) {
            
            cell.m_cancelLabel.hidden = YES;
            
        }else{
            
        }
        
        self.m_CommentArray = [Dydic objectForKey:@"DynamicComment"];
        
        self.m_DynamicPraiseArray =[Dydic objectForKey:@"DynamicPraise"];
        
        NSString *zanstringman =@"" ;
        CGSize zansize;
        
        if (self.m_DynamicPraiseArray.count == 0) {
            zansize.height = 0;
            cell.m_zanView.hidden = YES;
        }else{
            cell.m_zanView.hidden = NO;
            zanstringman =[[self.m_DynamicPraiseArray objectAtIndex:0]objectForKey:@"NickName"];
            
            //赞的人数组
            for (int iii=1; iii<self.m_DynamicPraiseArray.count; iii++) {
                
                NSDictionary * zandic = [self.m_DynamicPraiseArray objectAtIndex:iii ];
                
                zanstringman = [NSString stringWithFormat:@"%@,%@",zanstringman,[zandic objectForKey:@"NickName"]];
                
            }
            
            zansize = [[NSString stringWithFormat:@"空两%@",zanstringman] sizeWithFont:[UIFont systemFontOfSize:13.0f] constrainedToSize:CGSizeMake(WindowSizeWidth - 87, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
            
            
            if (isIOS5) {
                UILabel * zanl = [[UILabel alloc]initWithFrame:CGRectMake(0, 2, 230, zansize.height)];
                zanl.numberOfLines = 0;
                zanl.backgroundColor = [UIColor clearColor];
                zanl.font = [UIFont fontWithName:@"Baskerville" size:13];
                zanl.text = [NSString stringWithFormat:@"        %@",zanstringman];
                [cell.m_zanView addSubview:zanl];
                
            }else{
                NSArray *URLs;
                NSArray *URLRanges;
                NSAttributedString *as = [self attributedString:&URLs URLRanges:&URLRanges nicknamearray:self.m_DynamicPraiseArray];
                zan_label = [[CXAHyperlinkLabel alloc] initWithFrame:CGRectMake(0, 2, 230, zansize.height)];
                zan_label.numberOfLines = 0;
                zan_label.backgroundColor = [UIColor clearColor];
                zan_label.attributedText = as;
                [zan_label setURLs:URLs forRanges:URLRanges];
                
                zan_label.URLClickHandler = ^(CXAHyperlinkLabel *label, NSURL *URL, NSRange range, NSArray *textRects){
                    
                    //点击进入空间
                    //赞的人
                    [self ZannameBtn:[URL absoluteString]];
                    
                };
            }
            
            [cell.m_zanView addSubview:zan_label];
            
            UIImageView * imagevc = [[UIImageView alloc]initWithFrame:CGRectMake(5,0, 18, 18)];
            
            imagevc.image = [UIImage imageNamed:@"zanyige.png"];
            
            [cell.m_zanView addSubview:imagevc];
            
        }
        
        if (NewPingjia&&indexPath.row == Pingjiaindex) {
            
            self.m_commentTextField.text = @"";
            
            NewPingjia = NO;
            
        }
        
        cell.m_contentLabel.text = [NSString stringWithFormat:@"%@",[Dydic objectForKey:@"Contents"]];
        
        CGSize size;
        
        if ([cell.m_contentLabel.text isEqualToString:@""]) {
            size.height = 0.f;
        }else{
            
            size= [cell.m_contentLabel.text sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(WindowSizeWidth - 87, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
        }
        
        cell.m_contentLabel.frame = CGRectMake(cell.m_contentLabel.frame.origin.x, cell.m_contentLabel.frame.origin.y, WindowSizeWidth - 87, size.height+3);
        
        cell.m_recourceView.frame = CGRectMake(cell.m_recourceView.frame.origin.x, cell.m_contentLabel.frame.origin.y + size.height + 5, cell.m_recourceView.frame.size.width, cell.m_recourceView.frame.size.height);
        
        cell.m_titleLabel.text = [NSString stringWithFormat:@"%@",[Dydic objectForKey:@"Title"]];
        
        cell.m_SubtitleLabel.text = [NSString stringWithFormat:@"%@",[Dydic objectForKey:@"SubTitle"]];
        
        
        
        // 设置label，可以点击链接地址
        MarkupParser* p = [[MarkupParser alloc] init];
        // 清空数组重新赋值
        [p.images removeAllObjects];
        
        [cell.m_contentLabel.imageInfoArr removeAllObjects];
        
        NSMutableAttributedString* attString = [p attrStringFromMarkup:[Dydic objectForKey:@"Contents"]];
        CTFontRef verdana = CTFontCreateWithName((CFStringRef)@"Verdana",14,NULL);
        [attString addAttribute:(NSString*)(kCTFontAttributeName) value:(__bridge id)verdana range:NSMakeRange(0, attString.length)];
        
        [cell.m_contentLabel setAttString:attString withImages:p.images];
        // 这个属性设置为YES时就表示可以对网址进行操作
        cell.m_contentLabel.underlineLinks = YES;
        cell.m_contentLabel.userInteractionEnabled = YES;
        
        CGRect labelRect = cell.m_contentLabel.frame;
        
        labelRect.size.width = [cell.m_contentLabel sizeThatFits:CGSizeMake(WindowSizeWidth - 87, CGFLOAT_MAX)].width;
        labelRect.size.height = [cell.m_contentLabel sizeThatFits:CGSizeMake(WindowSizeWidth - 87, CGFLOAT_MAX)].height;
        //
        //        CGFloat textX = 20;
        //
        //        textX = 80;
        
        labelRect.origin = CGPointMake(80, 30);
        cell.m_contentLabel.frame = labelRect;
        [cell.m_contentLabel.layer display];
        
        
        
        if (self.m_CommentArray.count == 0) {
            
            cell.m_commentView.hidden =YES;
            
            cell.m_tempView.frame = CGRectMake(cell.m_tempView.frame.origin.x,cell.m_recourceView.frame.origin.y + cell.m_recourceView.frame.size.height+zansize.height , cell.m_tempView.frame.size.width, cell.m_tempView.frame.size.height);
            
            cell.m_lineImgV.frame = CGRectMake(cell.m_lineImgV.frame.origin.x, cell.m_tempView.frame.origin.y + cell.m_tempView.frame.size.height, cell.m_lineImgV.frame.size.width, cell.m_lineImgV.frame.size.height);
            
            cell.m_zanView.frame = CGRectMake(80, cell.m_tempView.frame.origin.y-zansize.height, cell.m_zanView.frame.size.width, zansize.height);
            
            return cell;
            
        }
        else if (self.m_CommentArray.count==1) {
            
            cell.m_commentView.hidden =NO;
            
            NSDictionary * dic = [self.m_CommentArray objectAtIndex:0];
            
            NSString *pinglu0 =[NSString stringWithFormat:@"%@:%@",[dic objectForKey:@"NickName"],[dic objectForKey:@"Contents"]];
            
            CGSize pinglu = [pinglu0 sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(WindowSizeWidth - 87, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
            
            UILabel * label = [[UILabel alloc]init];
            
            [label setFrame:CGRectMake(0 , 0, WindowSizeWidth - 97, pinglu.height)];
            
            label.text = pinglu0;
            
            label.backgroundColor = [UIColor clearColor];
            label.textColor = [UIColor lightGrayColor];
            [label setFont:[UIFont systemFontOfSize:14.0f]];
            label.numberOfLines = 0;// 不可少Label属性
            label.lineBreakMode = UILineBreakModeCharacterWrap;// 不可少Label属性之二
            
            [cell.m_commentView setFrame:CGRectMake(80,  cell.m_recourceView.frame.origin.y + cell.m_recourceView.frame.size.height , cell.m_commentView.frame.size.width, pinglu.height)];
            
            [cell.m_commentView addSubview:label];
            
        }
        else if (self.m_CommentArray.count==2) {
            
            CGFloat pingluHIGHT2 = 0;
            cell.m_commentView.hidden =NO;
            
            for (int i=0; i<self.m_CommentArray.count; i++) {
                
                NSDictionary * dic = [self.m_CommentArray objectAtIndex:0];
                NSString *pinglu0 =[NSString stringWithFormat:@"%@:%@",[dic objectForKey:@"NickName"],[dic objectForKey:@"Contents"]];
                CGSize pinglu = [pinglu0 sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(WindowSizeWidth - 87, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                
                NSDictionary * dic2 = [self.m_CommentArray objectAtIndex:1];
                NSString *pinglustring =[NSString stringWithFormat:@"%@:%@",[dic2 objectForKey:@"NickName"],[dic2 objectForKey:@"Contents"]];
                CGSize size1 = [pinglustring sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(WindowSizeWidth - 87, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                
                
                UILabel * label = [[UILabel alloc]init];
                
                if (i==0)
                {
                    pingluHIGHT2 = pingluHIGHT2+ pinglu.height;
                    
                    [label setFrame:CGRectMake(0 , i*pinglu.height, WindowSizeWidth - 97, pinglu.height)];
                    
                    label.text = pinglu0;
                    
                    
                }else if (i==1)
                {
                    
                    pingluHIGHT2 = pingluHIGHT2+ size1.height;
                    
                    [label setFrame:CGRectMake(0 , i*pinglu.height, WindowSizeWidth - 97, size1.height)];
                    
                    label.text = pinglustring;
                }
                
                label.backgroundColor = [UIColor clearColor];
                label.textColor = [UIColor lightGrayColor];
                [label setFont:[UIFont systemFontOfSize:14.0f]];
                label.numberOfLines = 0;// 不可少Label属性
                label.lineBreakMode = UILineBreakModeCharacterWrap;// 不可少Label属性之二
                
                [cell.m_commentView setFrame:CGRectMake(80, cell.m_recourceView.frame.origin.y +cell.m_recourceView.frame.size.height  , cell.m_commentView.frame.size.width, pingluHIGHT2)];
                
                [cell.m_commentView addSubview:label];
                
                
            }
            
        }
        else if (self.m_CommentArray.count>=3) {
            
            CGFloat pingluHIGHT2 = 0;
            cell.m_commentView.hidden =NO;
            
            for (int i=0; i<3; i++) {
                
                if (i==2) {
                    
                    UIButton * PINGLUMOREbtn =[UIButton buttonWithType:UIButtonTypeCustom];
                    [PINGLUMOREbtn setFrame:CGRectMake(0, cell.m_commentView.frame.size.height, WindowSizeWidth - 87, 25)];
                    
                    PINGLUMOREbtn.backgroundColor = [UIColor clearColor];
                    [PINGLUMOREbtn setTitle: @"查看更多评论" forState: UIControlStateNormal];
                    [PINGLUMOREbtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
                    [PINGLUMOREbtn.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
                    PINGLUMOREbtn.showsTouchWhenHighlighted = YES;
                    PINGLUMOREbtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
                    
                    PINGLUMOREbtn.tag = indexPath.row;
                    
                    [PINGLUMOREbtn addTarget:self action:@selector(MorepingluView:) forControlEvents:UIControlEventTouchUpInside];
                    
                    [cell.m_commentView setFrame:CGRectMake(80, cell.m_recourceView.frame.origin.y +cell.m_recourceView.frame.size.height , cell.m_commentView.frame.size.width, pingluHIGHT2+25)];
                    
                    [cell.m_commentView addSubview:PINGLUMOREbtn];
                    
                    break;
                    
                }
                
                NSDictionary * dic = [self.m_CommentArray objectAtIndex:0];
                NSString *pinglu0 =[NSString stringWithFormat:@"%@:%@",[dic objectForKey:@"NickName"],[dic objectForKey:@"Contents"]];
                CGSize pinglu = [pinglu0 sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(WindowSizeWidth - 87, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                
                NSDictionary * dic2 = [self.m_CommentArray objectAtIndex:1];
                NSString *pinglustring =[NSString stringWithFormat:@"%@:%@",[dic2 objectForKey:@"NickName"],[dic2 objectForKey:@"Contents"]];
                CGSize size1 = [pinglustring sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(WindowSizeWidth - 87, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                
                UILabel * label = [[UILabel alloc]init];
                
                if (i==0)
                {
                    pingluHIGHT2 = pingluHIGHT2+ pinglu.height;
                    
                    [label setFrame:CGRectMake(0 , i*pinglu.height, WindowSizeWidth - 97, pinglu.height)];
                    
                    label.text = pinglu0;
                    
                }else if (i==1)
                {
                    
                    pingluHIGHT2 = pingluHIGHT2+ size1.height;
                    
                    [label setFrame:CGRectMake(0 , i*pinglu.height, WindowSizeWidth - 97, size1.height)];
                    
                    label.text = pinglustring;
                    
                }
                
                label.backgroundColor = [UIColor clearColor];
                label.textColor = [UIColor lightGrayColor];
                [label setFont:[UIFont systemFontOfSize:14.0f]];
                label.numberOfLines = 0;// 不可少Label属性
                label.lineBreakMode = UILineBreakModeCharacterWrap;// 不可少Label属性之二
                
                [cell.m_commentView setFrame:CGRectMake(80, cell.m_recourceView.frame.origin.y +cell.m_recourceView.frame.size.height , cell.m_commentView.frame.size.width, pingluHIGHT2)];
                
                [cell.m_commentView addSubview:label];
                
            }
            
        }
        
        
        cell.m_tempView.frame = CGRectMake(cell.m_tempView.frame.origin.x, cell.m_commentView.frame.origin.y + cell.m_commentView.frame.size.height+zansize.height, cell.m_tempView.frame.size.width, cell.m_tempView.frame.size.height);
        
        cell.m_lineImgV.frame = CGRectMake(cell.m_lineImgV.frame.origin.x, cell.m_tempView.frame.origin.y + cell.m_tempView.frame.size.height, cell.m_lineImgV.frame.size.width, cell.m_lineImgV.frame.size.height);
        
        cell.m_zanView.frame = CGRectMake(80, cell.m_tempView.frame.origin.y-zansize.height, cell.m_zanView.frame.size.width, zansize.height);
        
        
        return cell;
        
    }
    
    return nil;
}


//转发的说说、分享的产品或链接
- (UITableViewCell *)tableViewSHA:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath DIC:(NSDictionary *)Dydic{
    
    if ( [self.m_typeString isEqualToString: KEY_DYNAMIC_FRIENDS]||[self.m_typeString isEqualToString: KEY_DYNAMIC_FromFRIENDS]) {
        
        static NSString *cellIdentifier = @"DynamicCellIdentifier";
        
        DynamicCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if ( cell == nil ) {
            
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"DynamicCell" owner:self options:nil];
            
            cell = (DynamicCell *)[nib objectAtIndex:0];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }

 
        cell.m_DelBtn.hidden = YES;
        //昵称
        cell.m_nameLabel.text = [NSString stringWithFormat:@"%@",[Dydic objectForKey:@"NickName"]];
        
        cell.m_timeLabel.text = [NSString stringWithFormat:@"%@",[Dydic objectForKey:@"CreateDate"]];
        
//        cell.m_fromLabel.text = [NSString stringWithFormat:@"来自:%@",[Dydic objectForKey:@"Source"]];
        
        cell.m_fromLabel.hidden = YES;
        CGSize namesize = [cell.m_nameLabel.text sizeWithFont:[UIFont systemFontOfSize:17.0f] constrainedToSize:CGSizeMake(90, MAXFLOAT) lineBreakMode:NSLineBreakByTruncatingTail];
        
        cell.m_nameLabel.frame = CGRectMake(cell.m_nameLabel.frame.origin.x, cell.m_nameLabel.frame.origin.y, namesize.width, 26);
        cell.m_zhuanzai.frame = CGRectMake(cell.m_nameLabel.frame.origin.x+cell.m_nameLabel.frame.size.width, cell.m_zhuanzai.frame.origin.y, cell.m_zhuanzai.frame.size.width, cell.m_zhuanzai.frame.size.height);
        
        
        NSString * FormNickName = @"";
        
        cell.m_zhuanzai.text = @"转发";
        
        FormNickName = [NSString stringWithFormat:@"%@",[Dydic objectForKey:@"FormNickName"]];
        
        NSMutableAttributedString *attributedString;
        
        if ( FormNickName.length != 0 ) {
            
            
            attributedString= [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@|%@:%@",[Dydic objectForKey:@"Contents"],FormNickName,[Dydic objectForKey:@"ForwardingContents"]]];
            
            //            [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:108.0/255 green:166.0/255  blue:205.0/255 alpha:1.0f] range:NSMakeRange([[Dydic objectForKey:@"Contents"] length] + 1,[FormNickName length])];
            //
            //内容
            cell.m_contentLabel.attributedText = attributedString;
            
        }else{
            
            
            attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@|%@",[Dydic objectForKey:@"Contents"],[Dydic objectForKey:@"ForwardingContents"]]];
            
            //            [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange([[Dydic objectForKey:@"Contents"] length] + 1,[[Dydic objectForKey:@"Contents"],[Dydic objectForKey:@"ForwardingContents"] length])];
            
            //内容
            cell.m_contentLabel.attributedText = attributedString;
        }
        
        NSString *anotherString=[attributedString string];
        //图片列表
        self.m_imageArray = [Dydic objectForKey:@"ForwardingDynPicList"];
        
        
        CGSize size = [anotherString sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(WindowSizeWidth - 87, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
        
        cell.m_contentLabel.frame = CGRectMake(cell.m_contentLabel.frame.origin.x, cell.m_contentLabel.frame.origin.y, WindowSizeWidth - 87, size.height+3);
        
        // 设置label，可以点击链接地址
        MarkupParser* p = [[MarkupParser alloc] init];
        // 清空数组重新赋值
        [p.images removeAllObjects];
        
        [cell.m_contentLabel.imageInfoArr removeAllObjects];
        
        NSMutableAttributedString* attString = attributedString;
        
        CTFontRef verdana = CTFontCreateWithName((CFStringRef)@"Verdana",14,NULL);
        [attString addAttribute:(NSString*)(kCTFontAttributeName) value:(__bridge id)verdana range:NSMakeRange(0, attString.length)];
        
        [cell.m_contentLabel setAttString:attString withImages:p.images];
        // 这个属性设置为YES时就表示可以对网址进行操作
        cell.m_contentLabel.underlineLinks = YES;
        cell.m_contentLabel.userInteractionEnabled = YES;
        
        CGRect labelRect = cell.m_contentLabel.frame;
        
        labelRect.size.width = [cell.m_contentLabel sizeThatFits:CGSizeMake(WindowSizeWidth - 87, CGFLOAT_MAX)].width;
        labelRect.size.height = [cell.m_contentLabel sizeThatFits:CGSizeMake(WindowSizeWidth - 87, CGFLOAT_MAX)].height;
        
        labelRect.origin = CGPointMake(80, 30);
        cell.m_contentLabel.frame = labelRect;
        [cell.m_contentLabel.layer display];
        
        
        
        cell.m_tempView.frame = CGRectMake(cell.m_tempView.frame.origin.x, cell.m_contentLabel.frame.origin.y + size.height, cell.m_tempView.frame.size.width, cell.m_tempView.frame.size.height);
        
        cell.m_lineImgV.frame = CGRectMake(cell.m_lineImgV.frame.origin.x, cell.m_tempView.frame.origin.y + cell.m_tempView.frame.size.height, cell.m_lineImgV.frame.size.width, cell.m_lineImgV.frame.size.height);
        
        cell.m_imageView.layer.masksToBounds = YES;
        cell.m_imageView.layer.cornerRadius = 8.0;
        //头像
        UIImageView*imv=[[UIImageView alloc]init];
        UIImage *reSizeImage = [imagechage getImage:[Dydic objectForKey:@"PhotoMidUrl"]];
        
        if (reSizeImage != nil)
        {
            cell.m_imageView.image = reSizeImage;
        }
        else{
            
            [imv setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[Dydic objectForKey:@"PhotoMidUrl"]]]] placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                cell.m_imageView.image = image;
                [imagechage addImage:image andUrl:[Dydic objectForKey:@"PhotoMidUrl"]];
            } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                
            }];
        }
        
        //删除
        for(id tmpView in cell.m_ImgView.subviews)
        {
            [tmpView removeFromSuperview];
        }
        for(id tmpView in cell.m_commentView.subviews)
        {
            [tmpView removeFromSuperview];
        }
        for (id tepview in cell.m_zanView.subviews) {
            [tepview removeFromSuperview];
        }
        
        
        //发表说说的点击头像
        cell.m_PhotoBtn.tag = indexPath.row;
        [cell.m_PhotoBtn addTarget:self action:@selector(PhotoBtn:) forControlEvents:UIControlEventTouchUpInside];
        // 添加按钮事件
        cell.m_zanBtn.tag = indexPath.row;
        cell.m_zhuanfaBtn.tag = indexPath.row;
        cell.m_pingjiaBtn.tag = indexPath.row;
        [cell.m_zanBtn addTarget:self action:@selector(zanClicked:) forControlEvents:UIControlEventTouchUpInside];
        [cell.m_zhuanfaBtn addTarget:self action:@selector(zhuanfaClicked:) forControlEvents:UIControlEventTouchUpInside];
        [cell.m_pingjiaBtn addTarget:self action:@selector(pingjiaClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        
        NSString *zanString = [self.m_zanDic objectForKey:[NSString stringWithFormat:@"%i",indexPath.row]];
        
        if ( [zanString isEqualToString:@"1"] ) {
            
            // 1表示赞 0表示未赞
            cell.m_cancelLabel.hidden = NO;
            
        }else if ( [zanString isEqualToString:@"0"] ) {
            
            cell.m_cancelLabel.hidden = YES;
            
        }else{
            
            
        }
        
        
        self.m_CommentArray = [Dydic objectForKey:@"DynamicComment"];
        
        self.m_DynamicPraiseArray =[Dydic objectForKey:@"DynamicPraise"];
        
        
        NSString *zanstringman =@"" ;
        CGSize zansize;
        
        if (self.m_DynamicPraiseArray.count == 0) {
            zansize.height = 0;
            cell.m_zanView.hidden = YES;
        }else{
            
            cell.m_zanView.hidden = NO;
            
            zanstringman =[[self.m_DynamicPraiseArray objectAtIndex:0]objectForKey:@"NickName"];
            
            //赞的人数组
            for (int iii=1; iii<self.m_DynamicPraiseArray.count; iii++) {
                
                
                NSDictionary * zandic = [self.m_DynamicPraiseArray objectAtIndex:iii ];
                
                zanstringman = [NSString stringWithFormat:@"%@,%@",zanstringman,[zandic objectForKey:@"NickName"]];
                
            }
            
            
            zansize = [[NSString stringWithFormat:@"空两%@",zanstringman] sizeWithFont:[UIFont systemFontOfSize:13.0f] constrainedToSize:CGSizeMake(WindowSizeWidth - 87, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
            
            
            if (isIOS5) {
                UILabel * zanl = [[UILabel alloc]initWithFrame:CGRectMake(0, 2, 230, zansize.height)];
                zanl.numberOfLines = 0;
                zanl.backgroundColor = [UIColor clearColor];
                zanl.font = [UIFont fontWithName:@"Baskerville" size:13];
                zanl.text = [NSString stringWithFormat:@"        %@",zanstringman];
                [cell.m_zanView addSubview:zanl];
                
            }else{
                NSArray *URLs;
                NSArray *URLRanges;
                NSAttributedString *as = [self attributedString:&URLs URLRanges:&URLRanges nicknamearray:self.m_DynamicPraiseArray];
                zan_label = [[CXAHyperlinkLabel alloc] initWithFrame:CGRectMake(0, 2, 230, zansize.height)];
                zan_label.numberOfLines = 0;
                zan_label.backgroundColor = [UIColor clearColor];
                zan_label.attributedText = as;
                [zan_label setURLs:URLs forRanges:URLRanges];
                
                
                zan_label.URLClickHandler = ^(CXAHyperlinkLabel *label, NSURL *URL, NSRange range, NSArray *textRects){
                    
                    //点击进入空间
                    //赞的人
                    [self ZannameBtn:[URL absoluteString]];
                    
                };
                
            }
            [cell.m_zanView addSubview:zan_label];
            
            UIImageView * imagevc = [[UIImageView alloc]initWithFrame:CGRectMake(5,0, 18, 18)];
            imagevc.image = [UIImage imageNamed:@"zanyige.png"];
            
            [cell.m_zanView addSubview:imagevc];
            
        }
        
        
        if (NewPingjia&&indexPath.row == Pingjiaindex) {
            
            self.m_commentTextField.text = @"";
            
            NewPingjia = NO;
            
        }
        
        //图片为空
        if (self.m_imageArray.count == 0) {
            
            cell.m_ImgView.hidden =YES;
            
            //没有评论
            if (self.m_CommentArray.count == 0) {
                
                cell.m_commentView.hidden =YES;
                
                cell.m_tempView.frame = CGRectMake(cell.m_tempView.frame.origin.x, cell.m_contentLabel.frame.origin.y+size.height+zansize.height, cell.m_tempView.frame.size.width, cell.m_tempView.frame.size.height);
                
                cell.m_lineImgV.frame = CGRectMake(cell.m_lineImgV.frame.origin.x, cell.m_tempView.frame.origin.y + cell.m_tempView.frame.size.height, cell.m_lineImgV.frame.size.width, cell.m_lineImgV.frame.size.height);
                
                cell.m_zanView.frame = CGRectMake(80, cell.m_tempView.frame.origin.y-zansize.height, cell.m_zanView.frame.size.width, zansize.height);
                
                
                return cell;
                
            }
            //一条评论
            else if (self.m_CommentArray.count==1) {
                
                cell.m_commentView.hidden =NO;
                
                NSDictionary * dic = [self.m_CommentArray objectAtIndex:0];
                
                NSString *pinglu0 =[NSString stringWithFormat:@"%@:%@",[dic objectForKey:@"NickName"],[dic objectForKey:@"Contents"]];
                
                CGSize pinglu = [pinglu0 sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(WindowSizeWidth - 87, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                
                
                UILabel * label = [[UILabel alloc]init];
                
                [label setFrame:CGRectMake(0 , 0, WindowSizeWidth - 97, pinglu.height)];
                
                label.text = pinglu0;
                
                
                label.backgroundColor = [UIColor clearColor];
                label.textColor = [UIColor lightGrayColor];
                [label setFont:[UIFont systemFontOfSize:14.0f]];
                label.numberOfLines = 0;// 不可少Label属性
                label.lineBreakMode = UILineBreakModeCharacterWrap;// 不可少Label属性之二
                
                
                [cell.m_commentView setFrame:CGRectMake(80, cell.m_contentLabel.frame.origin.y + size.height , cell.m_commentView.frame.size.width, pinglu.height)];
                
                [cell.m_commentView addSubview:label];
                
                
            }
            //两条评论
            else if (self.m_CommentArray.count==2) {
                
                CGFloat pingluHIGHT2 = 0;
                
                cell.m_commentView.hidden =NO;
                
                for (int i=0; i<self.m_CommentArray.count; i++) {
                    
                    
                    NSDictionary * dic = [self.m_CommentArray objectAtIndex:0];
                    
                    NSString *pinglu0 =[NSString stringWithFormat:@"%@:%@",[dic objectForKey:@"NickName"],[dic objectForKey:@"Contents"]];
                    CGSize pinglu = [pinglu0 sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(WindowSizeWidth - 87, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                    
                    NSDictionary * dic2 = [self.m_CommentArray objectAtIndex:1];
                    NSString *pinglustring =[NSString stringWithFormat:@"%@:%@",[dic2 objectForKey:@"NickName"],[dic2 objectForKey:@"Contents"]];
                    CGSize size1 = [pinglustring sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(WindowSizeWidth - 87, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                    
                    
                    UILabel * label = [[UILabel alloc]init];
                    
                    if (i==0)
                    {
                        pingluHIGHT2 = pingluHIGHT2+ pinglu.height;
                        
                        [label setFrame:CGRectMake(0 , i*pinglu.height, WindowSizeWidth - 97, pinglu.height)];
                        
                        label.text = pinglu0;
                        
                        
                    }else if (i==1)
                    {
                        
                        pingluHIGHT2 = pingluHIGHT2+ size1.height;
                        
                        [label setFrame:CGRectMake(0 , i*pinglu.height, WindowSizeWidth - 97, size1.height)];
                        
                        label.text = pinglustring;
                        
                    }
                    
                    label.backgroundColor = [UIColor clearColor];
                    label.textColor = [UIColor lightGrayColor];
                    [label setFont:[UIFont systemFontOfSize:14.0f]];
                    label.numberOfLines = 0;// 不可少Label属性
                    label.lineBreakMode = UILineBreakModeCharacterWrap;// 不可少Label属性之二
                    
                    
                    [cell.m_commentView setFrame:CGRectMake(80, cell.m_contentLabel.frame.origin.y +size.height, cell.m_commentView.frame.size.width, pingluHIGHT2)];
                    
                    [cell.m_commentView addSubview:label];
                    
                    
                }
                
            }
            //两条评论
            else if (self.m_CommentArray.count>=3) {
                
                CGFloat pingluHIGHT2 = 0;
                
                cell.m_commentView.hidden =NO;
                
                for (int i=0; i<3; i++) {
                    
                    if (i==2) {
                        
                        UIButton * PINGLUMOREbtn =[UIButton buttonWithType:UIButtonTypeCustom];
                        [PINGLUMOREbtn setFrame:CGRectMake(0, cell.m_commentView.frame.size.height, WindowSizeWidth - 87, 25)];
                        
                        PINGLUMOREbtn.backgroundColor = [UIColor clearColor];
                        [PINGLUMOREbtn setTitle: @"查看更多评论" forState: UIControlStateNormal];
                        [PINGLUMOREbtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
                        [PINGLUMOREbtn.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
                        PINGLUMOREbtn.showsTouchWhenHighlighted = YES;
                        PINGLUMOREbtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
                        
                        PINGLUMOREbtn.tag = indexPath.row;
                        
                        [PINGLUMOREbtn addTarget:self action:@selector(MorepingluView:) forControlEvents:UIControlEventTouchUpInside];
                        
                        [cell.m_commentView setFrame:CGRectMake(80, cell.m_contentLabel.frame.origin.y +size.height, cell.m_commentView.frame.size.width, pingluHIGHT2+25)];
                        
                        [cell.m_commentView addSubview:PINGLUMOREbtn];
                        
                        break;
                        
                    }
                    
                    
                    NSDictionary * dic = [self.m_CommentArray objectAtIndex:0];
                    NSString *pinglu0 =[NSString stringWithFormat:@"%@:%@",[dic objectForKey:@"NickName"],[dic objectForKey:@"Contents"]];
                    CGSize pinglu = [pinglu0 sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(WindowSizeWidth - 87, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                    
                    NSDictionary * dic2 = [self.m_CommentArray objectAtIndex:1];
                    NSString *pinglustring =[NSString stringWithFormat:@"%@:%@",[dic2 objectForKey:@"NickName"],[dic2 objectForKey:@"Contents"]];
                    CGSize size1 = [pinglustring sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(WindowSizeWidth - 87, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                    
                    
                    UILabel * label = [[UILabel alloc]init];
                    
                    if (i==0)
                    {
                        pingluHIGHT2 = pingluHIGHT2+ pinglu.height;
                        
                        [label setFrame:CGRectMake(0 , i*pinglu.height, WindowSizeWidth - 97, pinglu.height)];
                        
                        label.text = pinglu0;
                        
                    }else if (i==1)
                    {
                        
                        pingluHIGHT2 = pingluHIGHT2+ size1.height;
                        
                        [label setFrame:CGRectMake(0 , i*pinglu.height, WindowSizeWidth - 97, size1.height)];
                        
                        label.text = pinglustring;
                    }
                    
                    label.backgroundColor = [UIColor clearColor];
                    label.textColor = [UIColor lightGrayColor];
                    [label setFont:[UIFont systemFontOfSize:14.0f]];
                    label.numberOfLines = 0;// 不可少Label属性
                    label.lineBreakMode = UILineBreakModeCharacterWrap;// 不可少Label属性之二
                    
                    [cell.m_commentView setFrame:CGRectMake(80, cell.m_contentLabel.frame.origin.y +size.height + 2, cell.m_commentView.frame.size.width, pingluHIGHT2)];
                    
                    [cell.m_commentView addSubview:label];
                    
                    
                }
                
            }
            
            
            cell.m_tempView.frame = CGRectMake(cell.m_tempView.frame.origin.x, cell.m_commentView.frame.origin.y+cell.m_commentView.frame.size.height+zansize.height, cell.m_tempView.frame.size.width, cell.m_tempView.frame.size.height);
            
            cell.m_lineImgV.frame = CGRectMake(cell.m_lineImgV.frame.origin.x, cell.m_tempView.frame.origin.y + cell.m_tempView.frame.size.height, cell.m_lineImgV.frame.size.width, cell.m_lineImgV.frame.size.height);
            
            
            cell.m_zanView.frame = CGRectMake(80, cell.m_tempView.frame.origin.y-zansize.height, cell.m_zanView.frame.size.width, zansize.height);
            
            
        }
        //图片是1-9之间
        else if (self.m_imageArray.count>=1&&self.m_imageArray.count<=9)
        {
            cell.m_ImgView.hidden = NO;
            
            int line =0;
            
            if (self.m_imageArray.count<=3) {
                [cell.m_ImgView setFrame:CGRectMake(80, cell.m_contentLabel.frame.origin.y + size.height+3,cell.m_ImgView.frame.size.width, 80)];
            }else if (self.m_imageArray.count<=6){
                line =1;
                [cell.m_ImgView setFrame:CGRectMake(80, cell.m_contentLabel.frame.origin.y + size.height+3,cell.m_ImgView.frame.size.width, 160)];
                
            }else if (self.m_imageArray.count<=9){
                line =2;
                [cell.m_ImgView setFrame:CGRectMake(80, cell.m_contentLabel.frame.origin.y + size.height+3,cell.m_ImgView.frame.size.width, 235)];
                
            }
            
            for (int i=0; i<self.m_imageArray.count; i++) {
                
                NSDictionary * imageDic = [self.m_imageArray objectAtIndex:i];
                
                NSString *path=[NSString stringWithFormat:@"%@",[imageDic objectForKey:@"MidImgUrl"]];
                
                UIImageView*imv=[[UIImageView alloc]init];
                UIButton * Btn = [[UIButton alloc]init];
                
                UIImage *reSizeImage = [imagechage getImage:path];
                
                
                if (reSizeImage != nil)
                {
                    [Btn setFrame:CGRectMake(5+(i%3*75), 5+(i/3*75), 70, 70)];
                    
                    [Btn setImage:[CommonUtil scaleImage:reSizeImage toSize:CGSizeMake(70, 70)] forState:UIControlStateNormal];
                    
                    [Btn addTarget:self action:@selector(ChangeBigImage:) forControlEvents:UIControlEventTouchUpInside];
                    Btn.tag = i;
                    [cell.m_ImgView addSubview:Btn];
                    
                    continue;
                }
                else{
                    
                    [imv setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",path]]] placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                        
                        [Btn setFrame:CGRectMake(5+(i%3*75), 5+(i/3*75), 70, 70)];
                        
                        [Btn setImage:[CommonUtil scaleImage:image toSize:CGSizeMake(70, 70)] forState:UIControlStateNormal];
                        
                        [Btn addTarget:self action:@selector(ChangeBigImage:) forControlEvents:UIControlEventTouchUpInside];
                        
                        Btn.tag =i;
                        
                        [cell.m_ImgView addSubview:Btn];
                        
                        [imagechage addImage:[CommonUtil scaleImage:image toSize:CGSizeMake(70, 70)] andUrl:path];
                        
                    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                        
                        [Btn setFrame:CGRectMake(5+(i%3*75), 5+(i/3*75), 70, 70)];
                        [Btn setImage:[CommonUtil scaleImage:[UIImage imageNamed:@"invite_reg_no_photo.png"] toSize:CGSizeMake(70, 70)] forState:UIControlStateNormal];
                        [Btn addTarget:self action:@selector(ChangeBigImage:) forControlEvents:UIControlEventTouchUpInside];
                        Btn.tag =i;
                        [cell.m_ImgView addSubview:Btn];
                    }];
                    
                }
                
            }
            
            //没有评论
            if (self.m_CommentArray.count == 0) {
                
                cell.m_commentView.hidden =YES;
                
                cell.m_tempView.frame = CGRectMake(cell.m_tempView.frame.origin.x,cell.m_contentLabel.frame.origin.y + size.height +((line+1)*80)+8+zansize.height, cell.m_tempView.frame.size.width, cell.m_tempView.frame.size.height);
                
                cell.m_lineImgV.frame = CGRectMake(cell.m_lineImgV.frame.origin.x, cell.m_tempView.frame.origin.y + cell.m_tempView.frame.size.height, cell.m_lineImgV.frame.size.width, cell.m_lineImgV.frame.size.height);
                
                cell.m_zanView.frame = CGRectMake(80, cell.m_tempView.frame.origin.y-zansize.height - 5, cell.m_zanView.frame.size.width, zansize.height);
                
                return cell;
                
            }
            //一条评论
            else if (self.m_CommentArray.count==1) {
                
                cell.m_commentView.hidden =NO;
                
                NSDictionary * dic = [self.m_CommentArray objectAtIndex:0];
                
                NSString *pinglu0 =[NSString stringWithFormat:@"%@:%@",[dic objectForKey:@"NickName"],[dic objectForKey:@"Contents"]];
                
                CGSize pinglu = [pinglu0 sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(WindowSizeWidth - 87, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                
                UILabel * label = [[UILabel alloc]init];
                
                [label setFrame:CGRectMake(0 , 0, WindowSizeWidth - 97, pinglu.height)];
                
                label.text = pinglu0;
                
                label.backgroundColor = [UIColor clearColor];
                label.textColor = [UIColor lightGrayColor];
                [label setFont:[UIFont systemFontOfSize:14.0f]];
                label.numberOfLines = 0;// 不可少Label属性
                label.lineBreakMode = UILineBreakModeCharacterWrap;// 不可少Label属性之二
                
                [cell.m_commentView setFrame:CGRectMake(80, cell.m_contentLabel.frame.origin.y +size.height+ cell.m_ImgView.frame.size.height, cell.m_commentView.frame.size.width, pinglu.height)];
                
                [cell.m_commentView addSubview:label];
                
                
            }
            //两条评论
            else if (self.m_CommentArray.count==2) {
                
                CGFloat pingluHIGHT2 = 0;
                
                cell.m_commentView.hidden =NO;
                
                for (int i=0; i<self.m_CommentArray.count; i++) {
                    
                    NSDictionary * dic = [self.m_CommentArray objectAtIndex:0];
                    NSString *pinglu0 =[NSString stringWithFormat:@"%@:%@",[dic objectForKey:@"NickName"],[dic objectForKey:@"Contents"]];
                    CGSize pinglu = [pinglu0 sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(WindowSizeWidth - 87, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                    
                    NSDictionary * dic2 = [self.m_CommentArray objectAtIndex:1];
                    NSString *pinglustring =[NSString stringWithFormat:@"%@:%@",[dic2 objectForKey:@"NickName"],[dic2 objectForKey:@"Contents"]];
                    CGSize size1 = [pinglustring sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(WindowSizeWidth - 87, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                    
                    
                    UILabel * label = [[UILabel alloc]init];
                    
                    if (i==0)
                    {
                        pingluHIGHT2 = pingluHIGHT2+ pinglu.height;
                        
                        [label setFrame:CGRectMake(0 , i*pinglu.height, WindowSizeWidth - 97, pinglu.height)];
                        
                        label.text = pinglu0;
                        
                    }else if (i==1)
                    {
                        
                        pingluHIGHT2 = pingluHIGHT2+ size1.height;
                        
                        [label setFrame:CGRectMake(0 , i*pinglu.height, WindowSizeWidth - 97, size1.height)];
                        
                        label.text = pinglustring;
                    }
                    
                    label.backgroundColor = [UIColor clearColor];
                    label.textColor = [UIColor lightGrayColor];
                    [label setFont:[UIFont systemFontOfSize:14.0f]];
                    label.numberOfLines = 0;// 不可少Label属性
                    label.lineBreakMode = UILineBreakModeCharacterWrap;// 不可少Label属性之二
                    
                    
                    [cell.m_commentView setFrame:CGRectMake(80, cell.m_contentLabel.frame.origin.y +size.height+ cell.m_ImgView.frame.size.height, cell.m_commentView.frame.size.width, pingluHIGHT2)];
                    
                    [cell.m_commentView addSubview:label];
                    
                    
                }
                
            }
            //两条评论
            else if (self.m_CommentArray.count>=3) {
                
                cell.m_commentView.hidden =NO;
                
                CGFloat pingluHIGHT2 = 0;
                
                for (int i=0; i<3; i++) {
                    
                    if (i==2) {
                        
                        UIButton * PINGLUMOREbtn =[UIButton buttonWithType:UIButtonTypeCustom];
                        [PINGLUMOREbtn setFrame:CGRectMake(0, cell.m_commentView.frame.size.height, WindowSizeWidth - 87, 25)];
                        
                        PINGLUMOREbtn.backgroundColor = [UIColor clearColor];
                        [PINGLUMOREbtn setTitle: @"查看更多评论" forState: UIControlStateNormal];
                        [PINGLUMOREbtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
                        [PINGLUMOREbtn.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
                        PINGLUMOREbtn.showsTouchWhenHighlighted = YES;
                        PINGLUMOREbtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
                        
                        PINGLUMOREbtn.tag = indexPath.row;
                        
                        [PINGLUMOREbtn addTarget:self action:@selector(MorepingluView:) forControlEvents:UIControlEventTouchUpInside];
                        
                        [cell.m_commentView setFrame:CGRectMake(80, cell.m_contentLabel.frame.origin.y +size.height+ cell.m_ImgView.frame.size.height, cell.m_commentView.frame.size.width, pingluHIGHT2+25)];
                        
                        [cell.m_commentView addSubview:PINGLUMOREbtn];
                        
                        break;
                        
                    }
                    
                    
                    NSDictionary * dic = [self.m_CommentArray objectAtIndex:0];
                    NSString *pinglu0 =[NSString stringWithFormat:@"%@:%@",[dic objectForKey:@"NickName"],[dic objectForKey:@"Contents"]];
                    CGSize pinglu = [pinglu0 sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(WindowSizeWidth - 87, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                    
                    NSDictionary * dic2 = [self.m_CommentArray objectAtIndex:1];
                    NSString *pinglustring =[NSString stringWithFormat:@"%@:%@",[dic2 objectForKey:@"NickName"],[dic2 objectForKey:@"Contents"]];
                    CGSize size1 = [pinglustring sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(WindowSizeWidth - 87, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                    
                    
                    UILabel * label = [[UILabel alloc]init];
                    
                    if (i==0)
                    {
                        pingluHIGHT2 = pingluHIGHT2+ pinglu.height;
                        
                        [label setFrame:CGRectMake(0 , i*pinglu.height, WindowSizeWidth - 97, pinglu.height)];
                        
                        label.text = pinglu0;
                        
                    }else if (i==1)
                    {
                        
                        pingluHIGHT2 = pingluHIGHT2+ size1.height;
                        
                        [label setFrame:CGRectMake(0 , i*pinglu.height, WindowSizeWidth - 97, size1.height)];
                        
                        label.text = pinglustring;
                    }
                    
                    label.backgroundColor = [UIColor clearColor];
                    label.textColor = [UIColor lightGrayColor];
                    [label setFont:[UIFont systemFontOfSize:14.0f]];
                    label.numberOfLines = 0;// 不可少Label属性
                    label.lineBreakMode = UILineBreakModeCharacterWrap;// 不可少Label属性之二
                    
                    
                    [cell.m_commentView setFrame:CGRectMake(80, cell.m_contentLabel.frame.origin.y +size.height+ cell.m_ImgView.frame.size.height, cell.m_commentView.frame.size.width, pingluHIGHT2)];
                    
                    [cell.m_commentView addSubview:label];
                    
                    
                }
                
            }
            
            
            cell.m_tempView.frame = CGRectMake(cell.m_tempView.frame.origin.x, cell.m_commentView.frame.origin.y+cell.m_commentView.frame.size.height+zansize.height, cell.m_tempView.frame.size.width, cell.m_tempView.frame.size.height);
            
            cell.m_lineImgV.frame = CGRectMake(cell.m_lineImgV.frame.origin.x, cell.m_tempView.frame.origin.y + cell.m_tempView.frame.size.height, cell.m_lineImgV.frame.size.width, cell.m_lineImgV.frame.size.height);
            
            cell.m_zanView.frame = CGRectMake(80, cell.m_tempView.frame.origin.y-zansize.height, cell.m_zanView.frame.size.width, zansize.height);
            
        }
        
        return cell;
    }
    
    
    else if ([self.m_typeString isEqualToString: KEY_DYNAMIC_SvcShare]||[self.m_typeString isEqualToString: KEY_DYNAMIC_WebViewShare]||[self.m_typeString isEqualToString: KEY_DYNAMIC_DianPingShare] ){
        
        static NSString *cellIdentifier = @"DynamicDetailCellIdentifier";
        
        DynamicDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if ( cell == nil ) {
            
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"DynamicCell" owner:self options:nil];
            
            cell = (DynamicDetailCell *)[nib objectAtIndex:1];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
    
        
        cell.m_DelBtn.hidden = YES;
        
        cell.m_zhuanzai.text = @"转发";
        
        cell.m_nameLabel.text = [NSString stringWithFormat:@"%@",[Dydic objectForKey:@"NickName"]];
        
        cell.m_timeLabel.text = [NSString stringWithFormat:@"%@",[Dydic objectForKey:@"CreateDate"]];
        
//        cell.m_fromLabel.text = [NSString stringWithFormat:@"来自:%@",[Dydic objectForKey:@"Source"]];
        cell.m_fromLabel.hidden = YES;
        CGSize namesize = [cell.m_nameLabel.text sizeWithFont:[UIFont systemFontOfSize:17.0f] constrainedToSize:CGSizeMake(90, MAXFLOAT) lineBreakMode:NSLineBreakByTruncatingTail];
        cell.m_nameLabel.frame = CGRectMake(cell.m_nameLabel.frame.origin.x, cell.m_nameLabel.frame.origin.y, namesize.width, 26);
        cell.m_zhuanzai.frame = CGRectMake(cell.m_nameLabel.frame.origin.x+cell.m_nameLabel.frame.size.width, cell.m_zhuanzai.frame.origin.y, cell.m_zhuanzai.frame.size.width, cell.m_zhuanzai.frame.size.height);
        
        NSString * FormNickName = @"";
        
        FormNickName = [NSString stringWithFormat:@"%@",[Dydic objectForKey:@"FormNickName"]];
        
        NSMutableAttributedString *attributedString;
        
        
        if ( FormNickName.length != 0 ) {
            
            //不同颜色
            attributedString= [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@|%@:%@",[Dydic objectForKey:@"Contents"],FormNickName,[Dydic objectForKey:@"ForwardingContents"]]];
            
            //            [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:108.0/255 green:166.0/255  blue:205.0/255 alpha:1.0f] range:NSMakeRange([[Dydic objectForKey:@"Contents"] length] + 1,[FormNickName length])];
            
            //内容
            cell.m_contentLabel.attributedText = attributedString;
            
        }else{
            
            
            attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@|%@",[Dydic objectForKey:@"Contents"],[Dydic objectForKey:@"ForwardingContents"]]];
            
            //            [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange([[Dydic objectForKey:@"Contents"] length] + 1,[[Dydic objectForKey:@"Contents"],[Dydic objectForKey:@"ForwardingContents"] length])];
            
            //内容
            cell.m_contentLabel.attributedText = attributedString;
        }

        cell.m_imageView.layer.masksToBounds = YES;
        cell.m_imageView.layer.cornerRadius = 8.0;
        //头像
        UIImageView*imv=[[UIImageView alloc]init];
        UIImage *reSizeImage = [imagechage getImage:[Dydic objectForKey:@"PhotoMidUrl"]];
        
        if (reSizeImage != nil)
        {
            cell.m_imageView.image = reSizeImage;
        }
        else{
            
            [imv setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[Dydic objectForKey:@"PhotoMidUrl"]]]] placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                cell.m_imageView.image = image;
                [imagechage addImage:image andUrl:[Dydic objectForKey:@"PhotoMidUrl"]];
            } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                
            }];
        }
        
        
        // 设置label，可以点击链接地址
        MarkupParser* p = [[MarkupParser alloc] init];
        // 清空数组重新赋值
        [p.images removeAllObjects];
        
        [cell.m_contentLabel.imageInfoArr removeAllObjects];
        
        NSMutableAttributedString* attString = attributedString;
        
        CTFontRef verdana = CTFontCreateWithName((CFStringRef)@"Verdana",14,NULL);
        [attString addAttribute:(NSString*)(kCTFontAttributeName) value:(__bridge id)verdana range:NSMakeRange(0, attString.length)];
        
        [cell.m_contentLabel setAttString:attString withImages:p.images];
        // 这个属性设置为YES时就表示可以对网址进行操作
        cell.m_contentLabel.underlineLinks = YES;
        cell.m_contentLabel.userInteractionEnabled = YES;
        
        CGRect labelRect = cell.m_contentLabel.frame;
        
        labelRect.size.width = [cell.m_contentLabel sizeThatFits:CGSizeMake(WindowSizeWidth - 87, CGFLOAT_MAX)].width;
        labelRect.size.height = [cell.m_contentLabel sizeThatFits:CGSizeMake(WindowSizeWidth - 87, CGFLOAT_MAX)].height;
        //
        //        CGFloat textX = 20;
        //
        //        textX = 80;
        
        labelRect.origin = CGPointMake(80, 30);
        cell.m_contentLabel.frame = labelRect;
        [cell.m_contentLabel.layer display];
        
        
        cell.m_recourceView.frame = CGRectMake(cell.m_recourceView.frame.origin.x, cell.m_contentLabel.frame.origin.y + cell.m_contentLabel.frame.size.height + 5, cell.m_recourceView.frame.size.width, cell.m_recourceView.frame.size.height);
        
        cell.m_titleLabel.text = [NSString stringWithFormat:@"%@",[Dydic objectForKey:@"FormTitle"]];
        cell.m_SubtitleLabel.text = [NSString stringWithFormat:@"%@",[Dydic objectForKey:@"FormSubTitle"]];
        
        
        self.m_imageArray = [Dydic objectForKey:@"ForwardingDynPicList"];
        
        
        if (self.m_imageArray.count==0) {
            
            
            if ([self.m_typeString isEqualToString: KEY_DYNAMIC_SvcShare]) {
                
                [cell.self.m_imgV setImage:[UIImage imageNamed:@"invite_reg_no_photo.png"]];
                
            }else if ([self.m_typeString isEqualToString: KEY_DYNAMIC_ActShare])
            {
                [cell.self.m_imgV setImage:[UIImage imageNamed:@"invite_reg_no_photo.png"]];
                
            }else if ([self.m_typeString isEqualToString: KEY_DYNAMIC_WebViewShare])
            {
                [cell.self.m_imgV setImage:[UIImage imageNamed:@"lianjie.png"]];
                
                
            }else if ([self.m_typeString isEqualToString: KEY_DYNAMIC_DianPingShare]){
                
                [cell.self.m_imgV setImage:[UIImage imageNamed:@"invite_reg_no_photo.png"]];
                
            }
            
            
        }else{
            
            NSDictionary * imageDic = [self.m_imageArray objectAtIndex:0];
            
            NSString *path=[NSString stringWithFormat:@"%@",[imageDic objectForKey:@"MidImgUrl"]];
            
            [cell ShareCellimage:path];
        }
        
        
        for(id tmpView in cell.m_commentView.subviews)
        {
            [tmpView removeFromSuperview];
        }
        for (id tepview in cell.m_zanView.subviews) {
            [tepview removeFromSuperview];
        }
        
        
        //发表说说的点击头像
        cell.m_PhotoBtn.tag = indexPath.row;
        [cell.m_PhotoBtn addTarget:self action:@selector(PhotoBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        // 添加按钮事件
        cell.m_zanBtn.tag = indexPath.row;
        cell.m_zhuanfaBtn.tag = indexPath.row;
        cell.m_pingjiaBtn.tag = indexPath.row;
        [cell.m_zanBtn addTarget:self action:@selector(zanClicked:) forControlEvents:UIControlEventTouchUpInside];
        [cell.m_zhuanfaBtn addTarget:self action:@selector(zhuanfaClicked:) forControlEvents:UIControlEventTouchUpInside];
        [cell.m_pingjiaBtn addTarget:self action:@selector(pingjiaClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.m_linkBtn.tag = indexPath.row;//链接按钮；
        
        [cell.m_linkBtn addTarget:self action:@selector(resourcelink:) forControlEvents:UIControlEventTouchUpInside];
        
        
        NSString *zanString = [self.m_zanDic objectForKey:[NSString stringWithFormat:@"%i",indexPath.row]];
        
        if ( [zanString isEqualToString:@"1"] ) {
            
            // 1表示赞 0表示未赞
            cell.m_cancelLabel.hidden = NO;
            
        }else if ( [zanString isEqualToString:@"0"] ) {
            
            cell.m_cancelLabel.hidden = YES;
            
        }else{
            
            
        }
        
        
        self.m_CommentArray = [Dydic objectForKey:@"DynamicComment"];
        
        self.m_DynamicPraiseArray =[Dydic objectForKey:@"DynamicPraise"];
        
        
        NSString *zanstringman =@"" ;
        CGSize zansize;
        
        if (self.m_DynamicPraiseArray.count == 0) {
            zansize.height = 0;
            cell.m_zanView.hidden = YES;
        }else{
            
            cell.m_zanView.hidden = NO;
            
            zanstringman =[[self.m_DynamicPraiseArray objectAtIndex:0]objectForKey:@"NickName"];
            
            //赞的人数组
            for (int iii=1; iii<self.m_DynamicPraiseArray.count; iii++) {
                
                NSDictionary * zandic = [self.m_DynamicPraiseArray objectAtIndex:iii ];
                
                zanstringman = [NSString stringWithFormat:@"%@、%@",zanstringman,[zandic objectForKey:@"NickName"]];
                
            }
            
            
            zansize = [[NSString stringWithFormat:@"空两%@",zanstringman] sizeWithFont:[UIFont systemFontOfSize:13.0f] constrainedToSize:CGSizeMake(WindowSizeWidth - 87, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
            
            
            if (isIOS5) {
                UILabel * zanl = [[UILabel alloc]initWithFrame:CGRectMake(0, 2, 230, zansize.height)];
                zanl.numberOfLines = 0;
                zanl.backgroundColor = [UIColor clearColor];
                zanl.font = [UIFont fontWithName:@"Baskerville" size:13];
                zanl.text = [NSString stringWithFormat:@"        %@",zanstringman];
                [cell.m_zanView addSubview:zanl];
                
            }else{
                NSArray *URLs;
                NSArray *URLRanges;
                NSAttributedString *as = [self attributedString:&URLs URLRanges:&URLRanges nicknamearray:self.m_DynamicPraiseArray];
                zan_label = [[CXAHyperlinkLabel alloc] initWithFrame:CGRectMake(0, 2, 230, zansize.height)];
                zan_label.numberOfLines = 0;
                zan_label.backgroundColor = [UIColor clearColor];
                zan_label.attributedText = as;
                [zan_label setURLs:URLs forRanges:URLRanges];
                
                
                zan_label.URLClickHandler = ^(CXAHyperlinkLabel *label, NSURL *URL, NSRange range, NSArray *textRects){
                    
                    //点击进入空间
                    //赞的人
                    [self ZannameBtn:[URL absoluteString]];
                    
                };
                
            }
            [cell.m_zanView addSubview:zan_label];
            
            UIImageView * imagevc = [[UIImageView alloc]initWithFrame:CGRectMake(5,0, 18, 18)];
            imagevc.image = [UIImage imageNamed:@"zanyige.png"];
            
            [cell.m_zanView addSubview:imagevc];
            
        }
        
        
        if (NewPingjia&&indexPath.row == Pingjiaindex) {
            
            self.m_commentTextField.text = @"";
            
            NewPingjia = NO;
            
        }
        
        
        
        
        
        if (self.m_CommentArray.count == 0) {
            
            cell.m_commentView.hidden =YES;
            
            
            cell.m_tempView.frame = CGRectMake(cell.m_tempView.frame.origin.x,cell.m_recourceView.frame.origin.y + cell.m_recourceView.frame.size.height+zansize.height , cell.m_tempView.frame.size.width, cell.m_tempView.frame.size.height);
            
            cell.m_lineImgV.frame = CGRectMake(cell.m_lineImgV.frame.origin.x, cell.m_tempView.frame.origin.y + cell.m_tempView.frame.size.height, cell.m_lineImgV.frame.size.width, cell.m_lineImgV.frame.size.height);
            
            cell.m_zanView.frame = CGRectMake(80, cell.m_tempView.frame.origin.y-zansize.height, cell.m_zanView.frame.size.width, zansize.height);
            
            
            return cell;
            
        }
        else if (self.m_CommentArray.count==1) {
            
            cell.m_commentView.hidden =NO;
            
            NSDictionary * dic = [self.m_CommentArray objectAtIndex:0];
            
            NSString *pinglu0 =[NSString stringWithFormat:@"%@:%@",[dic objectForKey:@"NickName"],[dic objectForKey:@"Contents"]];
            
            CGSize pinglu = [pinglu0 sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(WindowSizeWidth - 87, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
            
            UILabel * label = [[UILabel alloc]init];
            
            [label setFrame:CGRectMake(0 , 0, WindowSizeWidth - 97, pinglu.height)];
            
            label.text = pinglu0;
            
            label.backgroundColor = [UIColor clearColor];
            label.textColor = [UIColor lightGrayColor];
            [label setFont:[UIFont systemFontOfSize:14.0f]];
            label.numberOfLines = 0;// 不可少Label属性
            label.lineBreakMode = UILineBreakModeCharacterWrap;// 不可少Label属性之二
            
            [cell.m_commentView setFrame:CGRectMake(80,  cell.m_recourceView.frame.origin.y + cell.m_recourceView.frame.size.height , cell.m_commentView.frame.size.width, pinglu.height)];
            
            [cell.m_commentView addSubview:label];
            
        }
        else if (self.m_CommentArray.count==2) {
            
            CGFloat pingluHIGHT2 = 0;
            cell.m_commentView.hidden =NO;
            
            
            for (int i=0; i<self.m_CommentArray.count; i++) {
                
                
                NSDictionary * dic = [self.m_CommentArray objectAtIndex:0];
                NSString *pinglu0 =[NSString stringWithFormat:@"%@:%@",[dic objectForKey:@"NickName"],[dic objectForKey:@"Contents"]];
                CGSize pinglu = [pinglu0 sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(WindowSizeWidth - 87, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                
                NSDictionary * dic2 = [self.m_CommentArray objectAtIndex:1];
                NSString *pinglustring =[NSString stringWithFormat:@"%@:%@",[dic2 objectForKey:@"NickName"],[dic2 objectForKey:@"Contents"]];
                CGSize size1 = [pinglustring sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(WindowSizeWidth - 87, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                
                
                UILabel * label = [[UILabel alloc]init];
                
                if (i==0)
                {
                    pingluHIGHT2 = pingluHIGHT2+ pinglu.height;
                    
                    [label setFrame:CGRectMake(0 , i*pinglu.height, WindowSizeWidth - 97, pinglu.height)];
                    
                    label.text = pinglu0;
                    
                    
                }else if (i==1)
                {
                    
                    pingluHIGHT2 = pingluHIGHT2+ size1.height;
                    
                    [label setFrame:CGRectMake(0 , i*pinglu.height, WindowSizeWidth - 97, size1.height)];
                    
                    label.text = pinglustring;
                }
                
                label.backgroundColor = [UIColor clearColor];
                label.textColor = [UIColor lightGrayColor];
                [label setFont:[UIFont systemFontOfSize:14.0f]];
                label.numberOfLines = 0;// 不可少Label属性
                label.lineBreakMode = UILineBreakModeCharacterWrap;// 不可少Label属性之二
                
                
                [cell.m_commentView setFrame:CGRectMake(80, cell.m_recourceView.frame.origin.y +cell.m_recourceView.frame.size.height  , cell.m_commentView.frame.size.width, pingluHIGHT2)];
                
                [cell.m_commentView addSubview:label];
                
                
            }
            
        }
        else if (self.m_CommentArray.count>=3) {
            
            CGFloat pingluHIGHT2 = 0;
            cell.m_commentView.hidden =NO;
            
            
            for (int i=0; i<3; i++) {
                
                if (i==2) {
                    
                    UIButton * PINGLUMOREbtn =[UIButton buttonWithType:UIButtonTypeCustom];
                    [PINGLUMOREbtn setFrame:CGRectMake(0, cell.m_commentView.frame.size.height, WindowSizeWidth - 87, 25)];
                    
                    PINGLUMOREbtn.backgroundColor = [UIColor clearColor];
                    [PINGLUMOREbtn setTitle: @"查看更多评论" forState: UIControlStateNormal];
                    [PINGLUMOREbtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
                    [PINGLUMOREbtn.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
                    PINGLUMOREbtn.showsTouchWhenHighlighted = YES;
                    PINGLUMOREbtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
                    
                    PINGLUMOREbtn.tag = indexPath.row;
                    
                    [PINGLUMOREbtn addTarget:self action:@selector(MorepingluView:) forControlEvents:UIControlEventTouchUpInside];
                    
                    [cell.m_commentView setFrame:CGRectMake(80, cell.m_recourceView.frame.origin.y +cell.m_recourceView.frame.size.height , cell.m_commentView.frame.size.width, pingluHIGHT2+25)];
                    
                    [cell.m_commentView addSubview:PINGLUMOREbtn];
                    
                    break;
                    
                }
                
                
                NSDictionary * dic = [self.m_CommentArray objectAtIndex:0];
                NSString *pinglu0 =[NSString stringWithFormat:@"%@:%@",[dic objectForKey:@"NickName"],[dic objectForKey:@"Contents"]];
                CGSize pinglu = [pinglu0 sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(WindowSizeWidth - 87, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                
                NSDictionary * dic2 = [self.m_CommentArray objectAtIndex:1];
                NSString *pinglustring =[NSString stringWithFormat:@"%@:%@",[dic2 objectForKey:@"NickName"],[dic2 objectForKey:@"Contents"]];
                CGSize size1 = [pinglustring sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(WindowSizeWidth - 87, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                
                UILabel * label = [[UILabel alloc]init];
                
                if (i==0)
                {
                    pingluHIGHT2 = pingluHIGHT2+ pinglu.height;
                    
                    [label setFrame:CGRectMake(0 , i*pinglu.height, WindowSizeWidth - 97, pinglu.height)];
                    
                    label.text = pinglu0;
                    
                }else if (i==1)
                {
                    
                    pingluHIGHT2 = pingluHIGHT2+ size1.height;
                    
                    [label setFrame:CGRectMake(0 , i*pinglu.height, WindowSizeWidth - 97, size1.height)];
                    
                    label.text = pinglustring;
                    
                }
                
                label.backgroundColor = [UIColor clearColor];
                label.textColor = [UIColor lightGrayColor];
                [label setFont:[UIFont systemFontOfSize:14.0f]];
                label.numberOfLines = 0;// 不可少Label属性
                label.lineBreakMode = UILineBreakModeCharacterWrap;// 不可少Label属性之二
                
                
                [cell.m_commentView setFrame:CGRectMake(80, cell.m_recourceView.frame.origin.y +cell.m_recourceView.frame.size.height , cell.m_commentView.frame.size.width, pingluHIGHT2)];
                
                [cell.m_commentView addSubview:label];
                
                
            }
            
        }
        
        
        cell.m_tempView.frame = CGRectMake(cell.m_tempView.frame.origin.x, cell.m_commentView.frame.origin.y + cell.m_commentView.frame.size.height+zansize.height, cell.m_tempView.frame.size.width, cell.m_tempView.frame.size.height);
        
        cell.m_lineImgV.frame = CGRectMake(cell.m_lineImgV.frame.origin.x, cell.m_tempView.frame.origin.y + cell.m_tempView.frame.size.height, cell.m_lineImgV.frame.size.width, cell.m_lineImgV.frame.size.height);
        
        cell.m_zanView.frame = CGRectMake(80, cell.m_tempView.frame.origin.y-zansize.height, cell.m_zanView.frame.size.width, zansize.height);
        
        
        return cell;
        
    }
    
    return nil;
    
    
}



#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.view endEditing:YES];
    [self.view endEditing:YES];
    
    NSMutableDictionary *dic = [self.m_DynamicArray objectAtIndex:indexPath.row];
    MorecommentViewController * VC = [[MorecommentViewController alloc]initWithNibName:@"MorecommentViewController" bundle:nil];
    VC.m_MoreDIC  = dic;
    [self.navigationController pushViewController:VC animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.m_DynamicArray.count == 0) {
        
        return 0;
    }
    
    NSDictionary * Dydic = [self.m_DynamicArray objectAtIndex:indexPath.row];
    
    self.m_CommentArray = [Dydic objectForKey:@"DynamicComment"];
    self.m_DynamicPraiseArray =[Dydic objectForKey:@"DynamicPraise"];
    
    if (NewPingjia&&indexPath.row == Pingjiaindex) {
        
        NSMutableDictionary * dic = [[NSMutableDictionary alloc]initWithCapacity:0];
        [dic setObject:[CommonUtil getValueByKey:NICK] forKey:@"NickName"];
        [dic setObject:[NSString stringWithFormat:@"%@",self.m_commentTextField.text] forKey:@"Contents"];
        
        [self.m_CommentArray addObject:dic];
        
    }
    
    //表示原态
    if ([[NSString stringWithFormat:@"%@",[Dydic objectForKey:@"FormDynamicType"]] isEqualToString:@""]) {
        
        self.m_typeString = [NSString stringWithFormat:@"%@",[Dydic objectForKey:@"DynamicType"]];
        
        //表示发表的说说
        if ( [self.m_typeString isEqualToString: KEY_DYNAMIC_FRIENDS]||[self.m_typeString isEqualToString: KEY_DYNAMIC_FromFRIENDS]) {
            
            NSString *string =  [NSString stringWithFormat:@"%@",[Dydic objectForKey:@"Contents"]];//说说内容
            
            self.m_imageArray = [Dydic objectForKey:@"DynamicPicList"];
            
            //说话内容的高度
            CGSize size = [string sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(WindowSizeWidth - 87, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
            
            NSString *zanstring =@"";
            CGSize zansize;
            
            NSMutableDictionary * dicdic = [[NSMutableDictionary alloc]initWithCapacity:0];
            
            if (zanaddordel==1&&Zanindex==indexPath.row){
                
                [dicdic setObject:[NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:NICK]] forKey:@"NickName"];
                [dicdic setObject:[NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:MEMBER_ID]]forKey:@"MemberID"];
                @try {
                    [self.m_DynamicPraiseArray addObject:dicdic];
                }
                @catch (NSException *exception) {
                }
                @finally {
                    
                }
                zanaddordel = 0;
                
            }else if (zanaddordel ==2&&Zanindex ==indexPath.row ){
                
                for (int iii=0; iii<self.m_DynamicPraiseArray.count; iii++) {
                    
                    if ([[[self.m_DynamicPraiseArray objectAtIndex:iii]objectForKey:@"MemberID"] isEqualToString:[CommonUtil getValueByKey:MEMBER_ID]]) {
                        
                        [self.m_DynamicPraiseArray removeObjectAtIndex:iii];
                    }
                }
                zanaddordel = 0;
            }
            
            if (self.m_DynamicPraiseArray.count == 0) {
                
                zansize.height = 0;
                
            }else{
                //赞的人数组
                for (int iii=0; iii<self.m_DynamicPraiseArray.count; iii++) {
                    
                    NSDictionary * zandic = [self.m_DynamicPraiseArray objectAtIndex:iii ];
                    
                    zanstring = [NSString stringWithFormat:@"%@,%@",zanstring,[zandic objectForKey:@"NickName"]];
                    
                }
                
                zanstring = [NSString stringWithFormat:@"空两%@",zanstring];
                
                zansize = [zanstring sizeWithFont:[UIFont systemFontOfSize:13.0f] constrainedToSize:CGSizeMake(WindowSizeWidth - 87, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
            }
            
            int line = 0;
            //有图片
            if (self.m_imageArray.count>0) {
                
                if (self.m_imageArray.count<=3) {
                    line =0;
                }else if (self.m_imageArray.count<=6){
                    line =1;
                }else if (self.m_imageArray.count<=9){
                    line =2;
                }
                
                //没有评论
                if (self.m_CommentArray.count == 0) {
                    
                    return 39 + size.height + 30 + ((line+1)*80) - 5  +(zansize.height);
                    
                    //一条评论
                }else if (self.m_CommentArray.count == 1){
                    
                    NSDictionary * dic = [self.m_CommentArray objectAtIndex:0];
                    NSString *pinglustring =[NSString stringWithFormat:@"%@:%@",[dic objectForKey:@"NickName"],[dic objectForKey:@"Contents"]];
                    CGSize size1 = [pinglustring sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(WindowSizeWidth - 87, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                    
                    return 30 + size.height + 30 + ((line+1)*80)+size1.height -5  +(zansize.height);
                    //两条评论
                }else if (self.m_CommentArray.count == 2){
                    
                    
                    CGFloat SIZEPING = 0;
                    
                    for (int i=0; i<2; i++) {
                        
                        NSDictionary * dic = [self.m_CommentArray objectAtIndex:i];
                        NSString *pinglustring =[NSString stringWithFormat:@"%@:%@",[dic objectForKey:@"NickName"],[dic objectForKey:@"Contents"]];
                        
                        CGSize size1 = [pinglustring sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(WindowSizeWidth - 87, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                        
                        SIZEPING =SIZEPING+size1.height;
                        
                    }
                    return 30 + size.height + 30 + ((line+1)*80) +SIZEPING -5  +(zansize.height);
                    
                    //超过两条评论
                }else if (self.m_CommentArray.count >=3){
                    
                    CGFloat SIZEPING = 0;
                    
                    for (int i=0; i<2; i++) {
                        
                        
                        NSDictionary * dic = [self.m_CommentArray objectAtIndex:i];
                        NSString *pinglustring =[NSString stringWithFormat:@"%@:%@",[dic objectForKey:@"NickName"],[dic objectForKey:@"Contents"]];
                        
                        CGSize size1 = [pinglustring sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(WindowSizeWidth - 87, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                        
                        SIZEPING =SIZEPING+size1.height;
                        
                    }
                    return 30 + size.height + 30 + ((line+1)*80) +SIZEPING + 20 +(zansize.height);
                    
                }
                
            }
            //空的图片
            else{
                
                //没有评论
                if (self.m_CommentArray.count == 0) {
                    
                    return 30 + size.height + 25 + zansize.height;
                    
                    //一条评论
                }else if (self.m_CommentArray.count == 1){
                    
                    NSDictionary * dic = [self.m_CommentArray objectAtIndex:0];
                    NSString *pinglustring =[NSString stringWithFormat:@"%@:%@",[dic objectForKey:@"NickName"],[dic objectForKey:@"Contents"]];
                    
                    CGSize size1 = [pinglustring sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(WindowSizeWidth - 87, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                    
                    return 39 + size.height + 30 +size1.height +5  +(zansize.height);
                    
                    //两条评论
                }else if (self.m_CommentArray.count == 2){
                    
                    CGFloat SIZEPING = 0;
                    
                    for (int i=0; i<2; i++) {
                        
                        NSDictionary * dic = [self.m_CommentArray objectAtIndex:0];
                        NSString *pinglustring =[NSString stringWithFormat:@"%@:%@",[dic objectForKey:@"NickName"],[dic objectForKey:@"Contents"]];
                        
                        CGSize size1 = [pinglustring sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(WindowSizeWidth - 87, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                        
                        SIZEPING =SIZEPING+size1.height;
                        
                    }
                    
                    return 39 + size.height + 30 + +SIZEPING -5  +(zansize.height);
                    
                    //超过两条评论
                }else if (self.m_CommentArray.count >=3){
                    
                    CGFloat SIZEPING = 0;
                    
                    for (int i=0; i<2; i++) {
                        
                        NSDictionary * dic = [self.m_CommentArray objectAtIndex:0];
                        NSString *pinglustring =[NSString stringWithFormat:@"%@:%@",[dic objectForKey:@"NickName"],[dic objectForKey:@"Contents"]];
                        
                        CGSize size1 = [pinglustring sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(WindowSizeWidth - 87, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                        
                        SIZEPING =SIZEPING+size1.height;
                        
                    }
                    return 39 + size.height + 30 +  +SIZEPING +20  +(zansize.height);
                    
                }
                
            }
            
        }
        
        //表示是分享的产品、链接
        else  if ([self.m_typeString isEqualToString: KEY_DYNAMIC_SvcShare]||[self.m_typeString isEqualToString: KEY_DYNAMIC_WebViewShare]||[self.m_typeString isEqualToString: KEY_DYNAMIC_DianPingShare] ){
            
            CGSize size ;
            NSString * string =  [NSString stringWithFormat:@"%@",[Dydic objectForKey:@"Contents"]];//说说内容
            
            if ([string isEqualToString:@""]) {
                
                size.height = 0.f;
                
            }else{
                size= [string sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(WindowSizeWidth - 87, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                
            }
            
            NSString *zanstring =@"" ;
            CGSize zansize;
            
            NSMutableDictionary * dicdic = [[NSMutableDictionary alloc]initWithCapacity:0];
            
            if (zanaddordel==1&&Zanindex==indexPath.row){
                
                [dicdic setObject:[NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:NICK]] forKey:@"NickName"];
                [dicdic setObject:[NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:MEMBER_ID]]forKey:@"MemberID"];
                
                @try {
                    [self.m_DynamicPraiseArray addObject:dicdic];
                }
                @catch (NSException *exception) {
                }
                @finally {
                    
                }
                
                
                zanaddordel = 0;
                
            }else if (zanaddordel ==2&&Zanindex ==indexPath.row ){
                
                for (int iii=0; iii<self.m_DynamicPraiseArray.count; iii++) {
                    
                    if ([[[self.m_DynamicPraiseArray objectAtIndex:iii]objectForKey:@"MemberID"] isEqualToString:[CommonUtil getValueByKey:MEMBER_ID]]) {
                        
                        [self.m_DynamicPraiseArray removeObjectAtIndex:iii];
                    }
                }
                zanaddordel = 0;
            }
            
            if (self.m_DynamicPraiseArray.count == 0) {
                
                zansize.height = 0;
                
            }else{
                //赞的人数组
                for (int iii=0; iii<self.m_DynamicPraiseArray.count; iii++) {
                    
                    NSDictionary * zandic = [self.m_DynamicPraiseArray objectAtIndex:iii ];
                    
                    zanstring = [NSString stringWithFormat:@"%@,%@",zanstring,[zandic objectForKey:@"NickName"]];
                }
                zanstring = [NSString stringWithFormat:@"空两%@",zanstring];
                zansize = [zanstring sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(WindowSizeWidth - 87, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
            }
            
            
            
            if (self.m_CommentArray.count == 0) {
                
                return 39 + size.height + 70 + 29 +zansize.height;
                
                
            }else if (self.m_CommentArray.count == 1){
                
                NSDictionary * dic = [self.m_CommentArray objectAtIndex:0];
                NSString *pinglustring =[NSString stringWithFormat:@"%@:%@",[dic objectForKey:@"NickName"],[dic objectForKey:@"Contents"]];
                
                CGSize size1 = [pinglustring sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(WindowSizeWidth - 87, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                
                return 39 + size.height + 70 + 29 +size1.height +zansize.height;
                
            }else if (self.m_CommentArray.count == 2){
                
                CGFloat SIZEPING = 0;
                
                for (int i=0; i<2; i++) {
                    
                    NSDictionary * dic = [self.m_CommentArray objectAtIndex:i];
                    NSString *pinglustring =[NSString stringWithFormat:@"%@:%@",[dic objectForKey:@"NickName"],[dic objectForKey:@"Contents"]];
                    
                    CGSize size1 = [pinglustring sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(WindowSizeWidth - 87, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                    
                    SIZEPING =SIZEPING+size1.height;
                    
                }
                
                return 39 + size.height + 70 +SIZEPING +29 +zansize.height;
                
                
            }else if (self.m_CommentArray.count >=3){
                
                CGFloat SIZEPING = 0;
                
                for (int i=0; i<2; i++) {
                    
                    NSDictionary * dic = [self.m_CommentArray objectAtIndex:i];
                    NSString *pinglustring =[NSString stringWithFormat:@"%@:%@",[dic objectForKey:@"NickName"],[dic objectForKey:@"Contents"]];
                    
                    CGSize size1 = [pinglustring sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(WindowSizeWidth - 87, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                    
                    SIZEPING =SIZEPING+size1.height;
                    
                }
                return 39 + size.height + 70 + 29 +SIZEPING + 25  +zansize.height;
                
            }
            
        }
        
    }
    //表示转发
    else if (![[NSString stringWithFormat:@"%@",[Dydic objectForKey:@"FormDynamicType"]] isEqualToString:@""])
    {
        self.m_typeString = [NSString stringWithFormat:@"%@",[Dydic objectForKey:@"FormDynamicType"]];
        
        //表示转发的原型《发表的内容》
        if ( [self.m_typeString isEqualToString: KEY_DYNAMIC_FRIENDS]||[self.m_typeString isEqualToString: KEY_DYNAMIC_FromFRIENDS]) {
            
            NSString *string = @"";
            
            NSString * FromName = [NSString stringWithFormat:@"%@",[Dydic objectForKey:@"FormNickName"]];
            
            self.m_imageArray = [Dydic objectForKey:@"ForwardingDynPicList"];
            
            if ( FromName.length != 0 ) {
                
                //不同颜色
                string = [NSString stringWithFormat:@"%@|%@:%@",[Dydic objectForKey:@"Contents"],FromName,[Dydic objectForKey:@"ForwardingContents"]];
                
            }else{
                
                string =[NSString stringWithFormat:@"%@|%@",[Dydic objectForKey:@"Contents"],[Dydic objectForKey:@"ForwardingContents"]];
            }
            
            //说话内容的高度
            CGSize size = [string sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(WindowSizeWidth - 87, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
            
            NSString *zanstring =@"" ;
            CGSize zansize;
            
            NSMutableDictionary * dicdic = [[NSMutableDictionary alloc]initWithCapacity:0];
            
            if (zanaddordel==1&&Zanindex==indexPath.row){
                
                [dicdic setObject:[NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:NICK]] forKey:@"NickName"];
                [dicdic setObject:[NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:MEMBER_ID]]forKey:@"MemberID"];
                @try {
                    [self.m_DynamicPraiseArray addObject:dicdic];
                }
                @catch (NSException *exception) {
                }
                @finally {
                    
                }
                zanaddordel = 0;
                
            }else if (zanaddordel ==2&&Zanindex ==indexPath.row ){
                
                for (int iii=0; iii<self.m_DynamicPraiseArray.count; iii++) {
                    
                    if ([[[self.m_DynamicPraiseArray objectAtIndex:iii]objectForKey:@"MemberID"] isEqualToString:[CommonUtil getValueByKey:MEMBER_ID]]) {
                        
                        [self.m_DynamicPraiseArray removeObjectAtIndex:iii];
                    }
                }
                zanaddordel = 0;
            }
            
            if (self.m_DynamicPraiseArray.count == 0) {
                
                zansize.height = 0;
                
            }else{
                //赞的人数组
                for (int iii=0; iii<self.m_DynamicPraiseArray.count; iii++) {
                    
                    NSDictionary * zandic = [self.m_DynamicPraiseArray objectAtIndex:iii ];
                    
                    zanstring = [NSString stringWithFormat:@"%@,%@",zanstring,[zandic objectForKey:@"NickName"]];
                    
                }
                zanstring = [NSString stringWithFormat:@"空两%@",zanstring];
                zansize = [zanstring sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(WindowSizeWidth - 87, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
            }
            
            
            int line = 0;
            //有图片
            if (self.m_imageArray.count>0) {
                
                if (self.m_imageArray.count<=3) {
                    line =0;
                }else if (self.m_imageArray.count<=6){
                    line =1;
                }else if (self.m_imageArray.count<=9){
                    line =2;
                }
                
                
                //没有评论
                if (self.m_CommentArray.count == 0) {
                    
                    
                    return 39 + size.height + 30 + ((line+1)*80) - 5  +(zansize.height);
                    
                    //一条评论
                }else if (self.m_CommentArray.count == 1){
                    
                    NSDictionary * dic = [self.m_CommentArray objectAtIndex:0];
                    NSString *pinglustring =[NSString stringWithFormat:@"%@:%@",[dic objectForKey:@"NickName"],[dic objectForKey:@"Contents"]];
                    CGSize size1 = [pinglustring sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(WindowSizeWidth - 87, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                    
                    return 39 + size.height + 30 + ((line+1)*80)+size1.height -5  +(zansize.height);
                    //两条评论
                }else if (self.m_CommentArray.count == 2){
                    
                    
                    CGFloat SIZEPING = 0;
                    
                    for (int i=0; i<2; i++) {
                        
                        NSDictionary * dic = [self.m_CommentArray objectAtIndex:i];
                        NSString *pinglustring =[NSString stringWithFormat:@"%@:%@",[dic objectForKey:@"NickName"],[dic objectForKey:@"Contents"]];
                        
                        CGSize size1 = [pinglustring sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(WindowSizeWidth - 87, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                        
                        SIZEPING =SIZEPING+size1.height;
                        
                    }
                    return 39 + size.height + 30 + ((line+1)*80) +SIZEPING -5  +(zansize.height);
                    
                    //超过两条评论
                }else if (self.m_CommentArray.count >=3){
                    
                    CGFloat SIZEPING = 0;
                    
                    for (int i=0; i<2; i++) {
                        
                        
                        NSDictionary * dic = [self.m_CommentArray objectAtIndex:i];
                        NSString *pinglustring =[NSString stringWithFormat:@"%@:%@",[dic objectForKey:@"NickName"],[dic objectForKey:@"Contents"]];
                        
                        CGSize size1 = [pinglustring sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(WindowSizeWidth - 87, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                        
                        SIZEPING =SIZEPING+size1.height;
                        
                    }
                    return 39 + size.height + 30 + ((line+1)*80) +SIZEPING + 20 +(zansize.height);
                    
                }
                
            }
            //空的图片
            else{
                
                //没有评论
                if (self.m_CommentArray.count == 0) {
                    
                    return 39 + size.height + 25 +(zansize.height);
                    
                    //一条评论
                }else if (self.m_CommentArray.count == 1){
                    
                    NSDictionary * dic = [self.m_CommentArray objectAtIndex:0];
                    NSString *pinglustring =[NSString stringWithFormat:@"%@:%@",[dic objectForKey:@"NickName"],[dic objectForKey:@"Contents"]];
                    
                    CGSize size1 = [pinglustring sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(WindowSizeWidth - 87, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                    
                    return 39 + size.height + 30 +size1.height +5  +(zansize.height);
                    
                    //两条评论
                }else if (self.m_CommentArray.count == 2){
                    
                    CGFloat SIZEPING = 0;
                    
                    for (int i=0; i<2; i++) {
                        
                        NSDictionary * dic = [self.m_CommentArray objectAtIndex:0];
                        NSString *pinglustring =[NSString stringWithFormat:@"%@:%@",[dic objectForKey:@"NickName"],[dic objectForKey:@"Contents"]];
                        
                        CGSize size1 = [pinglustring sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(WindowSizeWidth - 87, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                        
                        SIZEPING =SIZEPING+size1.height;
                        
                    }
                    
                    return 39 + size.height + 30 + +SIZEPING -5  +(zansize.height);
                    
                    //超过两条评论
                }else if (self.m_CommentArray.count >=3){
                    
                    CGFloat SIZEPING = 0;
                    
                    for (int i=0; i<2; i++) {
                        
                        NSDictionary * dic = [self.m_CommentArray objectAtIndex:0];
                        NSString *pinglustring =[NSString stringWithFormat:@"%@:%@",[dic objectForKey:@"NickName"],[dic objectForKey:@"Contents"]];
                        
                        CGSize size1 = [pinglustring sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(WindowSizeWidth - 87, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                        
                        SIZEPING =SIZEPING+size1.height;
                        
                    }
                    return 39 + size.height + 30 +  +SIZEPING +20  +(zansize.height);
                    
                }
                
            }
            
        }
        
        //表示是的原型《产品、链接》
        else  if ([self.m_typeString isEqualToString: KEY_DYNAMIC_SvcShare]||[self.m_typeString isEqualToString: KEY_DYNAMIC_WebViewShare]||[self.m_typeString isEqualToString: KEY_DYNAMIC_DianPingShare] ){
            
            NSString * FromName = [NSString stringWithFormat:@"%@",[Dydic objectForKey:@"FormNickName"]];
            
            NSString * string = @"";
            if ( FromName.length != 0 ) {
                
                //不同颜色
                string = [NSString stringWithFormat:@"%@|%@:%@",[Dydic objectForKey:@"Contents"],FromName,[Dydic objectForKey:@"ForwardingContents"]];
                
            }else{
                
                string =[NSString stringWithFormat:@"%@|%@",[Dydic objectForKey:@"Contents"],[Dydic objectForKey:@"ForwardingContents"]];
            }
            
            CGSize size ;
            
            if ([string isEqualToString:@""]) {
                
                size.height = 0.f;
                
            }else{
                size= [string sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(WindowSizeWidth - 87, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                
            }
            
            NSString *zanstring =@"" ;
            CGSize zansize;
            
            NSMutableDictionary * dicdic = [[NSMutableDictionary alloc]initWithCapacity:0];
            
            if (zanaddordel==1&&Zanindex==indexPath.row){
                
                [dicdic setObject:[NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:NICK]] forKey:@"NickName"];
                [dicdic setObject:[NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:MEMBER_ID]]forKey:@"MemberID"];
                @try {
                    [self.m_DynamicPraiseArray addObject:dicdic];
                }
                @catch (NSException *exception) {
                }
                @finally {
                    
                }
                zanaddordel = 0;
                
            }else if (zanaddordel ==2&&Zanindex ==indexPath.row ){
                
                for (int iii=0; iii<self.m_DynamicPraiseArray.count; iii++) {
                    
                    if ([[[self.m_DynamicPraiseArray objectAtIndex:iii]objectForKey:@"MemberID"] isEqualToString:[CommonUtil getValueByKey:MEMBER_ID]]) {
                        
                        [self.m_DynamicPraiseArray removeObjectAtIndex:iii];
                    }
                }
                zanaddordel = 0;
            }
            
            if (self.m_DynamicPraiseArray.count == 0) {
                
                zansize.height = 0;
                
            }else{
                //赞的人数组
                for (int iii=0; iii<self.m_DynamicPraiseArray.count; iii++) {
                    
                    NSDictionary * zandic = [self.m_DynamicPraiseArray objectAtIndex:iii ];
                    
                    zanstring = [NSString stringWithFormat:@"%@,%@",zanstring,[zandic objectForKey:@"NickName"]];
                }
                zanstring = [NSString stringWithFormat:@"空两%@",zanstring];
                
                zansize = [zanstring sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(WindowSizeWidth - 87, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
            }
            
            
            
            if (self.m_CommentArray.count == 0) {
                
                return 39 + size.height + 70 + 29 +zansize.height;
                
                
            }else if (self.m_CommentArray.count == 1){
                
                NSDictionary * dic = [self.m_CommentArray objectAtIndex:0];
                NSString *pinglustring =[NSString stringWithFormat:@"%@:%@",[dic objectForKey:@"NickName"],[dic objectForKey:@"Contents"]];
                
                CGSize size1 = [pinglustring sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(WindowSizeWidth - 87, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                
                return 39 + size.height + 70 + 29 +size1.height +zansize.height;
                
            }else if (self.m_CommentArray.count == 2){
                
                CGFloat SIZEPING = 0;
                
                for (int i=0; i<2; i++) {
                    
                    NSDictionary * dic = [self.m_CommentArray objectAtIndex:i];
                    NSString *pinglustring =[NSString stringWithFormat:@"%@:%@",[dic objectForKey:@"NickName"],[dic objectForKey:@"Contents"]];
                    
                    CGSize size1 = [pinglustring sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(WindowSizeWidth - 87, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                    
                    SIZEPING =SIZEPING+size1.height;
                    
                }
                
                return 39 + size.height + 70 +SIZEPING +29 +zansize.height;
                
                
            }else if (self.m_CommentArray.count >=3){
                
                CGFloat SIZEPING = 0;
                
                for (int i=0; i<2; i++) {
                    
                    NSDictionary * dic = [self.m_CommentArray objectAtIndex:i];
                    NSString *pinglustring =[NSString stringWithFormat:@"%@:%@",[dic objectForKey:@"NickName"],[dic objectForKey:@"Contents"]];
                    
                    CGSize size1 = [pinglustring sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(WindowSizeWidth - 87, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                    
                    SIZEPING =SIZEPING+size1.height;
                    
                }
                return 39 + size.height + 70 + 29 +SIZEPING + 25  +zansize.height;
                
            }
            
        }
    }
    
    return 0;
    
}


//发送评价
- (IBAction)sendCommentClicked:(id)sender {
    
    [self.m_textField resignFirstResponder];
    
    [self.m_commentTextField resignFirstResponder];
    
    [self.view endEditing:YES];
    
    
    if ( self.m_commentTextField.text.length == 0 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请输入要评价的内容"];
        
        return;
    }
    
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    NSMutableDictionary *dic = [self.m_DynamicArray objectAtIndex:Pingjiaindex];
    
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    AppHttpClient* httpClient = [AppHttpClient sharedSpace];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,     @"memberId",
                           key,   @"key",
                           [NSString stringWithFormat:@"%@",[dic objectForKey:@"DynamicID"]],@"dynamicID",
                           @"0",@"toMemberID",
                           [NSString stringWithFormat:@"%@",self.m_commentTextField.text],@"contents",
                           nil];
    
    [SVProgressHUD showWithStatus:@"数据提交中"];
    
    [httpClient requestSpace:@"DynamicComment.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showSuccessWithStatus:msg];
            
            NewPingjia = YES;
            
            // 刷新某一行
            
            NSArray *arr = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:Pingjiaindex inSection:0]];
            
            [self.m_tableView reloadRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationNone];//不刷新高度
            
        } else {
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
    } failure:^(NSError *error) {
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:@"提交失败，请稍后再试！"];

    }];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [self.view endEditing:YES];
    [self.view endEditing:YES];
    
    return YES;
    
}


- (void)productDetail:(NSDictionary*)sender ID:(NSString*)ZF{
    // 进入商品详情-商品
    ProductDetailViewController *VC = [[ProductDetailViewController alloc]initWithNibName:@"ProductDetailViewController" bundle:nil];
    
    VC.m_FromDPId = @"0";
    
    if ([ZF isEqualToString:@"1"]) {
        VC.m_productId = [NSString stringWithFormat:@"%@",[sender objectForKey:@"FormSvcId"]];
        VC.m_merchantShopId = [NSString stringWithFormat:@"%@",[sender objectForKey:@"FormMerchantShopId"]];
    }else{
        VC.m_productId = [NSString stringWithFormat:@"%@",[sender objectForKey:@"ServiceID"]];
        VC.m_merchantShopId = [NSString stringWithFormat:@"%@",[sender objectForKey:@"MerchantShopID"]];
    }
    
    
    [self.navigationController pushViewController:VC animated:YES];
    
}

- (void)activityDetail:(NSDictionary*)sender ID:(NSString*)ZF{
    
    // 进入商品详情 - 活动
    ActivityDetailViewController *VC = [[ActivityDetailViewController alloc]initWithNibName:@"ActivityDetailViewController" bundle:nil];
    
    VC.m_typeString = MERCHANTACTIVITY;
    VC.m_partyString = @"1";
    
    if ([ZF isEqualToString:@"1"]) {
        VC.m_serviceId = [NSString stringWithFormat:@"%@",[sender objectForKey:@"FormActId"]];
    }else{
        VC.m_serviceId = [NSString stringWithFormat:@"%@",[sender objectForKey:@"ActivityID"]];
        
    }
    
    
    [self.navigationController pushViewController:VC animated:YES];
}

- (void)DPDetail:(NSDictionary*)sender ID:(NSString*)ZF{
    
    // 进入商品详情 -点评
    ProductDetailViewController *VC = [[ProductDetailViewController alloc]initWithNibName:@"ProductDetailViewController" bundle:nil];
    
    VC.m_FromDPId = @"1";
    
    if ([ZF isEqualToString:@"1"]) {
        VC.m_productId = [NSString stringWithFormat:@"%@",[sender objectForKey:@"FormdealId"]];
        
    }else{
        VC.m_productId = [NSString stringWithFormat:@"%@",[sender objectForKey:@"DealId"]];
   
    }
    
    [self.navigationController pushViewController:VC animated:YES];
}




//赞
- (void)zanClicked:(id)sender{
    
    [self.view endEditing:YES];
    [self.view endEditing:YES];
    
    UIButton *btn = (UIButton *)sender;
    
    NSMutableDictionary *dic = [self.m_DynamicArray objectAtIndex:btn.tag];
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    AppHttpClient* httpClient = [AppHttpClient sharedSpace];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,     @"memberId",
                           key,   @"key",
                           [NSString stringWithFormat:@"%@",[dic objectForKey:@"DynamicID"]],@"dynamicID",
                           nil];
    
    [SVProgressHUD showWithStatus:@"数据提交中"];
    
    [httpClient requestSpace:@"Praise.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showSuccessWithStatus:msg];
            
            if (  [[self.m_zanDic objectForKey:[NSString stringWithFormat:@"%i",btn.tag]] isEqualToString:@"0"] ) {
                zanaddordel = 1;
                [self.m_zanDic setValue:@"1" forKey:[NSString stringWithFormat:@"%i",btn.tag]];
                
            }else{
                //没有赞
                zanaddordel = 2;
                [self.m_zanDic setValue:@"0" forKey:[NSString stringWithFormat:@"%i",btn.tag]];
            }
            Zanindex = btn.tag;
            
            // 刷新某一行
            NSArray *arr = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:btn.tag inSection:0]];
            
            [self.m_tableView reloadRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationNone];
            
            
        } else {
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
    } failure:^(NSError *error) {
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:@"提交失败，请稍后再试！"];

    }];
    
}

#pragma mark - BtnClicked
- (void)zhuanfaClicked:(id)sender{
    
    [self.view endEditing:YES];
    [self.view endEditing:YES];
    
    UIButton *btn = (UIButton *)sender;
    
    NSMutableDictionary *dic = [self.m_DynamicArray objectAtIndex:btn.tag];
    
    // 进入转发页面
    ForwardingViewController *VC = [[ForwardingViewController alloc]initWithNibName:@"ForwardingViewController" bundle:nil];
    
    VC.m_Dyanmicdic = dic;
    
    VC.forwarddele = self;
    
    [self.navigationController pushViewController:VC animated:YES];
    
}

//评价
- (void)pingjiaClicked:(id)sender{
    
    [self hiddenNumPadDone:nil];
    
    UIButton *btn = (UIButton *)sender;
    
    Pingjiaindex = btn.tag;
    
    [self.m_textField becomeFirstResponder];
    
    [self.m_commentTextField becomeFirstResponder];
    
    // 点击评价，设置tableView滚动到第几行
    [self.m_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:btn.tag inSection:0]atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
}

- (void)resourcelink:(id)sender{
    
    [self.view endEditing:YES];
    [self.view endEditing:YES];
    
    UIButton *btn = (UIButton *)sender;
    
    
    NSDictionary * Dydic = [self.m_DynamicArray objectAtIndex:btn.tag];
    
    NSString * Type;
    
    NSString * ID;
    
    if ([[NSString stringWithFormat:@"%@",[Dydic objectForKey:@"FormDynamicType"]] isEqualToString:@""]) {
        
        Type = [NSString stringWithFormat:@"%@",[Dydic objectForKey:@"DynamicType"]];
        
        ID = @"0";
        
    }else if (![[NSString stringWithFormat:@"%@",[Dydic objectForKey:@"FormDynamicType"]] isEqualToString:@""])
    {
        Type = [NSString stringWithFormat:@"%@",[Dydic objectForKey:@"FormDynamicType"]];
        
        ID = @"1";
        
    }
    
    
    if ([Type isEqualToString: KEY_DYNAMIC_SvcShare]) {
        
        [self productDetail:Dydic ID:ID];
        
    }else if ([Type isEqualToString: KEY_DYNAMIC_ActShare])
    {
        [self activityDetail:Dydic ID:ID];
        
    }else if ([Type isEqualToString: KEY_DYNAMIC_WebViewShare])
    {
        // 进入网页页面
        WebViewController *VC = [[WebViewController alloc]initWithNibName:@"WebViewController" bundle:nil];
        
        if ([[NSString stringWithFormat:@"%@",[Dydic objectForKey:@"FormDynamicType"]] isEqualToString:@""]) {
            
            VC.m_scanString = [NSString stringWithFormat:@"%@",[Dydic objectForKey:@"WebUrl"]];
            
        }else if (![[NSString stringWithFormat:@"%@",[Dydic objectForKey:@"FormDynamicType"]] isEqualToString:@""])
        {
            VC.m_scanString = [NSString stringWithFormat:@"%@",[Dydic objectForKey:@"FormWebUrl"]];
        }
        
        VC.m_typeString = @"2";
        
        [self.navigationController pushViewController:VC animated:YES];
        
    }else if ([Type isEqualToString: KEY_DYNAMIC_DianPingShare]){
        
        [self DPDetail:Dydic  ID:ID];
        
    }
    
    
}


//进入发表页面
- (IBAction) Publishing:(id)sender
{
    PublishViewController *VC = [PublishViewController PshareobjectSEL];
    
    VC.publishdele = self;
    
    [self.navigationController pushViewController:VC animated:YES];
    
}

// 进入新评论的页面
- (IBAction)newCommentClicked:(id)sender {
    
    // 将保存的数据置空为0
    [CommonUtil addValue:@"0" andKey:DynamicComments];
    
    // 进入新评论的页面
    NewCommentViewController *VC = [[NewCommentViewController alloc]initWithNibName:@"NewCommentViewController" bundle:nil];
    [self.navigationController pushViewController:VC animated:YES];
    
}

//放大图片
- (void)ChangeBigImage:(id)sender
{
    
    [self.view endEditing:YES];
    [self.view endEditing:YES];
    
    int index;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0&&[[[UIDevice currentDevice] systemVersion] floatValue]<8.0) {
        //获取Cell的indexpath.row
        index = [self.m_tableView indexPathForCell:((DynamicCell*)[[[[sender   superview]superview] superview]superview])].row; //这个方便一点点，不用设置tag。
    }else
    {
        //获取Cell的indexpath.row
        index = [self.m_tableView indexPathForCell:((DynamicCell*)[[[sender   superview]superview] superview])].row; //这个方便一点点，不用设置tag。
    }
    
    
    NSDictionary * Dydic = [self.m_DynamicArray objectAtIndex:index];
    
    self.m_typeString = [NSString stringWithFormat:@"%@",[Dydic objectForKey:@"DynamicType"]];
    
    //好友动态
    if ([self.m_typeString isEqualToString: KEY_DYNAMIC_FRIENDS]) {
        
        self.m_BigimageArray = [[self.m_DynamicArray objectAtIndex:index] objectForKey:@"DynamicPicList"];
        
    }
    //转发动态
    else if ([self.m_typeString isEqualToString: KEY_DYNAMIC_FromFRIENDS]) {
        
        self.m_BigimageArray = [[self.m_DynamicArray objectAtIndex:index] objectForKey:@"ForwardingDynPicList"];
        
    }
    
    
    UIButton *btn = (UIButton *)sender;
    
    int count = self.m_BigimageArray.count;
    // 1.封装图片数据
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i<count; i++) {
        // 替换为中等尺寸图片
        NSDictionary * BigimageDic = [self.m_BigimageArray objectAtIndex:i];
        NSString *path = [BigimageDic objectForKey:@"BigImgUrl"];
        MJPhoto *photo = [[MJPhoto alloc] init];
        photo.url = [NSURL URLWithString:path]; // 图片路径
        
        DynamicCell *cell = (DynamicCell *)[self tableView:self.m_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
        UIButton * BBBtn = cell.m_ImgView.subviews[i];
        if (BBBtn.imageView.image !=nil) {
            photo.srcImageView = BBBtn.imageView;
        }
        [photos addObject:photo];

    }
    
    
    // 2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = btn.tag; // 弹出相册时显示的第一张图片是？
    browser.photos = photos; // 设置所有的图片
    
    [browser show];
    
    
}



#pragma mark- 缩放图片
-(UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize {
    
    // 将图片存储在字典里
    UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, image.size.height*[UIScreen mainScreen].bounds.size.width/image.size.width)];
    
    imgV.image = [CommonUtil scaleImage:image toSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, image.size.height*[UIScreen mainScreen].bounds.size.width/image.size.width)];
    
    // 计算图片显示的大小
    float height = image.size.width / [UIScreen mainScreen].bounds.size.width;
    
    UIGraphicsBeginImageContext(CGSizeMake([UIScreen mainScreen].bounds.size.width,image.size.height / height));
    [image drawInRect:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, image.size.height / height)];
    
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return scaledImage;
}




-(void)handlegesture:(UIGestureRecognizer*)guesturerecongnizer;//响应手势的函数；
{
    if ([guesturerecongnizer state] == UIGestureRecognizerStateBegan) {
        
        UIActionSheet *sheet  = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"保存图片", nil];
        sheet.tag = 10002;
        [sheet showInView:self.view];
        
    }
}



// 指定回调方法
- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo

{
    if(error != NULL){
        
        [SVProgressHUD showErrorWithStatus:@"保存图片失败"];
        
    }else{
        
        [SVProgressHUD showSuccessWithStatus:@"保存图片成功"];
    }
    
}

#pragma mark - UIScrollerDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    //    if (scrollView == self.m_imageScrollView) {
    //        CGFloat pageWidth = 320;
    //        int index = floor((self.m_imageScrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    //        self.m_index = index;
    //
    //    }
    
    
    [self updateImg];
    
    
    
}

//- (void)cancelShare {
//
//    [activityIndicatorView stopAnimating];
//
//    for(id tmpView in self.m_imageScrollView.subviews)
//    {
//        [tmpView removeFromSuperview];
//    }
//    [self.m_showView removeFromSuperview];
//
//}

//更多评论页面
- (void)MorepingluView:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    NSMutableDictionary *dic = [self.m_DynamicArray objectAtIndex:btn.tag];
    
    MorecommentViewController * VC = [[MorecommentViewController alloc]initWithNibName:@"MorecommentViewController" bundle:nil];
    
    VC.m_MoreDIC  = dic;
    
    [self.navigationController pushViewController:VC animated:YES];
    
}

#pragma mark - 保存图片至沙盒
- (void) saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.5);
    // 获取沙盒目录
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    // 将图片写入文件
    [imageData writeToFile:fullPath atomically:NO];
}


#pragma mark - image picker delegte
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
	[picker dismissViewControllerAnimated:YES completion:^{}];
    UIImage *image=[[UIImage alloc]init];
    if (pickerorphoto==0)
    {
        image = [info objectForKey:UIImagePickerControllerEditedImage];
        
    }else if (pickerorphoto==1)
    {
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    [self saveImage:image withName:@"currentImage.png"];
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"currentImage.png"];
    UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
    
    
    self.m_activityV.hidden = NO;
    
    [self.m_activityV startAnimating];
    
    
    UIImageView * Imageview = [[UIImageView alloc]init];
    Imageview.image = savedImage;
    
    // 保存图片到字典用于请求数据
    [self.m_imageDic setValue:[self getImageData:Imageview] forKey:@"frontCover"];
    
    
    // 请求数据
    [self modifyPictureRequest];
    
    //=======
    
}

- (NSData *)getImageData:(UIImageView *)imageView {
    UIImage *iamge = imageView.image;
    return UIImageJPEGRepresentation(iamge, 1);
}

//截取图片
- (UIImage *)imageFromImage:(UIImage *)image inRect:(CGRect)rect {
    CGImageRef sourceImageRef = [image CGImage];
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, rect);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    // [self.m_coverBtn setBackgroundImage:newImage forState:UIControlStateNormal];
    
    self.m_imageView.image = newImage;
    
    // 保存图片到字典用于请求数据
    [self.m_imageDic setValue:[self getImageData:self.m_imageView] forKey:@"frontCover"];
    
    // 请求数据
    [self modifyPictureRequest];
    
    return newImage;
}

//更换封面
-(void)ChangeTheCoverImage
{
    
    UIActionSheet *sheet  = [[UIActionSheet alloc] initWithTitle:@"更换封面" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"立即拍照",@"相册选取", nil];
    sheet.tag = 10001;
    [sheet showInView:[UIApplication sharedApplication].keyWindow];
    
}

-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 10001)
    {
        
        //打开照相
        if (buttonIndex==0)
        {
            self.isChooseFrontCover = YES;
            
            pickerorphoto = 1;
            if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
                UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
                imagePicker.delegate = self;
                imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                
                [self presentViewController:imagePicker animated:YES completion:^{
                    
                }];
            }
            else{
                
                self.isChooseFrontCover = NO;
                
                //如果没有提示用户
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"错误" message:@"手机没有摄像头" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alert show];
            }
        }
        
        //打开相册
        if (buttonIndex == 1) {
            
            self.isChooseFrontCover = YES;
            
            pickerorphoto = 0;
            
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];//打开照片文件
            imagePicker.delegate = self;
            imagePicker.allowsEditing = YES;
            
            [self presentViewController:imagePicker animated:YES completion:^{
                
            }];
            
        }
    }
    if (actionSheet.tag == 10002)
    {
        if (buttonIndex==0)
        {
            
            
            NSDictionary * BigimageDic = [self.m_BigimageArray objectAtIndex:self.m_index];
            
            NSString *path = [BigimageDic objectForKey:@"BigImgUrl"];
            
            UIImage *reSizeImage = [imagechage getImage:path];
            
            // 保存图片到相册
            UIImageWriteToSavedPhotosAlbum(reSizeImage, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
            
        }
        
    }
}

//动态列表
-(void)DynamicList
{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    AppHttpClient* httpClient = [AppHttpClient sharedSpace];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,     @"memberId",
                           key,   @"key",
                            [NSString stringWithFormat:@"%d",page],@"pageIndex",nil];
    
    NSLog(@"字典：：%@",param);
     if(self.m_DynamicArray.count == 0)
    {
        [SVProgressHUD showWithStatus:@"数据加载中"];
    }
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    [httpClient requestSpace:@"DynamicList.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            [SVProgressHUD dismiss];
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            
            NSMutableArray *metchantShop = [json valueForKey:@"DynamicList"];
            
            if (page == 1) {
                if (metchantShop == nil || metchantShop.count == 0) {
                    [self.m_DynamicArray removeAllObjects];
                    //                    self.m_tableView.hidden = YES;
                    [SVProgressHUD showErrorWithStatus:@"暂无动态"];
                    
                    self.m_emptyLabel.hidden = NO;
                    
                    [self.m_tableView reloadData];
                    
                    
                } else {
                    
                    self.m_DynamicArray = metchantShop;
                    
                    [self Savedatafromarray];

                    
                }
            } else {
                if (metchantShop == nil || metchantShop.count == 0) {
                    page--;
                } else {
                    
                    [self.m_DynamicArray addObjectsFromArray:metchantShop];
                    
                }
            }
            
            self.m_tableView.hidden = NO;
            
            self.m_emptyLabel.hidden = YES;
            
            
            [self.m_tableView reloadData];
            
            for (int i = 0; i < self.m_DynamicArray.count; i ++) {
                
                NSMutableDictionary *dic = [self.m_DynamicArray objectAtIndex:i];
                
                [self.m_zanDic setValue:[dic objectForKey:@"IsPraise"] forKey:[NSString stringWithFormat:@"%i",i]];
                
            }
            
            
            NSData *encod = [NSKeyedArchiver archivedDataWithRootObject:self.m_zanDic];
            
            [CommonUtil addValue:encod andKey:[NSString stringWithFormat:@"%@_zandic",[CommonUtil getValueByKey:MEMBER_ID]]];
            
            
        } else {
            if (page > 1) {
                page--;
            }
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
        
        self.m_tableView.pullLastRefreshDate = [NSDate date];
        self.m_tableView.pullTableIsRefreshing = NO;
        self.m_tableView.pullTableIsLoadingMore = NO;
        
    } failure:^(NSError *error) {
        if (page > 1) {
            page--;
        }
        //NSLog(@"failed:%@", error);
        //self.tableView.pullLastRefreshDate = [NSDate date];
        [SVProgressHUD showErrorWithStatus:@"请求失败，请稍后再试！"];

        self.m_tableView.pullTableIsRefreshing = NO;
        self.m_tableView.pullTableIsLoadingMore = NO;
    }];
    
}

#pragma mark - PullTableViewDelegate
- (void)pullTableViewDidTriggerRefresh:(PullTableView*)pullTableView {
    page = 1;
    [self DynamicList];
}

- (void)pullTableViewDidTriggerLoadMore:(PullTableView*)pullTableView {
    page ++;
    [self DynamicList];
}


//点击头像跳转空间
- (void)PhotoBtn:(id)sender{
    UIButton *btn = (UIButton *)sender;
    NSDictionary *dic = [self.m_DynamicArray objectAtIndex:btn.tag];
    //进入自己空间
    if ([[NSString stringWithFormat:@"%@",[dic objectForKey:@"MemberID"]] isEqualToString:[NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:MEMBER_ID]]]) {
        
        NSLog( @"id::%@",[NSString stringWithFormat:@"%@",[dic objectForKey:@"MemberID"]]);
        
        [self AboutMe];
    }else{
        
        NSLog( @"id::%@",[NSString stringWithFormat:@"%@",[dic objectForKey:@"MemberID"]]);
        
    // 进入某个人的空间动态列表
    FriDynamicViewController * VC = [[FriDynamicViewController alloc]initWithNibName:@"FriDynamicViewController" bundle:nil];
    [VC setTitle:[NSString stringWithFormat:@"%@",[dic objectForKey:@"NickName"]]];
    VC.m_memberId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"MemberID"]];
    [self.navigationController pushViewController:VC animated:YES];
    }
}



//赞的人
//点击头像
- (void)ZannameBtn:(NSString *)merID{
    // 进入某个人的空间动态列表
    FriDynamicViewController * VC = [[FriDynamicViewController alloc]initWithNibName:@"FriDynamicViewController" bundle:nil];
    VC.m_memberId = [NSString stringWithFormat:@"%@",[merID substringFromIndex:3]];
    [self.navigationController pushViewController:VC animated:YES];
    
}




#pragma mark - privates

- (NSAttributedString *)attributedString:(NSArray *__autoreleasing *)outURLs
                               URLRanges:(NSArray *__autoreleasing *)outURLRanges
                           nicknamearray:(NSMutableArray *)array
{
    
    NSString *HTMLText ;
    
    if (array.count == 1) {
        
        //        HTMLText = [NSString stringWithFormat:@"<a href='%@' title=''>%@</a>、觉得赞",[[array objectAtIndex:0] objectForKey:@"MemberID"],[[array objectAtIndex:0] objectForKey:@"NickName"]];
        HTMLText = [NSString stringWithFormat:@"<a href='' title=''>        </a> <a href='%@' title=''>%@</a>",[[array objectAtIndex:0] objectForKey:@"MemberID"],[[array objectAtIndex:0] objectForKey:@"NickName"]];
    }else{
        HTMLText = [NSString stringWithFormat:@"<a href='' title=''>        </a> <a href='%@' title=''>%@</a>",[[array objectAtIndex:0] objectForKey:@"MemberID"],[[array objectAtIndex:0] objectForKey:@"NickName"]];
        for (int iii=1; iii<array.count; iii++) {
            NSDictionary * dic = [array objectAtIndex:iii];
            HTMLText = [NSString stringWithFormat:@"%@,<a href='%@' title=''>%@</a>",HTMLText,[dic objectForKey:@"MemberID"],[dic objectForKey:@"NickName"]];
        }
        //        HTMLText = [NSString stringWithFormat:@"%@、都觉得赞",HTMLText];
        HTMLText = [NSString stringWithFormat:@"%@",HTMLText];
    }
    NSArray *URLs;
    NSArray *URLRanges;
    UIColor *color = [UIColor blackColor];
    UIFont *font = [UIFont fontWithName:@"Baskerville" size:13];
    NSMutableParagraphStyle *mps = [[NSMutableParagraphStyle alloc] init];
    mps.lineSpacing = ceilf(font.pointSize *0.5);
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor whiteColor];
    shadow.shadowOffset = CGSizeMake(0, 1);
    NSString *str = [NSString stringWithHTMLText:HTMLText baseURL:[NSURL URLWithString:@""] URLs:&URLs URLRanges:&URLRanges];
    NSMutableAttributedString *mas;
    if (isIOS5) {
        mas = [[NSMutableAttributedString alloc] initWithString:str attributes:@
               {
                   //                                              NSForegroundColorAttributeName : color,
                   //                                              NSFontAttributeName            : font,
                   //                                          NSParagraphStyleAttributeName  : mps,
                   //                                              NSShadowAttributeName          : shadow,
               }];
        [URLRanges enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
            [mas addAttributes:@
             {
                 //                 NSForegroundColorAttributeName : [UIColor colorWithRed:25.0f/255.0f green:185.0f/255.0f blue:245.0f/255.0f alpha:1.0],
                 
             } range:[obj rangeValue]];
        }];
        
    }else
    {
        mas= [[NSMutableAttributedString alloc] initWithString:str attributes:@
              {
                  NSForegroundColorAttributeName : color,
                  NSFontAttributeName            : font,
                  //                                          NSParagraphStyleAttributeName  : mps,
                  NSShadowAttributeName          : shadow,
              }];
        [URLRanges enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
            [mas addAttributes:@
             {
                 NSForegroundColorAttributeName : [UIColor colorWithRed:25.0f/255.0f green:185.0f/255.0f blue:245.0f/255.0f alpha:1.0],
                 
             } range:[obj rangeValue]];
        }];
    }
    *outURLs = URLs;
    *outURLRanges = URLRanges;
    return [mas copy];
    
}

- (void)Publishfalseover:(NSDictionary *)FOdic;//假动作【结束】
{
    flaseover = @"YES";//正在上传中
    [self.m_DynamicArray insertObject:FOdic atIndex:0];
//    [self.m_tableView reloadData];
    [self insertTableviewCell];
}

//插入列表
-(void)insertTableviewCell
{
    [self.m_tableView beginUpdates];
    NSMutableArray *insertion = [[NSMutableArray alloc] initWithCapacity:0];
    [insertion addObject:[NSIndexPath indexPathForRow:0 inSection:0]];
    [self.m_tableView insertRowsAtIndexPaths:insertion withRowAnimation:UITableViewRowAnimationNone];
    [self.m_tableView endUpdates];
    
}


-(void)Savedatafromarray
{
    [CommonUtil addValue:@"0" andKey:Spacedp];//不需要从数据库捞数据；
    //保存本地更新时间
    NSString *time = [NSString stringWithFormat:@"%f", (double)[[NSDate date] timeIntervalSince1970]];
    [CommonUtil addValue:time andKey:Spaceuploadtime];
    NSData *encodemenulist = [NSKeyedArchiver archivedDataWithRootObject:self.m_DynamicArray];
    [CommonUtil addValue:encodemenulist andKey:[NSString stringWithFormat:@"%@space",[CommonUtil getValueByKey:MEMBER_ID]]];
}


@end
