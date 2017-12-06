//
//  UserInformationViewController.m
//  HuiHui
//
//  Created by mac on 13-12-3.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import "UserInformationViewController.h"

#import "ContactCell.h"

#import "CommonUtil.h"

#import "SVProgressHUD.h"

#import "AppHttpClient.h"

#import "UIImageView+AFNetworking.h"

//#import "SendMessageViewController.h"

//#import "MessageObject.h"

//#import "MessageAndUserObject.h"

//#import "UserMessage.h"

//#import "XMPPManager.h"

#import "FriDynamicViewController.h"
#import "ChatViewController.h"

@interface UserInformationViewController ()


@property (weak, nonatomic) IBOutlet UIImageView *m_imageView;

@property (weak, nonatomic) IBOutlet UILabel *m_nameLabel;

@property (weak, nonatomic) IBOutlet UIImageView *m_sexImgV;

@property (weak, nonatomic) IBOutlet UILabel *m_levelLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_phoneLabel;

@property (weak, nonatomic) IBOutlet UITableView *m_tableView;

@property (strong, nonatomic) IBOutlet UIView *m_footerView;

@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;

@property (weak, nonatomic) IBOutlet UIButton *m_addbtn;

@property (strong, nonatomic) IBOutlet UIView *m_showView;

@property (weak, nonatomic) IBOutlet UIImageView *m_backImageV;

@property (weak, nonatomic) IBOutlet UIImageView *m_headImagV;

@property (weak, nonatomic) IBOutlet UIScrollView *m_imageScrollerView;

// 不是好友时添加好友的view
@property (weak, nonatomic) IBOutlet UIView *m_addFriendsView;

@property (weak, nonatomic) IBOutlet UIImageView *m_headerImgV;

@property (weak, nonatomic) IBOutlet UILabel *m_noNameLabel;

@property (weak, nonatomic) IBOutlet UIImageView *m_noSexImgV;

@property (weak, nonatomic) IBOutlet UIButton *m_noAddBtn;

@property (weak, nonatomic) IBOutlet UIButton *m_noCancelBtn;

@property (weak, nonatomic) IBOutlet UILabel *m_tipLabel;


// 取消关注的按钮
//- (IBAction)CancelAttention:(id)sender;

// 添加好友
//- (IBAction)addClicked:(id)sender;
// 打电话触发的事件
- (IBAction)callClicked:(id)sender;
// 发短信触发的事件
- (IBAction)sendSMSClicked:(id)sender;
// 聊天按钮触发的事件
- (IBAction)chatClicked:(id)sender;
// 显示头像大图
- (IBAction)showHeadClicked:(id)sender;

@end

@implementation UserInformationViewController

@synthesize m_items;

@synthesize isLeavePage;

@synthesize m_chatString;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        m_items = [[NSMutableDictionary alloc]initWithCapacity:0];
        
        self.isLeavePage = NO;
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setTitle:@"详细资料"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    // 从聊天的页面进入后，如果点击的是自己的头像则不用显示消息按钮所在的footerview
    if ( [self.m_chatString isEqualToString:@"1"] ) {
        
        if ( ![self.m_friendId isEqualToString:[CommonUtil getValueByKey:MEMBER_ID]] ) {
            
            // 设置tableView的footerView
            self.m_tableView.tableFooterView = self.m_footerView;
        }
    }else{
        
        // 设置tableView的footerView
        self.m_tableView.tableFooterView = self.m_footerView;
    }
    
    
