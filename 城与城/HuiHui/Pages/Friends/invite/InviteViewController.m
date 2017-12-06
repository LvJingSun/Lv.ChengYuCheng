//
//  InviteViewController.m
//  baozhifu
//
//  Created by mac on 13-7-22.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "InviteViewController.h"
#import "InviteResultViewController.h"
#import "SVProgressHUD.h"
#import "CommonUtil.h"
//#import "AppHttpClient.h"
#import "QRCodeGenerator.h"
#import "UIImageView+AFNetworking.h"
#import "ModifyCodeViewController.h"


@interface InviteViewController ()

@property (weak, nonatomic) IBOutlet UITextField *name;

@property (weak, nonatomic) IBOutlet UITextField *sex;

@property (weak, nonatomic) IBOutlet UITextField *phone;

@property (weak, nonatomic) IBOutlet UIScrollView *m_scrollerView;

@property (weak, nonatomic) IBOutlet UIView *m_titleView;

//@property (weak, nonatomic) IBOutlet UIView *m_phoneView;

@property (weak, nonatomic) IBOutlet UIView *m_codeView;

//@property (weak, nonatomic) IBOutlet UILabel *m_tipLabel;

@property (weak, nonatomic) IBOutlet UIImageView *m_codeImgV;

@property (strong, nonatomic) IBOutlet UIView *m_showView;

@property (weak, nonatomic) IBOutlet UILabel *m_statusLabel;
// 分享按钮
@property (weak, nonatomic) IBOutlet UIButton *m_shareBtn;
// 复制按钮
@property (weak, nonatomic) IBOutlet UIButton *m_copyBtn;
// 发短信的按钮
@property (weak, nonatomic) IBOutlet UIButton *m_messageBtn;


- (IBAction)submit:(id)sender;

- (IBAction)selectSex:(id)sender;

- (IBAction)selectPhone:(id)sender;

- (IBAction)showRole:(id)sender;
// 分享公众邀请码
- (IBAction)shareCodeImageV:(id)sender;
// 分享
- (IBAction)shareBtnClicked:(id)sender;
// 取消分享
- (IBAction)cancelShare:(id)sender;
// 复制按钮触发的事件
- (IBAction)copyBtnClicked:(id)sender;
// 发送短信给好友
- (IBAction)sendToFriends:(id)sender;

@end

@implementation InviteViewController

