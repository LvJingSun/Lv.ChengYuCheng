//
//  BasicViewController.m
//  Receive
//
//  Created by 冯海强 on 13-12-31.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//

#import "BasicViewController.h"
#import "RunViewController.h"
#import "SVProgressHUD.h"

@interface BasicViewController ()

@property (nonatomic,weak) IBOutlet UITextField *B_one;//
@property (nonatomic,weak) IBOutlet UIButton *B_one_Btn;//


@property (nonatomic,weak) IBOutlet UITextField *B_two;//
@property (nonatomic,weak) IBOutlet UIButton *B_two_Btn;//

@property (weak, nonatomic) IBOutlet UITextView *B_allname;

@property (weak, nonatomic) IBOutlet UILabel *B_allnameTip;

//@property (nonatomic,weak) IBOutlet UITextField *B_allname;
@property (nonatomic,weak) IBOutlet UITextField *B_smallname;
@property (nonatomic,weak) IBOutlet UITextField *B_phone;
@property (nonatomic,weak) IBOutlet UITextField *B_www;
@property (nonatomic,weak) IBOutlet UITextField *B_tags;
@property (nonatomic,weak) IBOutlet UITextField *B_city;
@property (nonatomic,weak) IBOutlet UIButton *B_city_Btn;//

@property (nonatomic,weak) IBOutlet UITextView *B_jianjie;
@property (nonatomic,weak) IBOutlet UILabel * Business_lab;


@end

@implementation BasicViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.Basicdic=[[NSMutableDictionary alloc]initWithCapacity:0];
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [self hideTabBar:YES];
    
    [self hiddenNumPadDone:nil];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setTitle:@"基本信息"];
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];

    if (iPhone5) {
        
        [self.m_BasicView setContentSize:CGSizeMake(WindowSize.size.width,960)];//滑动范围
    }else{
        
        [self.m_BasicView setContentSize:CGSizeMake(WindowSize.size.width,950)];//滑动范围
    }
    
    
    self.B_jianjie.layer.borderColor =[[UIColor colorWithRed:0 green:0 blue:0 alpha:0.1] CGColor];
    
    self.B_jianjie.layer.borderWidth =1.0;
    
    self.B_jianjie.layer.cornerRadius =5.0;
    
    self.B_city.delegate=self.B_one.delegate=self.B_phone.delegate=self.B_smallname.delegate=self.B_tags.delegate=self.B_two.delegate=self.B_www.delegate=self;
    self.B_allname.delegate=self.B_jianjie.delegate=self;
    
    self.B_one.placeholder=@"商户一级类别*";
    self.B_two.placeholder=@"商户二级类别*";
//    self.B_allname.placeholder=@"商户全称*";
    self.B_smallname.placeholder=@"商户简称*";
    self.B_phone.placeholder=@"联系电话*";
    self.B_www.placeholder=@"商户网站";
    self.B_tags.placeholder=@"商户标签*(多个标签用‘,’区分)";
    self.B_city.placeholder=@"所在城市*";
    
    self.B_one.tag=101;self.B_one_Btn.tag=101;
    self.B_two.tag=102;self.B_two_Btn.tag=102;
    self.B_city.tag=103;self.B_city_Btn.tag=103;
    
    
    [self AddStep1];

}

