//
//  SceneryOrderformViewController.m
//  HuiHui
//
//  Created by mac on 15-1-28.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "SceneryOrderformViewController.h"

#import "CommonUtil.h"

#import "SceneryOrderListViewController.h"

#import "SceneryTravellerCell.h"

#import "CalendarSceneryHomeViewController.h"

#import "CalendarSceneryViewController.h"

@interface SceneryOrderformViewController (){
    
    CalendarSceneryHomeViewController *chvc;

}

@property (weak, nonatomic) IBOutlet UILabel *m_sceneryName;

@property (weak, nonatomic) IBOutlet UILabel *m_price;

@property (weak, nonatomic) IBOutlet UILabel *m_date;

@property (weak, nonatomic) IBOutlet UILabel *m_count;

@property (weak, nonatomic) IBOutlet UIButton *m_minusBtn;

@property (weak, nonatomic) IBOutlet UIButton *m_plusBtn;

@property (weak, nonatomic) IBOutlet UIView *m_peopleView;

@property (weak, nonatomic) IBOutlet UILabel *m_name;

@property (weak, nonatomic) IBOutlet UILabel *m_cardId;

@property (weak, nonatomic) IBOutlet UILabel *m_cardkey;

@property (weak, nonatomic) IBOutlet UIScrollView *m_scrollerView;

@property (weak, nonatomic) IBOutlet UILabel *m_totalPrice;

@property (weak, nonatomic) IBOutlet UIButton *m_resertBtn;

@property (weak, nonatomic) IBOutlet UITableView *m_tableView;

// 选择出行日期
- (IBAction)chooseOutDate:(id)sender;
// 减按钮触发的事件
- (IBAction)m_minusClicked:(id)sender;
// 加按钮触发的事件
- (IBAction)m_plusClicked:(id)sender;
// 选择出行人的按钮触发的事件
- (IBAction)chooseOutPeople:(id)sender;
// 下单按钮触发的事件
- (IBAction)submitOrder:(id)sender;

@end

@implementation SceneryOrderformViewController

@synthesize m_dic;

@synthesize realNameOrUseCard;

@synthesize m_sceneryId;

@synthesize m_travellerList;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        m_dic = [[NSMutableDictionary alloc]initWithCapacity:0];
        
        m_sceneryIndex = 1;
        
        m_travellerList = [[NSMutableArray alloc]initWithCapacity:0];
        
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"订单填写"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];

    [self.m_scrollerView setContentSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, self.m_scrollerView.frame.size.height)];

    self.m_tableView.hidden = YES;
    
    self.m_tableView.scrollEnabled = NO;
    
    // 将tableView的分割线去掉
    [self setExtraCellLineHidden:self.m_tableView];
    
    // 默认隐藏出行人的信息
    self.m_peopleView.hidden = YES;
    self.m_resertBtn.layer.cornerRadius = 5.0f;
    self.m_count.layer.borderWidth = 1.0;
    self.m_count.layer.borderColor = [UIColor colorWithRed:215/255.0 green:215/255.0 blue:215/255.0 alpha:1.0].CGColor;
    
    // 日期赋值
//    NSString *dateString = [self stringWithDateFromScenery:[NSDate date]];
    
//   self.m_date.text = [NSString stringWithFormat:@"%@",dateString];
    
    self.m_name.text = @"";
    self.m_cardId.text = @"";
    
    
    // 赋值刷新数据
    [self refreshData];
    

    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)leftClicked{
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示"
                                                       message:@"订单正在填写，您确定离开吗？"
                                                      delegate:self
                                             cancelButtonTitle:@"继续填写"
                                             otherButtonTitles:@"离开" , nil];
    alertView.tag = 10324;
    [alertView show];
    
}

// 刷新数据
- (void)refreshData{
    
    // 赋值
    self.m_sceneryName.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"policyName"]];
    
    // 赋值
    m_sceneryIndex = [[self.m_dic objectForKey:@"minT"]intValue];
    
    self.m_count.text = [NSString stringWithFormat:@"%i",m_sceneryIndex];
    
    self.m_price.text = [NSString stringWithFormat:@"￥%@",[self.m_dic objectForKey:@"tcPrice"]];
    
    self.m_totalPrice.text = [NSString stringWithFormat:@"￥%i",([[self.m_dic objectForKey:@"tcPrice"] intValue] * m_sceneryIndex)];
    
    // 计算出是实名制还是身份证的类型
    self.realNameOrUseCard = [self RealNameOrUseCard];
    
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if ( alertView.tag == 10324 ) {
        
        if ( buttonIndex == 1 ) {
            
            [self goBack];
            
        }
    }else if ( alertView.tag == 111094){
        
        if ( buttonIndex == 0 ) {
            // 继续预订
            [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:2] animated:YES];
            
        }else{
            
            // 查看订单
            SceneryOrderListViewController *VC = [[SceneryOrderListViewController alloc]initWithNibName:@"SceneryOrderListViewController" bundle:nil];
            VC.m_stringType = @"2";
            [self.navigationController pushViewController:VC animated:YES];
            
        }
        
    }
    
}