@synthesize m_dic;
@synthesize isLeavePage;
@synthesize m_phoneString;
@synthesize m_values;
@synthesize m_Funtions;
@synthesize m_keyTimes;
@synthesize m_itemsDic;
@synthesize m_stringStatus;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        m_dic = [[NSDictionary alloc]init];
        
        m_values = [[NSArray alloc]init];
        
        m_Funtions = [[NSArray alloc]init];
        
        m_keyTimes = [[NSArray alloc]init];
        
        self.isLeavePage = NO;
        
        m_itemsDic = [[NSMutableDictionary alloc]init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setTitle:@"邀请好友"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
//    [self setRightButtonWithNormalImage:@"xxqd.png" withTitle:@"通讯录" action:@selector(ChooseFromLocation)];

    
    [self.name setDelegate:self];
    [self.sex setDelegate:self];
    [self.phone setDelegate:self];
    
    if ( [self.stringType isEqualToString:@"1"] ) {
        
        // 重新邀请
        self.phone.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"InvitePhone"]];
        
        self.sex.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"InviteSex"]];
        
        self.name.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"InviteName"]];
    
    }else if ( [self.stringType isEqualToString:@"2"] ){
        
        NSString *string = [self.m_dic objectForKey:@"Phone"];
        
        if ( string.length != 0 ) {
            
            string = [string stringByReplacingOccurrencesOfString:@"-" withString:@""];
            string = [string stringByReplacingOccurrencesOfString:@"+86" withString:@""];
            
        }
        
        // 邀请好友
        self.phone.text = [NSString stringWithFormat:@"%@",string];

        self.sex.text = @"";
        
        self.name.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"NickName"]];
        
    }else if ( [self.stringType isEqualToString:@"3"] ){
        
        // 从搜索好友的页面
        self.phone.text = self.m_phoneString;
        
        self.sex.text = @"";
        
        self.name.text = @"";
        
    }else{
      
        // 邀请好友
        self.phone.text = @"";
        
        self.sex.text = @"";
        
        self.name.text = @"";
        
    }
    
    // 请求数据来判断用户是否是公众邀请码，如果是则显示两种邀请方式，如果不是则显示一种邀请方式
    [self requestValidateCode];
    
    // 初始化三个用于动画的数组
    NSArray *array = [[NSArray alloc]initWithObjects:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f, 0.01f, 1.0f)],[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.0f)],[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9f, 0.9f, 1.0f)],[NSValue valueWithCATransform3D:CATransform3DIdentity], nil];
    
    NSArray *keyTimes = [[NSArray alloc]initWithObjects:@"0.2f",@"0.5f", @"0.75f", @"1.0f", nil];
    
    NSArray *funtions = [[NSArray alloc]initWithObjects:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                         [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                         [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut], nil];
    
    self.m_values = array;
    
    self.m_keyTimes = keyTimes;
    
    self.m_Funtions = funtions;
    
    
    // 设置分享view的中心位置
    self.m_showView.center = self.view.center;

    
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

- (void)leftClicked{
    
    [self goBack];
}

// 从通讯录里面获取联系人
- (void)ChooseFromLocation{
    
    // 将分享的view先移除
    [self.m_showView removeFromSuperview];
    
    self.isLeavePage = YES;

    ABPeoplePickerNavigationController *picker = [[ABPeoplePickerNavigationController alloc] init];
    picker.peoplePickerDelegate = self;
    [self presentViewController:picker animated:YES completion:nil];
    
}

- (IBAction)submit:(id)sender {
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    NSString *name = self.name.text;
    if (name.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入姓名"];
        return;
    }
    
    NSString *sex = self.sex.text;
   
    if (sex.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择性别"];
        return;
  
    } else {
        
        if ([@"男" isEqualToString:sex]) {
            sex = @"Male";
        } else if ([@"女" isEqualToString:sex]) {
            sex = @"Female";
        }
    }
    
    NSString *phone = self.phone.text;
    if ( phone.length == 0 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请输入手机号码！"];
        
        return;
    }
    
    if ( phone.length != 11 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请输入11位手机号码"];
        
        return;
    }
    
//    if ( ![self isMobileNumber:phone] ) {
//        
//        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号码格式"];
//        
//        return;
//        
//    }
    
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,     @"memberId",
                           key,   @"key",
                           name,  @"name",
                           sex,   @"sex",
                           phone, @"phone",
                           nil];
    [SVProgressHUD showWithStatus:@"信息提交中"];
    [httpClient request:@"MemberInvite.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD dismiss];
            
            // 当是从通讯录页面进来时，将此数据设置为2，用于返回后重新请求数据
            if ( Appdelegate.isTongxunlu ) {

                Appdelegate.isTongxunlu = NO;
                
                [CommonUtil addValue:@"2" andKey:kMyContact];
                
            }
            
            // 存储邀请好友的状态用于请求数据刷新            
            [CommonUtil addValue:@"1" andKey:kInviteFriendsKey];

            
            InviteResultViewController *viewController = [[InviteResultViewController alloc] initWithNibName:@"InviteResultViewController" bundle:nil];
            viewController.message = msg;
            viewController.phone = phone;
            viewController.m_type = @"2";
            [self.navigationController pushViewController:viewController animated:YES];
            
        } else {
            
            // 当是从通讯录页面进来时，将此数据设置为2，用于返回后重新请求数据
            if ( Appdelegate.isTongxunlu ) {
                
                Appdelegate.isTongxunlu = NO;
                                
                [CommonUtil addValue:@"2" andKey:kMyContact];
                
            }
            
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
    } failure:^(NSError *error) {
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];
}

