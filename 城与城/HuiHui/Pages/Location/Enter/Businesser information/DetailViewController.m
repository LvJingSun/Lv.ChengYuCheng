//
//  DetailViewController.m
//  Receive
//
//  Created by 冯海强 on 13-12-27.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//

#import "DetailViewController.h"
#import "BshoplistsViewController.h"
#import "BusinessOutletsViewController.h"
#import "CommonUtil.h"
#import "SVProgressHUD.h"
#import "AppHttpClient.h"
#import "UIImageView+AFNetworking.h"
#import "RightCell.h"

@interface DetailViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *DetailScroview;

@property (weak, nonatomic) IBOutlet UIView *m_identityView;//身份证视图

//Businesser info
@property (nonatomic,weak) IBOutlet UITextField *B_one;//一级类别
@property (nonatomic,weak) IBOutlet UIButton *B_one_Btn;

@property (nonatomic,weak) IBOutlet UITextField *B_two;//二级类别
@property (nonatomic,weak) IBOutlet UIButton *B_two_Btn;

@property (nonatomic,weak) IBOutlet UITextField *B_allname;
@property (nonatomic,weak) IBOutlet UITextField *B_smallname;
@property (nonatomic,weak) IBOutlet UITextField *B_phone;
@property (nonatomic,weak) IBOutlet UITextField *B_www;
@property (nonatomic,weak) IBOutlet UITextField *B_tag;
@property (nonatomic,weak) IBOutlet UITextField *B_city;
@property (nonatomic,weak) IBOutlet UIButton *B_city_Btn;

@property (nonatomic,weak) IBOutlet UITextView *jianjie;//简介
@property (nonatomic,weak) IBOutlet UILabel *jianjielabel;//简介label

//run info
@property (nonatomic,weak) IBOutlet UITextField *R_yinye;//
@property (nonatomic,weak) IBOutlet UITextField *R_shuiwu;//
@property (nonatomic,weak) IBOutlet UITextField *R_fanren;
@property (nonatomic,weak) IBOutlet UITextField *R_likeman;//联系人
@property (nonatomic,weak) IBOutlet UITextField *R_moneypeople;
@property (nonatomic,weak) IBOutlet UITextField *R_moneyphone;//财务手机
@property (nonatomic,weak) IBOutlet UITextField *R_fax;//传真
@property (nonatomic,weak) IBOutlet UITextField *R_e_mail;
@property (nonatomic,weak) IBOutlet UITextField *R_farenphone;
//account
@property (nonatomic,weak) IBOutlet UITextField *A_leixing;//类型
@property (nonatomic,weak) IBOutlet UIButton *A_leixing_Btn;//类型

@property (nonatomic,weak) IBOutlet UITextField *A_bank;//银行
@property (nonatomic,weak) IBOutlet UIButton *A_bank_Btn;

@property (nonatomic,weak) IBOutlet UITextField *A_branch;//网点
@property (nonatomic,weak) IBOutlet UIButton *A_branch_Btn;

@property (nonatomic,weak) IBOutlet UITextField *A_name;//户名
@property (nonatomic,weak) IBOutlet UITextField *A_bamknum;//卡号
@property (nonatomic,weak) IBOutlet UITextField *A_identity;//身份证号
//other
@property (nonatomic,weak) IBOutlet UIButton *O_logo;//logo
//@property (nonatomic,weak) IBOutlet UIButton *O_application;//申请表
@property (nonatomic,weak) IBOutlet UIButton *O_license;//营业执照

@property (nonatomic,weak) IBOutlet UIButton *SaveBtn;

@property (nonatomic,weak) IBOutlet UIButton *PUT;
@property (nonatomic,weak) IBOutlet UIButton *Dele;
// 会员模式的按钮
@property (weak, nonatomic) IBOutlet UIButton *m_accountType;


@property (weak, nonatomic) IBOutlet UIControl *m_alphaView;

@property (weak, nonatomic) IBOutlet TableViewWithBlock *m_modelTableView;



// 选择会员模式按钮触发的事件
- (IBAction)chooseAccountTypeClicked:(id)sender;

// 点击背景触发的事件
- (IBAction)controlTap:(id)sender;


@end

@implementation DetailViewController

@synthesize m_modelArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        dbhelp = [[DBHelper alloc] init];
        self.Logoimagedic =[[NSMutableDictionary alloc]initWithCapacity:0];
        self.faxDic=[[NSMutableDictionary alloc]initWithCapacity:0];

        m_modelArray = [[NSMutableArray alloc]initWithCapacity:0];
        
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [self hideTabBar:YES];
    
    [self hiddenNumPadDone:nil];
    
    
    rightOpened = NO;
    self.m_modelTableView.hidden = YES;
    CGRect frame4 = self.m_modelTableView.frame;
    //    frame4.size.height = 0.0f;
    frame4 = CGRectMake(0, 40,  WindowSizeWidth, 0);
    
    [self.m_modelTableView setFrame:frame4];
    
    self.m_alphaView.alpha = 0;

}




