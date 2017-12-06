//
//  CtriphotelViewController.m
//  HuiHui
//
//  Created by 冯海强 on 14-9-11.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "CtriphotelViewController.h"

#import "CtriphotelCell.h"

#import "CtriphotellistViewController.h"

#import "Ctrip_chosehotelViewController.h"

#import "CtripwebViewController.h"
#import "CommonUtil.h"
#import "Hotel_CitylistDB.h"


@interface CtriphotelViewController ()

{
    int Ctrip_Days;//住几晚；
    
    NSString *Ctrip_address ;//地址、城市
    
    Hotel_CitylistDB *dbhelp;

}


// 日期的pickView
@property (nonatomic, strong) UIDatePicker          *m_datePicker;

// 日期的记录值
@property (nonatomic, strong) NSString              *m_datadaytext;//用来给Cell传值

@property (nonatomic, strong) NSString              *m_datayeartext;//年
@property (nonatomic, strong) NSString              *m_dataweektext;//周
@property (strong, nonatomic) NSMutableArray *CitysSource;

@end

@implementation CtriphotelViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.Ctrip_hotelInfomation = [[NSMutableDictionary alloc]initWithCapacity:0];
        dbhelp = [[Hotel_CitylistDB alloc] init];
        _CitysSource = [NSMutableArray array];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]
                                             initWithTarget:self action:@selector(handleBackgroundTap:)];
    tapRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapRecognizer];
    
    
    [self.C_ActhionSheet setFrame:CGRectMake(0, WindowSize.size.height, WindowSize.size.width, self.C_ActhionSheet.frame.size.height)];
    Ctrip_address = @"我附近的酒店";
    
    [self setTitle:@"国内酒店"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    self.Ctriphotel_start = @"";
        
    self.m_datePicker = [[UIDatePicker alloc]init];
    self.m_datePicker.date = [NSDate date];

    [self togglePicker];
    
    Ctrip_Days = 1;//默认住一晚；
    
    [self.C_DateActhionSheet setFrame:CGRectMake(0, WindowSize.size.height, WindowSize.size.width, self.C_DateActhionSheet.frame.size.height)];

    // 初始化pickerView
    [self initWithPickerView];
    
    [self.view addSubview:self.C_DateActhionSheet];
    
    [self InitBMap];

    //城市第一次 没有加载的情况 请求加载存储数据库
    self.CitysSource = [NSMutableArray arrayWithArray: [dbhelp queryCity]];
    
    if (self.CitysSource.count ==0) {
        
        [self showHudInView:self.navigationController.view.window hint:@"正在获取城市..."];
        [self loadHotelCity];
    }
    
    NSMutableArray *arr = [CommonUtil getValueByKey:@"HotelNameKeyArray"];
    if (!arr) {
        NSArray *array= @[@"如家",@"莫泰",@"汉庭",@"雅都",@"南苑e家",@"尚客优",@"新世纪",@"锦江之星",@"香格里拉",@"7天连锁",@"格林豪泰",@"飘HOME"];//房间数
        arr = [array mutableCopy];
        [CommonUtil addValue:array andKey:@"HotelNameKeyArray"];
    }
    
    _HotelNameKeypickview=[[ZHPickView alloc] initPickviewWithArray:[arr copy] isHaveNavControler:NO];
    [self.view addSubview:_HotelNameKeypickview];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    
}

- (void) handleBackgroundTap:(UITapGestureRecognizer*)sender
{
    [self.view endEditing:YES];
}

-(void)Gethotel_cityid
{
    for (NSDictionary *dic in self.CitysSource) {
        
        NSString *string = [dic objectForKey:@"CityName"];
        
        if ( [string isEqualToString:[NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:kSelectCityName]]] ) {
            
            [CommonUtil addValue:[NSString stringWithFormat:@"%@",[dic objectForKey:@"CityId"]] andKey:hotelCityCode];
            return;
        }
        
    }

}