-(IBAction)selectSex:(id)sender {
    [self.name resignFirstResponder];
    [self.phone resignFirstResponder];
    UIActionSheet *chooseImageSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                                  delegate:self
                                                         cancelButtonTitle:@"取消"
                                                    destructiveButtonTitle:nil
                                                         otherButtonTitles:@"男",@"女", nil];
    // 解决sheetAction不能点击的问题
    [chooseImageSheet showInView:[UIApplication sharedApplication].keyWindow];
    
}

-(IBAction)selectPhone:(id)sender {
    
    ABPeoplePickerNavigationController *picker = [[ABPeoplePickerNavigationController alloc] init];
    picker.peoplePickerDelegate = self;
    [self presentViewController:picker animated:YES completion:nil];
}

#pragma mark UIActionSheetDelegate Method
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            self.sex.text = @"男";
            
            [self resumeView];
            break;
            
        case 1:
            self.sex.text = @"女";
            
            [self resumeView];

            break;
        case 2:
            
            [self resumeView];
            
            break;
            
        default:
            break;
    }
}

#pragma mark ABPeoplePickerNavigationControllerDelegate Method
- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker {

    [peoplePicker dismissViewControllerAnimated:YES completion:nil];
}

- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController*)peoplePicker didSelectPerson:(ABRecordRef)person NS_AVAILABLE_IOS(8_0);
{
    [self peoplePickerNavigationController:peoplePicker shouldContinueAfterSelectingPerson:person];
}

