//
//  LaunchActivityViewController.m
//  baozhifu
//
//  Created by mac on 14-3-4.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "LaunchActivityViewController.h"

#import "ActivitySaleViewController.h"

#import "CommonUtil.h"

#import "AppHttpClient.h"

#import "SVProgressHUD.h"

@interface LaunchActivityViewController ()

@property (weak, nonatomic) IBOutlet UIView *m_titleView;

@property (weak, nonatomic) IBOutlet UIView *m_tempView;

@property (weak, nonatomic) IBOutlet UIScrollView *m_scrollerVIew;

@property (weak, nonatomic) IBOutlet UITextField *m_merchantTextField;

@property (weak, nonatomic) IBOutlet UITextField *m_typeTextField;

@property (weak, nonatomic) IBOutlet UITextField *m_activityName;

@property (weak, nonatomic) IBOutlet UITextField *m_modelTextField;

@property (weak, nonatomic) IBOutlet UITextView *m_infoTextView;

@property (weak, nonatomic) IBOutlet UITextView *m_anPaiTextView;

@property (weak, nonatomic) IBOutlet UITextView *m_tipTextView;

@property (weak, nonatomic) IBOutlet UILabel *m_infoLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_anpaiLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_tipLabel;

@property (weak, nonatomic) IBOutlet UIButton *m_modelBtn;


// 选择商户按钮触发的事件
- (IBAction)chooseMerchant:(id)sender;
// 选择分类
- (IBAction)chooseType:(id)sender;
// 选择模板
- (IBAction)chooseModel:(id)sender;
// 下一步按钮触发的事件
- (IBAction)nextStep:(id)sender;


@end

@implementation LaunchActivityViewController



@synthesize m_oneArray;

@synthesize m_twoArray;

@synthesize m_pickerToolBar;

@synthesize m_pickerView;

@synthesize isSelected;

@synthesize m_merchantArray;

@synthesize m_modelArray;

@synthesize m_dic;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        m_oneArray = [[NSMutableArray alloc]initWithCapacity:0];
        
        m_twoArray = [[NSMutableArray alloc]initWithCapacity:0];
        
        dbhelp = [[DBHelper alloc] init];
        
        isSelected = NO;
        
        m_merchantArray = [[NSMutableArray alloc]initWithCapacity:0];
        
        m_modelArray = [[NSMutableArray alloc]initWithCapacity:0];
        
        m_dic = [[NSMutableDictionary alloc]initWithCapacity:0];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setTitle:@"策划活动"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    // 初始化pickerView
    [self initpickerView];
    
    self.m_pickerView.hidden = YES;
    
    self.m_pickerToolBar.hidden = YES;
    
    self.m_categoryString = @"";
    
    self.m_merchantString1 = @"";
    
    self.m_modelString1 = @"";
    
    // 默认为0
    self.m_merchantId = @"0";
    
    self.m_serviceId = @"0";
    
    self.m_productId = @"0";
    
    self.m_productId2 = @"0";
    
    self.m_modelId = @"";
    
    self.m_modelId1 = @"";
    
    self.m_modelId2 = @"";
    // 按钮可点击
    self.m_modelBtn.userInteractionEnabled = YES;
    self.m_modelTextField.userInteractionEnabled = NO;
    
    // 设置默认的数组
    if ( [dbhelp queryCategory].count != 0 ) {
        
        self.m_oneArray = [dbhelp queryCategory];
        
        NSDictionary *dic = [self.m_oneArray objectAtIndex:0];
        
        self.m_twoArray = [dbhelp queryProject:[dic objectForKey:@"code"]];
        
        self.m_categoryString1 = [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];
        self.m_serviceId1 = [NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        
        NSDictionary *dic1 = [self.m_twoArray objectAtIndex:0];
        
        self.m_projectString1 = [NSString stringWithFormat:@"%@",[dic1 objectForKey:@"name"]];
        
        self.m_productId1 = [NSString stringWithFormat:@"%@",[dic1 objectForKey:@"code"]];
        
    }
    
    // 设置scrollerView的滚动范围
    [self.m_scrollerVIew setContentSize:CGSizeMake(WindowSizeWidth, 900)];
    
    self.m_typeString = @"Merchant";

    // 商户数据请求网络
    [self MerchantRequestSubmit];
    
    if ( [self.m_StringType isEqualToString:@"1"] ) {
        
        // 新增
        
    }else{
        
        // 编辑
        
        // 来自于编辑的页面
        [self editDataRequestSubmit];
    }
    
    // 设置键盘上面的完成按钮
    [self createKeyboard];

}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear: animated];
    
    [self hideTabBar:YES];

}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [self hideTabBar:NO];
    
    m_pickerToolBar.hidden = YES;
    
    m_pickerView.hidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)leftClicked{
    
    [self goBack];
}

