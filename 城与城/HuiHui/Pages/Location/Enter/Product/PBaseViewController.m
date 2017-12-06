//
//  PBaseViewController.m
//  baozhifu
//
//  Created by 冯海强 on 14-1-12.
//  Copyright (c) 2014年 mac. All rights reserved.
//


#import "PBaseViewController.h"
#import "PExpenseSetViewController.h"
#import "ChoseShopViewController.h"
#import "DowncellViewController.h"
#import "CommonUtil.h"
#import "SVProgressHUD.h"
#import "AppHttpClient.h"

@interface PBaseViewController ()

@property (nonatomic,weak) IBOutlet UITextField *P_Businesser;
@property (nonatomic,weak) IBOutlet UIButton *P_Businesser_Btn;

@property (nonatomic,weak) IBOutlet UITextField *P_shop;
@property (nonatomic,weak) IBOutlet UIButton *P_shop_Btn;

@property (nonatomic,weak) IBOutlet UITextField *P_one;
@property (nonatomic,weak) IBOutlet UIButton *P_one_Btn;

@property (nonatomic,weak) IBOutlet UITextField *P_two;
@property (nonatomic,weak) IBOutlet UIButton *P_two_Btn;

//@property (nonatomic,weak) IBOutlet UITextField *P_name;
@property (weak, nonatomic) IBOutlet UITextView *P_name;

@property (weak, nonatomic) IBOutlet UILabel *P_nameTip;


@property (nonatomic,weak) IBOutlet UITextField *P_smallname;
@property (nonatomic,weak) IBOutlet UITextField *P_tags;
@property (nonatomic,weak) IBOutlet UITextView *P_remind;
@property (nonatomic,weak) IBOutlet UILabel *P_remind_lab;

@property (nonatomic,weak) IBOutlet UITextView *P_introduce;
@property (nonatomic,weak) IBOutlet UILabel *P_introduce_lab;

@property (nonatomic,weak) UIButton *P_template_Btn;//模板按钮

@end

@implementation PBaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.Pbasearray=[[NSMutableArray alloc]initWithCapacity:0];
        self.Pbasedic=[[NSMutableDictionary alloc]initWithCapacity:0];
        self.chosearrayname = [[NSMutableArray alloc]initWithCapacity:0];
        self.chosearraycode = [[NSMutableArray alloc]initWithCapacity:0];
        
        
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self hideTabBar:YES];

    [self hiddenNumPadDone:nil];

    
}

- (void)viewWillDisappear:(BOOL)animated
{
    
    [super viewWillDisappear:animated];
    
    self.m_pickerToolBar.hidden = YES;
    
    self.m_pickerView.hidden = YES;
    
    KEYlabel.hidden=YES;
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.P_Businesser_Btn.tag=1;self.P_shop_Btn.tag=2;
    self.P_one_Btn.tag=3;self.P_two_Btn.tag=4;
    
    self.P_name.delegate=self;
    self.P_smallname.delegate=self;
    self.P_tags.delegate=self;
    self.P_remind.delegate=self;self.P_remind.tag=1;
    self.P_introduce.delegate=self;self.P_introduce.tag=2;
    
    if (iPhone5)
    {
        [self.P_BasicScrollView setContentSize:CGSizeMake(WindowSize.size.width,1005)];
        
    }else{
        
        [self.P_BasicScrollView setContentSize:CGSizeMake(WindowSize.size.width,980)];
    }
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    
    self.P_template_Btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.P_template_Btn setFrame:CGRectMake(0, 0, 60, 29)];
    self.P_template_Btn.backgroundColor = [UIColor clearColor];
    [self.P_template_Btn setImage:[UIImage imageNamed:@"comm_check_box_def.png"] forState:UIControlStateNormal];
    [self.P_template_Btn setTitle:@"模板" forState:UIControlStateNormal];
    self.P_template_Btn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [self.P_template_Btn addTarget:self action:@selector(P_template) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *_barButton = [[UIBarButtonItem alloc] initWithCustomView:self.P_template_Btn];
    [self.navigationItem setRightBarButtonItem:_barButton];

    
    
    UIImage*selectedimage=[UIImage imageNamed:@"comm_check_box_selected.png"];
    UIImage*unselectedimage=[UIImage imageNamed:@"comm_check_box_def.png"];
    [self.P_template_Btn setImage:selectedimage forState:UIControlStateSelected];
    [self.P_template_Btn setImage:unselectedimage forState:UIControlStateNormal];
    
    
    [self setTitle:@"基本信息"];

    // 初始化pickerView
    [self initpickerView];
    self.m_pickerView.hidden = YES;
    
    self.m_pickerToolBar.hidden = YES;
    
    KEYlabel = [[UILabel alloc]initWithFrame:CGRectMake(60,self.m_pickerView.frame.origin.y - 44, 200, 44)];
    KEYlabel.text = @"请选择模板";
    KEYlabel.font = [UIFont systemFontOfSize:15];
    KEYlabel.lineBreakMode = UILineBreakModeWordWrap;
    KEYlabel.numberOfLines = 0;
    KEYlabel.textAlignment = UITextAlignmentCenter;
    KEYlabel.textColor = [UIColor whiteColor];
    KEYlabel.backgroundColor = [UIColor clearColor];
    UIWindow *window = self.navigationController.view.window;
    
    [window addSubview:KEYlabel];
    KEYlabel.hidden=YES;
    
    
    [self ServiceAddStep1];
    
}


