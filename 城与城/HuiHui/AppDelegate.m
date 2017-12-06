//
//  AppDelegate.m
//  HuiHui
//
//  Created by mac on 13-11-19.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import "AppDelegate.h"
#import "StartViewController.h"
#import "JSON.h"
#import "CommonUtil.h"
#import "SVProgressHUD.h"
#import "AppHttpClient.h"
#import "Reachability.h"
#import "Configuration.h"
#import "BPush.h"
#import "JSONKit.h"
#import "OpenUDID.h"
#import "AppDelegate+EaseMob.h"
#import "LoginViewController.h"
#import "XWAlterview.h"
#import "FSB_GameViewController.h"
#import "FSB_GameNAVController.h"
#import "JPUSHService.h"
#import <AlipaySDK/AlipaySDK.h>

@interface AppDelegate ()<JPUSHRegisterDelegate>

@end

@implementation AppDelegate

@synthesize emotionJsonsKeyIsCode;

@synthesize emotionJsonsKeyIsText;

@synthesize m_badgeNumber;

@synthesize gChatGroups;

@synthesize HHinitRoomUsers;

@synthesize isAddToBase;

@synthesize isFirstGroup;

@synthesize m_groupList;

@synthesize m_groupIndex;

@synthesize m_groupUserId;

@synthesize AllMessageOfGroup;

@synthesize GroupMembers;

@synthesize isHello;

@synthesize mainController;

@synthesize m_isCategory;

@synthesize m_customRulesDic;

@synthesize m_customNameDic;

+ (AppDelegate *)instance {
	return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}


- (id)init {
	self = [super init];
    if (self) {
        _dpapi = [[DPAPI alloc] init];
		_appKey = [[NSUserDefaults standardUserDefaults] valueForKey:@"appkey"];
		if (_appKey.length<1) {
			_appKey = kDPAppKey;
		}
		_appSecret = [[NSUserDefaults standardUserDefaults] valueForKey:@"appsecret"];
		if (_appSecret.length<1) {
			_appSecret = kDPAppSecret;
		}
    }
    return self;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    //notice: 3.0.0及以后版本注册可以这样写，也可以继续用之前的注册方式
//    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
//    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
//    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
//        // 可以添加自定义categories
//        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
//        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
//    }
//    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
//    
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"PushConfig" ofType:@"plist"];
//    
//    NSDictionary *dic = [[NSDictionary alloc] initWithContentsOfFile:path];
//    
//    [JPUSHService setupWithOption:launchOptions
//                           appKey:[dic objectForKey:@"APP_KEY"]
//                          channel:[dic objectForKey:@"CHANNEL"]
//                 apsForProduction:[[dic objectForKey:@"APS_FOR_PRODUCTION"] boolValue]
//            advertisingIdentifier:nil];
//    
    //将判断当前是否是我的卡界面参数先清空
    [CommonUtil addValue:nil andKey:MycardViewcurrentBool];
    [CommonUtil addValue:nil andKey:MycardViewdetailcurrentBool];
    
    m_groupList = [[NSMutableArray alloc]initWithCapacity:0];

    gChatGroups = [[NSMutableArray alloc]initWithCapacity:0];
    
    HHinitRoomUsers = [[NSMutableArray alloc]initWithCapacity:0];
    
    m_customRulesDic = [[NSMutableDictionary alloc]initWithCapacity:0];
    
    m_customNameDic = [[NSMutableDictionary alloc]initWithCapacity:0];

    
    self.m_badgeNumber = 0;
    
    self.m_groupIndex = 0;
    
    self.m_groupUserId = @"";
    
    self.isHello = NO;
    
    self.m_isCategory = NO;
    
    // 读取json文件来获得表情的字符解释
    {
        
        NSString *path = [[NSBundle mainBundle]pathForResource:@"Emotions" ofType:@"json"];
        
        NSString *content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        
        emotionJsonsKeyIsCode = [[NSMutableDictionary alloc]initWithCapacity:90];
        emotionJsonsKeyIsText = [[NSMutableDictionary alloc]initWithCapacity:90];
        
        NSArray *array = [content JSONValue];
        
        for (NSDictionary *dic in array) {
            NSString *string = [dic objectForKey:@"string"];
            NSString *key = [dic objectForKey:@"key"];
            [emotionJsonsKeyIsCode setObject:string forKey:key];
            [emotionJsonsKeyIsText setObject:key forKey:string];
        }
    }
    
    self.isSelectgoShopping = NO;
    self.isModifyImage = NO;
    self.isChangeCover = NO;
    self.isChange = NO;
    self.isForward = NO;
    self.isTongxunlu = NO;
    self.isImageOrText = @"0";
    self.isMemberCountChange = NO;
    
    // =======
    self.isAddToBase = NO;
    self.isFirstGroup = YES;
    
    // 设置状态栏的背景颜色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    // 启动百度地图 secret Key im3Z1CD9dajFQYjCxt4Zmlpi
    {

        _mapManager = [[BMKMapManager alloc] init];
        BOOL ret = [_mapManager start:@"im3Z1CD9dajFQYjCxt4Zmlpi" generalDelegate:nil];
        if (ret) {

        }
    }
    // 微信 AppID   wx67aeb251adaae095
    {// 微信

        [WXApi registerApp:@"wx67aeb251adaae095" withDescription:@"demo 2.0"];
   
    }

    [BPush setupChannel:launchOptions];
    [BPush setDelegate:self];
    
    [application setApplicationIconBadgeNumber:0];

    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        
        UIUserNotificationType myTypes = UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:myTypes categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    
    }else

    {
        UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:myTypes];
    }
    

    // 保存纪录是否为第一次启动
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"everLaunched"]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"everLaunched"];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    else{
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"firstLaunch"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }

    // 注册通讯录变更时的操作
    [self registerCallback];

    _connectionState = eEMConnectionConnected;
    
    [self easemobApplication:application didFinishLaunchingWithOptions:launchOptions];

    BOOL isAutoLogin = [[[EaseMob sharedInstance] chatManager] isAutoLoginEnabled];
    
    if (isAutoLogin ) {
        [[ApplyViewController shareController] loadDataSourceFromLocalDB];
        [mainController networkChanged:_connectionState];
    }
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    StartViewController *startController = [[StartViewController alloc]initWithNibName:@"StartViewController" bundle:nil];
    _nav = [[UINavigationController alloc]initWithRootViewController:startController];
    _nav.delegate = self;
    self.window.rootViewController = self.nav;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [self versionRequest];
    

