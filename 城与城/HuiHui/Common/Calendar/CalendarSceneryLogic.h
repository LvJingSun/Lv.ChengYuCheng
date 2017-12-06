//
//  CalendarSceneryLogic.h
//  CandalDemo
//
//  Created by mac on 15-2-3.
//  Copyright (c) 2015年 WJL. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CalendarDayModel.h"
#import "NSDate+WQCalendarLogic.h"

@interface CalendarSceneryLogic : NSObject

// test
@property (nonatomic,strong) NSMutableArray *m_array;


@property (nonatomic,strong) NSString *m_string;


- (NSMutableArray *)reloadCalendarView:(NSDate *)date  selectDate:(NSDate *)selectdate needDays:(int)days_number withArray:(NSMutableArray *)array;

- (void)selectLogic:(CalendarDayModel *)day;


@end
