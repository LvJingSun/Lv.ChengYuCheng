//
//  RootViewController.m
//  HuiHui
//
//  Created by mac on 13-11-19.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import "RootViewController.h"

#import "StatusUtility.h"

//#import "MeetViewController.h"
#import "ChatListViewController.h"

#import "FreshViewController.h"

#import "MoreViewController.h"
#import "R_PersonViewController.h"

#import "CommonUtil.h"

//#import "FriendsCircleViewController.h"
#import "ContactsViewController.h"

#import "HomeViewController.h"

#import "ApplyViewController.h"
#import "IDInfoCache.h"

#import "MLNavigationController.h"
#import "Reachability.h"

#import "MyCardViewController.h"
#import "MyCarddetailViewController.h"
#import "XWAlterview.h"


//两次提示的默认间隔
static const CGFloat kDefaultPlaySoundInterval = 3.0;

@interface RootViewController ()<IChatManagerDelegate>
{
    ChatListViewController *_chatListVC;
    ContactsViewController *_contactsVC;
    
    //交易记录ID
    NSString    *alertallowpay;
    //收银员ID
    NSString *cashierID;
    //描述
    NSString *desc;
    //新增订单ID
    NSString *add_ID;
    //订单类型
    NSString *type;
    
    // 记录云菜单的值
    NSString    *m_cloundMenuId;

}
@property (strong, nonatomic)NSDate *lastPlaySoundDate;

@property (strong, nonatomic) IDInfoCache *InfoCache;

@end

@implementation RootViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.InfoCache  = [[IDInfoCache alloc]init];
    }
    return self;
}


- (void)setupSubviews
{
    [_chatListVC networkChanged:_connectionState];

    [CommonUtil addValue:@"1" andKey:Spacedp];//
 
    UITabBarItem *itemOne = [[UITabBarItem alloc]initWithTitle:@"消息" image:nil tag:100];
    
    UIImage *img1 = [self getImage:@"b_message_j.png"];
    
    [itemOne setFinishedSelectedImage:img1 withFinishedUnselectedImage:img1];
    _chatListVC = [[ChatListViewController alloc]init];
    MLNavigationController *controller1 = [[MLNavigationController alloc]init];
    [controller1 setViewControllers:[NSArray arrayWithObjects:_chatListVC, nil]];
    [controller1 setTabBarItem:itemOne];
    
    
    UITabBarItem *itemOneOne = [[UITabBarItem alloc]initWithTitle:@"圈子" image:nil tag:101];
    
    UIImage *img2 = [self getImage:@"b_quanzi_j.png"];

    
    [itemOneOne setFinishedSelectedImage:img2 withFinishedUnselectedImage:img2];
    _contactsVC = [[ContactsViewController alloc]init];
    MLNavigationController *controller11 = [[MLNavigationController alloc]init];
    [controller11 setViewControllers:[NSArray arrayWithObjects:_contactsVC, nil]];
    [controller11 setTabBarItem:itemOneOne];
    
    
    UITabBarItem *itemTwo = [[UITabBarItem alloc]initWithTitle:@"本地" image:nil tag:102];
    
    
    UIImage *img3 = [self getImage:@"b_native_j.png"];
    
    [itemTwo setFinishedSelectedImage:img3 withFinishedUnselectedImage:img3];
    
    HomeViewController *location = [[HomeViewController alloc]initWithNibName:@"HomeViewController" bundle:nil];
    MLNavigationController *controller2 = [[MLNavigationController alloc]init];
    [controller2 setViewControllers:[NSArray arrayWithObjects:location, nil]];
    [controller2 setTabBarItem:itemTwo];
    
    UITabBarItem *itemFour = [[UITabBarItem alloc]initWithTitle:@"我的" image:nil tag:104];
  
    UIImage *img5 = [self getImage:@"b_me_j.png"];
    
    [itemFour setFinishedSelectedImage:img5 withFinishedUnselectedImage:img5];
    
    MoreViewController *moreTest = [[MoreViewController alloc]initWithNibName:@"MoreViewController" bundle:nil];
    R_PersonViewController *moreNew = [[R_PersonViewController alloc] init];
    MLNavigationController *controller4 = [[MLNavigationController alloc]init];
    
    if ([[CommonUtil getValueByKey:MEMBER_ID] isEqualToString:@"19404"]) {
        
        [controller4 setViewControllers:[NSArray arrayWithObjects:moreTest, nil]];
        
    }else {
        
        [controller4 setViewControllers:[NSArray arrayWithObjects:moreNew, nil]];
        
    }
    
    
    [controller4 setTabBarItem:itemFour];
    
    // 设置tabBar上面的红点
    //[itemFour setBadgeValue:@""];

    NSString *string = [NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:@"BudgeNumberKey"]];
    
    // 由登录那边判断是否要显示tabBar上面的红点值
    if ( [string isEqualToString:@"1"] ) {
        [itemFour setBadgeValue:@""];
    }
    
    [self setViewControllers:[NSArray arrayWithObjects:controller1,controller11,controller2,controller4, nil]];
    
    // 设置tabBar的选中背景和未选中的背景
//    self.tabBar.backgroundImage = [UIImage imageNamed:@"menu_default.png"];

    self.tabBar.selectionIndicatorImage = [UIImage imageNamed:@"b22.png"];
    
    self.delegate = self;
    
    if ( isIOS7 ) {
        [self.tabBar setTranslucent:NO];
    }
    // 默认选中本地
    [self setSelectedIndex:2];
    
    // 设置tabBar上面选中的字体的颜色
    NSArray *items = self.tabBar.items;
    for (UITabBarItem *item in items) {
        [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor, nil] forState:UIControlStateNormal];
        [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor, nil] forState:UIControlStateSelected];
    }
    
    [_contactsVC reloadDataSource:nil];
    [_chatListVC refreshDataSource];


}

