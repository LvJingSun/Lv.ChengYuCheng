//
//  FlightsViewController.m
//  HuiHui
//
//  Created by mac on 14-12-2.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "FlightsViewController.h"

#import "CalendarHomeViewController.h"

#import "CalendarViewController.h"

#import "FlightsListViewController.h"

#import "CommonUtil.h"

#import "FlightsPayViewController.h"

@interface FlightsViewController ()
{
    
    CalendarHomeViewController *chvc;
    
}

@property (weak, nonatomic) IBOutlet UILabel *m_currentCity;

@property (weak, nonatomic) IBOutlet UILabel *m_arrivalCity;

@property (weak, nonatomic) IBOutlet UILabel *m_dateLabel;

@property (weak, nonatomic) IBOutlet UIView *m_singleView;

//@property (weak, nonatomic) IBOutlet UIView *m_returnView;

@property (weak, nonatomic) IBOutlet UIImageView *imageV1;

@property (weak, nonatomic) IBOutlet UIImageView *imageV2;

//@property (weak, nonatomic) IBOutlet UIImageView *imageV3;
//
//@property (weak, nonatomic) IBOutlet UIImageView *imageV4;

@property (weak, nonatomic) IBOutlet UISegmentedControl *m_segment;

@property (weak, nonatomic) IBOutlet UILabel *m_rgoDateLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_rbackDateLabel;

@property (weak, nonatomic) IBOutlet UIView *m_backView;
// 切换城市的按钮
@property (weak, nonatomic) IBOutlet UIButton *m_changeBtn;

// 搜索按钮触发的事件
- (IBAction)searchClicked:(id)sender;

// 按钮切换触发的事件
- (IBAction)segmentClicked:(id)sender;
// 出发城市的选择
- (IBAction)currentCityClicked:(id)sender;
// 到达城市的选择
- (IBAction)arrivalCityClicked:(id)sender;
// 出发日期的选择
- (IBAction)dateClicked:(id)sender;
// 出发城市与到达城市切换按钮触发的事件
- (IBAction)changeCityClicked:(id)sender;

@end

@implementation FlightsViewController

@synthesize isChangeCity;

@synthesize m_dic;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        
        isChangeCity = NO;
        
        m_dic = [[NSMutableDictionary alloc]initWithCapacity:0];
        
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setTitle:@"机票搜索"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    
    // 将线设置为0.4
    self.imageV1.frame = CGRectMake(16, 99, 284, 0.4f);
    self.imageV2.frame = CGRectMake(16, 205, 284, 0.4f);
//    self.imageV3.frame = CGRectMake(16, 50, 304, 0.4f);
//    self.imageV4.frame = CGRectMake(16, 76, 304, 0.4f);
    
    
   
    // 赋值当前的日期
    self.m_dateLabel.text = [NSString stringWithFormat:@"%@",[self getCurrentDate]];
    self.m_rgoDateLabel.text = [NSString stringWithFormat:@"%@",[self getCurrentDate]];
  
   
    
    // 设置字典默认的值为上海到北京的城市，默认日期为今天的日期
    NSDate *date = [NSDate date];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *dateStr = [formatter stringFromDate:date];
    
    self.m_dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"上海",@"currentCityKey",@"北京",@"arrivalCityKey",dateStr,@"currentDateKey", nil];
    
    // 默认值
    self.m_currentCity.text = @"上海";
    self.m_arrivalCity.text = @"北京";
    
    // 默认设置为单程的模式，
    self.m_backView.frame = CGRectMake(400, 110, 90, 90);
//    self.m_backView.hidden = YES;
    
    // 默认为单程的类型
    self.m_type = SingleType;
    
    // 默认为出发城市的值
    self.m_cityType = CurrentCityType;
    
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