//临时数据
-(void)ServiceAddStep1
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
            
            self.Pbasedic = [json valueForKey:@"SvcAddStep"];
            
            self.P_Businesser.text = [self.Pbasedic objectForKey:@"MerchantAllName"];
            self.P_shop.text =[self.Pbasedic objectForKey:@"MerchantShopName"];
            self.P_one.text =[self.Pbasedic objectForKey:@"FirstClassName"];
            self.P_two.text =[self.Pbasedic objectForKey:@"ClassName"];
            BusinessID =[self.Pbasedic objectForKey:@"MerchantID"];
            ShopID =[self.Pbasedic objectForKey:@"MerchantShopIDs"];
            oneID =[self.Pbasedic objectForKey:@"FirstClassID"];
            twoID =[self.Pbasedic objectForKey:@"ClassID"];
            self.P_name.text =[self.Pbasedic objectForKey:@"SvcName"];
            self.P_smallname.text =[self.Pbasedic objectForKey:@"SvcSimpleName"];
            self.P_tags.text =[self.Pbasedic objectForKey:@"Tags"];
            self.P_remind.text =[self.Pbasedic objectForKey:@"Explain"];
            self.P_introduce.text = [self.Pbasedic objectForKey:@"Introduction"];
            if (![self.P_remind.text isEqualToString:@""]) {
                self.P_remind_lab.hidden = YES;
            }
            if (![self.P_introduce.text isEqualToString:@""]) {
                self.P_introduce_lab.hidden = YES;
            }

            if (![self.P_name.text isEqualToString:@""]) {
                self.P_nameTip.hidden = YES;
            }
        
            self.LimitRebate = [NSString stringWithFormat:@"%@",[self.Pbasedic objectForKey:@"LimitRebate"]];
            self.RebatesType = [NSString stringWithFormat:@"%@",[self.Pbasedic objectForKey:@"RebatesType"]];
            
            NSLog(@"LimitRebate1111111111 = %@",self.LimitRebate);
            
        }
        else {
            
            [self.Pbasedic setObject:@"0" forKey:@"ServiceID"];
            
        }
        
        
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];
    
    
}



