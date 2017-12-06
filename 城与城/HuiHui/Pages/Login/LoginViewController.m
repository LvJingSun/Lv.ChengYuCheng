//
//  LoginViewController.m
//  HuiHui
//
//  Created by mac on 13-11-19.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import "LoginViewController.h"

#import "RootViewController.h"

#import "CommonUtil.h"

#import "RegistViewController.h"

#import "SVProgressHUD.h"

#import "BaseData.h"

#import "DateUtil.h"

#import "ForgetPasswordViewController.h"

#import "HH_cityListViewController.h"

#import "HH_PhoneViewController.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *m_accountTextField;

@property (weak, nonatomic) IBOutlet UITextField *m_passWordTextField;

@property (weak, nonatomic) IBOutlet UIButton *m_accountBtn;

@property (weak, nonatomic) IBOutlet UIButton *m_passwordBtn;

@property (nonatomic ,strong) NSMutableDictionary *photolist;

@property (weak, nonatomic) IBOutlet UIImageView *coverImgV;

@property (weak, nonatomic) IBOutlet UIView *m_qqView;

@property (weak, nonatomic) IBOutlet UIView *m_weixinView;

@property (weak, nonatomic) IBOutlet UIButton *m_newP;

@property (weak, nonatomic) IBOutlet UIButton *m_newBtnClick;

// 登录按钮触发的事件
- (IBAction)login:(id)sender;

// 注册按钮触发的事件
- (IBAction)registerClicked:(id)sender;

// 忘记密码按钮触发的事件
- (IBAction)forgetPassword:(id)sender;

// qq登录按钮触发的事件
- (IBAction)qqLoginClicked:(id)sender;

// 微信登录
//- (IBAction)weixinClicked:(id)sender;


@end

@implementation LoginViewController

@synthesize coverImgV;

@synthesize m_dic;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.photolist = [[NSMutableDictionary alloc]initWithCapacity:0];
        
        m_dic = [[NSMutableDictionary alloc]initWithCapacity:0];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setTitle:@"用户登录"];
    

    
    
    // 设置view的圆角
    self.m_qqView.layer.cornerRadius = 5.0f;
    self.m_qqView.layer.borderWidth = 1.0f;
    self.m_qqView.layer.borderColor = [UIColor lightGrayColor].CGColor;
   
    self.m_weixinView.layer.cornerRadius = 5.0f;
    self.m_weixinView.layer.borderWidth = 1.0f;
    self.m_weixinView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    self.m_qqView.hidden = YES;
    
    self.m_weixinView.hidden = YES;
    
    self.m_newP.hidden = YES;
    
    self.m_newBtnClick.hidden = YES;
    
}

//判断是否显示qq微信登录和注册按钮
- (void)requestFor {

    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    
    NSDictionary *param = [NSDictionary dictionary];
    
    [httpClient request:@"IsNumber.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            NSString *str = [NSString stringWithFormat:@"%@",[json valueForKey:@"numbers"]];
            
            if ([str isEqualToString:@"1"]) {
                
                //提交appstore审核
                
                self.m_qqView.hidden = YES;
                
                self.m_weixinView.hidden = YES;
                
                self.m_newP.hidden = YES;
                
                self.m_newBtnClick.hidden = YES;
                
            }else if ([str isEqualToString:@"0"]) {
                
                //审核通过
            
                if ([QQApi isQQInstalled]) {
                    
                    self.m_qqView.hidden = NO;
                    
                }
                
                if ([WXApi isWXAppInstalled]) {
                
                    self.m_weixinView.hidden = NO;
                    
                }
                
                self.m_newP.hidden = NO;
                
                self.m_newBtnClick.hidden = NO;
                
            }
            
        } else {
            
        }
    } failure:^(NSError *error) {

    }];
    
}

