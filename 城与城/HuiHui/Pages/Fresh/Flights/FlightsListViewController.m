//
//  FlightsListViewController.m
//  HuiHui
//
//  Created by mac on 14-12-10.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "FlightsListViewController.h"

#import "FlightsDetailCell.h"

#import "FlightsDetailViewController.h"

#import "CommonUtil.h"

#import "CalendarHomeViewController.h"

#import "CalendarViewController.h"


@interface FlightsListViewController (){
    
    CalendarHomeViewController *chvc;

}

@property (weak, nonatomic) IBOutlet UITableView *m_tableView;

@property (weak, nonatomic) IBOutlet UILabel *m_emptyLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_currentDate;

@property (weak, nonatomic) IBOutlet UIButton *m_lastDate;

@property (weak, nonatomic) IBOutlet UIButton *m_afterDate;

// 前一天按钮触发的事件
- (IBAction)lastDateClicked:(id)sender;
// 后一天按钮触发的事件
- (IBAction)afterDateClicked:(id)sender;

// 点击显示当前日期的位置时跳转到日期选择的页面
- (IBAction)dateChooseClicked:(id)sender;

@end

@implementation FlightsListViewController

@synthesize m_dictionary;

@synthesize m_list;

@synthesize m_currentDateString;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        
        m_dictionary = [[NSMutableDictionary alloc]initWithCapacity:0];
        
        m_list = [[NSMutableArray alloc]initWithCapacity:0];
        
        m_index = 1;
        
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // 设置导航栏的标题
    NSString *string = [NSString stringWithFormat:@"%@→%@",[self.m_dictionary objectForKey:@"currentCityKey"],[self.m_dictionary objectForKey:@"arrivalCityKey"]];
    
    [self setTitle:string];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftCilcked)];
    
   
    // 默认隐藏label
    self.m_tableView.hidden = YES;
    self.m_emptyLabel.hidden = YES;
    
    // 赋值
    self.m_currentDateString = [NSString stringWithFormat:@"%@",[self.m_dictionary objectForKey:@"currentDateKey"]];
    
    // 根据日期字符转换成NSDate
    NSDate *currentDate = [self dateWithString:self.m_currentDateString];

    // 根据当前搜索的日期计算出前一天和后一天的时间
    [self setBeforeDate:currentDate];
   
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)leftCilcked{
    
    [self goBack];
}

#pragma mark- BtnClick
- (IBAction)lastDateClicked:(id)sender {
    
    NSDate *currentDate = [self dateWithString:self.m_currentDateString];
    
    NSDate *nowDate = [NSDate date];
    
    NSString *string = [self stringWithDate:nowDate];
    
    
    NSLog(@"nowDate = %@,date = %@",string,self.m_currentDateString);
    // 判断当前时间和今天的时间进行比较
    if ( [string isEqualToString:self.m_currentDateString] ) {
        
        [SVProgressHUD showErrorWithStatus:@"不能查询晚于今天的信息"];
        
        return;
    }
    
    // 点击后一天的按钮后当前的时间变成后一天的日期
    NSDate *beforeDate = [currentDate dateByAddingTimeInterval:-(86400 * m_index)];
    // 重新赋值
    NSString *strday = [self stringWithDate:beforeDate];
    // 记录当前的日期值
    self.m_currentDateString = strday;
    
    // 重新设置前一天和后一天的日期
    [self setBeforeDate:beforeDate];
    
}

- (IBAction)afterDateClicked:(id)sender {
    
    NSDate *currentDate = [self dateWithString:self.m_currentDateString];
    
    // 点击后一天的按钮后当前的时间变成后一天的日期
    NSDate *afterDate = [currentDate dateByAddingTimeInterval:+(86400 * m_index)];
    // 重新赋值
    NSString *strday = [self stringWithDate:afterDate];
    // 记录当前的日期值
    self.m_currentDateString = strday;
   
    // 重新设置前一天和后一天的日期
    [self setBeforeDate:afterDate];
    
}

- (IBAction)dateChooseClicked:(id)sender {
    
    // 计算当年的所有天数
    int count = [self getNumberOfDaysOneYear];
    
    if (!chvc) {
        
        chvc = [[CalendarHomeViewController alloc]init];
        
        chvc.calendartitle = @"日期选择";
        
        //飞机初始化方法
        [chvc setAirPlaneToDay:count ToDateforString:nil];
        
    }
    
    chvc.calendarblock = ^(CalendarDayModel *model){
        
        //        NSLog(@"\n---------------------------");
        //        NSLog(@"1星期 %@",[model getWeek]);
        //        NSLog(@"2字符串 %@",[model toString]);
        //        NSLog(@"3节日  %@",model.holiday);
        
        // 选择完日期后返回进行数据的刷新和赋值
        if ( ![[model toString] isEqualToString:self.m_currentDateString] ) {
            // 如果选择的日期与当前的日期相同时则不刷新列表、不进行赋值,否则进行刷新列表与赋值
            self.m_currentDateString = [NSString stringWithFormat:@"%@",[model toString]];
            
            // 根据日期字符转换成NSDate
            NSDate *currentDate = [self dateWithString:self.m_currentDateString];
            
            // 根据当前搜索的日期计算出前一天和后一天的时间
            [self setBeforeDate:currentDate];
        }
      
    };
    
    [self.navigationController pushViewController:chvc animated:YES];

}

