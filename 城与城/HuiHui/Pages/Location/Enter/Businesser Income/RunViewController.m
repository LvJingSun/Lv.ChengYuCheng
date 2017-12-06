//
//  RunViewController.m
//  Receive
//
//  Created by 冯海强 on 14-1-2.
//  Copyright (c) 2014年 冯海强. All rights reserved.
//

#import "RunViewController.h"
#import "BankViewController.h"
#import "SVProgressHUD.h"

@interface RunViewController ()
@property (weak, nonatomic) IBOutlet UIView *m_titleView;

@property (weak, nonatomic) IBOutlet UIScrollView *m_RunView;


@property (nonatomic,weak) IBOutlet UITextField *R_yingye;//
@property (nonatomic,weak) IBOutlet UITextField *R_shuiwu;//
@property (nonatomic,weak) IBOutlet UITextField *R_fanren;//
@property (nonatomic,weak) IBOutlet UITextField *R_fanrenphone;//
@property (nonatomic,weak) IBOutlet UITextField *R_linkman;//联系人
@property (nonatomic,weak) IBOutlet UITextField *R_moneyman;
@property (nonatomic,weak) IBOutlet UITextField *R_moneyphone;
@property (nonatomic,weak) IBOutlet UITextField *R_fax;//传真
@property (nonatomic,weak) IBOutlet UITextField *R_e_mail;

@property (nonatomic,weak) IBOutlet UIView *R_e_mailview;

@end

@implementation RunViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.Rundic=[[NSMutableDictionary alloc]initWithCapacity:0];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    isOpened = NO;
    [self.emaildownTableview setFrame:CGRectMake(13, 662, self.R_e_mailview.frame.size.width, 0)];
    [self emaildownDataTotableview];

    
    self.R_e_mail.delegate=self.R_fanren.delegate=self.R_fanrenphone.delegate=self.R_fax.delegate=self.R_linkman.delegate=self.R_moneyman.delegate=self.R_moneyphone.delegate=self.R_shuiwu.delegate=self.R_yingye.delegate=self;
    
    self.R_yingye.placeholder=@"营业执照号*";
    self.R_shuiwu.placeholder=@"税务登记号";
    self.R_moneyphone.placeholder=@"财务负责人手机";
    self.R_moneyman.placeholder=@"财务负责人";
    self.R_linkman.placeholder=@"官方联系人*";
    self.R_fax.placeholder=@"传真";
    self.R_e_mail.placeholder=@"官方邮箱*";
    self.R_fanrenphone.placeholder=@"法人手机*";
    self.R_fanren.placeholder=@"法人代表*";
    

    [self setTitle:@"运营信息"];
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    [self.m_RunView setContentSize:CGSizeMake(WindowSize.size.width,756)];
 
    [self AddStep2];
    
}


-(void)AddStep2
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
            
            self.Rundic = [json valueForKey:@"MerchantShopAddStep"];
            if ([[self.Rundic objectForKey:@"BusinessLicense"] isEqualToString:@"<null>"]) {
                return ;
            }
            self.R_yingye.text = [self.Rundic objectForKey:@"BusinessLicense"];
            self.R_shuiwu.text = [self.Rundic objectForKey:@"TaxCertificate"];
            self.R_moneyphone.text = [self.Rundic objectForKey:@"TreasurerPhone"];
            self.R_moneyman.text = [self.Rundic objectForKey:@"Treasurer"];
            self.R_linkman.text = [self.Rundic objectForKey:@"OfficialContacts"];
            self.R_fax.text = [self.Rundic objectForKey:@"Fax"];
            self.R_e_mail.text = [self.Rundic objectForKey:@"OfficialMail"];
            self.R_fanrenphone.text = [self.Rundic objectForKey:@"OfficialContactsPhone"];
            self.R_fanren.text = [self.Rundic objectForKey:@"Legal"];
            
        } else {
            
            
        }
        
        
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];
    
   
    
}

