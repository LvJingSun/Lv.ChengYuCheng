//
//  PExpenseSetViewController.m
//  baozhifu
//
//  Created by 冯海强 on 14-1-12.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "PExpenseSetViewController.h"
#import "PimageViewController.h"
#import "CommonUtil.h"
#import "SVProgressHUD.h"
#import "AppHttpClient.h"


@interface PExpenseSetViewController ()

@property (nonatomic,weak) IBOutlet UITextField *PE_Data;
@property (nonatomic,weak) IBOutlet UIButton *PE_DataBtn;

@property (nonatomic,weak) IBOutlet UITextField *PE_Oldprice;
@property (nonatomic,weak) IBOutlet UITextField *PE_Newprice;
@property (nonatomic,weak) IBOutlet UITextField *PE_Scale;//比例
@property (nonatomic,weak) IBOutlet UILabel *PE_Scalemoney;//比例钱

@property (nonatomic,weak) IBOutlet UITextField *PE_KEY1;
@property (nonatomic,weak) IBOutlet UIButton *PE_KEYBtn1;
@property (nonatomic,weak) IBOutlet UITextField *PE_KEY2;
@property (nonatomic,weak) IBOutlet UIButton *PE_KEYBtn2;
@property (nonatomic,weak) IBOutlet UITextField *PE_Num;

@property (nonatomic,weak) IBOutlet UIButton *PE_PastBtn;
@property (nonatomic,weak) IBOutlet UIButton *PE_AlltimeBtn;
@property (nonatomic,weak) IBOutlet UIButton *PE_DontBtn;

@property (nonatomic,weak) IBOutlet UIButton *PE_WULIUBtn;//支持物流
@property (weak, nonatomic) IBOutlet UIView *wuliuView;

@property (weak, nonatomic) IBOutlet UIView *yunfeiView;

@property (weak, nonatomic) IBOutlet UIButton *PE_NEXTBtn;

@property (nonatomic,weak) IBOutlet UIButton *PE_ZFBBtn;//支持【支付保】

@end

@implementation PExpenseSetViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        // Custom initialization
        self.Pexpensedic=[[NSMutableDictionary alloc]initWithCapacity:0];
        array1 = [[NSArray alloc]init];
        array2 = [[NSArray alloc]init];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.yunfeiView.hidden = YES;
    
    [self setTitle:@"消费设置"];
    
    self.PE_Oldprice.delegate=self.PE_Newprice.delegate=self.PE_Scale.delegate=self.PE_Num.delegate=self;
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];

    [self.P_ExpenseSetScrollView setContentSize:CGSizeMake(WindowSize.size.width,700)];

    
    UIImage*selectedimage=[UIImage imageNamed:@"comm_check_box_selected.png"];
    UIImage*unselectedimage=[UIImage imageNamed:@"comm_check_box_def.png"];
    [self.PE_PastBtn setImage:selectedimage forState:UIControlStateSelected];
    [self.PE_PastBtn setImage:unselectedimage forState:UIControlStateNormal];
    [self.PE_AlltimeBtn setImage:selectedimage forState:UIControlStateSelected];
    [self.PE_AlltimeBtn setImage:unselectedimage forState:UIControlStateNormal];
    [self.PE_DontBtn setImage:selectedimage forState:UIControlStateSelected];
    [self.PE_DontBtn setImage:unselectedimage forState:UIControlStateNormal];
    [self.PE_ZFBBtn setImage:selectedimage forState:UIControlStateSelected];
    [self.PE_ZFBBtn setImage:unselectedimage forState:UIControlStateNormal];
    [self.PE_WULIUBtn setImage:selectedimage forState:UIControlStateSelected];
    [self.PE_WULIUBtn setImage:unselectedimage forState:UIControlStateNormal];
    
      
    // 初始化pickerView
    [self initWithPickerView];
    [self.m_datePicker setHidden:YES];
    [self.m_toolbar setHidden:YES];
    
    
    KEYlabel = [[UILabel alloc]initWithFrame:CGRectMake(60,self.m_datePicker.frame.origin.y - 44, 200, 44)];
    KEYlabel.text = @"提醒\nKEY值是会员购买商品时的电子消费凭证,用于会员现场消费时提供验证";
    KEYlabel.font = [UIFont systemFontOfSize:12];
    KEYlabel.lineBreakMode = UILineBreakModeWordWrap;
    KEYlabel.numberOfLines = 0;
    KEYlabel.textAlignment = UITextAlignmentCenter;
    KEYlabel.textColor = [UIColor whiteColor];
    [self.navigationController.view.window addSubview:KEYlabel];
    KEYlabel.hidden=YES;
    
    
    NSNumber *f =[NSNumber numberWithFloat:[self.RebatesType floatValue]];
    
    NSString *percentStr = [NSNumberFormatter localizedStringFromNumber:f numberStyle:NSNumberFormatterPercentStyle];//百分比格式
    
    NSNumber *ff =[NSNumber numberWithFloat:1-[self.RebatesType floatValue]];
    
    NSString *percentStrr = [NSNumberFormatter localizedStringFromNumber:ff numberStyle:NSNumberFormatterPercentStyle];
    
    self.RebatesTypeLabel.text = [NSString stringWithFormat:@"返利的%@返给生活达人(推荐用户的会员),%@返给资源达人(发布产品的会员)",percentStr,percentStrr];
    
    [self ServiceAddStep2];
}