//在键盘上加一个完成按钮，取消键盘
- (void)createKeyboard
{
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, WindowSizeWidth, 44)];
    toolbar.barStyle = UIBarStyleBlackTranslucent;
    self.m_textToolBar = toolbar;
    
    UIBarButtonItem *lastButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成"
                                                                       style:UIBarButtonItemStyleDone
                                                                      target:self
                                                                      action:@selector(removeKeyborad:)];
    
    UIBarButtonItem *spaceButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                    target:nil
                                                                                    action:nil];
    
    NSArray *array = [NSArray arrayWithObjects: spaceButtonItem,lastButtonItem, nil];
    [self.m_textToolBar setItems:array];
    
    self.m_infoTextView.inputAccessoryView = self.m_textToolBar;
    
    self.m_anPaiTextView.inputAccessoryView = self.m_textToolBar;
    
    self.m_tipTextView.inputAccessoryView = self.m_textToolBar;
    
}

//关闭键盘
- (void)removeKeyborad:(id)sender
{
	[self.view endEditing:YES];
}


- (IBAction)nextStep:(id)sender {
    
    if ( self.m_merchantTextField.text.length == 0 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请选择所属商户"];
        
        return;
    }
    
    if ( self.m_typeTextField.text.length == 0 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请选择活动类型"];
        
        return;
    }
    
    if ( self.m_activityName.text.length == 0 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请输入活动名称"];
        
        return;
    }
    
    if ( self.m_infoTextView.text.length == 0 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请输入活动简介"];
        
        return;
    }
    
    if ( self.m_anPaiTextView.text.length == 0 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请输入活动安排"];
        
        return;
    }

    
    if ( self.m_tipTextView.text.length == 0 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请输入特别提示"];
        
        return;
    }
    
    // 存储数据
    [self.m_dic setObject:self.m_merchantId forKey:@"mctId"];
    [self.m_dic setObject:self.m_productId forKey:@"classIDTxt"];
    [self.m_dic setObject:self.m_activityName.text forKey:@"activityName"];
    [self.m_dic setObject:self.m_infoTextView.text forKey:@"summary"];
    [self.m_dic setObject:self.m_anPaiTextView.text forKey:@"content"];
    [self.m_dic setObject:self.m_tipTextView.text forKey:@"explain"];

    [self.m_dic setObject:self.m_IsSpecial forKey:@"IsSpecial"];

    [self.m_dic setObject:self.m_StringType forKey:@"typeString"];
    
    
    // 下一步
    ActivitySaleViewController *VC = [[ActivitySaleViewController alloc]initWithNibName:@"ActivitySaleViewController" bundle:nil];
    VC.m_dic = self.m_dic;
    VC.LimitRebate = self.LimitRebate;
    VC.RebatesType = self.RebatesType;
    [self.navigationController pushViewController:VC animated:YES];
    
}

- (IBAction)chooseMerchant:(id)sender {
    
    self.view.userInteractionEnabled = NO;
    
    [self.view endEditing:YES];
    
    self.m_typeString = @"Merchant";
    
    m_pickerToolBar.hidden = NO;
    
    m_pickerView.hidden = NO;

    
    [self.m_pickerView reloadAllComponents];
}

- (IBAction)chooseType:(id)sender {
    
    self.view.userInteractionEnabled = NO;

    
    [self.view endEditing:YES];
    
    self.m_typeString = @"Category";

    // 选择分类
    
    m_pickerToolBar.hidden = NO;
    
    m_pickerView.hidden = NO;
    
    [self.m_pickerView reloadAllComponents];

    
}

- (IBAction)chooseModel:(id)sender {
    
    [self.view endEditing:YES];
    
    self.m_typeString = @"Model";
    
    if ( self.m_typeTextField.text.length == 0 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请先选择活动类型"];
        
        return;
    }
    
    self.view.userInteractionEnabled = NO;
    
    m_pickerToolBar.hidden = NO;
    
    m_pickerView.hidden = NO;
    
    [self.m_pickerView reloadAllComponents];

}