- (void)leftClicked{
    
    [self goBack];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)segmentClicked:(id)sender {

    UISegmentedControl *segment = (UISegmentedControl *)sender;
    
    if ( segment.selectedSegmentIndex == 0 ) {
        
        self.m_type = SingleType;
        
        // 设置view的坐标
        [UIView animateWithDuration:0.3 animations:^{
            
            [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
      
            self.m_backView.frame = CGRectMake(400, 110, 90, 90);

        
        } completion:^(BOOL finished) {
      
            
        }];
       
        
    }else if ( segment.selectedSegmentIndex == 1 ){
        
        self.m_type = BackType;
        
        // 设置view的坐标
        [UIView animateWithDuration:0.3 animations:^{
            
            [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
            
            self.m_backView.frame = CGRectMake(210, 110, 90, 90);
            
        } completion:^(BOOL finished) {
            

        }];

        
    }
    
}

- (IBAction)currentCityClicked:(id)sender {
    
    // 记录为出发城市的值
    self.m_cityType = CurrentCityType;
    
    // 城市列表选择的页面
    FlightCityListViewController *VC = [[FlightCityListViewController alloc]initWithNibName:@"FlightCityListViewController" bundle:nil];
    VC.delegate = self;
    [self.navigationController pushViewController:VC animated:YES];
    
}

- (IBAction)arrivalCityClicked:(id)sender {
    
    // 记录为到达城市的值
    self.m_cityType = ArrivalCityType;
    
    // 城市列表选择的页面
    FlightCityListViewController *VC = [[FlightCityListViewController alloc]initWithNibName:@"FlightCityListViewController" bundle:nil];
    VC.delegate = self;
    [self.navigationController pushViewController:VC animated:YES];

}

- (IBAction)dateClicked:(id)sender {
    
    UIButton *btn = (UIButton *)sender;
    
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
        
        if ( btn.tag == 11 ) {
            // 单程出发日期选择
            
            // 赋值
            self.m_dateLabel.text = [NSString stringWithFormat:@"%@ %@",[model toString],[model getWeek]];
            
            // 存储到字典里用于请求数据的时候用
            [self.m_dic setObject:[NSString stringWithFormat:@"%@",[model toString]] forKey:@"currentDateKey"];
            
            
        }else if ( btn.tag == 22 ){
            
            // 往返的触发日期赋值
            self.m_rbackDateLabel.text = [NSString stringWithFormat:@"%@ %@",[model toString],[model getWeek]];
            
            // 存储到字典里用于请求数据的时候用
            [self.m_dic setObject:[NSString stringWithFormat:@"%@",[model toString]] forKey:@"arrivalDateKey"];
            
        }else{
            
            
        }
        
    };
    
    [self.navigationController pushViewController:chvc animated:YES];
    
}

- (IBAction)changeCityClicked:(id)sender {
   
    // 点击切换后view设置为不可点击的状态
    self.view.userInteractionEnabled = NO;
    
    self.isChangeCity = !self.isChangeCity;
    
    // 设置view的坐标
    [UIView animateWithDuration:0.3 animations:^{
        
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        
        
        // 按钮旋转180°
        CABasicAnimation* rotationAnimation;
        rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        
        // 判断是触发城市切换成到达城市还是到达城市切换成出发城市
        if ( self.isChangeCity ) {
            
            self.m_arrivalCity.frame = CGRectMake(12, 50, 90, 40);
            
            self.m_currentCity.frame = CGRectMake(210, 50, 90, 40);
      
            rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 1.0 ];
            
            
            // 存储到字典里用于请求数据的时候用
            [self.m_dic setObject:[NSString stringWithFormat:@"%@",self.m_arrivalCity.text] forKey:@"currentCityKey"];
            [self.m_dic setObject:[NSString stringWithFormat:@"%@",self.m_currentCity.text] forKey:@"arrivalCityKey"];
            
            
            
        }else{
            
            self.m_currentCity.frame = CGRectMake(12, 50, 90, 40);
            
            self.m_arrivalCity.frame = CGRectMake(210, 50, 90, 40);
            
            rotationAnimation.toValue = [NSNumber numberWithFloat: -M_PI * 1.0 ];
            
            
            // 存储到字典里用于请求数据的时候用
            [self.m_dic setObject:[NSString stringWithFormat:@"%@",self.m_currentCity.text] forKey:@"currentCityKey"];
            [self.m_dic setObject:[NSString stringWithFormat:@"%@",self.m_arrivalCity.text] forKey:@"arrivalCityKey"];
            
            
        }
        
        rotationAnimation.duration = 0.5;
        rotationAnimation.cumulative = YES;
        rotationAnimation.repeatCount = 1;
        
        [self.m_changeBtn.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
        
    } completion:^(BOOL finished) {
        
        // 动画结束后view恢复可点击的状态
        self.view.userInteractionEnabled = YES;

    }];

    
}


- (IBAction)searchClicked:(id)sender {

    if ( self.m_type == SingleType ) {
        // 单程开始搜索
        
    }else{
        // 往返开始搜索

        NSLog(@"往返");
        
    }
    
    // 进入飞机票搜索的页面
    FlightsListViewController *VC = [[FlightsListViewController alloc]initWithNibName:@"FlightsListViewController" bundle:nil];
    VC.m_dictionary = self.m_dic;
    [self.navigationController pushViewController:VC animated:YES];
    

}

#pragma mark - HHCityListDelegate{
- (void)getFlightCityName:(NSMutableDictionary *)aCityName{
        
     // 如果城市列表中没有定位来的地理位置时，则默认个地址来进行搜索
    // 判断是否进行切换城市
    if ( self.isChangeCity ) {
        // 表示切换城市 到达城市和出发城市进行交换
        if ( self.m_cityType == CurrentCityType ) {
            // 出发城市赋值
            self.m_arrivalCity.text = [NSString stringWithFormat:@"%@",[aCityName objectForKey:@"Name"]];
            
            // 存储到字典里用于请求数据的时候用
            [self.m_dic setObject:[NSString stringWithFormat:@"%@",[aCityName objectForKey:@"Name"]] forKey:@"currentCityKey"];
            
        }else if ( self.m_cityType == ArrivalCityType ){
            // 到达城市赋值
            self.m_currentCity.text = [NSString stringWithFormat:@"%@",[aCityName objectForKey:@"Name"]];
            
            // 存储到字典里用于请求数据的时候用
            [self.m_dic setObject:[NSString stringWithFormat:@"%@",[aCityName objectForKey:@"Name"]] forKey:@"arrivalCityKey"];
        }
        
        
    }else{
        
        if ( self.m_cityType == CurrentCityType ) {
            // 出发城市赋值
            self.m_currentCity.text = [NSString stringWithFormat:@"%@",[aCityName objectForKey:@"Name"]];
            
            // 存储到字典里用于请求数据的时候用
            [self.m_dic setObject:[NSString stringWithFormat:@"%@",[aCityName objectForKey:@"Name"]] forKey:@"currentCityKey"];
            
        }else if ( self.m_cityType == ArrivalCityType ){
            // 到达城市赋值
            self.m_arrivalCity.text = [NSString stringWithFormat:@"%@",[aCityName objectForKey:@"Name"]];
            
            // 存储到字典里用于请求数据的时候用
            [self.m_dic setObject:[NSString stringWithFormat:@"%@",[aCityName objectForKey:@"Name"]] forKey:@"arrivalCityKey"];
        }
        
    }
    
}


@end
