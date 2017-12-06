//
//  AddAddressViewController.m
//  HuiHui
//
//  Created by mac on 15-2-15.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "AddAddressViewController.h"

@interface AddAddressViewController ()

@property (weak, nonatomic) IBOutlet UITextField *m_name;

@property (weak, nonatomic) IBOutlet UITextField *m_phone;

@property (weak, nonatomic) IBOutlet UITextField *m_emailCode;

@property (weak, nonatomic) IBOutlet UITextField *m_address;

@property (weak, nonatomic) IBOutlet UITextField *m_detailAddress;

@property (weak, nonatomic) IBOutlet UIButton *m_addressBtn;

@property (weak, nonatomic) IBOutlet UIScrollView *m_scrollerView;

@property (weak, nonatomic) IBOutlet UIButton *m_defaultBtn;

@property (weak, nonatomic) IBOutlet UIButton *m_deleteBtn;

// 选择地区按钮触发的事件
- (IBAction)addressBtnClicked:(id)sender;

// 提交按钮触发的事件
- (void)submitClicked:(id)sender;

// 设置为默认地址按钮触发的事件
- (IBAction)defaultAddressClicked:(id)sender;

- (IBAction)deleteAddressClicked:(id)sender;

@end

@implementation AddAddressViewController

@synthesize m_stringType;

@synthesize m_provinceArray;

@synthesize m_CityArray;

@synthesize m_AreaArray;

@synthesize m_pickerView;

@synthesize m_pickerToolBar;

@synthesize isSelectedArea;

@synthesize m_areaString;

@synthesize m_provinceName;

@synthesize m_cityName;

@synthesize m_areaName;

@synthesize m_dic;

@synthesize isDefault;