- (void)viewDidLoad
{
    [super viewDidLoad];
    self.SaveBtn.tag=10001;
    self.A_leixing_Btn.tag=1002;
    
    self.B_one_Btn.tag=101;
    self.B_two_Btn.tag=102;
    self.B_city_Btn.tag=103;
    self.A_bank_Btn.tag=201;
    self.A_branch_Btn.tag=202;
    
    self.PUT.tag=1;
    self.Dele.tag=2;
    
    self.B_one.placeholder=@"商户一级类别";
    self.B_two.placeholder=@"商户二级类别";

    
    self.B_one.delegate= self.B_two.delegate  = self.B_allname.delegate= self.B_city.delegate= self.B_phone.delegate= self.B_smallname.delegate= self.B_tag.delegate= self.B_www.delegate= self.R_e_mail.delegate= self.R_fanren.delegate= self.R_farenphone.delegate= self.R_fax.delegate= self.R_likeman.delegate= self.R_moneypeople.delegate= self.R_moneyphone.delegate= self.R_shuiwu.delegate= self.R_yinye.delegate= self.A_bamknum.delegate= self.A_bank.delegate= self.A_branch.delegate= self.A_identity.delegate= self.A_leixing.delegate= self.A_name.delegate=self;
    
    self.jianjie.delegate=self;
    self.jianjie.tag=1000;

    self.jianjie.layer.borderWidth=0;
    
    [self setTitle:@"商户详细信息"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];

    [self setRightButtonWithTitle:@"店铺" action:@selector(PUSHshop)];

    [self.DetailScroview setContentSize:CGSizeMake(WindowSizeWidth,1752)];
    
    self.jianjie.layer.borderColor =[[UIColor colorWithRed:0 green:0 blue:0 alpha:0.1] CGColor];
    
    self.jianjie.layer.borderWidth =1.0;
    
    self.jianjie.layer.cornerRadius =5.0;
    
    [self Detailfax];
    
    if ([self.Iscanchange isEqualToString:@"1"]) {
        self.remindlabel.text=@"请尽快完成资料，提交审核！";
    }
    else  if ([self.Iscanchange isEqualToString:@"2"]||[self.Iscanchange isEqualToString:@"3"]||[self.Iscanchange isEqualToString:@"4"])
    {
        [self allenableno];
        self.jianjie.editable=NO;
        self.remindlabel.text=@"商户此状态下不能修改信息哦！";
    }
     else if ([self.Iscanchange isEqualToString:@"5"]) {
        self.remindlabel.textColor=[UIColor redColor];
        self.remindlabel.text=[NSString stringWithFormat:@"%@%@",@"原因:",[self.faxDic objectForKey:@"Description"]];
    }
    
    NSLog(@"Iscanchange = %@",self.Iscanchange);
    
    NSLog(@"faxDic = %@",self.faxDic);
    
    // 已签约的情况下才能选择会员模式
    if ( [self.Iscanchange isEqualToString:@"3"] ) {
        
        self.m_accountType.hidden = NO;
        
        rightOpened = NO;
        self.m_alphaView.alpha = 0;
        
        NSString *modelType = [NSString stringWithFormat:@"%@",[self.faxDic objectForKey:@"CloudMenuModelName"]];
        // 根据值来对btn进行赋值
        
//        if ( modelType.length != 0 ) {
//           
//            [self.m_accountType setTitle:modelType forState:UIControlStateNormal];
//        
//        }else{
//            
//            [self.m_accountType setTitle:@"请选择会员模式" forState:UIControlStateNormal];
//
//        }

        [self.m_accountType setTitle:modelType forState:UIControlStateNormal];

        
        
        //
        
        
        // 请求会员模式的数据
        [self modelDataRequestSubmit];
        
    }else{
        
        self.m_accountType.hidden = YES;

        self.m_alphaView.alpha = 0;

    }
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)leftClicked{
    
    [self goBack];
    
}


-(void)allenableno
{

    //Businesser info
    self.B_one_Btn.enabled=self.B_two_Btn.enabled=self.B_city_Btn.enabled=self.A_bank_Btn.enabled=self.A_branch_Btn.enabled=self.O_logo.enabled=self.O_license.enabled=NO;self.A_leixing_Btn.enabled=NO;
    
    self.SaveBtn.hidden=YES;self.PUT.hidden=YES;self.Dele.hidden=YES;
    
    self.jianjie.editable=NO;
    self.B_allname.enabled=self.B_smallname.enabled=self.B_phone.enabled=self.B_www.enabled=self.B_tag.enabled=self.B_one.enabled=self.B_two.enabled=self.B_city.enabled=self.R_e_mail.enabled=self.R_fanren.enabled=self.R_farenphone.enabled=self.R_fax.enabled=self.R_likeman.enabled=self.R_moneypeople.enabled=self.R_moneyphone.enabled=self.R_shuiwu.enabled=self.R_yinye.enabled=self.A_leixing.enabled=self.A_bank.enabled=self.A_branch.enabled=self.A_name.enabled=self.A_bamknum.enabled=self.A_identity.enabled=NO;

}