//    // 1表示未关注-取消关注的按钮隐藏  2表示已关注 - 取消关注的按钮显示
//    if ( [self.m_typeString isEqualToString:@"1"] ) {
//        
//        // 设置导航栏的右按钮
//        UIButton *_button = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_button setFrame:CGRectMake(0, 0, 50, 29)];
//        _button.backgroundColor = [UIColor clearColor];
//        [_button.titleLabel setFont:[UIFont systemFontOfSize:12.0f]];
//        [_button setBackgroundImage:[UIImage imageNamed:@"xxqd.png"] forState:UIControlStateNormal];
//        
//        UIBarButtonItem *_barButton = [[UIBarButtonItem alloc] initWithCustomView:_button];
//        [self.navigationItem setRightBarButtonItem:_barButton];
//        
//        self.m_titleBtn = _button;
//        
//        
//        [self.m_titleBtn setTitle:@"添加好友" forState:UIControlStateNormal];
//        
//        [self.m_titleBtn removeTarget:self action:@selector(CancelAttention:) forControlEvents:UIControlEventTouchUpInside];
//        
//        [self.m_titleBtn addTarget:self action:@selector(showMessageAlertView) forControlEvents:UIControlEventTouchUpInside];
//        
//        
//    }else  if ( [self.m_typeString isEqualToString:@"2"] ) {
//        
//        // 设置导航栏的右按钮
//        UIButton *_button = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_button setFrame:CGRectMake(0, 0, 50, 29)];
//        _button.backgroundColor = [UIColor clearColor];
//        [_button.titleLabel setFont:[UIFont systemFontOfSize:12.0f]];
//        [_button setBackgroundImage:[UIImage imageNamed:@"xxqd.png"] forState:UIControlStateNormal];
//        
//        UIBarButtonItem *_barButton = [[UIBarButtonItem alloc] initWithCustomView:_button];
//        [self.navigationItem setRightBarButtonItem:_barButton];
//        
//        self.m_titleBtn = _button;
//        
//        
//        [self.m_titleBtn setTitle:@"取消关注" forState:UIControlStateNormal];
//        
//        [self.m_titleBtn removeTarget:self action:@selector(showMessageAlertView:) forControlEvents:UIControlEventTouchUpInside];
//        
//        [self.m_titleBtn addTarget:self action:@selector(CancelAttention:) forControlEvents:UIControlEventTouchUpInside];
//        
//        self.m_titleBtn.hidden = YES;
//        
//        self.navigationItem.rightBarButtonItem = nil;
//        
//    }else{
    
        // 设置导航栏的右按钮
        self.navigationItem.rightBarButtonItem = nil;
        
//    }
    
    
    //加载单击手势操作
    UITapGestureRecognizer *singleFingerOn=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleEvent:)];
    singleFingerOn.numberOfTouchesRequired = 1;
    singleFingerOn.numberOfTapsRequired = 1;
    singleFingerOn.delegate=self;
    [self.m_showView addGestureRecognizer:singleFingerOn];
    
    // 初始化
    self.m_imageScrollerView.maximumZoomScale = 1.5;
    self.m_imageScrollerView.minimumZoomScale = 1.0;
    self.m_imageScrollerView.showsVerticalScrollIndicator = NO;
    self.m_imageScrollerView.showsHorizontalScrollIndicator = NO;
    self.m_imageScrollerView.delegate = self;
    
    // 头像大图展示后设置背景透明
    self.m_backImageV.backgroundColor = [UIColor blackColor];
    self.m_backImageV.alpha = 0.8;

    
    self.m_addFriendsView.hidden = YES;
    self.m_tableView.hidden = YES;
    
    
    self.m_showView.frame = CGRectMake(self.m_showView.frame.origin.x, self.m_showView.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
    
    
    // 请求数据
    [self requestSubmit];
    
}



- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
     [self hideTabBar:YES];
   
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    if ( !self.isLeavePage ) {
        
        [self hideTabBar:NO];

    }
    [SVProgressHUD dismiss];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)leftClicked{
    
    [self goBack];
}

//单击手势
-(void)handleEvent:(UITapGestureRecognizer *)sender
{

    [self.m_showView removeFromSuperview];

}

- (IBAction)showHeadClicked:(id)sender {
    
    // 全屏添加showView
    UIWindow *window = self.navigationController.view.window;
    
    [window addSubview:self.m_showView];
    
    // 动画
    CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    popAnimation.duration = 0.4;
    popAnimation.values = self.m_values;
    popAnimation.keyTimes = self.m_keyTimes;
    popAnimation.timingFunctions = self.m_Funtions;
    
    [self.m_showView.layer addAnimation:popAnimation forKey:nil];

}

 //好友详细信息请求数据