#pragma mark - 设置日期转换
- (void)setBeforeDate:(NSDate *)currentDate{
    
    // 设置当前日期
    self.m_currentDate.text = [NSString stringWithFormat:@"%@ %@",self.m_currentDateString,[self getWeekday:currentDate]];
    
    // 设置后一天的日期
    NSDate *afterDate = [currentDate dateByAddingTimeInterval:+(86400 * m_index)];
    
    NSString *strday = [self stringWithDate:afterDate];
    
    NSString *afterString = [NSString stringWithFormat:@"%@ %@",strday,[self getWeekday:afterDate]];
    
    [self.m_afterDate setTitle:afterString forState:UIControlStateNormal];
    
    // 设置前一天的日期
    NSDate *beforeDate = [currentDate dateByAddingTimeInterval:-(86400 * m_index)];
    
    NSString *dateStirng = [self stringWithDate:beforeDate];
    
    NSString *beforeString = [NSString stringWithFormat:@"%@ %@",dateStirng,[self getWeekday:beforeDate]];
    
    [self.m_lastDate setTitle:beforeString forState:UIControlStateNormal];
    
    
    // 请求数据
    [self requestSubmit];

}

// 将字符日期转换成NSDate
- (NSDate *)dateWithString:(NSString *)aDateString{
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
    [formatter1 setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [formatter1 dateFromString:aDateString];
    
    return date;
}
// 将NSDate日期转换成字符
- (NSString *)stringWithDate:(NSDate *)aDate{
    
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [formatter stringFromDate:aDate];
    
    return dateString;
}

#pragma mark - UINetWorking 请求数据
- (void)requestSubmit{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    // 获取memberId
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient1];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           [NSString stringWithFormat:@"%@",[self.m_dictionary objectForKey:@"currentCityKey"]], @"dptCity",
                           [NSString stringWithFormat:@"%@",[self.m_dictionary objectForKey:@"arrivalCityKey"]],@"arrCity",
                           [NSString stringWithFormat:@"%@",self.m_currentDateString],@"dptDate",
                           memberId,@"memberId",
                           nil];
    [SVProgressHUD showWithStatus:@"数据加载中"];
        
    [httpClient requestFlights:@"QunarQbSearch.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        // status 0表示有数据 其他表示错误
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if ( success ) {
            
            [SVProgressHUD dismiss];
            
            // 赋值
            self.m_list = [json valueForKey:@"liebiao"];
            
            if ( self.m_list.count != 0 ) {
                
                self.m_tableView.hidden = NO;
                
                self.m_emptyLabel.hidden = YES;
                
                // 刷新列表
                [self.m_tableView reloadData];
                
            }else{
                
                // 没有数据的情况下
                self.m_tableView.hidden = YES;
                
                self.m_emptyLabel.hidden = NO;
                
                self.m_emptyLabel.text = @"没有搜索结果";
            }
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
            
            self.m_tableView.hidden = YES;
            
            self.m_emptyLabel.hidden = NO;
            
            self.m_emptyLabel.text = [NSString stringWithFormat:@"%@",msg];
        }
    } failure:^(NSError *error) {
        NSLog(@"failed:%@", error);
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.m_list.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"FlightsDetailCellIdentifier";
    
    FlightsDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"FlightsDetailCell" owner:self options:nil];
        
        cell = (FlightsDetailCell *)[nib objectAtIndex:0];
        
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
        // cell上面右边的箭头提示
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    
       

    }
    
    if ( self.m_list.count != 0 ) {
        
        NSDictionary *dic = [self.m_list objectAtIndex:indexPath.row];
        
        
        // 赋值
        cell.m_dptTime.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"dptTime"]];
        
        cell.m_arrTime.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"arrTime"]];
        
        cell.m_dptCity.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"dptCodeName"]];
        
        cell.m_arrCity.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"arrCodeName"]];
        
        cell.m_price.text = [NSString stringWithFormat:@"￥%@",[dic objectForKey:@"lowestPrice"]];
        
        // 判断折扣的，大于10表示原价，小于10表示是经济舱打几折
        NSString *discount = [NSString stringWithFormat:@"%@",[dic objectForKey:@"lowestDiscount"]];
        
        if ( [discount floatValue] < 10.00 ) {
            
            cell.m_discount.text = [NSString stringWithFormat:@"经济舱%@折",discount];

        }else{
            
            cell.m_discount.text = @"";
        }
        
        
        cell.m_airName.text = [NSString stringWithFormat:@"%@%@",[dic objectForKey:@"airlineCompany"],[dic objectForKey:@"flightNum"]];
        
        
    }
    
    // 设置分割线的坐标
//    cell.m_lineimagV.frame = CGRectMake(10, 84, 310, 0.4); //CGRectMake(10, cell.m_lineimagV.frame.origin.y, cell.m_lineimagV.frame.size.width, 0.4);
    
    return cell;
    
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 85.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSMutableDictionary *dic = [self.m_list objectAtIndex:indexPath.row];
    
    // 进入机票详情的页面
    FlightsDetailViewController *VC = [[FlightsDetailViewController alloc]initWithNibName:@"FlightsDetailViewController" bundle:nil];
    VC.m_dic = dic;
    
    [self.navigationController pushViewController:VC animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


@end