- (void)editDataRequestSubmit{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    
    // operation 1：新增；2：修改 actId聚会ID（默认为0）
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  memberId,     @"memberId",
                                  key,   @"key",
                                  [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"ActivityID"]],@"activityId",
                                  nil];
    
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"ActivityDetail.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            [SVProgressHUD dismiss];
            
            NSMutableDictionary *dic = [json valueForKey:@"Activity"];
            
            self.m_dic = dic;
            
             self.m_typeTextField.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"ActCatgNames"]];
            self.m_activityName.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"ActivityName"]];
            self.m_anPaiTextView.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"Content"]];
            self.m_tipTextView.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"Explain"]];

            self.m_infoTextView.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"Summary"]];

            self.m_merchantId = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"MerchantId"]];
            self.m_serviceId = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"FirstClassID"]];
            self.m_productId = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"SecondClassID"]];
            self.m_merchantTextField.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"MerchantAllName"]];
            
            self.m_IsSpecial = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"IsSpecial"]];
            
            self.LimitRebate = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"LimitRebate"]];
            
            self.RebatesType = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"RebatesType"]];


            // 判断label是否隐藏
            if ( self.m_anPaiTextView.text.length != 0 ) {
                
                self.m_anpaiLabel.hidden = YES;
                
            }else{
                
                self.m_anpaiLabel.hidden = NO;
                
            }
            if ( self.m_tipTextView.text.length != 0 ) {
                
                self.m_tipLabel.hidden = YES;
                
            }else{
                
                self.m_tipLabel.hidden = NO;
                
            }
            
            if ( self.m_infoTextView.text.length != 0 ) {
                
                self.m_infoLabel.hidden = YES;
                
            }else{
                
                self.m_infoLabel.hidden = NO;
                
            }
            
            // 模板请求数据
            [self modelRequestSubmit];
            
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
        
        
    } failure:^(NSError *error) {
        
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        //self.tableView.pullLastRefreshDate = [NSDate date];
        
    }];
    
}

// 选择模板请求数据
- (void)modelRequestSubmit{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }

    // templateType：（商户产品MerchantProductTemplate、商户活动MerchantActivityTemplate、系统短信SystemSmsTemplate、系统邮件SystemEmailTemplate）
    
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  @"MerchantActivityTemplate",@"templateType",
                                  @"0",@"svcClassID",
                                  [NSString stringWithFormat:@"%@",self.m_serviceId],@"activityCategoryID",
                                  nil];
    
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
//    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"TemplateKeyValue.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            [SVProgressHUD dismiss];
         
            
            self.m_modelArray = [json valueForKey:@"KeyValueList"];

            if ( self.m_modelArray.count != 0 ) {
                
                self.m_modelBtn.userInteractionEnabled = YES;
                
                NSDictionary *dic = [self.m_modelArray objectAtIndex:0];
                
                self.m_modelString = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Value"]];
                
                self.m_modelId1 = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Key"]];
                
            }else{
                
                self.m_modelBtn.userInteractionEnabled = NO;
                
                self.m_modelTextField.text = @"无模板";
                
            }
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
        
        
    } failure:^(NSError *error) {
        
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        //self.tableView.pullLastRefreshDate = [NSDate date];
        
    }];
    
}

// 商户数据请求数据
- (void)MerchantRequestSubmit{
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  memberId,     @"memberId",
                                  key,   @"key",
                                  nil];
    
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"MerchantKeyValue.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            [SVProgressHUD dismiss];
            
            self.m_merchantArray = [json valueForKey:@"MerchantKeyValueList"];
           
            if ( self.m_merchantArray.count != 0 ) {
                
                NSDictionary *dic = [self.m_merchantArray objectAtIndex:0];
                
                self.m_merchantString = [NSString stringWithFormat:@"%@",[dic objectForKey:@"MerchantName"]];
                
                self.m_merchantId1 = [NSString stringWithFormat:@"%@",[dic objectForKey:@"MerchantId"]];
                
                self.m_IsSpecial1 = [NSString stringWithFormat:@"%@",[dic objectForKey:@"IsSpecial"]];
                
                self.LimitRebate1 = [NSString stringWithFormat:@"%@",[dic objectForKey:@"LimitRebate"]];
                
                self.RebatesType1 = [NSString stringWithFormat:@"%@",[dic objectForKey:@"RebatesType"]];

            }
            
        } else {
            
            [SVProgressHUD dismiss];

            NSString *msg = [json valueForKey:@"msg"];
            
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示"
                                                               message:[NSString stringWithFormat:@"商户%@，您不可以策划活动",msg]                                                              delegate:self
                                                     cancelButtonTitle:@"确定"
                                                     otherButtonTitles: nil];
            alertView.tag = 103290;
            [alertView show];
            
        }
        
        
    } failure:^(NSError *error) {
        
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        //self.tableView.pullLastRefreshDate = [NSDate date];
        
    }];

}