- (BOOL)peoplePickerNavigationController: (ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person {
    
    NSString *personName = @"";
    //读取lastname
    NSString *lastname = (NSString*)CFBridgingRelease(ABRecordCopyValue(person, kABPersonLastNameProperty));
    if(lastname != nil)
        personName = [personName stringByAppendingFormat:@"%@",lastname];

    //读取middlename
    NSString *middlename = (NSString*)CFBridgingRelease(ABRecordCopyValue(person, kABPersonMiddleNameProperty));
    if(middlename != nil)
        personName = [personName stringByAppendingFormat:@"%@",middlename];
    
    //读取firstname
    NSString *firstname = (NSString*)CFBridgingRelease(ABRecordCopyValue(person, kABPersonFirstNameProperty));
    
    if(personName != nil){
        
        if ( firstname.length != 0 ) {
            personName = [personName stringByAppendingFormat:@"%@",firstname];

        }
    }
    self.name.text = personName;
        
    //获取联系人电话
    ABMutableMultiValueRef phoneMulti = ABRecordCopyValue(person, kABPersonPhoneProperty);
    NSMutableArray *phones = [[NSMutableArray alloc] init];
    
    
    for (int i = 0; i < ABMultiValueGetCount(phoneMulti); i++) {
        NSString *aPhone = (NSString*)CFBridgingRelease(ABMultiValueCopyValueAtIndex(phoneMulti, i));
        NSString *aLabel = (NSString*)CFBridgingRelease(ABMultiValueCopyLabelAtIndex(phoneMulti, i));
        
        if([aLabel isEqualToString:@"_$!<Mobile>!$_"]) {
            
            if ( aPhone.length != 0 ) {
                
                [phones addObject:aPhone];
                
            }
        }else if ( [aLabel isEqualToString:@"_$!<Home>!$_"] ){
            if ( aPhone.length != 0 ) {
                
                [phones addObject:aPhone];

            }
            
        }else if ( [aLabel isEqualToString:@"iPhone"] ){
            if ( aPhone.length != 0 ) {
                
                [phones addObject:aPhone];
                
            }
            
        }else if ( [aLabel isEqualToString:@"_$!<Work>!$_"] ){
            if ( aPhone.length != 0 ) {
                
                [phones addObject:aPhone];
                
            }
            
        }
        
    }
    
    if([phones count]>0) {
        
        
        for (int i = 0; i < phones.count; i ++) {
            
            NSString *mobileNo = [phones objectAtIndex:i];
            
            if (mobileNo != nil) {
                mobileNo = [mobileNo stringByReplacingOccurrencesOfString:@"-" withString:@""];
                mobileNo = [mobileNo stringByReplacingOccurrencesOfString:@"+86" withString:@""];
            }
            
            // 判断是手机号的格式
            if ( mobileNo.length == 11 ) {
                
                self.phone.text = mobileNo;
                
                i = phones.count;

                
            }else{
                
                
            }
            
            
        }
        
        
//        NSString *mobileNo = [phones objectAtIndex:0];
//        if (mobileNo != nil) {
//            mobileNo = [mobileNo stringByReplacingOccurrencesOfString:@"-" withString:@""];
//            mobileNo = [mobileNo stringByReplacingOccurrencesOfString:@"+86" withString:@""];
//            self.phone.text = mobileNo;
//        }
    }
        
    [peoplePicker dismissViewControllerAnimated:YES completion:nil];
    return NO;
}

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier {
    return NO;
}

- (IBAction)showRole:(id)sender {
//    SettingDetailViewController *viewController = [[SettingDetailViewController alloc] initWithNibName:@"SettingDetailViewController" bundle:nil];
//    //viewController.title = @"推荐规划";
//    viewController.infoKey = 56;
//    [self.navigationController pushViewController:viewController animated:YES];
}

- (IBAction)shareCodeImageV:(id)sender {
    
    [self.view addSubview:self.m_showView];
    
    // 动画
    CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    popAnimation.duration = 0.4;
    popAnimation.values = self.m_values;
    popAnimation.keyTimes = self.m_keyTimes;
    popAnimation.timingFunctions = self.m_Funtions;
    
    [self.m_showView.layer addAnimation:popAnimation forKey:nil];
}


- (NSData *)getImageData:(UIImageView *)imageView {
    UIImage *iamge = imageView.image;
    return UIImageJPEGRepresentation(iamge, 1);
}

- (IBAction)shareBtnClicked:(id)sender {
    
    [self.m_showView removeFromSuperview];
    
    UIButton *btn = (UIButton *)sender;
    
    if ( btn.tag == 1000 ) {
        //检测是否安装QQ
        if (![self checkIsVaildQQType]) {
            return;
        }
        // qq好友
        tencentOAuth = [[TencentOAuth alloc]initWithAppId:TencentQzoneAppId andDelegate:self];        
        NSString *title = @"邀请好友";
        NSString *description =  @"诚邀您加入本地实名邀请制品质人脉社交分享平台。点击此公众邀请码即可在“城与城”或“城与城App”进城注册";
        
        NSString *utf8String = [self.m_itemsDic objectForKey:@"MemberInviteCode"];
        
        QQApiNewsObject *newsObj = [QQApiNewsObject objectWithURL:[NSURL URLWithString:utf8String] title:title description:description previewImageURL:[NSURL URLWithString:[self.m_itemsDic objectForKey:@"QrCodeUrl"]]];
        
        
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
      
        NSString *title = @"邀请好友";
        NSString *description = @"诚邀您加入本地实名邀请制品质人脉社交分享平台。点击此公众邀请码即可在“城与城”或“城与城App”进城注册";
    
        NSString *utf8String = [self.m_itemsDic objectForKey:@"MemberInviteCode"];
        
        QQApiNewsObject *newsObj = [QQApiNewsObject objectWithURL:[NSURL URLWithString:utf8String] title:title description:description previewImageURL:[NSURL URLWithString:[self.m_itemsDic objectForKey:@"QrCodeUrl"]]];
        
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
        
    }else{
        
        
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
    message.title = @"邀请好友";
    message.description = @"诚邀您加入本地实名邀请制品质人脉社交分享平台。点击此公众邀请码即可在“城与城”或“城与城App”进城注册";
 
    NSString *imagePath = [NSString stringWithFormat:@"%@",[self.m_itemsDic objectForKey:@"QrCodeUrl"]];
  
    UIImageView *imgV = [[UIImageView alloc]init];
    
    [imgV setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:imagePath]]
                placeholderImage:[UIImage imageNamed:@""]
                         success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                             imgV.image = [CommonUtil scaleImage:image toSize:CGSizeMake(60, 60)];
                             
                             // 微信进行赋值
                             [message setThumbImage:imgV.image];
                             
                             WXWebpageObject *ext = [WXWebpageObject object];
                             ext.webpageUrl = [NSString stringWithFormat:@"%@",[self.m_itemsDic objectForKey:@"MemberInviteCode"]];
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
    message.title = @"邀请好友";
    message.description = @"诚邀您加入本地实名邀请制品质人脉社交分享平台。点击此公众邀请码即可在“城与城”或“城与城App”进城注册";
    
    
    NSString *imagePath = [NSString stringWithFormat:@"%@",[self.m_itemsDic objectForKey:@"QrCodeUrl"]];
    
    UIImageView *imgV = [[UIImageView alloc]init];
    
    [imgV setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:imagePath]]
                placeholderImage:[UIImage imageNamed:@""]
                         success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                             imgV.image = [CommonUtil scaleImage:image toSize:CGSizeMake(60, 60)];
                             
                             // 微信进行赋值
                             [message setThumbImage:imgV.image];
                             
                             WXWebpageObject *ext = [WXWebpageObject object];
                             
                             ext.webpageUrl = [NSString stringWithFormat:@"%@",[self.m_itemsDic objectForKey:@"MemberInviteCode"]];
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


- (IBAction)cancelShare:(id)sender {
    
    [self.m_showView removeFromSuperview];

}

- (IBAction)copyBtnClicked:(id)sender {
    
    // 复制到粘贴板
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = [NSString stringWithFormat:@"%@",[self.m_itemsDic objectForKey:@"MemberInviteCode"]];
    [SVProgressHUD showSuccessWithStatus:@"内容已经复制到粘贴板"];
    
}

- (IBAction)sendToFriends:(id)sender {
    
    // 诚邀您加入本地实名邀请制品质人脉社交分享平台。点击此公众邀请码即可在“城与城”或“诲诲App”进城注册 [self.m_itemsDic objectForKey:@"MemberInviteCode"]
    

    // 发送消息给好友
    if ([MFMessageComposeViewController canSendText]) {
        
        self.isLeavePage = YES;
        
        MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc] init];
        picker.messageComposeDelegate = self;
        
        
        picker.body = [NSString stringWithFormat:@"诚邀您加入本地实名邀请制品质人脉社交分享平台。点击此链接即可在“城与城”或“城与城App”进城注册%@",[self.m_itemsDic objectForKey:@"MemberInviteCode"]];
       
        // 如果从通讯录好友进来的时候就发给指定的某个人
        if ( [self.stringType isEqualToString:@"2"] ) {
            
            picker.recipients = [NSArray arrayWithObject:[NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"Phone"]]];

        }else{
            
            picker.recipients = [NSArray arrayWithObject:@" "];

        }
        
        
        [self presentViewController:picker animated:YES completion:nil];
        
    } else {
        
        self.isLeavePage = NO;
        
        [SVProgressHUD showErrorWithStatus:@"该设备不支持短信功能"];
    }
    
}