- (IBAction)chooseOutDate:(id)sender {
    
    // 计算当年的所有天数
    int count = [self getNumberOfDaysCurrentMonth];//[self getNumberOfDaysOneYear];
    
    if (!chvc) {
        
        chvc = [[CalendarSceneryHomeViewController alloc]init];
        chvc.m_policyId = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"policyId"]];
        chvc.calendartitle = @"选择出行日期";
        
        // 计算出是当前的第几个月
        NSCalendar *calendar = [NSCalendar currentCalendar];
        
        NSDate *date = [NSDate date];
        
        NSDateComponents *comps = [calendar components:(NSYearCalendarUnit |
                                                        NSMonthCalendarUnit |
                                                        NSDayCalendarUnit |
                                                        NSWeekdayCalendarUnit) fromDate:date];
       
        chvc.m_month = comps.day;
        
        // 根据当前的日期转换成字符传递
        NSString *dateStr = [self stringWithDateFromScenery:[NSDate date]];
        
        //飞机初始化方法
        [chvc setSceneryToDay:count ToDateforString:dateStr];
        
    }
    
    chvc.calendarblock = ^(CalendarDayModel *model){
        
        //        NSLog(@"\n---------------------------");
        //        NSLog(@"1星期 %@",[model getWeek]);
        //        NSLog(@"2字符串 %@",[model toString]);
        //        NSLog(@"3节日  %@",model.holiday);
        
        NSString *stirng = [NSString stringWithFormat:@"%@ %@",[model toString],[model getWeek]];
        
        NSLog(@"string = %@",stirng);
        
        // 赋值
//        self.m_date.text = [NSString stringWithFormat:@"%@ %@",[model toString],[model getWeek]];

        
        self.m_date.text = [NSString stringWithFormat:@"%@",[model toString]];

        
        
    };
    
    [self.navigationController pushViewController:chvc animated:YES];

    
    
}

- (IBAction)m_minusClicked:(id)sender {
    
    m_sceneryIndex --;
    
    NSString *min = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"minT"]];

    
    // 必须要选择一张票
    if ( m_sceneryIndex < [min intValue] ) {
        
        m_sceneryIndex = [min intValue];
        
        [self alertWithMessage:[NSString stringWithFormat:@"至少选择%@张票",min]];
        
        [self.m_minusBtn setBackgroundImage:[UIImage imageNamed:@"ic_minus_disable.png"] forState:UIControlStateNormal];
        [self.m_plusBtn setBackgroundImage:[UIImage imageNamed:@"ic_plus_normal.png"] forState:UIControlStateNormal];
        
    }else if ( m_sceneryIndex == [min intValue] ){
        
        [self.m_minusBtn setBackgroundImage:[UIImage imageNamed:@"ic_minus_disable.png"] forState:UIControlStateNormal];
        [self.m_plusBtn setBackgroundImage:[UIImage imageNamed:@"ic_plus_normal.png"] forState:UIControlStateNormal];
        
    }else{
       
        [self.m_minusBtn setBackgroundImage:[UIImage imageNamed:@"ic_minus_normal.png"] forState:UIControlStateNormal];
        [self.m_plusBtn setBackgroundImage:[UIImage imageNamed:@"ic_plus_normal.png"] forState:UIControlStateNormal];
        
    }
    
    
    // 赋值
    self.m_count.text = [NSString stringWithFormat:@"%i",m_sceneryIndex];
    
    self.m_totalPrice.text = [NSString stringWithFormat:@"￥%i",([[self.m_dic objectForKey:@"tcPrice"] intValue] * m_sceneryIndex)];

    
    
}

