//
//  HH_MenuTimeViewController.m
//  HuiHui
//
//  Created by mac on 15-6-24.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "HH_MenuTimeViewController.h"

#import "BCloundMenuCell.h"

#import "HH_OrderMenuCell.h"

#import "HHTimeButton.h"

@interface HH_MenuTimeViewController ()

@property (weak, nonatomic) IBOutlet UITableView *m_peopleTableView;

@property (weak, nonatomic) IBOutlet UITableView *m_timeTableView;


@property (weak, nonatomic) IBOutlet UIButton *m_todayBtn;

@property (weak, nonatomic) IBOutlet UIButton *m_tommoBtn;

@property (weak, nonatomic) IBOutlet UIButton *m_afterBtn;

@property (weak, nonatomic) IBOutlet UILabel *m_today;

@property (weak, nonatomic) IBOutlet UILabel *m_tommorrow;

@property (weak, nonatomic) IBOutlet UILabel *m_after;

@property (weak, nonatomic) IBOutlet UIImageView *m_todayImg;

@property (weak, nonatomic) IBOutlet UIImageView *m_tommorowImg;

@property (weak, nonatomic) IBOutlet UIImageView *m_afterImg;

@property (weak, nonatomic) IBOutlet UIScrollView *m_timeScroller;

@property (weak, nonatomic) IBOutlet UIScrollView *m_dateScrollerView;

@property (weak, nonatomic) IBOutlet UIScrollView *m_afterTimeScroller;



@property (weak, nonatomic) IBOutlet UILabel *m_titleTip;

// 时间日期的选择
- (IBAction)chooseDateClicked:(id)sender;


@end

@implementation HH_MenuTimeViewController

@synthesize m_peopleList;
@synthesize m_timeList;
@synthesize m_afterTimeList;
@synthesize m_dateList;
@synthesize m_timeString;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        
        m_peopleList = [[NSMutableArray alloc]initWithCapacity:0];
        m_timeList = [[NSMutableArray alloc]initWithCapacity:0];
        m_afterTimeList = [[NSMutableArray alloc]initWithCapacity:0];
        
        m_dateList = [[NSMutableArray alloc]initWithCapacity:0];
        
        selectedStepNext = NO;
        isSelectedPeople = -1;
        SelectedTime = -1;
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setTitle:@"点单"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];

    // 根据手机类型来判断是否设置scrollerView滚动
    if ( iPhone6 ) {
        // 设置srollerView的滚动范围
        [self.m_timeScroller setContentSize:CGSizeMake(WindowSizeWidth, 700)];
        
    }else if ( iPhone6plus ){
        
        
    }else{
        
        // 设置srollerView的滚动范围
        [self.m_timeScroller setContentSize:CGSizeMake(WindowSizeWidth, 600)];
        
    }
    
    self.m_orderTime.text = @"";
    self.m_peopleCOunt.text = @"";
    self.m_dateTime.text = @"";
    self.m_titleTip.text = @"";
    self.m_timeString = @"";
    
    // 请求时间和人数的数据
    [self timeRequestSubmit];
    
    [self peopleCountRequest];
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)leftClicked{
    
    [self goBack];
}