- (void)loadHotelCity {
    
    NSString *cityVer = [dbhelp queryVersion];
    
    NSLog(@"cityVer%@",cityVer);
    
    if (cityVer == nil ||[cityVer isEqualToString:@""]) {
        cityVer = @"-1";
    }
    
    AppHttpClient* httpClient = [AppHttpClient sharedCtrip];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           cityVer, @"cityVersion",
                           nil];
    [httpClient requestCtrip:@"CityList.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            
            NSArray *versionList = [json valueForKey:@"CityListSessions"];
            
            if ([versionList count] != 0) {
                
                NSString *cityVersion = [NSString stringWithFormat:@"%@",[json valueForKey:@"CityVersion"]];
                if (cityVersion > 0) {
                    NSArray *cityList = [json valueForKey:@"CityListSessions"];
                    [dbhelp updateData:cityList andVersion:[NSString stringWithFormat:@"%@",cityVersion]];
                    self.CitysSource = [NSMutableArray arrayWithArray: [dbhelp queryCity]];
                    [self Gethotel_cityid];

                }
                
            }
            
        }
        [self hideHud];

    } failure:^(NSError *error) {
        [self hideHud];

    }];
}

- (void)leftClicked{
    
    [self goBack];
    
}


- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self hideTabBar:YES];
    
    CH_mapView.delegate = self;
    CH_locService.delegate = self;
    m_search.delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [self hideTabBar:NO];
    [self.view endEditing:YES];

    CH_mapView.delegate = nil;
    CH_locService.delegate = nil;
    m_search.delegate = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma 初始化pickerView
- (void)initWithPickerView{
	
//    UIWindow *window = self.navigationController.view.window;
	//  datePickerView初始化
	self.m_datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 44, WindowSize.size.width, 200)];
    [self.m_datePicker setDatePickerMode:UIDatePickerModeDate];
    self.m_datePicker.minimumDate=[NSDate date];//不能选今日之前的。设最小日期；
    self.m_datePicker.maximumDate = [NSDate dateWithTimeIntervalSinceNow:86400*180];//最大一百八十天
	[self.m_datePicker addTarget:self action:@selector(togglePicker) forControlEvents:UIControlEventValueChanged];
    self.m_datePicker.backgroundColor = [UIColor whiteColor];
	[self.C_DateActhionSheet addSubview:self.m_datePicker];
    
    
    UIToolbar *pickerBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, WindowSize.size.width, 44)];
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
//    [window addSubview:pickerBar];
    pickerBar.backgroundColor = [UIColor clearColor];
    [self.C_DateActhionSheet addSubview:pickerBar];
    
}







#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 4;
            break;
            
        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = nil;
    
    switch (indexPath.section) {
        case 0:
            if ( indexPath.row == 0 ) {
                
                cell = [self tableView6:tableView cellForRowAtIndexPath:indexPath];
                
            }
            break;
        case 1:
            
            if ( indexPath.row == 0 ) {
                
                cell = [self tableView0:tableView cellForRowAtIndexPath:indexPath];
                
            }else if ( indexPath.row == 1 ){
                
                cell = [self tableView1:tableView cellForRowAtIndexPath:indexPath];
                
            }else if ( indexPath.row == 2 ){
                
                cell = [self tableView2:tableView cellForRowAtIndexPath:indexPath];
                
            }
            //    else if ( indexPath.row == 3 ){
            //
            //        cell = [self tableView3:tableView cellForRowAtIndexPath:indexPath];
            //
            //    }else if ( indexPath.row == 4 ){
            //
            //        cell = [self tableView4:tableView cellForRowAtIndexPath:indexPath];
            //        
            //    }
            else {
                
                cell = [self tableView5:tableView cellForRowAtIndexPath:indexPath];
                
            }
            break;
            
        default:
            break;
    }
  
    return cell;
}



// 第0行显示的数据
- (UITableViewCell *)tableView0:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"CtriphotelCellIdentifier";
    
    CtriphotelCell0 *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"CtriphotelCell" owner:self options:nil];
        
        cell = (CtriphotelCell0 *)[nib objectAtIndex:0];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    [cell.Ctriphotel_Myaddre.layer setBorderWidth:1.0]; //边框宽度
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 0.1, 0.1, 0.7, 1 });
    [cell.Ctriphotel_Myaddre.layer setBorderColor:colorref];//边框颜色
    
    [cell.Ctriphotel_Myaddre addTarget:self action:@selector(SwitchMyaddress) forControlEvents:UIControlEventTouchUpInside];

    
    [cell.Ctriphotel_Choseaddre addTarget:self action:@selector(ChoseCtripCity) forControlEvents:UIControlEventTouchUpInside];
    
    cell.Ctriphotel_city.text = Ctrip_address;
    
    return cell;
    
    
}

