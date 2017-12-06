//
//  NextPartyViewController.m
//  baozhifu
//
//  Created by mac on 14-3-4.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "NextPartyViewController.h"

#import "SVProgressHUD.h"

#import "CommonUtil.h"

#import "PosterViewController.h"

#import "AppHttpClient.h"

#import "AppDelegate.h"

@interface NextPartyViewController ()

@property (weak, nonatomic) IBOutlet UIView *m_tempView;

@property (weak, nonatomic) IBOutlet UIView *m_titleView;

@property (weak, nonatomic) IBOutlet UIScrollView *m_scrollerView;

@property (weak, nonatomic) IBOutlet UITextField *m_endDate;

@property (weak, nonatomic) IBOutlet UITextField *m_startDate;

@property (weak, nonatomic) IBOutlet UITextField *m_stopDate;

@property (weak, nonatomic) IBOutlet UITextField *m_startTime;

@property (weak, nonatomic) IBOutlet UITextField *m_endTime;

@property (weak, nonatomic) IBOutlet UITextField *m_province;

@property (weak, nonatomic) IBOutlet UITextField *m_city;

@property (weak, nonatomic) IBOutlet UITextField *m_area;

@property (weak, nonatomic) IBOutlet UITextField *m_detailAddress;

@property (weak, nonatomic) IBOutlet UITextField *m_minCount;

@property (weak, nonatomic) IBOutlet UITextField *m_maxCount;

@property (weak, nonatomic) IBOutlet UITextField *m_minAge;

@property (weak, nonatomic) IBOutlet UITextField *m_maxAge;

@property (weak, nonatomic) IBOutlet UITextField *m_sex;


// 截止日期选择
- (IBAction)chooseDateBtn:(id)sender;
// 时间选择
- (IBAction)timeChoose:(id)sender;
// 性别选择
- (IBAction)sexChoose:(id)sender;
// 下一步按钮触发的事件
- (IBAction)netxStep:(id)sender;
// 选择地区
- (IBAction)chooseAddress:(id)sender;

@end

@implementation NextPartyViewController

@synthesize m_datePicker;

@synthesize m_toolbar;

@synthesize m_timePicker;

@synthesize m_timeToolbar;

@synthesize m_cityArray;

@synthesize m_areaArray;

@synthesize m_addressArray;

@synthesize m_pickerToolBar;

@synthesize m_pickerView;

@synthesize m_dic;

@synthesize m_activityId;

