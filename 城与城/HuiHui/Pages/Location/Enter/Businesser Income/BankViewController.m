//
//  BankViewController.m
//  Receive
//
//  Created by 冯海强 on 14-1-2.
//  Copyright (c) 2014年 冯海强. All rights reserved.
//

#import "BankViewController.h"
#import "ImageViewController.h"
#import "SVProgressHUD.h"

@interface BankViewController ()

@property (nonatomic,weak) IBOutlet UITextField *B_leixing;//
@property (nonatomic,weak) IBOutlet UIButton *B_leixingBtn;//

@property (nonatomic,weak) IBOutlet UITextField *B_Bank;//
@property (nonatomic,weak) IBOutlet UIButton *B_BankBtn;//

@property (nonatomic,weak) IBOutlet UITextField *B_Branch;//
@property (nonatomic,weak) IBOutlet UIButton *B_BranckBtn;//

@property (nonatomic,weak) IBOutlet UITextField *B_Name;//
@property (nonatomic,weak) IBOutlet UITextField *B_Num;//
@property (nonatomic,weak) IBOutlet UITextField *B_Identity;

@end

@implementation BankViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.Bankdic=[[NSMutableDictionary alloc]initWithCapacity:0];
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
    
    self.B_Num.delegate=self.B_Name.delegate=self.B_leixing.delegate=self.B_Identity.delegate=self.B_Branch.delegate=self.B_Bank.delegate=self;
    
    self.B_leixing.tag=101;self.B_leixingBtn.tag=101;
    self.B_Bank.tag=201;self.B_BankBtn.tag=201;
    self.B_Branch.tag=202;self.B_BranckBtn.tag=202;
    
    self.B_Bank.placeholder=@"银行名称*";
    self.B_Branch.placeholder=@"开户网点*";
    self.B_Identity.placeholder=@"身份证号*";
    self.B_leixing.placeholder=@"账户类型*";
    self.B_Name.placeholder=@"户名*";
    self.B_Num.placeholder=@"账号*";
    
   
    [self setTitle:@"收款账号"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    [self.m_BankView setContentSize:CGSizeMake(WindowSize.size.width,568)];

    [self AddStep3];
    
}

- (void)leftClicked{
    
    [self goBack];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)AddStep3
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
            
            self.Bankdic = [json valueForKey:@"MerchantShopAddStep"];
            
            
            if ([[NSString stringWithFormat:@"%@",[self.Bankdic objectForKey:@"BankName"] ]  isEqualToString:@"<null>"]) {
                return ;
            }
            self.B_Bank.text = [self.Bankdic objectForKey:@"BankName"];
            Bankcodestring = [self.Bankdic objectForKey:@"BankCode"];
            Brachcodestring= [self.Bankdic objectForKey:@"BranchCode"];
            self.B_Branch.text = [self.Bankdic objectForKey:@"BranchName"];
            self.B_leixing.text = [self.Bankdic objectForKey:@"AccountCategoryName"];//类型
            self.B_Name.text = [self.Bankdic objectForKey:@"Name"];
            self.B_Num.text = [self.Bankdic objectForKey:@"CardNumber"];
            self.B_Identity.text = [self.Bankdic objectForKey:@"IDCard"];
            
            
            
            self.m_IdentityView.hidden=YES;
            self.IDlabel.hidden=YES;
            //对视图的滑动做处理
            self.NextBtn.frame = CGRectMake(20, 430, 280, 39);
            
        } else {
            
            
        }
        
        
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];

}


-(BOOL)textlegth
{
    if(self.B_leixing.text.length==0||[self.B_leixing.text isEqualToString:@""])
    {
        [SVProgressHUD showErrorWithStatus:@"请选择账户类型"];
        [self.m_BankView setContentOffset:CGPointMake(0, 0) animated:YES];

        return NO;
    }
    else if(self.B_Bank.text.length==0||[self.B_Bank.text isEqualToString:@""])
    {
        [SVProgressHUD showErrorWithStatus:@"请选择银行名称"];
        [self.m_BankView setContentOffset:CGPointMake(0, 0) animated:YES];

        return NO;
    }
    else if(self.B_Branch.text.length==0||[self.B_Branch.text isEqualToString:@""])
    {
        [SVProgressHUD showErrorWithStatus:@"请选择开启网点"];
        [self.m_BankView setContentOffset:CGPointMake(0, 0) animated:YES];

        return NO;
    }
    else if(self.B_Name.text.length==0||[self.B_Name.text isEqualToString:@""])
    {
        [SVProgressHUD showErrorWithStatus:@"请填写户名"];
        [self.m_BankView setContentOffset:CGPointMake(0, 272) animated:YES];

        return NO;
    }
    else if(self.B_Num.text.length==0||[self.B_Num.text isEqualToString:@""])
    {
        [SVProgressHUD showErrorWithStatus:@"请填写账号"];
        
        [self.m_BankView setContentOffset:CGPointMake(0, 345) animated:YES];

        return NO;
    }
    else if(self.m_IdentityView.hidden==NO)
    {
        if(self.B_Identity.text.length==0||[self.B_Identity.text isEqualToString:@""])
        {
        [SVProgressHUD showErrorWithStatus:@"请填写身份证号"];
        [self.m_BankView setContentOffset:CGPointMake(0, 420) animated:YES];

        return NO;
        }
        else if(self.B_Identity.text.length!=15&&self.B_Identity.text.length!=18)
        {
            [SVProgressHUD showErrorWithStatus:@"请填写正确身份证号"];
            [self.m_BankView setContentOffset:CGPointMake(0, 420) animated:YES];

            return NO;
        }
    }


    return YES;
}



- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField;
{
    
    if (textField == self.B_Name)
    {
         [self.m_BankView setContentOffset:CGPointMake(0, 196) animated:YES];

    }
    else if (textField == self.B_Num)
    {
        [self.m_BankView setContentOffset:CGPointMake(0, 271) animated:YES];
  
    }
    else if (textField == self.B_Identity)
    {
        [self.m_BankView setContentOffset:CGPointMake(0, 346) animated:YES];
    }
    self.m_BankView.bouncesZoom = NO;
    [self hiddenNumPadDone:nil];
    
    return YES;
}




-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ((textField == self.B_Bank) || (textField == self.B_Branch)||(textField == self.B_Identity)||(textField == self.B_leixing)||(textField == self.B_Name)||(textField == self.B_Num))
    {
        [textField resignFirstResponder];
    }

    return YES;
    
}



- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *Numbers=@"0123456789\n-xX";
    NSCharacterSet *cs;
    if((textField == self.B_Identity)||(textField == self.B_Num))
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
    
    [self.B_Num resignFirstResponder];
    [self.B_Name resignFirstResponder];
    [self.B_leixing resignFirstResponder];
    [self.B_Identity resignFirstResponder];
    [self.B_Branch resignFirstResponder];
    [self.B_Bank resignFirstResponder];
    
}

//代理传值银行
- (void)ChosesValue:(NSString *)value Bankcode:(NSString *)Bankcode;
{
    if ([self.B_Bank.text isEqualToString:value]) {
        return;
    }
    self.B_Bank.text = value;
    Bankcodestring = Bankcode;
    
    self.B_Branch.text = @"";
    Brachcodestring =@"";
}

//网点
- (void)ChosesBrachValue:(NSString *)value Brachcode:(NSString *)Brachcode
{
    if ([self.B_Branch.text isEqualToString:value]) {
        return;
    }
    self.B_Branch.text = value;
    Brachcodestring =Brachcode;
    
}


-(IBAction)textFieldchose:(UIButton*)sender
{
    [self closeallkey];

    
    if (sender.tag==101)
    {
        
        UIActionSheet *sheet;
        
        sheet  = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"对公账户",@"个人账户", nil];
        sheet.tag = 1;
        [sheet showInView:self.view];
    }
    else if (sender.tag==201)
    {
        
        DowncellViewController*downVC=[[DowncellViewController alloc]initWithNibName:@"DowncellViewController" bundle:nil];
        downVC.Itemstyle = @"ChoseBank";
        downVC.Chosedelegate = self;

        [self.navigationController pushViewController:downVC animated:YES];
        
    }else if (sender.tag==202)
    {
        
        if (self.B_Bank.text==nil||[self.B_Bank.text isEqualToString:@""])
        {
            [SVProgressHUD showErrorWithStatus:@"请先选择银行名称"];
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
            if ([self.B_Bank.text isEqualToString:[name objectAtIndex:i]])
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

    }
    
}



-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 1)
    {
        if (buttonIndex==0)
        {
            self.B_leixing.text=@"对公账户";
            self.m_IdentityView.hidden=YES;
            self.IDlabel.hidden=YES;

            //对视图的滑动做处理
            self.NextBtn.frame = CGRectMake(20, 430, 280, 39);
            
        }
        if (buttonIndex==1)
        {
            self.B_leixing.text=@"个人账户";
            self.m_IdentityView.hidden=NO;
            self.IDlabel.hidden=NO;
            
            self.NextBtn.frame = CGRectMake(20, 508, 280, 39);
            
        }
    }
}



-(void)SavttoDic
{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        return;
    }
    
    NSString * memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString * key = [CommonUtil getServerKey];
    NSString * accountCategory;
    NSString * iDCard;
    if ([self.B_leixing.text isEqualToString:@"个人账户"])
    {
        accountCategory = @"1";
        iDCard = self.B_Identity.text;
        
    }else if ([self.B_leixing.text isEqualToString:@"对公账户"])
    {
        accountCategory =@"3";
        iDCard = @"";
        
    }
    NSString * accountCategoryName = self.B_leixing.text;
    NSString * bankName = self.B_Bank.text;
    NSString * bankCode = Bankcodestring;
    NSString * branchName = self.B_Branch.text;
    NSString * branchCode = Brachcodestring;
    NSString * name = self.B_Name.text;
    NSString * cardNumber = self.B_Num.text;
    
    
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"memberId",
                           key,@"key",
                           accountCategory,@"accountCategory",
                           iDCard,@"iDCard",
                           accountCategoryName,@"accountCategoryName",
                           bankName,@"bankName",
                           bankCode,@"bankCode",
                           branchName,@"branchName",
                           branchCode,@"branchCode",
                           name,@"name",
                           cardNumber,@"cardNumber",
                           nil];
    
        
    [SVProgressHUD showWithStatus:@"数据提交中"];
    
    [httpClient request:@"MerchantAddStep3.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            
            [SVProgressHUD dismiss];
            
            ImageViewController *ImageVC=[[ImageViewController alloc]initWithNibName:@"ImageViewController" bundle:nil];
            ImageVC.memberBankCardID = [json valueForKey:@"MemberBankCardID"];
            
            [self.navigationController pushViewController:ImageVC animated:YES];
            
        } else {
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];
    
}



-(IBAction)FourNextToFive:(id)sender
{
    [self closeallkey];
    
    if ([self textlegth])
    {
        
    [self SavttoDic];
        
    }
    
}


@end