// 第1行显示的数据
- (UITableViewCell *)tableView1:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"CtriphotelCellIdentifier";
    
    CtriphotelCell1 *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"CtriphotelCell" owner:self options:nil];
        
        cell = (CtriphotelCell1 *)[nib objectAtIndex:1];
        
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
    }
    
    cell.Ctriphotel_goYR.text = self.m_datadaytext;//月日
    [self.Ctrip_hotelInfomation setObject:[NSString stringWithFormat:@"%@",self.m_datadaytext] forKey:@"startTime"];
    cell.Ctriphotel_goNZ.text = [NSString stringWithFormat:@"%@ %@",self.m_dataweektext,self.m_datayeartext];
 
    
    return cell;
    
}

// 第2行显示的数据
- (UITableViewCell *)tableView2:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"CtriphotelCellIdentifier";
    
    CtriphotelCell2 *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"CtriphotelCell" owner:self options:nil];
        
        cell = (CtriphotelCell2 *)[nib objectAtIndex:2];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    if (Ctrip_Days<=1) {
        
        [cell.Ctriphotel_outA addTarget:self action:@selector(ADDdays) forControlEvents:UIControlEventTouchUpInside];

        cell.Ctriphotel_outR.enabled = NO;
        [cell.Ctriphotel_outR setBackgroundImage:[UIImage imageNamed:@"ic_minus_disable.png"] forState:UIControlStateNormal];
        cell.Ctriphotel_outA.enabled = YES;
        [cell.Ctriphotel_outA setBackgroundImage:[UIImage imageNamed:@"ic_plus_normal.png"] forState:UIControlStateNormal];

        
    }else if (Ctrip_Days>=10)
    {
        
        [cell.Ctriphotel_outR addTarget:self action:@selector(Jiandays) forControlEvents:UIControlEventTouchUpInside];
        
        cell.Ctriphotel_outA.enabled = NO;
        [cell.Ctriphotel_outA setBackgroundImage:[UIImage imageNamed:@"ic_plus_disable.png"] forState:UIControlStateNormal];
        cell.Ctriphotel_outR.enabled = YES;
        [cell.Ctriphotel_outR setBackgroundImage:[UIImage imageNamed:@"ic_minus_normal.png"] forState:UIControlStateNormal];

        
    }else{
        
        [cell.Ctriphotel_outR addTarget:self action:@selector(Jiandays) forControlEvents:UIControlEventTouchUpInside];

        [cell.Ctriphotel_outA addTarget:self action:@selector(ADDdays) forControlEvents:UIControlEventTouchUpInside];
        
        cell.Ctriphotel_outR.enabled = YES;
        cell.Ctriphotel_outA.enabled = YES;

        [cell.Ctriphotel_outR setBackgroundImage:[UIImage imageNamed:@"ic_minus_normal.png"] forState:UIControlStateNormal];
        [cell.Ctriphotel_outA setBackgroundImage:[UIImage imageNamed:@"ic_plus_normal.png"] forState:UIControlStateNormal];

        
    }
    
    
    cell.Ctriphotel_outhowdays.text = [NSString stringWithFormat:@"住 %d 晚",Ctrip_Days];
    
    NSDate * OUTdate = [self.m_datePicker.date dateByAddingTimeInterval:+(86400*Ctrip_Days)];
    
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyy年MM月dd日"];
    NSString *strday = [formatter stringFromDate:OUTdate];
    
    cell.Ctriphotel_outYZ.text = [NSString stringWithFormat:@"%@ %@",[strday substringFromIndex:5],[self getWeekday:OUTdate]];

    [self.Ctrip_hotelInfomation setObject:[NSString stringWithFormat:@"住 %d 晚",Ctrip_Days] forKey:@"InNumDays"];
    [self.Ctrip_hotelInfomation setObject:[NSString stringWithFormat:@"%@",[strday substringFromIndex:5]] forKey:@"endTime"];
    
    //存储格式用于接口请求
    NSDateFormatter *formatterRequest =[[NSDateFormatter alloc] init];
    [formatterRequest setDateFormat:@"yyy-MM-dd"];
    NSString *endTimeRequest = [formatterRequest stringFromDate:OUTdate];
    [self.Ctrip_hotelInfomation setObject:endTimeRequest forKey:@"endTimeRequest"];
    
    
    return cell;
}