- (UIImage *)getImage:(NSString *)aimagName{
    
    UIImage* selectedImage = [UIImage imageNamed:aimagName];
   
    // 判断在8以上的版本不添加渲染使用原图
    if ( isIOS8 ) {
        
        //声明这张图片用原图(别渲染)
        selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    }
    
    
    return selectedImage;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 解决tabBar上面一条阴影的问题
    [self.tabBar setClipsToBounds:YES];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6){
        [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
        
    }

    //环信
    //获取未读消息数，此时并没有把self注册为SDK的delegate，读取出的未读数是上次退出程序时的
    [self didUnreadMessagesCountChanged];
//#warning 把self注册为SDK的delegate
    [self registerNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setupUntreatedApplyCount) name:@"setupUntreatedApplyCount" object:nil];
    
    [self setupSubviews];
    
    [self setupUnreadMessageCount];
    
    [self setupUntreatedApplyCount];

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
- (void)dealloc
{
    [self unregisterNotifications];
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{

 
}


#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 99) {
        if (buttonIndex != [alertView cancelButtonIndex]) {
      
            [[EaseMob sharedInstance].chatManager asyncLogoffWithUnbindDeviceToken:YES completion:^(NSDictionary *info, EMError *error) {
                [[ApplyViewController shareController] clear];
                
                // 退出的时候删除加在状态栏位置的label
                if ( isIOS7 ) {
                    
                    // 移除导航栏上面的view
                    for (UILabel *label in self.navigationController.view.subviews) {
                        
                        if ( label.tag == 10392 ) {
                            
                            [label removeFromSuperview];
                            
                        }
                    }
                    
                }
                
                [self.navigationController popToRootViewControllerAnimated:YES];
                
                // 设置状态栏的字体颜色
                [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

            } onQueue:nil];
        }
    }
    else if (alertView.tag == 100) {
        if (buttonIndex == [alertView cancelButtonIndex]) {
            
            // 退出的时候删除加在状态栏位置的label
            if ( isIOS7 ) {
                
                // 移除导航栏上面的view
                for (UILabel *label in self.navigationController.view.subviews) {
                    
                    if ( label.tag == 10392 ) {
                        
                        [label removeFromSuperview];
                        
                    }
                }
                
            }
            
            [self.navigationController popToRootViewControllerAnimated:YES];
            
            // 设置状态栏的字体颜色
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

        }else
        {
            [self loginWithUsername:[NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:MEMBER_ID]] password:@"888888"];
        }

    } else if (alertView.tag == 101) {
        
        // 退出的时候删除加在状态栏位置的label
        if ( isIOS7 ) {
            
            // 移除导航栏上面的view
            for (UILabel *label in self.navigationController.view.subviews) {
                
                if ( label.tag == 10392 ) {
                    
                    [label removeFromSuperview];
                    
                }
            }
            
        }
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        
        // 设置状态栏的字体颜色
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

    }
    else if (alertView.tag ==1999){
        
        if (buttonIndex != [alertView cancelButtonIndex]) {
            
            if (alertallowpay.length!=0) {
                [self alertallowpay:[NSString stringWithFormat:@"%@",alertallowpay]];
            }else
            {
                [SVProgressHUD showErrorWithStatus:@"订单已失效，支付失败"];
            }

        }else{
            alertallowpay = @"";
        }
    }else if (alertView.tag ==1008){
        
        //积分消费
        
        if (buttonIndex != [alertView cancelButtonIndex]) {
            
            if (alertallowpay.length!=0) {
                [self alertallowpay:[NSString stringWithFormat:@"%@",alertallowpay]];
            }else
            {
                [SVProgressHUD showErrorWithStatus:@"订单已失效，支付失败"];
            }
            
        }else{
            alertallowpay = @"";
        }
    }else if (alertView.tag ==1009){
        
        //红包消费
        
        if (buttonIndex != [alertView cancelButtonIndex]) {
            
            if (alertallowpay.length!=0) {
                [self alertallowpay:[NSString stringWithFormat:@"%@",alertallowpay]];
            }else
            {
                [SVProgressHUD showErrorWithStatus:@"订单已失效，支付失败"];
            }
            
        }else{
            alertallowpay = @"";
        }
    }else if (alertView.tag ==2000){
        //会员卡充值
    
        if ([[CommonUtil getValueByKey:MycardViewcurrentBool] isEqualToString:@"YES"]) {

            [[NSNotificationCenter defaultCenter] postNotificationName:MycardViewcurrentBool object:nil];
        }else if ([[CommonUtil getValueByKey:MycardViewdetailcurrentBool] isEqualToString:@"YES"]){

            [[NSNotificationCenter defaultCenter] postNotificationName:MycardViewdetailcurrentBool object:nil];
        }
    }else if (alertView.tag ==2001){
        
        // 云菜单收银确认
        
        if (buttonIndex != [alertView cancelButtonIndex]) {
            
            if (alertallowpay.length != 0) {

                // 请求数据
                [self cloundMenuSureRequest];
                
                
            }else
            {
                [SVProgressHUD showErrorWithStatus:@"订单已失效，确认失败"];
            }
            
        }else{
            alertallowpay = @"";
        }
    }
    
}

- (void)cloundMenuSureRequest{
    
    alertallowpay = @"";
    
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
                           m_cloundMenuId,@"orders",
                           nil];
    
    [httpClient request:@"ConfirmUseOrder.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        NSString *msg = [json valueForKey:@"msg"];
        if (success) {
            
            m_cloundMenuId = @"";

            [SVProgressHUD showSuccessWithStatus:msg];
            
        } else {
            
            [SVProgressHUD showErrorWithStatus:msg];
        }
    } failure:^(NSError *error) {

        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];

    
    
}


#pragma mark - public
- (void)jumpToChatList
{
    if(_chatListVC)
    {
        [self.navigationController popToViewController:self animated:NO];
        [self setSelectedViewController:_chatListVC];
    }
}

- (void)setupUntreatedApplyCount
{
    NSInteger unreadCount = [[[ApplyViewController shareController] dataSource] count];
        
    if (_contactsVC) {
        if (unreadCount > 0) {
            _contactsVC.navigationController.tabBarItem.badgeValue = [NSString stringWithFormat:@"%ld",(long)unreadCount];
        }else{
            _contactsVC.navigationController.tabBarItem.badgeValue = nil;
        }
    }
    
}

#pragma mark - private

-(void)registerNotifications
{
    [self unregisterNotifications];
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
}