-(void)viewDidAppear:(BOOL)animated {

    [super viewDidAppear:animated];
    
    [self requestFor];
    
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    

//     添加微信登录成功的通知
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(weixinAccessToken:) name:@"WeixinLogin" object:nil];
    
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];

    NSString *accountstring = [NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:ACCOUNT]];
    
    if ([accountstring isEqualToString:@"(null)"]) {
        
        self.m_accountTextField.text =@"";
        self.m_passWordTextField.text = @"";
        
    }else{
     
        self.m_accountTextField.text = [NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:ACCOUNT]];
      
        self.m_passWordTextField.text = [NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:PWD]];
        
    }

    // 将要保存的数据全部清空
    [CommonUtil addValue:@"" andKey:R_INVIDATECODE];
    [CommonUtil addValue:@"" andKey:R_USERNAME];
    [CommonUtil addValue:@"" andKey:R_EMAIL];
    [CommonUtil addValue:@"" andKey:R_LOGINPASSW];
    [CommonUtil addValue:@"" andKey:R_AGAINPASSW];
    [CommonUtil addValue:@"" andKey:R_VALIDATECODE];
    [CommonUtil addValue:@"" andKey:R_PAYPASSW];
    [CommonUtil addValue:@"" andKey:R_AGAINPAYPASSW];
    [CommonUtil addValue:@"" andKey:R_QUESTION_FIRST];
    [CommonUtil addValue:@"" andKey:R_QUESTION_SECOND];
    [CommonUtil addValue:@"" andKey:R_QUESTION_THIRD];
    [CommonUtil addValue:@"" andKey:R_ANSWER_FIRST];
    [CommonUtil addValue:@"" andKey:R_ANSWER_SECOND];
    [CommonUtil addValue:@"" andKey:R_ANSWER_THIRD];
    [CommonUtil addValue:@"" andKey:R_QUESTION_FIRST_ID];
    [CommonUtil addValue:@"" andKey:R_QUESTION_SECOND_ID];
    [CommonUtil addValue:@"" andKey:R_QUESTION_THIRD_ID];

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);

    //获取完整路径
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:@"MemberHeaderPhoto.plist"];
    //判断是否以创建文件
    if ([[NSFileManager defaultManager] fileExistsAtPath:plistPath])
    {
        self.photolist = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
        
        if ([self.photolist objectForKey:[NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:USER_PHOTO]]]!=nil) {
        [self.Headimage setImage:[UIImage imageWithData:[self.photolist objectForKey:[NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:USER_PHOTO]]]]];
        [self.Headimage.layer setMasksToBounds:YES];
        [self.Headimage.layer setCornerRadius:10.0];
        }
    }
 
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [self.m_accountTextField resignFirstResponder];
    
    [self.m_passWordTextField resignFirstResponder];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
  
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)login:(id)sender {

    // 默认记住账号=======
    [self.view endEditing:YES];
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        return;
    }
  
    NSString *account  = self.m_accountTextField.text;
    NSString *pwd = self.m_passWordTextField.text;
    
    if (account.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入手机号"];
        return;
    }
    if (pwd.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入密码"];
        return;
    }

    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           account,     @"account",
                           pwd,   @"password",
                           @"HuiHuiApple",@"versionType",nil];
        
    [SVProgressHUD showWithStatus:@"登录中..."];
    [httpClient request:@"Login.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
           
           [SVProgressHUD dismiss];
            
            // 表示是普通账号的登录
            [CommonUtil addValue:@"0" andKey:weixinOrQqOrAccount];

            NSDictionary * member = [json valueForKey:@"member"];
            
            NSString * sDatetime = [json valueForKey:@"sDatetime"];

            // 令牌
            [CommonUtil addValue:[json valueForKey:@"TokenNoUsedTotal"] andKey:TOKENNOUSEDTOTAL];
            
            [CommonUtil addValue:[json valueForKey:@"TokenUsedTotal"] andKey:TOKENUSEDTOTAL];
            
            // 保存登录用户的头像
             [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@",[member objectForKey:@"photoMidUrl"]]forKey:kMY_USER_Head];
            [CommonUtil addValue:[json valueForKey:@"ChatRoomPassword"] andKey:LOGINPASSWORD];
            
            [CommonUtil addValue:[NSString stringWithFormat:@"%@",self.m_accountTextField.text] andKey:ACCOUNT];
            [CommonUtil addValue:[NSString stringWithFormat:@"%@",self.m_passWordTextField.text] andKey:PWD];
            //记住密码
            
            //是否商户或代理商（1是；0:否）
            [CommonUtil addValue:[NSString stringWithFormat:@"%@", [json valueForKey:@"IsDaiLiAndMct"]] andKey:IsDaiLiAndMct];
            //存储会员身份，是否是生活达人或资源达人；
            [CommonUtil addValue:[NSString stringWithFormat:@"%@", [json valueForKey:@"IsMemDaren"]] andKey:IsMemDaren];
            [CommonUtil addValue:[NSString stringWithFormat:@"%@", [json valueForKey:@"IsResDaren"]] andKey:IsResDaren];
            //（消费返利比例）、（生活达人返利比例）
            [CommonUtil addValue:[NSString stringWithFormat:@"%@", [json valueForKey:@"XiaoFeiFanLiBiLi"]] andKey:XiaoFeiFanLiBiLi];
            [CommonUtil addValue:[NSString stringWithFormat:@"%@", [json valueForKey:@"LifFanLiBiLi"]] andKey:LifFanLiBiLi];
            
            // 保存大众点评的返利比例值
            [CommonUtil addValue:[NSString stringWithFormat:@"%@", [json valueForKey:@"DPRebates"]] andKey:DZDP_FANLI];

            

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
            
        }
    } failure:^(NSError *error) {
            [SVProgressHUD showErrorWithStatus:@"登录失败..."];
    }];
}