-(void)Detailfax
{
    
    B_MerchantID =[self.faxDic objectForKey:@"MerchantID"];
    
    [[NSUserDefaults standardUserDefaults] setObject:B_MerchantID forKey:@"DB_MerchantID"];//详细信息商户ID；

    if ([self.faxDic objectForKey:@"ClassParentID"]!=nil) {
        B_onecode =[self.faxDic objectForKey:@"ClassParentID"];
    }
    self.B_one.text=[NSString stringWithFormat:@"%@",[self.faxDic objectForKey:@"ClassParentName"]];
    self.B_two.text=[NSString stringWithFormat:@"%@",[self.faxDic objectForKey:@"ClassName"]];
    B_twocode = [self.faxDic objectForKey:@"ClassID"];
    self.B_allname.text=[NSString stringWithFormat:@"%@",[self.faxDic objectForKey:@"AllName"]];
    self.B_smallname.text=[NSString stringWithFormat:@"%@",[self.faxDic objectForKey:@"Abbreviation"]];
    self.B_phone.text=[NSString stringWithFormat:@"%@",[self.faxDic objectForKey:@"Tel"]];
    self.B_www.text=[NSString stringWithFormat:@"%@",[self.faxDic objectForKey:@"WebSite"]];
    self.B_tag.text=[NSString stringWithFormat:@"%@",[self.faxDic objectForKey:@"MerchantTags"]];
    self.B_city.text=[NSString stringWithFormat:@"%@",[self.faxDic objectForKey:@"CityName"]];
    cityID =[self.faxDic objectForKey:@"CityID"];
    self.jianjie.text=[NSString stringWithFormat:@"%@",[self.faxDic objectForKey:@"BriefIntro"]];
    if (self.jianjie.text!=nil) {
        self.jianjielabel.hidden=YES;
    }
    self.R_yinye.text=[NSString stringWithFormat:@"%@",[self.faxDic objectForKey:@"BusinessLicense"]];
    self.R_shuiwu.text=[NSString stringWithFormat:@"%@",[self.faxDic objectForKey:@"TaxCertificate"]];
    self.R_fanren.text=[NSString stringWithFormat:@"%@",[self.faxDic objectForKey:@"Legal"]];
    self.R_likeman.text=[NSString stringWithFormat:@"%@",[self.faxDic objectForKey:@"OfficialContacts"]];
    self.R_moneypeople.text=[NSString stringWithFormat:@"%@",[self.faxDic objectForKey:@"Treasurer"]];
    self.R_moneyphone.text=[NSString stringWithFormat:@"%@",[self.faxDic objectForKey:@"TreasurerPhone"]];
    self.R_fax.text=[NSString stringWithFormat:@"%@",[self.faxDic objectForKey:@"Fax"]];
    self.R_e_mail.text=[NSString stringWithFormat:@"%@",[self.faxDic objectForKey:@"OfficialMail"]];
    self.R_farenphone.text=[NSString stringWithFormat:@"%@",[self.faxDic objectForKey:@"OfficialContactsPhone"]];
    if ([[NSString stringWithFormat:@"%@",[self.faxDic objectForKey:@"AccountCategory"]]isEqualToString:@"1"]) {
      self.A_leixing.text=@"个人账户";
    }else  if ([[NSString stringWithFormat:@"%@",[self.faxDic objectForKey:@"AccountCategory"]]isEqualToString:@"2"]) {
        self.A_leixing.text=@"信用卡账户";
    }else  if ([[NSString stringWithFormat:@"%@",[self.faxDic objectForKey:@"AccountCategory"]]isEqualToString:@"3"]) {
        self.A_leixing.text=@"对公账户";
        self.m_identityView.hidden=YES;
    }
    
    
    if ([[NSString stringWithFormat:@"%@",[self.faxDic objectForKey:@"BankCode"]]isEqualToString:@"<null>"] )
    {
        Bankcodestring =@"";
    }else
    {
        Bankcodestring = [self.faxDic objectForKey:@"BankCode"];
    }
    if ([[NSString stringWithFormat:@"%@",[self.faxDic objectForKey:@"BranchCode"]]isEqualToString:@"<null>"] )
    {
        Brachcodestring =@"";
    }else
    {
        Brachcodestring = [self.faxDic objectForKey:@"BranchCode"];
    }
    
    
    if ([[NSString stringWithFormat:@"%@",[self.faxDic objectForKey:@"BankName"]]isEqualToString:@"<null>"])
    {
        self.A_bank.text=@"";
    }else
    {
        self.A_bank.text=[NSString stringWithFormat:@"%@",[self.faxDic objectForKey:@"BankName"]];
    }
    if ([[NSString stringWithFormat:@"%@",[self.faxDic objectForKey:@"BranchName"]] isEqualToString:@"<null>"])
    {
        self.A_branch.text=@"";
    }else
    {
        self.A_branch.text=[NSString stringWithFormat:@"%@",[self.faxDic objectForKey:@"BranchName"]];
    }
    if ([[NSString stringWithFormat:@"%@",[self.faxDic objectForKey:@"Name"]] isEqualToString:@"<null>"])
    {
        self.A_name.text=@"";
    }else
    {
        self.A_name.text=[NSString stringWithFormat:@"%@",[self.faxDic objectForKey:@"Name"]];
    }
    if ([[NSString stringWithFormat:@"%@",[self.faxDic objectForKey:@"CardNumber"]] isEqualToString:@"<null>"])
    {
        self.A_bamknum.text=@"";
    }else
    {
        self.A_bamknum.text=[NSString stringWithFormat:@"%@",[self.faxDic objectForKey:@"CardNumber"]];
    }
    if ([[NSString stringWithFormat:@"%@",[self.faxDic objectForKey:@"IDCard"]] isEqualToString:@"<null>"])
    {
        self.A_identity.text=@"";
    }else
    {
        self.A_identity.text=[NSString stringWithFormat:@"%@",[self.faxDic objectForKey:@"IDCard"]];
    }
    
    [self setImageView:[NSString stringWithFormat:@"%@",[self.faxDic objectForKey:@"Logo"]] whichbtn:@"1"];
    [self setImageView:[NSString stringWithFormat:@"%@",[self.faxDic objectForKey:@"BusinessLicensePhoto"]] whichbtn:@"3"];


}

