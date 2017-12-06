//
//  CalendarSceneryHomeViewController.m
//  CandalDemo
//
//  Created by mac on 15-2-3.
//  Copyright (c) 2015年 WJL. All rights reserved.
//

#import "CalendarSceneryHomeViewController.h"

#import "Color.h"

#import "CalendarSceneryLogic.h"

@interface CalendarSceneryHomeViewController ()
{
    
    
    int daynumber;//天数
    int optiondaynumber;//选择日期数量
    //    NSMutableArray *optiondayarray;//存放选择好的日期对象数组
    
    int sumDays;

    
}

@end

@implementation CalendarSceneryHomeViewController

@synthesize m_priceList;

@synthesize m_policyId;

- (id)init{
    
    self = [super init];
    
    if (self) {
        // Custom initialization
        
        m_priceList = [[NSMutableArray alloc]initWithCapacity:0];

        sumDays = 0;
        
    }
    return self;
    

}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    m_index = 0;

    [self setRightButtonWithTitle:@"更多日期" action:@selector(rightClicked)];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)rightClicked{
    
    self.m_month ++;
    
    m_index ++;
    
    // 获取下个月的天数
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDate *date = [NSDate date];
    
    NSDate *firstDate = [date firstDayOfCurrentMonth];
    
    NSDate *afterDate = [firstDate dayInTheFollowingDay:daynumber];//计算它days天以后的时间

    NSString *afterString = [self stringWithDateFromScenery:afterDate];
    
    NSDateComponents *comps = [calendar components:(NSYearCalendarUnit |
                                                    NSMonthCalendarUnit |
                                                    NSDayCalendarUnit |
                                                    NSWeekdayCalendarUnit) fromDate:afterDate];

    // 计算某个月的天数
    NSRange range = [calendar rangeOfUnit:NSDayCalendarUnit
                                   inUnit: NSMonthCalendarUnit
                                  forDate: [calendar dateFromComponents:comps]];

    sumDays = sumDays + range.length;
    
    // 请求日历价格的数据
    [self datePriceRequest:sumDays ToDateforString:afterString];
    
    // 最多显示后两个月的数据
    if ( m_index >= 2 ) {
        
        self.navigationItem.rightBarButtonItem = nil;
        
        return;
        
    }else{
        
        
    }
}

//计算这个月最开始的一天
- (NSDate *)firstDayOfCurrentMonth
{
    NSDate *startDate = nil;
    BOOL ok = [[NSCalendar currentCalendar] rangeOfUnit:NSMonthCalendarUnit startDate:&startDate interval:NULL forDate:self];
    NSAssert1(ok, @"Failed to calculate the first day of the month based on %@", self);
    return startDate;
}

#pragma mark - 设置方法
// 景区初始化方法
- (void)setSceneryToDay:(int)day ToDateforString:(NSString *)todate
{
    sumDays = day;
    
    // 请求日历价格的数据
    [self datePriceRequest:(int)day ToDateforString:todate];
    
   
}

#pragma mark - 逻辑代码初始化

//获取时间段内的天数数组
- (NSMutableArray *)getMonthArrayOfDayNumber:(int)day ToDateforString:(NSString *)todate
{
    
    NSDate *date = [NSDate date];
    
    NSDate *selectdate  = [NSDate date];
    
    if (todate) {
        
        selectdate = [selectdate dateFromString:todate];
        
    }
    
    super.Logic = [[CalendarSceneryLogic alloc]init];
    
    return [super.Logic reloadCalendarView:date selectDate:selectdate  needDays:day withArray:self.m_priceList];
    
    
}

// 获取当前日期之后的几个天
- (NSDate *)dayInTheFollowingDay:(int)day
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.day = day;
    return [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
}

#pragma mark - 设置标题

- (void)setCalendartitle:(NSString *)calendartitle
{
    
    //    [self.navigationItem setTitle:calendartitle];
    
    [self setTitle:calendartitle];
    
}

// 获取当月的数据
- (int)getNumberOfDaysMonth:(NSString *)aDate{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDate *date = [self dateWithstringFromScenery:aDate];
    
    NSDateComponents *comps = [calendar components:(NSYearCalendarUnit |
                                                    NSMonthCalendarUnit |
                                                    NSDayCalendarUnit |
                                                    NSWeekdayCalendarUnit) fromDate:date];
    
    NSRange range = [calendar rangeOfUnit:NSDayCalendarUnit
                                   inUnit: NSMonthCalendarUnit
                                  forDate: [calendar dateFromComponents:comps]];
    
    
    return range.length;
    
}

// 请求日历价格的数据
- (void)datePriceRequest:(int)day ToDateforString:(NSString *)todate{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    // 获取memberId
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    AppHttpClient* httpClient = [AppHttpClient scenerySharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"memberId",
                           [NSString stringWithFormat:@"%@",self.m_policyId],@"policyId",
                           [NSString stringWithFormat:@"%@",todate],@"startDate",
                           @"",@"endDate",
                           @"",@"isAutoShowPrice",
                           
                           nil];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    [httpClient requestScenery:@"Scenery/GetPriceCalendar.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        // status 0表示有数据 其他表示错误
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if ( success ) {
            
            [SVProgressHUD dismiss];
            
            NSMutableArray *arr = [json valueForKey:@"calendar"];
            
            int count = [self getNumberOfDaysMonth:todate];
            
            if ( arr.count != 0 ) {
                
                NSMutableArray *dayArr = [[NSMutableArray alloc]initWithCapacity:0];
                
                for (int i = 0; i < arr.count; i++) {
                    
                    NSDictionary *dic = [arr objectAtIndex:i];
                    
                    NSString *dateString = [NSString stringWithFormat:@"%@",[dic objectForKey:@"date"]];

                    NSString *priceString = [NSString stringWithFormat:@"%@",[dic objectForKey:@"tcPrice"]];
                    
                    NSString *dayString = [NSString stringWithFormat:@"%@",[dic objectForKey:@"day"]];
                    
                    
                    [dayArr addObject:dayString];
                    
                }
                
                
                NSMutableArray *l_priceArr = [[NSMutableArray alloc]initWithCapacity:0];
                
                for (int i = 1; i < count + 1; i++) {
                    
                    NSString *string = [NSString stringWithFormat:@"%i",i];
                    
                    if ( [dayArr containsObject:string] ) {
                        
                        NSInteger index = [dayArr indexOfObject:string];
                        
                        NSDictionary *dic = [arr objectAtIndex:index];
                        
                        [l_priceArr addObject:dic];
                        
                    }else{
                        
                        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"0",@"tcPrice", nil];
                        
                        [l_priceArr addObject:dic];

                    }
                    
                }
                
                
                [self.m_priceList addObject:l_priceArr];
                
                daynumber = day;
                optiondaynumber = 1;//选择一个后返回数据对象
                super.calendarMonth = [self getMonthArrayOfDayNumber:daynumber ToDateforString:todate];
                
                [super.collectionView reloadData];//刷新

            }else{
                
                [self alertWithMessage:@"暂无数据，请选择其他景区"];
                
                self.navigationItem.rightBarButtonItem = nil;
                
            }
            
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