//    NSNotificationCenter*defaultCenter = [NSNotificationCenter defaultCenter];
//    
//    [defaultCenter addObserver:self
//                      selector:@selector(beginLink:)
//                          name:kJPFNetworkIsConnectingNotification
//                        object:nil];
//    
//    [defaultCenter addObserver:self
//                      selector:@selector(setupLink:)
//                          name:kJPFNetworkDidSetupNotification
//                        object:nil];
//    
//    [defaultCenter addObserver:self
//                      selector:@selector(closeLink:)
//                          name:kJPFNetworkDidCloseNotification
//                        object:nil];
//    
//    [defaultCenter addObserver:self
//                      selector:@selector(registrationSuccess:)
//                          name:kJPFNetworkDidRegisterNotification
//                        object:nil];
//    
//    [defaultCenter addObserver:self
//                      selector:@selector(registrationFail:)
//                          name:kJPFNetworkFailedRegisterNotification
//                        object:nil];
//    
//    [defaultCenter addObserver:self
//                      selector:@selector(loginSuccess:)
//                          name:kJPFNetworkDidLoginNotification
//                        object:nil];
//    
//    [defaultCenter addObserver:self
//                      selector:@selector(JpushGetMessage:)
//                          name:kJPFNetworkDidReceiveMessageNotification
//                        object:nil];
//    
//    [defaultCenter addObserver:self
//                      selector:@selector(FailAlert:)
//                          name:kJPFServiceErrorNotification
//                        object:nil];
//
    
    return YES;
}