- (void)setImageView:(NSString *)imagePath whichbtn:(NSString*)Btnstr{

    UIImage *reSizeImage = [self.imageCache getImage:imagePath];
    if (reSizeImage != nil)
    {
        if ([Btnstr isEqualToString:@"1"])
        {
            [self.O_logo setImage: reSizeImage forState:UIControlStateNormal];
            return;
        }else if ([Btnstr isEqualToString:@"3"])
        {
            [self.O_license setImage: reSizeImage forState:UIControlStateNormal];
            return;
        }
    }
    UIImageView*imv=[[UIImageView alloc]init];
    [imv setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",imagePath]]] placeholderImage:[UIImage imageNamed:@""] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 230,150)];
        [self.imageCache addImage:imgV.image andUrl:imagePath];
        if ([Btnstr isEqualToString:@"1"])
        {
            [self.O_logo setImage: [CommonUtil scaleImage:image toSize:CGSizeMake(230, 150)]forState:UIControlStateNormal];
            [self.Logoimagedic setValue:[self getImageData:self.O_logo.imageView] forKey:@"logoUrl"];

            
            UIImageView *imgV1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 136,136)];
            imgV1.image =  [CommonUtil scaleImage:image toSize:CGSizeMake(136, 136)];
            
            UIImageView *imgV2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 80,80)];
            imgV2.image = [CommonUtil scaleImage:image toSize:CGSizeMake(80, 80)];
            
            UIImageView *imgV3 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 68,68)];
            imgV3.image = [CommonUtil scaleImage:image toSize:CGSizeMake(68, 68)];
            
            [self.Logoimagedic setValue:[self getImageData:imgV1] forKey:@"logoBigUrl"];
            [self.Logoimagedic setValue:[self getImageData:imgV2] forKey:@"logoMidUrl"];
            [self.Logoimagedic setValue:[self getImageData:imgV3] forKey:@"logoSmllUrl"];


            return;
        }else if ([Btnstr isEqualToString:@"3"])
        {
            [self.O_license setImage: [CommonUtil scaleImage:image toSize:CGSizeMake(230, 150)] forState:UIControlStateNormal];
            
            [self.Logoimagedic setValue:[self getImageData:self.O_license.imageView] forKey:@"businessLicensePhotoUrl"];
            


            return;
        }

    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        
    }];
 
}
-(void)closekey
{
    
    [self.B_one resignFirstResponder];
    [self.B_two resignFirstResponder];
    
    [self.B_allname resignFirstResponder];
    [self.B_smallname resignFirstResponder];
    [self.B_phone resignFirstResponder];
    [self.B_www resignFirstResponder];
    [self.B_tag resignFirstResponder];
    
    [self.B_city resignFirstResponder];
    [self.jianjie resignFirstResponder];
    [self.R_yinye resignFirstResponder];
    [self.R_shuiwu resignFirstResponder];
    [self.R_fanren resignFirstResponder];
    [self.R_likeman resignFirstResponder];
    
    [self.R_moneypeople resignFirstResponder];
    [self.R_moneyphone resignFirstResponder];
    [self.R_fax resignFirstResponder];
    [self.R_e_mail resignFirstResponder];
    [self.R_farenphone resignFirstResponder];
    
    [self.A_leixing resignFirstResponder];
    [self.A_bank resignFirstResponder];
    [self.A_branch resignFirstResponder];
    [self.A_name resignFirstResponder];
    [self.A_bamknum resignFirstResponder];
    
    [self.A_identity resignFirstResponder];
  

}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ((textField == self.B_one)||(textField == self.B_two)||(textField == self.B_allname)||(textField == self.B_city)||(textField == self.B_phone)||(textField == self.B_smallname)||(textField == self.B_tag)||(textField == self.B_www)||(textField == self.R_e_mail)||(textField == self.R_fanren)||(textField == self.R_farenphone)||(textField == self.R_fax)||(textField == self.R_likeman)||(textField == self.R_moneypeople)||(textField == self.R_moneyphone)||(textField == self.R_shuiwu)||(textField == self.R_yinye)||(textField == self.A_bamknum)||(textField == self.A_bank)||(textField == self.A_branch)||(textField == self.A_identity)||(textField == self.A_leixing)||(textField == self.A_name))
    {
        [textField resignFirstResponder];
    }
    return YES;
}

