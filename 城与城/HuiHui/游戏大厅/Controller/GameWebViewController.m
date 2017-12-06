//
//  GameWebViewController.m
//  HuiHui
//
//  Created by mac on 2017/5/18.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "GameWebViewController.h"
#import "LJConst.h"

#import "TiXingView.h"
#import "ShareGameView.h"

#import <TencentOpenAPI/TencentOAuth.h>

#import <TencentOpenAPI/QQApiInterface.h>

#import "WXApi.h"
#import "Sharetofriend.h"
#import "SharetoHuiHuiViewController.h"

#import "ShareGameToHuiHuiViewController.h"

// QQ分享的AppId
#define TencentQzoneAppId @"101026359"
#import <WebKit/WebKit.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import "FSB_GameViewController.h"
#import "FSB_GameNAVController.h"
#import "GG_HomeViewController.h"
#import "GameGoldNavViewController.h"


@interface GameWebViewController () <UIAlertViewDelegate,QQApiInterfaceDelegate,TencentSessionDelegate,WKNavigationDelegate,WKScriptMessageHandler,WKUIDelegate> {

    TencentOAuth *tencentOAuth;
    
    NSString *share_title;
    
    NSString *share_desc;
    
    NSString *share_url;
    
    NSString *share_image;
    
}

@property (nonatomic, weak) UIWebView *webview;

@property (nonatomic, retain) ShareGameView *shareview;

@property (nonatomic, weak) WKWebView *wkwebview;

@end

@implementation GameWebViewController



- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self requestForShareData];
    
    self.shareview = [[ShareGameView alloc] initWithCancle:@"取消"];
    
    __weak __typeof__(self) weakSelf = self;
    
    self.shareview.QQBlock = ^(){
        
        //qq好友分享
        [weakSelf QQShare];
        
    };
    
    self.shareview.QQZoneBlock = ^(){
        
        //qq空间分享
        [weakSelf QQZoneShare];
        
    };
    
    self.shareview.WeChatBlock = ^(){
        
        //微信好友分享
        [weakSelf WeChatShare];
        
    };
    
    self.shareview.WeChatZoneBlock = ^(){
        
        //朋友圈分享
        [weakSelf WeChatZoneShare];
        
    };
    
    self.shareview.HuiHuiBlock = ^(){
        
        //城与城好友分享
        [weakSelf HuiHuiShare];
        
    };
    
    self.shareview.HuiHuiZoneBlock = ^(){
        
        //圈子分享
        [weakSelf HuiHuiZoneShare];
        
    };
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:FSB_NAVFont,NSForegroundColorAttributeName:FSB_NAVTextColor}];

    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = [self SetNavigationBarImage:@"WebView_Back.png" andaction:@selector(viewDismiss)];
    
    WKWebViewConfiguration *conf = [[WKWebViewConfiguration alloc] init];
    
    conf.preferences = [[WKPreferences alloc] init];
    
    conf.preferences.javaScriptEnabled = YES;
    
    conf.preferences.javaScriptCanOpenWindowsAutomatically = NO;
    
    conf.userContentController = [[WKUserContentController alloc] init];
    
    [conf.userContentController addScriptMessageHandler:self name:@"startGoldpage"];
    
    WKWebView *wkweb = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, _WindowViewWidth, _WindowViewHeight - 64) configuration:conf];
    
    self.wkwebview = wkweb;
    
    wkweb.navigationDelegate = self;
    
    wkweb.UIDelegate = self;
    
    //加载请求的时候忽略缓存
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.loadStr] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:5.0];
    
    [wkweb loadRequest:request];
    
    [self.view addSubview:wkweb];
    
}

-(void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {

    if ([message.name isEqualToString:@"startGoldpage"]) {

        //我的奖励金
        GG_HomeViewController *vc = [[GG_HomeViewController alloc] init];
        
        GameGoldNavViewController *gamenav = [[GameGoldNavViewController alloc] initWithRootViewController:vc];
        
        [self presentViewController:gamenav animated:YES completion:nil];

    }

}

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"前往", nil];
    
    alert.tag = 10001;
    
    [alert show];

    completionHandler();

}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {

    self.title = self.wkwebview.title;
    
}

- (void)shareClick {
        
    [self.shareview show];
    
}

//城与城好友分享
- (void)HuiHuiShare {

    // 分享到城与城好友
    Sharetofriend *VC = [[Sharetofriend alloc]init];
    VC.MessageType = @"WEB";
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                share_image,@"imageURL",
                                share_url,@"shareString",
                                share_title,@"title",
                                nil];
    
    VC.TextDIC = dic;
    
    [self.navigationController pushViewController:VC animated:YES];
    
}

