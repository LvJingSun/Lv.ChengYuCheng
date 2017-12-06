//
//  InsurecountViewController.m
//  HuiHui
//
//  Created by 冯海强 on 14-7-15.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "InsurecountViewController.h"

#import "CommonUtil.h"

#import "UIImageView+AFNetworking.h"

@interface InsurecountViewController ()

@end

@implementation InsurecountViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.AgeArray = [[NSMutableArray alloc]initWithCapacity:0];

        
        self.m_values = [[NSArray alloc]init];
        
        self.m_Funtions = [[NSArray alloc]init];
        
        self.m_keyTimes = [[NSArray alloc]init];
        
        
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setTitle:self.InsureTitle];
    
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    
    [self.InsureScroll setContentSize:CGSizeMake(WindowSize.size.width,568)];
    self.InsureScroll.scrollEnabled = YES;
    
    
    
    
    [self.Workscroll setContentSize:CGSizeMake(WindowSize.size.width,630)];

    
    self.InsureName.delegate = self;
    self.Insurecoverage.delegate = self;
    
    
    self.exaple1.editable = self.exaple2.editable = NO;
    
    [self.Workout addTarget:self action:@selector(WorkoutInsure) forControlEvents:UIControlEventTouchUpInside];
    
    self.Workout.enabled = NO;
        

    // 设置view的圆角
    self.m_explainview.layer.cornerRadius = 10.0f;
    self.m_explainview.layer.borderWidth = 1.0f;
    
    self.m_explainview.layer.borderColor = [UIColor colorWithRed:215/255.0 green:215/255.0 blue:215/255.0 alpha:1.0].CGColor;

    
    // 初始化三个用于动画的数组
    NSArray *array = [[NSArray alloc]initWithObjects:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f, 0.01f, 1.0f)],[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.0f)],[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9f, 0.9f, 1.0f)],[NSValue valueWithCATransform3D:CATransform3DIdentity], nil];
    
    NSArray *keyTimes = [[NSArray alloc]initWithObjects:@"0.2f",@"0.5f", @"0.75f", @"1.0f", nil];
    
    NSArray *funtions = [[NSArray alloc]initWithObjects:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                         [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                         [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut], nil];
    
    self.m_values = array;
    
    self.m_keyTimes = keyTimes;
    
    self.m_Funtions = funtions;
    
    
    
    NSString * longplistPath=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/manlong.plist"];
    NSMutableArray * longarray = [[NSMutableArray alloc]initWithContentsOfFile:longplistPath];

    
    if ( longarray.count==0) {
        
        //第一次安装导入plist
        
        [self ArrayAddKey];
     
    }
    
}


//键值导入