// 第3行显示的数据
- (UITableViewCell *)tableView3:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"CtriphotelCellIdentifier";
    
    CtriphotelCell3 *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"CtriphotelCell" owner:self options:nil];
        
        cell = (CtriphotelCell3 *)[nib objectAtIndex:3];
        
        cell.selectionStyle = UITableViewCellSelectionStyleGray;

        
    }
    
    cell.Ctriphotel_key.enabled = NO;

    
    
    
    return cell;
}


// 第4行显示的数据
- (UITableViewCell *)tableView4:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    static NSString *cellIdentifier = @"CtriphotelCellIdentifier";
    
    CtriphotelCell4 *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"CtriphotelCell" owner:self options:nil];
        
        cell = (CtriphotelCell4 *)[nib objectAtIndex:4];
        
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
    }
    
    cell.Ctriphotel_money.enabled = NO;
    if ([self.Ctriphotel_start isEqualToString:@"不限"]) {
        
        cell.Ctriphotel_money.text = @"";

    }else{
        cell.Ctriphotel_money.text = self.Ctriphotel_start;

    }
    
    return cell;
}


// 第5行显示的数据
- (UITableViewCell *)tableView5:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    static NSString *cellIdentifier = @"CtriphotelCellIdentifier";
    
    CtriphotelCell5 *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"CtriphotelCell" owner:self options:nil];
        
        cell = (CtriphotelCell5 *)[nib objectAtIndex:5];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    [cell.Ctriphotel_checkBtn addTarget:self action:@selector(CheckCtripHotel) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

// 后来加上第0区第0行显示的数据（酒店名关键字搜索）
- (UITableViewCell *)tableView6:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"CtriphotelCellIdentifier";
    
    CtriphotelCell6 *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"CtriphotelCell" owner:self options:nil];
        
        cell = (CtriphotelCell6 *)[nib objectAtIndex:6];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    cell.Ctriphotel_KeyWord.delegate = self;
    
    [cell.Ctriphotel_checkBtn addTarget:self action:@selector(CheckHotelNameKey) forControlEvents:UIControlEventTouchUpInside];
    
    
    return cell;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField;           // became first responder
{
    [self hiddenNumPadDone:nil];
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField;
{
    [self.Ctrip_hotelInfomation setObject:textField.text forKey:@"Ctriphotel_KeyWord"];

}
- (BOOL)textFieldShouldReturn:(UITextField *)textField;
{
    [self.view endEditing:YES];
    return YES;
}


-(void)CloseKey
{
    [self.view endEditing:YES];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ( indexPath.row == 3 ) {
        
        return 58.0f;
        
    }
    return 50.0f;

}


#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 1:
            
            if (indexPath.row == 1) {
                
                [self.view endEditing:YES];
                [self Show_FHQactionsheetDate];
                
            }else if (indexPath.row == 3)
            {
                //        Ctrip_chosehotelViewController * VC = [[Ctrip_chosehotelViewController alloc ]initWithNibName:@"Ctrip_chosehotelViewController" bundle:nil];
                //
                //        [self.navigationController pushViewController:VC animated:YES];
                
            }else if (indexPath.row == 4)
            {
                
                //        [self Show_FHQactionsheet];
                
            }
            
            break;
            
        default:
            break;
    }
 
    [tableView deselectRowAtIndexPath:indexPath animated:YES];


}

#pragma mark - 我附近酒店、酒店城市
-(void)ChoseCtripCity
{
//    
//    CtripHotelCityViewController * VC = [[CtripHotelCityViewController alloc]initWithNibName:@"CtripHotelCityViewController" bundle:nil];
    [self.view endEditing:YES];

    HotelCitylistViewController * VC = [[HotelCitylistViewController alloc]initWithNibName:nil bundle:nil];
    VC.Chosectriphoteldelegate = self;
    [self.navigationController pushViewController:VC animated:YES];
    
}