- (void)TemplateRequestSubmit{

    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
//    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
//    NSString *key = [CommonUtil getServerKey];
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  [NSString stringWithFormat:@"%@",self.m_modelId],@"templateID",
                                  nil];
    
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"TemplateDetail.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            [SVProgressHUD dismiss];
            
            NSDictionary *dic = [json valueForKey:@"TemDetail"];
            
            // 选择模板后进行赋值
            self.m_activityName.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"ActivityName"]];
            self.m_infoTextView.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"ActivityPrecautions"]];

            self.m_anPaiTextView.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"ActivityContent"]];

            self.m_tipTextView.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"ActivityExplain"]];
            
            // 判断提示的label是否隐藏
             if ( self.m_tipTextView.text.length != 0 ) {
                 
                 self.m_tipLabel.hidden = YES;

             }else{
                 
                 self.m_tipLabel.hidden = NO;

             }
            
            if ( self.m_anPaiTextView.text.length != 0 ) {
                
                self.m_anpaiLabel.hidden = YES;

            }else{
                
                self.m_anpaiLabel.hidden = NO;

            }
            
            if ( self.m_infoTextView.text.length != 0 ) {
                
                self.m_infoLabel.hidden = YES;

            }else{
                
                self.m_infoLabel.hidden = NO;

            }
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
        
        
    } failure:^(NSError *error) {
        
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        //self.tableView.pullLastRefreshDate = [NSDate date];
        
    }];
    
}

#pragma mark -初始化显示地区的pickerView
- (void)initpickerView{
    UIWindow *window = self.navigationController.view.window;
	
	//  datePickerView初始化
	m_pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 216, WindowSizeWidth, 216)];
    m_pickerView.backgroundColor = [UIColor whiteColor];
    m_pickerView.delegate = self;
    m_pickerView.dataSource = self;
    // 设置pickerView选择时的背景，默认的为NO
    m_pickerView.showsSelectionIndicator = YES;
	[window addSubview:m_pickerView];
    
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
    
    
    self.view.userInteractionEnabled = YES;

    self.m_pickerView.hidden = YES;
    
    self.m_pickerToolBar.hidden = YES;
    
    
    if ( [self.m_typeString isEqualToString:@"Merchant"] ) {
        
        self.m_merchantTextField.text = [NSString stringWithFormat:@"%@",self.m_merchantString];
        // 赋值
        self.m_merchantString1 = [NSString stringWithFormat:@"%@",self.m_merchantTextField.text];
        
        self.m_merchantId = [NSString stringWithFormat:@"%@",self.m_merchantId1];
        
        self.m_merchantId2 = [NSString stringWithFormat:@"%@",self.m_merchantId1];
       
        self.m_IsSpecial = [NSString stringWithFormat:@"%@",self.m_IsSpecial1];
        
        self.m_IsSpecial2 = [NSString stringWithFormat:@"%@",self.m_IsSpecial1];
        
        self.LimitRebate = [NSString stringWithFormat:@"%@",self.LimitRebate1];
        
        self.LimitRebate2 = [NSString stringWithFormat:@"%@",self.LimitRebate1];
        
        self.RebatesType = [NSString stringWithFormat:@"%@",self.RebatesType1];
        
        self.RebatesType2  = [NSString stringWithFormat:@"%@",self.RebatesType1];
        
        
    }else  if ( [self.m_typeString isEqualToString:@"Category"] ){
        
        // 判断值是否要改变
        if ( ![self.m_serviceId2 isEqualToString:self.m_serviceId1] ) {
            
            // 当切换产品活动类型的时候，模板值清空
            self.m_modelTextField.text = @"";
            
            self.m_modelId = @"";
            
        }

        self.m_typeTextField.text = [NSString stringWithFormat:@"%@-%@",self.m_categoryString1,self.m_projectString1];
        
    
        // 赋值
        self.m_categoryString = [NSString stringWithFormat:@"%@",self.m_typeTextField.text];
        
        self.m_serviceId = [NSString stringWithFormat:@"%@",self.m_serviceId1];
        
        self.m_serviceId2 = [NSString stringWithFormat:@"%@",self.m_serviceId1];
        
        self.m_productId = [NSString stringWithFormat:@"%@",self.m_productId1];

        self.m_productId2 = [NSString stringWithFormat:@"%@",self.m_productId1];
        
        // 模板请求数据
        [self modelRequestSubmit];
        
        
        
    }else{
        
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示"
                                                           message:@"选择模板后将自动的帮您填写活动名称、活动简介、活动安排和特别提示"
                                                          delegate:self
                                                 cancelButtonTitle:@"取消"
                                                 otherButtonTitles:@"确定", nil];
        
        alertView.tag = 10930;
        [alertView show];
        
    }
    
    self.isSelected = NO;
  
}