@synthesize m_postList;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        m_cityArray = [[NSMutableArray alloc]initWithCapacity:0];
        
        m_areaArray = [[NSMutableArray alloc]initWithCapacity:0];

        m_addressArray = [[NSMutableArray alloc]initWithCapacity:0];

        dbhelp = [[DBHelper alloc]init];
        
        m_dic = [[NSMutableDictionary alloc]initWithCapacity:0];
        
        m_postList = [[NSMutableArray alloc]initWithCapacity:0];

    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    // 设置scrollerView的滚动范围
    [self.m_scrollerView setContentSize:CGSizeMake(WindowSizeWidth, 850)];
    
    // 初始化
    [self initWithPickerView];
    
    [self.m_datePicker setHidden:YES];
    
    [self.m_toolbar setHidden:YES];
    
    // 初始化时间的pickerView
    [self initWithTimePickerView];
    
    [self.m_timePicker setHidden:YES];
    
    [self.m_timeToolbar setHidden:YES];
    
    // 初始化地区的pickerView
    [self initpickerView];
    
    [self.m_pickerView setHidden:YES];
    
    [self.m_pickerToolBar setHidden:YES];
    
    // 赋值
    self.m_cityId = @"";
    self.m_cityId1 = @"";
    self.m_cityId2 = @"";
    
    self.m_areaId = @"";
    self.m_areaId1 = @"";
    self.m_areaId2 = @"";
    
    self.m_districtId = @"";
    self.m_districtId1 = @"";
    self.m_districtId2 = @"";
    
    // 地区赋值
     self.m_cityArray = [dbhelp queryCity];
    
    if ( self.m_cityArray.count != 0 ) {
        
        NSDictionary *dic = [self.m_cityArray objectAtIndex:0];
        
        self.m_areaArray = [dbhelp queryMerchant:[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]]];
        
        self.m_cityString = [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];

        self.m_cityId1 = [NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        
        if ( self.m_areaArray.count != 0 ) {
            
            NSDictionary *dic1 = [self.m_areaArray objectAtIndex:0];
            
            self.m_areaString = [NSString stringWithFormat:@"%@",[dic1 objectForKey:@"name"]];

            self.m_areaId1 = [NSString stringWithFormat:@"%@",[dic1 objectForKey:@"code"]];
            
            self.m_addressArray = [dbhelp queryArea:[NSString stringWithFormat:@"%@",[dic1 objectForKey:@"code"]]];
            
            NSDictionary *dic2 = [self.m_addressArray objectAtIndex:0];
            
            self.m_addressString = [NSString stringWithFormat:@"%@",[dic2 objectForKey:@"name"]];
            
            self.m_districtId1 = [NSString stringWithFormat:@"%@",[dic2 objectForKey:@"code"]];

        }

    }
    
    
    self.m_postList = [self.m_dic objectForKey:@"PosterList"];;
    
    // 判断来自于哪个页面
    if ( [self.m_typeString isEqualToString:@"1"] ) {
        
        [self setTitle:@"发起聚会"];

        NSString *string = [self.m_dic objectForKey:@"typeString"];
        if ( [string isEqualToString:@"1"] ) {
            // 新增
            
            [self.m_dic setObject:@"0" forKey:@"ActivityID"];
            
            [self.m_dic setObject:@"1" forKey:@"operation"];
            
        }else{
            
            // 编辑 - 赋值
            [self.m_dic setObject:@"2" forKey:@"operation"];
            
            self.m_endDate.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"RegStopTime"]];
            self.m_startDate.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"ActStartDate"]];
            self.m_stopDate.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"ActEndDate"]];
            self.m_startTime.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"ActStartTime"]];
            self.m_endTime.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"ActEndtTime"]];
            self.m_cityId = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"CityID"]];
            self.m_areaId = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"AreaID"]];
            self.m_districtId = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"DistrictID"]];
           self.m_province.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"AddressDetail"]];
            self.m_detailAddress.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"Address"]];
            self.m_minCount.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"PeoperNumMin"]];
            self.m_maxCount.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"PeoperNumMax"]];
            self.m_minAge.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"AgeMin"]];
            self.m_maxAge.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"AgeMax"]];
            NSString *sexString = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"Sex"]];
            
            if ( [sexString isEqualToString:@"Female"] ) {
                
                self.m_sex.text = @"女";
                
            }else if ( [sexString isEqualToString:@"Male"] ){
                
                self.m_sex.text = @"男";

            }else{
                
                self.m_sex.text = @"不限男女";

            }
            
        }
        
        
    }else{
        
        [self setTitle:@"策划活动"];
        
        NSString *string = [self.m_dic objectForKey:@"typeString"];
        
        if ( [string isEqualToString:@"1"] ) {
            // 新增
            
            [self.m_dic setObject:@"0" forKey:@"ActivityID"];
            
            [self.m_dic setObject:@"1" forKey:@"operation"];
            
        }else{
            
            // 编辑 - 赋值
            [self.m_dic setObject:@"2" forKey:@"operation"];
            
            self.m_endDate.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"RegStopTime"]];
            self.m_startDate.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"ActStartDate"]];
            self.m_stopDate.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"ActEndDate"]];
            self.m_startTime.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"ActStartTime"]];
            self.m_endTime.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"ActEndtTime"]];
            self.m_cityId = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"CityID"]];
            self.m_areaId = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"AreaID"]];
            self.m_districtId = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"DistrictID"]];
            self.m_province.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"AddressDetail"]];
            self.m_detailAddress.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"Address"]];
            self.m_minCount.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"PeoperNumMin"]];
            self.m_maxCount.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"PeoperNumMax"]];
            self.m_minAge.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"AgeMin"]];
            self.m_maxAge.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"AgeMax"]];
            NSString *sexString = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"Sex"]];
            
            if ( [sexString isEqualToString:@"Female"] ) {
                
                self.m_sex.text = @"女";
                
            }else if ( [sexString isEqualToString:@"Male"] ){
                
                self.m_sex.text = @"男";
                
            }else{
                
                self.m_sex.text = @"不限男女";
                
            }
            
        }
    
    }
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self hideTabBar:YES];
    
    // 如果从海报的页面过来，如果修改了海报，则需要请求数据替换海报的数组,否则不需要任何操作
    if ( Appdelegate.isModifyImage ) {
        
        // 请求详情
        [self DetailActRequestSubmit];
        
    }else{
        
        
    }
    
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [self hideTabBar:NO];

    // 隐藏pickerView和toolBar
    [m_datePicker setHidden:YES];
    
	[m_toolbar setHidden:YES];
    
    [m_timePicker setHidden:YES];
    
	[m_timeToolbar setHidden:YES];
    
    [self.m_pickerView setHidden:YES];
    
    [self.m_pickerToolBar setHidden:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)leftClicked{

    [self goBack];
    
}

