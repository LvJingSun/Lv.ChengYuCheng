//
//  CalendarSceneryViewController.h
//  CandalDemo
//
//  Created by mac on 15-2-3.
//  Copyright (c) 2015年 WJL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalendarSceneryLogic.h"
#import "BaseViewController.h"


//回掉代码块
typedef void (^CalendarBlock)(CalendarDayModel *model);

@interface CalendarSceneryViewController :BaseViewController

@property(nonatomic ,strong) UICollectionView* collectionView;//网格视图

@property(nonatomic ,strong) NSMutableArray *calendarMonth;//每个月份的中的daymodel容器数组

@property(nonatomic ,strong) CalendarSceneryLogic *Logic;

@property (nonatomic, copy) CalendarBlock calendarblock;//回调

@end