-  (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self hideTabBar:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    // 隐藏pickerView和toolBar
    [self.m_datePicker setHidden:YES];
	[self.m_toolbar setHidden:YES];
    KEYlabel.hidden=YES;

    [self hideTabBar:NO];
}


- (void)leftClicked{
    
    [self goBack];
}

//检查数据临时表内数据
-(void)ServiceAddStep2
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
    
    [httpClient request:@"ServiceAddStep.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        [SVProgressHUD dismiss];
        
        if (success) {
            
            NSLog(@"json = %@",json);
            
            self.Pexpensedic = [json valueForKey:@"SvcAddStep"];
            
            self.PE_Data.text =  [self.Pexpensedic objectForKey:@"ShelfTime"];
            self.PE_Oldprice.text = [self.Pexpensedic objectForKey:@"OriginalPrice"];
            self.PE_Newprice.text = [self.Pexpensedic objectForKey:@"Price"];
            
            self.PE_Scale.text = [NSString stringWithFormat:@"%.0f",[[self.Pexpensedic objectForKey:@"CommissionRate"] floatValue]];
            
            
            NSLog(@"self.PE_Scale.text = %@",self.PE_Scale.text);
            
            
            self.PE_KEY1.text = [self.Pexpensedic objectForKey:@"KeyVaildDateS"];
            self.PE_KEY2.text = [self.Pexpensedic objectForKey:@"KeyVaildDateE"];
            
            if (![[self.Pexpensedic objectForKey:@"Quantity"] isEqualToString:@"0"]) {
                self.PE_Num.text = [self.Pexpensedic objectForKey:@"Quantity"];
            }
            
            if (![[self.Pexpensedic objectForKey:@"CommissionRate"] isEqualToString:@""]) {
                float pe_scale =[[NSString stringWithFormat:@"%@",self.PE_Scale.text] floatValue];
                float pe_money = (pe_scale/100)*[[NSString stringWithFormat:@"%@",self.PE_Newprice.text] floatValue];
                self.PE_Scalemoney.text = [NSString stringWithFormat:@"%.2f",pe_money];
            }
            
            if ([[self.Pexpensedic objectForKey:@"IsExpiredReturn"] isEqualToString:@"Yes"]) {
                self.PE_PastBtn.selected = YES;
            }else if ([[self.Pexpensedic objectForKey:@"IsExpiredReturn"] isEqualToString:@"No"])
            {
                self.PE_PastBtn.selected = NO;
            }
            if ([[self.Pexpensedic objectForKey:@"IsAnyTimeReturn"] isEqualToString:@"Yes"]) {
                self.PE_AlltimeBtn.selected = YES;
            }else if ([[self.Pexpensedic objectForKey:@"IsAnyTimeReturn"] isEqualToString:@"No"])
            {
                self.PE_AlltimeBtn.selected = NO;
            }
            if ([[self.Pexpensedic objectForKey:@"IsReservation"] isEqualToString:@"Yes"]) {
                self.PE_DontBtn.selected = YES;
            }else if ([[self.Pexpensedic objectForKey:@"IsReservation"] isEqualToString:@"No"])
            {
                self.PE_DontBtn.selected = NO;
            }
            if ([[self.Pexpensedic objectForKey:@"IsWuLiu"] isEqualToString:@"1"]) {
                self.PE_WULIUBtn.selected = YES;
            }else if ([[self.Pexpensedic objectForKey:@"IsWuLiu"] isEqualToString:@"0"])
            {
                self.PE_WULIUBtn.selected = NO;
            }

            
        } else {
            
            
        }
        
        
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];
    
    
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFieldDidChange) name:UITextFieldTextDidChangeNotification object:self.PE_Newprice];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFieldDidChange) name:UITextFieldTextDidChangeNotification object:self.PE_Scale];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFieldDidChange) name:UITextFieldTextDidChangeNotification object:self.PE_Oldprice];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFieldDidChange) name:UITextFieldTextDidChangeNotification object:self.PE_Newprice];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFieldDidChange) name:UITextFieldTextDidChangeNotification object:self.PE_Num];
    
    if (textField == self.PE_Oldprice)
    {
        [self hiddenNumPadDone:nil];
        
        [self.P_ExpenseSetScrollView setContentOffset:CGPointMake(0,0) animated:YES];
    }
    else if (textField == self.PE_Newprice)
    {
        [self hiddenNumPadDone:nil];

        [self.P_ExpenseSetScrollView setContentOffset:CGPointMake(0,89) animated:YES];
    }
    else if (textField == self.PE_Scale)
    {
        [self showNumPadDone:nil];

        [self.P_ExpenseSetScrollView setContentOffset:CGPointMake(0,145) animated:YES];
    }
    else if (textField == self.PE_Num)
    {
        [self showNumPadDone:nil];

        if (iPhone5)
        {
            [self.P_ExpenseSetScrollView setContentOffset:CGPointMake(0,220) animated:YES];
        }
        else
        {
            [self.P_ExpenseSetScrollView setContentOffset:CGPointMake(0,305) animated:YES];
            
        }
    }
    
    self.P_ExpenseSetScrollView.bouncesZoom = NO;
    
    return YES;
}