- (void)leftClicked{
    
    [self goBack];
    
}


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if ([isActionInView isEqualToString:@"isActionInView"])
    {
        isActionInView = nil;
        
        UIActionSheet *sheet  = [[UIActionSheet alloc] initWithTitle:@"模板" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"选择模板使用",nil];
        
        sheet.tag = 101;
        [sheet showInView:self.view];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//选择模板
-(void)P_template
{
    
    if (self.P_template_Btn.selected)
    {
        self.P_template_Btn.selected=NO;
        
        [self PortTemplatenil];
    }
    else
    {
        if (self.P_one.text==nil||[self.P_one.text  isEqualToString:@""]) {
            [SVProgressHUD showErrorWithStatus:@"必须先选择产品的类型"];
            [self.P_BasicScrollView setContentOffset:CGPointMake(0, 152) animated:YES];
            return;
        }
        
        
        [self template:oneID two:@"0"];
        
        /////////////调模板接口
        
    }
}



#pragma mark -初始化显示地区的pickerView
- (void)initpickerView{
    UIWindow *window = self.navigationController.view.window;
	
	//  datePickerView初始化
	self.m_pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 216, WindowSizeWidth, 216)];
    self.m_pickerView.backgroundColor = [UIColor whiteColor];
    self.m_pickerView.delegate = self;
    self.m_pickerView.dataSource = self;
    // 设置pickerView选择时的背景，默认的为NO
    self.m_pickerView.showsSelectionIndicator = YES;
	[window addSubview:self.m_pickerView];
    
	//添加 PickerView上面的左右按钮
    UIBarButtonItem *pickItemCancle = [[UIBarButtonItem alloc] initWithTitle:@"取消"
                                                                       style:UIBarButtonItemStylePlain
                                                                      target:self
                                                                      action:@selector(doPickerCancel:)];
    pickItemCancle.style = UIBarButtonItemStyleBordered;
    
    UIBarButtonItem *pickItemOK = [[UIBarButtonItem alloc]initWithTitle:@"确定"
                                                                  style:UIBarButtonItemStylePlain
                                                                 target:self
                                                                 action:@selector(doPickerDone:)];
    pickItemOK.style = UIBarButtonItemStyleBordered;
    
    UIBarButtonItem *pickSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItem)UIBarButtonSystemItemFlexibleSpace
                                                                               target:self
                                                                               action:nil];
    // 自定义PickerView顶部的Toolbar，加载左右的取消和确定按钮
    UIToolbar *pickerBar = [[UIToolbar alloc] init];
    pickerBar.barStyle = UIBarStyleBlackTranslucent;
    NSArray *pickArray = [NSArray arrayWithObjects:pickItemCancle, pickSpace, pickItemOK,nil];
    [pickerBar setItems:pickArray animated:YES];
    pickerBar.frame = CGRectMake(0, self.m_pickerView.frame.origin.y - 44, WindowSizeWidth, 44);
    [window addSubview:pickerBar];
    pickerBar.backgroundColor = [UIColor clearColor];
    self.m_pickerToolBar = pickerBar;
    
}

#pragma mark - PickerBar按钮
- (void)doPickerDone:(id)sender{
    
    if (self.isSelected !=YES)
    {
        return;
    }else
    {
        
        self.view.userInteractionEnabled = YES;
        
        self.m_pickerView.hidden = YES;
        
        self.m_pickerToolBar.hidden = YES;
        KEYlabel.hidden=YES;
        
        self.isSelected = NO;
        
        
        [self Insetertemplate:self.m_merchantID];
        
    }
    
    
}

- (void)doPickerCancel:(id)sender{
    
    self.view.userInteractionEnabled = YES;
    
    self.m_pickerView.hidden = YES;
    
    self.m_pickerToolBar.hidden = YES;
    KEYlabel.hidden=YES;
    
}

//插入模板
-(void)Insetertemplate: (NSString *)templateID
{
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           templateID,@"templateID",
                           nil];
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"TemplateDetail.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            
            [SVProgressHUD dismiss];
            
            NSDictionary *dic = [json valueForKey:@"TemDetail"];
            
            
            self.P_name.text =[NSString stringWithFormat:@"%@",[dic objectForKey:@"SvcName"]];
            self.P_smallname.text= [NSString stringWithFormat:@"%@",[dic objectForKey:@"SvcSimpleName"]];
            self.P_tags.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"SvcTags"]];
            self.P_remind.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"SvcIntroduction"]];
            self.P_introduce.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"SvcExplain"]];
            
            
            self.P_template_Btn.selected=YES;
            
        }
        else
        {
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
        
    } failure:^(NSError *error) {
        
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}


#pragma mark - UIPickerViewDelegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 1;
    
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    return self.chosearrayname.count;
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    
    NSString * titleResult = [NSString stringWithFormat:@"%@",[self.chosearrayname objectAtIndex:row]];
    
    return titleResult;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    self.isSelected = YES;
    
    self.m_merchantID= [self.chosearraycode objectAtIndex:row];
    
    for (int i=0; i<[pickerView numberOfComponents]; i++) {
        
        [self.m_pickerView reloadComponent:i];
        
    }
    
}