-(void)unregisterNotifications
{
    [[EaseMob sharedInstance].chatManager removeDelegate:self];
}



// 统计未读消息数
-(void)setupUnreadMessageCount
{
    NSArray *conversations = [[[EaseMob sharedInstance] chatManager] conversations];
    NSInteger unreadCount = 0;
    for (EMConversation *conversation in conversations) {
        unreadCount += conversation.unreadMessagesCount;
    }
    if (_chatListVC) {
        if (unreadCount > 0) {
            _chatListVC.navigationController.tabBarItem.badgeValue = [NSString stringWithFormat:@"%ld",(long)unreadCount];
        }else{
            _chatListVC.navigationController.tabBarItem.badgeValue = nil;
        }
    }
    
    UIApplication *application = [UIApplication sharedApplication];
    [application setApplicationIconBadgeNumber:unreadCount];
}


#pragma mark - IChatManagerDelegate 消息变化

- (void)didUpdateConversationList:(NSArray *)conversationList
{
    [_chatListVC refreshDataSource];
}

// 未读消息数量变化回调
-(void)didUnreadMessagesCountChanged
{
    [self setupUnreadMessageCount];
}

- (void)didFinishedReceiveOfflineMessages:(NSArray *)offlineMessages{
    [self setupUnreadMessageCount];
}

- (BOOL)needShowNotification:(NSString *)fromChatter
{
    BOOL ret = YES;
    NSArray *igGroupIds = [[EaseMob sharedInstance].chatManager ignoredGroupIds];
    for (NSString *str in igGroupIds) {
        if ([str isEqualToString:fromChatter]) {
            ret = NO;
            break;
        }
    }
    
    if (ret) {
        EMPushNotificationOptions *options = [[EaseMob sharedInstance].chatManager pushNotificationOptions];
        
        do {
            if (options.noDisturbStatus) {
                NSDate *now = [NSDate date];
                NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitHour | NSCalendarUnitMinute
                                                                               fromDate:now];
                
                NSInteger hour = [components hour];
                //        NSInteger minute= [components minute];
                
                NSUInteger startH = options.noDisturbingStartH;
                NSUInteger endH = options.noDisturbingEndH;
                if (startH>endH) {
                    endH += 24;
                }
                
                if (hour>=startH && hour<=endH) {
                    ret = NO;
                    break;
                }
            }
        } while (0);
    }
    
    return ret;
}

// 收到消息回调
-(void)didReceiveMessage:(EMMessage *)message
{
    BOOL needShowNotification = message.isGroup ? [self needShowNotification:message.conversationChatter] : YES;
    if (needShowNotification) {
#if !TARGET_IPHONE_SIMULATOR
        [self playSoundAndVibration];
        
        BOOL isAppActivity = [[UIApplication sharedApplication] applicationState] == UIApplicationStateActive;
        if (!isAppActivity) {
            [self showNotificationWithMessage:message];
        }
#endif
    }
}

-(void)didReceiveCmdMessage:(EMMessage *)cmdMessage{
    EMCommandMessageBody *body = (EMCommandMessageBody *)cmdMessage.messageBodies.lastObject;
    NSArray *messagearray = [body.action componentsSeparatedByString:@","];
    
    NSLog(@"==%@==",messagearray);

    alertallowpay = [NSString stringWithFormat:@"%@",[messagearray objectAtIndex:4]];
    
    cashierID = [NSString stringWithFormat:@"%@",[messagearray objectAtIndex:5]];
    
    desc = [NSString stringWithFormat:@"%@",[messagearray objectAtIndex:6]];
    
    add_ID = [NSString stringWithFormat:@"%@",[messagearray objectAtIndex:7]];

    NSString *alerttitle = @"会员卡提醒";
    NSString *hintText = @"";
    if ([[NSString stringWithFormat:@"%@",[messagearray lastObject]] isEqualToString:@"card-1"]) {
        
        alerttitle = @"会员卡充值提醒";
        hintText= [NSString stringWithFormat:@"\n您在%@\n(%@)\n充值%@元\n",[messagearray objectAtIndex:1],[messagearray objectAtIndex:2],[messagearray objectAtIndex:3]];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:alerttitle
                                                            message:hintText
                                                           delegate:self
                                                  cancelButtonTitle:@"确认"
                                                  otherButtonTitles:nil];
        alertView.tag = 2000;
        [alertView show];

    }else if ([[NSString stringWithFormat:@"%@",[messagearray lastObject]] isEqualToString:@"card-2"]){
        
        type = @"1";
        
        alerttitle = @"会员卡消费提醒";
        hintText= [NSString stringWithFormat:@"\n您在%@\n(%@)\n共消费%@元\n",[messagearray objectAtIndex:1],[messagearray objectAtIndex:2],[messagearray objectAtIndex:3]];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:alerttitle
                                                            message:hintText
                                                           delegate:self
                                                  cancelButtonTitle:@"取消"
                                                  otherButtonTitles:@"支付",
                                                            nil];
        alertView.tag = 1999;
        [alertView show];

    }else if ([[NSString stringWithFormat:@"%@",[messagearray lastObject]] isEqualToString:@"card-3"]){
        
        alerttitle = @"云菜单消费提醒";
        
        m_cloundMenuId = [NSString stringWithFormat:@"%@",[messagearray objectAtIndex:2]];
        
        NSString *string = [messagearray objectAtIndex:3];
        
        NSArray *arr;
        
        NSString *l_string = @"";
        
        if ( string.length != 0 ) {
            
            arr = [string componentsSeparatedByString:@"|"];
            
            if ( arr.count != 0 ) {
                
                for (int i = 0; i < arr.count; i++) {
                    
                    l_string = [l_string stringByAppendingString:[NSString stringWithFormat:@"%@\n",[arr objectAtIndex:i]]];
                    
                }
                
            }
            
        }
        
        hintText= [NSString stringWithFormat:@"\n您在%@\n消费了\n%@",[messagearray objectAtIndex:1],l_string];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:alerttitle
                                                            message:hintText
                                                           delegate:self
                                                  cancelButtonTitle:@"取消"
                                                  otherButtonTitles:@"确定",
                                  nil];
        alertView.tag = 2001;
        [alertView show];

        
    }else if ([[NSString stringWithFormat:@"%@",[messagearray lastObject]] isEqualToString:@"card-5"]){
        
        // 对与商户收到透传后进行的处理
        [self setMactTakeAwayMessage:messagearray withFromId:[NSString stringWithFormat:@"%@",cmdMessage.from] toId:[NSString stringWithFormat:@"%@",cmdMessage.to]];

    }else if ([[NSString stringWithFormat:@"%@",[messagearray lastObject]] isEqualToString:@"card-6"]){
        
        // 对于用户
        // 对与用户收到透传后进行的处理
        [self setAccountMessage:messagearray];
        
    }else if ([[NSString stringWithFormat:@"%@",[messagearray lastObject]] isEqualToString:@"card-7"]){
        
        type = @"2";
        
        // 积分
        alerttitle = @"会员卡积分消费提醒";
        hintText= [NSString stringWithFormat:@"\n您在%@\n(%@)\n共消费%@积分\n",[messagearray objectAtIndex:1],[messagearray objectAtIndex:2],[messagearray objectAtIndex:3]];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:alerttitle
                                                            message:hintText
                                                           delegate:self
                                                  cancelButtonTitle:@"取消"
                                                  otherButtonTitles:@"确认",
                                  nil];
        alertView.tag = 1008;
        [alertView show];
        
    }else if ([[NSString stringWithFormat:@"%@",[messagearray lastObject]] isEqualToString:@"card-8"]){
        
        type = @"3";
        
        // 红包
        alerttitle = @"会员卡红包消费提醒";
        hintText= [NSString stringWithFormat:@"\n您在%@\n(%@)\n共消费%@元红包\n",[messagearray objectAtIndex:1],[messagearray objectAtIndex:2],[messagearray objectAtIndex:3]];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:alerttitle
                                                            message:hintText
                                                           delegate:self
                                                  cancelButtonTitle:@"取消"
                                                  otherButtonTitles:@"支付",
                                  nil];
        alertView.tag = 1009;
        [alertView show];
        
    }

}

