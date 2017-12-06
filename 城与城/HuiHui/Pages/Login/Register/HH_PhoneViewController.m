//
//  HH_PhoneViewController.m
//  HuiHui
//
//  Created by mac on 14-11-5.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "HH_PhoneViewController.h"

#import "AgreementViewController.h"

#import "HH_cityListViewController.h"

#import "DateUtil.h"

#import "UIImageView+AFNetworking.h"

@interface HH_PhoneViewController ()

@property (weak, nonatomic) IBOutlet UITextField *m_phoneTextField;

@property (weak, nonatomic) IBOutlet UITextField *m_codeTextField;

@property (weak, nonatomic) IBOutlet UIButton *m_checkBtn;

@property (weak, nonatomic) IBOutlet UIButton *m_registerBtn;

@property (nonatomic ,strong) NSMutableDictionary *photolist;

@property (weak, nonatomic) IBOutlet UIImageView *coverImgV;


// 获取验证码
//- (IBAction)SMSClicked:(id)sender;
// 注册按钮触发的事件
- (IBAction)registerClicked:(id)sender;
// 选择勾选按钮
//- (IBAction)checkAgreement:(id)sender;
//// 注册协议
//- (IBAction)Agreement:(id)sender;

@end

@implementation HH_PhoneViewController

@synthesize isChecked;

@synthesize m_dic;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        isChecked = YES;
        
        m_dic = [[NSMutableDictionary alloc]initWithCapacity:0];
        
        self.photolist = [[NSMutableDictionary alloc]initWithCapacity:0];

        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setTitle:@"绑定手机号"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    
    // 默认注册按钮是可以点击的
    self.m_registerBtn.enabled = YES;
    
    
    // 在状态栏位置添加label，使其背景色为黑色
    if ( isIOS7 ) {
        
        UILabel *l_label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 20)];
        //        l_label.backgroundColor = [UIColor blackColor];
        //        l_label.alpha = 0.5;
        
        
        l_label.backgroundColor = RGBACKTAB;
        l_label.tag = 1001;
        [self.navigationController.view addSubview:l_label];
        
    }
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self hideTabBar:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [self hideTabBar:NO];
    
    // 移除导航栏上面的view
    for (UILabel *label in self.navigationController.view.subviews) {
        
        if ( label.tag == 1001 ) {
            
            [label removeFromSuperview];
            
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)leftClicked{
    
    // 移除导航栏上面的view
    for (UILabel *label in self.navigationController.view.subviews) {
        
        if ( label.tag == 1001 ) {
            
            [label removeFromSuperview];
            
        }
    }

    
    [self goBack];
}

/*- (IBAction)SMSClicked:(id)sender {
    
    [self.view endEditing:YES];
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    if ( self.m_phoneTextField.text.length == 0 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请输入手机号码"];
        
        return;
    }
    
    if ( self.m_phoneTextField.text.length != 11 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请输入11位手机号码"];
        
        return;
    }
    
    if (self.clickDateTime != nil) {
        NSTimeInterval timeDiff = [self.clickDateTime timeIntervalSinceNow];
        //NSLog(@"%.0f", ABS(timeDiff));
        if (ABS(timeDiff) < 120) {
            [SVProgressHUD showErrorWithStatus:@"短信已发送，请过2分钟后再发送。"];
            return;
        }
    }
    
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           self.m_phoneTextField.text, @"phone",
                           nil];
    [SVProgressHUD showWithStatus:@"验证码发送中"];
    [httpClient request:@"PublicInviteSMSVld.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            self.clickDateTime = [[NSDate alloc] init];
            
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showSuccessWithStatus:msg];
            
        } else {
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
    } failure:^(NSError *error) {
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];
}*/

- (IBAction)registerClicked:(id)sender {
    
    [self.view endEditing:YES];

    if ( self.m_phoneTextField.text.length == 0 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请输入手机号"];
        
        return;
    }
   
    if ( self.m_phoneTextField.text.length != 11 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号格式"];
        
        return;
    }
    
    // 注册请求数据
    [self requestSubmit];
    
}

//- (IBAction)checkAgreement:(id)sender {
//    
//    self.isChecked = !self.isChecked;
//    
//    if ( self.isChecked ) {
//        
//        [self.m_checkBtn setImage:[UIImage imageNamed:@"comm_check_box_selected.png"] forState:UIControlStateNormal];
//        
//        self.m_registerBtn.enabled = YES;
//        
//    }else{
//        
//        [self.m_checkBtn setImage:[UIImage imageNamed:@"comm_check_box_def.png"] forState:UIControlStateNormal];
//        
//        self.m_registerBtn.enabled = NO;
//    }
//    
//}

//- (IBAction)Agreement:(id)sender {
//    
//    AgreementViewController *VC = [[AgreementViewController alloc]initWithNibName:@"AgreementViewController" bundle:nil];
//    
//    [self.navigationController pushViewController:VC animated:YES];
//}

#pragma mark - uitextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)sender {

    return YES;
}