//如果临时表有数据；插入数据；
-(void)AddStep1
{
        // 判断网络是否存在
        if ( ![self isConnectionAvailable] ) {
            return;
        }
        
        NSString * memberId = [CommonUtil getValueByKey:MEMBER_ID];
        NSString * key = [CommonUtil getServerKey];
        
        AppHttpClient* httpClient = [AppHttpClient sharedClient];
        NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                               memberId,@"memberId",
                               key,@"key",
                               nil];
        
        [SVProgressHUD showWithStatus:@"数据检测中"];
        [httpClient request:@"MerchantAddStep.ashx" parameters:param success:^(NSJSONSerialization* json) {
            BOOL success = [[json valueForKey:@"status"] boolValue];
            [SVProgressHUD dismiss];
            
            if (success) {
                                
                self.Basicdic = [json valueForKey:@"MerchantShopAddStep"];

                self.B_one.text = [self.Basicdic objectForKey:@"FirstClassName"];
                B_onecode = [self.Basicdic objectForKey:@"FirstClassId"];
                
                self.B_two.text = [self.Basicdic objectForKey:@"ClassName"];
                B_twocode = [self.Basicdic objectForKey:@"ClassID"];
                
                self.B_allname.text = [self.Basicdic objectForKey:@"AllName"];
                
                if (self.B_allname.text!=nil||![self.B_allname.text isEqualToString:@""]) {
                    self.B_allnameTip.hidden = YES;
                }
                
                self.B_smallname.text = [self.Basicdic objectForKey:@"Abbreviation"];
                self.B_phone.text = [self.Basicdic objectForKey:@"Tel"];
                self.B_www.text = [self.Basicdic objectForKey:@"WebSite"];
                self.B_tags.text = [self.Basicdic objectForKey:@"MerchantTags"];
                
                self.B_city.text = [self.Basicdic objectForKey:@"CityName"];
                
                self.B_jianjie.text = [self.Basicdic objectForKey:@"BriefIntro"];
                
                if (self.B_jianjie.text!=nil||![self.B_jianjie.text isEqualToString:@""]) {
                    self.Business_lab.hidden = YES;
                }
                
                cityID = [self.Basicdic objectForKey:@"CityID"];
                
            } else {
                
                self.Basicdic = [json valueForKey:@"MerchantShopAddStep"];
                
            }
            
            
        } failure:^(NSError *error) {
            [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        }];
        
   
}