//城与城朋友圈分享
- (void)HuiHuiZoneShare {
    
    //诲诲朋友圈
    ShareGameToHuiHuiViewController *vc = [[ShareGameToHuiHuiViewController alloc] init];
    
    vc.shareTitle = share_title;
    
    vc.shareDesc = share_desc;
    
    vc.shareUrl = share_url;
    
    vc.shareImg = share_image;
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

//微信好友分享
- (void)WeChatShare {

    if (![self checkIsVaildWeChat]) {
        
        return;
        
    }else {
    
        WXMediaMessage *message = [WXMediaMessage message];
        
        message.title = share_title;
        
        message.description = share_desc;
        
        [message setThumbImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",share_image]]]]];
        
        WXWebpageObject *webpageobject = [WXWebpageObject object];
        
        webpageobject.webpageUrl = share_url;
        
        message.mediaObject = webpageobject;
        
        SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
        
        req.bText = NO;
        
        req.message = message;
        
        req.scene = WXSceneSession;
        
        [WXApi sendReq:req];
        
    }
    
}

- (void)requestForShareData {
    
    AppHttpClient* httpClient = [AppHttpClient sharedExtension];
    
    NSDictionary *param = [NSDictionary dictionary];
    
    [httpClient ExtensionRequest:@"GameShare.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            
            share_title = [NSString stringWithFormat:@"%@",[json valueForKey:@"Title"]];
            
            share_desc = [NSString stringWithFormat:@"%@",[json valueForKey:@"Sub"]];
            
            share_image = [NSString stringWithFormat:@"%@",[json valueForKey:@"Icon"]];
            
            share_url = [NSString stringWithFormat:@"%@",[json valueForKey:@"Url"]];
            
            self.navigationItem.rightBarButtonItem = [self SetNavigationBarRightTitle:@"分享" andaction:@selector(shareClick)];
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showErrorWithStatus:msg];
            
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}

//微信朋友圈分享
- (void)WeChatZoneShare {
    
    if (![self checkIsVaildWeChat]) {
        
        return;
        
    }else {

        WXMediaMessage *message = [WXMediaMessage message];
        
        message.title = share_title;
        
        message.description = share_desc;
        
        [message setThumbImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",share_image]]]]];
        
        WXWebpageObject *webpageobject = [WXWebpageObject object];
        
        webpageobject.webpageUrl = share_url;
        
        message.mediaObject = webpageobject;
        
        SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
        
        req.bText = NO;
        
        req.message = message;
        
        req.scene = WXSceneTimeline;
        
        [WXApi sendReq:req];
        
    }
    
}

//检测是否安装微信
- (BOOL)checkIsVaildWeChat {

    if ([WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi]) {
        
        return YES;
        
    }else {
        
        //未安装
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示"
                                                        message:@"您尚未安装微信或是当前版本太低"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
    
        return NO;
        
    }
    
}

//QQ好友分享
- (void)QQShare {

    if (![self checkIsVaildQQType]) {
        
        return;
        
    }
    
    tencentOAuth = [[TencentOAuth alloc]initWithAppId:TencentQzoneAppId andDelegate:self];
    
    QQApiNewsObject *newobj = [QQApiNewsObject objectWithURL:[NSURL URLWithString:share_url] title:share_title description:share_desc previewImageURL:[NSURL URLWithString:share_image]];
    
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:newobj];
    //将内容分享到qq
    QQApiSendResultCode sent = [QQApiInterface sendReq:req];
    // 判断QQ的情况
    [self handleSendResult:sent];
    
}

//QQ空间分享
- (void)QQZoneShare {
    
    if (![self checkIsVaildQQType]) {
        
        return;
        
    }
    
    tencentOAuth = [[TencentOAuth alloc]initWithAppId:TencentQzoneAppId andDelegate:self];
    
    QQApiNewsObject *newobj = [QQApiNewsObject objectWithURL:[NSURL URLWithString:share_url] title:share_title description:share_desc previewImageURL:[NSURL URLWithString:share_image]];
    
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:newobj];
    //将内容分享到qq
    QQApiSendResultCode sent = [QQApiInterface SendReqToQZone:req];
    // 判断QQ的情况
    [self handleSendResult:sent];
    
}

//QQ分享结果
- (void)handleSendResult:(QQApiSendResultCode)sendResult {
    
    switch (sendResult)
    {
        case EQQAPIAPPNOTREGISTED:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"App未注册" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            break;
        }
        case EQQAPIMESSAGECONTENTINVALID:
        case EQQAPIMESSAGECONTENTNULL:
        case EQQAPIMESSAGETYPEINVALID:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"发送参数错误" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            break;
        }
        case EQQAPIQQNOTINSTALLED:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"未安装手Q" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            break;
        }
        case EQQAPIQQNOTSUPPORTAPI:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"API接口不支持" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            break;
        }
        case EQQAPISENDFAILD:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"发送失败" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            break;
        }
        default:
        {
            break;
        }
    }
}

// 检查是否安装了QQ的客户端
- (BOOL)checkIsVaildQQType {
    
    if ([QQApi isQQInstalled] &&[QQApi isQQSupportApi]) {
        return YES;
    }else
    {
        //未安装
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示"
                                                        message:@"您尚未安装QQ或是当前版本太低"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        return NO;
    }
    
}