- (void)tokenRequest{

    // 获取存储的token
    
    NSString *deviceToken = [CommonUtil getValueByKey:BPush_devicetoken];

    NSString *userId = [CommonUtil getValueByKey:BPush_kUserIdKey];

    NSString *appId = [CommonUtil getValueByKey:BPush_kAppIdKey];
    
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

    [httpClient request:@"AppTokenUpdate.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            
            
        } else {
            
            
        }
    } failure:^(NSError *error) {

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

            [CommonUtil addValue:[dic objectForKey:@"LogoBigUrl"] andKey:@"CardLoginBigUrl"];
            
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
                
                NSLog(@"RedDot = %i",RedDot);
                
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

- (IBAction)registerClicked:(id)sender {
    // 进入注册页面
    RegistViewController *VC = [[RegistViewController alloc]initWithNibName:@"RegistViewController" bundle:nil];
    [self.navigationController pushViewController:VC animated:YES];
}


#pragma matk - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if ( textField == self.m_passWordTextField ) {
        
        [textField resignFirstResponder];
        
        [self login:nil];
        
    }
    
    return YES;
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;   // return NO to not change text
{
    if (textField == self.m_accountTextField) {
        
        if ([string isEqualToString:@""]) {
            
            if (self.m_accountTextField.text.length!=0) {
                
            self.m_accountTextField.text  = [[NSString stringWithFormat:@"%@",self.m_accountTextField.text]substringToIndex:self.m_accountTextField.text.length-1];
            
            [self.Headimage setImage:[UIImage imageNamed:@"moren.png"]];

            return NO;
                
            }

            
        }else{
  
        self.m_accountTextField.text  = [NSString stringWithFormat:@"%@%@",self.m_accountTextField.text,string];
            
            if (self.m_accountTextField.text.length == 11) {
                
                if ([self.photolist objectForKey:[NSString stringWithFormat:@"%@",self.m_accountTextField.text]]!=nil) {
                    [self.Headimage setImage:[UIImage imageWithData:[self.photolist objectForKey:[NSString stringWithFormat:@"%@",self.m_accountTextField.text]]]];
                    [self.Headimage.layer setMasksToBounds:YES];
                    [self.Headimage.layer setCornerRadius:10.0];
                }

            }else
            {
                [self.Headimage setImage:[UIImage imageNamed:@"moren.png"]];

            }

  
        return NO;
        
        }
    }
    
    return YES;
}



- (void)textFieldDidBeginEditing:(UITextField *)textField;{

}