//算比例返利
-(void)textFieldDidChange
{
    if (self.PE_Scale.text.length==1||[self.PE_Scale.text isEqualToString:@"0"])
    {
        if ([self.PE_Scale.text isEqualToString:@"0"])
        {
            self.PE_Scale.text=@"1";
        }
    }
    
    if (self.PE_Scale.text.length>=3)
    {
        if ([[NSString stringWithFormat:@"%@",self.PE_Scale.text] floatValue]>100)
        {
            self.PE_Scale.text=@"100";
        }
    }
    
    if (self.PE_Oldprice.text.length==2||[self.PE_Oldprice.text isEqualToString:@"00"])
    {
        if ([self.PE_Oldprice.text isEqualToString:@"00"])
        {
            self.PE_Oldprice.text=@"0";
        }
    }
    if (self.PE_Newprice.text.length==2||[self.PE_Newprice.text isEqualToString:@"00"])
    {
        if ([self.PE_Newprice.text isEqualToString:@"00"])
        {
            self.PE_Newprice.text=@"0";
        }
    }
    if (self.PE_Num.text.length==1||[self.PE_Num.text isEqualToString:@"0"])
    {
        if ([self.PE_Num.text isEqualToString:@"0"])
        {
            self.PE_Num.text=@"";
        }
    }
    
    float pe_scale =[[NSString stringWithFormat:@"%@",self.PE_Scale.text] floatValue];
    float pe_money = (pe_scale/100)*[[NSString stringWithFormat:@"%@",self.PE_Newprice.text] floatValue];
    self.PE_Scalemoney.text = [NSString stringWithFormat:@"%.2f",pe_money];
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ((textField == self.PE_Num)||(textField == self.PE_Oldprice)||(textField == self.PE_Newprice)||(textField == self.PE_Scale))
    {
        [textField resignFirstResponder];
    }
    return YES;
}