- (IBAction)m_plusClicked:(id)sender {
    
    m_sceneryIndex ++;
    
    NSString *max = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"maxT"]];
    
    // 和预订的最大票数进行比较
    if ( m_sceneryIndex > [max intValue] ) {
        
        m_sceneryIndex = [max intValue];
        
        [self.m_minusBtn setBackgroundImage:[UIImage imageNamed:@"ic_minus_normal.png"] forState:UIControlStateNormal];
        [self.m_plusBtn setBackgroundImage:[UIImage imageNamed:@"ic_plus_disable.png"] forState:UIControlStateNormal];
        
         [self alertWithMessage:[NSString stringWithFormat:@"最多只能选择%@张票",max]];
        
    }else if ( m_sceneryIndex == [max intValue] ) {
        
        [self.m_minusBtn setBackgroundImage:[UIImage imageNamed:@"ic_minus_normal.png"] forState:UIControlStateNormal];
        [self.m_plusBtn setBackgroundImage:[UIImage imageNamed:@"ic_plus_disable.png"] forState:UIControlStateNormal];
        
    }else{
        
        [self.m_minusBtn setBackgroundImage:[UIImage imageNamed:@"ic_minus_normal.png"] forState:UIControlStateNormal];
        [self.m_plusBtn setBackgroundImage:[UIImage imageNamed:@"ic_plus_normal.png"] forState:UIControlStateNormal];
    }
    
    
    // 赋值
    self.m_count.text = [NSString stringWithFormat:@"%i",m_sceneryIndex];
    
    self.m_totalPrice.text = [NSString stringWithFormat:@"￥%i",([[self.m_dic objectForKey:@"tcPrice"] intValue] * m_sceneryIndex)];
    
}

- (IBAction)chooseOutPeople:(id)sender {
    
    // 进入选择出行人列表的页面
    SceneryOutListViewController *VC = [SceneryOutListViewController shareobject];//[[SceneryOutListViewController alloc]initWithNibName:@"SceneryOutListViewController" bundle:nil];
    VC.realNameIndex = self.realNameOrUseCard;
    VC.m_count = m_sceneryIndex;
    VC.delegate = self;
    [self.navigationController pushViewController:VC animated:YES];
    
}

- (IBAction)submitOrder:(id)sender {
    
    if ( [self.m_date.text isEqualToString:@"请选择出行日期"] ) {
        
        [SVProgressHUD showErrorWithStatus:@"请选择出行日期"];
        
        return;
    }
    
    if ( self.m_travellerList.count == 0 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请填写出行人信息"];
        
        return;
    
    }

    // 请求预订的接口
    [self submitOrderRequest];
    
}

// 请求立即预订的接口
- (void)submitOrderRequest{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
 
//    景区ID（是）：<input type="text" name="sceneryId" value="3440"/><br />
//    预订人（是）：<input type="text" name="bMan" value="peter"/><br />
//    预订人手机（是）：<input type="text" name="bMobile" value="18550037019"/><br />
//    预订人地址：<input type="text" name="bAddress" value="1"/><br />
//    预订人邮编：<input type="text" name="bPostCode" value="1"/><br />
//    预订人邮箱：<input type="text" name="bEmail" value="1"/><br />
//    取票人姓名（是）：<input type="text" name="tName" value="peter2"/><br />
//    取票人手机（是）：<input type="text" name="tMobile" value="18550037012"/><br />
//    政策ID（是）：<input type="text" name="policyId" value="24117"/><br />
//    预订票数（是）：<input type="text" name="tickets" value="1"/><br />
//    旅游日期（是）：<input type="text" name="travelDate" value="2015-01-30"/><br />
//    预订人IP（是）：<input type="text" name="orderIP" value=""/><br />
//    二代身份证：<input type="text" name="idCard" value="321081199007015139"/><br />
//    游玩人姓名：<input type="text" name="gName" value=""/><br />
//    游玩人手机：<input type="text" name="gMobile" value=""/><br />
//    会员Id（必传）：<input type="text" name="memberId" value="7923"/><br />
//    景点名称（必传）：<input type="text" name="sceneryName" value="哈哈哈"/><br />
//    景点价格（必传）：<input type="text" name="adviceAmount" value="222"/><br />
    
    NSString *cardNum = @"";
    NSString *name = @"";
    NSString *phone = @"";
    
    if ( self.m_travellerList.count != 0 ) {
        
        NSDictionary *dic = [self.m_travellerList objectAtIndex:0];
        
        cardNum = [NSString stringWithFormat:@"%@",[dic objectForKey:@"CardNum"]];

        name = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Name"]];

        phone = [NSString stringWithFormat:@"%@",[dic objectForKey:@"MobilePhone"]];

    
        if ( cardNum.length == 0 || [cardNum isEqualToString:@"(null)"] ) {
            
            cardNum = @"";
            
        }
        
        
        
    }
    
    
    // 获取memberId
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    AppHttpClient* httpClient = [AppHttpClient scenerySharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"memberId",
                           [NSString stringWithFormat:@"%@",self.m_sceneryId],@"sceneryId",
                           
                           [NSString stringWithFormat:@"%@",name],@"bMan",
                           [NSString stringWithFormat:@"%@",phone],@"bMobile",
                          
                           @"",@"bAddress",
                           @"",@"bPostCode",
                           @"",@"bEmail",
                           
                           [NSString stringWithFormat:@"%@",name],@"tName",
                           [NSString stringWithFormat:@"%@",phone],@"tMobile",
                           
                           [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"policyId"]],@"policyId",
                           
                           [NSString stringWithFormat:@"%i",m_sceneryIndex],@"tickets",
                           
                           [NSString stringWithFormat:@"%@",self.m_date.text],@"travelDate",
                           
                           @"",@"orderIP",
                           [NSString stringWithFormat:@"%@",cardNum],@"idCard",
                           
                           [NSString stringWithFormat:@"%@",name],@"gName",
                           [NSString stringWithFormat:@"%@",phone],@"gMobile",

                           [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"policyName"]],@"sceneryName",
                           
                           [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"tcPrice"]],@"adviceAmount",
                           
                           nil];
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    NSLog(@"parma = %@",param);
    
    [httpClient requestScenery:@"Scenery/SubmitSceneryOrder.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        // status 0表示有数据 其他表示错误
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        NSLog(@"json =%@",json);
        
        if ( success ) {
            
            [SVProgressHUD dismiss];
            
            NSString *msg = [json valueForKey:@"msg"];
            
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@""
                                                               message:msg
                                                              delegate:self
                                                     cancelButtonTitle:@"继续预订"
                                                     otherButtonTitles:@"查看订单", nil];
            alertView.tag = 111094;
            [alertView show];
            
            
        } else {
            
            
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
        
        
    } failure:^(NSError *error) {
        
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];

}