#define NUMBERS @"0123456789\n-x"

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSCharacterSet *cs;
    if((textField == self.B_phone)||(textField == self.R_farenphone)||(textField == self.R_fax)||(textField == self.R_moneyphone)||(textField == self.R_yinye)||(textField == self.A_bamknum)||(textField == self.A_identity))
    {
        cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS] invertedSet];
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

- (void)textFieldDidEndEditing:(UITextField *)textField;
{
    
    if (textField==self.R_e_mail)
    {
        if (![self isValidateEmail:self.R_e_mail.text])
        {
            [SVProgressHUD showErrorWithStatus:@"请正确输入您的邮箱格式!"];
        }
    }
    
}


-(void)textViewDidChange:(UITextView *)textView
{
    self.jianjielabel.text =  textView.text;
    if (textView.text.length == 0) {
        self.jianjielabel.text = @"商户简介";
        
    }else{
        self.jianjielabel.text = @"";
    }
}


-(IBAction)textfieldChoseButton:(UIButton*)sender
{
    [self closekey];
    
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
//        [self loadCategoryView];
        
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

    }else if (sender.tag==201)
    {
        
        DowncellViewController*downVC=[[DowncellViewController alloc]initWithNibName:@"DowncellViewController" bundle:nil];

        downVC.Itemstyle = @"ChoseBank";
        downVC.Chosedelegate = self;

        [self.navigationController pushViewController:downVC animated:YES];

    }else if (sender.tag==202)
    {
        
        if (self.A_bank.text==nil||[self.A_bank.text isEqualToString:@""])
        {
            [SVProgressHUD showErrorWithStatus:@"请先选择银行"];
            return;
        }
        
        NSMutableArray*code = [[NSMutableArray alloc] initWithObjects:@"0100",@"0102",@"0103",@"0104",@"0105",@"0302",@"0303",@"0305",@"0306",@"0308",@"0309",nil];
        NSMutableArray * name=[[NSMutableArray alloc]init];
        [name addObject:@"邮储银行"];
        [name addObject:@"中国工商银行"];
        [name addObject:@"中国农业银行"];
        [name addObject:@"中国银行"];
        [name addObject:@"中国建设银行"];
        [name addObject:@"中信银行"];
        [name addObject:@"中国光大银行"];
        [name addObject:@"中国民生银行"];
        [name addObject:@"广东发展银行"];
        [name addObject:@"招商银行"];
        [name addObject:@"兴业银行"];
        
        for (int i=0;i<name.count;i++)
        {
            if ([self.A_bank.text isEqualToString:[name objectAtIndex:i]])
            {
                Bankcodestring = [code objectAtIndex:i];
                break;
            }
        }
        

        BusinessOutletsViewController*OutletsVC=[[BusinessOutletsViewController alloc]initWithNibName:@"BusinessOutletsViewController" bundle:nil];
        OutletsVC.brachEnter = @"brachEnter";
        OutletsVC.bankCode = Bankcodestring;
        OutletsVC.ChoseBrachdelegate = self;
        
        [self.navigationController pushViewController:OutletsVC animated:YES];
        
    }else if (sender.tag==1002)
    {
        
        UIActionSheet *sheet;
        
        sheet  = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"对公账户",@"个人账户", nil];
        sheet.tag = 2;
        [sheet showInView:self.view];
    }
    
 
}


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

//代理传值银行
- (void)ChosesValue:(NSString *)value Bankcode:(NSString *)Bankcode;
{
    if ([self.A_bank.text isEqualToString:value]) {
        return;
    }
    self.A_bank.text = value;
    Bankcodestring = Bankcode;
    
    self.A_branch.text = @"";
    Brachcodestring =@"";
}

//网点
- (void)ChosesBrachValue:(NSString *)value Brachcode:(NSString *)Brachcode
{
    if ([self.A_branch.text isEqualToString:value]) {
        return;
    }
    self.A_branch.text = value;
    Brachcodestring =Brachcode;
    
}


-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag==2)
    {
        if (buttonIndex==0)
        {
            self.A_leixing.text=@"对公账户";
            self.m_identityView.hidden=YES;
            
        }
        if (buttonIndex==1)
        {
            self.A_leixing.text=@"个人账户";
            self.m_identityView.hidden=NO;

        }
        
    }
    else if (actionSheet.tag==101)
    {
        //打开照相
        if (buttonIndex==0)
        {
            pickerorphoto=1;
            if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
                UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
                imagePicker.delegate = self;
                //imagePicker.allowsImageEditing = YES;
                imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                
                
                [self presentViewController:imagePicker animated:YES completion:^{}];
            }
            else{
                //如果没有提示用户
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"错误" message:@"手机没有摄像头" delegate:nil cancelButtonTitle:@"确定!" otherButtonTitles:nil];
                [alert show];
            }
        }
        
        //打开相册
        if (buttonIndex == 1) {
            pickerorphoto=0;
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];//打开照片文件
            imagePicker.delegate = self;
            imagePicker.allowsEditing = YES;
            [self presentViewController:imagePicker animated:YES completion:^{
                
            }];
            
        }
    }
    
}



