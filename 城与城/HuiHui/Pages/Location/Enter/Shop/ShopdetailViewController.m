//
//  ShopdetailViewController.m
//  Receive
//
//  Created by 冯海强 on 13-12-27.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//

#import "ShopdetailViewController.h"
#import "SVProgressHUD.h"
#import "AppHttpClient.h"
#import "CommonUtil.h"

#import "BBMapViewController.h"
#import "ManagementViewController.h"

@interface ShopdetailViewController ()

@property (nonatomic,weak) IBOutlet UITextField *S_allname;//
@property (nonatomic,weak) IBOutlet UITextField *S_city;
@property (nonatomic,weak) IBOutlet UIButton *S_city_Btn;

@property (nonatomic,weak) IBOutlet UITextField *S_area;
@property (nonatomic,weak) IBOutlet UIButton *S_area_Btn;

@property (nonatomic,weak) IBOutlet UITextField *S_businessarea;
@property (nonatomic,weak) IBOutlet UIButton *S_businessarea_Btn;

@property (nonatomic,weak) IBOutlet UITextField *S_address;
@property (nonatomic,weak) IBOutlet UITextField *S_bus;//
@property (nonatomic,weak) IBOutlet UITextField *S_time;
@property (nonatomic,weak) IBOutlet UITextField *S_phone;


@property (nonatomic,weak) IBOutlet UIButton *S_seeSaveBtn;
@property (nonatomic,weak) IBOutlet UIButton *S_seeDeleBtn;
@property (nonatomic,weak) IBOutlet UIButton *S_SaveBtn;

@end

@implementation ShopdetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.shopdetaildic=[[NSMutableDictionary alloc]initWithCapacity:0];

        dbhelp = [[DBHelper alloc] init];

    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self hideTabBar:YES];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [self hideTabBar:NO];

}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.S_allname.delegate=self.S_city.delegate=self.S_area.delegate=self.S_businessarea.delegate=self.S_address.delegate=self.S_bus.delegate=self.S_time.delegate=self.S_phone.delegate=self;

    self.S_city_Btn.tag=101;
    self.S_area_Btn.tag=102;
    self.S_businessarea_Btn.tag=103;
    
    self.S_city.placeholder=@"城市";
    self.S_area.placeholder=@"区域";
    self.S_businessarea.placeholder=@"商圈";

    [self setTitle:@"店铺详细信息"];
    
    if ( ![self.addorchange isEqualToString:@"1"] )
    {
        [self shopdetailfax];
        self.S_SaveBtn.hidden=YES;
        
        NSString *isChange = [NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:@"IscanchangeKey"]];
        
        // 根据类型进行判断是否显示座位
        if ( [isChange isEqualToString:@"3"] ) {
            
            [self setRightButtonWithTitle:@"座位包厢" action:@selector(rightClicked)];

        }else{
            
            self.navigationItem.rightBarButtonItem = nil;
        }
        
    }else if ([self.addorchange isEqualToString:@"1"])
    {
        [self setTitle:@"增加店铺"];
        self.S_seeDeleBtn.hidden=YES;
        self.S_seeSaveBtn.hidden=YES;
        
        
    }
    
    [self hideTabBar:YES];
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    [self.m_shopView setContentSize:CGSizeMake(WindowSizeWidth,568)];



}

- (void)leftClicked{
    
    [self goBack];
}