//UITextField的协议方法，当开始编辑时监听
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    if ( textField == self.m_phoneTextField || textField == self.m_codeTextField ) {

        [self showNumPadDone:nil];
   
    }
   
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
}

- (void)requestSubmit{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        return;
    }
    
    
    
    NSString *openId = [CommonUtil getValueByKey:QQCurrentUserIdKey];
    NSString *wxQq = [CommonUtil getValueByKey:wxQqType];
    
    //    合作平台账户类别（1：QQ;2：微信)
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           openId,     @"wxQq",
                           wxQq, @"type",
                           [NSString stringWithFormat:@"%@",self.m_phoneTextField.text],@"account",
                           [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"province"]],@"province",
                            [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"gender"]],@"gender",
                            [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"figureurl_1"]],@"figureurl_1",
                           [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"figureurl_2"]],@"figureurl_2",
                           [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"figureurl_qq_1"]],@"figureurl_qq_1",
                           [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"figureurl_qq_2"]],@"figureurl_qq_2",nil];
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    [httpClient request:@"WxQqBind.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            [SVProgressHUD dismiss];
            
            [CommonUtil addValue:@"1" andKey:weixinOrQqOrAccount];
            
//            NSString *msg = [json valueForKey:@"msg"];
//            [SVProgressHUD showErrorWithStatus:msg];
            
            // 绑定过手机号后直接进行登录
            NSDictionary * member = [json valueForKey:@"member"];
            
            NSString * sDatetime = [json valueForKey:@"sDatetime"];
            
            // 令牌
            [CommonUtil addValue:[json valueForKey:@"TokenNoUsedTotal"] andKey:TOKENNOUSEDTOTAL];
            
            [CommonUtil addValue:[json valueForKey:@"TokenUsedTotal"] andKey:TOKENUSEDTOTAL];
            
            // 保存登录用户的头像
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@",[member objectForKey:@"photoMidUrl"]]forKey:kMY_USER_Head];
            [CommonUtil addValue:[json valueForKey:@"ChatRoomPassword"] andKey:LOGINPASSWORD];
            
//            [CommonUtil addValue:[NSString stringWithFormat:@"%@",self.m_accountTextField.text] andKey:ACCOUNT];
//            [CommonUtil addValue:[NSString stringWithFormat:@"%@",self.m_passWordTextField.text] andKey:PWD];
            //记住密码
            
            //是否商户或代理商（1是；0:否）
            [CommonUtil addValue:[NSString stringWithFormat:@"%@", [json valueForKey:@"IsDaiLiAndMct"]] andKey:IsDaiLiAndMct];
            //存储会员身份，是否是生活达人或资源达人；
            [CommonUtil addValue:[NSString stringWithFormat:@"%@", [json valueForKey:@"IsMemDaren"]] andKey:IsMemDaren];
            [CommonUtil addValue:[NSString stringWithFormat:@"%@", [json valueForKey:@"IsResDaren"]] andKey:IsResDaren];
            //（消费返利比例）、（生活达人返利比例）
            [CommonUtil addValue:[NSString stringWithFormat:@"%@", [json valueForKey:@"XiaoFeiFanLiBiLi"]] andKey:XiaoFeiFanLiBiLi];
            [CommonUtil addValue:[NSString stringWithFormat:@"%@", [json valueForKey:@"LifFanLiBiLi"]] andKey:LifFanLiBiLi];
            
            //保存代理等级
            [CommonUtil addValue:[NSString stringWithFormat:@"%@",[json valueForKey:@"DaiLiLevel"]] andKey:DaiLiLevel];
            
            [self saveLoginInfo:member serverDateTime:sDatetime];
            
            // 获取RGB的值请求数据
            [self loadPageRequest];
            
            // 保存token
            [self tokenRequest];

            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
            
//            [SVProgressHUD dismiss];
            
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];
}