- (void)initwithtimeScroller{
    
    // 删除btn
    for (id view in self.m_dateScrollerView.subviews) {
        
        if ( [view isKindOfClass:[UIButton class]] ) {
            
            [view removeFromSuperview];
            
        }
    }
    
    // 初始化上午的时间
    self.m_dateScrollerView.backgroundColor = [UIColor clearColor];
    
    self.m_dateScrollerView.pagingEnabled = YES;
    
    self.m_dateScrollerView.showsHorizontalScrollIndicator = NO;
    
    self.m_dateScrollerView.showsVerticalScrollIndicator = NO;
    
    int width = (WindowSizeWidth - 120)/5;
    
    if ( self.m_timeList.count != 0 ) {
        
        // 添加按钮
        for (int i = 0; i < self.m_timeList.count; i ++) {
            
            NSDictionary *dic = [self.m_timeList objectAtIndex:i];
            // 时间状态  0不可选 1可选
            NSString *status = [dic objectForKey:@"TimeStatus"];
            
            // 添加按钮触发点击事件
            HHTimeButton *btn = [HHTimeButton buttonWithType:UIButtonTypeCustom];
            //        btn.frame = CGRectMake(0, i * 50, self.m_dateScrollerView.frame.size.width, 40);
            btn.frame = CGRectMake(i % 5 * (width + 5) + 5,  i / 5 * 35, width, 30);
            
            btn.backgroundColor = [UIColor whiteColor];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
            btn.tag = i;
            btn.status = status;
            [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
            [btn setTitle:[NSString stringWithFormat:@"%@",[dic objectForKey:@"TimeValue"]] forState:UIControlStateNormal];
            
            if ( [status isEqualToString:@"1"] ) {
                
                //                btn.userInteractionEnabled = YES;
                
                btn.enabled = YES;
                
                [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                
            }else{
                
                //                btn.userInteractionEnabled = NO;
                
                btn.enabled = NO;
                
                [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                
            }
            
            
            [self.m_dateScrollerView addSubview:btn];
            
        }
        
        
    }
    
    
    CGRect frame = self.m_dateScrollerView.frame;
    
    int fr = self.m_timeList.count / 5 * 35;
    
    if (fr > 80) {
        
        frame.size.height = 80;
        
        [self.m_dateScrollerView setContentSize:CGSizeMake(self.m_dateScrollerView.frame.size.width,200/*self.m_shopList.count*/)];
        
    }else {
        
        //        frame.size.height = fr;
        frame.size.height = 80;
        
        
    }
    
    
    [self.m_dateScrollerView setFrame:frame];
    
    
    //    self.m_dateScrollerView.frame = CGRectMake(5, 30, WindowSizeWidth - 10, self.m_timeList.count * 40);
  
}

- (void)initAfterTimeScroller{
    
    // 删除btn
    for (id view in self.m_afterTimeScroller.subviews) {
        
        if ( [view isKindOfClass:[UIButton class]] ) {
            
            [view removeFromSuperview];
            
        }
    }
    
    // 初始化下午的时间
    self.m_afterTimeScroller.backgroundColor = [UIColor clearColor];
    
    self.m_afterTimeScroller.pagingEnabled = YES;
    
    self.m_afterTimeScroller.showsHorizontalScrollIndicator = NO;
    
    self.m_afterTimeScroller.showsVerticalScrollIndicator = NO;
    
    int width1 = (WindowSizeWidth - 120)/5;
    
    if ( self.m_afterTimeList.count != 0 ) {
    
        // 添加按钮
        for (int i = 0; i < self.m_afterTimeList.count; i ++) {
            
            NSDictionary *dic = [self.m_afterTimeList objectAtIndex:i];
            
            // 时间状态  0不可选 1可选
            NSString *status = [dic objectForKey:@"TimeStatus"];
         
            // 添加按钮触发点击事件
            HHTimeButton *btn = [HHTimeButton buttonWithType:UIButtonTypeCustom];
            //        btn.frame = CGRectMake(0, i * 50, self.m_dateScrollerView.frame.size.width, 40);
            btn.frame = CGRectMake(i % 5 * (width1 + 5) + 5,  i / 5 * 35, width1, 30);
            
            btn.backgroundColor = [UIColor whiteColor];
//            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
            btn.tag = i + 1000;
            btn.status = status;
            [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
            [btn setTitle:[NSString stringWithFormat:@"%@",[dic objectForKey:@"TimeValue"]] forState:UIControlStateNormal];
            
            if ( [status isEqualToString:@"1"] ) {
                
//                btn.userInteractionEnabled = YES;
                
                btn.enabled = YES;
                
                [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                
            }else{
                
//                btn.userInteractionEnabled = NO;
                
                btn.enabled = NO;
                
                [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                
            }
            
            [self.m_afterTimeScroller addSubview:btn];
            
        }
 
    }
    
    
    CGRect frame1 = self.m_afterTimeScroller.frame;
    int fr1 = self.m_afterTimeList.count / 5 * 35;
    
    
    if (fr1 > 170) {
        
        frame1.size.height = 170;
        
        [self.m_afterTimeScroller setContentSize:CGSizeMake(self.m_afterTimeScroller.frame.size.width,200/*self.m_shopList.count*/)];
        
    }else {
        
        //        frame.size.height = fr;
        frame1.size.height = 170;
        
        
    }
    
    
    [self.m_afterTimeScroller setFrame:frame1];

}

- (void)getCurrentTime{
    
    NSTimeInterval secondsPerDay = 24 * 60 * 60;
    NSDate *today = [[NSDate alloc] init];
    NSDate *tomorrow, *afterday;
    
    tomorrow = [today dateByAddingTimeInterval: secondsPerDay];
    afterday = [today dateByAddingTimeInterval: secondsPerDay * 2];
    
    // 10 first characters of description is the calendar date:
    NSString * todayString = [[today description] substringToIndex:10];
    NSString * tomorrowString = [[tomorrow description] substringToIndex:10];
    NSString * afterString = [[afterday description] substringToIndex:10];
    
    // 赋值
    [self.m_todayBtn setTitle:[NSString stringWithFormat:@"%@",todayString] forState:UIControlStateNormal];
    
    [self.m_tommoBtn setTitle:[NSString stringWithFormat:@"%@",tomorrowString] forState:UIControlStateNormal];
    
    [self.m_afterBtn setTitle:[NSString stringWithFormat:@"%@",afterString] forState:UIControlStateNormal];
    
    
}

- (IBAction)chooseDateClicked:(id)sender {
    
    UIButton *btn = (UIButton *)sender;
    
    if ( btn.tag == 11 ) {
        // 今天
        [self setLeft:YES withMiddle:NO withRight:NO];
        
    }else if ( btn.tag == 22 ){
        // 明天
        [self setLeft:NO withMiddle:YES withRight:NO];
        
    }else if ( btn.tag == 33 ){
        // 后天
        [self setLeft:NO withMiddle:NO withRight:YES];
        
    }
    
}

- (void)setLeft:(BOOL)aLeft withMiddle:(BOOL)aMiddle withRight:(BOOL)aRight{
    
    self.m_todayBtn.selected = aLeft;
    self.m_tommoBtn.selected = aMiddle;
    self.m_afterBtn.selected = aRight;
    
    // 设置
    self.m_orderTime.text = @"";
    self.m_timeString = @"";
    
    if ( aLeft ) {
        
        self.m_todayImg.backgroundColor = [UIColor redColor];
        self.m_tommorowImg.backgroundColor = [UIColor clearColor];
        self.m_afterImg.backgroundColor = [UIColor clearColor];
        
        self.m_today.textColor = [UIColor whiteColor];
        self.m_tommorrow.textColor = [UIColor blackColor];
        self.m_after.textColor = [UIColor blackColor];
        
        self.m_todayBtn.userInteractionEnabled = NO;
        self.m_tommoBtn.userInteractionEnabled = YES;
        self.m_afterBtn.userInteractionEnabled = YES;
       
        // 赋值预订的日期
        self.m_dateTime.text = [NSString stringWithFormat:@"%@",self.m_todayBtn.titleLabel.text];
        
        // 数组赋值
        if ( self.m_dateList.count == 3 ) {
            
            NSDictionary *dic1 = [self.m_dateList objectAtIndex:0];
            
            NSMutableArray *arr = [dic1 objectForKey:@"TimeInfoList"];
            
            if ( arr.count == 2 ) {
                
                NSDictionary *dic = [arr objectAtIndex:0];
                NSDictionary *dic1 = [arr objectAtIndex:1];
                
                self.m_timeList = [dic objectForKey:@"TimeList"];

                self.m_afterTimeList = [dic1 objectForKey:@"TimeList"];
                
            }
          
        }
    }
    
    if ( aMiddle ) {
        
        self.m_todayImg.backgroundColor = [UIColor clearColor];
        self.m_tommorowImg.backgroundColor = [UIColor redColor];
        self.m_afterImg.backgroundColor = [UIColor clearColor];
        
        self.m_today.textColor = [UIColor blackColor];
        self.m_tommorrow.textColor = [UIColor whiteColor];
        self.m_after.textColor = [UIColor blackColor];
        
        self.m_todayBtn.userInteractionEnabled = YES;
        self.m_tommoBtn.userInteractionEnabled = NO;
        self.m_afterBtn.userInteractionEnabled = YES;
        
        // 赋值预订的日期
        self.m_dateTime.text = [NSString stringWithFormat:@"%@",self.m_tommoBtn.titleLabel.text];

        
        if ( self.m_dateList.count == 3 ) {
            
            NSDictionary *dic2 = [self.m_dateList objectAtIndex:1];
            
            NSMutableArray *arr = [dic2 objectForKey:@"TimeInfoList"];
            
            if ( arr.count == 2 ) {
                
                NSDictionary *dic = [arr objectAtIndex:0];
                NSDictionary *dic1 = [arr objectAtIndex:1];
                
                self.m_timeList = [dic objectForKey:@"TimeList"];
                
                self.m_afterTimeList = [dic1 objectForKey:@"TimeList"];
                
            }
            
            
        }
        
        
    }
    
    if ( aRight ) {
        
        self.m_todayImg.backgroundColor = [UIColor clearColor];
        self.m_tommorowImg.backgroundColor = [UIColor clearColor];
        self.m_afterImg.backgroundColor = [UIColor redColor];
        
        self.m_today.textColor = [UIColor blackColor];
        self.m_tommorrow.textColor = [UIColor blackColor];
        self.m_after.textColor = [UIColor whiteColor];
        
        self.m_todayBtn.userInteractionEnabled = YES;
        self.m_tommoBtn.userInteractionEnabled = YES;
        self.m_afterBtn.userInteractionEnabled = NO;
        
        // 赋值预订的日期
        self.m_dateTime.text = [NSString stringWithFormat:@"%@",self.m_afterBtn.titleLabel.text];

        
        if ( self.m_dateList.count == 3 ) {
           
            NSDictionary *dic3 = [self.m_dateList objectAtIndex:2];
            
            NSMutableArray *arr = [dic3 objectForKey:@"TimeInfoList"];
            
            if ( arr.count == 2 ) {
                
                NSDictionary *dic = [arr objectAtIndex:0];
                NSDictionary *dic1 = [arr objectAtIndex:1];
                
                self.m_timeList = [dic objectForKey:@"TimeList"];
                
                self.m_afterTimeList = [dic1 objectForKey:@"TimeList"];
                
            }
        }
        
    }
    
    // 赋值
    self.m_titleTip.text = [NSString stringWithFormat:@"您选择了 %@  %@  %@",self.m_dateTime.text,self.m_orderTime.text,self.m_peopleCOunt.text];
    
    // 初始化scrollerView
    [self initwithtimeScroller];
    [self initAfterTimeScroller];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if ( tableView == self.m_peopleTableView ) {
        
        //        return self.m_peopleList.count;
        
        return self.m_peopleList.count % 2 == 0 ? [self.m_peopleList count] / 2 : [self.m_peopleList count] / 2 + 1;
        
        
    }else{
        
        //        return self.m_timeList.count % 2 == 0 ? [self.m_timeList count] / 2 : [self.m_timeList count] / 2 + 1;
        
        
        return 2;
        
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if ( tableView == self.m_peopleTableView ) {
        
        /* static NSString *cellIdentifier = @"HH_OrderMenuCellIdentifier";
         
         HH_OrderMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
         
         if ( cell == nil ) {
         
         NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"HH_OrderMenuCell" owner:self options:nil];
         
         cell = (HH_OrderMenuCell *)[nib objectAtIndex:0];
         
         }
         
         
         // 赋值
         if ( self.m_peopleList.count != 0 ) {
         
         cell.m_name.text = [NSString stringWithFormat:@"%@",[self.m_peopleList objectAtIndex:indexPath.row]];
         
         }
         
         if ( isSelectedPeople == indexPath.row ) {
         
         cell.m_name.textColor = RGBACKTAB;
         
         cell.accessoryType = UITableViewCellAccessoryCheckmark;
         
         }else{
         
         cell.m_name.textColor = [UIColor blackColor];
         
         cell.accessoryType = UITableViewCellAccessoryNone;
         
         }
         
         
         return cell;*/
        
        static NSString *cellIdentifier = @"HH_OrderMenuTimeCellIdentifier";
        
        HH_OrderMenuTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if ( cell == nil ) {
            
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"HH_OrderMenuCell" owner:self options:nil];
            
            cell = (HH_OrderMenuTimeCell *)[nib objectAtIndex:1];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        
        
        // 赋值
        if ( self.m_peopleList.count != 0 ) {
            
            
            cell.m_leftBtn.hidden = NO;
            cell.m_rightBtn.hidden = NO;
            
            
            if (indexPath.row * 2 + 0 <= [self.m_peopleList count] - 1 ) {
                
                NSDictionary *dic = [self.m_peopleList objectAtIndex:indexPath.row * 2 + 0];

                if (indexPath.row * 2 + 1 > [self.m_peopleList count] - 1) {
                    
                    cell.m_rightBtn.hidden = YES;
                    cell.m_rightBtn.userInteractionEnabled = NO;
                }
                
                cell.m_leftBtn.tag = indexPath.row * 2 + 0;
                
                [cell.m_leftBtn setTitle:[NSString stringWithFormat:@"%@",[dic objectForKey:@"CloudMenuPersoName"]] forState:UIControlStateNormal];
                
                // 添加按钮点击事件
                [cell.m_leftBtn addTarget:self action:@selector(peopleChooseClicked:) forControlEvents:UIControlEventTouchUpInside];
                
            }
            
            if (indexPath.row * 2 + 1 <=  [self.m_peopleList count] - 1) {
                
                NSDictionary *dic = [self.m_peopleList objectAtIndex:indexPath.row * 2 + 1];

                cell.m_rightBtn.tag = indexPath.row * 2 + 1;
                
                [cell.m_rightBtn setTitle:[NSString stringWithFormat:@"%@",[dic objectForKey:@"CloudMenuPersoName"]] forState:UIControlStateNormal];
                
                // 添加按钮点击事件
                [cell.m_rightBtn addTarget:self action:@selector(peopleChooseClicked:) forControlEvents:UIControlEventTouchUpInside];
                
            }
            
            if ( isSelectedPeople == indexPath.row * 2 + 0 ) {
                
                [cell.m_leftBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                
                [cell.m_rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                
            }else if ( isSelectedPeople == indexPath.row * 2 + 1){
                
                [cell.m_leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                
                [cell.m_rightBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                
            }else{
                
                [cell.m_leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [cell.m_rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                
            }
            
            
        }
        
        
        return cell;
        
        
        
        
    }else{
        
        static NSString *cellIdentifier = @"HH_OrderMenuCellIdentifier";
        
        HH_OrderMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if ( cell == nil ) {
            
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"HH_OrderMenuCell" owner:self options:nil];
            
            cell = (HH_OrderMenuCell *)[nib objectAtIndex:0];
            
        }
        
        
        // 赋值
        
        if ( indexPath.row == 0 ) {
            
            cell.m_name.text = @"上午";
            
        }else{
            
            cell.m_name.text = @"下午";
            
        }
        
        return cell;
        
    }
    
    
}

- (void)peopleChooseClicked:(id)sender{
    
    UIButton *btn = (UIButton *)sender;
    
    isSelectedPeople = btn.tag;
    
    NSDictionary *dic = [self.m_peopleList objectAtIndex:isSelectedPeople];
    
    self.m_peopleCOunt.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"CloudMenuPersoName"]];
    
    [self.m_peopleTableView reloadData];
    
    // 赋值
    self.m_titleTip.text = [NSString stringWithFormat:@"您选择了 %@  %@  %@",self.m_dateTime.text,self.m_orderTime.text,self.m_peopleCOunt.text];
    
}


- (void)btnClicked:(id)sender{
    
    UIButton *btn = (UIButton *)sender;
    
    if ( btn.tag >= 1000 ) {
        // 表示是下午的时间
        SelectedTime = btn.tag;
        
        NSDictionary *dic = [self.m_afterTimeList objectAtIndex:SelectedTime - 1000];
        
        self.m_orderTime.text = [NSString stringWithFormat:@"下午%@",[dic objectForKey:@"TimeValue"]];
        
        self.m_timeString = [NSString stringWithFormat:@"%@",[dic objectForKey:@"TimeValue"]];
        
        
        // 刷新scrollerView
        [self reloadScrollerView];
        
        
    }else{
        // 表示是上午时间
        
        SelectedTime = btn.tag;
        
        NSDictionary *dic = [self.m_timeList objectAtIndex:SelectedTime];

        self.m_orderTime.text = [NSString stringWithFormat:@"上午%@",[dic objectForKey:@"TimeValue"]];
        
        self.m_timeString = [NSString stringWithFormat:@"%@",[dic objectForKey:@"TimeValue"]];
        
        
        // 刷新scrollerView
        [self reloadScrollerView];
        
    }
    
    // 赋值
    self.m_titleTip.text = [NSString stringWithFormat:@"您选择了 %@  %@  %@",self.m_dateTime.text,self.m_orderTime.text,self.m_peopleCOunt.text];
   
}

// 刷新scrollerView
- (void)reloadScrollerView{
    
    if ( SelectedTime >= 1000 ) {
        
        [self scroller:self.m_afterTimeScroller cleanScroller:self.m_dateScrollerView];
    
    }else{
        
        
        [self scroller:self.m_dateScrollerView cleanScroller:self.m_afterTimeScroller];
        
    }
    
}

- (void)scroller:(UIScrollView *)scrollerView cleanScroller:(UIScrollView *)bScrollerView{
    
    for (id view in scrollerView.subviews ) {
        
        if ( [view isKindOfClass:[HHTimeButton class]] ) {
            
            HHTimeButton *btn = (HHTimeButton *)view;
            
            if ( btn.tag == SelectedTime ) {
                
                btn.userInteractionEnabled = NO;
                
//                [btn setTitleColor:RGBACKTAB forState:UIControlStateNormal];
                
                [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                
                btn.layer.borderWidth = 1.0f;
                btn.layer.borderColor = [UIColor redColor].CGColor;

                
            }else{
                
                if ( [btn.status isEqualToString:@"1"] ) {
                    
                    btn.userInteractionEnabled = YES;
                    
                    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                    
                    btn.layer.borderWidth = 0.0f;
                    btn.layer.borderColor = [UIColor clearColor].CGColor;
                    
                }else{
                    
                    btn.userInteractionEnabled = NO;
                    
                    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                    
                    btn.layer.borderWidth = 0.0f;
                    btn.layer.borderColor = [UIColor clearColor].CGColor;
                    
                }
                
            }
            
        }
        
    }
    
    
    for (id l_view in bScrollerView.subviews ) {
        
        if ( [l_view isKindOfClass:[HHTimeButton class]] ) {
            
            HHTimeButton *l_btn = (HHTimeButton *)l_view;
            
            if ( [l_btn.status isEqualToString:@"1"] ) {
                
                l_btn.userInteractionEnabled = YES;
                
                [l_btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                
                l_btn.layer.borderWidth = 0.0f;
                l_btn.layer.borderColor = [UIColor clearColor].CGColor;
                
            }else{
                
                l_btn.userInteractionEnabled = NO;
                
                [l_btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                
                
                l_btn.layer.borderWidth = 0.0f;
                l_btn.layer.borderColor = [UIColor clearColor].CGColor;
            }
            
            
        }
    }
    
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ( tableView == self.m_peopleTableView ) {
        
        return 40.0f;
        
    }else{
        
        return 60.0f;
        
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ( tableView == self.m_peopleTableView ) {
        
        
    }else{
        
        
        
    }
    
    
}

#pragma mark - Network
- (void)timeRequestSubmit{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        return;
    }
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    //    NSString *merchantId = [CommonUtil getValueByKey:MERCHANTID];
    
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"memberId",
                           key,@"key",nil];
    
    [httpClient request:@"CloudMenuDateTime.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            [SVProgressHUD dismiss];
            
            // 赋值
            self.m_dateList = [json valueForKey:@"dateList"];
            
            if ( self.m_dateList.count == 3 ) {
                
                NSDictionary *dic1 = [self.m_dateList objectAtIndex:0];
                
                NSDictionary *dic2 = [self.m_dateList objectAtIndex:1];
                NSDictionary *dic3 = [self.m_dateList objectAtIndex:2];
                
                
                // 赋值
                [self.m_todayBtn setTitle:[NSString stringWithFormat:@"%@",[dic1 objectForKey:@"DateValues"]] forState:UIControlStateNormal];
                
                [self.m_tommoBtn setTitle:[NSString stringWithFormat:@"%@",[dic2 objectForKey:@"DateValues"]] forState:UIControlStateNormal];
                
                [self.m_afterBtn setTitle:[NSString stringWithFormat:@"%@",[dic3 objectForKey:@"DateValues"]] forState:UIControlStateNormal];
                
                self.m_today.text = [NSString stringWithFormat:@"%@",[dic1 objectForKey:@"DateName"]];
                self.m_tommorrow.text = [NSString stringWithFormat:@"%@",[dic2 objectForKey:@"DateName"]];
                self.m_after.text = [NSString stringWithFormat:@"%@",[dic3 objectForKey:@"DateName"]];

                
                // 默认选中第一个
                [self setLeft:YES withMiddle:NO withRight:NO];
                
            }
            
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showErrorWithStatus:msg];
        }
        
        
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];

}

- (void)peopleCountRequest{
    
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        return;
    }
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    //    NSString *merchantId = [CommonUtil getValueByKey:MERCHANTID];
    
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"memberId",
                           key,@"key",nil];
    
    [httpClient request:@"CloudMenuPerson.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            [SVProgressHUD dismiss];
            
            // 赋值
            self.m_peopleList = [json valueForKey:@"PersonList"];
            
            [self.m_peopleTableView reloadData];
            
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showErrorWithStatus:msg];
        }
        
        
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];

}




@end