//离线透传消息接收完成的回调
- (void)didFinishedReceiveOfflineCmdMessages:(NSArray *)offlineCmdMessages;
{
    EMMessage *body = (EMMessage *)offlineCmdMessages.lastObject;
    EMCommandMessageBody *action = (EMCommandMessageBody*)[body.messageBodies objectAtIndex:0];
    NSArray *messagearray = [action.action componentsSeparatedByString:@","];

    alertallowpay = [NSString stringWithFormat:@"%@",[messagearray objectAtIndex:4]];
    
    cashierID = [NSString stringWithFormat:@"%@",[messagearray objectAtIndex:5]];
    
    desc = [NSString stringWithFormat:@"%@",[messagearray objectAtIndex:6]];
    
    add_ID = [NSString stringWithFormat:@"%@",[messagearray objectAtIndex:7]];
    
    NSString *alerttitle = @"会员卡提醒";
    
    NSString *hintText = @"";
    
    if ([[NSString stringWithFormat:@"%@",[messagearray lastObject]] isEqualToString:@"card-1"]) {
        alerttitle = @"会员卡充值提醒";
        hintText= [NSString stringWithFormat:@"\n您在%@\n(%@)\n充值%@元\n",[messagearray objectAtIndex:1],[messagearray objectAtIndex:2],[messagearray objectAtIndex:3]];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:alerttitle
                                                            message:hintText
                                                           delegate:self
                                                  cancelButtonTitle:@"确认"
                                                  otherButtonTitles:nil];
        alertView.tag = 2000;
        [alertView show];
        
    }else if ([[NSString stringWithFormat:@"%@",[messagearray lastObject]] isEqualToString:@"card-2"]){
        
        type = @"1";
        
        alerttitle = @"会员卡消费提醒";
        hintText= [NSString stringWithFormat:@"\n您在%@\n(%@)\n共消费%@元\n",[messagearray objectAtIndex:1],[messagearray objectAtIndex:2],[messagearray objectAtIndex:3]];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:alerttitle
                                                            message:hintText
                                                           delegate:self
                                                  cancelButtonTitle:@"取消"
                                                  otherButtonTitles:@"支付",
                                  nil];
        alertView.tag = 1999;
        [alertView show];
        
    }else if ([[NSString stringWithFormat:@"%@",[messagearray lastObject]] isEqualToString:@"card-3"]){
      
        alerttitle = @"云菜单消费提醒";
        
        NSString *string = [messagearray objectAtIndex:3];
        
        m_cloundMenuId = [NSString stringWithFormat:@"%@",[messagearray objectAtIndex:2]];
        
        NSArray *arr;
        
        NSString *l_string = @"";
        
        if ( string.length != 0 ) {
            
            arr = [string componentsSeparatedByString:@"|"];
            
            if ( arr.count != 0 ) {
               
                for (int i = 0; i < arr.count; i++) {
                    
                    l_string = [l_string stringByAppendingString:[NSString stringWithFormat:@"%@\n",[arr objectAtIndex:i]]];
                    
                }
                
            }
            
        }
        
        
        hintText= [NSString stringWithFormat:@"\n您在%@\n消费了\n%@",[messagearray objectAtIndex:1],l_string];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:alerttitle
                                                            message:hintText
                                                           delegate:self
                                                  cancelButtonTitle:@"取消"
                                                  otherButtonTitles:@"确定",
                                  nil];
        alertView.tag = 2001;
        [alertView show];
        
    }else if ([[NSString stringWithFormat:@"%@",[messagearray lastObject]] isEqualToString:@"card-5"]){
        
        if ( messagearray.count == 11 ) {
            
            NSString *fromId = [NSString stringWithFormat:@"%@",[messagearray objectAtIndex:8]];
            NSString *toId = [NSString stringWithFormat:@"%@",[messagearray objectAtIndex:9]];

            
            // card5对于商户
            // 对与商户收到透传后进行的处理
            [self setMactTakeAwayMessage:messagearray withFromId:fromId toId:toId];
            
        }
        
   
    
        
    }else if ([[NSString stringWithFormat:@"%@",[messagearray lastObject]] isEqualToString:@"card-6"]){
        
        // card6对于用户
        // 对与用户收到透传后进行的处理
        [self setAccountMessage:messagearray];

    }else if ([[NSString stringWithFormat:@"%@",[messagearray lastObject]] isEqualToString:@"card-7"]){
        
        type = @"2";
        
        // 积分
        alerttitle = @"会员卡积分消费提醒";
        hintText= [NSString stringWithFormat:@"\n您在%@\n(%@)\n共消费%@积分\n",[messagearray objectAtIndex:1],[messagearray objectAtIndex:2],[messagearray objectAtIndex:3]];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:alerttitle
                                                            message:hintText
                                                           delegate:self
                                                  cancelButtonTitle:@"取消"
                                                  otherButtonTitles:@"确认",
                                  nil];
        alertView.tag = 1008;
        [alertView show];
        
    }else if ([[NSString stringWithFormat:@"%@",[messagearray lastObject]] isEqualToString:@"card-8"]){
        
        type = @"3";
        
        // 红包
        alerttitle = @"会员卡红包消费提醒";
        hintText= [NSString stringWithFormat:@"\n您在%@\n(%@)\n共消费%@元红包\n",[messagearray objectAtIndex:1],[messagearray objectAtIndex:2],[messagearray objectAtIndex:3]];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:alerttitle
                                                            message:hintText
                                                           delegate:self
                                                  cancelButtonTitle:@"取消"
                                                  otherButtonTitles:@"支付",
                                  nil];
        alertView.tag = 1009;
        [alertView show];
        
    }
    
}