#pragma mark - MessageDelegate
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

//隐藏键盘的方法
-(void)hidenKeyboard {
    [self.name resignFirstResponder];
    [self.sex resignFirstResponder];
    [self.phone resignFirstResponder];
//    [self resumeView];
    
     if ( [self.m_stringStatus isEqualToString:@"PublicInviteCodePassed"] ) {
         
         // 恢复到原状
         [self.m_scrollerView setContentOffset:CGPointMake(0, 0)];
         [self.m_scrollerView setContentSize:CGSizeMake(WindowSizeWidth, 600)];

         
     }
   
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)sender {
    [self hidenKeyboard];
    return YES;
}

//UITextField的协议方法，当开始编辑时监听
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    if ( textField == self.phone ) {
        
        [self showNumPadDone:nil];

    }else if ( textField == self.name ){
        
        [self hiddenNumPadDone:nil];
    }

    if ( [self.m_stringStatus isEqualToString:@"PublicInviteCodePassed"] ) {
        
        [self.m_scrollerView setContentOffset:CGPointMake(0, 200)];
        [self.m_scrollerView setContentSize:CGSizeMake(WindowSizeWidth, 800)];

        
    }
   
    return YES;
}

//恢复原始视图位置
- (void)resumeView {
//    NSTimeInterval animationDuration=0.30f;
//    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
//    [UIView setAnimationDuration:animationDuration];
//    float width = self.view.frame.size.width;
//    float height = self.view.frame.size.height + 60;
//    float Y = 0.0f;
//    CGRect rect=CGRectMake(0.0f,Y,width,height);
//    self.view.frame=rect;
//    [UIView commitAnimations];
}

