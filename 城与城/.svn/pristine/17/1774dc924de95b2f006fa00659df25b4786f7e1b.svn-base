//
//  HH_MenuTimeViewController.h
//  HuiHui
//
//  Created by mac on 15-6-24.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//  菜单选择时间和人数的页面

#import "BaseViewController.h"

@interface HH_MenuTimeViewController : BaseViewController{
    
    BOOL        selectedStepNext;
    
    NSInteger   isSelectedPeople;
    
    NSInteger   SelectedTime;
  
    
}

// 存放人数的数组
@property (nonatomic, strong) NSMutableArray                *m_peopleList;
// 存放上午时间的数组
@property (nonatomic, strong) NSMutableArray                *m_timeList;
// 存放下午的时间
@property (nonatomic, strong) NSMutableArray                *m_afterTimeList;
// 存放时间的数组
@property (nonatomic, strong) NSMutableArray                *m_dateList;
// 存放时间的值
@property (nonatomic, strong) NSString                      *m_timeString;


@property (weak, nonatomic) IBOutlet UILabel *m_peopleCOunt;
@property (weak, nonatomic) IBOutlet UILabel *m_orderTime;
@property (weak, nonatomic) IBOutlet UILabel *m_dateTime;

// 点击按钮
- (void)setLeft:(BOOL)aLeft withMiddle:(BOOL)aMiddle withRight:(BOOL)aRight;
// 刷新scrollerView
- (void)reloadScrollerView;


// 请求时间的数据
- (void)timeRequestSubmit;

// 请求人数的数据
- (void)peopleCountRequest;



@end