//暂无模板清空数据
-(void)PortTemplatenil
{
    self.P_name.text=self.P_smallname.text=self.P_tags.text=self.P_remind.text=self.P_introduce.text=nil;
    self.P_remind_lab.hidden=NO;
    self.P_introduce_lab.hidden=NO;
    self.P_nameTip.hidden = NO;
}

//获取模板下拉
-(void)template:(NSString *)svcClassID two:(NSString*)activityCategoryID
{
    
    [self.chosearrayname removeAllObjects];
    
    [self.chosearraycode removeAllObjects];
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    NSString *templateType = @"MerchantProductTemplate";
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           
                           templateType,@"templateType",
                           svcClassID,@"svcClassID",
                           activityCategoryID,@"activityCategoryID",
                           nil];
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"TemplateKeyValue.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            
            [SVProgressHUD dismiss];
            NSMutableArray *metchantShop = [json valueForKey:@"KeyValueList"];
            if (metchantShop == nil || metchantShop.count == 0) {
                [self.chosearrayname removeAllObjects];
                [SVProgressHUD showErrorWithStatus:@"暂无模板"];
                
                return;
            } else {
                
                for (NSDictionary *data in metchantShop)
                {
                    [self.chosearrayname addObject:[data objectForKey:@"Value"]];
                    
                    [self.chosearraycode addObject:[data objectForKey:@"Key"]];
                }
                self.view.userInteractionEnabled = NO;
                
                [self.view endEditing:YES];
                
                self.m_pickerToolBar.hidden = NO;
                
                self.m_pickerView.hidden = NO;
                
                KEYlabel.hidden=NO;
                
                [self.m_pickerView reloadAllComponents];
                
                self.m_merchantID= [self.chosearraycode objectAtIndex:0];
                self.isSelected=YES;
                self.P_remind_lab.hidden=YES;
                self.P_introduce_lab.hidden=YES;
                self.P_nameTip.hidden = YES;
                
            }
            
            
        }
        else
        {
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
        
    } failure:^(NSError *error) {
        
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
    
    
    
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (/*(textField == self.P_name)||*/(textField == self.P_smallname)||(textField == self.P_tags))
    {
        [textField resignFirstResponder];
    }
    return YES;
}