- (void)GetCtrip_hotel_cityname:(NSDictionary *)cityname;
{
    Ctrip_address = [NSString stringWithFormat:@"%@",[cityname objectForKey:@"CityName"]];

    if ([Ctrip_address isEqualToString:@"我附近的酒店"]) {
 
        [self SwitchMyaddress];
        
    }else
    {
        [CommonUtil addValue:[NSString stringWithFormat:@"%@",[cityname objectForKey:@"CityId"]] andKey:hotelCityCode];

    }
    
    // 刷新第一行
    [self.Ctriptableview reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:1]] withRowAnimation:UITableViewRowAnimationNone];
    
}


//时间
#pragma mark - 入住时间、离店时间
- (void)togglePicker{
    
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyy年MM月dd日"];//用于显示界面
    NSString *strday = [formatter stringFromDate:self.m_datePicker.date];
    
    //存储格式用于接口请求
    NSDateFormatter *formatterRequest =[[NSDateFormatter alloc] init];
    [formatterRequest setDateFormat:@"yyy-MM-dd"];
    NSString *strdayRequest = [formatterRequest stringFromDate:self.m_datePicker.date];
    [self.Ctrip_hotelInfomation setObject:strdayRequest forKey:@"startTimeRequest"];

    NSDate * today = [NSDate date];
    NSDate * Tomorrow = [NSDate dateWithTimeIntervalSinceNow:+86400];
    NSDate * ATomorrow = [NSDate dateWithTimeIntervalSinceNow:+86400+86400];
    
    NSString * todayString = [formatter stringFromDate:today];
    NSString * TomorrowString = [formatter stringFromDate:Tomorrow];
    NSString * ATomorrowString = [formatter stringFromDate:ATomorrow];
    
    if ([strday isEqualToString:todayString]) {
        
        self.m_datadaytext = @"今天";
        self.m_dataweektext = [self getWeekday:today];
        
    }else if ([strday isEqualToString:TomorrowString])
    {
        self.m_datadaytext = @"明天";
        self.m_dataweektext = [self getWeekday:Tomorrow];
  
    }else if ([strday isEqualToString:ATomorrowString])
    {
        self.m_datadaytext = @"后天";
        self.m_dataweektext = [self getWeekday:ATomorrow];
        
    }else{
        
        self.m_datadaytext = [NSString stringWithFormat:@"%@",[strday substringFromIndex:5]];//用来当参数;
        self.m_dataweektext = [self getWeekday:self.m_datePicker.date];
        
    }
    
    self.m_datayeartext = [[NSString stringWithFormat:@"%@",strday] substringToIndex:5];
    
    [self.Ctriptableview reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:1 inSection:1]] withRowAnimation:UITableViewRowAnimationNone];

    [self.Ctriptableview reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:2 inSection:1]] withRowAnimation:UITableViewRowAnimationNone];

}



-(NSString *)getWeekday:(NSDate*)date
{
    NSDateComponents *componets = [[NSCalendar autoupdatingCurrentCalendar] components:NSWeekdayCalendarUnit fromDate:date];
    NSString *weekday = [self getWeekdayWithNumber:[componets weekday]];
    return weekday;
}

//1代表星期日、如此类推
-(NSString *)getWeekdayWithNumber:(int)number
{
    switch (number) {
            case 1:
            return @"周日";
            break;
        case 2:
            return @"周一";
            break;
        case 3:
            return @"周二";
            break;
        case 4:
            return @"周三";
            break;
        case 5:
            return @"周四";
            break;
        case 6:
            return @"周五";
            break;
        case 7:
            return @"周六";
            break;
        default:
            return @"";
            break;
    }
}



#pragma mark - PickerBar按钮//完成
- (void)doPCAPickerDone{
    
    [self Hidden_FHQactionsheetDate];

}


- (void)doPCAPickerCancel{

    self.m_datadaytext = @"今天";
    
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyy年MM月dd日"];
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    self.m_datayeartext = [[NSString stringWithFormat:@"%@",currentDateStr] substringToIndex:5];
    self.m_dataweektext = [self getWeekday: [NSDate date]];

    Ctrip_Days = 1;
    self.m_datePicker.date = [NSDate date];
    
    NSDateFormatter *formatterRequest =[[NSDateFormatter alloc] init];
    [formatterRequest setDateFormat:@"yyy-MM-dd"];
    NSString *strdayRequest = [formatterRequest stringFromDate:[NSDate date]];
    [self.Ctrip_hotelInfomation setObject:strdayRequest forKey:@"startTimeRequest"];
    
    [self.Ctriptableview reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:1 inSection:1]] withRowAnimation:UITableViewRowAnimationNone];

    [self.Ctriptableview reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:2 inSection:1]] withRowAnimation:UITableViewRowAnimationNone];
    
    [self Hidden_FHQactionsheetDate];
    
}