//- (void)beginLink:(NSNotification *)notification {
//
//    NSLog(@"正在连接中");
//    
//}
//
//- (void)setupLink:(NSNotification *)notification {
//    
//    NSLog(@"建立连接");
//    
//}
//
//- (void)closeLink:(NSNotification *)notification {
//    
//    NSLog(@"关闭连接");
//    
//}
//
//- (void)registrationSuccess:(NSNotification *)notification {
//    
//    NSLog(@"注册成功");
//    
//}
//
//- (void)registrationFail:(NSNotification *)notification {
//    
//    NSLog(@"注册失败");
//    
//}
//
//- (void)loginSuccess:(NSNotification *)notification {
//    
//    NSLog(@"登录成功%@",[JPUSHService registrationID]);
//    
//}
//
//- (void)JpushGetMessage:(NSNotification *)notification {
//    
//    NSLog(@"获取信息");
//    
//}
//
//- (void)FailAlert:(NSNotification *)notification {
//    
//    NSLog(@"错误提示");
//    
//}

//版本检测
- (void)versionRequest{
    
    //当前版本信息
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    
    NSError *error;
    
    NSString *urlstr = [NSString stringWithFormat:@"https:itunes.apple.com/lookup?id=796827489"];
    
    NSURL *url = [NSURL URLWithString:urlstr];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
    
    if (error) {
        
    }
    
    NSArray *array = [dic objectForKey:@"results"];
    
    if (![array count]) {
        
    }
    
    NSDictionary *infodic = [array objectAtIndex:0];
    
    NSString *appstoreVersion = [infodic objectForKey:@"version"];
    
    //下载链接
    NSString *downLoad = [infodic objectForKey:@"trackViewUrl"];
    
    if ([self CompareDemoVersion:version WithAppStoreVersion:appstoreVersion]) {
        
        XWAlterview *alert = [[XWAlterview alloc] initWithIcon:@"icon_120.png" Content:@"城与城新版本发布啦！功能更加优化，体验更棒！" Title:@"版本更新" Cancle:@"稍后再说" Sure:@"立即下载"];
        
        alert.rightBlock = ^(){
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:downLoad]];
            
        };
        
        [alert show];
        
    }
    
}

- (BOOL)CompareDemoVersion:(NSString *)demoVersion WithAppStoreVersion:(NSString *)appstoreVersion {
    
    NSMutableArray *demoArr = [NSMutableArray arrayWithArray:[demoVersion componentsSeparatedByString:@"."]];
    
    NSMutableArray *appstoreArr = [NSMutableArray arrayWithArray:[appstoreVersion componentsSeparatedByString:@"."]];
    
    // 补全版本信息为相同位数
    while (demoArr.count < appstoreArr.count) {
        
        [demoArr addObject:@"0"];
        
    }
    while (appstoreArr.count < demoArr.count) {
        
        [appstoreArr addObject:@"0"];
        
    }
    
    BOOL compareResutl = NO;
    
    for(NSUInteger i = 0; i < demoArr.count; i++){
        
        NSInteger versionNumber1 = [demoArr[i] integerValue];
        
        NSInteger versionNumber2 = [appstoreArr[i] integerValue];
        
        if (versionNumber1 < versionNumber2) {
            
            compareResutl = YES;
            
            break;
            
        }else if (versionNumber2 < versionNumber1){
            
            compareResutl = NO;
            
            break;
            
        }else{
            
            compareResutl = NO;
            
        }
        
    }
    
    return compareResutl;
    
}


- (void)request:(DPRequest *)request didFailWithError:(NSError *)error {
    
    [SVProgressHUD dismiss];
    
}

- (void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result {
    
    for (int i = 0; i < 100; i++) {
        
        
        
    }
    
    NSString * success = [result valueForKey:@"status"];
    
    if ([success isEqualToString:@"OK"]) {
        
        [SVProgressHUD dismiss];
        
        NSMutableArray *arr = [result valueForKey:@"cities"];
        
        for (int i = 0; i < arr.count; i ++) {
            
//            NSString *string = [arr objectAtIndex:i];
            
        }

    }
    
}


// ======================================================================

// 接收通知的方法
- (void)setPush
{
    // 先将数字置0
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeBadge)];
    
}


- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    
    // 删除分隔符和空格
    NSMutableString* mut_str = [[NSMutableString alloc] initWithFormat:@"%@",[deviceToken description]];
    // 删除开始的“<”
    NSRange range;
    range.location = 0;
    range.length = 1;
    [mut_str deleteCharactersInRange:range];
    // 删除结束的“>”
    range.location = [mut_str length] - 1;
    range.length = 1;
    [mut_str deleteCharactersInRange:range];
    // 删除空格
    range.location = 0;
    range.length = [mut_str length] - 1;
    [mut_str replaceOccurrencesOfString:@" " withString:@"" options:NSCaseInsensitiveSearch range:range];
    
    // 保存deviceToken
    [CommonUtil addValue:mut_str andKey:BPush_devicetoken];
    
    // 初始化token
    [BPush registerDeviceToken: deviceToken];
    // 通知注册成功后绑定channel  
    [BPush bindChannel];
    
    /// Required - 注册 DeviceToken
    //方法被环信重写，在环信方法中执行