-(void)ArrayAddKey
{
    
    for (int i=1; i<=4; i++) {
        
        NSString *path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%d",i] ofType:@"txt"];
        
        NSString *contents = [[NSString alloc] initWithContentsOfFile:path encoding:NSASCIIStringEncoding error:nil];
        NSArray *contentsArray = [contents componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
        
        
        NSString *docs ;
        
        switch (i) {
            case 1:
                docs= [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/manlong.plist"];
                break;
            case 2:
                docs= [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/womanlong.plist"];
                break;
            case 3:
                docs= [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/mansick.plist"];
                break;
            case 4:
                docs= [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/womansick.plist"];
                break;
                
            default:
                break;
        }
        
        
        
        NSMutableArray *arr = [[NSMutableArray alloc] init];
        
        NSInteger idx;
        for (idx = 0; idx < contentsArray.count; idx++) {
            NSString* currentContent = [contentsArray objectAtIndex:idx];
            NSArray* timeDataArr = [currentContent componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@";"]];
            
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            
            switch (i) {
                case 1:
                    [dic setObject:[timeDataArr objectAtIndex:0] forKey:@"男性年龄"];
                    break;
                case 2:
                    [dic setObject:[timeDataArr objectAtIndex:0] forKey:@"女性年龄"];
                    break;
                case 3:
                    [dic setObject:[timeDataArr objectAtIndex:0] forKey:@"男性年龄"];
                    break;
                case 4:
                    [dic setObject:[timeDataArr objectAtIndex:0] forKey:@"女性年龄"];
                    break;
                    
                default:
                    break;
            }
            
            [dic setObject:[timeDataArr objectAtIndex:1] forKey:@"1年交"];
            [dic setObject:[timeDataArr objectAtIndex:2] forKey:@"3年交"];
            [dic setObject:[timeDataArr objectAtIndex:3] forKey:@"5年交"];
            [dic setObject:[timeDataArr objectAtIndex:4] forKey:@"10年交"];
            [dic setObject:[timeDataArr objectAtIndex:5] forKey:@"15年交"];
            [dic setObject:[timeDataArr objectAtIndex:6] forKey:@"20年交"];
            
            [arr addObject:dic];
            
            
        }
        
        [arr writeToFile:docs atomically:YES];
        
        NSLog(@"写入成功");
        
    }
    
    
}







-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self hideTabBar:YES];
    
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView;
{
    [self.view endEditing:YES];
}


- (void)textFieldDidBeginEditing:(UITextField *)textField;
{
    if (textField ==  self.InsureName) {
        
        [self hiddenNumPadDone:nil];
        
    }else if (textField == self.Insurecoverage)
    {
        [self showNumPadDone:nil];
        
        [self.InsureScroll setContentOffset:CGPointMake(0,150) animated:YES];

    }
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{
    if (textField == self.Insurecoverage) {
        
        if ([self.Insurecoverage.text isEqualToString:@""]) {
            
            if ([string isEqualToString:@"0"]) {
                
                return NO;
                
            }
            
        }
        
    }
    
    return YES;
}



- (void)textFieldDidEndEditing:(UITextField *)textField;
{
    if (textField ==  self.Insurecoverage) {
        
        if ([self.Insurecoverage.text intValue]<10) {
            
            [self alertWithMessage:@"保额最低不能小于10万，请重新输入！" tag:10 delegate:self];
            
        }
        
    }
    
    if ([self.InsureName.text isEqualToString:@""]||[self.InsureSex.text isEqualToString:@""]||[self.InsureAge.text isEqualToString:@""]||[self.Insurecoverage.text isEqualToString:@""]||[self.InsureClass.text isEqualToString:@""]||[self.InsureYear.text isEqualToString:@""]) {
        
        self.Workout.enabled = NO;
        
    }else
    {
        self.Workout.enabled = YES;
    }
}




- (BOOL)textFieldShouldReturn:(UITextField *)textField;
{

    [self.view endEditing:YES];
    
    UIButton * Btn =[[UIButton alloc]init];
    Btn.tag = 10001;
    
    [self Chose:Btn];
    
    return YES;
    
}


- (void)leftClicked{
    
    [self goBack];
    
}


- (IBAction)Chose:(id)sender
{
    [self.view endEditing:YES];

    UIButton * Btn = (UIButton *)sender;
    
    if (Btn.tag==10001) {
        
        UIActionSheet *sheet  = [[UIActionSheet alloc] initWithTitle:@"选择性别" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"男",@"女", nil];
        
        sheet.tag = 10001;
        [sheet showInView:self.view];
        
        
    }else if (Btn.tag == 10002){
        
        UIActionSheet *sheet  = [[UIActionSheet alloc] initWithTitle:@"选择年龄" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30",@"31",@"32",@"33",@"34",@"35",@"36",@"37",@"38",@"39",@"40",@"41",@"42",@"43",@"44",@"45",@"46",@"47",@"48",@"49",@"50",@"51",@"52",@"53",@"54",@"55",@"56",@"57",@"58",@"59",@"60",@"61",@"62",@"63",@"64",@"65",nil];
        
        sheet.tag = 10002;
        
//        [sheet showInView:self.view];
        
        [sheet showFromToolbar:self.view];
        
    }else if (Btn.tag == 10003){
        
        UIActionSheet *sheet  = [[UIActionSheet alloc] initWithTitle:@"选择险种" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"中意一生保终身重疾险", nil];
        
        sheet.tag = 10003;
        [sheet showInView:self.view];
        
    }else if (Btn.tag == 10004){
        
        UIActionSheet *sheet  = [[UIActionSheet alloc] initWithTitle:@"选择年限" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"1年",@"3年",@"5年",@"10年",@"15年",@"20年",nil];
        
        sheet.tag = 10004;
        [sheet showInView:self.view];
        
    }

    
}




- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 10001){
        
        if (buttonIndex==0){
            
            self.InsureSex.text = @"男";
        }
        else if (buttonIndex==1) {
            
            self.InsureSex.text = @"女";

        }
    }else if (actionSheet.tag == 10002){
        
        self.InsureAge.text = [NSString stringWithFormat:@"%d",buttonIndex];
        
    }else if (actionSheet.tag == 10003){
        
        
        self.InsureClass.text = @"中意一生保终身重疾险";
        
        
    }else if (actionSheet.tag == 10004){
        
        if (buttonIndex==0){
            
            self.InsureYear.text = @"1年交";
        }
        else if (buttonIndex==1) {
            
            self.InsureYear.text = @"3年交";
            
        }
        else if (buttonIndex==2) {
            
            self.InsureYear.text = @"5年交";
            
        }
        else if (buttonIndex==3) {
            
            self.InsureYear.text = @"10年交";
            
        }
        else if (buttonIndex==4) {
            
            self.InsureYear.text = @"15年交";
            
        }
        else if (buttonIndex==5) {
            
            self.InsureYear.text = @"20年交";
            
        }
        
    }
    
    if ([self.InsureName.text isEqualToString:@""]||[self.InsureSex.text isEqualToString:@""]||[self.InsureAge.text isEqualToString:@""]||[self.Insurecoverage.text isEqualToString:@""]||[self.InsureClass.text isEqualToString:@""]||[self.InsureYear.text isEqualToString:@""]) {
        
        self.Workout.enabled = NO;
        
    }else
    {
        self.Workout.enabled = YES;
    }
    
    
    
}



- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
{
    if (alertView.tag == 10) {
        
        self.Insurecoverage.text = @"";
        
    }else if ( alertView.tag == 100100 ) {
        if ( buttonIndex == 1 ) {
            // 跳转到下载微信的地址
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[WXApi getWXAppInstallUrl]]];
        }else{
            
        }
    }else{
        
        
    }

    
}

//计算
- (void)WorkoutInsure
{
    
    //捞数据；
    
    [self FindData];
    
    
    if ([self.workoverstring.text isEqual:@"0.00"]) {
        
        [self alertWithMessage:@"不符合投保规则，请减少缴费年限！"];
        
        return;
        
    }

    
    [self.view addSubview:self.WorkoverView];
    
    // 动画
    CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    popAnimation.duration = 0.3;
    popAnimation.values = self.m_values;
    popAnimation.keyTimes = self.m_keyTimes;
    popAnimation.timingFunctions = self.m_Funtions;
    
    [self.WorkoverView.layer addAnimation:popAnimation forKey:nil];
    
    
    
}


-(IBAction)Cacle:(id)sender
{
    [self.WorkoverView removeFromSuperview];
    
}




-(void)FindData
{
    
    
        NSString *longplistPath =@"" ;
        NSString *sickplistPath =@"" ;
    
        float longinsure;
        float sickinsure;
    
    
        if ([self.InsureSex.text isEqualToString:@"男"]) {
            
        longplistPath=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/manlong.plist"];
            
        }else if ([self.InsureSex.text isEqualToString:@"女"]){
         
        longplistPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/mansick.plist"];
            
        }
        
        
        for (int i=0; i<=70; i++) {
            
            if ([self.InsureAge.text intValue] ==i) {
                
                for (int j=0; j<=20; j++) {
                    
                    if ([self.InsureYear.text intValue]==j) {
                        
                        
                        NSMutableArray * array = [[NSMutableArray alloc]initWithContentsOfFile:longplistPath];
                        
                        
                        NSMutableDictionary * dic = [array objectAtIndex:i];
                        
                        longinsure = [[dic objectForKey:self.InsureYear.text] floatValue]*10*[self.Insurecoverage.text intValue];
                        
         
                    }
                }
                
            }
            
        }
        

    
    
    
        if ([self.InsureSex.text isEqualToString:@"男"]) {
            
            sickplistPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/mansick.plist"];

            
        }else if ([self.InsureSex.text isEqualToString:@"女"]){
            
            sickplistPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/womansick.plist"];

        }
        
        
        for (int i=0; i<=65; i++) {
            
            if ([self.InsureAge.text intValue] ==i) {
                
                for (int j=0; j<=20; j++) {
                    
                    if ([self.InsureYear.text intValue]==j) {
                        
                        
                        NSMutableArray * array = [[NSMutableArray alloc]initWithContentsOfFile:sickplistPath];
                        
                        NSMutableDictionary * dic = [array objectAtIndex:i];
                        
                        sickinsure = [[dic objectForKey:self.InsureYear.text] floatValue]*10*[self.Insurecoverage.text intValue];
                        
                        
//                         sickinsure= [NSString stringWithFormat:@"%.2f",[[dic objectForKey:self.InsureYear.text] floatValue]*10*[self.Insurecoverage.text intValue]];
                    
                }
                
            }
            
        }
            
    }

        self.workoverstring.text = [NSString stringWithFormat:@"%.2f",longinsure + sickinsure];

}










//我要分享
-(IBAction)Wantshow:(id)sender
{
   
    [self.view addSubview:self.m_showview];
    
    // 动画
    CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    popAnimation.duration = 0.3;
    popAnimation.values = self.m_values;
    popAnimation.keyTimes = self.m_keyTimes;
    popAnimation.timingFunctions = self.m_Funtions;
    
    [self.m_showview.layer addAnimation:popAnimation forKey:nil];
    
    
}






- (IBAction)shareBtnClicked:(id)sender {
    
    [self.m_showview removeFromSuperview];
    
    UIButton *btn = (UIButton *)sender;
    
    if ( btn.tag == 1000 ) {
        //检测是否安装QQ
        if (![self checkIsVaildQQType]) {
            return;
        }
        // qq好友
        tencentOAuth = [[TencentOAuth alloc]initWithAppId:TencentQzoneAppId andDelegate:self];
        
        
        //        http://wx.cityandcity.com/commodity_detail.aspx?svcid=101&mctid=63
        
        
        NSString * utf8String = [NSString stringWithFormat:@"http://wx.cityandcity.com/baoxian/%@/%@$%@$%@$%@$%@$%@$%@$%@$%@",self.Insuremctid,self.InsureMerchantID,self.InsureName.text,self.InsureSex.text,self.InsureAge.text,self.Insurecoverage.text,self.InsureClass.text,self.InsureYear.text,self.workoverstring.text,self.InsureServiceID];
        
        
        
        NSString *title = [NSString stringWithFormat:@"%@",self.InsuresimpleTitle];
        NSString *description =  [NSString stringWithFormat:@"%@",self.InsureTitle];
        
        
        NSString *rateCardsName_CN=[[NSString stringWithFormat:@"%@",utf8String]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

        
        QQApiNewsObject *newsObj = [QQApiNewsObject objectWithURL:[NSURL URLWithString:rateCardsName_CN] title:title description:description previewImageURL:[NSURL URLWithString:[CommonUtil getValueByKey:@"productImage"]]];
        
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
        
        NSString * utf8String = [NSString stringWithFormat:@"http://wx.cityandcity.com/baoxian/%@/%@$%@$%@$%@$%@$%@$%@$%@$%@",self.Insuremctid,self.InsureMerchantID,self.InsureName.text,self.InsureSex.text,self.InsureAge.text,self.Insurecoverage.text,self.InsureClass.text,self.InsureYear.text,self.workoverstring.text,self.InsureServiceID];
        

        NSString *rateCardsName_CN=[[NSString stringWithFormat:@"%@",utf8String]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

        NSString *title = [NSString stringWithFormat:@"%@",self.InsuresimpleTitle];
        NSString *description =  [NSString stringWithFormat:@"%@",self.InsureTitle];
        
        QQApiNewsObject *newsObj = [QQApiNewsObject objectWithURL:[NSURL URLWithString:rateCardsName_CN] title:title description:description previewImageURL:[NSURL URLWithString:[CommonUtil getValueByKey:@"productImage"]]];
        
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
    message.title = [NSString stringWithFormat:@"%@", self.InsuresimpleTitle];
    message.description = [NSString stringWithFormat:@"%@",self.InsureTitle];
    
    NSString *imagePath = [NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:@"productImage"]];
    
    UIImageView *imgV = [[UIImageView alloc]init];
    
    [imgV setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:imagePath]]
                placeholderImage:[UIImage imageNamed:@""]
                         success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                             imgV.image = [CommonUtil scaleImage:image toSize:CGSizeMake(60, 60)];
                             
                             // 微信进行赋值
                             [message setThumbImage:imgV.image];
                             
                             WXWebpageObject *ext = [WXWebpageObject object];
                             
                             
                            NSString *rateCardsName_CN=[[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"http://wx.cityandcity.com/baoxian/%@/%@$%@$%@$%@$%@$%@$%@$%@$%@",self.Insuremctid,self.InsureMerchantID,self.InsureName.text,self.InsureSex.text,self.InsureAge.text,self.Insurecoverage.text,self.InsureClass.text,self.InsureYear.text,self.workoverstring.text,self.InsureServiceID]]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                             
                             ext.webpageUrl  = rateCardsName_CN;
                             
                             
                             


                             
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
    message.title =@"分享";
    message.title = [NSString stringWithFormat:@"%@", self.InsuresimpleTitle];
    message.description = [NSString stringWithFormat:@"%@",self.InsureTitle];
    
    
    NSString *imagePath = [NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:@"productImage"]];
    
    UIImageView *imgV = [[UIImageView alloc]init];
    
    [imgV setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:imagePath]]
                placeholderImage:[UIImage imageNamed:@""]
                         success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                             imgV.image = [CommonUtil scaleImage:image toSize:CGSizeMake(60, 60)];
                             
                             // 微信进行赋值
                             [message setThumbImage:imgV.image];
                             
                             WXWebpageObject *ext = [WXWebpageObject object];
                             
                             
                             NSString *rateCardsName_CN=[[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"http://wx.cityandcity.com/baoxian/%@/%@$%@$%@$%@$%@$%@$%@$%@$%@",self.Insuremctid,self.InsureMerchantID,self.InsureName.text,self.InsureSex.text,self.InsureAge.text,self.Insurecoverage.text,self.InsureClass.text,self.InsureYear.text,self.workoverstring.text,self.InsureServiceID]]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                             
                             ext.webpageUrl  = rateCardsName_CN;
                             
                             
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









-(IBAction)CacleShow:(id)sender
{
    [self.m_showview removeFromSuperview];
    
}










- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
