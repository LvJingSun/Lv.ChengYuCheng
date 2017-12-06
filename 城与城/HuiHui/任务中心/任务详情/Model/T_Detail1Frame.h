//
//  T_Detail1Frame.h
//  HuiHui
//
//  Created by mac on 2017/3/22.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>
//@class T_Task;
@class TH_TaskModel;

@interface T_Detail1Frame : NSObject

@property (nonatomic, assign) CGRect TaskNameF;

@property (nonatomic, assign) CGRect TaskTypeF;

@property (nonatomic, assign) CGRect LineF;

@property (nonatomic, assign) CGRect PersonF;

@property (nonatomic, assign) CGRect CountF;

@property (nonatomic, assign) CGRect TimeF;

@property (nonatomic, assign) CGRect StatusTitleF;

@property (nonatomic, assign) CGRect StatusF;

//@property (nonatomic, strong) T_Task *taskmodel;

@property (nonatomic, strong) TH_TaskModel *th_taskmodel;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) CGRect Line2F;

@end