- (void)leftClicked{
    
    [self goBack];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textlegth
{
    if(self.B_one.text.length==0||[self.B_one.text isEqualToString:@""])
    {
    [SVProgressHUD showErrorWithStatus:@"请选择商户一级类别"];
    [self.m_BasicView setContentOffset:CGPointMake(0, 0) animated:YES];
    self.m_BasicView.bouncesZoom = NO;

        return NO;
    }
    else if(self.B_two.text.length==0||[self.B_two.text isEqualToString:@""])
    {
        [SVProgressHUD showErrorWithStatus:@"请选择商户二级类别"];
        [self.m_BasicView setContentOffset:CGPointMake(0, 0) animated:YES];
        self.m_BasicView.bouncesZoom = NO;

        return NO;
    }
    else if(self.B_allname.text.length==0||[self.B_allname.text isEqualToString:@""])
    {
        [SVProgressHUD showErrorWithStatus:@"请填写商户全称"];
        [self.m_BasicView setContentOffset:CGPointMake(0, 0) animated:YES];
        self.m_BasicView.bouncesZoom = NO;
        return NO;
    }
    else if(self.B_smallname.text.length==0||[self.B_smallname.text isEqualToString:@""])
    {
        [SVProgressHUD showErrorWithStatus:@"请填写商户简称"];
        [self.m_BasicView setContentOffset:CGPointMake(0, 160) animated:YES];
        self.m_BasicView.bouncesZoom = NO;

        return NO;
    }
    else if(self.B_phone.text.length==0||[self.B_phone.text isEqualToString:@""])
    {
        [SVProgressHUD showErrorWithStatus:@"请填写联系电话"];
        [self.m_BasicView setContentOffset:CGPointMake(0, 308) animated:YES];
        self.m_BasicView.bouncesZoom = NO;

        return NO;
    }
    else if(self.B_tags.text.length==0||[self.B_tags.text isEqualToString:@""])
    {
        [SVProgressHUD showErrorWithStatus:@"请填写商户标签"];
        [self.m_BasicView setContentOffset:CGPointMake(0, 382) animated:YES];
        self.m_BasicView.bouncesZoom = NO;

        return NO;
    }
    else if(self.B_city.text.length==0||[self.B_city.text isEqualToString:@""])
    {
        [SVProgressHUD showErrorWithStatus:@"请选择所有城市"];
        [self.m_BasicView setContentOffset:CGPointMake(0, 458) animated:YES];
        self.m_BasicView.bouncesZoom = NO;

        return NO;
    }
    else if(self.B_jianjie.text.length==0||[self.B_jianjie.text isEqualToString:@""])
    {
        [SVProgressHUD showErrorWithStatus:@"请填写商户简介"];
        
        if (iPhone5)
        {
            [self.m_BasicView setContentOffset:CGPointMake(0, 458) animated:YES];
        }
        else
        {
            [self.m_BasicView setContentOffset:CGPointMake(0, 535) animated:YES];
        }
        self.m_BasicView.bouncesZoom = NO;
        return NO;
    }
    return YES;
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField;
{
    /*if (textField == self.B_allname)
    {
        [self.m_BasicView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    else*/ if (textField == self.B_smallname)
    {
        [self.m_BasicView setContentOffset:CGPointMake(0, 127) animated:YES];
    }
    else if (textField == self.B_www)
    {
        [self.m_BasicView setContentOffset:CGPointMake(0, 200) animated:YES];
    
    }
    else if (textField == self.B_phone)
    {
        [self.m_BasicView setContentOffset:CGPointMake(0, 275) animated:YES];

    }
    else if (textField == self.B_tags)
    {
        [self.m_BasicView setContentOffset:CGPointMake(0, 350) animated:YES];

    }
   
    self.m_BasicView.bouncesZoom = NO;

    [self hiddenNumPadDone:nil];
    
    return YES;
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ((textField == self.B_www) || (textField == self.B_two)||(textField == self.B_tags)||(textField == self.B_smallname)||(textField == self.B_phone)||(textField == self.B_one)||(textField == self.B_city)/*||(textField == self.B_allname)*/)
    {
        [textField resignFirstResponder];
    }
    return YES;
    
}



- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *Numbers=@"0123456789\n-";
    NSCharacterSet *cs;
    if(textField == self.B_phone)
    {
        cs = [[NSCharacterSet characterSetWithCharactersInString:Numbers] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        BOOL basicTest = [string isEqualToString:filtered];
        if(!basicTest)
        {
            [SVProgressHUD showErrorWithStatus:@"请正确输入!"];
            return NO;
        }
    }
    
    //其他的类型不需要检测，直接写入
    return YES;
}

-(void)closeallkey
{
    
    [self.B_allname resignFirstResponder];
    [self.B_city resignFirstResponder];
    [self.B_jianjie resignFirstResponder];
    [self.B_one resignFirstResponder];
    [self.B_phone resignFirstResponder];
    [self.B_smallname resignFirstResponder];
    [self.B_tags resignFirstResponder];
    [self.B_two resignFirstResponder];
    [self.B_www resignFirstResponder];
    
}


- (void)textViewDidBeginEditing:(UITextView *)textView;
{
    if (iPhone5)
    {
        [self.m_BasicView setContentOffset:CGPointMake(0, 458) animated:YES];
    }
    else
    {
        [self.m_BasicView setContentOffset:CGPointMake(0, 535) animated:YES];
    }
    
    [self hiddenNumPadDone:nil];
    self.m_BasicView.bouncesZoom = NO;

}


-(void)textViewDidChange:(UITextView *)textView
{
    if (textView == self.B_jianjie) {
       
//        self.B_jianjie.text =  textView.text;
        if (textView.text.length == 0) {
            self.Business_lab.text = @"商户简介*";
            
        }else{
            self.Business_lab.text = @"";
        }
        
    }else if (textView == self.B_allname){
        
//        self.B_allname.text =  textView.text;
        if (textView.text.length == 0) {
            self.B_allnameTip.text = @"全称*";
            
        }else{
            self.B_allnameTip.text = @"";
        }
    }
    
}

- (void)textViewDidEndEditing:(UITextView *)textView {

    if (textView == self.B_jianjie) {
        
        self.B_jianjie.text =  textView.text;
        
    }else if (textView == self.B_allname) {
    
        self.B_allname.text =  textView.text;
        
    }
}


//////////////
- (void)ChosesoneValue:(NSString *)value code:(NSString *)onecode
{
    if ([self.B_one.text isEqualToString:value]) {
        return;
    }
    self.B_one.text = value;
    B_onecode = onecode;
    
    self.B_two.text = @"";
    B_twocode = @"";
    
}

/////////////
- (void)ChosestwoValue:(NSString *)value code:(NSString *)twocode
{
    if ([self.B_two.text isEqualToString:value]) {
        return;
    }
    self.B_two.text = value;
    B_twocode = twocode;
    
}

- (void)ChosescityValue:(NSString *)value code:(NSString *)citycode
{
    if ([self.B_city.text isEqualToString:value]) {
        return;
    }
    self.B_city.text =  value;
    cityID = citycode;
    
}



//button
-(IBAction)textfieldChose:(UIButton*)sender
{
    [self closeallkey];
    
    if (sender.tag==101)
    {
        
        DowncellViewController*downVC=[[DowncellViewController alloc]initWithNibName:@"DowncellViewController" bundle:nil];
        downVC.Itemstyle = @"B_one";
        
        downVC.Chosedelegate = self;
        
        [self.navigationController pushViewController:downVC animated:YES];

    }else if (sender.tag==102)
    {
        
        if (self.B_one.text==nil||[self.B_one.text isEqualToString:@""])
        {
            [SVProgressHUD showErrorWithStatus:@"请先选择一级类别"];
            return;
        }
        
        DowncellViewController*downVC=[[DowncellViewController alloc]initWithNibName:@"DowncellViewController" bundle:nil];
        downVC.Itemstyle = @"B_two";
        downVC.Needtwo = B_onecode;

        downVC.Chosedelegate = self;

        [self.navigationController pushViewController:downVC animated:YES];

    }
    else if (sender.tag==103)
    {
        DowncellViewController*downVC=[[DowncellViewController alloc]initWithNibName:@"DowncellViewController" bundle:nil];

        downVC.Itemstyle = @"B_city";

        downVC.Chosedelegate = self;

        [self.navigationController pushViewController:downVC animated:YES];

    }
    
}


-(void)SaveToDic
{
 
//    [self.Basicdic setObject:B_twocode forKey:@"F.Basic.B_two"];
//    [self.Basicdic setObject:self.B_allname.text forKey:@"F.Basic.B_allname"];
//    [self.Basicdic setObject:self.B_smallname.text forKey:@"F.Basic.B_smallname"];
//    [self.Basicdic setObject:self.B_phone.text forKey:@"F.Basic.B_phone"];
//    if ([self.B_www.text isEqualToString:@""]||self.B_www.text==nil)
//    {
//        [self.Basicdic setObject:@"" forKey:@"F.Basic.B_www"];
//    }else
//    {
//        [self.Basicdic setObject:self.B_www.text forKey:@"F.Basic.B_www"];
//    }
//    [self.Basicdic setObject:self.B_tags.text forKey:@"F.Basic.B_tags"];
//    [self.Basicdic setObject:cityID forKey:@"F.Basic.B_city"];
//    [self.Basicdic setObject:self.B_jianjie.text forKey:@"F.Basic.B_jianjie"];
    
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        return;
    }
    
    NSString * memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString * MerchantID = [self.Basicdic objectForKey:@"MerchantId"];
    NSString * key = [CommonUtil getServerKey];
    NSString * classId =B_twocode;
    NSString * allName =self.B_allname.text;
    NSString * abbreviation =self.B_smallname.text;
    NSString * webSite;
    if ([self.B_www.text isEqualToString:@""]||self.B_www.text==nil)
    {
        webSite =@"";
    }else
    {
        webSite =self.B_www.text;
    }
    NSString * tel =self.B_phone.text;
    NSString * merchantTags =self.B_tags.text;
    NSString * city_ID =cityID;
    NSString * briefIntro =self.B_jianjie.text;
    
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"memberId",
                           MerchantID,@"merchantID",
                           key,@"key",
                           classId,@"classID",
                           allName,@"allName",
                           abbreviation,@"abbreviation",
                           webSite,@"webSite",
                           tel,@"tel",
                           merchantTags,@"merchantTags",
                           city_ID,@"cityID",
                           briefIntro,@"briefIntro",
                           nil];
    
    [SVProgressHUD showWithStatus:@"数据提交中"];
    
    [httpClient request:@"MerchantAddStep1.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            [SVProgressHUD dismiss];
            
            RunViewController *RunVC=[[RunViewController alloc]initWithNibName:@"RunViewController" bundle:nil];
                        
            [self.navigationController pushViewController:RunVC animated:YES];
            
        } else {
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];
    

    
}





-(IBAction)TwoNextToThree:(id)sender
{
    [self closeallkey];

   if ([self textlegth])
    {
    
    [self SaveToDic];
    
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
    
}

@end