-(void)textViewDidChange:(UITextView *)textView
{
    if (textView.tag==1)
    {
        if (textView.text.length == 0) {
            self.P_remind_lab.text = @"特别提醒*";
            
        }else{
            self.P_remind_lab.text = @"";
        }
    }else if (textView.tag==2)
    {
        if (textView.text.length == 0) {
            self.P_introduce_lab.text = @"商户简介*";
            
        }else{
            self.P_introduce_lab.text = @"";
        }
        
    }else if (textView.tag==33)
    {
        if (textView.text.length == 0) {
            self.P_nameTip.text = @"产品全称*";
            
        }else{
            self.P_nameTip.text = @"";
        }
        
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField;
{
    [self hiddenNumPadDone:nil];
}



-(IBAction)textfieldChoseButton:(UIButton*)sender
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
    if (sender.tag==1)
    {
        DowncellViewController*downVC=[[DowncellViewController alloc]initWithNibName:@"DowncellViewController" bundle:nil];
        
        downVC.Itemstyle = @"Business";
        downVC.Chosedelegate = self;
        [self.navigationController pushViewController:downVC animated:YES];

    }else if (sender.tag==2)
    {
        if (self.P_Businesser.text==nil||[self.P_Businesser.text isEqualToString:@""])
        {
            [SVProgressHUD showErrorWithStatus:@"请先选择商户"];
            return;
        }
        ChoseShopViewController*downVC=[[ChoseShopViewController alloc]initWithNibName:@"ChoseShopViewController" bundle:nil];
        
        downVC.chosemerchantId=BusinessID;
        
        downVC.Choseshopdelegate =self;
    
        [self.navigationController pushViewController:downVC animated:YES];
    }else if (sender.tag==3)
    {
        DowncellViewController*downVC=[[DowncellViewController alloc]initWithNibName:@"DowncellViewController" bundle:nil];
        
        downVC.Itemstyle = @"B_one";
        downVC.Chosedelegate = self;
        [self.navigationController pushViewController:downVC animated:YES];

    }else if (sender.tag==4)
    {
        if (self.P_one.text==nil||[self.P_one.text isEqualToString:@""])
        {
            [SVProgressHUD showErrorWithStatus:@"请先选择一级类型"];
            return;
        }
        
        DowncellViewController*downVC=[[DowncellViewController alloc]initWithNibName:@"DowncellViewController" bundle:nil];
        
        downVC.Itemstyle = @"B_two";
        downVC.Needtwo = oneID;
        downVC.Chosedelegate = self;
        [self.navigationController pushViewController:downVC animated:YES];

    }
}



- (void)ChosesbusinessValue:(NSString *)value code:(NSString *)Bcode Special:(NSString *)Specialstring LimitRebate:(NSString *)LimitRebatestring RebatesType:(NSString *)RebatesTypestring; //选择商户
{
    
    NSLog(@"LimitRebatestring  =%@",LimitRebatestring);
 
    if ([self.P_Businesser.text isEqualToString:value]) {
        return;
    }
    self.P_Businesser.text =value;
    BusinessID = Bcode;
    IsSpecial = Specialstring;
    
    //商户变了。店铺肯定也变了
    self.P_shop.text=@"";
    ShopID = @"";
    
    self.LimitRebate = LimitRebatestring;
    self.RebatesType = RebatesTypestring;//返利类别
    
    
    NSLog(@"self.LimitRebate  =%@",self.LimitRebate);

    
    
}

-(void)ChosesshopValue:(NSString *)value code:(NSString *)shopcode
{
    if ([self.P_shop.text isEqualToString:value]) {
        return;
    }
    self.P_shop.text =value;
    ShopID =shopcode;
}


//////////////
- (void)ChosesoneValue:(NSString *)value code:(NSString *)onecode
{
    if ([self.P_one.text isEqualToString:value]) {
        return;
    }
    self.P_one.text = value;
    oneID = onecode;
    
    //一级类别变了，二级肯定也变了
    self.P_two.text = @"";
    twoID = @"";
    
    isActionInView = @"isActionInView";

}

/////////////
- (void)ChosestwoValue:(NSString *)value code:(NSString *)twocode
{
    if ([self.P_two.text isEqualToString:value]) {
        return;
    }
    
    self.P_two.text = value;
    twoID = twocode;
    
}



#pragma mark UIActionSheetDelegate Method
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (actionSheet.tag == 101)
    {
    
        if (buttonIndex==0){
            
            [self template:oneID two:@"0"];
            
        }

    }

}



- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField;
{
    /*if (textField == self.P_name)
    {
        [self.P_BasicScrollView setContentOffset:CGPointMake(0,152) animated:YES];
    }
    else*/ if (textField == self.P_smallname)
    {
        [self.P_BasicScrollView setContentOffset:CGPointMake(0,266) animated:YES];
    }
    else if (textField == self.P_tags)
    {
        [self.P_BasicScrollView setContentOffset:CGPointMake(0,340) animated:YES];
        
    }
    
    self.P_BasicScrollView.bouncesZoom = NO;
    
    return YES;
}


- (void)textViewDidBeginEditing:(UITextView *)textView;
{
    
    [self hiddenNumPadDone:nil];
    
    if (textView == self.P_remind)
    {
        [self.P_BasicScrollView setContentOffset:CGPointMake(0,415) animated:YES];
    }
    else if (textView == self.P_introduce)
    {
        if (iPhone5)
        {
            [self.P_BasicScrollView setContentOffset:CGPointMake(0,540) animated:YES];
        }
        else
        {
            [self.P_BasicScrollView setContentOffset:CGPointMake(0, 602) animated:YES];
            
        }
    }
    self.P_BasicScrollView.bouncesZoom = NO;
    
}