- (void)rightClicked{
    
    // 进入座位列表的页面
    ManagementViewController *VC = [[ManagementViewController alloc]initWithNibName:@"ManagementViewController" bundle:nil];
    
    VC.m_merchantShopId = [NSString stringWithFormat:@"%@",[self.shopdetaildic objectForKey:@"MerchantShopId"]];
    [self.navigationController pushViewController:VC animated:YES];
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)shopdetailfax
{

    self.S_allname.text=[NSString stringWithFormat:@"%@",[self.shopdetaildic objectForKey:@"ShopName"]];
    self.S_city.text =[NSString stringWithFormat:@"%@",[self.shopdetaildic objectForKey:@"CityName"]];
    self.S_area.text =[NSString stringWithFormat:@"%@",[self.shopdetaildic objectForKey:@"AreaName"]];
    self.S_businessarea.text =[NSString stringWithFormat:@"%@",[self.shopdetaildic objectForKey:@"DistrictName"]];
    cityID=[NSString stringWithFormat:@"%@",[self.shopdetaildic objectForKey:@"CityID"]];
    areaID=[NSString stringWithFormat:@"%@",[self.shopdetaildic objectForKey:@"AreaID"]];
    businID=[NSString stringWithFormat:@"%@",[self.shopdetaildic objectForKey:@"DistrictID"]];
    
    _HC=[NSString stringWithFormat:@"%@",[self.shopdetaildic objectForKey:@"HC"]];
    _MapX=[NSString stringWithFormat:@"%@",[self.shopdetaildic objectForKey:@"MapX"]];
    _Mapy=[NSString stringWithFormat:@"%@",[self.shopdetaildic objectForKey:@"MapY"]];

    if ([[NSString stringWithFormat:@"%@",[self.shopdetaildic objectForKey:@"Address"]] isEqualToString:@"(null)"]) {
        self.S_address.text =nil;
    }else
    {
    self.S_address.text=[NSString stringWithFormat:@"%@",[self.shopdetaildic objectForKey:@"Address"]];
    }
    if ([[NSString stringWithFormat:@"%@",[self.shopdetaildic objectForKey:@"BusInfo"]] isEqualToString:@"(null)"]) {
        self.S_bus.text =nil;
    }else
    {
        self.S_bus.text=[NSString stringWithFormat:@"%@",[self.shopdetaildic objectForKey:@"BusInfo"]];
    }
    if ([[NSString stringWithFormat:@"%@",[self.shopdetaildic objectForKey:@"OpeningHours"]] isEqualToString:@"(null)"]) {
        self.S_time.text =nil;
    }else
    {
        self.S_time.text=[NSString stringWithFormat:@"%@",[self.shopdetaildic objectForKey:@"OpeningHours"]];
    }
    if ([[NSString stringWithFormat:@"%@",[self.shopdetaildic objectForKey:@"Phone"]] isEqualToString:@"(null)"]) {
        self.S_phone.text =nil;
    }else
    {
        self.S_phone.text=[NSString stringWithFormat:@"%@",[self.shopdetaildic objectForKey:@"Phone"]];
    }

}



-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ((textField == self.S_address) || (textField == self.S_allname)||(textField == self.S_area)||(textField == self.S_bus)||(textField == self.S_businessarea)||(textField == self.S_city)||(textField == self.S_phone)||(textField == self.S_time))
    {
        [textField resignFirstResponder];
    }
    return YES;
    
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *Numbers=@"0123456789\n-";
    NSCharacterSet *cs;
    if(textField == self.S_phone)
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
    [self.S_allname resignFirstResponder];
    [self.S_city resignFirstResponder];
    [self.S_area resignFirstResponder];
    [self.S_businessarea resignFirstResponder];
    [self.S_address resignFirstResponder];
    [self.S_bus resignFirstResponder];
    [self.S_time resignFirstResponder];
    [self.S_phone resignFirstResponder];
    
}

-(IBAction)textFieldChose:(UIButton*)sender
{
    [self closeallkey];

    
    if (sender.tag==101)
    {
        
        DowncellViewController*downVC=[[DowncellViewController alloc]initWithNibName:@"DowncellViewController" bundle:nil];
    
        downVC.Itemstyle = @"city";
        downVC.Chosedelegate =self;
        

        [self.navigationController pushViewController:downVC animated:YES];

        
    }else if (sender.tag==102)
    {
        if (self.S_city.text==nil||[self.S_city.text isEqualToString:@""])
        {
            [SVProgressHUD showErrorWithStatus:@"请先选择城市"];
            return;
        }
        
        DowncellViewController*downVC=[[DowncellViewController alloc]initWithNibName:@"DowncellViewController" bundle:nil];
        
        downVC.Itemstyle = @"area";
        downVC.Needtwo = cityID;
        downVC.Chosedelegate =self;

        

        [self.navigationController pushViewController:downVC animated:YES];

    }
    else if (sender.tag==103)
    {
        if (self.S_area.text==nil||[self.S_area.text isEqualToString:@""])
        {
            [SVProgressHUD showErrorWithStatus:@"请先选择区域"];
            return;
        }

        
        DowncellViewController*downVC=[[DowncellViewController alloc]initWithNibName:@"DowncellViewController" bundle:nil];
        
        downVC.Itemstyle = @"busin";
        downVC.Needthree = areaID;

        downVC.Chosedelegate =self;


        [self.navigationController pushViewController:downVC animated:YES];

    }
  
}