- (IBAction)forgetPassword:(id)sender {
    // 进入忘记密码的页面
    ForgetPasswordViewController *VC = [[ForgetPasswordViewController alloc]initWithNibName:@"ForgetPasswordViewController" bundle:nil];
    [self.navigationController pushViewController:VC animated:YES];

}


#pragma mark - weixinClicked
- (IBAction)weixinClicked:(id)sender{
    
    if( [WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi] ){ //判断是否安装且支持微信
        
        //构造SendAuthReq结构体
        SendAuthReq* req = [[SendAuthReq alloc]init];
        req.scope = @"snsapi_message,snsapi_userinfo,snsapi_friend,snsapi_contact";
        req.state = @"123";
        //第三方向微信终端发送一个SendAuthReq消息结构
        [WXApi sendReq:req];
        
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

// 微信根据code获取access_token
- (void)weixinAccessToken:(NSNotification *)notification{

    NSString *code = [NSString stringWithFormat:@"%@",[notification.userInfo objectForKey:@"codeKey"]];
    
    // AppID：wx67aeb251adaae095  AppSecret：eb7c53df9cbea1f5877336cf283d3696
    
    
 //    https://api.weixin.qq.com/sns/oauth2/access_token?appid=APPID&secret=SECRET&code=CODE&grant_type=authorization_code
    
    
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        return;
    }
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    
    NSString *appId = @"wx67aeb251adaae095";
    NSString *appSecret = @"eb7c53df9cbea1f5877336cf283d3696";
    
    
    
    NSString *urlString = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code",appId,appSecret,code];
    
    
    [SVProgressHUD showWithStatus:@"accessToken请求中"];
    [httpClient request:urlString parameters:nil success:^(NSJSONSerialization* json) {
        
        // 获取到accessToken后进行用户信息的请求
        [self getWeixinUserInfoRequest:json];

    } failure:^(NSError *error) {
        
        //NSLog(@"failed:%@", error);
        //        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];

}

- (void)getWeixinUserInfoRequest:(NSJSONSerialization *)dic{
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        return;
    }
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    
    // 得到accessToken和openId
    NSString *accessToekn = [NSString stringWithFormat:@"%@",[dic valueForKey:@"access_token"]];
    NSString *openid = [NSString stringWithFormat:@"%@",[dic valueForKey:@"openid"]];
    
    NSString *urlString = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@",accessToekn,openid];
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:urlString parameters:nil success:^(NSJSONSerialization* json) {

        
        NSString *sex = [json valueForKey:@"gender"];
        
        // sex	普通用户性别，1为男性，2为女性
        if ( [sex isEqualToString:@"1"] ) {
            
            sex = @"男";
            
        }else if ( [sex isEqualToString:@"2"] ) {
            
            sex = @"女";

        }else{
            
            sex = @"";

        }
        
        // 存储到字典用于绑定手机号使用
        [self.m_dic setObject:[json valueForKey:@"nickname"] forKey:@"nickname"];
        
        [self.m_dic setObject:[json valueForKey:@"province"] forKey:@"province"];
        
        [self.m_dic setObject:sex forKey:@"gender"];
        
        [self.m_dic setObject:[json valueForKey:@"headimgurl"] forKey:@"figureurl_1"];
        
        [self.m_dic setObject:@"" forKey:@"figureurl_2"];
        
        [self.m_dic setObject:@"" forKey:@"figureurl_qq_1"];
        
        [self.m_dic setObject:@"" forKey:@"figureurl_qq_2"];
        
        // 保存token和openId
        [CommonUtil addValue:accessToekn andKey:QQAccessTokenKey];
        [CommonUtil addValue:openid andKey:QQCurrentUserIdKey];
        [CommonUtil addValue:@"" andKey:QQExpirationDateKey];
        
        // 根据用户信息请求验证绑定手机号的接口
        [self yanzhengRequest:@"2"];
        
    } failure:^(NSError *error) {

    }];
    
    
}

- (void)loginWithUsername:(NSString *)username password:(NSString *)password
{
    NSLog(@"login");
    [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:username
                                                        password:password
                                                      completion:
     ^(NSDictionary *loginInfo, EMError *error) {
         [self hideHud];
         if (loginInfo && !error) {
             //获取群组列表
             [[EaseMob sharedInstance].chatManager asyncFetchMyGroupsList];
             
             [[EaseMob sharedInstance].chatManager setIsAutoLoginEnabled:YES];//设置环信的自动登录（必须）不然会出现数据缓存的问题
             [EaseMob sharedInstance].chatManager.apnsNickname =[NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:USER_NAME]];
             EMError *error = [[EaseMob sharedInstance].chatManager importDataToNewDatabase];
             if (!error) { error = [[EaseMob sharedInstance].chatManager loadDataFromDatabase]; };

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

#pragma mark - qqLogin
- (IBAction)qqLoginClicked:(id)sender {

    // qq登录
    // 初始化qq登录
    _permissions = [NSMutableArray arrayWithObjects:
                    kOPEN_PERMISSION_GET_USER_INFO,
                    kOPEN_PERMISSION_GET_SIMPLE_USER_INFO,
                    kOPEN_PERMISSION_GET_INFO,
                    nil];
    _tencentOAuth = [[TencentOAuth alloc] initWithAppId:TencentQzoneAppId andDelegate:self];

    _tencentOAuth.redirectURI = @"www.qq.com";
    
    // 调用qq登录的方法，登录成功后则会执行 tencentDidLogin 的代理方法
    [_tencentOAuth authorize:_permissions inSafari:NO];
    
}

// qq登录成功后执行的方法
- (void)qqLoginSuccess{
    
    // 登录成功后请求接口去验证是否绑定过手机号
    
    [self yanzhengRequest:@"1"];
    
}

#pragma mark - 登录成功后执行的代理方法
- (void)tencentDidLogin {

    if (_tencentOAuth.accessToken
        && 0 != [_tencentOAuth.accessToken length])
    {
        
        // 存储token、openId和token失效的时间
        [CommonUtil addValue:_tencentOAuth.accessToken andKey:QQAccessTokenKey];
        [CommonUtil addValue:_tencentOAuth.openId andKey:QQCurrentUserIdKey];
        [CommonUtil addValue:_tencentOAuth.expirationDate andKey:QQExpirationDateKey];
        
        [SVProgressHUD showWithStatus:@"数据加载中"];

        // 获取用户的信息，成功的话则会执行 getUserInfoResponse 的代理方法
        if( ![_tencentOAuth getUserInfo] ){
            
            [SVProgressHUD dismiss];
            
            [self showInvalidTokenOrOpenIDMessage];
        }
        
        
    }
    else
    {

    }
    
}

- (void)tencentDidNotLogin:(BOOL)cancelled
{
    if ( cancelled ){
        
        [SVProgressHUD showErrorWithStatus:@"用户取消登录"];
        
    }
    else {
        
        [SVProgressHUD showErrorWithStatus:@"登录失败"];
    }
    
}


- (void)tencentDidNotNetWork
{
    [SVProgressHUD showErrorWithStatus:@"无网络连接，请设置网络"];
    
}

- (void)showInvalidTokenOrOpenIDMessage{

    [SVProgressHUD showErrorWithStatus:@"可能授权已过期，请重新登录获取"];
    
    [self performSelector:@selector(qqAuthLogin) withObject:nil afterDelay:2.0];
    
}

// qq授权
-(void)qqAuthLogin
{
    // 清空token及openId的值
    [CommonUtil addValue:@"" andKey:QQAccessTokenKey];
    [CommonUtil addValue:@"" andKey:QQCurrentUserIdKey];
    [CommonUtil addValue:@"" andKey:QQExpirationDateKey];
    
    // 重新调用qq登录的方法
    [_tencentOAuth authorize:_permissions inSafari:NO];
}


// Called when the get_user_info has response.
#pragma mark - 获取个人信息成功后执行的代理方法
- (void)getUserInfoResponse:(APIResponse*) response {

    if (response.retCode == URLREQUEST_SUCCEED)
    {
      
        // 存储到字典用于绑定手机号使用
        [self.m_dic setObject:[response.jsonResponse objectForKey:@"nickname"] forKey:@"nickname"];

        [self.m_dic setObject:[response.jsonResponse objectForKey:@"province"] forKey:@"province"];

        [self.m_dic setObject:[response.jsonResponse objectForKey:@"gender"] forKey:@"gender"];

        [self.m_dic setObject:[response.jsonResponse objectForKey:@"figureurl_1"] forKey:@"figureurl_1"];

        [self.m_dic setObject:[response.jsonResponse objectForKey:@"figureurl_2"] forKey:@"figureurl_2"];

        [self.m_dic setObject:[response.jsonResponse objectForKey:@"figureurl_qq_1"] forKey:@"figureurl_qq_1"];

        [self.m_dic setObject:[response.jsonResponse objectForKey:@"figureurl_qq_2"] forKey:@"figureurl_qq_2"];

        
        
        NSMutableString *str = [NSMutableString stringWithFormat:@""];
        for (id key in response.jsonResponse) {
            [str appendString: [NSString stringWithFormat:@"%@:%@\n",key,[response.jsonResponse objectForKey:key]]];
        }
    
        
        // qq登录成功后执行的方法
        [self qqLoginSuccess];
        
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"操作失败"
                                                        message:[NSString stringWithFormat:@"%@", response.errorMsg]
                                                       delegate:self
                                              cancelButtonTitle:@"我知道啦"
                                              otherButtonTitles: nil];
        alert.tag = 1112;
        [alert show];
        
    }
    
}

#pragma mark - UIalertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{

    if (alertView.tag == 1112 ){
        
        NSString *Title = [alertView title];
        NSString *ButtonTitle = [alertView buttonTitleAtIndex:buttonIndex];
        UITextField *textMatch;
        UITextField *textReqnum;
        
        
        if ([Title isEqualToString:@"请输入匹配字符串"])
        {
            if([ButtonTitle isEqualToString:@"确定"])
            {
                //textMatch = [alertView textFieldAtIndex:0];
                textMatch = (UITextField*)[alertView viewWithTag:0xAA];
                _Marth = [textMatch.text copy];
            }
        }
        else if ([Title isEqualToString:@"请输入请求个数"])
        {
            if([ButtonTitle isEqualToString:@"确定"])
            {
                //textReqnum = [alertView textFieldAtIndex:0];
                textReqnum = (UITextField*)[alertView viewWithTag:0xAA];
                _Reqnum = [textReqnum.text copy];
                
            }
        }
        
        CFRunLoopStop(CFRunLoopGetCurrent());
        
    }else if ( alertView.tag == 100100 ) {
        
        if ( buttonIndex == 1 ) {
            // 跳转到下载微信的地址
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[WXApi getWXAppInstallUrl]]];
        }else{
            
        }
        
    }else{
        
        
    }

}