// 实名制和身份证两个的综合类型
- (int)RealNameOrUseCard{
    
    NSString *realName = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"realName"]];
    
    NSString *useCard = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"useCard"]];
    
    if ( [realName isEqualToString:@"1"] && [useCard isEqualToString:@"1"] ) {
        // 是实名制，又是身份证的    要填写取票人的姓名、手机号和身份证（多个）
        return 1;
        
    }else if ( [realName isEqualToString:@"0"] && [useCard isEqualToString:@"1"] ) {
        
        // 不是实名制，是身份证的     要填写取票人的姓名、手机号和身份证（1个）
        return 2;
        
    }else if ( [realName isEqualToString:@"1"] && [useCard isEqualToString:@"0"] ) {
        
        // 是实名制，不是身份证的    要填写每个取票人的姓名和手机号（多个）
        return 3;
        
    }else{
        
        // 不是实名制，不是身份证的 只填写  取票人的姓名和手机号（1个）
        return 4;
    }
    
}

#pragma mark - SceneryTraveller
- (void)SceneryTraveller:(NSMutableArray *)arr{
    
    self.m_travellerList = arr;
    
    self.m_tableView.frame = CGRectMake(self.m_tableView.frame.origin.x, self.m_tableView.frame.origin.y, self.m_tableView.frame.size.width, 53 * self.m_travellerList.count);
    
    [self.m_scrollerView setContentSize:CGSizeMake(self.m_scrollerView.frame.size.width, 53 * self.m_travellerList.count + 300)];
    
    self.m_tableView.hidden = NO;
    
    // 刷新列表
    [self.m_tableView reloadData];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.m_travellerList.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *cellIdentifier = @"SceneryTravellerCellIdentifier";
    
    SceneryTravellerCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"SceneryTravellerCell" owner:self options:nil];
        
        cell = (SceneryTravellerCell *)[nib objectAtIndex:0];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
    }
    
    
    if ( self.m_travellerList.count != 0 ) {
        
        NSDictionary *dic = [self.m_travellerList objectAtIndex:indexPath.row];
        
        cell.m_name.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Name"]];
        
        if ( realNameOrUseCard == 1 || realNameOrUseCard == 2 ) {
            // 显示身份证和姓名信息 赋值
            
            cell.m_cardKey.text = @"身份证：";
            
            cell.m_cardId.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"CardNum"]];
            
        }else{
            
            cell.m_cardKey.text = @"手机号：";
            
            cell.m_cardId.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"MobilePhone"]];
            
        }
   
    }
    
    return cell;

}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 53.0f;
}

@end
