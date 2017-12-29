//
//  HL_RecommendViewController.m
//  HuiHui
//
//  Created by mac on 2017/12/25.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "HL_RecommendViewController.h"
#import "LJConst.h"
#import "HL_RecommendModel.h"
#import "HL_RecommendFrame.h"
#import "HL_RecommendCell.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import <QuartzCore/QuartzCore.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <MessageUI/MessageUI.h>

@interface HL_RecommendViewController ()<UITableViewDelegate,UITableViewDataSource,QQApiInterfaceDelegate,TencentSessionDelegate,MFMessageComposeViewControllerDelegate> {
    
    TencentOAuth *tencentOAuth;
    
}

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation HL_RecommendViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    [self setTitle:@"推荐代理"];
    
    self.view.backgroundColor = [UIColor colorWithRed:154/255. green:207/255. blue:233/255. alpha:1.];
    
    [self allocWithTableview];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    [self requestForTuiJian];
    
}

- (void)requestForTuiJian {
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         [CommonUtil getValueByKey:MEMBER_ID],@"memberid",
                         [CommonUtil getServerKey],@"Key",
                         nil];
    
    AppHttpClient *http = [AppHttpClient sharedHuLa];
    
    [http HuLarequest:@"GetUrlLink.ashx" parameters:dic success:^(NSJSONSerialization *json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            NSDictionary *dd = [json valueForKey:@"inviteCode"];
            
            HL_RecommendModel *model = [[HL_RecommendModel alloc] init];
            
            model.urlImg = [NSString stringWithFormat:@"%@",dd[@"QrCodeUrl"]];
            
            model.MemberInviteCode = [NSString stringWithFormat:@"%@",dd[@"MemberInviteCode"]];
            
            model.mail = [NSString stringWithFormat:@"%@",dd[@"DuanXin"]];
            
            HL_RecommendFrame *frame = [[HL_RecommendFrame alloc] init];
            
            frame.model = model;
            
            NSMutableArray *mut = [NSMutableArray array];
            
            [mut addObject:frame];
            
            self.dataArray = mut;
            
            [self.tableview reloadData];
            
        }else {
            
            [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"%@",[json valueForKey:@"msg"]]];
            
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}

- (void)allocWithTableview {
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, _WindowViewWidth, _WindowViewHeight - 64)];
    
    self.tableview = tableview;
    
    tableview.delegate = self;
    
    tableview.dataSource = self;
    
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    tableview.backgroundColor = [UIColor colorWithRed:154/255. green:207/255. blue:233/255. alpha:1.];
    
    [self.view addSubview:tableview];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HL_RecommendFrame *frame = self.dataArray[indexPath.row];
    
    HL_RecommendCell *cell = [[HL_RecommendCell alloc] init];
    
    cell.frameModel = frame;
    
    cell.QQBlock = ^{
        
        [self qqShare];
        
    };
    
    cell.QZoneBlock = ^{
        
        [self qqzoneShare];
        
    };
    
    cell.WXBlock = ^{
        
        // 微信分享
        [self checkIsVaildweixinType:1002];
        
    };
    
    cell.CircleBlock = ^{
        
        // 朋友圈分享
        [self checkIsVaildweixinType:1003];
        
    };
    
    cell.MessageBlock = ^{
        
        //发短信
        MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc] init];
        
        picker.messageComposeDelegate = self;
        
        picker.body = [NSString stringWithFormat:@"%@",frame.model.mail];
        
        picker.recipients = [NSArray arrayWithObject:@" "];
        
        [self presentViewController:picker animated:YES completion:nil];
        
    };
    
    cell.CopyBlock = ^{
        
        //复制二维码
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        
        pasteboard.string = [NSString stringWithFormat:@"%@",frame.model.MemberInviteCode];
        
        [SVProgressHUD showSuccessWithStatus:@"内容已经复制到粘贴板"];
        
    };
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HL_RecommendFrame *frame = self.dataArray[indexPath.row];
    
    return frame.height;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (void)leftClicked {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

//qq分享
- (void)qqShare {
    
    //检测是否安装QQ
    if (![self checkIsVaildQQType]) {
        return;
    }
    
    HL_RecommendFrame *frame = self.dataArray[0];
    
    // qq好友
    tencentOAuth = [[TencentOAuth alloc]initWithAppId:TencentQzoneAppId andDelegate:self];
    NSString *title = @"虎啦游戏邀请";
    NSString *description = @"虎啦游戏代理诚邀您加入他的团队，点击链接即可加入";
    
    NSString *utf8String = frame.model.MemberInviteCode;
    
    QQApiNewsObject *newsObj = [QQApiNewsObject objectWithURL:[NSURL URLWithString:utf8String] title:title description:description previewImageURL:[NSURL URLWithString:frame.model.urlImg]];
    
    
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:newsObj];
    //将内容分享到qq
    QQApiSendResultCode sent = 0;
    sent = [QQApiInterface sendReq:req];
    // 判断QQ的情况
    [self handleSendResult:sent];
    
}