- (void)saveLoginInfo:(NSDictionary *)member serverDateTime:(NSString *)sDatetime {
    NSTimeInterval timeDiff = [DateUtil computerServerTimeDiff:sDatetime];
    
    [CommonUtil addValue:[NSString stringWithFormat:@"%.0f", timeDiff] andKey:SERVER_TIME_DIFF];
    
    [CommonUtil addValue:[NSString stringWithFormat:@"%d", [[member valueForKey:@"memberId"] intValue]] andKey:MEMBER_ID];
    
    [CommonUtil addValue:[NSString stringWithFormat:@"%@",[member valueForKey:@"account"]] andKey:ACCOUNT];
    
    [CommonUtil addValue:[member valueForKey:@"nick"] andKey:NICK];
    
    [CommonUtil addValue:[member valueForKey:@"name"] andKey:USER_NAME];
    
    //AppPkgUrl  VersionNumber 保存版本号
    [CommonUtil addValue:[member objectForKey:@"versionNumber"] andKey:VERSION_NUM];
    
    [CommonUtil addValue:[member objectForKey:@"appPkgUrl"] andKey:VERSION_APPURL];
    
    // 保存会员编号
    [CommonUtil addValue:[member objectForKey:@"memberCode"] andKey:MEMBERCODE];
    
    // 保存用户的生日、邮箱、居住地址等
    [CommonUtil addValue:[member objectForKey:@"birthday"] andKey:USER_BIRTHDAY];
    
    [CommonUtil addValue:[member objectForKey:@"email"] andKey:USER_EMAIL];
    
    [CommonUtil addValue:[member objectForKey:@"liveAddress"] andKey:USER_AREA];
    
    [CommonUtil addValue:[member objectForKey:@"photoMidUrl"] andKey:USER_PHOTO];
    
    [CommonUtil addValue:[member objectForKey:@"sex"] andKey:USER_SEX];
    
    // 保存账号和密码、JID等
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:MEMBER_ID]] forKey:kMY_USER_ID];
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@@home.cityandcity.com",[CommonUtil getValueByKey:MEMBER_ID]] forKey:kXMPPmyJID];
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:LOGINPASSWORD]] forKey:kXMPPmyPassword];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    [self requestSubmitRedDian];
    
    [self Setphotot:[NSString stringWithFormat:@"%@",[member objectForKey:@"photoMidUrl"]] andid:[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%@", [CommonUtil getValueByKey:USER_PHOTO]]]];
    
}

- (void)tokenRequest{
    
    // 获取存储的token
    
    NSString *deviceToken = [CommonUtil getValueByKey:BPush_devicetoken];
    
    NSString *userId = [CommonUtil getValueByKey:BPush_kUserIdKey];
    
//    NSString *appId = [CommonUtil getValueByKey:BPush_kAppIdKey];
    
    NSString *channelId = [CommonUtil getValueByKey:BPush_kChannelIdKey];
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    //roleCode- Member会员,Merchant商户,Operator操作员 model-苹果Apple安卓Android type-CityPay：宝支付；HuiHui：诲诲；BossTool：老板驾驶舱；Acquirer：收单 userId 操作员Id，默认为0
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"memberId",
                           key,@"key",
                           @"0",@"userId",
                           @"Member",@"roleCode",
                           [NSString stringWithFormat:@"%@",deviceToken],@"tokenValue",
                           [NSString stringWithFormat:@"%@",userId],@"bdUserID",
                           [NSString stringWithFormat:@"%@",channelId],@"bdChannelId",
                           @"Apple",@"model",
                           @"HuiHui",@"type",nil];
    
    //    [SVProgressHUD showWithStatus:@"登录中"];
    [httpClient request:@"AppTokenUpdate.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            
            
        } else {
            
            
        }
    } failure:^(NSError *error) {
        //NSLog(@"failed:%@", error);
        //        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}


// 获取RGB
- (void)loadPageRequest{
    
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
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"AppSiteInfo.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            
            [SVProgressHUD dismiss];
            
            NSDictionary *dic = [json valueForKey:@"BtPageConfig"];
            
            // 保存引导页的图片和RGB的值
            [CommonUtil addValue:[dic objectForKey:@"MerchantId"] andKey:MERCHANTID];
            
            [CommonUtil addValue:[dic objectForKey:@"MaxBgImg"] andKey:LOADINGPAGEIMAGE];
            [CommonUtil addValue:[dic objectForKey:@"YunDongYSUrl"] andKey:YunDongYSUrl];

            
            //            [CommonUtil addValue:[dic objectForKey:@"Rgb"] andKey:LOADINGPAGERGB];
            
            // 将图片保存起来-用于封面的显示
            [self.coverImgV setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:[dic objectForKey:@"MaxBgImg"]]]
                                  placeholderImage:[UIImage imageNamed:@""]
                                           success:^(NSURLRequest *request, NSHTTPURLResponse *response,  UIImage *image){
                                               
                                               //                                                 imgV.image = [CommonUtil scaleImage:image toSize:CGSizeMake(320, [UIScreen mainScreen].bounds.size.height)];
                                               
                                               self.coverImgV.image = image; //[CommonUtil scaleImage:image toSize:CGSizeMake(320, [UIScreen mainScreen].bounds.size.height)];
                                               
                                               // 保存起来图片
                                               [self saveImage:self.coverImgV.image];
                                               
                                           }
                                           failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                                               
                                           }];
            
            
            
        } else {
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
            
        }
    } failure:^(NSError *error) {
        //NSLog(@"failed:%@", error);
        //        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];
    
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
    //    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"RedTip.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            
            NSDictionary *dic = [json valueForKey:@"RedTipCnt"];
            
            friendHelp = [[FriendHelper alloc]init];
            
            int RedDot = [self sumOfSixValueWithDic:dic];
            
            if ( [friendHelp redDotArray].count != 0 ) {
                
                int RedDot1 = [self sumOfSixValueWithDic:[[friendHelp redDotArray] objectAtIndex:0]];
                
                // 如果这两值相等的话则表示没有新消息，不显示红点
                if ( RedDot != RedDot1 ) {
                    
                    [CommonUtil addValue:@"1" andKey:@"BudgeNumberKey"];
                    
                }else{
                    
                    [CommonUtil addValue:@"0" andKey:@"BudgeNumberKey"];
                    
                }
                
                
            }else{
                
                // 第一次进入时数据库中没有数据，如果这个值为0则表示没消息不显示红点,否则显示红点
                if ( RedDot != 0 ) {
                    
                    [CommonUtil addValue:@"1" andKey:@"BudgeNumberKey"];
                    
                }else{
                    
                    [CommonUtil addValue:@"0" andKey:@"BudgeNumberKey"];
                    
                }
                
            }
            
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showErrorWithStatus:msg];
            
        }
    } failure:^(NSError *error) {
        //        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];
    
    
    //登录环信
    [self loginWithUsername:[NSString stringWithFormat:@"%@", [CommonUtil getValueByKey:MEMBER_ID]] password:@"888888"];
    
    //保存密码
    [CommonUtil addValue:@"1" andKey:LOGINSELF];
    
    
    // 进入定位
    HH_cityListViewController *VC = [[HH_cityListViewController alloc]initWithNibName:@"HH_cityListViewController" bundle:nil];
    VC.m_typeString = @"1";
    [self.navigationController pushViewController:VC animated:NO];
    
    
}