- (void)DetailActRequestSubmit
{
    
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
                                  self.m_activityId,@"activityId",
                                  nil];
    
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
//    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"ActivityDetail.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
//            [SVProgressHUD dismiss];
            
            NSMutableDictionary *dic = [json valueForKey:@"Activity"];
            
            // 赋值
            self.m_postList = [dic objectForKey:@"PosterList"];;

            
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




- (IBAction)chooseDateBtn:(id)sender {
    
    self.view.userInteractionEnabled = NO;
    
    [self.view endEditing:YES];

    UIButton *btn = (UIButton *)sender;
    
    self.m_dateString = [NSString stringWithFormat:@"%i",btn.tag];
    

    [self.m_datePicker setHidden:NO];
    
    [self.m_toolbar setHidden:NO];
}

- (IBAction)timeChoose:(id)sender {
    
    self.view.userInteractionEnabled = NO;

    
    [self.view endEditing:YES];

    
    UIButton *btn = (UIButton *)sender;
    
    self.m_dateString = [NSString stringWithFormat:@"%i",btn.tag];

    
    [self.m_timePicker setHidden:NO];
    
    [self.m_timeToolbar setHidden:NO];
}

- (IBAction)sexChoose:(id)sender {
    
    
    [self.view endEditing:YES];
    // 性别选择
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"性别限制"
                                                            delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil
                                                   otherButtonTitles:@"不限男女",@"男",@"女", nil];
    
    // 解决sheetAction不能点击的问题
    [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
    
}