//qq空间分享
- (void)qqzoneShare {
    
    //检测是否安装QQ
    if (![self checkIsVaildQQType]) {
        return;
    }
    // QQ空间分享
    tencentOAuth = [[TencentOAuth alloc]initWithAppId:TencentQzoneAppId andDelegate:self];
    
    NSString *title = @"虎啦游戏邀请";
    NSString *description = @"虎啦游戏代理诚邀您加入他的团队，点击链接即可加入";
    
    HL_RecommendFrame *frame = self.dataArray[0];
    
    NSString *utf8String = frame.model.MemberInviteCode;
    
    QQApiNewsObject *newsObj = [QQApiNewsObject objectWithURL:[NSURL URLWithString:utf8String] title:title description:description previewImageURL:[NSURL URLWithString:frame.model.urlImg]];
    
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:newsObj];
    //将内容分享到qq
    QQApiSendResultCode sent = 0;
    
    //将内容分享到qzone
    sent = [QQApiInterface SendReqToQZone:req];
    
    // 判断QQ的情况
    [self handleSendResult:sent];
    
}

// 检查是否安装了QQ的客户端
-(BOOL)checkIsVaildQQType {
    
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
-(void)shareTogoodFriend {
    
    WXMediaMessage *message = [WXMediaMessage message];//发送消息的多媒体内容
    
    message.title = @"虎啦游戏邀请";
    message.description = @"虎啦游戏代理诚邀您加入他的团队，点击链接即可加入";
    
    HL_RecommendFrame *frame = self.dataArray[0];
    
    NSString *imagePath = [NSString stringWithFormat:@"%@",frame.model.urlImg];
    
    UIImageView *imgV = [[UIImageView alloc]init];
    
    [imgV setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:imagePath]]
                placeholderImage:[UIImage imageNamed:@""]
                         success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                             imgV.image = [CommonUtil scaleImage:image toSize:CGSizeMake(60, 60)];
                             
                             // 微信进行赋值
                             [message setThumbImage:imgV.image];
                             
                             WXWebpageObject *ext = [WXWebpageObject object];
                             ext.webpageUrl = [NSString stringWithFormat:@"%@",frame.model.MemberInviteCode];
                             message.mediaObject = ext;
                             SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
                             req.bText = NO;//发送消息的类型，包括文本消息和多媒体消息两种，两者只能选择其一，不能同时发送文本和多媒体消息
                             req.message = message;
                             req.scene = WXSceneSession;//选择发送好友
                             [WXApi sendReq:req];
                             
                         }
                         failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                             
                         }];
    
}

// 朋友圈
-(void)shareTogoodFriendShipsWithMessage {
    
    WXMediaMessage *message = [WXMediaMessage message];//发送消息的多媒体内容
    message.title = @"虎啦游戏邀请";
    message.description = @"虎啦游戏代理诚邀您加入他的团队，点击链接即可加入";
    
    HL_RecommendFrame *frame = self.dataArray[0];
    
    
    NSString *imagePath = [NSString stringWithFormat:@"%@",frame.model.urlImg];
    
    UIImageView *imgV = [[UIImageView alloc]init];
    
    [imgV setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:imagePath]]
                placeholderImage:[UIImage imageNamed:@""]
                         success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                             imgV.image = [CommonUtil scaleImage:image toSize:CGSizeMake(60, 60)];
                             
                             // 微信进行赋值
                             [message setThumbImage:imgV.image];
                             
                             WXWebpageObject *ext = [WXWebpageObject object];
                             
                             ext.webpageUrl = [NSString stringWithFormat:@"%@",frame.model.MemberInviteCode];
                             message.mediaObject = ext;
                             
                             SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
                             req.bText = NO;//发送消息的类型，包括文本消息和多媒体消息两种，两者只能选择其一，不能同时发送文本和多媒体消息
                             req.message = message;
                             req.scene = WXSceneTimeline;//发送到朋友圈
                             
                             [WXApi sendReq:req];
                         }
                         failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                             
                         }];
    
}

//短信发送完成代理
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