- (void)playSoundAndVibration{
    
    //如果距离上次响铃和震动时间太短, 则跳过响铃

    NSTimeInterval timeInterval = [[NSDate date]
                                   timeIntervalSinceDate:self.lastPlaySoundDate];
    if (timeInterval < kDefaultPlaySoundInterval) {
        return;
    }
    //保存最后一次响铃时间
    self.lastPlaySoundDate = [NSDate date];
    
    // 收到消息时，播放音频
    [[EaseMob sharedInstance].deviceManager asyncPlayNewMessageSound];
    // 收到消息时，震动
    [[EaseMob sharedInstance].deviceManager asyncPlayVibration];
}

- (void)showNotificationWithMessage:(EMMessage *)message
{
    EMPushNotificationOptions *options = [[EaseMob sharedInstance].chatManager pushNotificationOptions];
    //发送本地推送
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.fireDate = [NSDate date]; //触发通知的时间
    
    if (options.displayStyle == ePushNotificationDisplayStyle_messageSummary) {
        id<IEMMessageBody> messageBody = [message.messageBodies firstObject];
        NSString *messageStr = nil;
        if(message.ext && [message.ext objectForKey:@"type"]){
            if ([[NSString stringWithFormat:@"%@",[message.ext objectForKey:@"type"]] isEqualToString:@"PRO"]) {
                messageStr = @"[产品]";
            }else if ([[NSString stringWithFormat:@"%@",[message.ext objectForKey:@"type"]] isEqualToString:@"WEB"]){
                messageStr = @"[链接]";
            }else if ([[NSString stringWithFormat:@"%@",[message.ext objectForKey:@"type"]] isEqualToString:@"DALI"]){
                messageStr = @"[服务打评]";
            }else if ([[NSString stringWithFormat:@"%@",[message.ext objectForKey:@"type"]] isEqualToString:@"MENU"]){
                messageStr = @"[订单通知]";
            }else if ([[NSString stringWithFormat:@"%@",[message.ext objectForKey:@"type"]] isEqualToString:@"game"]){
                messageStr = @"[游戏结果]";
            }else{
                
            }
        }else{
        switch (messageBody.messageBodyType) {
            case eMessageBodyType_Text:
            {
                messageStr = ((EMTextMessageBody *)messageBody).text;
            }
                break;
            case eMessageBodyType_Image:
            {
                messageStr = @"[图片]";
            }
                break;
            case eMessageBodyType_Location:
            {
                messageStr = @"[位置]";
            }
                break;
            case eMessageBodyType_Voice:
            {
                messageStr = @"[音频]";
            }
                break;
            case eMessageBodyType_Video:{
                messageStr = @"[视频]";
            }
                break;
            default:
                break;
        }
        }
        
        NSString *title = message.from;
        if (message.isGroup) {
            NSArray *groupArray = [[EaseMob sharedInstance].chatManager groupList];
            for (EMGroup *group in groupArray) {
                if ([group.groupId isEqualToString:message.conversationChatter]) {
                    title = [NSString stringWithFormat:@"%@(%@)", message.groupSenderName, group.groupSubject];
                    break;
                }
            }
        }
        
        notification.alertBody = [NSString stringWithFormat:@"%@:%@", title, messageStr];
        if ([self isPureInt:message.from]&&(![self ISnullInfo:message.from])) {
            [self requestSubmitFromID:message.from andSEL:4 andmessage:messageStr];
            return;
        }else
        {
            title =[NSString stringWithFormat:@"%@",[[self.InfoCache getInfo:title]       objectForKey:@"RealName"]];
            notification.alertBody = [NSString stringWithFormat:@"%@:%@", title, messageStr];
        }
    }
    else{
        notification.alertBody = @"您有一条新消息";
    }

#warning 去掉注释会显示[本地]开头, 方便在开发中区分是否为本地推送
    //notification.alertBody = [[NSString alloc] initWithFormat:@"[本地]%@", notification.alertBody];
    
    notification.alertAction = @"打开";
    notification.timeZone = [NSTimeZone defaultTimeZone];
    //发送通知
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    //    UIApplication *application = [UIApplication sharedApplication];
    //    application.applicationIconBadgeNumber += 1;
}

#pragma mark - IChatManagerDelegate 登陆回调（主要用于监听自动登录是否成功）