- (void)requestSubmit{
    
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
                           [NSString stringWithFormat:@"%@",self.m_friendId],@"otherId",
                           nil];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"FriendsDetail.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            
            [SVProgressHUD dismiss];
            
            self.m_items = [json valueForKey:@"friendsInfo"];
            
            NSString *isFriends = [NSString stringWithFormat:@"%@",[self.m_items objectForKey:@"IsFrends"]];
            
            self.m_RName = [NSString stringWithFormat:@"%@",[self.m_items objectForKey:@"RealName"]];
            
            // IsFrends 0：不是好友；1：是好友
            if ( [isFriends isEqualToString:@"1"] ) {
                
                self.m_addFriendsView.hidden = YES;
                
                self.m_tableView.hidden = NO;
                
                // 设置坐标与性别图标的位置
                self.m_nameLabel.text = [NSString stringWithFormat:@"%@",[self.m_items objectForKey:@"NickName"]];
                
                // 判断男女性别
                if ( [[self.m_items objectForKey:@"Sex"] isEqualToString:@"Female"] ) {
                    
                    self.m_sexImgV.image = [UIImage imageNamed:@"gr_xingbie.png"];
                    
                }else if ( [[self.m_items objectForKey:@"Sex"] isEqualToString:@"Male"] ) {
                    
                    self.m_sexImgV.image = [UIImage imageNamed:@"gr_xingbie2.png"];
                    
                }else{
                    
                    self.m_sexImgV.image = [UIImage imageNamed:@""];
                }
                
                self.m_levelLabel.text = [NSString stringWithFormat:@"PR.%@",[self.m_items objectForKey:@"PR"]];
                self.m_phoneLabel.text = [NSString stringWithFormat:@"%@",[self.m_items objectForKey:@"PhoneNumber"]];
                
                // 赋值图片
                NSString *path = [self.m_items objectForKey:@"PhotoMidUrl"];
                
                [self.m_imageView setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:path]]
                                        placeholderImage:[UIImage imageNamed:@"moren.png"]
                                                 success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                                                     //                                                 self.m_imageView.image = [CommonUtil scaleImage:image toSize:CGSizeMake(60, 60)];
                                                     
                                                     
                                                     self.m_imageView.image = image;
                                                     
                                                     self.m_imageView.contentMode = UIViewContentModeScaleAspectFit;
                                                     
                                                 }
                                                 failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                                                     
                                                 }];
                
                NSString *bigPath = [self.m_items objectForKey:@"PhotoBigUrl"];
                
                [self.m_headImagV setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:bigPath]]
                                        placeholderImage:[UIImage imageNamed:@"moren.png"]
                                                 success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                                                     
                                                     self.m_headImagV.image = [CommonUtil scaleImage:image toSize:CGSizeMake(160, 160)];
                                                     
                                                     self.m_headImagV.contentMode = UIViewContentModeCenter;
                                                     
                                                 }
                                                 failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                                                     
                                                 }];
                
                
                
                CGSize size = [self.m_nameLabel.text sizeWithFont:[UIFont systemFontOfSize:16.0f] constrainedToSize:CGSizeMake(MAXFLOAT, 21) lineBreakMode:NSLineBreakByWordWrapping];
                
                self.m_nameLabel.frame = CGRectMake(self.m_nameLabel.frame.origin.x, self.m_nameLabel.frame.origin.y, size.width, 21);
                
                self.m_sexImgV.frame = CGRectMake(self.m_nameLabel.frame.origin.x + size.width + 10, self.m_sexImgV.frame.origin.y, self.m_sexImgV.frame.size.width, self.m_sexImgV.frame.size.height);
                
                // 刷新列表
                [self.m_tableView reloadData];

                
            }else{
                
                // 不是好友则显示让用户去添加其为好友的功能
                self.m_tableView.hidden = YES;
                
                self.m_addFriendsView.hidden = NO;
                
                
                // 设置坐标与性别图标的位置
                self.m_noNameLabel.text = [NSString stringWithFormat:@"%@",[self.m_items objectForKey:@"NickName"]];
                
                // 判断男女性别
                if ( [[self.m_items objectForKey:@"Sex"] isEqualToString:@"Female"] ) {
                    
                    self.m_noSexImgV.image = [UIImage imageNamed:@"gr_xingbie.png"];
                    
                }else if ( [[self.m_items objectForKey:@"Sex"] isEqualToString:@"Male"] ) {
                    
                    self.m_noSexImgV.image = [UIImage imageNamed:@"gr_xingbie2.png"];
                    
                }else{
                    
                    self.m_noSexImgV.image = [UIImage imageNamed:@""];
                }
                
                
                // 赋值图片
                NSString *path = [self.m_items objectForKey:@"PhotoMidUrl"];
                
                [self.m_headerImgV setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:path]]
                                        placeholderImage:[UIImage imageNamed:@"moren.png"]
                                                 success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                                                     //                                                 self.m_imageView.image = [CommonUtil scaleImage:image toSize:CGSizeMake(60, 60)];
                                                     
                                                     
                                                     self.m_headerImgV.image = image;
                                                     
                                                     self.m_headerImgV.contentMode = UIViewContentModeScaleAspectFit;
                                                     
                                                 }
                                                 failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                                                     
                                                 }];
                