- (void)Chosescity:(NSString *)value code:(NSString *)citycode;//选择城市
{
    if ([self.S_city.text  isEqualToString:value])
    {
        return;
    }
    self.S_city.text =value;
    cityID =citycode;
    
    self.S_area.text =@"";
    areaID = @"";
    self.S_businessarea.text = @"";
    businID = @"";
    
}
- (void)Chosesarea:(NSString *)value code:(NSString *)areacode;//选择区域
{
    if ([self.S_area.text isEqualToString:value]) {
        return;
    }
    
    self.S_area.text =value;
    areaID = areacode;
    
    self.S_businessarea.text = @"";
    businID = @"";
    
}
- (void)Chosesbusin:(NSString *)value code:(NSString *)busincode;//选择商区
{
    self.S_businessarea.text = value;
    businID = busincode;
    
}

- (void)ChosesMapValue:(NSString *)address mapx:(NSString *)mapx mapy:(NSString *)mapy level:(NSString *)level
{
    self.S_address.text = address;
    _MapX = mapx;
    _Mapy = mapy;
    _HC= level;
    
}



-(IBAction)ShopMapview:(id)sender
{
    [self closeallkey];

//    BMapViewController *shopmapVC=[[BMapViewController alloc]initWithNibName:@"BMapViewController" bundle:nil];
//    shopmapVC.Chosemapdelegate = self;
//    shopmapVC.item=self.shopdetaildic;
//    
//    [self.navigationController pushViewController:shopmapVC animated:YES];
    
    
    BBMapViewController *VC = [[BBMapViewController alloc]initWithNibName:@"BBMapViewController" bundle:nil];
    VC.Chosemapdelegate = self;
    VC.item = self.shopdetaildic;
    [self.navigationController pushViewController:VC animated:YES];
    
}