- (void)didLoginWithInfo:(NSDictionary *)loginInfo error:(EMError *)error
{
    
    if (error) {
        /*NSString *hintText = @"";
         if (error.errorCode != EMErrorServerMaxRetryCountExceeded) {
         if (![[[EaseMob sharedInstance] chatManager] isAutoLoginEnabled]) {
         hintText = @"你的账号登录失败，请重新登陆";
         UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
         message:hintText
         delegate:self
         cancelButtonTitle:@"确定"
         otherButtonTitles:nil,
         nil];
         alertView.tag = 99;
         [alertView show];  
         }
         } else {
         hintText = @"已达到最大登陆重试次数，请重新登陆";
         UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
         message:hintText
         delegate:self
         cancelButtonTitle:@"确定"
         otherButtonTitles:nil,
         nil];
         alertView.tag = 99;
         [alertView show];
         }*/
        NSString *hintText = @"你的账号登录失败，正在重试中... \n点击 '登出' 按钮跳转到登录页面 \n点击 '继续等待' 按钮等待重连成功";
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:hintText
                                                           delegate:self
                                                  cancelButtonTitle:@"继续等待"
                                                  otherButtonTitles:@"登出",
                                  nil];
        alertView.tag = 99;
        [alertView show];
    }
}

#pragma mark - IChatManagerDelegate 好友变化

- (void)didReceiveBuddyRequest:(NSString *)username
                       message:(NSString *)message
{
    
if ([self ISnullInfo:username]) {
    
#if !TARGET_IPHONE_SIMULATOR
        NSString * NickName = [NSString stringWithFormat:@"%@",[[self.InfoCache getInfo:username]       objectForKey:@"NickName"]];

        [self playSoundAndVibration];
        BOOL isAppActivity = [[UIApplication sharedApplication] applicationState] == UIApplicationStateActive;
        if (!isAppActivity) {
            //发送本地推送
            UILocalNotification *notification = [[UILocalNotification alloc] init];
            notification.fireDate = [NSDate date]; //触发通知的时间
            notification.alertBody = [NSString stringWithFormat:@"%@ %@", NickName, @"添加你为好友"];
            notification.alertAction = @"打开";
            notification.timeZone = [NSTimeZone defaultTimeZone];
        }
#endif
        [_contactsVC reloadApplyView];

    }else{
        
        [self requestSubmitFromID:username andSEL:3 andmessage:nil];
    }
    
    [[ApplyViewController shareController] ISrequest:username];
}

- (void)didUpdateBuddyList:(NSArray *)buddyList
            changedBuddies:(NSArray *)changedBuddies
                     isAdd:(BOOL)isAdd
{
    [_contactsVC reloadDataSource:nil];
}

- (void)didRemovedByBuddy:(NSString *)username
{
    [[EaseMob sharedInstance].chatManager removeConversationByChatter:username deleteMessages:YES append2Chat:NO];
    [_chatListVC refreshDataSource];
    [_contactsVC reloadDataSource:nil];
}

- (void)didAcceptedByBuddy:(NSString *)username
{
    [_contactsVC reloadDataSource:nil];
}

- (void)didRejectedByBuddy:(NSString *)username
{
    if ([self ISnullInfo:username]) {
    NSString * NickName = [NSString stringWithFormat:@"%@",[[self.InfoCache getInfo:username]       objectForKey:@"NickName"]];
    NSString *message = [NSString stringWithFormat:@"你被'%@'无情的拒绝了", NickName];
        TTAlertNoTitle(message);
    }else{
        [self requestSubmitFromID:username andSEL:1 andmessage:nil];
    }

}

- (void)didAcceptBuddySucceed:(NSString *)username{
    [_contactsVC reloadDataSource:nil];
}

#pragma mark - IChatManagerDelegate 群组变化
//入群的邀请
- (void)didReceiveGroupInvitationFrom:(NSString *)groupId
                              inviter:(NSString *)username
                              message:(NSString *)message
{
#if !TARGET_IPHONE_SIMULATOR
    [self playSoundAndVibration];
#endif
    
    [_contactsVC reloadGroupView];
}

//接收到入群申请
- (void)didReceiveApplyToJoinGroup:(NSString *)groupId
                         groupname:(NSString *)groupname
                     applyUsername:(NSString *)username
                            reason:(NSString *)reason
                             error:(EMError *)error
{
    if (!error) {
        
        [[ApplyViewController shareController] ISrequest:username];

#if !TARGET_IPHONE_SIMULATOR
        [self playSoundAndVibration];
#endif
        
        [_contactsVC reloadGroupView];
    }
    
}

//邀请别人加入群组, 但被别人拒绝后的回调
- (void)didReceiveGroupRejectFrom:(NSString *)groupId
                          invitee:(NSString *)username
                           reason:(NSString *)reason
{

    if ([self ISnullInfo:username]) {
        NSString * NickName = [NSString stringWithFormat:@"%@",[[self.InfoCache getInfo:username]       objectForKey:@"NickName"]];
        NSString *message = [NSString stringWithFormat:@"你被'%@'无耻的拒绝加入聊天群", NickName];
        TTAlertNoTitle(message);
    }else{
        [self requestSubmitFromID:username andSEL:2 andmessage:nil];
    }
}


- (void)didReceiveAcceptApplyToJoinGroup:(NSString *)groupId
                               groupname:(NSString *)groupname
{
    NSString *message = [NSString stringWithFormat:@"同意加入群组\'%@\'", groupname];
    [self showHint:message];
}

#pragma mark - IChatManagerDelegate 登录状态变化

- (void)didLoginFromOtherDevice
{
    [[EaseMob sharedInstance].chatManager asyncLogoffWithUnbindDeviceToken:NO completion:^(NSDictionary *info, EMError *error) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"您的账号在别处登录被迫下线了。\n如果这不是您本人的操作,那么您的密码可能已经泄露,建议立即修改密码。"
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:@"重新连接",nil,
                                  nil];
        alertView.tag = 100;
        [alertView show];
    } onQueue:nil];
}

- (void)didRemovedFromServer {
    
    [[EaseMob sharedInstance].chatManager asyncLogoffWithUnbindDeviceToken:NO completion:^(NSDictionary *info, EMError *error) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"你的账号已被从服务器端移除"
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil,
                                  nil];
        alertView.tag = 101;
        [alertView show];
    } onQueue:nil];
}

//- (void)didConnectionStateChanged:(EMConnectionState)connectionState
//{
//    [_chatListVC networkChanged:connectionState];
//}