//                
//                
//                
//                NSLog(@"IsFrends = %@",[self.m_items objectForKey:@"IsAttention"]);
//
//                
//               // IsAttention（1：已关注；0：未关注）
//                NSString *IsAttention = [NSString stringWithFormat:@"%@",[self.m_items objectForKey:@"IsAttention"]];
//                
//                if ( [IsAttention isEqualToString:@"1"] ) {
//                    // 已关注的
//                    self.m_tipLabel.text = @"您已经关注了对方，但是对方还没同意您的好友请求，同意后你们将成为好友关系";
//
//                    self.m_noAddBtn.hidden = YES;
//                    self.m_noCancelBtn.hidden = NO;
//                    
//                    self.m_noCancelBtn.hidden = YES;//不能取消
//
//
//                }else{
                
                UIButton *addButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 44)];
                [addButton setTitle:@"加好友" forState:UIControlStateNormal];
                [addButton.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
                [addButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
                [addButton addTarget:self action:@selector(showMessageAlertView) forControlEvents:UIControlEventTouchUpInside];
                UIBarButtonItem *_addFriendItem = [[UIBarButtonItem alloc] initWithCustomView:addButton];
                self.navigationItem.rightBarButtonItem = _addFriendItem;
                
                self.m_tipLabel.text = @"您和对方还不是好友关系,添加对方为好友吧！";
                    
                self.m_noAddBtn.hidden = NO;
                self.m_noCancelBtn.hidden = YES;
                
                
                
//                }
               
            }
            
        } else {
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
    } failure:^(NSError *error) {
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        [SVProgressHUD showErrorWithStatus:@"请求失败，稍后再试"];
    }];

}