- (IBAction)netxStep:(id)sender {
    
    if ( self.m_endDate.text.length == 0 ) {
      
        [SVProgressHUD showErrorWithStatus:@"请选择报名截止日期"];
        
        return;
    }
  
    if ( self.m_startDate.text.length == 0 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请选择开始日期"];
        
        return;
    }
   
    if ( self.m_stopDate.text.length == 0 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请选择结束日期"];
        
        return;
    }
   
    if ( [self.m_PartyEndDate compare:self.m_PartystartDate] == NSOrderedAscending ) {
        
        [SVProgressHUD showErrorWithStatus:@"开始日期不能早于结束日期"];
        
        return;
        
    }
    
    if ( self.m_startTime.text.length == 0 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请选择开始时间"];
        
        return;
    }
 
    if ( self.m_endTime.text.length == 0 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请选择结束时间"];
        
        return;
    }
    
    if ( self.m_province.text.length == 0 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请选择所在区域"];
        
        return;
    }
  
    
    if ( self.m_detailAddress.text.length == 0 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请输入详细地址"];
        
        return;
    }
    
    if ( self.m_minCount.text.length == 0 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请输入报名最少人数"];
        
        return;
    }
    
    if ( self.m_maxCount.text.length == 0 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请输入报名最多人数"];
        
        return;
    }
    
    if ( [self.m_minCount.text intValue] > [self.m_maxCount.text intValue] ) {
        
        [SVProgressHUD showErrorWithStatus:@"报名最少人数不得大于最多人数"];
        
        return;
    }
    
    if ( self.m_minAge.text.length == 0 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请输入最小年龄"];
        
        return;
    }
    
    if ( self.m_maxAge.text.length == 0 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请输入最大年龄"];
        
        return;
    }
    
    
    if ( [self.m_minAge.text intValue] > [self.m_maxAge.text intValue] ) {
        
        [SVProgressHUD showErrorWithStatus:@"最小年龄不得大于最大年龄"];
        
        return;
    }
    
    if ( self.m_sex.text.length == 0 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请选择性别"];
        
        return;
    }
    
    NSString *sexString;
    
    if ( [self.m_sex.text isEqualToString:@"男"] ) {
        
        sexString = @"Male";
        
    }else if ( [self.m_sex.text isEqualToString:@"女"] ) {
        
        sexString = @"Female";
        
    }else{
        
        sexString = @"";
        
    }
    
    // 存储数据
    [self.m_dic setObject:self.m_endDate.text forKey:@"regStopTime"];
    [self.m_dic setObject:self.m_startDate.text forKey:@"actStartDate"];
    [self.m_dic setObject:self.m_stopDate.text forKey:@"actEndDate"];
    [self.m_dic setObject:self.m_startTime.text forKey:@"actStartTime"];
    [self.m_dic setObject:self.m_endTime.text forKey:@"actEndTime"];
    [self.m_dic setObject:self.m_cityId forKey:@"cityIDTxt"];
    [self.m_dic setObject:self.m_areaId forKey:@"areaIDTxt"];
    [self.m_dic setObject:self.m_districtId forKey:@"districtIDTxt"];
    [self.m_dic setObject:self.m_detailAddress.text forKey:@"address"];
    [self.m_dic setObject:self.m_minCount.text forKey:@"peoperNumMin"];
    [self.m_dic setObject:self.m_maxCount.text forKey:@"peoperNumMax"];
    [self.m_dic setObject:self.m_minAge.text forKey:@"ageMin"];
    [self.m_dic setObject:self.m_maxAge.text forKey:@"ageMax"];
    [self.m_dic setObject:sexString forKey:@"sexTxt"];

        
    // 判断来自于哪个页面
    if ( [self.m_typeString isEqualToString:@"1"] ) {
        
        // 上传数据
        [self PartyRequestSubmit];
        
    }else{
        
        [self activityRequestSubmit];
        
    }

    
}

