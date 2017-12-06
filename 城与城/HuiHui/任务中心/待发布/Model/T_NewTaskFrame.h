//
//  T_NewTaskFrame.h
//  HuiHui
//
//  Created by mac on 2017/3/23.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>
@class T_NewTask;

@interface T_NewTaskFrame : NSObject

@property (nonatomic, assign) CGRect chooseBtnF;

@property (nonatomic, assign) CGRect nameF;

@property (nonatomic, assign) CGRect descF;

@property (nonatomic, assign) CGRect lineF;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) T_NewTask *taskModel;

@end
