//
//  FSB_ProfitModel.h
//  HuiHui
//
//  Created by mac on 2017/5/15.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FSB_ProfitModel : NSObject

//memberID
@property (nonatomic, copy) NSString *MemberID;

//当日收益
@property (nonatomic, copy) NSString *TodayProfit;

//日期
@property (nonatomic, copy) NSString *TodayDate;

//类型
@property (nonatomic, copy) NSString *Type;

@end