//    [JPUSHService registerDeviceToken:deviceToken];
    
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

- (void) onMethod:(NSString*)method response:(NSDictionary*)data {

  
    NSDictionary* res = [[NSDictionary alloc] initWithDictionary:data];
    if ([BPushRequestMethod_Bind isEqualToString:method]) {
        NSString *appid = [res valueForKey:BPushRequestAppIdKey];
        NSString *userid = [res valueForKey:BPushRequestUserIdKey];
        NSString *channelid = [res valueForKey:BPushRequestChannelIdKey];
        //NSString *requestid = [res valueForKey:BPushRequestRequestIdKey];
        int returnCode = [[res valueForKey:BPushRequestErrorCodeKey] intValue];
        
        if (returnCode == BPushErrorCode_Success) {
        
            // 存储三个值
            [CommonUtil addValue:appid andKey:BPush_kAppIdKey];
            [CommonUtil addValue:userid andKey:BPush_kUserIdKey];
            [CommonUtil addValue:channelid andKey:BPush_kChannelIdKey];

            
            // 在内存中备份，以便短时间内进入可以看到这些值，而不需要重新bind
            self.appId = appid;
            self.channelId = channelid;
            self.userId = userid;
            
        }
    } else if ([BPushRequestMethod_Unbind isEqualToString:method]) {
        int returnCode = [[res valueForKey:BPushRequestErrorCodeKey] intValue];
        if (returnCode == BPushErrorCode_Success) {
//            self.viewController.appidText.text = nil;
//            self.viewController.useridText.text = nil;
//            self.viewController.channelidText.text = nil;
        }
    }


}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {

    // 有通知后请求数据标记传给服务端，用于将数字置为0
    [self numberRequest];
    if (mainController) {
        [mainController jumpToChatList];
    }

    [[EaseMob sharedInstance] application:application didReceiveRemoteNotification:userInfo];
    
	NSDictionary *apsInfo = [userInfo objectForKey:@"aps"];
	
	NSString *alert = [apsInfo objectForKey:@"alert"];

	application.applicationIconBadgeNumber = [[apsInfo objectForKey:@"badge"] integerValue];
    
    // 根据服务端返回的类型来处理跳转
    self.m_messageType = [NSString stringWithFormat:@"%@",[userInfo objectForKey:@"ccpmessagetype"]];
    if (self.m_messageType) {
        // 接收到通知后如果是打开app的则跳出提示
        if( application.applicationState == UIApplicationStateActive ){
            
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@""
                                                                message:alert
                                                               delegate:nil
                                                      cancelButtonTitle:@"取消"
                                                      otherButtonTitles:@"查看",nil];
            alertView.tag = 1234321;
            [alertView show];
            
            
        }else{
            
            
            // 根据类型来进行不同的页面上面的通知 1表示点评返利 2表示我的用户
            NSDictionary *dic = [NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"%@",self.m_messageType] forKey:@"messageTypeKey"];
            
            // 发送通知
            [[NSNotificationCenter defaultCenter]postNotificationName:kPushNotifaction object:self userInfo:dic];
            
        }
    }
    
    [BPush handleNotification:userInfo];

    // Required,For systems with less than or equal to iOS6
//    [JPUSHService handleRemoteNotification:userInfo];
    
}

- (void)numberRequest{
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        return;
    }
    if ([CommonUtil getValueByKey:MEMBER_ID] ==nil) {
        return;
    }
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           [NSString stringWithFormat:@"%@",memberId],@"memberId",nil];
    [httpClient request:@"AppPushUpdate.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
        } else {
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];

}


- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    
    // 接收到本地通知后取消所有的本地通知：设置了本地通知的badgeNumber后，badgeNumber为0时本地通知就取消
    self.m_badgeNumber = 0;
    
    application.applicationIconBadgeNumber = self.m_badgeNumber;
    
    if (mainController) {
        [mainController jumpToChatList];
    }