#pragma mark - addorjian//住几晚

-(void)ADDdays
{
    [self.view endEditing:YES];

    Ctrip_Days ++ ;
    
    [self.Ctriptableview reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:2 inSection:1]] withRowAnimation:UITableViewRowAnimationNone];

    
}


-(void)Jiandays
{
    [self.view endEditing:YES];

    Ctrip_Days -- ;

    [self.Ctriptableview reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:2 inSection:1]] withRowAnimation:UITableViewRowAnimationNone];


}



#pragma mark - 查找酒店

-(void)CheckCtripHotel
{
    
    [self.view endEditing:YES];
    CtriphotellistViewController * VC = [[CtriphotellistViewController alloc]initWithNibName:@"CtriphotellistViewController" bundle:nil];
    VC.Ctrip_hotelInfomation = self.Ctrip_hotelInfomation;
    [self.navigationController pushViewController:VC animated:YES];
    
//    CtripwebViewController * VC = [[CtripwebViewController alloc]initWithNibName:@"CtripwebViewController" bundle:nil];
//    VC.Ctrip_webstring = @"http://m.ctrip.com/webapp/hotel";
//    [self.navigationController pushViewController:VC animated:YES];

    
}
#pragma mark - 选择入住日期（代理）自定义 actionsheet
-(void)Show_FHQactionsheetDate
{
    [UIView animateWithDuration:0.3 animations:^{
        
        CGRect frame=self.C_DateActhionSheet.frame;
        frame.origin.y = WindowSize.size.height - 318;
        
        [self.C_DateActhionSheet setFrame:frame];
        self.C_alphaView.alpha = 0.3;
        
    } completion:^(BOOL finished){
    }];
}
-(void)Hidden_FHQactionsheetDate
{
    [UIView animateWithDuration:0.3 animations:^{
        
        CGRect frame=self.C_DateActhionSheet.frame;
        frame.origin.y = WindowSize.size.height;
        [self.C_DateActhionSheet setFrame:frame];
        self.C_alphaView.alpha = 0;
        
    } completion:^(BOOL finished){
    }];
}



#pragma mark - 选择酒店星级（代理）自定义 actionsheet

-(void)Show_FHQactionsheet
{
    [UIView animateWithDuration:0.3 animations:^{
        
        CGRect frame=self.C_ActhionSheet.frame;
        frame.origin.y = WindowSize.size.height - 300;
        
        [self.C_ActhionSheet setFrame:frame];
        self.C_alphaView.alpha = 0.3;
        
    } completion:^(BOOL finished){
        
    }];
}


-(void)Hidden_FHQactionsheet
{
    [UIView animateWithDuration:0.3 animations:^{
        
        CGRect frame=self.C_ActhionSheet.frame;
        frame.origin.y = WindowSize.size.height;
        [self.C_ActhionSheet setFrame:frame];
        self.C_alphaView.alpha = 0;
        
    } completion:^(BOOL finished){
        
    }];
}


- (IBAction)C_alphaviewtap:(id)sender
{
    [self Hidden_FHQactionsheet];
    [self Hidden_FHQactionsheetDate];
}


-(IBAction)Chose_Cstarts:(id)sender
{
    [self.view endEditing:YES];

    UIButton * Btn = (UIButton *)sender;
    
    self.Ctriphotel_start = Btn.titleLabel.text;

    [self Hidden_FHQactionsheet];
    
    [self.Ctriptableview reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:4 inSection:1]] withRowAnimation:UITableViewRowAnimationNone];

    
}

//切换我的位置
-(void)SwitchMyaddress
{
    [self.view endEditing:YES];

    if ( (![CLLocationManager locationServicesEnabled]) || ([CLLocationManager authorizationStatus]==kCLAuthorizationStatusDenied)) {
        [self alertWithMessage:@"为了不影响您的正常使用\n请在系统设置中开启定位服务！"];
        return;
    }
    
    
    [self showHudInView:self.navigationController.view.window hint:@"正在定位..."];
    Ctrip_address = @"我附近的酒店";
    [self startLocation];
    [self.Ctriptableview reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:1]] withRowAnimation:UITableViewRowAnimationNone];


}