-(void)viewWillAppear:(BOOL)animated {
    
    if ([self.pushType isEqualToString:@"RH"]) {
        
        self.navigationController.navigationBar.barTintColor = FSB_StyleCOLOR;
        
    }

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *str = [defaults objectForKey:@"Game_YanZheng"];
    
    NSString *fensibaoExtension = [defaults objectForKey:@"game_extension"];
    
    if ([str isEqualToString:@"0"]) {
        
        TiXingView *tixingview = [[TiXingView alloc] initWithFrame:CGRectMake(0, 0, _WindowViewWidth, _WindowViewHeight)];
        
        tixingview.iconImg.image = [UIImage imageNamed:@"yxyuan@2x.png"];
        
        [tixingview.sureBtn addTarget:self action:@selector(tongyiRequest) forControlEvents:UIControlEventTouchUpInside];
        
        [tixingview.backBtn addTarget:self action:@selector(dissClick) forControlEvents:UIControlEventTouchUpInside];
        
        fensibaoExtension = [fensibaoExtension stringByReplacingOccurrencesOfString:@"/n" withString:@"\n"];
        
        tixingview.textview.text = [NSString stringWithFormat:@"%@",fensibaoExtension];
        
        [[[UIApplication sharedApplication].windows firstObject] addSubview:tixingview];
        
    }
    
}

- (UIBarButtonItem *)SetNavigationBarRightTitle:(NSString *)title andaction:(SEL)Saction{
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addButton setFrame:CGRectMake(0, 0, 40, 40)];
    addButton.backgroundColor = [UIColor clearColor];
    [addButton setTitle:title forState:UIControlStateNormal];
    [addButton setTitleColor:[UIColor whiteColor] forState:0];
    [addButton addTarget:self action:Saction forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *_addFriendItem = [[UIBarButtonItem alloc] initWithCustomView:addButton];
    return _addFriendItem;
}

- (void)dissClick {

    [self.navigationController popViewControllerAnimated:YES];
    
    if ([self.pushType isEqualToString:@"RH"]) {
        
        self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
        
    }
    
}

//签订游戏协议
- (void)tongyiRequest {
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    
    AppHttpClient* httpClient = [AppHttpClient sharedExtension];
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"Memberid",
                           @"4",@"type",
                           @"1",@"IsAgree",
                           nil];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient ExtensionRequest:@"FistAgreement.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            
            [SVProgressHUD showSuccessWithStatus:@"欢迎加入游戏"];
            
            [self yyanZheng];
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showErrorWithStatus:msg];
            
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}

//确认同意后再次验证
- (void)yyanZheng {
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    
    AppHttpClient* httpClient = [AppHttpClient sharedExtension];
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"Memberid",
                           @"4",@"type",
                           @"0",@"IsAgree",
                           nil];
    
    [httpClient ExtensionRequest:@"FistAgreement.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            
            [defaults setObject:@"1" forKey:@"Game_YanZheng"];
            
        } else {
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            
            [defaults setObject:@"0" forKey:@"Game_YanZheng"];
            
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}

- (void)viewDismiss {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"您确定要离开此页面吗？" delegate:self cancelButtonTitle:@"我要留下" otherButtonTitles:@"确定", nil];
    
    alert.tag = 10002;
    
    [alert show];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (alertView.tag == 10001) {
        
        switch (buttonIndex) {
            case 1:
            {
                
                //前往游戏大厅
                FSB_GameViewController *vc = [[FSB_GameViewController alloc] init];
                
                FSB_GameNAVController *gameNav = [[FSB_GameNAVController alloc] initWithRootViewController:vc];
                
                [self presentViewController:gameNav animated:YES completion:nil];
                
            }
                break;
                
            default:
                break;
                
        }
        
    }else if (alertView.tag == 10002) {
        
        switch (buttonIndex) {
            case 1:
            {
                
                [self.navigationController popViewControllerAnimated:YES];
                
                if ([self.pushType isEqualToString:@"RH"]) {
                    
                    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
                    
                }
                
            }
                break;
                
            default:
                break;
                
        }
        
    }
    
}

- (UIBarButtonItem *)SetNavigationBarImage:(NSString *)aImageName andaction:(SEL)Saction{
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addButton setFrame:CGRectMake(-5, 0, 30, 30)];
    addButton.backgroundColor = [UIColor clearColor];
    [addButton setImage:[UIImage imageNamed:aImageName] forState:UIControlStateNormal];
    [addButton addTarget:self action:Saction forControlEvents:UIControlEventTouchUpInside];
    
    addButton.layer.masksToBounds = YES;
    
    addButton.layer.cornerRadius = addButton.frame.size.width * 0.5;
    UIBarButtonItem *_addFriendItem = [[UIBarButtonItem alloc] initWithCustomView:addButton];
    return _addFriendItem;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