- (void)loginWithUsername:(NSString *)username password:(NSString *)password
{
    [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:username
                                                        password:password
                                                      completion:
     ^(NSDictionary *loginInfo, EMError *error) {
         [self hideHud];
         if (loginInfo && !error) {
             [[EaseMob sharedInstance].chatManager setIsAutoLoginEnabled:YES];//设置环信的自动登录（必须）不然会出现数据缓存的问题
             [EaseMob sharedInstance].chatManager.apnsNickname =[NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:USER_NAME]];
             
         }else {
             switch (error.errorCode) {
                 case EMErrorServerNotReachable:
//                     TTAlertNoTitle(@"聊天连接服务器失败!");
                     break;
                 case EMErrorServerAuthenticationFailure:
                     TTAlertNoTitle(@"聊天用户名或密码错误");
                     break;
                 case EMErrorServerTimeout:
                     TTAlertNoTitle(@"聊天连接服务器超时!");
                     break;
                 default:
                     TTAlertNoTitle(@"聊天登录失败");
                     break;
             }
         }
     } onQueue:nil];
}

//保存头像到plist
-(void)Setphotot:(NSString *)imagepaht andid:(NSString *)USER_PHOTO
{
    
    //    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    
    //获取完整路径
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"MemberHeaderPhoto.plist"];
    //添加一项内容
    UIImage *reSizeImage = [self.imageCache getImage:imagepaht];
    
    if (reSizeImage != nil){
        
        NSData *dataObj = UIImageJPEGRepresentation(reSizeImage, 1.0);
        [self.photolist setObject:dataObj forKey:USER_PHOTO];
        [self.photolist setObject:dataObj forKey:[NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:ACCOUNT]]];
        //        [self.photolist setObject:[CommonUtil getValueByKey:PWD] forKey:[NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:PWD]]];
        
        [self.photolist writeToFile:path atomically:YES];
        
    }
    else{
        
        UIImageView *IMA = [[UIImageView alloc]init];
        [IMA setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:imagepaht]] placeholderImage:[UIImage imageNamed:@"moren.png"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
            NSData *dataObj = UIImageJPEGRepresentation(image, 1.0);
            [self.photolist setObject:dataObj forKey:USER_PHOTO];
            [self.photolist setObject:dataObj forKey:[NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:ACCOUNT]]];
            [self.photolist writeToFile:path atomically:YES];
            
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
            
            
        }];
        
    }
    
}



@end