-(void)InitBMap
{
    // 初始化地图
    CH_mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, WindowSize.size.width,WindowSize.size.height - 44 - 20 )];
    //初始化BMKLocationService
    CH_locService = [[BMKLocationService alloc]init];
    m_search = [[BMKGeoCodeSearch alloc]init];

}
//普通态
-(void)startLocation
{
    [CH_locService startUserLocationService];
    NSLog(@"进入普通定位态");
    CH_mapView.showsUserLocation = NO;//先关闭显示的定位图层
    CH_mapView.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态
    CH_mapView.showsUserLocation = YES;//显示定位图层
}

#pragma mark - BMKMapViewDelegate
//- (void)didUpdateUserLocation:(BMKUserLocation *)userLocation
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    [CH_mapView updateLocationData:userLocation];
    
    CLLocationCoordinate2D pt = (CLLocationCoordinate2D){0, 0};
    pt = (CLLocationCoordinate2D){userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude};
    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    reverseGeocodeSearchOption.reverseGeoPoint = pt;
    BOOL flag = [m_search reverseGeoCode:reverseGeocodeSearchOption];
    
    if(flag)
    {
        NSLog(@"反geo检索发送成功");
    }
    else
    {
        NSLog(@"反geo检索发送失败");
        [self hideHud];
        
    }

}


- (void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    if (error == 0) {
        
    BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
    item.coordinate = result.location;
    item.title = result.address;

    // 反编码成功后进行一些操作
    // 定位取消
    [CH_locService stopUserLocationService];
    CH_mapView.showsUserLocation = NO;
    [self hideHud];
    if ([result.addressDetail.city isEqualToString:@""]) {
        return;
    }
    NSString *City =[result.addressDetail.city substringWithRange:NSMakeRange(0, result.addressDetail.city.length - 1)];
    
    [CommonUtil addValue:[NSString stringWithFormat:@"%f",result.location.latitude] andKey:kLatitudeKey];
    [CommonUtil addValue:[NSString stringWithFormat:@"%f",result.location.longitude] andKey:kLongitudeKey];
    [CommonUtil addValue:City andKey:kSelectCityName];
    [CommonUtil addValue:[NSString stringWithFormat:@"%@%@",result.addressDetail.streetName,result.addressDetail.streetNumber] andKey:kSelectAddress];
    [CommonUtil addValue:[NSString stringWithFormat:@"%@",result.address] andKey:kALLSelectAddress];
    [self Gethotel_cityid];

    }

    
}



//定位失败
- (void)mapView:(BMKMapView *)mapView didFailToLocateUserWithError:(NSError *)error{
    
    CH_mapView.showsUserLocation = NO;
    CH_mapView.delegate = nil;
    CH_locService.delegate = nil;
    m_search.delegate = nil;
    
    [self hideHud];

}

//快捷填充酒店名称的关键字
-(void)CheckHotelNameKey
{
    [self.view endEditing:YES];
    _HotelNameKeypickview.delegate = self;
    [UIView animateWithDuration:0.3 animations:^{
        self.C_alphaView.alpha = 0.3;
        _HotelNameKeypickview.frame = CGRectMake(0,WindowSize.size.height-240-64, WindowSize.size.width, 240);
    } completion:^(BOOL finished){
    }];
}

- (IBAction)HidetoobarDonBtnHaveClick:(id)sender
{
    [UIView animateWithDuration:0.3 animations:^{
        self.C_alphaView.alpha = 0;
        _HotelNameKeypickview.frame = CGRectMake(0, WindowSize.size.height, WindowSize.size.width, 240);
    } completion:^(BOOL finished){
    }];
    [self.view endEditing:YES];
    
}

-(void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultString:(NSString *)resultString{
    
    CtriphotelCell6 *cell = (CtriphotelCell6 *)[self.Ctriptableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    cell.Ctriphotel_KeyWord.text = resultString;
    [self.Ctrip_hotelInfomation setObject:resultString forKey:@"Ctriphotel_KeyWord"];
    
}

@end
