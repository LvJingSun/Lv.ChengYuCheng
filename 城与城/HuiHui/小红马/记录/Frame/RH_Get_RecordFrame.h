//
//  RH_Get_RecordFrame.h
//  HuiHui
//
//  Created by mac on 2017/8/4.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RH_Get_RecordModel;

@interface RH_Get_RecordFrame : NSObject

//日期
@property (nonatomic, assign) CGRect DateF;

//收益
@property (nonatomic, assign) CGRect ProfitF;

//类型
@property (nonatomic, assign) CGRect TypeF;

//分割线
@property (nonatomic, assign) CGRect LineF;

//高度
@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) RH_Get_RecordModel *getModel;

@end
