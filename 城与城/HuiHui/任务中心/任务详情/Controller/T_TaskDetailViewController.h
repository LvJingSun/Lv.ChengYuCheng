//
//  T_TaskDetailViewController.h
//  HuiHui
//
//  Created by mac on 2017/3/22.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "T_TemplateViewController.h"
@class T_Task;
@class TH_TaskModel;

@interface T_TaskDetailViewController : T_TemplateViewController

@property (nonatomic, strong) T_Task *task;

@property (nonatomic, strong) TH_TaskModel *th_taskmodel;

@end