-(IBAction)Saveshopdetail:(id)sender
{
    [self savedatatoserver];
    
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField;
{
    
    if (textField == self.S_allname)
    {
        [self.m_shopView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    else if (textField == self.S_bus)
    {
        [self.m_shopView setContentOffset:CGPointMake(0, 118) animated:YES];
    }
    else if (textField == self.S_time)
    {
        [self.m_shopView setContentOffset:CGPointMake(0, 118) animated:YES];
        
    }
    else if (textField == self.S_phone)
    {
        [self.m_shopView setContentOffset:CGPointMake(0, 118) animated:YES];
        
    }
    
    [self hiddenNumPadDone:nil];

    self.m_shopView.bouncesZoom = NO;
    
    return YES;
}



-(BOOL)textlegth

{
    if(self.S_city.text.length==0||[self.S_city.text isEqualToString:@""])
    {
        [SVProgressHUD showErrorWithStatus:@"请选择城市"];
        [self.m_shopView setContentOffset:CGPointMake(0, 0) animated:YES];

        return NO;
    }
    else if(self.S_area.text.length==0||[self.S_area.text isEqualToString:@""])
    {
        [SVProgressHUD showErrorWithStatus:@"请选择区域"];
        [self.m_shopView setContentOffset:CGPointMake(0, 0) animated:YES];

        return NO;
    }
    else if(self.S_businessarea.text.length==0||[self.S_businessarea.text isEqualToString:@""])
    {
        [SVProgressHUD showErrorWithStatus:@"请选择商圈"];
        [self.m_shopView setContentOffset:CGPointMake(0, 0) animated:YES];

        return NO;
    }
    else if(self.S_allname.text.length==0||[self.S_allname.text isEqualToString:@""])
    {
        [SVProgressHUD showErrorWithStatus:@"请填写全称"];
        [self.m_shopView setContentOffset:CGPointMake(0, 65) animated:YES];

        return NO;
    }
    else if(self.S_address.text.length==0||[self.S_address.text isEqualToString:@""])
    {
        [SVProgressHUD showErrorWithStatus:@"请填写地址"];
        [self.m_shopView setContentOffset:CGPointMake(0, 118) animated:YES];

        return NO;
    }
    else if(self.S_bus.text.length==0||[self.S_bus.text isEqualToString:@""])
    {
        [SVProgressHUD showErrorWithStatus:@"请填写公交信息"];
        [self.m_shopView setContentOffset:CGPointMake(0, 173) animated:YES];

        return NO;
    }
    else if(self.S_time.text.length==0||[self.S_time.text isEqualToString:@""])
    {
        [SVProgressHUD showErrorWithStatus:@"请填写营业时间"];
        [self.m_shopView setContentOffset:CGPointMake(0, 173) animated:YES];

        return NO;
    }
    else if(self.S_phone.text.length==0||[self.S_phone.text isEqualToString:@""])
    {
        [SVProgressHUD showErrorWithStatus:@"请填写咨询电话"];
        [self.m_shopView setContentOffset:CGPointMake(0, 173) animated:YES];

        return NO;
    }
    return YES;
}




- (void)savedatatoserver;
{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    if ([self textlegth])
    {

    NSString *memberId; NSString *merchantId;NSString *merchantShopId;NSString *cityId;NSString *areaId;NSString*districtId;NSString *shopName;NSString *address;NSString *busInfo;NSString *openingHours;NSString *tel;NSString *key;   NSString *HC;NSString *MapX;NSString *MapY;
        
    merchantId = [[NSUserDefaults standardUserDefaults] objectForKey:@"DB_MerchantID"];
        
    memberId = [CommonUtil getValueByKey:MEMBER_ID];
    key = [CommonUtil getServerKey];
    if ([self.addorchange isEqualToString:@"1"])
    {
        merchantShopId=@"0";

    }else
    {
        merchantShopId=[self.shopdetaildic objectForKey:@"MerchantShopId"];
 
    }
        
    HC=_HC;
    MapX=_MapX;
    MapY=_Mapy;

    cityId=cityID;
    areaId=areaID;
    districtId=businID;
    shopName=self.S_allname.text;
    address=self.S_address.text;
    busInfo=self.S_bus.text;
    openingHours=self.S_time.text;
    tel=self.S_phone.text;

        
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"memberId",
                           merchantId,@"merchantId",
                           merchantShopId,@"merchantShopId",
                           cityId,@"cityId",
                           areaId,@"areaId",
                           districtId,@"districtId",
                           shopName,@"shopName",
                           address,@"address",
                           busInfo,@"busInfo",
                           openingHours,@"openingHours",
                           tel,@"tel",
                           key,@"key",
                           HC,@"HC",
                           MapX,@"MapX",
                           MapY,@"MapY",
                           nil];
    [SVProgressHUD showWithStatus:@"数据提交中"];
    [httpClient request:@"MerchantShopAdd.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            [SVProgressHUD dismiss];
            NSString *msg=[json valueForKey:@"msg"];
            [SVProgressHUD showSuccessWithStatus:msg];
            [self closeallkey];
            
        [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(popview) userInfo:nil repeats:NO];
            
        } else {
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
    } failure:^(NSError *error) {
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];
        
    }
  
}

-(void)popview
{
    [self.navigationController popViewControllerAnimated:YES];

}


-(IBAction)Deleshop:(id)sender
{
    
    UIAlertView *alerv = [[UIAlertView alloc] initWithTitle:@"确认删除" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
    alerv.tag=101;
    [alerv show];
 
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
            [self DeLeleshp];
            return;
        }
        
    }
    
}

-(void)DeLeleshp
{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
        NSString *memberId; NSString *key;NSString *merchantShopId;
        memberId = [CommonUtil getValueByKey:MEMBER_ID];
        key = [CommonUtil getServerKey];

        merchantShopId=[self.shopdetaildic objectForKey:@"MerchantShopId"];

        AppHttpClient* httpClient = [AppHttpClient sharedClient];
        NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                               memberId,@"memberId",
                               merchantShopId,@"merchantShopId",
                               key,@"key",
                               nil];
        [SVProgressHUD showWithStatus:@"数据提交中"];
        [httpClient request:@"MerchantShopDelete.ashx" parameters:param success:^(NSJSONSerialization* json) {
            BOOL success = [[json valueForKey:@"status"] boolValue];
            if (success) {
                [SVProgressHUD dismiss];
                NSString *msg=[json valueForKey:@"msg"];
                [SVProgressHUD showSuccessWithStatus:msg];
                
                [self closeallkey];

                [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(popview) userInfo:nil repeats:NO];
                
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
