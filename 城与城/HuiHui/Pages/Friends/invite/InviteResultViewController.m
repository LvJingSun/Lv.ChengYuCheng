//
//  InviteResultViewController.m
//  baozhifu
//
//  Created by mac on 13-7-23.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "InviteResultViewController.h"
#import "SVProgressHUD.h"

@interface InviteResultViewController ()

@property (weak, nonatomic) IBOutlet UILabel *labMessage;

@property (weak, nonatomic) IBOutlet UIView *m_titleView;

@property (weak, nonatomic) IBOutlet UIView *m_tempView;

-(IBAction)sendMsg:(id)sender;

-(IBAction)copyMsg:(id)sender;
// 返回按钮触发的事件
- (IBAction)goBack:(id)sender;

// 分享按钮触发的事件
- (IBAction)shareClicked:(id)sender;

@end

@implementation InviteResultViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setTitle:@"邀请结果"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    self.labMessage.text = self.message;
   
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

- (IBAction)sendMsg:(id)sender {
    
    if ([MFMessageComposeViewController canSendText]) {
        MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc] init];
        picker.messageComposeDelegate = self;
        picker.body = self.message;
        picker.recipients = [NSArray arrayWithObject:self.phone];
        [self presentViewController:picker animated:YES completion:nil];
        
    } else {
        
        [SVProgressHUD showErrorWithStatus:@"该设备不支持短信功能"];
    }

}

-(IBAction)copyMsg:(id)sender {
    
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.message;
    [SVProgressHUD showSuccessWithStatus:@"内容已经复制到粘贴板"];
}

- (IBAction)goBack:(id)sender {
    
    if ( [self.m_type isEqualToString:@"2"] ) {
        // 返回好友列表
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count - 3] animated:YES];
    }else{
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

- (IBAction)shareClicked:(id)sender {
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"分享"
                                                            delegate:self
                                                   cancelButtonTitle:@"取消"
                                              destructiveButtonTitle:nil
                                                   otherButtonTitles:@"发短信",@"发给微信好友",@"发给QQ好友", nil];
    
    // 解决sheetAction不能点击的问题
    [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
    
}

-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    
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
// 检查是否安装了QQ的客户端
-(BOOL)checkIsVaildQQType
{
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

// 检查是否安装了微信的客户端
-(void)checkIsVaildweixinType
{
    if( [WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi] ){ //判断是否安装且支持微信
        //安装了微信
        [self shareTogoodFriend];
        
    }else{
        
        //未安装
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示"
                                                        message:@"您尚未安装微信,确认进行安装吗？"
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                              otherButtonTitles:@"确定",nil];
        alert.tag = 100100;
        [alert show];
        
        
    }
    
}

//发送给好友
-(void)shareTogoodFriend
{
    /*    WXMediaMessage *message = [WXMediaMessage message];//发送消息的多媒体内容
     message.title = shareMessage;
     message.description = shareMessage;
     
     UIImage *imageS = [UIImage imageWithContentsOfFile:[self GetImageFromLocal]];
     
     [message setThumbImage:imageS];
     
     WXWebpageObject *ext = [WXWebpageObject object];
     ext.webpageUrl = @"http://wap.kfc.com.cn";
     message.mediaObject = ext;
     SendMessageToWXReq* req = [[[SendMessageToWXReq alloc] init]autorelease];
     req.bText = NO;//发送消息的类型，包括文本消息和多媒体消息两种，两者只能选择其一，不能同时发送文本和多媒体消息
     req.message = message;
     req.scene = WXSceneSession;//选择发送好友
     [WXApi sendReq:req];*/
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = YES;
    req.text = [NSString stringWithFormat:@"%@",self.labMessage.text];
    req.scene = WXSceneSession;
    
    [WXApi sendReq:req];
}

#pragma mark UIActionSheetDelegate Method
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
        
    if ( buttonIndex == 0 )
    {
        // 发短信
        [self sendMsg:nil];
        
    }else if ( buttonIndex == 1 ){
        
        // 微信分享
        [self checkIsVaildweixinType];
        
    }else if ( buttonIndex == 2 ) {
        //检测是否安装QQ
        if (![self checkIsVaildQQType]) {
            return;
        }
        // 初始化
        tencentOAuth = [[TencentOAuth alloc]initWithAppId:TencentQzoneAppId andDelegate:self];
        
        // 发送给QQ好友
        QQApiTextObject *txtObj = [QQApiTextObject objectWithText:self.labMessage.text ? : @""];
        ////        [txtObj setCflag:[self shareControlFlags]];
        SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:txtObj];
        QQApiSendResultCode sent = 0;
        //分享到QQ
        sent = [QQApiInterface sendReq:req];
        // 判断QQ的情况
        [self handleSendResult:sent];
        
    }
    
}

- (void)handleSendResult:(QQApiSendResultCode)sendResult
{
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

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if ( alertView.tag == 100100 ) {
        if ( buttonIndex == 1 ) {
            // 跳转到下载微信的地址
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[WXApi getWXAppInstallUrl]]];
        }else{
            
        }
    }else{
        
        
    }
  
}

@end
