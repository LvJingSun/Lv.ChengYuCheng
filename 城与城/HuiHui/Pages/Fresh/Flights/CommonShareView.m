//
//  CommonShareView.m
//  HuiHui
//
//  Created by mac on 15-5-14.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "CommonShareView.h"

#import "SharetoHuiHuiViewController.h"

#import "Sharetofriend.h"

@implementation CommonShareView

@synthesize delegate;

@synthesize m_subTitle;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        // 初始化view
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(20, 85, 280, 260)];
        view.backgroundColor = [UIColor blackColor];
        
        // 初始化按钮和label
        // QQ好友分享
        UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn1.frame = CGRectMake(18, 10, 57, 59);
        btn1.backgroundColor = [UIColor clearColor];
        [btn1 setBackgroundImage:[UIImage imageNamed:@"qq.png"] forState:UIControlStateNormal];
        btn1.tag = 1000;
        [btn1 addTarget:self action:@selector(sharingClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        [view addSubview:btn1];
        
        
        UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(12, 70, 68, 21)];
        label1.font = [UIFont systemFontOfSize:13.0f];
        label1.backgroundColor = [UIColor clearColor];
        label1.text = @"QQ好友";
        label1.textColor = [UIColor whiteColor];
        label1.textAlignment = NSTextAlignmentCenter;
        [view addSubview:label1];
        
        // QQ空间分享
        UIButton *btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn4.frame = CGRectMake(18, 99, 57, 59);
        btn4.backgroundColor = [UIColor clearColor];
        [btn4 setBackgroundImage:[UIImage imageNamed:@"zoon.png"] forState:UIControlStateNormal];
        btn4.tag = 1001;
        [btn4 addTarget:self action:@selector(sharingClicked:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btn4];
        
        
        UILabel *label4 = [[UILabel alloc]initWithFrame:CGRectMake(12, 159, 68, 21)];
        label4.font = [UIFont systemFontOfSize:13.0f];
        label4.backgroundColor = [UIColor clearColor];
        label4.text = @"QQ空间";
        label4.textColor = [UIColor whiteColor];
        label4.textAlignment = NSTextAlignmentCenter;
        [view addSubview:label4];
        
        
        // 微信好友
        UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn2.frame = CGRectMake(112, 10, 57, 59);
        btn2.backgroundColor = [UIColor clearColor];
        [btn2 setBackgroundImage:[UIImage imageNamed:@"weixin.png"] forState:UIControlStateNormal];
        btn2.tag = 1002;
        [btn2 addTarget:self action:@selector(sharingClicked:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btn2];
        
        
        UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(106, 70, 68, 21)];
        label2.font = [UIFont systemFontOfSize:13.0f];
        label2.backgroundColor = [UIColor clearColor];
        label2.text = @"微信好友";
        label2.textColor = [UIColor whiteColor];
        label2.textAlignment = NSTextAlignmentCenter;
        [view addSubview:label2];
        
        
        // 微信朋友圈
        UIButton *btn5 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn5.frame = CGRectMake(112, 99, 57, 59);
        btn5.backgroundColor = [UIColor clearColor];
        [btn5 setBackgroundImage:[UIImage imageNamed:@"friend.png"] forState:UIControlStateNormal];
        btn5.tag = 1003;
        [btn5 addTarget:self action:@selector(sharingClicked:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btn5];
        
        
        UILabel *label5 = [[UILabel alloc]initWithFrame:CGRectMake(106, 159, 68, 21)];
        label5.font = [UIFont systemFontOfSize:13.0f];
        label5.backgroundColor = [UIColor clearColor];
        label5.text = @"微信朋友圈";
        label5.textColor = [UIColor whiteColor];
        label5.textAlignment = NSTextAlignmentCenter;
        [view addSubview:label5];
        
        
        // 城与城好友
        UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn3.frame = CGRectMake(201, 10, 57, 59);
        btn3.backgroundColor = [UIColor clearColor];
        [btn3 setBackgroundImage:[UIImage imageNamed:@"icon.png"] forState:UIControlStateNormal];
        btn3.tag = 1004;
        [btn3 addTarget:self action:@selector(sharingClicked:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btn3];
        
        
        UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(195, 70, 68, 21)];
        label3.font = [UIFont systemFontOfSize:13.0f];
        label3.backgroundColor = [UIColor clearColor];
        label3.text = @"城与城好友";
        label3.textAlignment = NSTextAlignmentCenter;
        label3.textColor = [UIColor whiteColor];
        [view addSubview:label3];

        // 城与城朋友圈
        UIButton *btn6 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn6.frame = CGRectMake(201, 99, 57, 59);
        btn6.backgroundColor = [UIColor whiteColor];
        [btn6 setBackgroundImage:[UIImage imageNamed:@"f1.png"] forState:UIControlStateNormal];
        btn6.tag = 1005;
        [btn6 addTarget:self action:@selector(sharingClicked:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btn6];
        
        
        UILabel *label6 = [[UILabel alloc]initWithFrame:CGRectMake(187, 159, 85, 21)];
        label6.font = [UIFont systemFontOfSize:13.0f];
        label6.backgroundColor = [UIColor clearColor];
        label6.text = @"城与城朋友圈";
        label6.textColor = [UIColor whiteColor];
        label6.textAlignment = NSTextAlignmentCenter;
        [view addSubview:label6];
        
        
        // 取消按钮
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelBtn.frame = CGRectMake(10, 195, 260, 35);
        cancelBtn.backgroundColor = [UIColor clearColor];
        cancelBtn.tag = 1000;
        [cancelBtn addTarget:self action:@selector(cancelShare:) forControlEvents:UIControlEventTouchUpInside];
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBtn setBackgroundImage:[UIImage imageNamed:@"blue_btn.png"] forState:UIControlStateNormal];
        [view addSubview:cancelBtn];
        
        [self addSubview:view];
        
        view.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2 - 40);
        
    }
    
    return self;
}