@synthesize m_provinceName1;
@synthesize m_cityName1;
@synthesize m_areaName1;
@synthesize m_provinceId1;
@synthesize m_cityId1;
@synthesize m_areaId1;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        isSelectedArea = NO;
        
        dbhelp = [[AreaDB alloc] init];
        
        m_provinceArray = [[NSMutableArray alloc]initWithCapacity:0];
        
        m_CityArray = [[NSMutableArray alloc]initWithCapacity:0];
        
        m_AreaArray = [[NSMutableArray alloc]initWithCapacity:0];
        
        m_dic = [[NSMutableDictionary alloc]initWithCapacity:0];
        
    }
    
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    if ( [self.m_stringType isEqualToString:@"1"] ) {
        
        [self setTitle:@"新建地址"];
        
        // 赋值默认地址 - 添加地址的时候默认地址
        self.isDefault = @"1";
        
        [self.m_defaultBtn setImage:[UIImage imageNamed:@"login_gouxuan1.png"] forState:UIControlStateNormal];
        
        self.m_deleteBtn.hidden = YES;

    }else{
        
        [self setTitle:@"编辑地址"];
        
        self.m_deleteBtn.hidden = NO;

        
        // 赋值
        self.m_name.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"LinkName"]];
        
        self.m_phone.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"LinkPhone"]];
        
        self.m_emailCode.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"PostalCode"]];
        
        self.m_address.text = [NSString stringWithFormat:@"%@%@%@",[self.m_dic objectForKey:@"ProvinceName"],[self.m_dic objectForKey:@"CityName"],[self.m_dic objectForKey:@"AreaName"]];
        
        self.m_detailAddress.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"Address"]];
        
        // 赋值默认地址
        self.isDefault = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"IsDefault"]];
        
        NSLog(@"isDefault = %@",self.isDefault);
        
        if ( [self.isDefault isEqualToString:@"1"] ) {
            
            [self.m_defaultBtn setImage:[UIImage imageNamed:@"login_gouxuan1.png"] forState:UIControlStateNormal];
            
        }else{
            
            
            [self.m_defaultBtn setImage:[UIImage imageNamed:@"login_gouxuan2.png"] forState:UIControlStateNormal];

        }
        
    }
    
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    [self setRightButtonWithTitle:@"保存" action:@selector(submitClicked:)];
    
    
    // 初始化地区所存放的pickerView
    [self initpickerView];
    
    // 隐藏pickerView和toolBar
    self.m_pickerView.hidden = YES;
    
    self.m_pickerToolBar.hidden = YES;
    
    self.m_pickerView.backgroundColor = [UIColor whiteColor];
    
    self.m_areaString = @"";

    
    if ( [dbhelp queryCity].count != 0 ) {
        
        if ( [self.m_stringType isEqualToString:@"1"] ) {
            
            
            // 默认为空
            self.m_provinceName1 = @"";
            self.m_cityName1 = @"";
            self.m_areaName1 = @"";
            self.m_provinceId1 = @"";
            self.m_cityId1 = @"";
            self.m_areaId1 = @"";
            
            self.m_provinceName2 = @"";
            self.m_cityName2 = @"";
            self.m_areaName2 = @"";
            self.m_provinceId2 = @"";
            self.m_cityId2 = @"";
            self.m_areaId2 = @"";
            
            // 新增地址的情况下默认为第一个数据
            // 从保存的数据库中读取数据
            [self.m_provinceArray addObjectsFromArray:[dbhelp queryCity]];
            
            NSLog(@"地址：：%@",self.m_provinceArray);
            
            NSDictionary *proDic = [self.m_provinceArray objectAtIndex:0];
            
            self.m_provinceId = [NSString stringWithFormat:@"%@",[proDic objectForKey:@"code"]];
            
            self.m_provinceName = [NSString stringWithFormat:@"%@",[proDic objectForKey:@"name"]];
            
            self.m_CityArray = [dbhelp queryArea:self.m_provinceId];
            
            NSDictionary *cityDic = [self.m_CityArray objectAtIndex:0];
            
            self.m_cityId = [NSString stringWithFormat:@"%@",[cityDic objectForKey:@"code"]];
            
            self.m_cityName = [NSString stringWithFormat:@"%@",[cityDic objectForKey:@"name"]];
            
            
            self.m_AreaArray = [dbhelp queryArea:self.m_cityId];
            
            NSDictionary *areaDic = [self.m_AreaArray objectAtIndex:0];
            
            self.m_areaId = [NSString stringWithFormat:@"%@",[areaDic objectForKey:@"code"]];
            
            self.m_areaName = [NSString stringWithFormat:@"%@",[areaDic objectForKey:@"name"]];
            
            
            [self.m_pickerView reloadAllComponents];

            
        }else{
            
            // 赋值
            self.m_provinceName2 = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"ProvinceName"]];
            
            self.m_cityName2 = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"CityName"]];
            
            self.m_areaName2 = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"AreaName"]];
            
            
            self.m_provinceId2 = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"ProvinceID"]];
            
            self.m_cityId2 =  [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"CityID"]];
            
            self.m_areaId2 = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"AreaID"]];
            
            // 赋值给临时的存储值
            self.m_provinceName1 = [NSString stringWithFormat:@"%@",self.m_provinceName2];
            
            self.m_cityName1 = [NSString stringWithFormat:@"%@",self.m_cityName2];
            
            self.m_areaName1 = [NSString stringWithFormat:@"%@",self.m_areaName2];
            
            self.m_provinceId1 = [NSString stringWithFormat:@"%@",self.m_provinceId2];
            
            self.m_cityId1 = [NSString stringWithFormat:@"%@",self.m_cityId2];
            
            self.m_areaId1 = [NSString stringWithFormat:@"%@",self.m_areaId2];
            
            
            // 赋值-赋值为第1个数据的值
            [self.m_provinceArray addObjectsFromArray:[dbhelp queryCity]];
            
            NSDictionary *proDic = [self.m_provinceArray objectAtIndex:0];
            
            self.m_provinceId = [NSString stringWithFormat:@"%@",[proDic objectForKey:@"code"]];
            
            self.m_provinceName = [NSString stringWithFormat:@"%@",[proDic objectForKey:@"name"]];
            
            self.m_CityArray = [dbhelp queryArea:self.m_provinceId];
            
            NSDictionary *cityDic = [self.m_CityArray objectAtIndex:0];
            
            
            self.m_cityId = [NSString stringWithFormat:@"%@",[cityDic objectForKey:@"code"]];
            
            self.m_cityName = [NSString stringWithFormat:@"%@",[cityDic objectForKey:@"name"]];
            
            
            self.m_AreaArray = [dbhelp queryArea:self.m_cityId];
            
            NSDictionary *areaDic = [self.m_AreaArray objectAtIndex:0];
            
            self.m_areaId = [NSString stringWithFormat:@"%@",[areaDic objectForKey:@"code"]];
            
            self.m_areaName = [NSString stringWithFormat:@"%@",[areaDic objectForKey:@"name"]];
            
            
            [self.m_pickerView reloadAllComponents];
            
            
        }
        
    }else{
        
        // 请求数据
        [self requestAreaSubmit];
        
    }
    
    // 设置scrollerView的滚动范围
    if ( iPhone4 ) {
        
        [self.m_scrollerView setContentSize:CGSizeMake(WindowSizeWidth, 550)];

    }else if ( iPhone5 ) {
        
        [self.m_scrollerView setContentSize:CGSizeMake(WindowSizeWidth, 600)];

    }else{
        

        [self.m_scrollerView setContentSize:CGSizeMake(WindowSizeWidth, 700)];

    }
    
    self.m_address.enabled = NO;
    

}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    self.m_pickerView.hidden = YES;
    
    self.m_pickerToolBar.hidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)leftClicked{
    
    [self goBack];
    
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    self.m_pickerView.hidden = YES;
    self.m_pickerToolBar.hidden = YES;

    if ( textField == self.m_phone || textField == self.m_emailCode ) {
        
        [self showNumPadDone:nil];
        
    }else{
        
        [self hiddenNumPadDone:nil];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{

    [textField resignFirstResponder];

}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    return YES;
}


- (IBAction)addressBtnClicked:(id)sender {
    
    [self.view endEditing:YES];
    
    self.m_pickerView.hidden = NO;
    
    self.m_pickerToolBar.hidden = NO;
}

- (void)submitClicked:(id)sender {
    
    [self.view endEditing:YES];
    
    NSLog(@"isDefault = %@",self.isDefault);
    NSLog(@"type = %@",self.m_stringType);

    
    self.m_pickerToolBar.hidden = YES;
    self.m_pickerView.hidden = YES;
    
    if ( self.m_name.text.length == 0 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请输入联系人名称"];
        
        return;
    }
    
    if ( self.m_phone.text.length == 0 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请输入联系人手机号"];
        
        return;
    }

    if ( self.m_emailCode.text.length == 0 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请输入邮政编码"];
        
        return;
    }
   
    if ( self.m_address.text.length == 0 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请输入所在地区"];
        
        return;
    }
    
    if ( self.m_detailAddress.text.length == 0 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请输入详细的地址"];
        
        return;
    }
    
    // 新增数据请求接口
    [self addAddressRequest];
    
    
}

- (IBAction)defaultAddressClicked:(id)sender {
    
    if ( [self.isDefault isEqualToString:@"1"] ) {
        
        self.isDefault = @"0";
        
        [self.m_defaultBtn setImage:[UIImage imageNamed:@"login_gouxuan2.png"] forState:UIControlStateNormal];

    }else{
        
        self.isDefault = @"1";
        
        [self.m_defaultBtn setImage:[UIImage imageNamed:@"login_gouxuan1.png"] forState:UIControlStateNormal];
    }
    
}

- (IBAction)deleteAddressClicked:(id)sender {
    
    // 删除地址的响应的事件
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil
                                                       message:@"您确定删除该收货地址？"
                                                      delegate:self
                                             cancelButtonTitle:@"取消"
                                             otherButtonTitles:@"确定", nil];
    alertView.tag = 14532;
    
    [alertView show];
    
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if ( alertView.tag == 14532 ) {
        
        if ( buttonIndex == 1 ) {
            
            // 表示删除该地址返回上一级
            [self deleteAddressRequest];
            
            
        }else{
            
            
            
        }
    }
    
    
}