-(IBAction)uploadlogo:(id)sender
{
    UIActionSheet *sheet;
    
    sheet  = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"马上拍照",@"相册选取", nil];
    
    sheet.tag = 101;
    [sheet showInView:self.view];
    whichBtn=1;
    
}





-(IBAction)uploadphoto:(id)sender
{
    UIActionSheet *sheet;
    
    sheet  = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"马上拍照",@"相册选取", nil];
    
    sheet.tag = 101;
    [sheet showInView:self.view];
    whichBtn=3;
    
}


#pragma mark - 保存图片至沙盒
- (void) saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.5);
    // 获取沙盒目录
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    // 将图片写入文件
    [imageData writeToFile:fullPath atomically:NO];
}


#pragma mark - image picker delegte

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
	[picker dismissViewControllerAnimated:YES completion:^{}];
    UIImage *image=[[UIImage alloc]init];
    if (pickerorphoto==0)
    {
        image = [info objectForKey:UIImagePickerControllerEditedImage];
    }else if (pickerorphoto==1)
    {
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    [self saveImage:image withName:@"currentImage.png"];
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"currentImage.png"];
    UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
    UIImage *scaleImage = [self scaleImage:savedImage toScale:0.3];
    
    if (whichBtn==1)
    {
        [self.O_logo setImage:scaleImage forState:UIControlStateNormal];
    }
//    else if (whichBtn==2)
//    {
//        [self.O_application setImage:scaleImage forState:UIControlStateNormal];
//    }
    else if (whichBtn==3)
    {
        [self.O_license setImage:scaleImage forState:UIControlStateNormal];
    }
    
}


- (NSData *)getImageData:(UIImageView *)imageView {
    UIImage *iamge = imageView.image;
    return UIImageJPEGRepresentation(iamge, 1);
}

-(UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize {
    
    // 将图片存储在字典里
    UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 230,150)];
    imgV.image = [CommonUtil scaleImage:image toSize:CGSizeMake(230,150)];
    
    UIImageView *imgV1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 136,136)];
    imgV1.image = [CommonUtil scaleImage:image toSize:CGSizeMake(136,136)];
    
    UIImageView *imgV2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 80,80)];
    imgV2.image = [CommonUtil scaleImage:image toSize:CGSizeMake(80,80)];
    
    UIImageView *imgV3 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 68,68)];
    imgV3.image = [CommonUtil scaleImage:image toSize:CGSizeMake(68,68)];
    
    if (whichBtn==1)
    {
        
    [self.Logoimagedic setValue:[self getImageData:imgV] forKey:@"logoUrl"];
    [self.Logoimagedic setValue:[self getImageData:imgV1] forKey:@"logoBigUrl"];
    [self.Logoimagedic setValue:[self getImageData:imgV2] forKey:@"logoMidUrl"];
    [self.Logoimagedic setValue:[self getImageData:imgV3] forKey:@"logoSmllUrl"];

    }
    else if (whichBtn==3)
    {
    [self.Logoimagedic setValue:[self getImageData:imgV] forKey:@"businessLicensePhotoUrl"];
    }
    
    // 计算图片显示的大小
    float height = image.size.width / 230.0f;
    UIGraphicsBeginImageContext(CGSizeMake(230,image.size.height / height));
    [image drawInRect:CGRectMake(0, 0, 230, image.size.height / height)];
    
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return scaledImage;
    
}




-(void)PUSHshop
{
    
 
    NSLog(@"self.Iscanchange = %@",self.Iscanchange);

    // 保存起来用于后面店铺里面座位的选择设置
    [CommonUtil addValue:self.Iscanchange andKey:@"IscanchangeKey"];
        
    [self closekey];
    
    BshoplistsViewController*SListVC=[[BshoplistsViewController alloc]initWithNibName:@"BshoplistsViewController" bundle:nil];
    
    SListVC.merchantId = B_MerchantID;
    
    [self.navigationController pushViewController:SListVC animated:YES];
   
}