- (void)yanzhengRequest:(NSString *)aType{

    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        return;
    }
 
    NSString *openId = [CommonUtil getValueByKey:QQCurrentUserIdKey];
    
//    合作平台账户类别（1：QQ;2：微信)
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           openId,     @"wxQq",
                           [NSString stringWithFormat:@"%@",aType], @"type",nil];

    
    [httpClient request:@"WxQqCheck.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        // 将是qq还是微信登录存储起来
        [CommonUtil addValue:aType andKey:wxQqType];

        if (success) {
            
            [SVProgressHUD dismiss];

            // 验证成功表示是qq还是微信登录
            [CommonUtil addValue:@"1" andKey:weixinOrQqOrAccount];

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
            
//            NSString *msg = [json valueForKey:@"msg"];
//            [SVProgressHUD showErrorWithStatus:msg];
            
            [SVProgressHUD dismiss];
            
            [CommonUtil addValue:@"0" andKey:weixinOrQqOrAccount];
            
            // 如果是0表示未绑定好手机号  进入手机绑定的页面
            HH_PhoneViewController *VC = [[HH_PhoneViewController alloc]initWithNibName:@"HH_PhoneViewController" bundle:nil];
            VC.m_dic = self.m_dic;
            [self.navigationController pushViewController:VC animated:YES];
            
            
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];
}

@end
