//
//  DateUtil.m
//  baozhifu
//
//  Created by mac on 13-6-12.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "DateUtil.h"

@implementation DateUtil

+ (NSDate *)getDate:(NSString *) sDate dateFormat:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    return [formatter dateFromString:sDate];
}

+ (NSString *)formatDate:(NSDate *) date dateFormat:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    return [formatter stringFromDate:date];
}

+ (NSTimeInterval) computerServerTimeDiff:(NSString *)serverDateTime {
    NSDate *serverTime = [self getDate:serverDateTime dateFormat:DATE_FORMAT];
    return  [serverTime timeIntervalSinceNow];
}

@end
