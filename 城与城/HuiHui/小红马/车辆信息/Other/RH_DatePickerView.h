//
//  RH_DatePickerView.h
//  HuiHui
//
//  Created by mac on 2017/6/15.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, DateType) {
    DateTypeNormal,       // 默认时间选择(月日时分)
    DateTypeModeDate      // 时间选择(只有年月日)
};

typedef void (^ConfirmDateBlock)(NSDate  *date);

@interface RH_DatePickerView : UIView

- (instancetype)initWithFrame:(CGRect)frame
               datePickerMode:(UIDatePickerMode)datePickerMode
                     lastDate:(NSDate *)lastDate;

/**
 *  View显示
 */
- (void)showView;

/**
 *  确认所选时间
 *
 *  @param block 传出Date
 */
- (void)confirmDate:(ConfirmDateBlock)block;

@end