- (void)doPickerCancel:(id)sender{
    
    self.view.userInteractionEnabled = YES;

    self.m_pickerView.hidden = YES;
    
    self.m_pickerToolBar.hidden = YES;
    
    if ( self.isSelected ) {
        
        if ( [self.m_typeString isEqualToString:@"Merchant"] ) {
            
            // 赋值
            self.m_merchantTextField.text = [NSString stringWithFormat:@"%@",self.m_merchantString1];
            
            self.m_merchantId = [NSString stringWithFormat:@"%@",self.m_merchantId2];
            
            self.m_IsSpecial = [NSString stringWithFormat:@"%@",self.m_IsSpecial2];
            
            self.LimitRebate = [NSString stringWithFormat:@"%@",self.LimitRebate2];
            
            self.RebatesType = [NSString stringWithFormat:@"%@",self.RebatesType2];


        }else if ( [self.m_typeString isEqualToString:@"Category"] ){
            
            // 赋值
            self.m_typeTextField.text = [NSString stringWithFormat:@"%@",self.m_categoryString];
            
            self.m_serviceId = [NSString stringWithFormat:@"%@",self.m_serviceId2];
            
            self.m_productId = [NSString stringWithFormat:@"%@",self.m_productId2];

         

        }else{
            
            self.m_modelTextField.text = [NSString stringWithFormat:@"%@",self.m_modelString1];
            
            self.m_modelId = [NSString stringWithFormat:@"%@",self.m_modelId2];
    
        }
      
    }
    
}

#pragma mark - UIALertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if ( alertView.tag == 10930 ) {
        
        if ( buttonIndex == 1 ) {
            // 选择模板后刷新数据
            self.m_modelTextField.text = [NSString stringWithFormat:@"%@",self.m_modelString];
            
            self.m_modelString1 = [NSString stringWithFormat:@"%@",self.m_modelString];
            
            self.m_modelId = [NSString stringWithFormat:@"%@",self.m_modelId1];
            
            self.m_modelId2 = [NSString stringWithFormat:@"%@",self.m_modelId1];
            
            // 请求模板选择后的接口
            [self TemplateRequestSubmit];
            
        }else{
            
            
        }
    }else if ( alertView.tag == 103290 ){
        
        if ( buttonIndex == 0 ) {
            // 无商户的情况下不可策划活动，返回上一级
            [self.navigationController popViewControllerAnimated:YES];
            
        }
    }else{
        
        
    }
}