// 上传信息
- (void)PartyRequestSubmit{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    // operation 1：新增；2：修改
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  memberId,     @"memberId",
                                  key,   @"key",
                                  [self.m_dic objectForKey:@"ActivityID"],@"actId",
                                  [self.m_dic objectForKey:@"operation"],@"operation",
                                  [self.m_dic objectForKey:@"classIDTxt"],@"classIDTxt",
                                  [self.m_dic objectForKey:@"activityName"],@"activityName",
                                  [self.m_dic objectForKey:@"fee"],@"fee",
                                  [self.m_dic objectForKey:@"content"],@"content",
                                  [self.m_dic objectForKey:@"explain"],@"explain",
                                  [self.m_dic objectForKey:@"regStopTime"],@"regStopTime",
                                  [self.m_dic objectForKey:@"actStartDate"],@"actStartDate",
                                  [self.m_dic objectForKey:@"actStartTime"],@"actStartTime",
                                  [self.m_dic objectForKey:@"actEndDate"],@"actEndDate",
                                  [self.m_dic objectForKey:@"actEndTime"],@"actEndTime",
                                  [self.m_dic objectForKey:@"cityIDTxt"],@"cityIDTxt",
                                  [self.m_dic objectForKey:@"areaIDTxt"],@"areaIDTxt",
                                  [self.m_dic objectForKey:@"districtIDTxt"],@"districtIDTxt",
                                  [self.m_dic objectForKey:@"address"],@"address",
                                  [self.m_dic objectForKey:@"peoperNumMin"],@"peoperNumMin",
                                  [self.m_dic objectForKey:@"peoperNumMax"],@"peoperNumMax",
                                  [self.m_dic objectForKey:@"ageMin"],@"ageMin",
                                  [self.m_dic objectForKey:@"ageMax"],@"ageMax",
                                  [self.m_dic objectForKey:@"sexTxt"],@"sexTxt",
                                  nil];
    
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"ActivityLifeAdd.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            [SVProgressHUD dismiss];
            
            // 赋值
            self.m_activityId = [NSString stringWithFormat:@"%@",[json valueForKey:@"ActivityId"]];
            
            // 进入上传海报的页面
            PosterViewController *VC = [[PosterViewController alloc]initWithNibName:@"PosterViewController" bundle:nil];
            VC.m_typeString = self.m_typeString;
            VC.m_activeId = [NSString stringWithFormat:@"%@",[json valueForKey:@"ActivityId"]];
            VC.m_posterList = self.m_postList;  //[self.m_dic objectForKey:@"PosterList"];
            [self.navigationController pushViewController:VC animated:YES];

            
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

- (void)activityRequestSubmit{
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
                                  [self.m_dic objectForKey:@"ActivityID"],@"actId",
                                  [self.m_dic objectForKey:@"mctId"],@"mctId",
                                  [self.m_dic objectForKey:@"operation"],@"operation",
                                  [self.m_dic objectForKey:@"classIDTxt"],@"classIDTxt",
                                  [self.m_dic objectForKey:@"activityName"],@"activityName",
                                  [self.m_dic objectForKey:@"summary"],@"summary",
                                  [self.m_dic objectForKey:@"content"],@"content",
                                  [self.m_dic objectForKey:@"explain"],@"explain",
                                  [self.m_dic objectForKey:@"originalPrice"],@"originalPrice",
                                  [self.m_dic objectForKey:@"price"],@"price",
                                  [self.m_dic objectForKey:@"brokerage"],@"brokerage",
                                  [self.m_dic objectForKey:@"keyVaildDateS"],@"keyVaildDateS",
                                  [self.m_dic objectForKey:@"keyVaildDateE"],@"keyVaildDateE",
                                  [self.m_dic objectForKey:@"isAnyTimeReturn"],@"isAnyTimeReturn",
                                  [self.m_dic objectForKey:@"isExpiredReturn"],@"isExpiredReturn",
                                  [self.m_dic objectForKey:@"isReservation"],@"isReservation",
                                  [self.m_dic objectForKey:@"regStopTime"],@"regStopTime",
                                  [self.m_dic objectForKey:@"actStartDate"],@"actStartDate",
                                  [self.m_dic objectForKey:@"actStartTime"],@"actStartTime",
                                  [self.m_dic objectForKey:@"actEndDate"],@"actEndDate",
                                  [self.m_dic objectForKey:@"actEndTime"],@"actEndTime",
                                  [self.m_dic objectForKey:@"cityIDTxt"],@"cityIDTxt",
                                  [self.m_dic objectForKey:@"areaIDTxt"],@"areaIDTxt",
                                  [self.m_dic objectForKey:@"districtIDTxt"],@"districtIDTxt",
                                  [self.m_dic objectForKey:@"address"],@"address",
                                  [self.m_dic objectForKey:@"peoperNumMin"],@"peoperNumMin",
                                  [self.m_dic objectForKey:@"peoperNumMax"],@"peoperNumMax",
                                  [self.m_dic objectForKey:@"ageMin"],@"ageMin",
                                  [self.m_dic objectForKey:@"ageMax"],@"ageMax",
                                  [self.m_dic objectForKey:@"sexTxt"],@"sexTxt",
                                  nil];
    
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"ActivityResAdd.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            [SVProgressHUD dismiss];
            
            // 赋值
            self.m_activityId = [NSString stringWithFormat:@"%@",[json valueForKey:@"ActivityId"]];

            // 进入上传海报的页面
            PosterViewController *VC = [[PosterViewController alloc]initWithNibName:@"PosterViewController" bundle:nil];
            VC.m_typeString = self.m_typeString;
            VC.m_activeId = [NSString stringWithFormat:@"%@",[json valueForKey:@"ActivityId"]];
            VC.m_posterList = self.m_postList;
            [self.navigationController pushViewController:VC animated:YES];
            
            
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