#pragma mark - DeleteAddressRequest
- (void)deleteAddressRequest{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        return;
    }
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"MemberID",
                           key,@"key",
                           [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"AddressID"]],@"AddressID",
                           nil];
    
    NSLog(@"params = %@",param);
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    [httpClient request:@"DeleteCloudMenuAddress.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showSuccessWithStatus:msg];
            
            
            // 记录是否删除了地址和修改了地址，用于地址列表进行刷新数据
            [CommonUtil addValue:@"1" andKey:ADDRESSMODIFY];
            
            // 删除成功后返回上一个页面
            [self goBack];
            
        }else{
            
            // 记录是否删除了地址和修改了地址，用于地址列表进行刷新数据
            [CommonUtil addValue:@"0" andKey:ADDRESSMODIFY];
            
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
            
        }
        
    } failure:^(NSError *error) {
        
        // 记录是否删除了地址和修改了地址，用于地址列表进行刷新数据
        [CommonUtil addValue:@"0" andKey:ADDRESSMODIFY];
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
    
}

#pragma mark - UINetWorking
- (void)addAddressRequest{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        return;
    }
    
    // 1表示新增 2表示编辑修改
    NSString *addressId = @"";
    
    // 地址的类型 - 用于请求数据 0是添加 1是编辑
    NSString *type = @"";
    
    if ( [self.m_stringType isEqualToString:@"1"] ) {
        // 新增
        addressId = @"";
        
        type = @"0";
        
    }else{
        
        addressId = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"AddressID"]];
       
        type = @"1";
        
    }
    
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"MemberID",
                           key,@"key",
                           [NSString stringWithFormat:@"%@",self.m_detailAddress.text],@"Address",
                           addressId,@"AddressID",
                           self.m_areaId2,@"AreaID",
                           self.m_areaName2,@"AreaName",
                           self.m_cityId2,@"CityID",
                           self.m_cityName2,@"CityName",
                           self.isDefault,@"IsDefault",
                           [NSString stringWithFormat:@"%@",self.m_name.text],@"LinkName",
                           [NSString stringWithFormat:@"%@",self.m_phone.text],@"LinkPhone",
                           [NSString stringWithFormat:@"%@",self.m_emailCode.text],@"PostalCode",
                           self.m_provinceId2,@"ProvinceID",
                           self.m_provinceName2,@"ProvinceName",
                           [NSString stringWithFormat:@"%@",type],@"Type",
                           nil];
    
    
    NSLog(@"params = %@",param);
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    [httpClient request:@"CloudMenuAddress.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showSuccessWithStatus:msg];
            
            
            // 记录是否删除了地址和修改了地址，用于地址列表进行刷新数据
            [CommonUtil addValue:@"1" andKey:ADDRESSMODIFY];

             [self goBack];
            
        }else{
            
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
            
            // 记录是否删除了地址和修改了地址，用于地址列表进行刷新数据
            [CommonUtil addValue:@"0" andKey:ADDRESSMODIFY];
        
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
        // 记录是否删除了地址和修改了地址，用于地址列表进行刷新数据
        [CommonUtil addValue:@"0" andKey:ADDRESSMODIFY];
        
    }];

    
}