- (void)savedatatoserver;
{
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    NSString *memberId; NSString *merchantId;NSString *classId;NSString *cityId;
    NSString *allName;NSString*abbreviation;NSString *tel;NSString *website;NSString *merchanttags;
    NSString *briefintro;NSString *businessLicense;NSString *taxCertificate;
    
    NSString *officialContacts; NSString *legal;NSString *officialContactsPhone;NSString *treasurer;
    NSString *treasurerPhone;NSString*fax;NSString *memberBankCard;NSString *memberBankCardId;NSString *accountCategory;
    NSString *bankId;NSString *bankCode;NSString *bankName;NSString *officialmail;
    
    NSString *branchCode; NSString *branchName;NSString *cardNumber;NSString *iDCard;
    NSString *name;NSString*phone;NSString *provinceId;NSString *cityCode;NSString *key;
    
    merchantId = B_MerchantID;
    memberId = [CommonUtil getValueByKey:MEMBER_ID];
    classId =B_twocode;
    cityId =cityID;
    allName =self.B_allname.text;
    abbreviation =self.B_smallname.text;
    tel =self.B_phone.text;
    website =self.B_www.text;
    merchanttags =self.B_tag.text;
    briefintro =self.jianjie.text;
    businessLicense =self.R_yinye.text;
    taxCertificate =self.R_shuiwu.text;
    officialContacts =self.R_likeman.text;
    legal =self.R_fanren.text;
    officialContactsPhone =self.R_farenphone.text;
    treasurer =self.R_moneypeople.text;
    treasurerPhone =self.R_moneyphone.text;
    fax =self.R_fax.text;
    officialmail=self.R_e_mail.text;
    memberBankCard=@"0";//收款账户
    memberBankCardId =[NSString stringWithFormat:@"%@",[self.faxDic objectForKey:@"MemberBankCardID"]];
    if ([self.A_leixing.text isEqualToString:@"个人账户"])
    {
        accountCategory=@"1";
    }else if ([self.A_leixing.text isEqualToString:@"对公账户"])
    {
        accountCategory=@"3";
    }
    bankId =[NSString stringWithFormat:@"%@",[self.faxDic objectForKey:@"BankID"]];
    bankCode =Bankcodestring;
    bankName =self.A_bank.text;
    branchCode =Brachcodestring;//银联号
    branchName =self.A_branch.text;
    cardNumber =self.A_bamknum.text;
    iDCard =self.A_identity.text;
    name =self.A_name.text;
    phone =@"0";//银行预留手机号；
    provinceId =[NSString stringWithFormat:@"%@",[self.faxDic objectForKey:@"ProvinceID"]];//省级
    key = [CommonUtil getServerKey];
    cityCode =@"0";//城市代码
 
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"memberId",
                           merchantId,@"merchantId",
                           classId,@"classId",
                           cityId,@"cityId",
                           allName,@"allName",
                           abbreviation,@"abbreviation",
                           tel,@"tel",
                           website,@"website",
                           merchanttags,@"merchanttags",
                           briefintro,@"briefintro",
                           businessLicense,@"businessLicense",
                           taxCertificate,@"taxCertificate",
                           officialContacts,@"officialContacts",
                           legal,@"legal",
                           officialContactsPhone,@"officialContactsPhone",
                           treasurer,@"treasurer",
                           treasurerPhone,@"treasurerPhone",
                           fax,@"fax",
                           officialmail,@"officialMail",
                           memberBankCard,@"memberBankCard",
                           memberBankCardId,@"memberBankCardId",
                           accountCategory,@"accountCategory",
                           bankId,@"bankId",
                           bankCode,@"bankCode",
                           bankName,@"bankName",
                           branchCode,@"branchCode",
                           branchName,@"branchName",
                           cardNumber,@"cardNumber",
                           iDCard,@"iDCard",
                           name,@"name",
                           phone,@"phone",
                           provinceId,@"provinceId",
                           cityCode,@"cityCode",
                           key,@"key",
                           nil];


    [SVProgressHUD showWithStatus:@"数据提交中"];
    [httpClient multiRequest:@"MemberMerchantAdd.ashx" parameters:param files:self.Logoimagedic success:^
     
     (NSJSONSerialization* json){
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            [SVProgressHUD dismiss];
            NSString *msg=[json valueForKey:@"msg"];
            [SVProgressHUD showSuccessWithStatus:msg];
            [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(poptoview) userInfo:nil repeats:NO];
            
        } else {
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
    } failure:^(NSError *error) {
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];
    
}

-(void)poptoview
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(IBAction)saveDataBtn:(id)sender
{
    [self savedatatoserver];
    
}


-(IBAction)DeleorPutBtn:(UIButton *)sender
{
    NSString *put=@"商户信息提交后为审核状态,审核中商户信息不可修改了哦!";
    NSString *del=@"您将删除该商户所有信息,包括商户下面所有门店哦!";
    NSString *putend=@"确认提交";
    NSString *delend=@"确认删除";
    
    if (sender.tag==1)
    {
        UIAlertView *alerv = [[UIAlertView alloc] initWithTitle:putend message:put delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
        alerv.tag=101;
        option=@"1";
        [alerv show];
    }else if (sender.tag==2)
    {
        UIAlertView *alerv = [[UIAlertView alloc] initWithTitle:delend message:del delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
        alerv.tag=101;
        option=@"2";
        [alerv show];
    }

    
}


-(void)alertView : (UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==101)
    {
        if (buttonIndex==0)
        {
            return;
        }
        if (buttonIndex==1)
        {
            [self DeleorPutBusiness];
            return;
        }
        
    }
    if (alertView.tag==103)//添加店铺
    {
        if (buttonIndex==0)
        {
            return;
        }
        if (buttonIndex==1)
        {
            [self performSelector:@selector(PUSHshop) withObject:nil];
            return;
        }
        
    }
    
}


//删除商户
-(void)DeleorPutBusiness
{
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    NSString *memberId; NSString *merchantId;NSString *key;
    memberId = [CommonUtil getValueByKey:MEMBER_ID];
    key = [CommonUtil getServerKey];
    
    merchantId =B_MerchantID;
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"memberId",
                           merchantId,@"merchantId",
                           [NSString stringWithFormat:@"%@",option],@"option",
                           key,@"key",
                           nil];
    [SVProgressHUD showWithStatus:@"数据提交中"];
    [httpClient request:@"MerchantOptions.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            [SVProgressHUD dismiss];
            NSString *msg=[json valueForKey:@"msg"];
            [SVProgressHUD showSuccessWithStatus:msg];
            [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(poptoview) userInfo:nil repeats:NO];
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD dismiss];

            if ([msg isEqualToString:@"请添加商户店铺"])
            {
                UIAlertView *alerv = [[UIAlertView alloc] initWithTitle:msg message:@"提交审核失败\n商户没有店铺不能提交审核哦!" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
                alerv.tag=103;
                [alerv show];
                
            }
            
           // [SVProgressHUD showErrorWithStatus:msg];
        }
    } failure:^(NSError *error) {
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];

}