#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
    return 7;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{


    static NSString *cellIdentifier = @"cellIdentifier";
    
    UserDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"ContactCell" owner:self options:nil];
        
        cell = (UserDetailsCell *)[nib objectAtIndex:1];
        
        if ( indexPath.row == 5 ) {
            
            cell.selectionStyle = UITableViewCellSelectionStyleGray;

        } else{
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

        }
    }
    
    // 赋值
    if ( indexPath.row == 0 ) {
        
        cell.m_titleLabel.text = @"地区";
        
        cell.m_subLabel.text = [NSString stringWithFormat:@"%@",[self.m_items objectForKey:@"LiveAddress"]];
        
        cell.m_subLabel.textColor = [UIColor blackColor];
        
    }else if ( indexPath.row == 1 ){
        
        cell.m_titleLabel.text = @"邮箱";
        
        cell.m_subLabel.text = [NSString stringWithFormat:@"%@",[self.m_items objectForKey:@"Email"]];
        
        cell.m_subLabel.textColor = [UIColor blackColor];
        
    }else if ( indexPath.row == 2 ){
        
        cell.m_titleLabel.text = @"生日";
        
        cell.m_subLabel.text = [NSString stringWithFormat:@"%@",[self.m_items objectForKey:@"Birthday"]];
        
        cell.m_subLabel.textColor = [UIColor blackColor];

    }else if ( indexPath.row == 3 ){
        
        cell.m_titleLabel.text = @"粉丝";
        
        cell.m_subLabel.text = [NSString stringWithFormat:@"%@",[self.m_items objectForKey:@"Fans"]];
    
        cell.m_subLabel.textColor = [UIColor colorWithRed:66/255.0 green:171/255.0 blue:230/255.0 alpha:1.0];
    
    }else if ( indexPath.row == 4 ){
        cell.m_titleLabel.text = @"关注";
        
        cell.m_subLabel.text = [NSString stringWithFormat:@"%@",[self.m_items objectForKey:@"Attention"]];
        
        cell.m_subLabel.textColor = [UIColor colorWithRed:66/255.0 green:171/255.0 blue:230/255.0 alpha:1.0];

    }else if ( indexPath.row == 5 ){
        
        cell.m_titleLabel.text = @"备注";
        
        cell.m_subLabel.text = [NSString stringWithFormat:@"%@",[self.m_items objectForKey:@"RemarkName"]];
        
        cell.m_subLabel.textAlignment = NSTextAlignmentRight;
        
        cell.m_rightImgv.hidden = NO;
        
    }else if ( indexPath.row == 6 ){
        
        cell.m_titleLabel.text = @"看其空间";
        
        cell.m_subLabel.text = @"";
        
        cell.m_rightImgv.hidden = NO;
        
    }
    
    return cell;
    
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 5) {
        ModifyNoteViewController * VC = [[ModifyNoteViewController alloc]initWithNibName:@"ModifyNoteViewController" bundle:nil];
        VC.delegate = self;
        VC.toMemberId =[NSString stringWithFormat:@"%@",[self.m_items objectForKey:@"MemberId"]];
        VC.oldNotetext =[NSString stringWithFormat:@"%@",[self.m_items objectForKey:@"RemarkName"]];
        [self.navigationController pushViewController:VC animated:YES];

    }
    else if ( indexPath.row == 6 ) {
        
        // 进入某个人的空间动态列表
        FriDynamicViewController * VC = [[FriDynamicViewController alloc]initWithNibName:@"FriDynamicViewController" bundle:nil];
        [VC setTitle:[NSString stringWithFormat:@"%@",[self.m_items objectForKey:@"NickName"]]];
        VC.m_memberId = [NSString stringWithFormat:@"%@",[self.m_items objectForKey:@"MemberId"]];
        VC.m_Isback = @"YES";
        
        [self.navigationController pushViewController:VC animated:YES];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


//- (IBAction)CancelAttention:(id)sender {
//
//    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示"
//                                                       message:@"确定取消对其的关注？"
//                                                      delegate:self
//                                             cancelButtonTitle:@"取消"
//                                             otherButtonTitles:@"确定", nil];
//    
//    alertView.tag = 1000;
//    
//    [alertView show];
//}

//- (IBAction)addClicked:(id)sender {
//    
//    // 判断网络是否存在
//    if ( ![self isConnectionAvailable] ) {
//        
//        return;
//    }
//    
//    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
//    NSString *key = [CommonUtil getServerKey];
//    AppHttpClient* httpClient = [AppHttpClient sharedClient];
//    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
//                           memberId,     @"memberId",
//                           key,   @"key",
//                           [NSString stringWithFormat:@"%@",[self.m_items objectForKey:@"MemberId"]],@"otherId",
//                           nil];
//    [SVProgressHUD showWithStatus:@"数据加载中"];
//    [httpClient request:@"AttentionAdd.ashx" parameters:param success:^(NSJSONSerialization* json) {
//        BOOL success = [[json valueForKey:@"status"] boolValue];
//        if (success) {
//            
//            NSString *msg = [json valueForKey:@"msg"];
//            
//            [SVProgressHUD showSuccessWithStatus:msg];
//            
//            // 关注成功后请求数据刷新下列表
//            [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(requestSubmit) userInfo:nil repeats:NO];
//            // 关注成功后的处理
////            self.m_addbtn.hidden = YES;
////            self.cancelBtn.hidden = NO;
//            
//            [self.m_titleBtn setTitle:@"取消关注" forState:UIControlStateNormal];
//            
//            [self.m_titleBtn removeTarget:self action:@selector(addClicked:) forControlEvents:UIControlEventTouchUpInside];
//            
//            [self.m_titleBtn addTarget:self action:@selector(CancelAttention:) forControlEvents:UIControlEventTouchUpInside];
//            
//            
//        } else {
//            NSString *msg = [json valueForKey:@"msg"];
//            [SVProgressHUD showErrorWithStatus:msg];
//        }
//    } failure:^(NSError *error) {
//        //NSLog(@"failed:%@", error);
//        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
//    }];
//    
//}

- (IBAction)callClicked:(id)sender {
  
    NSString *phone = [NSString stringWithFormat:@"%@",[self.m_items objectForKey:@"PhoneNumber"]];
    
    // 判断设备是否支持
    if([[[UIDevice currentDevice] model] rangeOfString:@"iPhone Simulator"].location != NSNotFound) {
        
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示"
//                                                        message:@"该设备暂不支持电话功能"
//                                                       delegate:self
//                                              cancelButtonTitle:@"确定"
//                                              otherButtonTitles: nil];
//        [alert show];
        
        [SVProgressHUD showErrorWithStatus:@"该设备暂不支持电话功能"];
        
    }else{
        
        self.m_webView = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
        [self.m_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", phone]]]];
        
    }

}

- (IBAction)sendSMSClicked:(id)sender {
    
    if ([MFMessageComposeViewController canSendText]) {
        
        self.isLeavePage = YES;

        MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc] init];
        picker.messageComposeDelegate = self;
        picker.body = @"";
        picker.recipients = [NSArray arrayWithObject:[NSString stringWithFormat:@"%@",[self.m_items objectForKey:@"PhoneNumber"]]];

        [self presentViewController:picker animated:YES completion:nil];
        
    } else {
        
        self.isLeavePage = NO;

        [SVProgressHUD showErrorWithStatus:@"该设备不支持短信功能"];
    }

}