#pragma mark - 初始化显示地区的pickerView
- (void)initpickerView{
    UIWindow *window = self.navigationController.view.window;
    
    //  datePickerView初始化
    m_pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 216, WindowSizeWidth, 216)];
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
    pickerBar.frame = CGRectMake(0, m_pickerView.frame.origin.y - 44, WindowSizeWidth, 44);
    [window addSubview:pickerBar];
    pickerBar.backgroundColor = [UIColor clearColor];
    self.m_pickerToolBar = pickerBar;
    
}

#pragma mark - PickerBar按钮
- (void)doPickerDone:(id)sender{
    
    self.m_pickerView.hidden = YES;
    
    self.m_pickerToolBar.hidden = YES;
    
    self.m_areaString = [NSString stringWithFormat:@"%@|%@|%@",self.m_provinceId,self.m_cityId,self.m_areaId];
    
    if ( self.isSelectedArea ) {
        
        self.m_address.text = [NSString stringWithFormat:@"%@%@%@",self.m_provinceName,self.m_cityName,self.m_areaName];
        
    }else{
        
        self.m_address.text = [NSString stringWithFormat:@"%@%@%@",self.m_provinceName,self.m_cityName,self.m_areaName];
 
    }
    
    
    // 赋值给临时的存储值
    self.m_provinceName1 = [NSString stringWithFormat:@"%@",self.m_provinceName];

    self.m_cityName1 = [NSString stringWithFormat:@"%@",self.m_cityName];

    self.m_areaName1 = [NSString stringWithFormat:@"%@",self.m_areaName];
    
    
    self.m_provinceId1 = [NSString stringWithFormat:@"%@",self.m_provinceId];
    
    self.m_cityId1 = [NSString stringWithFormat:@"%@",self.m_cityId];
    
    self.m_areaId1 = [NSString stringWithFormat:@"%@",self.m_areaId];
    
    
    self.m_provinceName2 = [NSString stringWithFormat:@"%@",self.m_provinceName];
    
    self.m_cityName2 = [NSString stringWithFormat:@"%@",self.m_cityName];
    
    self.m_areaName2 = [NSString stringWithFormat:@"%@",self.m_areaName];
    
    
    self.m_provinceId2 = [NSString stringWithFormat:@"%@",self.m_provinceId];
    
    self.m_cityId2 = [NSString stringWithFormat:@"%@",self.m_cityId];
    
    self.m_areaId2 = [NSString stringWithFormat:@"%@",self.m_areaId];
  
    
    self.isSelectedArea = NO;
    
}