#warning SDK方法调用
    [[EaseMob sharedInstance] application:application didReceiveLocalNotification:notification];
  
}




- (void)applicationWillEnterForeground:(UIApplication *)application
{

    
    [CommonUtil addValue:self.appId andKey:BPush_kAppIdKey];
    [CommonUtil addValue:self.userId andKey:BPush_kUserIdKey];
    [CommonUtil addValue:self.channelId andKey:BPush_kChannelIdKey];
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
#warning SDK方法调用
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    [CommonUtil addValue:[BPush getAppId] andKey:BPush_kAppIdKey];
    [CommonUtil addValue:[BPush getUserId] andKey:BPush_kUserIdKey];
    [CommonUtil addValue:[BPush getChannelId] andKey:BPush_kChannelIdKey];
    
    NSString *string = [NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:MEMBER_ID]];
    
    NSInteger numberBadge = [UIApplication sharedApplication].applicationIconBadgeNumber;
    
    if ( numberBadge != 0 ) {
        
        if ( ![string isEqualToString:@"(null)"] ) {
            
            // 请求收到push接口的数据，用于服务端设置push的数字为0
            [self numberRequest];
        }
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:UIApplicationDidBecomeActiveNotification object:nil];
    
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
#warning SDK方法调用
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // 判断属于下面的某个类的时候，导航栏隐藏
    if ( [viewController isKindOfClass:[RootViewController class]] || [viewController isKindOfClass:[StartViewController class]] ) {
       self.nav.navigationBarHidden = YES;
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

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ( alertView.tag == 100001 ) {
        if (buttonIndex == 0) {
            if ([self.IsUpdate isEqualToString:@"0"]) {
            }else if ([self.IsUpdate isEqualToString:@"1"])
            {
                exit(0);
            }
        }
        if ( buttonIndex == 1 ) {
            // 点击进入版本升级的url-appStore下载的地址
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[CommonUtil getValueByKey:VERSION_APPURL]]];
        }
    }else if ( alertView.tag == 1234321 ){
        
        if ( buttonIndex == 1 ) {
            
            // 通知的一些处理方法
            // 根据类型来进行不同的页面上面的通知 1表示点评返利 2表示我的用户
            NSDictionary *dic = [NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"%@",self.m_messageType] forKey:@"messageTypeKey"];
            
            // 发送通知
            [[NSNotificationCenter defaultCenter]postNotificationName:kPushNotifaction object:self userInfo:dic];
            
        }
    }else if ( alertView.tag == 13576){
        
        if ( buttonIndex == 0 ) {
            
            // 支付成功后通知跳转到分享的页面-提示用户下单成功
            
            // 发送通知
            [[NSNotificationCenter defaultCenter]postNotificationName:@"MenuPaySuccessKey" object:self userInfo:nil];
            
        }
        
    }
}


//微信代理方法
#pragma mark App delegate
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    
    NSString *tencentScheme = [NSString stringWithFormat:@"wx67aeb251adaae095"];
    if ([[url scheme] isEqualToString:tencentScheme]) {
        return [WXApi handleOpenURL:url delegate:self];
    }else{
        /*[QQApiInterface handleOpenURL:url delegate:self] || */
      return [TencentOAuth HandleOpenURL:url];
    }
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    
    NSString *tencentScheme = [NSString stringWithFormat:@"wx67aeb251adaae095"];
    
    if ([[url scheme] isEqualToString:@"huihuigame"]) {
        
        if([[EaseMob sharedInstance].chatManager isLoggedIn]) {
        
            FSB_GameViewController *vc = [[FSB_GameViewController alloc] init];
            
            FSB_GameNAVController *gameNav = [[FSB_GameNAVController alloc] initWithRootViewController:vc];
            
            [self.window.rootViewController presentViewController:gameNav animated:YES completion:nil];
            
        }
        
        return YES;
        
    }else if ([[url scheme] isEqualToString:@"huihuiAliPay"]) {
        
        if ([url.host isEqualToString:@"safepay"]) {
            
            [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
                
//                NSLog(@"----%@",resultDic);
                
            }];
            
        }
        
        return YES;
        
    }else if ([[url scheme] isEqualToString:tencentScheme]) {
        
        return [WXApi handleOpenURL:url delegate:self];
        
    }else{
        
        /*[QQApiInterface handleOpenURL:url delegate:self] ||*/
        return  [TencentOAuth HandleOpenURL:url];
        
    }
    
}