#pragma mark - UIPickerViewDelegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
   
    if ( [self.m_typeString isEqualToString:@"Merchant"] ) {

        return 1;
        
    }else if ( [self.m_typeString isEqualToString:@"Category"] ){
        
        return 2;

    }else{
        
         return 1;
    }
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    if ( [self.m_typeString isEqualToString:@"Merchant"] ) {

        
        return self.m_merchantArray.count;
        
    }else if ( [self.m_typeString isEqualToString:@"Category"] ){
        
        if ( component == 0 ) {
            
            return self.m_oneArray.count;
            
        }else{
            
            return self.m_twoArray.count;
        }

        
    }else{
        
        return self.m_modelArray.count;
    }
    
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    NSString *titleResult = @"";
    
    if ( [self.m_typeString isEqualToString:@"Merchant"] ) {

        NSDictionary *dic = [self.m_merchantArray objectAtIndex:row];
        
        titleResult = [NSString stringWithFormat:@"%@",[dic objectForKey:@"MerchantName"]];
        
        
    }else if ( [self.m_typeString isEqualToString:@"Category"] ){

        if ( component == 0 ) {
            
            if ( self.m_oneArray.count > 0 ) {
                
                NSDictionary *dic = [self.m_oneArray objectAtIndex:row];
                
                titleResult = [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];
                
            }
            
        }else if ( component == 1 ){
            
            NSDictionary *dic = [self.m_twoArray objectAtIndex:row];
            
            titleResult = [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];
            
        }else{
            
            titleResult = @"";
            
        }

    }else{
        
        
        NSDictionary *dic = [self.m_modelArray objectAtIndex:row];
        
        titleResult = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Value"]];

    }
    
    return titleResult;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    self.isSelected = YES;
    
    if ( [self.m_typeString isEqualToString:@"Merchant"] ) {
        
        NSDictionary *dic = [self.m_merchantArray objectAtIndex:row];
        
        self.m_merchantString = [NSString stringWithFormat:@"%@",[dic objectForKey:@"MerchantName"]];
        
         self.m_merchantId1 =[NSString stringWithFormat:@"%@",[dic objectForKey:@"MerchantId"]];
        
        self.m_IsSpecial1 = [NSString stringWithFormat:@"%@",[dic objectForKey:@"IsSpecial"]];
        
        self.LimitRebate1 = [NSString stringWithFormat:@"%@",[dic objectForKey:@"LimitRebate"]];
        
        self.RebatesType1 = [NSString stringWithFormat:@"%@",[dic objectForKey:@"RebatesType"]];

        
    }else  if ( [self.m_typeString isEqualToString:@"Category"] ){
        
        
        if ( component == 0 ) {
            
            NSDictionary *dic = [self.m_oneArray objectAtIndex:row];
            
            self.m_twoArray = [dbhelp queryProject:[dic objectForKey:@"code"]];
            
            self.m_categoryString1 = [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];
            self.m_serviceId1 = [NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];

            
            NSDictionary *dic1 = [self.m_twoArray objectAtIndex:0];
            
            self.m_projectString1 = [NSString stringWithFormat:@"%@",[dic1 objectForKey:@"name"]];
            
            self.m_productId1 = [NSString stringWithFormat:@"%@",[dic1 objectForKey:@"code"]];

            // 刷新选择器
            [self.m_pickerView selectRow:0 inComponent:1 animated:YES];
            
        }else if ( component == 1 ){
            
            NSDictionary *dic = [self.m_twoArray objectAtIndex:row];
            
            self.m_projectString1 = [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];
            
            self.m_productId1 = [NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
            
        }

    }else{
        
        NSDictionary *dic = [self.m_modelArray objectAtIndex:row];
        
         self.m_modelString =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Value"]];
        
        self.m_modelId1 = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Key"]];

    }
    
    for (int i=0; i<[pickerView numberOfComponents]; i++) {
        
        [self.m_pickerView reloadComponent:i];
        
    }
    
}

#pragma mark - UITextDieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    if ( textField == self.m_activityName ) {
        
        [self hiddenNumPadDone:nil];
        
    }

}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    [textField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    return YES;
}

#pragma mark - UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView{
    
    [self.m_scrollerVIew setContentSize:CGSizeMake(WindowSizeWidth, 1200)];
    
    if ( textView == self.m_anPaiTextView || textView == self.m_infoTextView || textView == self.m_tipTextView ) {
        
        [self hiddenNumPadDone:nil];
    }

    if ( textView == self.m_infoTextView ) {
        
        self.m_infoLabel.hidden = YES;
   
    }else if ( textView == self.m_anPaiTextView ) {
        
        self.m_anpaiLabel.hidden = YES;
        
    }else{
        
        self.m_tipLabel.hidden = YES;
        
    }
    
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    
//    [self resumeView];
    
    [self.m_scrollerVIew setContentSize:CGSizeMake(WindowSizeWidth, 900)];

    if ( textView == self.m_infoTextView ) {
        
        if ( self.m_infoTextView.text.length == 0 ) {
            
            self.m_infoLabel.hidden = NO;
            
        }else{
            
            
            
        }
    }else if ( textView == self.m_anPaiTextView ){
        
        if ( self.m_anPaiTextView.text.length == 0 ) {
            
            self.m_anpaiLabel.hidden = NO;
            
        }else{
            
            
        }
    }else{
        
        if ( self.m_tipTextView.text.length == 0 ) {
            
            self.m_tipLabel.hidden = NO;
            
        }else{
            
            
        }
        
    }
    
    [textView resignFirstResponder];
}

//恢复原始视图位置
-(void)resumeView {
    NSTimeInterval animationDuration=0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    float width = self.view.frame.size.width;
    float height = self.view.frame.size.height;
    float Y = 0.0f;
    CGRect rect=CGRectMake(0.0f,Y,width,height);
    self.view.frame=rect;
    [UIView commitAnimations];
}

@end