- (void)doPickerCancel:(id)sender{
    
    self.m_pickerView.hidden = YES;
    
    self.m_pickerToolBar.hidden = YES;
    
    // 重新赋值
    self.m_provinceName2 = [NSString stringWithFormat:@"%@",self.m_provinceName1];
    
    self.m_cityName2 = [NSString stringWithFormat:@"%@",self.m_cityName1];
    
    self.m_areaName2 = [NSString stringWithFormat:@"%@",self.m_areaName1];
    
    
    self.m_provinceId2 = [NSString stringWithFormat:@"%@",self.m_provinceId1];
    
    self.m_cityId2 = [NSString stringWithFormat:@"%@",self.m_cityId1];
    
    self.m_areaId2 = [NSString stringWithFormat:@"%@",self.m_areaId1];
    
    
    self.m_address.text = [NSString stringWithFormat:@"%@%@%@",self.m_provinceName2,self.m_cityName2,self.m_areaName2];

}

#pragma mark - UIPickerViewDelegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    if ( component == 0 ) {
        
        return self.m_provinceArray.count;
        
    }else if ( component == 1 ){
        
        return self.m_CityArray.count;
        
    }else if ( component == 2 ){
        
        return self.m_AreaArray.count;
        
    }else{
        
        return 0;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    NSString *titleResult = @"";
    
    if ( component == 0 ) {
        
        if ( self.m_provinceArray.count > 0 ) {
            
            NSDictionary *dic = [self.m_provinceArray objectAtIndex:row];
            
            titleResult = [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];
            
        }
    }else if ( component == 1 ){
        
        if ( self.m_CityArray.count > 0 ) {
            
            NSDictionary *dic = [self.m_CityArray objectAtIndex:row];
            
            titleResult = [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];
            
        }
    }else if ( component == 2 ){
        
        if ( self.m_AreaArray.count > 0 ) {
            
            NSDictionary *dic = [self.m_AreaArray objectAtIndex:row];
            
            titleResult = [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];
            
        }
    }else{
        
        titleResult = @"";
    }
    
    return titleResult;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    self.isSelectedArea = YES;
    
    if ( component == 0 ) {
        
        NSDictionary *dic = [self.m_provinceArray objectAtIndex:row];
        
        self.m_provinceId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        
        self.m_provinceName = [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];

        self.m_CityArray = [dbhelp queryArea:self.m_provinceId];
        
        if ( self.m_CityArray && [self.m_CityArray count] > 0 ) {
            
            NSDictionary *dic = [self.m_CityArray objectAtIndex:0];
            
            self.m_cityId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];

            self.m_cityName = [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];

            // 取得市数组第一个所对应的区
            if ( self.m_cityId ) {
                
                self.m_AreaArray = [dbhelp queryArea:self.m_cityId];
                
                NSDictionary *dic = [self.m_AreaArray objectAtIndex:0];
                
                self.m_areaId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];

                self.m_areaName = [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];

                
            }
            
            // 刷新选择器
            [self.m_pickerView selectRow:0 inComponent:1 animated:YES];
            [self.m_pickerView selectRow:0 inComponent:2 animated:YES];
        }
        
    }else if ( component == 1 ){
        
        NSDictionary *dic = [self.m_CityArray objectAtIndex:row];
        
        self.m_cityId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];

        self.m_cityName = [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];

        self.m_AreaArray = [dbhelp queryArea:self.m_cityId];
        
        NSDictionary *areaDic = [self.m_AreaArray objectAtIndex:0];
        
        self.m_areaId = [NSString stringWithFormat:@"%@",[areaDic objectForKey:@"code"]];

        self.m_areaName = [NSString stringWithFormat:@"%@",[areaDic objectForKey:@"name"]];

        
        [self.m_pickerView selectRow:0 inComponent:2 animated:YES];
        
    }else{
        
        NSDictionary *dic = [self.m_AreaArray objectAtIndex:row];
        
        self.m_areaId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];

        self.m_areaName = [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];

    }
    
    for (int i=0; i<[pickerView numberOfComponents]; i++) {
        
        [self.m_pickerView reloadComponent:i];
        
    }
    
    NSLog(@"%@%@%@",self.m_provinceName,self.m_cityName,self.m_areaName);
    
    
}