- (IBAction)chooseAddress:(id)sender {
    
    self.view.userInteractionEnabled = NO;

    // 选择地区
    
    [self.m_pickerView setHidden:NO];
    
    [self.m_pickerToolBar setHidden:NO];
    
    [self.m_pickerView reloadAllComponents];
    
}

#pragma 初始化pickerView
- (void)initWithPickerView{
    
    UIWindow *window = self.navigationController.view.window;
	//  datePickerView初始化
	m_datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 210, WindowSizeWidth, 200)];
    [m_datePicker setDatePickerMode:UIDatePickerModeDate];
	[m_datePicker addTarget:self action:@selector(togglePicker:) forControlEvents:UIControlEventValueChanged];
    m_datePicker.backgroundColor = [UIColor whiteColor];
    
	[window addSubview:m_datePicker];
    UIToolbar *pickerBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.m_datePicker.frame.origin.y - 44, WindowSizeWidth, 44)];
    pickerBar.barStyle = UIBarStyleBlackTranslucent;
    
    
    UIBarButtonItem *cancelBarButton = [[UIBarButtonItem alloc] initWithTitle:@"取消"
                                                                        style:UIBarButtonItemStylePlain
                                                                       target:self
                                                                       action:@selector(doPCAPickerCancel:)];
    cancelBarButton.style = UIBarButtonItemStyleBordered;
    
    UIBarButtonItem *spaceButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                    target:nil
                                                                                    action:nil];
    
    
    UIBarButtonItem *lastButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成"
                                                                       style:UIBarButtonItemStylePlain
                                                                      target:self
                                                                      action:@selector(doPCAPickerDone:)];
    lastButtonItem.style = UIBarButtonItemStyleBordered;
    
    NSArray *pickArray = [NSArray arrayWithObjects: cancelBarButton, spaceButtonItem, lastButtonItem, nil];
    [pickerBar setItems:pickArray animated:YES];
    [window addSubview:pickerBar];
    pickerBar.backgroundColor = [UIColor clearColor];
    self.m_toolbar = pickerBar;
    
    [window addSubview:self.m_toolbar];
}

- (void)initWithTimePickerView{
    
    UIWindow *window = self.navigationController.view.window;
	//  datePickerView初始化
	m_timePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 210, WindowSizeWidth, 200)];
    [m_timePicker setDatePickerMode:UIDatePickerModeTime];
	[m_timePicker addTarget:self action:@selector(TimetogglePicker:) forControlEvents:UIControlEventValueChanged];
    m_timePicker.backgroundColor = [UIColor whiteColor];
	[window addSubview:m_timePicker];
    UIToolbar *pickerBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.m_timePicker.frame.origin.y - 44, WindowSizeWidth, 44)];
    pickerBar.barStyle = UIBarStyleBlackTranslucent;
    
    
    UIBarButtonItem *cancelBarButton = [[UIBarButtonItem alloc] initWithTitle:@"取消"
                                                                        style:UIBarButtonItemStylePlain
                                                                       target:self
                                                                       action:@selector(doTimePickerCancel:)];
    cancelBarButton.style = UIBarButtonItemStyleBordered;
    
    UIBarButtonItem *spaceButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                    target:nil
                                                                                    action:nil];
    
    
    UIBarButtonItem *lastButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成"
                                                                       style:UIBarButtonItemStylePlain
                                                                      target:self
                                                                      action:@selector(doTimePickerDone:)];
    lastButtonItem.style = UIBarButtonItemStyleBordered;
    
    NSArray *pickArray = [NSArray arrayWithObjects: cancelBarButton, spaceButtonItem, lastButtonItem, nil];
    [pickerBar setItems:pickArray animated:YES];
    [window addSubview:pickerBar];
    pickerBar.backgroundColor = [UIColor clearColor];
    self.m_timeToolbar = pickerBar;
    
    [window addSubview:self.m_timeToolbar];
}