- (void)textFieldDidEndEditing:(UITextField *)textField;
{
    if (textField == self.PE_Scale)
    {
        NSLog(@"%@",self.PE_Scale.text);

        //没有最低返利设置
        if ([self.LimitRebate isEqualToString:@""]) {
            
        }//有最低返利设定
        else{
            
            NSLog(@"self.LimitRebate = %@,%f",self.LimitRebate,[self.LimitRebate floatValue]*100);
            
            if ([self.PE_Scale.text floatValue]<[self.LimitRebate floatValue]*100) {
                
                self.PE_Scale.text= [NSString stringWithFormat:@"%.0f",[self.LimitRebate floatValue]*100] ;
                
                NSNumber *f =[NSNumber numberWithFloat:[self.LimitRebate floatValue]];
                
                NSString *percentStr = [NSNumberFormatter localizedStringFromNumber:f numberStyle:NSNumberFormatterPercentStyle];
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:[NSString stringWithFormat:@"您有最低返利设定，您所发布产品的返利比例最低设置为%@",percentStr] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [alert show];
            }
            
        }
    }
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *Numbers=@"0123456789\n.";
    NSCharacterSet *cs;
    
    if (textField == self.PE_Oldprice) {
        
        array1 = [self.PE_Oldprice.text componentsSeparatedByString:@"."];
        
        if ( array1.count >= 2 ) {
            
            Numbers =@"0123456789\n";
        }
        
        cs = [[NSCharacterSet characterSetWithCharactersInString:Numbers] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        BOOL basicTest = [string isEqualToString:filtered];
        if(!basicTest)
        {
            [SVProgressHUD showErrorWithStatus:@"请正确输入!"];
            return NO;
        }
        
        return YES;
        
    }
    else if (textField == self.PE_Newprice)
    {
        
        array2 = [self.PE_Newprice.text componentsSeparatedByString:@"."];
        
        if ( array2.count >= 2 ) {
            
            Numbers =@"0123456789\n";
        }
        
        cs = [[NSCharacterSet characterSetWithCharactersInString:Numbers] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        BOOL basicTest = [string isEqualToString:filtered];
        if(!basicTest)
        {
            [SVProgressHUD showErrorWithStatus:@"请正确输入!"];
            return NO;
        }
        
    }
    array1 = [self.PE_Oldprice.text componentsSeparatedByString:@"."];
    array2 = [self.PE_Newprice.text componentsSeparatedByString:@"."];
    
    //其他的类型不需要检测，直接写入
    return YES;
}


#pragma mark - BtnClicked
- (IBAction)timeChoose:(id)sender {

    self.KeyString=@"3";
    [self.view endEditing:YES];
    [self.m_datePicker setDatePickerMode:UIDatePickerModeDateAndTime];
    self.m_datePicker.hidden = NO;
    self.m_toolbar.hidden = NO;
    
    NSTimeInterval secondDay = 24 * 60 * 60;
    NSDate * today = [[NSDate alloc]init];
    NSDate *min = [today dateByAddingTimeInterval:secondDay];
    self.m_datePicker.minimumDate=min;//不能选明日之前的。设最小日期；
    
    [self togglePicker];
}

-(IBAction)choseKEY1:(id)sender
{
    KEYlabel.hidden=NO;
    self.KeyString=@"1";
    [self.view endEditing:YES];
    [self.m_datePicker setDatePickerMode:UIDatePickerModeDate];
    self.m_datePicker.hidden = NO;
    self.m_toolbar.hidden = NO;
    self.m_datePicker.minimumDate=[NSDate date];//不能选今日之前的。设最小日期；
    if (iPhone5)
    {
        [self.P_ExpenseSetScrollView setContentOffset:CGPointMake(0,220) animated:YES];
    }
    else
    {
        [self.P_ExpenseSetScrollView setContentOffset:CGPointMake(0,270) animated:YES];
    }
    [self togglePicker];

}

-(IBAction)choseKEY2:(id)sender
{
    KEYlabel.hidden=NO;
    self.KeyString=@"2";
    [self.view endEditing:YES];
    [self.m_datePicker setDatePickerMode:UIDatePickerModeDate];
    self.m_datePicker.hidden = NO;
    self.m_toolbar.hidden = NO;
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyy/MM/dd"];
    NSDate *minDate = [formatter dateFromString:self.PE_KEY1.text];
    self.m_datePicker.minimumDate=minDate;//不能选KEY1之前的。设最小日期；
    if (iPhone5)
    {
        [self.P_ExpenseSetScrollView setContentOffset:CGPointMake(0,220) animated:YES];
    }
    else
    {
        [self.P_ExpenseSetScrollView setContentOffset:CGPointMake(0,270) animated:YES];
    }
    [self togglePicker];
}


#pragma 初始化pickerView
- (void)initWithPickerView{
	
    UIWindow *window = self.navigationController.view.window;
	//  datePickerView初始化
	self.m_datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 210, WindowSizeWidth, 200)];
    [self.m_datePicker setDatePickerMode:UIDatePickerModeDateAndTime];
	[self.m_datePicker addTarget:self action:@selector(togglePicker) forControlEvents:UIControlEventValueChanged];
    self.m_datePicker.backgroundColor = [UIColor whiteColor];
	[window addSubview:self.m_datePicker];
    
    UIToolbar *pickerBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.m_datePicker.frame.origin.y - 44, WindowSizeWidth, 44)];
    pickerBar.barStyle = UIBarStyleBlackTranslucent;
    
    UIBarButtonItem *cancelBarButton = [[UIBarButtonItem alloc] initWithTitle:@"取消"
                                                                        style:UIBarButtonItemStyleDone
                                                                       target:self
                                                                       action:@selector(doPCAPickerCancel)];

    
    UIBarButtonItem *spaceButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                    target:nil
                                                                                    action:nil];
    
    
    UIBarButtonItem *lastButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成"
                                                                       style:UIBarButtonItemStyleDone
                                                                      target:self
                                                                      action:@selector(doPCAPickerDone)];
    
    NSArray *pickArray = [NSArray arrayWithObjects: cancelBarButton, spaceButtonItem, lastButtonItem, nil];
    [pickerBar setItems:pickArray animated:YES];
    [window addSubview:pickerBar];
    pickerBar.backgroundColor = [UIColor clearColor];
    self.m_toolbar = pickerBar;
    
    [window addSubview:self.m_toolbar];
}