// 判断登录的用户是否生成过公众邀请码的请求
- (void)requestValidateCode{
    
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
                           nil];
//    [SVProgressHUD showWithStatus:@"数据加载中"];PublicInviteIsExist.ashx
    [httpClient request:@"PublicInviteIsExist_1.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
//            [SVProgressHUD dismiss];
            
            // 审核中(PublicInviteCodePending)、已通过(PublicInviteCodePassed)、已禁用（PublicInviteCodeStopped）和已退回(PublicInviteCodeReturened)
          
            // IsDaiLi 根据该值来判断是代理还是不是代理，如果是代理的话则再判断二维码的状态，如果不是代理的话则直接进行公众邀请码的申请 1是代理  0不是代理

            // 失败原因[self.m_itemsDic objectForKey:@"ReturnDescript"]
            
            self.m_itemsDic = [json valueForKey:@"inviteCode"];
            
            self.m_stringStatus = [NSString stringWithFormat:@"%@",[self.m_itemsDic objectForKey:@"InviteCodeStatus"]];
            
            
            // 审核中(PublicInviteCodePending)、已通过(PublicInviteCodePassed)、已禁用（PublicInviteCodeStopped）和已退回(PublicInviteCodeReturened)

            //生成二维码图片
            UIImage *codeImage = [QRCodeGenerator qrImageForString:[self.m_itemsDic objectForKey:@"MemberInviteCode"] imageSize:self.m_codeImgV.frame.size.width];
            [self.m_codeImgV setImage:codeImage];
            
            // 根据是否是代理及二维码的状态来进行判断
            NSString *daili = [NSString stringWithFormat:@"%@",[self.m_itemsDic objectForKey:@"IsDaiLi"]];
            
            NSLog(@"self.m_stringStatus = %@,daili = %@",self.m_stringStatus,daili);

            
            // 是代理的情况下根据二维码的状态去判断是否可以重新申请或者申请扩容
            if ( [daili isEqualToString:@"1"] ) {

                if ( [self.m_stringStatus isEqualToString:@"PublicInviteCodePassed"] ) {

                    // 已通过
                    self.m_codeView.hidden = NO;
                    self.m_statusLabel.hidden = YES;
                    
                    // 设置scrollerView的滚动范围
                    [self.m_scrollerView setContentSize:CGSizeMake(WindowSizeWidth, WindowSize.size.height)];
                    
                    // 申请扩容或延期
                    [self setRightButtonWithTitle:@"申请扩容" action:@selector(ExpansionClicked)];
                    
                    
                }else if ( [self.m_stringStatus isEqualToString:@"PublicInviteCodePending"] ) {

                    // 审核中
                    self.m_codeView.hidden = YES;
                    self.m_statusLabel.hidden = NO;
                    self.m_statusLabel.text = @"公众邀请码还在审核中,暂不可邀请";
                    
                    self.navigationItem.rightBarButtonItem = nil;

                }else if ( [self.m_stringStatus isEqualToString:@"PublicInviteCodeStopped"] ) {
                
                    // 已禁用
                    self.m_codeView.hidden = YES;
                    self.m_statusLabel.hidden = NO;
                    self.m_statusLabel.text = [NSString stringWithFormat:@"公众邀请码已禁用,暂不可邀请\n原因:%@" ,[self.m_itemsDic objectForKey:@"ReturnDescript"]];
                    
                    
                    // 重新申请
                    [self setRightButtonWithTitle:@"重新申请" action:@selector(ReapplyClicked)];
                    
                }else if ( [self.m_stringStatus isEqualToString:@"PublicInviteCodeReturened"] ) {
                    // 已退回
                    self.m_codeView.hidden = YES;
                    self.m_statusLabel.hidden = NO;
                    self.m_statusLabel.text = [NSString stringWithFormat:@"公众邀请码已退回,暂不可邀请\n原因:%@" ,[self.m_itemsDic objectForKey:@"ReturnDescript"]];
                    
                    // 重新申请
                    [self setRightButtonWithTitle:@"重新申请" action:@selector(ReapplyClicked)];

                }
                
            }else{
                
                if ( [self.m_stringStatus isEqualToString:@"PublicInviteCodePassed"] ) {
                    
                    // 已通过
                    self.m_codeView.hidden = NO;
                    self.m_statusLabel.hidden = YES;
                    
                    // 设置scrollerView的滚动范围
                    [self.m_scrollerView setContentSize:CGSizeMake(WindowSizeWidth, WindowSize.size.height)];
                    
                    self.navigationItem.rightBarButtonItem = nil;

                }else if ( [self.m_stringStatus isEqualToString:@"PublicInviteCodePending"] ) {
                    
                    // 审核中
                    self.m_codeView.hidden = YES;
                    self.m_statusLabel.hidden = NO;
                    self.m_statusLabel.text = @"公众邀请码还在审核中,暂不可邀请";
                
                    self.navigationItem.rightBarButtonItem = nil;

                }else if ( [self.m_stringStatus isEqualToString:@"PublicInviteCodeStopped"] ) {
                    
                    // 已禁用
                    self.m_codeView.hidden = YES;
                    self.m_statusLabel.hidden = NO;
                    self.m_statusLabel.text = [NSString stringWithFormat:@"公众邀请码已禁用,暂不可邀请\n原因:%@" ,[self.m_itemsDic objectForKey:@"ReturnDescript"]];
                    
                }else if ( [self.m_stringStatus isEqualToString:@"PublicInviteCodeReturened"] ) {
                    // 已退回
                    self.m_codeView.hidden = YES;
                    self.m_statusLabel.hidden = NO;
                    self.m_statusLabel.text = [NSString stringWithFormat:@"公众邀请码已退回,暂不可邀请\n原因:%@" ,[self.m_itemsDic objectForKey:@"ReturnDescript"]];
                }
                
                
            }
            
        } else {
            
            
        }
    } failure:^(NSError *error) {
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
//        self.m_phoneView.hidden = NO;
//        
//        self.m_tipLabel.hidden = YES;
//        
//        self.m_codeView.hidden = YES;
//        
//        self.m_phoneView.frame = CGRectMake(10, 0, 320, 270);

        // 设置scrollerView的滚动范围
//        [self.m_scrollerView setContentSize:CGSizeMake(320, 480)];
        
    }];
    
}
// 重新申请
- (void)ReapplyClicked{
    // 进入重新申请的页面
    ModifyCodeViewController *VC = [[ModifyCodeViewController alloc]initWithNibName:@"ModifyCodeViewController" bundle:nil];
    VC.m_dic = self.m_itemsDic;
    [self.navigationController pushViewController:VC animated:YES];
    
}
// 申请扩容
- (void)ExpansionClicked{
    
    // 已通过跳转到修改公众邀请码的页面
    ModifyCodeViewController *VC = [[ModifyCodeViewController alloc]initWithNibName:@"ModifyCodeViewController" bundle:nil];
    VC.m_dic = self.m_itemsDic;
    [self.navigationController pushViewController:VC animated:YES];

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