#pragma mark - PickerBar按钮
- (void)doPCAPickerDone:(id)sender{
    
    self.view.userInteractionEnabled = YES;

    
    [self.m_datePicker setHidden:YES];
    
    [self.m_toolbar setHidden:YES];

    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone systemTimeZone]];

    [formatter setDateFormat:@"yyy-MM-dd"];
    
    if ( [self.m_dateString isEqualToString:@"11"] ) {
        
        self.m_endDate.text = [formatter stringFromDate:m_datePicker.date];
        
        self.m_Deadline = m_datePicker.date;
        
    }else if ( [self.m_dateString isEqualToString:@"12"] ) {
        
        self.m_startDate.text = [formatter stringFromDate:m_datePicker.date];
        
        self.m_PartystartDate = m_datePicker.date;
        
    }else if ( [self.m_dateString isEqualToString:@"13"] ){
        
        self.m_stopDate.text = [formatter stringFromDate:m_datePicker.date];
        
        self.m_PartyEndDate = m_datePicker.date;
    }
    
    self.isSelected = NO;
    
}

- (void)doPCAPickerCancel:(id)sender{
    
    self.view.userInteractionEnabled = YES;

    [self.m_datePicker setHidden:YES];
    
    [self.m_toolbar setHidden:YES];
    
}

- (void)doTimePickerDone:(id)sender{
    
    self.view.userInteractionEnabled = YES;

    [self.m_timeToolbar setHidden:YES];
    
    [self.m_timePicker setHidden:YES];
    
    // 小时制的hh表示12小时制 HH表示24小时制
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone systemTimeZone]];

    [formatter setDateFormat:@"HH:mm:ss"];
    
    NSString *dateString = [formatter stringFromDate:m_timePicker.date];
    
    if ( [self.m_dateString isEqualToString:@"111"] ) {
        // 开始时间
        self.m_startTime.text = [NSString stringWithFormat:@"%@",dateString];
        
    }else if ( [self.m_dateString isEqualToString:@"222"] ){
        
        // 结束时间
        self.m_endTime.text = [NSString stringWithFormat:@"%@",dateString];

    }
    
}

- (void)doTimePickerCancel:(id)sender{
    
    self.view.userInteractionEnabled = YES;

    [self.m_timeToolbar setHidden:YES];
    
    [self.m_timePicker setHidden:YES];

    
}

// pickerView的选择事件
- (void) togglePicker:(id)sender{
    
    self.isSelected = YES;
    
}

- (void)TimetogglePicker:(id)sender{

    
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
    
    self.m_province.text = [NSString stringWithFormat:@"%@ %@ %@",self.m_cityString,self.m_areaString,self.m_addressString];
    
    self.m_cityId = [NSString stringWithFormat:@"%@",self.m_cityId1];

    self.m_cityId2 = [NSString stringWithFormat:@"%@",self.m_cityId1];

    self.m_areaId = [NSString stringWithFormat:@"%@",self.m_areaId1];
    
    self.m_areaId2 = [NSString stringWithFormat:@"%@",self.m_areaId1];
    
    self.m_districtId = [NSString stringWithFormat:@"%@",self.m_districtId1];
    
    self.m_districtId2 = [NSString stringWithFormat:@"%@",self.m_districtId1];
    
    
    self.isSelected = NO;
    
}