#pragma mark - 城市请求数据
- (void)requestAreaSubmit{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    NSDictionary *versions = [dbhelp queryVersion];
    NSString *cityVer = [versions objectForKey:TYPE_CITY];
    
    if (cityVer == nil) {
        cityVer = @"0";
    }
    
    
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           
                           cityVer,@"memberCityVer",
                           nil];
    
    [httpClient request:@"MemberCity.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            [SVProgressHUD dismiss];
            
            NSArray *versionList = [json valueForKey:@"MemberVersion"];
            if (versionList == nil || [versionList count] == 0) {
                
                return;
            }
            
            int cityVersion = 0;
            int categoryVersion = 0;
            
            for (NSDictionary *version in versionList) {
                NSString *type = [version objectForKey:@"VersionType"];
                if ([@"VersionMemberCity" isEqualToString:type]) {
                    cityVersion = [[version objectForKey:@"MemberVersionNum"] intValue];
                }
                
                if ([@"VersionClass" isEqualToString:type]) {
                    categoryVersion = [[version objectForKey:@"VersionNum"] intValue];
                }
                
            }
            
            if (cityVersion > 0) {
                NSArray *cityList = [json valueForKey:@"memberCity"];
                [dbhelp updateData:cityList andType:TYPE_CITY andVersion:[NSString stringWithFormat:@"%d", cityVersion]];
            }
            
            // 清空数据重新赋值
            [self.m_provinceArray removeAllObjects];
            [self.m_CityArray removeAllObjects];
            [self.m_AreaArray removeAllObjects];
            
            // 赋值
            [self.m_provinceArray addObjectsFromArray:[dbhelp queryCity]];
            
            NSDictionary *proDic = [self.m_provinceArray objectAtIndex:0];
            
            self.m_provinceId = [NSString stringWithFormat:@"%@",[proDic objectForKey:@"code"]];

            self.m_provinceName = [NSString stringWithFormat:@"%@",[proDic objectForKey:@"name"]];

            
            self.m_CityArray = [dbhelp queryArea:self.m_provinceId];
            
            NSDictionary *cityDic = [self.m_CityArray objectAtIndex:0];
            
            
            self.m_cityId = [NSString stringWithFormat:@"%@",[cityDic objectForKey:@"code"]];

            self.m_cityName = [NSString stringWithFormat:@"%@",[cityDic objectForKey:@"name"]];

            self.m_AreaArray = [dbhelp queryArea:self.m_cityId];
            
            NSDictionary *areaDic = [self.m_AreaArray objectAtIndex:0];
            
            self.m_areaId = [NSString stringWithFormat:@"%@",[areaDic objectForKey:@"code"]];

            self.m_areaName = [NSString stringWithFormat:@"%@",[areaDic objectForKey:@"name"]];

            
            [self.m_pickerView reloadAllComponents];
            
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