- (void)onResp:(id)resp{
    
    NSString *strMsg = nil;
    // 判断是来自微信分享还是qq分享
    if ( [resp isKindOfClass:[SendMessageToWXResp class]] ) {
        SendMessageToWXResp *respResult = (SendMessageToWXResp *)resp;
        if ( respResult.errCode == 0 ) {
            strMsg = @"微信分享成功";
        }else{
            strMsg = @"微信分享失败";
        }
        
        
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示"
                                                           message:strMsg
                                                          delegate:nil
                                                 cancelButtonTitle:@"确定"
                                                 otherButtonTitles: nil];
        
        [alertView show];
        
    }
    else if ( [resp isKindOfClass:[SendMessageToQQResp class]] ){
        SendMessageToQQResp *respQResult = (SendMessageToQQResp *)resp;
        // qq返回说明：0对 1错
        if ( [respQResult.result isEqualToString:@"0"] ) {
            strMsg = @"QQ分享成功";
        }else{
            strMsg = @"QQ分享失败";
        }
        
        
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示"
                                                           message:strMsg
                                                          delegate:nil
                                                 cancelButtonTitle:@"确定"
                                                 otherButtonTitles: nil];
        
        [alertView show];
    }
    
    // 微信登录返回的回调
    else if ( [resp isKindOfClass:[SendAuthResp class]] ){
        
        SendAuthResp *temp = (SendAuthResp*)resp;

//        strMsg = [NSString stringWithFormat:@"code:%@,state:%@,errcode:%d", temp.code, temp.state, temp.errCode];
      
        //errStr
        
        if ( temp.errCode == 0 ) {
            
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"WeixinLogin" object:temp];
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%@",temp.code],@"codeKey", nil];
            
            [[NSNotificationCenter defaultCenter]postNotificationName:@"WeixinLogin" object:self userInfo:dic];
        }
    }
    
    
    else if ( [resp isKindOfClass:[PayResp class]] ){
        
        PayResp *response = (PayResp *)resp;
        
        switch (response.errCode) {
                
            case WXSuccess:
                
            {
                //服务器端查询支付通知或查询API返回的结果再提示成功
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示"
                                                                   message:@"支付成功"
                                                                  delegate:self
                                                         cancelButtonTitle:@"确定"
                                                         otherButtonTitles: nil];
                
                alertView.tag = 13576;
                [alertView show];
                
                
            }
                break;
            default:
                NSLog(@"支付失败， retcode=%d",response.errCode);
                
            {
            
                if ( response.errCode == -2 ) {
                    
                    //服务器端查询支付通知或查询API返回的结果再提示成功
                    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示"
                                                                       message:@"取消支付"
                                                                      delegate:nil
                                                             cancelButtonTitle:@"确定"
                                                             otherButtonTitles: nil];
                    
                    [alertView show];

                }else{
                    
                    //服务器端查询支付通知或查询API返回的结果再提示成功
                    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示"
                                                                       message:@"支付失败"
                                                                      delegate:nil
                                                             cancelButtonTitle:@"确定"
                                                             otherButtonTitles: nil];
                    
                    [alertView show];

                }
                
            }
                break;
        }
    
    }

    
}




//注册监听
- (void)registerCallback {
    
    if (!_addressBook) {

            _addressBook =ABAddressBookCreate();
    }

    if (!_hasRegister) {
        ABAddressBookRegisterExternalChangeCallback(_addressBook, addressCallback, (__bridge void *)(self));
        _hasRegister = YES ;
    }
}

//注销监听
- (void)unregisterCallback {
    if (_hasRegister) {
        ABAddressBookUnregisterExternalChangeCallback(_addressBook, addressCallback, (__bridge void *)(self));
        _hasRegister = NO;
    }
}


//添加回调方法
void addressCallback(ABAddressBookRef addressBook, CFDictionaryRef info, void *context) {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"RHAddressBookExternalChangeNotification" object:nil];
    
    // 通讯录变化后根据这个值来进行圈子里红点的刷新