- (IBAction)chatClicked:(id)sender {
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 6.0) {
        UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"警告" message:@"由于您的手机操作系统版本太低，城与城 部分功能不能使用，若想完美使用城与城，请在设置中更新您手机的操作系统。" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [view show];
    return;
    }
    
    UIButton *btn = (UIButton *)sender;
    
    if ([self.m_BackorPop isEqualToString:@"POP"]) {

        if ( self.tabBarController.selectedIndex != 0 ) {
                [self.tabBarController setSelectedIndex:0];
            }
        
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:0] animated:NO];

        NSString * username = [NSString stringWithFormat:@"%@",[self.m_items objectForKey:@"MemberId"]];

        NSMutableDictionary *DIC = [[NSMutableDictionary alloc]init];
        if (btn.tag ==98) {
             [DIC setObject:[NSString stringWithFormat:@"%@",[self.m_items objectForKey:@"NickName"]] forKey:@"RName"];
        }else
        {
            [DIC setObject:self.m_RName forKey:@"RName"];
        }
        [DIC setObject:self.m_headerImgV.image forKey:@"m_headImagV"];
        [DIC setObject:username forKey:@"username"];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"GroupselectedO"object:DIC];

 
        
    }
    else if ( [self.m_chatString isEqualToString:@"1"] ) {
        
        // 从聊天的页面过来，点击消息的时候返回上一级的聊天页面
        [self.navigationController popViewControllerAnimated:YES];
        
    }else{
        
        NSString * username = [NSString stringWithFormat:@"%@",[self.m_items objectForKey:@"MemberId"]];
        
        ChatViewController *chatVC = [[ChatViewController alloc] initWithChatter:username isGroup:NO];
        chatVC.title = self.m_RName;
        chatVC.Uimage = self.m_headImagV.image;
        [self.navigationController pushViewController:chatVC animated:YES];
    }
  
}