- (void)networkChanged:(EMConnectionState)connectionState
{
    _connectionState = connectionState;
    [_chatListVC networkChanged:connectionState];
}


#pragma mark -

- (void)willAutoReconnect{
    [self hideHud];
}

- (void)didAutoReconnectFinishedWithError:(NSError *)error{
    [self hideHud];

    if (error) {
//        [self showHint:@"重连失败，稍候将继续重连"];
    }else{
//        [self showHint:@"重连成功！"];
    }
   
}

// 好友详细信息请求数据
- (void)requestSubmitFromID:(NSString *)ID andSEL:(int)Num andmessage:(NSString *)Mess{
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.fireDate = [NSDate date];
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,     @"memberId",
                           key,   @"key",
                           ID,@"otherId",
                           nil];
    [httpClient request:@"FriendsDetail.ashx" parameters:param success:^(NSJSONSerialization* json){
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            
            [self.InfoCache addInfo:[json valueForKey:@"friendsInfo"] andID:ID];
        
            switch (Num) {
                case 1:
                    //请求好友被拒绝的信息
                    [self didRejectedByBuddy:ID];
                    break;
                case 2:
                    //邀请别人加入群组, 但被别人拒绝后的回调
                    [self didReceiveGroupRejectFrom:nil invitee:ID reason:nil];
                    break;
                case 3:
                    [self didReceiveBuddyRequest:ID message:nil];
                    break;
                case 4:
                    //触发通知的时间
                    notification.alertBody = [NSString stringWithFormat:@"%@:%@", [NSString stringWithFormat:@"%@",[[self.InfoCache getInfo:ID]       objectForKey:@"RealName"]], Mess];
                    notification.alertAction = @"打开";
                    notification.timeZone = [NSTimeZone defaultTimeZone];
                    //发送通知
                    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
                    break;
                default:
                    break;
            }
        }
        else{
            if (Num ==4) {
                UILocalNotification *notification = [[UILocalNotification alloc] init];
                notification.fireDate = [NSDate date]; //触发通知的时间
                notification.alertBody = [NSString stringWithFormat:@"%@:%@", [NSString stringWithFormat:@"%@",[[self.InfoCache getInfo:ID]       objectForKey:@"RealName"]], Mess];
                notification.alertAction = @"打开";
                notification.timeZone = [NSTimeZone defaultTimeZone];
                //发送通知
                [[UIApplication sharedApplication] scheduleLocalNotification:notification];
            }
        }
    } failure:^(NSError *error) {
        
        UILocalNotification *notification = [[UILocalNotification alloc] init];
        notification.fireDate = [NSDate date]; //触发通知的时间
        notification.alertBody = @"您有一条新消息";
        notification.alertAction = @"打开";
        notification.timeZone = [NSTimeZone defaultTimeZone];
        //发送通知
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    }];
    
}

//判断根据ID的个人信息是否为空
-(BOOL)ISnullInfo:(NSString *)ID{
    NSMutableDictionary *reSizeInfo = [self.InfoCache getInfo:ID];
    if (reSizeInfo != nil) {
        return YES;
    }return NO;
}

/*!
 @method
 @brief 用户将要进行自动登录操作的回调
 @discussion
 @param loginInfo 登录的用户信息
 @param error     错误信息
 @result
 */
- (void)willAutoLoginWithInfo:(NSDictionary *)loginInfo error:(EMError *)error {

    NSLog(@"准备自动登录");
    
}

/*!
 @method
 @brief 用户自动登录完成后的回调
 @discussion
 @param loginInfo 登录的用户信息
 @param error     错误信息
 @result
 */
- (void)didAutoLoginWithInfo:(NSDictionary *)loginInfo error:(EMError *)error {

    NSLog(@"自动登录完成");
    
}

//被踢重新登陆聊天
- (void)loginWithUsername:(NSString *)username password:(NSString *)password
{
    [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:username
                                                        password:password
                                                      completion:
     ^(NSDictionary *loginInfo, EMError *error) {
         [self hideHud];
         if (loginInfo && !error) {
             [[EaseMob sharedInstance].chatManager setIsAutoLoginEnabled:YES];//设置环信的自动登录（必须）不然会出现数据缓存的问题
             EMError *error = [[EaseMob sharedInstance].chatManager importDataToNewDatabase];
             if (!error) { error = [[EaseMob sharedInstance].chatManager loadDataFromDatabase];
             };
         }else {
             switch (error.errorCode) {
                 case EMErrorServerNotReachable:
                     TTAlertNoTitle(@"连接服务器失败!");
                     break;
                 case EMErrorServerAuthenticationFailure:
                     TTAlertNoTitle(@"用户名或密码错误");
                     break;
                 case EMErrorServerTimeout:
                     TTAlertNoTitle(@"连接服务器超时!");
                     break;
                 default:
                     TTAlertNoTitle(@"登录失败");
                     break;
             }
         }
     } onQueue:nil];
}

//判断为数字//判断是否为整形：
- (BOOL)isPureInt:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

-(void)alertallowpay:(NSString *)cardTranRcdsID
{
    alertallowpay = @"";
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
                           cardTranRcdsID,@"cardTranRcdsID",
                           type,@"type",
                           cashierID,@"cashierAccountID",
                           desc,@"desc",
                           add_ID,@"add_id",
                           nil];
    
    [httpClient request:@"ConfirmVIPCardPay_1.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        NSString *msg = [json valueForKey:@"msg"];
        if (success) {
            [SVProgressHUD showSuccessWithStatus:msg];
            if ([[CommonUtil getValueByKey:MycardViewcurrentBool] isEqualToString:@"YES"]) {
                [[NSNotificationCenter defaultCenter] postNotificationName:MycardViewcurrentBool object:nil];
            }else if ([[CommonUtil getValueByKey:MycardViewdetailcurrentBool] isEqualToString:@"YES"]){
                [[NSNotificationCenter defaultCenter] postNotificationName:MycardViewdetailcurrentBool object:nil];
            }
        } else {
            
            [SVProgressHUD showErrorWithStatus:msg];
        }
    } failure:^(NSError *error) {
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];
    
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
        [SVProgressHUD showErrorWithStatus:@"目前无网络可用"];
    }
    return isExistenceNetWork;
}