//    [CommonUtil addValue:@"1" andKey:@"NewFriendsKey"];
    
}

#pragma mark - IChatManagerDelegate 好友变化
//接收到好友请求时的通知
- (void)didReceiveBuddyRequest:(NSString *)username
                       message:(NSString *)message
{
        if (!username) {
            return;
        }
        if (!message) {
            message = [NSString stringWithFormat:@"添加你为好友"];
        }
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"title":username, @"username":username, @"applyMessage":message, @"applyStyle":[NSNumber numberWithInteger:ApplyStyleFriend]}];
        [[ApplyViewController shareController] addNewApply:dic];
    
        [[ApplyViewController shareController] ISrequest:username];

        [[NSNotificationCenter defaultCenter] postNotificationName:@"setupUntreatedApplyCount" object:nil];

}

#pragma mark - IChatManagerDelegate 群组变化
//收到了其它群组的加入邀请（群主邀请你加入*群）
- (void)didReceiveGroupInvitationFrom:(NSString *)groupId
                              inviter:(NSString *)username
                              message:(NSString *)message
{
        if (!groupId || !username) {
            return;
        }
            NSString *groupName = groupId;
        if (!message || message.length == 0) {
            message = [NSString stringWithFormat:@"%@ 邀请你加入群组【%@】", username, groupName];
        }
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"title":groupName, @"groupId":groupId, @"username":username, @"applyMessage":message, @"applyStyle":[NSNumber numberWithInteger:ApplyStyleGroupInvitation]}];
        [[ApplyViewController shareController] addNewApply:dic];
    
        [[NSNotificationCenter defaultCenter] postNotificationName:@"setupUntreatedApplyCount" object:nil];

}

//收到加入群组的申请 + 申请入群发生错误
- (void)didReceiveApplyToJoinGroup:(NSString *)groupId
                         groupname:(NSString *)groupname
                     applyUsername:(NSString *)username
                            reason:(NSString *)reason
                             error:(EMError *)error
{
        if (!groupId || !username) {
            return;
        }
        if (!reason || reason.length == 0) {
            reason = [NSString stringWithFormat:@"%@ 申请加入群组【%@】", username, groupname];
        }
        else{
            reason = [NSString stringWithFormat:@"%@ 申请加入群组【%@】：%@", username, groupname, reason];
        }
        
        if (error) {
            NSString *message = [NSString stringWithFormat:@"发送申请失败:%@\n原因：%@", reason, error.description];
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"错误" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else{
            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"title":groupname, @"groupId":groupId, @"username":username, @"groupname":groupname, @"applyMessage":reason, @"applyStyle":[NSNumber numberWithInteger:ApplyStyleJoinGroup]}];
            [[ApplyViewController shareController] addNewApply:dic];
            
            [[ApplyViewController shareController] ISrequest:username];

            [[NSNotificationCenter defaultCenter] postNotificationName:@"setupUntreatedApplyCount" object:nil];
            
        }
}

- (void)didReceiveRejectApplyToJoinGroupFrom:(NSString *)fromId
                                   groupname:(NSString *)groupname
                                      reason:(NSString *)reason
{
    if (!reason || reason.length == 0) {
        reason = [NSString stringWithFormat:@"被拒绝加入群组【%@】", groupname];
    }
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"申请提示" message:reason delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
}

- (void)group:(EMGroup *)group didLeave:(EMGroupLeaveReason)reason error:(EMError *)error
{
    NSString *tmpStr = group.groupSubject;
    NSString *str;
    if (!tmpStr || tmpStr.length == 0) {
        NSArray *groupArray = [[EaseMob sharedInstance].chatManager groupList];
        for (EMGroup *obj in groupArray) {
            if ([obj.groupId isEqualToString:group.groupId]) {
                tmpStr = obj.groupSubject;
                break;
            }
        }
    }
    
    if (reason == eGroupLeaveReason_BeRemoved) {
        str = [NSString stringWithFormat:@"你被从群组【%@】中踢出", tmpStr];
    }
    if (str.length > 0) {
        TTAlertNoTitle(str);
    }
}

#pragma mark - push

- (void)didBindDeviceWithError:(EMError *)error
{
    if (error) {
        TTAlertNoTitle(@"消息推送与设备绑定失败");
    }
}




@end