-(BOOL)textlegthpbase
{
    
    if(self.P_Businesser.text.length==0||[self.P_Businesser.text isEqualToString:@""])
    {
        [SVProgressHUD showErrorWithStatus:@"请选择所属商户"];
        [self.P_BasicScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        
        return NO;
    }
    else if(self.P_shop.text.length==0||[self.P_shop.text isEqualToString:@""])
    {
        [SVProgressHUD showErrorWithStatus:@"请选择所属店铺"];
        [self.P_BasicScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        
        return NO;
    }
    else if(self.P_one.text.length==0||[self.P_one.text isEqualToString:@""])
    {
        [SVProgressHUD showErrorWithStatus:@"请选择商品一级类型"];
        [self.P_BasicScrollView setContentOffset:CGPointMake(0, 152) animated:YES];
        
        return NO;
    }
    else if(self.P_two.text.length==0||[self.P_two.text isEqualToString:@""])
    {
        [SVProgressHUD showErrorWithStatus:@"请选择商品二级类型"];
        [self.P_BasicScrollView setContentOffset:CGPointMake(0, 152) animated:YES];
        
        return NO;
    }
    else if(self.P_name.text.length==0||[self.P_name.text isEqualToString:@""])
    {
        [SVProgressHUD showErrorWithStatus:@"请填写产品名称"];
        [self.P_BasicScrollView setContentOffset:CGPointMake(0, 226) animated:YES];
        
        return NO;
    }
    else if(self.P_smallname.text.length==0||[self.P_smallname.text isEqualToString:@""])
    {
        [SVProgressHUD showErrorWithStatus:@"请填写产品简称"];
        [self.P_BasicScrollView setContentOffset:CGPointMake(0, 340) animated:YES];
        
        return NO;
    }
    else if(self.P_tags.text.length==0||[self.P_tags.text isEqualToString:@""])
    {
        [SVProgressHUD showErrorWithStatus:@"请填写产品标签"];
        [self.P_BasicScrollView setContentOffset:CGPointMake(0, 415) animated:YES];
        
        return NO;
    }
    else if(self.P_remind.text.length==0||[self.P_remind.text isEqualToString:@""])
    {
        [SVProgressHUD showErrorWithStatus:@"请填写特别提醒"];
        [self.P_BasicScrollView setContentOffset:CGPointMake(0,415) animated:YES];
        
        return NO;
    }
    else if(self.P_introduce.text.length==0||[self.P_introduce.text isEqualToString:@""])
    {
        [SVProgressHUD showErrorWithStatus:@"请填写产品简介"];
        if (iPhone5)
        {
            [self.P_BasicScrollView setContentOffset:CGPointMake(0,540) animated:YES];
        }
        else
        {
            [self.P_BasicScrollView setContentOffset:CGPointMake(0, 602) animated:YES];
            
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
    NSString * serviceId = [self.Pbasedic objectForKey:@"ServiceID"];
    NSString * merchantId =BusinessID;
    NSString * merchantAllName =self.P_Businesser.text;
    NSString * merchantShopIDs =ShopID;
    NSString * merchantShopNames =self.P_shop.text;
    NSString * classId =twoID;
    NSString * svcName =self.P_name.text ;
    NSString * svcSimpleName =self.P_smallname.text;
    NSString * tags = self.P_tags.text;
    NSString * explain =self.P_remind.text;
    NSString * introduction =self.P_introduce.text;
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"memberId",
                           key,@"key",
                           serviceId,@"serviceId",
                           merchantId,@"merchantId",
                           merchantAllName,@"merchantAllName",
                           merchantShopIDs,@"merchantShopIDs",
                           merchantShopNames,@"merchantShopNames",
                           classId,@"classId",
                           svcName,@"svcName",
                           svcSimpleName,@"svcSimpleName",
                           tags,@"tags",
                           explain,@"explain",
                           introduction,@"introduction",
                           nil];
        
    [SVProgressHUD showWithStatus:@"数据提交中"];
    
    [httpClient request:@"ServiceAddStep1.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            [SVProgressHUD dismiss];
            
            NSLog(@"LimitRebate = %@",self.LimitRebate);
            
            PExpenseSetViewController *RunVC=[[PExpenseSetViewController alloc]initWithNibName:@"PExpenseSetViewController" bundle:nil];
            
            RunVC.LimitRebate = self.LimitRebate;
            RunVC.RebatesType = self.RebatesType;
            
            [self.navigationController pushViewController:RunVC animated:YES];
            
        } else {
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];
    

    

}




-(IBAction)POneToNextTwo:(id)sender
{
    if ([self textlegthpbase])
    {
        [[[UIApplication sharedApplication] keyWindow] endEditing:YES];

        [self setDatatoDIC];
        
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
    
}



@end