-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    
    self.isLeavePage = NO;
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    switch (result) {
        case MessageComposeResultCancelled:
            break;
        case MessageComposeResultFailed:
            [SVProgressHUD showErrorWithStatus:@"发送失败"];
            break;
        case MessageComposeResultSent:
            [SVProgressHUD showSuccessWithStatus:@"发送成功"];
            break;
        default:
            break;
    }
}

// 取消关注请求数据
//- (void)requestCancelFriends{
//   
//    // 判断网络是否存在
//    if ( ![self isConnectionAvailable] ) {
//        
//        return;
//    }
//    
//    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
//    NSString *key = [CommonUtil getServerKey];
//    AppHttpClient* httpClient = [AppHttpClient sharedClient];
//    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
//                           memberId,     @"memberId",
//                           key,   @"key",
//                           [NSString stringWithFormat:@"%@",[self.m_items objectForKey:@"MemberId"]],@"otherId",
//                           nil];
//    [SVProgressHUD showWithStatus:@"数据加载中"];
//    [httpClient request:@"CancelAttention.ashx" parameters:param success:^(NSJSONSerialization* json) {
//        BOOL success = [[json valueForKey:@"status"] boolValue];
//        if (success) {
//            
//            NSString *msg = [json valueForKey:@"msg"];
//            
//            [SVProgressHUD showSuccessWithStatus:msg];
//            
//            // 关注成功后请求数据刷新下列表
//            [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(requestSubmit) userInfo:nil repeats:NO];
//            // 关注成功后的处理
////            self.cancelBtn.hidden = YES;
////            self.m_addbtn.hidden = NO;
//            
//            [self.m_titleBtn setTitle:@"关注" forState:UIControlStateNormal];
//            
//            [self.m_titleBtn removeTarget:self action:@selector(CancelAttention:) forControlEvents:UIControlEventTouchUpInside];
//            
//            [self.m_titleBtn addTarget:self action:@selector(addClicked:) forControlEvents:UIControlEventTouchUpInside];
//            
//        } else {
//            NSString *msg = [json valueForKey:@"msg"];
//            [SVProgressHUD showErrorWithStatus:msg];
//        }
//    } failure:^(NSError *error) {
//        //NSLog(@"failed:%@", error);
//        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
//    }];
//    
//}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if ( alertView.tag == 1000 ) {
        
        if ( buttonIndex == 1 ) {
            
            // 确定取消关注请求数据
            [self requestCancelFriends];
      
        }else{
            
            
        }
    }else if (alertView.tag ==99)
    {
        if ([alertView cancelButtonIndex] != buttonIndex) {
            UITextField *messageTextField = [alertView textFieldAtIndex:0];
            NSString *messageStr = @"";
            if (messageTextField.text.length > 0) {
                messageStr = [NSString stringWithFormat:@"%@", messageTextField.text];
            }
            else{
                messageStr = [NSString stringWithFormat:@"邀请你为好友"];
            }
            [self sendFriendApplyAtIndexPath:messageStr];
            
        }
    }
}

#pragma mark === UIScrollView Delegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    
    return self.m_headImagV;
    
}

- (void)showMessageAlertView{
    [self hiddenNumPadDone:nil];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"输入请求消息" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
    alert.tag = 99;
    [alert show];
}


- (void)sendFriendApplyAtIndexPath:(NSString *)message
{
    NSString *buddyName =[NSString stringWithFormat:@"%@",[self.m_items objectForKey:@"MemberId"]];
    if (buddyName && buddyName.length > 0) {
        [self showHudInView:self.view hint:@"正在发送申请..."];
        EMError *error;
        [[EaseMob sharedInstance].chatManager addBuddy:buddyName message:message error:&error];
        [self hideHud];
        if (error) {
            [self showHint:@"发送申请失败，请重新操作"];
        }
        else{
            [self showHint:@"发送申请成功"];
            
        }
    }
}

- (void)GetSaveRemarkName:(NSString *)RemarkName;
{
    [self.m_items setObject:RemarkName forKey:@"RemarkName"];
    
    [self.m_tableView reloadData];

}
@end