- (id)init{
    
    self = [super init];
    
    if ( self ) {
    }
    
    return self;
    
}

// 跳转时带来的分享的链接和标题
- (void)getSharingUrl:(NSString *)aUrl withTitle:(NSString *)aTitle withSubTitle:(NSString *)aSubTitle{

    self.m_titleString = [NSString stringWithFormat:@"%@",aTitle];
    
    self.m_shareString = [NSString stringWithFormat:@"%@",aUrl];
    
    self.m_subTitle = [NSString stringWithFormat:@"%@",aSubTitle];
    
}

- (void)sharingClicked:(id)sender{
    
    UIButton *btn = (UIButton *)sender;
    
    if ( btn.tag == 1000 ) {
        //检测是否安装QQ
        if (![self checkIsVaildQQType]) {
            return;
        }
        // qq好友
        tencentOAuth = [[TencentOAuth alloc]initWithAppId:TencentQzoneAppId andDelegate:self];
        
        //        http://wx.cityandcity.com/commodity_detail.aspx?svcid=101&mctid=63
        
        NSString *utf8String = [NSString stringWithFormat:@"%@",self.m_shareString];
        
        NSString *title = [NSString stringWithFormat:@"%@",self.m_titleString];
        NSString *description = [NSString stringWithFormat:@"%@",self.m_subTitle];
        
        QQApiNewsObject *newsObj;
        
        newsObj = [QQApiNewsObject objectWithURL:[NSURL URLWithString:utf8String] title:title description:description previewImageURL:[NSURL URLWithString:@"http://www.cityandcity.com/Resource/Attached/common/lianjie.png"]];

        SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:newsObj];
        //将内容分享到qq
        QQApiSendResultCode sent = 0;
        sent = [QQApiInterface sendReq:req];
        // 判断QQ的情况
        [self handleSendResult:sent];
        
        
    }else if ( btn.tag == 1001 ) {
        //检测是否安装QQ
        if (![self checkIsVaildQQType]) {
            return;
        }
        // QQ空间分享
        tencentOAuth = [[TencentOAuth alloc]initWithAppId:TencentQzoneAppId andDelegate:self];
        
        NSString *utf8String = [NSString stringWithFormat:@"%@",self.m_shareString];
        
        NSString *title = [NSString stringWithFormat:@"%@",self.m_titleString];
        NSString *description = [NSString stringWithFormat:@"%@",self.m_subTitle];
        
        QQApiNewsObject *newsObj;
        
        newsObj = [QQApiNewsObject objectWithURL:[NSURL URLWithString:utf8String] title:title description:description previewImageURL:[NSURL URLWithString:@"http://www.cityandcity.com/Resource/Attached/common/lianjie.png"]];

        SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:newsObj];
        //将内容分享到qq
        QQApiSendResultCode sent = 0;
        
        //将内容分享到qzone
        sent = [QQApiInterface SendReqToQZone:req];
        
        // 判断QQ的情况
        [self handleSendResult:sent];
        
        
    }else if ( btn.tag == 1002 ) {
        
        // 微信分享
        [self checkIsVaildweixinType:1002];
        
    }else if ( btn.tag == 1003 ) {
        
        // 朋友圈分享
        [self checkIsVaildweixinType:1003];
        
    }else if ( btn.tag == 1004 ){
        //诲诲好友
        if ( delegate && [delegate respondsToSelector:@selector(getShare:)] ) {
            
            [delegate performSelector:@selector(getShare:) withObject:@"1"];
            
        }
        
        
    }else if ( btn.tag == 1005 ){
        //诲诲朋友圈
        if ( delegate && [delegate respondsToSelector:@selector(getShare:)] ) {
            
            [delegate performSelector:@selector(getShare:) withObject:@"2"];
            
        }
        

    }
    
    
    [self removeFromSuperview];

    
    
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
-(void)checkIsVaildweixinType:(NSInteger)aType
{
    if( [WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi] ){ //判断是否安装且支持微信
        if ( aType == 1002 ) {
            
            // 好友
            [self shareTogoodFriend];
            
        }else if ( aType == 1003 ) {
            
            // 朋友圈
            [self shareTogoodFriendShipsWithMessage];
            
        }else{
            
            
        }
        
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
    
    WXMediaMessage *message = [WXMediaMessage message];//发送消息的多媒体内容
    message.title = [NSString stringWithFormat:@"%@", self.m_titleString];
    message.description = [NSString stringWithFormat:@"%@",self.m_subTitle];
    
    // 微信进行赋值
    
//    if (_downloadImages.count==0) {
        [message setThumbImage:[UIImage imageNamed:@"lianjie.png"]];
//    }else{
//        [message setThumbImage:[_downloadImages objectAtIndex:0]];
//    }
    
    
    WXWebpageObject *ext = [WXWebpageObject object];
    ext.webpageUrl = [NSString stringWithFormat:@"%@",self.m_shareString];
    message.mediaObject = ext;
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;//发送消息的类型，包括文本消息和多媒体消息两种，两者只能选择其一，不能同时发送文本和多媒体消息
    req.message = message;
    req.scene = WXSceneSession;//选择发送好友
    [WXApi sendReq:req];
    
}

// 朋友圈
-(void)shareTogoodFriendShipsWithMessage {
    
    WXMediaMessage *message = [WXMediaMessage message];//发送消息的多媒体内容
//    message.title = @"分享";
    message.title = [NSString stringWithFormat:@"%@",self.m_subTitle];
    message.description = [NSString stringWithFormat:@"%@",self.m_subTitle];
    
    NSLog(@"title = %@,des = %@",message.title,message.description);
    
    // 微信进行赋值
//    if (_downloadImages.count==0) {
        [message setThumbImage:[UIImage imageNamed:@"lianjie.png"]];
//    }else{
//        [message setThumbImage:[_downloadImages objectAtIndex:0]];
//    }
    WXWebpageObject *ext = [WXWebpageObject object];
    ext.webpageUrl = [NSString stringWithFormat:@"%@",self.m_shareString];
    message.mediaObject = ext;
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;//发送消息的类型，包括文本消息和多媒体消息两种，两者只能选择其一，不能同时发送文本和多媒体消息
    req.message = message;
    req.scene = WXSceneTimeline;//发送到朋友圈
    
    [WXApi sendReq:req];
    
}


- (void)cancelShare:(id)sender {
    
    [self removeFromSuperview];
    
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
{
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