// 对于商户的处理
- (void)setMactTakeAwayMessage:(NSArray *)array withFromId:(NSString *)fromId toId:(NSString *)toId{
    
    NSString *title = @"";
    
    if ( array.count != 0 ) {
        
        NSString *string = [array objectAtIndex:0];
        // 0表示非外卖 1表示外卖
        if ( [string isEqualToString:@"0"] ) {
            
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil
                                                               message:@"您有预订订单，请查看"
                                                              delegate:nil
                                                     cancelButtonTitle:nil
                                                     otherButtonTitles:@"确定", nil];
            [alertView show];
            
            
            
            //注册声音到系统
            AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"appointment" ofType:@"wav"]],&shake_sound_male_id);
            AudioServicesPlaySystemSound(shake_sound_male_id);   //播放注册的声音，（此句代码，可以在本类中的任意位置调用，不限于本方法中）
            
            title = @"预订订单成功";
            
        }else if ( [string isEqualToString:@"1"] ){
            
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil
                                                               message:@"您有外卖订单，请查看"
                                                              delegate:nil
                                                     cancelButtonTitle:nil
                                                     otherButtonTitles:@"确定", nil];
            [alertView show];
            
            
            //注册声音到系统
            AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Takeaway" ofType:@"wav"]],&shake_sound_male_id);
            AudioServicesPlaySystemSound(shake_sound_male_id);   //播放注册的声音，（此句代码，可以在本类中的任意位置调用，不限于本方法中）
            
            title = @"外卖订单成功";

        }
    }
    
    
    // 对用户进行发送消息
    [self sendU_definedMessage:@"" andtitle:title andsubtitle:nil andtype:@"MENU" andtoid:fromId andgroup:NO withArray:array];
    
//    [self sendU_definedMessage:@"" andtitle:title andsubtitle:nil andtype:@"WEB" andtoid:fromId andgroup:NO];

    
}

// 对于用户的处理
- (void)setAccountMessage:(NSArray *)array{

    /*
     if ( array.count != 0 ) {
     
     NSString *string = [array objectAtIndex:0];
     // 0表示非外卖 1表示外卖
     if ( [string isEqualToString:@"0"] ) {
     
     UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil
     message:@"您有预订订单，请查看"
     delegate:nil
     cancelButtonTitle:nil
     otherButtonTitles:@"确定", nil];
     [alertView show];
     
     
     
     //注册声音到系统
     AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"appointment" ofType:@"wav"]],&shake_sound_male_id);
     AudioServicesPlaySystemSound(shake_sound_male_id);   //播放注册的声音，（此句代码，可以在本类中的任意位置调用，不限于本方法中）
     
     }else if ( [string isEqualToString:@"1"] ){
     
     UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil
     message:@"您有外卖订单，请查看"
     delegate:nil
     cancelButtonTitle:nil
     otherButtonTitles:@"确定", nil];
     [alertView show];
     
     
     //注册声音到系统
     AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Takeaway" ofType:@"wav"]],&shake_sound_male_id);
     AudioServicesPlaySystemSound(shake_sound_male_id);   //播放注册的声音，（此句代码，可以在本类中的任意位置调用，不限于本方法中）
     
     }
     }
     
     */
    
}

-(void)sendU_definedMessage:(NSString *)Photo andtitle:(NSString *)title andsubtitle:(NSString *)subtitle andtype:(NSString *)type andtoid:(NSString *)username andgroup:(BOOL)Isgroup withArray:(NSArray *)array
{
    
    //@"自定义消息_HuiHui_012345"
    EMChatText *userObject = [[EMChatText alloc] initWithText:title];
    EMTextMessageBody *body = [[EMTextMessageBody alloc]
                               initWithChatObject:userObject];
    EMMessage *msg = [[EMMessage alloc] initWithReceiver:username
                                                  bodies:@[body]];
    msg.requireEncryption = NO;
    msg.isGroup = Isgroup;
    NSMutableDictionary *vcardProperty = [NSMutableDictionary dictionary];
   	[vcardProperty setObject:Photo forKey:@"coverphoto"];
    [vcardProperty setObject:title forKey:@"title"];
   	[vcardProperty setObject:type forKey:@"type"];
    
    if ( array.count != 0 && array.count == 11 ) {

        [vcardProperty setObject:[NSString stringWithFormat:@"%@",[array objectAtIndex:0]] forKey:@"isWaimai"];
        [vcardProperty setObject:[NSString stringWithFormat:@"%@",[array objectAtIndex:1]] forKey:@"OrderNO"];
        [vcardProperty setObject:@"0" forKey:@"isMact"];
        [vcardProperty setObject:[NSString stringWithFormat:@"%@",[array objectAtIndex:3]] forKey:@"LinkName"];
        [vcardProperty setObject:[NSString stringWithFormat:@"%@",[array objectAtIndex:6]] forKey:@"shopPhone"];
        
        [vcardProperty setObject:[NSString stringWithFormat:@"%@",[array objectAtIndex:2]] forKey:@"menuTime"];
        [vcardProperty setObject:[NSString stringWithFormat:@"%@",[array objectAtIndex:4]] forKey:@"menuPhone"];
        [vcardProperty setObject:[NSString stringWithFormat:@"%@",[array objectAtIndex:5]] forKey:@"shopName"];
        [vcardProperty setObject:[NSString stringWithFormat:@"%@",[array objectAtIndex:7]] forKey:@"menuTitle"];

        
    }

    msg.ext = vcardProperty;
    
    [[EaseMob sharedInstance].chatManager asyncSendMessage:msg progress:nil prepare:^(EMMessage *message, EMError *error) {
        if (!error) {
//            [self showHudInView:self.view hint:@"正在发送..."];
        }
    } onQueue:nil completion:^(EMMessage *message, EMError *error) {
        [self hideHud];
        if (!error) {
//            [self showHint:@"发送成功"];
//            [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(leftClicked) userInfo:nil repeats:NO];
        }else{
//            [self showHint:@"发送失败"];
        }
    } onQueue:nil];
    
}


@end