#pragma mark - AccountChooseClicked
- (IBAction)chooseAccountTypeClicked:(id)sender {
    
    if (rightOpened) {
        
        [UIView animateWithDuration:0.3 animations:^{
            
            CGRect frame = self.m_modelTableView.frame;
            
            frame.size.height = 0;
            [self.m_modelTableView setFrame:frame];
            self.m_alphaView.alpha = 0;
            
            
        } completion:^(BOOL finished){
            
            rightOpened = NO;
        }];
        
    }else{
        
        self.m_modelTableView.hidden = NO;
        
        [UIView animateWithDuration:0.3 animations:^{
            
            CGRect frame = self.m_modelTableView.frame;
            
            int fr = self.m_modelArray.count * 44;
           
            if (fr>300) {
                frame.size.height = 300;
            }else
            {
                frame.size.height = fr;
            }
            
            [self.m_modelTableView setFrame:frame];
            
            self.m_alphaView.alpha = 0.3;
            
        } completion:^(BOOL finished){
            
            rightOpened = YES;
            
        }];
        
    }
  
}

- (IBAction)controlTap:(id)sender;
{
    
    rightOpened = YES;
    
    [self chooseAccountTypeClicked:nil];
}

// 选择会员模式进行赋值
- (void) modelDataTotableview
{
    
    [self.m_modelTableView initTableViewDataSourceAndDelegate:^(UITableView *tableView,NSInteger section)
     {
         NSInteger count = self.m_modelArray.count;
         return count;
         
     } setCellForIndexPathBlock:^(UITableView *tableView,NSIndexPath *indexPath)
     {
         RightCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RightCell"];
         
         if ( !cell )
         {
             cell = [[[NSBundle mainBundle]loadNibNamed:@"RightCell" owner:self options:nil]objectAtIndex:0];
             [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
         }
         
         if ( self.m_modelArray.count != 0 ) {
             
             NSDictionary *dic = [self.m_modelArray objectAtIndex:indexPath.row];
             
             [cell.MctName setText:[NSString stringWithFormat:@"%@ (%@)",[dic objectForKey:@"ModelName"],[dic objectForKey:@"ModelDesc"]]];

         }
         return cell;
         
     } setDidSelectRowBlock:^(UITableView *tableView,NSIndexPath *indexPath)
     {
//         RightCell *cell = (RightCell*)[tableView cellForRowAtIndexPath:indexPath];
         
         if ( self.m_modelArray.count != 0 ) {
             
             NSDictionary *dic = [self.m_modelArray objectAtIndex:indexPath.row];
             
            [self.m_accountType setTitle:[NSString stringWithFormat:@"会员模式：%@",[dic objectForKey:@"ModelName"]] forState:UIControlStateNormal];
             
             // 选择会员模式后请求数据
             [self chooseModelRequest:[NSString stringWithFormat:@"%@",[dic objectForKey:@"CloudMenuModelID"]]];
             
         }
         
         [self controlTap:nil];
        
         
     }];
    
    [self.m_modelTableView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.m_modelTableView.layer setBorderWidth:0];
    
}

// 会员模式请求数据
- (void)modelDataRequestSubmit{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    NSString *memberId; NSString *merchantId;NSString *key;
    memberId = [CommonUtil getValueByKey:MEMBER_ID];
    key = [CommonUtil getServerKey];
    
    merchantId =B_MerchantID;
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
//    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
//                           memberId,@"memberId",
//                           merchantId,@"merchantId",
//                           [NSString stringWithFormat:@"%@",option],@"option",
//                           key,@"key",
//                           nil];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"CloudMenuModelList.ashx" parameters:nil success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            
            [SVProgressHUD dismiss];
            
//            NSString *msg = [json valueForKey:@"msg"];
//            [SVProgressHUD showSuccessWithStatus:msg];
            self.m_modelArray = [json valueForKey:@"modelList"];
            
            // 刷新tableView
            [self modelDataTotableview];
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
            

        }
    } failure:^(NSError *error) {
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];
    
}

- (void)chooseModelRequest:(NSString *)modelId{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                               memberId,@"memberId",
                               key,@"key",
                               modelId,@"cloudMenuModelId",
                               
                               nil];
    
    NSLog(@"params = %@",param);
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"ChangeModel.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            
            [SVProgressHUD dismiss];
            
            
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
            
        }
    } failure:^(NSError *error) {
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];

    
}


@end