- (void)leftClicked{
    
    [self goBack];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self hideTabBar:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textlegth
{
    if(self.R_yingye.text.length==0||[self.R_yingye.text isEqualToString:@""])
    {
        [SVProgressHUD showErrorWithStatus:@"请填写营业执照号"];
        [self.m_RunView setContentOffset:CGPointMake(0, 0) animated:YES];

        return NO;
    }
    else if(self.R_fanren.text.length==0||[self.R_fanren.text isEqualToString:@""])
    {
        [SVProgressHUD showErrorWithStatus:@"请填写法人代表"];
        [self.m_RunView setContentOffset:CGPointMake(0, 165) animated:YES];

        return NO;
    }
    else if(self.R_fanrenphone.text.length==0||[self.R_fanrenphone.text isEqualToString:@""])
    {
        [SVProgressHUD showErrorWithStatus:@"请填写法人手机"];
        [self.m_RunView setContentOffset:CGPointMake(0, 238) animated:YES];

        return NO;
    }
    else if(self.R_linkman.text.length==0||[self.R_linkman.text isEqualToString:@""])
    {
        [SVProgressHUD showErrorWithStatus:@"请填写官方联系人"];
        [self.m_RunView setContentOffset:CGPointMake(0, 310) animated:YES];

        return NO;
    }
    else if(self.R_e_mail.text.length==0||[self.R_e_mail.text isEqualToString:@""])
    {
        [SVProgressHUD showErrorWithStatus:@"请填写官方邮箱"];
        [self.m_RunView setContentOffset:CGPointMake(0, 607) animated:YES];

        return NO;
    }
    else if (![self isValidateEmail:self.R_e_mail.text])
    {

        [self.m_RunView setContentOffset:CGPointMake(0, 607) animated:YES];
 
        return NO;
    }
    else if(self.R_fanrenphone.text.length!=11)
    {
        [SVProgressHUD showErrorWithStatus:@"法人手机格式不正确"];
        [self.m_RunView setContentOffset:CGPointMake(0, 238) animated:YES];
        
        return NO;
    }
    else if(self.R_moneyphone.text.length!=0)
    {
        if (self.R_moneyphone.text.length!=11) {
            [SVProgressHUD showErrorWithStatus:@"财务负责人手机格式不正确"];
            [self.m_RunView setContentOffset:CGPointMake(0, 460) animated:YES];
            
            return NO;
        }

    }
 
    return YES;
  
}



- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField;
{

    if (textField == self.R_yingye)
    {
        [self.m_RunView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    else if (textField == self.R_shuiwu)
    {
        [self.m_RunView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    else if (textField == self.R_fanren)
    {
        [self.m_RunView setContentOffset:CGPointMake(0, 88) animated:YES];
        
    }
    else if (textField == self.R_fanrenphone)
    {
        [self.m_RunView setContentOffset:CGPointMake(0, 162) animated:YES];
        
    }
    else if (textField == self.R_linkman)
    {
        [self.m_RunView setContentOffset:CGPointMake(0, 236) animated:YES];
        
    }
    else if (textField == self.R_moneyman)
    {
        [self.m_RunView setContentOffset:CGPointMake(0, 310) animated:YES];
        
    }
    else if (textField == self.R_moneyphone)
    {
        [self.m_RunView setContentOffset:CGPointMake(0, 385) animated:YES];
        
    }
    else if (textField == self.R_fax)
    {
        [self.m_RunView setContentOffset:CGPointMake(0, 460) animated:YES];
        
    }
    else if (textField == self.R_e_mail)
    {
        [self.m_RunView setContentOffset:CGPointMake(0, 607) animated:YES];
        
    }
    self.m_RunView.bouncesZoom = NO;
    
    [self hiddenNumPadDone:nil];
    
    return YES;
}




-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ((textField == self.R_e_mail) || (textField == self.R_fanren)||(textField == self.R_fanrenphone)||(textField == self.R_fax)||(textField == self.R_linkman)||(textField == self.R_moneyman)||(textField == self.R_moneyphone)||(textField == self.R_shuiwu)||(textField==self.R_yingye))
    {
        [textField resignFirstResponder];
    }

    return YES;
    
}



- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{

     if(textField == self.R_e_mail)
    {
    //删除空格
    self.R_e_mail.text = [self.R_e_mail.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

        if ([string isEqualToString:@""]) {
            
            self.R_e_mail.text = [self.R_e_mail.text substringToIndex:self.R_e_mail.text.length -1];
        }
        self.R_e_mail.text =  [NSString stringWithFormat:@"%@%@",self.R_e_mail.text,string];

        if (self.R_e_mail.text.length!=0&&!([self.R_e_mail.text.description rangeOfString:@"@"].location!=NSNotFound))
        {
            [self.emaildownTableview reloadData];
            
            isOpened = NO;
        
            [self emaildownOpenBtn];
        
        }else if (self.R_e_mail.text.length==0)

        {
            isOpened = YES;
        
            [self emaildownOpenBtn];
        }
        
        return NO;
    }

    NSString *Numbers=@"0123456789\n-";
    NSCharacterSet *cs;

    if((textField == self.R_fanrenphone)||(textField == self.R_fax)||(textField == self.R_moneyphone)||(textField==self.R_yingye))
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

- (BOOL)textFieldShouldClear:(UITextField *)textField;
{
    
    isOpened = YES;
    
    [self emaildownOpenBtn];
    
    return YES;
}



-(void)emaildownDataTotableview
{
    
    [self.emaildownTableview initTableViewDataSourceAndDelegate:^(UITableView *tableView,NSInteger section)
     {
         NSInteger count=12;
         return count;
         
     } setCellForIndexPathBlock:^(UITableView *tableView,NSIndexPath *indexPath)
     {
         emaildownCell *cell=[tableView dequeueReusableCellWithIdentifier:@"emaildownCell"];
         
         if (!cell)
             
         {
             cell=[[[NSBundle mainBundle]loadNibNamed:@"emaildownCell" owner:self options:nil]objectAtIndex:0];
             
             [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
  
         }
    
         switch (indexPath.row) {
             case 0:
                 cell.emaildown.text = [NSString stringWithFormat:@"%@@qq.com",self.R_e_mail.text];
                 break;
             case 1:
                 cell.emaildown.text = [NSString stringWithFormat:@"%@@sina.com",self.R_e_mail.text];                 break;
             case 2:
                 cell.emaildown.text = [NSString stringWithFormat:@"%@@163.com",self.R_e_mail.text];                 break;
             case 3:
                 cell.emaildown.text = [NSString stringWithFormat:@"%@@126.com",self.R_e_mail.text];                 break;
             case 4:
                 cell.emaildown.text = [NSString stringWithFormat:@"%@@vip.sina.com",self.R_e_mail.text];                 break;
             case 5:
                 cell.emaildown.text = [NSString stringWithFormat:@"%@@sina.cn",self.R_e_mail.text];                 break;
             case 6:
                 cell.emaildown.text = [NSString stringWithFormat:@"%@@hotmail.com",self.R_e_mail.text];                 break;
             case 7:
                 cell.emaildown.text = [NSString stringWithFormat:@"%@@gmail.com",self.R_e_mail.text];                 break;
             case 8:
                 cell.emaildown.text = [NSString stringWithFormat:@"%@@sohu.com",self.R_e_mail.text];                 break;
             case 9:
                 cell.emaildown.text = [NSString stringWithFormat:@"%@@yahoo.com",self.R_e_mail.text];                 break;
             case 10:
                 cell.emaildown.text = [NSString stringWithFormat:@"%@@139.com",self.R_e_mail.text];                 break;
             case 11:
                 cell.emaildown.text = [NSString stringWithFormat:@"%@@189.com",self.R_e_mail.text];                 break;
             default:
                 break;
         }
         
         return cell;
         
     } setDidSelectRowBlock:^(UITableView *tableView,NSIndexPath *indexPath)
     {
        emaildownCell *cell=(emaildownCell*)[tableView cellForRowAtIndexPath:indexPath];
         
         self.R_e_mail.text = cell.emaildown.text;
         
         isOpened = YES;
         
         [self emaildownOpenBtn];
         
         
     }];
    
}



- (void)emaildownOpenBtn {
    
    if (isOpened) {
        
        [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
        
        [UIView animateWithDuration:0.3 animations:^{
            
            CGRect frame=self.emaildownTableview.frame;
            
            frame.size.height=0;
            
            [self.emaildownTableview setFrame:frame];
            
            
        } completion:^(BOOL finished){
            
            isOpened=NO;
        }];
        
    }else{
   
        [self.m_RunView setContentOffset:CGPointMake(0, 607) animated:NO];
        if (iPhone5) {
            [self.m_RunView setContentSize:CGSizeMake(WindowSize.size.width,1100)];
        }else{
            [self.m_RunView setContentSize:CGSizeMake(WindowSize.size.width,1012)];
        }

        [UIView animateWithDuration:0.3 animations:^{


            CGRect frame=self.emaildownTableview.frame;
            frame.size.height = 130;
            
            if (iPhone5) {
                frame.size.height=220;
            }
            [self.emaildownTableview setFrame:frame];

            
        } completion:^(BOOL finished){
            
            isOpened=YES;
            
        }];
        
    }
    
    
}




- (void)textFieldDidEndEditing:(UITextField *)textField;
{
    if (textField==self.R_fanrenphone)
    {

    }
    else if (textField==self.R_moneyphone)
    {

    }
    else if (textField==self.R_e_mail)
    {
        isOpened = YES;
        
        [self emaildownOpenBtn];
        
        if (![self isValidateEmail:self.R_e_mail.text])
        {
            [SVProgressHUD showErrorWithStatus:@"请正确输入您的邮箱格式!"];
        }
    }
    
}

-(void)closeallkey
{
    
    [self.R_yingye resignFirstResponder];
    [self.R_shuiwu resignFirstResponder];
    [self.R_moneyphone resignFirstResponder];
    [self.R_moneyman resignFirstResponder];
    [self.R_linkman resignFirstResponder];
    [self.R_fax resignFirstResponder];
    [self.R_fanrenphone resignFirstResponder];
    [self.R_fanren resignFirstResponder];
    [self.R_e_mail resignFirstResponder];
    
}

-(void)SavttoDic
{
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        return;
    }
    
    NSString * memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString * MerchantID = [self.Rundic objectForKey:@"MerchantId"];
    NSString * key = [CommonUtil getServerKey];
    NSString * businessLicense = self.R_yingye.text;
    
    NSString * taxCertificate ;
    if ([self.R_shuiwu.text isEqualToString:@""]||self.R_shuiwu==nil)
    {
        taxCertificate =@"";
    }else{
        taxCertificate = self.R_shuiwu.text;
    }
    
    NSString * treasurer ;
    if ([self.R_moneyman.text isEqualToString:@""]||self.R_moneyman==nil)
    {
        treasurer =@"";
    }else{
        treasurer = self.R_moneyman.text;
    }
    
    NSString * treasurerPhone ;
    if ([self.R_moneyphone.text isEqualToString:@""]||self.R_moneyphone==nil)
    {
        treasurerPhone =@"";
    }else{
        treasurerPhone = self.R_moneyphone.text;
    }
    
    NSString * fax ;
    if ([self.R_fax.text isEqualToString:@""]||self.R_fax==nil)
    {
        fax =@"";
    }else{
        fax = self.R_fax.text;
    }

    NSString * officialContacts = self.R_linkman.text;
    NSString * officialMail = self.R_e_mail.text;
    NSString * officialContactsPhone = self.R_fanrenphone.text;
    NSString * legal = self.R_fanren.text;
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"memberId",
                           MerchantID,@"merchantId",
                           key,@"key",
                           businessLicense,@"businessLicense",
                           taxCertificate,@"taxCertificate",
                           treasurerPhone,@"treasurerPhone",
                           treasurer,@"treasurer",
                           officialContacts,@"officialContacts",
                           fax,@"fax",
                           officialMail,@"officialMail",
                           officialContactsPhone,@"officialContactsPhone",
                           legal,@"legal",

                           nil];
    
    [SVProgressHUD showWithStatus:@"数据提交中"];
    
    [httpClient request:@"MerchantAddStep2.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            [SVProgressHUD dismiss];
            
            BankViewController *BankVC=[[BankViewController alloc]initWithNibName:@"BankViewController" bundle:nil];
            
            [self.navigationController pushViewController:BankVC animated:YES];
            
        } else {
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];

}



-(IBAction)ThreeNextToFour:(id)sender
{
   [self closeallkey];
    
   if ([self textlegth])
    {
    [self SavttoDic];
   
    }
}

@end