#pragma mark - PickerBar按钮//完成
- (void)doPCAPickerDone{
    
    KEYlabel.hidden=YES;
    [self.m_datePicker setHidden:YES];
    [self.m_toolbar setHidden:YES];
    if ([self.KeyString isEqualToString:@"1"])
    {
            self.PE_KEY1.text = [[NSString stringWithFormat:@"%@",self.m_dataString] substringToIndex:10];
    }
    else if ([self.KeyString isEqualToString:@"2"])
    {
            self.PE_KEY2.text = [[NSString stringWithFormat:@"%@",self.m_dataString] substringToIndex:10];
    }
    else if ([self.KeyString isEqualToString:@"3"])
    {
            self.PE_Data.text = [NSString stringWithFormat:@"%@",self.m_dataString];
    }
}


- (void)doPCAPickerCancel{
    
    [self.m_datePicker setHidden:YES];
    [self.m_toolbar setHidden:YES];
    KEYlabel.hidden=YES;

}


// pickerView的选择事件
- (void) togglePicker{
    
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    if ([self.KeyString isEqualToString:@"3"])
    {
        [formatter setDateFormat:@"yyy/MM/dd HH:mm"];
    }else
    {
        [formatter setDateFormat:@"yyy/MM/dd"];
    }
    
    NSString *str = [formatter stringFromDate:self.m_datePicker.date];
    self.m_dataString = [NSString stringWithFormat:@"%@",str];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(IBAction)isPE_PastBtn:(id)sender;
{
    if (self.PE_PastBtn.selected)
    {
        self.PE_PastBtn.selected=NO;
    }
    else
    {
        self.PE_PastBtn.selected=YES;
    }
}

-(IBAction)isPE_AlltimeBtn:(id)sender;
{
    if (self.PE_AlltimeBtn.selected)
    {
        self.PE_AlltimeBtn.selected=NO;
    }
    else
    {
        self.PE_AlltimeBtn.selected=YES;
    }
}

-(IBAction)isPE_DontBtn:(id)sender;
{
    if (self.PE_DontBtn.selected)
    {
        self.PE_DontBtn.selected=NO;
    }
    else
    {
        self.PE_DontBtn.selected=YES;
    }
}

-(IBAction)isPE_ZFBBtn:(id)sender;
{
    if (self.PE_ZFBBtn.selected)
    {
        self.PE_ZFBBtn.selected=NO;
    }
    else
    {
        self.PE_ZFBBtn.selected=YES;
    }
}

-(IBAction)isPE_WULIUBtn:(id)sender;
{
    if (self.PE_WULIUBtn.selected)
    {
        self.PE_WULIUBtn.selected=NO;
        
        self.yunfeiView.hidden = YES;
        
        self.PE_NEXTBtn.frame = CGRectMake(self.PE_NEXTBtn.frame.origin.x, CGRectGetMaxY(self.wuliuView.frame) + 5, self.PE_NEXTBtn.frame.size.width, self.PE_NEXTBtn.frame.size.height);
    }
    else
    {
        self.PE_WULIUBtn.selected=YES;
        
        self.yunfeiView.hidden = NO;
        
        self.yunfeiView.frame = CGRectMake(self.yunfeiView.frame.origin.x, CGRectGetMaxY(self.wuliuView.frame) + 5, self.yunfeiView.frame.size.width, self.yunfeiView.frame.size.height);
        
        self.PE_NEXTBtn.frame = CGRectMake(self.PE_NEXTBtn.frame.origin.x, CGRectGetMaxY(self.yunfeiView.frame) + 5, self.PE_NEXTBtn.frame.size.width, self.PE_NEXTBtn.frame.size.height);
//        
//        UITextField *textfield = [[UITextField alloc] initWithFrame:CGRectMake(self.PE_Num.bounds.origin.x, CGRectGetMaxY(self.PE_WULIUBtn.frame) + 10, self.PE_Num.bounds.size.width, self.PE_Num.bounds.size.height)];
//        
//        self.yunfeiField = textfield;
//        
//        [self.view addSubview:textfield];
        
    }
}

-(BOOL)textlegthPExpen
{
  
    if(self.PE_Data.text.length==0||[self.PE_Data.text isEqualToString:@""])
    {
        [SVProgressHUD showErrorWithStatus:@"请选择下架日期"];
        [self.P_ExpenseSetScrollView setContentOffset:CGPointMake(0,0) animated:YES];

        return NO;
    }
    else if(self.PE_Oldprice.text.length==0||[self.PE_Oldprice.text isEqualToString:@""])
    {
        [SVProgressHUD showErrorWithStatus:@"请填写原来价钱"];
        [self.P_ExpenseSetScrollView setContentOffset:CGPointMake(0,0) animated:YES];

        return NO;
    }
    else if(self.PE_Newprice.text.length==0||[self.PE_Newprice.text isEqualToString:@""])
    {
        [SVProgressHUD showErrorWithStatus:@"请填写城与城价钱"];

        if (iPhone5)
        {
            [self.P_ExpenseSetScrollView setContentOffset:CGPointMake(0,132) animated:YES];
        }
        else
        {
            [self.P_ExpenseSetScrollView setContentOffset:CGPointMake(0,165) animated:YES];
        }


        return NO;
    }
    else if(self.PE_Scale.text.length==0||[self.PE_Scale.text isEqualToString:@""])
    {
        [SVProgressHUD showErrorWithStatus:@"请填写返利比例"];
        
        if (iPhone5)
        {
            
            [self.P_ExpenseSetScrollView setContentOffset:CGPointMake(0,132) animated:YES];
        }
        else
        {
            [self.P_ExpenseSetScrollView setContentOffset:CGPointMake(0,215) animated:YES];
        }

        return NO;
    }
    else if(self.PE_KEY1.text.length==0||[self.PE_KEY1.text isEqualToString:@""])
    {
        [SVProgressHUD showErrorWithStatus:@"请选择KEY值有效期"];
        
        if (iPhone5)
        {
            
            [self.P_ExpenseSetScrollView setContentOffset:CGPointMake(0,132) animated:YES];
        }
        else
        {
            [self.P_ExpenseSetScrollView setContentOffset:CGPointMake(0,215) animated:YES];
        }

        return NO;
    }
    else if(self.PE_KEY2.text.length==0||[self.PE_KEY2.text isEqualToString:@""])
    {
        [SVProgressHUD showErrorWithStatus:@"请选择KEY值有效期"];
        
        if (iPhone5)
        {
            
            [self.P_ExpenseSetScrollView setContentOffset:CGPointMake(0,132) animated:YES];
        }
        else
        {
            [self.P_ExpenseSetScrollView setContentOffset:CGPointMake(0,215) animated:YES];
        }

        return NO;
    }
    else if(self.PE_Num.text.length==0||[self.PE_Num.text isEqualToString:@""])
    {
        [SVProgressHUD showErrorWithStatus:@"请填写产品数量"];
        if (iPhone5)
        {
   
            [self.P_ExpenseSetScrollView setContentOffset:CGPointMake(0,132) animated:YES];
        }
        else
        {
            [self.P_ExpenseSetScrollView setContentOffset:CGPointMake(0,215) animated:YES];
        }

        return NO;
    }

    return YES;
    
}


//保存值先在字典里
-(void)setDatatoDIC
{

    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        return;
    }
    
    NSString * memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString * key = [CommonUtil getServerKey];
    NSString * serviceId = [self.Pexpensedic objectForKey:@"ServiceID"];
    NSString * shelfTime =self.PE_Data.text;//下架时间
    NSString * originalPrice =self.PE_Oldprice.text;//原价
    NSString * price =self.PE_Newprice.text;//城价
    NSString * commissionRate =self.PE_Scale.text;//比例
    NSString * keyVaildDateS =self.PE_KEY1.text;
    NSString * keyVaildDateE =self.PE_KEY2.text;
    NSString * quantity =self.PE_Num.text;//数量
    
    NSString * isExpiredReturn;
    if (self.PE_PastBtn.selected)
    {
        isExpiredReturn = @"Yes";
    }
    else
    {
        isExpiredReturn = @"No";
    }
    NSString * isAnyTimeReturn;

    if (self.PE_AlltimeBtn.selected)
    {
        isAnyTimeReturn = @"Yes";
    }
    else
    {
      isAnyTimeReturn = @"No";
    }
    NSString * isReservation;

    if (self.PE_DontBtn.selected)
    {
        isReservation = @"Yes";
    }
    else
    {
        isReservation =@"No";
    }
    NSString * isPE_WULIUBtn;

    if (self.PE_WULIUBtn.selected)
    {
        isPE_WULIUBtn = @"1";
    }
    else
    {
        isPE_WULIUBtn =@"0";
    }
    
    
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"memberId",
                           key,@"key",
                           serviceId,@"serviceId",
                           shelfTime,@"shelfTime",
                           originalPrice,@"originalPrice",
                           price,@"price",
                           commissionRate,@"commissionRate",
                           keyVaildDateS,@"keyVaildDateS",
                           keyVaildDateE,@"keyVaildDateE",
                           quantity,@"quantity",
                           isExpiredReturn,@"isExpiredReturn",
                           isAnyTimeReturn,@"isAnyTimeReturn",
                           isReservation,@"isReservation",
                           isPE_WULIUBtn,@"isWuliu",
                           nil];
        
    [SVProgressHUD showWithStatus:@"数据提交中"];
    NSLog(@"%@",param);
    
    [httpClient request:@"ServiceAddStep2_1.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            [SVProgressHUD dismiss];
            
            PimageViewController *PimageVC=[[PimageViewController alloc]initWithNibName:@"PimageViewController" bundle:nil];
            PimageVC.P_AddORSubmit=@"1";
            [self.navigationController pushViewController:PimageVC animated:YES];
            
        } else {
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];
    

    
    


}





-(IBAction)PTwoToNextThree:(id)sender
{
    
    if ([self textlegthPExpen])
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyy/MM/dd"];
        NSDate *tempDate1 = [dateFormatter dateFromString:[NSString stringWithFormat:@"%@",self.PE_KEY1.text]];
        NSDate *tempDate2 = [dateFormatter dateFromString:[NSString stringWithFormat:@"%@",self.PE_KEY2.text]];
        NSTimeInterval timeBetween = [tempDate1 timeIntervalSinceDate:tempDate2];
        if (timeBetween>0) {
            [SVProgressHUD showErrorWithStatus:@"KEY值开始日期必须小于结束日期"];
            if (iPhone5)
            {
                
                [self.P_ExpenseSetScrollView setContentOffset:CGPointMake(0,132) animated:YES];
            }
            else
            {
                [self.P_ExpenseSetScrollView setContentOffset:CGPointMake(0,215) animated:YES];
            }
            return;
        }
        
        [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
        
        [self setDatatoDIC];

    }
    
}

@end