- (void)doPickerCancel:(id)sender{
    
    self.view.userInteractionEnabled = YES;

    self.m_pickerView.hidden = YES;
    
    self.m_pickerToolBar.hidden = YES;
    
    if ( self.isSelected ) {

    }
    
    
    self.m_cityId = [NSString stringWithFormat:@"%@",self.m_cityId2];
    self.m_areaId = [NSString stringWithFormat:@"%@",self.m_areaId2];
    self.m_districtId = [NSString stringWithFormat:@"%@",self.m_districtId2];
    
}

#pragma mark - UIPickerViewDelegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    if ( component == 0 ) {
        
        return self.m_cityArray.count;
        
    }else if ( component == 1 ){
        
        return self.m_areaArray.count;

    }else{
        
        return self.m_addressArray.count;
    }
    
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    NSString *titleResult = @"";
    
    if ( component == 0 ) {
        
        if ( self.m_cityArray.count > 0 ) {
            
            NSDictionary *dic = [self.m_cityArray objectAtIndex:row];
            
            titleResult = [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];
            
        }
        
    }else if ( component == 1 ){
        
        NSDictionary *dic = [self.m_areaArray objectAtIndex:row];
        
        titleResult = [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];
        
    }else if (component == 2 ){
        
        NSDictionary *dic = [self.m_addressArray objectAtIndex:row];
        
        titleResult = [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];
   
    }else{
        
        titleResult = @"";
        
    }
    

    
    return titleResult;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    self.isSelected = YES;
        
    if ( component == 0 ) {
        
        NSDictionary *dic = [self.m_cityArray objectAtIndex:row];
        
        self.m_cityString = [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];
        
        self.m_cityId1 = [NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        
        self.m_areaArray = [dbhelp queryMerchant:[dic objectForKey:@"code"]];

        NSDictionary *dic1 = [self.m_areaArray objectAtIndex:0];
        
        self.m_areaString = [NSString stringWithFormat:@"%@",[dic1 objectForKey:@"name"]];
        
        self.m_areaId1 = [NSString stringWithFormat:@"%@",[dic1 objectForKey:@"code"]];
        
        // 刷新选择器
        [self.m_pickerView selectRow:0 inComponent:1 animated:YES];
        
    }else if ( component == 1 ){
        
        NSDictionary *dic = [self.m_areaArray objectAtIndex:row];
        
        self.m_addressArray = [dbhelp queryArea:[dic objectForKey:@"code"]];
       
        NSDictionary *dic1 = [self.m_addressArray objectAtIndex:0];
        
        self.m_areaString = [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];
       
        self.m_areaId1 = [NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];

        self.m_addressString = [NSString stringWithFormat:@"%@",[dic1 objectForKey:@"name"]];
        
        self.m_districtId1 = [NSString stringWithFormat:@"%@",[dic1 objectForKey:@"code"]];

        
        // 刷新选择器
        [self.m_pickerView selectRow:0 inComponent:2 animated:YES];

    }else{
        
         NSDictionary *dic = [self.m_addressArray objectAtIndex:row];
        
        self.m_addressString = [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];
    
        self.m_districtId1 = [NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];

    }

    
    for (int i=0; i<[pickerView numberOfComponents]; i++) {
        
        [self.m_pickerView reloadComponent:i];
        
    }
    
}


#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if ( buttonIndex == 0 ) {
        
        self.m_sex.text = @"不限男女";
        
    }else if ( buttonIndex == 1 ){
        
        self.m_sex.text = @"男";

    }else if ( buttonIndex == 2 ){
        
        self.m_sex.text = @"女";

    }else{
        
        
    }
    
    
}

#pragma mark - UITextDieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    if ( textField == self.m_minCount || textField == self.m_maxCount || textField == self.m_minAge || textField == self.m_maxAge ) {
        
        [self showNumPadDone:nil];
        
    }else{
        
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

@end
